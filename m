From: noreply@alsa-project.org
Subject: [ALSA - driver 0000155]: Crackly / sizzly recording on VIA VT82C686 AC97 since 2.6.3
Date: Sun, 20 Jun 2004 11:41:34 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <662fb21fe6f42d25a0950c00d6f3ba8e@bugtrack.alsa-project.org>
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
0155
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Reported By:                sim
Assigned To:                tiwai
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Project:                    ALSA - driver
Bug ID:                     155
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian unstable
Kernel Version:             2.6.3 through 2.6.5-rc2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Date Submitted:             03-24-2004 06:03 CET
Last Modified:              06-20-2004 11:41 CEST
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary:                    Crackly / sizzly recording on VIA VT82C686 AC=
97
since 2.6.3
Description:=20
Hello,

I have a mythtv box set up and recently upgraded the kernel from
2.6.0-test9 to 2.6.4.  Everything appeared to play normally, but new
recordings since the upgrade all sound crackly.  2.6.5-rc2 and 2.6.3 also
seem to be broken.  2.6.2 works as expected.

There appear to be a large number of changes to the ALSA core between
2.6.2 and 2.6.3.  How should I attempt to track the problem down further?

Athlon 1800 XP, MSI K7 Master (MS-6330), 48 KHz stereo recording and
playback.  The problem also shows up with Audacity, and as such does not
appear to be application specific.  I can send a sample of the poor sound
recording upon request.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

----------------------------------------------------------------------
 m9715936 - 04-10-2004 10:13 CEST=20
----------------------------------------------------------------------
I upgraded from kernel 2.6.2 to 2.6.5 and I'm having the same problem.
Whenever I record something, with sox or mencoder for example, the result
sounds crackly, like listening to an fm-station not tuned in correctly.

a sample can be found at :

http://chef.studentenweb.org/public/radio2004_04_07-18_15_22.mp3

(and I tested al kinds of different mixer settings)

MSI K7T Turbo MB, VIA VT82C686B Chipset, using Mandrake 9.2 (+ cooker)

hope this can be fixed soon,

Dominique De Munck

edited on: 04-10-04 10:13

----------------------------------------------------------------------
 uli - 04-11-2004 19:28 CEST=20
----------------------------------------------------------------------
Hello,

the same problem appears to me. Related to kernel 2.4.22 in alsa drivers
0.9.8 everthing works fine while in 1.0.0pre3 recordings create crack
noises.

Records are made with both broadcast2000 and audacity.

Mainboard MSI K7T Pro (MS-6330) with onboard VT82C686 AC97 Audio
Controller.


Regards,
Uli Flender

----------------------------------------------------------------------
 tiwai - 04-23-2004 17:30 CEST=20
----------------------------------------------------------------------
please check /proc/asound/card0/pcm0c/sub0/hw_params
and /proc/asound/card0/codec97#0/ac97#0-0 during the recording.

----------------------------------------------------------------------
 m9715936 - 04-23-2004 18:02 CEST=20
----------------------------------------------------------------------
the requested information:=20

cat /proc/asound/card0/pcm0c/sub0/hw_params
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 32000 (32000/1)
period_size: 2048
buffer_size: 16384
tick_time: 1000
OSS format: S16_LE
OSS channels: 2
OSS rate: 32000
OSS period bytes: 8192
OSS periods: 8
OSS period frames: 2048

cat=20
/proc/asound/card0/codec97\https://bugtrack.alsa-project.org/alsa-bug/bug=
_view_page.php?bug_id=3D0000000/ac97\https://bugtrack.alsa-project.org/al=
sa-bug/bug_view_page.php?bug_id=3D0000000-0


0-0/0: ICEnsemble ICE1232

Capabilities     : -headphone out-
DAC resolution   : 18-bit
ADC resolution   : 18-bit
3D enhancement   : IC Ensemble/KS Waves

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=3D0 rev=3D0 AMAP DSA=3D0 VRA
Extended status  : VRA
PCM front DAC    : 44100Hz
PCM ADC          : 32000Hz


as an extra, some more information with a 2.6.2 kernel
http://chef.studentenweb.org/public/viaRecordingBug/viaRecordingOutput262=
.txt

----------------------------------------------------------------------
 tiwai - 04-23-2004 18:07 CEST=20
----------------------------------------------------------------------
thanks, the hardware configuration seems ok.  both the ADC rate and
hw_params values match.

does the noise appear also when you run record via arecord (i.e.
ALSA native app)?

----------------------------------------------------------------------
 m9715936 - 04-23-2004 18:36 CEST=20
----------------------------------------------------------------------
no, than the recording is ok !

Dominique

----------------------------------------------------------------------
 tiwai - 04-23-2004 18:40 CEST=20
----------------------------------------------------------------------
then it's likely a bug of OSS emulation.
please make sure that the same condition (32kHz) works with arecord.
check /proc/asound...hw_params again.

----------------------------------------------------------------------
 m9715936 - 04-23-2004 18:59 CEST=20
----------------------------------------------------------------------
yes, 32 khz no problem with arecord. The noise also appears at 48khz
with oss, I checked that before.
while "arecord -f S16_LE -c2 -r 32000 > alsa32khz.wav"

cat /proc/asound/card0/pcm0c/sub0/hw_params=20
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 32000 (32000/1)
period_size: 4000
buffer_size: 16000
tick_time: 1000

----------------------------------------------------------------------
 sim - 06-13-2004 11:32 CEST=20
----------------------------------------------------------------------
I have uploaded "patch-2.6.3-rc1-try2.11.works" which are two hunks of
patch-2.6.3-rc1 which cause the problem to occur.  Reverse-applying this
patch to 2.6.3-rc1 (or 2.6.7-rc3, for that matter) cures the crackly soun=
d
problem.

The actual change appears to be nonsensical, at least from what I can mak=
e
from it.  Was there an intent to make "avail_min" be a number of periods
in period_size but only partially modified?

Anyway, the bug should be relatively easy to fix at this point.

----------------------------------------------------------------------
 uli - 06-20-2004 11:41 CEST=20
----------------------------------------------------------------------
Hello,

reverse-applying of patch-2.6.3-rc1-try2.11.works, as in my case in kerne=
l
2.6.7, indeed cures the problem.

Thanks + regards
Uli

Bug History
Date Modified  Username       Field                    Change            =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
03-24-04 06:03 sim            New Bug                                    =
 =20
03-24-04 06:03 sim            Distribution              =3D> Debian unsta=
ble=20
03-24-04 06:03 sim            Kernel Version            =3D> 2.6.3 throug=
h
2.6.5-rc2
04-08-04 15:15 m9715936       Bug Monitored: m9715936                    =
 =20
04-08-04 15:25 m9715936       Bugnote Added: 0000767                     =
 =20
04-08-04 15:29 m9715936       Bugnote Edited: 0000767                    =
 =20
04-10-04 10:13 m9715936       Bugnote Edited: 0000767                    =
 =20
04-11-04 19:28 uli            Bugnote Added: 0000780                     =
 =20
04-23-04 17:29 tiwai          Assigned To               =3D> tiwai       =
   =20
04-23-04 17:29 tiwai          Status                   new =3D> assigned =
   =20
04-23-04 17:30 tiwai          Bugnote Added: 0000907                     =
 =20
04-23-04 18:02 m9715936       Bugnote Added: 0000913                     =
 =20
04-23-04 18:07 tiwai          Bugnote Added: 0000914                     =
 =20
04-23-04 18:36 m9715936       Bugnote Added: 0000915                     =
 =20
04-23-04 18:40 tiwai          Bugnote Added: 0000916                     =
 =20
04-23-04 18:59 m9715936       Bugnote Added: 0000917                     =
 =20
06-13-04 11:27 sim            File Added: patch-2.6.3-rc1-try2.11.works  =
      =20
         =20
06-13-04 11:32 sim            Bugnote Added: 0001303                     =
 =20
06-20-04 11:41 uli            Bugnote Added: 0001324                     =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
