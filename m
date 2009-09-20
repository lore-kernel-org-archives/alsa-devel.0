From: Mitko Haralanov <voidtrance@comcast.net>
Subject: S/PDIF on NVidia CK804 not working
Date: Sun, 20 Sep 2009 11:21:17 -0700
Message-ID: <20090920112117.78a17dd2@nighthawk.voidtrance.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/rta3ZL0xENVwye1FM1JH458"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from QMTA03.emeryville.ca.mail.comcast.net
	(qmta03.emeryville.ca.mail.comcast.net [76.96.30.32])
	by alsa0.perex.cz (Postfix) with ESMTP id F1B3024487
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Sep 2009 20:21:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--MP_/rta3ZL0xENVwye1FM1JH458
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

I am new to the list and was hoping that someone here could give me
some help and advise as I am stuck and none of my research has turned
anything up.

I am having trouble getting any sound out of the S/PDIF port on my
built-in sound card. The card is recognized and 'aplay -L' shows the
iec958 device (as evident by the attached alsa-info.txt file) but when
I try to play any sound through it (using aplay) I get one of two
errors:

1. If I use the iec958 device directly:
$ aplay -D iec958 /usr/share/sounds/alsa/Front_Center.wav 
Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bit
Little Endian, Rate 48000 Hz, Mono aplay: set_params:984: Channels
count non available

2. If I try to use the plug:iec958:
$ aplay -D plug:iec958 /usr/share/sounds/alsa/Front_Center.wav  
Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bit
Little Endian, Rate 48000 Hz, Mono
(the sound file seems to play but there is no audio coming out of the
receiver)

Looking through the ALSA website, I see that my sound device is
supported. Configuring /etc/asound.conf and /etc/modprobe.conf as per
the ALSA website yields the same results as above.

Can anyone please, help me get my S/PDIF working?
Thank you very much!

-- 
Mitko Haralanov
--MP_/rta3ZL0xENVwye1FM1JH458
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=alsa-info.txt

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.58
!!################################

!!Script ran on: Sun Sep 20 17:32:25 UTC 2009


!!Linux Distribution
!!------------------




!!DMI Information
!!---------------

Manufacturer:      MICRO-STAR INTERNATIONAL CO., LTD
Product Name:      MS-7125


!!Kernel Information
!!------------------

Kernel release:    2.6.27.9-159.fc10.x86_64
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         x86_64
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.18a
Library version:    
Utilities version:  1.0.21


!!Loaded ALSA modules
!!-------------------

snd_intel8x0


!!Sound Servers on this system
!!----------------------------

aRts:
      Installed - Yes (/usr/bin/artsd)
      Running - No

Jack:
      Installed - Yes (/usr/bin/jackd)
      Running - No


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [CK804          ]: NFORCE - NVidia CK804
                      NVidia CK804 with ALC850 at irq 22


!!PCI Soundcards installed in the system
!!--------------------------------------

00:04.0 Multimedia audio controller: nVidia Corporation CK804 AC'97 Audio Controller (rev a2)
01:06.0 Multimedia video controller: Internext Compression Inc iTVC16 (CX23416) MPEG-2 Encoder (rev 01)
01:07.0 Multimedia video controller: Internext Compression Inc iTVC16 (CX23416) MPEG-2 Encoder (rev 01)
01:08.0 Multimedia video controller: Internext Compression Inc iTVC16 (CX23416) MPEG-2 Encoder (rev 01)
01:09.0 Multimedia video controller: Conexant CX23880/1/2/3 PCI Video and Audio Decoder (rev 05)
01:09.2 Multimedia controller: Conexant CX23880/1/2/3 PCI Video and Audio Decoder [MPEG Port] (rev 05)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:04.0 0401: 10de:0059 (rev a2)
	Subsystem: 1462:7585


!!Loaded sound module options
!!--------------------------

!!Module: snd_intel8x0
	ac97_clock : 0
	ac97_quirk : <NULL>
	buggy_irq : Y
	buggy_semaphore : N
	enable : N
	id : <NULL>
	index : -1
	joystick : 0
	spdif_aclink : 0
	xbox : N


!!AC97 Codec information
!!---------------------------
--startcollapse--

0-0/0: Realtek ALC850 rev 0

PCI Subsys Vendor: 0x1462
PCI Subsys Device: 0x7585

Revision         : 0x00
Compat. Class    : 0x00
Subsys. Vendor ID: 0xffff
Subsys. ID       : 0xffff

Capabilities     :
DAC resolution   : 16-bit
ADC resolution   : 16-bit
3D enhancement   : No 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Double rate slots: 7/8
Extended ID      : codec=0 rev=2 LDAC SDAC CDAC DSA=0 SPDIF DRA
Extended status  : PRK PRJ PRI SPCV SPDIF=10/11 SPDIF
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz

0:00 = 0000
0:02 = 0e0e
0:04 = 0000
0:06 = 000e
0:08 = 0000
0:0a = 000e
0:0c = 801f
0:0e = 801f
0:10 = 9f1f
0:12 = 1616
0:14 = 0000
0:16 = 9f1f
0:18 = 1616
0:1a = 0000
0:1c = 0d0d
0:1e = 0000
0:20 = 0400
0:22 = 0000
0:24 = 0000
0:26 = 030c
0:28 = 09c6
0:2a = 3c34
0:2c = bb80
0:2e = bb80
0:30 = bb80
0:32 = bb80
0:34 = 0000
0:36 = 9f80
0:38 = 9f9f
0:3a = 2824
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 0000
0:5e = 0000
0:60 = 0000
0:62 = 0000
0:64 = 0808
0:66 = 0808
0:68 = 0a0a
0:6a = 8400
0:6c = 0000
0:6e = 0017
0:70 = c5a0
0:72 = 00c0
0:74 = 8388
0:76 = aad0
0:78 = 1c8f
0:7a = 10e2
0:7c = 414c
0:7e = 4790
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root root 116, 8 Sep 20 10:22 /dev/snd/controlC0
crw-rw----+ 1 root root 116, 7 Sep 20 10:22 /dev/snd/pcmC0D0c
crw-rw----+ 1 root root 116, 6 Sep 20 10:22 /dev/snd/pcmC0D0p
crw-rw----+ 1 root root 116, 5 Sep 20 10:22 /dev/snd/pcmC0D1c
crw-rw----+ 1 root root 116, 4 Sep 20 10:22 /dev/snd/pcmC0D2p
crw-rw----+ 1 root root 116, 3 Sep 20 10:22 /dev/snd/seq
crw-rw----+ 1 root root 116, 2 Sep 20 10:22 /dev/snd/timer


!!ALSA configuration files
!!------------------------

!!User specific config file (~/.asoundrc)

# ~/.asoundrc or /etc/asound.conf
# ALSA configuration file

##### USAGE #####
# Save this file as "~/.asoundrc" (for user-specific sound configuration) or
# "/etc/asound.conf" (for system-wide sound configuration) and specify ALSA
# device names ad described in the next section.


##### DEVICE NAMES #####
# This configuration file defines four devices for use by the user.  Those
# devices are "analog", "mixed-analog", "digital", and "mixed-digital".  The
# user may also re-define "default" to be identical to one of the above-named
# devices (i.e. to send all sound output to the digital output unless otherwise
# specified).  Use the device names as described below:
#  - "analog" outputs to the analog output directly and (at least on software
#  sound cards) blocks other audio output.  After playback completes, "queued"
#  sounds are output in sequence.
#  - "mixed-analog" mixes audio output from multiple programs into the analog
#  output (so you can hear beeps, alerts, and other noises while playing back
#  an audio stream).
#  - "digital" outputs to the digital output directly.  Since most (all?)
#  digital outputs expect 48kHz PCM audio, this may not work for some playback
#  (i.e. CD's--which are 44.1kHz PCM audio--or 32kHz audio streams from TV
#  recordings, etc.).
#  - "mixed-digital"

# All other devices created within this file are used only by the configuration
# file itself and should /not/ be used directly.  In other words, do not use
# the devices "analog-hw", "dmix-analog", "digital-hw", or "dmix-digital".


##### IMPORTANT #####
# To make this ALSA configuration file work with your sound card, you will need
# to define the appropriate card and device information for the "analog-hw" and
# "digital-hw" devices below.  You can find the card and device information
# using "aplay -l".


##### Configuration File #####

# Override the default output used by ALSA.  If you do not override the
# default, your default device is identical to the (unmixed) "analog" device
# shown below.  If you prefer mixed and/or digital output, uncomment the
# appropriate four lines below (only one slave.pcm line).
#
# Note, also, that as of ALSA 1.0.9, "software" sound cards have been modified
# such that their default "default" device is identical to the "mixed-analog"
# device.  Whether using an ALSA version before or after 1.0.9, it does no harm
# and has no affect on performance to redefine the device (even if the
# redefinition does not change anything).  Also, by using this ALSA
# configuration file, you once again have access to unmixed analog output using
# the "analog" device.
pcm.!default {
  type plug
## Uncomment the following to use "mixed-analog" by default
#  slave.pcm "dmix-analog"
## Uncomment the following to use (unmixed) "digital" by default
  slave.pcm "digital-hw"
## Uncomment the following to use "mixed-digital" by default
#  slave.pcm "dmix-digital"
}

# Control device (mixer, etc.) for the card
ctl.!default {
  type hw
  card 0
}

# Alias for (converted) analog output on the card
# - This is identical to the device named "default"--which always exists and
# refers to hw:0,0 (unless overridden)
# - Therefore, we can specify "hw:0,0", "default", or "analog" to access analog
# output on the card
# - Note that as of ALSA 1.0.9, "software" sound card definitions redefine
# "default" to do mixing, meaning this device is different from "default" and
# allows playback while blocking other sound sources (until playback
# completes).
pcm.analog {
  type plug
  slave.pcm "analog-hw"
}

# Control device (mixer, etc.) for the card
ctl.analog {
  type hw
  card 0
}

# Alias for (converted) mixed analog output on the card
# - This will accept audio input--regardless of rate--and convert to the rate
# required for the dmix plugin (in this case 48000Hz)
# - Note that as of ALSA 1.0.9, "software" sound card definitions redefine
# "default" to do mixing, meaning this device is identical to "default" for
# "software" sound cards.
pcm.mixed-analog {
  type plug
  slave.pcm "dmix-analog"
}

# Control device (mixer, etc.) for the card
ctl.mixed-analog {
  type hw
  card 0
}

# Alias for (converted) digital (S/PDIF) output on the card
# - This will accept audio input--regardless of rate--and convert to the rate
# required for the S/PDIF hardware (in this case 48000Hz)
pcm.digital {
  type plug
  slave.pcm "digital-hw"
}

# Control device (mixer, etc.) for the card
ctl.digital {
  type hw
  card 0
}

# Alias for mixed (converted) digital (S/PDIF) output on the card
#  - This will accept audio input--regardless of rate--and convert to the rate
#  required for the S/PDIF hardware (in this case 48000Hz)
pcm.mixed-digital {
  type plug
  slave.pcm "dmix-digital"
}

# Control device (mixer, etc.) for the card
ctl.mixed-digital {
  type hw
  card 0
}

# The following devices are not useful by themselves.  They require specific
# rates, channels, and formats.  Therefore, you probably do not want to use
# them directly.  Instead use of of the devices defined above.

# Alias for analog output on the card
# Do not use this directly--it requires specific rate, channels, and format
pcm.analog-hw {
  type hw
  card 0
  # The default value for device is 0, so no need to specify
#  - Uncomment one of the below or create a new "device N" line as appropriate
#    for your sound card or 
#  device 1
#  device 4
}

# Control device (mixer, etc.) for the card
ctl.analog-hw {
  type hw
  card 0
}

# Alias for digital (S/PDIF) output on the card
# Do not use this directly--it requires specific rate, channels, and format
pcm.digital-hw {
  type hw
  card 0
#  device 1
#  - Comment out "device 1" above and uncomment one of the below or create a
#    new "device N" line as appropriate for your sound card or 
  device 2
#  device 4
}

# Control device (mixer, etc.) for the card
ctl.digital-hw {
  type hw
  card 0
}

# Direct software mixing plugin for analog output on the card
# Do not use this directly--it requires specific rate, channels, and format
pcm.dmix-analog {
  type dmix
  ipc_key 1234
  slave {
    pcm "analog-hw"
    period_time 0
    period_size 1024
    buffer_size 4096
    rate 48000
  } 
}

# Control device (mixer, etc.) for the card
ctl.dmix-analog {
  type hw
  card 0
}

# Direct software mixing plugin for digital (S/PDIF) output on the card
# Do not use this directly--it requires specific rate, channels, and format
pcm.dmix-digital {
  type dmix
  ipc_key 1235
  slave {
    pcm "digital-hw"
    period_time 0
    period_size 1024
    buffer_size 4096
    rate 48000
  } 
}

# Control device (mixer, etc.) for the card
ctl.dmix-digital {
  type hw
  card 0
}


!!System wide config file (/etc/asound.conf)

# ~/.asoundrc or /etc/asound.conf
# ALSA configuration file

##### USAGE #####
# Save this file as "~/.asoundrc" (for user-specific sound configuration) or
# "/etc/asound.conf" (for system-wide sound configuration) and specify ALSA
# device names ad described in the next section.


##### DEVICE NAMES #####
# This configuration file defines four devices for use by the user.  Those
# devices are "analog", "mixed-analog", "digital", and "mixed-digital".  The
# user may also re-define "default" to be identical to one of the above-named
# devices (i.e. to send all sound output to the digital output unless otherwise
# specified).  Use the device names as described below:
#  - "analog" outputs to the analog output directly and (at least on software
#  sound cards) blocks other audio output.  After playback completes, "queued"
#  sounds are output in sequence.
#  - "mixed-analog" mixes audio output from multiple programs into the analog
#  output (so you can hear beeps, alerts, and other noises while playing back
#  an audio stream).
#  - "digital" outputs to the digital output directly.  Since most (all?)
#  digital outputs expect 48kHz PCM audio, this may not work for some playback
#  (i.e. CD's--which are 44.1kHz PCM audio--or 32kHz audio streams from TV
#  recordings, etc.).
#  - "mixed-digital"

# All other devices created within this file are used only by the configuration
# file itself and should /not/ be used directly.  In other words, do not use
# the devices "analog-hw", "dmix-analog", "digital-hw", or "dmix-digital".


##### IMPORTANT #####
# To make this ALSA configuration file work with your sound card, you will need
# to define the appropriate card and device information for the "analog-hw" and
# "digital-hw" devices below.  You can find the card and device information
# using "aplay -l".


##### Configuration File #####

# Override the default output used by ALSA.  If you do not override the
# default, your default device is identical to the (unmixed) "analog" device
# shown below.  If you prefer mixed and/or digital output, uncomment the
# appropriate four lines below (only one slave.pcm line).
#
# Note, also, that as of ALSA 1.0.9, "software" sound cards have been modified
# such that their default "default" device is identical to the "mixed-analog"
# device.  Whether using an ALSA version before or after 1.0.9, it does no harm
# and has no affect on performance to redefine the device (even if the
# redefinition does not change anything).  Also, by using this ALSA
# configuration file, you once again have access to unmixed analog output using
# the "analog" device.
pcm.!default {
  type plug
## Uncomment the following to use "mixed-analog" by default
#  slave.pcm "dmix-analog"
## Uncomment the following to use (unmixed) "digital" by default
  slave.pcm "digital-hw"
## Uncomment the following to use "mixed-digital" by default
#  slave.pcm "dmix-digital"
}

# Control device (mixer, etc.) for the card
ctl.!default {
  type hw
  card 0
}

# Alias for (converted) analog output on the card
# - This is identical to the device named "default"--which always exists and
# refers to hw:0,0 (unless overridden)
# - Therefore, we can specify "hw:0,0", "default", or "analog" to access analog
# output on the card
# - Note that as of ALSA 1.0.9, "software" sound card definitions redefine
# "default" to do mixing, meaning this device is different from "default" and
# allows playback while blocking other sound sources (until playback
# completes).
pcm.analog {
  type plug
  slave.pcm "analog-hw"
}

# Control device (mixer, etc.) for the card
ctl.analog {
  type hw
  card 0
}

# Alias for (converted) mixed analog output on the card
# - This will accept audio input--regardless of rate--and convert to the rate
# required for the dmix plugin (in this case 48000Hz)
# - Note that as of ALSA 1.0.9, "software" sound card definitions redefine
# "default" to do mixing, meaning this device is identical to "default" for
# "software" sound cards.
pcm.mixed-analog {
  type plug
  slave.pcm "dmix-analog"
}

# Control device (mixer, etc.) for the card
ctl.mixed-analog {
  type hw
  card 0
}

# Alias for (converted) digital (S/PDIF) output on the card
# - This will accept audio input--regardless of rate--and convert to the rate
# required for the S/PDIF hardware (in this case 48000Hz)
pcm.digital {
  type plug
  slave.pcm "digital-hw"
}

# Control device (mixer, etc.) for the card
ctl.digital {
  type hw
  card 0
}

# Alias for mixed (converted) digital (S/PDIF) output on the card
#  - This will accept audio input--regardless of rate--and convert to the rate
#  required for the S/PDIF hardware (in this case 48000Hz)
pcm.mixed-digital {
  type plug
  slave.pcm "dmix-digital"
}

# Control device (mixer, etc.) for the card
ctl.mixed-digital {
  type hw
  card 0
}

# The following devices are not useful by themselves.  They require specific
# rates, channels, and formats.  Therefore, you probably do not want to use
# them directly.  Instead use of of the devices defined above.

# Alias for analog output on the card
# Do not use this directly--it requires specific rate, channels, and format
pcm.analog-hw {
  type hw
  card 0
  # The default value for device is 0, so no need to specify
#  - Uncomment one of the below or create a new "device N" line as appropriate
#    for your sound card or 
#  device 1
#  device 4
}

# Control device (mixer, etc.) for the card
ctl.analog-hw {
  type hw
  card 0
}

# Alias for digital (S/PDIF) output on the card
# Do not use this directly--it requires specific rate, channels, and format
pcm.digital-hw {
  type hw
  card 0
#  device 1
#  - Comment out "device 1" above and uncomment one of the below or create a
#    new "device N" line as appropriate for your sound card or 
  device 2
#  device 4
}

# Control device (mixer, etc.) for the card
ctl.digital-hw {
  type hw
  card 0
}

# Direct software mixing plugin for analog output on the card
# Do not use this directly--it requires specific rate, channels, and format
pcm.dmix-analog {
  type dmix
  ipc_key 1234
  slave {
    pcm "analog-hw"
    period_time 0
    period_size 1024
    buffer_size 4096
    rate 48000
  } 
}

# Control device (mixer, etc.) for the card
ctl.dmix-analog {
  type hw
  card 0
}

# Direct software mixing plugin for digital (S/PDIF) output on the card
# Do not use this directly--it requires specific rate, channels, and format
pcm.dmix-digital {
  type dmix
  ipc_key 1235
  slave {
    pcm "digital-hw"
    period_time 0
    period_size 1024
    buffer_size 4096
    rate 48000
  } 
}

# Control device (mixer, etc.) for the card
ctl.dmix-digital {
  type hw
  card 0
}


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: CK804 [NVidia CK804], device 0: Intel ICH [NVidia CK804]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: CK804 [NVidia CK804], device 2: Intel ICH - IEC958 [NVidia CK804 - IEC958]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: CK804 [NVidia CK804], device 0: Intel ICH [NVidia CK804]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: CK804 [NVidia CK804], device 1: Intel ICH - MIC ADC [NVidia CK804 - MIC ADC]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [CK804]

Card hw:0 'CK804'/'NVidia CK804 with ALC850 at irq 22'
  Mixer name	: 'Realtek ALC850 rev 0'
  Components	: 'AC97a:414c4790'
  Controls      : 42
  Simple ctrls  : 27
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 17 [55%] [-21.00dB] [on]
  Front Right: Playback 17 [55%] [-21.00dB] [on]
Simple mixer control 'Master Mono',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 17 [55%] [-21.00dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 9 [29%] [-21.00dB] [on]
  Front Right: Playback 9 [29%] [-21.00dB] [on]
Simple mixer control 'Surround',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-46.50dB] [off]
  Front Right: Playback 0 [0%] [-46.50dB] [off]
Simple mixer control 'Surround Jack Mode',0
  Capabilities: enum
  Items: 'Shared' 'Independent'
  Item0: 'Shared'
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 31 [100%] [0.00dB] [off]
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 0 [0%] [-46.50dB] [off]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 0 [0%] [-34.50dB] [off] Capture [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off] Capture [off]
Simple mixer control 'CD',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 9 [29%] [-21.00dB] [on] Capture [off]
  Front Right: Playback 9 [29%] [-21.00dB] [on] Capture [off]
Simple mixer control 'Mic',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono: Playback 0 [0%] [-34.50dB] [off]
  Front Left: Capture [on]
  Front Right: Capture [on]
Simple mixer control 'Mic Boost (+20dB)',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Mic Front Input',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Mic Select',0
  Capabilities: enum
  Items: 'Mic1' 'Mic2'
  Item0: 'Mic1'
Simple mixer control 'Video',0
  Capabilities: cswitch cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'Phone',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono: Playback 0 [0%] [-34.50dB] [off]
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined cswitch cswitch-joined
  Playback channels: Mono
  Capture channels: Mono
  Mono: Playback [on] Capture [off]
Simple mixer control 'IEC958 Playback AC97-SPSA',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 3
  Mono: 3 [100%]
Simple mixer control 'IEC958 Playback Source',0
  Capabilities: enum
  Items: 'PCM' 'Analog In' 'IEC958 In'
  Item0: 'PCM'
Simple mixer control 'PC Speaker',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 15
  Mono: Playback 8 [53%] [-21.00dB] [on]
Simple mixer control 'Aux',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 0 [0%] [-34.50dB] [off] Capture [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off] Capture [off]
Simple mixer control 'Mono Output Select',0
  Capabilities: enum
  Items: 'Mix' 'Mic'
  Item0: 'Mix'
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch cswitch-joined
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 15
  Front Left: Capture 13 [87%] [19.50dB] [on]
  Front Right: Capture 13 [87%] [19.50dB] [on]
Simple mixer control 'Mix',0
  Capabilities: cswitch cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'Mix Mono',0
  Capabilities: cswitch cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'Channel Mode',0
  Capabilities: enum
  Items: '2ch' '4ch' '6ch' '8ch'
  Item0: '6ch'
Simple mixer control 'Duplicate Front',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'External Amplifier',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]


!!Alsactl output
!!-------------

--startcollapse--
state.CK804 {
	control.1 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Master Playback Switch'
		value true
	}
	control.2 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -4650
		comment.dbmax 0
		iface MIXER
		name 'Master Playback Volume'
		value.0 17
		value.1 17
	}
	control.3 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Center Playback Switch'
		value false
	}
	control.4 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 31'
		comment.dbmin -4650
		comment.dbmax 0
		iface MIXER
		name 'Center Playback Volume'
		value 31
	}
	control.5 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'LFE Playback Switch'
		value false
	}
	control.6 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 31'
		comment.dbmin -4650
		comment.dbmax 0
		iface MIXER
		name 'LFE Playback Volume'
		value 0
	}
	control.7 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Surround Playback Switch'
		value.0 false
		value.1 false
	}
	control.8 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -4650
		comment.dbmax 0
		iface MIXER
		name 'Surround Playback Volume'
		value.0 0
		value.1 0
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Master Mono Playback Switch'
		value true
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 31'
		comment.dbmin -4650
		comment.dbmax 0
		iface MIXER
		name 'Master Mono Playback Volume'
		value 17
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'PC Speaker Playback Switch'
		value true
	}
	control.12 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 15'
		comment.dbmin -4500
		comment.dbmax 0
		iface MIXER
		name 'PC Speaker Playback Volume'
		value 8
	}
	control.13 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Phone Playback Switch'
		value false
	}
	control.14 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'Phone Playback Volume'
		value 0
	}
	control.15 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Mic Playback Switch'
		value false
	}
	control.16 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'Mic Playback Volume'
		value 0
	}
	control.17 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Mic Boost (+20dB)'
		value false
	}
	control.18 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Line Playback Switch'
		value false
	}
	control.19 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'Line Playback Volume'
		value.0 0
		value.1 0
	}
	control.20 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'CD Playback Switch'
		value true
	}
	control.21 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'CD Playback Volume'
		value.0 9
		value.1 9
	}
	control.22 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Aux Playback Switch'
		value false
	}
	control.23 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'Aux Playback Volume'
		value.0 0
		value.1 0
	}
	control.24 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'PCM Playback Switch'
		value true
	}
	control.25 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'PCM Playback Volume'
		value.0 9
		value.1 9
	}
	control.26 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 2
		comment.item.0 Mic
		comment.item.1 CD
		comment.item.2 Video
		comment.item.3 Aux
		comment.item.4 Line
		comment.item.5 Mix
		comment.item.6 'Mix Mono'
		comment.item.7 Phone
		iface MIXER
		name 'Capture Source'
		value.0 Mic
		value.1 Mic
	}
	control.27 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Capture Switch'
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
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mix
		comment.item.1 Mic
		iface MIXER
		name 'Mono Output Select'
		value Mix
	}
	control.30 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic1
		comment.item.1 Mic2
		iface MIXER
		name 'Mic Select'
		value Mic1
	}
	control.31 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.32 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value cf00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
	}
	control.33 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Default'
		value '0082000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.34 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Switch'
		value true
	}
	control.35 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 3'
		iface MIXER
		name 'IEC958 Playback AC97-SPSA'
		value 3
	}
	control.36 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Duplicate Front'
		value false
	}
	control.37 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Mic Front Input Switch'
		value false
	}
	control.38 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Shared
		comment.item.1 Independent
		iface MIXER
		name 'Surround Jack Mode'
		value Shared
	}
	control.39 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 '2ch'
		comment.item.1 '4ch'
		comment.item.2 '6ch'
		comment.item.3 '8ch'
		iface MIXER
		name 'Channel Mode'
		value '6ch'
	}
	control.40 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Capture Switch'
		value false
	}
	control.41 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 PCM
		comment.item.1 'Analog In'
		comment.item.2 'IEC958 In'
		iface MIXER
		name 'IEC958 Playback Source'
		value PCM
	}
	control.42 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'External Amplifier'
		value true
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
nls_utf8
cifs
fuse
autofs4
sunrpc
ip6t_REJECT
nf_conntrack_ipv6
ip6table_filter
ip6_tables
ipv6
or51132
cx88_dvb
cx88_vp3054_i2c
msp3400
videobuf_dvb
saa7115
dvb_core
tuner_simple
tuner_types
tda9887
tda8290
tuner
cx8800
ivtv
snd_intel8x0
cx8802
snd_ac97_codec
ac97_bus
cx88xx
snd_seq_dummy
compat_ioctl32
videodev
snd_seq_oss
snd_seq_midi_event
firewire_ohci
ir_common
i2c_algo_bit
firewire_core
crc_itu_t
snd_seq
v4l1_compat
cx2341x
sata_nv
snd_seq_device
btcx_risc
videobuf_dma_sg
v4l2_common
snd_pcm_oss
snd_mixer_oss
tveeprom
videobuf_core
snd_pcm
i2c_nforce2
i2c_core
snd_timer
k8temp
shpchp
snd
soundcore
hwmon
snd_page_alloc
ppdev
forcedeth
parport_pc
pcspkr
joydev
parport
serio_raw
lirc_mceusb
floppy
lirc_dev
ata_generic
pata_acpi
pata_amd


!!ALSA/HDA dmesg
!!------------------




--MP_/rta3ZL0xENVwye1FM1JH458
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--MP_/rta3ZL0xENVwye1FM1JH458--
