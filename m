From: "Martin Devall" <martyd@tp-sys.com>
Subject: unresolved symbol sound_class when adding snd* modules
Date: Tue, 30 May 2006 12:02:01 -0700
Message-ID: <109BFA9B9D8AC548BC910337D91654CE942ED2@newthor.tp-sys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1303215760=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Class: urn:content-classes:message
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

--===============1303215760==
Content-Type: multipart/related;
	boundary="----_=_NextPart_001_01C6841B.883EC731";
	type="multipart/alternative"
Content-Class: urn:content-classes:message

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6841B.883EC731
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C6841B.883EC731"


------_=_NextPart_002_01C6841B.883EC731
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I am trying to get the alsa dirver modules to install on a small device
running Linux 2.4.28 kernel.  When I run modprobe to add the alsa driver
I get "unresolved symbol sound_class".  Should sound_class be difined as
an alaise to soundcore or is sound_core.c out of date.

=20

Marty DeVall......

=20

=20

ts_mgd:/bin# modprobe -v snd-via82xx

/sbin/insmod /usr/lib/modules/snd-page-alloc.o

Using /usr/lib/modules/snd-page-alloc.o

Symbol version prefix ''

/sbin/insmod /usr/lib/modules/snd.o

Using /usr/lib/modules/snd.o

/usr/lib/modules/snd.o: unresolved symbol sound_class

/usr/lib/modules/snd.o: insmod /usr/lib/modules/snd.o failed

# delete snd-page-alloc

/usr/lib/modules/snd.o: insmod snd-via82xx failed

=20

ts_mgd:/bin# lsmod

Module                  Size  Used by    Not tainted

via82cxxx_audio        18744   0  (unused)

ac97_codec             12204   0  [via82cxxx_audio]

soundcore               3460   2  [via82cxxx_audio]

rtc                     6268   0

supermount             63072   3

usb-printer             8224   0  (unused)

usb-uhci               20780   0  (unused)

ehci-hcd               16104   0  (unused)

usb-storage            23832   0  (unused)

sd_mod                 10924   0  (unused)

vfat                    9164   1

fat                    30072   0  [vfat]

udf                    76928   0  (unused)

usbcore                56384   0  [usb-printer usb-uhci ehci-hcd
usb-storage]

scsi_mod               53776   1  [usb-storage sd_mod]

8139too                12008   1

mii                     2224   0  [8139too]

crc32                   2832   0  [8139too]

apm                     9032   0

=20

When I run depmod I get......

=20

=20

ts_mgd:/bin# depmod -v

xftw starting at /lib/modules

xftw_readdir /lib/modules

type 2 /lib/modules

xftw_readdir /lib/modules

user function /lib/modules

resolving /lib/modules/2.4.28 symlink to /lib/modules user function
/lib/modules

user function /lib/modules/8139too.o

user function /lib/modules/ac97_codec.o

user function /lib/modules/apm.o

user function /lib/modules/crc32.o

user function /lib/modules/ehci-hcd.o

user function /lib/modules/fat.o

user function /lib/modules/mii.o

resolving /lib/modules/modules.dep symlink to /tmp/modules/modules.dep
user function /tmp/modules/modules.dep

resolving /lib/modules/modules.description symlink to
/tmp/modules/modules.description: does not exist, dangling symlink
ignored

resolving /lib/modules/modules.generic_string symlink to
/tmp/modules/modules.generic_string user function
/tmp/modules/modules.generic_string

resolving /lib/modules/modules.ieee1394map symlink to
/tmp/modules/modules.ieee1394map user function
/tmp/modules/modules.ieee1394map

resolving /lib/modules/modules.isapnpmap symlink to
/tmp/modules/modules.isapnpmap user function
/tmp/modules/modules.isapnpmap

resolving /lib/modules/modules.parportmap symlink to
/tmp/modules/modules.parportmap user function
/tmp/modules/modules.parportmap

resolving /lib/modules/modules.pcimap symlink to
/tmp/modules/modules.pcimap user function /tmp/modules/modules.pcimap

resolving /lib/modules/modules.pnpbiosmap symlink to
/tmp/modules/modules.pnpbiosmap user function
/tmp/modules/modules.pnpbiosmap

resolving /lib/modules/modules.usbmap symlink to
/tmp/modules/modules.usbmap user function /tmp/modules/modules.usbmap

user function /lib/modules/rtc.o

user function /lib/modules/scsi_mod.o

user function /lib/modules/sd_mod.o

user function /lib/modules/soundcore.o

user function /lib/modules/supermount.o

user function /lib/modules/udf.o

user function /lib/modules/usb-ohci.o

user function /lib/modules/usb-printer.o

user function /lib/modules/usb-storage.o

user function /lib/modules/usb-uhci.o

user function /lib/modules/usbcore.o

user function /lib/modules/vfat.o

user function /lib/modules/via82cxxx_audio.o

xftw starting at /usr/lib/modules

xftw_readdir /usr/lib/modules

type 2 /usr/lib/modules

xftw_readdir /usr/lib/modules

user function /usr/lib/modules

user function /usr/lib/modules/snd-ac97-codec.o

user function /usr/lib/modules/snd-mixer-oss.o

user function /usr/lib/modules/snd-mpu401-uart.o

user function /usr/lib/modules/snd-page-alloc.o

user function /usr/lib/modules/snd-pcm-oss.o

user function /usr/lib/modules/snd-pcm.o

user function /usr/lib/modules/snd-pnp.o

user function /usr/lib/modules/snd-rawmidi.o

user function /usr/lib/modules/snd-seq-device.o

user function /usr/lib/modules/snd-seq-midi-event.o

user function /usr/lib/modules/snd-seq-midi.o

user function /usr/lib/modules/snd-seq-oss.o

user function /usr/lib/modules/snd-seq.o

user function /usr/lib/modules/snd-timer.o

user function /usr/lib/modules/snd-via82xx.o

user function /usr/lib/modules/snd.o

depmod: /tmp/modules/modules.dep is not an ELF file

depmod: cannot read ELF header from /tmp/modules/modules.generic_string

depmod: /tmp/modules/modules.ieee1394map is not an ELF file

depmod: /tmp/modules/modules.isapnpmap is not an ELF file

depmod: cannot read ELF header from /tmp/modules/modules.parportmap

depmod: /tmp/modules/modules.pcimap is not an ELF file

depmod: cannot read ELF header from /tmp/modules/modules.pnpbiosmap

depmod: /tmp/modules/modules.usbmap is not an ELF file

/lib/modules/8139too.o

/lib/modules/ac97_codec.o

/lib/modules/apm.o

/lib/modules/crc32.o

/lib/modules/ehci-hcd.o

/lib/modules/fat.o

/lib/modules/mii.o

/lib/modules/rtc.o

/lib/modules/scsi_mod.o

/lib/modules/sd_mod.o

/lib/modules/soundcore.o

/lib/modules/supermount.o

/lib/modules/udf.o

/lib/modules/usb-ohci.o

/lib/modules/usb-printer.o

/lib/modules/usb-storage.o

/lib/modules/usb-uhci.o

/lib/modules/usbcore.o

/lib/modules/vfat.o

/lib/modules/via82cxxx_audio.o

depmod: *** Unresolved symbols in /usr/lib/modules/snd-ac97-codec.o

/usr/lib/modules/snd-ac97-codec.o

depmod: *** Unresolved symbols in /usr/lib/modules/snd-mixer-oss.o

/usr/lib/modules/snd-mixer-oss.o

depmod: *** Unresolved symbols in /usr/lib/modules/snd-mpu401-uart.o

/usr/lib/modules/snd-mpu401-uart.o

/usr/lib/modules/snd-page-alloc.o

depmod: *** Unresolved symbols in /usr/lib/modules/snd-pcm-oss.o

/usr/lib/modules/snd-pcm-oss.o

depmod: *** Unresolved symbols in /usr/lib/modules/snd-pcm.o

/usr/lib/modules/snd-pcm.o

depmod: *** Unresolved symbols in /usr/lib/modules/snd-pnp.o

/usr/lib/modules/snd-pnp.o

depmod: *** Unresolved symbols in /usr/lib/modules/snd-rawmidi.o

/usr/lib/modules/snd-rawmidi.o

depmod: *** Unresolved symbols in /usr/lib/modules/snd-seq-device.o

/usr/lib/modules/snd-seq-device.o

depmod: *** Unresolved symbols in /usr/lib/modules/snd-seq-midi-event.o

/usr/lib/modules/snd-seq-midi-event.o

depmod: *** Unresolved symbols in /usr/lib/modules/snd-seq-midi.o

/usr/lib/modules/snd-seq-midi.o

depmod: *** Unresolved symbols in /usr/lib/modules/snd-seq-oss.o

/usr/lib/modules/snd-seq-oss.o

depmod: *** Unresolved symbols in /usr/lib/modules/snd-seq.o

/usr/lib/modules/snd-seq.o

depmod: *** Unresolved symbols in /usr/lib/modules/snd-timer.o

/usr/lib/modules/snd-timer.o

depmod: *** Unresolved symbols in /usr/lib/modules/snd-via82xx.o

/usr/lib/modules/snd-via82xx.o

depmod: *** Unresolved symbols in /usr/lib/modules/snd.o

/usr/lib/modules/snd.o

=20

Best Regards,

=20

Marty DeVall

=20

ThinPATH Systems Inc.

26200 SW 95th Ave.

Suite 301

Wilsonville, OR 97070

=20

Phone: 971-404-3282

Fax:     971-404-3259

Web:    www.tp-sys.com

 =20

=20


------_=_NextPart_002_01C6841B.883EC731
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><o:SmartTagType
 namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags" =
name=3D"PostalCode"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"State"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"City"/>
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
font-family:Arial'>I am trying to get the alsa dirver modules to install =
on a small
device running Linux 2.4.28 kernel.&nbsp; When I run modprobe to add the =
alsa
driver I get &#8220;unresolved symbol sound_class&#8221;.&nbsp; Should =
sound_class
be difined as an alaise to soundcore or is sound_core.c out of =
date.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Marty =
DeVall&#8230;&#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>ts_mgd:/bin# modprobe -v =
snd-via82xx<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/sbin/insmod =
/usr/lib/modules/snd-page-alloc.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Using =
/usr/lib/modules/snd-page-alloc.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Symbol version prefix ''<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/sbin/insmod =
/usr/lib/modules/snd.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Using =
/usr/lib/modules/snd.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/usr/lib/modules/snd.o: unresolved symbol =
sound_class<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/usr/lib/modules/snd.o: insmod /usr/lib/modules/snd.o =
failed<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'># delete snd-page-alloc<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/usr/lib/modules/snd.o: insmod snd-via82xx =
failed<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>ts_mgd:/bin# lsmod<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Module&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Size&nbsp; Used by&nbsp;&nbsp;&nbsp; Not =
tainted<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>via82cxxx_audio&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;
18744&nbsp;&nbsp; 0&nbsp; (unused)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>ac97_codec&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;
12204&nbsp;&nbsp; 0&nbsp; [via82cxxx_audio]<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>soundcore&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
3460&nbsp;&nbsp; 2&nbsp; [via82cxxx_audio]<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>rtc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
6268&nbsp;&nbsp; 0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>supermount&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;
63072&nbsp;&nbsp; 3<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>usb-printer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
8224&nbsp;&nbsp; 0&nbsp; (unused)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>usb-uhci&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
20780&nbsp;&nbsp; 0&nbsp; (unused)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>ehci-hcd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
16104&nbsp;&nbsp; 0&nbsp; (unused)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>usb-storage&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
23832&nbsp;&nbsp; 0&nbsp; (unused)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>sd_mod&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
10924&nbsp;&nbsp; 0&nbsp; (unused)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>vfat&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
9164&nbsp;&nbsp; 1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>fat&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
30072&nbsp;&nbsp; 0&nbsp; [vfat]<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>udf&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
76928&nbsp;&nbsp; 0&nbsp; (unused)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>usbcore&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
56384&nbsp;&nbsp; 0&nbsp; [usb-printer usb-uhci ehci-hcd =
usb-storage]<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>scsi_mod&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
53776&nbsp;&nbsp; 1&nbsp; [usb-storage =
sd_mod]<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>8139too&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
12008&nbsp;&nbsp; 1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>mii&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
2224&nbsp;&nbsp; 0&nbsp; [8139too]<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>crc32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
2832&nbsp;&nbsp; 0&nbsp; [8139too]<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>apm&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
9032&nbsp;&nbsp; 0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>When I run depmod I =
get&#8230;&#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>ts_mgd:/bin# depmod -v<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>xftw starting at =
/lib/modules<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>xftw_readdir =
/lib/modules<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>type 2 /lib/modules<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>xftw_readdir =
/lib/modules<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/lib/modules<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>resolving /lib/modules/2.4.28 symlink to /lib/modules =
user
function /lib/modules<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/lib/modules/8139too.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/lib/modules/ac97_codec.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/lib/modules/apm.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/lib/modules/crc32.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/lib/modules/ehci-hcd.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/lib/modules/fat.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/lib/modules/mii.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>resolving /lib/modules/modules.dep symlink to
/tmp/modules/modules.dep user function =
/tmp/modules/modules.dep<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>resolving /lib/modules/modules.description symlink to
/tmp/modules/modules.description: does not exist, dangling symlink =
ignored<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>resolving /lib/modules/modules.generic_string symlink =
to
/tmp/modules/modules.generic_string user function
/tmp/modules/modules.generic_string<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>resolving /lib/modules/modules.ieee1394map symlink to
/tmp/modules/modules.ieee1394map user function =
/tmp/modules/modules.ieee1394map<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>resolving /lib/modules/modules.isapnpmap symlink to
/tmp/modules/modules.isapnpmap user function =
/tmp/modules/modules.isapnpmap<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>resolving /lib/modules/modules.parportmap symlink to
/tmp/modules/modules.parportmap user function =
/tmp/modules/modules.parportmap<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>resolving /lib/modules/modules.pcimap symlink to
/tmp/modules/modules.pcimap user function =
/tmp/modules/modules.pcimap<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>resolving /lib/modules/modules.pnpbiosmap symlink to
/tmp/modules/modules.pnpbiosmap user function =
/tmp/modules/modules.pnpbiosmap<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>resolving /lib/modules/modules.usbmap symlink to
/tmp/modules/modules.usbmap user function =
/tmp/modules/modules.usbmap<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/lib/modules/rtc.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/lib/modules/scsi_mod.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/lib/modules/sd_mod.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/lib/modules/soundcore.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/lib/modules/supermount.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/lib/modules/udf.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/lib/modules/usb-ohci.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/lib/modules/usb-printer.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/lib/modules/usb-storage.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/lib/modules/usb-uhci.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/lib/modules/usbcore.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/lib/modules/vfat.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/lib/modules/via82cxxx_audio.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>xftw starting at =
/usr/lib/modules<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>xftw_readdir =
/usr/lib/modules<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>type 2 /usr/lib/modules<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>xftw_readdir =
/usr/lib/modules<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/usr/lib/modules<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/usr/lib/modules/snd-ac97-codec.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/usr/lib/modules/snd-mixer-oss.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/usr/lib/modules/snd-mpu401-uart.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/usr/lib/modules/snd-page-alloc.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/usr/lib/modules/snd-pcm-oss.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/usr/lib/modules/snd-pcm.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/usr/lib/modules/snd-pnp.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/usr/lib/modules/snd-rawmidi.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/usr/lib/modules/snd-seq-device.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/usr/lib/modules/snd-seq-midi-event.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/usr/lib/modules/snd-seq-midi.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/usr/lib/modules/snd-seq-oss.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/usr/lib/modules/snd-seq.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/usr/lib/modules/snd-timer.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/usr/lib/modules/snd-via82xx.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user function =
/usr/lib/modules/snd.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>depmod: /tmp/modules/modules.dep is not an ELF =
file<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>depmod: cannot read ELF header from
/tmp/modules/modules.generic_string<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>depmod: /tmp/modules/modules.ieee1394map is not an =
ELF file<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>depmod: /tmp/modules/modules.isapnpmap is not an ELF =
file<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>depmod: cannot read ELF header from =
/tmp/modules/modules.parportmap<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>depmod: /tmp/modules/modules.pcimap is not an ELF =
file<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>depmod: cannot read ELF header from
/tmp/modules/modules.pnpbiosmap<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>depmod: /tmp/modules/modules.usbmap is not an ELF =
file<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/lib/modules/8139too.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/lib/modules/ac97_codec.o<o:p></o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/lib/modules/apm.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/lib/modules/crc32.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/lib/modules/ehci-hcd.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/lib/modules/fat.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/lib/modules/mii.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/lib/modules/rtc.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/lib/modules/scsi_mod.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/lib/modules/sd_mod.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/lib/modules/soundcore.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/lib/modules/supermount.o<o:p></o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/lib/modules/udf.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/lib/modules/usb-ohci.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/lib/modules/usb-printer.o<o:p></o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/lib/modules/usb-storage.o<o:p></o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/lib/modules/usb-uhci.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/lib/modules/usbcore.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/lib/modules/vfat.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/lib/modules/via82cxxx_audio.o<o:p></o:p></span></font=
></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>depmod: *** Unresolved symbols in
/usr/lib/modules/snd-ac97-codec.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/usr/lib/modules/snd-ac97-codec.o<o:p></o:p></span></f=
ont></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>depmod: *** Unresolved symbols in
/usr/lib/modules/snd-mixer-oss.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/usr/lib/modules/snd-mixer-oss.o<o:p></o:p></span></fo=
nt></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>depmod: *** Unresolved symbols in
/usr/lib/modules/snd-mpu401-uart.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/usr/lib/modules/snd-mpu401-uart.o<o:p></o:p></span></=
font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/usr/lib/modules/snd-page-alloc.o<o:p></o:p></span></f=
ont></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>depmod: *** Unresolved symbols in
/usr/lib/modules/snd-pcm-oss.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/usr/lib/modules/snd-pcm-oss.o<o:p></o:p></span></font=
></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>depmod: *** Unresolved symbols in =
/usr/lib/modules/snd-pcm.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/usr/lib/modules/snd-pcm.o<o:p></o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>depmod: *** Unresolved symbols in =
/usr/lib/modules/snd-pnp.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/usr/lib/modules/snd-pnp.o<o:p></o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>depmod: *** Unresolved symbols in
/usr/lib/modules/snd-rawmidi.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/usr/lib/modules/snd-rawmidi.o<o:p></o:p></span></font=
></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>depmod: *** Unresolved symbols in
/usr/lib/modules/snd-seq-device.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/usr/lib/modules/snd-seq-device.o<o:p></o:p></span></f=
ont></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>depmod: *** Unresolved symbols in =
/usr/lib/modules/snd-seq-midi-event.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/usr/lib/modules/snd-seq-midi-event.o<o:p></o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>depmod: *** Unresolved symbols in
/usr/lib/modules/snd-seq-midi.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/usr/lib/modules/snd-seq-midi.o<o:p></o:p></span></fon=
t></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>depmod: *** Unresolved symbols in
/usr/lib/modules/snd-seq-oss.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/usr/lib/modules/snd-seq-oss.o<o:p></o:p></span></font=
></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>depmod: *** Unresolved symbols in =
/usr/lib/modules/snd-seq.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/usr/lib/modules/snd-seq.o<o:p></o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>depmod: *** Unresolved symbols in
/usr/lib/modules/snd-timer.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/usr/lib/modules/snd-timer.o<o:p></o:p></span></font><=
/p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>depmod: *** Unresolved symbols in =
/usr/lib/modules/snd-via82xx.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/usr/lib/modules/snd-via82xx.o<o:p></o:p></span></font=
></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>depmod: *** Unresolved symbols in =
/usr/lib/modules/snd.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/usr/lib/modules/snd.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Best Regards,</span></font><font =
size=3D2
color=3Dnavy><span =
style=3D'font-size:10.0pt;color:navy'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3D"Times New =
Roman"><span
style=3D'font-size:10.0pt;color:navy'>&nbsp;<o:p></o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Marty DeVall</span></font><font =
size=3D2
color=3Dnavy><span =
style=3D'font-size:10.0pt;color:navy'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3D"Times New =
Roman"><span
style=3D'font-size:10.0pt;color:navy'>&nbsp;<o:p></o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>ThinPATH Systems =
Inc.</span></font><font
size=3D2 color=3Dnavy><span =
style=3D'font-size:10.0pt;color:navy'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><U1:STREET u2:st=3D"on"><U1:ADDRESS =
u2:st=3D"on"><U3:STREET u4:st=3D"on"><U3:ADDRESS =
style=3D"BACKGROUND-POSITION: left bottom; BACKGROUND-IMAGE: =
url(res://ietag.dll/#34/#1001); BACKGROUND-REPEAT: repeat-x" =
tabIndex=3D"0" u4:st=3D"on"><st1:Street
w:st=3D"on"><st1:address tabIndex=3D"0"
 style=3D"BACKGROUND-POSITION: left bottom; BACKGROUND-IMAGE: =
url(res://ietag.dll/#34/#1001); BACKGROUND-REPEAT: repeat-x"
 w:st=3D"on"><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:10.0pt;
  font-family:Arial;color:navy'>26200 SW 95th =
Ave.</span></font></st1:address></st1:Street><o:p></o:p></p>

<p class=3DMsoNormal><st1:Street w:st=3D"on"><st1:address tabIndex=3D"0"
 style=3D"BACKGROUND-POSITION: left bottom; BACKGROUND-IMAGE: =
url(res://ietag.dll/#34/#1001); BACKGROUND-REPEAT: repeat-x"
 w:st=3D"on"><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:10.0pt;
  font-family:Arial;color:navy'>Suite =
301</span></font></st1:address></st1:Street></U3:ADDRESS></U3:STREET></U3=
:ADDRESS></U3:STREET><font
size=3D2 color=3Dnavy><span =
style=3D'font-size:10.0pt;color:navy'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><U1:PLACE u2:st=3D"on"><U1:CITY =
u2:st=3D"on"><st1:place w:st=3D"on"><st1:City
 w:st=3D"on"><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:10.0pt;
  =
font-family:Arial;color:navy'>Wilsonville</span></font></st1:City></st1:p=
lace><font
size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial;
color:navy'></U1:CITY>, <U1:STATE u2:st=3D"on"><st1:State =
w:st=3D"on">OR</U1:STATE></st1:State>
<U1:POSTALCODE u2:st=3D"on"><st1:PostalCode =
w:st=3D"on">97070</U1:POSTALCODE></st1:PostalCode></span></font></U1:PLAC=
E><font
size=3D2 color=3Dnavy><span =
style=3D'font-size:10.0pt;color:navy'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3D"Times New =
Roman"><span
style=3D'font-size:10.0pt;color:navy'>&nbsp;<o:p></o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Phone: =
971-404-3282</span></font><font
size=3D2 color=3Dnavy><span =
style=3D'font-size:10.0pt;color:navy'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Fax:&nbsp;&nbsp;&nbsp;&nbsp; =
971-404-3259<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Web:&nbsp;&nbsp;&nbsp; <a
href=3D"http://www.tp-sys.com">www.tp-sys.com</a></span></font><font =
size=3D2><span
style=3D'font-size:10.0pt'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<img border=3D0 width=3D245 height=3D58 =
id=3D"_x0000_i1025"
src=3D"cid:image001.gif@01C683E0.DBD1A3A0"></span></font><font =
color=3Dnavy
face=3DArial><span =
style=3D'font-family:Arial;color:navy'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_002_01C6841B.883EC731--

------_=_NextPart_001_01C6841B.883EC731
Content-Type: image/gif;
	name="image001.gif"
Content-Transfer-Encoding: base64
Content-ID: <image001.gif@01C683E0.DBD1A3A0>
Content-Description: image001.gif
Content-Location: image001.gif

R0lGODlh9QA6AHcAMSH+GlNvZnR3YXJlOiBNaWNyb3NvZnQgT2ZmaWNlACH5BAEAAAAALAAAAADl
ADoAhwAAAAAAAAAAMwAAZgAAmQAAzAAA/wAzAAAzMwAzZgAzmQAzzAAz/wBmAABmMwBmZgBmmQBm
zABm/wCZAACZMwCZZgCZmQCZzACZ/wDMAADMMwDMZgDMmQDMzADM/wD/AAD/MwD/ZgD/mQD/zAD/
/zMAADMAMzMAZjMAmTMAzDMA/zMzADMzMzMzZjMzmTMzzDMz/zNmADNmMzNmZjNmmTNmzDNm/zOZ
ADOZMzOZZjOZmTOZzDOZ/zPMADPMMzPMZjPMmTPMzDPM/zP/ADP/MzP/ZjP/mTP/zDP//2YAAGYA
M2YAZmYAmWYAzGYA/2YzAGYzM2YzZmYzmWYzzGYz/2ZmAGZmM2ZmZmZmmWZmzGZm/2aZAGaZM2aZ
ZmaZmWaZzGaZ/2bMAGbMM2bMZmbMmWbMzGbM/2b/AGb/M2b/Zmb/mWb/zGb//5kAAJkAM5kAZpkA
mZkAzJkA/5kzAJkzM5kzZpkzmZkzzJkz/5lmAJlmM5lmZplmmZlmzJlm/5mZAJmZM5mZZpmZmZmZ
zJmZ/5nMAJnMM5nMZpnMmZnMzJnM/5n/AJn/M5n/Zpn/mZn/zJn//8wAAMwAM8wAZswAmcwAzMwA
/8wzAMwzM8wzZswzmcwzzMwz/8xmAMxmM8xmZsxmmcxmzMxm/8yZAMyZM8yZZsyZmcyZzMyZ/8zM
AMzMM8zMZszMmczMzMzM/8z/AMz/M8z/Zsz/mcz/zMz///8AAP8AM/8AZv8Amf8AzP8A//8zAP8z
M/8zZv8zmf8zzP8z//9mAP9mM/9mZv9mmf9mzP9m//+ZAP+ZM/+ZZv+Zmf+ZzP+Z///MAP/MM//M
Zv/Mmf/MzP/M////AP//M///Zv//mf//zP///wECAwECAwECAwECAwECAwECAwECAwECAwECAwEC
AwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwEC
AwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwj/AAEIHEiwoMGDCBMqXMhQIQaBGB42nEix
osWLGDNq3MixY8SHEQV6kBiyo8mTKFOqXOmxpMGPH1nKnEmzpk2HLhWOjOjhps+fQINOzLkwZEyh
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
t/JJQAAAOw==

------_=_NextPart_001_01C6841B.883EC731--


--===============1303215760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1303215760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1303215760==--
