From: "John Utz" <John.Utz@dmxmusic.com>
Subject: shouldnt the #define for reg 0x5c be called
 AC97_VENDOR_RESERVED?
Date: Wed, 7 Feb 2007 14:14:50 -0800
Message-ID: <F8FB97052F1BEF409F7842E960E49B5AEDA256@sea-exch-01.na.corp.dmxmusic.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0014622810=="
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

--===============0014622810==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C74B05.62FD623D"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C74B05.62FD623D
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Just a thought!

When I grepped for 5c I found some non-obvious things that make sense
with respect to the people that implemented the drivers:

[jutz@localhost mntgto]$ find . -name \*.h -exec grep -Hn AC97 {} \; |
grep -i 5C

./alsa/alsa-driver-1.0.14rc2/sound/include/ac97_codec.h:283:#define
AC97_AD_TEST2               0x5c    /* undocumented test register 2 */
./alsa/alsa-driver-1.0.14rc2/sound/include/ac97_codec.h:299:#define
AC97_CXR_AUDIO_MISC 0x5c

 but as near as I can tell it's called 'vendor reserved'
(AC '97 Component Specification p62 - 'Vendor Reserved Registers =
5A=3D5Fh,
70h - 7Ah)


John L. Utz III




------_=_NextPart_001_01C74B05.62FD623D
Content-Type: text/html;
 charset=us-ascii
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">
<TITLE>shouldnt the #define for reg 0x5c be called =
AC97_VENDOR_RESERVED?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Arial">Just a thought</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">!</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">When</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 FACE=3D"Arial">I</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial"> grepped for 5c</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Arial">I</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"> found some non-obvious =
things that make sense with respect to the</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Arial">people</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"> that implemented the =
drivers</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">:</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Arial">[jutz@localhost mntgto]$ find . -name \*.h -exec =
grep -Hn AC97 {} \; | grep -i 5C</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">./alsa/alsa-driver-1.0.14rc2/sound/include/ac97_codec.h:28=
3:#define =
AC97_AD_TEST2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0x5c&nbsp;&nbsp;&nbsp; /* undocumented test =
register 2 */</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">./alsa/alsa-driver-1.0.14rc2/sound/include/ac97_codec.h:29=
9:#define AC97_CXR_AUDIO_MISC 0x5c</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Arial">&nbsp;but as near as</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Arial">I</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"></FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Arial">can tell it</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">&#8217;</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">s called</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Arial">&#8216;</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">vendor =
reserved</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&#8217;</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Arial">(AC</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Arial">&#8217;</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">97 Component Specification =
p62</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT =
SIZE=3D2 FACE=3D"Arial">&#8211;</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial"></FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 FACE=3D"Arial">&#8216;</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">Vendor Reserved Registers 5A=3D5Fh, =
70h</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT =
SIZE=3D2 FACE=3D"Arial">&#8211;</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial"> 7Ah)</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"></SPAN><A NAME=3D""><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">John L. Utz =
III</FONT></SPAN></A></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN></P>

</BODY>
</HTML>
------_=_NextPart_001_01C74B05.62FD623D--



--===============0014622810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0014622810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0014622810==--
