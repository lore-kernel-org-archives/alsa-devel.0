From: gt bradley <baykelper@gmail.com>
Subject: multi-channel set up on PS3
Date: Wed, 18 Jul 2007 23:55:06 -0700
Message-ID: <469F0ACA.1080805@gmail.com>
References: <4689B1BF.2050709@gmail.com>	<s5hps39a4hv.wl%tiwai@suse.de>	<468A9A7A.7020802@gmail.com>
	<s5hfy44a8rn.wl%tiwai@suse.de> <468C47FD.7070003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 8AEE8103867
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Jul 2007 08:50:44 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id m22so414636nzf
	for <alsa-devel@alsa-project.org>; Wed, 18 Jul 2007 23:50:43 -0700 (PDT)
In-Reply-To: <468C47FD.7070003@gmail.com>
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

I'm running Fedora 7 on a PS3  (2.6.22 kernel, 1.0.14rc2 alsa).

I'm trying to create a multi-channel device by following the 
instructions at:
http://www.alsa-project.org/alsa-doc/doc-php/asoundrc.php

On the section on "virtual multi channel devices"

I also tried changing the slave b hardware number to 7 to match my set-up.
( and tried putting 7 -> 0 and 1->0 to make the snd_ps3 the "second" 
device w/o record).

attempting to run the test command yeilds:
[root@ps3 Surround-SDL-testfiles]# arecord -f S16_LE -r 44100 -c 4 -D 
multi | aplay -f S16_LE -r 44100 -c 4 -D multi
arecord: main:545: audio open error: No such file or directory
aplay: playback:2018: read error

to remove the record part of things, I've also tried :
[root@ps3 Surround-SDL-testfiles]#  aplay -f S16_LE -r 44100 -c 4 -D 
multi dolby-canyon.ogg
Playing raw data 'dolby-canyon.ogg' : Signed 16 bit Little Endian, Rate 
44100 Hz, Channels 4
aplay: set_params:878: Broken configuration for this PCM: no 
configurations available

(I also tried Big-endian).

Looking at 
http://bugtrack.alsa-project.org/main/index.php/Matrix:Module-usb-audio

the relevent part of my kernel config file is below: and the output of 
lsmod.
I notice that soundcore.o is in my build tree, but I'm unable to find a 
soundcore.ko file.  I'm assuming that this is being statically linked 
into the kernel.  (I can find .soundcore_open in the System.map file for 
my kernel).  this looks reasonable to me.


 From my various tries at this I believe I have a configuration issue, 
and would appriciate some pointers in the right direction.

thanks
GT



***********Config info: ******************
I'm able to run speaker-test -c 2 and get sound out of L&R for each of 
the two cards.


the output of aplay -l is
 [root@ps3 Surround-SDL-testfiles]# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: PS3 [PS3], device 0: SPDIF [SPDIF]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 7: MP3 [Sound Blaster MP3+], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

The out-put of aplay -l is as follows:
[root@ps3 Surround-SDL-testfiles]# aplay -L
null
    Discard all samples (playback) or generate zero samples (capture)
default:CARD=MP3
    Sound Blaster MP3+, USB Audio
    Default Audio Device
front:CARD=MP3,DEV=0
    Sound Blaster MP3+, USB Audio
    Front speakers
surround40:CARD=MP3,DEV=0
    Sound Blaster MP3+, USB Audio
    4.0 Surround output to Front and Rear speakers
surround41:CARD=MP3,DEV=0
    Sound Blaster MP3+, USB Audio
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=MP3,DEV=0
    Sound Blaster MP3+, USB Audio
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=MP3,DEV=0
    Sound Blaster MP3+, USB Audio
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=MP3,DEV=0
    Sound Blaster MP3+, USB Audio
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
iec958:CARD=MP3,DEV=0
    Sound Blaster MP3+, USB Audio
    IEC958 (S/PDIF) Digital Audio Output

>From 
http://bugtrack.alsa-project.org/main/index.php/Matrix:Vendor-Creative_Labs
I see that only analog output is supported


.configure file:

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
# CONFIG_SND_SEQUENCER_OSS is not set
# CONFIG_SND_DYNAMIC_MINORS is not set
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# ALSA PowerMac devices
#

#
# ALSA PowerMac requires I2C
#

#
# ALSA PowerPC devices

***** loaded modules ****
[root@ps3 usb]# lsmod
Module                  Size  Used by
hidp                   27896  0
rfcomm                 59208  0
l2cap                  34312  6 hidp,rfcomm
snd_usb_audio         114200  0
snd_usb_lib            25544  1 snd_usb_audio
snd_rawmidi            34408  1 snd_usb_lib
snd_ps3                19128  0
hci_usb                23172  2
bluetooth              81524  8 hidp,rfcomm,l2cap,hci_usb
usb_storage            54236  0
snd_seq_device         11692  1 snd_rawmidi
snd_hwdep              14368  1 snd_usb_audio
snd_pcm               123132  2 snd_usb_audio,snd_ps3
usbhid                 28828  0
snd_page_alloc         10816  1 snd_pcm
sys_manager             7052  0 [permanent]
snd_timer              33872  1 snd_pcm
snd                    77328  7 
snd_usb_audio,snd_rawmidi,snd_ps3,snd_seq_device,snd_hwdep,snd_pcm,snd_timer
sg                     46816  0
ext2                   75584  5
