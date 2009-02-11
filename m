From: aeleneski@comcast.net
Subject: Re: No sound for HP Pavilion DV4z
Date: Wed, 11 Feb 2009 22:15:30 +0000 (UTC)
Message-ID: <947282031.309861234390530891.JavaMail.root@sz0025a.westchester.pa.mail.comcast.net>
References: <1856646965.309841234390528103.JavaMail.root@sz0025a.westchester.pa.mail.comcast.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_14811_766190217.1234390530888"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from QMTA03.westchester.pa.mail.comcast.net
	(qmta03.westchester.pa.mail.comcast.net [76.96.62.32])
	by alsa0.perex.cz (Postfix) with ESMTP id 6DBE31038CC
	for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2009 23:15:33 +0100 (CET)
In-Reply-To: <1856646965.309841234390528103.JavaMail.root@sz0025a.westchester.pa.mail.comcast.net>
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

------=_Part_14811_766190217.1234390530888
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Alright. Well, it again seems like a no go. 
Ran all the commands, still no sound. Upon starting Amarok, I receive the error "xine was unable to initialize any audio drivers." 

Then also when I do aplay -l I get: 

**** List of PLAYBACK Hardware Devices **** 
card 1: HDMI [HDA ATI HDMI], device 3: ATI HDMI [ATI HDMI] 
Subdevices: 1/1 
Subdevice #0: subdevice #0 


Attached is the alsa-info text. 

Thanks again. 
Andrew 



----- Original Message ----- 
From: "Takashi Iwai" <tiwai@suse.de> 
To: aeleneski@comcast.net 
Cc: alsa-devel@alsa-project.org 
Sent: Wednesday, February 11, 2009 1:34:29 AM GMT -05:00 US/Canada Eastern 
Subject: Re: [alsa-devel] No sound for HP Pavilion DV4z 

At Tue, 10 Feb 2009 23:58:19 +0000 (UTC), 
aeleneski@comcast.net wrote: 
> 
> Ok, well I tried this: 
> 
> The above might be not suffice to give the initialization before the 
> parser. Try to call hda-verb like the following instead: 
> 
> hda-verb /dev/snd/hwC0D0 0x0d 0x71c 0x10 
> hda-verb /dev/snd/hwC0D0 0x0d 0x71d 0x11 
> hda-verb /dev/snd/hwC0D0 0x0d 0x71e 0x17 
> hda-verb /dev/snd/hwC0D0 0x0d 0x71f 0x90 
> 
> then 
> 
> echo 1 > /sys/class/sound/hwC0D0/reconfig 
> 
> I started my system, changed to probe_only=1. Ran the commands above, and 
> removed probe_only=1. 
> Upon shutdown during restart, I again heard the speakers crackle. When the 
> system came back up, no sound. 

Ah no, you don't have to restart the system at all. 
Maybe I wasn't clear enough. 

The sequence above itself will make your sound system already usable. 
(and you don't have to probe_only=1 option.) 
Just use your sound apps after the sequence above after checking the 
mixer status. 

If it still doesn't work, run alsa-info and attach the outupt again. 
Also, show the kernel message, too. 


Takashi 


> 
> ----- Original Message ----- 
> From: "Takashi Iwai" <tiwai@suse.de> 
> To: aeleneski@comcast.net 
> Cc: alsa-devel@alsa-project.org 
> Sent: Tuesday, February 10, 2009 6:34:02 AM GMT -05:00 US/Canada Eastern 
> Subject: Re: [alsa-devel] No sound for HP Pavilion DV4z 
> 
> At Mon, 09 Feb 2009 18:24:57 +0100, 
> I wrote: 
> > 
> > At Mon, 9 Feb 2009 17:18:59 +0000 (UTC), 
> > aeleneski@comcast.net wrote: 
> > > 
> > > Thanks for your time and all these suggestions. Still no luck though. 
> > > 
> > > Seems like you might not be able to have two files ending in alsa-base in 
> > > the /etc/modprobe.d/ folder. That was the reason for the orange speaker 
> > > indicator. I had 
> > > alsa-base and backup-alsa-base, for some reason it was grabbing the 
> settings 
> > > from the backup. 
> > 
> > Ah, yes, module-init-tools doesn't check every backup file suffix. 
> > Better to remove completely old files. 
> > 
> > > Anyway, with probe only, orange sound indicator, when doing aplay -l I get 
> > > 
> > > **** List of PLAYBACK Hardware Devices **** 
> > > card 1: HDMI [HDA ATI HDMI], device 3: ATI HDMI [ATI HDMI] 
> > > Subdevices: 1/1 
> > > Subdevice #0: subdevice #0 
> > 
> > With probe_only option, it doesn't make sense to run aplay. This 
> > option basically means "probe codecs but don't set up for use yet". 
> > This is useful to check the raw setup by BIOS before overriding or 
> > modifying by the driver. 
> > 
> > One thing we can try is to add the pin config dynamically then 
> > reconfigure. For example, load the driver with probe_only=1, then 
> > do the following as root: 
> > 
> > echo 0x0d 0x71c 0x10 > /sys/class/sound/hwC0D0/init_verbs 
> > echo 0x0d 0x71d 0x11 > /sys/class/sound/hwC0D0/init_verbs 
> > echo 0x0d 0x71e 0x17 > /sys/class/sound/hwC0D0/init_verbs 
> > echo 0x0d 0x71f 0x90 > /sys/class/sound/hwC0D0/init_verbs 
> 
> The above might be not suffice to give the initialization before the 
> parser. Try to call hda-verb like the following instead: 
> 
> hda-verb /dev/snd/hwC0D0 0x0d 0x71c 0x10 
> hda-verb /dev/snd/hwC0D0 0x0d 0x71d 0x11 
> hda-verb /dev/snd/hwC0D0 0x0d 0x71e 0x17 
> hda-verb /dev/snd/hwC0D0 0x0d 0x71f 0x90 
> 
> then 
> 
> echo 1 > /sys/class/sound/hwC0D0/reconfig 
> 
> Takashi 
> 
> 

------=_Part_14811_766190217.1234390530888
Content-Type: text/plain; name=alsa-info.txt
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=alsa-info.txt

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.53
!!################################

!!Script ran on: Wed Feb 11 22:13:17 UTC 2009


!!Linux Distribution
!!------------------

Ubuntu 8.10 \n \l DISTRIB_ID=Ubuntu DISTRIB_DESCRIPTION="Ubuntu 8.10"


!!Kernel Information
!!------------------

Kernel release:    2.6.27-11-generic
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         unknown
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.19
Library version:    1.0.19
Utilities version:  1.0.19


!!Loaded ALSA modules
!!-------------------

snd_hda_intel
snd_hda_intel


!!Sound Servers on this system
!!----------------------------

aRts:
      Installed - Yes (/usr/bin/artsd)
      Running - No


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [SB             ]: HDA-Intel - HDA ATI SB
                      HDA ATI SB at 0xd2500000 irq 16
 1 [HDMI           ]: HDA-Intel - HDA ATI HDMI
                      HDA ATI HDMI at 0xd2410000 irq 19


!!PCI Soundcards installed in the system
!!--------------------------------------

00:14.2 Audio device: ATI Technologies Inc SBx00 Azalia (Intel HDA)
01:05.1 Audio device: ATI Technologies Inc RS780 Azalia controller


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:14.2 0403: 1002:4383
	Subsystem: 103c:30fb
--
01:05.1 0403: 1002:960f
	Subsystem: 1002:960f


!!Modprobe options (Sound related)
!!--------------------------------

snd-hda-intel: model=hp-dv5
snd-hda-intel: model=laptop


!!Loaded sound module options
!!--------------------------

!!Module: snd_hda_intel
bdl_pos_adj : 32,32,-1,-1,-1,-1,-1,-1
enable : Y,Y,Y,Y,Y,Y,Y,Y
enable_msi : 0
id : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
index : -1,-1,-1,-1,-1,-1,-1,-1
model : hp-dv5,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
position_fix : 0,0,0,0,0,0,0,0
power_save : 0
power_save_controller : Y
probe_mask : -1,-1,-1,-1,-1,-1,-1,-1
probe_only : N,N,N,N,N,N,N,N
single_cmd : N

!!Module: snd_hda_intel
bdl_pos_adj : 32,32,-1,-1,-1,-1,-1,-1
enable : Y,Y,Y,Y,Y,Y,Y,Y
enable_msi : 0
id : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
index : -1,-1,-1,-1,-1,-1,-1,-1
model : hp-dv5,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
position_fix : 0,0,0,0,0,0,0,0
power_save : 0
power_save_controller : Y
probe_mask : -1,-1,-1,-1,-1,-1,-1,-1
probe_only : N,N,N,N,N,N,N,N
single_cmd : N


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: IDT 92HD71B7X
Address: 0
Vendor Id: 0x111d76b2
Subsystem Id: 0x103c30fb
Revision Id: 0x100302
No Modem Function Group found
Default PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Default Amp-Out caps: ofs=0x7f, nsteps=0x7f, stepsize=0x02, mute=1
GPIO: io=8, o=0, i=0, unsolicited=1, wake=1
  IO[0]: enable=1, dir=1, wake=0, sticky=0, data=1, unsol=0
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[3]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[4]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[5]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[6]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[7]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Power-Map: 0x01
Analog Loopback: 0xf0
Node 0x0a [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0000001c: OUT HP Detect
  Pin Default 0x02214010: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=01, enabled=1
  Connection: 3
     0x10 0x11* 0x17
Node 0x0b [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x00001724: IN Detect
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x02a19020: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Pink
    DefAssociation = 0x2, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=02, enabled=1
Node 0x0c [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x00001724: IN Detect
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x40f100f0: [N/A] Other at Ext N/A
    Conn = 1/8, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00: VREF_HIZ
  Unsolicited: tag=00, enabled=0
Node 0x0d [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x00000014: OUT Detect
  Pin Default 0x90171110: [Fixed] Speaker at Int N/A
    Conn = Analog, Color = Black
    DefAssociation = 0x1, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Connection: 3
     0x10* 0x11 0x17
Node 0x0e [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x00001724: IN Detect
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x40f100f2: [N/A] Other at Ext N/A
    Conn = 1/8, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x2
  Pin-ctls: 0x00: VREF_HIZ
  Unsolicited: tag=00, enabled=0
Node 0x0f [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x00000014: OUT Detect
  Pin Default 0x40f100f3: [N/A] Other at Ext N/A
    Conn = 1/8, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x3
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Connection: 3
     0x10 0x11 0x17*
Node 0x10 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0x7f 0x7f]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x11 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0x7f 0x7f]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x12 [Audio Input] wcaps 0x1d0541: Stereo
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power: setting=D3, actual=D3
  Delay: 13 samples
  Connection: 1
     0x1c
  Processing caps: benign=0, ncoeff=0
Node 0x13 [Audio Input] wcaps 0x1d0541: Stereo
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power: setting=D3, actual=D3
  Delay: 13 samples
  Connection: 1
     0x1d
  Processing caps: benign=0, ncoeff=0
Node 0x14 [Pin Complex] wcaps 0x400100: Mono
  Pincap 0x00000010: OUT
  Pin Default 0x40f100f4: [N/A] Other at Ext N/A
    Conn = 1/8, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x4
  Pin-ctls: 0x00:
  Connection: 1
     0x16
Node 0x15 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 3
     0x10* 0x11 0x17
Node 0x16 [Audio Mixer] wcaps 0x200100: Mono
  Connection: 1
     0x15
Node 0x17 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x96 0x96] [0x94 0x94] [0x97 0x97] [0x96 0x96] [0x95 0x95]
  Connection: 5
     0x10 0x11 0x27 0x1a 0x1b
Node 0x18 [Pin Complex] wcaps 0x40000d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00000020: IN
  Pin Default 0x40f100f5: [N/A] Other at Ext N/A
    Conn = 1/8, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x5
  Pin-ctls: 0x00:
Node 0x19 [Pin Complex] wcaps 0x40000d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00000020: IN
  Pin Default 0x40f100f6: [N/A] Other at Ext N/A
    Conn = 1/8, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x6
  Pin-ctls: 0x00:
Node 0x1a [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-Out vals:  [0x02 0x02]
  Connection: 3
     0x0b* 0x0c 0x0e
Node 0x1b [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-Out vals:  [0x02 0x02]
  Connection: 3
     0x0b* 0x0c 0x0e
Node 0x1c [Audio Selector] wcaps 0x30090d: Stereo Amp-Out R/L
  Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x0d 0x0d]
  Connection: 4
     0x1a* 0x17 0x18 0x19
Node 0x1d [Audio Selector] wcaps 0x30090d: Stereo Amp-Out R/L
  Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 4
     0x1b* 0x17 0x18 0x19
Node 0x1e [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x40f100f7: [N/A] Other at Ext N/A
    Conn = 1/8, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x7
  Pin-ctls: 0x00:
  Connection: 1
     0x24
Node 0x1f [Pin Complex] wcaps 0x400701: Stereo Digital
  Pincap 0x00010010: OUT EAPD
  EAPD 0x0:
  Pin Default 0x40f100f8: [N/A] Other at Ext N/A
    Conn = 1/8, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x8
  Pin-ctls: 0x00:
  Power: setting=D0, actual=D0
  Connection: 2
     0x24* 0x25
Node 0x20 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x40f100f9: [N/A] Other at Ext N/A
    Conn = 1/8, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x9
  Pin-ctls: 0x00:
  Connection: 1
     0x25
Node 0x21 [Audio Output] wcaps 0x40211: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Delay: 4 samples
Node 0x22 [Audio Output] wcaps 0x40211: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Delay: 4 samples
Node 0x23 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x24 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 3
     0x21* 0x1c 0x1d
Node 0x25 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 3
     0x22* 0x1c 0x1d
Node 0x26 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x03, nsteps=0x03, stepsize=0x17, mute=1
  Amp-Out vals:  [0x00]
Node 0x27 [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x00000020: IN
  Pin Default 0x40f100fa: [N/A] Other at Ext N/A
    Conn = 1/8, Color = Unknown
    DefAssociation = 0xf, Sequence = 0xa
  Pin-ctls: 0x00:
Node 0x28 [Volume Knob Widget] wcaps 0x600000: Mono
  Volume-Knob: delta=1, steps=127, direct=1, val=127
  Connection: 2
     0x10 0x11
Codec: LSI ID 1040
Address: 1
Vendor Id: 0x11c11040
Subsystem Id: 0x103c137e
Revision Id: 0x100200
Modem Function Group: 0x1
Codec: ATI RS690/780 HDMI
Address: 0
Vendor Id: 0x1002791a
Subsystem Id: 0x791a00
Revision Id: 0x100000
No Modem Function Group found
Default PCM:
    rates [0x40]: 48000
    bits [0x2]: 16
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x02 [Audio Output] wcaps 0x201: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
Node 0x03 [Pin Complex] wcaps 0x400381: Stereo Digital
  Pincap 0x00000094: OUT Detect HDMI
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x02
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116,  0 Feb 11 16:46 /dev/snd/controlC0
crw-rw----+ 1 root audio 116, 32 Feb 11 16:46 /dev/snd/controlC1
crw-rw----+ 1 root audio 116,  4 Feb 11 16:46 /dev/snd/hwC0D0
crw-rw----+ 1 root audio 116,  5 Feb 11 16:46 /dev/snd/hwC0D1
crw-rw----+ 1 root audio 116, 36 Feb 11 16:46 /dev/snd/hwC1D0
crw-rw----+ 1 root audio 116, 51 Feb 11 16:46 /dev/snd/pcmC1D3p
crw-rw----+ 1 root audio 116, 33 Feb 11 16:46 /dev/snd/timer


!!ALSA configuration files
!!------------------------

!!User specific config file (~/.asoundrc)

# ALSA library configuration file

# Include settings that are under the control of asoundconf(1).
# (To disable these settings, comment out this line.)
</home/aeleneski/.asoundrc.asoundconf>



!!asoundconf-generated config file

# ALSA library configuration file managed by asoundconf(1).
#
# MANUAL CHANGES TO THIS FILE WILL BE OVERWRITTEN!
#
# Manual changes to the ALSA library configuration should be implemented
# by editing the ~/.asoundrc file, not by editing this file.


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 1: HDMI [HDA ATI HDMI], device 3: ATI HDMI [ATI HDMI]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [SB]

Card hw:0 'SB'/'HDA ATI SB at 0xd2500000 irq 16'
  Mixer name	: 'IDT 92HD71B7X'
  Components	: 'HDA:111d76b2,103c30fb,00100302 HDA:11c11040,103c137e,00100200'
  Controls      : 27
  Simple ctrls  : 17
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 64 [100%] [0.00dB] [on]
  Front Right: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 255 [100%] [0.00dB]
  Front Right: Playback 255 [100%] [0.00dB]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 15
  Front Left: Capture 13 [87%] [19.50dB] [on]
  Front Right: Capture 13 [87%] [19.50dB] [on]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 15
  Front Left: Capture 0 [0%] [0.00dB] [off]
  Front Right: Capture 0 [0%] [0.00dB] [off]
Simple mixer control 'Analog Loopback',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Analog Loopback',1
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'DAC0',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 22 [71%] [-1.50dB] [off]
  Front Right: Capture 22 [71%] [-1.50dB] [off]
Simple mixer control 'DAC1',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 21 [68%] [-3.00dB] [off]
  Front Right: Capture 21 [68%] [-3.00dB] [off]
Simple mixer control 'Digital Input Source',0
  Capabilities: enum
  Items: 'Analog Inputs' 'Mixer'
  Item0: 'Analog Inputs'
Simple mixer control 'Digital Input Source',1
  Capabilities: enum
  Items: 'Analog Inputs' 'Mixer'
  Item0: 'Analog Inputs'
Simple mixer control 'Import0 Mux',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 22 [71%] [-1.50dB] [off]
  Front Right: Capture 22 [71%] [-1.50dB] [off]
Simple mixer control 'Import1 Mux',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 20 [65%] [-4.50dB] [off]
  Front Right: Capture 20 [65%] [-4.50dB] [off]
Simple mixer control 'Mux',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 3
  Front Left: Capture 2 [67%] [20.00dB]
  Front Right: Capture 2 [67%] [20.00dB]
Simple mixer control 'Mux',1
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 3
  Front Left: Capture 2 [67%] [20.00dB]
  Front Right: Capture 2 [67%] [20.00dB]
Simple mixer control 'PC Beep',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 3
  Mono: Playback 3 [100%] [0.00dB] [on]
Simple mixer control 'Speaker',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 64 [100%] [0.00dB] [on]
  Front Right: Playback 64 [100%] [0.00dB] [on]

!!-------Mixer controls for card 1 [HDMI]

Card hw:1 'HDMI'/'HDA ATI HDMI at 0xd2410000 irq 19'
  Mixer name	: 'ATI RS690/780 HDMI'
  Components	: 'HDA:1002791a,00791a00,00100000'
  Controls      : 4
  Simple ctrls  : 1
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]


!!Alsactl output
!!-------------

--startcollapse--
state.SB {
	control.25 {
		comment.access 'read write user'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 255'
		comment.tlv '0000000100000008ffffec1400000014'
		comment.dbmin -5100
		comment.dbmax 0
		iface MIXER
		name 'PCM Playback Volume'
		value.0 255
		value.1 255
	}
	control.26 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Analog Loopback'
		value true
	}
	control.27 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Analog Loopback'
		index 1
		value true
	}
	control.28 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 15'
		comment.dbmin 0
		comment.dbmax 2250
		iface MIXER
		name 'Capture Volume'
		value.0 13
		value.1 13
	}
	control.29 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		value.0 true
		value.1 true
	}
	control.30 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 15'
		comment.dbmin 0
		comment.dbmax 2250
		iface MIXER
		name 'Capture Volume'
		index 1
		value.0 0
		value.1 0
	}
	control.31 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		index 1
		value.0 false
		value.1 false
	}
	control.32 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Import0 Mux Capture Switch'
		value.0 false
		value.1 false
	}
	control.33 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'Import0 Mux Capture Volume'
		value.0 22
		value.1 22
	}
	control.34 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Import1 Mux Capture Switch'
		value.0 false
		value.1 false
	}
	control.35 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'Import1 Mux Capture Volume'
		value.0 20
		value.1 20
	}
	control.36 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'DAC0 Capture Switch'
		value.0 false
		value.1 false
	}
	control.37 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'DAC0 Capture Volume'
		value.0 22
		value.1 22
	}
	control.38 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'DAC1 Capture Switch'
		value.0 false
		value.1 false
	}
	control.39 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'DAC1 Capture Volume'
		value.0 21
		value.1 21
	}
	control.40 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 64'
		comment.dbmin -4800
		comment.dbmax 0
		iface MIXER
		name 'Speaker Playback Volume'
		value.0 64
		value.1 64
	}
	control.41 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Speaker Playback Switch'
		value.0 true
		value.1 true
	}
	control.42 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'PC Beep Playback Switch'
		value true
	}
	control.43 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 3'
		comment.dbmin -1800
		comment.dbmax 0
		iface MIXER
		name 'PC Beep Playback Volume'
		value 3
	}
	control.44 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 64'
		comment.dbmin -4800
		comment.dbmax 0
		iface MIXER
		name 'Headphone Playback Volume'
		value.0 64
		value.1 64
	}
	control.45 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Headphone Playback Switch'
		value.0 true
		value.1 true
	}
	control.46 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 3'
		comment.dbmin 0
		comment.dbmax 3000
		iface MIXER
		name 'Mux Capture Volume'
		value.0 2
		value.1 2
	}
	control.47 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 3'
		comment.dbmin 0
		comment.dbmax 3000
		iface MIXER
		name 'Mux Capture Volume'
		index 1
		value.0 2
		value.1 2
	}
	control.48 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'Analog Inputs'
		comment.item.1 Mixer
		iface MIXER
		name 'Digital Input Source'
		value 'Analog Inputs'
	}
	control.49 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'Analog Inputs'
		comment.item.1 Mixer
		iface MIXER
		name 'Digital Input Source'
		index 1
		value 'Analog Inputs'
	}
	control.50 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 64'
		comment.dbmin -4800
		comment.dbmax 0
		iface MIXER
		name 'Master Playback Volume'
		value 64
	}
	control.51 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Master Playback Switch'
		value true
	}
}
state.HDMI {
	control.1 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.2 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.3 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.4 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Switch'
		value false
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
af_packet
binfmt_misc
rfcomm
sco
bridge
stp
bnep
l2cap
bluetooth
ppdev
vmnet
vmblock
vmci
vmmon
ipv6
powernow_k8
cpufreq_powersave
cpufreq_ondemand
cpufreq_userspace
cpufreq_stats
freq_table
cpufreq_conservative
pci_slot
sbs
sbshc
container
iptable_filter
ip_tables
x_tables
ieee80211_crypt_tkip
ieee80211_crypt
parport_pc
lp
parport
joydev
snd_hda_codec_atihdmi
uvcvideo
snd_hda_codec_idt
compat_ioctl32
serio_raw
snd_hda_intel
videodev
snd_hda_codec
psmouse
pcspkr
v4l1_compat
snd_hwdep
evdev
snd_pcm
i2c_piix4
sdhci_pci
snd_timer
sdhci
snd
soundcore
snd_page_alloc
mmc_core
i2c_core
fglrx
battery
video
output
wmi
ac
button
shpchp
pci_hotplug
ext3
jbd
mbcache
usbhid
hid
pata_acpi
sd_mod
sr_mod
crc_t10dif
cdrom
sg
pata_atiixp
ohci_hcd
ehci_hcd
ata_generic
ahci
usbcore
libata
scsi_mod
r8169
mii
dock
thermal
processor
fan
fbcon
tileblit
font
bitblit
softcursor
fuse



------=_Part_14811_766190217.1234390530888
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_14811_766190217.1234390530888--
