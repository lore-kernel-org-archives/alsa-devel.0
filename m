From: Greg Farrell <greg@gregfarrell.org>
Subject: Re: Patch to enable audio on alc888 vendor id
 0x10ec0888 revision id 0x100202
Date: Mon, 06 Oct 2014 15:52:36 +0100
Message-ID: <5432ACB4.6060202@gregfarrell.org>
References: <5432A439.1050909@gregfarrell.org> <s5h4mvhxom4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gregfarrell.org (mail.gregfarrell.org [64.62.190.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 7283B260579
 for <alsa-devel@alsa-project.org>; Mon,  6 Oct 2014 16:52:42 +0200 (CEST)
In-Reply-To: <s5h4mvhxom4.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Kailang Yang <kailang@realtek.com>
List-Id: alsa-devel@alsa-project.org

On 06/10/14 15:24, Takashi Iwai wrote:
> Is the chip really identified as ALC888 by the driver? Please give 
> alsa-info.sh output (run with --no-upload option), just to be sure. 
> The same codec ID (10ec:0888) is used by various chips, so we may need 
> to use a different thing to check the validity of alc888_coef_init() 
> application. thanks, Takashi

It is. One other thing of note is that there is a 'SKU not ready' error.

I originally intended to just cut & paste enough content from the 
alsa-info.sh output file to show it is detected as a ALC888 chip but 
figured that I was better giving you everything rather than filtering 
based on what I feel is helpful to you. Apologies for the size of the email.

This is from a FC20 machine running 3.17rc7. Output is very similar on 
Fedora 18 / 3.11 kernel where it is also detected as ALC888 and the 
behaviour is identical.

Greg




upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.64
!!################################

!!Script ran on: Thu Oct  2 10:47:45 UTC 2014


!!Linux Distribution
!!------------------

Fedora release 20 (Heisenbug) Fedora release 20 (Heisenbug) NAME=Fedora ID=fedora PRETTY_NAME="Fedora 20 (Heisenbug)" CPE_NAME="cpe:/o:fedoraproject:fedora:20" HOME_URL="https://fedoraproject.org/" BUG_REPORT_URL="https://bugzilla.redhat.com/" REDHAT_BUGZILLA_PRODUCT="Fedora" REDHAT_BUGZILLA_PRODUCT_VERSION=20 REDHAT_SUPPORT_PRODUCT="Fedora" REDHAT_SUPPORT_PRODUCT_VERSION=20 Fedora release 20 (Heisenbug) Fedora release 20 (Heisenbug)


!!DMI Information
!!---------------

Manufacturer:      JAOtech Limited
Product Name:      JAO-ATOM-L-N270-945GSE-00
Product Version:   6.0
Firmware Version:  6.00 PG


!!Kernel Information
!!------------------

Kernel release:    3.17.0-0.rc7.git0.1.vanilla.mainline.knurd.1.fc20.i686
Operating System:  GNU/Linux
Architecture:      i686
Processor:         i686
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     k3.17.0-0.rc7.git0.1.vanilla.mainline.knurd.1.fc20.i686
Library version:
Utilities version:  1.0.27.2


!!Loaded ALSA modules
!!-------------------

snd_hda_intel


!!Sound Servers on this system
!!----------------------------

Pulseaudio:
       Installed - Yes (/usr/bin/pulseaudio)
       Running - Yes


!!Soundcards recognised by ALSA
!!-----------------------------

  0 [Intel          ]: HDA-Intel - HDA Intel
                       HDA Intel at 0xfdff8000 irq 26


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation NM10/ICH7 Family High Definition Audio Controller (rev 02)


!!Advanced information - PCI Vendor/Device/Subsystem ID's
!!-------------------------------------------------------

00:1b.0 0403: 8086:27d8 (rev 02)
	Subsystem: 8086:27d8


!!Loaded sound module options
!!---------------------------

!!Module: snd_hda_intel
	align_buffer_size : -1
	bdl_pos_adj : 1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	beep_mode : N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	enable_msi : -1
	id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	jackpoll_ms : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	model : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	patch : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	position_fix : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	power_save : 0
	power_save_controller : Y
	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	probe_only : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	single_cmd : N
	snoop : Y


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Realtek ALC888
Address: 0
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x10ec0888
Subsystem Id: 0xe6fe0000
Revision Id: 0x100202
No Modem Function Group found
Default PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
   Power states:  D0 D1 D2 D3 CLKSTOP
   Power: setting=D0, actual=D0
GPIO: io=2, o=0, i=0, unsolicited=1, wake=1
   IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
   IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Node 0x02 [Audio Output] wcaps 0x411: Stereo
   Device: name="ALC888 Analog", type="Audio", device=0
   Converter: stream=5, channel=0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
Node 0x03 [Audio Output] wcaps 0x411: Stereo
   Converter: stream=5, channel=0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
Node 0x04 [Audio Output] wcaps 0x411: Stereo
   Converter: stream=5, channel=0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
Node 0x05 [Audio Output] wcaps 0x411: Stereo
   Converter: stream=0, channel=0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
Node 0x06 [Audio Output] wcaps 0x611: Stereo Digital
   Control: name="IEC958 Playback Con Mask", index=0, device=0
   Control: name="IEC958 Playback Pro Mask", index=0, device=0
   Control: name="IEC958 Playback Default", index=0, device=0
   Control: name="IEC958 Playback Switch", index=0, device=0
   Control: name="IEC958 Default PCM Playback Switch", index=0, device=0
   Device: name="ALC888 Digital", type="SPDIF", device=1
   Converter: stream=5, channel=0
   Digital:
   Digital category: 0x0
   IEC Coding Type: 0x0
   PCM:
     rates [0x5e0]: 44100 48000 88200 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x08 [Audio Input] wcaps 0x10051b: Stereo Amp-In
   Control: name="Capture Volume", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=0, ofs=0
   Control: name="Capture Switch", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=0, ofs=0
   Device: name="ALC888 Analog", type="Audio", device=0
   Amp-In caps: ofs=0x0b, nsteps=0x1f, stepsize=0x05, mute=1
   Amp-In vals:  [0x1e 0x1e]
   Converter: stream=1, channel=0
   SDI-Select: 0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
   Connection: 1
      0x23
Node 0x09 [Audio Input] wcaps 0x10051b: Stereo Amp-In
   Control: name="Capture Volume", index=1, device=0
     ControlAmp: chs=3, dir=In, idx=0, ofs=0
   Control: name="Capture Switch", index=1, device=0
     ControlAmp: chs=3, dir=In, idx=0, ofs=0
   Device: name="ALC888 Alt Analog", type="Audio", device=2
   Amp-In caps: ofs=0x0b, nsteps=0x1f, stepsize=0x05, mute=1
   Amp-In vals:  [0x80 0x80]
   Converter: stream=0, channel=0
   SDI-Select: 0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
   Connection: 1
      0x22
Node 0x0a [Audio Input] wcaps 0x100711: Stereo Digital
   Converter: stream=0, channel=0
   SDI-Select: 0
   Digital:
   Digital category: 0x0
   IEC Coding Type: 0x0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
   Connection: 1
      0x1f
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
   Control: name="Mic Playback Volume", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=1, ofs=0
   Control: name="Mic Playback Switch", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=1, ofs=0
   Control: name="Mic Playback Volume", index=1, device=0
     ControlAmp: chs=3, dir=In, idx=0, ofs=0
   Control: name="Mic Playback Switch", index=1, device=0
     ControlAmp: chs=3, dir=In, idx=0, ofs=0
   Control: name="Beep Playback Volume", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=5, ofs=0
   Control: name="Beep Playback Switch", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=5, ofs=0
   Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
   Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x1f 0x1f] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
   Connection: 10
      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17
Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
   Control: name="Front Playback Volume", index=0, device=0
     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x00 0x00]
   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
   Amp-Out vals:  [0x1f 0x1f]
   Connection: 2
      0x02 0x0b
Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
   Control: name="Surround Playback Volume", index=0, device=0
     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x80 0x80] [0x80 0x80]
   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
   Amp-Out vals:  [0x1f 0x1f]
   Connection: 2
      0x03 0x0b
Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
   Control: name="Center Playback Volume", index=0, device=0
     ControlAmp: chs=1, dir=Out, idx=0, ofs=0
   Control: name="LFE Playback Volume", index=0, device=0
     ControlAmp: chs=2, dir=Out, idx=0, ofs=0
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x80 0x80] [0x80 0x80]
   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
   Amp-Out vals:  [0x1f 0x1f]
   Connection: 2
      0x04 0x0b
Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x80 0x80]
   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
   Amp-Out vals:  [0x00 0x00]
   Connection: 2
      0x05 0x0b
Node 0x10 [Audio Output] wcaps 0x611: Stereo Digital
   Converter: stream=0, channel=0
   Digital:
   Digital category: 0x0
   IEC Coding Type: 0x0
   PCM:
     rates [0x5e0]: 44100 48000 88200 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
Node 0x11 [Pin Complex] wcaps 0x400780: Mono Digital
   Pincap 0x00000014: OUT Detect
   Pin Default 0x411110f0: [N/A] Speaker at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0xf, Sequence = 0x0
   Pin-ctls: 0x40: OUT
   Unsolicited: tag=00, enabled=0
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
   Connection: 1
      0x10
Node 0x12 [Pin Complex] wcaps 0x400401: Stereo
   Pincap 0x00000020: IN
   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x00:
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x14 [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
   Control: name="Front Playback Switch", index=0, device=0
     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
   Control: name="Line Out Phantom Jack", index=0, device=0
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x00 0x00]
   Pincap 0x0001003e: IN OUT HP EAPD Detect Trigger
   EAPD 0x2: EAPD
   Pin Default 0x04014110: [Jack] Line Out at Ext Right
     Conn = 1/8, Color = Green
     DefAssociation = 0x1, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x40: OUT
   Unsolicited: tag=00, enabled=0
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
   Connection: 5
      0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x15 [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x0001003e: IN OUT HP EAPD Detect Trigger
   EAPD 0x2: EAPD
   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x20: IN
   Unsolicited: tag=00, enabled=0
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
   Connection: 5
      0x0c 0x0d* 0x0e 0x0f 0x26
Node 0x16 [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x00000036: IN OUT Detect Trigger
   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x20: IN
   Unsolicited: tag=00, enabled=0
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
   Connection: 5
      0x0c 0x0d 0x0e* 0x0f 0x26
Node 0x17 [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x00000036: IN OUT Detect Trigger
   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x20: IN
   Unsolicited: tag=00, enabled=0
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
   Connection: 5
      0x0c 0x0d 0x0e 0x0f* 0x26
Node 0x18 [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
   Control: name="Center Playback Switch", index=0, device=0
     ControlAmp: chs=1, dir=Out, idx=0, ofs=0
   Control: name="LFE Playback Switch", index=0, device=0
     ControlAmp: chs=2, dir=Out, idx=0, ofs=0
   Control: name="Mic Boost Volume", index=1, device=0
     ControlAmp: chs=3, dir=In, idx=0, ofs=0
   Control: name="Mic Jack", index=1, device=0
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x03 0x03]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x00 0x00]
   Pincap 0x0000373e: IN OUT HP Detect Trigger
     Vref caps: HIZ 50 GRD 80 100
   Pin Default 0x04a19830: [Jack] Mic at Ext Right
     Conn = 1/8, Color = Pink
     DefAssociation = 0x3, Sequence = 0x0
   Pin-ctls: 0x21: IN VREF_50
   Unsolicited: tag=02, enabled=1
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
   Connection: 5
      0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x19 [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
   Control: name="Surround Playback Switch", index=0, device=0
     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
   Control: name="Mic Boost Volume", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=0, ofs=0
   Control: name="Mic Jack", index=0, device=0
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x03 0x03]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x00 0x00]
   Pincap 0x0000373e: IN OUT HP Detect Trigger
     Vref caps: HIZ 50 GRD 80 100
   Pin Default 0x04a1383f: [Jack] Mic at Ext Right
     Conn = 1/8, Color = Blue
     DefAssociation = 0x3, Sequence = 0xf
   Pin-ctls: 0x24: IN VREF_80
   Unsolicited: tag=01, enabled=1
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
   Connection: 5
      0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1a [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x0000373e: IN OUT HP Detect Trigger
     Vref caps: HIZ 50 GRD 80 100
   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x20: IN VREF_HIZ
   Unsolicited: tag=00, enabled=0
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
   Connection: 5
      0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1b [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x0000373e: IN OUT HP Detect Trigger
     Vref caps: HIZ 50 GRD 80 100
   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x20: IN VREF_HIZ
   Unsolicited: tag=00, enabled=0
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
   Connection: 5
      0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1c [Pin Complex] wcaps 0x400481: Stereo
   Pincap 0x00000024: IN Detect
   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x20: IN
   Unsolicited: tag=00, enabled=0
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
Node 0x1d [Pin Complex] wcaps 0x400400: Mono
   Pincap 0x00000020: IN
   Pin Default 0x598301f0: [N/A] Line In at Int ATAPI
     Conn = ATAPI, Color = Unknown
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x20: IN
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
Node 0x1e [Pin Complex] wcaps 0x400780: Mono Digital
   Control: name="SPDIF Phantom Jack", index=0, device=0
   Pincap 0x00000014: OUT Detect
   Pin Default 0x99430120: [Fixed] SPDIF Out at Int ATAPI
     Conn = ATAPI, Color = Unknown
     DefAssociation = 0x2, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x40: OUT
   Unsolicited: tag=00, enabled=0
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
   Connection: 1
      0x06
Node 0x1f [Pin Complex] wcaps 0x400680: Mono Digital
   Pincap 0x00000024: IN Detect
   Pin Default 0x41c46060: [N/A] SPDIF In at Ext Rear
     Conn = RCA, Color = Orange
     DefAssociation = 0x6, Sequence = 0x0
   Pin-ctls: 0x20: IN
   Unsolicited: tag=00, enabled=0
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
   Processing caps: benign=0, ncoeff=25
Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x22 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x80 0x80] [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
   Connection: 12
      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b 0x12
Node 0x23 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x80 0x80] [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
   Connection: 11
      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x24 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x25 [Audio Output] wcaps 0x411: Stereo
   Converter: stream=0, channel=0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
Node 0x26 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x80 0x80]
   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
   Amp-Out vals:  [0x00 0x00]
   Connection: 2
      0x25 0x0b
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116,  2 Oct  2 11:45 /dev/snd/controlC0
crw-rw----+ 1 root audio 116,  7 Oct  2 11:45 /dev/snd/hwC0D0
crw-rw----+ 1 root audio 116,  4 Oct  2 11:46 /dev/snd/pcmC0D0c
crw-rw----+ 1 root audio 116,  3 Oct  2 11:46 /dev/snd/pcmC0D0p
crw-rw----+ 1 root audio 116,  5 Oct  2 11:46 /dev/snd/pcmC0D1p
crw-rw----+ 1 root audio 116,  6 Oct  2 11:45 /dev/snd/pcmC0D2c
crw-rw----+ 1 root audio 116,  1 Oct  2 11:45 /dev/snd/seq
crw-rw----+ 1 root audio 116, 33 Oct  2 11:45 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x. 2 root root  60 Oct  2 11:45 .
drwxr-xr-x. 3 root root 220 Oct  2 11:45 ..
lrwxrwxrwx. 1 root root  12 Oct  2 11:45 pci-0000:00:1b.0 -> ../controlC0


!!ALSA configuration files
!!------------------------

!!System wide config file (/etc/asound.conf)

#
# Place your global alsa-lib configuration here...
#


!!Aplay/Arecord output
!!--------------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: ALC888 Analog [ALC888 Analog]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 1: ALC888 Digital [ALC888 Digital]
   Subdevices: 1/1
   Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: Intel [HDA Intel], device 0: ALC888 Analog [ALC888 Analog]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 2: ALC888 Alt Analog [ALC888 Alt Analog]
   Subdevices: 1/1
   Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [Intel]

Card hw:0 'Intel'/'HDA Intel at 0xfdff8000 irq 26'
   Mixer name	: 'Realtek ALC888'
   Components	: 'HDA:10ec0888,e6fe0000,00100202'
   Controls      : 39
   Simple ctrls  : 18
Simple mixer control 'Master',0
   Capabilities: pvolume pvolume-joined pswitch pswitch-joined
   Playback channels: Mono
   Limits: Playback 0 - 31
   Mono: Playback 31 [100%] [0.00dB] [on]
Simple mixer control 'PCM',0
   Capabilities: pvolume
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 255
   Mono:
   Front Left: Playback 255 [100%] [0.00dB]
   Front Right: Playback 255 [100%] [0.00dB]
Simple mixer control 'Front',0
   Capabilities: pvolume pswitch
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 31
   Mono:
   Front Left: Playback 31 [100%] [0.00dB] [on]
   Front Right: Playback 31 [100%] [0.00dB] [on]
Simple mixer control 'Surround',0
   Capabilities: pvolume pswitch
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 31
   Mono:
   Front Left: Playback 31 [100%] [0.00dB] [on]
   Front Right: Playback 31 [100%] [0.00dB] [on]
Simple mixer control 'Center',0
   Capabilities: pvolume pvolume-joined pswitch pswitch-joined
   Playback channels: Mono
   Limits: Playback 0 - 31
   Mono: Playback 31 [100%] [0.00dB] [on]
Simple mixer control 'LFE',0
   Capabilities: pvolume pvolume-joined pswitch pswitch-joined
   Playback channels: Mono
   Limits: Playback 0 - 31
   Mono: Playback 31 [100%] [0.00dB] [on]
Simple mixer control 'Mic',0
   Capabilities: pvolume pswitch
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 31
   Mono:
   Front Left: Playback 0 [0%] [-34.50dB] [off]
   Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Mic Boost',0
   Capabilities: volume
   Playback channels: Front Left - Front Right
   Capture channels: Front Left - Front Right
   Limits: 0 - 3
   Front Left: 3 [100%] [30.00dB]
   Front Right: 3 [100%] [30.00dB]
Simple mixer control 'Mic',1
   Capabilities: pvolume pswitch
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 31
   Mono:
   Front Left: Playback 0 [0%] [-34.50dB] [off]
   Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Mic Boost',1
   Capabilities: volume
   Playback channels: Front Left - Front Right
   Capture channels: Front Left - Front Right
   Limits: 0 - 3
   Front Left: 3 [100%] [30.00dB]
   Front Right: 3 [100%] [30.00dB]
Simple mixer control 'IEC958',0
   Capabilities: pswitch pswitch-joined
   Playback channels: Mono
   Mono: Playback [off]
Simple mixer control 'IEC958 Default PCM',0
   Capabilities: pswitch pswitch-joined
   Playback channels: Mono
   Mono: Playback [on]
Simple mixer control 'Beep',0
   Capabilities: pvolume pswitch
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 31
   Mono:
   Front Left: Playback 31 [100%] [12.00dB] [on]
   Front Right: Playback 31 [100%] [12.00dB] [on]
Simple mixer control 'Capture',0
   Capabilities: cvolume cswitch
   Capture channels: Front Left - Front Right
   Limits: Capture 0 - 31
   Front Left: Capture 30 [97%] [28.50dB] [on]
   Front Right: Capture 30 [97%] [28.50dB] [on]
Simple mixer control 'Capture',1
   Capabilities: cvolume cswitch
   Capture channels: Front Left - Front Right
   Limits: Capture 0 - 31
   Front Left: Capture 0 [0%] [-16.50dB] [off]
   Front Right: Capture 0 [0%] [-16.50dB] [off]
Simple mixer control 'Channel Mode',0
   Capabilities: enum
   Items: '2ch' '4ch' '6ch'
   Item0: '2ch'
Simple mixer control 'Input Source',0
   Capabilities: cenum
   Items: 'Mic' 'Mic 1'
   Item0: 'Mic'
Simple mixer control 'Input Source',1
   Capabilities: cenum
   Items: 'Mic' 'Mic 1'
   Item0: 'Mic'


!!Alsactl output
!!--------------

--startcollapse--
state.Intel {
	control.1 {
		iface MIXER
		name 'Channel Mode'
		value '2ch'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 '2ch'
			item.1 '4ch'
			item.2 '6ch'
		}
	}
	control.2 {
		iface MIXER
		name 'Front Playback Volume'
		value.0 31
		value.1 31
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -4650
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.3 {
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
	control.4 {
		iface MIXER
		name 'Surround Playback Volume'
		value.0 31
		value.1 31
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -4650
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.5 {
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
	control.6 {
		iface MIXER
		name 'Center Playback Volume'
		value 31
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 31'
			dbmin -4650
			dbmax 0
			dbvalue.0 0
		}
	}
	control.7 {
		iface MIXER
		name 'LFE Playback Volume'
		value 31
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 31'
			dbmin -4650
			dbmax 0
			dbvalue.0 0
		}
	}
	control.8 {
		iface MIXER
		name 'Center Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.9 {
		iface MIXER
		name 'LFE Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.10 {
		iface MIXER
		name 'Mic Playback Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -3450
			dbmax 1200
			dbvalue.0 -3450
			dbvalue.1 -3450
		}
	}
	control.11 {
		iface MIXER
		name 'Mic Playback Switch'
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.12 {
		iface MIXER
		name 'Mic Playback Volume'
		index 1
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -3450
			dbmax 1200
			dbvalue.0 -3450
			dbvalue.1 -3450
		}
	}
	control.13 {
		iface MIXER
		name 'Mic Playback Switch'
		index 1
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.14 {
		iface MIXER
		name 'Input Source'
		value Mic
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Mic
			item.1 'Mic 1'
		}
	}
	control.15 {
		iface MIXER
		name 'Input Source'
		index 1
		value Mic
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Mic
			item.1 'Mic 1'
		}
	}
	control.16 {
		iface MIXER
		name 'Capture Volume'
		value.0 30
		value.1 30
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -1650
			dbmax 3000
			dbvalue.0 2850
			dbvalue.1 2850
		}
	}
	control.17 {
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
	control.18 {
		iface MIXER
		name 'Capture Volume'
		index 1
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -1650
			dbmax 3000
			dbvalue.0 -1650
			dbvalue.1 -1650
		}
	}
	control.19 {
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
	control.20 {
		iface MIXER
		name 'Mic Boost Volume'
		value.0 3
		value.1 3
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 3'
			dbmin 0
			dbmax 3000
			dbvalue.0 3000
			dbvalue.1 3000
		}
	}
	control.21 {
		iface MIXER
		name 'Mic Boost Volume'
		index 1
		value.0 3
		value.1 3
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 3'
			dbmin 0
			dbmax 3000
			dbvalue.0 3000
			dbvalue.1 3000
		}
	}
	control.22 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.23 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.24 {
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.25 {
		iface MIXER
		name 'IEC958 Playback Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.26 {
		iface MIXER
		name 'IEC958 Default PCM Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.27 {
		iface MIXER
		name 'Master Playback Volume'
		value 31
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 31'
			dbmin -4650
			dbmax 0
			dbvalue.0 0
		}
	}
	control.28 {
		iface MIXER
		name 'Master Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.29 {
		iface CARD
		name 'Mic Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.30 {
		iface CARD
		name 'Mic Jack'
		index 1
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.31 {
		iface CARD
		name 'Line Out Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.32 {
		iface CARD
		name 'SPDIF Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.33 {
		iface MIXER
		name 'Beep Playback Volume'
		value.0 31
		value.1 31
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -3450
			dbmax 1200
			dbvalue.0 1200
			dbvalue.1 1200
		}
	}
	control.34 {
		iface MIXER
		name 'Beep Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.35 {
		iface PCM
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
	control.36 {
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
	control.37 {
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
	control.38 {
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
	control.39 {
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
fuse
ip6t_rpfilter
ip6t_REJECT
xt_conntrack
bnep
bluetooth
cfg80211
rfkill
ebtable_nat
ebtable_broute
bridge
stp
llc
ebtable_filter
ebtables
ip6table_nat
nf_conntrack_ipv6
nf_defrag_ipv6
nf_nat_ipv6
ip6table_mangle
ip6table_security
ip6table_raw
ip6table_filter
ip6_tables
iptable_nat
nf_conntrack_ipv4
nf_defrag_ipv4
nf_nat_ipv4
nf_nat
nf_conntrack
iptable_mangle
iptable_security
iptable_raw
iTCO_wdt
ppdev
iTCO_vendor_support
snd_hda_codec_realtek
snd_hda_codec_generic
snd_hda_intel
uvcvideo
snd_hda_controller
snd_hda_codec
videobuf2_vmalloc
videobuf2_memops
coretemp
videobuf2_core
v4l2_common
snd_hwdep
videodev
snd_seq
snd_seq_device
serio_raw
pcspkr
snd_pcm
media
i2c_i801
joydev
snd_timer
lpc_ich
snd
soundcore
parport_pc
parport
acpi_cpufreq
i915
i2c_algo_bit
video
drm_kms_helper
e1000e
drm
ata_generic
pata_acpi
ptp
pps_core


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x11 0x411110f0
0x12 0x411111f0
0x14 0x04014110
0x15 0x411111f0
0x16 0x411111f0
0x17 0x411111f0
0x18 0x04a19830
0x19 0x04a1383f
0x1a 0x411111f0
0x1b 0x411111f0
0x1c 0x411111f0
0x1d 0x598301f0
0x1e 0x99430120
0x1f 0x41c46060

/sys/class/sound/hwC0D0/driver_pin_configs:

/sys/class/sound/hwC0D0/user_pin_configs:

/sys/class/sound/hwC0D0/init_verbs:

/sys/class/sound/hwC0D0/hints:


!!ALSA/HDA dmesg
!!--------------

[   18.164118] uvcvideo: Found UVC 1.00 device USB Camera Device (174f:142b)
[   18.193973] snd_hda_intel 0000:00:1b.0: irq 26 for MSI/MSI-X
[   18.200809] input: USB Camera Device as /devices/pci0000:00/0000:00:1e.0/0000:02:03.2/usb2/2-2/2-2:1.0/input/input8
--
[   18.201610] USB Video Class driver (1.1.1)
[   18.305764] sound hdaudioC0D0: ALC888: SKU not ready 0x598301f0
[   18.305987] sound hdaudioC0D0: autoconfig: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
[   18.305999] sound hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   18.306072] sound hdaudioC0D0:    hp_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   18.306080] sound hdaudioC0D0:    mono: mono_out=0x0
[   18.306088] sound hdaudioC0D0:    dig-out=0x1e/0x0
[   18.306095] sound hdaudioC0D0:    inputs:
[   18.306105] sound hdaudioC0D0:      Mic=0x19
[   18.306114] sound hdaudioC0D0:      Mic=0x18
[   18.392187] input: HDA Intel Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input9
[   18.392652] input: HDA Intel Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input10
[   18.396462] iTCO_vendor_support: vendor-support=0
