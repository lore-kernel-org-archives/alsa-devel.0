From: "Martinez de la Cruz, Leonides" <leonides@ti.com>
Subject: TWL4030 Codec for OMAP
Date: Wed, 7 Mar 2007 14:36:44 -0600
Message-ID: <1E65310C3C9FCC4AAE66BA8952B9842D09DC13@dlee11.ent.ti.com>
References: <1E65310C3C9FCC4AAE66BA8952B9842D09DBF5@dlee11.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0408860614=="
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

--===============0408860614==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C760F8.52037206"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C760F8.52037206
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
I am posting the link for the code:
http://leonidosaurio.8m.com/TI/codec.html =
<http://leonidosaurio.8m.com/TI/codec.html>=20
=20
It looks like the soundcard is registered and so do the controls, but I =
can't have access to them.=20
I am including the info I get if that can be helpful to point out what I =
could be missing.=20
=20
Thanks again,
Leo
-------------------------------------------------------------------------=
---
=20
root@# cat /sys/devices/L3/omap-audio7/
bus              sound:controlC0  sound:pcmC0D0p
driver           sound:pcmC0D0c
root@# cat /proc/driver/
snd-page-alloc  twl4030-rtc
root@# cat /proc/driver/snd-page-alloc
pages  : 262144 bytes (64 pages per 4kB)
root@# cat /sys/module/
8250         mmc_block    snd          snd_timer    v4l1_compat
lockd        smc91x       snd_pcm      tcp_bic      video_buf
root@# cat /sys/module/snd
snd        snd_pcm    snd_timer
root@# cat /sys/module/snd/parameters/
cards_limit  major
root@# cat /sys/module/snd/parameters/cards_limit
1
root@# cat /sys/module/snd_pcm/parameters/
maximum_substreams  preallocate_dma
root@# cat /sys/module/snd_pcm/parameters/maximum_substreams
4
root@# cat /sys/module/snd_timer/parameters/timer_limit
1
root@# more /proc/modules
root@#
root@# cat /dev/s [Tab]
shm      snd      sndstat  stderr   stdin    stdout
root@# cat /dev/snd
snd      sndstat
root@# cat /dev/snd/
controlC0  pcmC0D0c   pcmC0D0p   timer
root@# cat /dev/snd/controlC0
cat: /dev/snd/controlC0: File descriptor in bad state         <-------- =
!!!!
root@# cat /dev/snd/pcmC0D0c
cat: /dev/snd/pcmC0D0c: File descriptor in bad state          <-------- =
!!!!
root@# cat /dev/snd/pcmC0D0p
cat: /dev/snd/pcmC0D0p: Invalid argument                      <-------- =
!!!!
root@# cat /dev/snd/timer
[Ctrl + C]
root@# cat /dev/sndstat
cat: /dev/sndstat: No such file or directory
root@#
root@# cat /proc/asound/card0/pcm0c/info
card: 0
device: 0
subdevice: 0
stream: CAPTURE
id: OMAP PCM
name: omap alsa pcm
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1
root@# cat /proc/asound/card0/pcm0p/info
card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: OMAP PCM
name: omap alsa pcm
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1
root@#
=20
=20

________________________________

From: Martinez de la Cruz, Leonides
Sent: Fri 3/2/2007 4:19 PM
To: alsa-devel@lists.sourceforge.net
Subject: TWL4030 Codec for OMAP


Hi,=20
=20
I am currently working in porting a TWL4030 chip codec to use ALSA =
library. I am using alsa-lib-1.0.13 and alsa-utils-1.0.13, in a 2.6.14 =
kernel version. It seems the sound card is registered and also do the =
mixer controls. But when trying to access the specific information of =
one control, I get the following error:
=20
amixer: Control hw:0 element read error: Inappropriate ioctl for device
=20
Have anyone seen this type of error before? Am I missing to register =
something correctly in the codec?
Any hint will be appreciated. Thanks in advance for your help :)
=20
Regards,
Leo
=20
I am including the log of what I get:
-------------------------------------------------------------------------=
------------------
root@#
root@# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: TWL4030 [TWL4030], device 0: OMAP PCM [omap alsa pcm]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
root@# arecord -l
**** List of CAPTURE Hardware Devices ****
card 0: TWL4030 [TWL4030], device 0: OMAP PCM [omap alsa pcm]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
root@# amixer info
Card default 'TWL4030'/'TWL4030'
  Mixer name    : ''
  Components    : ''
  Controls      : 16
amixer: Mixer load default error: Inappropriate ioctl for device
root@# amixer -c0 controls
numid=3D1,iface=3DMIXER,name=3D'Master Playback Volume'
numid=3D10,iface=3DMIXER,name=3D'Master Capture Volume'
numid=3D7,iface=3DMIXER,name=3D'Earphone Playback Switch'
numid=3D6,iface=3DMIXER,name=3D'Earphone Playback Volume'
numid=3D5,iface=3DMIXER,name=3D'Hands-free Playback Switch'
numid=3D4,iface=3DMIXER,name=3D'Hands-free Playback Volume'
numid=3D3,iface=3DMIXER,name=3D'Headset Playback Switch'
numid=3D2,iface=3DMIXER,name=3D'Headset Playback Volume'
numid=3D12,iface=3DMIXER,name=3D'Headset-Mic Capture Switch'
numid=3D11,iface=3DMIXER,name=3D'Headset-Mic Capture Volume'
numid=3D14,iface=3DMIXER,name=3D'Main-Mic Capture Switch'
numid=3D13,iface=3DMIXER,name=3D'Main-Mic Capture Volume'
numid=3D9,iface=3DMIXER,name=3D'Sidetone Playback Switch'
numid=3D8,iface=3DMIXER,name=3D'Sidetone Playback Volume'
numid=3D16,iface=3DMIXER,name=3D'Sub-Mic Capture Switch'
numid=3D15,iface=3DMIXER,name=3D'Sub-Mic Capture Volume'
root@# amixer -c0 scontrols
amixer: Mixer hw:0 load error: Inappropriate ioctl for device
root@# amixer -c0 cget numid=3D1
numid=3D1,iface=3DMIXER,name=3D'Master Playback Volume'
  ; =
type=3DINTEGER,access=3Drw------,values=3D2,min=3D0,max=3D100,step=3D0
amixer: Control hw:0 element read error: Inappropriate ioctl for device
root@# amixer -c0 cset numid=3D1 50
amixer: Control hw:0 element write error: Inappropriate ioctl for device
root@#

------_=_NextPart_001_01C760F8.52037206
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML dir=3Dltr><HEAD>=0A=
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dunicode">=0A=
<META content=3D"MSHTML 6.00.6000.16414" name=3DGENERATOR></HEAD>=0A=
<BODY>=0A=
<DIV id=3DidOWAReplyText26096 dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 =
size=3D2>Hi,</FONT></DIV>=0A=
<DIV dir=3Dltr>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>I am posting the link for the =
code:</FONT></DIV>=0A=
<DIV dir=3Dltr><A =
href=3D"http://leonidosaurio.8m.com/TI/codec.html"><FONT face=3DArial =
size=3D2>http://leonidosaurio.8m.com/TI/codec.html</FONT></A></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>It looks like the soundcard =
is registered and so do the controls, but I can't have access to =
them.&nbsp;</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>I am including the =
i</FONT><FONT face=3DArial size=3D2>nfo I get if&nbsp;that can be =
helpful to point out what I&nbsp;could be&nbsp;missing. </FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Thanks again,</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Leo</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial =
size=3D2>----------------------------------------------------------------=
------------</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT face=3D"Courier New" =
size=3D2><STRONG>root@</STRONG></FONT><FONT face=3D"Courier New" =
size=3D2><STRONG># cat =
/sys/devices/L3/omap-audio7/</STRONG><BR>bus&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sound:controlC0&nbsp; =
sound:pcmC0D0p<BR>driver&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; sound:pcmC0D0c</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3D"Courier New" =
size=3D2><STRONG>root@</STRONG></FONT><FONT face=3D"Courier New" =
size=3D2><STRONG># cat /proc/driver/</STRONG><BR>snd-page-alloc&nbsp; =
twl4030-rtc<BR></FONT><FONT face=3D"Courier New" =
size=3D2><STRONG>root@</STRONG></FONT><FONT face=3D"Courier New" =
size=3D2><STRONG># cat =
/proc/driver/snd-page-alloc</STRONG><BR>pages&nbsp; : 262144 bytes (64 =
pages per 4kB)</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3D"Courier New" =
size=3D2><STRONG>root@</STRONG></FONT><FONT face=3D"Courier New" =
size=3D2><STRONG># cat =
/sys/module/</STRONG><BR>8250&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; mmc_block&nbsp;&nbsp;&nbsp; =
snd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
snd_timer&nbsp;&nbsp;&nbsp; =
v4l1_compat<BR>lockd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
smc91x&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
snd_pcm&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tcp_bic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; video_buf<BR></FONT><FONT =
face=3D"Courier New" size=3D2><STRONG>root@</STRONG></FONT><FONT =
face=3D"Courier New" size=3D2><STRONG># cat =
/sys/module/snd</STRONG><BR>snd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 snd_pcm&nbsp;&nbsp;&nbsp; snd_timer<BR></FONT><FONT face=3D"Courier =
New" size=3D2><STRONG>root@</STRONG></FONT><FONT face=3D"Courier New" =
size=3D2><STRONG># cat =
/sys/module/snd/parameters/</STRONG><BR>cards_limit&nbsp; =
major<BR></FONT><FONT face=3D"Courier New" =
size=3D2><STRONG>root@</STRONG></FONT><FONT face=3D"Courier New" =
size=3D2><STRONG># cat =
/sys/module/snd/parameters/cards_limit</STRONG><BR>1<BR></FONT><FONT =
face=3D"Courier New" size=3D2><STRONG>root@</STRONG></FONT><FONT =
face=3D"Courier New" size=3D2><STRONG># cat =
/sys/module/snd_pcm/parameters/</STRONG><BR>maximum_substreams&nbsp; =
preallocate_dma<BR></FONT><FONT face=3D"Courier New" =
size=3D2><STRONG>root@</STRONG></FONT><FONT face=3D"Courier New" =
size=3D2><STRONG># cat =
/sys/module/snd_pcm/parameters/maximum_substreams<BR></STRONG>4<BR></FONT=
><FONT face=3D"Courier New" size=3D2><STRONG>root@</STRONG></FONT><FONT =
face=3D"Courier New" size=3D2><STRONG># cat =
/sys/module/snd_timer/parameters/timer_limit</STRONG><BR>1</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3D"Courier New" =
size=3D2><STRONG>root@</STRONG></FONT><STRONG><FONT face=3D"Courier New" =
size=3D2># more /proc/modules<BR></FONT><FONT face=3D"Courier New" =
size=3D2>root@</FONT><FONT face=3D"Courier New" =
size=3D2>#</FONT></STRONG></DIV>=0A=
<DIV dir=3Dltr><FONT face=3D"Courier New" =
size=3D2><STRONG>root@</STRONG></FONT><FONT face=3D"Courier New" =
size=3D2><STRONG># cat /dev/s =
</STRONG>[Tab]<BR>shm&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
snd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sndstat&nbsp; stderr&nbsp;&nbsp; =
stdin&nbsp;&nbsp;&nbsp; stdout<BR></FONT><FONT face=3D"Courier New" =
size=3D2><STRONG>root@</STRONG></FONT><FONT face=3D"Courier New" =
size=3D2><STRONG># cat =
/dev/snd</STRONG><BR>snd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
sndstat<BR></FONT><FONT face=3D"Courier New" =
size=3D2><STRONG>root@</STRONG></FONT><FONT face=3D"Courier New" =
size=3D2><STRONG># cat /dev/snd/</STRONG><BR>controlC0&nbsp; =
pcmC0D0c&nbsp;&nbsp; pcmC0D0p&nbsp;&nbsp; timer<BR></FONT><FONT =
face=3D"Courier New" size=3D2><STRONG>root@</STRONG></FONT><FONT =
face=3D"Courier New" size=3D2><STRONG># cat =
/dev/snd/controlC0</STRONG><BR>cat: /dev/snd/controlC0: File descriptor =
in bad state&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT =
color=3D#ff0000>&lt;-------- !!!!</FONT><BR></FONT><FONT face=3D"Courier =
New" size=3D2><STRONG>root@</STRONG></FONT><FONT face=3D"Courier New" =
size=3D2><STRONG># cat /dev/snd/pcmC0D0c</STRONG><BR>cat: =
/dev/snd/pcmC0D0c: File descriptor in bad =
state&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT =
color=3D#ff0000>&lt;-------- !!!!<BR></FONT></FONT><FONT face=3D"Courier =
New" size=3D2><STRONG>root@</STRONG></FONT><FONT face=3D"Courier New" =
size=3D2><STRONG># cat /dev/snd/pcmC0D0p</STRONG><BR>cat: =
/dev/snd/pcmC0D0p: Invalid =
argument&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<FONT =
color=3D#ff0000>&lt;-------- !!!!</FONT><BR></FONT><STRONG><FONT =
face=3D"Courier New" size=3D2>root@</FONT><FONT face=3D"Courier New" =
size=3D2># cat /dev/snd/timer</FONT></STRONG></DIV>=0A=
<DIV dir=3Dltr><FONT face=3D"Courier New" size=3D2>[Ctrl + =
C]</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3D"Courier New" =
size=3D2>ro<STRONG>ot@</STRONG></FONT><FONT face=3D"Courier New" =
size=3D2><STRONG># cat /dev/sndstat</STRONG><BR>cat: /dev/sndstat: No =
such file or directory<BR></FONT><STRONG><FONT face=3D"Courier New" =
size=3D2>root@</FONT><FONT face=3D"Courier New" =
size=3D2>#</FONT></STRONG></DIV>=0A=
<DIV dir=3Dltr><FONT face=3D"Courier New" =
size=3D2><STRONG>root@</STRONG></FONT><FONT face=3D"Courier New" =
size=3D2><STRONG># cat /proc/asound/card0/pcm0c/info</STRONG><BR>card: =
0<BR>device: 0<BR>subdevice: 0<BR>stream: CAPTURE<BR>id: OMAP =
PCM<BR>name: omap alsa pcm<BR>subname: subdevice #0<BR>class: =
0<BR>subclass: 0<BR>subdevices_count: 1<BR>subdevices_avail: =
1<BR></FONT><FONT face=3D"Courier New" =
size=3D2><STRONG>root@</STRONG></FONT><FONT face=3D"Courier New" =
size=3D2><STRONG># cat /proc/asound/card0/pcm0p/info</STRONG><BR>card: =
0<BR>device: 0<BR>subdevice: 0<BR>stream: PLAYBACK<BR>id: OMAP =
PCM<BR>name: omap alsa pcm<BR>subname: subdevice #0<BR>class: =
0<BR>subclass: 0<BR>subdevices_count: 1<BR>subdevices_avail: =
1<BR></FONT><STRONG><FONT face=3D"Courier New" =
size=3D2>root@</FONT><FONT face=3D"Courier New" =
size=3D2>#</FONT></STRONG></DIV>=0A=
<DIV dir=3Dltr><STRONG><FONT face=3D"Courier New" =
size=3D2></FONT></STRONG>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><STRONG><FONT face=3D"Courier New" =
size=3D2></FONT></STRONG>&nbsp;</DIV></DIV></DIV>=0A=
<DIV dir=3Dltr><BR>=0A=
<HR tabIndex=3D-1>=0A=
<FONT face=3DTahoma size=3D2><B>From:</B> Martinez de la Cruz, =
Leonides<BR><B>Sent:</B> Fri 3/2/2007 4:19 PM<BR><B>To:</B> =
alsa-devel@lists.sourceforge.net<BR><B>Subject:</B> TWL4030 Codec for =
OMAP<BR></FONT><BR></DIV>=0A=
<DIV dir=3Dltr>=0A=
<DIV><FONT face=3DArial color=3D#000000 size=3D2>=0A=
<DIV><FONT face=3DArial size=3D2>Hi, </FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2>I am currently&nbsp;working in =
porting&nbsp;a TWL4030 chip codec&nbsp;to use ALSA =
library.&nbsp;I&nbsp;am using alsa-lib-1.0.13 and =
alsa-utils-1.0.13,&nbsp;in a 2.6.14 kernel version. It seems the sound =
card is registered and also do the mixer controls. But when trying to =
access the specific information of one control, I get the following =
error:</FONT></DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV><FONT face=3D"Courier New" size=3D2>amixer: Control hw:0 element =
read error: Inappropriate ioctl for device</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2>Have anyone seen this type of error =
before? Am I missing to register something correctly in the =
codec?</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2>Any hint will be appreciated. Thanks in =
advance for&nbsp;your help :)</FONT></DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2>Regards,</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2>Leo</FONT></DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV>I am including the log of what I get:</DIV>=0A=
<DIV><FONT face=3DArial =
size=3D2>----------------------------------------------------------------=
---------------------------</FONT></DIV>=0A=
<DIV><FONT color=3D#000000 size=3D2><FONT face=3D"Courier =
New"><STRONG>root@</STRONG></FONT><STRONG><FONT face=3D"Courier =
New">#<BR></FONT><FONT face=3D"Courier New">root@</FONT></STRONG><FONT =
face=3D"Courier New"><STRONG># aplay -l</STRONG><BR>**** List of =
PLAYBACK Hardware Devices ****<BR>card 0: TWL4030 [TWL4030], device 0: =
OMAP PCM [omap alsa pcm]<BR>&nbsp; Subdevices: 1/1<BR>&nbsp; Subdevice =
#0: subdevice #0<BR></FONT><FONT face=3D"Courier =
New"><STRONG>root@</STRONG></FONT><FONT face=3D"Courier New"><STRONG># =
arecord -l</STRONG><BR>**** List of CAPTURE Hardware Devices =
****<BR>card 0: TWL4030 [TWL4030], device 0: OMAP PCM [omap alsa =
pcm]<BR>&nbsp; Subdevices: 1/1<BR>&nbsp; Subdevice #0: subdevice =
#0<BR></FONT><FONT face=3D"Courier =
New"><STRONG>root@</STRONG></FONT><FONT face=3D"Courier New"><STRONG># =
amixer info</STRONG><BR>Card default 'TWL4030'/'TWL4030'<BR>&nbsp; Mixer =
name&nbsp;&nbsp;&nbsp; : ''<BR>&nbsp; Components&nbsp;&nbsp;&nbsp; : =
''<BR>&nbsp; Controls&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 16<BR>amixer: =
Mixer load default error: Inappropriate ioctl for device<BR></FONT><FONT =
face=3D"Courier New"><STRONG>root@</STRONG></FONT><FONT face=3D"Courier =
New"><STRONG># amixer -c0 =
controls</STRONG><BR>numid=3D1,iface=3DMIXER,name=3D'Master Playback =
Volume'<BR>numid=3D10,iface=3DMIXER,name=3D'Master Capture =
Volume'<BR>numid=3D7,iface=3DMIXER,name=3D'Earphone Playback =
Switch'<BR>numid=3D6,iface=3DMIXER,name=3D'Earphone Playback =
Volume'<BR>numid=3D5,iface=3DMIXER,name=3D'Hands-free Playback =
Switch'<BR>numid=3D4,iface=3DMIXER,name=3D'Hands-free Playback =
Volume'<BR>numid=3D3,iface=3DMIXER,name=3D'Headset Playback =
Switch'<BR>numid=3D2,iface=3DMIXER,name=3D'Headset Playback =
Volume'<BR>numid=3D12,iface=3DMIXER,name=3D'Headset-Mic Capture =
Switch'<BR>numid=3D11,iface=3DMIXER,name=3D'Headset-Mic Capture =
Volume'<BR>numid=3D14,iface=3DMIXER,name=3D'Main-Mic Capture =
Switch'<BR>numid=3D13,iface=3DMIXER,name=3D'Main-Mic Capture =
Volume'<BR>numid=3D9,iface=3DMIXER,name=3D'Sidetone Playback =
Switch'<BR>numid=3D8,iface=3DMIXER,name=3D'Sidetone Playback =
Volume'<BR>numid=3D16,iface=3DMIXER,name=3D'Sub-Mic Capture =
Switch'<BR>numid=3D15,iface=3DMIXER,name=3D'Sub-Mic Capture =
Volume'<BR></FONT><FONT face=3D"Courier =
New"><STRONG>root@</STRONG></FONT><FONT face=3D"Courier New"><STRONG># =
amixer -c0 scontrols</STRONG><BR>amixer: Mixer hw:0 load error: =
Inappropriate ioctl for device<BR></FONT><FONT face=3D"Courier =
New"><STRONG>root@</STRONG></FONT><FONT face=3D"Courier New"><STRONG># =
amixer -c0 cget =
numid=3D1</STRONG><BR>numid=3D1,iface=3DMIXER,name=3D'Master Playback =
Volume'<BR>&nbsp; ; =
type=3DINTEGER,access=3Drw------,values=3D2,min=3D0,max=3D100,step=3D0<BR=
>amixer: Control hw:0 element read error: Inappropriate ioctl for =
device</FONT></FONT></DIV>=0A=
<DIV><FONT color=3D#000000 size=3D2><FONT face=3D"Courier =
New"><STRONG>root@</STRONG></FONT><FONT face=3D"Courier New"><STRONG># =
amixer -c0 cset numid=3D1 50</STRONG><BR>amixer: Control hw:0 element =
write error: Inappropriate ioctl for device</FONT></FONT></DIV>=0A=
<DIV><FONT color=3D#000000 size=3D2><STRONG><FONT face=3D"Courier =
New">root@</FONT><FONT face=3D"Courier =
New">#</FONT></STRONG></FONT></DIV></FONT></DIV></DIV></BODY></HTML>
------_=_NextPart_001_01C760F8.52037206--


--===============0408860614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0408860614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0408860614==--
