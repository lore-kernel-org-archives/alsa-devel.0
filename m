From: noreply@alsa-project.org
Subject: [ALSA - driver 0000238]: spdif output fails with atiixp
Date: Sat, 12 Jun 2004 16:41:05 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <283b640b7b2aa5cd1c85d439ec2f72a3@bugtrack.alsa-project.org>
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
0238
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Reported By:                pkashou
Assigned To:                tiwai
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Project:                    ALSA - driver
Bug ID:                     238
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             gentoo-dev-sources 2.6.5 (running cvs alsa in
kernel)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Date Submitted:             04-27-2004 03:54 CEST
Last Modified:              06-12-2004 16:41 CEST
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary:                    spdif output fails with atiixp
Description:=20
When running ALSA 1.0.4rc2 included in 2.6.5 kernel, spdif output was
intermittant, almost complete static. Updating kernel alsa to latest cvs
caused spdif output to stop completely.=20

dmesg reports no errors. Everything appears configured, but there is zero
output on the spdif line - no light through wire.

>aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: IXP [ATI IXP], device 0: ATI IXP AC97 [ATI IXP AC97]
  Subdevices: 1/1
  Subdevice
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0000:
subdevice
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0000
card 0: IXP [ATI IXP], device 1: ATI IXP IEC958 [ATI IXP IEC958]
  Subdevices: 1/1
  Subdevice
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0000:
subdevice
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0000


>cat /proc/asound/devices
  1:       : sequencer
  0: [0- 0]: ctl
 17: [0- 1]: digital audio playback
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
 33:       : timer

>aplay -D hw:0,1 <whatever>.wav returns:
Playing WAVE 'audiodump.wav' : Signed 16 bit Little Endian, Rate 44100 Hz=
,
Stereo
Warning: rate is not accurate (requested =3D 44100Hz, got =3D 48000Hz) pl=
ease,
try the plug plugin (-Dplug:hw:0,1)

Analog output is working correctly.

More info and logs on request.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

----------------------------------------------------------------------
 tiwai - 04-27-2004 12:29 CEST=20
----------------------------------------------------------------------
did you set correct IEC958 status bits?
you need either to pass parameters of iec958 plugin or set
statically via iecset program.

also, show the contents of AC97 codec and register dump in
/proc/asound/card0/codec97#0/*.

----------------------------------------------------------------------
 pkashou - 04-27-2004 13:41 CEST=20
----------------------------------------------------------------------
I have not set the bits manually, but they are set.

>iecset -x
AES0=3D0x00,AES1=3D0x82,AES2=3D0x00,AES3=3D0x02

>iecset -Dhw:0
Mode: consumer
Data: audio
Rate: 48000 Hz
Copyright: protected
Emphasis: none
Category: PCM coder
Original: original
Clock: 1000 ppm

>cat /proc/asound/card0/codec97#0/*
0-0/0: Realtek ALC650 rev 3

Capabilities     :
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : Realtek 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=3D0 rev=3D1 LDAC SDAC CDAC DSA=3D0 SPDIF DRA VRA
Extended status  : LDAC SDAC CDAC SPDIF=3D3/4 SPDIF VRA
PCM front DAC    : 44100Hz
PCM Surr DAC     : 44100Hz
PCM LFE DAC      : 44100Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Category=3D0x2 Generation=3D1 Rate=3D48kH=
z
SPDIF In Status  : Not Locked
0:00 =3D 5980
0:02 =3D 0808
0:04 =3D 0000
0:06 =3D 0008
0:08 =3D 0000
0:0a =3D 8008
0:0c =3D 801f
0:0e =3D 801f
0:10 =3D 1f1f
0:12 =3D 9f1f
0:14 =3D 1f1f
0:16 =3D 8808
0:18 =3D 0808
0:1a =3D 0404
0:1c =3D 8b0b
0:1e =3D 0000
0:20 =3D 0000
0:22 =3D 0002
0:24 =3D 0000
0:26 =3D 800f
0:28 =3D 05c7
0:2a =3D 01c5
0:2c =3D ac44
0:2e =3D ac44
0:30 =3D ac44
0:32 =3D bb80
0:34 =3D 0000
0:36 =3D 0808
0:38 =3D 0808
0:3a =3D 2824
0:3c =3D 0000
0:3e =3D 0000
0:40 =3D 0000
0:42 =3D 0000
0:44 =3D 0000
0:46 =3D 0000
0:48 =3D 0000
0:4a =3D 0000
0:4c =3D 0000
0:4e =3D 0000
0:50 =3D 0000
0:52 =3D 0000
0:54 =3D 0000
0:56 =3D 0000
0:58 =3D 0000
0:5a =3D 0000
0:5c =3D 0000
0:5e =3D 0000
0:60 =3D 0000
0:62 =3D 8000
0:64 =3D 0808
0:66 =3D 0808
0:68 =3D 0000
0:6a =3D 1000
0:6c =3D 0000
0:6e =3D 0025
0:70 =3D 0231
0:72 =3D 00a0
0:74 =3D 0043
0:76 =3D 0001
0:78 =3D 8102
0:7a =3D 57c3
0:7c =3D 414c
0:7e =3D 4720

----------------------------------------------------------------------
 pkashou - 04-28-2004 02:32 CEST=20
----------------------------------------------------------------------
Uploaded my asound.state in case something strange was going on there.

----------------------------------------------------------------------
 tiwai - 04-30-2004 11:34 CEST=20
----------------------------------------------------------------------
the status seems ok.

could you try iec958 PCM name instead of hw:0,1?
or, try 'ac3dec -C something.ac3'.

----------------------------------------------------------------------
 pkashou - 05-01-2004 01:02 CEST=20
----------------------------------------------------------------------
Same result, no sound...no light at all with:

>ac3dec -C test.ac3
Using PCM device 'plug:iec958:{AES0 0x2 AES1 0x82 AES2 0x0 AES3 0x2}'
AC3 Stream 48.0 KHz 448 kbps

I did notice that 'AES0' does not have the same value in ac3dec as from
'iecset -x'
Could there be a connection?

And 'aplay -D iec958 test.wav' did not have light/sound either.

edited on: 05-01-04 01:00

edited on: 05-01-04 01:02

----------------------------------------------------------------------
 tiwai - 05-01-2004 10:33 CEST=20
----------------------------------------------------------------------
to be sure: did you update alsa-lib, too?

----------------------------------------------------------------------
 pkashou - 05-01-2004 21:17 CEST=20
----------------------------------------------------------------------
Well...I had a long, in-depth note about what I did and what happened and
the ALSA bug system decided to crash. So..here it is again.

Yes I did have alsa-lib CVS installed.

I just downgraded my kernel to 1.0.4 and alsa-lib to 1.0.4. After
rebuild/restart I now get light and static with "aplay -D hw:0,1
test.wav". ac3dec now actually puts light on the line, but it plays an
entire ac3 song in less than a second, so I can't tell what the ouput is
(probably not good sound). Here are the new regs and iecset stuff for
comparison.

>iecset -x
AES0=3D0x00,AES1=3D0x82,AES2=3D0x00,AES3=3D0x00

>iecset -Dhw:0
Mode: consumer
Data: audio
Rate: 44100 Hz
Copyright: protected
Emphasis: none
Category: PCM coder
Original: original
Clock: 1000 ppm

>cat /proc/asound/card0/codec97#0/*
0-0/0: Realtek ALC650 rev 3

Capabilities     :
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : Realtek 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=3D0 rev=3D1 LDAC SDAC CDAC DSA=3D0 SPDIF DRA VRA
Extended status  : LDAC SDAC CDAC SPDIF=3D3/4 SPDIF VRA
PCM front DAC    : 48000Hz
PCM Surr DAC     : 48000Hz
PCM LFE DAC      : 48000Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Category=3D0x2 Generation=3D1 Rate=3D44.1=
kHz
SPDIF In Status  : Not Locked
0:00 =3D 5980
0:02 =3D 0808
0:04 =3D 0000
0:06 =3D 0008
0:08 =3D 0000
0:0a =3D 800a
0:0c =3D 801f
0:0e =3D 801f
0:10 =3D 1f1f
0:12 =3D 9f1f
0:14 =3D 1f1f
0:16 =3D 8808
0:18 =3D 0808
0:1a =3D 0404
0:1c =3D 8b0b
0:1e =3D 0000
0:20 =3D 0000
0:22 =3D 0002
0:24 =3D 0000
0:26 =3D 000f
0:28 =3D 05c7
0:2a =3D 01c5
0:2c =3D bb80
0:2e =3D bb80
0:30 =3D bb80
0:32 =3D bb80
0:34 =3D 0000
0:36 =3D 0808
0:38 =3D 0808
0:3a =3D 0824
0:3c =3D 0000
0:3e =3D 0000
0:40 =3D 0000
0:42 =3D 0000
0:44 =3D 0000
0:46 =3D 0000
0:48 =3D 0000
0:4a =3D 0000
0:4c =3D 0000
0:4e =3D 0000
0:50 =3D 0000
0:52 =3D 0000
0:54 =3D 0000
0:56 =3D 0000
0:58 =3D 0000
0:5a =3D 0000
0:5c =3D 0000
0:5e =3D 0000
0:60 =3D 0000
0:62 =3D 8000
0:64 =3D 0808
0:66 =3D 0808
0:68 =3D 0000
0:6a =3D 0000
0:6c =3D 0000
0:6e =3D 0025
0:70 =3D 0231
0:72 =3D 00a0
0:74 =3D 0043
0:76 =3D 0001
0:78 =3D 8102
0:7a =3D 57c3
0:7c =3D 414c
0:7e =3D 4720

----------------------------------------------------------------------
 pkashou - 05-24-2004 15:02 CEST=20
----------------------------------------------------------------------
Any sort of status update available?=20

I saw that there was some experimental code added to CVS, but I have not
tested it. Are you waiting to do further testing?

Thanks.

----------------------------------------------------------------------
 pkashou - 06-12-2004 16:41 CEST=20
----------------------------------------------------------------------
Just tried out the latest CVS kernel and lib and still no sound or light =
on
iec958. Any ideas as to why only ALSA 1.0.4 works? If I change nothing
else on my system but the ALSA version, I get static with 1.0.4 and
1.0.4r2 and no output with later versions.

Bug History
Date Modified  Username       Field                    Change            =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
04-27-04 03:54 pkashou        New Bug                                    =
 =20
04-27-04 03:54 pkashou        Distribution              =3D> Gentoo      =
   =20
04-27-04 03:54 pkashou        Kernel Version            =3D> gentoo-dev-s=
ources
2.6.5 (running cvs alsa in kernel)
04-27-04 12:29 tiwai          Bugnote Added: 0000960                     =
 =20
04-27-04 13:41 pkashou        Bugnote Added: 0000961                     =
 =20
04-28-04 02:31 pkashou        File Added: asound.state                   =
 =20
04-28-04 02:32 pkashou        Bugnote Added: 0000968                     =
 =20
04-30-04 11:34 tiwai          Bugnote Added: 0000979                     =
 =20
05-01-04 00:56 pkashou        Bugnote Added: 0000985                     =
 =20
05-01-04 00:56 pkashou        Bugnote Edited: 0000985                    =
 =20
05-01-04 01:00 pkashou        Bugnote Edited: 0000985                    =
 =20
05-01-04 01:02 pkashou        Bugnote Edited: 0000985                    =
 =20
05-01-04 10:33 tiwai          Bugnote Added: 0000993                     =
 =20
05-01-04 21:17 pkashou        Bugnote Added: 0001001                     =
 =20
05-24-04 15:02 pkashou        Bugnote Added: 0001185                     =
 =20
06-12-04 16:41 pkashou        Bugnote Added: 0001301                     =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
