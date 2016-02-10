From: Martin Kepplinger <martink@posteo.de>
Subject: Re: [BUG] [REGRESSION] [BISECTED] -rc1 breaks audio over HDMI for
 i915
Date: Wed, 10 Feb 2016 18:21:11 +0100
Message-ID: <56BB7187.1020108@posteo.de>
References: <56B98888.5000702@posteo.de> <s5h4mdixg4n.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070503000407080408050908"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h4mdixg4n.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: david.henningsson@canonical.com, han.lu@intel.com, libin.yang@intel.com, treding@nvidia.com, perex@perex.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070503000407080408050908
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

Am 2016-02-09 um 12:44 schrieb Takashi Iwai:
> On Tue, 09 Feb 2016 07:34:48 +0100,
> Martin Kepplinger wrote:
>>
>> The following change:
>>
>> 788d441 ALSA: hda - Use component ops for i915 HDMI/DP audio jack handling
>>
>> breaks audio over HDMI on my snd_hda_intel laptop. It is the first bad
>> commit.
>>
>> This was merged for -rc1 and isn't fixed until now, so I got nervous.
>> There are
>> no errors in the log that stand out. I'm no sound or alsa developer, and
>> just reverting it isn't easy since there is stuff depending on this.
>>
>> I'm happy to test possible fixes and hope v4.5 not to ship with such a big
>> regression ;)
> 
> Could you give a bit more detail about your hardware?  At best, give
> alsa-info.sh output (run with --no-upload option).  Also, give the
> output of dmesg, too.
> 
> In addition, what shows /proc/asound/card*/eld#*.* files?  Does any of
> it show the proper connection state and ELD?

alsa-info and dmesg are appended, and

root@laptop:/home/martin/dev# cat /proc/asound/card*/eld#*
monitor_present		0
eld_valid		0


> 
> A simple revert of the commit is a patch like below.  Does it make the
> HDMI audio working again?
> 

It does! Everything back to normal in this case. Any idea for a proper
fix? Again, I'm happy to test.

                        martin


> 
> thanks,
> 
> Takashi
> 
> ---
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -156,7 +156,7 @@ struct hdmi_spec {
>  	bool i915_bound; /* was i915 bound in this driver? */
>  };
>  
> -#ifdef CONFIG_SND_HDA_I915
> +#if 0
>  #define codec_has_acomp(codec) \
>  	((codec)->bus->core.audio_component != NULL)
>  #else
> 


--------------070503000407080408050908
Content-Type: text/plain; charset=UTF-8;
 name="alsa-info.txt.rQKXSZTTfT"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="alsa-info.txt.rQKXSZTTfT"

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.64
!!################################

!!Script ran on: Wed Feb 10 14:56:37 UTC 2016


!!Linux Distribution
!!------------------

Debian GNU/Linux 8 \n \l PRETTY_NAME="Debian GNU/Linux 8 (jessie)" NAME="Debian GNU/Linux" ID=debian HOME_URL="http://www.debian.org/" SUPPORT_URL="http://www.debian.org/support" BUG_REPORT_URL="https://bugs.debian.org/"


!!DMI Information
!!---------------

Manufacturer:      Acer
Product Name:      TravelMate B113
Product Version:   V1.09
Firmware Version:  V1.09


!!Kernel Information
!!------------------

Kernel release:    4.5.0-rc3
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         unknown
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     k4.5.0-rc3
Library version:    1.0.28
Utilities version:  1.0.28


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

 0 [PCH            ]: HDA-Intel - HDA Intel PCH
                      HDA Intel PCH at 0xc0610000 irq 29


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation 7 Series/C210 Series Chipset Family High Definition Audio Controller (rev 04)


!!Advanced information - PCI Vendor/Device/Subsystem ID's
!!-------------------------------------------------------

00:1b.0 0403: 8086:1e20 (rev 04)
	Subsystem: 1025:0748


!!Modprobe options (Sound related)
!!--------------------------------

snd_pcsp: index=-2
snd_usb_audio: index=-2
snd_atiixp_modem: index=-2
snd_intel8x0m: index=-2
snd_via82xx_modem: index=-2


!!Loaded sound module options
!!---------------------------

!!Module: snd_hda_intel
	align_buffer_size : -1
	bdl_pos_adj : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	beep_mode : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
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
	snoop : -1


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Realtek ALC271X
Address: 0
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x10ec0269
Subsystem Id: 0x10250748
Revision Id: 0x100100
No Modem Function Group found
Default PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
  Power states:  D0 D1 D2 D3 CLKSTOP EPSS
  Power: setting=D0, actual=D0
GPIO: io=2, o=0, i=0, unsolicited=1, wake=0
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Node 0x02 [Audio Output] wcaps 0x1d: Stereo Amp-Out
  Control: name="Headphone Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Device: name="ALC271X Analog", type="Audio", device=0
  Amp-Out caps: ofs=0x57, nsteps=0x57, stepsize=0x02, mute=0
  Amp-Out vals:  [0x00 0x00]
  Converter: stream=5, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x03 [Audio Output] wcaps 0x1d: Stereo Amp-Out
  Control: name="Speaker Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x57, nsteps=0x57, stepsize=0x02, mute=0
  Amp-Out vals:  [0x00 0x00]
  Converter: stream=5, channel=0
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
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x08 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Control: name="Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Capture Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Device: name="ALC271X Analog", type="Audio", device=0
  Amp-In caps: ofs=0x0b, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x1c 0x1c]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Connection: 1
     0x23
Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Amp-In caps: ofs=0x0b, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x8b 0x8b]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Connection: 1
     0x22
Node 0x0a [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Control: name="Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=3, ofs=0
  Control: name="Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=3, ofs=0
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
  Amp-In vals:  [0x00] [0x80]
  Connection: 2
     0x02 0x0b
Node 0x10 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x12 [Pin Complex] wcaps 0x40000b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000020: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Control: name="Speaker Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00010014: OUT EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x90170110: [Fixed] Speaker at Int N/A
    Conn = Analog, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Connection: 2
     0x0c 0x0d*
Node 0x15 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x16 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x17 [Pin Complex] wcaps 0x40010c: Mono Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80]
  Pincap 0x00000010: OUT
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Connection: 1
     0x0f
Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00001734: IN OUT Detect
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x0d
Node 0x19 [Pin Complex] wcaps 0x40008b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00001724: IN Detect
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=00, enabled=0
Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000003c: IN OUT HP Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
  Unsolicited: tag=00, enabled=0
  Connection: 2
     0x0c* 0x0d
Node 0x1b [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Control: name="Mic Boost Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00000034: IN OUT Detect
  Pin Default 0x90a70920: [Fixed] Mic at Int N/A
    Conn = Analog, Color = Unknown
    DefAssociation = 0x2, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
  Unsolicited: tag=00, enabled=0
  Connection: 2
     0x0c* 0x0d
Node 0x1c [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1d [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x00000020: IN
  Pin Default 0x40189b2d: [N/A] Speaker at Ext N/A
    Conn = DIN, Color = Pink
    DefAssociation = 0x2, Sequence = 0xd
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x1e [Pin Complex] wcaps 0x400381: Stereo Digital
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
  Processing caps: benign=0, ncoeff=25
Node 0x21 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000001c: OUT HP Detect
  Pin Default 0x0321101f: [Jack] HP Out at Ext Left
    Conn = 1/8, Color = Black
    DefAssociation = 0x1, Sequence = 0xf
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=01, enabled=1
  Connection: 2
     0x0c* 0x0d
Node 0x22 [Audio Selector] wcaps 0x30010b: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Connection: 7
     0x18* 0x19 0x1a 0x1b 0x1d 0x0b 0x12
Node 0x23 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x00 0x00] [0x80 0x80] [0x80 0x80]
  Connection: 6
     0x18 0x19 0x1a 0x1b 0x1d 0x0b
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
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x02
Node 0x06 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x80]
  Pincap 0x09000094: OUT Detect HBR HDMI DP
  Pin Default 0x58560020: [N/A] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x2, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x03
Node 0x07 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x80]
  Pincap 0x09000094: OUT Detect HBR HDMI DP
  Pin Default 0x58560030: [N/A] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x3, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x04
Node 0x08 [Vendor Defined Widget] wcaps 0xf00000: Mono
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116,  2 Feb  9 20:18 /dev/snd/controlC0
crw-rw----+ 1 root audio 116,  6 Feb  9 20:18 /dev/snd/hwC0D0
crw-rw----+ 1 root audio 116,  7 Feb  9 20:18 /dev/snd/hwC0D3
crw-rw----+ 1 root audio 116,  4 Feb  9 20:18 /dev/snd/pcmC0D0c
crw-rw----+ 1 root audio 116,  3 Feb 10 15:56 /dev/snd/pcmC0D0p
crw-rw----+ 1 root audio 116,  5 Feb  9 20:18 /dev/snd/pcmC0D3p
crw-rw----+ 1 root audio 116,  1 Feb  9 20:18 /dev/snd/seq
crw-rw----+ 1 root audio 116, 33 Feb  9 20:18 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  60 Feb  9 20:18 .
drwxr-xr-x 3 root root 220 Feb  9 20:18 ..
lrwxrwxrwx 1 root root  12 Feb  9 20:18 pci-0000:00:1b.0 -> ../controlC0


!!Aplay/Arecord output
!!--------------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: PCH [HDA Intel PCH], device 0: ALC271X Analog [ALC271X Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: PCH [HDA Intel PCH], device 0: ALC271X Analog [ALC271X Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [PCH]

Card hw:0 'PCH'/'HDA Intel PCH at 0xc0610000 irq 29'
  Mixer name	: 'Realtek ALC271X'
  Components	: 'HDA:10ec0269,10250748,00100100 HDA:80862806,80860101,00100000'
  Controls      : 29
  Simple ctrls  : 12
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 87
  Mono: Playback 0 [0%] [-65.25dB] [off]
Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 87
  Mono:
  Front Left: Playback 87 [100%] [0.00dB] [off]
  Front Right: Playback 87 [100%] [0.00dB] [off]
Simple mixer control 'Speaker',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 87
  Mono:
  Front Left: Playback 0 [0%] [-65.25dB] [off]
  Front Right: Playback 0 [0%] [-65.25dB] [off]
Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 0 [0%] [-51.00dB]
  Front Right: Playback 0 [0%] [-51.00dB]
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
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
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
  Limits: Capture 0 - 31
  Front Left: Capture 28 [90%] [25.50dB] [on]
  Front Right: Capture 28 [90%] [25.50dB] [on]
Simple mixer control 'Auto-Mute Mode',0
  Capabilities: enum
  Items: 'Disabled' 'Enabled'
  Item0: 'Enabled'
Simple mixer control 'Digital',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 120
  Front Left: Capture 60 [50%] [0.00dB]
  Front Right: Capture 60 [50%] [0.00dB]
Simple mixer control 'Loopback Mixing',0
  Capabilities: enum
  Items: 'Disabled' 'Enabled'
  Item0: 'Enabled'


!!Alsactl output
!!--------------

--startcollapse--
state.PCH {
	control.1 {
		iface MIXER
		name 'Headphone Playback Volume'
		value.0 87
		value.1 87
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 87'
			dbmin -6525
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.2 {
		iface MIXER
		name 'Headphone Playback Switch'
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.3 {
		iface MIXER
		name 'Speaker Playback Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 87'
			dbmin -6525
			dbmax 0
			dbvalue.0 -6525
			dbvalue.1 -6525
		}
	}
	control.4 {
		iface MIXER
		name 'Speaker Playback Switch'
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
		name 'Loopback Mixing'
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
	control.7 {
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
	control.8 {
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
	control.9 {
		iface MIXER
		name 'Capture Volume'
		value.0 28
		value.1 28
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -1650
			dbmax 3000
			dbvalue.0 2550
			dbvalue.1 2550
		}
	}
	control.10 {
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
	control.11 {
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
			dbmax 3600
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.12 {
		iface MIXER
		name 'Master Playback Volume'
		value 0
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 87'
			dbmin -6525
			dbmax 0
			dbvalue.0 -6525
		}
	}
	control.13 {
		iface MIXER
		name 'Master Playback Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.14 {
		iface CARD
		name 'Mic Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.15 {
		iface CARD
		name 'Headphone Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.16 {
		iface CARD
		name 'Speaker Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.17 {
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
	control.18 {
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
	control.19 {
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
	control.20 {
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
	control.21 {
		iface CARD
		name 'HDMI/DP,pcm=3 Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
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
	control.27 {
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
	control.28 {
		iface MIXER
		name 'PCM Playback Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write user'
			type INTEGER
			count 2
			range '0 - 255'
			tlv '0000000100000008ffffec1400000014'
			dbmin -5100
			dbmax 0
			dbvalue.0 -5100
			dbvalue.1 -5100
		}
	}
	control.29 {
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
--endcollapse--


!!All Loaded Modules
!!------------------

Module
hid_cherry
hid_generic
usbhid
hid
usb_storage
ctr
ccm
sha256_ssse3
sha256_generic
hmac
drbg
ansi_cprng
cbc
ecb
binfmt_misc
bnep
nfsd
auth_rpcgss
oid_registry
nfs_acl
nfs
lockd
grace
fscache
sunrpc
joydev
uvcvideo
videobuf2_vmalloc
videobuf2_memops
videobuf2_v4l2
videobuf2_core
videodev
media
btusb
btrtl
btbcm
btintel
iTCO_wdt
bluetooth
iTCO_vendor_support
acer_wmi
sparse_keymap
intel_rapl
x86_pkg_temp_thermal
intel_powerclamp
coretemp
kvm_intel
snd_hda_codec_hdmi
kvm
irqbypass
crct10dif_pclmul
crc32_pclmul
snd_hda_codec_realtek
snd_hda_codec_generic
ghash_clmulni_intel
cryptd
evdev
psmouse
serio_raw
pcspkr
arc4
snd_hda_intel
iwldvm
i915
mac80211
drm_kms_helper
snd_hda_codec
iwlwifi
drm
snd_hda_core
snd_hwdep
i2c_i801
i2c_algo_bit
snd_pcm
cfg80211
mei_me
snd_timer
snd
lpc_ich
rfkill
soundcore
i2c_core
mei
mfd_core
shpchp
ac
battery
video
wmi
button
tpm_tis
tpm
fuse
ecryptfs
parport_pc
ppdev
lp
parport
autofs4
ext4
crc16
mbcache
jbd2
dm_mod
sg
sd_mod
crc32c_intel
ahci
libahci
libata
tg3
scsi_mod
ptp
xhci_pci
sdhci_pci
ehci_pci
sdhci
pps_core
xhci_hcd
ehci_hcd
libphy
mmc_core
usbcore
usb_common


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x12 0x411111f0
0x14 0x90170110
0x17 0x411111f0
0x18 0x411111f0
0x19 0x411111f0
0x1a 0x411111f0
0x1b 0x90a70920
0x1d 0x40189b2d
0x1e 0x411111f0
0x21 0x0321101f

/sys/class/sound/hwC0D0/driver_pin_configs:

/sys/class/sound/hwC0D0/user_pin_configs:

/sys/class/sound/hwC0D0/init_verbs:

/sys/class/sound/hwC0D0/hints:

/sys/class/sound/hwC0D3/init_pin_configs:
0x05 0x18560010
0x06 0x58560020
0x07 0x58560030

/sys/class/sound/hwC0D3/driver_pin_configs:

/sys/class/sound/hwC0D3/user_pin_configs:

/sys/class/sound/hwC0D3/init_verbs:

/sys/class/sound/hwC0D3/hints:


!!ALSA/HDA dmesg
!!--------------

[    2.285432] usb 1-1.3: Manufacturer: SuYin
[    2.294256] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC271X: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[    2.294279] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    2.294296] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
[    2.294311] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[    2.294321] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    2.294332] snd_hda_codec_realtek hdaudioC0D0:      Mic=0x1b
[    2.338580] Adding 4789244k swap on /dev/sda5.  Priority:-1 extents:1 across:4789244k SSFS
--
[    2.409123] usbcore: registered new interface driver btusb
[    2.413436] snd_hda_intel 0000:00:1b.0: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
[    2.414373] fbcon: inteldrmfb (fb0) is primary device
[    2.417721] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/sound/card0/input9
[    2.422023] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input10
[    2.422193] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1b.0/sound/card0/input13
[    2.442221] media: Linux media interface: v0.10



--------------070503000407080408050908
Content-Type: text/plain; charset=UTF-8;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg.txt"

[    0.000000] Linux version 4.5.0-rc3 (martin@laptop) (gcc version 4.9.2 (Debian 4.9.2-10) ) #37 SMP Mon Feb 8 15:35:01 CET 2016
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.5.0-rc3 root=UUID=bc17d7c1-da00-453d-bb7c-d956af38c74d ro nosplash
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Supporting XSAVE feature 0x01: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x02: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x04: 'AVX registers'
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] x86/fpu: Using 'eager' FPU context switches.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009d7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009d800-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000020000000-0x00000000201fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000020200000-0x000000003fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000040000000-0x00000000401fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000040200000-0x00000000a6abefff] usable
[    0.000000] BIOS-e820: [mem 0x00000000a6abf000-0x00000000a6ebefff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000a6ebf000-0x00000000a6fbefff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000a6fbf000-0x00000000a6ffefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000a6fff000-0x00000000a6ffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000a7000000-0x00000000af9fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feb00000-0x00000000feb03fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed10000-0x00000000fed19fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffc80000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000024f5fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: Acer TravelMate B113/BA10_HX           , BIOS V1.09 10/30/2012
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x24f600 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-E7FFF write-protect
[    0.000000]   E8000-EFFFF write-combining
[    0.000000]   F0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask F80000000 write-back
[    0.000000]   1 base 080000000 mask FC0000000 write-back
[    0.000000]   2 base 0A7000000 mask FFF000000 uncachable
[    0.000000]   3 base 0A8000000 mask FF8000000 uncachable
[    0.000000]   4 base 0B0000000 mask FF0000000 uncachable
[    0.000000]   5 base 0FFC00000 mask FFFC00000 write-protect
[    0.000000]   6 base 100000000 mask F00000000 write-back
[    0.000000]   7 base 200000000 mask FC0000000 write-back
[    0.000000]   8 base 240000000 mask FF0000000 write-back
[    0.000000]   9 base 24F600000 mask FFFE00000 uncachable
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT  
[    0.000000] e820: last_pfn = 0xa7000 max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000fe1b0-0x000fe1bf] mapped at [ffff8800000fe1b0]
[    0.000000] Base memory trampoline at [ffff880000097000] 97000 size 24576
[    0.000000] reserving inaccessible SNB gfx pages
[    0.000000] BRK [0x01b5d000, 0x01b5dfff] PGTABLE
[    0.000000] BRK [0x01b5e000, 0x01b5efff] PGTABLE
[    0.000000] BRK [0x01b5f000, 0x01b5ffff] PGTABLE
[    0.000000] BRK [0x01b60000, 0x01b60fff] PGTABLE
[    0.000000] BRK [0x01b61000, 0x01b61fff] PGTABLE
[    0.000000] BRK [0x01b62000, 0x01b62fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x360e2000-0x37068fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000FE020 000024 (v02 ACRSYS)
[    0.000000] ACPI: XSDT 0x00000000A6FFE210 00008C (v01 ACRSYS ACRPRDCT 00000001      01000013)
[    0.000000] ACPI: FACP 0x00000000A6FFB000 0000F4 (v04 ACRSYS ACRPRDCT 00000001 1025 00040000)
[    0.000000] ACPI: DSDT 0x00000000A6FEC000 00B903 (v01 ACRSYS ACRPRDCT 00000000 1025 00040000)
[    0.000000] ACPI: FACS 0x00000000A6FBB000 000040
[    0.000000] ACPI: FACS 0x00000000A6FBB000 000040
[    0.000000] ACPI: UEFI 0x00000000A6FFD000 000236 (v01 ACRSYS ACRPRDCT 00000001 1025 00040000)
[    0.000000] ACPI: ASF! 0x00000000A6FFC000 0000A5 (v32 ACRSYS ACRPRDCT 00000001 1025 00040000)
[    0.000000] ACPI: HPET 0x00000000A6FFA000 000038 (v01 ACRSYS ACRPRDCT 00000001 1025 00040000)
[    0.000000] ACPI: APIC 0x00000000A6FF9000 00008C (v02 ACRSYS ACRPRDCT 00000001 1025 00040000)
[    0.000000] ACPI: MCFG 0x00000000A6FF8000 00003C (v01 ACRSYS ACRPRDCT 00000001 1025 00040000)
[    0.000000] ACPI: SLIC 0x00000000A6FEB000 000176 (v01 ACRSYS ACRPRDCT 00000001 1025 00040000)
[    0.000000] ACPI: SSDT 0x00000000A6FEA000 0006FE (v01 ACRSYS ACRPRDCT 00001000 1025 00040000)
[    0.000000] ACPI: BOOT 0x00000000A6FE8000 000028 (v01 ACRSYS ACRPRDCT 00000001 1025 00040000)
[    0.000000] ACPI: ASPT 0x00000000A6FE3000 000034 (v07 ACRSYS ACRPRDCT 00000001 1025 00040000)
[    0.000000] ACPI: FPDT 0x00000000A6FE1000 000044 (v01 ACRSYS ACRPRDCT 00000001 1025 00040000)
[    0.000000] ACPI: SSDT 0x00000000A6FE0000 00079A (v01 ACRSYS ACRPRDCT 00003000 1025 00040000)
[    0.000000] ACPI: SSDT 0x00000000A6FDF000 000A92 (v01 ACRSYS ACRPRDCT 00003000 1025 00040000)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000024f5fffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x24f5f5000-0x24f5f8fff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000024f5fffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009cfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000001fffffff]
[    0.000000]   node   0: [mem 0x0000000020200000-0x000000003fffffff]
[    0.000000]   node   0: [mem 0x0000000040200000-0x00000000a6abefff]
[    0.000000]   node   0: [mem 0x00000000a6fff000-0x00000000a6ffffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000024f5fffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000024f5fffff]
[    0.000000] On node 0 totalpages: 2055260
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 156 pages reserved
[    0.000000]   DMA zone: 3996 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 10587 pages used for memmap
[    0.000000]   DMA32 zone: 677568 pages, LIFO batch:31
[    0.000000]   Normal zone: 21464 pages used for memmap
[    0.000000]   Normal zone: 1373696 pages, LIFO batch:31
[    0.000000] Reserving Intel graphics stolen memory at 0xa7a00000-0xaf9fffff
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 8 CPUs, 4 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009d000-0x0009dfff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x20000000-0x201fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x40000000-0x401fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xa6abf000-0xa6ebefff]
[    0.000000] PM: Registered nosave memory: [mem 0xa6ebf000-0xa6fbefff]
[    0.000000] PM: Registered nosave memory: [mem 0xa6fbf000-0xa6ffefff]
[    0.000000] PM: Registered nosave memory: [mem 0xa7000000-0xaf9fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xafa00000-0xdfffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xe0000000-0xefffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf0000000-0xfeafffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfeb00000-0xfeb03fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfeb04000-0xfebfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec01000-0xfed0ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed10000-0xfed19fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed1a000-0xfed1bfff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed20000-0xfedfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xffc7ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xffc80000-0xffffffff]
[    0.000000] e820: [mem 0xafa00000-0xdfffffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:8 nr_node_ids:1
[    0.000000] PERCPU: Embedded 33 pages/cpu @ffff88024f200000 s94888 r8192 d32088 u262144
[    0.000000] pcpu-alloc: s94888 r8192 d32088 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 2022989
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.5.0-rc3 root=UUID=bc17d7c1-da00-453d-bb7c-d956af38c74d ro nosplash
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 7996236K/8221040K available (5705K kernel code, 1187K rwdata, 2044K rodata, 1340K init, 880K bss, 224804K reserved, 0K cma-reserved)
[    0.000000] kmemleak: Kernel memory leak detector disabled
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=8.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=8
[    0.000000] NR_IRQS:33024 nr_irqs:488 16
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] kmemleak: Early log buffer exceeded (2566), please increase DEBUG_KMEMLEAK_EARLY_LOG_SIZE
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 1496.599 MHz processor
[    0.000054] Calibrating delay loop (skipped), value calculated using timer frequency.. 2993.19 BogoMIPS (lpj=5986396)
[    0.000186] pid_max: default: 32768 minimum: 301
[    0.000271] ACPI: Core revision 20160108
[    0.019694] ACPI: 4 ACPI AML tables successfully acquired and loaded

[    0.019767] Security Framework initialized
[    0.019843] Yama: becoming mindful.
[    0.019913] AppArmor: AppArmor disabled by boot time parameter
[    0.020818] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.023520] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.024751] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.024839] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.025331] CPU: Physical Processor ID: 0
[    0.025395] CPU: Processor Core ID: 0
[    0.025461] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.025528] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.025598] mce: CPU supports 7 MCE banks
[    0.025677] CPU0: Thermal monitoring enabled (TM1)
[    0.025749] process: using mwait in idle threads
[    0.025816] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
[    0.025882] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.026526] Freeing SMP alternatives memory: 24K (ffffffff81a79000 - ffffffff81a7f000)
[    0.050442] ftrace: allocating 24039 entries in 94 pages
[    0.067725] x2apic: IRQ remapping doesn't support X2APIC mode
[    0.068280] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.108034] TSC deadline timer enabled
[    0.108039] smpboot: CPU0: Intel(R) Core(TM) i3-2377M CPU @ 1.50GHz (family: 0x6, model: 0x2a, stepping: 0x7)
[    0.108285] Performance Events: PEBS fmt1+, 16-deep LBR, SandyBridge events, full-width counters, Intel PMU driver.
[    0.108604] ... version:                3
[    0.108667] ... bit width:              48
[    0.108729] ... generic registers:      4
[    0.108792] ... value mask:             0000ffffffffffff
[    0.108856] ... max period:             0000ffffffffffff
[    0.108921] ... fixed-purpose events:   3
[    0.108983] ... event mask:             000000070000000f
[    0.109877] x86: Booting SMP configuration:
[    0.109940] .... node  #0, CPUs:      #1
[    0.112730] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.113021]  #2 #3
[    0.118222] x86: Booted up 1 node, 4 CPUs
[    0.118290] smpboot: Total of 4 processors activated (11972.79 BogoMIPS)
[    0.123113] devtmpfs: initialized
[    0.129331] PM: Registering ACPI NVS region [mem 0xa6ebf000-0xa6fbefff] (1048576 bytes)
[    0.129591] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.129779] pinctrl core: initialized pinctrl subsystem
[    0.130079] NET: Registered protocol family 16
[    0.138859] cpuidle: using governor ladder
[    0.150859] cpuidle: using governor menu
[    0.150985] Simple Boot Flag at 0x44 set to 0x1
[    0.151111] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.151195] ACPI: bus type PCI registered
[    0.151258] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.151475] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.151564] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    0.151649] PCI: Using configuration type 1 for base access
[    0.152187] perf_event_intel: PMU erratum BJ122, BV98, HSD29 worked around, HT is on
[    0.163075] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.163562] ACPI: Added _OSI(Module Device)
[    0.163626] ACPI: Added _OSI(Processor Device)
[    0.163689] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.163752] ACPI: Added _OSI(Processor Aggregator Device)
[    0.166497] ACPI: Executed 1 blocks of module-level executable AML code
[    0.173591] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.174598] ACPI: Dynamic OEM Table Load:
[    0.174615] ACPI: SSDT 0xFFFF8802468A7000 00083B (v01 PmRef  Cpu0Cst  00003001 INTL 20100121)
[    0.175854] ACPI: Dynamic OEM Table Load:
[    0.175866] ACPI: SSDT 0xFFFF88024559A800 000303 (v01 PmRef  ApIst    00003000 INTL 20100121)
[    0.176880] ACPI: Dynamic OEM Table Load:
[    0.176891] ACPI: SSDT 0xFFFF880245564400 000119 (v01 PmRef  ApCst    00003000 INTL 20100121)
[    0.178916] ACPI : EC: EC started
[    0.179178] ACPI: Interpreter enabled
[    0.179272] ACPI: (supports S0 S3 S4 S5)
[    0.180123] ACPI: Using IOAPIC for interrupt routing
[    0.180239] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.336095] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    0.336171] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.336577] \_SB_.PCI0 (33DB4D5B-1FF7-401C-9657-7441C03DD766): _OSC invalid UUID
[    0.336580] _OSC request data: 1 1f 0
[    0.336586] acpi PNP0A08:00: _OSC failed (AE_ERROR); disabling ASPM
[    0.337819] PCI host bridge to bus 0000:00
[    0.337884] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.337954] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.338022] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.338105] pci_bus 0000:00: root bus resource [mem 0xafa00000-0xfeafffff window]
[    0.338189] pci_bus 0000:00: root bus resource [bus 00-fe]
[    0.338264] pci 0000:00:00.0: [8086:0104] type 00 class 0x060000
[    0.338441] pci 0000:00:02.0: [8086:0116] type 00 class 0x030000
[    0.338456] pci 0000:00:02.0: reg 0x10: [mem 0xc0000000-0xc03fffff 64bit]
[    0.338465] pci 0000:00:02.0: reg 0x18: [mem 0xb0000000-0xbfffffff 64bit pref]
[    0.338472] pci 0000:00:02.0: reg 0x20: [io  0x2000-0x203f]
[    0.338686] pci 0000:00:14.0: [8086:1e31] type 00 class 0x0c0330
[    0.338722] pci 0000:00:14.0: reg 0x10: [mem 0xc0600000-0xc060ffff 64bit]
[    0.338848] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.338944] pci 0000:00:14.0: System wakeup disabled by ACPI
[    0.339097] pci 0000:00:16.0: [8086:1e3a] type 00 class 0x078000
[    0.339133] pci 0000:00:16.0: reg 0x10: [mem 0xc0614000-0xc061400f 64bit]
[    0.339262] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.339436] pci 0000:00:1a.0: [8086:1e2d] type 00 class 0x0c0320
[    0.339765] pci 0000:00:1a.0: reg 0x10: [mem 0xc0619000-0xc06193ff]
[    0.341635] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.341763] pci 0000:00:1a.0: System wakeup disabled by ACPI
[    0.341916] pci 0000:00:1b.0: [8086:1e20] type 00 class 0x040300
[    0.341948] pci 0000:00:1b.0: reg 0x10: [mem 0xc0610000-0xc0613fff 64bit]
[    0.342091] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.342191] pci 0000:00:1b.0: System wakeup disabled by ACPI
[    0.342337] pci 0000:00:1c.0: [8086:1e10] type 01 class 0x060400
[    0.342483] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.342587] pci 0000:00:1c.0: System wakeup disabled by ACPI
[    0.342733] pci 0000:00:1c.1: [8086:1e12] type 01 class 0x060400
[    0.342879] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.342980] pci 0000:00:1c.1: System wakeup disabled by ACPI
[    0.343135] pci 0000:00:1c.2: [8086:1e14] type 01 class 0x060400
[    0.343280] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.343382] pci 0000:00:1c.2: System wakeup disabled by ACPI
[    0.343540] pci 0000:00:1d.0: [8086:1e26] type 00 class 0x0c0320
[    0.343860] pci 0000:00:1d.0: reg 0x10: [mem 0xc0618000-0xc06183ff]
[    0.345734] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.345859] pci 0000:00:1d.0: System wakeup disabled by ACPI
[    0.346006] pci 0000:00:1f.0: [8086:1e57] type 00 class 0x060100
[    0.346319] pci 0000:00:1f.2: [8086:1e03] type 00 class 0x010601
[    0.346351] pci 0000:00:1f.2: reg 0x10: [io  0x2088-0x208f]
[    0.346366] pci 0000:00:1f.2: reg 0x14: [io  0x2094-0x2097]
[    0.346382] pci 0000:00:1f.2: reg 0x18: [io  0x2080-0x2087]
[    0.346398] pci 0000:00:1f.2: reg 0x1c: [io  0x2090-0x2093]
[    0.346414] pci 0000:00:1f.2: reg 0x20: [io  0x2060-0x207f]
[    0.346430] pci 0000:00:1f.2: reg 0x24: [mem 0xc0617000-0xc06177ff]
[    0.346521] pci 0000:00:1f.2: PME# supported from D3hot
[    0.346684] pci 0000:00:1f.3: [8086:1e22] type 00 class 0x0c0500
[    0.346713] pci 0000:00:1f.3: reg 0x10: [mem 0xc0615000-0xc06150ff 64bit]
[    0.346755] pci 0000:00:1f.3: reg 0x20: [io  0x2040-0x205f]
[    0.347049] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.347432] pci 0000:03:00.0: [8086:088e] type 00 class 0x028000
[    0.347661] pci 0000:03:00.0: reg 0x10: [mem 0xc0500000-0xc0501fff 64bit]
[    0.348965] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    0.349201] pci 0000:03:00.0: System wakeup disabled by ACPI
[    0.355268] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.355342] pci 0000:00:1c.1:   bridge window [mem 0xc0500000-0xc05fffff]
[    0.355539] pci 0000:04:00.0: [14e4:16b5] type 00 class 0x020000
[    0.355585] pci 0000:04:00.0: reg 0x10: [mem 0xc0410000-0xc041ffff 64bit pref]
[    0.355617] pci 0000:04:00.0: reg 0x18: [mem 0xc0420000-0xc042ffff 64bit pref]
[    0.355675] pci 0000:04:00.0: reg 0x30: [mem 0xfffff800-0xffffffff pref]
[    0.355867] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
[    0.355949] pci 0000:04:00.0: System wakeup disabled by ACPI
[    0.356144] pci 0000:04:00.1: [14e4:16bc] type 00 class 0x080501
[    0.356189] pci 0000:04:00.1: reg 0x10: [mem 0xc0400000-0xc040ffff 64bit pref]
[    0.356414] pci 0000:04:00.1: PME# supported from D0 D3hot D3cold
[    0.363254] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.363336] pci 0000:00:1c.2:   bridge window [mem 0xc0400000-0xc04fffff 64bit pref]
[    0.435845] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 10 11 12 14 15) *7
[    0.436581] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 10 *11 12 14 15)
[    0.437256] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 10 *11 12 14 15)
[    0.437928] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 *10 11 12 14 15)
[    0.438602] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.439380] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 *10 11 12 14 15)
[    0.440053] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 *10 11 12 14 15)
[    0.440728] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 10 11 12 14 15) *7
[    0.441476] ACPI: Enabled 6 GPEs in block 00 to 3F
[    0.441542] ACPI : EC: GPE = 0x17, I/O: command/status = 0x66, data = 0x62
[    0.441766] vgaarb: setting as boot device: PCI:0000:00:02.0
[    0.441833] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.441919] vgaarb: loaded
[    0.441980] vgaarb: bridge control possible 0000:00:02.0
[    0.442203] PCI: Using ACPI for IRQ routing
[    0.450288] PCI: pci_cache_line_size set to 64 bytes
[    0.450487] e820: reserve RAM buffer [mem 0x0009d800-0x0009ffff]
[    0.450490] e820: reserve RAM buffer [mem 0xa6abf000-0xa7ffffff]
[    0.450493] e820: reserve RAM buffer [mem 0xa7000000-0xa7ffffff]
[    0.450495] e820: reserve RAM buffer [mem 0x24f600000-0x24fffffff]
[    0.450754] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.451189] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.453290] clocksource: Switched to clocksource hpet
[    0.464552] VFS: Disk quotas dquot_6.6.0
[    0.464660] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.464974] pnp: PnP ACPI init
[    0.465182] pnp 00:00: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.465370] pnp 00:01: Plug and Play ACPI device, IDs ETD0502 PNP0f13 (active)
[    0.465617] system 00:02: [io  0x0680-0x069f] has been reserved
[    0.465686] system 00:02: [io  0xfd60-0xfd63] has been reserved
[    0.465752] system 00:02: [io  0x1000-0x100f] has been reserved
[    0.465819] system 00:02: [io  0xffff] has been reserved
[    0.465885] system 00:02: [io  0xffff] has been reserved
[    0.465951] system 00:02: [io  0x0400-0x0453] could not be reserved
[    0.466018] system 00:02: [io  0x0458-0x047f] has been reserved
[    0.466085] system 00:02: [io  0x0500-0x057f] has been reserved
[    0.466152] system 00:02: [io  0x164e-0x164f] has been reserved
[    0.466222] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.466274] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.466381] system 00:04: [io  0x0454-0x0457] has been reserved
[    0.466451] system 00:04: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    0.537664] system 00:05: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.537735] system 00:05: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.537803] system 00:05: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.537871] system 00:05: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.537940] system 00:05: [mem 0xe0000000-0xefffffff] has been reserved
[    0.538008] system 00:05: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.538077] system 00:05: [mem 0xfed90000-0xfed93fff] has been reserved
[    0.538145] system 00:05: [mem 0xff000000-0xff000fff] has been reserved
[    0.538214] system 00:05: [mem 0xff010000-0xffffffff] could not be reserved
[    0.538284] system 00:05: [mem 0xfee00000-0xfeefffff] could not be reserved
[    0.538354] system 00:05: [mem 0xafa00000-0xafa00fff] has been reserved
[    0.538424] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.538948] system 00:06: [mem 0x20000000-0x201fffff] has been reserved
[    0.539016] system 00:06: [mem 0x40000000-0x401fffff] has been reserved
[    0.539085] system 00:06: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.539118] pnp: PnP ACPI: found 7 devices
[    0.546941] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.547034] pci 0000:04:00.0: can't claim BAR 6 [mem 0xfffff800-0xffffffff pref]: no compatible bridge window
[    0.547140] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 02] add_size 1000
[    0.547145] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 02] add_size 200000 add_align 100000
[    0.547148] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff] to [bus 02] add_size 200000 add_align 100000
[    0.547183] pci 0000:00:1c.0: res[14]=[mem 0x00100000-0x000fffff] res_to_dev_res add_size 200000 min_align 100000
[    0.547186] pci 0000:00:1c.0: res[14]=[mem 0x00100000-0x002fffff] res_to_dev_res add_size 200000 min_align 100000
[    0.547190] pci 0000:00:1c.0: res[15]=[mem 0x00100000-0x000fffff 64bit pref] res_to_dev_res add_size 200000 min_align 100000
[    0.547193] pci 0000:00:1c.0: res[15]=[mem 0x00100000-0x002fffff 64bit pref] res_to_dev_res add_size 200000 min_align 100000
[    0.547196] pci 0000:00:1c.0: res[13]=[io  0x1000-0x0fff] res_to_dev_res add_size 1000 min_align 1000
[    0.547199] pci 0000:00:1c.0: res[13]=[io  0x1000-0x1fff] res_to_dev_res add_size 1000 min_align 1000
[    0.547205] pci 0000:00:1c.0: BAR 14: assigned [mem 0xafb00000-0xafcfffff]
[    0.547279] pci 0000:00:1c.0: BAR 15: assigned [mem 0xafd00000-0xafefffff 64bit pref]
[    0.547364] pci 0000:00:1c.2: BAR 14: assigned [mem 0xaff00000-0xafffffff]
[    0.547434] pci 0000:00:1c.0: BAR 13: assigned [io  0x3000-0x3fff]
[    0.547503] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.547570] pci 0000:00:1c.0:   bridge window [io  0x3000-0x3fff]
[    0.547643] pci 0000:00:1c.0:   bridge window [mem 0xafb00000-0xafcfffff]
[    0.547715] pci 0000:00:1c.0:   bridge window [mem 0xafd00000-0xafefffff 64bit pref]
[    0.547807] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.547880] pci 0000:00:1c.1:   bridge window [mem 0xc0500000-0xc05fffff]
[    0.547961] pci 0000:04:00.0: BAR 6: assigned [mem 0xaff00000-0xaff007ff pref]
[    0.548044] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.548115] pci 0000:00:1c.2:   bridge window [mem 0xaff00000-0xafffffff]
[    0.548189] pci 0000:00:1c.2:   bridge window [mem 0xc0400000-0xc04fffff 64bit pref]
[    0.548281] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.548284] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.548287] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.548289] pci_bus 0000:00: resource 7 [mem 0xafa00000-0xfeafffff window]
[    0.548292] pci_bus 0000:02: resource 0 [io  0x3000-0x3fff]
[    0.548295] pci_bus 0000:02: resource 1 [mem 0xafb00000-0xafcfffff]
[    0.548297] pci_bus 0000:02: resource 2 [mem 0xafd00000-0xafefffff 64bit pref]
[    0.548300] pci_bus 0000:03: resource 1 [mem 0xc0500000-0xc05fffff]
[    0.548303] pci_bus 0000:04: resource 1 [mem 0xaff00000-0xafffffff]
[    0.548305] pci_bus 0000:04: resource 2 [mem 0xc0400000-0xc04fffff 64bit pref]
[    0.548382] NET: Registered protocol family 2
[    0.548737] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
[    0.549164] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
[    0.549904] TCP: Hash tables configured (established 65536 bind 65536)
[    0.550048] UDP hash table entries: 4096 (order: 6, 393216 bytes)
[    0.550273] UDP-Lite hash table entries: 4096 (order: 6, 393216 bytes)
[    0.550620] NET: Registered protocol family 1
[    0.550709] pci 0000:00:02.0: Video device with shadowed ROM
[    0.581421] PCI: CLS 64 bytes, default 64
[    0.581504] Unpacking initramfs...
[    1.059240] Freeing initrd memory: 15900K (ffff8800360e2000 - ffff880037069000)
[    1.059353] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.059424] software IO TLB [mem 0xa2abf000-0xa6abf000] (64MB) mapped at [ffff8800a2abf000-ffff8800a6abefff]
[    1.059594] RAPL PMU detected, API unit is 2^-32 Joules, 3 fixed counters 163840 ms ovfl timer
[    1.059679] hw unit of domain pp0-core 2^-16 Joules
[    1.059743] hw unit of domain package 2^-16 Joules
[    1.059807] hw unit of domain pp1-gpu 2^-16 Joules
[    1.060576] futex hash table entries: 2048 (order: 5, 131072 bytes)
[    1.060727] audit: initializing netlink subsys (disabled)
[    1.060820] audit: type=2000 audit(1455045484.036:1): initialized
[    1.061598] zbud: loaded
[    1.062532] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    1.062667] io scheduler noop registered
[    1.062734] io scheduler deadline registered
[    1.062809] io scheduler cfq registered (default)
[    1.063662] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    1.063741] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    1.063843] intel_idle: MWAIT substates: 0x21120
[    1.063846] intel_idle: v0.4 model 0x2A
[    1.063847] intel_idle: lapic_timer_reliable_states 0xffffffff
[    1.064637] GHES: HEST is not enabled!
[    1.064825] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.065838] Linux agpgart interface v0.103
[    1.066024] AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    1.066092] AMD IOMMUv2 functionality not available on this system
[    1.066237] Failed to find cpu0 device node
[    1.066301] Unable to detect cache hierarchy from DT for CPU 0
[    1.066467] i8042: PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
[    1.079519] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.079592] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.080045] mousedev: PS/2 mouse device common for all mice
[    1.080181] rtc_cmos 00:03: RTC can wake from S4
[    1.080484] rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
[    1.080584] rtc_cmos 00:03: alarms up to one month, 242 bytes nvram, hpet irqs
[    1.080691] Intel P-state driver initializing.
[    1.081120] ledtrig-cpu: registered to indicate activity on CPUs
[    1.082808] NET: Registered protocol family 10
[    1.083641] mip6: Mobile IPv6
[    1.083735] NET: Registered protocol family 17
[    1.083836] mpls_gso: MPLS GSO support
[    1.084574] microcode: CPU0 sig=0x206a7, pf=0x10, revision=0x28
[    1.084681] microcode: CPU1 sig=0x206a7, pf=0x10, revision=0x28
[    1.084793] microcode: CPU2 sig=0x206a7, pf=0x10, revision=0x28
[    1.084901] microcode: CPU3 sig=0x206a7, pf=0x10, revision=0x28
[    1.085101] microcode: Microcode Update Driver: v2.01 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    1.085596] registered taskstats version 1
[    1.085694] zswap: loaded using pool lzo/zbud
[    1.086504] rtc_cmos 00:03: setting system clock to 2016-02-09 19:18:04 UTC (1455045484)
[    1.086750] PM: Hibernation image not present or could not be loaded.
[    1.088019] Freeing unused kernel memory: 1340K (ffffffff8192a000 - ffffffff81a79000)
[    1.088105] Write protecting the kernel read-only data: 8192k
[    1.088517] Freeing unused kernel memory: 428K (ffff880001595000 - ffff880001600000)
[    1.088683] Freeing unused kernel memory: 4K (ffff8800017ff000 - ffff880001800000)
[    1.098436] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    1.146204] systemd-udevd[77]: starting version 215
[    1.146675] random: systemd-udevd urandom read with 2 bits of entropy available
[    1.175024] ACPI: bus type USB registered
[    1.175183] usbcore: registered new interface driver usbfs
[    1.175300] usbcore: registered new interface driver hub
[    1.175439] usbcore: registered new device driver usb
[    1.177974] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.178193] pps_core: LinuxPPS API ver. 1 registered
[    1.178263] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    1.179348] ehci-pci: EHCI PCI platform driver
[    1.179422] sdhci: Secure Digital Host Controller Interface driver
[    1.179492] sdhci: Copyright(c) Pierre Ossman
[    1.179660] ehci-pci 0000:00:1a.0: EHCI Host Controller
[    1.179740] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 1
[    1.179842] ehci-pci 0000:00:1a.0: debug port 2
[    1.180131] sdhci-pci 0000:04:00.1: SDHCI controller found [14e4:16bc] (rev 10)
[    1.181666] PTP clock support registered
[    1.181841] mmc0: SDHCI controller on PCI [0000:04:00.1] using ADMA 64-bit
[    1.183828] ehci-pci 0000:00:1a.0: cache line size of 64 is not supported
[    1.183881] ehci-pci 0000:00:1a.0: irq 16, io mem 0xc0619000
[    1.184324] tg3.c:v3.137 (May 11, 2014)
[    1.184536] SCSI subsystem initialized
[    1.187792] libata version 3.00 loaded.
[    1.193322] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    1.193534] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.193655] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.193745] usb usb1: Product: EHCI Host Controller
[    1.193831] usb usb1: Manufacturer: Linux 4.5.0-rc3 ehci_hcd
[    1.193906] usb usb1: SerialNumber: 0000:00:1a.0
[    1.194421] hub 1-0:1.0: USB hub found
[    1.194495] hub 1-0:1.0: 2 ports detected
[    1.195264] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.195346] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    1.196534] xhci_hcd 0000:00:14.0: hcc params 0x20007181 hci version 0x100 quirks 0x0000b930
[    1.196629] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    1.196874] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    1.196946] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.197033] usb usb2: Product: xHCI Host Controller
[    1.197103] usb usb2: Manufacturer: Linux 4.5.0-rc3 xhci-hcd
[    1.197171] usb usb2: SerialNumber: 0000:00:14.0
[    1.197627] hub 2-0:1.0: USB hub found
[    1.197713] hub 2-0:1.0: 4 ports detected
[    1.199021] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.199096] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 3
[    1.199268] usb usb3: New USB device found, idVendor=1d6b, idProduct=0003
[    1.199347] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.199444] usb usb3: Product: xHCI Host Controller
[    1.199514] usb usb3: Manufacturer: Linux 4.5.0-rc3 xhci-hcd
[    1.199590] usb usb3: SerialNumber: 0000:00:14.0
[    1.201888] hub 3-0:1.0: USB hub found
[    1.202278] hub 3-0:1.0: 4 ports detected
[    1.207939] ahci 0000:00:1f.2: version 3.0
[    1.208308] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
[    1.208710] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x1 impl SATA mode
[    1.209113] ahci 0000:00:1f.2: flags: 64bit ncq stag pm led clo pio slum part ems apst 
[    1.211554] tg3 0000:04:00.0 eth0: Tigon3 [partno(BCM57785) rev 57785100] (PCI Express) MAC address b8:88:e3:a5:16:6f
[    1.211653] tg3 0000:04:00.0 eth0: attached PHY is 57765 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    1.211748] tg3 0000:04:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[    1.211839] tg3 0000:04:00.0 eth0: dma_rwctrl[00000001] dma_mask[64-bit]
[    1.214421] scsi host0: ahci
[    1.214801] scsi host1: ahci
[    1.215505] scsi host2: ahci
[    1.215993] scsi host3: ahci
[    1.216473] scsi host4: ahci
[    1.216864] scsi host5: ahci
[    1.217197] ata1: SATA max UDMA/133 abar m2048@0xc0617000 port 0xc0617100 irq 25
[    1.217306] ata2: DUMMY
[    1.217372] ata3: DUMMY
[    1.217434] ata4: DUMMY
[    1.217496] ata5: DUMMY
[    1.217555] ata6: DUMMY
[    1.217897] ehci-pci 0000:00:1d.0: EHCI Host Controller
[    1.217972] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 4
[    1.218073] ehci-pci 0000:00:1d.0: debug port 2
[    1.222034] ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
[    1.222064] ehci-pci 0000:00:1d.0: irq 23, io mem 0xc0618000
[    1.233319] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    1.233448] usb usb4: New USB device found, idVendor=1d6b, idProduct=0002
[    1.233519] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.233602] usb usb4: Product: EHCI Host Controller
[    1.233668] usb usb4: Manufacturer: Linux 4.5.0-rc3 ehci_hcd
[    1.233734] usb usb4: SerialNumber: 0000:00:1d.0
[    1.234040] hub 4-0:1.0: USB hub found
[    1.234115] hub 4-0:1.0: 2 ports detected
[    1.505402] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    1.509387] usb 2-4: new high-speed USB device number 2 using xhci_hcd
[    1.529268] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.541754] ata1.00: ATA-8: KINGSTON SV300S37A120G, 583ABBF0, max UDMA/133
[    1.541854] ata1.00: 234441648 sectors, multi 1: LBA48 NCQ (depth 31/32), AA
[    1.545398] usb 4-1: new high-speed USB device number 2 using ehci-pci
[    1.551424] ata1.00: configured for UDMA/133
[    1.552242] scsi 0:0:0:0: Direct-Access     ATA      KINGSTON SV300S3 BBF0 PQ: 0 ANSI: 5
[    1.579316] sd 0:0:0:0: [sda] 234441648 512-byte logical blocks: (120 GB/112 GiB)
[    1.579607] sd 0:0:0:0: [sda] Write Protect is off
[    1.579686] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.579741] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.580735]  sda: sda1 sda2 < sda5 >
[    1.581498] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.582429] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    1.623392] device-mapper: uevent: version 1.0.3
[    1.623603] device-mapper: ioctl: 4.34.0-ioctl (2015-10-28) initialised: dm-devel@redhat.com
[    1.633246] PM: Starting manual resume from disk
[    1.633393] PM: Hibernation image partition 8:5 present
[    1.633396] PM: Looking for hibernation image.
[    1.633726] PM: Image not found (code -22)
[    1.633730] PM: Hibernation image not present or could not be loaded.
[    1.637746] usb 1-1: New USB device found, idVendor=8087, idProduct=0024
[    1.637824] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.638548] hub 1-1:1.0: USB hub found
[    1.638627] usb 2-4: New USB device found, idVendor=18d1, idProduct=4ee1
[    1.638694] usb 2-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    1.638769] usb 2-4: Product: Nexus 5
[    1.638833] usb 2-4: Manufacturer: LGE
[    1.638895] usb 2-4: SerialNumber: 09d991040220b54d
[    1.639076] hub 1-1:1.0: 6 ports detected
[    1.672184] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    1.677656] usb 4-1: New USB device found, idVendor=8087, idProduct=0024
[    1.677726] usb 4-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.678242] hub 4-1:1.0: USB hub found
[    1.678421] hub 4-1:1.0: 8 ports detected
[    1.749555] systemd[1]: systemd 215 running in system mode. (+PAM +AUDIT +SELINUX +IMA +SYSVINIT +LIBCRYPTSETUP +GCRYPT +ACL +XZ -SECCOMP -APPARMOR)
[    1.749977] systemd[1]: Detected architecture 'x86-64'.
[    1.765436] systemd[1]: Inserted module 'autofs4'
[    1.765896] systemd[1]: Set hostname to <laptop>.
[    1.863735] systemd[1]: Starting Forward Password Requests to Wall Directory Watch.
[    1.863919] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    1.864023] systemd[1]: Starting Remote File Systems (Pre).
[    1.864456] systemd[1]: Reached target Remote File Systems (Pre).
[    1.864551] systemd[1]: Starting Dispatch Password Requests to Console Directory Watch.
[    1.864685] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    1.864797] systemd[1]: Starting Arbitrary Executable File Formats File System Automount Point.
[    1.865335] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    1.865442] systemd[1]: Expecting device dev-disk-by\x2duuid-b29a64d5\x2dc973\x2d4622\x2da96d\x2d0537683e6290.device...
[    1.865768] systemd[1]: Starting Root Slice.
[    1.866158] systemd[1]: Created slice Root Slice.
[    1.866238] systemd[1]: Starting User and Session Slice.
[    1.866660] systemd[1]: Created slice User and Session Slice.
[    1.866740] systemd[1]: Starting Delayed Shutdown Socket.
[    1.867147] systemd[1]: Listening on Delayed Shutdown Socket.
[    1.867228] systemd[1]: Starting /dev/initctl Compatibility Named Pipe.
[    1.867639] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[    1.867723] systemd[1]: Starting Journal Socket (/dev/log).
[    1.868131] systemd[1]: Listening on Journal Socket (/dev/log).
[    1.868212] systemd[1]: Starting Device-mapper event daemon FIFOs.
[    1.870242] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    1.870327] systemd[1]: Starting LVM2 metadata daemon socket.
[    1.871550] systemd[1]: Listening on LVM2 metadata daemon socket.
[    1.871637] systemd[1]: Starting udev Control Socket.
[    1.872030] systemd[1]: Listening on udev Control Socket.
[    1.872114] systemd[1]: Starting udev Kernel Socket.
[    1.872496] systemd[1]: Listening on udev Kernel Socket.
[    1.872581] systemd[1]: Starting Journal Socket.
[    1.872988] systemd[1]: Listening on Journal Socket.
[    1.873082] systemd[1]: Starting System Slice.
[    1.873521] systemd[1]: Created slice System Slice.
[    1.873610] systemd[1]: Started File System Check on Root Device.
[    1.873691] systemd[1]: Starting system-getty.slice.
[    1.874120] systemd[1]: Created slice system-getty.slice.
[    1.874220] systemd[1]: Starting Increase datagram queue length...
[    1.889851] systemd[1]: Mounting POSIX Message Queue File System...
[    1.891433] systemd[1]: Starting Create list of required static device nodes for the current kernel...
[    1.898933] systemd[1]: Starting Load Kernel Modules...
[    1.901025] systemd[1]: Starting udev Coldplug all Devices...
[    1.903029] systemd[1]: Mounting Debug File System...
[    1.906617] systemd[1]: Started Set Up Additional Binary Formats.
[    1.906744] systemd[1]: Mounting Huge Pages File System...
[    1.908240] systemd[1]: Starting Slices.
[    1.908693] systemd[1]: Reached target Slices.
[    1.910196] systemd[1]: Mounted Debug File System.
[    1.910698] systemd[1]: Mounted POSIX Message Queue File System.
[    1.912224] systemd[1]: Started Increase datagram queue length.
[    1.913564] systemd[1]: Started Create list of required static device nodes for the current kernel.
[    1.914816] systemd[1]: Mounted Huge Pages File System.
[    1.915186] lp: driver loaded but no devices found
[    1.917255] ppdev: user-space parallel port driver
[    1.917331] usb 1-1.1: new full-speed USB device number 3 using ehci-pci
[    1.924685] fuse init (API version 7.24)
[    1.927378] systemd[1]: Started Load Kernel Modules.
[    1.937982] systemd[1]: Started udev Coldplug all Devices.
[    1.943357] systemd[1]: Starting udev Wait for Complete Device Initialization...
[    1.953584] systemd[1]: Starting Apply Kernel Variables...
[    1.954781] systemd[1]: Mounted Configuration File System.
[    1.954923] systemd[1]: Mounting FUSE Control File System...
[    1.956077] systemd[1]: Starting Create Static Device Nodes in /dev...
[    1.957475] systemd[1]: Starting Syslog Socket.
[    1.958271] systemd[1]: Listening on Syslog Socket.
[    1.958407] systemd[1]: Starting Journal Service...
[    1.959924] systemd[1]: Started Journal Service.
[    1.983046] systemd-udevd[209]: starting version 215
[    2.014258] usb 1-1.1: New USB device found, idVendor=8087, idProduct=07da
[    2.014339] usb 1-1.1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.057315] tsc: Refined TSC clocksource calibration: 1496.600 MHz
[    2.057400] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x159296d3708, max_idle_ns: 440795218047 ns
[    2.085318] usb 1-1.3: new high-speed USB device number 4 using ehci-pci
[    2.096681] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:01/PNP0C0C:00/input/input2
[    2.096785] ACPI: Power Button [PWRB]
[    2.096992] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:01/PNP0C0D:00/input/input3
[    2.097169] ACPI: Lid Switch [LID0]
[    2.097714] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:01/PNP0C0E:00/input/input4
[    2.097809] ACPI: Sleep Button [SLPB]
[    2.098187] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input5
[    2.098278] ACPI: Power Button [PWRF]
[    2.116135] wmi: Mapper loaded
[    2.136932] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
[    2.160225] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    2.172369] ACPI Warning: SystemIO range 0x0000000000000428-0x000000000000042F conflicts with OpRegion 0x0000000000000400-0x000000000000047F (\PMIO) (20160108/utaddress-255)
[    2.172383] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[    2.172511] ACPI Warning: SystemIO range 0x0000000000000540-0x000000000000054F conflicts with OpRegion 0x0000000000000500-0x0000000000000563 (\GPIO) (20160108/utaddress-255)
[    2.172520] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[    2.172609] ACPI Warning: SystemIO range 0x0000000000000530-0x000000000000053F conflicts with OpRegion 0x0000000000000500-0x0000000000000563 (\GPIO) (20160108/utaddress-255)
[    2.172618] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[    2.173183] ACPI Warning: SystemIO range 0x0000000000000500-0x000000000000052F conflicts with OpRegion 0x0000000000000500-0x0000000000000563 (\GPIO) (20160108/utaddress-255)
[    2.173196] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[    2.173321] lpc_ich: Resource conflict(s) found affecting gpio_ich
[    2.182345] ACPI Warning: SystemIO range 0x0000000000002040-0x000000000000205F conflicts with OpRegion 0x0000000000002040-0x000000000000204F (\_SB.PCI0.SBUS.SMBI) (20160108/utaddress-255)
[    2.182360] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[    2.187741] Intel(R) Wireless WiFi driver for Linux
[    2.187809] Copyright(c) 2003- 2015 Intel Corporation
[    2.188103] iwlwifi 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM control
[    2.193878] [drm] Initialized drm 1.1.0 20060810
[    2.195951] iwlwifi 0000:03:00.0: loaded firmware version 18.168.6.1 op_mode iwldvm
[    2.213477] iwlwifi 0000:03:00.0: CONFIG_IWLWIFI_DEBUG disabled
[    2.213551] iwlwifi 0000:03:00.0: CONFIG_IWLWIFI_DEBUGFS disabled
[    2.213619] iwlwifi 0000:03:00.0: CONFIG_IWLWIFI_DEVICE_TRACING disabled
[    2.213689] iwlwifi 0000:03:00.0: Detected Intel(R) Centrino(R) Advanced-N 6235 AGN, REV=0xB0
[    2.213949] iwlwifi 0000:03:00.0: L1 Enabled - LTR Disabled
[    2.232513] [drm] Memory usable by graphics device = 2048M
[    2.232621] [drm] Replacing VGA console driver
[    2.233560] Console: switching to colour dummy device 80x25
[    2.233662] pmd_set_huge: Cannot satisfy [mem 0xb0000000-0xb0200000] with a huge-page mapping due to MTRR override.
[    2.236366] ieee80211 phy0: Selected rate control algorithm 'iwl-agn-rs'
[    2.238417] input: PC Speaker as /devices/platform/pcspkr/input/input6
[    2.242196] Error: Driver 'pcspkr' is already registered, aborting...
[    2.242602] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    2.242610] [drm] Driver supports precise vblank timestamp query.
[    2.242978] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    2.274852] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    2.275427] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input8
[    2.275861] [drm] Initialized i915 1.6.0 20151218 for 0000:00:02.0 on minor 0
[    2.285377] usb 1-1.3: New USB device found, idVendor=064e, idProduct=e330
[    2.285393] usb 1-1.3: New USB device strings: Mfr=3, Product=1, SerialNumber=0
[    2.285419] usb 1-1.3: Product: HD WebCam
[    2.285432] usb 1-1.3: Manufacturer: SuYin
[    2.294256] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC271X: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[    2.294279] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    2.294296] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
[    2.294311] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[    2.294321] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    2.294332] snd_hda_codec_realtek hdaudioC0D0:      Mic=0x1b
[    2.338580] Adding 4789244k swap on /dev/sda5.  Priority:-1 extents:1 across:4789244k SSFS
[    2.347895] intel_rapl: Found RAPL domain package
[    2.347905] intel_rapl: Found RAPL domain core
[    2.347911] intel_rapl: Found RAPL domain uncore
[    2.347923] intel_rapl: RAPL package 0 domain package locked by BIOS
[    2.379997] iTCO_vendor_support: vendor-support=0
[    2.385589] acer_wmi: Acer Laptop ACPI-WMI Extras
[    2.385616] acer_wmi: Function bitmap for Communication Button: 0x801
[    2.385908] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    2.385978] iTCO_wdt: Found a Panther Point TCO device (Version=2, TCOBASE=0x0460)
[    2.387338] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    2.387555] input: Acer WMI hotkeys as /devices/virtual/input/input11
[    2.388287] input: Acer BMA150 accelerometer as /devices/virtual/input/input12
[    2.390188] Bluetooth: Core ver 2.21
[    2.390221] NET: Registered protocol family 31
[    2.390230] Bluetooth: HCI device and connection manager initialized
[    2.390244] Bluetooth: HCI socket layer initialized
[    2.390256] Bluetooth: L2CAP socket layer initialized
[    2.390278] Bluetooth: SCO socket layer initialized
[    2.409123] usbcore: registered new interface driver btusb
[    2.413436] snd_hda_intel 0000:00:1b.0: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
[    2.414373] fbcon: inteldrmfb (fb0) is primary device
[    2.417721] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/sound/card0/input9
[    2.422023] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input10
[    2.422193] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1b.0/sound/card0/input13
[    2.442221] media: Linux media interface: v0.10
[    2.447657] Linux video capture interface: v2.00
[    2.457230] uvcvideo: Found UVC 1.00 device HD WebCam (064e:e330)
[    2.462822] uvcvideo 1-1.3:1.0: Entity type for entity Extension 4 was not initialized!
[    2.462831] uvcvideo 1-1.3:1.0: Entity type for entity Processing 2 was not initialized!
[    2.462834] uvcvideo 1-1.3:1.0: Entity type for entity Camera 1 was not initialized!
[    2.463024] input: HD WebCam as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.3/1-1.3:1.0/input/input14
[    2.463159] usbcore: registered new interface driver uvcvideo
[    2.463160] USB Video Class driver (1.1.1)
[    2.489404] ACPI: Battery Slot [BAT1] (battery present)
[    2.489697] ACPI: AC Adapter [ACAD] (off-line)
[    2.990018] psmouse serio1: elantech: assuming hardware version 4 (with firmware version 0x461f02)
[    3.010511] psmouse serio1: elantech: Synaptics capabilities query result 0x01, 0x16, 0x0c.
[    3.031209] psmouse serio1: elantech: Elan sample query result 02, 33, 85
[    3.057639] clocksource: Switched to clocksource tsc
[    3.147609] input: ETPS/2 Elantech Touchpad as /devices/platform/i8042/serio1/input/input7
[    3.301713] Console: switching to colour frame buffer device 170x48
[    3.310590] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    3.489981] systemd-journald[207]: Received request to flush runtime journal from PID 1
[    3.725129] RPC: Registered named UNIX socket transport module.
[    3.726583] RPC: Registered udp transport module.
[    3.727971] RPC: Registered tcp transport module.
[    3.729339] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    3.734734] FS-Cache: Loaded
[    3.744326] FS-Cache: Netfs 'nfs' registered for caching
[    3.754325] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[    3.865427] cgroup: new mount options do not match the existing superblock, will be ignored
[    4.005562] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    4.007337] Bluetooth: BNEP filters: protocol multicast
[    4.009084] Bluetooth: BNEP socket layer initialized
[    5.423140] iwlwifi 0000:03:00.0: L1 Enabled - LTR Disabled
[    5.430041] iwlwifi 0000:03:00.0: L1 Enabled - LTR Disabled
[    5.430138] iwlwifi 0000:03:00.0: Radio type=0x2-0x1-0x0
[    5.702682] iwlwifi 0000:03:00.0: L1 Enabled - LTR Disabled
[    5.709351] iwlwifi 0000:03:00.0: L1 Enabled - LTR Disabled
[    5.709446] iwlwifi 0000:03:00.0: Radio type=0x2-0x1-0x0
[    8.691436] random: nonblocking pool is initialized
[    9.135351] wlan0: authenticate with b4:99:ba:92:f2:71
[    9.138098] wlan0: send auth to b4:99:ba:92:f2:71 (try 1/3)
[    9.139835] wlan0: authenticated
[    9.140083] iwlwifi 0000:03:00.0 wlan0: disabling HT as WMM/QoS is not supported by the AP
[    9.140090] iwlwifi 0000:03:00.0 wlan0: disabling VHT as WMM/QoS is not supported by the AP
[    9.141331] wlan0: associate with b4:99:ba:92:f2:71 (try 1/3)
[    9.145117] wlan0: RX AssocResp from b4:99:ba:92:f2:71 (capab=0x421 status=0 aid=7)
[    9.148859] wlan0: associated
[ 1896.606851] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
[ 1896.607002] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
[ 1896.607117] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
[ 1896.607239] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
[ 1896.607280] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
[ 1896.607974] pci_bus 0000:02: Allocating resources
[ 1896.608004] pci_bus 0000:03: Allocating resources
[ 1896.608060] pcieport 0000:00:1c.1: bridge window [io  0x1000-0x0fff] to [bus 03] add_size 1000
[ 1896.608069] pcieport 0000:00:1c.1: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 03] add_size 200000 add_align 100000
[ 1896.608083] pci_bus 0000:04: Allocating resources
[ 1896.608138] pcieport 0000:00:1c.2: bridge window [io  0x1000-0x0fff] to [bus 04] add_size 1000
[ 1896.608145] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
[ 1896.608156] pcieport 0000:00:1c.1: res[15]=[mem 0x00100000-0x000fffff 64bit pref] res_to_dev_res add_size 200000 min_align 100000
[ 1896.608162] pcieport 0000:00:1c.1: res[15]=[mem 0x00100000-0x002fffff 64bit pref] res_to_dev_res add_size 200000 min_align 100000
[ 1896.608166] pcieport 0000:00:1c.1: res[13]=[io  0x1000-0x0fff] res_to_dev_res add_size 1000 min_align 1000
[ 1896.608171] pcieport 0000:00:1c.1: res[13]=[io  0x1000-0x1fff] res_to_dev_res add_size 1000 min_align 1000
[ 1896.608176] pcieport 0000:00:1c.2: res[13]=[io  0x1000-0x0fff] res_to_dev_res add_size 1000 min_align 1000
[ 1896.608181] pcieport 0000:00:1c.2: res[13]=[io  0x1000-0x1fff] res_to_dev_res add_size 1000 min_align 1000
[ 1896.608196] pcieport 0000:00:1c.1: BAR 15: assigned [mem 0xc0700000-0xc08fffff 64bit pref]
[ 1896.608205] pcieport 0000:00:1c.1: BAR 13: assigned [io  0x4000-0x4fff]
[ 1896.608212] pcieport 0000:00:1c.2: BAR 13: assigned [io  0x5000-0x5fff]
[ 1896.608486] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
[ 1896.643237] wlan0: deauthenticating from b4:99:ba:92:f2:71 by local choice (Reason: 3=DEAUTH_LEAVING)
[ 1896.673664] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
[ 1898.077523] PM: Syncing filesystems ... done.
[ 1898.085166] PM: Preparing system for sleep (mem)
[ 1898.085519] Freezing user space processes ... (elapsed 0.001 seconds) done.
[ 1898.087399] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[ 1898.088609] PM: Suspending system (mem)
[ 1898.088636] Suspending console(s) (use no_console_suspend to debug)
[ 1898.089424] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[ 1898.089481] sd 0:0:0:0: [sda] Stopping disk
[ 1898.571589] PM: suspend of devices complete after 482.564 msecs
[ 1898.586792] PM: late suspend of devices complete after 15.195 msecs
[ 1898.589089] ehci-pci 0000:00:1d.0: System wakeup enabled by ACPI
[ 1898.589099] tg3 0000:04:00.0: System wakeup enabled by ACPI
[ 1898.589309] ehci-pci 0000:00:1a.0: System wakeup enabled by ACPI
[ 1898.589485] xhci_hcd 0000:00:14.0: System wakeup enabled by ACPI
[ 1898.602908] PM: noirq suspend of devices complete after 16.111 msecs
[ 1898.603262] ACPI: Preparing to enter system sleep state S3
[ 1898.606741] ACPI : EC: EC stopped
[ 1898.606741] PM: Saving platform NVS memory
[ 1898.606747] Disabling non-boot CPUs ...
[ 1898.607069] Broke affinity for irq 25
[ 1898.608156] smpboot: CPU 1 is now offline
[ 1898.608837] Broke affinity for irq 23
[ 1898.608842] Broke affinity for irq 25
[ 1898.609941] smpboot: CPU 2 is now offline
[ 1898.610645] Broke affinity for irq 23
[ 1898.610648] Broke affinity for irq 24
[ 1898.610649] Broke affinity for irq 25
[ 1898.610651] Broke affinity for irq 27
[ 1898.611741] smpboot: CPU 3 is now offline
[ 1898.613517] ACPI: Low-level resume complete
[ 1898.613579] ACPI : EC: EC started
[ 1898.613580] PM: Restoring platform NVS memory
[ 1898.613970] Enabling non-boot CPUs ...
[ 1898.614062] x86: Booting SMP configuration:
[ 1898.614064] smpboot: Booting Node 0 Processor 1 APIC 0x1
[ 1898.622111] CPU1 is up
[ 1898.622235] smpboot: Booting Node 0 Processor 2 APIC 0x2
[ 1898.625650] CPU2 is up
[ 1898.625781] smpboot: Booting Node 0 Processor 3 APIC 0x3
[ 1898.629349] CPU3 is up
[ 1898.634177] ACPI: Waking up from system sleep state S3
[ 1898.653286] ehci-pci 0000:00:1a.0: System wakeup disabled by ACPI
[ 1898.654267] ehci-pci 0000:00:1d.0: System wakeup disabled by ACPI
[ 1898.654315] xhci_hcd 0000:00:14.0: System wakeup disabled by ACPI
[ 1898.654389] PM: noirq resume of devices complete after 17.160 msecs
[ 1898.654863] PM: early resume of devices complete after 0.403 msecs
[ 1898.655189] tg3 0000:04:00.0: System wakeup disabled by ACPI
[ 1898.660697] sd 0:0:0:0: [sda] Starting disk
[ 1898.795727] xhci_hcd 0000:00:14.0: port 3 resume PLC timeout
[ 1898.816945] rtc_cmos 00:03: System wakeup disabled by ACPI
[ 1899.328585] usb 1-1.1: reset full-speed USB device number 3 using ehci-pci
[ 1899.361009] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[ 1899.377993] ata1.00: configured for UDMA/133
[ 1899.492568] usb 1-1.3: reset high-speed USB device number 4 using ehci-pci
[ 1901.309681] PM: resume of devices complete after 2654.803 msecs
[ 1901.309873] usb 1-1.1:1.0: rebind failed: -517
[ 1901.309879] usb 1-1.1:1.1: rebind failed: -517
[ 1901.310607] PM: Finishing wakeup.
[ 1901.310613] Restarting tasks ... 
[ 1901.320540] usb 2-4: USB disconnect, device number 2
[ 1901.321392] done.
[ 1902.070068] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[ 1902.535798] iwlwifi 0000:03:00.0: L1 Enabled - LTR Disabled
[ 1902.542427] iwlwifi 0000:03:00.0: L1 Enabled - LTR Disabled
[ 1902.542518] iwlwifi 0000:03:00.0: Radio type=0x2-0x1-0x0
[ 1902.821410] iwlwifi 0000:03:00.0: L1 Enabled - LTR Disabled
[ 1902.828034] iwlwifi 0000:03:00.0: L1 Enabled - LTR Disabled
[ 1902.828126] iwlwifi 0000:03:00.0: Radio type=0x2-0x1-0x0
[ 1906.173700] wlan0: authenticate with 30:91:8f:7f:7f:15
[ 1906.176176] wlan0: send auth to 30:91:8f:7f:7f:15 (try 1/3)
[ 1906.178968] wlan0: authenticated
[ 1906.180932] wlan0: associate with 30:91:8f:7f:7f:15 (try 1/3)
[ 1906.184588] wlan0: RX AssocResp from 30:91:8f:7f:7f:15 (capab=0x411 status=0 aid=5)
[ 1906.186974] wlan0: associated
[ 2299.376942] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
[ 2299.377097] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
[ 2299.377212] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
[ 2299.377339] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
[ 2299.377377] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
[ 2299.378095] pci_bus 0000:02: Allocating resources
[ 2299.378124] pci_bus 0000:03: Allocating resources
[ 2299.378201] pci_bus 0000:04: Allocating resources
[ 2299.378259] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
[ 2299.378529] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
[ 2299.412655] wlan0: deauthenticating from 30:91:8f:7f:7f:15 by local choice (Reason: 3=DEAUTH_LEAVING)
[ 2299.444611] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
[ 2300.595009] PM: Syncing filesystems ... done.
[ 2300.610866] PM: Preparing system for sleep (mem)
[ 2300.611190] Freezing user space processes ... (elapsed 0.001 seconds) done.
[ 2300.612858] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[ 2300.614052] PM: Suspending system (mem)
[ 2300.614075] Suspending console(s) (use no_console_suspend to debug)
[ 2300.614793] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[ 2300.614842] sd 0:0:0:0: [sda] Stopping disk
[ 2301.094766] PM: suspend of devices complete after 480.305 msecs
[ 2301.108870] PM: late suspend of devices complete after 14.095 msecs
[ 2301.111104] tg3 0000:04:00.0: System wakeup enabled by ACPI
[ 2301.111295] ehci-pci 0000:00:1d.0: System wakeup enabled by ACPI
[ 2301.111545] ehci-pci 0000:00:1a.0: System wakeup enabled by ACPI
[ 2301.111596] xhci_hcd 0000:00:14.0: System wakeup enabled by ACPI
[ 2301.125054] PM: noirq suspend of devices complete after 16.176 msecs
[ 2301.125716] ACPI: Preparing to enter system sleep state S3
[ 2301.128916] ACPI : EC: EC stopped
[ 2301.128917] PM: Saving platform NVS memory
[ 2301.128929] Disabling non-boot CPUs ...
[ 2301.129471] Broke affinity for irq 23
[ 2301.129476] Broke affinity for irq 25
[ 2301.130565] smpboot: CPU 1 is now offline
[ 2301.132002] Broke affinity for irq 23
[ 2301.132008] Broke affinity for irq 25
[ 2301.133116] smpboot: CPU 2 is now offline
[ 2301.133806] Broke affinity for irq 23
[ 2301.133808] Broke affinity for irq 24
[ 2301.133810] Broke affinity for irq 25
[ 2301.133811] Broke affinity for irq 27
[ 2301.134888] smpboot: CPU 3 is now offline
[ 2301.136746] ACPI: Low-level resume complete
[ 2301.136809] ACPI : EC: EC started
[ 2301.136809] PM: Restoring platform NVS memory
[ 2301.137192] Enabling non-boot CPUs ...
[ 2301.137285] x86: Booting SMP configuration:
[ 2301.137286] smpboot: Booting Node 0 Processor 1 APIC 0x1
[ 2301.145354] CPU1 is up
[ 2301.145482] smpboot: Booting Node 0 Processor 2 APIC 0x2
[ 2301.148907] CPU2 is up
[ 2301.149036] smpboot: Booting Node 0 Processor 3 APIC 0x3
[ 2301.152602] CPU3 is up
[ 2301.157476] ACPI: Waking up from system sleep state S3
[ 2301.174708] ehci-pci 0000:00:1d.0: System wakeup disabled by ACPI
[ 2301.176174] xhci_hcd 0000:00:14.0: System wakeup disabled by ACPI
[ 2301.176648] ehci-pci 0000:00:1a.0: System wakeup disabled by ACPI
[ 2301.176699] PM: noirq resume of devices complete after 16.193 msecs
[ 2301.177163] PM: early resume of devices complete after 0.393 msecs
[ 2301.177784] tg3 0000:04:00.0: System wakeup disabled by ACPI
[ 2301.187090] sd 0:0:0:0: [sda] Starting disk
[ 2301.247271] rtc_cmos 00:03: System wakeup disabled by ACPI
[ 2301.498568] usb 1-1.1: reset full-speed USB device number 3 using ehci-pci
[ 2301.662551] usb 1-1.3: reset high-speed USB device number 4 using ehci-pci
[ 2301.855782] PM: resume of devices complete after 678.601 msecs
[ 2301.855964] usb 1-1.1:1.0: rebind failed: -517
[ 2301.855970] usb 1-1.1:1.1: rebind failed: -517
[ 2301.856688] PM: Finishing wakeup.
[ 2301.856694] Restarting tasks ... done.
[ 2301.887551] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[ 2301.907167] ata1.00: configured for UDMA/133
[ 2302.146806] [Firmware Bug]: battery: (dis)charge rate invalid.
[ 2302.614307] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[ 2303.079037] iwlwifi 0000:03:00.0: L1 Enabled - LTR Disabled
[ 2303.085653] iwlwifi 0000:03:00.0: L1 Enabled - LTR Disabled
[ 2303.085744] iwlwifi 0000:03:00.0: Radio type=0x2-0x1-0x0
[ 2303.359778] iwlwifi 0000:03:00.0: L1 Enabled - LTR Disabled
[ 2303.366392] iwlwifi 0000:03:00.0: L1 Enabled - LTR Disabled
[ 2303.366482] iwlwifi 0000:03:00.0: Radio type=0x2-0x1-0x0
[ 2306.922510] wlan0: authenticate with 30:91:8f:7f:7f:15
[ 2306.923605] wlan0: send auth to 30:91:8f:7f:7f:15 (try 1/3)
[ 2306.931025] wlan0: authenticated
[ 2306.934559] wlan0: associate with 30:91:8f:7f:7f:15 (try 1/3)
[ 2306.938212] wlan0: RX AssocResp from 30:91:8f:7f:7f:15 (capab=0x411 status=0 aid=4)
[ 2306.940574] wlan0: associated
[ 2324.418673] usb 2-3: new high-speed USB device number 3 using xhci_hcd
[ 2324.546878] usb 2-3: New USB device found, idVendor=04cc, idProduct=1521
[ 2324.546891] usb 2-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[ 2324.547581] hub 2-3:1.0: USB hub found
[ 2324.547630] hub 2-3:1.0: 7 ports detected
[ 2324.818692] usb 2-3.5: new high-speed USB device number 4 using xhci_hcd
[ 2324.909110] usb 2-3.5: New USB device found, idVendor=058f, idProduct=6362
[ 2324.909122] usb 2-3.5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[ 2324.909128] usb 2-3.5: Product: Mass Storage Device
[ 2324.909132] usb 2-3.5: Manufacturer: Generic
[ 2324.909136] usb 2-3.5: SerialNumber: 058F312D81B1
[ 2324.928034] usb-storage 2-3.5:1.0: USB Mass Storage device detected
[ 2324.928260] scsi host6: usb-storage 2-3.5:1.0
[ 2324.928607] usbcore: registered new interface driver usb-storage
[ 2324.978690] usb 2-3.6: new high-speed USB device number 5 using xhci_hcd
[ 2325.066777] usb 2-3.6: New USB device found, idVendor=0424, idProduct=2514
[ 2325.066787] usb 2-3.6: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[ 2325.067360] hub 2-3.6:1.0: USB hub found
[ 2325.067409] hub 2-3.6:1.0: 2 ports detected
[ 2325.338673] usb 2-3.6.1: new low-speed USB device number 6 using xhci_hcd
[ 2325.431289] usb 2-3.6.1: New USB device found, idVendor=093a, idProduct=2510
[ 2325.431302] usb 2-3.6.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[ 2325.431307] usb 2-3.6.1: Product: USB OPTICAL MOUSE
[ 2325.431311] usb 2-3.6.1: Manufacturer: PIXART
[ 2325.454440] hidraw: raw HID events driver (C) Jiri Kosina
[ 2325.459203] usbcore: registered new interface driver usbhid
[ 2325.459211] usbhid: USB HID core driver
[ 2325.462433] input: PIXART USB OPTICAL MOUSE as /devices/pci0000:00/0000:00:14.0/usb2/2-3/2-3.6/2-3.6.1/2-3.6.1:1.0/0003:093A:2510.0001/input/input15
[ 2325.463065] hid-generic 0003:093A:2510.0001: input,hidraw0: USB HID v1.11 Mouse [PIXART USB OPTICAL MOUSE] on usb-0000:00:14.0-3.6.1/input0
[ 2325.518660] usb 2-3.6.2: new low-speed USB device number 7 using xhci_hcd
[ 2325.634511] usb 2-3.6.2: New USB device found, idVendor=046a, idProduct=0023
[ 2325.634523] usb 2-3.6.2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[ 2325.677444] input: HID 046a:0023 as /devices/pci0000:00/0000:00:14.0/usb2/2-3/2-3.6/2-3.6.2/2-3.6.2:1.0/0003:046A:0023.0002/input/input16
[ 2325.731182] cherry 0003:046A:0023.0002: input,hidraw1: USB HID v1.11 Keyboard [HID 046a:0023] on usb-0000:00:14.0-3.6.2/input0
[ 2325.733591] input: HID 046a:0023 as /devices/pci0000:00/0000:00:14.0/usb2/2-3/2-3.6/2-3.6.2/2-3.6.2:1.1/0003:046A:0023.0003/input/input17
[ 2325.787216] cherry 0003:046A:0023.0003: input,hidraw2: USB HID v1.11 Device [HID 046a:0023] on usb-0000:00:14.0-3.6.2/input1
[ 2325.927495] scsi 6:0:0:0: Direct-Access     Generic  USB SD Reader    1.00 PQ: 0 ANSI: 0
[ 2325.928131] scsi 6:0:0:1: Direct-Access     Generic  USB CF Reader    1.01 PQ: 0 ANSI: 0
[ 2325.928701] scsi 6:0:0:2: Direct-Access     Generic  USB SM Reader    1.02 PQ: 0 ANSI: 0
[ 2325.929281] scsi 6:0:0:3: Direct-Access     Generic  USB MS Reader    1.03 PQ: 0 ANSI: 0
[ 2325.930017] sd 6:0:0:0: Attached scsi generic sg1 type 0
[ 2325.932663] sd 6:0:0:1: Attached scsi generic sg2 type 0
[ 2325.932970] sd 6:0:0:0: [sdb] Attached SCSI removable disk
[ 2325.933447] sd 6:0:0:2: Attached scsi generic sg3 type 0
[ 2325.934199] sd 6:0:0:1: [sdc] Attached SCSI removable disk
[ 2325.935570] sd 6:0:0:3: Attached scsi generic sg4 type 0
[ 2325.936389] sd 6:0:0:2: [sdd] Attached SCSI removable disk
[ 2325.938005] sd 6:0:0:3: [sde] Attached SCSI removable disk

--------------070503000407080408050908--
