From: Manolo =?UTF-8?B?RMOtYXo=?= <diaz.manolo@gmail.com>
Subject: Re: HD-audio regression after commit
 34588709af61be1550b4e2bcee5c85d0ac4f34d4
Date: Wed, 16 Jan 2013 14:55:09 +0100
Message-ID: <20130116145509.434c0bb9@gmail.com>
References: <CA+S_cwraM+wofw5Nz_d0ctOget5dY-0nr5pRHCzOJtLX+JM2TA@mail.gmail.com>
 <CAN8ccia1N-eseNR2dET=ghXuyK0E0gXaakehW3VAN8u1UxUQ8Q@mail.gmail.com>
 <20130114133122.52cadb99@gmail.com> <s5h7gngc4lt.wl%tiwai@suse.de>
 <20130114135947.1f0bbbf4@gmail.com> <s5h1udndihf.wl%tiwai@suse.de>
 <20130114172354.1f47f49b@gmail.com>
 <CAN8cciaoAt75sRUtLM6Ov4VGBQ1pFgPwO-EZT88q6d1gm-JggQ@mail.gmail.com>
 <20130115095325.7aa2dfdd@gmail.com>
 <CAN8cciYrMSBhpp-9QjHdE8aVMHh_JwHswwfPfjtGY6OB_E4NcQ@mail.gmail.com>
 <20130116094941.0e1170b2@gmail.com> <s5hwqvd33va.wl%tiwai@suse.de>
 <20130116133952.18449985@gmail.com> <s5hbocpp9tn.wl%tiwai@suse.de>
 <20130116140412.01c73523@gmail.com> <s5h8v7tp8s8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/D3P...mFXLW7fkqwrsz17Sy"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
 by alsa0.perex.cz (Postfix) with ESMTP id C192B2615C0
 for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2013 14:55:15 +0100 (CET)
Received: by mail-wg0-f41.google.com with SMTP id ds1so2691013wgb.4
 for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2013 05:55:14 -0800 (PST)
In-Reply-To: <s5h8v7tp8s8.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, alsa-devel@alsa-project.org, basinilya@gmail.com, Miro Hodak <mhodak127@gmail.com>
List-Id: alsa-devel@alsa-project.org

--MP_/D3P...mFXLW7fkqwrsz17Sy
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

El mi=C3=A9, 16 ene 2013 a las 14:16 horas
Takashi Iwai escribi=C3=B3:

>At Wed, 16 Jan 2013 14:04:12 +0100,
>Manolo D=C3=ADaz wrote:
>>=20
>> El mi=C3=A9, 16 ene 2013 a las 13:54 horas
>> Takashi Iwai escribi=C3=B3:
>>=20
>> >At Wed, 16 Jan 2013 13:39:52 +0100,
>> >Manolo D=C3=ADaz wrote:
>> >>=20
>> >> El mi=C3=A9, 16 ene 2013 a las 9:54 horas
>> >> Takashi Iwai escribi=C3=B3:
>> >>=20
>> >> >At Wed, 16 Jan 2013 09:49:41 +0100,
>> >> >Manolo D=C3=ADaz wrote:
>> >> >>=20
>> >> >> El mi=C3=A9, 16 ene 2013 a las 9:52 horas
>> >> >> Raymond Yau escribi=C3=B3:
>> >> >>=20
>> >> >> >>
>> >> >> >> >>
>> >> >> >> >> >Yes, testing the latest code with real machines is highly
>> >> >> >> >> >appreciated.  Try sound-unstable git tree, either master or
>> >> >> >> >> >test/hda-migrate branch.
>> >> >> >> >> >  git://
>> >> >> >git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-unstable.git
>> >> >> >> >> >
>> >> >> >> >> >Alternatively you can build the external alsa-driver module=
s from
>> >> >> >> >> >alsa-driver-unstable snapshot tarball, too
>> >> >> >> >> >
>> >> >> >> >
>> >> >> >ftp://ftp.suse.com/pub/people/tiwai/snapshot/alsa-driver-unstable=
-snapshot.tar.gz
>> >> >> >> >> >
>> >> >> >> >> >Note that only the behavior of model=3Dauto has been change=
d in the tree
>> >> >> >> >> >above.  The other model behaviors of AD codecs are unchange=
d at all.
>> >> >> >> >>
>> >> >> >> >> Mixer crashes are gone. As I wrote I have no way to test the=
 digital
>> >> >> >> >> output.
>> >> >> >> >>
>> >> >> >> >> I haven't found a way to test multi stream playback either. =
After
>> >> >> >> >> choosing HP Independant enabled I can't hear nothing through=
 the
>> >> >> >> >> headphone.
>> >> >> >> >>
>> >> >> >
>> >> >> >Did audio work with suspend and resume since my p5b-v ad1988 cann=
ot suspend
>> >> >> >/ resume anymore after install Ubuntu 12.04 ?
>> >> >> >
>> >> >> >Audio can suspend / resume in fedora 10 for different version of =
alsa
>> >> >> >driver
>> >> >> >
>> >> >> >Seen many ad1988 controls are missing ?
>> >> >> >
>> >> >> >1) rear Mic, line , front Mic  playback volume and switch
>> >> >> >2) CD playback switch
>> >> >> >3) input mix in input source
>> >> >> >4) analog loopback mix volume and mute switch
>> >> >>=20
>> >> >> I can confirm both: no sound after resume and missing controls.
>> >> >> Attached are captures from the mixer control list using linux stab=
le
>> >> >> and sound unstable, both with BIOS autoprobe.
>> >> >
>> >> >Give alsa-info.sh outputs before and after suspend, instead.
>> >> >
>> >> >
>> >> >Takashi
>> >>=20
>> >> Ok.
>> >>=20
>> >> Outputs attached. This is the diff:
>> >>=20
>> >> --- alsa-info-before-suspend.txt	2013-01-16 13:29:59.991633927 +0100
>> >> +++ alsa-info-after-resume.txt	2013-01-16 13:31:06.353096949 +0100
>> >> @@ -3,7 +3,7 @@
>> >>  !!ALSA Information Script v 0.4.61
>> >>  !!################################
>> >> =20
>> >> -!!Script ran on: Wed Jan 16 12:29:57 UTC 2013
>> >> +!!Script ran on: Wed Jan 16 12:31:03 UTC 2013
>> >> =20
>> >> =20
>> >>  !!Linux Distribution
>> >> @@ -127,7 +127,7 @@
>> >>      ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
>> >>    Device: name=3D"AD1989B Analog", type=3D"Audio", device=3D2
>> >>    Amp-Out caps: ofs=3D0x27, nsteps=3D0x27, stepsize=3D0x05, mute=3D0
>> >> -  Amp-Out vals:  [0x23 0x23]
>> >> +  Amp-Out vals:  [0x27 0x27]
>> >>    Converter: stream=3D8, channel=3D0
>> >>    Power states:  D0 D3
>> >>    Power: setting=3DD0, actual=3DD0
>> >> @@ -136,7 +136,7 @@
>> >>      ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
>> >>    Device: name=3D"AD1989B Analog", type=3D"Audio", device=3D0
>> >>    Amp-Out caps: ofs=3D0x27, nsteps=3D0x27, stepsize=3D0x05, mute=3D0
>> >> -  Amp-Out vals:  [0x1e 0x1e]
>> >> +  Amp-Out vals:  [0x27 0x27]
>> >
>> >Hm, are you running the latest sound-unstable tree?
>> >
>> >There have been a few critical bugs fixed since the last time you
>> >wrote.  This might be the issue you hit.
>> >
>> >
>> >Takashi
>>=20
>>=20
>> #git show=20
>> commit 9d7b2668e0d3ddf69a3872d2f3622b2af262ed8e
>> Merge: bcf4f30 fb85635
>> Author: Takashi Iwai <tiwai@suse.de>
>> Date:   Mon Jan 14 10:15:24 2013 +0100
>>=20
>>     Merge remote-tracking branch 'stable/master'
>
>The latest master HEAD is
>
>commit 3c8a646ae30522bd041596282ab5e9e5bc7e1c6d
>Merge: 261ecc2 c0f3b21
>Author: Takashi Iwai <tiwai@suse.de>
>Date:   Wed Jan 16 11:57:22 2013 +0100
>
>    Merge branch 'test/hda-gen-parser'
>
>
>Takashi

Sorry. I'll repeat those tests.

commit 3c8a646ae30522bd041596282ab5e9e5bc7e1c6d
Merge: 261ecc2 c0f3b21
Author: Takashi Iwai <tiwai@suse.de>
Date:   Wed Jan 16 11:57:22 2013 +0100

    Merge branch 'test/hda-gen-parser'


You're right. Things seem so much better now:

-Multi stream play does work (tested front speakers and headphone)
-Sound doesn't disappear after resume

--- alsa-info-before-suspend.txt	2013-01-16 14:38:53.398515024 +0100
+++ alsa-info-after-resume.txt	2013-01-16 14:39:48.424133569 +0100
@@ -3,7 +3,7 @@
 !!ALSA Information Script v 0.4.61
 !!################################
=20
-!!Script ran on: Wed Jan 16 13:38:52 UTC 2013
+!!Script ran on: Wed Jan 16 13:39:47 UTC 2013
=20
=20
 !!Linux Distribution
@@ -1138,7 +1138,7 @@
 	control.31 {
 		iface CARD
 		name 'Line Out Front Jack'
-		value true
+		value false
 		comment {
 			access read
 			type BOOLEAN
@@ -1453,5 +1453,9 @@
 [    2.361493]   #0: HDA ATI SB at 0xfe8f4000 irq 16
 [    2.363720]   #1: HDA ATI HDMI at 0xfe9ec000 irq 42
 [    2.366474] EXT4-fs (sda1): couldn't mount as ext3 due to feature incom=
patibilities
+--
+[  200.736358] serial 00:08: activated
+[  200.736528] snd_hda_intel 0000:01:00.1: irq 42 for MSI/MSI-X
+[  200.736593] pcieport 0000:00:06.0: System wakeup disabled by ACPI


But the number of controls is smaller than in linux stable 3.7.2. I
don't know if that's a regression.


--=20
Manolo D=C3=ADaz

--MP_/D3P...mFXLW7fkqwrsz17Sy
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=alsa-info-after-resume.txt

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.61
!!################################

!!Script ran on: Wed Jan 16 13:39:47 UTC 2013


!!Linux Distribution
!!------------------

[0;32mDebian testing (Wheezy) [0;31m\n. [1;33m\l[0;32m PRETTY_NAME="Debian GNU/Linux 7.0 (wheezy)" NAME="Debian GNU/Linux" ID=debian HOME_URL="http://www.debian.org/" SUPPORT_URL="http://www.debian.org/support/" BUG_REPORT_URL="http://bugs.debian.org/"


!!DMI Information
!!---------------

Manufacturer:      System manufacturer
Product Name:      System Product Name
Product Version:   System Version
Firmware Version:  1801   


!!Kernel Information
!!------------------

Kernel release:    3.8.0-rc3+
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         unknown
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     k3.8.0-rc3+
Library version:    1.0.25
Utilities version:  1.0.25


!!Loaded ALSA modules
!!-------------------



!!Sound Servers on this system
!!----------------------------

Jack:
      Installed - Yes (/usr/bin/jackd)
      Running - No


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [SB             ]: HDA-Intel - HDA ATI SB
                      HDA ATI SB at 0xfe8f4000 irq 16
 1 [HDMI           ]: HDA-Intel - HDA ATI HDMI
                      HDA ATI HDMI at 0xfe9ec000 irq 42


!!PCI Soundcards installed in the system
!!--------------------------------------

00:14.2 Audio device: Advanced Micro Devices [AMD] nee ATI SBx00 Azalia (Intel HDA)
01:00.1 Audio device: Advanced Micro Devices [AMD] nee ATI RV610 HDMI Audio [Radeon HD 2350/2400 Series]


!!Advanced information - PCI Vendor/Device/Subsystem ID's
!!-------------------------------------------------------

00:14.2 0403: 1002:4383
	Subsystem: 1043:8288
--
01:00.1 0403: 1002:aa10
	Subsystem: 1043:aa10


!!Loaded sound module options
!!---------------------------


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Analog Devices AD1989B
Address: 0
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x11d4989b
Subsystem Id: 0x10438311
Revision Id: 0x100300
No Modem Function Group found
Default PCM:
    rates [0x7ff]: 8000 11025 16000 22050 32000 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Default Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
State of AFG node 0x01:
  Power states:  D0 D3
  Power: setting=D0, actual=D0
GPIO: io=3, o=0, i=0, unsolicited=1, wake=0
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=1, unsol=0
  IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Node 0x02 [Audio Output] wcaps 0x30211: Stereo Digital
  Control: name="IEC958 Playback Con Mask", index=0, device=0
  Control: name="IEC958 Playback Pro Mask", index=0, device=0
  Control: name="IEC958 Playback Default", index=0, device=0
  Control: name="IEC958 Playback Switch", index=0, device=0
  Control: name="IEC958 Default PCM Playback Switch", index=0, device=0
  Device: name="AD1989B Digital", type="SPDIF", device=1
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Delay: 3 samples
Node 0x03 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Control: name="Headphone Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Device: name="AD1989B Analog", type="Audio", device=2
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
  Amp-Out vals:  [0x23 0x23]
  Converter: stream=8, channel=0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
Node 0x04 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Control: name="Front Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Device: name="AD1989B Analog", type="Audio", device=0
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
  Amp-Out vals:  [0x1e 0x1e]
  Converter: stream=8, channel=0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
Node 0x05 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Control: name="Center Playback Volume", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Control: name="LFE Playback Volume", index=0, device=0
    ControlAmp: chs=2, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
  Amp-Out vals:  [0x23 0x23]
  Converter: stream=8, channel=0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
Node 0x06 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Control: name="Surround Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
  Amp-Out vals:  [0x23 0x23]
  Converter: stream=8, channel=0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
Node 0x07 [Audio Input] wcaps 0x130391: Stereo Digital
  Converter: stream=0, channel=0
  SDI-Select: 0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Unsolicited: tag=00, enabled=0
  Delay: 3 samples
  Connection: 1
     0x1c
Node 0x08 [Audio Input] wcaps 0x100501: Stereo
  Device: name="AD1989B Analog", type="Audio", device=0
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
  Connection: 1
     0x0c
Node 0x09 [Audio Input] wcaps 0x100501: Stereo
  Device: name="AD1989B Analog", type="Audio", device=2
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
  Connection: 1
     0x0d
Node 0x0a [Audio Output] wcaps 0x405: Stereo Amp-Out
  Control: name="Side Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
  Amp-Out vals:  [0x23 0x23]
  Converter: stream=8, channel=0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
Node 0x0b [Audio Output] wcaps 0x30211: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Delay: 3 samples
Node 0x0c [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Control: name="Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Capture Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x27, nsteps=0x36, stepsize=0x05, mute=1
  Amp-Out vals:  [0xa7 0xa7]
  Connection: 11
     0x38 0x39* 0x3a 0x3b 0x3c 0x18 0x24 0x25 0x3d 0x20 0x1f
Node 0x0d [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Control: name="Capture Volume", index=1, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Capture Switch", index=1, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x27, nsteps=0x36, stepsize=0x05, mute=1
  Amp-Out vals:  [0xa7 0xa7]
  Connection: 10
     0x38 0x39* 0x3a 0x3b 0x3c 0x18 0x24 0x25 0x3d 0x20
Node 0x0e [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Control: name="Capture Volume", index=2, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Capture Switch", index=2, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x27, nsteps=0x36, stepsize=0x05, mute=1
  Amp-Out vals:  [0xa7 0xa7]
  Connection: 10
     0x38 0x39* 0x3a 0x3b 0x3c 0x18 0x24 0x25 0x3d 0x20
Node 0x0f [Audio Input] wcaps 0x100501: Stereo
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
  Connection: 1
     0x0e
Node 0x10 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x0f, nsteps=0x0f, stepsize=0x0b, mute=1
  Amp-Out vals:  [0x8f]
Node 0x11 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Front Headphone Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000373f: IN OUT HP Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x02214030: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
    DefAssociation = 0x3, Sequence = 0x0
  Pin-ctls: 0xc0: OUT HP VREF_HIZ
  Unsolicited: tag=01, enabled=1
  Connection: 1
     0x22
Node 0x12 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Control: name="Front Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Line Out Front Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000373f: IN OUT HP Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x01014010: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT VREF_HIZ
  Unsolicited: tag=02, enabled=1
  Connection: 1
     0x29
Node 0x13 [Pin Complex] wcaps 0x40010c: Mono Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x9f]
  Pincap 0x00000010: OUT
  Pin Default 0x511711f0: [N/A] Speaker at Int Rear
    Conn = Analog, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x2d
Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Control: name="Front Mic Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000373f: IN OUT HP Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x02a1902e: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Pink
    DefAssociation = 0x2, Sequence = 0xe
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=06, enabled=1
  Connection: 1
     0x2b
Node 0x15 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Control: name="Line Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00003737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x01813021: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Blue
    DefAssociation = 0x2, Sequence = 0x1
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=08, enabled=1
  Connection: 1
     0x2c
Node 0x16 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Control: name="Surround Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Line Out Surround Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00000037: IN OUT Detect Trigger ImpSense
  Pin Default 0x01011012: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0x1, Sequence = 0x2
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=03, enabled=1
  Connection: 1
     0x2a
Node 0x17 [Pin Complex] wcaps 0x40098d: Stereo Amp-Out R/L
  Control: name="Rear Mic Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00003737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x01a19020: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Pink
    DefAssociation = 0x2, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=07, enabled=1
  Connection: 1
     0x26
Node 0x18 [Pin Complex] wcaps 0x400081: Stereo
  Control: name="CD Phantom Jack", index=0, device=0
  Pincap 0x00000024: IN Detect
  Pin Default 0x99331122: [Fixed] CD at Int ATAPI
    Conn = ATAPI, Color = Black
    DefAssociation = 0x2, Sequence = 0x2
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
  Unsolicited: tag=00, enabled=0
Node 0x19 [Power Widget] wcaps 0x500500: Mono
  Power states:  D0 D3
  Power: setting=D0, actual=D0
  Connection: 2
     0x20 0x21
Node 0x1a [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x00000020: IN
  Pin Default 0x911711f0: [Fixed] Speaker at Int Rear
    Conn = Analog, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x1b [Pin Complex] wcaps 0x40030d: Stereo Digital Amp-Out
  Control: name="SPDIF Phantom Jack", index=0, device=0
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=1
  Amp-Out vals:  [0x27 0x27]
  Pincap 0x00000010: OUT
  Pin Default 0x0145f1a0: [Jack] SPDIF Out at Ext Rear
    Conn = Optical, Color = Other
    DefAssociation = 0xa, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x02
Node 0x1c [Pin Complex] wcaps 0x40020b: Stereo Digital Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x97 0x97]
  Pincap 0x00000020: IN
  Pin Default 0x41c5f160: [N/A] SPDIF In at Ext Rear
    Conn = Optical, Color = Other
    DefAssociation = 0x6, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x1d [Pin Complex] wcaps 0x40030d: Stereo Digital Amp-Out
  Control: name="HDMI Phantom Jack", index=1, device=0
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=1
  Amp-Out vals:  [0x27 0x27]
  Pincap 0x00000010: OUT
  Pin Default 0x1856f1b0: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Other
    DefAssociation = 0xb, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0b
Node 0x1e [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Connection: 2
     0x36 0x21
Node 0x1f [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x20 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97]
  Connection: 8
     0x39 0x33 0x38 0x3d 0x34 0x3b 0x18 0x1a
Node 0x21 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x9f 0x9f]
  Connection: 1
     0x20
Node 0x22 [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Connection: 2
     0x37 0x21
Node 0x23 [Vendor Defined Widget] wcaps 0xf00100: Mono
  Connection: 18
     0x11* 0x12 0x13 0x14 0x15 0x16 0x17 0x18 0x24 0x25 0x38 0x39 0x3a 0x3b 0x3c 0x3d 0x20 0x21
Node 0x24 [Pin Complex] wcaps 0x40098d: Stereo Amp-Out R/L
  Control: name="Center Playback Switch", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Control: name="LFE Playback Switch", index=0, device=0
    ControlAmp: chs=2, dir=Out, idx=0, ofs=0
  Control: name="Line Out CLFE Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00000037: IN OUT Detect Trigger ImpSense
  Pin Default 0x01016011: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Orange
    DefAssociation = 0x1, Sequence = 0x1
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=04, enabled=1
  Connection: 1
     0x27
Node 0x25 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Control: name="Side Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Line Out Side Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00000037: IN OUT Detect Trigger ImpSense
  Pin Default 0x01012014: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Grey
    DefAssociation = 0x1, Sequence = 0x4
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=05, enabled=1
  Connection: 1
     0x28
Node 0x26 [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Connection: 2
     0x32 0x21
Node 0x27 [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Connection: 2
     0x05 0x21
Node 0x28 [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Connection: 2
     0x0a 0x21
Node 0x29 [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Connection: 2
     0x04 0x21
Node 0x2a [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Connection: 2
     0x06 0x21
Node 0x2b [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Connection: 2
     0x30 0x21
Node 0x2c [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Connection: 2
     0x31 0x21
Node 0x2d [Audio Mixer] wcaps 0x200100: Mono
  Connection: 1
     0x1e
Node 0x2e [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x2f [Vendor Defined Widget] wcaps 0xf00100: Mono
  Connection: 6
     0x11* 0x12 0x14 0x15 0x16 0x17
Node 0x30 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 3
     0x03* 0x04 0x06
Node 0x31 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x04* 0x0a
Node 0x32 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x05* 0x04
Node 0x33 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 3
     0x3a* 0x25 0x24
Node 0x34 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 3
     0x3c* 0x25 0x24
Node 0x35 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x36 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 3
     0x03* 0x04 0x06
Node 0x37 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 3
     0x03* 0x04 0x06
Node 0x38 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 1
     0x11
Node 0x39 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 1
     0x14
Node 0x3a [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 1
     0x15
Node 0x3b [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x3c [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 1
     0x17
Node 0x3d [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 1
     0x12
Codec: ATI R6xx HDMI
Address: 0
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x1002aa01
Subsystem Id: 0x00aa0100
Revision Id: 0x100000
No Modem Function Group found
Default PCM:
    rates [0x40]: 48000
    bits [0x2]: 16
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
  Power states:  D0 D3
  Power: setting=D0, actual=D0
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x02 [Audio Output] wcaps 0x201: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
Node 0x03 [Pin Complex] wcaps 0x400381: Stereo Digital
  Control: name="HDMI/DP,pcm=3 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=0, device=0
  Control: name="IEC958 Playback Pro Mask", index=0, device=0
  Control: name="IEC958 Playback Default", index=0, device=0
  Control: name="IEC958 Playback Switch", index=0, device=0
  Control: name="ELD", index=0, device=3
  Pincap 0x00000094: OUT Detect HDMI
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=01, enabled=1
  Connection: 1
     0x02
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw---T 1 root audio 116,  7 Jan 16 14:36 /dev/snd/controlC0
crw-rw---T 1 root audio 116,  9 Jan 16 14:36 /dev/snd/controlC1
crw-rw---T 1 root audio 116,  6 Jan 16 14:36 /dev/snd/pcmC0D0c
crw-rw---T 1 root audio 116,  5 Jan 16 14:38 /dev/snd/pcmC0D0p
crw-rw---T 1 root audio 116,  4 Jan 16 14:36 /dev/snd/pcmC0D1p
crw-rw---T 1 root audio 116,  3 Jan 16 14:36 /dev/snd/pcmC0D2c
crw-rw---T 1 root audio 116,  2 Jan 16 14:36 /dev/snd/pcmC0D2p
crw-rw---T 1 root audio 116,  8 Jan 16 14:36 /dev/snd/pcmC1D3p
crw-rw---T 1 root audio 116,  1 Jan 16 14:36 /dev/snd/seq
crw-rw---T 1 root audio 116, 33 Jan 16 14:36 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  80 Jan 16 14:36 .
drwxr-xr-x 3 root root 260 Jan 16 14:36 ..
lrwxrwxrwx 1 root root  12 Jan 16 14:36 pci-0000:00:14.2 -> ../controlC0
lrwxrwxrwx 1 root root  12 Jan 16 14:36 pci-0000:01:00.1 -> ../controlC1


!!Aplay/Arecord output
!!--------------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: SB [HDA ATI SB], device 0: AD1989B Analog [AD1989B Analog]
  Subdevices: 0/1
  Subdevice #0: subdevice #0
card 0: SB [HDA ATI SB], device 1: AD1989B Digital [AD1989B Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: SB [HDA ATI SB], device 2: AD1989B Analog [AD1989B Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: HDMI [HDA ATI HDMI], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: SB [HDA ATI SB], device 0: AD1989B Analog [AD1989B Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: SB [HDA ATI SB], device 2: AD1989B Analog [AD1989B Analog]
  Subdevices: 2/2
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [SB]

Card hw:0 'SB'/'HDA ATI SB at 0xfe8f4000 irq 16'
  Mixer name	: 'Analog Devices AD1989B'
  Components	: 'HDA:11d4989b,10438311,00100300'
  Controls      : 48
  Simple ctrls  : 18
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 39
  Mono: Playback 35 [90%] [-6.00dB] [on]
Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 39
  Mono:
  Front Left: Playback 39 [100%] [0.00dB] [on]
  Front Right: Playback 39 [100%] [0.00dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 238 [93%] [-3.40dB]
  Front Right: Playback 238 [93%] [-3.40dB]
Simple mixer control 'Front',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 39
  Mono:
  Front Left: Playback 34 [87%] [-7.50dB] [on]
  Front Right: Playback 34 [87%] [-7.50dB] [on]
Simple mixer control 'Surround',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 39
  Mono:
  Front Left: Playback 39 [100%] [0.00dB] [on]
  Front Right: Playback 39 [100%] [0.00dB] [on]
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 39
  Mono: Playback 39 [100%] [0.00dB] [on]
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 39
  Mono: Playback 39 [100%] [0.00dB] [on]
Simple mixer control 'Side',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 39
  Mono:
  Front Left: Playback 39 [100%] [0.00dB] [on]
  Front Right: Playback 39 [100%] [0.00dB] [on]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'IEC958 Default PCM',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 54
  Front Left: Capture 39 [72%] [0.00dB] [off]
  Front Right: Capture 39 [72%] [0.00dB] [off]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 54
  Front Left: Capture 39 [72%] [0.00dB] [off]
  Front Right: Capture 39 [72%] [0.00dB] [off]
Simple mixer control 'Capture',2
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 54
  Front Left: Capture 39 [72%] [0.00dB] [off]
  Front Right: Capture 39 [72%] [0.00dB] [off]
Simple mixer control 'Auto-Mute Mode',0
  Capabilities: enum
  Items: 'Disabled' 'Enabled'
  Item0: 'Enabled'
Simple mixer control 'Independent HP',0
  Capabilities: enum
  Items: 'Disabled' 'Enabled'
  Item0: 'Disabled'
Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Front Mic' 'Rear Mic' 'Line' 'CD'
  Item0: 'Front Mic'
Simple mixer control 'Input Source',1
  Capabilities: cenum
  Items: 'Front Mic' 'Rear Mic' 'Line' 'CD'
  Item0: 'Front Mic'
Simple mixer control 'Input Source',2
  Capabilities: cenum
  Items: 'Front Mic' 'Rear Mic' 'Line' 'CD'
  Item0: 'Front Mic'

!!-------Mixer controls for card 1 [HDMI]

Card hw:1 'HDMI'/'HDA ATI HDMI at 0xfe9ec000 irq 42'
  Mixer name	: 'ATI R6xx HDMI'
  Components	: 'HDA:1002aa01,00aa0100,00100000'
  Controls      : 7
  Simple ctrls  : 1
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]


!!Alsactl output
!!--------------

--startcollapse--
state.SB {
	control.1 {
		iface MIXER
		name 'Front Playback Volume'
		value.0 34
		value.1 34
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 39'
			dbmin -5850
			dbmax 0
			dbvalue.0 -750
			dbvalue.1 -750
		}
	}
	control.2 {
		iface MIXER
		name 'Front Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.3 {
		iface MIXER
		name 'Surround Playback Volume'
		value.0 39
		value.1 39
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 39'
			dbmin -5850
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.4 {
		iface MIXER
		name 'Surround Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.5 {
		iface MIXER
		name 'Center Playback Volume'
		value 39
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 39'
			dbmin -5850
			dbmax 0
			dbvalue.0 0
		}
	}
	control.6 {
		iface MIXER
		name 'LFE Playback Volume'
		value 39
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 39'
			dbmin -5850
			dbmax 0
			dbvalue.0 0
		}
	}
	control.7 {
		iface MIXER
		name 'Center Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.8 {
		iface MIXER
		name 'LFE Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.9 {
		iface MIXER
		name 'Side Playback Volume'
		value.0 39
		value.1 39
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 39'
			dbmin -5850
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.10 {
		iface MIXER
		name 'Side Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.11 {
		iface MIXER
		name 'Headphone Playback Volume'
		value.0 39
		value.1 39
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 39'
			dbmin -5850
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.12 {
		iface MIXER
		name 'Headphone Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.13 {
		iface MIXER
		name 'Independent HP'
		value Disabled
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Disabled
			item.1 Enabled
		}
	}
	control.14 {
		iface MIXER
		name 'Auto-Mute Mode'
		value Enabled
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Disabled
			item.1 Enabled
		}
	}
	control.15 {
		iface MIXER
		name 'Input Source'
		value 'Front Mic'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 'Front Mic'
			item.1 'Rear Mic'
			item.2 Line
			item.3 CD
		}
	}
	control.16 {
		iface MIXER
		name 'Input Source'
		index 1
		value 'Front Mic'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 'Front Mic'
			item.1 'Rear Mic'
			item.2 Line
			item.3 CD
		}
	}
	control.17 {
		iface MIXER
		name 'Input Source'
		index 2
		value 'Front Mic'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 'Front Mic'
			item.1 'Rear Mic'
			item.2 Line
			item.3 CD
		}
	}
	control.18 {
		iface MIXER
		name 'Capture Volume'
		value.0 39
		value.1 39
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 54'
			dbmin -5850
			dbmax 2250
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.19 {
		iface MIXER
		name 'Capture Switch'
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.20 {
		iface MIXER
		name 'Capture Volume'
		index 1
		value.0 39
		value.1 39
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 54'
			dbmin -5850
			dbmax 2250
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.21 {
		iface MIXER
		name 'Capture Switch'
		index 1
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.22 {
		iface MIXER
		name 'Capture Volume'
		index 2
		value.0 39
		value.1 39
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 54'
			dbmin -5850
			dbmax 2250
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.23 {
		iface MIXER
		name 'Capture Switch'
		index 2
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.24 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.25 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.26 {
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.27 {
		iface MIXER
		name 'IEC958 Playback Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.28 {
		iface MIXER
		name 'IEC958 Default PCM Playback Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.29 {
		iface MIXER
		name 'Master Playback Volume'
		value 35
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 39'
			dbmin -5850
			dbmax 0
			dbvalue.0 -600
		}
	}
	control.30 {
		iface MIXER
		name 'Master Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.31 {
		iface CARD
		name 'Line Out Front Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.32 {
		iface CARD
		name 'Line Out Surround Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.33 {
		iface CARD
		name 'Line Out CLFE Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.34 {
		iface CARD
		name 'Line Out Side Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.35 {
		iface CARD
		name 'Front Headphone Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.36 {
		iface CARD
		name 'Front Mic Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.37 {
		iface CARD
		name 'Rear Mic Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.38 {
		iface CARD
		name 'Line Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.39 {
		iface CARD
		name 'CD Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.40 {
		iface CARD
		name 'SPDIF Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.41 {
		iface CARD
		name 'HDMI Phantom Jack'
		index 1
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.42 {
		iface PCM
		name 'Playback Channel Map'
		value.0 3
		value.1 4
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		comment {
			access read
			type INTEGER
			count 8
			range '0 - 36'
		}
	}
	control.43 {
		iface PCM
		name 'Capture Channel Map'
		value.0 0
		value.1 0
		comment {
			access read
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
	control.44 {
		iface PCM
		device 1
		name 'Playback Channel Map'
		value.0 0
		value.1 0
		comment {
			access read
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
	control.45 {
		iface PCM
		device 2
		name 'Playback Channel Map'
		value.0 0
		value.1 0
		comment {
			access read
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
	control.46 {
		iface PCM
		device 2
		name 'Capture Channel Map'
		value.0 0
		value.1 0
		comment {
			access read
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
	control.47 {
		iface PCM
		device 2
		name 'Capture Channel Map'
		index 1
		value.0 0
		value.1 0
		comment {
			access read
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
	control.48 {
		iface MIXER
		name 'PCM Playback Volume'
		value.0 238
		value.1 238
		comment {
			access 'read write user'
			type INTEGER
			count 2
			range '0 - 255'
			tlv '0000000100000008ffffec1400000014'
			dbmin -5100
			dbmax 0
			dbvalue.0 -340
			dbvalue.1 -340
		}
	}
}
state.HDMI {
	control.1 {
		iface CARD
		name 'HDMI/DP,pcm=3 Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.2 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.3 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.4 {
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.5 {
		iface MIXER
		name 'IEC958 Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.6 {
		iface PCM
		device 3
		name ELD
		value ''
		comment {
			access 'read volatile'
			type BYTES
			count 0
		}
	}
	control.7 {
		iface PCM
		device 3
		name 'Playback Channel Map'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------



!!ALSA/HDA dmesg
!!--------------

[    2.099338] hid-generic 0003:15D9:0A4D.0001: input: USB HID v1.11 Mouse [ USB OPTICAL MOUSE] on usb-0000:00:12.1-2/input0
[    2.241461] hda_codec: AD1989B: BIOS auto-probing.
[    2.265082] input: HDA ATI SB Line as /devices/pci0000:00/0000:00:14.2/sound/card0/input4
[    2.267522] input: HDA ATI SB Rear Mic as /devices/pci0000:00/0000:00:14.2/sound/card0/input5
[    2.269900] input: HDA ATI SB Front Mic as /devices/pci0000:00/0000:00:14.2/sound/card0/input6
[    2.272287] input: HDA ATI SB Front Headphone as /devices/pci0000:00/0000:00:14.2/sound/card0/input7
[    2.274691] input: HDA ATI SB Line Out Side as /devices/pci0000:00/0000:00:14.2/sound/card0/input8
[    2.277114] input: HDA ATI SB Line Out CLFE as /devices/pci0000:00/0000:00:14.2/sound/card0/input9
[    2.279535] input: HDA ATI SB Line Out Surround as /devices/pci0000:00/0000:00:14.2/sound/card0/input10
[    2.281966] input: HDA ATI SB Line Out Front as /devices/pci0000:00/0000:00:14.2/sound/card0/input11
[    2.284729] snd_hda_intel 0000:01:00.1: irq 42 for MSI/MSI-X
[    2.288532] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:02.0/0000:01:00.1/sound/card1/input12
[    2.291228] GACT probability NOT on
--
[    2.356980] powernow-k8: Found 1 AMD Athlon(tm) X2 Dual Core Processor BE-2350 (2 cpu cores) (version 2.20.00)
[    2.359269] ALSA device list:
[    2.361493]   #0: HDA ATI SB at 0xfe8f4000 irq 16
[    2.363720]   #1: HDA ATI HDMI at 0xfe9ec000 irq 42
[    2.366474] EXT4-fs (sda1): couldn't mount as ext3 due to feature incompatibilities
--
[  200.736358] serial 00:08: activated
[  200.736528] snd_hda_intel 0000:01:00.1: irq 42 for MSI/MSI-X
[  200.736593] pcieport 0000:00:06.0: System wakeup disabled by ACPI



--MP_/D3P...mFXLW7fkqwrsz17Sy
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=alsa-info-before-suspend.txt

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.61
!!################################

!!Script ran on: Wed Jan 16 13:38:52 UTC 2013


!!Linux Distribution
!!------------------

[0;32mDebian testing (Wheezy) [0;31m\n. [1;33m\l[0;32m PRETTY_NAME="Debian GNU/Linux 7.0 (wheezy)" NAME="Debian GNU/Linux" ID=debian HOME_URL="http://www.debian.org/" SUPPORT_URL="http://www.debian.org/support/" BUG_REPORT_URL="http://bugs.debian.org/"


!!DMI Information
!!---------------

Manufacturer:      System manufacturer
Product Name:      System Product Name
Product Version:   System Version
Firmware Version:  1801   


!!Kernel Information
!!------------------

Kernel release:    3.8.0-rc3+
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         unknown
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     k3.8.0-rc3+
Library version:    1.0.25
Utilities version:  1.0.25


!!Loaded ALSA modules
!!-------------------



!!Sound Servers on this system
!!----------------------------

Jack:
      Installed - Yes (/usr/bin/jackd)
      Running - No


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [SB             ]: HDA-Intel - HDA ATI SB
                      HDA ATI SB at 0xfe8f4000 irq 16
 1 [HDMI           ]: HDA-Intel - HDA ATI HDMI
                      HDA ATI HDMI at 0xfe9ec000 irq 42


!!PCI Soundcards installed in the system
!!--------------------------------------

00:14.2 Audio device: Advanced Micro Devices [AMD] nee ATI SBx00 Azalia (Intel HDA)
01:00.1 Audio device: Advanced Micro Devices [AMD] nee ATI RV610 HDMI Audio [Radeon HD 2350/2400 Series]


!!Advanced information - PCI Vendor/Device/Subsystem ID's
!!-------------------------------------------------------

00:14.2 0403: 1002:4383
	Subsystem: 1043:8288
--
01:00.1 0403: 1002:aa10
	Subsystem: 1043:aa10


!!Loaded sound module options
!!---------------------------


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Analog Devices AD1989B
Address: 0
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x11d4989b
Subsystem Id: 0x10438311
Revision Id: 0x100300
No Modem Function Group found
Default PCM:
    rates [0x7ff]: 8000 11025 16000 22050 32000 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Default Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
State of AFG node 0x01:
  Power states:  D0 D3
  Power: setting=D0, actual=D0
GPIO: io=3, o=0, i=0, unsolicited=1, wake=0
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=1, unsol=0
  IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Node 0x02 [Audio Output] wcaps 0x30211: Stereo Digital
  Control: name="IEC958 Playback Con Mask", index=0, device=0
  Control: name="IEC958 Playback Pro Mask", index=0, device=0
  Control: name="IEC958 Playback Default", index=0, device=0
  Control: name="IEC958 Playback Switch", index=0, device=0
  Control: name="IEC958 Default PCM Playback Switch", index=0, device=0
  Device: name="AD1989B Digital", type="SPDIF", device=1
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Delay: 3 samples
Node 0x03 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Control: name="Headphone Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Device: name="AD1989B Analog", type="Audio", device=2
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
  Amp-Out vals:  [0x23 0x23]
  Converter: stream=8, channel=0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
Node 0x04 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Control: name="Front Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Device: name="AD1989B Analog", type="Audio", device=0
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
  Amp-Out vals:  [0x1e 0x1e]
  Converter: stream=8, channel=0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
Node 0x05 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Control: name="Center Playback Volume", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Control: name="LFE Playback Volume", index=0, device=0
    ControlAmp: chs=2, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
  Amp-Out vals:  [0x23 0x23]
  Converter: stream=8, channel=0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
Node 0x06 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Control: name="Surround Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
  Amp-Out vals:  [0x23 0x23]
  Converter: stream=8, channel=0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
Node 0x07 [Audio Input] wcaps 0x130391: Stereo Digital
  Converter: stream=0, channel=0
  SDI-Select: 0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Unsolicited: tag=00, enabled=0
  Delay: 3 samples
  Connection: 1
     0x1c
Node 0x08 [Audio Input] wcaps 0x100501: Stereo
  Device: name="AD1989B Analog", type="Audio", device=0
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
  Connection: 1
     0x0c
Node 0x09 [Audio Input] wcaps 0x100501: Stereo
  Device: name="AD1989B Analog", type="Audio", device=2
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
  Connection: 1
     0x0d
Node 0x0a [Audio Output] wcaps 0x405: Stereo Amp-Out
  Control: name="Side Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
  Amp-Out vals:  [0x23 0x23]
  Converter: stream=8, channel=0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
Node 0x0b [Audio Output] wcaps 0x30211: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Delay: 3 samples
Node 0x0c [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Control: name="Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Capture Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x27, nsteps=0x36, stepsize=0x05, mute=1
  Amp-Out vals:  [0xa7 0xa7]
  Connection: 11
     0x38 0x39* 0x3a 0x3b 0x3c 0x18 0x24 0x25 0x3d 0x20 0x1f
Node 0x0d [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Control: name="Capture Volume", index=1, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Capture Switch", index=1, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x27, nsteps=0x36, stepsize=0x05, mute=1
  Amp-Out vals:  [0xa7 0xa7]
  Connection: 10
     0x38 0x39* 0x3a 0x3b 0x3c 0x18 0x24 0x25 0x3d 0x20
Node 0x0e [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Control: name="Capture Volume", index=2, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Capture Switch", index=2, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x27, nsteps=0x36, stepsize=0x05, mute=1
  Amp-Out vals:  [0xa7 0xa7]
  Connection: 10
     0x38 0x39* 0x3a 0x3b 0x3c 0x18 0x24 0x25 0x3d 0x20
Node 0x0f [Audio Input] wcaps 0x100501: Stereo
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
  Connection: 1
     0x0e
Node 0x10 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x0f, nsteps=0x0f, stepsize=0x0b, mute=1
  Amp-Out vals:  [0x8f]
Node 0x11 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Front Headphone Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000373f: IN OUT HP Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x02214030: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
    DefAssociation = 0x3, Sequence = 0x0
  Pin-ctls: 0xc0: OUT HP VREF_HIZ
  Unsolicited: tag=01, enabled=1
  Connection: 1
     0x22
Node 0x12 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Control: name="Front Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Line Out Front Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000373f: IN OUT HP Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x01014010: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT VREF_HIZ
  Unsolicited: tag=02, enabled=1
  Connection: 1
     0x29
Node 0x13 [Pin Complex] wcaps 0x40010c: Mono Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x9f]
  Pincap 0x00000010: OUT
  Pin Default 0x511711f0: [N/A] Speaker at Int Rear
    Conn = Analog, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x2d
Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Control: name="Front Mic Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000373f: IN OUT HP Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x02a1902e: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Pink
    DefAssociation = 0x2, Sequence = 0xe
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=06, enabled=1
  Connection: 1
     0x2b
Node 0x15 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Control: name="Line Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00003737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x01813021: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Blue
    DefAssociation = 0x2, Sequence = 0x1
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=08, enabled=1
  Connection: 1
     0x2c
Node 0x16 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Control: name="Surround Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Line Out Surround Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00000037: IN OUT Detect Trigger ImpSense
  Pin Default 0x01011012: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0x1, Sequence = 0x2
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=03, enabled=1
  Connection: 1
     0x2a
Node 0x17 [Pin Complex] wcaps 0x40098d: Stereo Amp-Out R/L
  Control: name="Rear Mic Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00003737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x01a19020: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Pink
    DefAssociation = 0x2, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=07, enabled=1
  Connection: 1
     0x26
Node 0x18 [Pin Complex] wcaps 0x400081: Stereo
  Control: name="CD Phantom Jack", index=0, device=0
  Pincap 0x00000024: IN Detect
  Pin Default 0x99331122: [Fixed] CD at Int ATAPI
    Conn = ATAPI, Color = Black
    DefAssociation = 0x2, Sequence = 0x2
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
  Unsolicited: tag=00, enabled=0
Node 0x19 [Power Widget] wcaps 0x500500: Mono
  Power states:  D0 D3
  Power: setting=D0, actual=D0
  Connection: 2
     0x20 0x21
Node 0x1a [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x00000020: IN
  Pin Default 0x911711f0: [Fixed] Speaker at Int Rear
    Conn = Analog, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x1b [Pin Complex] wcaps 0x40030d: Stereo Digital Amp-Out
  Control: name="SPDIF Phantom Jack", index=0, device=0
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=1
  Amp-Out vals:  [0x27 0x27]
  Pincap 0x00000010: OUT
  Pin Default 0x0145f1a0: [Jack] SPDIF Out at Ext Rear
    Conn = Optical, Color = Other
    DefAssociation = 0xa, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x02
Node 0x1c [Pin Complex] wcaps 0x40020b: Stereo Digital Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x97 0x97]
  Pincap 0x00000020: IN
  Pin Default 0x41c5f160: [N/A] SPDIF In at Ext Rear
    Conn = Optical, Color = Other
    DefAssociation = 0x6, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x1d [Pin Complex] wcaps 0x40030d: Stereo Digital Amp-Out
  Control: name="HDMI Phantom Jack", index=1, device=0
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=1
  Amp-Out vals:  [0x27 0x27]
  Pincap 0x00000010: OUT
  Pin Default 0x1856f1b0: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Other
    DefAssociation = 0xb, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0b
Node 0x1e [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Connection: 2
     0x36 0x21
Node 0x1f [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x20 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97]
  Connection: 8
     0x39 0x33 0x38 0x3d 0x34 0x3b 0x18 0x1a
Node 0x21 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x9f 0x9f]
  Connection: 1
     0x20
Node 0x22 [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Connection: 2
     0x37 0x21
Node 0x23 [Vendor Defined Widget] wcaps 0xf00100: Mono
  Connection: 18
     0x11* 0x12 0x13 0x14 0x15 0x16 0x17 0x18 0x24 0x25 0x38 0x39 0x3a 0x3b 0x3c 0x3d 0x20 0x21
Node 0x24 [Pin Complex] wcaps 0x40098d: Stereo Amp-Out R/L
  Control: name="Center Playback Switch", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Control: name="LFE Playback Switch", index=0, device=0
    ControlAmp: chs=2, dir=Out, idx=0, ofs=0
  Control: name="Line Out CLFE Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00000037: IN OUT Detect Trigger ImpSense
  Pin Default 0x01016011: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Orange
    DefAssociation = 0x1, Sequence = 0x1
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=04, enabled=1
  Connection: 1
     0x27
Node 0x25 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Control: name="Side Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Line Out Side Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00000037: IN OUT Detect Trigger ImpSense
  Pin Default 0x01012014: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Grey
    DefAssociation = 0x1, Sequence = 0x4
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=05, enabled=1
  Connection: 1
     0x28
Node 0x26 [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Connection: 2
     0x32 0x21
Node 0x27 [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Connection: 2
     0x05 0x21
Node 0x28 [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Connection: 2
     0x0a 0x21
Node 0x29 [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Connection: 2
     0x04 0x21
Node 0x2a [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Connection: 2
     0x06 0x21
Node 0x2b [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Connection: 2
     0x30 0x21
Node 0x2c [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Connection: 2
     0x31 0x21
Node 0x2d [Audio Mixer] wcaps 0x200100: Mono
  Connection: 1
     0x1e
Node 0x2e [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x2f [Vendor Defined Widget] wcaps 0xf00100: Mono
  Connection: 6
     0x11* 0x12 0x14 0x15 0x16 0x17
Node 0x30 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 3
     0x03* 0x04 0x06
Node 0x31 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x04* 0x0a
Node 0x32 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x05* 0x04
Node 0x33 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 3
     0x3a* 0x25 0x24
Node 0x34 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 3
     0x3c* 0x25 0x24
Node 0x35 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x36 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 3
     0x03* 0x04 0x06
Node 0x37 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 3
     0x03* 0x04 0x06
Node 0x38 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 1
     0x11
Node 0x39 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 1
     0x14
Node 0x3a [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 1
     0x15
Node 0x3b [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x3c [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 1
     0x17
Node 0x3d [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 1
     0x12
Codec: ATI R6xx HDMI
Address: 0
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x1002aa01
Subsystem Id: 0x00aa0100
Revision Id: 0x100000
No Modem Function Group found
Default PCM:
    rates [0x40]: 48000
    bits [0x2]: 16
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
  Power states:  D0 D3
  Power: setting=D0, actual=D0
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x02 [Audio Output] wcaps 0x201: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
Node 0x03 [Pin Complex] wcaps 0x400381: Stereo Digital
  Control: name="HDMI/DP,pcm=3 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=0, device=0
  Control: name="IEC958 Playback Pro Mask", index=0, device=0
  Control: name="IEC958 Playback Default", index=0, device=0
  Control: name="IEC958 Playback Switch", index=0, device=0
  Control: name="ELD", index=0, device=3
  Pincap 0x00000094: OUT Detect HDMI
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=01, enabled=1
  Connection: 1
     0x02
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw---T 1 root audio 116,  7 Jan 16 14:36 /dev/snd/controlC0
crw-rw---T 1 root audio 116,  9 Jan 16 14:36 /dev/snd/controlC1
crw-rw---T 1 root audio 116,  6 Jan 16 14:36 /dev/snd/pcmC0D0c
crw-rw---T 1 root audio 116,  5 Jan 16 14:38 /dev/snd/pcmC0D0p
crw-rw---T 1 root audio 116,  4 Jan 16 14:36 /dev/snd/pcmC0D1p
crw-rw---T 1 root audio 116,  3 Jan 16 14:36 /dev/snd/pcmC0D2c
crw-rw---T 1 root audio 116,  2 Jan 16 14:36 /dev/snd/pcmC0D2p
crw-rw---T 1 root audio 116,  8 Jan 16 14:36 /dev/snd/pcmC1D3p
crw-rw---T 1 root audio 116,  1 Jan 16 14:36 /dev/snd/seq
crw-rw---T 1 root audio 116, 33 Jan 16 14:36 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  80 Jan 16 14:36 .
drwxr-xr-x 3 root root 260 Jan 16 14:36 ..
lrwxrwxrwx 1 root root  12 Jan 16 14:36 pci-0000:00:14.2 -> ../controlC0
lrwxrwxrwx 1 root root  12 Jan 16 14:36 pci-0000:01:00.1 -> ../controlC1


!!Aplay/Arecord output
!!--------------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: SB [HDA ATI SB], device 0: AD1989B Analog [AD1989B Analog]
  Subdevices: 0/1
  Subdevice #0: subdevice #0
card 0: SB [HDA ATI SB], device 1: AD1989B Digital [AD1989B Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: SB [HDA ATI SB], device 2: AD1989B Analog [AD1989B Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: HDMI [HDA ATI HDMI], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: SB [HDA ATI SB], device 0: AD1989B Analog [AD1989B Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: SB [HDA ATI SB], device 2: AD1989B Analog [AD1989B Analog]
  Subdevices: 2/2
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [SB]

Card hw:0 'SB'/'HDA ATI SB at 0xfe8f4000 irq 16'
  Mixer name	: 'Analog Devices AD1989B'
  Components	: 'HDA:11d4989b,10438311,00100300'
  Controls      : 48
  Simple ctrls  : 18
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 39
  Mono: Playback 35 [90%] [-6.00dB] [on]
Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 39
  Mono:
  Front Left: Playback 39 [100%] [0.00dB] [on]
  Front Right: Playback 39 [100%] [0.00dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 238 [93%] [-3.40dB]
  Front Right: Playback 238 [93%] [-3.40dB]
Simple mixer control 'Front',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 39
  Mono:
  Front Left: Playback 34 [87%] [-7.50dB] [on]
  Front Right: Playback 34 [87%] [-7.50dB] [on]
Simple mixer control 'Surround',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 39
  Mono:
  Front Left: Playback 39 [100%] [0.00dB] [on]
  Front Right: Playback 39 [100%] [0.00dB] [on]
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 39
  Mono: Playback 39 [100%] [0.00dB] [on]
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 39
  Mono: Playback 39 [100%] [0.00dB] [on]
Simple mixer control 'Side',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 39
  Mono:
  Front Left: Playback 39 [100%] [0.00dB] [on]
  Front Right: Playback 39 [100%] [0.00dB] [on]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'IEC958 Default PCM',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 54
  Front Left: Capture 39 [72%] [0.00dB] [off]
  Front Right: Capture 39 [72%] [0.00dB] [off]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 54
  Front Left: Capture 39 [72%] [0.00dB] [off]
  Front Right: Capture 39 [72%] [0.00dB] [off]
Simple mixer control 'Capture',2
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 54
  Front Left: Capture 39 [72%] [0.00dB] [off]
  Front Right: Capture 39 [72%] [0.00dB] [off]
Simple mixer control 'Auto-Mute Mode',0
  Capabilities: enum
  Items: 'Disabled' 'Enabled'
  Item0: 'Enabled'
Simple mixer control 'Independent HP',0
  Capabilities: enum
  Items: 'Disabled' 'Enabled'
  Item0: 'Disabled'
Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Front Mic' 'Rear Mic' 'Line' 'CD'
  Item0: 'Front Mic'
Simple mixer control 'Input Source',1
  Capabilities: cenum
  Items: 'Front Mic' 'Rear Mic' 'Line' 'CD'
  Item0: 'Front Mic'
Simple mixer control 'Input Source',2
  Capabilities: cenum
  Items: 'Front Mic' 'Rear Mic' 'Line' 'CD'
  Item0: 'Front Mic'

!!-------Mixer controls for card 1 [HDMI]

Card hw:1 'HDMI'/'HDA ATI HDMI at 0xfe9ec000 irq 42'
  Mixer name	: 'ATI R6xx HDMI'
  Components	: 'HDA:1002aa01,00aa0100,00100000'
  Controls      : 7
  Simple ctrls  : 1
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]


!!Alsactl output
!!--------------

--startcollapse--
state.SB {
	control.1 {
		iface MIXER
		name 'Front Playback Volume'
		value.0 34
		value.1 34
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 39'
			dbmin -5850
			dbmax 0
			dbvalue.0 -750
			dbvalue.1 -750
		}
	}
	control.2 {
		iface MIXER
		name 'Front Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.3 {
		iface MIXER
		name 'Surround Playback Volume'
		value.0 39
		value.1 39
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 39'
			dbmin -5850
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.4 {
		iface MIXER
		name 'Surround Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.5 {
		iface MIXER
		name 'Center Playback Volume'
		value 39
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 39'
			dbmin -5850
			dbmax 0
			dbvalue.0 0
		}
	}
	control.6 {
		iface MIXER
		name 'LFE Playback Volume'
		value 39
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 39'
			dbmin -5850
			dbmax 0
			dbvalue.0 0
		}
	}
	control.7 {
		iface MIXER
		name 'Center Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.8 {
		iface MIXER
		name 'LFE Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.9 {
		iface MIXER
		name 'Side Playback Volume'
		value.0 39
		value.1 39
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 39'
			dbmin -5850
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.10 {
		iface MIXER
		name 'Side Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.11 {
		iface MIXER
		name 'Headphone Playback Volume'
		value.0 39
		value.1 39
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 39'
			dbmin -5850
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.12 {
		iface MIXER
		name 'Headphone Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.13 {
		iface MIXER
		name 'Independent HP'
		value Disabled
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Disabled
			item.1 Enabled
		}
	}
	control.14 {
		iface MIXER
		name 'Auto-Mute Mode'
		value Enabled
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Disabled
			item.1 Enabled
		}
	}
	control.15 {
		iface MIXER
		name 'Input Source'
		value 'Front Mic'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 'Front Mic'
			item.1 'Rear Mic'
			item.2 Line
			item.3 CD
		}
	}
	control.16 {
		iface MIXER
		name 'Input Source'
		index 1
		value 'Front Mic'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 'Front Mic'
			item.1 'Rear Mic'
			item.2 Line
			item.3 CD
		}
	}
	control.17 {
		iface MIXER
		name 'Input Source'
		index 2
		value 'Front Mic'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 'Front Mic'
			item.1 'Rear Mic'
			item.2 Line
			item.3 CD
		}
	}
	control.18 {
		iface MIXER
		name 'Capture Volume'
		value.0 39
		value.1 39
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 54'
			dbmin -5850
			dbmax 2250
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.19 {
		iface MIXER
		name 'Capture Switch'
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.20 {
		iface MIXER
		name 'Capture Volume'
		index 1
		value.0 39
		value.1 39
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 54'
			dbmin -5850
			dbmax 2250
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.21 {
		iface MIXER
		name 'Capture Switch'
		index 1
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.22 {
		iface MIXER
		name 'Capture Volume'
		index 2
		value.0 39
		value.1 39
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 54'
			dbmin -5850
			dbmax 2250
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.23 {
		iface MIXER
		name 'Capture Switch'
		index 2
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.24 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.25 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.26 {
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.27 {
		iface MIXER
		name 'IEC958 Playback Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.28 {
		iface MIXER
		name 'IEC958 Default PCM Playback Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.29 {
		iface MIXER
		name 'Master Playback Volume'
		value 35
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 39'
			dbmin -5850
			dbmax 0
			dbvalue.0 -600
		}
	}
	control.30 {
		iface MIXER
		name 'Master Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.31 {
		iface CARD
		name 'Line Out Front Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.32 {
		iface CARD
		name 'Line Out Surround Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.33 {
		iface CARD
		name 'Line Out CLFE Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.34 {
		iface CARD
		name 'Line Out Side Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.35 {
		iface CARD
		name 'Front Headphone Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.36 {
		iface CARD
		name 'Front Mic Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.37 {
		iface CARD
		name 'Rear Mic Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.38 {
		iface CARD
		name 'Line Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.39 {
		iface CARD
		name 'CD Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.40 {
		iface CARD
		name 'SPDIF Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.41 {
		iface CARD
		name 'HDMI Phantom Jack'
		index 1
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.42 {
		iface PCM
		name 'Playback Channel Map'
		value.0 3
		value.1 4
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		comment {
			access read
			type INTEGER
			count 8
			range '0 - 36'
		}
	}
	control.43 {
		iface PCM
		name 'Capture Channel Map'
		value.0 0
		value.1 0
		comment {
			access read
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
	control.44 {
		iface PCM
		device 1
		name 'Playback Channel Map'
		value.0 0
		value.1 0
		comment {
			access read
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
	control.45 {
		iface PCM
		device 2
		name 'Playback Channel Map'
		value.0 0
		value.1 0
		comment {
			access read
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
	control.46 {
		iface PCM
		device 2
		name 'Capture Channel Map'
		value.0 0
		value.1 0
		comment {
			access read
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
	control.47 {
		iface PCM
		device 2
		name 'Capture Channel Map'
		index 1
		value.0 0
		value.1 0
		comment {
			access read
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
	control.48 {
		iface MIXER
		name 'PCM Playback Volume'
		value.0 238
		value.1 238
		comment {
			access 'read write user'
			type INTEGER
			count 2
			range '0 - 255'
			tlv '0000000100000008ffffec1400000014'
			dbmin -5100
			dbmax 0
			dbvalue.0 -340
			dbvalue.1 -340
		}
	}
}
state.HDMI {
	control.1 {
		iface CARD
		name 'HDMI/DP,pcm=3 Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.2 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.3 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.4 {
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.5 {
		iface MIXER
		name 'IEC958 Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.6 {
		iface PCM
		device 3
		name ELD
		value ''
		comment {
			access 'read volatile'
			type BYTES
			count 0
		}
	}
	control.7 {
		iface PCM
		device 3
		name 'Playback Channel Map'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------



!!ALSA/HDA dmesg
!!--------------

[    2.099338] hid-generic 0003:15D9:0A4D.0001: input: USB HID v1.11 Mouse [ USB OPTICAL MOUSE] on usb-0000:00:12.1-2/input0
[    2.241461] hda_codec: AD1989B: BIOS auto-probing.
[    2.265082] input: HDA ATI SB Line as /devices/pci0000:00/0000:00:14.2/sound/card0/input4
[    2.267522] input: HDA ATI SB Rear Mic as /devices/pci0000:00/0000:00:14.2/sound/card0/input5
[    2.269900] input: HDA ATI SB Front Mic as /devices/pci0000:00/0000:00:14.2/sound/card0/input6
[    2.272287] input: HDA ATI SB Front Headphone as /devices/pci0000:00/0000:00:14.2/sound/card0/input7
[    2.274691] input: HDA ATI SB Line Out Side as /devices/pci0000:00/0000:00:14.2/sound/card0/input8
[    2.277114] input: HDA ATI SB Line Out CLFE as /devices/pci0000:00/0000:00:14.2/sound/card0/input9
[    2.279535] input: HDA ATI SB Line Out Surround as /devices/pci0000:00/0000:00:14.2/sound/card0/input10
[    2.281966] input: HDA ATI SB Line Out Front as /devices/pci0000:00/0000:00:14.2/sound/card0/input11
[    2.284729] snd_hda_intel 0000:01:00.1: irq 42 for MSI/MSI-X
[    2.288532] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:02.0/0000:01:00.1/sound/card1/input12
[    2.291228] GACT probability NOT on
--
[    2.356980] powernow-k8: Found 1 AMD Athlon(tm) X2 Dual Core Processor BE-2350 (2 cpu cores) (version 2.20.00)
[    2.359269] ALSA device list:
[    2.361493]   #0: HDA ATI SB at 0xfe8f4000 irq 16
[    2.363720]   #1: HDA ATI HDMI at 0xfe9ec000 irq 42
[    2.366474] EXT4-fs (sda1): couldn't mount as ext3 due to feature incompatibilities



--MP_/D3P...mFXLW7fkqwrsz17Sy
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--MP_/D3P...mFXLW7fkqwrsz17Sy--
