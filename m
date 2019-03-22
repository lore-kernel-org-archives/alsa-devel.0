From: Guido Trentalancia <guido@trentalancia.com>
Subject: Re: Hercules P32 DJ: severe sound distortion
	during	MIDI transfers
Date: Fri, 22 Mar 2019 10:17:17 +0100
Message-ID: <D5E663E4-9118-4CA3-8ADE-5F97202D9404@trentalancia.com>
References: <1553114844.12865.6.camel@trentalancia.com>
 <1335514032.30698.1553207267014@pim.register.it>
 <s5hr2azp9t3.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from authsmtp.register.it (authsmtp35.register.it [81.88.55.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 97699F8078F
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2019 10:19:02 +0100 (CET)
In-Reply-To: <s5hr2azp9t3.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

It cannot be a firmware bug, as you say, because:

- it does NOT happen on Windows!
- it does NOT even always happen on Linux: other users (with different kernel / ALSA library) are not experiencing the same problem;
- it happens with several firmware versions, including the latest one (1.36 and 1.46).

So it is either a bug in ALSA kernel driver, USB sound driver (more likely) or ALSA library.

Now, you are in charge of the USB sound driver, can you please double check??

Regards,

Guido

Il 22 marzo 2019 09:55:52 CET, Takashi Iwai <tiwai@suse.de> ha scritto:
>On Thu, 21 Mar 2019 23:27:46 +0100,
>Guido Trentalancia wrote:
>> 
>> I wonder if this might be due to a bug in the "USB Audio Driver for
>Alsa"?
>> 
>>
>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/usb
>> 
>>
>https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/tree/sound/usb
>
>More likely a buggy firmware of your USB audio device :)
>
> From the driver implementation POV, both audio and MIDI devices are
>handled by individual endpoints, hence they shouldn't conflict.
>
>Or another possibility would be some USB host side issue like the
>bandwidth.  But it's a MIDI stream that is very low data rate, so this
>sounds also unlikely...
>
>
>thanks,
>
>Takashi
>
>> 
>> Guido
>> 
>>     On the 20th of March 2019 at 21.47 Guido Trentalancia
>>     <guido@trentalancia.com wrote:
>>    
>>     Hello.
>>    
>>     I am hitting a very serious bug (ALSA kernel driver or ALSA
>library)
>>     when using the Hercules P32 DJ audio interface.
>>    
>>     The sound is severely distorted during MIDI transfers.
>>    
>>     To reproduce:
>>    
>>       + start playing something in a first console:
>>    
>>     console1# AUDIODEV=hw:2,0 play audio.wav
>>    
>>       + the audio plays fine
>>        
>>       + now start "amidi" in a second console while the above track
>is still
>>         playing
>>        
>>     console2# amidi -p hw:2,0,0 -d
>>    
>>       + the sound is now severely distorted (basically noise, with
>some hard-
>>         to-distinguish features resembling the original track) until
>"amidi"
>>         is
>>         interrupted !
>>    
>>     Kernel versions tested: from 4.12 up to 5.0.2 (latest).
>>    
>>     NOTES: Always reproducible. Same device is working fine on
>Windows.
>>    
>>     The output from alsa-info.sh and lsusb -v follows.
>>    
>>     upload=true&script=true&cardinfo=
>>     !!################################
>>     !!ALSA Information Script v 0.4.64
>>     !!################################
>>    
>>     !!Script ran on: Wed Mar 20 20:44:36 UTC 2019
>>    
>>     !!Linux Distribution
>>     !!------------------
>>    
>>     !!DMI Information
>>     !!---------------
>>    
>>     Manufacturer: Acer
>>     Product Name: Aspire 5745G
>>     Product Version: V1.19
>>     Firmware Version: V1.19
>>     Board Vendor: Acer
>>     Board Name: JV51_CP
>>    
>>     !!ACPI Device Status Information
>>     !!---------------
>>    
>>     /sys/bus/acpi/devices/PNP0103:00/status 15
>>     /sys/bus/acpi/devices/PNP0C0A:00/status 31
>>     /sys/bus/acpi/devices/PNP0C0F:00/status 9
>>     /sys/bus/acpi/devices/PNP0C0F:01/status 9
>>     /sys/bus/acpi/devices/PNP0C0F:02/status 9
>>     /sys/bus/acpi/devices/PNP0C0F:03/status 9
>>     /sys/bus/acpi/devices/PNP0C0F:04/status 9
>>     /sys/bus/acpi/devices/PNP0C0F:05/status 9
>>     /sys/bus/acpi/devices/PNP0C0F:06/status 9
>>     /sys/bus/acpi/devices/PNP0C0F:07/status 9
>>    
>>     !!Kernel Information
>>     !!------------------
>>    
>>     Kernel release: 5.0.2
>>     Operating System: GNU/Linux
>>     Architecture: x86_64
>>     Processor: unknown
>>     SMP Enabled: Yes
>>    
>>     !!ALSA Version
>>     !!------------
>>    
>>     Driver version: k5.0.2
>>     Library version: 1.1.8
>>     Utilities version: 1.1.8
>>    
>>     !!Loaded ALSA modules
>>     !!-------------------
>>    
>>     snd_hda_intel
>>     snd_hda_intel
>>     snd_usb_audio
>>    
>>     !!Sound Servers on this system
>>     !!----------------------------
>>    
>>     Pulseaudio:
>>     Installed - Yes (/usr/bin/pulseaudio)
>>     Running - No
>>    
>>     Jack:
>>     Installed - Yes (/usr/bin/jackd)
>>     Running - No
>>    
>>     !!Soundcards recognised by ALSA
>>     !!-----------------------------
>>    
>>     0 [MID ]: HDA-Intel - HDA Intel MID
>>     HDA Intel MID at 0xb7100000 irq 27
>>     1 [NVidia ]: HDA-Intel - HDA NVidia
>>     HDA NVidia at 0xb3000000 irq 16
>>     2 [DJ ]: USB-Audio - Hercules P32 DJ
>>     Guillemot Corporation Hercules P32 DJ at usb-
>>     0000:00:1d.0-1.4, full speed
>>    
>>     !!PCI Soundcards installed in the system
>>     !!--------------------------------------
>>    
>>     00:1b.0 Audio device: Intel Corporation 5 Series/3400 Series
>Chipset
>>     High Definition Audio (rev 05)
>>     01:00.1 Audio device: NVIDIA Corporation GT216 HDMI Audio
>Controller
>>     (rev a1)
>>    
>>     !!Advanced information - PCI Vendor/Device/Subsystem ID's
>>     !!-------------------------------------------------------
>>    
>>     00:1b.0 0403: 8086:3b56 (rev 05)
>>    
>>     Subsystem: 1025:035b
>>     --
>>     01:00.1 0403: 10de:0be2 (rev a1)
>>     Subsystem: 1025:035a
>>    
>>     !!Loaded sound module options
>>     !!---------------------------
>>    
>>     !!Module: snd_hda_intel
>>     align_buffer_size : -1
>>     bdl_pos_adj : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-
>>     1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
>>     beep_mode :
>>     N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N
>>     enable :
>>     Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
>>     enable_msi : -1
>>     id :
>>    
>(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(
>>    
>null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(n
>>    
>ull),(null),(null),(null),(null),(null),(null),(null),(null),(null),(nu
>>     ll),(null)
>>     index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-
>>     1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
>>     jackpoll_ms :
>>     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
>>     model :
>>    
>(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(
>>    
>null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(n
>>    
>ull),(null),(null),(null),(null),(null),(null),(null),(null),(null),(nu
>>     ll),(null)
>>     patch :
>>    
>(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(
>>    
>null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(n
>>    
>ull),(null),(null),(null),(null),(null),(null),(null),(null),(null),(nu
>>     ll),(null)
>>     pm_blacklist : Y
>>     position_fix : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-
>>     1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
>>     power_save : 0
>>     power_save_controller : Y
>>     probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-
>>     1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
>>     probe_only :
>>     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
>>     single_cmd : -1
>>     snoop : -1
>>    
>>     !!Module: snd_hda_intel
>>     align_buffer_size : -1
>>     bdl_pos_adj : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-
>>     1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
>>     beep_mode :
>>     N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N
>>     enable :
>>     Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
>>     enable_msi : -1
>>     id :
>>    
>(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(
>>    
>null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(n
>>    
>ull),(null),(null),(null),(null),(null),(null),(null),(null),(null),(nu
>>     ll),(null)
>>     index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-
>>     1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
>>     jackpoll_ms :
>>     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
>>     model :
>>    
>(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(
>>    
>null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(n
>>    
>ull),(null),(null),(null),(null),(null),(null),(null),(null),(null),(nu
>>     ll),(null)
>>     patch :
>>    
>(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(
>>    
>null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(n
>>    
>ull),(null),(null),(null),(null),(null),(null),(null),(null),(null),(nu
>>     ll),(null)
>>     pm_blacklist : Y
>>     position_fix : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-
>>     1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
>>     power_save : 0
>>     power_save_controller : Y
>>     probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-
>>     1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
>>     probe_only :
>>     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
>>     single_cmd : -1
>>     snoop : -1
>>    
>>     !!Module: snd_usb_audio
>>     autoclock : Y
>>     device_setup :
>>     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
>>     enable :
>>     Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
>>     id :
>>    
>(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(
>>    
>null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(n
>>    
>ull),(null),(null),(null),(null),(null),(null),(null),(null),(null),(nu
>>     ll),(null)
>>     ignore_ctl_error : N
>>     index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-
>>     1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
>>     pid : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-
>>     1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
>>     quirk_alias :
>>    
>(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(
>>    
>null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(n
>>    
>ull),(null),(null),(null),(null),(null),(null),(null),(null),(null),(nu
>>     ll),(null)
>>     use_vmalloc : Y
>>     vid : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-
>>     1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
>>    
>>     !!HDA-Intel Codec information
>>     !!---------------------------
>>     --startcollapse--
>>    
>>     Codec: Realtek ALC269VB
>>     Address: 0
>>     AFG Function Id: 0x1 (unsol 1)
>>     Vendor Id: 0x10ec0269
>>     Subsystem Id: 0x1025035b
>>     Revision Id: 0x100100
>>     No Modem Function Group found
>>     Default PCM:
>>     rates [0x560]: 44100 48000 96000 192000
>>     bits [0xe]: 16 20 24
>>     formats [0x1]: PCM
>>     Default Amp-In caps: N/A
>>     Default Amp-Out caps: N/A
>>     State of AFG node 0x01:
>>     Power states: D0 D1 D2 D3 CLKSTOP EPSS
>>     Power: setting=D0, actual=D0
>>     GPIO: io=2, o=0, i=0, unsolicited=1, wake=0
>>     IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>>     IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>>     Node 0x02 [Audio Output] wcaps 0x1d: Stereo Amp-Out
>>     Control: name="Headphone Playback Volume", index=0, device=0
>>     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>>     Device: name="ALC269VB Analog", type="Audio", device=0
>>     Amp-Out caps: ofs=0x57, nsteps=0x57, stepsize=0x02, mute=0
>>     Amp-Out vals: [0x00 0x00]
>>     Converter: stream=5, channel=0
>>     PCM:
>>     rates [0x560]: 44100 48000 96000 192000
>>     bits [0xe]: 16 20 24
>>     formats [0x1]: PCM
>>     Node 0x03 [Audio Output] wcaps 0x1d: Stereo Amp-Out
>>     Control: name="Speaker Playback Volume", index=0, device=0
>>     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>>     Amp-Out caps: ofs=0x57, nsteps=0x57, stepsize=0x02, mute=0
>>     Amp-Out vals: [0x51 0x51]
>>     Converter: stream=5, channel=0
>>     PCM:
>>     rates [0x560]: 44100 48000 96000 192000
>>     bits [0xe]: 16 20 24
>>     formats [0x1]: PCM
>>     Node 0x04 [Vendor Defined Widget] wcaps 0xf00000: Mono
>>     Node 0x05 [Vendor Defined Widget] wcaps 0xf00000: Mono
>>     Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
>>     Control: name="IEC958 Playback Con Mask", index=0, device=0
>>     Control: name="IEC958 Playback Pro Mask", index=0, device=0
>>     Control: name="IEC958 Playback Default", index=0, device=0
>>     Control: name="IEC958 Playback Switch", index=0, device=0
>>     Control: name="IEC958 Default PCM Playback Switch", index=0,
>device=0
>>     Device: name="ALC269VB Digital", type="SPDIF", device=1
>>     Converter: stream=5, channel=0
>>     Digital:
>>     Digital category: 0x0
>>     IEC Coding Type: 0x0
>>     PCM:
>>     rates [0x5e0]: 44100 48000 88200 96000 192000
>>     bits [0xe]: 16 20 24
>>     formats [0x1]: PCM
>>     Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
>>     Node 0x08 [Audio Input] wcaps 0x10011b: Stereo Amp-In
>>     Amp-In caps: ofs=0x0b, nsteps=0x1f, stepsize=0x05, mute=1
>>     Amp-In vals: [0x8b 0x8b]
>>     Converter: stream=0, channel=0
>>     SDI-Select: 0
>>     PCM:
>>     rates [0x560]: 44100 48000 96000 192000
>>     bits [0xe]: 16 20 24
>>     formats [0x1]: PCM
>>     Connection: 1
>>     0x23
>>     Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In
>>     Control: name="Capture Volume", index=0, device=0
>>     ControlAmp: chs=3, dir=In, idx=0, ofs=0
>>     Control: name="Capture Switch", index=0, device=0
>>     ControlAmp: chs=3, dir=In, idx=0, ofs=0
>>     Device: name="ALC269VB Analog", type="Audio", device=0
>>     Amp-In caps: ofs=0x0b, nsteps=0x1f, stepsize=0x05, mute=1
>>     Amp-In vals: [0x00 0x00]
>>     Converter: stream=1, channel=0
>>     SDI-Select: 0
>>     PCM:
>>     rates [0x560]: 44100 48000 96000 192000
>>     bits [0xe]: 16 20 24
>>     formats [0x1]: PCM
>>     Connection: 1
>>     0x22
>>     Node 0x0a [Vendor Defined Widget] wcaps 0xf00000: Mono
>>     Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>>     Control: name="Mic Playback Volume", index=0, device=0
>>     ControlAmp: chs=3, dir=In, idx=0, ofs=0
>>     Control: name="Mic Playback Switch", index=0, device=0
>>     ControlAmp: chs=3, dir=In, idx=0, ofs=0
>>     Control: name="Beep Playback Volume", index=0, device=0
>>     ControlAmp: chs=3, dir=In, idx=4, ofs=0
>>     Control: name="Beep Playback Switch", index=0, device=0
>>     ControlAmp: chs=3, dir=In, idx=4, ofs=0
>>     Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
>>     Amp-In vals: [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
>[0x80
>>     0x80]
>>     Connection: 5
>>     0x18 0x19 0x1a 0x1b 0x1d
>>     Node 0x0c [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>>     Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>>     Amp-In vals: [0x00 0x00] [0x80 0x80]
>>     Connection: 2
>>     0x02 0x0b
>>     Node 0x0d [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>>     Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>>     Amp-In vals: [0x00 0x00] [0x80 0x80]
>>     Connection: 2
>>     0x03 0x0b
>>     Node 0x0e [Vendor Defined Widget] wcaps 0xf00000: Mono
>>     Node 0x0f [Audio Mixer] wcaps 0x20010a: Mono Amp-In
>>     Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>>     Amp-In vals: [0x00] [0x80]
>>     Connection: 2
>>     0x02 0x0b
>>     Node 0x10 [Vendor Defined Widget] wcaps 0xf00000: Mono
>>     Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono
>>     Node 0x12 [Pin Complex] wcaps 0x40000b: Stereo Amp-In
>>     Control: name="Internal Mic Boost Volume", index=0, device=0
>>     ControlAmp: chs=3, dir=In, idx=0, ofs=0
>>     Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
>>     Amp-In vals: [0x00 0x00]
>>     Pincap 0x00000020: IN
>>     Pin Default 0x99a30930: [Fixed] Mic at Int ATAPI
>>     Conn = ATAPI, Color = Unknown
>>     DefAssociation = 0x3, Sequence = 0x0
>>     Misc = NO_PRESENCE
>>     Pin-ctls: 0x20: IN
>>     Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
>>     Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
>>     Control: name="Speaker Playback Switch", index=0, device=0
>>     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>>     Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>>     Amp-Out vals: [0x00 0x00]
>>     Pincap 0x00010014: OUT EAPD Detect
>>     EAPD 0x2: EAPD
>>     Pin Default 0x99130110: [Fixed] Speaker at Int ATAPI
>>     Conn = ATAPI, Color = Unknown
>>     DefAssociation = 0x1, Sequence = 0x0
>>     Misc = NO_PRESENCE
>>     Pin-ctls: 0x40: OUT
>>     Unsolicited: tag=00, enabled=0
>>     Connection: 2
>>     0x0c 0x0d*
>>     Node 0x15 [Vendor Defined Widget] wcaps 0xf00000: Mono
>>     Node 0x16 [Vendor Defined Widget] wcaps 0xf00000: Mono
>>     Node 0x17 [Pin Complex] wcaps 0x40010c: Mono Amp-Out
>>     Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>>     Amp-Out vals: [0x80]
>>     Pincap 0x00000010: OUT
>>     Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>>     Conn = 1/8, Color = Black
>>     DefAssociation = 0xf, Sequence = 0x0
>>     Misc = NO_PRESENCE
>>     Pin-ctls: 0x00:
>>     Connection: 1
>>     0x0f
>>     Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>>     Control: name="Mic Boost Volume", index=0, device=0
>>     ControlAmp: chs=3, dir=In, idx=0, ofs=0
>>     Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
>>     Amp-In vals: [0x00 0x00]
>>     Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>>     Amp-Out vals: [0x80 0x80]
>>     Pincap 0x00001734: IN OUT Detect
>>     Vref caps: HIZ 50 GRD 80
>>     Pin Default 0x03a19840: [Jack] Mic at Ext Left
>>     Conn = 1/8, Color = Pink
>>     DefAssociation = 0x4, Sequence = 0x0
>>     Pin-ctls: 0x24: IN VREF_80
>>     Unsolicited: tag=02, enabled=1
>>     Connection: 1
>>     0x0d
>>     Node 0x19 [Pin Complex] wcaps 0x40008b: Stereo Amp-In
>>     Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
>>     Amp-In vals: [0x00 0x00]
>>     Pincap 0x00001724: IN Detect
>>     Vref caps: HIZ 50 GRD 80
>>     Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>>     Conn = 1/8, Color = Black
>>     DefAssociation = 0xf, Sequence = 0x0
>>     Misc = NO_PRESENCE
>>     Pin-ctls: 0x20: IN VREF_HIZ
>>     Unsolicited: tag=00, enabled=0
>>     Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>>     Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
>>     Amp-In vals: [0x00 0x00]
>>     Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>>     Amp-Out vals: [0x80 0x80]
>>     Pincap 0x0000003c: IN OUT HP Detect
>>     Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>>     Conn = 1/8, Color = Black
>>     DefAssociation = 0xf, Sequence = 0x0
>>     Misc = NO_PRESENCE
>>     Pin-ctls: 0x20: IN
>>     Unsolicited: tag=00, enabled=0
>>     Connection: 2
>>     0x0c* 0x0d
>>     Node 0x1b [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>>     Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
>>     Amp-In vals: [0x00 0x00]
>>     Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>>     Amp-Out vals: [0x80 0x80]
>>     Pincap 0x00000034: IN OUT Detect
>>     Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>>     Conn = 1/8, Color = Black
>>     DefAssociation = 0xf, Sequence = 0x0
>>     Misc = NO_PRESENCE
>>     Pin-ctls: 0x20: IN
>>     Unsolicited: tag=00, enabled=0
>>     Connection: 2
>>     0x0c* 0x0d
>>     Node 0x1c [Vendor Defined Widget] wcaps 0xf00000: Mono
>>     Node 0x1d [Pin Complex] wcaps 0x400000: Mono
>>     Pincap 0x00000020: IN
>>     Pin Default 0x4017992d: [N/A] Speaker at Ext N/A
>>     Conn = Analog, Color = Pink
>>     DefAssociation = 0x2, Sequence = 0xd
>>     Misc = NO_PRESENCE
>>     Pin-ctls: 0x20: IN
>>     Node 0x1e [Pin Complex] wcaps 0x400381: Stereo Digital
>>     Pincap 0x00000014: OUT Detect
>>     Pin Default 0x03451120: [Jack] SPDIF Out at Ext Left
>>     Conn = Optical, Color = Black
>>     DefAssociation = 0x2, Sequence = 0x0
>>     Misc = NO_PRESENCE
>>     Pin-ctls: 0x40: OUT
>>     Unsolicited: tag=00, enabled=0
>>     Connection: 1
>>     0x06
>>     Node 0x1f [Vendor Defined Widget] wcaps 0xf00000: Mono
>>     Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
>>     Processing caps: benign=0, ncoeff=25
>>     Node 0x21 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
>>     Control: name="Headphone Playback Switch", index=0, device=0
>>     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>>     Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>>     Amp-Out vals: [0x80 0x80]
>>     Pincap 0x0000001c: OUT HP Detect
>>     Pin Default 0x0321101f: [Jack] HP Out at Ext Left
>>     Conn = 1/8, Color = Black
>>     DefAssociation = 0x1, Sequence = 0xf
>>     Pin-ctls: 0xc0: OUT HP
>>     Unsolicited: tag=01, enabled=1
>>     Connection: 2
>>     0x0c* 0x0d
>>     Node 0x22 [Audio Selector] wcaps 0x30010b: Stereo Amp-In
>>     Amp-In caps: N/A
>>     Amp-In vals: [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>[0x00
>>     0x00] [0x00 0x00] [0x00 0x00]
>>     Connection: 7
>>     0x18 0x19 0x1a 0x1b 0x1d 0x0b 0x12*
>>     Node 0x23 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>>     Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>>     Amp-In vals: [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
>[0x80
>>     0x80] [0x80 0x80]
>>     Connection: 6
>>     0x18 0x19 0x1a 0x1b 0x1d 0x0b
>>     Codec: Nvidia Generic
>>     Address: 0
>>     AFG Function Id: 0x1 (unsol 0)
>>     Vendor Id: 0x10de000a
>>     Subsystem Id: 0x10de0101
>>     Revision Id: 0x100100
>>     No Modem Function Group found
>>     Default PCM:
>>     rates [0x0]:
>>     bits [0x0]:
>>     formats [0x0]:
>>     Default Amp-In caps: N/A
>>     Default Amp-Out caps: N/A
>>     State of AFG node 0x01:
>>     Power states: D0 D1 D2 D3
>>     Power: setting=D0, actual=D0
>>     GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
>>     Node 0x04 [Audio Output] wcaps 0x72b1: 8-Channels Digital Stripe
>CP
>>     Control: name="IEC958 Playback Con Mask", index=0, device=0
>>     Control: name="IEC958 Playback Pro Mask", index=0, device=0
>>     Control: name="IEC958 Playback Default", index=0, device=0
>>     Control: name="IEC958 Playback Switch", index=0, device=0
>>     Device: name="Generic Digital", type="HDMI", device=3
>>     Converter: stream=0, channel=0
>>     Digital: Enabled
>>     Digital category: 0x0
>>     IEC Coding Type: 0x0
>>     PCM:
>>     rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
>>     bits [0xe]: 16 20 24
>>     formats [0x5]: PCM AC3
>>     Unsolicited: tag=00, enabled=0
>>     Node 0x05 [Pin Complex] wcaps 0x407381: 8-Channels Digital CP
>>     Pincap 0x09000094: OUT Detect HBR HDMI DP
>>     Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
>>     Conn = Digital, Color = Unknown
>>     DefAssociation = 0x1, Sequence = 0x0
>>     Pin-ctls: 0x40: OUT
>>     Unsolicited: tag=01, enabled=1
>>     Connection: 1
>>     0x04
>>     Codec: Nvidia Generic
>>     Address: 1
>>     AFG Function Id: 0x1 (unsol 0)
>>     Vendor Id: 0x10de000a
>>     Subsystem Id: 0x10de0101
>>     Revision Id: 0x100100
>>     No Modem Function Group found
>>     Default PCM:
>>     rates [0x0]:
>>     bits [0x0]:
>>     formats [0x0]:
>>     Default Amp-In caps: N/A
>>     Default Amp-Out caps: N/A
>>     State of AFG node 0x01:
>>     Power states: D0 D1 D2 D3
>>     Power: setting=D0, actual=D0
>>     GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
>>     Node 0x04 [Audio Output] wcaps 0x72b1: 8-Channels Digital Stripe
>CP
>>     Control: name="IEC958 Playback Con Mask", index=1, device=0
>>     Control: name="IEC958 Playback Pro Mask", index=1, device=0
>>     Control: name="IEC958 Playback Default", index=1, device=0
>>     Control: name="IEC958 Playback Switch", index=1, device=0
>>     Device: name="Generic Digital", type="HDMI", device=7
>>     Converter: stream=0, channel=0
>>     Digital: Enabled
>>     Digital category: 0x0
>>     IEC Coding Type: 0x0
>>     PCM:
>>     rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
>>     bits [0xe]: 16 20 24
>>     formats [0x5]: PCM AC3
>>     Unsolicited: tag=00, enabled=0
>>     Node 0x05 [Pin Complex] wcaps 0x407381: 8-Channels Digital CP
>>     Pincap 0x09000094: OUT Detect HBR HDMI DP
>>     Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
>>     Conn = Digital, Color = Unknown
>>     DefAssociation = 0x1, Sequence = 0x0
>>     Pin-ctls: 0x40: OUT
>>     Unsolicited: tag=01, enabled=1
>>     Connection: 1
>>     0x04
>>     Codec: Nvidia Generic
>>     Address: 2
>>     AFG Function Id: 0x1 (unsol 0)
>>     Vendor Id: 0x10de000a
>>     Subsystem Id: 0x10de0101
>>     Revision Id: 0x100100
>>     No Modem Function Group found
>>     Default PCM:
>>     rates [0x0]:
>>     bits [0x0]:
>>     formats [0x0]:
>>     Default Amp-In caps: N/A
>>     Default Amp-Out caps: N/A
>>     State of AFG node 0x01:
>>     Power states: D0 D1 D2 D3
>>     Power: setting=D0, actual=D0
>>     GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
>>     Node 0x04 [Audio Output] wcaps 0x72b1: 8-Channels Digital Stripe
>CP
>>     Control: name="IEC958 Playback Con Mask", index=2, device=0
>>     Control: name="IEC958 Playback Pro Mask", index=2, device=0
>>     Control: name="IEC958 Playback Default", index=2, device=0
>>     Control: name="IEC958 Playback Switch", index=2, device=0
>>     Device: name="Generic Digital", type="HDMI", device=8
>>     Converter: stream=0, channel=0
>>     Digital: Enabled
>>     Digital category: 0x0
>>     IEC Coding Type: 0x0
>>     PCM:
>>     rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
>>     bits [0xe]: 16 20 24
>>     formats [0x5]: PCM AC3
>>     Unsolicited: tag=00, enabled=0
>>     Node 0x05 [Pin Complex] wcaps 0x407381: 8-Channels Digital CP
>>     Pincap 0x09000094: OUT Detect HBR HDMI DP
>>     Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
>>     Conn = Digital, Color = Unknown
>>     DefAssociation = 0x1, Sequence = 0x0
>>     Pin-ctls: 0x40: OUT
>>     Unsolicited: tag=01, enabled=1
>>     Connection: 1
>>     0x04
>>     Codec: Nvidia Generic
>>     Address: 3
>>     AFG Function Id: 0x1 (unsol 0)
>>     Vendor Id: 0x10de000a
>>     Subsystem Id: 0x10de0101
>>     Revision Id: 0x100100
>>     No Modem Function Group found
>>     Default PCM:
>>     rates [0x0]:
>>     bits [0x0]:
>>     formats [0x0]:
>>     Default Amp-In caps: N/A
>>     Default Amp-Out caps: N/A
>>     State of AFG node 0x01:
>>     Power states: D0 D1 D2 D3
>>     Power: setting=D0, actual=D0
>>     GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
>>     Node 0x04 [Audio Output] wcaps 0x72b1: 8-Channels Digital Stripe
>CP
>>     Control: name="IEC958 Playback Con Mask", index=3, device=0
>>     Control: name="IEC958 Playback Pro Mask", index=3, device=0
>>     Control: name="IEC958 Playback Default", index=3, device=0
>>     Control: name="IEC958 Playback Switch", index=3, device=0
>>     Device: name="Generic Digital", type="HDMI", device=9
>>     Converter: stream=5, channel=0
>>     Digital: Enabled
>>     Digital category: 0x0
>>     IEC Coding Type: 0x0
>>     PCM:
>>     rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
>>     bits [0xe]: 16 20 24
>>     formats [0x5]: PCM AC3
>>     Unsolicited: tag=00, enabled=0
>>     Node 0x05 [Pin Complex] wcaps 0x407381: 8-Channels Digital CP
>>     Pincap 0x09000094: OUT Detect HBR HDMI DP
>>     Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
>>     Conn = Digital, Color = Unknown
>>     DefAssociation = 0x1, Sequence = 0x0
>>     Pin-ctls: 0x40: OUT
>>     Unsolicited: tag=01, enabled=1
>>     Connection: 1
>>     0x04
>>     --endcollapse--
>>    
>>     !!USB Mixer information
>>     !!---------------------
>>     --startcollapse--
>>    
>>     USB Mixer: usb_id=0x06f8b121, ctrlif=0, ctlerr=0
>>     Card: Guillemot Corporation Hercules P32 DJ at
>usb-0000:00:1d.0-1.4,
>>     full speed
>>     Unit: 2
>>     Control: name="PCM Playback Volume", index=0
>>     Info: id=2, control=2, cmask=0xf, channels=4, type="S16"
>>     Volume: min=-25600, max=0, dBmin=-10000, dBmax=0
>>     Unit: 2
>>     Control: name="PCM Playback Switch", index=0
>>     Info: id=2, control=1, cmask=0xf, channels=4, type="INV_BOOLEAN"
>>     Volume: min=0, max=1, dBmin=0, dBmax=0
>>     --endcollapse--
>>    
>>     !!ALSA Device nodes
>>     !!-----------------
>>    
>>     crw-rw----. 1 root audio 116, 6 Mar 20 18:15 /dev/snd/controlC0
>>     crw-rw----. 1 root audio 116, 15 Mar 20 18:15 /dev/snd/controlC1
>>     crw-rw----. 1 root audio 116, 18 Mar 20 21:25 /dev/snd/controlC2
>>     crw-rw----. 1 root audio 116, 5 Mar 20 18:15 /dev/snd/hwC0D0
>>     crw-rw----. 1 root audio 116, 11 Mar 20 18:15 /dev/snd/hwC1D0
>>     crw-rw----. 1 root audio 116, 12 Mar 20 18:15 /dev/snd/hwC1D1
>>     crw-rw----. 1 root audio 116, 13 Mar 20 18:15 /dev/snd/hwC1D2
>>     crw-rw----. 1 root audio 116, 14 Mar 20 18:15 /dev/snd/hwC1D3
>>     crw-rw----. 1 root audio 116, 17 Mar 20 21:25 /dev/snd/midiC2D0
>>     crw-rw----. 1 root audio 116, 3 Mar 20 19:58 /dev/snd/pcmC0D0c
>>     crw-rw----. 1 root audio 116, 2 Mar 20 20:40 /dev/snd/pcmC0D0p
>>     crw-rw----. 1 root audio 116, 4 Mar 20 19:58 /dev/snd/pcmC0D1p
>>     crw-rw----. 1 root audio 116, 7 Mar 20 19:58 /dev/snd/pcmC1D3p
>>     crw-rw----. 1 root audio 116, 8 Mar 20 19:58 /dev/snd/pcmC1D7p
>>     crw-rw----. 1 root audio 116, 9 Mar 20 19:58 /dev/snd/pcmC1D8p
>>     crw-rw----. 1 root audio 116, 10 Mar 20 19:58 /dev/snd/pcmC1D9p
>>     crw-rw----. 1 root audio 116, 16 Mar 20 21:32 /dev/snd/pcmC2D0p
>>     crw-rw----. 1 root audio 116, 1 Mar 20 17:19 /dev/snd/seq
>>     crw-rw----. 1 root audio 116, 33 Mar 20 18:15 /dev/snd/timer
>>    
>>     /dev/snd/by-id:
>>     total 0
>>     drwxr-xr-x. 2 root root 60 Mar 20 21:25 .
>>     drwxr-xr-x. 4 root root 460 Mar 20 21:25 ..
>>     lrwxrwxrwx. 1 root root 12 Mar 20 21:25 usb-
>>     Guillemot_Corporation_Hercules_P32_DJ-00 -> ../controlC2
>>    
>>     /dev/snd/by-path:
>>     total 0
>>     drwxr-xr-x. 2 root root 100 Mar 20 21:25 .
>>     drwxr-xr-x. 4 root root 460 Mar 20 21:25 ..
>>     lrwxrwxrwx. 1 root root 12 Mar 20 18:15 pci-0000:00:1b.0 ->
>>     ../controlC0
>>     lrwxrwxrwx. 1 root root 12 Mar 20 21:25
>pci-0000:00:1d.0-usb-0:1.4:1.0
>>     -> ../controlC2
>>     lrwxrwxrwx. 1 root root 12 Mar 20 18:15 pci-0000:01:00.1 ->
>>     ../controlC1
>>    
>>     !!Aplay/Arecord output
>>     !!--------------------
>>    
>>     APLAY
>>    
>>     **** List of PLAYBACK Hardware Devices ****
>>     card 0: MID [HDA Intel MID], device 0: ALC269VB Analog [ALC269VB
>>     Analog]
>>     Subdevices: 1/1
>>     Subdevice #0: subdevice #0
>>     card 0: MID [HDA Intel MID], device 1: ALC269VB Digital [ALC269VB
>>     Digital]
>>     Subdevices: 1/1
>>     Subdevice #0: subdevice #0
>>     card 1: NVidia [HDA NVidia], device 3: Generic Digital [Generic
>>     Digital]
>>     Subdevices: 1/1
>>     Subdevice #0: subdevice #0
>>     card 1: NVidia [HDA NVidia], device 7: Generic Digital [Generic
>>     Digital]
>>     Subdevices: 1/1
>>     Subdevice #0: subdevice #0
>>     card 1: NVidia [HDA NVidia], device 8: Generic Digital [Generic
>>     Digital]
>>     Subdevices: 1/1
>>     Subdevice #0: subdevice #0
>>     card 1: NVidia [HDA NVidia], device 9: Generic Digital [Generic
>>     Digital]
>>     Subdevices: 1/1
>>     Subdevice #0: subdevice #0
>>     card 2: DJ [Hercules P32 DJ], device 0: USB Audio [USB Audio]
>>     Subdevices: 1/1
>>     Subdevice #0: subdevice #0
>>    
>>     ARECORD
>>    
>>     **** List of CAPTURE Hardware Devices ****
>>     card 0: MID [HDA Intel MID], device 0: ALC269VB Analog [ALC269VB
>>     Analog]
>>     Subdevices: 1/1
>>     Subdevice #0: subdevice #0
>>    
>>     !!Amixer output
>>     !!-------------
>>    
>>     !!-------Mixer controls for card 0 [MID]
>>    
>>     Card hw:0 'MID'/'HDA Intel MID at 0xb7100000 irq 27'
>>     Mixer name : 'Realtek ALC269VB'
>>     Components : 'HDA:10ec0269,1025035b,00100100'
>>     Controls : 31
>>     Simple ctrls : 14
>>     Simple mixer control 'Master',0
>>     Capabilities: pvolume pvolume-joined pswitch pswitch-joined
>>     Playback channels: Mono
>>     Limits: Playback 0 - 87
>>     Mono: Playback 81 [93%] [-4.50dB] [on]
>>     Simple mixer control 'Headphone',0
>>     Capabilities: pvolume pswitch
>>     Playback channels: Front Left - Front Right
>>     Limits: Playback 0 - 87
>>     Mono:
>>     Front Left: Playback 0 [0%] [-65.25dB] [off]
>>     Front Right: Playback 0 [0%] [-65.25dB] [off]
>>     Simple mixer control 'Speaker',0
>>     Capabilities: pvolume pswitch
>>     Playback channels: Front Left - Front Right
>>     Limits: Playback 0 - 87
>>     Mono:
>>     Front Left: Playback 87 [100%] [0.00dB] [on]
>>     Front Right: Playback 87 [100%] [0.00dB] [on]
>>     Simple mixer control 'PCM',0
>>     Capabilities: pvolume
>>     Playback channels: Front Left - Front Right
>>     Limits: Playback 0 - 255
>>     Mono:
>>     Front Left: Playback 128 [50%] [-25.40dB]
>>     Front Right: Playback 128 [50%] [-25.40dB]
>>     Simple mixer control 'Mic',0
>>     Capabilities: pvolume pswitch
>>     Playback channels: Front Left - Front Right
>>     Limits: Playback 0 - 31
>>     Mono:
>>     Front Left: Playback 0 [0%] [-34.50dB] [off]
>>     Front Right: Playback 0 [0%] [-34.50dB] [off]
>>     Sim
