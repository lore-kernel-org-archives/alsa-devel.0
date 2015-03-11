From: Vasil Zlatanov <vasil.zlatanov@gmail.com>
Subject: Microphone Not Working after Suspend on Apple
 MacBookAir5, 2 Cirrus Logic CS4206
Date: Wed, 11 Mar 2015 23:26:00 +0100
Message-ID: <20150311222600.GA2927@airon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1757855134016359049=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f181.google.com (mail-lb0-f181.google.com
 [209.85.217.181])
 by alsa0.perex.cz (Postfix) with ESMTP id AE2BE265372
 for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2015 23:26:06 +0100 (CET)
Received: by lbvn10 with SMTP id n10so12165806lbv.1
 for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2015 15:26:06 -0700 (PDT)
Received: from localhost (c-2ec3869e-74736162.cust.telenor.se.
 [46.195.134.158])
 by mx.google.com with ESMTPSA id en12sm967632lbc.11.2015.03.11.15.26.03
 for <alsa-devel@alsa-project.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Mar 2015 15:26:04 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1757855134016359049==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Content-Disposition: inline


--wzJLGUyc3ArbnUjN
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Issue as seen on reddit thread:
https://www.reddit.com/r/linux/comments/1kccbk/alsa_bug_driving_me_crazy_pl=
ease_help/

A common problem for Apple Macbook Air 5.2 users where microphone does=20
not work after system resume. As users have noted microphone starts=20
working ones again when the volume is changed in alsa-mixer.=20

alsa-info dumps are attached showing before and after being adjusted
(where before causes microphone not to work while in after it does)

IRC user 'debianuser' kindly helped out and found that using the two
following commands fix the issue:

amixer -cPCH set "Capture" 0% nocap=20
amixer -cPCH set "Capture" 100% cap                                     =20

In my experience both are required and they seem to have the same effect
as manually changing the volume level in alsamixer, and as such resolve
the issue (until another suspend when they have to be run again).

As of now I'm resolving this issue by creating a service that is to run
after resume from susspend with the given amixer commands to renable the
microphone.

The second issue, which is also in the reddit thread, is that the
microphine is mono and when recording only right channel audio is seen.
For me this broke programs such as mumble and skype.

A alsa-info output with coefficients is attached.

'debianuser' managed to find a solution to this issue well, resolving it
by running the following two commands:

hda-verb /dev/snd/hwC0D0 0x11 SET_COEF_INDEX 2
hda-verb /dev/snd/hwC0D0 0x11 SET_PROC_COEF 0x102a

After one runs them a single time after boot, the channels collectly
show and programs issues are resolved. 'debianuser' mentions that the
sources for the commands are available in the kernel and applied to the
macbook 8.1 model, but not to mine.



--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=after

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.64
!!################################

!!Script ran on: Wed Mar 11 18:45:56 UTC 2015


!!Linux Distribution
!!------------------

Arch Linux \r (\l) DISTRIB_ID=Arch DISTRIB_DESCRIPTION="Arch Linux" NAME="Arch Linux" ID=arch PRETTY_NAME="Arch Linux" HOME_URL="https://www.archlinux.org/" SUPPORT_URL="https://bbs.archlinux.org/" BUG_REPORT_URL="https://bugs.archlinux.org/"


!!DMI Information
!!---------------

Manufacturer:      Apple Inc.
Product Name:      MacBookAir5,2
Product Version:   1.0
Firmware Version:  MBA51.88Z.00EF.B02.1211271028


!!Kernel Information
!!------------------

Kernel release:    3.18.6-1-ARCH
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         unknown
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     k3.18.6-1-ARCH
Library version:    1.0.28
Utilities version:  1.0.28


!!Loaded ALSA modules
!!-------------------

snd_hda_intel


!!Sound Servers on this system
!!----------------------------

Jack:
      Installed - Yes (/usr/bin/jackd)
      Running - No


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [PCH            ]: HDA-Intel - HDA Intel PCH
                      HDA Intel PCH at 0xa0610000 irq 34


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation 7 Series/C210 Series Chipset Family High Definition Audio Controller (rev 04)


!!Advanced information - PCI Vendor/Device/Subsystem ID's
!!-------------------------------------------------------

00:1b.0 0403: 8086:1e20 (rev 04)
	Subsystem: 8086:7270


!!Loaded sound module options
!!---------------------------

!!Module: snd_hda_intel
	align_buffer_size : -1
	bdl_pos_adj : 1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	beep_mode : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	enable_msi : -1
	id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	jackpoll_ms : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	model : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	patch : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	position_fix : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	power_save : 1
	power_save_controller : Y
	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	probe_only : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	single_cmd : N
	snoop : Y


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Cirrus Logic CS4206
Address: 0
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x10134206
Subsystem Id: 0x106b5600
Revision Id: 0x100302
No Modem Function Group found
Default PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x3]: PCM FLOAT
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
  Power states:  D0 D3 CLKSTOP EPSS
  Power: setting=D0, actual=D0
GPIO: io=4, o=0, i=0, unsolicited=0, wake=0
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[1]: enable=1, dir=1, wake=0, sticky=0, data=0, unsol=0
  IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[3]: enable=1, dir=1, wake=0, sticky=0, data=1, unsol=0
Node 0x02 [Audio Output] wcaps 0xd041d: Stereo Amp-Out
  Control: name="Headphone Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Device: name="CS4206 Analog", type="Audio", device=0
  Amp-Out caps: ofs=0x73, nsteps=0x7f, stepsize=0x01, mute=1
  Amp-Out vals:  [0x50 0x50]
  Converter: stream=0, channel=0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x3]: PCM FLOAT
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x03 [Audio Output] wcaps 0xd041d: Stereo Amp-Out
  Amp-Out caps: ofs=0x73, nsteps=0x7f, stepsize=0x01, mute=1
  Amp-Out vals:  [0xf3 0xf3]
  Converter: stream=0, channel=0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x3]: PCM FLOAT
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x04 [Audio Output] wcaps 0xd041d: Stereo Amp-Out
  Control: name="Speaker Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Speaker Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x73, nsteps=0x7f, stepsize=0x01, mute=1
  Amp-Out vals:  [0x48 0x48]
  Converter: stream=0, channel=0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x3]: PCM FLOAT
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x05 [Audio Input] wcaps 0x18051b: Stereo Amp-In
  Amp-In caps: ofs=0x33, nsteps=0x3f, stepsize=0x03, mute=1
  Amp-In vals:  [0xb3 0xb3] [0xb3 0xb3]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x1f5]: 8000 16000 32000 44100 48000 88200 96000
    bits [0x1e]: 16 20 24 32
    formats [0x3]: PCM FLOAT
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 8 samples
  Connection: 2
     0x0c* 0x12
Node 0x06 [Audio Input] wcaps 0x18051b: Stereo Amp-In
  Control: name="Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Capture Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Device: name="CS4206 Analog", type="Audio", device=0
  Amp-In caps: ofs=0x33, nsteps=0x3f, stepsize=0x03, mute=1
  Amp-In vals:  [0x3f 0x3f] [0x3f 0x3f]
  Converter: stream=4, channel=0
  SDI-Select: 0
  PCM:
    rates [0x1f5]: 8000 16000 32000 44100 48000 88200 96000
    bits [0x1e]: 16 20 24 32
    formats [0x3]: PCM FLOAT
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 8 samples
  Connection: 2
     0x0d* 0x0e
Node 0x07 [Audio Input] wcaps 0x180791: Stereo Digital
  Converter: stream=0, channel=0
  SDI-Select: 0
  Digital: Preemphasis Non-Copyright
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x570]: 32000 44100 48000 96000 192000
    bits [0x1e]: 16 20 24 32
    formats [0x7]: PCM FLOAT AC3
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 8 samples
  Connection: 1
     0x0f
Node 0x08 [Audio Output] wcaps 0x40611: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x7]: PCM FLOAT AC3
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 4 samples
Node 0x09 [Pin Complex] wcaps 0x410581: Stereo
  Control: name="Headphone Jack", index=0, device=0
  Pincap 0x0000001c: OUT HP Detect
  Pin Default 0x022140f0: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=01, enabled=1
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 1 samples
  Connection: 1
     0x02
Node 0x0a [Pin Complex] wcaps 0x410581: Stereo
  Pincap 0x00000054: OUT Detect Balanced
  Pin Default 0x010140f0: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Green
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 1 samples
  Connection: 1
     0x03
Node 0x0b [Pin Complex] wcaps 0x410101: Stereo
  Control: name="Speaker Phantom Jack", index=0, device=0
  Pincap 0x00000050: OUT Balanced
  Pin Default 0x901700f0: [Fixed] Speaker at Int N/A
    Conn = Analog, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Delay: 1 samples
  Connection: 1
     0x04
Node 0x0c [Pin Complex] wcaps 0x41048b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000024: IN Detect
  Pin Default 0x01813051: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Blue
    DefAssociation = 0x5, Sequence = 0x1
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 1 samples
Node 0x0d [Pin Complex] wcaps 0x41048b: Stereo Amp-In
  Control: name="Mic Boost Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Mic Phantom Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x01 0x01]
  Pincap 0x00001764: IN Detect Balanced
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x01a19031: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Pink
    DefAssociation = 0x3, Sequence = 0x1
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 1 samples
Node 0x0e [Pin Complex] wcaps 0x41000b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x02, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000020: IN
  Pin Default 0xb7d6003e: [Fixed] Digital In at Oth Mobile-In
    Conn = Digital, Color = Unknown
    DefAssociation = 0x3, Sequence = 0xe
  Pin-ctls: 0x00:
  Delay: 1 samples
Node 0x0f [Pin Complex] wcaps 0x410681: Stereo Digital
  Pincap 0x00000024: IN Detect
  Pin Default 0x02c4e0f0: [Jack] SPDIF In at Ext Front
    Conn = RCA, Color = White
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 1 samples
Node 0x10 [Pin Complex] wcaps 0x410301: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x014460f0: [Jack] SPDIF Out at Ext Rear
    Conn = RCA, Color = Orange
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Delay: 1 samples
  Connection: 1
     0x08
Node 0x11 [Vendor Defined Widget] wcaps 0xf00040: Mono
  Processing caps: benign=0, ncoeff=22
Node 0x12 [Pin Complex] wcaps 0x41000b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x02, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000020: IN
  Pin Default 0xb7d6005e: [Fixed] Digital In at Oth Mobile-In
    Conn = Digital, Color = Unknown
    DefAssociation = 0x5, Sequence = 0xe
  Pin-ctls: 0x00:
  Delay: 1 samples
Node 0x13 [Beep Generator Widget] wcaps 0x700000: Mono
Node 0x14 [Audio Output] wcaps 0x40611: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x7]: PCM FLOAT AC3
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 4 samples
Node 0x15 [Pin Complex] wcaps 0x410301: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x014510f0: [Jack] SPDIF Out at Ext Rear
    Conn = Optical, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Delay: 1 samples
  Connection: 1
     0x14
Codec: Intel PantherPoint HDMI
Address: 3
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x80862806
Subsystem Id: 0x80860101
Revision Id: 0x100000
No Modem Function Group found
Default PCM:
    rates [0x0]:
    bits [0x0]:
    formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
  Power states:  D0 D3 CLKSTOP EPSS
  Power: setting=D0, actual=D0, Clock-stop-OK
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x02 [Audio Output] wcaps 0x6611: 8-Channels Digital
  Converter: stream=0, channel=0
  Digital: Enabled
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x5]: PCM AC3
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x03 [Audio Output] wcaps 0x6611: 8-Channels Digital
  Converter: stream=0, channel=0
  Digital: Enabled
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x5]: PCM AC3
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x04 [Audio Output] wcaps 0x6611: 8-Channels Digital
  Converter: stream=0, channel=0
  Digital: Enabled
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x5]: PCM AC3
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x05 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
  Control: name="HDMI/DP,pcm=3 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=0, device=0
  Control: name="IEC958 Playback Pro Mask", index=0, device=0
  Control: name="IEC958 Playback Default", index=0, device=0
  Control: name="IEC958 Playback Switch", index=0, device=0
  Control: name="ELD", index=0, device=3
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x09000094: OUT Detect HBR HDMI DP
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=01, enabled=1
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x02
Node 0x06 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
  Control: name="HDMI/DP,pcm=7 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=1, device=0
  Control: name="IEC958 Playback Pro Mask", index=1, device=0
  Control: name="IEC958 Playback Default", index=1, device=0
  Control: name="IEC958 Playback Switch", index=1, device=0
  Control: name="ELD", index=0, device=7
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x09000094: OUT Detect HBR HDMI DP
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=02, enabled=1
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x03
Node 0x07 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
  Control: name="HDMI/DP,pcm=8 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=2, device=0
  Control: name="IEC958 Playback Pro Mask", index=2, device=0
  Control: name="IEC958 Playback Default", index=2, device=0
  Control: name="IEC958 Playback Switch", index=2, device=0
  Control: name="ELD", index=0, device=8
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x09000094: OUT Detect HBR HDMI DP
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=03, enabled=1
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x04
Node 0x08 [Vendor Defined Widget] wcaps 0xf00000: Mono
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116,  2 Mar  9 17:36 /dev/snd/controlC0
crw-rw----+ 1 root audio 116,  8 Mar  9 17:36 /dev/snd/hwC0D0
crw-rw----+ 1 root audio 116,  9 Mar  9 17:36 /dev/snd/hwC0D3
crw-rw----+ 1 root audio 116,  4 Mar 11 19:45 /dev/snd/pcmC0D0c
crw-rw----+ 1 root audio 116,  3 Mar 11 18:22 /dev/snd/pcmC0D0p
crw-rw----+ 1 root audio 116,  5 Mar  9 17:36 /dev/snd/pcmC0D3p
crw-rw----+ 1 root audio 116,  6 Mar  9 17:36 /dev/snd/pcmC0D7p
crw-rw----+ 1 root audio 116,  7 Mar  9 17:36 /dev/snd/pcmC0D8p
crw-rw----+ 1 root audio 116,  1 Mar  9 17:36 /dev/snd/seq
crw-rw----+ 1 root audio 116, 33 Mar  9 17:36 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  60 Mar  9 17:36 .
drwxr-xr-x 3 root root 260 Mar  9 17:36 ..
lrwxrwxrwx 1 root root  12 Mar  9 17:36 pci-0000:00:1b.0 -> ../controlC0


!!ALSA configuration files
!!------------------------

!!User specific config file (~/.asoundrc)

pcm.swapped {
    type route
    slave {
        pcm "cards.pcm.default"
        channels 2
    }
    ttable.0.1 1.0
    ttable.1.1 1.0
}


!!Aplay/Arecord output
!!--------------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: PCH [HDA Intel PCH], device 0: CS4206 Analog [CS4206 Analog]
  Subdevices: 0/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 7: HDMI 1 [HDMI 1]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 8: HDMI 2 [HDMI 2]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: PCH [HDA Intel PCH], device 0: CS4206 Analog [CS4206 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [PCH]

Card hw:0 'PCH'/'HDA Intel PCH at 0xa0610000 irq 34'
  Mixer name	: 'Intel PantherPoint HDMI'
  Components	: 'HDA:10134206,106b5600,00100302 HDA:80862806,80860101,00100000'
  Controls      : 38
  Simple ctrls  : 11
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 127
  Mono: Playback 80 [63%] [-23.50dB] [on]
Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 127
  Mono:
  Front Left: Playback 127 [100%] [6.00dB] [on]
  Front Right: Playback 127 [100%] [6.00dB] [on]
Simple mixer control 'Speaker',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 127
  Mono:
  Front Left: Playback 119 [94%] [2.00dB] [on]
  Front Right: Playback 119 [94%] [2.00dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 255 [100%] [0.00dB]
  Front Right: Playback 255 [100%] [0.00dB]
Simple mixer control 'Mic Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 1 [33%] [10.00dB]
  Front Right: 1 [33%] [10.00dB]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'IEC958',1
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958',2
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 63
  Front Left: Capture 63 [100%] [12.00dB] [on]
  Front Right: Capture 63 [100%] [12.00dB] [on]
Simple mixer control 'Auto-Mute Mode',0
  Capabilities: enum
  Items: 'Disabled' 'Enabled'
  Item0: 'Enabled'
Simple mixer control 'Digital',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 120
  Front Left: Capture 120 [100%] [30.00dB]
  Front Right: Capture 120 [100%] [30.00dB]


!!Alsactl output
!!--------------

--startcollapse--
state.PCH {
	control.1 {
		iface MIXER
		name 'Headphone Playback Volume'
		value.0 127
		value.1 127
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 127'
			dbmin -5750
			dbmax 600
			dbvalue.0 600
			dbvalue.1 600
		}
	}
	control.2 {
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
	control.3 {
		iface MIXER
		name 'Speaker Playback Volume'
		value.0 119
		value.1 119
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 127'
			dbmin -5750
			dbmax 600
			dbvalue.0 200
			dbvalue.1 200
		}
	}
	control.4 {
		iface MIXER
		name 'Speaker Playback Switch'
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
	control.6 {
		iface MIXER
		name 'Capture Volume'
		value.0 63
		value.1 63
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 63'
			dbmin -5100
			dbmax 1200
			dbvalue.0 1200
			dbvalue.1 1200
		}
	}
	control.7 {
		iface MIXER
		name 'Capture Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.8 {
		iface MIXER
		name 'Mic Boost Volume'
		value.0 1
		value.1 1
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 3'
			dbmin 0
			dbmax 3000
			dbvalue.0 1000
			dbvalue.1 1000
		}
	}
	control.9 {
		iface MIXER
		name 'Master Playback Volume'
		value 80
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 127'
			dbmin -6350
			dbmax 0
			dbvalue.0 -2350
		}
	}
	control.10 {
		iface MIXER
		name 'Master Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.11 {
		iface CARD
		name 'Mic Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.12 {
		iface CARD
		name 'Headphone Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.13 {
		iface CARD
		name 'Speaker Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.14 {
		iface PCM
		name 'Playback Channel Map'
		value.0 3
		value.1 4
		comment {
			access read
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
	control.15 {
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
	control.16 {
		iface CARD
		name 'HDMI/DP,pcm=3 Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.17 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.18 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.19 {
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.20 {
		iface MIXER
		name 'IEC958 Playback Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.21 {
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
	control.22 {
		iface CARD
		name 'HDMI/DP,pcm=7 Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.23 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		index 1
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.24 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		index 1
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.25 {
		iface MIXER
		name 'IEC958 Playback Default'
		index 1
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.26 {
		iface MIXER
		name 'IEC958 Playback Switch'
		index 1
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.27 {
		iface PCM
		device 7
		name ELD
		value ''
		comment {
			access 'read volatile'
			type BYTES
			count 0
		}
	}
	control.28 {
		iface CARD
		name 'HDMI/DP,pcm=8 Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.29 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		index 2
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.30 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		index 2
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.31 {
		iface MIXER
		name 'IEC958 Playback Default'
		index 2
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.32 {
		iface MIXER
		name 'IEC958 Playback Switch'
		index 2
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.33 {
		iface PCM
		device 8
		name ELD
		value ''
		comment {
			access 'read volatile'
			type BYTES
			count 0
		}
	}
	control.34 {
		iface PCM
		device 3
		name 'Playback Channel Map'
		value.0 0
		value.1 0
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		comment {
			access 'read write'
			type INTEGER
			count 8
			range '0 - 36'
		}
	}
	control.35 {
		iface PCM
		device 7
		name 'Playback Channel Map'
		value.0 0
		value.1 0
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		comment {
			access 'read write'
			type INTEGER
			count 8
			range '0 - 36'
		}
	}
	control.36 {
		iface PCM
		device 8
		name 'Playback Channel Map'
		value.0 0
		value.1 0
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		comment {
			access 'read write'
			type INTEGER
			count 8
			range '0 - 36'
		}
	}
	control.37 {
		iface MIXER
		name 'PCM Playback Volume'
		value.0 255
		value.1 255
		comment {
			access 'read write user'
			type INTEGER
			count 2
			range '0 - 255'
			tlv '0000000100000008ffffec1400000014'
			dbmin -5100
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.38 {
		iface MIXER
		name 'Digital Capture Volume'
		value.0 120
		value.1 120
		comment {
			access 'read write user'
			type INTEGER
			count 2
			range '0 - 120'
			tlv '0000000100000008fffff44800000032'
			dbmin -3000
			dbmax 3000
			dbvalue.0 3000
			dbvalue.1 3000
		}
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
bluetooth
wl
cfg80211
cpufreq_stats
msr
ecb
joydev
iTCO_wdt
iTCO_vendor_support
coretemp
intel_rapl
x86_pkg_temp_thermal
intel_powerclamp
kvm_intel
applesmc
led_class
input_polldev
hwmon
snd_hda_codec_hdmi
kvm
i915
snd_hda_codec_cirrus
snd_hda_codec_generic
snd_hda_intel
evdev
snd_hda_controller
mousedev
mac_hid
drm_kms_helper
rfkill
thunderbolt
pcspkr
i2c_i801
snd_hda_codec
drm
snd_hwdep
sbs
snd_pcm
battery
sbshc
snd_timer
intel_gtt
mei_me
i2c_algo_bit
snd
i2c_core
video
ac
apple_bl
soundcore
mei
button
shpchp
lpc_ich
processor
sch_fq_codel
ext4
crc16
mbcache
jbd2
algif_skcipher
af_alg
nls_iso8859_1
hid_generic
hid_apple
usbhid
hid
uas
usb_storage
dm_crypt
dm_mod
sd_mod
crct10dif_pclmul
crc32_pclmul
crc32c_intel
ghash_clmulni_intel
aesni_intel
aes_x86_64
lrw
gf128mul
glue_helper
ablk_helper
cryptd
ahci
libahci
libata
scsi_mod
xhci_pci
ehci_pci
xhci_hcd
ehci_hcd
usbcore
usb_common
vfat
fat
nls_cp437


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x09 0x0e2b4030
0x0a 0x400000f0
0x0b 0x90100120
0x0c 0x400000f0
0x0d 0x90a00110
0x0e 0x400000f0
0x0f 0x400000f0
0x10 0x400000f0
0x12 0x400000f0
0x15 0x400000f0

/sys/class/sound/hwC0D0/driver_pin_configs:

/sys/class/sound/hwC0D0/user_pin_configs:

/sys/class/sound/hwC0D0/init_verbs:

/sys/class/sound/hwC0D0/hints:

/sys/class/sound/hwC0D3/init_pin_configs:
0x05 0x18560010
0x06 0x18560010
0x07 0x18560010

/sys/class/sound/hwC0D3/driver_pin_configs:

/sys/class/sound/hwC0D3/user_pin_configs:

/sys/class/sound/hwC0D3/init_verbs:

/sys/class/sound/hwC0D3/hints:


!!ALSA/HDA dmesg
!!--------------

[ 1393.780109] pciehp 0000:04:00.0:pcie24: Timeout on hotplug command 0x1038 (issued 30183 msec ago)
[ 1393.780303] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[ 1393.783649] sd 0:0:0:0: [sda] Starting disk
--
[ 1431.463975] wl_resume: PCI Resume handler
[ 1431.464557] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[ 1431.466052] pciehp 0000:04:00.0:pcie24: Timeout on hotplug command 0x1038 (issued 37670 msec ago)
--
[ 1461.567865] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[ 1461.568439] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[ 1461.569468] wl_resume: PCI Resume handler
--
[ 1491.846401] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[ 1491.846682] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[ 1491.846789] wl_resume: PCI Resume handler
--
[ 1522.149949] sd 0:0:0:0: [sda] Starting disk
[ 1522.163262] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[ 1522.227872] thunderbolt 0000:05:00.0: resetting error on 0:b.
--
[ 2765.016828] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[ 2765.017185] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[ 2765.017859] wl_resume: PCI Resume handler
--
[ 5787.715068] sd 0:0:0:0: [sda] Starting disk
[ 5787.757774] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[ 5787.796921] thunderbolt 0000:05:00.0: resetting error on 0:b.
--
[ 5817.880839] wl_resume: PCI Resume handler
[ 5817.881779] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[ 5817.882310] sd 0:0:0:0: [sda] Starting disk
--
[ 5848.129236] wl_resume: PCI Resume handler
[ 5848.129437] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[ 5848.132494] pciehp 0000:04:03.0:pcie24: Timeout on hotplug command 0x1038 (issued 30226 msec ago)
--
[ 5900.394162] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[ 5900.394443] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[ 5900.394565] wl_resume: PCI Resume handler
--
[ 5937.589195] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[ 5937.589444] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[ 5937.589450] wl_resume: PCI Resume handler
--
[ 5967.718117] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[ 5967.718520] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[ 5967.721194] wl_resume: PCI Resume handler
--
[ 6589.429158] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[ 6589.429428] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[ 6589.429501] wl_resume: PCI Resume handler
--
[ 7749.136571] wl_resume: PCI Resume handler
[ 7749.136860] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[ 7749.139454] pciehp 0000:04:06.0:pcie24: Timeout on hotplug command 0x1038 (issued 1159290 msec ago)
--
[ 7778.860951] sd 0:0:0:0: [sda] Starting disk
[ 7778.867743] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[ 7778.946330] thunderbolt 0000:05:00.0: resetting error on 0:b.
--
[10247.039758] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[10247.040149] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[10247.046059] wl_resume: PCI Resume handler
--
[10401.586065] pciehp 0000:04:00.0:pcie24: Timeout on hotplug command 0x1038 (issued 154450 msec ago)
[10401.586304] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[10401.589389] pciehp 0000:04:04.0:pcie24: Timeout on hotplug command 0x1038 (issued 154453 msec ago)
--
[12765.711223] wl_resume: PCI Resume handler
[12765.714439] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[12765.717613] pciehp 0000:04:05.0:pcie24: Timeout on hotplug command 0x1038 (issued 2363153 msec ago)
--
[13916.017893] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[13916.018020] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[13916.018109] wl_resume: PCI Resume handler
--
[14770.967985] wl_resume: PCI Resume handler
[14770.968223] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[14770.971062] pciehp 0000:04:03.0:pcie24: Timeout on hotplug command 0x1038 (issued 854470 msec ago)
--
[14801.854573] wl_resume: PCI Resume handler
[14801.854716] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[14801.857217] pciehp 0000:04:00.0:pcie24: Timeout on hotplug command 0x1038 (issued 30866 msec ago)
--
[16699.443313] WARNING: CPU: 1 PID: 329 at net/wireless/sme.c:791 cfg80211_roamed+0x91/0xa0 [cfg80211]()
[16699.443315] Modules linked in: msr wl(PO) ecb joydev iTCO_wdt iTCO_vendor_support coretemp intel_rapl x86_pkg_temp_thermal intel_powerclamp kvm_intel applesmc led_class input_polldev hwmon snd_hda_codec_hdmi kvm i915 snd_hda_codec_cirrus snd_hda_codec_generic snd_hda_intel bcm5974 cfg80211 evdev snd_hda_controller mousedev mac_hid drm_kms_helper rfkill thunderbolt pcspkr i2c_i801 snd_hda_codec drm snd_hwdep sbs snd_pcm battery sbshc snd_timer intel_gtt mei_me i2c_algo_bit snd i2c_core video ac apple_bl soundcore mei button shpchp lpc_ich processor sch_fq_codel ext4 crc16 mbcache jbd2 algif_skcipher af_alg nls_iso8859_1 hid_generic hid_apple usbhid hid uas usb_storage dm_crypt dm_mod sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul
  glue_helper
[16699.443374]  ablk_helper cryptd ahci libahci libata scsi_mod xhci_pci ehci_pci xhci_hcd ehci_hcd usbcore usb_common vfat fat nls_cp437 [last unloaded: bluetooth]
--
[17953.934198] WARNING: CPU: 1 PID: 329 at net/wireless/sme.c:791 cfg80211_roamed+0x91/0xa0 [cfg80211]()
[17953.934202] Modules linked in: msr wl(PO) ecb joydev iTCO_wdt iTCO_vendor_support coretemp intel_rapl x86_pkg_temp_thermal intel_powerclamp kvm_intel applesmc led_class input_polldev hwmon snd_hda_codec_hdmi kvm i915 snd_hda_codec_cirrus snd_hda_codec_generic snd_hda_intel bcm5974 cfg80211 evdev snd_hda_controller mousedev mac_hid drm_kms_helper rfkill thunderbolt pcspkr i2c_i801 snd_hda_codec drm snd_hwdep sbs snd_pcm battery sbshc snd_timer intel_gtt mei_me i2c_algo_bit snd i2c_core video ac apple_bl soundcore mei button shpchp lpc_ich processor sch_fq_codel ext4 crc16 mbcache jbd2 algif_skcipher af_alg nls_iso8859_1 hid_generic hid_apple usbhid hid uas usb_storage dm_crypt dm_mod sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul
  glue_helper
[17953.934301]  ablk_helper cryptd ahci libahci libata scsi_mod xhci_pci ehci_pci xhci_hcd ehci_hcd usbcore usb_common vfat fat nls_cp437 [last unloaded: bluetooth]
--
[19280.877417] wl_resume: PCI Resume handler
[19280.877545] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[19280.880907] pciehp 0000:04:05.0:pcie24: Timeout on hotplug command 0x1038 (issued 4476560 msec ago)
--
[19871.524657] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[19871.525029] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[19871.525444] wl_resume: PCI Resume handler
--
[23942.064207] WARNING: CPU: 0 PID: 329 at net/wireless/sme.c:791 cfg80211_roamed+0x91/0xa0 [cfg80211]()
[23942.064209] Modules linked in: bluetooth videodev media msr wl(PO) ecb joydev iTCO_wdt iTCO_vendor_support coretemp intel_rapl x86_pkg_temp_thermal intel_powerclamp kvm_intel applesmc led_class input_polldev hwmon snd_hda_codec_hdmi kvm i915 snd_hda_codec_cirrus snd_hda_codec_generic snd_hda_intel bcm5974 cfg80211 evdev snd_hda_controller mousedev mac_hid drm_kms_helper rfkill thunderbolt pcspkr i2c_i801 snd_hda_codec drm snd_hwdep sbs snd_pcm battery sbshc snd_timer intel_gtt mei_me i2c_algo_bit snd i2c_core video ac apple_bl soundcore mei button shpchp lpc_ich processor sch_fq_codel ext4 crc16 mbcache jbd2 algif_skcipher af_alg nls_iso8859_1 hid_generic hid_apple usbhid hid uas usb_storage dm_crypt dm_mod sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_inte
 l aes_x86_64
[23942.064262]  lrw gf128mul glue_helper ablk_helper cryptd ahci libahci libata scsi_mod xhci_pci ehci_pci xhci_hcd ehci_hcd usbcore usb_common vfat fat nls_cp437 [last unloaded: bluetooth]
--
[24219.883163] WARNING: CPU: 0 PID: 329 at net/wireless/sme.c:791 cfg80211_roamed+0x91/0xa0 [cfg80211]()
[24219.883164] Modules linked in: bluetooth videodev media msr wl(PO) ecb joydev iTCO_wdt iTCO_vendor_support coretemp intel_rapl x86_pkg_temp_thermal intel_powerclamp kvm_intel applesmc led_class input_polldev hwmon snd_hda_codec_hdmi kvm i915 snd_hda_codec_cirrus snd_hda_codec_generic snd_hda_intel bcm5974 cfg80211 evdev snd_hda_controller mousedev mac_hid drm_kms_helper rfkill thunderbolt pcspkr i2c_i801 snd_hda_codec drm snd_hwdep sbs snd_pcm battery sbshc snd_timer intel_gtt mei_me i2c_algo_bit snd i2c_core video ac apple_bl soundcore mei button shpchp lpc_ich processor sch_fq_codel ext4 crc16 mbcache jbd2 algif_skcipher af_alg nls_iso8859_1 hid_generic hid_apple usbhid hid uas usb_storage dm_crypt dm_mod sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_inte
 l aes_x86_64
[24219.883199]  lrw gf128mul glue_helper ablk_helper cryptd ahci libahci libata scsi_mod xhci_pci ehci_pci xhci_hcd ehci_hcd usbcore usb_common vfat fat nls_cp437 [last unloaded: bluetooth]
--
[24306.240631] sd 0:0:0:0: [sda] Starting disk
[24306.260550] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[24306.310276] bcm5974: bad trackpad package, length: 8
--
[25215.382207] WARNING: CPU: 0 PID: 329 at net/wireless/sme.c:791 cfg80211_roamed+0x91/0xa0 [cfg80211]()
[25215.382209] Modules linked in: msr wl(PO) ecb joydev iTCO_wdt iTCO_vendor_support coretemp intel_rapl x86_pkg_temp_thermal intel_powerclamp kvm_intel applesmc led_class input_polldev hwmon snd_hda_codec_hdmi kvm i915 snd_hda_codec_cirrus snd_hda_codec_generic snd_hda_intel bcm5974 cfg80211 evdev snd_hda_controller mousedev mac_hid drm_kms_helper rfkill thunderbolt pcspkr i2c_i801 snd_hda_codec drm snd_hwdep sbs snd_pcm battery sbshc snd_timer intel_gtt mei_me i2c_algo_bit snd i2c_core video ac apple_bl soundcore mei button shpchp lpc_ich processor sch_fq_codel ext4 crc16 mbcache jbd2 algif_skcipher af_alg nls_iso8859_1 hid_generic hid_apple usbhid hid uas usb_storage dm_crypt dm_mod sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul
  glue_helper
[25215.382246]  ablk_helper cryptd ahci libahci libata scsi_mod xhci_pci ehci_pci xhci_hcd ehci_hcd usbcore usb_common vfat fat nls_cp437 [last unloaded: bluetooth]
--
[25309.744408] WARNING: CPU: 1 PID: 329 at net/wireless/sme.c:791 cfg80211_roamed+0x91/0xa0 [cfg80211]()
[25309.744411] Modules linked in: msr wl(PO) ecb joydev iTCO_wdt iTCO_vendor_support coretemp intel_rapl x86_pkg_temp_thermal intel_powerclamp kvm_intel applesmc led_class input_polldev hwmon snd_hda_codec_hdmi kvm i915 snd_hda_codec_cirrus snd_hda_codec_generic snd_hda_intel bcm5974 cfg80211 evdev snd_hda_controller mousedev mac_hid drm_kms_helper rfkill thunderbolt pcspkr i2c_i801 snd_hda_codec drm snd_hwdep sbs snd_pcm battery sbshc snd_timer intel_gtt mei_me i2c_algo_bit snd i2c_core video ac apple_bl soundcore mei button shpchp lpc_ich processor sch_fq_codel ext4 crc16 mbcache jbd2 algif_skcipher af_alg nls_iso8859_1 hid_generic hid_apple usbhid hid uas usb_storage dm_crypt dm_mod sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul
  glue_helper
[25309.744492]  ablk_helper cryptd ahci libahci libata scsi_mod xhci_pci ehci_pci xhci_hcd ehci_hcd usbcore usb_common vfat fat nls_cp437 [last unloaded: bluetooth]
--
[27330.509876] wl_resume: PCI Resume handler
[27330.510229] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[27330.512404] pciehp 0000:04:00.0:pcie24: Timeout on hotplug command 0x1038 (issued 3022960 msec ago)
--
[27657.899383] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[27657.899846] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[27657.900732] wl_resume: PCI Resume handler
--
[27658.246122] ata1.00: configured for UDMA/133
[27658.924364] sound hdaudioC0D3: HDMI: invalid ELD data byte 0
[27658.925883] PM: resume of devices complete after 1026.202 msecs
--
[27658.944649] video LNXVIDEO:00: Restoring backlight state
[27659.224453] sound hdaudioC0D3: HDMI: invalid ELD data byte 0
[27659.524644] sound hdaudioC0D3: HDMI: invalid ELD data byte 0
[27659.824755] sound hdaudioC0D3: HDMI: invalid ELD data byte 0
[27660.124905] sound hdaudioC0D3: HDMI: invalid ELD data byte 0
[27660.424985] sound hdaudioC0D3: HDMI: invalid ELD data byte 0
[27660.725150] sound hdaudioC0D3: HDMI: invalid ELD data byte 0
[27661.025198] sound hdaudioC0D3: HDMI: invalid ELD data byte 0
[27661.325413] sound hdaudioC0D3: HDMI: invalid ELD data byte 0
[27662.406074] wl0: link up (wlp2s0)
--
[28200.883590] wl_resume: PCI Resume handler
[28200.883990] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[28200.886693] pciehp 0000:04:00.0:pcie24: Timeout on hotplug command 0x1038 (issued 542730 msec ago)
--
[28314.534439] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[28314.534707] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[28314.534765] wl_resume: PCI Resume handler
--
[28673.591664] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[28673.591971] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[28673.592141] wl_resume: PCI Resume handler
--
[28804.730000] sd 0:0:0:0: [sda] Starting disk
[28804.771017] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[28804.811247] thunderbolt 0000:05:00.0: resetting error on 0:b.
--
[29019.310637] wl_resume: PCI Resume handler
[29019.310917] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[29019.312270] pciehp 0000:04:04.0:pcie24: Timeout on hotplug command 0x1038 (issued 214490 msec ago)
--
[29210.547795] pciehp 0000:04:05.0:pcie24: Timeout on hotplug command 0x1038 (issued 191143 msec ago)
[29210.547936] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[29210.552317] sd 0:0:0:0: [sda] Starting disk
--
[29721.088166] pciehp 0000:04:04.0:pcie24: Timeout on hotplug command 0x1038 (issued 510306 msec ago)
[29721.088400] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[29721.093897] sd 0:0:0:0: [sda] Starting disk
--
[30540.528405] wl_resume: PCI Resume handler
[30540.528549] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[30540.531924] pciehp 0000:04:00.0:pcie24: Timeout on hotplug command 0x1038 (issued 819070 msec ago)
--
[31724.155563] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[31724.155891] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[31724.157702] wl_resume: PCI Resume handler
--
[33575.548401] wl_resume: PCI Resume handler
[33575.548591] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[33575.551329] pciehp 0000:04:00.0:pcie24: Timeout on hotplug command 0x1038 (issued 1850523 msec ago)
--
[33605.681004] pciehp 0000:04:00.0:pcie24: Timeout on hotplug command 0x1038 (issued 30113 msec ago)
[33605.727187] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[33605.727342] sd 0:0:0:0: [sda] Starting disk
--
[33829.704874] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[33829.707343] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[33829.710497] wl_resume: PCI Resume handler
--
[37142.587189] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[37142.587594] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[37142.590239] wl_resume: PCI Resume handler
--
[37171.948804] pciehp 0000:04:00.0:pcie24: Timeout on hotplug command 0x1038 (issued 29340 msec ago)
[37171.948955] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[37171.949011] pciehp 0000:04:03.0:pcie24: Timeout on hotplug command 0x1038 (issued 29340 msec ago)
--
[37202.208363] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[37202.208720] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[37202.211228] wl_resume: PCI Resume handler
--
[37544.801736] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[37544.802119] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[37544.805270] wl_resume: PCI Resume handler
--
[41138.905836] wl_resume: PCI Resume handler
[41138.905923] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[41138.908655] pciehp 0000:04:05.0:pcie24: Timeout on hotplug command 0x1038 (issued 3592356 msec ago)
--
[41169.402025] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[41169.402314] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[41169.402374] wl_resume: PCI Resume handler
--
[41169.747473] ata1.00: configured for UDMA/133
[41170.425480] sound hdaudioC0D0: hda-codec: out of range cmd 0:11:400:ffffffff
[41170.425846] PM: resume of devices complete after 1023.430 msecs
--
[42693.703287] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[42693.703770] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[42693.705654] wl_resume: PCI Resume handler
--
[42771.610474] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[42771.610758] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[42771.610901] wl_resume: PCI Resume handler
--
[42887.962183] wl_resume: PCI Resume handler
[42887.962365] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[42887.965171] pciehp 0000:04:06.0:pcie24: Timeout on hotplug command 0x1038 (issued 116290 msec ago)
--
[42901.228834] WARNING: CPU: 2 PID: 329 at net/wireless/sme.c:791 cfg80211_roamed+0x91/0xa0 [cfg80211]()
[42901.228836] Modules linked in: msr wl(PO) ecb joydev iTCO_wdt iTCO_vendor_support coretemp intel_rapl x86_pkg_temp_thermal intel_powerclamp kvm_intel applesmc led_class input_polldev hwmon snd_hda_codec_hdmi kvm i915 snd_hda_codec_cirrus snd_hda_codec_generic snd_hda_intel bcm5974 cfg80211 evdev snd_hda_controller mousedev mac_hid drm_kms_helper rfkill thunderbolt pcspkr i2c_i801 snd_hda_codec drm snd_hwdep sbs snd_pcm battery sbshc snd_timer intel_gtt mei_me i2c_algo_bit snd i2c_core video ac apple_bl soundcore mei button shpchp lpc_ich processor sch_fq_codel ext4 crc16 mbcache jbd2 algif_skcipher af_alg nls_iso8859_1 hid_generic hid_apple usbhid hid uas usb_storage dm_crypt dm_mod sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul
  glue_helper
[42901.228902]  ablk_helper cryptd ahci libahci libata scsi_mod xhci_pci ehci_pci xhci_hcd ehci_hcd usbcore usb_common vfat fat nls_cp437 [last unloaded: bluetooth]
--
[42918.023119] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[42918.023405] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[42918.023488] wl_resume: PCI Resume handler
--
[42983.110177] WARNING: CPU: 1 PID: 329 at net/wireless/sme.c:791 cfg80211_roamed+0x91/0xa0 [cfg80211]()
[42983.110178] Modules linked in: msr wl(PO) ecb joydev iTCO_wdt iTCO_vendor_support coretemp intel_rapl x86_pkg_temp_thermal intel_powerclamp kvm_intel applesmc led_class input_polldev hwmon snd_hda_codec_hdmi kvm i915 snd_hda_codec_cirrus snd_hda_codec_generic snd_hda_intel bcm5974 cfg80211 evdev snd_hda_controller mousedev mac_hid drm_kms_helper rfkill thunderbolt pcspkr i2c_i801 snd_hda_codec drm snd_hwdep sbs snd_pcm battery sbshc snd_timer intel_gtt mei_me i2c_algo_bit snd i2c_core video ac apple_bl soundcore mei button shpchp lpc_ich processor sch_fq_codel ext4 crc16 mbcache jbd2 algif_skcipher af_alg nls_iso8859_1 hid_generic hid_apple usbhid hid uas usb_storage dm_crypt dm_mod sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul
  glue_helper
[42983.110225]  ablk_helper cryptd ahci libahci libata scsi_mod xhci_pci ehci_pci xhci_hcd ehci_hcd usbcore usb_common vfat fat nls_cp437 [last unloaded: bluetooth]
--
[45608.665202] wl_resume: PCI Resume handler
[45608.665393] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[45608.668455] pciehp 0000:04:03.0:pcie24: Timeout on hotplug command 0x1038 (issued 2689353 msec ago)
--
[46279.336400] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[46279.336965] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[46279.337231] wl_resume: PCI Resume handler
--
[49183.766876] wl_resume: PCI Resume handler
[49183.767091] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[49183.770241] pciehp 0000:04:00.0:pcie24: Timeout on hotplug command 0x1038 (issued 2903046 msec ago)
--
[50084.503103] wl_resume: PCI Resume handler
[50084.503313] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[50084.503988] pciehp 0000:04:00.0:pcie24: Timeout on hotplug command 0x1038 (issued 900303 msec ago)
--
[51188.937840] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[51188.938109] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[51188.938840] sd 0:0:0:0: [sda] Starting disk
--
[55582.265169] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[55582.265581] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[55582.265847] wl_resume: PCI Resume handler
--
[56228.782000] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[56228.782405] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[56228.783317] wl_resume: PCI Resume handler
--
[56292.387615] NET: Unregistered protocol family 31
[56487.227921] snd_hda_intel 0000:00:1b.0: Unstable LPIB (131072 >= 8192); disabling LPIB delay counting
[56713.068171] wl0: link down (wlp2s0)




--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=before

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.64
!!################################

!!Script ran on: Wed Mar 11 18:44:36 UTC 2015


!!Linux Distribution
!!------------------

Arch Linux \r (\l) DISTRIB_ID=Arch DISTRIB_DESCRIPTION="Arch Linux" NAME="Arch Linux" ID=arch PRETTY_NAME="Arch Linux" HOME_URL="https://www.archlinux.org/" SUPPORT_URL="https://bbs.archlinux.org/" BUG_REPORT_URL="https://bugs.archlinux.org/"


!!DMI Information
!!---------------

Manufacturer:      Apple Inc.
Product Name:      MacBookAir5,2
Product Version:   1.0
Firmware Version:  MBA51.88Z.00EF.B02.1211271028


!!Kernel Information
!!------------------

Kernel release:    3.18.6-1-ARCH
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         unknown
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     k3.18.6-1-ARCH
Library version:    1.0.28
Utilities version:  1.0.28


!!Loaded ALSA modules
!!-------------------

snd_hda_intel


!!Sound Servers on this system
!!----------------------------

Jack:
      Installed - Yes (/usr/bin/jackd)
      Running - No


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [PCH            ]: HDA-Intel - HDA Intel PCH
                      HDA Intel PCH at 0xa0610000 irq 34


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation 7 Series/C210 Series Chipset Family High Definition Audio Controller (rev 04)


!!Advanced information - PCI Vendor/Device/Subsystem ID's
!!-------------------------------------------------------

00:1b.0 0403: 8086:1e20 (rev 04)
	Subsystem: 8086:7270


!!Loaded sound module options
!!---------------------------

!!Module: snd_hda_intel
	align_buffer_size : -1
	bdl_pos_adj : 1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	beep_mode : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	enable_msi : -1
	id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	jackpoll_ms : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	model : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	patch : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	position_fix : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	power_save : 1
	power_save_controller : Y
	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	probe_only : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	single_cmd : N
	snoop : Y


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Cirrus Logic CS4206
Address: 0
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x10134206
Subsystem Id: 0x106b5600
Revision Id: 0x100302
No Modem Function Group found
Default PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x3]: PCM FLOAT
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
  Power states:  D0 D3 CLKSTOP EPSS
  Power: setting=D0, actual=D0
GPIO: io=4, o=0, i=0, unsolicited=0, wake=0
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[1]: enable=1, dir=1, wake=0, sticky=0, data=0, unsol=0
  IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[3]: enable=1, dir=1, wake=0, sticky=0, data=1, unsol=0
Node 0x02 [Audio Output] wcaps 0xd041d: Stereo Amp-Out
  Control: name="Headphone Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Device: name="CS4206 Analog", type="Audio", device=0
  Amp-Out caps: ofs=0x73, nsteps=0x7f, stepsize=0x01, mute=1
  Amp-Out vals:  [0x50 0x50]
  Converter: stream=0, channel=0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x3]: PCM FLOAT
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x03 [Audio Output] wcaps 0xd041d: Stereo Amp-Out
  Amp-Out caps: ofs=0x73, nsteps=0x7f, stepsize=0x01, mute=1
  Amp-Out vals:  [0xf3 0xf3]
  Converter: stream=0, channel=0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x3]: PCM FLOAT
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x04 [Audio Output] wcaps 0xd041d: Stereo Amp-Out
  Control: name="Speaker Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Speaker Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x73, nsteps=0x7f, stepsize=0x01, mute=1
  Amp-Out vals:  [0x48 0x48]
  Converter: stream=0, channel=0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x3]: PCM FLOAT
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x05 [Audio Input] wcaps 0x18051b: Stereo Amp-In
  Amp-In caps: ofs=0x33, nsteps=0x3f, stepsize=0x03, mute=1
  Amp-In vals:  [0xb3 0xb3] [0xb3 0xb3]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x1f5]: 8000 16000 32000 44100 48000 88200 96000
    bits [0x1e]: 16 20 24 32
    formats [0x3]: PCM FLOAT
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 8 samples
  Connection: 2
     0x0c* 0x12
Node 0x06 [Audio Input] wcaps 0x18051b: Stereo Amp-In
  Control: name="Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Capture Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Device: name="CS4206 Analog", type="Audio", device=0
  Amp-In caps: ofs=0x33, nsteps=0x3f, stepsize=0x03, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Converter: stream=4, channel=0
  SDI-Select: 0
  PCM:
    rates [0x1f5]: 8000 16000 32000 44100 48000 88200 96000
    bits [0x1e]: 16 20 24 32
    formats [0x3]: PCM FLOAT
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 8 samples
  Connection: 2
     0x0d* 0x0e
Node 0x07 [Audio Input] wcaps 0x180791: Stereo Digital
  Converter: stream=0, channel=0
  SDI-Select: 0
  Digital: Preemphasis Non-Copyright
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x570]: 32000 44100 48000 96000 192000
    bits [0x1e]: 16 20 24 32
    formats [0x7]: PCM FLOAT AC3
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 8 samples
  Connection: 1
     0x0f
Node 0x08 [Audio Output] wcaps 0x40611: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x7]: PCM FLOAT AC3
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 4 samples
Node 0x09 [Pin Complex] wcaps 0x410581: Stereo
  Control: name="Headphone Jack", index=0, device=0
  Pincap 0x0000001c: OUT HP Detect
  Pin Default 0x022140f0: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=01, enabled=1
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 1 samples
  Connection: 1
     0x02
Node 0x0a [Pin Complex] wcaps 0x410581: Stereo
  Pincap 0x00000054: OUT Detect Balanced
  Pin Default 0x010140f0: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Green
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 1 samples
  Connection: 1
     0x03
Node 0x0b [Pin Complex] wcaps 0x410101: Stereo
  Control: name="Speaker Phantom Jack", index=0, device=0
  Pincap 0x00000050: OUT Balanced
  Pin Default 0x901700f0: [Fixed] Speaker at Int N/A
    Conn = Analog, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Delay: 1 samples
  Connection: 1
     0x04
Node 0x0c [Pin Complex] wcaps 0x41048b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000024: IN Detect
  Pin Default 0x01813051: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Blue
    DefAssociation = 0x5, Sequence = 0x1
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 1 samples
Node 0x0d [Pin Complex] wcaps 0x41048b: Stereo Amp-In
  Control: name="Mic Boost Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Mic Phantom Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x01 0x01]
  Pincap 0x00001764: IN Detect Balanced
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x01a19031: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Pink
    DefAssociation = 0x3, Sequence = 0x1
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 1 samples
Node 0x0e [Pin Complex] wcaps 0x41000b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x02, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000020: IN
  Pin Default 0xb7d6003e: [Fixed] Digital In at Oth Mobile-In
    Conn = Digital, Color = Unknown
    DefAssociation = 0x3, Sequence = 0xe
  Pin-ctls: 0x00:
  Delay: 1 samples
Node 0x0f [Pin Complex] wcaps 0x410681: Stereo Digital
  Pincap 0x00000024: IN Detect
  Pin Default 0x02c4e0f0: [Jack] SPDIF In at Ext Front
    Conn = RCA, Color = White
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 1 samples
Node 0x10 [Pin Complex] wcaps 0x410301: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x014460f0: [Jack] SPDIF Out at Ext Rear
    Conn = RCA, Color = Orange
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Delay: 1 samples
  Connection: 1
     0x08
Node 0x11 [Vendor Defined Widget] wcaps 0xf00040: Mono
  Processing caps: benign=0, ncoeff=22
Node 0x12 [Pin Complex] wcaps 0x41000b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x02, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000020: IN
  Pin Default 0xb7d6005e: [Fixed] Digital In at Oth Mobile-In
    Conn = Digital, Color = Unknown
    DefAssociation = 0x5, Sequence = 0xe
  Pin-ctls: 0x00:
  Delay: 1 samples
Node 0x13 [Beep Generator Widget] wcaps 0x700000: Mono
Node 0x14 [Audio Output] wcaps 0x40611: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x7]: PCM FLOAT AC3
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 4 samples
Node 0x15 [Pin Complex] wcaps 0x410301: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x014510f0: [Jack] SPDIF Out at Ext Rear
    Conn = Optical, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Delay: 1 samples
  Connection: 1
     0x14
Codec: Intel PantherPoint HDMI
Address: 3
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x80862806
Subsystem Id: 0x80860101
Revision Id: 0x100000
No Modem Function Group found
Default PCM:
    rates [0x0]:
    bits [0x0]:
    formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
  Power states:  D0 D3 CLKSTOP EPSS
  Power: setting=D0, actual=D0, Clock-stop-OK
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x02 [Audio Output] wcaps 0x6611: 8-Channels Digital
  Converter: stream=0, channel=0
  Digital: Enabled
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x5]: PCM AC3
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x03 [Audio Output] wcaps 0x6611: 8-Channels Digital
  Converter: stream=0, channel=0
  Digital: Enabled
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x5]: PCM AC3
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x04 [Audio Output] wcaps 0x6611: 8-Channels Digital
  Converter: stream=0, channel=0
  Digital: Enabled
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x5]: PCM AC3
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x05 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
  Control: name="HDMI/DP,pcm=3 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=0, device=0
  Control: name="IEC958 Playback Pro Mask", index=0, device=0
  Control: name="IEC958 Playback Default", index=0, device=0
  Control: name="IEC958 Playback Switch", index=0, device=0
  Control: name="ELD", index=0, device=3
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x09000094: OUT Detect HBR HDMI DP
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=01, enabled=1
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x02
Node 0x06 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
  Control: name="HDMI/DP,pcm=7 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=1, device=0
  Control: name="IEC958 Playback Pro Mask", index=1, device=0
  Control: name="IEC958 Playback Default", index=1, device=0
  Control: name="IEC958 Playback Switch", index=1, device=0
  Control: name="ELD", index=0, device=7
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x09000094: OUT Detect HBR HDMI DP
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=02, enabled=1
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x03
Node 0x07 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
  Control: name="HDMI/DP,pcm=8 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=2, device=0
  Control: name="IEC958 Playback Pro Mask", index=2, device=0
  Control: name="IEC958 Playback Default", index=2, device=0
  Control: name="IEC958 Playback Switch", index=2, device=0
  Control: name="ELD", index=0, device=8
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x09000094: OUT Detect HBR HDMI DP
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=03, enabled=1
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x04
Node 0x08 [Vendor Defined Widget] wcaps 0xf00000: Mono
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116,  2 Mar  9 17:36 /dev/snd/controlC0
crw-rw----+ 1 root audio 116,  8 Mar  9 17:36 /dev/snd/hwC0D0
crw-rw----+ 1 root audio 116,  9 Mar  9 17:36 /dev/snd/hwC0D3
crw-rw----+ 1 root audio 116,  4 Mar 11 19:44 /dev/snd/pcmC0D0c
crw-rw----+ 1 root audio 116,  3 Mar 11 18:22 /dev/snd/pcmC0D0p
crw-rw----+ 1 root audio 116,  5 Mar  9 17:36 /dev/snd/pcmC0D3p
crw-rw----+ 1 root audio 116,  6 Mar  9 17:36 /dev/snd/pcmC0D7p
crw-rw----+ 1 root audio 116,  7 Mar  9 17:36 /dev/snd/pcmC0D8p
crw-rw----+ 1 root audio 116,  1 Mar  9 17:36 /dev/snd/seq
crw-rw----+ 1 root audio 116, 33 Mar  9 17:36 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  60 Mar  9 17:36 .
drwxr-xr-x 3 root root 260 Mar  9 17:36 ..
lrwxrwxrwx 1 root root  12 Mar  9 17:36 pci-0000:00:1b.0 -> ../controlC0


!!ALSA configuration files
!!------------------------

!!User specific config file (~/.asoundrc)

pcm.swapped {
    type route
    slave {
        pcm "cards.pcm.default"
        channels 2
    }
    ttable.0.1 1.0
    ttable.1.1 1.0
}


!!Aplay/Arecord output
!!--------------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: PCH [HDA Intel PCH], device 0: CS4206 Analog [CS4206 Analog]
  Subdevices: 0/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 7: HDMI 1 [HDMI 1]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 8: HDMI 2 [HDMI 2]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: PCH [HDA Intel PCH], device 0: CS4206 Analog [CS4206 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [PCH]

Card hw:0 'PCH'/'HDA Intel PCH at 0xa0610000 irq 34'
  Mixer name	: 'Intel PantherPoint HDMI'
  Components	: 'HDA:10134206,106b5600,00100302 HDA:80862806,80860101,00100000'
  Controls      : 38
  Simple ctrls  : 11
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 127
  Mono: Playback 80 [63%] [-23.50dB] [on]
Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 127
  Mono:
  Front Left: Playback 127 [100%] [6.00dB] [on]
  Front Right: Playback 127 [100%] [6.00dB] [on]
Simple mixer control 'Speaker',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 127
  Mono:
  Front Left: Playback 119 [94%] [2.00dB] [on]
  Front Right: Playback 119 [94%] [2.00dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 255 [100%] [0.00dB]
  Front Right: Playback 255 [100%] [0.00dB]
Simple mixer control 'Mic Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 1 [33%] [10.00dB]
  Front Right: 1 [33%] [10.00dB]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'IEC958',1
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958',2
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 63
  Front Left: Capture 63 [100%] [12.00dB] [on]
  Front Right: Capture 63 [100%] [12.00dB] [on]
Simple mixer control 'Auto-Mute Mode',0
  Capabilities: enum
  Items: 'Disabled' 'Enabled'
  Item0: 'Enabled'
Simple mixer control 'Digital',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 120
  Front Left: Capture 120 [100%] [30.00dB]
  Front Right: Capture 120 [100%] [30.00dB]


!!Alsactl output
!!--------------

--startcollapse--
state.PCH {
	control.1 {
		iface MIXER
		name 'Headphone Playback Volume'
		value.0 127
		value.1 127
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 127'
			dbmin -5750
			dbmax 600
			dbvalue.0 600
			dbvalue.1 600
		}
	}
	control.2 {
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
	control.3 {
		iface MIXER
		name 'Speaker Playback Volume'
		value.0 119
		value.1 119
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 127'
			dbmin -5750
			dbmax 600
			dbvalue.0 200
			dbvalue.1 200
		}
	}
	control.4 {
		iface MIXER
		name 'Speaker Playback Switch'
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
	control.6 {
		iface MIXER
		name 'Capture Volume'
		value.0 63
		value.1 63
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 63'
			dbmin -5100
			dbmax 1200
			dbvalue.0 1200
			dbvalue.1 1200
		}
	}
	control.7 {
		iface MIXER
		name 'Capture Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.8 {
		iface MIXER
		name 'Mic Boost Volume'
		value.0 1
		value.1 1
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 3'
			dbmin 0
			dbmax 3000
			dbvalue.0 1000
			dbvalue.1 1000
		}
	}
	control.9 {
		iface MIXER
		name 'Master Playback Volume'
		value 80
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 127'
			dbmin -6350
			dbmax 0
			dbvalue.0 -2350
		}
	}
	control.10 {
		iface MIXER
		name 'Master Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.11 {
		iface CARD
		name 'Mic Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.12 {
		iface CARD
		name 'Headphone Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.13 {
		iface CARD
		name 'Speaker Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.14 {
		iface PCM
		name 'Playback Channel Map'
		value.0 3
		value.1 4
		comment {
			access read
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
	control.15 {
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
	control.16 {
		iface CARD
		name 'HDMI/DP,pcm=3 Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.17 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.18 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.19 {
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.20 {
		iface MIXER
		name 'IEC958 Playback Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.21 {
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
	control.22 {
		iface CARD
		name 'HDMI/DP,pcm=7 Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.23 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		index 1
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.24 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		index 1
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.25 {
		iface MIXER
		name 'IEC958 Playback Default'
		index 1
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.26 {
		iface MIXER
		name 'IEC958 Playback Switch'
		index 1
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.27 {
		iface PCM
		device 7
		name ELD
		value ''
		comment {
			access 'read volatile'
			type BYTES
			count 0
		}
	}
	control.28 {
		iface CARD
		name 'HDMI/DP,pcm=8 Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.29 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		index 2
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.30 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		index 2
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.31 {
		iface MIXER
		name 'IEC958 Playback Default'
		index 2
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.32 {
		iface MIXER
		name 'IEC958 Playback Switch'
		index 2
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.33 {
		iface PCM
		device 8
		name ELD
		value ''
		comment {
			access 'read volatile'
			type BYTES
			count 0
		}
	}
	control.34 {
		iface PCM
		device 3
		name 'Playback Channel Map'
		value.0 0
		value.1 0
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		comment {
			access 'read write'
			type INTEGER
			count 8
			range '0 - 36'
		}
	}
	control.35 {
		iface PCM
		device 7
		name 'Playback Channel Map'
		value.0 0
		value.1 0
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		comment {
			access 'read write'
			type INTEGER
			count 8
			range '0 - 36'
		}
	}
	control.36 {
		iface PCM
		device 8
		name 'Playback Channel Map'
		value.0 0
		value.1 0
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		comment {
			access 'read write'
			type INTEGER
			count 8
			range '0 - 36'
		}
	}
	control.37 {
		iface MIXER
		name 'PCM Playback Volume'
		value.0 255
		value.1 255
		comment {
			access 'read write user'
			type INTEGER
			count 2
			range '0 - 255'
			tlv '0000000100000008ffffec1400000014'
			dbmin -5100
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.38 {
		iface MIXER
		name 'Digital Capture Volume'
		value.0 120
		value.1 120
		comment {
			access 'read write user'
			type INTEGER
			count 2
			range '0 - 120'
			tlv '0000000100000008fffff44800000032'
			dbmin -3000
			dbmax 3000
			dbvalue.0 3000
			dbvalue.1 3000
		}
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
bluetooth
wl
cfg80211
cpufreq_stats
msr
ecb
joydev
iTCO_wdt
iTCO_vendor_support
coretemp
intel_rapl
x86_pkg_temp_thermal
intel_powerclamp
kvm_intel
applesmc
led_class
input_polldev
hwmon
snd_hda_codec_hdmi
kvm
i915
snd_hda_codec_cirrus
snd_hda_codec_generic
snd_hda_intel
evdev
snd_hda_controller
mousedev
mac_hid
drm_kms_helper
rfkill
thunderbolt
pcspkr
i2c_i801
snd_hda_codec
drm
snd_hwdep
sbs
snd_pcm
battery
sbshc
snd_timer
intel_gtt
mei_me
i2c_algo_bit
snd
i2c_core
video
ac
apple_bl
soundcore
mei
button
shpchp
lpc_ich
processor
sch_fq_codel
ext4
crc16
mbcache
jbd2
algif_skcipher
af_alg
nls_iso8859_1
hid_generic
hid_apple
usbhid
hid
uas
usb_storage
dm_crypt
dm_mod
sd_mod
crct10dif_pclmul
crc32_pclmul
crc32c_intel
ghash_clmulni_intel
aesni_intel
aes_x86_64
lrw
gf128mul
glue_helper
ablk_helper
cryptd
ahci
libahci
libata
scsi_mod
xhci_pci
ehci_pci
xhci_hcd
ehci_hcd
usbcore
usb_common
vfat
fat
nls_cp437


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x09 0x0e2b4030
0x0a 0x400000f0
0x0b 0x90100120
0x0c 0x400000f0
0x0d 0x90a00110
0x0e 0x400000f0
0x0f 0x400000f0
0x10 0x400000f0
0x12 0x400000f0
0x15 0x400000f0

/sys/class/sound/hwC0D0/driver_pin_configs:

/sys/class/sound/hwC0D0/user_pin_configs:

/sys/class/sound/hwC0D0/init_verbs:

/sys/class/sound/hwC0D0/hints:

/sys/class/sound/hwC0D3/init_pin_configs:
0x05 0x18560010
0x06 0x18560010
0x07 0x18560010

/sys/class/sound/hwC0D3/driver_pin_configs:

/sys/class/sound/hwC0D3/user_pin_configs:

/sys/class/sound/hwC0D3/init_verbs:

/sys/class/sound/hwC0D3/hints:


!!ALSA/HDA dmesg
!!--------------

[ 1393.780109] pciehp 0000:04:00.0:pcie24: Timeout on hotplug command 0x1038 (issued 30183 msec ago)
[ 1393.780303] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[ 1393.783649] sd 0:0:0:0: [sda] Starting disk
--
[ 1431.463975] wl_resume: PCI Resume handler
[ 1431.464557] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[ 1431.466052] pciehp 0000:04:00.0:pcie24: Timeout on hotplug command 0x1038 (issued 37670 msec ago)
--
[ 1461.567865] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[ 1461.568439] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[ 1461.569468] wl_resume: PCI Resume handler
--
[ 1491.846401] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[ 1491.846682] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[ 1491.846789] wl_resume: PCI Resume handler
--
[ 1522.149949] sd 0:0:0:0: [sda] Starting disk
[ 1522.163262] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[ 1522.227872] thunderbolt 0000:05:00.0: resetting error on 0:b.
--
[ 2765.016828] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[ 2765.017185] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[ 2765.017859] wl_resume: PCI Resume handler
--
[ 5787.715068] sd 0:0:0:0: [sda] Starting disk
[ 5787.757774] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[ 5787.796921] thunderbolt 0000:05:00.0: resetting error on 0:b.
--
[ 5817.880839] wl_resume: PCI Resume handler
[ 5817.881779] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[ 5817.882310] sd 0:0:0:0: [sda] Starting disk
--
[ 5848.129236] wl_resume: PCI Resume handler
[ 5848.129437] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[ 5848.132494] pciehp 0000:04:03.0:pcie24: Timeout on hotplug command 0x1038 (issued 30226 msec ago)
--
[ 5900.394162] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[ 5900.394443] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[ 5900.394565] wl_resume: PCI Resume handler
--
[ 5937.589195] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[ 5937.589444] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[ 5937.589450] wl_resume: PCI Resume handler
--
[ 5967.718117] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[ 5967.718520] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[ 5967.721194] wl_resume: PCI Resume handler
--
[ 6589.429158] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[ 6589.429428] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[ 6589.429501] wl_resume: PCI Resume handler
--
[ 7749.136571] wl_resume: PCI Resume handler
[ 7749.136860] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[ 7749.139454] pciehp 0000:04:06.0:pcie24: Timeout on hotplug command 0x1038 (issued 1159290 msec ago)
--
[ 7778.860951] sd 0:0:0:0: [sda] Starting disk
[ 7778.867743] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[ 7778.946330] thunderbolt 0000:05:00.0: resetting error on 0:b.
--
[10247.039758] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[10247.040149] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[10247.046059] wl_resume: PCI Resume handler
--
[10401.586065] pciehp 0000:04:00.0:pcie24: Timeout on hotplug command 0x1038 (issued 154450 msec ago)
[10401.586304] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[10401.589389] pciehp 0000:04:04.0:pcie24: Timeout on hotplug command 0x1038 (issued 154453 msec ago)
--
[12765.711223] wl_resume: PCI Resume handler
[12765.714439] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[12765.717613] pciehp 0000:04:05.0:pcie24: Timeout on hotplug command 0x1038 (issued 2363153 msec ago)
--
[13916.017893] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[13916.018020] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[13916.018109] wl_resume: PCI Resume handler
--
[14770.967985] wl_resume: PCI Resume handler
[14770.968223] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[14770.971062] pciehp 0000:04:03.0:pcie24: Timeout on hotplug command 0x1038 (issued 854470 msec ago)
--
[14801.854573] wl_resume: PCI Resume handler
[14801.854716] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[14801.857217] pciehp 0000:04:00.0:pcie24: Timeout on hotplug command 0x1038 (issued 30866 msec ago)
--
[16699.443313] WARNING: CPU: 1 PID: 329 at net/wireless/sme.c:791 cfg80211_roamed+0x91/0xa0 [cfg80211]()
[16699.443315] Modules linked in: msr wl(PO) ecb joydev iTCO_wdt iTCO_vendor_support coretemp intel_rapl x86_pkg_temp_thermal intel_powerclamp kvm_intel applesmc led_class input_polldev hwmon snd_hda_codec_hdmi kvm i915 snd_hda_codec_cirrus snd_hda_codec_generic snd_hda_intel bcm5974 cfg80211 evdev snd_hda_controller mousedev mac_hid drm_kms_helper rfkill thunderbolt pcspkr i2c_i801 snd_hda_codec drm snd_hwdep sbs snd_pcm battery sbshc snd_timer intel_gtt mei_me i2c_algo_bit snd i2c_core video ac apple_bl soundcore mei button shpchp lpc_ich processor sch_fq_codel ext4 crc16 mbcache jbd2 algif_skcipher af_alg nls_iso8859_1 hid_generic hid_apple usbhid hid uas usb_storage dm_crypt dm_mod sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul
  glue_helper
[16699.443374]  ablk_helper cryptd ahci libahci libata scsi_mod xhci_pci ehci_pci xhci_hcd ehci_hcd usbcore usb_common vfat fat nls_cp437 [last unloaded: bluetooth]
--
[17953.934198] WARNING: CPU: 1 PID: 329 at net/wireless/sme.c:791 cfg80211_roamed+0x91/0xa0 [cfg80211]()
[17953.934202] Modules linked in: msr wl(PO) ecb joydev iTCO_wdt iTCO_vendor_support coretemp intel_rapl x86_pkg_temp_thermal intel_powerclamp kvm_intel applesmc led_class input_polldev hwmon snd_hda_codec_hdmi kvm i915 snd_hda_codec_cirrus snd_hda_codec_generic snd_hda_intel bcm5974 cfg80211 evdev snd_hda_controller mousedev mac_hid drm_kms_helper rfkill thunderbolt pcspkr i2c_i801 snd_hda_codec drm snd_hwdep sbs snd_pcm battery sbshc snd_timer intel_gtt mei_me i2c_algo_bit snd i2c_core video ac apple_bl soundcore mei button shpchp lpc_ich processor sch_fq_codel ext4 crc16 mbcache jbd2 algif_skcipher af_alg nls_iso8859_1 hid_generic hid_apple usbhid hid uas usb_storage dm_crypt dm_mod sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul
  glue_helper
[17953.934301]  ablk_helper cryptd ahci libahci libata scsi_mod xhci_pci ehci_pci xhci_hcd ehci_hcd usbcore usb_common vfat fat nls_cp437 [last unloaded: bluetooth]
--
[19280.877417] wl_resume: PCI Resume handler
[19280.877545] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[19280.880907] pciehp 0000:04:05.0:pcie24: Timeout on hotplug command 0x1038 (issued 4476560 msec ago)
--
[19871.524657] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[19871.525029] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[19871.525444] wl_resume: PCI Resume handler
--
[23942.064207] WARNING: CPU: 0 PID: 329 at net/wireless/sme.c:791 cfg80211_roamed+0x91/0xa0 [cfg80211]()
[23942.064209] Modules linked in: bluetooth videodev media msr wl(PO) ecb joydev iTCO_wdt iTCO_vendor_support coretemp intel_rapl x86_pkg_temp_thermal intel_powerclamp kvm_intel applesmc led_class input_polldev hwmon snd_hda_codec_hdmi kvm i915 snd_hda_codec_cirrus snd_hda_codec_generic snd_hda_intel bcm5974 cfg80211 evdev snd_hda_controller mousedev mac_hid drm_kms_helper rfkill thunderbolt pcspkr i2c_i801 snd_hda_codec drm snd_hwdep sbs snd_pcm battery sbshc snd_timer intel_gtt mei_me i2c_algo_bit snd i2c_core video ac apple_bl soundcore mei button shpchp lpc_ich processor sch_fq_codel ext4 crc16 mbcache jbd2 algif_skcipher af_alg nls_iso8859_1 hid_generic hid_apple usbhid hid uas usb_storage dm_crypt dm_mod sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_inte
 l aes_x86_64
[23942.064262]  lrw gf128mul glue_helper ablk_helper cryptd ahci libahci libata scsi_mod xhci_pci ehci_pci xhci_hcd ehci_hcd usbcore usb_common vfat fat nls_cp437 [last unloaded: bluetooth]
--
[24219.883163] WARNING: CPU: 0 PID: 329 at net/wireless/sme.c:791 cfg80211_roamed+0x91/0xa0 [cfg80211]()
[24219.883164] Modules linked in: bluetooth videodev media msr wl(PO) ecb joydev iTCO_wdt iTCO_vendor_support coretemp intel_rapl x86_pkg_temp_thermal intel_powerclamp kvm_intel applesmc led_class input_polldev hwmon snd_hda_codec_hdmi kvm i915 snd_hda_codec_cirrus snd_hda_codec_generic snd_hda_intel bcm5974 cfg80211 evdev snd_hda_controller mousedev mac_hid drm_kms_helper rfkill thunderbolt pcspkr i2c_i801 snd_hda_codec drm snd_hwdep sbs snd_pcm battery sbshc snd_timer intel_gtt mei_me i2c_algo_bit snd i2c_core video ac apple_bl soundcore mei button shpchp lpc_ich processor sch_fq_codel ext4 crc16 mbcache jbd2 algif_skcipher af_alg nls_iso8859_1 hid_generic hid_apple usbhid hid uas usb_storage dm_crypt dm_mod sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_inte
 l aes_x86_64
[24219.883199]  lrw gf128mul glue_helper ablk_helper cryptd ahci libahci libata scsi_mod xhci_pci ehci_pci xhci_hcd ehci_hcd usbcore usb_common vfat fat nls_cp437 [last unloaded: bluetooth]
--
[24306.240631] sd 0:0:0:0: [sda] Starting disk
[24306.260550] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[24306.310276] bcm5974: bad trackpad package, length: 8
--
[25215.382207] WARNING: CPU: 0 PID: 329 at net/wireless/sme.c:791 cfg80211_roamed+0x91/0xa0 [cfg80211]()
[25215.382209] Modules linked in: msr wl(PO) ecb joydev iTCO_wdt iTCO_vendor_support coretemp intel_rapl x86_pkg_temp_thermal intel_powerclamp kvm_intel applesmc led_class input_polldev hwmon snd_hda_codec_hdmi kvm i915 snd_hda_codec_cirrus snd_hda_codec_generic snd_hda_intel bcm5974 cfg80211 evdev snd_hda_controller mousedev mac_hid drm_kms_helper rfkill thunderbolt pcspkr i2c_i801 snd_hda_codec drm snd_hwdep sbs snd_pcm battery sbshc snd_timer intel_gtt mei_me i2c_algo_bit snd i2c_core video ac apple_bl soundcore mei button shpchp lpc_ich processor sch_fq_codel ext4 crc16 mbcache jbd2 algif_skcipher af_alg nls_iso8859_1 hid_generic hid_apple usbhid hid uas usb_storage dm_crypt dm_mod sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul
  glue_helper
[25215.382246]  ablk_helper cryptd ahci libahci libata scsi_mod xhci_pci ehci_pci xhci_hcd ehci_hcd usbcore usb_common vfat fat nls_cp437 [last unloaded: bluetooth]
--
[25309.744408] WARNING: CPU: 1 PID: 329 at net/wireless/sme.c:791 cfg80211_roamed+0x91/0xa0 [cfg80211]()
[25309.744411] Modules linked in: msr wl(PO) ecb joydev iTCO_wdt iTCO_vendor_support coretemp intel_rapl x86_pkg_temp_thermal intel_powerclamp kvm_intel applesmc led_class input_polldev hwmon snd_hda_codec_hdmi kvm i915 snd_hda_codec_cirrus snd_hda_codec_generic snd_hda_intel bcm5974 cfg80211 evdev snd_hda_controller mousedev mac_hid drm_kms_helper rfkill thunderbolt pcspkr i2c_i801 snd_hda_codec drm snd_hwdep sbs snd_pcm battery sbshc snd_timer intel_gtt mei_me i2c_algo_bit snd i2c_core video ac apple_bl soundcore mei button shpchp lpc_ich processor sch_fq_codel ext4 crc16 mbcache jbd2 algif_skcipher af_alg nls_iso8859_1 hid_generic hid_apple usbhid hid uas usb_storage dm_crypt dm_mod sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul
  glue_helper
[25309.744492]  ablk_helper cryptd ahci libahci libata scsi_mod xhci_pci ehci_pci xhci_hcd ehci_hcd usbcore usb_common vfat fat nls_cp437 [last unloaded: bluetooth]
--
[27330.509876] wl_resume: PCI Resume handler
[27330.510229] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[27330.512404] pciehp 0000:04:00.0:pcie24: Timeout on hotplug command 0x1038 (issued 3022960 msec ago)
--
[27657.899383] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[27657.899846] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[27657.900732] wl_resume: PCI Resume handler
--
[27658.246122] ata1.00: configured for UDMA/133
[27658.924364] sound hdaudioC0D3: HDMI: invalid ELD data byte 0
[27658.925883] PM: resume of devices complete after 1026.202 msecs
--
[27658.944649] video LNXVIDEO:00: Restoring backlight state
[27659.224453] sound hdaudioC0D3: HDMI: invalid ELD data byte 0
[27659.524644] sound hdaudioC0D3: HDMI: invalid ELD data byte 0
[27659.824755] sound hdaudioC0D3: HDMI: invalid ELD data byte 0
[27660.124905] sound hdaudioC0D3: HDMI: invalid ELD data byte 0
[27660.424985] sound hdaudioC0D3: HDMI: invalid ELD data byte 0
[27660.725150] sound hdaudioC0D3: HDMI: invalid ELD data byte 0
[27661.025198] sound hdaudioC0D3: HDMI: invalid ELD data byte 0
[27661.325413] sound hdaudioC0D3: HDMI: invalid ELD data byte 0
[27662.406074] wl0: link up (wlp2s0)
--
[28200.883590] wl_resume: PCI Resume handler
[28200.883990] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[28200.886693] pciehp 0000:04:00.0:pcie24: Timeout on hotplug command 0x1038 (issued 542730 msec ago)
--
[28314.534439] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[28314.534707] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[28314.534765] wl_resume: PCI Resume handler
--
[28673.591664] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[28673.591971] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[28673.592141] wl_resume: PCI Resume handler
--
[28804.730000] sd 0:0:0:0: [sda] Starting disk
[28804.771017] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[28804.811247] thunderbolt 0000:05:00.0: resetting error on 0:b.
--
[29019.310637] wl_resume: PCI Resume handler
[29019.310917] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[29019.312270] pciehp 0000:04:04.0:pcie24: Timeout on hotplug command 0x1038 (issued 214490 msec ago)
--
[29210.547795] pciehp 0000:04:05.0:pcie24: Timeout on hotplug command 0x1038 (issued 191143 msec ago)
[29210.547936] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[29210.552317] sd 0:0:0:0: [sda] Starting disk
--
[29721.088166] pciehp 0000:04:04.0:pcie24: Timeout on hotplug command 0x1038 (issued 510306 msec ago)
[29721.088400] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[29721.093897] sd 0:0:0:0: [sda] Starting disk
--
[30540.528405] wl_resume: PCI Resume handler
[30540.528549] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[30540.531924] pciehp 0000:04:00.0:pcie24: Timeout on hotplug command 0x1038 (issued 819070 msec ago)
--
[31724.155563] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[31724.155891] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[31724.157702] wl_resume: PCI Resume handler
--
[33575.548401] wl_resume: PCI Resume handler
[33575.548591] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[33575.551329] pciehp 0000:04:00.0:pcie24: Timeout on hotplug command 0x1038 (issued 1850523 msec ago)
--
[33605.681004] pciehp 0000:04:00.0:pcie24: Timeout on hotplug command 0x1038 (issued 30113 msec ago)
[33605.727187] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[33605.727342] sd 0:0:0:0: [sda] Starting disk
--
[33829.704874] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[33829.707343] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[33829.710497] wl_resume: PCI Resume handler
--
[37142.587189] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[37142.587594] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[37142.590239] wl_resume: PCI Resume handler
--
[37171.948804] pciehp 0000:04:00.0:pcie24: Timeout on hotplug command 0x1038 (issued 29340 msec ago)
[37171.948955] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[37171.949011] pciehp 0000:04:03.0:pcie24: Timeout on hotplug command 0x1038 (issued 29340 msec ago)
--
[37202.208363] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[37202.208720] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[37202.211228] wl_resume: PCI Resume handler
--
[37544.801736] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[37544.802119] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[37544.805270] wl_resume: PCI Resume handler
--
[41138.905836] wl_resume: PCI Resume handler
[41138.905923] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[41138.908655] pciehp 0000:04:05.0:pcie24: Timeout on hotplug command 0x1038 (issued 3592356 msec ago)
--
[41169.402025] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[41169.402314] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[41169.402374] wl_resume: PCI Resume handler
--
[41169.747473] ata1.00: configured for UDMA/133
[41170.425480] sound hdaudioC0D0: hda-codec: out of range cmd 0:11:400:ffffffff
[41170.425846] PM: resume of devices complete after 1023.430 msecs
--
[42693.703287] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[42693.703770] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[42693.705654] wl_resume: PCI Resume handler
--
[42771.610474] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[42771.610758] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[42771.610901] wl_resume: PCI Resume handler
--
[42887.962183] wl_resume: PCI Resume handler
[42887.962365] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[42887.965171] pciehp 0000:04:06.0:pcie24: Timeout on hotplug command 0x1038 (issued 116290 msec ago)
--
[42901.228834] WARNING: CPU: 2 PID: 329 at net/wireless/sme.c:791 cfg80211_roamed+0x91/0xa0 [cfg80211]()
[42901.228836] Modules linked in: msr wl(PO) ecb joydev iTCO_wdt iTCO_vendor_support coretemp intel_rapl x86_pkg_temp_thermal intel_powerclamp kvm_intel applesmc led_class input_polldev hwmon snd_hda_codec_hdmi kvm i915 snd_hda_codec_cirrus snd_hda_codec_generic snd_hda_intel bcm5974 cfg80211 evdev snd_hda_controller mousedev mac_hid drm_kms_helper rfkill thunderbolt pcspkr i2c_i801 snd_hda_codec drm snd_hwdep sbs snd_pcm battery sbshc snd_timer intel_gtt mei_me i2c_algo_bit snd i2c_core video ac apple_bl soundcore mei button shpchp lpc_ich processor sch_fq_codel ext4 crc16 mbcache jbd2 algif_skcipher af_alg nls_iso8859_1 hid_generic hid_apple usbhid hid uas usb_storage dm_crypt dm_mod sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul
  glue_helper
[42901.228902]  ablk_helper cryptd ahci libahci libata scsi_mod xhci_pci ehci_pci xhci_hcd ehci_hcd usbcore usb_common vfat fat nls_cp437 [last unloaded: bluetooth]
--
[42918.023119] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[42918.023405] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[42918.023488] wl_resume: PCI Resume handler
--
[42983.110177] WARNING: CPU: 1 PID: 329 at net/wireless/sme.c:791 cfg80211_roamed+0x91/0xa0 [cfg80211]()
[42983.110178] Modules linked in: msr wl(PO) ecb joydev iTCO_wdt iTCO_vendor_support coretemp intel_rapl x86_pkg_temp_thermal intel_powerclamp kvm_intel applesmc led_class input_polldev hwmon snd_hda_codec_hdmi kvm i915 snd_hda_codec_cirrus snd_hda_codec_generic snd_hda_intel bcm5974 cfg80211 evdev snd_hda_controller mousedev mac_hid drm_kms_helper rfkill thunderbolt pcspkr i2c_i801 snd_hda_codec drm snd_hwdep sbs snd_pcm battery sbshc snd_timer intel_gtt mei_me i2c_algo_bit snd i2c_core video ac apple_bl soundcore mei button shpchp lpc_ich processor sch_fq_codel ext4 crc16 mbcache jbd2 algif_skcipher af_alg nls_iso8859_1 hid_generic hid_apple usbhid hid uas usb_storage dm_crypt dm_mod sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul
  glue_helper
[42983.110225]  ablk_helper cryptd ahci libahci libata scsi_mod xhci_pci ehci_pci xhci_hcd ehci_hcd usbcore usb_common vfat fat nls_cp437 [last unloaded: bluetooth]
--
[45608.665202] wl_resume: PCI Resume handler
[45608.665393] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[45608.668455] pciehp 0000:04:03.0:pcie24: Timeout on hotplug command 0x1038 (issued 2689353 msec ago)
--
[46279.336400] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[46279.336965] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[46279.337231] wl_resume: PCI Resume handler
--
[49183.766876] wl_resume: PCI Resume handler
[49183.767091] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[49183.770241] pciehp 0000:04:00.0:pcie24: Timeout on hotplug command 0x1038 (issued 2903046 msec ago)
--
[50084.503103] wl_resume: PCI Resume handler
[50084.503313] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[50084.503988] pciehp 0000:04:00.0:pcie24: Timeout on hotplug command 0x1038 (issued 900303 msec ago)
--
[51188.937840] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[51188.938109] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[51188.938840] sd 0:0:0:0: [sda] Starting disk
--
[55582.265169] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[55582.265581] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[55582.265847] wl_resume: PCI Resume handler
--
[56228.782000] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[56228.782405] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[56228.783317] wl_resume: PCI Resume handler
--
[56292.387615] NET: Unregistered protocol family 31
[56487.227921] snd_hda_intel 0000:00:1b.0: Unstable LPIB (131072 >= 8192); disabling LPIB delay counting
[56713.068171] wl0: link down (wlp2s0)




--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=coefficients

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.64
!!################################

!!Script ran on: Wed Mar 11 20:05:47 UTC 2015


!!Linux Distribution
!!------------------

Arch Linux \r (\l) DISTRIB_ID=Arch DISTRIB_DESCRIPTION="Arch Linux" NAME="Arch Linux" ID=arch PRETTY_NAME="Arch Linux" HOME_URL="https://www.archlinux.org/" SUPPORT_URL="https://bbs.archlinux.org/" BUG_REPORT_URL="https://bugs.archlinux.org/"


!!DMI Information
!!---------------

Manufacturer:      Apple Inc.
Product Name:      MacBookAir5,2
Product Version:   1.0
Firmware Version:  MBA51.88Z.00EF.B02.1211271028


!!Kernel Information
!!------------------

Kernel release:    3.18.6-1-ARCH
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         unknown
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     k3.18.6-1-ARCH
Library version:    1.0.28
Utilities version:  1.0.28


!!Loaded ALSA modules
!!-------------------

snd_hda_intel


!!Sound Servers on this system
!!----------------------------

Jack:
      Installed - Yes (/usr/bin/jackd)
      Running - No


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [PCH            ]: HDA-Intel - HDA Intel PCH
                      HDA Intel PCH at 0xa0610000 irq 34


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation 7 Series/C210 Series Chipset Family High Definition Audio Controller (rev 04)


!!Advanced information - PCI Vendor/Device/Subsystem ID's
!!-------------------------------------------------------

00:1b.0 0403: 8086:1e20 (rev 04)
	Subsystem: 8086:7270


!!Loaded sound module options
!!---------------------------

!!Module: snd_hda_intel
	align_buffer_size : -1
	bdl_pos_adj : 1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	beep_mode : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	enable_msi : -1
	id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	jackpoll_ms : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	model : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	patch : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	position_fix : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	power_save : 1
	power_save_controller : Y
	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	probe_only : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	single_cmd : N
	snoop : Y


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Cirrus Logic CS4206
Address: 0
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x10134206
Subsystem Id: 0x106b5600
Revision Id: 0x100302
No Modem Function Group found
Default PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x3]: PCM FLOAT
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
  Power states:  D0 D3 CLKSTOP EPSS
  Power: setting=D0, actual=D0
GPIO: io=4, o=0, i=0, unsolicited=0, wake=0
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[1]: enable=1, dir=1, wake=0, sticky=0, data=0, unsol=0
  IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[3]: enable=1, dir=1, wake=0, sticky=0, data=1, unsol=0
Node 0x02 [Audio Output] wcaps 0xd041d: Stereo Amp-Out
  Control: name="Headphone Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Device: name="CS4206 Analog", type="Audio", device=0
  Amp-Out caps: ofs=0x73, nsteps=0x7f, stepsize=0x01, mute=1
  Amp-Out vals:  [0x50 0x50]
  Converter: stream=0, channel=0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x3]: PCM FLOAT
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x03 [Audio Output] wcaps 0xd041d: Stereo Amp-Out
  Amp-Out caps: ofs=0x73, nsteps=0x7f, stepsize=0x01, mute=1
  Amp-Out vals:  [0xf3 0xf3]
  Converter: stream=0, channel=0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x3]: PCM FLOAT
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x04 [Audio Output] wcaps 0xd041d: Stereo Amp-Out
  Control: name="Speaker Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Speaker Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x73, nsteps=0x7f, stepsize=0x01, mute=1
  Amp-Out vals:  [0x48 0x48]
  Converter: stream=0, channel=0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x3]: PCM FLOAT
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x05 [Audio Input] wcaps 0x18051b: Stereo Amp-In
  Amp-In caps: ofs=0x33, nsteps=0x3f, stepsize=0x03, mute=1
  Amp-In vals:  [0xb3 0xb3] [0xb3 0xb3]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x1f5]: 8000 16000 32000 44100 48000 88200 96000
    bits [0x1e]: 16 20 24 32
    formats [0x3]: PCM FLOAT
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 8 samples
  Connection: 2
     0x0c* 0x12
Node 0x06 [Audio Input] wcaps 0x18051b: Stereo Amp-In
  Control: name="Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Capture Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Device: name="CS4206 Analog", type="Audio", device=0
  Amp-In caps: ofs=0x33, nsteps=0x3f, stepsize=0x03, mute=1
  Amp-In vals:  [0x3f 0x3f] [0x3f 0x3f]
  Converter: stream=4, channel=0
  SDI-Select: 0
  PCM:
    rates [0x1f5]: 8000 16000 32000 44100 48000 88200 96000
    bits [0x1e]: 16 20 24 32
    formats [0x3]: PCM FLOAT
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 8 samples
  Connection: 2
     0x0d* 0x0e
Node 0x07 [Audio Input] wcaps 0x180791: Stereo Digital
  Converter: stream=0, channel=0
  SDI-Select: 0
  Digital: Preemphasis Non-Copyright
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x570]: 32000 44100 48000 96000 192000
    bits [0x1e]: 16 20 24 32
    formats [0x7]: PCM FLOAT AC3
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 8 samples
  Connection: 1
     0x0f
Node 0x08 [Audio Output] wcaps 0x40611: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x7]: PCM FLOAT AC3
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 4 samples
Node 0x09 [Pin Complex] wcaps 0x410581: Stereo
  Control: name="Headphone Jack", index=0, device=0
  Pincap 0x0000001c: OUT HP Detect
  Pin Default 0x022140f0: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=01, enabled=1
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 1 samples
  Connection: 1
     0x02
Node 0x0a [Pin Complex] wcaps 0x410581: Stereo
  Pincap 0x00000054: OUT Detect Balanced
  Pin Default 0x010140f0: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Green
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 1 samples
  Connection: 1
     0x03
Node 0x0b [Pin Complex] wcaps 0x410101: Stereo
  Control: name="Speaker Phantom Jack", index=0, device=0
  Pincap 0x00000050: OUT Balanced
  Pin Default 0x901700f0: [Fixed] Speaker at Int N/A
    Conn = Analog, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Delay: 1 samples
  Connection: 1
     0x04
Node 0x0c [Pin Complex] wcaps 0x41048b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000024: IN Detect
  Pin Default 0x01813051: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Blue
    DefAssociation = 0x5, Sequence = 0x1
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 1 samples
Node 0x0d [Pin Complex] wcaps 0x41048b: Stereo Amp-In
  Control: name="Mic Boost Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Mic Phantom Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x01 0x01]
  Pincap 0x00001764: IN Detect Balanced
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x01a19031: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Pink
    DefAssociation = 0x3, Sequence = 0x1
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 1 samples
Node 0x0e [Pin Complex] wcaps 0x41000b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x02, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000020: IN
  Pin Default 0xb7d6003e: [Fixed] Digital In at Oth Mobile-In
    Conn = Digital, Color = Unknown
    DefAssociation = 0x3, Sequence = 0xe
  Pin-ctls: 0x00:
  Delay: 1 samples
Node 0x0f [Pin Complex] wcaps 0x410681: Stereo Digital
  Pincap 0x00000024: IN Detect
  Pin Default 0x02c4e0f0: [Jack] SPDIF In at Ext Front
    Conn = RCA, Color = White
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 1 samples
Node 0x10 [Pin Complex] wcaps 0x410301: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x014460f0: [Jack] SPDIF Out at Ext Rear
    Conn = RCA, Color = Orange
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Delay: 1 samples
  Connection: 1
     0x08
Node 0x11 [Vendor Defined Widget] wcaps 0xf00040: Mono
  Processing caps: benign=0, ncoeff=22
    Coeff 0x00: 0x001e
    Coeff 0x01: 0x000a
    Coeff 0x02: 0x000a
    Coeff 0x03: 0x146a
    Coeff 0x04: 0x0007
    Coeff 0x05: 0x0000
    Coeff 0x06: 0x0000
    Coeff 0x07: 0x0000
    Coeff 0x08: 0x0000
    Coeff 0x09: 0x0000
    Coeff 0x0a: 0x0000
    Coeff 0x0b: 0x0000
    Coeff 0x0c: 0x0000
    Coeff 0x0d: 0x0000
    Coeff 0x0e: 0x0000
    Coeff 0x0f: 0x0000
    Coeff 0x10: 0x0000
    Coeff 0x11: 0x0000
    Coeff 0x12: 0x0000
    Coeff 0x13: 0x0000
    Coeff 0x14: 0x0000
    Coeff 0x15: 0x0000
Node 0x12 [Pin Complex] wcaps 0x41000b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x02, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000020: IN
  Pin Default 0xb7d6005e: [Fixed] Digital In at Oth Mobile-In
    Conn = Digital, Color = Unknown
    DefAssociation = 0x5, Sequence = 0xe
  Pin-ctls: 0x00:
  Delay: 1 samples
Node 0x13 [Beep Generator Widget] wcaps 0x700000: Mono
Node 0x14 [Audio Output] wcaps 0x40611: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x7]: PCM FLOAT AC3
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 4 samples
Node 0x15 [Pin Complex] wcaps 0x410301: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x014510f0: [Jack] SPDIF Out at Ext Rear
    Conn = Optical, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Delay: 1 samples
  Connection: 1
     0x14
Codec: Intel PantherPoint HDMI
Address: 3
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x80862806
Subsystem Id: 0x80860101
Revision Id: 0x100000
No Modem Function Group found
Default PCM:
    rates [0x0]:
    bits [0x0]:
    formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
  Power states:  D0 D3 CLKSTOP EPSS
  Power: setting=D0, actual=D0, Clock-stop-OK
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x02 [Audio Output] wcaps 0x6611: 8-Channels Digital
  Converter: stream=0, channel=0
  Digital: Enabled
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x5]: PCM AC3
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x03 [Audio Output] wcaps 0x6611: 8-Channels Digital
  Converter: stream=0, channel=0
  Digital: Enabled
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x5]: PCM AC3
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x04 [Audio Output] wcaps 0x6611: 8-Channels Digital
  Converter: stream=0, channel=0
  Digital: Enabled
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x5]: PCM AC3
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x05 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
  Control: name="HDMI/DP,pcm=3 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=0, device=0
  Control: name="IEC958 Playback Pro Mask", index=0, device=0
  Control: name="IEC958 Playback Default", index=0, device=0
  Control: name="IEC958 Playback Switch", index=0, device=0
  Control: name="ELD", index=0, device=3
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x09000094: OUT Detect HBR HDMI DP
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=01, enabled=1
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x02
Node 0x06 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
  Control: name="HDMI/DP,pcm=7 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=1, device=0
  Control: name="IEC958 Playback Pro Mask", index=1, device=0
  Control: name="IEC958 Playback Default", index=1, device=0
  Control: name="IEC958 Playback Switch", index=1, device=0
  Control: name="ELD", index=0, device=7
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x09000094: OUT Detect HBR HDMI DP
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=02, enabled=1
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x03
Node 0x07 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
  Control: name="HDMI/DP,pcm=8 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=2, device=0
  Control: name="IEC958 Playback Pro Mask", index=2, device=0
  Control: name="IEC958 Playback Default", index=2, device=0
  Control: name="IEC958 Playback Switch", index=2, device=0
  Control: name="ELD", index=0, device=8
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x09000094: OUT Detect HBR HDMI DP
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=03, enabled=1
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x04
Node 0x08 [Vendor Defined Widget] wcaps 0xf00000: Mono
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116,  2 Mar  9 17:36 /dev/snd/controlC0
crw-rw----+ 1 root audio 116,  8 Mar  9 17:36 /dev/snd/hwC0D0
crw-rw----+ 1 root audio 116,  9 Mar  9 17:36 /dev/snd/hwC0D3
crw-rw----+ 1 root audio 116,  4 Mar 11 21:04 /dev/snd/pcmC0D0c
crw-rw----+ 1 root audio 116,  3 Mar 11 18:22 /dev/snd/pcmC0D0p
crw-rw----+ 1 root audio 116,  5 Mar  9 17:36 /dev/snd/pcmC0D3p
crw-rw----+ 1 root audio 116,  6 Mar  9 17:36 /dev/snd/pcmC0D7p
crw-rw----+ 1 root audio 116,  7 Mar  9 17:36 /dev/snd/pcmC0D8p
crw-rw----+ 1 root audio 116,  1 Mar  9 17:36 /dev/snd/seq
crw-rw----+ 1 root audio 116, 33 Mar  9 17:36 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  60 Mar  9 17:36 .
drwxr-xr-x 3 root root 260 Mar  9 17:36 ..
lrwxrwxrwx 1 root root  12 Mar  9 17:36 pci-0000:00:1b.0 -> ../controlC0


!!ALSA configuration files
!!------------------------

!!User specific config file (~/.asoundrc)

pcm.swapped {
    type route
    slave {
        pcm "cards.pcm.default"
        channels 2
    }
    ttable.0.1 1.0
    ttable.1.1 1.0
}


!!Aplay/Arecord output
!!--------------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: PCH [HDA Intel PCH], device 0: CS4206 Analog [CS4206 Analog]
  Subdevices: 0/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 7: HDMI 1 [HDMI 1]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 8: HDMI 2 [HDMI 2]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: PCH [HDA Intel PCH], device 0: CS4206 Analog [CS4206 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [PCH]

Card hw:0 'PCH'/'HDA Intel PCH at 0xa0610000 irq 34'
  Mixer name	: 'Intel PantherPoint HDMI'
  Components	: 'HDA:10134206,106b5600,00100302 HDA:80862806,80860101,00100000'
  Controls      : 38
  Simple ctrls  : 11
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 127
  Mono: Playback 80 [63%] [-23.50dB] [on]
Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 127
  Mono:
  Front Left: Playback 127 [100%] [6.00dB] [on]
  Front Right: Playback 127 [100%] [6.00dB] [on]
Simple mixer control 'Speaker',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 127
  Mono:
  Front Left: Playback 119 [94%] [2.00dB] [on]
  Front Right: Playback 119 [94%] [2.00dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 255 [100%] [0.00dB]
  Front Right: Playback 255 [100%] [0.00dB]
Simple mixer control 'Mic Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 1 [33%] [10.00dB]
  Front Right: 1 [33%] [10.00dB]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'IEC958',1
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958',2
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 63
  Front Left: Capture 63 [100%] [12.00dB] [on]
  Front Right: Capture 63 [100%] [12.00dB] [on]
Simple mixer control 'Auto-Mute Mode',0
  Capabilities: enum
  Items: 'Disabled' 'Enabled'
  Item0: 'Enabled'
Simple mixer control 'Digital',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 120
  Front Left: Capture 120 [100%] [30.00dB]
  Front Right: Capture 120 [100%] [30.00dB]


!!Alsactl output
!!--------------

--startcollapse--
state.PCH {
	control.1 {
		iface MIXER
		name 'Headphone Playback Volume'
		value.0 127
		value.1 127
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 127'
			dbmin -5750
			dbmax 600
			dbvalue.0 600
			dbvalue.1 600
		}
	}
	control.2 {
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
	control.3 {
		iface MIXER
		name 'Speaker Playback Volume'
		value.0 119
		value.1 119
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 127'
			dbmin -5750
			dbmax 600
			dbvalue.0 200
			dbvalue.1 200
		}
	}
	control.4 {
		iface MIXER
		name 'Speaker Playback Switch'
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
	control.6 {
		iface MIXER
		name 'Capture Volume'
		value.0 63
		value.1 63
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 63'
			dbmin -5100
			dbmax 1200
			dbvalue.0 1200
			dbvalue.1 1200
		}
	}
	control.7 {
		iface MIXER
		name 'Capture Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.8 {
		iface MIXER
		name 'Mic Boost Volume'
		value.0 1
		value.1 1
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 3'
			dbmin 0
			dbmax 3000
			dbvalue.0 1000
			dbvalue.1 1000
		}
	}
	control.9 {
		iface MIXER
		name 'Master Playback Volume'
		value 80
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 127'
			dbmin -6350
			dbmax 0
			dbvalue.0 -2350
		}
	}
	control.10 {
		iface MIXER
		name 'Master Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.11 {
		iface CARD
		name 'Mic Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.12 {
		iface CARD
		name 'Headphone Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.13 {
		iface CARD
		name 'Speaker Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.14 {
		iface PCM
		name 'Playback Channel Map'
		value.0 3
		value.1 4
		comment {
			access read
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
	control.15 {
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
	control.16 {
		iface CARD
		name 'HDMI/DP,pcm=3 Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.17 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.18 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.19 {
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.20 {
		iface MIXER
		name 'IEC958 Playback Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.21 {
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
	control.22 {
		iface CARD
		name 'HDMI/DP,pcm=7 Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.23 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		index 1
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.24 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		index 1
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.25 {
		iface MIXER
		name 'IEC958 Playback Default'
		index 1
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.26 {
		iface MIXER
		name 'IEC958 Playback Switch'
		index 1
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.27 {
		iface PCM
		device 7
		name ELD
		value ''
		comment {
			access 'read volatile'
			type BYTES
			count 0
		}
	}
	control.28 {
		iface CARD
		name 'HDMI/DP,pcm=8 Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.29 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		index 2
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.30 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		index 2
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.31 {
		iface MIXER
		name 'IEC958 Playback Default'
		index 2
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.32 {
		iface MIXER
		name 'IEC958 Playback Switch'
		index 2
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.33 {
		iface PCM
		device 8
		name ELD
		value ''
		comment {
			access 'read volatile'
			type BYTES
			count 0
		}
	}
	control.34 {
		iface PCM
		device 3
		name 'Playback Channel Map'
		value.0 0
		value.1 0
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		comment {
			access 'read write'
			type INTEGER
			count 8
			range '0 - 36'
		}
	}
	control.35 {
		iface PCM
		device 7
		name 'Playback Channel Map'
		value.0 0
		value.1 0
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		comment {
			access 'read write'
			type INTEGER
			count 8
			range '0 - 36'
		}
	}
	control.36 {
		iface PCM
		device 8
		name 'Playback Channel Map'
		value.0 0
		value.1 0
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		comment {
			access 'read write'
			type INTEGER
			count 8
			range '0 - 36'
		}
	}
	control.37 {
		iface MIXER
		name 'PCM Playback Volume'
		value.0 255
		value.1 255
		comment {
			access 'read write user'
			type INTEGER
			count 2
			range '0 - 255'
			tlv '0000000100000008ffffec1400000014'
			dbmin -5100
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.38 {
		iface MIXER
		name 'Digital Capture Volume'
		value.0 120
		value.1 120
		comment {
			access 'read write user'
			type INTEGER
			count 2
			range '0 - 120'
			tlv '0000000100000008fffff44800000032'
			dbmin -3000
			dbmax 3000
			dbvalue.0 3000
			dbvalue.1 3000
		}
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
bluetooth
wl
cfg80211
cpufreq_stats
msr
ecb
joydev
iTCO_wdt
iTCO_vendor_support
coretemp
intel_rapl
x86_pkg_temp_thermal
intel_powerclamp
kvm_intel
applesmc
led_class
input_polldev
hwmon
snd_hda_codec_hdmi
kvm
i915
snd_hda_codec_cirrus
snd_hda_codec_generic
snd_hda_intel
evdev
snd_hda_controller
mousedev
mac_hid
drm_kms_helper
rfkill
thunderbolt
pcspkr
i2c_i801
snd_hda_codec
drm
snd_hwdep
sbs
snd_pcm
battery
sbshc
snd_timer
intel_gtt
mei_me
i2c_algo_bit
snd
i2c_core
video
ac
apple_bl
soundcore
mei
button
shpchp
lpc_ich
processor
sch_fq_codel
ext4
crc16
mbcache
jbd2
algif_skcipher
af_alg
nls_iso8859_1
hid_generic
hid_apple
usbhid
hid
uas
usb_storage
dm_crypt
dm_mod
sd_mod
crct10dif_pclmul
crc32_pclmul
crc32c_intel
ghash_clmulni_intel
aesni_intel
aes_x86_64
lrw
gf128mul
glue_helper
ablk_helper
cryptd
ahci
libahci
libata
scsi_mod
xhci_pci
ehci_pci
xhci_hcd
ehci_hcd
usbcore
usb_common
vfat
fat
nls_cp437


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x09 0x0e2b4030
0x0a 0x400000f0
0x0b 0x90100120
0x0c 0x400000f0
0x0d 0x90a00110
0x0e 0x400000f0
0x0f 0x400000f0
0x10 0x400000f0
0x12 0x400000f0
0x15 0x400000f0

/sys/class/sound/hwC0D0/driver_pin_configs:

/sys/class/sound/hwC0D0/user_pin_configs:

/sys/class/sound/hwC0D0/init_verbs:

/sys/class/sound/hwC0D0/hints:

/sys/class/sound/hwC0D3/init_pin_configs:
0x05 0x18560010
0x06 0x18560010
0x07 0x18560010

/sys/class/sound/hwC0D3/driver_pin_configs:

/sys/class/sound/hwC0D3/user_pin_configs:

/sys/class/sound/hwC0D3/init_verbs:

/sys/class/sound/hwC0D3/hints:


!!ALSA/HDA dmesg
!!--------------

[ 7749.136571] wl_resume: PCI Resume handler
[ 7749.136860] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[ 7749.139454] pciehp 0000:04:06.0:pcie24: Timeout on hotplug command 0x1038 (issued 1159290 msec ago)
--
[ 7778.860951] sd 0:0:0:0: [sda] Starting disk
[ 7778.867743] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[ 7778.946330] thunderbolt 0000:05:00.0: resetting error on 0:b.
--
[10247.039758] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[10247.040149] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[10247.046059] wl_resume: PCI Resume handler
--
[10401.586065] pciehp 0000:04:00.0:pcie24: Timeout on hotplug command 0x1038 (issued 154450 msec ago)
[10401.586304] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[10401.589389] pciehp 0000:04:04.0:pcie24: Timeout on hotplug command 0x1038 (issued 154453 msec ago)
--
[12765.711223] wl_resume: PCI Resume handler
[12765.714439] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[12765.717613] pciehp 0000:04:05.0:pcie24: Timeout on hotplug command 0x1038 (issued 2363153 msec ago)
--
[13916.017893] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[13916.018020] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[13916.018109] wl_resume: PCI Resume handler
--
[14770.967985] wl_resume: PCI Resume handler
[14770.968223] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[14770.971062] pciehp 0000:04:03.0:pcie24: Timeout on hotplug command 0x1038 (issued 854470 msec ago)
--
[14801.854573] wl_resume: PCI Resume handler
[14801.854716] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[14801.857217] pciehp 0000:04:00.0:pcie24: Timeout on hotplug command 0x1038 (issued 30866 msec ago)
--
[16699.443313] WARNING: CPU: 1 PID: 329 at net/wireless/sme.c:791 cfg80211_roamed+0x91/0xa0 [cfg80211]()
[16699.443315] Modules linked in: msr wl(PO) ecb joydev iTCO_wdt iTCO_vendor_support coretemp intel_rapl x86_pkg_temp_thermal intel_powerclamp kvm_intel applesmc led_class input_polldev hwmon snd_hda_codec_hdmi kvm i915 snd_hda_codec_cirrus snd_hda_codec_generic snd_hda_intel bcm5974 cfg80211 evdev snd_hda_controller mousedev mac_hid drm_kms_helper rfkill thunderbolt pcspkr i2c_i801 snd_hda_codec drm snd_hwdep sbs snd_pcm battery sbshc snd_timer intel_gtt mei_me i2c_algo_bit snd i2c_core video ac apple_bl soundcore mei button shpchp lpc_ich processor sch_fq_codel ext4 crc16 mbcache jbd2 algif_skcipher af_alg nls_iso8859_1 hid_generic hid_apple usbhid hid uas usb_storage dm_crypt dm_mod sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul
  glue_helper
[16699.443374]  ablk_helper cryptd ahci libahci libata scsi_mod xhci_pci ehci_pci xhci_hcd ehci_hcd usbcore usb_common vfat fat nls_cp437 [last unloaded: bluetooth]
--
[17953.934198] WARNING: CPU: 1 PID: 329 at net/wireless/sme.c:791 cfg80211_roamed+0x91/0xa0 [cfg80211]()
[17953.934202] Modules linked in: msr wl(PO) ecb joydev iTCO_wdt iTCO_vendor_support coretemp intel_rapl x86_pkg_temp_thermal intel_powerclamp kvm_intel applesmc led_class input_polldev hwmon snd_hda_codec_hdmi kvm i915 snd_hda_codec_cirrus snd_hda_codec_generic snd_hda_intel bcm5974 cfg80211 evdev snd_hda_controller mousedev mac_hid drm_kms_helper rfkill thunderbolt pcspkr i2c_i801 snd_hda_codec drm snd_hwdep sbs snd_pcm battery sbshc snd_timer intel_gtt mei_me i2c_algo_bit snd i2c_core video ac apple_bl soundcore mei button shpchp lpc_ich processor sch_fq_codel ext4 crc16 mbcache jbd2 algif_skcipher af_alg nls_iso8859_1 hid_generic hid_apple usbhid hid uas usb_storage dm_crypt dm_mod sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul
  glue_helper
[17953.934301]  ablk_helper cryptd ahci libahci libata scsi_mod xhci_pci ehci_pci xhci_hcd ehci_hcd usbcore usb_common vfat fat nls_cp437 [last unloaded: bluetooth]
--
[19280.877417] wl_resume: PCI Resume handler
[19280.877545] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[19280.880907] pciehp 0000:04:05.0:pcie24: Timeout on hotplug command 0x1038 (issued 4476560 msec ago)
--
[19871.524657] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[19871.525029] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[19871.525444] wl_resume: PCI Resume handler
--
[23942.064207] WARNING: CPU: 0 PID: 329 at net/wireless/sme.c:791 cfg80211_roamed+0x91/0xa0 [cfg80211]()
[23942.064209] Modules linked in: bluetooth videodev media msr wl(PO) ecb joydev iTCO_wdt iTCO_vendor_support coretemp intel_rapl x86_pkg_temp_thermal intel_powerclamp kvm_intel applesmc led_class input_polldev hwmon snd_hda_codec_hdmi kvm i915 snd_hda_codec_cirrus snd_hda_codec_generic snd_hda_intel bcm5974 cfg80211 evdev snd_hda_controller mousedev mac_hid drm_kms_helper rfkill thunderbolt pcspkr i2c_i801 snd_hda_codec drm snd_hwdep sbs snd_pcm battery sbshc snd_timer intel_gtt mei_me i2c_algo_bit snd i2c_core video ac apple_bl soundcore mei button shpchp lpc_ich processor sch_fq_codel ext4 crc16 mbcache jbd2 algif_skcipher af_alg nls_iso8859_1 hid_generic hid_apple usbhid hid uas usb_storage dm_crypt dm_mod sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_inte
 l aes_x86_64
[23942.064262]  lrw gf128mul glue_helper ablk_helper cryptd ahci libahci libata scsi_mod xhci_pci ehci_pci xhci_hcd ehci_hcd usbcore usb_common vfat fat nls_cp437 [last unloaded: bluetooth]
--
[24219.883163] WARNING: CPU: 0 PID: 329 at net/wireless/sme.c:791 cfg80211_roamed+0x91/0xa0 [cfg80211]()
[24219.883164] Modules linked in: bluetooth videodev media msr wl(PO) ecb joydev iTCO_wdt iTCO_vendor_support coretemp intel_rapl x86_pkg_temp_thermal intel_powerclamp kvm_intel applesmc led_class input_polldev hwmon snd_hda_codec_hdmi kvm i915 snd_hda_codec_cirrus snd_hda_codec_generic snd_hda_intel bcm5974 cfg80211 evdev snd_hda_controller mousedev mac_hid drm_kms_helper rfkill thunderbolt pcspkr i2c_i801 snd_hda_codec drm snd_hwdep sbs snd_pcm battery sbshc snd_timer intel_gtt mei_me i2c_algo_bit snd i2c_core video ac apple_bl soundcore mei button shpchp lpc_ich processor sch_fq_codel ext4 crc16 mbcache jbd2 algif_skcipher af_alg nls_iso8859_1 hid_generic hid_apple usbhid hid uas usb_storage dm_crypt dm_mod sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_inte
 l aes_x86_64
[24219.883199]  lrw gf128mul glue_helper ablk_helper cryptd ahci libahci libata scsi_mod xhci_pci ehci_pci xhci_hcd ehci_hcd usbcore usb_common vfat fat nls_cp437 [last unloaded: bluetooth]
--
[24306.240631] sd 0:0:0:0: [sda] Starting disk
[24306.260550] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[24306.310276] bcm5974: bad trackpad package, length: 8
--
[25215.382207] WARNING: CPU: 0 PID: 329 at net/wireless/sme.c:791 cfg80211_roamed+0x91/0xa0 [cfg80211]()
[25215.382209] Modules linked in: msr wl(PO) ecb joydev iTCO_wdt iTCO_vendor_support coretemp intel_rapl x86_pkg_temp_thermal intel_powerclamp kvm_intel applesmc led_class input_polldev hwmon snd_hda_codec_hdmi kvm i915 snd_hda_codec_cirrus snd_hda_codec_generic snd_hda_intel bcm5974 cfg80211 evdev snd_hda_controller mousedev mac_hid drm_kms_helper rfkill thunderbolt pcspkr i2c_i801 snd_hda_codec drm snd_hwdep sbs snd_pcm battery sbshc snd_timer intel_gtt mei_me i2c_algo_bit snd i2c_core video ac apple_bl soundcore mei button shpchp lpc_ich processor sch_fq_codel ext4 crc16 mbcache jbd2 algif_skcipher af_alg nls_iso8859_1 hid_generic hid_apple usbhid hid uas usb_storage dm_crypt dm_mod sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul
  glue_helper
[25215.382246]  ablk_helper cryptd ahci libahci libata scsi_mod xhci_pci ehci_pci xhci_hcd ehci_hcd usbcore usb_common vfat fat nls_cp437 [last unloaded: bluetooth]
--
[25309.744408] WARNING: CPU: 1 PID: 329 at net/wireless/sme.c:791 cfg80211_roamed+0x91/0xa0 [cfg80211]()
[25309.744411] Modules linked in: msr wl(PO) ecb joydev iTCO_wdt iTCO_vendor_support coretemp intel_rapl x86_pkg_temp_thermal intel_powerclamp kvm_intel applesmc led_class input_polldev hwmon snd_hda_codec_hdmi kvm i915 snd_hda_codec_cirrus snd_hda_codec_generic snd_hda_intel bcm5974 cfg80211 evdev snd_hda_controller mousedev mac_hid drm_kms_helper rfkill thunderbolt pcspkr i2c_i801 snd_hda_codec drm snd_hwdep sbs snd_pcm battery sbshc snd_timer intel_gtt mei_me i2c_algo_bit snd i2c_core video ac apple_bl soundcore mei button shpchp lpc_ich processor sch_fq_codel ext4 crc16 mbcache jbd2 algif_skcipher af_alg nls_iso8859_1 hid_generic hid_apple usbhid hid uas usb_storage dm_crypt dm_mod sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul
  glue_helper
[25309.744492]  ablk_helper cryptd ahci libahci libata scsi_mod xhci_pci ehci_pci xhci_hcd ehci_hcd usbcore usb_common vfat fat nls_cp437 [last unloaded: bluetooth]
--
[27330.509876] wl_resume: PCI Resume handler
[27330.510229] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[27330.512404] pciehp 0000:04:00.0:pcie24: Timeout on hotplug command 0x1038 (issued 3022960 msec ago)
--
[27657.899383] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[27657.899846] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[27657.900732] wl_resume: PCI Resume handler
--
[27658.246122] ata1.00: configured for UDMA/133
[27658.924364] sound hdaudioC0D3: HDMI: invalid ELD data byte 0
[27658.925883] PM: resume of devices complete after 1026.202 msecs
--
[27658.944649] video LNXVIDEO:00: Restoring backlight state
[27659.224453] sound hdaudioC0D3: HDMI: invalid ELD data byte 0
[27659.524644] sound hdaudioC0D3: HDMI: invalid ELD data byte 0
[27659.824755] sound hdaudioC0D3: HDMI: invalid ELD data byte 0
[27660.124905] sound hdaudioC0D3: HDMI: invalid ELD data byte 0
[27660.424985] sound hdaudioC0D3: HDMI: invalid ELD data byte 0
[27660.725150] sound hdaudioC0D3: HDMI: invalid ELD data byte 0
[27661.025198] sound hdaudioC0D3: HDMI: invalid ELD data byte 0
[27661.325413] sound hdaudioC0D3: HDMI: invalid ELD data byte 0
[27662.406074] wl0: link up (wlp2s0)
--
[28200.883590] wl_resume: PCI Resume handler
[28200.883990] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[28200.886693] pciehp 0000:04:00.0:pcie24: Timeout on hotplug command 0x1038 (issued 542730 msec ago)
--
[28314.534439] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[28314.534707] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[28314.534765] wl_resume: PCI Resume handler
--
[28673.591664] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[28673.591971] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[28673.592141] wl_resume: PCI Resume handler
--
[28804.730000] sd 0:0:0:0: [sda] Starting disk
[28804.771017] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[28804.811247] thunderbolt 0000:05:00.0: resetting error on 0:b.
--
[29019.310637] wl_resume: PCI Resume handler
[29019.310917] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[29019.312270] pciehp 0000:04:04.0:pcie24: Timeout on hotplug command 0x1038 (issued 214490 msec ago)
--
[29210.547795] pciehp 0000:04:05.0:pcie24: Timeout on hotplug command 0x1038 (issued 191143 msec ago)
[29210.547936] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[29210.552317] sd 0:0:0:0: [sda] Starting disk
--
[29721.088166] pciehp 0000:04:04.0:pcie24: Timeout on hotplug command 0x1038 (issued 510306 msec ago)
[29721.088400] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[29721.093897] sd 0:0:0:0: [sda] Starting disk
--
[30540.528405] wl_resume: PCI Resume handler
[30540.528549] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[30540.531924] pciehp 0000:04:00.0:pcie24: Timeout on hotplug command 0x1038 (issued 819070 msec ago)
--
[31724.155563] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[31724.155891] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[31724.157702] wl_resume: PCI Resume handler
--
[33575.548401] wl_resume: PCI Resume handler
[33575.548591] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[33575.551329] pciehp 0000:04:00.0:pcie24: Timeout on hotplug command 0x1038 (issued 1850523 msec ago)
--
[33605.681004] pciehp 0000:04:00.0:pcie24: Timeout on hotplug command 0x1038 (issued 30113 msec ago)
[33605.727187] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[33605.727342] sd 0:0:0:0: [sda] Starting disk
--
[33829.704874] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[33829.707343] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[33829.710497] wl_resume: PCI Resume handler
--
[37142.587189] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[37142.587594] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[37142.590239] wl_resume: PCI Resume handler
--
[37171.948804] pciehp 0000:04:00.0:pcie24: Timeout on hotplug command 0x1038 (issued 29340 msec ago)
[37171.948955] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[37171.949011] pciehp 0000:04:03.0:pcie24: Timeout on hotplug command 0x1038 (issued 29340 msec ago)
--
[37202.208363] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[37202.208720] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[37202.211228] wl_resume: PCI Resume handler
--
[37544.801736] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[37544.802119] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[37544.805270] wl_resume: PCI Resume handler
--
[41138.905836] wl_resume: PCI Resume handler
[41138.905923] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[41138.908655] pciehp 0000:04:05.0:pcie24: Timeout on hotplug command 0x1038 (issued 3592356 msec ago)
--
[41169.402025] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[41169.402314] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[41169.402374] wl_resume: PCI Resume handler
--
[41169.747473] ata1.00: configured for UDMA/133
[41170.425480] sound hdaudioC0D0: hda-codec: out of range cmd 0:11:400:ffffffff
[41170.425846] PM: resume of devices complete after 1023.430 msecs
--
[42693.703287] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[42693.703770] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[42693.705654] wl_resume: PCI Resume handler
--
[42771.610474] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[42771.610758] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[42771.610901] wl_resume: PCI Resume handler
--
[42887.962183] wl_resume: PCI Resume handler
[42887.962365] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[42887.965171] pciehp 0000:04:06.0:pcie24: Timeout on hotplug command 0x1038 (issued 116290 msec ago)
--
[42901.228834] WARNING: CPU: 2 PID: 329 at net/wireless/sme.c:791 cfg80211_roamed+0x91/0xa0 [cfg80211]()
[42901.228836] Modules linked in: msr wl(PO) ecb joydev iTCO_wdt iTCO_vendor_support coretemp intel_rapl x86_pkg_temp_thermal intel_powerclamp kvm_intel applesmc led_class input_polldev hwmon snd_hda_codec_hdmi kvm i915 snd_hda_codec_cirrus snd_hda_codec_generic snd_hda_intel bcm5974 cfg80211 evdev snd_hda_controller mousedev mac_hid drm_kms_helper rfkill thunderbolt pcspkr i2c_i801 snd_hda_codec drm snd_hwdep sbs snd_pcm battery sbshc snd_timer intel_gtt mei_me i2c_algo_bit snd i2c_core video ac apple_bl soundcore mei button shpchp lpc_ich processor sch_fq_codel ext4 crc16 mbcache jbd2 algif_skcipher af_alg nls_iso8859_1 hid_generic hid_apple usbhid hid uas usb_storage dm_crypt dm_mod sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul
  glue_helper
[42901.228902]  ablk_helper cryptd ahci libahci libata scsi_mod xhci_pci ehci_pci xhci_hcd ehci_hcd usbcore usb_common vfat fat nls_cp437 [last unloaded: bluetooth]
--
[42918.023119] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[42918.023405] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[42918.023488] wl_resume: PCI Resume handler
--
[42983.110177] WARNING: CPU: 1 PID: 329 at net/wireless/sme.c:791 cfg80211_roamed+0x91/0xa0 [cfg80211]()
[42983.110178] Modules linked in: msr wl(PO) ecb joydev iTCO_wdt iTCO_vendor_support coretemp intel_rapl x86_pkg_temp_thermal intel_powerclamp kvm_intel applesmc led_class input_polldev hwmon snd_hda_codec_hdmi kvm i915 snd_hda_codec_cirrus snd_hda_codec_generic snd_hda_intel bcm5974 cfg80211 evdev snd_hda_controller mousedev mac_hid drm_kms_helper rfkill thunderbolt pcspkr i2c_i801 snd_hda_codec drm snd_hwdep sbs snd_pcm battery sbshc snd_timer intel_gtt mei_me i2c_algo_bit snd i2c_core video ac apple_bl soundcore mei button shpchp lpc_ich processor sch_fq_codel ext4 crc16 mbcache jbd2 algif_skcipher af_alg nls_iso8859_1 hid_generic hid_apple usbhid hid uas usb_storage dm_crypt dm_mod sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul
  glue_helper
[42983.110225]  ablk_helper cryptd ahci libahci libata scsi_mod xhci_pci ehci_pci xhci_hcd ehci_hcd usbcore usb_common vfat fat nls_cp437 [last unloaded: bluetooth]
--
[45608.665202] wl_resume: PCI Resume handler
[45608.665393] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[45608.668455] pciehp 0000:04:03.0:pcie24: Timeout on hotplug command 0x1038 (issued 2689353 msec ago)
--
[46279.336400] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[46279.336965] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[46279.337231] wl_resume: PCI Resume handler
--
[49183.766876] wl_resume: PCI Resume handler
[49183.767091] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[49183.770241] pciehp 0000:04:00.0:pcie24: Timeout on hotplug command 0x1038 (issued 2903046 msec ago)
--
[50084.503103] wl_resume: PCI Resume handler
[50084.503313] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[50084.503988] pciehp 0000:04:00.0:pcie24: Timeout on hotplug command 0x1038 (issued 900303 msec ago)
--
[51188.937840] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[51188.938109] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[51188.938840] sd 0:0:0:0: [sda] Starting disk
--
[55582.265169] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[55582.265581] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[55582.265847] wl_resume: PCI Resume handler
--
[56228.782000] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[56228.782405] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[56228.783317] wl_resume: PCI Resume handler
--
[56292.387615] NET: Unregistered protocol family 31
[56487.227921] snd_hda_intel 0000:00:1b.0: Unstable LPIB (131072 >= 8192); disabling LPIB delay counting
[56713.068171] wl0: link down (wlp2s0)
--
[60541.181932] wl_resume: PCI Resume handler
[60541.182069] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[60541.184030] pciehp 0000:04:00.0:pcie24: Timeout on hotplug command 0x1038 (issued 4310340 msec ago)
--
[60541.524463] ata1.00: configured for UDMA/133
[60542.204601] sound hdaudioC0D0: hda-codec: out of range cmd 0:11:400:ffffffff
[60542.205120] PM: resume of devices complete after 1022.998 msecs
--
[60559.926302] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[60559.926564] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[60559.926769] wl_resume: PCI Resume handler
--
[60580.221653] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[60580.221922] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[60580.221996] wl_resume: PCI Resume handler
--
[61611.579571] pciehp 0000:04:04.0:pcie24: Timeout on hotplug command 0x1038 (issued 1030840 msec ago)
[61611.579996] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[61611.580321] sd 0:0:0:0: [sda] Starting disk
--
[62448.626814] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[62448.627149] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[62448.627395] wl_resume: PCI Resume handler
--
[62662.580789] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[62662.581191] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[62662.586595] wl_resume: PCI Resume handler
--
[62841.546683] wl_resume: PCI Resume handler
[62841.546818] snd_hda_intel 0000:00:1b.0: irq 32 for MSI/MSI-X
[62841.546827] mei_me 0000:00:16.0: irq 34 for MSI/MSI-X
--
[62898.634865] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[62898.635134] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[62898.635221] wl_resume: PCI Resume handler
--
[63029.073214] pciehp 0000:04:06.0:pcie24: Timeout on hotplug command 0x1038 (issued 130720 msec ago)
[63029.075279] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[63029.075801] sd 0:0:0:0: [sda] Starting disk
--
[63126.257829] wl_resume: PCI Resume handler
[63126.257962] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[63126.260316] pciehp 0000:04:00.0:pcie24: Timeout on hotplug command 0x1038 (issued 97536 msec ago)
--
[63188.943528] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[63188.943841] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[63188.944085] wl_resume: PCI Resume handler
--
[63258.626115] mei_me 0000:00:16.0: irq 32 for MSI/MSI-X
[63258.626655] snd_hda_intel 0000:00:1b.0: irq 34 for MSI/MSI-X
[63258.631046] wl_resume: PCI Resume handler




--6TrnltStXW4iwmi0--

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVAMD2AAoJEO5QSAKJUTTFu30H/ia6ORMTvqnhN7lCaIGEi9/c
YdIk+jCLNUqk+cHBMhV+A19bKKPQB9i1EwL6HGTYAiC7+k2HLa+R93GClDNUrceV
S5C/hpU0ko4gp3JvxRGS6asIa0aaCH1Dyg6Qtw18kOBQZuHNAeQg2nZTY+Yw4JID
LQ5W/e7xwjl2UAx0wR1tKygad8QboxPHx5MDcBbB8aD8YEs6jD7knl4sZ5uZG7Lx
22Xzo/ksO8QRXMJuSUPOG+DWfs/nTFSAPPKt14h3Pyu0rpCF0XTqI6nDzSn9F2+k
XKGwwnexNmYhAeiGJoPvcXmt33RWjakVza7NmZZl92ISRDV10qrdRh3VnBFBHXc=
=mFgd
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--

--===============1757855134016359049==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1757855134016359049==--
