<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:exsl="http://exslt.org/common"
  extension-element-prefixes="exsl"
  exclude-result-prefixes="exsl">

<xsl:import href="pass1_xhtml_headers.xsl"/>
<xsl:import href="pass2_xhtml_gdocs_headers.xsl"/>
<xsl:import href="pass3_xhtml_divs.xsl"/>
<xsl:import href="pass4_xhtml_text.xsl"/>
<xsl:import href="pass6_xhtml2cnxml.xsl"/>
<xsl:import href="pass7_cnxml_postprocessing.xsl"/>
<xsl:import href="pass8_cnxml_id-generation.xsl"/>
<xsl:import href="pass9_cnxml_postprocessing.xsl"/>

<xsl:output
  method="xml"
  encoding="UTF-8"
  indent="yes"/>

<xsl:strip-space elements="*"/>

<xsl:template match="/">
  <!-- general HTML/GDocs XSLTs -->
  <xsl:variable name="temp1">
    <xsl:apply-templates select="." mode="pass1"/>
  </xsl:variable>
<!--
  Do not do pass2 now. It brakes paragraph creation!
  <xsl:variable name="temp2">
    <xsl:apply-templates select="exsl:node-set($temp1)" mode="pass2"/>
  </xsl:variable>
-->
  <!-- merge DIVs -->
  <xsl:variable name="temp3">
    <xsl:apply-templates select="exsl:node-set($temp1)" mode="pass3"/>
  </xsl:variable>

  <!-- generate paragraphs -->
  <xsl:variable name="temp4">
    <xsl:apply-templates select="exsl:node-set($temp3)" mode="pass4"/>
  </xsl:variable>

  <!-- do now pass2 -->
  <xsl:variable name="temp5">
    <xsl:apply-templates select="exsl:node-set($temp4)" mode="pass2"/>
  </xsl:variable>

  <!-- XHTML 2 CNXML -->
  <xsl:variable name="temp6">
    <xsl:apply-templates select="exsl:node-set($temp5)" mode="pass6"/>
  </xsl:variable>
  <xsl:variable name="temp7">
    <xsl:apply-templates select="exsl:node-set($temp6)" mode="pass7"/>
  </xsl:variable>
  <xsl:variable name="temp8">
    <xsl:apply-templates select="exsl:node-set($temp7)" mode="pass8"/>
  </xsl:variable>  
  <xsl:apply-templates select="exsl:node-set($temp8)" mode="pass9"/>
</xsl:template>

</xsl:stylesheet>