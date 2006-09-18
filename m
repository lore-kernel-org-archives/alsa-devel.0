From: "Luke Zhang" <lzhang@intrinsyc.com>
Subject: some problem in wm9712 driver
Date: Mon, 18 Sep 2006 09:49:15 -0700
Message-ID: <DBC923D919FAB345973A94E6E194E8490353C38C@yvrmail01.itc.intrinsyc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0894569965=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--===============0894569965==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6DB42.60788A48"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6DB42.60788A48
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello everyone,

=20

I found some problem in wm9711_snd_ac97_controls[] of ac97_patch.c. =20

=20

For example, for the interface AC97_SINGLE("Mic 1 Volume", AC97_MIC, 8,
32, 1), here the mask is set as 32, but the MIC1 volume field in Reg 0eh
occupies 8-12 bits.  So it means if I set the MIC1 volume as 32 using
amixer command, it will affect M22P bit actually.

=20

Another, for the interface AC97_DOUBLE("Capture Volume", AC97_REC_GAIN,
8, 0, 15, 1), here the mask is 15, but RECVOLL and RECVOLR occupies 6
bits individually.  So if I set capture volume as 32, the actual value
will be 15 instead.

=20

=20

Did anyone try the wolfson wm9712 drivers and meet same problems before?
Thanks.

=20

Luke Zhang

Intrinsyc Software International, Inc.

10th Floor, 700 W Pender St.

Vancouver, BC V6C 1G8

Direct:  1-604-632-3563

Fax  :   1-604-801-6417

www.intrinsyc.com <http://www.intrinsyc.com> =20

=20

Making Mobility Work

=20

=20


------_=_NextPart_001_01C6DB42.60788A48
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PostalCode"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"State"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"City"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"Street"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"address"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hello everyone,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I found some problem in wm9711_snd_ac97_controls[] of
ac97_patch.c.&nbsp; <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>For example, for the interface AC97_SINGLE(&quot;Mic =
1
Volume&quot;, AC97_MIC, 8, 32, 1), here the mask is set as 32, but the =
MIC1
volume field in Reg 0eh occupies 8-12 bits. &nbsp;So it means if I set =
the MIC1
volume as 32 using amixer command, it will affect M22P bit =
actually.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Another, for the interface AC97_DOUBLE(&quot;Capture
Volume&quot;, AC97_REC_GAIN, 8, 0, 15, 1), here the mask is 15, but =
RECVOLL and
RECVOLR occupies 6 bits individually. &nbsp;So if I set capture volume =
as 32,
the actual value will be 15 instead.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Did anyone try the wolfson wm9712 drivers and meet =
same
problems before? &nbsp;Thanks.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Luke Zhang<o:p></o:p></span></font></p>

<p class=3DMsoNormal><strong><b><font size=3D3 face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt'>Intrinsyc Software International, =
Inc.<o:p></o:p></span></font></b></strong></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>10th Floor, <U1:STREET u2:st=3D"on"><U1:ADDRESS =
u2:st=3D"on"><st1:Street
w:st=3D"on"><st1:address w:st=3D"on">700 W Pender =
St</U1:ADDRESS></U1:STREET></st1:address></st1:Street>.</span></font><o:p=
></o:p></p>

<p class=3DMsoNormal><st1:place w:st=3D"on"><st1:City w:st=3D"on"><font =
size=3D2
  face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Vancouver</span></font></st1=
:City><font
 size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>, <U1:STATE =
u2:st=3D"on"><st1:State
 w:st=3D"on">BC</U1:STATE></st1:State> <U1:POSTALCODE =
u2:st=3D"on"><st1:PostalCode
 w:st=3D"on">V6C =
1G8</U1:POSTALCODE></st1:PostalCode></span></font></st1:place><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Direct:&nbsp; =
1-604-632-3563<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Fax&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;1-604-801-6417<o:p><=
/o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><a href=3D"http://www.intrinsyc.com" =
title=3D"http://www.intrinsyc.com"><strong><b><font
color=3Dblack face=3D"Times New Roman" =
title=3D"http://www.intrinsyc.com"><span
title=3D"http://www.intrinsyc.com"><span =
title=3D"http://www.intrinsyc.com"><span
style=3D'color:windowtext;text-decoration:none'>www.intrinsyc.com</span><=
/span></span></font></b></strong></a><strong><b><font
face=3D"Times New Roman"> =
<o:p></o:p></font></b></strong></span></font></p>

<p class=3DMsoNormal><strong><b><font size=3D3 face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></b></strong></=
p>

<p class=3DMsoNormal><strong><b><font size=3D3 face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt'>Making Mobility =
Work</span></font></b></strong><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C6DB42.60788A48--


--===============0894569965==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0894569965==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0894569965==--
