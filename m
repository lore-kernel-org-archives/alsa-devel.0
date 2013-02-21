From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: HDA regression on Fujitsu S7020 laptop (ALC260
	codec)
Date: Thu, 21 Feb 2013 21:24:05 +0800
Message-ID: <CAN8ccibAsWUVCcEem-ykcouJ6RXEG8k-eq9mPf7VV7qPied6nw@mail.gmail.com>
References: <s5h8v7xjw4f.wl%tiwai@suse.de>
 <20130210114707.GA26574@marvin.atrad.com.au>
 <s5hzjzbql3a.wl%tiwai@suse.de>
 <20130216112505.GE4164@marvin.atrad.com.au>
 <s5h8v6ncpcp.wl%tiwai@suse.de>
 <20130217125316.GA25824@marvin.atrad.com.au>
 <s5h1ucedgge.wl%tiwai@suse.de> <s5hzjyzi8a5.wl%tiwai@suse.de>
 <20130220121055.GA23804@marvin.atrad.com.au>
 <s5hip5ni0ur.wl%tiwai@suse.de>
 <20130221121540.GA11524@marvin.atrad.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f176.google.com (mail-vc0-f176.google.com
 [209.85.220.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 63FB3261643
 for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2013 14:24:08 +0100 (CET)
Received: by mail-vc0-f176.google.com with SMTP id fk10so5702183vcb.21
 for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2013 05:24:07 -0800 (PST)
In-Reply-To: <20130221121540.GA11524@marvin.atrad.com.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Woithe <jwoithe@just42.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, peter.golden@btinternet.com, ullinux@ymail.com
List-Id: alsa-devel@alsa-project.org

> > > > >
> > > > > No, we need to try to implement something and discuss later.
> > > > > I think simply implementing two things would work: providing the
vref
> > > > > setup in Headphone Jack Mode enum, and add a pin to the Input
Source.
> > > > > User would require two setups, but it's less conflicting with
giving
> > > > > implicit dependency with each other, IMO.
> > > >
> > > > FYI, sound-unstable git tree test/hda-hp-mic branch contains the new
> > > > patches.  Pass model=fujitsu-jwse option, and all features will be
> > > > enabled
>
> I was able to test sound-unstable this evening (reporting a kernel version
> of 3.8.0-rc7+).  I passed "model=fujitsu-jwse" as instructed.  The
> "Headphone Mic" mode switch influences the headphone jack when it's
> configured as an input as I expect is the intent.  The speaker still works
> and the speaker/headphone controls behave as expected.  In short there
> appear to be no regressions in these respects.

Can you confirm that the speaker really need this patch to work ?

http://git.kernel.org/?p=linux/kernel/git/tiwai/sound.git;a=commit;h=978e77e78cff7a85a31ad552ffd8afee319e8721

Does the headphone Jack or Mic Jack  support imedpance sense to
differentiate the Jack type or not  ?

The behaviour of this notebook and e8020 will be different from other
notebook

No auto Mic selection because CD and non detectable dock line in

>
> Output from /proc/asound/card0/codec#0 under 3.8.0-rc7+ using
> "model=fujitsu-jmse":
>
> Codec: Realtek ALC260
> Address: 0
> AFG Function Id: 0x1 (unsol 1)
> Vendor Id: 0x10ec0260
> Subsystem Id: 0x10cf0000
> Revision Id: 0x100400
> No Modem Function Group found
> Default PCM:
>     rates [0x560]: 44100 48000 96000 192000
>     bits [0xe]: 16 20 24
>     formats [0x1]: PCM
> Default Amp-In caps: N/A
> Default Amp-Out caps: N/A
> State of AFG node 0x01:
>   Power states:  D0 D1 D2 D3
>   Power: setting=D0, actual=D0
> GPIO: io=4, o=0, i=0, unsolicited=1, wake=0
>   IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>   IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>   IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>   IO[3]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
> Node 0x02 [Audio Output] wcaps 0x11: Stereo
>   Device: name="ALC260 Analog", type="Audio", device=0
>   Converter: stream=8, channel=0
>   PCM:
>     rates [0x560]: 44100 48000 96000 192000
>     bits [0xe]: 16 20 24
>     formats [0x1]: PCM
> Node 0x03 [Audio Output] wcaps 0x211: Stereo Digital
>   Converter: stream=0, channel=0
>   Digital:
>   Digital category: 0x0
>   IEC Coding Type: 0x0
>   PCM:
>     rates [0x560]: 44100 48000 96000 192000
>     bits [0x1e]: 16 20 24 32
>     formats [0x1]: PCM
> Node 0x04 [Audio Input] wcaps 0x10011b: Stereo Amp-In
>   Control: name="Capture Volume", index=0, device=0
>     ControlAmp: chs=3, dir=In, idx=0, ofs=0
>   Control: name="Capture Switch", index=0, device=0
>     ControlAmp: chs=3, dir=In, idx=0, ofs=0
>   Device: name="ALC260 Analog", type="Audio", device=0
>   Amp-In caps: ofs=0x00, nsteps=0x23, stepsize=0x03, mute=1
>   Amp-In vals:  [0x0c 0x0c]
>   Converter: stream=0, channel=0
>   SDI-Select: 0
>   PCM:
>     rates [0x160]: 44100 48000 96000
>     bits [0x6]: 16 20
>     formats [0x1]: PCM
>   Connection: 7
>      0x12 0x13* 0x14 0x15 0x16 0x0f 0x10
> Node 0x05 [Audio Input] wcaps 0x10011b: Stereo Amp-In
>   Control: name="Capture Volume", index=1, device=0
>     ControlAmp: chs=3, dir=In, idx=0, ofs=0
>   Control: name="Capture Switch", index=1, device=0
>     ControlAmp: chs=3, dir=In, idx=0, ofs=0
>   Device: name="ALC260 Alt Analog", type="Audio", device=2
>   Amp-In caps: ofs=0x00, nsteps=0x23, stepsize=0x03, mute=1
>   Amp-In vals:  [0x00 0x00]
>   Converter: stream=4, channel=0
>   SDI-Select: 0
>   PCM:
>     rates [0x160]: 44100 48000 96000
>     bits [0x6]: 16 20
>     formats [0x1]: PCM
>   Connection: 8
>      0x12 0x13 0x14* 0x15 0x16 0x07 0x0f 0x10
> Node 0x06 [Audio Input] wcaps 0x100391: Stereo Digital
>   Converter: stream=0, channel=0
>   SDI-Select: 0
>   Digital:
>   Digital category: 0x0
>   IEC Coding Type: 0x0
>   PCM:
>     rates [0x160]: 44100 48000 96000
>     bits [0x1e]: 16 20 24 32
>     formats [0x1]: PCM
>   Unsolicited: tag=00, enabled=0
>   Connection: 1
>      0x19
> Node 0x07 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>   Control: name="Mic Playback Volume", index=0, device=0
>     ControlAmp: chs=3, dir=In, idx=0, ofs=0
>   Control: name="Mic Playback Switch", index=0, device=0
>     ControlAmp: chs=3, dir=In, idx=0, ofs=0
>   Control: name="Line Playback Volume", index=0, device=0
>     ControlAmp: chs=3, dir=In, idx=1, ofs=0
>   Control: name="Line Playback Switch", index=0, device=0
>     ControlAmp: chs=3, dir=In, idx=1, ofs=0
>   Control: name="CD Playback Volume", index=0, device=0
>     ControlAmp: chs=3, dir=In, idx=4, ofs=0
>   Control: name="CD Playback Switch", index=0, device=0
>     ControlAmp: chs=3, dir=In, idx=4, ofs=0
>   Control: name="Headphone Mic Playback Volume", index=0, device=0
>     ControlAmp: chs=3, dir=In, idx=2, ofs=0
>   Control: name="Headphone Mic Playback Switch", index=0, device=0
>     ControlAmp: chs=3, dir=In, idx=2, ofs=0
>   Amp-In caps: ofs=0x23, nsteps=0x41, stepsize=0x03, mute=1
>   Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x03
0x03] [0x80 0x80] [0x80 0x80] [0x80 0x80]
>   Connection: 8
>      0x12 0x13 0x14 0x15 0x16 0x17 0x0f 0x10
> Node 0x08 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>   Control: name="Headphone Playback Volume", index=0, device=0
>     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
>   Amp-Out vals:  [0x27 0x27]
>   Connection: 2
>      0x02 0x07
> Node 0x09 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>   Control: name="Speaker Playback Volume", index=0, device=0
>     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
>   Amp-Out vals:  [0x33 0x33]
>   Connection: 2
>      0x02 0x07
> Node 0x0a [Audio Mixer] wcaps 0x20010e: Mono Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x00] [0x80]
>   Amp-Out caps: ofs=0x23, nsteps=0x41, stepsize=0x03, mute=0
>   Amp-Out vals:  [0x23]
>   Connection: 2
>      0x02 0x07
> Node 0x0b [Audio Selector] wcaps 0x300101: Stereo
>   Connection: 2
>      0x08* 0x09
> Node 0x0c [Audio Selector] wcaps 0x300101: Stereo
>   Connection: 2
>      0x08* 0x09
> Node 0x0d [Audio Selector] wcaps 0x300101: Stereo
>   Connection: 2
>      0x08* 0x09
> Node 0x0e [Audio Selector] wcaps 0x300101: Stereo
>   Connection: 2
>      0x08* 0x09
> Node 0x0f [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x80 0x80]
>   Pincap 0x0001003f: IN OUT HP EAPD Detect Trigger ImpSense
>   EAPD 0x2: EAPD
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn = 1/8, Color = Black
>     DefAssociation = 0xf, Sequence = 0x0
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x20: IN
>   Unsolicited: tag=00, enabled=0
>   Connection: 1
>      0x08
> Node 0x10 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
>   Control: name="Speaker Playback Switch", index=0, device=0
>     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>   Control: name="Speaker Phantom Jack", index=0, device=0
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x00 0x00]
>   Pincap 0x0001003f: IN OUT HP EAPD Detect Trigger ImpSense
>   EAPD 0x2: EAPD
>   Pin Default 0xe4011110: [Both] Line Out at Sep Right
>     Conn = 1/8, Color = Black
>     DefAssociation = 0x1, Sequence = 0x0
>     Misc = NO_PRESENCE
>   Pin-ctls: 0xc0: OUT HP
>   Unsolicited: tag=00, enabled=0
>   Connection: 1
>      0x09
> Node 0x11 [Pin Complex] wcaps 0x40010c: Mono Amp-Out
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x80]
>   Pincap 0x00000010: OUT
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn = 1/8, Color = Black
>     DefAssociation = 0xf, Sequence = 0x0
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x40: OUT
>   Connection: 1
>      0x0a
> Node 0x12 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
>   Control: name="Mic Jack", index=0, device=0
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x80 0x80]
>   Pincap 0x0000133f: IN OUT HP Detect Trigger ImpSense
>     Vref caps: HIZ 50 80
>   Pin Default 0x03a11820: [Jack] Mic at Ext Left
>     Conn = 1/8, Color = Black
>     DefAssociation = 0x2, Sequence = 0x0
>   Pin-ctls: 0x20: IN VREF_HIZ
>   Unsolicited: tag=03, enabled=1
>   Connection: 1
>      0x0b
> Node 0x13 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
>   Control: name="Line Phantom Jack", index=0, device=0
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x80 0x80]
>   Pincap 0x0000133f: IN OUT HP Detect Trigger ImpSense
>     Vref caps: HIZ 50 80
>   Pin Default 0x24811121: [Jack] Line In at Sep Right
>     Conn = 1/8, Color = Black
>     DefAssociation = 0x2, Sequence = 0x1
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x20: IN VREF_HIZ
>   Unsolicited: tag=00, enabled=0
>   Connection: 1
>      0x0c
> Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
>   Control: name="Headphone Playback Switch", index=0, device=0
>     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>   Control: name="Headphone Mic Jack", index=0, device=0
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x00 0x00]
>   Pincap 0x0000133f: IN OUT HP Detect Trigger ImpSense
>     Vref caps: HIZ 50 80
>   Pin Default 0x0321101f: [Jack] HP Out at Ext Left
>     Conn = 1/8, Color = Black
>     DefAssociation = 0x1, Sequence = 0xf
>   Pin-ctls: 0x24: IN VREF_80
>   Unsolicited: tag=01, enabled=1
>   Connection: 1
>      0x0d
> Node 0x15 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x80 0x80]
>   Pincap 0x0000133f: IN OUT HP Detect Trigger ImpSense
>     Vref caps: HIZ 50 80
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn = 1/8, Color = Black
>     DefAssociation = 0xf, Sequence = 0x0
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x20: IN VREF_HIZ
>   Unsolicited: tag=00, enabled=0
>   Connection: 1
>      0x0e
> Node 0x16 [Pin Complex] wcaps 0x400001: Stereo
>   Control: name="CD Phantom Jack", index=0, device=0
>   Pincap 0x00000020: IN
>   Pin Default 0x88331122: [Fixed] CD at Ext Drive Bar
>     Conn = ATAPI, Color = Black
>     DefAssociation = 0x2, Sequence = 0x2
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x00:
> Node 0x17 [Pin Complex] wcaps 0x400000: Mono
>   Pincap 0x00000020: IN
>   Pin Default 0xb7931123: [Fixed] Aux at Oth Mobile-In
>     Conn = ATAPI, Color = Black
>     DefAssociation = 0x2, Sequence = 0x3
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x00:
> Node 0x18 [Pin Complex] wcaps 0x400380: Mono Digital
>   Pincap 0x00000014: OUT Detect
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn = 1/8, Color = Black
>     DefAssociation = 0xf, Sequence = 0x0
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x00:
>   Unsolicited: tag=00, enabled=0
>   Connection: 1
>      0x03
> Node 0x19 [Pin Complex] wcaps 0x400280: Mono Digital
>   Pincap 0x00000024: IN Detect
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn = 1/8, Color = Black
>     DefAssociation = 0xf, Sequence = 0x0
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x00:
>   Unsolicited: tag=00, enabled=0
