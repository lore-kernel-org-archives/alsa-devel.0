From: noreply@alsa-project.org
Subject: [ALSA - driver 0000354]: Line-In Dead - Setting "Default PhoneJacks" in Linux
Date: Thu, 1 Jul 2004 09:40:46 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <6e07281b3f1fe70a4757d28649ef4393@bugtrack.alsa-project.org>
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug=
_id=3D0000354
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Reported By:                Quantum
Assigned To:               =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Project:                    ALSA - driver
Bug ID:                     354
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             Gentoo-2.6.5-r1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Date Submitted:             06-30-2004 20:35 CEST
Last Modified:              07-01-2004 09:40 CEST
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary:                    Line-In Dead - Setting "Default PhoneJacks" i=
n Linux
Description:=20
Another full day of research.=20
=20
 It's clear now that my mobo (MSI6712 KT4V Via8235) has several audio
modes. If the optional S-panel is added, front speakers are the normal
Line-Out and the others are on the S-panel. I do not have the S-panel
though, and only need 2 channels and LineIn. LineIn is silent; really nee=
d
this for recording.=20
=20
 There's a mode MSI calls "Default Phonejack". If enabled, the built-in
jacks Mic/LineIn/LineOut are what you'd expect. If disabled though,
LineOut is normal, LineIn is RearOut (4-channel) and Mic is sub/center
(6-channel).=20
=20
 Since my Mic and LineOut work but LineIn does not, it appears the mobo
defaults to 4 channel, NON-Default Phonejack. So I must set that Default
Phonejack bit in order to get LineIn; I'm sure it's a register setting in
the mobo.=20
=20
 All that appears to do that is a Winduhs utility, only for Winduhs.=20
=20
 Tried all Alsa dxs_support options (only clean up the intermod
distortion?) and ac97_quirk options (incl. 4) to no avail.. Sound out is
fine; But I need to feed in sound through LineIn.=20
=20
 Can you advise?=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

----------------------------------------------------------------------
 Quantum - 06-30-2004 21:13 CEST=20
----------------------------------------------------------------------
More: in alsamixer, Line is the only capture device.  I can control volum=
e
of Surround, Center, and Line, but not Line In.  Nothing is muted.

So it seems clear that I am in 4-speaker mode ("Default Phonejack").

----------------------------------------------------------------------
 Quantum - 06-30-2004 21:31 CEST=20
----------------------------------------------------------------------
# cat /proc/asound/card0/codec97#0/ac97#0-0
0-0/0: Realtek ALC650 rev 2

Capabilities     :
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : Realtek 3D Stereo Enhancement

Current setup
Mic gain         : +20dB [+20dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : on
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=3D0 rev=3D1 LDAC SDAC CDAC DSA=3D0 SPDIF DRA VRA
Extended status  : SPCV LDAC SDAC CDAC SPDIF=3D3/4 SPDIF VRA
PCM front DAC    : 44100Hz
PCM Surr DAC     : 44100Hz
PCM LFE DAC      : 44100Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Category=3D0x2 Generation=3D1 Rate=3D44.1=
kHz
SPDIF In Status  : Not Locked
#

# cat /proc/asound/card0/codec97#0/ac97#0-0+regs
0:00 =3D 5980
0:02 =3D 0505
0:04 =3D 0000
0:06 =3D 0005
0:08 =3D 0000
0:0a =3D 0004
0:0c =3D 0006
0:0e =3D 0045
0:10 =3D 0506
0:12 =3D 0505
0:14 =3D 0505
0:16 =3D 0505
0:18 =3D 0606
0:1a =3D 0404
0:1c =3D 8000
0:1e =3D 0000
0:20 =3D 2000
0:22 =3D 0000
0:24 =3D 0000
0:26 =3D 800f
0:28 =3D 05c7
0:2a =3D 05c5
0:2c =3D ac44
0:2e =3D ac44
0:30 =3D ac44
0:32 =3D bb80
0:34 =3D 0000
0:36 =3D 0605
0:38 =3D 0505
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
0:62 =3D 0000
0:64 =3D 0808
0:66 =3D 0808
0:68 =3D 0000
0:6a =3D 520f
0:6c =3D 0000
0:6e =3D 0014
0:70 =3D 0211
0:72 =3D 00a0
0:74 =3D 0043
0:76 =3D 0001
0:78 =3D 8102
0:7a =3D 57c7
0:7c =3D 414c
0:7e =3D 4720
#

----------------------------------------------------------------------
 pzad - 07-01-2004 09:40 CEST=20
----------------------------------------------------------------------
mute this "Duplicate Front"
mute this "Line-In As Surround"

Bug History
Date Modified  Username       Field                    Change            =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
06-30-04 20:35 Quantum        New Bug                                    =
 =20
06-30-04 20:35 Quantum        Distribution              =3D> Gentoo      =
   =20
06-30-04 20:35 Quantum        Kernel Version            =3D> Gentoo-2.6.5=
-r1=20
06-30-04 21:13 Quantum        Bugnote Added: 0001365                     =
 =20
06-30-04 21:27 Quantum        File Added: asound.state                   =
 =20
06-30-04 21:31 Quantum        Bugnote Added: 0001366                     =
 =20
07-01-04 09:40 pzad           Bugnote Added: 0001369                     =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
