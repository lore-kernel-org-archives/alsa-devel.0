From: "Rick Woodring" <rwoodring@nsseng.com>
Subject: Document update for ALS4000
Date: Thu, 11 Jan 2007 14:55:02 -0500
Message-ID: <8F1C2B75DFED1F4FA3ECEDF0B3553E3DFF331C@novaexch1.nssengineering.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0956198145=="
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

--===============0956198145==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C735BA.625ADC35"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C735BA.625ADC35
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I tried to add a note to the ALS400 page at
http://www.alsa-project.org/alsa-doc/doc-php/template.php?company=3DAvanc=
e
+Logic&card=3DALS4000.&chip=3Dals4000&module=3Dals4000 but whenever I try=
 to
submit my comment, and error message is displayed.  Because I do not
know if the comment is being sent to anyone or not, I have included it
in this message.  If my comment has not been received, could someone
please post it so that others may be spared the trouble I took in
digging up updated install documentation.

 

Thanks

-rick

 

Rick Woodring

RWoodring_@_mail_._com

 

 

In order to get ALSA v1.0.13 working on a 2.6.16 kernel with a udev file
system, 
do NOT run the ./snddevices script.  The correct entries will be placed
in /dev 
automatically when the kernel modules are loaded and the hardware is
detected.  
Also, I had to create a udev rules file for alsa
(/etc/udev/rules.d/15-alsa.rules)
as described here (code copied below): 
http://www.linuxfromscratch.org/blfs/view/svn/multimedia/alsa-utils.html
 
     cat > /etc/udev/rules.d/15-alsa.rules << "EOF"
     # Give the audio group ownership of sound devices
     SUBSYSTEM=3D=3D"sound",       GROUP=3D"audio"
     SUBSYSTEM=3D=3D"snd",         GROUP=3D"audio"
 
     # ALSA Devices
     # When a sound device is detected, restore the volume settings
     KERNEL=3D=3D"controlC[0-9]*", ACTION=3D=3D"add", RUN+=3D"/usr/sbin/a=
lsactl
restore %n"
     KERNEL=3D"hw[CD0-9]*",      NAME=3D"snd/%k"
     KERNEL=3D"pcm[CD0-9cp]*",   NAME=3D"snd/%k"
     KERNEL=3D"midiC[D0-9]*",    NAME=3D"snd/%k"
     KERNEL=3D"timer",           NAME=3D"snd/%k"
     KERNEL=3D"seq",             NAME=3D"snd/%k"
     EOF
 
     chmod 644 /etc/udev/rules.d/15-alsa.rules
 
And lastly, instead of using the ~/.asoudrc file described in this
document, I had to copy 
the alsa.conf file from alsa-lib-XXXXX/src/conf/alsa.conf to my
/usr/share/alsa/ folder.
Without the /usr/share/alsa/alsa.conf file in place, I received the
following errors when 
trying to use alsamixer or alsactl
 
     ALSA lib control.c:910:(snd_ctl_open_noupdate) Invalid CTL default
     alsamixer: function snd_ctl_open failed for default: No such file
or directory
 
     ALSA lib control.c:910:(snd_ctl_open_noupdate) Invalid CTL hw:0
     alsactl: set_controls:1179: snd_ctl_open error: No such file or
directory

 


 



"This email contains proprietary and/or privileged material.  This email =
and any files transmitted with it are proprietary and intended solely for t=
he person or entity to whom they are addressed.  Any review, retransmission=
, dissemination or other use of, or taking of any action in reliance upon t=
his information by persons or entities other than the intended recipient is=
 prohibited.  If you have received this email in error, please contact the =
sender and delete the material from any computer."
------_=_NextPart_001_01C735BA.625ADC35
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:st1=3D"urn:schemas-microsoft-com:off=
ice:smarttags" xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType namespaceuri=3D"urn:schemas-microsoft-com:office:smarttag=
s"
 name=3D"PersonName"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
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
pre
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";
	color:black;}
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

<body lang=3DEN-US link=3Dblue vlink=3Dpurple><P>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'>I tried to add a note to the ALS400 page at <a
href=3D"http://www.alsa-project.org/alsa-doc/doc-php/template.php?company=
=3DAvance+Logic&amp;card=3DALS4000.&amp;chip=3Dals4000&amp;module=3Dals4000=
">http://www.alsa-project.org/alsa-doc/doc-php/template.php?company=3DAvanc=
e+Logic&amp;card=3DALS4000.&amp;chip=3Dals4000&amp;module=3Dals4000</a>
but whenever I try to submit my comment, and error message is displayed.&=
nbsp;
Because I do not know if the comment is being sent to anyone or not, I ha=
ve
included it in this message.&nbsp; If my comment has not been received, c=
ould
someone please post it so that others may be spared the trouble I took in
digging up updated install documentation.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'>Thanks<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'>-rick<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><st1:PersonName w:st=3D"on"><font size=3D2 face=3DAr=
ial><span
 style=3D'font-size:10.0pt;font-family:Arial'>Rick Woodring</span></font>=
</st1:PersonName><font
size=3D2 face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'>=
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'>RWoodring_@_mail_._com<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<pre><font size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'fon=
t-size:10.0pt'>In order to get ALSA v1.0.13 working on a 2.6.16 kernel with=
 a udev file system, <o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0=
pt'>do NOT run the ./snddevices script.&nbsp; The correct entries will be p=
laced in /dev <o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0=
pt'>automatically when the kernel modules are loaded and the hardware is de=
tected.&nbsp; <o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0=
pt'>Also, I had to create a udev rules file for alsa (/etc/udev/rules.d/15-=
alsa.rules)<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0=
pt'>as described here (code copied below): <o:p></o:p></span></font></pre><=
pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0=
pt'><a
href=3D"http://www.linuxfromscratch.org/blfs/view/svn/multimedia/alsa-uti=
ls.html">http://www.linuxfromscratch.org/blfs/view/svn/multimedia/alsa-util=
s.html</a><o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0=
pt'><o:p>&nbsp;</o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0=
pt'>&nbsp;&nbsp;&nbsp;&nbsp; cat &gt; /etc/udev/rules.d/15-alsa.rules &lt;&=
lt; &quot;EOF&quot;<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0=
pt'>&nbsp;&nbsp;&nbsp;&nbsp; # Give the audio group ownership of sound devi=
ces<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0=
pt'>&nbsp;&nbsp;&nbsp;&nbsp; SUBSYSTEM=3D=3D&quot;sound&quot;,&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; GROUP=3D&quot;audio&quot;<o:p></o:p></span></font><=
/pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0=
pt'>&nbsp;&nbsp;&nbsp;&nbsp; SUBSYSTEM=3D=3D&quot;snd&quot;,&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GROUP=3D&quot;audio&quot;<o:p></o:p></spa=
n></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0=
pt'><o:p>&nbsp;</o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0=
pt'>&nbsp;&nbsp;&nbsp;&nbsp; # ALSA Devices<o:p></o:p></span></font></pre><=
pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0=
pt'>&nbsp;&nbsp;&nbsp;&nbsp; # When a sound device is detected, restore the=
 volume settings<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0=
pt'>&nbsp;&nbsp;&nbsp;&nbsp; KERNEL=3D=3D&quot;controlC[0-9]*&quot;, ACTION=
=3D=3D&quot;add&quot;, RUN+=3D&quot;/usr/sbin/alsactl restore %n&quot;<o:p>=
</o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0=
pt'>&nbsp;&nbsp;&nbsp;&nbsp; KERNEL=3D&quot;hw[CD0-9]*&quot;,&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; NAME=3D&quot;snd/%k&quot;<o:p></o:p></span></font></pre><p=
re><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0=
pt'>&nbsp;&nbsp;&nbsp;&nbsp; KERNEL=3D&quot;pcm[CD0-9cp]*&quot;,&nbsp;&nbsp=
; NAME=3D&quot;snd/%k&quot;<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0=
pt'>&nbsp;&nbsp;&nbsp;&nbsp; KERNEL=3D&quot;midiC[D0-9]*&quot;,&nbsp;&nbsp;=
&nbsp; NAME=3D&quot;snd/%k&quot;<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0=
pt'>&nbsp;&nbsp;&nbsp;&nbsp; KERNEL=3D&quot;timer&quot;,&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NAME=3D&quot;snd/%k&quot;<o:p></o=
:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0=
pt'>&nbsp;&nbsp;&nbsp;&nbsp; KERNEL=3D&quot;seq&quot;,&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NAME=3D&quot;snd/%k&quo=
t;<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0=
pt'>&nbsp;&nbsp;&nbsp;&nbsp; EOF<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0=
pt'><o:p>&nbsp;</o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0=
pt'>&nbsp;&nbsp;&nbsp;&nbsp; chmod 644 /etc/udev/rules.d/15-alsa.rules<o:p>=
</o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0=
pt'><o:p>&nbsp;</o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0=
pt'>And lastly, instead of using the ~/.asoudrc file described in this docu=
ment, I had to copy <o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0=
pt'>the alsa.conf file from alsa-lib-XXXXX/src/conf/alsa.conf to my /usr/sh=
are/alsa/ folder.<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0=
pt'>Without the /usr/share/alsa/alsa.conf file in place, I received the fol=
lowing errors when <o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0=
pt'>trying to use alsamixer or alsactl<o:p></o:p></span></font></pre><pre><=
font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0=
pt'><o:p>&nbsp;</o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0=
pt'>&nbsp;&nbsp;&nbsp;&nbsp; ALSA lib control.c:910:(snd_ctl_open_noupdate)=
 Invalid CTL default<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0=
pt'>&nbsp;&nbsp;&nbsp;&nbsp; alsamixer: function snd_ctl_open failed for de=
fault: No such file or directory<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0=
pt'><o:p>&nbsp;</o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0=
pt'>&nbsp;&nbsp;&nbsp;&nbsp; ALSA lib control.c:910:(snd_ctl_open_noupdate)=
 Invalid CTL hw:0<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0=
pt'>&nbsp;&nbsp;&nbsp;&nbsp; alsactl: set_controls:1179: snd_ctl_open error=
: No such file or directory<o:p></o:p></span></font></pre>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=
=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

 </P>
<P>
<HR style=3D"HEIGHT: 1px">
<SPAN class=3D601015812-25082005><FONT face=3DArial size=3D2>"<EM>This em=
ail 
contains&nbsp;proprietary and/or privileged material.&nbsp; This email an=
d any 
files transmitted with it are&nbsp;proprietary and intended solely for th=
e 
person or entity to whom they are addressed.&nbsp; Any review, retransmis=
sion, 
dissemination or other use of, or taking of any action in reliance upon t=
his 
information by persons or entities other than the intended recipient is 
prohibited.&nbsp; If you have received this email in error, please contac=
t the 
sender and delete the material from any computer</EM>."</FONT></SPAN></bo=
dy>

</html>


------_=_NextPart_001_01C735BA.625ADC35--


--===============0956198145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0956198145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0956198145==--
