From: Jens John <lists@2ion.de>
Subject: Re: Persisting background noise on HDA Intel PCH
 (ALC3232)
Date: Sun, 14 Dec 2014 15:17:34 +0100
Message-ID: <20141214141734.GC29554@camelia.2ion.de>
References: <20141213221334.GA4350@camelia.2ion.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lMM8JwqTlfDpEaS6"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wp254.webpack.hosteurope.de (wp254.webpack.hosteurope.de
 [80.237.133.23])
 by alsa0.perex.cz (Postfix) with ESMTP id B18EB2604CF
 for <alsa-devel@alsa-project.org>; Sun, 14 Dec 2014 15:17:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20141213221334.GA4350@camelia.2ion.de>
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


--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

I have acquired the alsa-info.sh (attached) output from a person who has a
*different* X240 model with the same ALC3232 codec that *doesn't* exhibit the
issue.

Maybe this will help with investigating the bug.

Best Regards
Jens.

On Sat, Dec 13, 2014 at 11:13:34PM +0100, Jens John wrote:
> Hello all,
> 
> On my Thinkpad x240, I am experiencing exactly the same bug as someone on the
> x230 [0], that is I get clearly audible background noise on headphone and
> speaker outputs unless I mute the Headphone/Speaker control or Master. In both
> cases, a Realtek ALC on a Thinkpad is involved.
> 
> I have attached the alsa-info.sh output. The problems occur with plain ALSA
> output, Jack or Pulse are not involved.
> 
> I have tried all suggestions mentioned in [0], and also tested all available
> ALC-related model= parameters to snd_hda_intel, but the issue persists.
> 
> Muting all mixers on all cards didn't change anything either. Other Thinkpad
> laptops with the ALC3232 codec are also affected by this bug, for example [1].
> 
> The bug makes the audio output unuseable for any serious purpose.
> 
> I would be very grateful if somebody could look into this (again?), and also
> assist as far as I can.
> 
> Thank you & Best regards
> -Jens.
> 
> --
> [0]: http://mailman.alsa-project.org/pipermail/alsa-devel/2014-August/080039.html
> [1]: http://askubuntu.com/questions/541538/headphone-hiss-after-upgrade-to-14-10
> 
> PS. I'm sorry if this is not the correct place to report this, but the bug
> tracker linked on the ALSA project home page seems to be down.
> 

> upload=true&script=true&cardinfo=
> !!################################
> !!ALSA Information Script v 0.4.64
> !!################################
> 
> !!Script ran on: Sat Dec 13 22:02:44 UTC 2014
> 
> 
> !!Linux Distribution
> !!------------------
> 
> Arch Linux \r (\l) NAME="Arch Linux" ID=arch PRETTY_NAME="Arch Linux" HOME_URL="https://www.archlinux.org/" SUPPORT_URL="https://bbs.archlinux.org/" BUG_REPORT_URL="https://bugs.archlinux.org/"
> 
> 
> !!DMI Information
> !!---------------
> 
> Manufacturer:      LENOVO
> Product Name:      20AMS4SM00
> Product Version:   ThinkPad X240
> Firmware Version:  GIET76WW (2.26 )
> 
> 
> !!Kernel Information
> !!------------------
> 
> Kernel release:    3.17.6-1-ARCH
> Operating System:  GNU/Linux
> Architecture:      x86_64
> Processor:         unknown
> SMP Enabled:       Yes
> 
> 
> !!ALSA Version
> !!------------
> 
> Driver version:     k3.17.6-1-ARCH
> Library version:    1.0.28
> Utilities version:  1.0.28
> 
> 
> !!Loaded ALSA modules
> !!-------------------
> 
> snd_hda_intel
> snd_hda_intel
> thinkpad_acpi
> 
> 
> !!Sound Servers on this system
> !!----------------------------
> 
> Jack:
>       Installed - Yes (/usr/bin/jackd)
>       Running - No
> 
> 
> !!Soundcards recognised by ALSA
> !!-----------------------------
> 
>  0 [HDMI           ]: HDA-Intel - HDA Intel HDMI
>                       HDA Intel HDMI at 0xf0630000 irq 48
>  1 [PCH            ]: HDA-Intel - HDA Intel PCH
>                       HDA Intel PCH at 0xf0634000 irq 47
> 29 [ThinkPadEC     ]: ThinkPad EC - ThinkPad Console Audio Control
>                       ThinkPad Console Audio Control at EC reg 0x30, fw unknown
> 
> 
> !!PCI Soundcards installed in the system
> !!--------------------------------------
> 
> 00:03.0 Audio device: Intel Corporation Haswell-ULT HD Audio Controller (rev 0b)
> 00:1b.0 Audio device: Intel Corporation 8 Series HD Audio Controller (rev 04)
> 
> 
> !!Advanced information - PCI Vendor/Device/Subsystem ID's
> !!-------------------------------------------------------
> 
> 00:03.0 0403: 8086:0a0c (rev 0b)
> 	Subsystem: 17aa:2214
> --
> 00:1b.0 0403: 8086:9c20 (rev 04)
> 	Subsystem: 17aa:2214
> 
> 
> !!Modprobe options (Sound related)
> !!--------------------------------
> 
> snd_hda_intel: power_save=1
> 
> 
> !!Loaded sound module options
> !!---------------------------
> 
> !!Module: snd_hda_intel
> 	align_buffer_size : -1
> 	bdl_pos_adj : 32,1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
> 	beep_mode : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
> 	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
> 	enable_msi : -1
> 	id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
> 	index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
> 	jackpoll_ms : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
> 	model : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
> 	patch : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
> 	position_fix : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
> 	power_save : 1
> 	power_save_controller : Y
> 	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
> 	probe_only : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
> 	single_cmd : N
> 	snoop : Y
> 
> !!Module: snd_hda_intel
> 	align_buffer_size : -1
> 	bdl_pos_adj : 32,1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
> 	beep_mode : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
> 	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
> 	enable_msi : -1
> 	id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
> 	index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
> 	jackpoll_ms : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
> 	model : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
> 	patch : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
> 	position_fix : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
> 	power_save : 1
> 	power_save_controller : Y
> 	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
> 	probe_only : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
> 	single_cmd : N
> 	snoop : Y
> 
> !!Module: thinkpad_acpi
> 	brightness_enable : 2
> 	brightness_mode : 4
> 	enable : Y
> 	experimental : 0
> 	fan_control : N
> 	force_load : N
> 	id : ThinkPadEC
> 	index : -536870912
> 	volume_capabilities : 0
> 	volume_control : N
> 	volume_mode : 3
> 
> 
> !!HDA-Intel Codec information
> !!---------------------------
> --startcollapse--
> 
> Codec: Intel Haswell HDMI
> Address: 0
> AFG Function Id: 0x1 (unsol 0)
> Vendor Id: 0x80862807
> Subsystem Id: 0x80860101
> Revision Id: 0x100000
> No Modem Function Group found
> Default PCM:
>     rates [0x0]:
>     bits [0x0]:
>     formats [0x0]:
> Default Amp-In caps: N/A
> Default Amp-Out caps: N/A
> State of AFG node 0x01:
>   Power states:  D0 D3 CLKSTOP EPSS
>   Power: setting=D0, actual=D0, Clock-stop-OK
> GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
> Node 0x02 [Audio Output] wcaps 0x6611: 8-Channels Digital
>   Converter: stream=0, channel=0
>   Digital: Enabled KAE
>   Digital category: 0x0
>   IEC Coding Type: 0x0
>   PCM:
>     rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
>     bits [0x1e]: 16 20 24 32
>     formats [0x5]: PCM AC3
>   Power states:  D0 D3 EPSS
>   Power: setting=D0, actual=D0
> Node 0x03 [Audio Output] wcaps 0x6611: 8-Channels Digital
>   Converter: stream=0, channel=0
>   Digital: Enabled KAE
>   Digital category: 0x0
>   IEC Coding Type: 0x0
>   PCM:
>     rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
>     bits [0x1e]: 16 20 24 32
>     formats [0x5]: PCM AC3
>   Power states:  D0 D3 EPSS
>   Power: setting=D0, actual=D0
> Node 0x04 [Audio Output] wcaps 0x6611: 8-Channels Digital
>   Converter: stream=0, channel=0
>   Digital: Enabled KAE
>   Digital category: 0x0
>   IEC Coding Type: 0x0
>   PCM:
>     rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
>     bits [0x1e]: 16 20 24 32
>     formats [0x5]: PCM AC3
>   Power states:  D0 D3 EPSS
>   Power: setting=D0, actual=D0
> Node 0x05 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
>   Control: name="HDMI/DP,pcm=3 Jack", index=0, device=0
>   Control: name="IEC958 Playback Con Mask", index=0, device=0
>   Control: name="IEC958 Playback Pro Mask", index=0, device=0
>   Control: name="IEC958 Playback Default", index=0, device=0
>   Control: name="IEC958 Playback Switch", index=0, device=0
>   Control: name="ELD", index=0, device=3
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x00 0x00]
>   Pincap 0x0b000094: OUT Detect HBR HDMI DP
>   Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
>     Conn = Digital, Color = Unknown
>     DefAssociation = 0x1, Sequence = 0x0
>   Pin-ctls: 0x00:
>   Unsolicited: tag=01, enabled=1
>   Power states:  D0 D3 EPSS
>   Power: setting=D0, actual=D0
>   Devices: 0
>   Connection: 0
>   In-driver Connection: 3
>      0x02 0x03 0x04
> Node 0x06 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
>   Control: name="HDMI/DP,pcm=7 Jack", index=0, device=0
>   Control: name="IEC958 Playback Con Mask", index=1, device=0
>   Control: name="IEC958 Playback Pro Mask", index=1, device=0
>   Control: name="IEC958 Playback Default", index=1, device=0
>   Control: name="IEC958 Playback Switch", index=1, device=0
>   Control: name="ELD", index=0, device=7
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x00 0x00]
>   Pincap 0x0b000094: OUT Detect HBR HDMI DP
>   Pin Default 0x18560020: [Jack] Digital Out at Int HDMI
>     Conn = Digital, Color = Unknown
>     DefAssociation = 0x2, Sequence = 0x0
>   Pin-ctls: 0x00:
>   Unsolicited: tag=02, enabled=1
>   Power states:  D0 D3 EPSS
>   Power: setting=D0, actual=D0
>   Devices: 0
>   Connection: 0
>   In-driver Connection: 3
>      0x02 0x03 0x04
> Node 0x07 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
>   Control: name="HDMI/DP,pcm=8 Jack", index=0, device=0
>   Control: name="IEC958 Playback Con Mask", index=2, device=0
>   Control: name="IEC958 Playback Pro Mask", index=2, device=0
>   Control: name="IEC958 Playback Default", index=2, device=0
>   Control: name="IEC958 Playback Switch", index=2, device=0
>   Control: name="ELD", index=0, device=8
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x00 0x00]
>   Pincap 0x0b000094: OUT Detect HBR HDMI DP
>   Pin Default 0x18560030: [Jack] Digital Out at Int HDMI
>     Conn = Digital, Color = Unknown
>     DefAssociation = 0x3, Sequence = 0x0
>   Pin-ctls: 0x00:
>   Unsolicited: tag=03, enabled=1
>   Power states:  D0 D3 EPSS
>   Power: setting=D0, actual=D0
>   Devices: 0
>   Connection: 0
>   In-driver Connection: 3
>      0x02 0x03 0x04
> Node 0x08 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Codec: Realtek ALC3232
> Address: 0
> AFG Function Id: 0x1 (unsol 1)
> Vendor Id: 0x10ec0292
> Subsystem Id: 0x17aa2214
> Revision Id: 0x100001
> No Modem Function Group found
> Default PCM:
>     rates [0x5f0]: 32000 44100 48000 88200 96000 192000
>     bits [0xe]: 16 20 24
>     formats [0x1]: PCM
> Default Amp-In caps: N/A
> Default Amp-Out caps: N/A
> State of AFG node 0x01:
>   Power states:  D0 D1 D2 D3 CLKSTOP EPSS
>   Power: setting=D0, actual=D0
> GPIO: io=5, o=0, i=0, unsolicited=1, wake=0
>   IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>   IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>   IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>   IO[3]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>   IO[4]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
> Node 0x02 [Audio Output] wcaps 0x41d: Stereo Amp-Out
>   Control: name="Headphone Playback Volume", index=0, device=0
>     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>   Device: name="ALC3232 Analog", type="Audio", device=0
>   Amp-Out caps: ofs=0x57, nsteps=0x57, stepsize=0x02, mute=0
>   Amp-Out vals:  [0x00 0x00]
>   Converter: stream=0, channel=0
>   PCM:
>     rates [0x560]: 44100 48000 96000 192000
>     bits [0xe]: 16 20 24
>     formats [0x1]: PCM
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
> Node 0x03 [Audio Output] wcaps 0x41d: Stereo Amp-Out
>   Control: name="Speaker Playback Volume", index=0, device=0
>     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>   Amp-Out caps: ofs=0x57, nsteps=0x57, stepsize=0x02, mute=0
>   Amp-Out vals:  [0x00 0x00]
>   Converter: stream=0, channel=0
>   PCM:
>     rates [0x560]: 44100 48000 96000 192000
>     bits [0xe]: 16 20 24
>     formats [0x1]: PCM
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
> Node 0x04 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x05 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x06 [Audio Output] wcaps 0x611: Stereo Digital
>   Converter: stream=0, channel=0
>   Digital:
>   Digital category: 0x0
>   IEC Coding Type: 0x0
>   PCM:
>     rates [0x5f0]: 32000 44100 48000 88200 96000 192000
>     bits [0xe]: 16 20 24
>     formats [0x1]: PCM
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
> Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x08 [Audio Input] wcaps 0x10051b: Stereo Amp-In
>   Amp-In caps: ofs=0x17, nsteps=0x3f, stepsize=0x02, mute=1
>   Amp-In vals:  [0x97 0x97]
>   Converter: stream=0, channel=0
>   SDI-Select: 0
>   PCM:
>     rates [0x560]: 44100 48000 96000 192000
>     bits [0xe]: 16 20 24
>     formats [0x1]: PCM
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
>   Connection: 1
>      0x23
> Node 0x09 [Audio Input] wcaps 0x10051b: Stereo Amp-In
>   Control: name="Capture Volume", index=0, device=0
>     ControlAmp: chs=3, dir=In, idx=0, ofs=0
>   Control: name="Capture Switch", index=0, device=0
>     ControlAmp: chs=3, dir=In, idx=0, ofs=0
>   Device: name="ALC3232 Analog", type="Audio", device=0
>   Amp-In caps: ofs=0x17, nsteps=0x3f, stepsize=0x02, mute=1
>   Amp-In vals:  [0x80 0x80]
>   Converter: stream=0, channel=0
>   SDI-Select: 0
>   PCM:
>     rates [0x560]: 44100 48000 96000 192000
>     bits [0xe]: 16 20 24
>     formats [0x1]: PCM
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
>   Connection: 1
>      0x22
> Node 0x0a [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>   Control: name="Mic Playback Volume", index=0, device=0
>     ControlAmp: chs=3, dir=In, idx=2, ofs=0
>   Control: name="Mic Playback Switch", index=0, device=0
>     ControlAmp: chs=3, dir=In, idx=2, ofs=0
>   Control: name="Beep Playback Volume", index=0, device=0
>     ControlAmp: chs=3, dir=In, idx=4, ofs=0
>   Control: name="Beep Playback Switch", index=0, device=0
>     ControlAmp: chs=3, dir=In, idx=4, ofs=0
>   Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
>   Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
>   Connection: 5
>      0x18 0x19 0x1a 0x1b 0x1d
> Node 0x0c [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x00 0x00] [0x00 0x00]
>   Connection: 2
>      0x02 0x0b
> Node 0x0d [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x00 0x00] [0x00 0x00]
>   Connection: 2
>      0x03 0x0b
> Node 0x0e [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x0f [Audio Mixer] wcaps 0x20010a: Mono Amp-In
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x80] [0x00]
>   Connection: 2
>      0x02 0x03
> Node 0x10 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x12 [Pin Complex] wcaps 0x40040b: Stereo Amp-In
>   Control: name="Internal Mic Boost Volume", index=0, device=0
>     ControlAmp: chs=3, dir=In, idx=0, ofs=0
>   Control: name="Internal Mic Phantom Jack", index=0, device=0
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
>   Amp-In vals:  [0x00 0x00]
>   Pincap 0x00000020: IN
>   Pin Default 0x90a60130: [Fixed] Mic at Int N/A
>     Conn = Digital, Color = Unknown
>     DefAssociation = 0x3, Sequence = 0x0
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x20: IN
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
> Node 0x13 [Pin Complex] wcaps 0x40040b: Stereo Amp-In
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
>   Amp-In vals:  [0x00 0x00]
>   Pincap 0x00000020: IN
>   Pin Default 0x40000000: [N/A] Line Out at Ext N/A
>     Conn = Unknown, Color = Unknown
>     DefAssociation = 0x0, Sequence = 0x0
>   Pin-ctls: 0x00:
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
> Node 0x14 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
>   Control: name="Speaker Playback Switch", index=0, device=0
>     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>   Control: name="Speaker Phantom Jack", index=0, device=0
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x80 0x80]
>   Pincap 0x00010010: OUT EAPD
>   EAPD 0x2: EAPD
>   Pin Default 0x90170110: [Fixed] Speaker at Int N/A
>     Conn = Analog, Color = Unknown
>     DefAssociation = 0x1, Sequence = 0x0
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x00:
>   Unsolicited: tag=00, enabled=0
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
>   Connection: 2
>      0x0c 0x0d*
> Node 0x15 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
>   Control: name="Headphone Playback Switch", index=0, device=0
>     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>   Control: name="Headphone Jack", index=0, device=0
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x00 0x00]
>   Pincap 0x0001001c: OUT HP EAPD Detect
>   EAPD 0x2: EAPD
>   Pin Default 0x0321101f: [Jack] HP Out at Ext Left
>     Conn = 1/8, Color = Black
>     DefAssociation = 0x1, Sequence = 0xf
>   Pin-ctls: 0xc0: OUT HP
>   Unsolicited: tag=01, enabled=1
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
>   Connection: 2
>      0x0c* 0x0d
> Node 0x16 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x80 0x80]
>   Pincap 0x0001001c: OUT HP EAPD Detect
>   EAPD 0x2: EAPD
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn = 1/8, Color = Black
>     DefAssociation = 0xf, Sequence = 0x0
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x00:
>   Unsolicited: tag=00, enabled=0
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
>   Connection: 2
>      0x0c* 0x0d
> Node 0x17 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x18 [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x80 0x80]
>   Pincap 0x00003734: IN OUT Detect
>     Vref caps: HIZ 50 GRD 80 100
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn = 1/8, Color = Black
>     DefAssociation = 0xf, Sequence = 0x0
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x20: IN VREF_HIZ
>   Unsolicited: tag=00, enabled=0
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
>   Connection: 2
>      0x0c* 0x0d
> Node 0x19 [Pin Complex] wcaps 0x40048b: Stereo Amp-In
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
>   Amp-In vals:  [0x00 0x00]
>   Pincap 0x00000024: IN Detect
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn = 1/8, Color = Black
>     DefAssociation = 0xf, Sequence = 0x0
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x00:
>   Unsolicited: tag=00, enabled=0
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
> Node 0x1a [Pin Complex] wcaps 0x40048b: Stereo Amp-In
>   Control: name="Mic Boost Volume", index=0, device=0
>     ControlAmp: chs=3, dir=In, idx=0, ofs=0
>   Control: name="Mic Jack", index=0, device=0
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00]
>   Pincap 0x00003724: IN Detect
>     Vref caps: HIZ 50 GRD 80 100
>   Pin Default 0x03a11020: [Jack] Mic at Ext Left
>     Conn = 1/8, Color = Black
>     DefAssociation = 0x2, Sequence = 0x0
>   Pin-ctls: 0x24: IN VREF_80
>   Unsolicited: tag=02, enabled=1
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
> Node 0x1b [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x80 0x80]
>   Pincap 0x00003734: IN OUT Detect
>     Vref caps: HIZ 50 GRD 80 100
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn = 1/8, Color = Black
>     DefAssociation = 0xf, Sequence = 0x0
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x20: IN VREF_HIZ
>   Unsolicited: tag=00, enabled=0
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
>   Connection: 2
>      0x0c* 0x0d
> Node 0x1c [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x1d [Pin Complex] wcaps 0x400400: Mono
>   Pincap 0x00000020: IN
>   Pin Default 0x40738105: [N/A] Modem Hand at Ext N/A
>     Conn = ATAPI, Color = Purple
>     DefAssociation = 0x0, Sequence = 0x5
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x20: IN
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
> Node 0x1e [Pin Complex] wcaps 0x400781: Stereo Digital
>   Pincap 0x00000014: OUT Detect
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn = 1/8, Color = Black
>     DefAssociation = 0xf, Sequence = 0x0
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x40: OUT
>   Unsolicited: tag=00, enabled=0
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
>   Connection: 1
>      0x06
> Node 0x1f [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
>   Processing caps: benign=0, ncoeff=124
> Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x22 [Audio Selector] wcaps 0x300101: Stereo
>   Connection: 8
>      0x18 0x19 0x1a 0x1b 0x1d 0x0b 0x12* 0x13
> Node 0x23 [Audio Selector] wcaps 0x300101: Stereo
>   Connection: 6
>      0x18* 0x19 0x1a 0x1b 0x1d 0x0b
> Node 0x24 [Vendor Defined Widget] wcaps 0xf00000: Mono
> --endcollapse--
> 
> 
> !!ALSA Device nodes
> !!-----------------
> 
> crw-rw----+ 1 root audio 116,  3 Dec 13 16:44 /dev/snd/controlC0
> crw-rw----+ 1 root audio 116,  8 Dec 13 16:44 /dev/snd/controlC1
> crw-rw----+ 1 root audio 116,  2 Dec 13 16:44 /dev/snd/controlC29
> crw-rw----+ 1 root audio 116,  7 Dec 13 16:44 /dev/snd/hwC0D0
> crw-rw----+ 1 root audio 116, 11 Dec 13 16:44 /dev/snd/hwC1D0
> crw-rw----+ 1 root audio 116,  4 Dec 13 16:44 /dev/snd/pcmC0D3p
> crw-rw----+ 1 root audio 116,  5 Dec 13 16:44 /dev/snd/pcmC0D7p
> crw-rw----+ 1 root audio 116,  6 Dec 13 16:44 /dev/snd/pcmC0D8p
> crw-rw----+ 1 root audio 116, 10 Dec 13 16:44 /dev/snd/pcmC1D0c
> crw-rw----+ 1 root audio 116,  9 Dec 13 16:44 /dev/snd/pcmC1D0p
> crw-rw----+ 1 root audio 116,  1 Dec 13 16:44 /dev/snd/seq
> crw-rw----+ 1 root audio 116, 33 Dec 13 16:44 /dev/snd/timer
> 
> /dev/snd/by-path:
> total 0
> drwxr-xr-x 2 root root 100 Dec 13 16:44 .
> drwxr-xr-x 3 root root 300 Dec 13 16:44 ..
> lrwxrwxrwx 1 root root  12 Dec 13 16:44 pci-0000:00:03.0 -> ../controlC0
> lrwxrwxrwx 1 root root  12 Dec 13 16:44 pci-0000:00:1b.0 -> ../controlC1
> lrwxrwxrwx 1 root root  13 Dec 13 16:44 platform-thinkpad_acpi -> ../controlC29
> 
> 
> !!ALSA configuration files
> !!------------------------
> 
> !!User specific config file (~/.asoundrc)
> 
> defaults.pcm.rate_converter "samplerate_best"
> 
> ctl.equal {
>   type equal;
> }
> 
> pcm.plugequal {
>   type equal;
>   slave.pcm "plughw:1,0"
> }
> 
> pcm.equal {
>   type plug;
>   slave.pcm plugequal;
> }
> 
> pcm.noequal {
>   type plug;
>   slave.pcm dmix;
> }
> 
> pcm.!default equal;
> 
> 
> !!System wide config file (/etc/asound.conf)
> 
> defaults.ctl.card 1
> defaults.pcm.card 1
> defaults.timer.card 1
> 
> 
> !!Aplay/Arecord output
> !!--------------------
> 
> APLAY
> 
> **** List of PLAYBACK Hardware Devices ****
> card 0: HDMI [HDA Intel HDMI], device 3: HDMI 0 [HDMI 0]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> card 0: HDMI [HDA Intel HDMI], device 7: HDMI 1 [HDMI 1]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> card 0: HDMI [HDA Intel HDMI], device 8: HDMI 2 [HDMI 2]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> card 1: PCH [HDA Intel PCH], device 0: ALC3232 Analog [ALC3232 Analog]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> 
> ARECORD
> 
> **** List of CAPTURE Hardware Devices ****
> card 1: PCH [HDA Intel PCH], device 0: ALC3232 Analog [ALC3232 Analog]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> 
> !!Amixer output
> !!-------------
> 
> !!-------Mixer controls for card 0 [HDMI]
> 
> Card hw:0 'HDMI'/'HDA Intel HDMI at 0xf0630000 irq 48'
>   Mixer name	: 'Intel Haswell HDMI'
>   Components	: 'HDA:80862807,80860101,00100000'
>   Controls      : 21
>   Simple ctrls  : 3
> Simple mixer control 'IEC958',0
>   Capabilities: pswitch pswitch-joined
>   Playback channels: Mono
>   Mono: Playback [on]
> Simple mixer control 'IEC958',1
>   Capabilities: pswitch pswitch-joined
>   Playback channels: Mono
>   Mono: Playback [on]
> Simple mixer control 'IEC958',2
>   Capabilities: pswitch pswitch-joined
>   Playback channels: Mono
>   Mono: Playback [on]
> 
> !!-------Mixer controls for card 1 [PCH]
> 
> Card hw:1 'PCH'/'HDA Intel PCH at 0xf0634000 irq 47'
>   Mixer name	: 'Realtek ALC3232'
>   Components	: 'HDA:10ec0292,17aa2214,00100001'
>   Controls      : 21
>   Simple ctrls  : 9
> Simple mixer control 'Master',0
>   Capabilities: pvolume pvolume-joined pswitch pswitch-joined
>   Playback channels: Mono
>   Limits: Playback 0 - 87
>   Mono: Playback 3 [3%] [-63.00dB] [on]
> Simple mixer control 'Headphone',0
>   Capabilities: pvolume pswitch
>   Playback channels: Front Left - Front Right
>   Limits: Playback 0 - 87
>   Mono:
>   Front Left: Playback 0 [0%] [-65.25dB] [on]
>   Front Right: Playback 0 [0%] [-65.25dB] [on]
> Simple mixer control 'Speaker',0
>   Capabilities: pvolume pswitch
>   Playback channels: Front Left - Front Right
>   Limits: Playback 0 - 87
>   Mono:
>   Front Left: Playback 0 [0%] [-65.25dB] [off]
>   Front Right: Playback 0 [0%] [-65.25dB] [off]
> Simple mixer control 'Mic',0
>   Capabilities: pvolume pswitch
>   Playback channels: Front Left - Front Right
>   Limits: Playback 0 - 31
>   Mono:
>   Front Left: Playback 0 [0%] [-34.50dB] [off]
>   Front Right: Playback 0 [0%] [-34.50dB] [off]
> Simple mixer control 'Mic Boost',0
>   Capabilities: volume
>   Playback channels: Front Left - Front Right
>   Capture channels: Front Left - Front Right
>   Limits: 0 - 3
>   Front Left: 0 [0%] [0.00dB]
>   Front Right: 0 [0%] [0.00dB]
> Simple mixer control 'Beep',0
>   Capabilities: pvolume pswitch
>   Playback channels: Front Left - Front Right
>   Limits: Playback 0 - 31
>   Mono:
>   Front Left: Playback 0 [0%] [-34.50dB] [off]
>   Front Right: Playback 0 [0%] [-34.50dB] [off]
> Simple mixer control 'Capture',0
>   Capabilities: cvolume cswitch
>   Capture channels: Front Left - Front Right
>   Limits: Capture 0 - 63
>   Front Left: Capture 0 [0%] [-17.25dB] [off]
>   Front Right: Capture 0 [0%] [-17.25dB] [off]
> Simple mixer control 'Auto-Mute Mode',0
>   Capabilities: enum
>   Items: 'Disabled' 'Enabled'
>   Item0: 'Enabled'
> Simple mixer control 'Internal Mic Boost',0
>   Capabilities: volume
>   Playback channels: Front Left - Front Right
>   Capture channels: Front Left - Front Right
>   Limits: 0 - 1
>   Front Left: 0 [0%] [0.00dB]
>   Front Right: 0 [0%] [0.00dB]
> 
> !!-------Mixer controls for card 29 [ThinkPadEC]
> 
> Card hw:29 'ThinkPadEC'/'ThinkPad Console Audio Control at EC reg 0x30, fw unknown'
>   Mixer name	: 'ThinkPad EC (unknown)'
>   Components	: ''
>   Controls      : 1
>   Simple ctrls  : 1
> Simple mixer control 'Console',0
>   Capabilities: pswitch pswitch-joined
>   Playback channels: Mono
>   Mono: Playback [on]
> 
> 
> !!Alsactl output
> !!--------------
> 
> --startcollapse--
> state.HDMI {
> 	control.1 {
> 		iface CARD
> 		name 'HDMI/DP,pcm=3 Jack'
> 		value false
> 		comment {
> 			access read
> 			type BOOLEAN
> 			count 1
> 		}
> 	}
> 	control.2 {
> 		iface MIXER
> 		name 'IEC958 Playback Con Mask'
> 		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
> 		comment {
> 			access read
> 			type IEC958
> 			count 1
> 		}
> 	}
> 	control.3 {
> 		iface MIXER
> 		name 'IEC958 Playback Pro Mask'
> 		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
> 		comment {
> 			access read
> 			type IEC958
> 			count 1
> 		}
> 	}
> 	control.4 {
> 		iface MIXER
> 		name 'IEC958 Playback Default'
> 		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
> 		comment {
> 			access 'read write'
> 			type IEC958
> 			count 1
> 		}
> 	}
> 	control.5 {
> 		iface MIXER
> 		name 'IEC958 Playback Switch'
> 		value true
> 		comment {
> 			access 'read write'
> 			type BOOLEAN
> 			count 1
> 		}
> 	}
> 	control.6 {
> 		iface PCM
> 		device 3
> 		name ELD
> 		value ''
> 		comment {
> 			access 'read volatile'
> 			type BYTES
> 			count 0
> 		}
> 	}
> 	control.7 {
> 		iface CARD
> 		name 'HDMI/DP,pcm=7 Jack'
> 		value false
> 		comment {
> 			access read
> 			type BOOLEAN
> 			count 1
> 		}
> 	}
> 	control.8 {
> 		iface MIXER
> 		name 'IEC958 Playback Con Mask'
> 		index 1
> 		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
> 		comment {
> 			access read
> 			type IEC958
> 			count 1
> 		}
> 	}
> 	control.9 {
> 		iface MIXER
> 		name 'IEC958 Playback Pro Mask'
> 		index 1
> 		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
> 		comment {
> 			access read
> 			type IEC958
> 			count 1
> 		}
> 	}
> 	control.10 {
> 		iface MIXER
> 		name 'IEC958 Playback Default'
> 		index 1
> 		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
> 		comment {
> 			access 'read write'
> 			type IEC958
> 			count 1
> 		}
> 	}
> 	control.11 {
> 		iface MIXER
> 		name 'IEC958 Playback Switch'
> 		index 1
> 		value true
> 		comment {
> 			access 'read write'
> 			type BOOLEAN
> 			count 1
> 		}
> 	}
> 	control.12 {
> 		iface PCM
> 		device 7
> 		name ELD
> 		value ''
> 		comment {
> 			access 'read volatile'
> 			type BYTES
> 			count 0
> 		}
> 	}
> 	control.13 {
> 		iface CARD
> 		name 'HDMI/DP,pcm=8 Jack'
> 		value false
> 		comment {
> 			access read
> 			type BOOLEAN
> 			count 1
> 		}
> 	}
> 	control.14 {
> 		iface MIXER
> 		name 'IEC958 Playback Con Mask'
> 		index 2
> 		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
> 		comment {
> 			access read
> 			type IEC958
> 			count 1
> 		}
> 	}
> 	control.15 {
> 		iface MIXER
> 		name 'IEC958 Playback Pro Mask'
> 		index 2
> 		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
> 		comment {
> 			access read
> 			type IEC958
> 			count 1
> 		}
> 	}
> 	control.16 {
> 		iface MIXER
> 		name 'IEC958 Playback Default'
> 		index 2
> 		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
> 		comment {
> 			access 'read write'
> 			type IEC958
> 			count 1
> 		}
> 	}
> 	control.17 {
> 		iface MIXER
> 		name 'IEC958 Playback Switch'
> 		index 2
> 		value true
> 		comment {
> 			access 'read write'
> 			type BOOLEAN
> 			count 1
> 		}
> 	}
> 	control.18 {
> 		iface PCM
> 		device 8
> 		name ELD
> 		value ''
> 		comment {
> 			access 'read volatile'
> 			type BYTES
> 			count 0
> 		}
> 	}
> 	control.19 {
> 		iface PCM
> 		device 3
> 		name 'Playback Channel Map'
> 		value.0 0
> 		value.1 0
> 		value.2 0
> 		value.3 0
> 		value.4 0
> 		value.5 0
> 		value.6 0
> 		value.7 0
> 		comment {
> 			access 'read write'
> 			type INTEGER
> 			count 8
> 			range '0 - 36'
> 		}
> 	}
> 	control.20 {
> 		iface PCM
> 		device 7
> 		name 'Playback Channel Map'
> 		value.0 0
> 		value.1 0
> 		value.2 0
> 		value.3 0
> 		value.4 0
> 		value.5 0
> 		value.6 0
> 		value.7 0
> 		comment {
> 			access 'read write'
> 			type INTEGER
> 			count 8
> 			range '0 - 36'
> 		}
> 	}
> 	control.21 {
> 		iface PCM
> 		device 8
> 		name 'Playback Channel Map'
> 		value.0 0
> 		value.1 0
> 		value.2 0
> 		value.3 0
> 		value.4 0
> 		value.5 0
> 		value.6 0
> 		value.7 0
> 		comment {
> 			access 'read write'
> 			type INTEGER
> 			count 8
> 			range '0 - 36'
> 		}
> 	}
> }
> state.PCH {
> 	control.1 {
> 		iface MIXER
> 		name 'Headphone Playback Volume'
> 		value.0 0
> 		value.1 0
> 		comment {
> 			access 'read write'
> 			type INTEGER
> 			count 2
> 			range '0 - 87'
> 			dbmin -6525
> 			dbmax 0
> 			dbvalue.0 -6525
> 			dbvalue.1 -6525
> 		}
> 	}
> 	control.2 {
> 		iface MIXER
> 		name 'Headphone Playback Switch'
> 		value.0 true
> 		value.1 true
> 		comment {
> 			access 'read write'
> 			type BOOLEAN
> 			count 2
> 		}
> 	}
> 	control.3 {
> 		iface MIXER
> 		name 'Speaker Playback Volume'
> 		value.0 0
> 		value.1 0
> 		comment {
> 			access 'read write'
> 			type INTEGER
> 			count 2
> 			range '0 - 87'
> 			dbmin -6525
> 			dbmax 0
> 			dbvalue.0 -6525
> 			dbvalue.1 -6525
> 		}
> 	}
> 	control.4 {
> 		iface MIXER
> 		name 'Speaker Playback Switch'
> 		value.0 false
> 		value.1 false
> 		comment {
> 			access 'read write'
> 			type BOOLEAN
> 			count 2
> 		}
> 	}
> 	control.5 {
> 		iface MIXER
> 		name 'Mic Playback Volume'
> 		value.0 0
> 		value.1 0
> 		comment {
> 			access 'read write'
> 			type INTEGER
> 			count 2
> 			range '0 - 31'
> 			dbmin -3450
> 			dbmax 1200
> 			dbvalue.0 -3450
> 			dbvalue.1 -3450
> 		}
> 	}
> 	control.6 {
> 		iface MIXER
> 		name 'Mic Playback Switch'
> 		value.0 false
> 		value.1 false
> 		comment {
> 			access 'read write'
> 			type BOOLEAN
> 			count 2
> 		}
> 	}
> 	control.7 {
> 		iface MIXER
> 		name 'Auto-Mute Mode'
> 		value Enabled
> 		comment {
> 			access 'read write'
> 			type ENUMERATED
> 			count 1
> 			item.0 Disabled
> 			item.1 Enabled
> 		}
> 	}
> 	control.8 {
> 		iface MIXER
> 		name 'Capture Volume'
> 		value.0 0
> 		value.1 0
> 		comment {
> 			access 'read write'
> 			type INTEGER
> 			count 2
> 			range '0 - 63'
> 			dbmin -1725
> 			dbmax 3000
> 			dbvalue.0 -1725
> 			dbvalue.1 -1725
> 		}
> 	}
> 	control.9 {
> 		iface MIXER
> 		name 'Capture Switch'
> 		value.0 false
> 		value.1 false
> 		comment {
> 			access 'read write'
> 			type BOOLEAN
> 			count 2
> 		}
> 	}
> 	control.10 {
> 		iface MIXER
> 		name 'Mic Boost Volume'
> 		value.0 0
> 		value.1 0
> 		comment {
> 			access 'read write'
> 			type INTEGER
> 			count 2
> 			range '0 - 3'
> 			dbmin 0
> 			dbmax 3000
> 			dbvalue.0 0
> 			dbvalue.1 0
> 		}
> 	}
> 	control.11 {
> 		iface MIXER
> 		name 'Internal Mic Boost Volume'
> 		value.0 0
> 		value.1 0
> 		comment {
> 			access 'read write'
> 			type INTEGER
> 			count 2
> 			range '0 - 1'
> 			dbmin 0
> 			dbmax 1200
> 			dbvalue.0 0
> 			dbvalue.1 0
> 		}
> 	}
> 	control.12 {
> 		iface MIXER
> 		name 'Master Playback Volume'
> 		value 3
> 		comment {
> 			access 'read write'
> 			type INTEGER
> 			count 1
> 			range '0 - 87'
> 			dbmin -6525
> 			dbmax 0
> 			dbvalue.0 -6300
> 		}
> 	}
> 	control.13 {
> 		iface MIXER
> 		name 'Master Playback Switch'
> 		value true
> 		comment {
> 			access 'read write'
> 			type BOOLEAN
> 			count 1
> 		}
> 	}
> 	control.14 {
> 		iface CARD
> 		name 'Mic Jack'
> 		value false
> 		comment {
> 			access read
> 			type BOOLEAN
> 			count 1
> 		}
> 	}
> 	control.15 {
> 		iface CARD
> 		name 'Internal Mic Phantom Jack'
> 		value true
> 		comment {
> 			access read
> 			type BOOLEAN
> 			count 1
> 		}
> 	}
> 	control.16 {
> 		iface CARD
> 		name 'Headphone Jack'
> 		value true
> 		comment {
> 			access read
> 			type BOOLEAN
> 			count 1
> 		}
> 	}
> 	control.17 {
> 		iface CARD
> 		name 'Speaker Phantom Jack'
> 		value true
> 		comment {
> 			access read
> 			type BOOLEAN
> 			count 1
> 		}
> 	}
> 	control.18 {
> 		iface MIXER
> 		name 'Beep Playback Volume'
> 		value.0 0
> 		value.1 0
> 		comment {
> 			access 'read write'
> 			type INTEGER
> 			count 2
> 			range '0 - 31'
> 			dbmin -3450
> 			dbmax 1200
> 			dbvalue.0 -3450
> 			dbvalue.1 -3450
> 		}
> 	}
> 	control.19 {
> 		iface MIXER
> 		name 'Beep Playback Switch'
> 		value.0 false
> 		value.1 false
> 		comment {
> 			access 'read write'
> 			type BOOLEAN
> 			count 2
> 		}
> 	}
> 	control.20 {
> 		iface PCM
> 		name 'Playback Channel Map'
> 		value.0 0
> 		value.1 0
> 		comment {
> 			access read
> 			type INTEGER
> 			count 2
> 			range '0 - 36'
> 		}
> 	}
> 	control.21 {
> 		iface PCM
> 		name 'Capture Channel Map'
> 		value.0 0
> 		value.1 0
> 		comment {
> 			access read
> 			type INTEGER
> 			count 2
> 			range '0 - 36'
> 		}
> 	}
> }
> state.ThinkPadEC {
> 	control.1 {
> 		iface MIXER
> 		name 'Console Playback Switch'
> 		value true
> 		comment {
> 			access read
> 			type BOOLEAN
> 			count 1
> 		}
> 	}
> }
> --endcollapse--
> 
> 
> !!All Loaded Modules
> !!------------------
> 
> Module
> ctr
> ccm
> snd_hda_codec_realtek
> snd_hda_codec_hdmi
> snd_hda_codec_generic
> nls_iso8859_1
> nls_cp437
> vfat
> fat
> joydev
> xfs
> libcrc32c
> arc4
> iwlmvm
> mac80211
> iwlwifi
> cfg80211
> iTCO_wdt
> iTCO_vendor_support
> coretemp
> intel_rapl
> thinkpad_acpi
> x86_pkg_temp_thermal
> intel_powerclamp
> nvram
> mousedev
> kvm_intel
> snd_hda_intel
> snd_hda_controller
> snd_hda_codec
> snd_hwdep
> snd_pcm
> snd_timer
> snd
> uvcvideo
> videobuf2_vmalloc
> videobuf2_memops
> videobuf2_core
> v4l2_common
> videodev
> media
> kvm
> i915
> rtsx_pci_ms
> memstick
> thermal
> drm_kms_helper
> evdev
> drm
> mac_hid
> psmouse
> serio_raw
> e1000e
> led_class
> wmi
> rfkill
> soundcore
> tpm_tis
> intel_gtt
> mei_me
> battery
> ac
> hwmon
> mei
> tpm
> i2c_i801
> i2c_algo_bit
> i2c_core
> video
> ptp
> shpchp
> pps_core
> lpc_ich
> processor
> button
> sch_fq_codel
> ext4
> crc16
> mbcache
> jbd2
> algif_skcipher
> af_alg
> hid_logitech_dj
> usbhid
> hid
> dm_crypt
> dm_mod
> sd_mod
> crc_t10dif
> rtsx_pci_sdmmc
> mmc_core
> atkbd
> libps2
> crct10dif_pclmul
> crct10dif_common
> crc32_pclmul
> crc32c_intel
> ghash_clmulni_intel
> aesni_intel
> aes_x86_64
> lrw
> gf128mul
> glue_helper
> ablk_helper
> cryptd
> ahci
> libahci
> libata
> ehci_pci
> xhci_hcd
> scsi_mod
> ehci_hcd
> rtsx_pci
> usbcore
> usb_common
> i8042
> serio
> 
> 
> !!Sysfs Files
> !!-----------
> 
> /sys/class/sound/hwC0D0/init_pin_configs:
> 0x05 0x18560010
> 0x06 0x18560010
> 0x07 0x18560010
> 
> /sys/class/sound/hwC0D0/driver_pin_configs:
> 
> /sys/class/sound/hwC0D0/user_pin_configs:
> 
> /sys/class/sound/hwC0D0/init_verbs:
> 
> /sys/class/sound/hwC0D0/hints:
> 
> /sys/class/sound/hwC1D0/init_pin_configs:
> 0x12 0x90a60130
> 0x13 0x40000000
> 0x14 0x90170110
> 0x15 0x0321101f
> 0x16 0x411111f0
> 0x18 0x411111f0
> 0x19 0x411111f0
> 0x1a 0x03a11020
> 0x1b 0x411111f0
> 0x1d 0x40738105
> 0x1e 0x411111f0
> 
> /sys/class/sound/hwC1D0/driver_pin_configs:
> 
> /sys/class/sound/hwC1D0/user_pin_configs:
> 
> /sys/class/sound/hwC1D0/init_verbs:
> 
> /sys/class/sound/hwC1D0/hints:
> 
> 
> !!ALSA/HDA dmesg
> !!--------------
> 
> [   23.481291] [drm] Initialized i915 1.6.0 20140725 for 0000:00:02.0 on minor 0
> [   23.482981] snd_hda_intel 0000:00:1b.0: irq 47 for MSI/MSI-X
> [   23.487831] snd_hda_intel 0000:00:03.0: irq 48 for MSI/MSI-X
> [   23.518727] sound hdaudioC1D0: autoconfig: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
> [   23.518731] sound hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> [   23.518733] sound hdaudioC1D0:    hp_outs=1 (0x15/0x0/0x0/0x0/0x0)
> [   23.518734] sound hdaudioC1D0:    mono: mono_out=0x0
> [   23.518735] sound hdaudioC1D0:    inputs:
> [   23.518737] sound hdaudioC1D0:      Mic=0x1a
> [   23.518738] sound hdaudioC1D0:      Internal Mic=0x12
> [   23.541544] input: HDA Intel HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:03.0/sound/card0/input11
> [   23.541671] input: HDA Intel HDMI HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:03.0/sound/card0/input12
> [   23.541796] input: HDA Intel HDMI HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:03.0/sound/card0/input13
> [   23.542290] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/sound/card1/hdaudioC1D0/input14
> [   23.546460] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1b.0/sound/card1/input15
> [   23.546545] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card1/input16
> [   23.600969] e1000e 0000:00:19.0: irq 44 for MSI/MSI-X
> --
> [ 1501.741652] WARNING: CPU: 2 PID: 323 at net/wireless/reg.c:1806 reg_process_hint+0x2d1/0x460 [cfg80211]()
> [ 1501.741654] Modules linked in: ctr ccm snd_hda_codec_realtek snd_hda_codec_hdmi snd_hda_codec_generic nls_iso8859_1 nls_cp437 vfat fat joydev xfs libcrc32c arc4 iwlmvm mac80211 iwlwifi cfg80211 iTCO_wdt iTCO_vendor_support coretemp intel_rapl thinkpad_acpi x86_pkg_temp_thermal intel_powerclamp nvram mousedev kvm_intel snd_hda_intel snd_hda_controller snd_hda_codec snd_hwdep snd_pcm snd_timer snd uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_core v4l2_common videodev media kvm i915 rtsx_pci_ms memstick thermal drm_kms_helper evdev drm mac_hid psmouse serio_raw e1000e led_class wmi rfkill soundcore tpm_tis intel_gtt mei_me battery ac hwmon mei tpm i2c_i801 i2c_algo_bit i2c_core video ptp shpchp pps_core lpc_ich processor button sch_fq_codel ext4 crc16 mbcache jbd2 algif_skcipher
  af_alg hid_logitech_dj
> [ 1501.741706]  usbhid hid dm_crypt dm_mod sd_mod crc_t10dif rtsx_pci_sdmmc mmc_core atkbd libps2 crct10dif_pclmul crct10dif_common crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd ahci libahci libata ehci_pci xhci_hcd scsi_mod ehci_hcd rtsx_pci usbcore usb_common i8042 serio
> --
> [ 1501.925114] WARNING: CPU: 2 PID: 323 at net/wireless/reg.c:1806 reg_process_hint+0x2d1/0x460 [cfg80211]()
> [ 1501.925117] Modules linked in: ctr ccm snd_hda_codec_realtek snd_hda_codec_hdmi snd_hda_codec_generic nls_iso8859_1 nls_cp437 vfat fat joydev xfs libcrc32c arc4 iwlmvm mac80211 iwlwifi cfg80211 iTCO_wdt iTCO_vendor_support coretemp intel_rapl thinkpad_acpi x86_pkg_temp_thermal intel_powerclamp nvram mousedev kvm_intel snd_hda_intel snd_hda_controller snd_hda_codec snd_hwdep snd_pcm snd_timer snd uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_core v4l2_common videodev media kvm i915 rtsx_pci_ms memstick thermal drm_kms_helper evdev drm mac_hid psmouse serio_raw e1000e led_class wmi rfkill soundcore tpm_tis intel_gtt mei_me battery ac hwmon mei tpm i2c_i801 i2c_algo_bit i2c_core video ptp shpchp pps_core lpc_ich processor button sch_fq_codel ext4 crc16 mbcache jbd2 algif_skcipher
  af_alg hid_logitech_dj
> [ 1501.925185]  usbhid hid dm_crypt dm_mod sd_mod crc_t10dif rtsx_pci_sdmmc mmc_core atkbd libps2 crct10dif_pclmul crct10dif_common crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd ahci libahci libata ehci_pci xhci_hcd scsi_mod ehci_hcd rtsx_pci usbcore usb_common i8042 serio
> --
> [ 1502.176477] WARNING: CPU: 2 PID: 323 at net/wireless/reg.c:1806 reg_process_hint+0x2d1/0x460 [cfg80211]()
> [ 1502.176479] Modules linked in: ctr ccm snd_hda_codec_realtek snd_hda_codec_hdmi snd_hda_codec_generic nls_iso8859_1 nls_cp437 vfat fat joydev xfs libcrc32c arc4 iwlmvm mac80211 iwlwifi cfg80211 iTCO_wdt iTCO_vendor_support coretemp intel_rapl thinkpad_acpi x86_pkg_temp_thermal intel_powerclamp nvram mousedev kvm_intel snd_hda_intel snd_hda_controller snd_hda_codec snd_hwdep snd_pcm snd_timer snd uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_core v4l2_common videodev media kvm i915 rtsx_pci_ms memstick thermal drm_kms_helper evdev drm mac_hid psmouse serio_raw e1000e led_class wmi rfkill soundcore tpm_tis intel_gtt mei_me battery ac hwmon mei tpm i2c_i801 i2c_algo_bit i2c_core video ptp shpchp pps_core lpc_ich processor button sch_fq_codel ext4 crc16 mbcache jbd2 algif_skcipher
  af_alg hid_logitech_dj
> [ 1502.176529]  usbhid hid dm_crypt dm_mod sd_mod crc_t10dif rtsx_pci_sdmmc mmc_core atkbd libps2 crct10dif_pclmul crct10dif_common crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd ahci libahci libata ehci_pci xhci_hcd scsi_mod ehci_hcd rtsx_pci usbcore usb_common i8042 serio
> --
> [ 5204.097588] mei_me 0000:00:16.0: irq 43 for MSI/MSI-X
> [ 5204.097602] snd_hda_intel 0000:00:03.0: irq 41 for MSI/MSI-X
> [ 5204.097658] e1000e 0000:00:19.0: System wakeup disabled by ACPI
> [ 5204.097684] xhci_hcd 0000:00:14.0: irq 44 for MSI/MSI-X
> [ 5204.097769] snd_hda_intel 0000:00:1b.0: irq 47 for MSI/MSI-X
> [ 5204.098644] rtc_cmos 00:02: System wakeup disabled by ACPI
> --
> [ 5233.998236] WARNING: CPU: 3 PID: 7335 at net/wireless/reg.c:1806 reg_process_hint+0x2d1/0x460 [cfg80211]()
> [ 5233.998237] Modules linked in: ctr ccm snd_hda_codec_realtek snd_hda_codec_hdmi snd_hda_codec_generic nls_iso8859_1 nls_cp437 vfat fat joydev xfs libcrc32c arc4 iwlmvm mac80211 iwlwifi cfg80211 iTCO_wdt iTCO_vendor_support coretemp intel_rapl thinkpad_acpi x86_pkg_temp_thermal intel_powerclamp nvram mousedev kvm_intel snd_hda_intel snd_hda_controller snd_hda_codec snd_hwdep snd_pcm snd_timer snd uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_core v4l2_common videodev media kvm i915 rtsx_pci_ms memstick thermal drm_kms_helper evdev drm mac_hid psmouse serio_raw e1000e led_class wmi rfkill soundcore tpm_tis intel_gtt mei_me battery ac hwmon mei tpm i2c_i801 i2c_algo_bit i2c_core video ptp shpchp pps_core lpc_ich processor button sch_fq_codel ext4 crc16 mbcache jbd2 algif_skcipher
  af_alg hid_logitech_dj
> [ 5233.998287]  usbhid hid dm_crypt dm_mod sd_mod crc_t10dif rtsx_pci_sdmmc mmc_core atkbd libps2 crct10dif_pclmul crct10dif_common crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd ahci libahci libata ehci_pci xhci_hcd scsi_mod ehci_hcd rtsx_pci usbcore usb_common i8042 serio
> --
> [ 5234.103710] WARNING: CPU: 3 PID: 7335 at net/wireless/reg.c:1806 reg_process_hint+0x2d1/0x460 [cfg80211]()
> [ 5234.103712] Modules linked in: ctr ccm snd_hda_codec_realtek snd_hda_codec_hdmi snd_hda_codec_generic nls_iso8859_1 nls_cp437 vfat fat joydev xfs libcrc32c arc4 iwlmvm mac80211 iwlwifi cfg80211 iTCO_wdt iTCO_vendor_support coretemp intel_rapl thinkpad_acpi x86_pkg_temp_thermal intel_powerclamp nvram mousedev kvm_intel snd_hda_intel snd_hda_controller snd_hda_codec snd_hwdep snd_pcm snd_timer snd uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_core v4l2_common videodev media kvm i915 rtsx_pci_ms memstick thermal drm_kms_helper evdev drm mac_hid psmouse serio_raw e1000e led_class wmi rfkill soundcore tpm_tis intel_gtt mei_me battery ac hwmon mei tpm i2c_i801 i2c_algo_bit i2c_core video ptp shpchp pps_core lpc_ich processor button sch_fq_codel ext4 crc16 mbcache jbd2 algif_skcipher
  af_alg hid_logitech_dj
> [ 5234.103758]  usbhid hid dm_crypt dm_mod sd_mod crc_t10dif rtsx_pci_sdmmc mmc_core atkbd libps2 crct10dif_pclmul crct10dif_common crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd ahci libahci libata ehci_pci xhci_hcd scsi_mod ehci_hcd rtsx_pci usbcore usb_common i8042 serio
> --
> [ 5234.352794] WARNING: CPU: 3 PID: 7335 at net/wireless/reg.c:1806 reg_process_hint+0x2d1/0x460 [cfg80211]()
> [ 5234.352795] Modules linked in: ctr ccm snd_hda_codec_realtek snd_hda_codec_hdmi snd_hda_codec_generic nls_iso8859_1 nls_cp437 vfat fat joydev xfs libcrc32c arc4 iwlmvm mac80211 iwlwifi cfg80211 iTCO_wdt iTCO_vendor_support coretemp intel_rapl thinkpad_acpi x86_pkg_temp_thermal intel_powerclamp nvram mousedev kvm_intel snd_hda_intel snd_hda_controller snd_hda_codec snd_hwdep snd_pcm snd_timer snd uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_core v4l2_common videodev media kvm i915 rtsx_pci_ms memstick thermal drm_kms_helper evdev drm mac_hid psmouse serio_raw e1000e led_class wmi rfkill soundcore tpm_tis intel_gtt mei_me battery ac hwmon mei tpm i2c_i801 i2c_algo_bit i2c_core video ptp shpchp pps_core lpc_ich processor button sch_fq_codel ext4 crc16 mbcache jbd2 algif_skcipher
  af_alg hid_logitech_dj
> [ 5234.352840]  usbhid hid dm_crypt dm_mod sd_mod crc_t10dif rtsx_pci_sdmmc mmc_core atkbd libps2 crct10dif_pclmul crct10dif_common crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd ahci libahci libata ehci_pci xhci_hcd scsi_mod ehci_hcd rtsx_pci usbcore usb_common i8042 serio
> --
> [ 5313.936602] WARNING: CPU: 3 PID: 3811 at net/wireless/reg.c:1806 reg_process_hint+0x2d1/0x460 [cfg80211]()
> [ 5313.936603] Modules linked in: ctr ccm snd_hda_codec_realtek snd_hda_codec_hdmi snd_hda_codec_generic nls_iso8859_1 nls_cp437 vfat fat joydev xfs libcrc32c arc4 iwlmvm mac80211 iwlwifi cfg80211 iTCO_wdt iTCO_vendor_support coretemp intel_rapl thinkpad_acpi x86_pkg_temp_thermal intel_powerclamp nvram mousedev kvm_intel snd_hda_intel snd_hda_controller snd_hda_codec snd_hwdep snd_pcm snd_timer snd uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_core v4l2_common videodev media kvm i915 rtsx_pci_ms memstick thermal drm_kms_helper evdev drm mac_hid psmouse serio_raw e1000e led_class wmi rfkill soundcore tpm_tis intel_gtt mei_me battery ac hwmon mei tpm i2c_i801 i2c_algo_bit i2c_core video ptp shpchp pps_core lpc_ich processor button sch_fq_codel ext4 crc16 mbcache jbd2 algif_skcipher
  af_alg hid_logitech_dj
> [ 5313.936638]  usbhid hid dm_crypt dm_mod sd_mod crc_t10dif rtsx_pci_sdmmc mmc_core atkbd libps2 crct10dif_pclmul crct10dif_common crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd ahci libahci libata ehci_pci xhci_hcd scsi_mod ehci_hcd rtsx_pci usbcore usb_common i8042 serio
> --
> [ 5314.041499] WARNING: CPU: 3 PID: 3811 at net/wireless/reg.c:1806 reg_process_hint+0x2d1/0x460 [cfg80211]()
> [ 5314.041500] Modules linked in: ctr ccm snd_hda_codec_realtek snd_hda_codec_hdmi snd_hda_codec_generic nls_iso8859_1 nls_cp437 vfat fat joydev xfs libcrc32c arc4 iwlmvm mac80211 iwlwifi cfg80211 iTCO_wdt iTCO_vendor_support coretemp intel_rapl thinkpad_acpi x86_pkg_temp_thermal intel_powerclamp nvram mousedev kvm_intel snd_hda_intel snd_hda_controller snd_hda_codec snd_hwdep snd_pcm snd_timer snd uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_core v4l2_common videodev media kvm i915 rtsx_pci_ms memstick thermal drm_kms_helper evdev drm mac_hid psmouse serio_raw e1000e led_class wmi rfkill soundcore tpm_tis intel_gtt mei_me battery ac hwmon mei tpm i2c_i801 i2c_algo_bit i2c_core video ptp shpchp pps_core lpc_ich processor button sch_fq_codel ext4 crc16 mbcache jbd2 algif_skcipher
  af_alg hid_logitech_dj
> [ 5314.041538]  usbhid hid dm_crypt dm_mod sd_mod crc_t10dif rtsx_pci_sdmmc mmc_core atkbd libps2 crct10dif_pclmul crct10dif_common crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd ahci libahci libata ehci_pci xhci_hcd scsi_mod ehci_hcd rtsx_pci usbcore usb_common i8042 serio
> --
> [ 5314.290895] WARNING: CPU: 3 PID: 3811 at net/wireless/reg.c:1806 reg_process_hint+0x2d1/0x460 [cfg80211]()
> [ 5314.290897] Modules linked in: ctr ccm snd_hda_codec_realtek snd_hda_codec_hdmi snd_hda_codec_generic nls_iso8859_1 nls_cp437 vfat fat joydev xfs libcrc32c arc4 iwlmvm mac80211 iwlwifi cfg80211 iTCO_wdt iTCO_vendor_support coretemp intel_rapl thinkpad_acpi x86_pkg_temp_thermal intel_powerclamp nvram mousedev kvm_intel snd_hda_intel snd_hda_controller snd_hda_codec snd_hwdep snd_pcm snd_timer snd uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_core v4l2_common videodev media kvm i915 rtsx_pci_ms memstick thermal drm_kms_helper evdev drm mac_hid psmouse serio_raw e1000e led_class wmi rfkill soundcore tpm_tis intel_gtt mei_me battery ac hwmon mei tpm i2c_i801 i2c_algo_bit i2c_core video ptp shpchp pps_core lpc_ich processor button sch_fq_codel ext4 crc16 mbcache jbd2 algif_skcipher
  af_alg hid_logitech_dj
> [ 5314.290964]  usbhid hid dm_crypt dm_mod sd_mod crc_t10dif rtsx_pci_sdmmc mmc_core atkbd libps2 crct10dif_pclmul crct10dif_common crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd ahci libahci libata ehci_pci xhci_hcd scsi_mod ehci_hcd rtsx_pci usbcore usb_common i8042 serio
> 
> 

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="alsa-info.output.txt"


!!################################
!!ALSA Information Script v 0.4.64
!!################################

!!Script ran on: Sun Dec 14 13:51:19 UTC 2014


!!Linux Distribution
!!------------------

Arch Linux \r (\l) NAME="Arch Linux" ID=arch PRETTY_NAME="Arch Linux" HOME_URL="https://www.archlinux.org/" SUPPORT_URL="https://bbs.archlinux.org/" BUG_REPORT_URL="https://bugs.archlinux.org/"


!!DMI Information
!!---------------

Manufacturer:      LENOVO
Product Name:      20ALCTO1WW
Product Version:   ThinkPad X240
Firmware Version:  GIET69WW (2.19 )


!!Kernel Information
!!------------------

Kernel release:    3.17.6-1-ARCH
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         unknown
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     k3.17.6-1-ARCH
Library version:    1.0.28
Utilities version:  1.0.28


!!Loaded ALSA modules
!!-------------------

snd_hda_intel
snd_hda_intel
thinkpad_acpi


!!Sound Servers on this system
!!----------------------------

Jack:
      Installed - Yes (/usr/bin/jackd)
      Running - No


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [PCH            ]: HDA-Intel - HDA Intel PCH
                      HDA Intel PCH at 0xf0634000 irq 50
 1 [HDMI           ]: HDA-Intel - HDA Intel HDMI
                      HDA Intel HDMI at 0xf0630000 irq 49
29 [ThinkPadEC     ]: ThinkPad EC - ThinkPad Console Audio Control
                      ThinkPad Console Audio Control at EC reg 0x30, fw unknown


!!PCI Soundcards installed in the system
!!--------------------------------------

00:03.0 Audio device: Intel Corporation Haswell-ULT HD Audio Controller (rev 0b)
00:1b.0 Audio device: Intel Corporation 8 Series HD Audio Controller (rev 04)


!!Advanced information - PCI Vendor/Device/Subsystem ID's
!!-------------------------------------------------------

00:03.0 0403: 8086:0a0c (rev 0b)
	Subsystem: 17aa:2214
--
00:1b.0 0403: 8086:9c20 (rev 04)
	Subsystem: 17aa:2214


!!Modprobe options (Sound related)
!!--------------------------------

snd_hda_intel: index=0 model=auto vid=8086 pid=9c20
snd_hda_intel: index=1 model=auto vid=8086 pid=0c0c


!!Loaded sound module options
!!---------------------------

!!Module: snd_hda_intel
	align_buffer_size : -1
	bdl_pos_adj : 32,1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	beep_mode : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	enable_msi : -1
	id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	index : 1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	jackpoll_ms : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	model : auto,(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	patch : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	position_fix : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	power_save : 0
	power_save_controller : N
	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	probe_only : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	single_cmd : N
	snoop : Y

!!Module: snd_hda_intel
	align_buffer_size : -1
	bdl_pos_adj : 32,1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	beep_mode : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	enable_msi : -1
	id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	index : 1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	jackpoll_ms : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	model : auto,(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	patch : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	position_fix : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	power_save : 0
	power_save_controller : N
	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	probe_only : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	single_cmd : N
	snoop : Y

!!Module: thinkpad_acpi
	brightness_enable : 2
	brightness_mode : 4
	enable : Y
	experimental : 0
	fan_control : N
	force_load : N
	id : ThinkPadEC
	index : -536870912
	volume_capabilities : 0
	volume_control : N
	volume_mode : 3


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Realtek ALC3232
Address: 0
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x10ec0292
Subsystem Id: 0x17aa2214
Revision Id: 0x100001
No Modem Function Group found
Default PCM:
    rates [0x5f0]: 32000 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
  Power states:  D0 D1 D2 D3 CLKSTOP EPSS
  Power: setting=D0, actual=D0
GPIO: io=5, o=0, i=0, unsolicited=1, wake=0
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[3]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[4]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Node 0x02 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name="Headphone Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Device: name="ALC3232 Analog", type="Audio", device=0
  Amp-Out caps: ofs=0x57, nsteps=0x57, stepsize=0x02, mute=0
  Amp-Out vals:  [0x55 0x55]
  Converter: stream=8, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x03 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name="Speaker Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x57, nsteps=0x57, stepsize=0x02, mute=0
  Amp-Out vals:  [0x56 0x56]
  Converter: stream=8, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x04 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x05 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x06 [Audio Output] wcaps 0x611: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x5f0]: 32000 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x08 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x3f, stepsize=0x02, mute=1
  Amp-In vals:  [0x97 0x97]
  Converter: stream=0, channel=0
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
  Control: name="Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Capture Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Device: name="ALC3232 Analog", type="Audio", device=0
  Amp-In caps: ofs=0x17, nsteps=0x3f, stepsize=0x02, mute=1
  Amp-In vals:  [0x3f 0x3f]
  Converter: stream=4, channel=0
  SDI-Select: 0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x22
Node 0x0a [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Control: name="Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=2, ofs=0
  Control: name="Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=2, ofs=0
  Control: name="Beep Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=4, ofs=0
  Control: name="Beep Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=4, ofs=0
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 5
     0x18 0x19 0x1a 0x1b 0x1d
Node 0x0c [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Connection: 2
     0x02 0x0b
Node 0x0d [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Connection: 2
     0x03 0x0b
Node 0x0e [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0f [Audio Mixer] wcaps 0x20010a: Mono Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80] [0x00]
  Connection: 2
     0x02 0x03
Node 0x10 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x12 [Pin Complex] wcaps 0x40040b: Stereo Amp-In
  Control: name="Internal Mic Boost Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Internal Mic Phantom Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000020: IN
  Pin Default 0x90a60130: [Fixed] Mic at Int N/A
    Conn = Digital, Color = Unknown
    DefAssociation = 0x3, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x13 [Pin Complex] wcaps 0x40040b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000020: IN
  Pin Default 0x40000000: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0x0, Sequence = 0x0
  Pin-ctls: 0x00:
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x14 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Speaker Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Speaker Phantom Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x00]
  Pincap 0x00010010: OUT EAPD
  EAPD 0x2: EAPD
  Pin Default 0x90170110: [Fixed] Speaker at Int N/A
    Conn = Analog, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 2
     0x0c 0x0d*
Node 0x15 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Headphone Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0001001c: OUT HP EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x0321101f: [Jack] HP Out at Ext Left
    Conn = 1/8, Color = Black
    DefAssociation = 0x1, Sequence = 0xf
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=01, enabled=1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 2
     0x0c* 0x0d
Node 0x16 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0001001c: OUT HP EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 2
     0x0c* 0x0d
Node 0x17 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x18 [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00003734: IN OUT Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 2
     0x0c* 0x0d
Node 0x19 [Pin Complex] wcaps 0x40048b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000024: IN Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x1a [Pin Complex] wcaps 0x40048b: Stereo Amp-In
  Control: name="Mic Boost Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Mic Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00003724: IN Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x03a11020: [Jack] Mic at Ext Left
    Conn = 1/8, Color = Black
    DefAssociation = 0x2, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=02, enabled=1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x1b [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00003734: IN OUT Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 2
     0x0c* 0x0d
Node 0x1c [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1d [Pin Complex] wcaps 0x400400: Mono
  Pincap 0x00000020: IN
  Pin Default 0x40738105: [N/A] Modem Hand at Ext N/A
    Conn = ATAPI, Color = Purple
    DefAssociation = 0x0, Sequence = 0x5
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x1e [Pin Complex] wcaps 0x400781: Stereo Digital
  Pincap 0x00000014: OUT Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x06
Node 0x1f [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
  Processing caps: benign=0, ncoeff=124
Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x22 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 8
     0x18 0x19 0x1a 0x1b 0x1d 0x0b 0x12* 0x13
Node 0x23 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 6
     0x18* 0x19 0x1a 0x1b 0x1d 0x0b
Node 0x24 [Vendor Defined Widget] wcaps 0xf00000: Mono
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
  Power: setting=D0, actual=D0, Clock-stop-OK
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x02 [Audio Output] wcaps 0x6611: 8-Channels Digital
  Converter: stream=0, channel=0
  Digital: Enabled KAE
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
  Digital: Enabled KAE
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x5]: PCM AC3
  Power states:  D0 D3 EPSS
  Power: setting=D3, actual=D3
Node 0x04 [Audio Output] wcaps 0x6611: 8-Channels Digital
  Converter: stream=0, channel=0
  Digital: Enabled KAE
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x5]: PCM AC3
  Power states:  D0 D3 EPSS
  Power: setting=D3, actual=D3
Node 0x05 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
  Control: name="HDMI/DP,pcm=3 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=0, device=0
  Control: name="IEC958 Playback Pro Mask", index=0, device=0
  Control: name="IEC958 Playback Default", index=0, device=0
  Control: name="IEC958 Playback Switch", index=0, device=0
  Control: name="ELD", index=0, device=3
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0b000094: OUT Detect HBR HDMI DP
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=01, enabled=1
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Devices: 0
  Connection: 0
  In-driver Connection: 3
     0x02 0x03 0x04
Node 0x06 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
  Control: name="HDMI/DP,pcm=7 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=1, device=0
  Control: name="IEC958 Playback Pro Mask", index=1, device=0
  Control: name="IEC958 Playback Default", index=1, device=0
  Control: name="IEC958 Playback Switch", index=1, device=0
  Control: name="ELD", index=0, device=7
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0b000094: OUT Detect HBR HDMI DP
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=02, enabled=1
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Devices: 0
  Connection: 0
  In-driver Connection: 3
     0x02 0x03 0x04
Node 0x07 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
  Control: name="HDMI/DP,pcm=8 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=2, device=0
  Control: name="IEC958 Playback Pro Mask", index=2, device=0
  Control: name="IEC958 Playback Default", index=2, device=0
  Control: name="IEC958 Playback Switch", index=2, device=0
  Control: name="ELD", index=0, device=8
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0b000094: OUT Detect HBR HDMI DP
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=03, enabled=1
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Devices: 0
  Connection: 0
  In-driver Connection: 3
     0x02 0x03 0x04
Node 0x08 [Vendor Defined Widget] wcaps 0xf00000: Mono
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----  1 root audio 116,  8 Dec 14 14:43 /dev/snd/controlC0
crw-rw----  1 root audio 116,  3 Dec 14 14:43 /dev/snd/controlC1
crw-rw----  1 root audio 116,  2 Dec 14 14:43 /dev/snd/controlC29
crw-rw----  1 root audio 116, 11 Dec 14 14:43 /dev/snd/hwC0D0
crw-rw----  1 root audio 116,  7 Dec 14 14:43 /dev/snd/hwC1D0
crw-rw----  1 root audio 116, 10 Dec 14 14:49 /dev/snd/pcmC0D0c
crw-rw----  1 root audio 116,  9 Dec 14 14:50 /dev/snd/pcmC0D0p
crw-rw----  1 root audio 116,  4 Dec 14 14:43 /dev/snd/pcmC1D3p
crw-rw----  1 root audio 116,  5 Dec 14 14:43 /dev/snd/pcmC1D7p
crw-rw----  1 root audio 116,  6 Dec 14 14:43 /dev/snd/pcmC1D8p
crw-rw----  1 root audio 116,  1 Dec 14 14:43 /dev/snd/seq
crw-rw----  1 root audio 116, 33 Dec 14 14:43 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root 100 Dec 14 14:43 .
drwxr-xr-x 3 root root 300 Dec 14 14:43 ..
lrwxrwxrwx 1 root root  12 Dec 14 14:43 pci-0000:00:03.0 -> ../controlC1
lrwxrwxrwx 1 root root  12 Dec 14 14:43 pci-0000:00:1b.0 -> ../controlC0
lrwxrwxrwx 1 root root  13 Dec 14 14:43 platform-thinkpad_acpi -> ../controlC29


!!Aplay/Arecord output
!!--------------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: PCH [HDA Intel PCH], device 0: ALC3232 Analog [ALC3232 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: HDMI [HDA Intel HDMI], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: HDMI [HDA Intel HDMI], device 7: HDMI 1 [HDMI 1]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: HDMI [HDA Intel HDMI], device 8: HDMI 2 [HDMI 2]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: PCH [HDA Intel PCH], device 0: ALC3232 Analog [ALC3232 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [PCH]

Card hw:0 'PCH'/'HDA Intel PCH at 0xf0634000 irq 50'
  Mixer name	: 'Realtek ALC3232'
  Components	: 'HDA:10ec0292,17aa2214,00100001'
  Controls      : 23
  Simple ctrls  : 11
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 87
  Mono: Playback 87 [100%] [0.00dB] [on]
Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 87
  Mono:
  Front Left: Playback 85 [98%] [-1.50dB] [on]
  Front Right: Playback 85 [98%] [-1.50dB] [on]
Simple mixer control 'Speaker',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 87
  Mono:
  Front Left: Playback 86 [99%] [-0.75dB] [off]
  Front Right: Playback 86 [99%] [-0.75dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 254 [100%] [-0.20dB]
  Front Right: Playback 254 [100%] [-0.20dB]
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
  Front Left: 0 [0%] [0.00dB]
  Front Right: 0 [0%] [0.00dB]
Simple mixer control 'Beep',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 63
  Front Left: Capture 63 [100%] [30.00dB] [on]
  Front Right: Capture 63 [100%] [30.00dB] [on]
Simple mixer control 'Auto-Mute Mode',0
  Capabilities: enum
  Items: 'Disabled' 'Enabled'
  Item0: 'Disabled'
Simple mixer control 'Digital',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 120
  Front Left: Capture 60 [50%] [0.00dB]
  Front Right: Capture 60 [50%] [0.00dB]
Simple mixer control 'Internal Mic Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 1
  Front Left: 0 [0%] [0.00dB]
  Front Right: 0 [0%] [0.00dB]

!!-------Mixer controls for card 1 [HDMI]

Card hw:1 'HDMI'/'HDA Intel HDMI at 0xf0630000 irq 49'
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

!!-------Mixer controls for card 29 [ThinkPadEC]

Card hw:29 'ThinkPadEC'/'ThinkPad Console Audio Control at EC reg 0x30, fw unknown'
  Mixer name	: 'ThinkPad EC (unknown)'
  Components	: ''
  Controls      : 1
  Simple ctrls  : 1
Simple mixer control 'Console',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]


!!Alsactl output
!!--------------

--startcollapse--
state.PCH {
	control.1 {
		iface MIXER
		name 'Headphone Playback Volume'
		value.0 85
		value.1 85
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 87'
			dbmin -6525
			dbmax 0
			dbvalue.0 -150
			dbvalue.1 -150
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
		value.0 86
		value.1 86
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 87'
			dbmin -6525
			dbmax 0
			dbvalue.0 -75
			dbvalue.1 -75
		}
	}
	control.4 {
		iface MIXER
		name 'Speaker Playback Switch'
		value.0 false
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.5 {
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
	control.6 {
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
	control.7 {
		iface MIXER
		name 'Auto-Mute Mode'
		value Disabled
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Disabled
			item.1 Enabled
		}
	}
	control.8 {
		iface MIXER
		name 'Capture Volume'
		value.0 63
		value.1 63
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 63'
			dbmin -1725
			dbmax 3000
			dbvalue.0 3000
			dbvalue.1 3000
		}
	}
	control.9 {
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
	control.10 {
		iface MIXER
		name 'Mic Boost Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 3'
			dbmin 0
			dbmax 3000
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.11 {
		iface MIXER
		name 'Internal Mic Boost Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 1'
			dbmin 0
			dbmax 1200
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.12 {
		iface MIXER
		name 'Master Playback Volume'
		value 87
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 87'
			dbmin -6525
			dbmax 0
			dbvalue.0 0
		}
	}
	control.13 {
		iface MIXER
		name 'Master Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.14 {
		iface CARD
		name 'Mic Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.15 {
		iface CARD
		name 'Internal Mic Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.16 {
		iface CARD
		name 'Headphone Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.17 {
		iface CARD
		name 'Speaker Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.18 {
		iface MIXER
		name 'Beep Playback Volume'
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
	control.19 {
		iface MIXER
		name 'Beep Playback Switch'
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.20 {
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
	control.21 {
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
	control.22 {
		iface MIXER
		name 'PCM Playback Volume'
		value.0 254
		value.1 254
		comment {
			access 'read write user'
			type INTEGER
			count 2
			range '0 - 255'
			tlv '0000000100000008ffffec1400000014'
			dbmin -5100
			dbmax 0
			dbvalue.0 -20
			dbvalue.1 -20
		}
	}
	control.23 {
		iface MIXER
		name 'Digital Capture Volume'
		value.0 60
		value.1 60
		comment {
			access 'read write user'
			type INTEGER
			count 2
			range '0 - 120'
			tlv '0000000100000008fffff44800000032'
			dbmin -3000
			dbmax 3000
			dbvalue.0 0
			dbvalue.1 0
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
		iface CARD
		name 'HDMI/DP,pcm=7 Jack'
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
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
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
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
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
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
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
		name 'HDMI/DP,pcm=8 Jack'
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
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
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
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
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
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
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
state.ThinkPadEC {
	control.1 {
		iface MIXER
		name 'Console Playback Switch'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
uvcvideo
videobuf2_vmalloc
videobuf2_memops
ecb
videobuf2_core
btusb
v4l2_common
bluetooth
videodev
media
joydev
mousedev
arc4
nls_iso8859_1
nls_cp437
vfat
fat
snd_hda_codec_realtek
snd_hda_codec_hdmi
snd_hda_codec_generic
iwlmvm
coretemp
intel_rapl
x86_pkg_temp_thermal
mac80211
intel_powerclamp
kvm_intel
kvm
crct10dif_pclmul
crc32_pclmul
iTCO_wdt
iTCO_vendor_support
crc32c_intel
ghash_clmulni_intel
aesni_intel
iwlwifi
aes_x86_64
rtsx_pci_ms
lrw
gf128mul
snd_hda_intel
memstick
glue_helper
cfg80211
snd_hda_controller
ablk_helper
pcspkr
cryptd
psmouse
snd_hda_codec
serio_raw
thinkpad_acpi
e1000e
wmi
snd_hwdep
i2c_i801
nvram
tpm_tis
snd_pcm
led_class
mei_me
tpm
ptp
rfkill
snd_timer
hwmon
evdev
snd
ac
mei
mac_hid
battery
pps_core
soundcore
thermal
shpchp
lpc_ich
processor
sch_fq_codel
pci_stub
vboxpci
vboxnetflt
vboxnetadp
vboxdrv
nfs
lockd
sunrpc
fscache
acpi_call
ext4
crc16
mbcache
jbd2
sd_mod
crc_t10dif
crct10dif_common
ahci
libahci
rtsx_pci_sdmmc
atkbd
mmc_core
libps2
ehci_pci
libata
ehci_hcd
scsi_mod
xhci_hcd
rtsx_pci
usbcore
usb_common
i8042
serio
i915
button
intel_gtt
i2c_algo_bit
video
drm_kms_helper
drm
i2c_core


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x12 0x90a60130
0x13 0x40000000
0x14 0x90170110
0x15 0x0321101f
0x16 0x411111f0
0x18 0x411111f0
0x19 0x411111f0
0x1a 0x03a11020
0x1b 0x411111f0
0x1d 0x40738105
0x1e 0x411111f0

/sys/class/sound/hwC0D0/driver_pin_configs:

/sys/class/sound/hwC0D0/user_pin_configs:

/sys/class/sound/hwC0D0/init_verbs:

/sys/class/sound/hwC0D0/hints:

/sys/class/sound/hwC1D0/init_pin_configs:
0x05 0x18560010
0x06 0x18560010
0x07 0x18560010

/sys/class/sound/hwC1D0/driver_pin_configs:

/sys/class/sound/hwC1D0/user_pin_configs:

/sys/class/sound/hwC1D0/init_verbs:

/sys/class/sound/hwC1D0/hints:


!!ALSA/HDA dmesg
!!--------------

[    2.962965] cfg80211: Calling CRDA to update world regulatory domain
[    2.966417] snd_hda_intel: unknown parameter 'vid' ignored
[    2.966419] snd_hda_intel: unknown parameter 'pid' ignored
[    2.966421] snd_hda_intel: unknown parameter 'vid' ignored
[    2.966422] snd_hda_intel: unknown parameter 'pid' ignored
[    2.979575] Intel(R) Wireless WiFi driver for Linux, in-tree:
--
[    3.111712] e1000e 0000:00:19.0 eth0: MAC: 11, PHY: 12, PBA No: 1000FF-0FF
[    3.111938] snd_hda_intel 0000:00:03.0: irq 49 for MSI/MSI-X
[    3.112082] snd_hda_intel 0000:00:1b.0: irq 50 for MSI/MSI-X
[    3.116757] e1000e 0000:00:19.0 enp0s25: renamed from eth0
[    3.129443] sound hdaudioC0D0: autoconfig: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[    3.129448] sound hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    3.129450] sound hdaudioC0D0:    hp_outs=1 (0x15/0x0/0x0/0x0/0x0)
[    3.129452] sound hdaudioC0D0:    mono: mono_out=0x0
[    3.129453] sound hdaudioC0D0:    inputs:
[    3.129455] sound hdaudioC0D0:      Mic=0x1a
[    3.129457] sound hdaudioC0D0:      Internal Mic=0x12
[    3.148784] input: HDA Intel HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:03.0/sound/card1/input9
[    3.148885] input: HDA Intel HDMI HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:03.0/sound/card1/input10
[    3.148960] input: HDA Intel HDMI HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:03.0/sound/card1/input11
[    3.149649] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/sound/card0/hdaudioC0D0/input12
[    3.150315] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input13
[    3.150696] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input14
[    3.193362] random: nonblocking pool is initialized
--
[    8.282573] input: TPPS/2 IBM TrackPoint as /devices/platform/i8042/serio1/serio2/input/input15
[   80.041444] snd_hda_intel 0000:00:1b.0: IRQ timing workaround is activated for card #0. Suggest a bigger bdl_pos_adj.



--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--lMM8JwqTlfDpEaS6--
