From: noreply@alsa-project.org
Subject: [ALSA - driver 0000263]: Maya44 MKII (Envy 24HT processor) probes correctly yet doesn't work.
Date: Thu, 17 Jun 2004 08:02:41 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <e0020444a11ed791321bbe0de80ac9c1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A BUGNOTE has been added to this bug.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0263
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Reported By:                Vladimir Dyakov
Assigned To:               =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Project:                    ALSA - driver
Bug ID:                     263
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               ASPLinux 9.2 (base on Fedora Core 1)
Kernel Version:             kernel-2.6.5-mm6
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Date Submitted:             05-08-2004 08:27 CEST
Last Modified:              06-17-2004 08:02 CEST
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary:                    Maya44 MKII (Envy 24HT processor) probes corr=
ectly
yet doesn't work.
Description:=20
I've got Audiotrak Maya44 MKII soundcard and Linux kernel-2.6.5-mm6 with
alsa-1.0.4rc2. If I am not mistaken my soundcard is base on Envy24HT
processor. There's a driver in alsa for this processor called ice1724.
It's written in it's source that it supports only Prodigy 7.1.

Is there any way to make driver work with my audio card?
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

----------------------------------------------------------------------
 Vladimir Dyakov - 05-08-2004 08:35 CEST=20
----------------------------------------------------------------------
I tried to upload file with photographs and it failed with note to apply =
to
site admin. The photos can be found here:
http://linux.alhimia.ru/pub/maya_photos.rar (1.7 Mb)

----------------------------------------------------------------------
 Vladimir Dyakov - 05-11-2004 07:03 CEST=20
----------------------------------------------------------------------
Hi, I tried to get round EEPROM check in ice1724.c and had some interstin=
g
results.

Here is the patch:
--- cut ---
--- ice1724.c.orig  2004-05-10 13:31:15.000000000 +0600=20
+++ ice1724.c   2004-05-10 13:30:49.191099408 +0600=20
@@ -1777,6 +1777,8 @@ static int __devinit snd_vt1724_read_eep
    ice->eeprom.size =3D snd_vt1724_read_i2c(ice, dev, 0x04);
    if (ice->eeprom.size < 6)
        ice->eeprom.size =3D 32;
+   if (ice->eeprom.size =3D=3D 120)=20
+       ice->eeprom.size =3D 32;=20
    else if (ice->eeprom.size > 32) {
        snd_printk("invalid EEPROM (size =3D %i)\n", ice->eeprom.size);
        return -EIO;
--- /cut ---

dmesg now says:
--- cut ---
invalid EEPROM version 120
AC'97 0 does not respond - RESET
AC'97 0 access is not valid [0xffffffff], removing mixer.
ice1712: cannot initialize pro ac97, skipped
--- /cut ---

lsmod:
--- cut ---
Module                  Size  Used by
ac                      3980  0
asb100                 21632  0
asus_acpi               9368  0
autofs                 13184  0
battery                 8204  0
bluetooth              41444  4 rfcomm,l2cap
button                  4760  0
cdrom                  38944  1 ide_cd
eeprom                  6408  0
fan                     3084  0
fat                    40384  1 vfat
hid                    31364  0
i2c_core               18692  5
eeprom,w83l785ts,asb100,i2c_sensor,i2c_nforce2
i2c_nforce2             5376  0
i2c_sensor              2560  3 eeprom,w83l785ts,asb100
ide_cd                 38276  0
ipv6                  244260  12
isofs                  31032  3
l2cap                  19972  5 rfcomm
md                     41416  0
ntfs                   86476  1
nvidia               1703180  10
ohci_hcd               17564  0
processor              14896  1 thermal
reiserfs              257140  1
rfcomm                 33692  0
sd_mod                 19072  0
snd_ac97_codec         60932  1 snd_ice1724
snd_ak4xxx_adda         5632  2 snd_ice1724,snd_ice17xx_ak4xxx
snd_ice1724            35532  1
snd_ice17xx_ak4xxx      3328  1 snd_ice1724
snd_mpu401_uart         6016  1 snd_ice1724
snd_rawmidi            20000  1 snd_mpu401_uart
supermount             89748  1
thermal                11536  0
udf                    96644  0
vfat                   12032  1
w83l785ts               6148  0
zlib_inflate           21376  1 isofs
--- /cut ---

the window of alsamixer:
--- cut ---
lqqqqqqqqqqqqqqqqqqqqqqqqqq[AlsaMixer v1.00 (Press Escape to
quit)]qqqqqqqqqqqqqqqqqqqqqqqqqqqk
x Card: ICEnsemble ICE1724                                               =
=20
                   x
x Chip: ICE1724 - multitrack                                             =
=20
                   x
x Item: IEC958                                                           =
=20
                   x
x                                                                        =
=20
                   x
x             lMMk                       lqqk     lqqk     lqqk     lqqk =
=20
  lMMk     lqqk    x
x             x  x                       x  x     x  x     x  x     x  x =
=20
  x  x     x  x    x
x             x  x                       x  x     x  x     x  x     x  x =
=20
  x  x     x  x    x
x             x  x                       x  x     x  x     x  x     x  x =
=20
  x  x     x  x    x
x             x  x                       x  x     x  x     x  x     x  x =
=20
  x  x     x  x    x
x             x  x                       x  x     x  x     x  x     x  x =
=20
  x  x     x  x    x
x             x  x                       x  x     x  x     x  x     x  x =
=20
  x  x     x  x    x
x  H/W In 0   x  x   PCM Out   44100     x  x     x  x     x  x     x  x =
=20
  x  x     x  x    x
x             x  x                       x  x     x  x     x  x     x  x =
=20
  x  x     x  x    x
x             x  x                       x  x     x  x     x  x     x  x =
=20
  x  x     x  x    x
x             x  x                       x  x     x  x     x  x     x  x =
=20
  x  x     x  x    x
x             mqqj                       mqqj     mqqj     mqqj     mqqj =
=20
  mqqj     mqqj    x
x                                        0<>0     0<>0     0<>0     0<>0 =
=20
                   x
x < IEC958 >IEC958 O IEC958 1 Multi Tr Multi Tr Multi Tr Multi Tr Multi T=
r
Multi Tr Multi Tr  x
x                                                                        =
=20
                   x
mqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq=
qqqqqqqqqqqqqqqqqqqqqj
--- /cut ---

ls -lRa /proc/asound
--- cut ---
/proc/asound:
total 1
dr-xr-xr-x    5 root     root            0 May 10 14:48 .
dr-xr-xr-x  103 root     root            0 May 10  2004 ..
lrwxrwxrwx    1 root     root            5 May 10 14:49 ICE1724 -> card0
dr-xr-xr-x    7 root     root            0 May 10 14:49 card0
-r--r--r--    1 root     root            0 May 10 14:49 cards
-r--r--r--    1 root     root            0 May 10 14:49 devices
dr-xr-xr-x    2 root     root            0 May 10 14:49 oss
-r--r--r--    1 root     root            0 May 10 14:49 pcm
dr-xr-xr-x    2 root     root            0 May 10 14:49 seq
-r--r--r--    1 root     root            0 May 10 14:49 timers
-r--r--r--    1 root     root            0 May 10 14:49 version

/proc/asound/card0:
total 0
dr-xr-xr-x    7 root     root            0 May 10 14:49 .
dr-xr-xr-x    5 root     root            0 May 10 14:48 ..
dr-xr-xr-x    2 root     root            0 May 10 14:49 codec97#0
-r--r--r--    1 root     root            0 May 10 14:49 ice1724
-r--r--r--    1 root     root            0 May 10 14:49 id
-r--r--r--    1 root     root            0 May 10 14:49 midi0
-rw-r--r--    1 root     root            0 May 10 14:49 oss_mixer
dr-xr-xr-x    3 root     root            0 May 10 14:49 pcm0c
dr-xr-xr-x    3 root     root            0 May 10 14:49 pcm0p
dr-xr-xr-x    3 root     root            0 May 10 14:49 pcm1c
dr-xr-xr-x    3 root     root            0 May 10 14:49 pcm1p

/proc/asound/card0/codec97#0:
total 0
dr-xr-xr-x    2 root     root            0 May 10 14:49 .
dr-xr-xr-x    7 root     root            0 May 10 14:49 ..

/proc/asound/card0/pcm0c:
total 0
dr-xr-xr-x    3 root     root            0 May 10 14:49 .
dr-xr-xr-x    7 root     root            0 May 10 14:49 ..
-r--r--r--    1 root     root            0 May 10 14:49 info
-rw-r--r--    1 root     root            0 May 10 14:49 oss
dr-xr-xr-x    2 root     root            0 May 10 14:49 sub0

/proc/asound/card0/pcm0c/sub0:=20
total 0
dr-xr-xr-x    2 root     root            0 May 10 14:49 .
dr-xr-xr-x    3 root     root            0 May 10 14:49 ..
-r--r--r--    1 root     root            0 May 10 14:49 hw_params
-r--r--r--    1 root     root            0 May 10 14:49 info
-r--r--r--    1 root     root            0 May 10 14:49 prealloc
-r--r--r--    1 root     root            0 May 10 14:49 status
-r--r--r--    1 root     root            0 May 10 14:49 sw_params

/proc/asound/card0/pcm0p:
total 0
dr-xr-xr-x    3 root     root            0 May 10 14:49 .
dr-xr-xr-x    7 root     root            0 May 10 14:49 ..
-r--r--r--    1 root     root            0 May 10 14:49 info
-rw-r--r--    1 root     root            0 May 10 14:49 oss
dr-xr-xr-x    2 root     root            0 May 10 14:49 sub0

/proc/asound/card0/pcm0p/sub0:
total 0
dr-xr-xr-x    2 root     root            0 May 10 14:49 .
dr-xr-xr-x    3 root     root            0 May 10 14:49 ..
-r--r--r--    1 root     root            0 May 10 14:49 hw_params
-r--r--r--    1 root     root            0 May 10 14:49 info
-r--r--r--    1 root     root            0 May 10 14:49 prealloc
-r--r--r--    1 root     root            0 May 10 14:49 status
-r--r--r--    1 root     root            0 May 10 14:49 sw_params

/proc/asound/card0/pcm1c:
total 0
dr-xr-xr-x    3 root     root            0 May 10 14:49 .
dr-xr-xr-x    7 root     root            0 May 10 14:49 ..
-r--r--r--    1 root     root            0 May 10 14:49 info
-rw-r--r--    1 root     root            0 May 10 14:49 oss
dr-xr-xr-x    2 root     root            0 May 10 14:49 sub0

/proc/asound/card0/pcm1c/sub0:
total 0
dr-xr-xr-x    2 root     root            0 May 10 14:49 .
dr-xr-xr-x    3 root     root            0 May 10 14:49 ..
-r--r--r--    1 root     root            0 May 10 14:49 hw_params
-r--r--r--    1 root     root            0 May 10 14:49 info
-r--r--r--    1 root     root            0 May 10 14:49 prealloc
-r--r--r--    1 root     root            0 May 10 14:49 status
-r--r--r--    1 root     root            0 May 10 14:49 sw_params

/proc/asound/card0/pcm1p:=20
total 0
dr-xr-xr-x    3 root     root            0 May 10 14:49 .
dr-xr-xr-x    7 root     root            0 May 10 14:49 ..
-r--r--r--    1 root     root            0 May 10 14:49 info
-rw-r--r--    1 root     root            0 May 10 14:49 oss
dr-xr-xr-x    2 root     root            0 May 10 14:49 sub0

/proc/asound/card0/pcm1p/sub0:
total 0
dr-xr-xr-x    2 root     root            0 May 10 14:49 .
dr-xr-xr-x    3 root     root            0 May 10 14:49 ..
-r--r--r--    1 root     root            0 May 10 14:49 hw_params
-r--r--r--    1 root     root            0 May 10 14:49 info
-r--r--r--    1 root     root            0 May 10 14:49 prealloc
-r--r--r--    1 root     root            0 May 10 14:49 status
-r--r--r--    1 root     root            0 May 10 14:49 sw_params

/proc/asound/oss:
total 0
dr-xr-xr-x    2 root     root            0 May 10 14:49 .
dr-xr-xr-x    5 root     root            0 May 10 14:48 ..
-r--r--r--    1 root     root            0 May 10 14:49 devices
-r--r--r--    1 root     root            0 May 10 14:49 sndstat

/proc/asound/seq:
total 0
dr-xr-xr-x    2 root     root            0 May 10 14:49 .
dr-xr-xr-x    5 root     root            0 May 10 14:48 ..
-r--r--r--    1 root     root            0 May 10 14:49 clients
-r--r--r--    1 root     root            0 May 10 14:49 drivers
-r--r--r--    1 root     root            0 May 10 14:49 oss
-r--r--r--    1 root     root            0 May 10 14:49 queues
-r--r--r--    1 root     root            0 May 10 14:49 timer
--- /cut ---

----------------------------------------------------------------------
 Vladimir Dyakov - 05-11-2004 07:07 CEST=20
----------------------------------------------------------------------
Alsamixer output in my previous post seems to be looking corrupted, so I
have put more humanic screenshot here:
http://linux.alhimia.ru/pub/alsamixer.html

----------------------------------------------------------------------
 tiwai - 05-18-2004 20:44 CEST=20
----------------------------------------------------------------------
what shows the EEPROM of /proc/asound/card0/ice1724 after your patch?

----------------------------------------------------------------------
 Vladimir Dyakov - 05-19-2004 13:31 CEST=20
----------------------------------------------------------------------
$ cat /proc/asound/card0/ice1724 | grep EPROM
EEPROM:
$ cat /proc/asound/card0/ice1724
ICEnsemble ICE1724 at 0xd000, irq 11

EEPROM:
  Subvendor        : 0x30315441
  Size             : 32 bytes
  Version          : 120
  System Config    : 0x78
  ACLink           : 0x78
  I2S              : 0x45
  S/PDIF           : 0x47
  GPIO direction   : 0x59534f
  GPIO mask        : 0xffff53
  GPIO state       : 0xffffff
  Extra
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0018    =20
  : 0xff
  Extra
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0019    =20
  : 0xff
  Extra
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0020    =20
  : 0xff
  Extra
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0021    =20
  : 0xff
  Extra
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0022    =20
  : 0xff
  Extra
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0023    =20
  : 0xff
  Extra
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0024    =20
  : 0xff
  Extra
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0025    =20
  : 0xff
  Extra
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0026    =20
  : 0x0
  Extra
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0027    =20
  : 0x0
  Extra
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0028    =20
  : 0x0
  Extra
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0029    =20
  : 0x0
  Extra
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0030    =20
  : 0x0
  Extra
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0031    =20
  : 0x0

Registers:
  PSDOUT03 : 0x00000002
  CCS00    : 0x00
  CCS01    : 0x00
  CCS02    : 0x00
  CCS03    : 0x00
  CCS04    : 0x78
  CCS05    : 0x00
  CCS06    : 0x45
  CCS07    : 0x47
  CCS08    : 0x00
  CCS09    : 0x00
  CCS0a    : 0x00
  CCS0b    : 0x00
  CCS0c    : 0x00
  CCS0d    : 0x0a
  CCS0e    : 0x00
  CCS0f    : 0x00
  CCS10    : 0x00
  CCS11    : 0x00
  CCS12    : 0x30
  CCS13    : 0x80
  CCS14    : 0xbc
  CCS15    : 0xa4
  CCS16    : 0x53
  CCS17    : 0xff
  CCS18    : 0x4f
  CCS19    : 0x53
  CCS1a    : 0x59
  CCS1b    : 0x00
  CCS1c    : 0x00
  CCS1d    : 0x00
  CCS1e    : 0x22
  CCS1f    : 0xff
  MT00     : 0x00
  MT01     : 0x00
  MT02     : 0x00
  MT03     : 0x08
  MT04     : 0x00
  MT05     : 0x30
  MT06     : 0x00
  MT07     : 0x00
  MT08     : 0x00
  MT09     : 0x00
  MT0a     : 0x00
  MT0b     : 0x00
  MT0c     : 0x00
  MT0d     : 0x00
  MT0e     : 0x00
  MT0f     : 0x00
  MT10     : 0x00
  MT11     : 0x00
  MT12     : 0x00
  MT13     : 0x00
  MT14     : 0x00
  MT15     : 0x00
  MT16     : 0x00
  MT17     : 0x00
  MT18     : 0x00
  MT19     : 0x00
  MT1a     : 0x00
  MT1b     : 0x00
  MT1c     : 0x00
  MT1d     : 0x00
  MT1e     : 0x00
  MT1f     : 0x00
  MT20     : 0x00
  MT21     : 0x00
  MT22     : 0x00
  MT23     : 0x00
  MT24     : 0x00
  MT25     : 0x00
  MT26     : 0x00
  MT27     : 0x00
  MT28     : 0x00
  MT29     : 0x00
  MT2a     : 0x00
  MT2b     : 0x00
  MT2c     : 0x02
  MT2d     : 0x00
  MT2e     : 0x00
  MT2f     : 0x00

----------------------------------------------------------------------
 Vladimir Dyakov - 05-19-2004 13:35 CEST=20
----------------------------------------------------------------------
I submitted information from proc that you have asked but again it seems =
to
have been corrupted by the bugtracking system. It is available in origin
here: http://linux.alhimia.ru/pub/ice1724

----------------------------------------------------------------------
 tiwai - 05-25-2004 14:51 CEST=20
----------------------------------------------------------------------
hmm,the values look bogus.

try to dump all 120 bytes in the probe routine (via printk)
for checking the real EEPROM image offset and size.

----------------------------------------------------------------------
 Vladimir Dyakov - 05-26-2004 04:33 CEST=20
----------------------------------------------------------------------
> try to dump all 120 bytes in the probe routine (via printk)
> for checking the real EEPROM image offset and size.

Feel myself a fool but do not know how to. Is printk that what goes to
dmesg?

----------------------------------------------------------------------
 tiwai - 05-26-2004 14:35 CEST=20
----------------------------------------------------------------------
i meant to add a debug output in snd_vt1724_read_eeprom():
    for (i =3D 0; i < 120; i++)
        printk(KERN_DEBUG "EEPROM: %02x %02x\n",
            i, snd_vt1724_read_i2c(ice, dev, i));

then attach the resultant dump in the kernel message.

----------------------------------------------------------------------
 Vladimir Dyakov - 05-31-2004 05:26 CEST=20
----------------------------------------------------------------------
> i meant to add a debug output in snd_vt1724_read_eeprom():
> ...
> then attach the resultant dump in the kernel message.

I've done both correct eeprom size detection and printk() output. The
patch, dmesg and /proc/asound/card0/ice1724 are here:
http://linux.alhimia.ru/pub/alsa/2/

----------------------------------------------------------------------
 Vladimir Dyakov - 05-31-2004 05:29 CEST=20
----------------------------------------------------------------------
All previous stuff is available here (if you will need it):
http://linux.alhimia.ru/pub/alsa/1/

----------------------------------------------------------------------
 Vladimir Dyakov - 06-17-2004 06:51 CEST=20
----------------------------------------------------------------------
Hi.
I've plugged in alsa-1.0.5a driver and now get this in dmesg:
http://linux.alhimia.ru/pub/alsa/3/dmesg

----------------------------------------------------------------------
 Apostolos Dimitromanolakis - 06-17-2004 08:02 CEST=20
----------------------------------------------------------------------
The ice1724 driver will need to be extended to handle your card, it will
not work as it is since I don't think any othe card has a WM8731 chip (no=
t
sure about this, at least not Prodigy, M-Audio Revolution and Aureon). Th=
e
thing to do is figure out the connections between envy24 and WM8731 codec=
s
and then maybe someone can modift the driver to work. This is a bit
difficult if you don't have the card but possible with some patience. Loo=
k
what the guys at some other new eny24 card did:

https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0142

Bug History
Date Modified  Username       Field                    Change            =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
05-08-04 08:27 Vladimir DyakovNew Bug                                    =
 =20
05-08-04 08:27 Vladimir DyakovDistribution              =3D> ASPLinux 9.2=
 (base on
Fedora Core 1)
05-08-04 08:27 Vladimir DyakovKernel Version            =3D> kernel-2.6.5=
-mm6
05-08-04 08:35 Vladimir DyakovBugnote Added: 0001070                     =
 =20
05-11-04 07:03 Vladimir DyakovBugnote Added: 0001081                     =
 =20
05-11-04 07:07 Vladimir DyakovBugnote Added: 0001082                     =
 =20
05-18-04 20:44 tiwai          Bugnote Added: 0001144                     =
 =20
05-19-04 13:31 Vladimir DyakovBugnote Added: 0001151                     =
 =20
05-19-04 13:35 Vladimir DyakovBugnote Added: 0001152                     =
 =20
05-25-04 14:51 tiwai          Bugnote Added: 0001212                     =
 =20
05-26-04 04:33 Vladimir DyakovBugnote Added: 0001245                     =
 =20
05-26-04 14:35 tiwai          Bugnote Added: 0001256                     =
 =20
05-31-04 05:26 Vladimir DyakovBugnote Added: 0001279                     =
 =20
05-31-04 05:29 Vladimir DyakovBugnote Added: 0001280                     =
 =20
06-17-04 06:51 Vladimir DyakovBugnote Added: 0001314                     =
 =20
06-17-04 08:02 Apostolos DimitromanolakisBugnote Added: 0001315          =
      =20
    =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
