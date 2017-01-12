From: Enrico Mioso <mrkiko.rs@gmail.com>
Subject: Re: Intel HDA audio on EEE PC 1101HGo
Date: Thu, 12 Jan 2017 15:05:32 +0100 (CET)
Message-ID: <alpine.LNX.2.20.1701121501490.2201@localhost.localdomain>
References: <alpine.LNX.2.20.1504082130290.1715@localhost.localdomain>
 <s5hegntl2cs.wl-tiwai@suse.de>
 <alpine.LNX.2.20.1611230916070.5938@localhost.localdomain>
 <s5hr35s0xh2.wl-tiwai@suse.de>
 <alpine.LNX.2.20.1612011450060.7660@localhost.localdomain>
 <s5h4m2n21ll.wl-tiwai@suse.de>
 <alpine.LNX.2.20.1701031449090.1620@localhost.localdomain>
 <s5hlgujyyop.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f66.google.com (mail-lf0-f66.google.com
 [209.85.215.66])
 by alsa0.perex.cz (Postfix) with ESMTP id CEEE3266AFF
 for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2017 15:05:37 +0100 (CET)
Received: by mail-lf0-f66.google.com with SMTP id v186so1957005lfa.2
 for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2017 06:05:37 -0800 (PST)
In-Reply-To: <s5hlgujyyop.wl-tiwai@suse.de>
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
Cc: hui.wang@canonical.com, alsa-devel@alsa-project.org, kailang@realtek.com
List-Id: alsa-devel@alsa-project.org

Hello Takashi,
hello to all of you reading this message.
If wish to thank you all again.

With this patch applied, thesystem is stable.
And the module reports only a small amount of messages:
[   18.054976] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC269: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[   18.067358] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   18.080055] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x15/0x0/0x0/0x0/0x0)
[   18.092172] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[   18.104042] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[   18.147300] snd_hda_codec_realtek hdaudioC0D0:      Mic=0x18
[   18.191065] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x12
[   18.247499] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/sound/card0/input8
[   18.285601] input: HDA Intel MID Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input9
[   18.310620] input: HDA Intel MID Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input10
[ 5379.300565] snd_hda_intel 0000:00:1b.0: Invalid position buffer, using LPIB read method instead.

So it seems all is working fine now. thank you very much for your help and patience.
power_save -> 40
power_save_controller -> Y

Thank you again,
waiting for further instructions... I would like this to be fixed / fixable in upstream.

My /proc/asound/card0/codec#0 contains what follows:
Codec: Realtek ALC269
Address: 0
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x10ec0269
Subsystem Id: 0x104383ce
Revision Id: 0x100004
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
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x02 [Audio Output] wcaps 0x1d: Stereo Amp-Out
   Control: name="Headphone Playback Volume", index=0, device=0
     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
   Device: name="ALC269 Analog", type="Audio", device=0
   Amp-Out caps: ofs=0x3f, nsteps=0x40, stepsize=0x03, mute=0
   Amp-Out vals:  [0x40 0x40]
   Converter: stream=0, channel=0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
Node 0x03 [Audio Output] wcaps 0x1d: Stereo Amp-Out
   Control: name="Speaker Playback Volume", index=0, device=0
     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
   Amp-Out caps: ofs=0x3f, nsteps=0x40, stepsize=0x03, mute=0
   Amp-Out vals:  [0x40 0x40]
   Converter: stream=0, channel=0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
Node 0x04 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x05 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
   Converter: stream=0, channel=0
   Digital:
   Digital category: 0x0
   IEC Coding Type: 0x0
   PCM:
     rates [0x5f0]: 32000 44100 48000 88200 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
Node 0x07 [Audio Input] wcaps 0x10011b: Stereo Amp-In
   Amp-In caps: ofs=0x11, nsteps=0x2e, stepsize=0x03, mute=1
   Amp-In vals:  [0x90 0x90]
   Converter: stream=0, channel=0
   SDI-Select: 0
   PCM:
     rates [0x160]: 44100 48000 96000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Connection: 1
      0x24
Node 0x08 [Audio Input] wcaps 0x10011b: Stereo Amp-In
   Control: name="Capture Volume", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=0, ofs=0
   Control: name="Capture Switch", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=0, ofs=0
   Device: name="ALC269 Analog", type="Audio", device=0
   Amp-In caps: ofs=0x11, nsteps=0x2e, stepsize=0x03, mute=1
   Amp-In vals:  [0x1d 0x1d]
   Converter: stream=0, channel=0
   SDI-Select: 0
   PCM:
     rates [0x160]: 44100 48000 96000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Connection: 1
      0x23
Node 0x09 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0a [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
   Control: name="Mic Playback Volume", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=0, ofs=0
   Control: name="Mic Playback Switch", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=0, ofs=0
   Control: name="Beep Playback Volume", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=4, ofs=0
   Control: name="Beep Playback Switch", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=4, ofs=0
   Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
   Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x13 0x13]
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
Node 0x0e [Audio Mixer] wcaps 0x20010a: Mono Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00] [0x80]
   Connection: 2
      0x0c 0x0d
Node 0x0f [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x10 [Audio Output] wcaps 0x211: Stereo Digital
   Converter: stream=0, channel=0
   Digital:
   Digital category: 0x0
   IEC Coding Type: 0x0
   PCM:
     rates [0x5f0]: 32000 44100 48000 88200 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
Node 0x11 [Pin Complex] wcaps 0x400380: Mono Digital
   Pincap 0x00000014: OUT Detect
   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x40: OUT
   Unsolicited: tag=00, enabled=0
   Connection: 1
      0x10
Node 0x12 [Pin Complex] wcaps 0x400001: Stereo
   Pincap 0x00000020: IN
   Pin Default 0x99a30920: [Fixed] Mic at Int ATAPI
     Conn = ATAPI, Color = Unknown
     DefAssociation = 0x2, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x20: IN
Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x14 [Pin Complex] wcaps 0x40010d: Stereo Amp-Out
   Control: name="Speaker Playback Switch", index=0, device=0
     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x00 0x00]
   Pincap 0x00010050: OUT EAPD Balanced
   EAPD 0x2: EAPD
   Pin Default 0x99130110: [Fixed] Speaker at Int ATAPI
     Conn = ATAPI, Color = Unknown
     DefAssociation = 0x1, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x00:
   Connection: 2
      0x0c 0x0d*
Node 0x15 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
   Control: name="Headphone Playback Switch", index=0, device=0
     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x00 0x00]
   Pincap 0x0001001c: OUT HP EAPD Detect
   EAPD 0x2: EAPD
   Pin Default 0x0421441f: [Jack] HP Out at Ext Right
     Conn = 1/8, Color = Green
     DefAssociation = 0x1, Sequence = 0xf
   Pin-ctls: 0xc0: OUT HP
   Unsolicited: tag=01, enabled=1
   Connection: 2
      0x0c* 0x0d
Node 0x16 [Pin Complex] wcaps 0x40010c: Mono Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80]
   Pincap 0x00000010: OUT
   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x00:
   Connection: 1
      0x0e
Node 0x17 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
   Control: name="Mic Boost Volume", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=0, ofs=0
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x00003734: IN OUT Detect
     Vref caps: HIZ 50 GRD 80 100
   Pin Default 0x04a19830: [Jack] Mic at Ext Right
     Conn = 1/8, Color = Pink
     DefAssociation = 0x3, Sequence = 0x0
   Pin-ctls: 0x24: IN VREF_80
   Unsolicited: tag=02, enabled=1
   Connection: 2
      0x0c* 0x0d
Node 0x19 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
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
   Connection: 2
      0x0c* 0x0d
Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x0000373c: IN OUT HP Detect
     Vref caps: HIZ 50 GRD 80 100
   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x20: IN VREF_HIZ
   Unsolicited: tag=00, enabled=0
   Connection: 2
      0x0c* 0x0d
Node 0x1b [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
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
   Connection: 2
      0x0c* 0x0d
Node 0x1c [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1d [Pin Complex] wcaps 0x400000: Mono
   Pincap 0x00000020: IN
   Pin Default 0x4005822d: [N/A] Line Out at Ext N/A
     Conn = Optical, Color = Purple
     DefAssociation = 0x2, Sequence = 0xd
   Pin-ctls: 0x20: IN
Node 0x1e [Pin Complex] wcaps 0x400380: Mono Digital
   Pincap 0x00000014: OUT Detect
   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x40: OUT
   Unsolicited: tag=00, enabled=0
   Connection: 1
      0x06
Node 0x1f [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
   Processing caps: benign=0, ncoeff=33
Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x22 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x23 [Audio Selector] wcaps 0x300101: Stereo
   Connection: 7
      0x18 0x19 0x1a 0x1b 0x1d 0x12* 0x0b
Node 0x24 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
   Connection: 6
      0x18 0x19 0x1a 0x1b 0x1d 0x0b

On Tue, 10 Jan 2017, Takashi Iwai wrote:

> Date: Tue, 10 Jan 2017 11:52:22
> From: Takashi Iwai <tiwai@suse.de>
> To: Enrico Mioso <mrkiko.rs@gmail.com>
> Cc: hui.wang@canonical.com, alsa-devel@alsa-project.org, kailang@realtek.com
> Subject: Re: [alsa-devel] Intel HDA audio on EEE PC 1101HGo
> 
> On Tue, 03 Jan 2017 14:49:40 +0100,
> Enrico Mioso wrote:
>>
>> hello Tahaski,
>> hello everyone reading this message.
>>
>> Thank you for the patience you had with me. Now I finally came to set up this system for crash analysis, compiling the kernel with debug informations and frame pointers and so on. I set up kdump also. Unfortunately, I can get no useful output.
>> The last things the system wrote before dying have been reconstructed. I noted down decimal values with the help of my mum. She wrote them down on a piece of paper.
>> I am hitting the following messages:
>> azx_get_response timeout, switching to polling mode: last cmd=0x014ba000
>> azx_get_response timeout, switching to single_cmd mode: last cmd=0x014ba000
>
> It's reading the output amp on NID 0x14, the speaker pin.  It's weird
> that such a verb triggers the problem.  Usually the unexpected
> behavior is triggered at the widget power up/down.
>
> If the switching to single cmd mode causes an issue, you can disable
> by the patch like below.  This may lead to the continuous errors,
> though.
>
>
> Takashi
>
> ---
> diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
> index 500878556578..43bf151d8712 100644
> --- a/sound/pci/hda/hda_controller.c
> +++ b/sound/pci/hda/hda_controller.c
> @@ -861,6 +861,7 @@ static int azx_rirb_get_response(struct hdac_bus *bus, unsigned int addr,
> 		return -EIO;
> 	}
>
> +#if 0
> 	/* a fatal communication error; need either to reset or to fallback
> 	 * to the single_cmd mode
> 	 */
> @@ -875,6 +876,7 @@ static int azx_rirb_get_response(struct hdac_bus *bus, unsigned int addr,
> 	chip->single_cmd = 1;
> 	hbus->response_reset = 0;
> 	snd_hdac_bus_stop_cmd_io(bus);
> +#endif
> 	return -EIO;
> }
>
>
