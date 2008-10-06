From: "Klaas De Craemer" <klaasdc@gmail.com>
Subject: Re: [PATCH] Sigmatel stac92hd71b7 low HP volume
Date: Mon, 6 Oct 2008 19:10:14 +0200
Message-ID: <f59e60020810061010m39b83fb4qb05f8f008d46adf3@mail.gmail.com>
References: <200810052210.46360.klaasdc@gmail.com>
	<s5h4p3qgiri.wl%tiwai@suse.de> <200810061248.43643.klaasdc@gmail.com>
	<s5hskraf0ti.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 0469B244BA
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Oct 2008 19:10:27 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so2017891fgg.44
	for <alsa-devel@alsa-project.org>; Mon, 06 Oct 2008 10:10:14 -0700 (PDT)
In-Reply-To: <s5hskraf0ti.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 6, 2008 at 12:57 PM, Takashi Iwai <tiwai@suse.de> wrote:
> [please don't drop Cc to alsa-devel ML]
>
> At Mon, 6 Oct 2008 12:48:43 +0200,
> Klaas De Craemer wrote:
>>
>> Hello,
>>
>> I'm sure that the audioquality will degrade somewhat because of the additional amplification,
>> but before, the HP-out was not usable at all. I had to use an external ampli just to use my
>> headphones, even after turning all volume sliders to 100%. Then again, when removing the HP,
>> the volume though the internal speakers was way too loud...
>>
>> I'm not sure what you mean with the output pin and headphone control, but I have uploaded the
>> output of the codegraph tool before and after my modification here:
>> http://users.vtk.be/~s0159120/codec_original.svg
>> http://users.vtk.be/~s0159120/codec_final.svg
>>
>> Below is the output of alsa-info with the patched module
>> Klaas
>
> Thanks.
>
> So, if I understand correctly, when the pin 0x0a is connected directly
> from DAC0 0x10, the output level is too low even if you set the all
> volumes maximal.

That is correct.


> In the alsa-info.sh output, I see the following:
>> Node 0x10 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
>>   Amp-Out caps: N/A
>>   Amp-Out vals:  [0x5e 0x5e]
>
> which means that you decrease the output level intentionally.
> Is the HP output still too low even if you set to the higher value?


No, after the patch I don't need 100% anymore. The HP output is fine
now, and I can tune it up and down a bit. Before using the mixer-amp,
going from 90 to 100 resulted in going from no sound to little sound.
Now the range is more useful.

>
> Takashi
>
>
>>
>> -----
>> upload=true&script=true&cardinfo=
>> !!################################
>> !!ALSA Information Script v 0.4.51
>> !!################################
>>
>> !!Script ran on: Mon Oct  6 12:42:48 CEST 2008
>>
>>
>> !!Linux Distribution
>> !!------------------
>>
>> Debian GNU/Linux lenny/sid \n \l
>>
>>
>> !!Kernel Information
>> !!------------------
>>
>> Kernel release:    2.6.26-5.slh.6-sidux-686
>> Operating System:  GNU/Linux
>> Architecture:      i686
>> Processor:         unknown
>> SMP Enabled:       Yes
>>
>>
>> !!ALSA Version
>> !!------------
>>
>> Driver version:     1.0.16
>> Library version:
>> Utilities version:  1.0.16
>>
>>
>> !!Loaded ALSA modules
>> !!-------------------
>>
>> snd_hda_intel
>>
>>
>> !!Soundcards recognised by ALSA
>> !!-----------------------------
>>
>>  0 [Intel          ]: HDA-Intel - HDA Intel
>>                       HDA Intel at 0xf6fdc000 irq 21
>>
>>
>> !!PCI Soundcards installed in the system
>> !!--------------------------------------
>>
>> 00:1b.0 Audio device: Intel Corporation 82801I (ICH9 Family) HD Audio Controller (rev 03)
>>
>>
>> !!Advanced information - PCI Vendor/Device/Susbsystem ID's
>> !!--------------------------------------------------------
>>
>> 00:1b.0 0403: 8086:293e (rev 03)
>>       Subsystem: 1028:024f
>>
>>
>> !!Modprobe options (Sound related)
>> !!--------------------------------
>>
>> snd-atiixp-modem: index=-2
>> snd-intel8x0m: index=-2
>> snd-via82xx-modem: index=-2
>> snd-pcsp: index=-2
>>
>>
>> !!Loaded sound module options
>> !!--------------------------
>>
>> !!Module: snd_hda_intel
>> enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
>> enable_msi : 0
>> id :
>> <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
>> index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
>> model :
>> <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
>> position_fix : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
>> power_save : 0
>> power_save_controller : Y
>> probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
>> single_cmd : N
>>
>>
>> !!HDA-Intel Codec information
>> !!---------------------------
>> --startcollapse--
>>
>> Codec: IDT 92HD71B7X
>> Address: 0
>> Vendor Id: 0x111d76b2
>> Subsystem Id: 0x1028024f
>> Revision Id: 0x100302
>> No Modem Function Group found
>> Default PCM:
>>     rates [0x7e0]: 44100 48000 88200 96000 176400 192000
>>     bits [0xe]: 16 20 24
>>     formats [0x1]: PCM
>> Default Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>> Default Amp-Out caps: ofs=0x7f, nsteps=0x7f, stepsize=0x02, mute=1
>> GPIO: io=8, o=0, i=0, unsolicited=1, wake=1
>>   IO[0]: enable=1, dir=1, wake=0, sticky=0, data=1
>>   IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0
>>   IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0
>>   IO[3]: enable=0, dir=0, wake=0, sticky=0, data=0
>>   IO[4]: enable=0, dir=0, wake=0, sticky=0, data=0
>>   IO[5]: enable=0, dir=0, wake=0, sticky=0, data=0
>>   IO[6]: enable=0, dir=0, wake=0, sticky=0, data=0
>>   IO[7]: enable=0, dir=0, wake=0, sticky=0, data=0
>> Node 0x0a [Pin Complex] wcaps 0x400181: Stereo
>>   Pincap 0x081c: OUT HP Detect
>>   Pin Default 0x0421101f: [Jack] HP Out at Ext Right
>>     Conn = 1/8, Color = Black
>>     DefAssociation = 0x1, Sequence = 0xf
>>   Pin-ctls: 0xc0: OUT HP
>>   Unsolicited: tag=30, enabled=1
>>   Connection: 3
>>      0x10 0x11 0x17*
>> Node 0x0b [Pin Complex] wcaps 0x400081: Stereo
>>   Pincap 0x081724: IN Detect
>>     Vref caps: HIZ 50 GRD 80
>>   Pin Default 0x04a11221: [Jack] Mic at Ext Right
>>     Conn = 1/8, Color = Black
>>     DefAssociation = 0x2, Sequence = 0x1
>>   Pin-ctls: 0x24: IN VREF_80
>>   Unsolicited: tag=00, enabled=0
>> Node 0x0c [Pin Complex] wcaps 0x400081: Stereo
>>   Pincap 0x081724: IN Detect
>>     Vref caps: HIZ 50 GRD 80
>>   Pin Default 0x40f000f0: [N/A] Other at Ext N/A
>>     Conn = Unknown, Color = Unknown
>>     DefAssociation = 0xf, Sequence = 0x0
>>   Pin-ctls: 0x00: VREF_HIZ
>>   Unsolicited: tag=00, enabled=0
>> Node 0x0d [Pin Complex] wcaps 0x400181: Stereo
>>   Pincap 0x0814: OUT Detect
>>   Pin Default 0x90170110: [Fixed] Speaker at Int N/A
>>     Conn = Analog, Color = Unknown
>>     DefAssociation = 0x1, Sequence = 0x0
>>     Misc = NO_PRESENCE
>>   Pin-ctls: 0x00:
>>   Unsolicited: tag=00, enabled=0
>>   Connection: 3
>>      0x10* 0x11 0x17
>> Node 0x0e [Pin Complex] wcaps 0x400081: Stereo
>>   Pincap 0x081724: IN Detect
>>     Vref caps: HIZ 50 GRD 80
>>   Pin Default 0x23a1902e: [Jack] Mic at Sep Left
>>     Conn = 1/8, Color = Pink
>>     DefAssociation = 0x2, Sequence = 0xe
>>   Pin-ctls: 0x24: IN VREF_80
>>   Unsolicited: tag=00, enabled=0
>> Node 0x0f [Pin Complex] wcaps 0x400181: Stereo
>>   Pincap 0x0814: OUT Detect
>>   Pin Default 0x23014250: [Jack] Line Out at Sep Left
>>     Conn = 1/8, Color = Green
>>     DefAssociation = 0x5, Sequence = 0x0
>>   Pin-ctls: 0x00:
>>   Unsolicited: tag=00, enabled=0
>>   Connection: 3
>>      0x10* 0x11 0x17
>> Node 0x10 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
>>   Amp-Out caps: N/A
>>   Amp-Out vals:  [0x5e 0x5e]
>>   Converter: stream=5, channel=0
>>   Power: setting=D0, actual=D0
>>   Delay: 13 samples
>> Node 0x11 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
>>   Amp-Out caps: N/A
>>   Amp-Out vals:  [0x3d 0x3d]
>>   Converter: stream=5, channel=0
>>   Power: setting=D0, actual=D0
>>   Delay: 13 samples
>> Node 0x12 [Audio Input] wcaps 0x1d0541: Stereo
>>   Converter: stream=0, channel=0
>>   SDI-Select: 0
>>   Power: setting=D0, actual=D0
>>   Delay: 13 samples
>>   Connection: 1
>>      0x1c
>>   Processing caps: benign=0, ncoeff=0
>> Node 0x13 [Audio Input] wcaps 0x1d0541: Stereo
>>   Converter: stream=0, channel=0
>>   SDI-Select: 0
>>   Power: setting=D0, actual=D0
>>   Delay: 13 samples
>>   Connection: 1
>>      0x1d
>>   Processing caps: benign=0, ncoeff=0
>> Node 0x14 [Pin Complex] wcaps 0x400100: Mono
>>   Pincap 0x0810: OUT
>>   Pin Default 0x40f000f0: [N/A] Other at Ext N/A
>>     Conn = Unknown, Color = Unknown
>>     DefAssociation = 0xf, Sequence = 0x0
>>   Pin-ctls: 0x00:
>>   Connection: 1
>>      0x16
>> Node 0x15 [Audio Selector] wcaps 0x300101: Stereo
>>   Connection: 3
>>      0x10* 0x11 0x17
>> Node 0x16 [Audio Mixer] wcaps 0x200100: Mono
>>   Connection: 1
>>      0x15
>> Node 0x17 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>>   Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
>>   Amp-In vals:  [0x1f 0x1f] [0x1f 0x1f] [0x97 0x97] [0x97 0x97] [0x97 0x97]
>>   Connection: 5
>>      0x10 0x11 0x27 0x1a 0x1b
>> Node 0x18 [Pin Complex] wcaps 0x40000d: Stereo Amp-Out
>>   Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>>   Amp-Out vals:  [0x00 0x00]
>>   Pincap 0x0820: IN
>>   Pin Default 0x90a000f0: [Fixed] Mic at Int N/A
>>     Conn = Unknown, Color = Unknown
>>     DefAssociation = 0xf, Sequence = 0x0
>>   Pin-ctls: 0x20: IN
>> Node 0x19 [Pin Complex] wcaps 0x40000d: Stereo Amp-Out
>>   Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>>   Amp-Out vals:  [0x00 0x00]
>>   Pincap 0x0820: IN
>>   Pin Default 0x40f000f0: [N/A] Other at Ext N/A
>>     Conn = Unknown, Color = Unknown
>>     DefAssociation = 0xf, Sequence = 0x0
>>   Pin-ctls: 0x20: IN
>> Node 0x1a [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
>>   Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>>   Amp-Out vals:  [0x01 0x01]
>>   Connection: 3
>>      0x0b* 0x0c 0x0e
>> Node 0x1b [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
>>   Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>>   Amp-Out vals:  [0x00 0x00]
>>   Connection: 3
>>      0x0b* 0x0c 0x0e
>> Node 0x1c [Audio Selector] wcaps 0x30090d: Stereo Amp-Out R/L
>>   Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=1
>>   Amp-Out vals:  [0x00 0x00]
>>   Connection: 4
>>      0x1a* 0x17 0x18 0x19
>> Node 0x1d [Audio Selector] wcaps 0x30090d: Stereo Amp-Out R/L
>>   Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=1
>>   Amp-Out vals:  [0x80 0x80]
>>   Connection: 4
>>      0x1b* 0x17 0x18 0x19
>> Node 0x1e [Pin Complex] wcaps 0x400301: Stereo Digital
>>   Pincap 0x0810: OUT
>>   Pin Default 0x4f0000f0: [N/A] Line Out at Ext UNKNOWN
>>     Conn = Unknown, Color = Unknown
>>     DefAssociation = 0xf, Sequence = 0x0
>>   Pin-ctls: 0x00:
>>   Connection: 1
>>      0x24
>> Node 0x1f [Pin Complex] wcaps 0x400701: Stereo Digital
>>   Pincap 0x0810010: OUT EAPD
>>   EAPD 0x0:
>>   Pin Default 0x40f000f6: [N/A] Other at Ext N/A
>>     Conn = Unknown, Color = Unknown
>>     DefAssociation = 0xf, Sequence = 0x6
>>   Pin-ctls: 0x00:
>>   Power: setting=D0, actual=D0
>>   Connection: 2
>>      0x24* 0x25
>> Node 0x20 [Pin Complex] wcaps 0x400301: Stereo Digital
>>   Pincap 0x0810: OUT
>>   Pin Default 0x40f000f7: [N/A] Other at Ext N/A
>>     Conn = Unknown, Color = Unknown
>>     DefAssociation = 0xf, Sequence = 0x7
>>   Pin-ctls: 0x00:
>>   Connection: 1
>>      0x25
>> Node 0x21 [Audio Output] wcaps 0x40211: Stereo Digital
>>   Converter: stream=0, channel=0
>>   Digital:
>>   Digital category: 0x0
>>   PCM:
>>     rates [0x7e0]: 44100 48000 88200 96000 176400 192000
>>     bits [0xe]: 16 20 24
>>     formats [0x5]: PCM AC3
>>   Delay: 4 samples
>> Node 0x22 [Audio Output] wcaps 0x40211: Stereo Digital
>>   Converter: stream=0, channel=0
>>   Digital:
>>   Digital category: 0x0
>>   PCM:
>>     rates [0x7e0]: 44100 48000 88200 96000 176400 192000
>>     bits [0xe]: 16 20 24
>>     formats [0x5]: PCM AC3
>>   Delay: 4 samples
>> Node 0x23 [Vendor Defined Widget] wcaps 0xf00000: Mono
>> Node 0x24 [Audio Selector] wcaps 0x300101: Stereo
>>   Connection: 3
>>      0x21* 0x1c 0x1d
>> Node 0x25 [Audio Selector] wcaps 0x300101: Stereo
>>   Connection: 3
>>      0x22* 0x1c 0x1d
>> Node 0x26 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
>>   Amp-Out caps: ofs=0x03, nsteps=0x03, stepsize=0x17, mute=1
>>   Amp-Out vals:  [0x00]
>> Node 0x27 [Pin Complex] wcaps 0x400000: Mono
>>   Pincap 0x0820: IN
>>   Pin Default 0x40f000f0: [N/A] Other at Ext N/A
>>     Conn = Unknown, Color = Unknown
>>     DefAssociation = 0xf, Sequence = 0x0
>>   Pin-ctls: 0x00:
>> Node 0x28 [Volume Knob Widget] wcaps 0x600000: Mono
>>   Volume-Knob: delta=1, steps=127, direct=1, val=127
>>   Connection: 2
>>      0x10* 0x11
>> --endcollapse--
>>
>>
>> !!ALSA Device nodes
>> !!-----------------
>>
>> crw-rw---- 1 root audio 116, 7 okt  6 12:40 /dev/snd/controlC0
>> crw-rw---- 1 root audio 116, 6 okt  6 12:40 /dev/snd/hwC0D0
>> crw-rw---- 1 root audio 116, 5 okt  6 12:40 /dev/snd/pcmC0D0c
>> crw-rw---- 1 root audio 116, 4 okt  6 12:41 /dev/snd/pcmC0D0p
>> crw-rw---- 1 root audio 116, 3 okt  6 11:41 /dev/snd/seq
>> crw-rw---- 1 root audio 116, 2 okt  6 11:41 /dev/snd/timer
>>
>>
>> !!Aplay/Arecord output
>> !!------------
>>
>> APLAY
>>
>> **** List of PLAYBACK Hardware Devices ****
>> card 0: Intel [HDA Intel], device 0: STAC92xx Analog [STAC92xx Analog]
>>   Subdevices: 0/1
>>   Subdevice #0: subdevice #0
>>
>> ARECORD
>>
>> **** List of CAPTURE Hardware Devices ****
>> card 0: Intel [HDA Intel], device 0: STAC92xx Analog [STAC92xx Analog]
>>   Subdevices: 2/2
>>   Subdevice #0: subdevice #0
>>   Subdevice #1: subdevice #1
>>
>> !!Amixer output
>> !!-------------
>>
>> !!-------Mixer controls for card 0 [Intel]
>>
>> Card hw:0 'Intel'/'HDA Intel at 0xf6fdc000 irq 21'
>>   Mixer name  : 'IDT 92HD71B7X'
>>   Components  : 'HDA:111d76b2'
>>   Controls      : 19
>>   Simple ctrls  : 14
>> Simple mixer control 'Master',0
>>   Capabilities: pvolume pvolume-joined pswitch pswitch-joined
>>   Playback channels: Mono
>>   Limits: Playback 0 - 127
>>   Mono: Playback 94 [74%] [-24.75dB] [on]
>> Simple mixer control 'Headphone',0
>>   Capabilities: pvolume pswitch
>>   Playback channels: Front Left - Front Right
>>   Limits: Playback 0 - 127
>>   Mono:
>>   Front Left: Playback 127 [100%] [0.00dB] [on]
>>   Front Right: Playback 127 [100%] [0.00dB] [on]
>> Simple mixer control 'PCM',0
>>   Capabilities: pvolume
>>   Playback channels: Front Left - Front Right
>>   Limits: Playback 0 - 255
>>   Mono:
>>   Front Left: Playback 255 [100%] [0.00dB]
>>   Front Right: Playback 255 [100%] [0.00dB]
>> Simple mixer control 'Front',0
>>   Capabilities: pvolume pswitch
>>   Playback channels: Front Left - Front Right
>>   Limits: Playback 0 - 127
>>   Mono:
>>   Front Left: Playback 127 [100%] [0.00dB] [on]
>>   Front Right: Playback 127 [100%] [0.00dB] [on]
>> Simple mixer control 'Capture',0
>>   Capabilities: cvolume cswitch
>>   Capture channels: Front Left - Front Right
>>   Limits: Capture 0 - 15
>>   Front Left: Capture 0 [0%] [0.00dB] [on]
>>   Front Right: Capture 0 [0%] [0.00dB] [on]
>> Simple mixer control 'Capture Mux',0
>>   Capabilities: volume
>>   Playback channels: Front Left - Front Right
>>   Capture channels: Front Left - Front Right
>>   Limits: 0 - 3
>>   Front Left: 1 [33%] [10.00dB]
>>   Front Right: 1 [33%] [10.00dB]
>> Simple mixer control 'Capture Mux',1
>>   Capabilities: volume
>>   Playback channels: Front Left - Front Right
>>   Capture channels: Front Left - Front Right
>>   Limits: 0 - 3
>>   Front Left: 0 [0%] [0.00dB]
>>   Front Right: 0 [0%] [0.00dB]
>> Simple mixer control 'Capture',1
>>   Capabilities: cvolume cswitch
>>   Capture channels: Front Left - Front Right
>>   Limits: Capture 0 - 15
>>   Front Left: Capture 0 [0%] [0.00dB] [off]
>>   Front Right: Capture 0 [0%] [0.00dB] [off]
>> Simple mixer control 'Analog Loopback',0
>>   Capabilities: pswitch pswitch-joined
>>   Playback channels: Mono
>>   Mono: Playback [off]
>> Simple mixer control 'Analog Loopback',1
>>   Capabilities: pswitch pswitch-joined
>>   Playback channels: Mono
>>   Mono: Playback [off]
>> Simple mixer control 'Digital Input Source',0
>>   Capabilities: enum
>>   Items: 'Analog Inputs' 'Digital Mic 1'
>>   Item0: 'Analog Inputs'
>> Simple mixer control 'Digital Mic 1',0
>>   Capabilities: cvolume
>>   Capture channels: Front Left - Front Right
>>   Limits: Capture 0 - 3
>>   Front Left: Capture 0 [0%] [0.00dB]
>>   Front Right: Capture 0 [0%] [0.00dB]
>> Simple mixer control 'Input Source',0
>>   Capabilities: cenum
>>   Items: 'Mic' 'Front Mic'
>>   Item0: 'Mic'
>> Simple mixer control 'Input Source',1
>>   Capabilities: cenum
>>   Items: 'Mic' 'Front Mic'
>>   Item0: 'Mic'
>>
>>
>> !!Alsactl output
>> !!-------------
>>
>> --startcollapse--
>> state.Intel {
>>       control.1 {
>>               comment.access 'read write'
>>               comment.type ENUMERATED
>>               comment.count 1
>>               comment.item.0 Mic
>>               comment.item.1 'Front Mic'
>>               iface MIXER
>>               name 'Input Source'
>>               value Mic
>>       }
>>       control.2 {
>>               comment.access 'read write'
>>               comment.type ENUMERATED
>>               comment.count 1
>>               comment.item.0 Mic
>>               comment.item.1 'Front Mic'
>>               iface MIXER
>>               name 'Input Source'
>>               index 1
>>               value Mic
>>       }
>>       control.3 {
>>               comment.access 'read write'
>>               comment.type BOOLEAN
>>               comment.count 1
>>               iface MIXER
>>               name 'Analog Loopback'
>>               value false
>>       }
>>       control.4 {
>>               comment.access 'read write'
>>               comment.type BOOLEAN
>>               comment.count 1
>>               iface MIXER
>>               name 'Analog Loopback'
>>               index 1
>>               value false
>>       }
>>       control.5 {
>>               comment.access 'read write'
>>               comment.type INTEGER
>>               comment.count 2
>>               comment.range '0 - 15'
>>               comment.dbmin 0
>>               comment.dbmax 2250
>>               iface MIXER
>>               name 'Capture Volume'
>>               value.0 0
>>               value.1 0
>>       }
>>       control.6 {
>>               comment.access 'read write'
>>               comment.type BOOLEAN
>>               comment.count 2
>>               iface MIXER
>>               name 'Capture Switch'
>>               value.0 true
>>               value.1 true
>>       }
>>       control.7 {
>>               comment.access 'read write'
>>               comment.type INTEGER
>>               comment.count 2
>>               comment.range '0 - 3'
>>               comment.dbmin 0
>>               comment.dbmax 3000
>>               iface MIXER
>>               name 'Capture Mux Volume'
>>               value.0 1
>>               value.1 1
>>       }
>>       control.8 {
>>               comment.access 'read write'
>>               comment.type INTEGER
>>               comment.count 2
>>               comment.range '0 - 15'
>>               comment.dbmin 0
>>               comment.dbmax 2250
>>               iface MIXER
>>               name 'Capture Volume'
>>               index 1
>>               value.0 0
>>               value.1 0
>>       }
>>       control.9 {
>>               comment.access 'read write'
>>               comment.type BOOLEAN
>>               comment.count 2
>>               iface MIXER
>>               name 'Capture Switch'
>>               index 1
>>               value.0 false
>>               value.1 false
>>       }
>>       control.10 {
>>               comment.access 'read write'
>>               comment.type INTEGER
>>               comment.count 2
>>               comment.range '0 - 3'
>>               comment.dbmin 0
>>               comment.dbmax 3000
>>               iface MIXER
>>               name 'Capture Mux Volume'
>>               index 1
>>               value.0 0
>>               value.1 0
>>       }
>>       control.11 {
>>               comment.access 'read write'
>>               comment.type INTEGER
>>               comment.count 2
>>               comment.range '0 - 127'
>>               comment.dbmin -9525
>>               comment.dbmax 0
>>               iface MIXER
>>               name 'Front Playback Volume'
>>               value.0 127
>>               value.1 127
>>       }
>>       control.12 {
>>               comment.access 'read write'
>>               comment.type BOOLEAN
>>               comment.count 2
>>               iface MIXER
>>               name 'Front Playback Switch'
>>               value.0 true
>>               value.1 true
>>       }
>>       control.13 {
>>               comment.access 'read write'
>>               comment.type INTEGER
>>               comment.count 2
>>               comment.range '0 - 127'
>>               comment.dbmin -9525
>>               comment.dbmax 0
>>               iface MIXER
>>               name 'Headphone Playback Volume'
>>               value.0 127
>>               value.1 127
>>       }
>>       control.14 {
>>               comment.access 'read write'
>>               comment.type BOOLEAN
>>               comment.count 2
>>               iface MIXER
>>               name 'Headphone Playback Switch'
>>               value.0 true
>>               value.1 true
>>       }
>>       control.15 {
>>               comment.access 'read write'
>>               comment.type INTEGER
>>               comment.count 2
>>               comment.range '0 - 3'
>>               comment.dbmin 0
>>               comment.dbmax 3000
>>               iface MIXER
>>               name 'Digital Mic 1 Capture Volume'
>>               value.0 0
>>               value.1 0
>>       }
>>       control.16 {
>>               comment.access 'read write'
>>               comment.type ENUMERATED
>>               comment.count 1
>>               comment.item.0 'Analog Inputs'
>>               comment.item.1 'Digital Mic 1'
>>               iface MIXER
>>               name 'Digital Input Source'
>>               value 'Analog Inputs'
>>       }
>>       control.17 {
>>               comment.access 'read write'
>>               comment.type INTEGER
>>               comment.count 1
>>               comment.range '0 - 127'
>>               comment.dbmin -9525
>>               comment.dbmax 0
>>               iface MIXER
>>               name 'Master Playback Volume'
>>               value 94
>>       }
>>       control.18 {
>>               comment.access 'read write'
>>               comment.type BOOLEAN
>>               comment.count 1
>>               iface MIXER
>>               name 'Master Playback Switch'
>>               value true
>>       }
>>       control.19 {
>>               comment.access 'read write user'
>>               comment.type INTEGER
>>               comment.count 2
>>               comment.range '0 - 255'
>>               comment.tlv '0000000100000008ffffec1400000014'
>>               comment.dbmin -5100
>>               comment.dbmax 0
>>               iface MIXER
>>               name 'PCM Playback Volume'
>>               value.0 255
>>               value.1 255
>>       }
>> }
>> --endcollapse--
>>
>>
>> !!All Loaded Modules
>> !!------------------
>>
>> Module
>> snd_hda_intel
>> snd_hwdep
>> nls_cp437
>> vfat
>> fat
>> loop
>> isofs
>> udf
>> nvidia
>> ppdev
>> lp
>> parport
>> acpi_cpufreq
>> cpufreq_performance
>> cpufreq_stats
>> cpufreq_ondemand
>> cpufreq_powersave
>> cpufreq_conservative
>> freq_table
>> ipv6
>> af_packet
>> hfsplus
>> nls_utf8
>> ntfs
>> nls_base
>> fuse
>> snd_pcm_oss
>> snd_pcm
>> snd_page_alloc
>> snd_mixer_oss
>> pcmcia
>> firmware_class
>> snd_seq_dummy
>> rtc_cmos
>> snd_seq_oss
>> rtc_core
>> rtc_lib
>> dcdbas
>> snd_seq_midi_event
>> snd_seq
>> snd_timer
>> snd_seq_device
>> serio_raw
>> psmouse
>> i2c_i801
>> snd
>> pcspkr
>> evdev
>> i2c_core
>> yenta_socket
>> rsrc_nonstatic
>> pcmcia_core
>> soundcore
>> video
>> output
>> wmi
>> ac
>> button
>> battery
>> intel_agp
>> ext3
>> jbd
>> mbcache
>> dm_mirror
>> dm_log
>> dm_snapshot
>> dm_mod
>> firewire_sbp2
>> sg
>> sr_mod
>> cdrom
>> sd_mod
>> usbhid
>> hid
>> ff_memless
>> ahci
>> libata
>> scsi_mod
>> dock
>> ricoh_mmc
>> sdhci
>> mmc_core
>> firewire_ohci
>> firewire_core
>> crc_itu_t
>> ehci_hcd
>> uhci_hcd
>> usbcore
>> e1000e
>> thermal
>> processor
>> fan
>>
>>
>> On Monday 06 October 2008 11:44:33 you wrote:
>> > At Sun, 5 Oct 2008 22:10:46 +0200,
>> >
>> > Klaas De Craemer wrote:
>> > > Hello,
>> > >
>> > > A few days ago, I posted a patch to the linux kernel list, but afterwards
>> > > I realised that it is more appropriate for the alsa list. So I repost it
>> > > here.
>> > >
>> > > Below is my patch for an issue on Dell E6500 notebooks with the Sigmatel
>> > > stac92hd71b7 codec. In the default snd-hda-intel configuration, the sound
>> > > going to the headphone jack goes comes directly from the DAC, resulting
>> > > in very low volume output. The patch changes the codec's widget
>> > > connections so that the internal mixer is put in between and sets its
>> > > input amplifiers to the maximum value. The output to the internal speaker
>> > > port has been left untouched.
>> > > I have tested this and it gives a much better output.
>> >
>> > Thanks for the patch.
>> >
>> > I wonder whether this really improves the quality.
>> > Basically what you does is to set the volume of the input mixer over
>> > 0dB, and this is usually bad when really high signals come in.
>> >
>> > Just to be sure, is the output pin set to the headphone pin control?
>> > You can give alsa-info.sh output (run with --no-upload option) for
>> > further analysis.  The script is found in
>> >     http://www.alsa-project.org/alsa-info.sh
>> >
>> >
>> > thanks,
>> >
>> > Takashi
>>
>>
>
