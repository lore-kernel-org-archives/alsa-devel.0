From: "Pieter-Augustijn Van Malleghe" <p-a@scarlet.be>
Subject: Re: no sound with hda-intel,
	conexant venice chip on hp 2836
Date: Thu, 16 Aug 2007 12:11:17 +0200
Message-ID: <b82ea05d0708160311q35314b90h3a4bb7724f0e909@mail.gmail.com>
References: <20070815173601.GA3227@bentham.lan>
	<1187227351.5512.280.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.228])
	by alsa0.perex.cz (Postfix) with ESMTP id 3FA75103843
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Aug 2007 12:11:21 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id m22so67590nzf
	for <alsa-devel@alsa-project.org>; Thu, 16 Aug 2007 03:11:20 -0700 (PDT)
In-Reply-To: <1187227351.5512.280.camel@razman.gruemaster.com>
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
To: Tobin Davis <tdavis@dsl-only.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

It is indeed a windows problem. I'm dual booting with vista, and it
seems only a cold linux boot will route the pins correctly.
I've tried loading the test driver and then reloading without options,
without any result. The codec file remains as is.

This is what the Codec file should look like:

Node 0x10 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x2b, nsteps=0x2b, stepsize=0x05, mute=1
  Amp-Out vals:  [0x26 0x26]
  Pincap 0x0810014: OUT EAPD Detect
  Pin Default 0x95170110: [Fixed] Speaker at Int Top
    Conn = Analog, Color = Unknown
  Pin-ctls: 0x40: OUT
  Power: 0x0
  Connection: 2
     0x19* 0x17
Node 0x11 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x2b, nsteps=0x2b, stepsize=0x05, mute=1
  Amp-Out vals:  [0x26 0x26]
  Pincap 0x08113c: IN OUT HP Detect
  Pin Default 0x0221401f: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
  Pin-ctls: 0xc0: OUT HP
  Power: 0x0
  Connection: 2
     0x19* 0x17
Node 0x12 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x2b, nsteps=0x2b, stepsize=0x05, mute=1
  Amp-Out vals:  [0xab 0xab]
  Pincap 0x08113c: IN OUT HP Detect
  Pin Default 0x62a1902e: [N/A] Mic at Sep Front
    Conn = 1/8, Color = Pink
  Pin-ctls: 0x20: IN
  Power: 0x0
  Connection: 2
     0x19* 0x17

The Amp-out values on 0x12 changed as well as the connection indications.

I'd be glad to help in any possible way with the debugging of this
driver. Is the Conexant documentation publically available ?

Thanks,

Pieter-Augustijn

On 8/16/07, Tobin Davis <tdavis@dsl-only.net> wrote:
>
>  For some reason, your system is defaulting the output pin connections to the mixer as opposed to the pcm (Node 0x10 & 0x11 should connect to 0x19).
>
>  Are you dual booting to Windows?  I've had issues getting this driver debugged, and this is usually one of the causes.  I'll try to revisit it again soon.
>
>  In the mean time, try unloading the driver, then load it with "modprobe -i snd-hda-intel model=test" to correctly set the channels, then unload and reload the driver without parameters.
>
>  Tobin
>
>
>  On Wed, 2007-08-15 at 19:36 +0200, Pieter-Augustijn Van Malleghem wrote:
>
>
> hi,
>
> i've just installed debian unstable on an hp 2386ea. This is the sound
> card it uses:
>
> 00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High
> 	Definition Audio Controller (rev 02)
> Subsystem: Hewlett-Packard Company Unknown device 30b2
>
> The driver is snd-hda-intel and everything loads fine. Alsamixer does
> the job equally well. However, no actual sound is produced. It uses the
> Conexant Venice (cx20549) codec. Nothing special in dmesg. I tried
> loading the kernel with noacpi, but no changes.
>
> I attach alsa-info.txt.
>
> Any clues ?
>
> Thanks in advance,
>
> pieter-augustijn
>
> name=root&type=33&description=/tmp/alsa-info.txt&expiry=&s=Submit+Post&content=
> !!################################
> !!ALSA Information Script v 0.4.30
> !!################################
>
> !!Script ran on: Wed Aug 15 17:19:13 CEST 2007
>
>
> !!Linux Distribution
> !!------------------
>
> Debian GNU/Linux lenny/sid \n \l
>
>
> !!Kernel Information
> !!------------------
>
> Kernel release:    2.6.22-1-amd64
> Operating System:  GNU/Linux
> Architecture:      x86_64
> Processor:         unknown
> SMP Enabled:       Yes
>
>
> !!ALSA Version
> !!------------
>
> Driver version:     1.0.14
> Library version:
> Utilities version:  1.0.14
>
>
> !!Loaded ALSA modules
> !!-------------------
>
> snd_hda_intel
>
>
> !!Soundcards recognised by ALSA
> !!-----------------------------
>
>  0 [Intel          ]: HDA-Intel - HDA Intel
>                       HDA Intel at 0xd6400000 irq 22
>
>
> !!PCI Soundcards installed in the system
> !!--------------------------------------
>
> 00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller (rev 02)
>
>
> !!Advanced information - PCI Vendor/Device/Susbsystem ID's
> !!--------------------------------------------------------
>
> 00:1b.0 0403: 8086:27d8 (rev 02)
> 	Subsystem: 103c:30b2
>
>
> !!HDA-Intel Codec information
> !!---------------------------
>
> Codec: Conexant CX20549 (Venice)
> Address: 0
> Vendor Id: 0x14f15045
> Subsystem Id: 0x103c30b2
> Revision Id: 0x100100
> Default PCM:
>     rates [0x140]: 48000 96000
>     bits [0xe]: 16 20 24
>     formats [0x1]: PCM
> Default Amp-In caps: N/A
> Default Amp-Out caps: N/A
> Node 0x10 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
>   Amp-Out caps: ofs=0x2b, nsteps=0x2b, stepsize=0x05, mute=1
>   Amp-Out vals:  [0x1e 0x1e]
>   Pincap 0x0810014: OUT EAPD Detect
>   Pin Default 0x95170110: [Fixed] Speaker at Int Top
>     Conn = Analog, Color = Unknown
>   Pin-ctls: 0x40: OUT
>   Power: 0x0
>   Connection: 2
>      0x19 0x17*
> Node 0x11 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
>   Amp-Out caps: ofs=0x2b, nsteps=0x2b, stepsize=0x05, mute=1
>   Amp-Out vals:  [0x1e 0x1e]
>   Pincap 0x08113c: IN OUT HP Detect
>   Pin Default 0x0221401f: [Jack] HP Out at Ext Front
>     Conn = 1/8, Color = Green
>   Pin-ctls: 0xc0: OUT HP
>   Power: 0x0
>   Connection: 2
>      0x19 0x17*
> Node 0x12 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
>   Amp-Out caps: ofs=0x2b, nsteps=0x2b, stepsize=0x05, mute=1
>   Amp-Out vals:  [0x14 0x14]
>   Pincap 0x08113c: IN OUT HP Detect
>   Pin Default 0x62a1902e: [N/A] Mic at Sep Front
>     Conn = 1/8, Color = Pink
>   Pin-ctls: 0x20: IN
>   Power: 0x0
>   Connection: 2
>      0x19 0x17*
> Node 0x13 [Pin Complex] wcaps 0x400301: Stereo Digital
>   Pincap 0x0810: OUT
>   Pin Default 0x21451130: [Jack] SPDIF Out at Sep Rear
>     Conn = Optical, Color = Black
>   Pin-ctls: 0x00:
>   Connection: 1
>      0x18
> Node 0x14 [Pin Complex] wcaps 0x400081: Stereo
>   Pincap 0x081124: IN Detect
>   Pin Default 0x97a701f0: [Fixed] Mic at Int Riser
>     Conn = Analog, Color = Unknown
>   Pin-ctls: 0x24: IN
> Node 0x15 [Pin Complex] wcaps 0x400001: Stereo
>   Pincap 0x0820: IN
>   Pin Default 0x54330121: [N/A] CD at Int Right
>     Conn = ATAPI, Color = Unknown
>   Pin-ctls: 0x00:
> Node 0x16 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
>   Amp-Out caps: ofs=0x07, nsteps=0x07, stepsize=0x0b, mute=1
>   Amp-Out vals:  [0x06]
> Node 0x17 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
>   Amp-In caps: ofs=0x14, nsteps=0x2b, stepsize=0x05, mute=1
>   Amp-In vals:  [0x94 0x94] [0x94 0x94] [0x94 0x94] [0x94 0x94] [0x94 0x94]
>   Power: 0x0
>   Connection: 5
>      0x19 0x14 0x12 0x11 0x15
> Node 0x18 [Audio Output] wcaps 0x211: Stereo Digital
>   PCM:
>     rates [0x40]: 48000
>     bits [0x6]: 16 20
>     formats [0x5]: PCM AC3
> Node 0x19 [Audio Output] wcaps 0xc11: Stereo
>   PCM:
>     rates [0x540]: 48000 96000 192000
>     bits [0xe]: 16 20 24
>     formats [0x1]: PCM
>   Power: 0x0
> Node 0x1a [Audio Input] wcaps 0x100d0b: Stereo Amp-In
>   Amp-In caps: ofs=0x00, nsteps=0x17, stepsize=0x05, mute=1
>   Amp-In vals:  [0x17 0x17] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>   Power: 0x0
>   Connection: 5
>      0x17 0x14* 0x12 0x11 0x15
> Node 0x1b [Vendor Defined Widget] wcaps 0xf00000: Mono
>
>
> !!ALSA Device nodes
> !!-----------------
>
> crw-rw---- 1 root audio 116,  0 2007-08-15 16:56 /dev/snd/controlC0
> crw-rw---- 1 root audio 116, 24 2007-08-15 16:56 /dev/snd/pcmC0D0c
> crw-rw---- 1 root audio 116, 16 2007-08-15 16:56 /dev/snd/pcmC0D0p
> crw-rw---- 1 root audio 116, 17 2007-08-15 16:56 /dev/snd/pcmC0D1p
> crw-rw---- 1 root audio 116, 33 2007-08-15 16:03 /dev/snd/timer
>
>
> !!Aplay output
> !!------------
>
> **** List of PLAYBACK Hardware Devices ****
> card 0: Intel [HDA Intel], device 0: CONEXANT Analog [CONEXANT Analog]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> card 0: Intel [HDA Intel], device 1: Conexant Digital [Conexant Digital]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
>
>
> !!Amixer output
> !!-------------
>
> !!-------Mixer controls for card 0 [Intel]
>
> Simple mixer control 'Master',0
>   Capabilities: pvolume pswitch pswitch-joined
>   Playback channels: Front Left - Front Right
>   Limits: Playback 0 - 43
>   Mono:
>   Front Left: Playback 30 [70%] [on]
>   Front Right: Playback 30 [70%] [on]
> Simple mixer control 'PCM',0
>   Capabilities: pvolume
>   Playback channels: Front Left - Front Right
>   Limits: Playback 0 - 255
>   Mono:
>   Front Left: Playback 231 [91%] [-4.80dB]
>   Front Right: Playback 231 [91%] [-4.80dB]
> Simple mixer control 'LineIn',0
>   Capabilities: cswitch cswitch-joined cswitch-exclusive
>   Capture exclusive group: 0
>   Capture channels: Mono
>   Mono: Capture [off]
> Simple mixer control 'IEC958',0
>   Capabilities: pswitch pswitch-joined
>   Playback channels: Mono
>   Mono: Playback [off]
> Simple mixer control 'Ext Mic',0
>   Capabilities: volume pswitch
>   Playback channels: Front Left - Front Right
>   Capture channels: Front Left - Front Right
>   Limits: 0 - 23
>   Front Left: 9 [39%] [13.50dB] Playback [on]
>   Front Right: 9 [39%] [13.50dB] Playback [on]
> Simple mixer control 'Int Mic',0
>   Capabilities: volume pswitch
>   Playback channels: Front Left - Front Right
>   Capture channels: Front Left - Front Right
>   Limits: 0 - 23
>   Front Left: 13 [57%] [19.50dB] Playback [on]
>   Front Right: 13 [57%] [19.50dB] Playback [on]
> Simple mixer control 'IntMic',0
>   Capabilities: cswitch cswitch-joined cswitch-exclusive
>   Capture exclusive group: 0
>   Capture channels: Mono
>   Mono: Capture [on]
>
>
> !!All Loaded Modules
> !!------------------
>
> Module
> snd_hda_intel
> snd_pcm_oss
> snd_mixer_oss
> snd_pcm
> snd_timer
> snd
> soundcore
> snd_page_alloc
> arc4
> ecb
> blkcipher
> ieee80211_crypt_wep
> nvidia
> ipv6
> button
> ac
> battery
> dm_snapshot
> dm_mirror
> dm_mod
> firewire_sbp2
> loop
> tsdev
> joydev
> ipw3945
> hci_usb
> i2c_i801
> sdhci
> ieee80211
> ieee80211_crypt
> psmouse
> bluetooth
> i2c_core
> mmc_core
> serio_raw
> firmware_class
> iTCO_wdt
> intel_agp
> evdev
> ext3
> jbd
> mbcache
> ide_cd
> cdrom
> sd_mod
> piix
> generic
> ide_core
> e100
> ata_generic
> ahci
> firewire_ohci
> firewire_core
> crc_itu_t
> mii
> libata
> ehci_hcd
> scsi_mod
> uhci_hcd
> thermal
> processor
> fan
>
>
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
>   --  Tobin Davis
>
>  After years of research, scientists recently reported that there is,
> indeed, arroz in Spanish Harlem.
>
>
