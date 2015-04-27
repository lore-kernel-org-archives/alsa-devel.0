From: Gabriele Martino <g.martino@gmx.com>
Subject: Re: Intel HDA / ca0132: support for Alienware 15
 Creative Sound Core3D-EX
Date: Mon, 27 Apr 2015 20:08:52 +0200
Message-ID: <553E7B34.2080501@gmx.com>
References: <553AE4CF.3070805@gmx.com> <s5hh9s2lyz0.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010801030501000700050804"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B19226145B
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 20:08:34 +0200 (CEST)
Received: from [192.168.69.6] ([79.44.224.230]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0LzLJR-1ZQgbG0QQz-014X7m for
 <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 20:08:33 +0200
In-Reply-To: <s5hh9s2lyz0.wl-tiwai@suse.de>
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

This is a multi-part message in MIME format.
--------------010801030501000700050804
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 27/04/2015 11:09, Takashi Iwai wrote:
> In general, we check either PCI or codec SSID to identify the model
> and applies the quirk accordingly.  Does your board have also a unique
> SSID?
Good question. How do I find it? I can't see any in alsa-info.

Regards,
Gabriele

--------------010801030501000700050804
Content-Type: text/plain; charset=UTF-8;
 name="alsa-info.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="alsa-info.txt"

upload=3Dtrue&script=3Dtrue&cardinfo=3D
!!################################
!!ALSA Information Script v 0.4.64
!!################################

!!Script ran on: Mon Apr 27 17:52:38 UTC 2015


!!Linux Distribution
!!------------------

Gentoo Base System release 2.2 DISTRIB_ID=3D"Gentoo" NAME=3DGentoo ID=3Dg=
entoo PRETTY_NAME=3D"Gentoo/Linux" HOME_URL=3D"http://www.gentoo.org/" SU=
PPORT_URL=3D"http://www.gentoo.org/main/en/support.xml" BUG_REPORT_URL=3D=
"https://bugs.gentoo.org/"


!!DMI Information
!!---------------

Manufacturer:      Alienware
Product Name:      Alienware 15
Product Version:   A02
Firmware Version:  A02


!!Kernel Information
!!------------------

Kernel release:    4.0.0-wl-ath+
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         Intel(R) Core(TM) i7-4710HQ CPU @ 2.50GHz
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     k4.0.0-wl-ath+
Library version:    1.0.29
Utilities version:  1.0.29


!!Loaded ALSA modules
!!-------------------

snd_hda_intel
snd_hda_intel


!!Sound Servers on this system
!!----------------------------

Pulseaudio:
      Installed - Yes (/usr/bin/pulseaudio)
      Running - Yes

Jack:
      Installed - Yes (/usr/bin/jackd)
      Running - No


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [HDMI           ]: HDA-Intel - HDA Intel HDMI
                      HDA Intel HDMI at 0xf751c000 irq 42
 1 [PCH            ]: HDA-Intel - HDA Intel PCH
                      HDA Intel PCH at 0xf7518000 irq 41


!!PCI Soundcards installed in the system
!!--------------------------------------

00:03.0 Audio device: Intel Corporation Xeon E3-1200 v3/4th Gen Core Proc=
essor HD Audio Controller (rev 06)
00:1b.0 Audio device: Intel Corporation 8 Series/C220 Series Chipset High=
 Definition Audio Controller (rev 05)


!!Advanced information - PCI Vendor/Device/Subsystem ID's
!!-------------------------------------------------------

00:03.0 0403: 8086:0c0c (rev 06)
	Subsystem: 1028:0685
--
00:1b.0 0403: 8086:8c20 (rev 05)
	Subsystem: 1028:0685


!!Loaded sound module options
!!---------------------------

!!Module: snd_hda_intel
	align_buffer_size : -1
	bdl_pos_adj : 32,1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	enable_msi : -1
	id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(nul=
l),(null),(null)
	index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	jackpoll_ms : 0,0,0,0,0,0,0,0,0,0,0,0
	model : (null),(null),(null),(null),(null),(null),(null),(null),(null),(=
null),(null),(null)
	patch : (null),(null),(null),(null),(null),(null),(null),(null),(null),(=
null),(null),(null)
	position_fix : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	power_save : 60
	power_save_controller : Y
	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	probe_only : 0,0,0,0,0,0,0,0,0,0,0,0
	single_cmd : N
	snoop : -1

!!Module: snd_hda_intel
	align_buffer_size : -1
	bdl_pos_adj : 32,1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	enable_msi : -1
	id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(nul=
l),(null),(null)
	index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	jackpoll_ms : 0,0,0,0,0,0,0,0,0,0,0,0
	model : (null),(null),(null),(null),(null),(null),(null),(null),(null),(=
null),(null),(null)
	patch : (null),(null),(null),(null),(null),(null),(null),(null),(null),(=
null),(null),(null)
	position_fix : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	power_save : 60
	power_save_controller : Y
	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	probe_only : 0,0,0,0,0,0,0,0,0,0,0,0
	single_cmd : N
	snoop : -1


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Intel Haswell HDMI
Address: 0
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x80862807
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
  Power: setting=3DD0, actual=3DD0, Clock-stop-OK
GPIO: io=3D0, o=3D0, i=3D0, unsolicited=3D0, wake=3D0
Node 0x02 [Audio Output] wcaps 0x6611: 8-Channels Digital
  Converter: stream=3D1, channel=3D0
  Digital: Enabled GenLevel KAE
  Digital category: 0x2
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x5]: PCM AC3
  Power states:  D0 D3 EPSS
  Power: setting=3DD0, actual=3DD0
Node 0x03 [Audio Output] wcaps 0x6611: 8-Channels Digital
  Converter: stream=3D0, channel=3D0
  Digital: Enabled KAE
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x5]: PCM AC3
  Power states:  D0 D3 EPSS
  Power: setting=3DD0, actual=3DD0
Node 0x04 [Audio Output] wcaps 0x6611: 8-Channels Digital
  Converter: stream=3D0, channel=3D0
  Digital: Enabled KAE
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x5]: PCM AC3
  Power states:  D0 D3 EPSS
  Power: setting=3DD0, actual=3DD0
Node 0x05 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
  Control: name=3D"HDMI/DP,pcm=3D3 Jack", index=3D0, device=3D0
  Control: name=3D"IEC958 Playback Con Mask", index=3D0, device=3D0
  Control: name=3D"IEC958 Playback Pro Mask", index=3D0, device=3D0
  Control: name=3D"IEC958 Playback Default", index=3D0, device=3D0
  Control: name=3D"IEC958 Playback Switch", index=3D0, device=3D0
  Control: name=3D"ELD", index=3D0, device=3D3
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0b000094: OUT Detect HBR HDMI DP
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn =3D Digital, Color =3D Unknown
    DefAssociation =3D 0x1, Sequence =3D 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=3D01, enabled=3D1
  Power states:  D0 D3 EPSS
  Power: setting=3DD0, actual=3DD0
  Devices: 0
  Connection: 0
  In-driver Connection: 3
     0x02 0x03 0x04
Node 0x06 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
  Control: name=3D"HDMI/DP,pcm=3D7 Jack", index=3D0, device=3D0
  Control: name=3D"IEC958 Playback Con Mask", index=3D1, device=3D0
  Control: name=3D"IEC958 Playback Pro Mask", index=3D1, device=3D0
  Control: name=3D"IEC958 Playback Default", index=3D1, device=3D0
  Control: name=3D"IEC958 Playback Switch", index=3D1, device=3D0
  Control: name=3D"ELD", index=3D0, device=3D7
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0b000094: OUT Detect HBR HDMI DP
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn =3D Digital, Color =3D Unknown
    DefAssociation =3D 0x1, Sequence =3D 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=3D02, enabled=3D1
  Power states:  D0 D3 EPSS
  Power: setting=3DD0, actual=3DD0
  Devices: 0
  Connection: 0
  In-driver Connection: 3
     0x02 0x03 0x04
Node 0x07 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
  Control: name=3D"HDMI/DP,pcm=3D8 Jack", index=3D0, device=3D0
  Control: name=3D"IEC958 Playback Con Mask", index=3D2, device=3D0
  Control: name=3D"IEC958 Playback Pro Mask", index=3D2, device=3D0
  Control: name=3D"IEC958 Playback Default", index=3D2, device=3D0
  Control: name=3D"IEC958 Playback Switch", index=3D2, device=3D0
  Control: name=3D"ELD", index=3D0, device=3D8
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0b000094: OUT Detect HBR HDMI DP
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn =3D Digital, Color =3D Unknown
    DefAssociation =3D 0x1, Sequence =3D 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=3D03, enabled=3D1
  Power states:  D0 D3 EPSS
  Power: setting=3DD0, actual=3DD0
  Devices: 0
  Connection: 0
  In-driver Connection: 3
     0x02 0x03 0x04
Node 0x08 [Vendor Defined Widget] wcaps 0xf00000: Mono
Codec: Creative CA0132
Address: 0
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x11020011
Subsystem Id: 0x10280685
Revision Id: 0x100918
No Modem Function Group found
Default PCM:
    rates [0x0]:
    bits [0x0]:
    formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
  Power states:  D0 D3 D3cold S3D3cold CLKSTOP EPSS
  Power: setting=3DD0, actual=3DD0
GPIO: io=3D0, o=3D0, i=3D0, unsolicited=3D1, wake=3D1
Node 0x02 [Audio Output] wcaps 0x49d: Stereo Amp-Out
  Device: name=3D"CA0132 Analog", type=3D"Audio", device=3D0
  Amp-Out caps: ofs=3D0x5a, nsteps=3D0x63, stepsize=3D0x03, mute=3D1
  Amp-Out vals:  [0x39 0x39]
  Converter: stream=3D8, channel=3D0
  PCM:
    rates [0x5e4]: 16000 44100 48000 88200 96000 192000
    bits [0x1f]: 8 16 20 24 32
    formats [0x1]: PCM
  Unsolicited: tag=3D00, enabled=3D0
  Power states:  D0 D3 EPSS
  Power: setting=3DD0, actual=3DD0
Node 0x03 [Audio Output] wcaps 0x49d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x5a, nsteps=3D0x63, stepsize=3D0x03, mute=3D1
  Amp-Out vals:  [0x5a 0x5a]
  Converter: stream=3D0, channel=3D0
  PCM:
    rates [0x5e4]: 16000 44100 48000 88200 96000 192000
    bits [0x1f]: 8 16 20 24 32
    formats [0x1]: PCM
  Unsolicited: tag=3D00, enabled=3D0
  Power states:  D0 D3 EPSS
  Power: setting=3DD0, actual=3DD0
Node 0x04 [Audio Output] wcaps 0x49d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x5a, nsteps=3D0x63, stepsize=3D0x03, mute=3D1
  Amp-Out vals:  [0x5a 0x5a]
  Converter: stream=3D0, channel=3D0
  PCM:
    rates [0x5e4]: 16000 44100 48000 88200 96000 192000
    bits [0x1f]: 8 16 20 24 32
    formats [0x1]: PCM
  Unsolicited: tag=3D00, enabled=3D0
  Power states:  D0 D3 EPSS
  Power: setting=3DD0, actual=3DD0
Node 0x05 [Audio Output] wcaps 0x691: Stereo Digital
  Control: name=3D"IEC958 Playback Con Mask", index=3D0, device=3D0
  Control: name=3D"IEC958 Playback Pro Mask", index=3D0, device=3D0
  Control: name=3D"IEC958 Playback Default", index=3D0, device=3D0
  Control: name=3D"IEC958 Playback Switch", index=3D0, device=3D0
  Control: name=3D"IEC958 Default PCM Playback Switch", index=3D0, device=
=3D0
  Device: name=3D"CA0132 Digital", type=3D"SPDIF", device=3D1
  Converter: stream=3D0, channel=3D0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0x1e]: 16 20 24 32
    formats [0x5]: PCM AC3
  Unsolicited: tag=3D00, enabled=3D0
  Power states:  D0 D3 EPSS
  Power: setting=3DD0, actual=3DD0
Node 0x06 [Audio Output] wcaps 0x691: Stereo Digital
  Converter: stream=3D0, channel=3D0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0x1e]: 16 20 24 32
    formats [0x5]: PCM AC3
  Unsolicited: tag=3D00, enabled=3D0
  Power states:  D0 D3 EPSS
  Power: setting=3DD0, actual=3DD0
Node 0x07 [Audio Input] wcaps 0x100591: Stereo
  Device: name=3D"CA0132 Analog", type=3D"Audio", device=3D0
  Converter: stream=3D0, channel=3D0
  SDI-Select: 0
  PCM:
    rates [0x1e4]: 16000 44100 48000 88200 96000
    bits [0x1f]: 8 16 20 24 32
    formats [0x1]: PCM
  Unsolicited: tag=3D00, enabled=3D0
  Power states:  D0 D3 EPSS
  Power: setting=3DD0, actual=3DD0
  Connection: 1
     0x12
Node 0x08 [Audio Input] wcaps 0x10059b: Stereo Amp-In
  Control: name=3D"Analog-Mic2 Capture Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
  Control: name=3D"Analog-Mic2 Capture Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
  Device: name=3D"CA0132 Analog Mic-In2", type=3D"Audio", device=3D2
  Amp-In caps: ofs=3D0x5a, nsteps=3D0x63, stepsize=3D0x03, mute=3D1
  Amp-In vals:  [0x5a 0x5a]
  Converter: stream=3D0, channel=3D0
  SDI-Select: 0
  PCM:
    rates [0x1e4]: 16000 44100 48000 88200 96000
    bits [0x1f]: 8 16 20 24 32
    formats [0x1]: PCM
  Unsolicited: tag=3D00, enabled=3D0
  Power states:  D0 D3 EPSS
  Power: setting=3DD0, actual=3DD0
  Connection: 1
     0x11
Node 0x09 [Audio Input] wcaps 0x100791: Stereo Digital
  Control: name=3D"IEC958 Capture Switch", index=3D0, device=3D0
  Control: name=3D"IEC958 Capture Default", index=3D0, device=3D0
  Device: name=3D"CA0132 Digital", type=3D"SPDIF", device=3D1
  Converter: stream=3D0, channel=3D0
  SDI-Select: 0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x1f0]: 32000 44100 48000 88200 96000
    bits [0x1a]: 16 24 32
    formats [0x1]: PCM
  Unsolicited: tag=3D00, enabled=3D0
  Power states:  D0 D3 EPSS
  Power: setting=3DD0, actual=3DD0
  Connection: 1
     0x0e
Node 0x0a [Audio Input] wcaps 0x10079b: Stereo Digital Amp-In
  Control: name=3D"What U Hear Capture Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
  Control: name=3D"What U Hear Capture Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
  Device: name=3D"CA0132 What U Hear", type=3D"Audio", device=3D4
  Amp-In caps: ofs=3D0x5a, nsteps=3D0x63, stepsize=3D0x03, mute=3D1
  Amp-In vals:  [0x5a 0x5a]
  Converter: stream=3D0, channel=3D0
  SDI-Select: 0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x1ec]: 16000 22050 44100 48000 88200 96000
    bits [0x1b]: 8 16 24 32
    formats [0x1]: PCM
  Unsolicited: tag=3D00, enabled=3D0
  Power states:  D0 D3 EPSS
  Power: setting=3DD0, actual=3DD0
  Connection: 1
     0x13
Node 0x0b [Pin Complex] wcaps 0x400581: Stereo
  Control: name=3D"Speaker Phantom Jack", index=3D0, device=3D0
  Pincap 0x00010014: OUT EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x01014010: [Jack] Line Out at Ext Rear
    Conn =3D 1/8, Color =3D Green
    DefAssociation =3D 0x1, Sequence =3D 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=3D00, enabled=3D0
  Power states:  D0 D3 EPSS
  Power: setting=3DD0, actual=3DD0
  Connection: 1
     0x02
Node 0x0c [Pin Complex] wcaps 0x400701: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x014580f0: [Jack] SPDIF Out at Ext Rear
    Conn =3D Optical, Color =3D Purple
    DefAssociation =3D 0xf, Sequence =3D 0x0
  Pin-ctls: 0x00:
  Power states:  D0 D3 EPSS
  Power: setting=3DD0, actual=3DD0
  Connection: 1
     0x05
Node 0x0d [Pin Complex] wcaps 0x400701: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x014570f0: [Jack] SPDIF Out at Ext Rear
    Conn =3D Optical, Color =3D Yellow
    DefAssociation =3D 0xf, Sequence =3D 0x0
  Pin-ctls: 0x00:
  Power states:  D0 D3 EPSS
  Power: setting=3DD0, actual=3DD0
  Connection: 1
     0x06
Node 0x0e [Pin Complex] wcaps 0x400681: Stereo Digital
  Pincap 0x00000020: IN
  Pin Default 0x01c530f0: [Jack] SPDIF In at Ext Rear
    Conn =3D Optical, Color =3D Blue
    DefAssociation =3D 0xf, Sequence =3D 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=3D00, enabled=3D0
  Power states:  D0 D3 EPSS
  Power: setting=3DD0, actual=3DD0
Node 0x0f [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x0000001c: OUT HP Detect
  Pin Default 0x0221401f: [Jack] HP Out at Ext Front
    Conn =3D 1/8, Color =3D Green
    DefAssociation =3D 0x1, Sequence =3D 0xf
  Pin-ctls: 0x00:
  Unsolicited: tag=3D00, enabled=3D0
  Power states:  D0 D3 EPSS
  Power: setting=3DD0, actual=3DD0
  Connection: 1
     0x02
Node 0x10 [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x0000001c: OUT HP Detect
  Pin Default 0x02216011: [Jack] HP Out at Ext Front
    Conn =3D 1/8, Color =3D Orange
    DefAssociation =3D 0x1, Sequence =3D 0x1
  Pin-ctls: 0x00:
  Unsolicited: tag=3D01, enabled=3D1
  Power states:  D0 D3 EPSS
  Power: setting=3DD0, actual=3DD0
  Connection: 1
     0x03
Node 0x11 [Pin Complex] wcaps 0x40058b: Stereo Amp-In
  Control: name=3D"Line Jack", index=3D0, device=3D0
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000134: IN OUT Detect
    Vref caps: HIZ
  Pin Default 0x02012014: [Jack] Line Out at Ext Front
    Conn =3D 1/8, Color =3D Grey
    DefAssociation =3D 0x1, Sequence =3D 0x4
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=3D04, enabled=3D1
  Power states:  D0 D3 EPSS
  Power: setting=3DD0, actual=3DD0
  Connection: 1
     0x04
Node 0x12 [Pin Complex] wcaps 0x400481: Stereo
  Control: name=3D"Mic1-Boost (30dB) Capture Switch", index=3D0, device=3D=
0
    ControlAmp: chs=3D1, dir=3DIn, idx=3D0, ofs=3D0
  Control: name=3D"Mic Phantom Jack", index=3D0, device=3D0
  Pincap 0x00003724: IN Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x37a791f0: [Jack] Mic at Oth Mobile-In
    Conn =3D Analog, Color =3D Pink
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=3D02, enabled=3D1
  Power states:  D0 D3 EPSS
  Power: setting=3DD0, actual=3DD0
Node 0x13 [Pin Complex] wcaps 0x400681: Stereo Digital
  Pincap 0x00000020: IN
  Pin Default 0x908700f0: [Fixed] Line In at Int N/A
    Conn =3D Analog, Color =3D Unknown
    DefAssociation =3D 0xf, Sequence =3D 0x0
  Pin-ctls: 0x20: IN
  Unsolicited: tag=3D00, enabled=3D0
  Power states:  D0 D3 EPSS
  Power: setting=3DD0, actual=3DD0
Node 0x14 [Beep Generator Widget] wcaps 0x70040c: Mono Amp-Out
  Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
  Amp-Out vals:  [0x1c]
  Power states:  D0 D3 EPSS
  Power: setting=3DD0, actual=3DD0
Node 0x15 [Vendor Defined Widget] wcaps 0xf00600: Mono Digital
  Power states:  D0 D3 EPSS
  Power: setting=3DD0, actual=3DD0
Node 0x16 [Vendor Defined Widget] wcaps 0xf00680: Mono Digital
  Unsolicited: tag=3D03, enabled=3D1
  Power states:  D0 D3 EPSS
  Power: setting=3DD0, actual=3DD0
Node 0x17 [Audio Output] wcaps 0x49d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x5a, nsteps=3D0x63, stepsize=3D0x03, mute=3D1
  Amp-Out vals:  [0x5a 0x5a]
  Converter: stream=3D0, channel=3D0
  PCM:
    rates [0x5ec]: 16000 22050 44100 48000 88200 96000 192000
    bits [0x1f]: 8 16 20 24 32
    formats [0x1]: PCM
  Unsolicited: tag=3D00, enabled=3D0
  Power states:  D0 D3 EPSS
  Power: setting=3DD0, actual=3DD0
Node 0x18 [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x00000010: OUT
  Pin Default 0x500000f0: [N/A] Line Out at Int N/A
    Conn =3D Unknown, Color =3D Unknown
    DefAssociation =3D 0xf, Sequence =3D 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=3D00, enabled=3D0
  Power states:  D0 D3 EPSS
  Power: setting=3DD0, actual=3DD0
  Connection: 1
     0x17
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116, 10 Apr 27 19:43 /dev/snd/controlC0
crw-rw----+ 1 root audio 116,  2 Apr 27 19:43 /dev/snd/controlC1
crw-rw----+ 1 root audio 116, 14 Apr 27 19:43 /dev/snd/hwC0D0
crw-rw----+ 1 root audio 116,  9 Apr 27 19:43 /dev/snd/hwC1D0
crw-rw----+ 1 root audio 116, 11 Apr 27 19:49 /dev/snd/pcmC0D3p
crw-rw----+ 1 root audio 116, 12 Apr 27 19:43 /dev/snd/pcmC0D7p
crw-rw----+ 1 root audio 116, 13 Apr 27 19:43 /dev/snd/pcmC0D8p
crw-rw----+ 1 root audio 116,  4 Apr 27 19:44 /dev/snd/pcmC1D0c
crw-rw----+ 1 root audio 116,  3 Apr 27 19:49 /dev/snd/pcmC1D0p
crw-rw----+ 1 root audio 116,  8 Apr 27 19:43 /dev/snd/pcmC1D1c
crw-rw----+ 1 root audio 116,  7 Apr 27 19:43 /dev/snd/pcmC1D1p
crw-rw----+ 1 root audio 116,  5 Apr 27 19:43 /dev/snd/pcmC1D2c
crw-rw----+ 1 root audio 116,  6 Apr 27 19:43 /dev/snd/pcmC1D4c
crw-rw----+ 1 root audio 116,  1 Apr 27 19:43 /dev/snd/seq
crw-rw----+ 1 root audio 116, 33 Apr 27 19:43 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  80 Apr 27 19:51 .
drwxr-xr-x 3 root root 360 Apr 27 19:51 ..
lrwxrwxrwx 1 root root  12 Apr 27 19:43 pci-0000:00:03.0 -> ../controlC0
lrwxrwxrwx 1 root root  12 Apr 27 19:43 pci-0000:00:1b.0 -> ../controlC1


!!Aplay/Arecord output
!!--------------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: HDMI [HDA Intel HDMI], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: HDMI [HDA Intel HDMI], device 7: HDMI 1 [HDMI 1]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: HDMI [HDA Intel HDMI], device 8: HDMI 2 [HDMI 2]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: PCH [HDA Intel PCH], device 0: CA0132 Analog [CA0132 Analog]
  Subdevices: 0/1
  Subdevice #0: subdevice #0
card 1: PCH [HDA Intel PCH], device 1: CA0132 Digital [CA0132 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 1: PCH [HDA Intel PCH], device 0: CA0132 Analog [CA0132 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: PCH [HDA Intel PCH], device 1: CA0132 Digital [CA0132 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: PCH [HDA Intel PCH], device 2: CA0132 Analog Mic-In2 [CA0132 Anal=
og Mic-In2]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: PCH [HDA Intel PCH], device 4: CA0132 What U Hear [CA0132 What U =
Hear]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [HDMI]

Card hw:0 'HDMI'/'HDA Intel HDMI at 0xf751c000 irq 42'
  Mixer name	: 'Intel Haswell HDMI'
  Components	: 'HDA:80862807,80860101,00100000'
  Controls      : 21
  Simple ctrls  : 3
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958',1
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958',2
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]

!!-------Mixer controls for card 1 [PCH]

Card hw:1 'PCH'/'HDA Intel PCH at 0xf7518000 irq 41'
  Mixer name	: 'Creative CA0132'
  Components	: 'HDA:11020011,10280685,00100918'
  Controls      : 43
  Simple ctrls  : 25
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 99
  Mono:
  Front Left: Playback 57 [58%] [-33.00dB] [on]
  Front Right: Playback 57 [58%] [-33.00dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 255 [100%] [0.00dB]
  Front Right: Playback 255 [100%] [0.00dB]
Simple mixer control 'Surround',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Mic SVM',0
  Capabilities: cswitch cswitch-joined
  Capture channels: Mono
  Mono: Capture [on]
Simple mixer control 'Mic1-Boost (30dB)',0
  Capabilities: cswitch cswitch-joined
  Capture channels: Mono
  Mono: Capture [off]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined cswitch cswitch-joined
  Playback channels: Mono
  Capture channels: Mono
  Mono: Playback [off] Capture [off]
Simple mixer control 'IEC958 Default PCM',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 99
  Front Left: Capture 90 [91%] [0.00dB] [off]
  Front Right: Capture 90 [91%] [0.00dB] [off]
Simple mixer control 'AMic1/DMic',0
  Capabilities: cswitch cswitch-joined
  Capture channels: Mono
  Mono: Capture [off]
Simple mixer control 'AMic1/DMic Auto Detect',0
  Capabilities: cswitch cswitch-joined
  Capture channels: Mono
  Mono: Capture [off]
Simple mixer control 'Analog-Mic2',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 99
  Front Left: Capture 90 [91%] [0.00dB] [on]
  Front Right: Capture 90 [91%] [0.00dB] [on]
Simple mixer control 'CrystalVoice',0
  Capabilities: cswitch cswitch-joined
  Capture channels: Mono
  Mono: Capture [off]
Simple mixer control 'Crystalizer',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Dialog Plus',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Echo Cancellation',0
  Capabilities: cswitch cswitch-joined
  Capture channels: Mono
  Mono: Capture [off]
Simple mixer control 'Equalizer',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'HP/Speaker',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'HP/Speaker Auto Detect',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Noise Reduction',0
  Capabilities: cswitch cswitch-joined
  Capture channels: Mono
  Mono: Capture [on]
Simple mixer control 'PlayEnhancement',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Smart Volume',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Voice Focus',0
  Capabilities: cswitch cswitch-joined
  Capture channels: Mono
  Mono: Capture [on]
Simple mixer control 'VoiceFX',0
  Capabilities: cenum
  Items: 'Neutral' 'Female2Male' 'Male2Female' 'ScrappyKid' 'Elderly' 'Or=
c' 'Elf' 'Dwarf' 'AlienBrute' 'Robot' 'Marine' 'Emo' 'DeepVoice' 'Munchki=
n'
  Item0: 'Neutral'
Simple mixer control 'What U Hear',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 99
  Front Left: Capture 90 [91%] [0.00dB] [on]
  Front Right: Capture 90 [91%] [0.00dB] [on]
Simple mixer control 'X-Bass',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]


!!Alsactl output
!!--------------

--startcollapse--
state.HDMI {
	control.1 {
		iface CARD
		name 'HDMI/DP,pcm=3D3 Jack'
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
		value '0fff000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.3 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.4 {
		iface MIXER
		name 'IEC958 Playback Default'
		value '0482000200000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000'
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
		iface CARD
		name 'HDMI/DP,pcm=3D7 Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.8 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		index 1
		value '0fff000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.9 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		index 1
		value '0f00000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.10 {
		iface MIXER
		name 'IEC958 Playback Default'
		index 1
		value '0400000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.11 {
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
	control.12 {
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
	control.13 {
		iface CARD
		name 'HDMI/DP,pcm=3D8 Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.14 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		index 2
		value '0fff000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.15 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		index 2
		value '0f00000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.16 {
		iface MIXER
		name 'IEC958 Playback Default'
		index 2
		value '0400000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.17 {
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
	control.18 {
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
	control.19 {
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
	control.20 {
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
	control.21 {
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
}
state.PCH {
	control.1 {
		iface MIXER
		name 'Master Playback Volume'
		value.0 57
		value.1 57
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 99'
			dbmin -9000
			dbmax 900
			dbvalue.0 -3300
			dbvalue.1 -3300
		}
	}
	control.2 {
		iface MIXER
		name 'Master Playback Switch'
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
		name 'Capture Volume'
		value.0 90
		value.1 90
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 99'
			dbmin -9000
			dbmax 900
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.4 {
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
	control.5 {
		iface MIXER
		name 'Analog-Mic2 Capture Volume'
		value.0 90
		value.1 90
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 99'
			dbmin -9000
			dbmax 900
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.6 {
		iface MIXER
		name 'Analog-Mic2 Capture Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.7 {
		iface MIXER
		name 'What U Hear Capture Volume'
		value.0 90
		value.1 90
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 99'
			dbmin -9000
			dbmax 900
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.8 {
		iface MIXER
		name 'What U Hear Capture Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.9 {
		iface MIXER
		name 'Mic1-Boost (30dB) Capture Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.10 {
		iface MIXER
		name 'HP/Speaker Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.11 {
		iface MIXER
		name 'AMic1/DMic Capture Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.12 {
		iface MIXER
		name 'HP/Speaker Auto Detect Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.13 {
		iface MIXER
		name 'AMic1/DMic Auto Detect Capture Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.14 {
		iface MIXER
		name 'Surround Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.15 {
		iface MIXER
		name 'Crystalizer Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.16 {
		iface MIXER
		name 'Dialog Plus Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.17 {
		iface MIXER
		name 'Smart Volume Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.18 {
		iface MIXER
		name 'X-Bass Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.19 {
		iface MIXER
		name 'Equalizer Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.20 {
		iface MIXER
		name 'Echo Cancellation Capture Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.21 {
		iface MIXER
		name 'Voice Focus Capture Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.22 {
		iface MIXER
		name 'Mic SVM Capture Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.23 {
		iface MIXER
		name 'Noise Reduction Capture Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.24 {
		iface MIXER
		name 'PlayEnhancement Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.25 {
		iface MIXER
		name 'CrystalVoice Capture Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.26 {
		iface MIXER
		name 'VoiceFX Capture Switch'
		value Neutral
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Neutral
			item.1 Female2Male
			item.2 Male2Female
			item.3 ScrappyKid
			item.4 Elderly
			item.5 Orc
			item.6 Elf
			item.7 Dwarf
			item.8 AlienBrute
			item.9 Robot
			item.10 Marine
			item.11 Emo
			item.12 DeepVoice
			item.13 Munchkin
		}
	}
	control.27 {
		iface CARD
		name 'Mic Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.28 {
		iface CARD
		name 'Line Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.29 {
		iface CARD
		name 'Speaker Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.30 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.31 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.32 {
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.33 {
		iface MIXER
		name 'IEC958 Playback Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.34 {
		iface MIXER
		name 'IEC958 Default PCM Playback Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.35 {
		iface MIXER
		name 'IEC958 Capture Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.36 {
		iface MIXER
		name 'IEC958 Capture Default'
		value '0400000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.37 {
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
	control.38 {
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
	control.39 {
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
	control.40 {
		iface PCM
		device 4
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
	control.41 {
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
	control.42 {
		iface PCM
		device 1
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
	control.43 {
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
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
bbswitch
joydev
snd_usb_audio
snd_usbmidi_lib
snd_rawmidi
ath3k
btusb
bluetooth
uvcvideo
videobuf2_vmalloc
videobuf2_memops
videobuf2_core
hid_generic
snd_hda_codec_ca0132
snd_hda_codec_hdmi
iTCO_wdt
iTCO_vendor_support
rtsx_pci_sdmmc
rtsx_pci_ms
mmc_core
memstick
x86_pkg_temp_thermal
intel_powerclamp
kvm_intel
dell_wmi
sparse_keymap
kvm
crct10dif_pclmul
crc32_pclmul
crc32c_intel
ghash_clmulni_intel
aesni_intel
aes_x86_64
glue_helper
lrw
ablk_helper
snd_soc_rt5640
cryptd
snd_hda_intel
ath10k_pci
regmap_i2c
snd_hda_controller
snd_soc_rl6231
microcode
alx
snd_hda_codec
ath10k_core
snd_soc_core
psmouse
mdio
serio_raw
rtsx_pci
snd_compress
snd_hwdep
efivars
lpc_ich
ehci_pci
snd_pcm
int3403_thermal
int3402_thermal
ath
ehci_hcd
mfd_core
wmi
int340x_thermal_zone
i2c_designware_platform
spi_pxa2xx_platform
shpchp
i2c_designware_core
acpi_pad
evdev
int3400_thermal
acpi_thermal_rel
vboxnetflt
vboxnetadp
vboxdrv
snd_seq_oss
snd_seq_midi_event
snd_seq
snd_seq_device
snd_timer
snd
uinput
ftdi_sio
usbserial
coretemp
tun
efivarfs


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x05 0x18560010
0x06 0x18560010
0x07 0x18560010

/sys/class/sound/hwC0D0/driver_pin_configs:

/sys/class/sound/hwC0D0/user_pin_configs:

/sys/class/sound/hwC0D0/init_verbs:

/sys/class/sound/hwC0D0/hints:

/sys/class/sound/hwC1D0/init_pin_configs:
0x0b 0x901701f0
0x0c 0x434510f0
0x0d 0x414510f0
0x0e 0x50c600f0
0x0f 0x432110f0
0x10 0x432110f0
0x11 0x038110f0
0x12 0xb7a601f0
0x13 0x50d000f0
0x18 0x500000f0

/sys/class/sound/hwC1D0/driver_pin_configs:

/sys/class/sound/hwC1D0/user_pin_configs:

/sys/class/sound/hwC1D0/init_verbs:

/sys/class/sound/hwC1D0/hints:


!!ALSA/HDA dmesg
!!--------------

[    2.382711] hub 4-0:1.0: 2 ports detected
[    2.384378] snd_hda_intel 0000:00:03.0: enabling device (0000 -> 0002)=

[    2.384591] snd_hda_intel 0000:00:03.0: bound 0000:00:02.0 (ops 0xffff=
ffff81872ac0)
[    2.392654] snd_hda_intel 0000:00:1b.0: enabling device (0000 -> 0002)=

[    2.395829] iTCO_vendor_support: vendor-support=3D0
--
[    2.408150] iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D0)
[    2.416384] sound hdaudioC1D0: autoconfig for CA0132: line_outs=3D1 (0=
xb/0x0/0x0/0x0/0x0) type:speaker
[    2.416387] sound hdaudioC1D0:    speaker_outs=3D0 (0x0/0x0/0x0/0x0/0x=
0)
[    2.416388] sound hdaudioC1D0:    hp_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
[    2.416389] sound hdaudioC1D0:    mono: mono_out=3D0x0
[    2.416390] sound hdaudioC1D0:    inputs:
[    2.416391] sound hdaudioC1D0:      Mic=3D0x12
[    2.416392] sound hdaudioC1D0:      Line=3D0x11
[    2.449249] hid-generic 0003:187C:0528.0001: hiddev0,hidraw0: USB HID =
v1.01 Device [Alienware AW1517] on usb-0000:00:14.0-4/input0
--
[    3.230416] usb 1-2.2.3.3: new low-speed USB device number 11 using xh=
ci_hcd
[    3.259240] input: HDA Intel PCH Line as /devices/pci0000:00/0000:00:1=
b.0/sound/card1/input12
[    3.319711] usb 1-2.2.3.3: ep 0x81 - rounding interval to 128 microfra=
mes, ep desc says 192 microframes
--
[    3.384431] input: Gaming Keyboard G110 as /devices/pci0000:00/0000:00=
:14.0/usb1/1-2/1-2.2/1-2.2.3/1-2.2.3.3/1-2.2.3.3:1.1/0003:046D:C22A.0005/=
input/input14
[    3.413847] input: HDA Intel HDMI HDMI/DP,pcm=3D3 as /devices/pci0000:=
00/0000:00:03.0/sound/card0/input15
[    3.418785] ath10k_pci 0000:03:00.0: qca6174 hw2.1 (0x05010000, 0x0034=
05ff, 168c:003e:1a56:1525 fallback) fw killer-n1525-fw api 4 htt 3.0 wmi =
4 cal otp max_sta 32
[    3.418788] ath10k_pci 0000:03:00.0: debug 1 debugfs 0 tracing 0 dfs 0=
 testmode 0
[    3.437485] input: HDA Intel HDMI HDMI/DP,pcm=3D7 as /devices/pci0000:=
00/0000:00:03.0/sound/card0/input16
[    3.437680] hid-generic 0003:046D:C22A.0005: input,hiddev0,hidraw4: US=
B HID v1.10 Device [Gaming Keyboard G110] on usb-0000:00:14.0-2.2.3.3/inp=
ut1
[    3.437773] input: HDA Intel HDMI HDMI/DP,pcm=3D8 as /devices/pci0000:=
00/0000:00:03.0/sound/card0/input17
[    3.454972] EXT4-fs (sda3): mounted filesystem with writeback data mod=
e. Opts: data=3Dwriteback
--
[    3.715256] hid-generic 0003:06A3:0CD5.0006: input,hidraw5: USB HID v1=
=2E11 Mouse [Saitek Cyborg R.A.T.5 Mouse] on usb-0000:00:14.0-2.2.3.4/inp=
ut0
[    3.744363] usbcore: registered new interface driver snd-usb-audio
[    3.785101] input: SynPS/2 Synaptics TouchPad as /devices/platform/i80=
42/serio1/input/input7



--------------010801030501000700050804
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------010801030501000700050804--
