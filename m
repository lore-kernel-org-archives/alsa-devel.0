From: Abdelghani Ouchabane <abdelghani@ezono.com>
Subject: Re: "modprobe snd_hda_intel" crashes on my hardware
Date: Wed, 28 Sep 2011 09:54:46 +0200
Message-ID: <4E82D2C6.9060307@ezono.com>
References: <4E817010.7030607@ezono.com> <s5hipodciju.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070901000503080006060403"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ezo.ezono.com (ezo.ezono.com [50.22.105.208])
	by alsa0.perex.cz (Postfix) with ESMTP id BE01124556
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Sep 2011 11:54:53 +0200 (CEST)
In-Reply-To: <s5hipodciju.wl%tiwai@suse.de>
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

This is a multi-part message in MIME format.
--------------070901000503080006060403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> At Tue, 27 Sep 2011 08:41:20 +0200,
> Abdelghani Ouchabane wrote:
>   
>> diff -auNrp kernel-2.6.26.orig/sound/pci/hda/patch_via.c kernel-2.6.26.new/sound/pci/hda/patch_via.c
>> --- kernel-2.6.26.orig/sound/pci/hda/patch_via.c	2008-10-17 18:58:06.000000000 +0200
>> +++ kernel-2.6.26.new/sound/pci/hda/patch_via.c	2008-10-17 19:01:21.000000000 +0200
>>     
> ...
>
> Does the problem occur with 3.0 or 3.1-rc kernel?
>   
Hallo Takashi,

  It occurs with Fedora 15 ( Kernel : 2.6.39 )
> (Alternatively you can try alsa-driver-snapshot tarball.)
>
> If yes, load the driver with probe_only=1 option, run alsa-info.sh
> with --no-upload option, and attach the output.
>   
I attached to you the following :

    1 - The output of alsa-info.sh  ( probe_only=1  +  --no-upload + my 
changes(ezonopatch) + alsa-driver 1.0.24 )

    2 - The output of alsa-info.sh  ( probe_only=1  +  --no-upload + 
alsa-driver-snapshot ( alsa-driver-1.0.24.72.g7c48f.1314.geb1d0)

    3 - With alsa-driver-1.0.24.72.g7c48f.1314.geb1d0 : modprobe 
snd_hda_intel : The system did not crash but alsamixer said that "This 
sound device does not have any controls"

Many thanks,
Ghani

--------------070901000503080006060403
Content-Type: text/plain;
 name="alsa-info.txt-ezonopatch-1.0.24"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-info.txt-ezonopatch-1.0.24"

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.60
!!################################

!!Script ran on: Sun Aug 21 22:14:37 UTC 2011


!!Linux Distribution
!!------------------

Fedora release 15 (Lovelock) Fedora release 15 (Lovelock) Fedora release 15 (Lovelock) Fedora release 15 (Lovelock)


!!DMI Information
!!---------------

Manufacturer:      
Product Name:      
Product Version:   


!!Kernel Information
!!------------------

Kernel release:    2.6.40.3-0.119.delos.i686
Operating System:  GNU/Linux
Architecture:      i686
Processor:         i686
SMP Enabled:       No


!!ALSA Version
!!------------

Driver version:     1.0.24
Library version:    
Utilities version:  1.0.24.1


!!Loaded ALSA modules
!!-------------------

snd_hda_intel


!!Sound Servers on this system
!!----------------------------

No sound servers found.


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xfea38000 irq 10


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation N10/ICH 7 Family High Definition Audio Controller (rev 02)


!!Advanced information - PCI Vendor/Device/Subsystem ID's
!!--------------------------------------------------------

00:1b.0 0403: 8086:27d8 (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-


!!Loaded sound module options
!!--------------------------

!!Module: snd_hda_intel
	bdl_pos_adj : 1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	beep_mode : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	enable_msi : -1
	id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	model : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	patch : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	position_fix : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	power_save : 0
	power_save_controller : Y
	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	probe_only : 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	single_cmd : N


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Not Set
Address: 2
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x11061708
Subsystem Id: 0x7fafffdd
Revision Id: 0x100700
No Modem Function Group found
Default PCM:
    rates [0x0]:
    bits [0x0]:
    formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x10 [Audio Output] wcaps 0x411: Stereo
  Converter: stream=0, channel=0
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xa]: 16 24
    formats [0x1]: PCM
  Power states:  D0 D1
  Power: setting=D0, actual=D0
Node 0x11 [Audio Output] wcaps 0x411: Stereo
  Converter: stream=0, channel=0
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xa]: 16 24
    formats [0x1]: PCM
  Power states:  D0 D1
  Power: setting=D0, actual=D0
Node 0x12 [Audio Output] wcaps 0x411: Stereo
  Converter: stream=0, channel=0
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xa]: 16 24
    formats [0x1]: PCM
  Power states:  D0 D1
  Power: setting=D0, actual=D0
Node 0x13 [Audio Output] wcaps 0x411: Stereo
  Converter: stream=0, channel=0
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xa]: 16 24
    formats [0x1]: PCM
  Power states:  D0 D1
  Power: setting=D0, actual=D0
Node 0x14 [Audio Output] wcaps 0x211: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xa]: 16 24
    formats [0x5]: PCM AC3
Node 0x15 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x14, stepsize=0x06, mute=1
  Amp-In vals:  [0x80 0x80]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x440]: 48000 192000
    bits [0xa]: 16 24
    formats [0x1]: PCM
  Power states:  D0 D1
  Power: setting=D0, actual=D0
  Connection: 1
     0x18
Node 0x16 [Audio Input] wcaps 0x100311: Stereo Digital
  Converter: stream=0, channel=0
  SDI-Select: 0
  Digital: Validity
  Digital category: 0x0
  PCM:
    rates [0x1f0]: 32000 44100 48000 88200 96000
    bits [0xa]: 16 24
    formats [0x5]: PCM AC3
  Connection: 1
     0x26
Node 0x17 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x06, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 6
     0x10 0x24 0x1d 0x1e 0x21 0x13
Node 0x18 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 5
     0x17* 0x24 0x1d 0x1e 0x21
Node 0x19 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1b, nsteps=0x1b, stepsize=0x06, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 1
     0x11
Node 0x1a [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1b, nsteps=0x1b, stepsize=0x06, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 1
     0x12
Node 0x1b [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1b, nsteps=0x1b, stepsize=0x06, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 1
     0x13
Node 0x1c [Pin Complex] wcaps 0x40010d: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000001c: OUT HP Detect
  Pin Default 0x7febf7ff: [N/A] Reserved at Oth UNKNOWN
    Conn = Comb, Color = Other
    DefAssociation = 0xf, Sequence = 0xf
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Connection: 1
     0x19
Node 0x1d [Pin Complex] wcaps 0x400101: Stereo
  Pincap 0x00000334: IN OUT Detect
    Vref caps: HIZ 50
  Pin Default 0xffbff7ff: [Both] Telephony at Oth UNKNOWN
    Conn = Other, Color = Other
    DefAssociation = 0xf, Sequence = 0xf
    Misc = NO_PRESENCE
  Pin-ctls: 0x00: VREF_HIZ
  Connection: 1
     0x1a
Node 0x1e [Pin Complex] wcaps 0x400101: Stereo
  Pincap 0x00000334: IN OUT Detect
    Vref caps: HIZ 50
  Pin Default 0xfffef6fd: [Both] Other at Oth UNKNOWN
    Conn = UNKNOWN, Color = Other
    DefAssociation = 0xf, Sequence = 0xd
  Pin-ctls: 0x00: VREF_HIZ
  Connection: 1
     0x19
Node 0x1f [Pin Complex] wcaps 0x40010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1b, nsteps=0x1b, stepsize=0x06, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000001c: OUT HP Detect
  Pin Default 0xfffdfffe: [Both] Other at Oth UNKNOWN
    Conn = UNKNOWN, Color = Other
    DefAssociation = 0xf, Sequence = 0xe
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x17
Node 0x20 [Pin Complex] wcaps 0x40010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1b, nsteps=0x1b, stepsize=0x06, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000001c: OUT HP Detect
  Pin Default 0xffad7fff: [Both] Mic at Oth UNKNOWN
    Conn = UNKNOWN, Color = Yellow
    DefAssociation = 0xf, Sequence = 0xf
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x17
Node 0x21 [Pin Complex] wcaps 0x400101: Stereo
  Pincap 0x00000334: IN OUT Detect
    Vref caps: HIZ 50
  Pin Default 0xffbe3eff: [Both] Telephony at Oth UNKNOWN
    Conn = UNKNOWN, Color = Blue
    DefAssociation = 0xf, Sequence = 0xf
  Pin-ctls: 0x00: VREF_HIZ
  Connection: 1
     0x1b
Node 0x22 [Pin Complex] wcaps 0x400101: Stereo
  Pincap 0x00000014: OUT Detect
  Pin Default 0xfe7fa67f: [Both] Modem Hand at Oth UNKNOWN
    Conn = Other, Color = UNKNOWN
    DefAssociation = 0x7, Sequence = 0xf
  Pin-ctls: 0x00:
  Connection: 1
     0x1a
Node 0x23 [Pin Complex] wcaps 0x400101: Stereo
  Pincap 0x00000014: OUT Detect
  Pin Default 0xbffffff5: [Fixed] Other at Oth UNKNOWN
    Conn = Other, Color = Other
    DefAssociation = 0xf, Sequence = 0x5
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Connection: 1
     0x1b
Node 0x24 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0xdbfbbfff: [Both] Other at Int UNKNOWN
    Conn = Comb, Color = UNKNOWN
    DefAssociation = 0xf, Sequence = 0xf
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
Node 0x25 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0xffefbf7d: [Both] Reserved at Oth UNKNOWN
    Conn = Other, Color = UNKNOWN
    DefAssociation = 0x7, Sequence = 0xd
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Connection: 1
     0x14
Node 0x26 [Pin Complex] wcaps 0x400201: Stereo Digital
  Pincap 0x00010030: IN OUT EAPD
  EAPD 0x0:
  Pin Default 0xfffe3fef: [Both] Other at Oth UNKNOWN
    Conn = UNKNOWN, Color = Blue
    DefAssociation = 0xe, Sequence = 0xf
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
Node 0x27 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x14, stepsize=0x06, mute=1
  Amp-In vals:  [0x80 0x80]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x440]: 48000 192000
    bits [0xa]: 16 24
    formats [0x1]: PCM
  Power states:  D0 D1
  Power: setting=D0, actual=D0
  Connection: 1
     0x21
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw---- 1 root cyclades 116,  3 Aug 22 00:12 /dev/snd/controlC0
crw-rw---- 1 root cyclades 116,  2 Aug 22 00:12 /dev/snd/hwC0D2
crw-rw---- 1 root cyclades 116,  1 Aug 22 00:12 /dev/snd/seq
crw-rw---- 1 root cyclades 116, 33 Aug 22 00:12 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  60 Aug 22 00:12 .
drwxr-xr-x 3 root root 140 Aug 22 00:12 ..
lrwxrwxrwx 1 root root  12 Aug 22 00:12 pci-0000:00:1b.0 -> ../controlC0


!!ALSA configuration files
!!------------------------

!!System wide config file (/etc/asound.conf)

#
# Place your global alsa-lib configuration here...
#

@hooks [
	{
		func load
		files [
			"/etc/alsa/pulse-default.conf"
		]
		errors false
	}
]


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****

ARECORD

**** List of CAPTURE Hardware Devices ****

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [Intel]

Card hw:0 'Intel'/'HDA Intel at 0xfea38000 irq 10'
  Mixer name	: ''
  Components	: 'HDA:11061708,7fafffdd,00100700'
  Controls      : 0
  Simple ctrls  : 0


!!Alsactl output
!!-------------

--startcollapse--
state.Intel {
	control {
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
snd_hda_intel
snd_hda_codec
snd_hwdep
snd_seq
snd_seq_device
snd_pcm
snd_timer
snd
soundcore
snd_page_alloc
ipv6
fakephp
cgosdrv
joydev
mcs7830
usbnet
mii
iTCO_wdt
iTCO_vendor_support
i2c_i801
usbtouchscreen
serio_raw
pciehp
xfs
i915
drm_kms_helper
drm
i2c_algo_bit
i2c_core
video


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D2/init_pin_configs:
0x1c 0x7febf7ff
0x1d 0xffbff7ff
0x1e 0xfffef6fd
0x1f 0xfffdfffe
0x20 0xffad7fff
0x21 0xffbe3eff
0x22 0xfe7fa67f
0x23 0xbffffff5
0x24 0xdbfbbfff
0x25 0xffefbf7d
0x26 0xfffe3fef

/sys/class/sound/hwC0D2/driver_pin_configs:

/sys/class/sound/hwC0D2/user_pin_configs:

/sys/class/sound/hwC0D2/init_verbs:


!!ALSA/HDA dmesg
!!------------------

[   23.202024] eth0: no IPv6 routers present
[  297.563955] HDA Intel 0000:00:1b.0: PCI INT A -> Link[LNKA] -> GSI 10 (level, low) -> IRQ 10
[  297.563995] HDA Intel 0000:00:1b.0: setting latency timer to 64



--------------070901000503080006060403
Content-Type: text/plain;
 name="alsa-info.txt-alsa-driver-snapshot"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-info.txt-alsa-driver-snapshot"

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.60
!!################################

!!Script ran on: Sun Aug 21 23:16:47 UTC 2011


!!Linux Distribution
!!------------------

Fedora release 15 (Lovelock) Fedora release 15 (Lovelock) Fedora release 15 (Lovelock) Fedora release 15 (Lovelock)


!!DMI Information
!!---------------

Manufacturer:      
Product Name:      
Product Version:   


!!Kernel Information
!!------------------

Kernel release:    2.6.40.3-0.119.delos.i686
Operating System:  GNU/Linux
Architecture:      i686
Processor:         i686
SMP Enabled:       No


!!ALSA Version
!!------------

Driver version:     1.0.24
Library version:    
Utilities version:  1.0.24.1


!!Loaded ALSA modules
!!-------------------

snd_hda_intel


!!Sound Servers on this system
!!----------------------------

No sound servers found.


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xfea38000 irq 10


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation N10/ICH 7 Family High Definition Audio Controller (rev 02)


!!Advanced information - PCI Vendor/Device/Subsystem ID's
!!--------------------------------------------------------

00:1b.0 0403: 8086:27d8 (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-


!!Loaded sound module options
!!--------------------------

!!Module: snd_hda_intel
	align_buffer_size : N
	bdl_pos_adj : 1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	beep_mode : 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	enable_msi : -1
	id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	model : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	patch : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	position_fix : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	power_save : 0
	power_save_controller : Y
	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	probe_only : 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	single_cmd : N


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Not Set
Address: 2
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x11061708
Subsystem Id: 0x7faffedd
Revision Id: 0x100700
No Modem Function Group found
Default PCM:
    rates [0x0]:
    bits [0x0]:
    formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x10 [Audio Output] wcaps 0x411: Stereo
  Converter: stream=0, channel=0
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xa]: 16 24
    formats [0x1]: PCM
  Power states:  D0 D1
  Power: setting=D0, actual=D0
Node 0x11 [Audio Output] wcaps 0x411: Stereo
  Converter: stream=0, channel=0
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xa]: 16 24
    formats [0x1]: PCM
  Power states:  D0 D1
  Power: setting=D0, actual=D0
Node 0x12 [Audio Output] wcaps 0x411: Stereo
  Converter: stream=0, channel=0
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xa]: 16 24
    formats [0x1]: PCM
  Power states:  D0 D1
  Power: setting=D0, actual=D0
Node 0x13 [Audio Output] wcaps 0x411: Stereo
  Converter: stream=0, channel=0
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xa]: 16 24
    formats [0x1]: PCM
  Power states:  D0 D1
  Power: setting=D0, actual=D0
Node 0x14 [Audio Output] wcaps 0x211: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xa]: 16 24
    formats [0x5]: PCM AC3
Node 0x15 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x14, stepsize=0x06, mute=1
  Amp-In vals:  [0x80 0x80]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x440]: 48000 192000
    bits [0xa]: 16 24
    formats [0x1]: PCM
  Power states:  D0 D1
  Power: setting=D0, actual=D0
  Connection: 1
     0x18
Node 0x16 [Audio Input] wcaps 0x100311: Stereo Digital
  Converter: stream=0, channel=0
  SDI-Select: 0
  Digital: Validity
  Digital category: 0x0
  PCM:
    rates [0x1f0]: 32000 44100 48000 88200 96000
    bits [0xa]: 16 24
    formats [0x5]: PCM AC3
  Connection: 1
     0x26
Node 0x17 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x06, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 6
     0x10 0x24 0x1d 0x1e 0x21 0x13
Node 0x18 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 5
     0x17* 0x24 0x1d 0x1e 0x21
Node 0x19 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1b, nsteps=0x1b, stepsize=0x06, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 1
     0x11
Node 0x1a [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1b, nsteps=0x1b, stepsize=0x06, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 1
     0x12
Node 0x1b [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1b, nsteps=0x1b, stepsize=0x06, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 1
     0x13
Node 0x1c [Pin Complex] wcaps 0x40010d: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000001c: OUT HP Detect
  Pin Default 0x7febf7ff: [N/A] Reserved at Oth UNKNOWN
    Conn = Comb, Color = Other
    DefAssociation = 0xf, Sequence = 0xf
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Connection: 1
     0x19
Node 0x1d [Pin Complex] wcaps 0x400101: Stereo
  Pincap 0x00000334: IN OUT Detect
    Vref caps: HIZ 50
  Pin Default 0xfbbff7ff: [Both] Telephony at Oth UNKNOWN
    Conn = Other, Color = Other
    DefAssociation = 0xf, Sequence = 0xf
    Misc = NO_PRESENCE
  Pin-ctls: 0x00: VREF_HIZ
  Connection: 1
     0x1a
Node 0x1e [Pin Complex] wcaps 0x400101: Stereo
  Pincap 0x00000334: IN OUT Detect
    Vref caps: HIZ 50
  Pin Default 0xfffef6fd: [Both] Other at Oth UNKNOWN
    Conn = UNKNOWN, Color = Other
    DefAssociation = 0xf, Sequence = 0xd
  Pin-ctls: 0x00: VREF_HIZ
  Connection: 1
     0x19
Node 0x1f [Pin Complex] wcaps 0x40010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1b, nsteps=0x1b, stepsize=0x06, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000001c: OUT HP Detect
  Pin Default 0xfffdfffe: [Both] Other at Oth UNKNOWN
    Conn = UNKNOWN, Color = Other
    DefAssociation = 0xf, Sequence = 0xe
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x17
Node 0x20 [Pin Complex] wcaps 0x40010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1b, nsteps=0x1b, stepsize=0x06, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000001c: OUT HP Detect
  Pin Default 0xffa97fff: [Both] Mic at Oth UNKNOWN
    Conn = XLR, Color = Yellow
    DefAssociation = 0xf, Sequence = 0xf
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x17
Node 0x21 [Pin Complex] wcaps 0x400101: Stereo
  Pincap 0x00000334: IN OUT Detect
    Vref caps: HIZ 50
  Pin Default 0xffb63eff: [Both] Telephony at Oth UNKNOWN
    Conn = Digital, Color = Blue
    DefAssociation = 0xf, Sequence = 0xf
  Pin-ctls: 0x00: VREF_HIZ
  Connection: 1
     0x1b
Node 0x22 [Pin Complex] wcaps 0x400101: Stereo
  Pincap 0x00000014: OUT Detect
  Pin Default 0xfe7fa67f: [Both] Modem Hand at Oth UNKNOWN
    Conn = Other, Color = UNKNOWN
    DefAssociation = 0x7, Sequence = 0xf
  Pin-ctls: 0x00:
  Connection: 1
     0x1a
Node 0x23 [Pin Complex] wcaps 0x400101: Stereo
  Pincap 0x00000014: OUT Detect
  Pin Default 0xbffbfff5: [Fixed] Other at Oth UNKNOWN
    Conn = Comb, Color = Other
    DefAssociation = 0xf, Sequence = 0x5
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Connection: 1
     0x1b
Node 0x24 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0xdbfbbfff: [Both] Other at Int UNKNOWN
    Conn = Comb, Color = UNKNOWN
    DefAssociation = 0xf, Sequence = 0xf
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
Node 0x25 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0xffefbf7d: [Both] Reserved at Oth UNKNOWN
    Conn = Other, Color = UNKNOWN
    DefAssociation = 0x7, Sequence = 0xd
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Connection: 1
     0x14
Node 0x26 [Pin Complex] wcaps 0x400201: Stereo Digital
  Pincap 0x00010030: IN OUT EAPD
  EAPD 0x0:
  Pin Default 0xfffe3fed: [Both] Other at Oth UNKNOWN
    Conn = UNKNOWN, Color = Blue
    DefAssociation = 0xe, Sequence = 0xd
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
Node 0x27 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x14, stepsize=0x06, mute=1
  Amp-In vals:  [0x80 0x80]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x440]: 48000 192000
    bits [0xa]: 16 24
    formats [0x1]: PCM
  Power states:  D0 D1
  Power: setting=D0, actual=D0
  Connection: 1
     0x21
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw---- 1 root cyclades 116,  3 Aug 22 01:16 /dev/snd/controlC0
crw-rw---- 1 root cyclades 116,  2 Aug 22 01:16 /dev/snd/hwC0D2
crw-rw---- 1 root cyclades 116,  1 Aug 22 01:16 /dev/snd/seq
crw-rw---- 1 root cyclades 116, 33 Aug 22 01:16 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  60 Aug 22 01:16 .
drwxr-xr-x 3 root root 140 Aug 22 01:16 ..
lrwxrwxrwx 1 root root  12 Aug 22 01:16 pci-0000:00:1b.0 -> ../controlC0


!!ALSA configuration files
!!------------------------

!!System wide config file (/etc/asound.conf)

#
# Place your global alsa-lib configuration here...
#

@hooks [
	{
		func load
		files [
			"/etc/alsa/pulse-default.conf"
		]
		errors false
	}
]


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****

ARECORD

**** List of CAPTURE Hardware Devices ****

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [Intel]

Card hw:0 'Intel'/'HDA Intel at 0xfea38000 irq 10'
  Mixer name	: ''
  Components	: 'HDA:11061708,7faffedd,00100700'
  Controls      : 0
  Simple ctrls  : 0


!!Alsactl output
!!-------------

--startcollapse--
state.Intel {
	control {
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
snd_hda_intel
snd_hda_codec
snd_hwdep
snd_seq
snd_seq_device
snd_pcm
snd_timer
snd
soundcore
snd_page_alloc
ipv6
fakephp
cgosdrv
joydev
mcs7830
usbnet
mii
usbtouchscreen
pciehp
serio_raw
iTCO_wdt
iTCO_vendor_support
i2c_i801
xfs
i915
drm_kms_helper
drm
i2c_algo_bit
i2c_core
video


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D2/init_pin_configs:
0x1c 0x7febf7ff
0x1d 0xfbbff7ff
0x1e 0xfffef6fd
0x1f 0xfffdfffe
0x20 0xffa97fff
0x21 0xffb63eff
0x22 0xfe7fa67f
0x23 0xbffbfff5
0x24 0xdbfbbfff
0x25 0xffefbf7d
0x26 0xfffe3fed

/sys/class/sound/hwC0D2/driver_pin_configs:

/sys/class/sound/hwC0D2/user_pin_configs:

/sys/class/sound/hwC0D2/init_verbs:


!!ALSA/HDA dmesg
!!------------------

[   22.306024] eth0: no IPv6 routers present
[   48.149978] snd_hda_intel 0000:00:1b.0: PCI INT A -> Link[LNKA] -> GSI 10 (level, low) -> IRQ 10
[   48.150180] snd_hda_intel 0000:00:1b.0: setting latency timer to 64



--------------070901000503080006060403
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070901000503080006060403--
