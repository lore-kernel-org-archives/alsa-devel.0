From: "Ryan Cassidy" <rcassidy@stanford.edu>
Subject: Understanding JACK's inner loop?
Date: Wed, 10 Dec 2003 00:38:50 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000001c3bef9$09182fa0$264440ab@roboserv1>
Reply-To: <rcassidy@stanford.edu>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0001_01C3BEB5.FAF4EFA0"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------=_NextPart_000_0001_01C3BEB5.FAF4EFA0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello all,
 
I am trying to understand the specifics of the mechanism that JACK uses
to perform audio duplexing (simultaneous playback and capture of audio).
I have downloaded the latest source from CVS.  Is the file
'alsa_driver.c' a good place to start (i.e. is this where the magic
happens)?  Does JACK use memory-mapped read/write?
 
Any info. greatly appreciated.
 
Cheers, rjc.
--
Ryan Cassidy
Electrical Engineering Graduate Student, CCRMA Researcher
Stanford University
E-mail: ryanc@ieee.org
 

------=_NextPart_000_0001_01C3BEB5.FAF4EFA0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">


<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 10">
<meta name=3DOriginator content=3D"Microsoft Word 10">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C3BEB5.FA8712A0">
<!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:DoNotRelyOnCSS/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:SpellingState>Clean</w:SpellingState>
  <w:DocumentKind>DocumentEmail</w:DocumentKind>
  <w:EnvelopeVis/>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]-->
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;
	text-underline:single;}
p.MsoAutoSig, li.MsoAutoSig, div.MsoAutoSig
	{margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	mso-style-noshow:yes;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Arial;
	mso-ascii-font-family:Arial;
	mso-hansi-font-family:Arial;
	mso-bidi-font-family:Arial;
	color:windowtext;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 10]>
<style>
 /* Style Definitions */=20
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman";}
</style>
<![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple =
style=3D'tab-interval:.5in'>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hello all,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am trying to understand the specifics of the =
mechanism
that JACK uses to perform audio <span class=3DSpellE>duplexing</span>
(simultaneous playback and capture of audio). <span
style=3D'mso-spacerun:yes'>&nbsp;</span>I have downloaded the latest =
source from
CVS.<span style=3D'mso-spacerun:yes'>&nbsp; </span>Is the file =
&#8216;<span
class=3DSpellE>alsa_driver.c</span>&#8217; a good place to start (i.e. =
is this
where the magic happens)?<span style=3D'mso-spacerun:yes'>&nbsp; =
</span>Does JACK use
memory-mapped read/write?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Any info. greatly =
appreciated.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoAutoSig><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial;mso-no-proof:yes'>Cheers, rjc.</span></font><span
style=3D'mso-no-proof:yes'><o:p></o:p></span></p>

<p class=3DMsoAutoSig><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial;mso-no-proof:yes'>--</span></font><span =
style=3D'mso-no-proof:
yes'><o:p></o:p></span></p>

<p class=3DMsoAutoSig><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial;mso-no-proof:yes'>Ryan Cassidy</span></font><span
style=3D'mso-no-proof:yes'><o:p></o:p></span></p>

<p class=3DMsoAutoSig><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial;mso-no-proof:yes'>Electrical Engineering Graduate =
Student,
CCRMA Researcher</span></font><span =
style=3D'mso-no-proof:yes'><o:p></o:p></span></p>

<p class=3DMsoAutoSig><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial;mso-no-proof:yes'>Stanford =
University</span></font><span
style=3D'mso-no-proof:yes'><o:p></o:p></span></p>

<p class=3DMsoAutoSig><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial;mso-no-proof:yes'>E-mail: =
ryanc@ieee.org</span></font><span
style=3D'mso-no-proof:yes'><o:p></o:p></span></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0001_01C3BEB5.FAF4EFA0--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
