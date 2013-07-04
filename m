From: Tormen <my.nl.abos@gmail.com>
Subject: Re: No sound with Sony VAIO VPCZ1 (ALC889)
Date: Fri, 05 Jul 2013 00:53:48 +0200
Message-ID: <51D5FCFC.8010506@gmail.com>
References: <51D464A5.6040507@gmail.com> <51D59D60.9020105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
 [209.85.212.177])
 by alsa0.perex.cz (Postfix) with ESMTP id EE8422657EC
 for <alsa-devel@alsa-project.org>; Fri,  5 Jul 2013 00:53:51 +0200 (CEST)
Received: by mail-wi0-f177.google.com with SMTP id ey16so1617190wid.10
 for <alsa-devel@alsa-project.org>; Thu, 04 Jul 2013 15:53:51 -0700 (PDT)
In-Reply-To: <51D59D60.9020105@gmail.com>
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Dear Takashi,
As you were involved in both threads below, I dared to cc you on this.
I hope you don't mind.
Tormen.


Hi again,

I digged again into google and stumbled across this thread from a year ago:
http://mailman.alsa-project.org/pipermail/alsa-devel/2012-March/050504.html

I have the same Notebook than Adam.

The thread stopped there. I contacted Adam and he confirmed me something 
I also had noticed (but forgotten):
     The sound output via the speakers broke (went silent) between 3.1 
and 3.2.
     It was working though for sometime between 3.2 and 3.9.6 - I 
confirmed it to be working in 3.7!
     And now it is broken again.

I also had found this thread (before posting):
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-February/059462.html 

Which seems to be related ("caused Vaio Z laptops to become silent").
And I tried passing "model=no-primary-hp" to snd-hda-intel.ko (see my 
alsa-info.sh) .... but without effect

Thanks a lot for any hint on this. I would be very glad to assist in 
getting this fixed for good :)


Tormen

--

On 04/07/13 18:05, Tormen wrote:
> Hi,
>
> I guess, no one had time yet, to look at the below issue I posted.
>
> To be more clear:
> The speakers do not get detected [anymore]. So the sound in mplayer 
> plays fine, but you hear nothing ;)
> And on the line-out (with headphones) the sound is audible and works 
> fine.
>
> And also of course:
> What could I provide to assist with this ?
>
>
> Thanks a lot,
>
> Tormen.
>
> ---
>
> On 03/07/13 19:51, Tormen wrote:
>> Hi,
>>
>> alsa-driver:     1.0.25.3453.g60df0     (the latest I guess -- I used 
>> alsa-compile.sh)
>> Kernel:            3.9.6-1~bpo70+1 (debian 7.1 backport)
>>
>> Problem:
>> Sound works fine, except that no speaker gets detected.
>> The internal speakers in my Sony VAIO VPCZ1 notebook did get detected 
>> in the past though.
>>
>> If I am not mistaken, this is the problem:
>>     [    5.864681] ALSA hda_auto_parser.c:397    speaker_outs=0 
>> (0x0/0x0/0x0/0x0/0x0)
>>
>>
>> alsa-info.sh:
>>
>> !!################################
>> !!ALSA Information Script v 0.4.62
>> !!################################
>>
>> !!Script ran on: Wed Jul  3 17:38:37 UTC 2013
>>
>>
>> !!Linux Distribution
>> !!------------------
>>
>> Debian GNU/Linux 7 \n \l PRETTY_NAME="Debian GNU/Linux 7 (wheezy)" 
>> NAME="Debian GNU/Linux" ID=debian HOME_URL="http://www.debian.org/" 
>> SUPPORT_URL="http://www.debian.org/support/" 
>> BUG_REPORT_URL="http://bugs.debian.org/"
>>
>>
>> !!DMI Information
>> !!---------------
>>
>> Manufacturer:      Sony Corporation
>> Product Name:      VPCZ1290S
>> Product Version:   J0049ZZ5
>> Firmware Version:  R3030C3
>>
>>
>> !!Kernel Information
>> !!------------------
>>
>> Kernel release:    3.9-0.bpo.1-amd64
>> Operating System:  GNU/Linux
>> Architecture:      x86_64
>> Processor:         unknown
>> SMP Enabled:       Yes
>>
>>
>> !!ALSA Version
>> !!------------
>>
>> Driver version:     1.0.25.3453.g60df0
>> Library version:    1.0.25
>> Utilities version:  1.0.25
>>
>>
>> !!Loaded ALSA modules
>> !!-------------------
>>
>> snd_hda_intel
>>
>>
>> !!Sound Servers on this system
>> !!----------------------------
>>
>> Pulseaudio:
>>       Installed - Yes (/usr/bin/pulseaudio)
>>       Running - Yes
>>
>>
>> !!Soundcards recognised by ALSA
>> !!-----------------------------
>>
>>  0 [MID            ]: HDA-Intel - HDA Intel MID
>>                       HDA Intel MID at 0xb6420000 irq 45
>>
>>
>> !!PCI Soundcards installed in the system
>> !!--------------------------------------
>>
>> 00:1b.0 Audio device: Intel Corporation 5 Series/3400 Series Chipset 
>> High Definition Audio (rev 05)
>>
>>
>> !!Advanced information - PCI Vendor/Device/Subsystem ID's
>> !!-------------------------------------------------------
>>
>> 00:1b.0 0403: 8086:3b56 (rev 05)
>>     Subsystem: 104d:905a
>>
>>
>> !!Modprobe options (Sound related)
>> !!--------------------------------
>>
>> snd_pcsp: index=-2
>> snd_usb_audio: index=-2
>> snd_atiixp_modem: index=-2
>> snd_intel8x0m: index=-2
>> snd_via82xx_modem: index=-2
>> snd_hda_intel: model=no-primary-hp
>>
>>
>> !!Loaded sound module options
>> !!---------------------------
>>
>> !!Module: snd_hda_intel
>>     align_buffer_size : -1
>>     bdl_pos_adj : 32,-1,-1,-1,-1,-1,-1,-1
>>     beep_mode : Y,Y,Y,Y,Y,Y,Y,Y
>>     enable : Y,Y,Y,Y,Y,Y,Y,Y
>>     enable_msi : -1
>>     id : (null),(null),(null),(null),(null),(null),(null),(null)
>>     index : -1,-1,-1,-1,-1,-1,-1,-1
>>     jackpoll_ms : 0,0,0,0,0,0,0,0
>>     model : 
>> no-primary-hp,(null),(null),(null),(null),(null),(null),(null)
>>     patch : (null),(null),(null),(null),(null),(null),(null),(null)
>>     position_fix : -1,-1,-1,-1,-1,-1,-1,-1
>>     power_save : 0
>>     power_save_controller : Y
>>     probe_mask : -1,-1,-1,-1,-1,-1,-1,-1
>>     probe_only : 0,0,0,0,0,0,0,0
>>     single_cmd : N
>>     snoop : Y
>>
>>
>> !!HDA-Intel Codec information
>> !!---------------------------
>> --startcollapse--
>>
>> Codec: Realtek ALC889
>> Address: 0
>> AFG Function Id: 0x1 (unsol 1)
>> Vendor Id: 0x10ec0889
>> Subsystem Id: 0x104d4400
>> Revision Id: 0x100005
>> No Modem Function Group found
>> Default PCM:
>>     rates [0x5f0]: 32000 44100 48000 88200 96000 192000
>>     bits [0xe]: 16 20 24
>>     formats [0x1]: PCM
>> Default Amp-In caps: N/A
>> Default Amp-Out caps: N/A
>> State of AFG node 0x01:
>>   Power states:  D0 D1 D2 D3 CLKSTOP EPSS
>>   Power: setting=D0, actual=D0
>> GPIO: io=2, o=0, i=0, unsolicited=1, wake=1
>>   IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>>   IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>> Node 0x02 [Audio Output] wcaps 0x11: Stereo
>>   Device: name="ALC889 Analog", type="Audio", device=0
>>   Converter: stream=8, channel=0
>>   PCM:
>>     rates [0x5e0]: 44100 48000 88200 96000 192000
>>     bits [0xe]: 16 20 24
>>     formats [0x1]: PCM
>> Node 0x03 [Audio Output] wcaps 0x11: Stereo
>>   Converter: stream=8, channel=0
>>   PCM:
>>     rates [0x5e0]: 44100 48000 88200 96000 192000
>>     bits [0xe]: 16 20 24
>>     formats [0x1]: PCM
>> Node 0x04 [Audio Output] wcaps 0x11: Stereo
>>   Converter: stream=8, channel=0
>>   PCM:
>>     rates [0x5e0]: 44100 48000 88200 96000 192000
>>     bits [0xe]: 16 20 24
>>     formats [0x1]: PCM
>> Node 0x05 [Audio Output] wcaps 0x11: Stereo
>>   Converter: stream=8, channel=0
>>   PCM:
>>     rates [0x5e0]: 44100 48000 88200 96000 192000
>>     bits [0xe]: 16 20 24
>>     formats [0x1]: PCM
>> Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
>>   Converter: stream=0, channel=0
>>   Digital:
>>   Digital category: 0x0
>>   IEC Coding Type: 0x0
>>   PCM:
>>     rates [0x5f0]: 32000 44100 48000 88200 96000 192000
>>     bits [0xe]: 16 20 24
>>     formats [0x1]: PCM
>> Node 0x07 [Audio Input] wcaps 0x10011b: Stereo Amp-In
>>   Control: name="Capture Volume", index=0, device=0
>>     ControlAmp: chs=3, dir=In, idx=0, ofs=0
>>   Control: name="Capture Switch", index=0, device=0
>>     ControlAmp: chs=3, dir=In, idx=0, ofs=0
>>   Device: name="ALC889 Analog", type="Audio", device=0
>>   Amp-In caps: ofs=0x10, nsteps=0x2e, stepsize=0x03, mute=1
>>   Amp-In vals:  [0x28 0x28]
>>   Converter: stream=4, channel=0
>>   SDI-Select: 0
>>   PCM:
>>     rates [0x5e0]: 44100 48000 88200 96000 192000
>>     bits [0xe]: 16 20 24
>>     formats [0x1]: PCM
>>   Connection: 1
>>      0x24
>> Node 0x08 [Audio Input] wcaps 0x10011b: Stereo Amp-In
>>   Amp-In caps: ofs=0x10, nsteps=0x2e, stepsize=0x03, mute=1
>>   Amp-In vals:  [0x90 0x90]
>>   Converter: stream=0, channel=0
>>   SDI-Select: 0
>>   PCM:
>>     rates [0x5e0]: 44100 48000 88200 96000 192000
>>     bits [0xe]: 16 20 24
>>     formats [0x1]: PCM
>>   Connection: 1
>>      0x23
>> Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In
>>   Amp-In caps: ofs=0x10, nsteps=0x2e, stepsize=0x03, mute=1
>>   Amp-In vals:  [0x90 0x90]
>>   Converter: stream=0, channel=0
>>   SDI-Select: 0
>>   PCM:
>>     rates [0x5e0]: 44100 48000 88200 96000 192000
>>     bits [0xe]: 16 20 24
>>     formats [0x1]: PCM
>>   Connection: 1
>>      0x22
>> Node 0x0a [Audio Input] wcaps 0x100391: Stereo Digital
>>   Converter: stream=0, channel=0
>>   SDI-Select: 0
>>   Digital:
>>   Digital category: 0x0
>>   IEC Coding Type: 0x0
>>   PCM:
>>     rates [0x570]: 32000 44100 48000 96000 192000
>>     bits [0xe]: 16 20 24
>>     formats [0x1]: PCM
>>   Unsolicited: tag=00, enabled=0
>>   Connection: 1
>>      0x1f
>> Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>>   Control: name="Mic Playback Volume", index=0, device=0
>>     ControlAmp: chs=3, dir=In, idx=0, ofs=0
>>   Control: name="Mic Playback Switch", index=0, device=0
>>     ControlAmp: chs=3, dir=In, idx=0, ofs=0
>>   Control: name="Mic Playback Volume", index=1, device=0
>>     ControlAmp: chs=3, dir=In, idx=1, ofs=0
>>   Control: name="Mic Playback Switch", index=1, device=0
>>     ControlAmp: chs=3, dir=In, idx=1, ofs=0
>>   Control: name="Beep Playback Volume", index=0, device=0
>>     ControlAmp: chs=3, dir=In, idx=5, ofs=0
>>   Control: name="Beep Playback Switch", index=0, device=0
>>     ControlAmp: chs=3, dir=In, idx=5, ofs=0
>>   Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
>>   Amp-In vals:  [0x8f 0x8f] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 
>> 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
>>   Connection: 10
>>      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17
>> Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>>   Control: name="Headphone Playback Volume", index=0, device=0
>>     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>>   Amp-In vals:  [0x00 0x00] [0x00 0x00]
>>   Amp-Out caps: ofs=0x3e, nsteps=0x40, stepsize=0x03, mute=0
>>   Amp-Out vals:  [0x3e 0x3e]
>>   Connection: 2
>>      0x02 0x0b
>> Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>>   Control: name="Surround Playback Volume", index=0, device=0
>>     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>>   Amp-In vals:  [0x80 0x80] [0x80 0x80]
>>   Amp-Out caps: ofs=0x3e, nsteps=0x40, stepsize=0x03, mute=0
>>   Amp-Out vals:  [0x3e 0x3e]
>>   Connection: 2
>>      0x03 0x0b
>> Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>>   Control: name="Center Playback Volume", index=0, device=0
>>     ControlAmp: chs=1, dir=Out, idx=0, ofs=0
>>   Control: name="LFE Playback Volume", index=0, device=0
>>     ControlAmp: chs=2, dir=Out, idx=0, ofs=0
>>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>>   Amp-In vals:  [0x80 0x80] [0x80 0x80]
>>   Amp-Out caps: ofs=0x3e, nsteps=0x40, stepsize=0x03, mute=0
>>   Amp-Out vals:  [0x3e 0x3e]
>>   Connection: 2
>>      0x04 0x0b
>> Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>>   Control: name="Speaker Playback Volume", index=0, device=0
>>     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>>   Amp-In vals:  [0x00 0x00] [0x00 0x00]
>>   Amp-Out caps: ofs=0x3e, nsteps=0x40, stepsize=0x03, mute=0
>>   Amp-Out vals:  [0x40 0x40]
>>   Connection: 2
>>      0x05 0x0b
>> Node 0x10 [Audio Output] wcaps 0x211: Stereo Digital
>>   Converter: stream=0, channel=0
>>   Digital:
>>   Digital category: 0x0
>>   IEC Coding Type: 0x0
>>   PCM:
>>     rates [0x5f0]: 32000 44100 48000 88200 96000 192000
>>     bits [0xe]: 16 20 24
>>     formats [0x1]: PCM
>> Node 0x11 [Pin Complex] wcaps 0x400300: Mono Digital
>>   Pincap 0x00000010: OUT
>>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>>     Conn = 1/8, Color = Black
>>     DefAssociation = 0xf, Sequence = 0x0
>>     Misc = NO_PRESENCE
>>   Pin-ctls: 0x40: OUT
>>   Connection: 1
>>      0x10
>> Node 0x12 [Pin Complex] wcaps 0x400001: Stereo
>>   Control: name="Internal Mic Phantom Jack", index=0, device=0
>>   Pincap 0x00000020: IN
>>   Pin Default 0x90a60120: [Fixed] Mic at Int N/A
>>     Conn = Digital, Color = Unknown
>>     DefAssociation = 0x2, Sequence = 0x0
>>     Misc = NO_PRESENCE
>>   Pin-ctls: 0x20: IN
>> Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
>> Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
>>   Control: name="Speaker Playback Switch", index=0, device=0
>>     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>>   Control: name="Speaker Phantom Jack", index=0, device=0
>>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>>   Amp-Out vals:  [0x00 0x00]
>>   Pincap 0x0001003c: IN OUT HP EAPD Detect
>>   EAPD 0x2: EAPD
>>   Pin Default 0x90170110: [Fixed] Speaker at Int N/A
>>     Conn = Analog, Color = Unknown
>>     DefAssociation = 0x1, Sequence = 0x0
>>     Misc = NO_PRESENCE
>>   Pin-ctls: 0x40: OUT
>>   Unsolicited: tag=00, enabled=0
>>   Connection: 5
>>      0x0c 0x0d 0x0e 0x0f* 0x26
>> Node 0x15 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
>>   Control: name="Headphone Playback Switch", index=0, device=0
>>     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>>   Control: name="Headphone Jack", index=0, device=0
>>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>>   Amp-Out vals:  [0x00 0x00]
>>   Pincap 0x0001003c: IN OUT HP EAPD Detect
>>   EAPD 0x2: EAPD
>>   Pin Default 0x0421101f: [Jack] HP Out at Ext Right
>>     Conn = 1/8, Color = Black
>>     DefAssociation = 0x1, Sequence = 0xf
>>   Pin-ctls: 0xc0: OUT HP
>>   Unsolicited: tag=01, enabled=1
>>   Connection: 5
>>      0x0c* 0x0d 0x0e 0x0f 0x26
>> Node 0x16 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
>>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>>   Amp-Out vals:  [0x80 0x80]
>>   Pincap 0x00000034: IN OUT Detect
>>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>>     Conn = 1/8, Color = Black
>>     DefAssociation = 0xf, Sequence = 0x0
>>     Misc = NO_PRESENCE
>>   Pin-ctls: 0x00:
>>   Unsolicited: tag=00, enabled=0
>>   Connection: 5
>>      0x0c 0x0d 0x0e* 0x0f 0x26
>> Node 0x17 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
>>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>>   Amp-Out vals:  [0x80 0x80]
>>   Pincap 0x00000034: IN OUT Detect
>>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>>     Conn = 1/8, Color = Black
>>     DefAssociation = 0xf, Sequence = 0x0
>>     Misc = NO_PRESENCE
>>   Pin-ctls: 0x00:
>>   Unsolicited: tag=00, enabled=0
>>   Connection: 5
>>      0x0c 0x0d 0x0e 0x0f* 0x26
>> Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>>   Control: name="Surround Playback Switch", index=0, device=0
>>     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>>   Control: name="Mic Boost Volume", index=0, device=0
>>     ControlAmp: chs=3, dir=In, idx=0, ofs=0
>>   Control: name="Mic Jack", index=0, device=0
>>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>>   Amp-In vals:  [0x00 0x00]
>>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>>   Amp-Out vals:  [0x00 0x00]
>>   Pincap 0x0000373c: IN OUT HP Detect
>>     Vref caps: HIZ 50 GRD 80 100
>>   Pin Default 0x04a1102e: [Jack] Mic at Ext Right
>>     Conn = 1/8, Color = Black
>>     DefAssociation = 0x2, Sequence = 0xe
>>   Pin-ctls: 0x24: IN VREF_80
>>   Unsolicited: tag=02, enabled=1
>>   Connection: 5
>>      0x0c 0x0d 0x0e 0x0f 0x26*
>> Node 0x19 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>>   Control: name="Center Playback Switch", index=0, device=0
>>     ControlAmp: chs=1, dir=Out, idx=0, ofs=0
>>   Control: name="LFE Playback Switch", index=0, device=0
>>     ControlAmp: chs=2, dir=Out, idx=0, ofs=0
>>   Control: name="Mic Boost Volume", index=1, device=0
>>     ControlAmp: chs=3, dir=In, idx=0, ofs=0
>>   Control: name="Mic Jack", index=1, device=0
>>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>>   Amp-In vals:  [0x00 0x00]
>>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>>   Amp-Out vals:  [0x00 0x00]
>>   Pincap 0x0000373c: IN OUT HP Detect
>>     Vref caps: HIZ 50 GRD 80 100
>>   Pin Default 0x04a11030: [Jack] Mic at Ext Right
>>     Conn = 1/8, Color = Black
>>     DefAssociation = 0x3, Sequence = 0x0
>>   Pin-ctls: 0x24: IN VREF_80
>>   Unsolicited: tag=03, enabled=1
>>   Connection: 5
>>      0x0c 0x0d 0x0e 0x0f 0x26*
>> Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>>   Amp-In vals:  [0x00 0x00]
>>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>>   Amp-Out vals:  [0x80 0x80]
>>   Pincap 0x0000373c: IN OUT HP Detect
>>     Vref caps: HIZ 50 GRD 80 100
>>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>>     Conn = 1/8, Color = Black
>>     DefAssociation = 0xf, Sequence = 0x0
>>     Misc = NO_PRESENCE
>>   Pin-ctls: 0x20: IN VREF_HIZ
>>   Unsolicited: tag=00, enabled=0
>>   Connection: 5
>>      0x0c 0x0d 0x0e 0x0f 0x26*
>> Node 0x1b [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>>   Amp-In vals:  [0x00 0x00]
>>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>>   Amp-Out vals:  [0x80 0x80]
>>   Pincap 0x0000373c: IN OUT HP Detect
>>     Vref caps: HIZ 50 GRD 80 100
>>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>>     Conn = 1/8, Color = Black
>>     DefAssociation = 0xf, Sequence = 0x0
>>     Misc = NO_PRESENCE
>>   Pin-ctls: 0x20: IN VREF_HIZ
>>   Unsolicited: tag=00, enabled=0
>>   Connection: 5
>>      0x0c 0x0d 0x0e 0x0f 0x26*
>> Node 0x1c [Pin Complex] wcaps 0x400081: Stereo
>>   Pincap 0x00000024: IN Detect
>>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>>     Conn = 1/8, Color = Black
>>     DefAssociation = 0xf, Sequence = 0x0
>>     Misc = NO_PRESENCE
>>   Pin-ctls: 0x20: IN
>>   Unsolicited: tag=00, enabled=0
>> Node 0x1d [Pin Complex] wcaps 0x400000: Mono
>>   Pincap 0x00000020: IN
>>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>>     Conn = 1/8, Color = Black
>>     DefAssociation = 0xf, Sequence = 0x0
>>     Misc = NO_PRESENCE
>>   Pin-ctls: 0x20: IN
>> Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital
>>   Pincap 0x00000010: OUT
>>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>>     Conn = 1/8, Color = Black
>>     DefAssociation = 0xf, Sequence = 0x0
>>     Misc = NO_PRESENCE
>>   Pin-ctls: 0x40: OUT
>>   Connection: 1
>>      0x06
>> Node 0x1f [Pin Complex] wcaps 0x400280: Mono Digital
>>   Pincap 0x00000020: IN
>>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>>     Conn = 1/8, Color = Black
>>     DefAssociation = 0xf, Sequence = 0x0
>>     Misc = NO_PRESENCE
>>   Pin-ctls: 0x20: IN
>>   Unsolicited: tag=00, enabled=0
>> Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
>>   Processing caps: benign=0, ncoeff=28
>> Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
>> Node 0x22 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>>   Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 
>> 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] 
>> [0x80 0x80]
>>   Connection: 11
>>      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
>> Node 0x23 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>>   Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 
>> 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] 
>> [0x80 0x80]
>>   Connection: 11
>>      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
>> Node 0x24 [Audio Selector] wcaps 0x300101: Stereo
>>   Connection: 12
>>      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b 0x12*
>> Node 0x25 [Audio Output] wcaps 0x11: Stereo
>>   Converter: stream=0, channel=0
>>   PCM:
>>     rates [0x5e0]: 44100 48000 88200 96000 192000
>>     bits [0xe]: 16 20 24
>>     formats [0x1]: PCM
>> Node 0x26 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>>   Amp-In vals:  [0x00 0x00] [0x80 0x80]
>>   Amp-Out caps: ofs=0x3e, nsteps=0x40, stepsize=0x03, mute=0
>>   Amp-Out vals:  [0x3e 0x3e]
>>   Connection: 2
>>      0x25 0x0b
>> --endcollapse--
>>
>>
>> !!ALSA Device nodes
>> !!-----------------
>>
>> crw-rw---T+ 1 root audio 116,  0 Jul  3 19:35 /dev/snd/controlC0
>> crw-rw---T+ 1 root audio 116,  4 Jul  3 19:35 /dev/snd/hwC0D0
>> crw-rw---T+ 1 root audio 116, 24 Jul  3 19:36 /dev/snd/pcmC0D0c
>> crw-rw---T+ 1 root audio 116, 16 Jul  3 19:36 /dev/snd/pcmC0D0p
>> crw-rw---T+ 1 root audio 116,  1 Jul  3 19:35 /dev/snd/seq
>> crw-rw---T+ 1 root audio 116, 33 Jul  3 19:35 /dev/snd/timer
>>
>> /dev/snd/by-path:
>> total 0
>> drwxr-xr-x 2 root root  60 Jul  3 19:35 .
>> drwxr-xr-x 3 root root 180 Jul  3 19:35 ..
>> lrwxrwxrwx 1 root root  12 Jul  3 19:35 pci-0000:00:1b.0 -> ../controlC0
>>
>>
>> !!ALSA configuration files
>> !!------------------------
>>
>> !!System wide config file (/etc/asound.conf)
>>
>> pcm.pulse {
>>     type pulse
>> }
>> ctl.pulse {
>>     type pulse
>> }
>> pcm.!default {
>>     type pulse
>> }
>> ctl.!default {
>>     type pulse
>> }
>>
>>
>>
>> !!Aplay/Arecord output
>> !!--------------------
>>
>> APLAY
>>
>> **** List of PLAYBACK Hardware Devices ****
>> card 0: MID [HDA Intel MID], device 0: ALC889 Analog [ALC889 Analog]
>>   Subdevices: 1/1
>>   Subdevice #0: subdevice #0
>>
>> ARECORD
>>
>> **** List of CAPTURE Hardware Devices ****
>> card 0: MID [HDA Intel MID], device 0: ALC889 Analog [ALC889 Analog]
>>   Subdevices: 1/1
>>   Subdevice #0: subdevice #0
>>
>> !!Amixer output
>> !!-------------
>>
>> !!-------Mixer controls for card 0 [MID]
>>
>> Card hw:0 'MID'/'HDA Intel MID at 0xb6420000 irq 45'
>>   Mixer name    : 'Realtek ALC889'
>>   Components    : 'HDA:10ec0889,104d4400,00100005'
>>   Controls      : 34
>>   Simple ctrls  : 18
>> Simple mixer control 'Master',0
>>   Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
>>   Playback channels: Mono
>>   Limits: Playback 0 - 64
>>   Mono: Playback 64 [100%] [0.00dB] [on]
>> Simple mixer control 'Headphone',0
>>   Capabilities: pvolume pswitch penum
>>   Playback channels: Front Left - Front Right
>>   Limits: Playback 0 - 64
>>   Mono:
>>   Front Left: Playback 62 [97%] [0.00dB] [on]
>>   Front Right: Playback 62 [97%] [0.00dB] [on]
>> Simple mixer control 'Speaker',0
>>   Capabilities: pvolume pswitch penum
>>   Playback channels: Front Left - Front Right
>>   Limits: Playback 0 - 64
>>   Mono:
>>   Front Left: Playback 64 [100%] [2.00dB] [on]
>>   Front Right: Playback 64 [100%] [2.00dB] [on]
>> Simple mixer control 'PCM',0
>>   Capabilities: pvolume penum
>>   Playback channels: Front Left - Front Right
>>   Limits: Playback 0 - 255
>>   Mono:
>>   Front Left: Playback 255 [100%] [0.00dB]
>>   Front Right: Playback 255 [100%] [0.00dB]
>> Simple mixer control 'Surround',0
>>   Capabilities: pvolume pswitch penum
>>   Playback channels: Front Left - Front Right
>>   Limits: Playback 0 - 64
>>   Mono:
>>   Front Left: Playback 62 [97%] [0.00dB] [on]
>>   Front Right: Playback 62 [97%] [0.00dB] [on]
>> Simple mixer control 'Center',0
>>   Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
>>   Playback channels: Mono
>>   Limits: Playback 0 - 64
>>   Mono: Playback 62 [97%] [0.00dB] [on]
>> Simple mixer control 'LFE',0
>>   Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
>>   Playback channels: Mono
>>   Limits: Playback 0 - 64
>>   Mono: Playback 62 [97%] [0.00dB] [on]
>> Simple mixer control 'Mic',0
>>   Capabilities: pvolume pswitch cswitch cswitch-joined 
>> cswitch-exclusive penum
>>   Capture exclusive group: 0
>>   Playback channels: Front Left - Front Right
>>   Capture channels: Mono
>>   Limits: Playback 0 - 31
>>   Mono: Capture [off]
>>   Front Left: Playback 15 [48%] [-12.00dB] [off]
>>   Front Right: Playback 15 [48%] [-12.00dB] [off]
>> Simple mixer control 'Mic 1',0
>>   Capabilities: cswitch cswitch-joined cswitch-exclusive penum
>>   Capture exclusive group: 0
>>   Capture channels: Mono
>>   Mono: Capture [off]
>> Simple mixer control 'Mic Boost',0
>>   Capabilities: volume penum
>>   Playback channels: Front Left - Front Right
>>   Capture channels: Front Left - Front Right
>>   Limits: 0 - 3
>>   Front Left: 0 [0%] [0.00dB]
>>   Front Right: 0 [0%] [0.00dB]
>> Simple mixer control 'Mic',1
>>   Capabilities: pvolume pswitch penum
>>   Playback channels: Front Left - Front Right
>>   Limits: Playback 0 - 31
>>   Mono:
>>   Front Left: Playback 0 [0%] [-34.50dB] [off]
>>   Front Right: Playback 0 [0%] [-34.50dB] [off]
>> Simple mixer control 'Mic Boost',1
>>   Capabilities: volume penum
>>   Playback channels: Front Left - Front Right
>>   Capture channels: Front Left - Front Right
>>   Limits: 0 - 3
>>   Front Left: 0 [0%] [0.00dB]
>>   Front Right: 0 [0%] [0.00dB]
>> Simple mixer control 'Beep',0
>>   Capabilities: pvolume pswitch penum
>>   Playback channels: Front Left - Front Right
>>   Limits: Playback 0 - 31
>>   Mono:
>>   Front Left: Playback 0 [0%] [-34.50dB] [off]
>>   Front Right: Playback 0 [0%] [-34.50dB] [off]
>> Simple mixer control 'Capture',0
>>   Capabilities: cvolume cswitch penum
>>   Capture channels: Front Left - Front Right
>>   Limits: Capture 0 - 46
>>   Front Left: Capture 40 [87%] [24.00dB] [on]
>>   Front Right: Capture 40 [87%] [24.00dB] [on]
>> Simple mixer control 'Auto-Mute Mode',0
>>   Capabilities: enum
>>   Items: 'Disabled' 'Enabled'
>>   Item0: 'Enabled'
>> Simple mixer control 'Channel Mode',0
>>   Capabilities: enum
>>   Items: '2ch' '4ch' '6ch'
>>   Item0: '2ch'
>> Simple mixer control 'Digital',0
>>   Capabilities: cvolume penum
>>   Capture channels: Front Left - Front Right
>>   Limits: Capture 0 - 120
>>   Front Left: Capture 0 [0%] [-30.00dB]
>>   Front Right: Capture 0 [0%] [-30.00dB]
>> Simple mixer control 'Internal Mic',0
>>   Capabilities: cswitch cswitch-joined cswitch-exclusive penum
>>   Capture exclusive group: 0
>>   Capture channels: Mono
>>   Mono: Capture [on]
>>
>>
>> !!Alsactl output
>> !!--------------
>>
>> --startcollapse--
>> state.MID {
>>     control.1 {
>>         iface MIXER
>>         name 'Channel Mode'
>>         value '2ch'
>>         comment {
>>             access 'read write'
>>             type ENUMERATED
>>             count 1
>>             item.0 '2ch'
>>             item.1 '4ch'
>>             item.2 '6ch'
>>         }
>>     }
>>     control.2 {
>>         iface MIXER
>>         name 'Headphone Playback Volume'
>>         value.0 62
>>         value.1 62
>>         comment {
>>             access 'read write'
>>             type INTEGER
>>             count 2
>>             range '0 - 64'
>>             dbmin -6200
>>             dbmax 200
>>             dbvalue.0 0
>>             dbvalue.1 0
>>         }
>>     }
>>     control.3 {
>>         iface MIXER
>>         name 'Headphone Playback Switch'
>>         value.0 true
>>         value.1 true
>>         comment {
>>             access 'read write'
>>             type BOOLEAN
>>             count 2
>>         }
>>     }
>>     control.4 {
>>         iface MIXER
>>         name 'Surround Playback Volume'
>>         value.0 62
>>         value.1 62
>>         comment {
>>             access 'read write'
>>             type INTEGER
>>             count 2
>>             range '0 - 64'
>>             dbmin -6200
>>             dbmax 200
>>             dbvalue.0 0
>>             dbvalue.1 0
>>         }
>>     }
>>     control.5 {
>>         iface MIXER
>>         name 'Surround Playback Switch'
>>         value.0 true
>>         value.1 true
>>         comment {
>>             access 'read write'
>>             type BOOLEAN
>>             count 2
>>         }
>>     }
>>     control.6 {
>>         iface MIXER
>>         name 'Center Playback Volume'
>>         value 62
>>         comment {
>>             access 'read write'
>>             type INTEGER
>>             count 1
>>             range '0 - 64'
>>             dbmin -6200
>>             dbmax 200
>>             dbvalue.0 0
>>         }
>>     }
>>     control.7 {
>>         iface MIXER
>>         name 'LFE Playback Volume'
>>         value 62
>>         comment {
>>             access 'read write'
>>             type INTEGER
>>             count 1
>>             range '0 - 64'
>>             dbmin -6200
>>             dbmax 200
>>             dbvalue.0 0
>>         }
>>     }
>>     control.8 {
>>         iface MIXER
>>         name 'Center Playback Switch'
>>         value true
>>         comment {
>>             access 'read write'
>>             type BOOLEAN
>>             count 1
>>         }
>>     }
>>     control.9 {
>>         iface MIXER
>>         name 'LFE Playback Switch'
>>         value true
>>         comment {
>>             access 'read write'
>>             type BOOLEAN
>>             count 1
>>         }
>>     }
>>     control.10 {
>>         iface MIXER
>>         name 'Speaker Playback Volume'
>>         value.0 64
>>         value.1 64
>>         comment {
>>             access 'read write'
>>             type INTEGER
>>             count 2
>>             range '0 - 64'
>>             dbmin -6200
>>             dbmax 200
>>             dbvalue.0 200
>>             dbvalue.1 200
>>         }
>>     }
>>     control.11 {
>>         iface MIXER
>>         name 'Speaker Playback Switch'
>>         value.0 true
>>         value.1 true
>>         comment {
>>             access 'read write'
>>             type BOOLEAN
>>             count 2
>>         }
>>     }
>>     control.12 {
>>         iface MIXER
>>         name 'Mic Playback Volume'
>>         value.0 15
>>         value.1 15
>>         comment {
>>             access 'read write'
>>             type INTEGER
>>             count 2
>>             range '0 - 31'
>>             dbmin -3450
>>             dbmax 1200
>>             dbvalue.0 -1200
>>             dbvalue.1 -1200
>>         }
>>     }
>>     control.13 {
>>         iface MIXER
>>         name 'Mic Playback Switch'
>>         value.0 false
>>         value.1 false
>>         comment {
>>             access 'read write'
>>             type BOOLEAN
>>             count 2
>>         }
>>     }
>>     control.14 {
>>         iface MIXER
>>         name 'Mic Playback Volume'
>>         index 1
>>         value.0 0
>>         value.1 0
>>         comment {
>>             access 'read write'
>>             type INTEGER
>>             count 2
>>             range '0 - 31'
>>             dbmin -3450
>>             dbmax 1200
>>             dbvalue.0 -3450
>>             dbvalue.1 -3450
>>         }
>>     }
>>     control.15 {
>>         iface MIXER
>>         name 'Mic Playback Switch'
>>         index 1
>>         value.0 false
>>         value.1 false
>>         comment {
>>             access 'read write'
>>             type BOOLEAN
>>             count 2
>>         }
>>     }
>>     control.16 {
>>         iface MIXER
>>         name 'Auto-Mute Mode'
>>         value Enabled
>>         comment {
>>             access 'read write'
>>             type ENUMERATED
>>             count 1
>>             item.0 Disabled
>>             item.1 Enabled
>>         }
>>     }
>>     control.17 {
>>         iface MIXER
>>         name 'Capture Source'
>>         value 'Internal Mic'
>>         comment {
>>             access 'read write'
>>             type ENUMERATED
>>             count 1
>>             item.0 Mic
>>             item.1 'Mic 1'
>>             item.2 'Internal Mic'
>>         }
>>     }
>>     control.18 {
>>         iface MIXER
>>         name 'Capture Volume'
>>         value.0 40
>>         value.1 40
>>         comment {
>>             access 'read write'
>>             type INTEGER
>>             count 2
>>             range '0 - 46'
>>             dbmin -1600
>>             dbmax 3000
>>             dbvalue.0 2400
>>             dbvalue.1 2400
>>         }
>>     }
>>     control.19 {
>>         iface MIXER
>>         name 'Capture Switch'
>>         value.0 true
>>         value.1 true
>>         comment {
>>             access 'read write'
>>             type BOOLEAN
>>             count 2
>>         }
>>     }
>>     control.20 {
>>         iface MIXER
>>         name 'Mic Boost Volume'
>>         value.0 0
>>         value.1 0
>>         comment {
>>             access 'read write'
>>             type INTEGER
>>             count 2
>>             range '0 - 3'
>>             dbmin 0
>>             dbmax 3000
>>             dbvalue.0 0
>>             dbvalue.1 0
>>         }
>>     }
>>     control.21 {
>>         iface MIXER
>>         name 'Mic Boost Volume'
>>         index 1
>>         value.0 0
>>         value.1 0
>>         comment {
>>             access 'read write'
>>             type INTEGER
>>             count 2
>>             range '0 - 3'
>>             dbmin 0
>>             dbmax 3000
>>             dbvalue.0 0
>>             dbvalue.1 0
>>         }
>>     }
>>     control.22 {
>>         iface MIXER
>>         name 'Master Playback Volume'
>>         value 64
>>         comment {
>>             access 'read write'
>>             type INTEGER
>>             count 1
>>             range '0 - 64'
>>             dbmin -6400
>>             dbmax 0
>>             dbvalue.0 0
>>         }
>>     }
>>     control.23 {
>>         iface MIXER
>>         name 'Master Playback Switch'
>>         value true
>>         comment {
>>             access 'read write'
>>             type BOOLEAN
>>             count 1
>>         }
>>     }
>>     control.24 {
>>         iface CARD
>>         name 'Mic Jack'
>>         value false
>>         comment {
>>             access read
>>             type BOOLEAN
>>             count 1
>>         }
>>     }
>>     control.25 {
>>         iface CARD
>>         name 'Mic Jack'
>>         index 1
>>         value false
>>         comment {
>>             access read
>>             type BOOLEAN
>>             count 1
>>         }
>>     }
>>     control.26 {
>>         iface CARD
>>         name 'Internal Mic Phantom Jack'
>>         value true
>>         comment {
>>             access read
>>             type BOOLEAN
>>             count 1
>>         }
>>     }
>>     control.27 {
>>         iface CARD
>>         name 'Headphone Jack'
>>         value false
>>         comment {
>>             access read
>>             type BOOLEAN
>>             count 1
>>         }
>>     }
>>     control.28 {
>>         iface CARD
>>         name 'Speaker Phantom Jack'
>>         value true
>>         comment {
>>             access read
>>             type BOOLEAN
>>             count 1
>>         }
>>     }
>>     control.29 {
>>         iface MIXER
>>         name 'Beep Playback Volume'
>>         value.0 0
>>         value.1 0
>>         comment {
>>             access 'read write'
>>             type INTEGER
>>             count 2
>>             range '0 - 31'
>>             dbmin -3450
>>             dbmax 1200
>>             dbvalue.0 -3450
>>             dbvalue.1 -3450
>>         }
>>     }
>>     control.30 {
>>         iface MIXER
>>         name 'Beep Playback Switch'
>>         value.0 false
>>         value.1 false
>>         comment {
>>             access 'read write'
>>             type BOOLEAN
>>             count 2
>>         }
>>     }
>>     control.31 {
>>         iface PCM
>>         name 'Playback Channel Map'
>>         value.0 0
>>         value.1 0
>>         comment {
>>             access read
>>             type INTEGER
>>             count 2
>>             range '0 - 36'
>>         }
>>     }
>>     control.32 {
>>         iface PCM
>>         name 'Capture Channel Map'
>>         value.0 0
>>         value.1 0
>>         comment {
>>             access read
>>             type INTEGER
>>             count 2
>>             range '0 - 36'
>>         }
>>     }
>>     control.33 {
>>         iface MIXER
>>         name 'PCM Playback Volume'
>>         value.0 255
>>         value.1 255
>>         comment {
>>             access 'read write user'
>>             type INTEGER
>>             count 2
>>             range '0 - 255'
>>             tlv '0000000100000008ffffec1400000014'
>>             dbmin -5100
>>             dbmax 0
>>             dbvalue.0 0
>>             dbvalue.1 0
>>         }
>>     }
>>     control.34 {
>>         iface MIXER
>>         name 'Digital Capture Volume'
>>         value.0 0
>>         value.1 0
>>         comment {
>>             access 'read write user'
>>             type INTEGER
>>             count 2
>>             range '0 - 120'
>>             tlv '0000000100000008fffff44800000032'
>>             dbmin -3000
>>             dbmax 3000
>>             dbvalue.0 -3000
>>             dbvalue.1 -3000
>>         }
>>     }
>> }
>> --endcollapse--
>>
>>
>> !!All Loaded Modules
>> !!------------------
>>
>> Module
>> parport_pc
>> ppdev
>> lp
>> parport
>> binfmt_misc
>> fuse
>> ext2
>> mbcache
>> dm_crypt
>> loop
>> snd_hda_codec_realtek
>> videobuf2_vmalloc
>> videobuf2_memops
>> videobuf2_core
>> videodev
>> media
>> joydev
>> snd_hda_intel
>> snd_hda_codec
>> snd_hwdep
>> snd_pcm_oss
>> snd_mixer_oss
>> snd_pcm
>> snd_page_alloc
>> snd_seq_dummy
>> snd_seq_oss
>> snd_seq_midi
>> snd_seq_midi_event
>> snd_rawmidi
>> snd_seq
>> arc4
>> coretemp
>> iwldvm
>> kvm_intel
>> mac80211
>> snd_seq_device
>> kvm
>> snd_timer
>> crc32c_intel
>> ghash_clmulni_intel
>> snd
>> iTCO_wdt
>> iTCO_vendor_support
>> aesni_intel
>> iwlwifi
>> i915
>> aes_x86_64
>> ablk_helper
>> mxm_wmi
>> cryptd
>> xts
>> cfg80211
>> sg
>> lrw
>> gf128mul
>> sr_mod
>> cdrom
>> psmouse
>> drm_kms_helper
>> serio_raw
>> sony_laptop
>> evdev
>> drm
>> rfkill
>> pcspkr
>> video
>> wmi
>> i2c_i801
>> i2c_algo_bit
>> battery
>> button
>> i2c_core
>> ehci_pci
>> ehci_hcd
>> e1000e
>> intel_ips
>> soundcore
>> acpi_cpufreq
>> mperf
>> ac
>> lpc_ich
>> usbcore
>> mfd_core
>> mei
>> sdhci_pci
>> sdhci
>> ptp
>> mmc_core
>> pps_core
>> usb_common
>> processor
>> btrfs
>> crc32c
>> libcrc32c
>> xor
>> zlib_deflate
>> raid6_pq
>> dm_mod
>> raid0
>> md_mod
>> sd_mod
>> crc_t10dif
>> ahci
>> libahci
>> microcode
>> thermal
>> thermal_sys
>> libata
>> scsi_mod
>>
>>
>> !!Sysfs Files
>> !!-----------
>>
>> /sys/class/sound/hwC0D0/init_pin_configs:
>> 0x11 0x411111f0
>> 0x12 0x90a60120
>> 0x14 0x90170110
>> 0x15 0x0421101f
>> 0x16 0x411111f0
>> 0x17 0x411111f0
>> 0x18 0x04a1102e
>> 0x19 0x04a11030
>> 0x1a 0x411111f0
>> 0x1b 0x411111f0
>> 0x1c 0x411111f0
>> 0x1d 0x411111f0
>> 0x1e 0x411111f0
>> 0x1f 0x411111f0
>>
>> /sys/class/sound/hwC0D0/driver_pin_configs:
>>
>> /sys/class/sound/hwC0D0/user_pin_configs:
>>
>> /sys/class/sound/hwC0D0/init_verbs:
>>
>> /sys/class/sound/hwC0D0/hints:
>>
>>
>> !!ALSA/HDA dmesg
>> !!--------------
>>
>> [    5.121872] pipe_off wait timed out
>> [    5.121921] Modules linked in: uvcvideo videobuf2_vmalloc 
>> videobuf2_memops videobuf2_core videodev media joydev 
>> snd_hda_intel(O+) snd_hda_codec(O) snd_hwdep(O) snd_pcm_oss(O) 
>> snd_mixer_oss(O) snd_pcm(O) snd_page_alloc(O) snd_seq_dummy(O) 
>> snd_seq_oss(O) snd_seq_midi(O) snd_seq_midi_event(O) snd_rawmidi(O) 
>> snd_seq(O) arc4 coretemp iwldvm kvm_intel mac80211 snd_seq_device(O) 
>> kvm snd_timer(O) crc32c_intel ghash_clmulni_intel snd(O) iTCO_wdt 
>> iTCO_vendor_support aesni_intel iwlwifi i915(+) aes_x86_64 
>> ablk_helper mxm_wmi cryptd xts cfg80211 sg lrw gf128mul sr_mod cdrom 
>> psmouse drm_kms_helper serio_raw sony_laptop evdev drm rfkill pcspkr 
>> video wmi i2c_i801 i2c_algo_bit battery button i2c_core ehci_pci 
>> ehci_hcd e1000e intel_ips soundcore acpi_cpufreq mperf ac lpc_ich 
>> usbcore mfd_core mei sdhci_pci sdhci ptp mmc_core pps_core usb_common 
>> processor btrfs crc32c libcrc32c xor zlib_deflate raid6_pq dm_mod 
>> raid0 md_mod sd_mod crc_t10dif ahci libahci microcode thermal 
>> thermal_sys libata scsi_mod
>> [    5.121941] Pid: 635, comm: modprobe Tainted: G           O 
>> 3.9-0.bpo.1-amd64 #1 Debian 3.9.6-1~bpo70+1
>> -- 
>> [    5.835404] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 
>> on minor 0
>> [    5.835752] snd_hda_intel 0000:00:1b.0: irq 45 for MSI/MSI-X
>> [    5.864320] hda_codec: ALC889: SKU not ready 0x411111f0
>> [    5.864675] ALSA hda_auto_parser.c:393 autoconfig: line_outs=1 
>> (0x14/0x0/0x0/0x0/0x0) type:speaker
>> [    5.864681] ALSA hda_auto_parser.c:397    speaker_outs=0 
>> (0x0/0x0/0x0/0x0/0x0)
>> [    5.864686] ALSA hda_auto_parser.c:401    hp_outs=1 
>> (0x15/0x0/0x0/0x0/0x0)
>> [    5.864689] ALSA hda_auto_parser.c:402    mono: mono_out=0x0
>> [    5.864693] ALSA hda_auto_parser.c:406    inputs:
>> [    5.864697] ALSA hda_auto_parser.c:410      Mic=0x18
>> [    5.864701] ALSA hda_auto_parser.c:410      Mic=0x19
>> [    5.864704] ALSA hda_auto_parser.c:410      Internal Mic=0x12
>> [    5.864709] ALSA patch_realtek.c:486 realtek: No valid SSID, 
>> checking pincfg 0x411111f0 for NID 0x1d
>> [    5.864713] ALSA patch_realtek.c:569 realtek: Enable default setup 
>> for auto mode as fallback
>> [    5.868644] input: HDA Digital PCBeep as 
>> /devices/pci0000:00/0000:00:1b.0/input/input9
>> [    5.874177] input: HDA Intel MID Headphone as 
>> /devices/pci0000:00/0000:00:1b.0/sound/card0/input10
>> [    5.874232] input: HDA Intel MID Mic as 
>> /devices/pci0000:00/0000:00:1b.0/sound/card0/input11
>> [    5.874284] input: HDA Intel MID Mic as 
>> /devices/pci0000:00/0000:00:1b.0/sound/card0/input12
>> [    6.760494] btrfs: use ssd allocation scheme
>> -- 
>> [   26.166424] pipe_off wait timed out
>> [   26.166426] Modules linked in: parport_pc ppdev lp parport 
>> binfmt_misc fuse ext2 mbcache dm_crypt loop snd_hda_codec_realtek(O) 
>> uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_core videodev 
>> media joydev snd_hda_intel(O) snd_hda_codec(O) snd_hwdep(O) 
>> snd_pcm_oss(O) snd_mixer_oss(O) snd_pcm(O) snd_page_alloc(O) 
>> snd_seq_dummy(O) snd_seq_oss(O) snd_seq_midi(O) snd_seq_midi_event(O) 
>> snd_rawmidi(O) snd_seq(O) arc4 coretemp iwldvm kvm_intel mac80211 
>> snd_seq_device(O) kvm snd_timer(O) crc32c_intel ghash_clmulni_intel 
>> snd(O) iTCO_wdt iTCO_vendor_support aesni_intel iwlwifi i915 
>> aes_x86_64 ablk_helper mxm_wmi cryptd xts cfg80211 sg lrw gf128mul 
>> sr_mod cdrom psmouse drm_kms_helper serio_raw sony_laptop evdev drm 
>> rfkill pcspkr video wmi i2c_i801 i2c_algo_bit battery button i2c_core 
>> ehci_pci ehci_hcd e1000e intel_ips soundcore acpi_cpufreq mperf ac 
>> lpc_ich usbcore mfd_core mei sdhci_pci sdhci ptp mmc_core pps_core 
>> usb_common processor btrfs crc32c libcrc32c xor zlib_deflate raid6_pq 
>> dm_mod raid0 md_mod sd_mod crc_t10dif ahci libahci microcode thermal 
>> thermal_sys libata scsi_mod
>> [   26.166527] Pid: 4157, comm: Xorg Tainted: G        W  O 
>> 3.9-0.bpo.1-amd64 #1 Debian 3.9.6-1~bpo70+1
>>
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
