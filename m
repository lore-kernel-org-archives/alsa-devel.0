From: "Blacky (alsa-devel)" <alsa-devel@blackdog.shacknet.nu>
Subject: Re: Status of HDMI on Nvidia 10de:0774 device
	(AsusM3N-H	HDMI
Date: Thu, 16 Oct 2008 08:15:20 +1100
Message-ID: <assp.0174c97161.59BA8640D0DC924897A613C8240D88390442BA@vex.jingella.net>
References: <59BA8640D0DC924897A613C8240D88390442B4@vex.jingella.net>
	<s5h3aj096l4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jingella.dyndns.org (unknown [124.189.101.81])
	by alsa0.perex.cz (Postfix) with ESMTP id A10EE244A9
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Oct 2008 23:15:37 +0200 (CEST)
Received: from dalmatian.dnsdojo.net (localhost.localdomain [127.0.0.1])
	by jingella.dyndns.org (8.13.8/8.13.8) with ESMTP id m9FLFEaH021773
	for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2008 08:15:16 +1100
Content-class: urn:content-classes:message
In-Reply-To: <s5h3aj096l4.wl%tiwai@suse.de>
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


Hi List Members,

> Subject: Re: [alsa-devel] Status of HDMI on Nvidia 10de:0774 device
> (AsusM3N-H HDMI
> 
> > patches for nvhdmi. (By latest, I just checked them from CVS today,
> > they seem

> Do you mean git?  We have no more CVS.

I stand corrected :-)

> It's the PCI ID of the HD-audio *controller*.  The audio codecs aren't
> listed there.  And, yes, this controller is supported.
> 
> Takashi


Thank you for confirming that.  I have had no luck getting sound from
HDMI as yet.  

The short of it is, 'aplay -Dhdmi' attempts to open the device
'/dev/snd/pcmC0D3p', which
doesn't exists. The reporting tools show the HDMI as being
/dev/snd/pcmC0D4p..

The (very) long follows....

I used git pull to make sure my tree was the absolute "latest"..  What
is the git
command to show be the build number? I used 'git log' which produced
output
starting with:

commit dbae2ea3627142cb382e6f5a2a7ade02a8502a09
Author: Takashi Iwai <tiwai@suse.de>
Date:   Fri Sep 26 12:27:38 2008 +0200

Some details..

root@mythtv:/# find /dev/snd -ls
 12478    0 drwxr-xr-x   2 root     root          240 Oct 14 21:58
/dev/snd
 12747    0 crw-rw----   1 root     audio             Oct 14 21:58
/dev/snd/controlC0
 12741    0 crw-rw----   1 root     audio             Oct 14 21:58
/dev/snd/hwC0D0
 12735    0 crw-rw----   1 root     audio             Oct 14 21:58
/dev/snd/hwC0D3
 12717    0 crw-rw----   1 root     audio             Oct 14 22:11
/dev/snd/pcmC0D0c
 12711    0 crw-rw----   1 root     audio             Oct 14 22:13
/dev/snd/pcmC0D0p
 12699    0 crw-rw----   1 root     audio             Oct 14 21:58
/dev/snd/pcmC0D1p
 12693    0 crw-rw----   1 root     audio             Oct 14 21:58
/dev/snd/pcmC0D2c
 12685    0 crw-rw----   1 root     audio             Oct 14 21:58
/dev/snd/pcmC0D4p
 12489    0 crw-rw----   1 root     audio             Oct 14 21:58
/dev/snd/seq
 12479    0 crw-rw----   1 root     audio             Oct 14 21:58
/dev/snd/timer

# Note the existence of /dev/snd/pcmC0D4p.  This is the HDMI output.

root@mythtv:/dev/snd# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: NVidia [HDA NVidia], device 0: ALC888 Analog [ALC888 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: NVidia [HDA NVidia], device 1: ALC888 Digital [ALC888 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: NVidia [HDA NVidia], device 4: NVIDIA HDMI [NVIDIA HDMI]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

root@mythtv:/dev/snd# aplay -L
default:CARD=NVidia
    HDA NVidia, ALC888 Analog
    Default Audio Device
front:CARD=NVidia,DEV=0
    HDA NVidia, ALC888 Analog
    Front speakers
surround40:CARD=NVidia,DEV=0
    HDA NVidia, ALC888 Analog
    4.0 Surround output to Front and Rear speakers
surround41:CARD=NVidia,DEV=0
    HDA NVidia, ALC888 Analog
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=NVidia,DEV=0
    HDA NVidia, ALC888 Analog
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=NVidia,DEV=0
    HDA NVidia, ALC888 Analog
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=NVidia,DEV=0
    HDA NVidia, ALC888 Analog
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
hdmi:CARD=NVidia,DEV=0
    HDA NVidia
    HDMI Audio Output
null
    Discard all samples (playback) or generate zero samples (capture)

root@mythtv:/proc# find asound -ls
4026532090    0 dr-xr-xr-x   5 root     root            0 Oct 14 22:27
asound
4026532172    0 lrwxrwxrwx   1 root     root            5 Oct 14 22:27
asound/NVidia -> card0
4026532115    0 dr-xr-xr-x   7 root     root            0 Oct 14 22:27
asound/card0
4026532174    0 -rw-r--r--   1 root     root            0 Oct 14 22:27
asound/card0/oss_mixer
4026532173    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/card0/id
4026532171    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/card0/codec#0
4026532170    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/card0/codec#3
4026532157    0 dr-xr-xr-x   3 root     root            0 Oct 14 22:27
asound/card0/pcm4p
4026532160    0 dr-xr-xr-x   2 root     root            0 Oct 14 22:27
asound/card0/pcm4p/sub0
4026532166    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm4p/sub0/prealloc_max
4026532165    0 -rw-r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm4p/sub0/prealloc
4026532164    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm4p/sub0/status
4026532163    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm4p/sub0/sw_params
4026532162    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm4p/sub0/hw_params
4026532161    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm4p/sub0/info
4026532159    0 -rw-r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm4p/xrun_debug
4026532158    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm4p/info
4026532147    0 dr-xr-xr-x   3 root     root            0 Oct 14 22:27
asound/card0/pcm2c
4026532150    0 dr-xr-xr-x   2 root     root            0 Oct 14 22:27
asound/card0/pcm2c/sub0
4026532156    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm2c/sub0/prealloc_max
4026532155    0 -rw-r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm2c/sub0/prealloc
4026532154    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm2c/sub0/status
4026532153    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm2c/sub0/sw_params
4026532152    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm2c/sub0/hw_params
4026532151    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm2c/sub0/info
4026532149    0 -rw-r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm2c/xrun_debug
4026532148    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm2c/info
4026532137    0 dr-xr-xr-x   3 root     root            0 Oct 14 22:27
asound/card0/pcm1p
4026532167    0 -rw-r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm1p/oss
4026532140    0 dr-xr-xr-x   2 root     root            0 Oct 14 22:27
asound/card0/pcm1p/sub0
4026532146    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm1p/sub0/prealloc_max
4026532145    0 -rw-r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm1p/sub0/prealloc
4026532144    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm1p/sub0/status
4026532143    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm1p/sub0/sw_params
4026532142    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm1p/sub0/hw_params
4026532141    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm1p/sub0/info
4026532139    0 -rw-r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm1p/xrun_debug
4026532138    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm1p/info
4026532125    0 dr-xr-xr-x   3 root     root            0 Oct 14 22:27
asound/card0/pcm0c
4026532169    0 -rw-r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm0c/oss
4026532128    0 dr-xr-xr-x   2 root     root            0 Oct 14 22:27
asound/card0/pcm0c/sub0
4026532136    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm0c/sub0/prealloc_max
4026532135    0 -rw-r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm0c/sub0/prealloc
4026532132    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm0c/sub0/status
4026532131    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm0c/sub0/sw_params
4026532130    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm0c/sub0/hw_params
4026532129    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm0c/sub0/info
4026532127    0 -rw-r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm0c/xrun_debug
4026532126    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm0c/info
4026532117    0 dr-xr-xr-x   3 root     root            0 Oct 14 22:27
asound/card0/pcm0p
4026532168    0 -rw-r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm0p/oss
4026532120    0 dr-xr-xr-x   2 root     root            0 Oct 14 22:27
asound/card0/pcm0p/sub0
4026532134    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm0p/sub0/prealloc_max
4026532133    0 -rw-r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm0p/sub0/prealloc
4026532124    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm0p/sub0/status
4026532123    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm0p/sub0/sw_params
4026532122    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm0p/sub0/hw_params
4026532121    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm0p/sub0/info
4026532119    0 -rw-r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm0p/xrun_debug
4026532118    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/card0/pcm0p/info
4026532114    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/pcm
4026532112    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/hwdep
4026532107    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/timers
4026532098    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/meminfo
4026532097    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/modules
4026532096    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/cards
4026532094    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/devices
4026532093    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/version
4026532092    0 dr-xr-xr-x   2 root     root            0 Oct 14 22:27
asound/seq
4026532111    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/seq/oss
4026532110    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/seq/timer
4026532109    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/seq/clients
4026532108    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/seq/queues
4026532106    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/seq/drivers
4026532091    0 dr-xr-xr-x   2 root     root            0 Oct 14 22:27
asound/oss
4026532099    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/oss/sndstat
4026532095    0 -r--r--r--   1 root     root            0 Oct 14 22:27
asound/oss/devices

Again, note asound/card0/pcm4p..

root@mythtv:/proc# cat /proc/asound/card0/pcm4p/info
card: 0
device: 4
subdevice: 0
stream: PLAYBACK
id: NVIDIA HDMI
name: NVIDIA HDMI
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

Finally..

root@mythtv:/usr/src/alsa/dev/alsa-utils/speaker-test/samples# aplay
Front_Center.wav
Playing WAVE 'Front_Center.wav' : Signed 16 bit Little Endian, Rate
48000 Hz, Mono
-- Audio from speakers in main 'front' speaker plug

root@mythtv:/usr/src/alsa/dev/alsa-utils/speaker-test/samples# aplay
-Drubbish Front_Center.wav
ALSA lib pcm.c:2202:(snd_pcm_open_noupdate) Unknown PCM rubbish
aplay: main:583: audio open error: No such file or directory

root@mythtv:/usr/src/alsa/dev/alsa-utils/speaker-test/samples# aplay
-Dhdmi Front_Center.wav
aplay: main:583: audio open error: No such file or directory

--- Here, we see it understands the difference between 'hdmi' and
'rubbish'.  What is the error?

root@mythtv:/usr/src/alsa/dev/alsa-utils/speaker-test/samples# strace
-eaccess,stat,lstat,open aplay -Dhdmi Front_Center.wav 
--- output trimmed to remove loading of locale and support libraries
unrelated to alsa

open("/lib/librt.so.1", O_RDONLY)       = 3
access("/etc/asound.conf", R_OK)        = -1 ENOENT (No such file or
directory)
access("/root/.asoundrc", R_OK)         = -1 ENOENT (No such file or
directory)

-- no files for /root/.asoundrc or /etc/asound.conf 

open("/dev/snd/controlC0", O_RDONLY)    = 3
open("/dev/snd/controlC0", O_RDONLY)    = 3
open("/dev/snd/controlC0", O_RDWR)      = 3
open("/dev/snd/controlC1", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/dev/aloadC1", O_RDONLY)          = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC2", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/dev/aloadC2", O_RDONLY)          = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC3", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/dev/aloadC3", O_RDONLY)          = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC4", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/dev/aloadC4", O_RDONLY)          = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC5", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/dev/aloadC5", O_RDONLY)          = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC6", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/dev/aloadC6", O_RDONLY)          = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC7", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/dev/aloadC7", O_RDONLY)          = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC8", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/dev/aloadC8", O_RDONLY)          = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC9", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/dev/aloadC9", O_RDONLY)          = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC10", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC10", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC11", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC11", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC12", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC12", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC13", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC13", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC14", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC14", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC15", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC15", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC16", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC16", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC17", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC17", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC18", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC18", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC19", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC19", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC20", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC20", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC21", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC21", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC22", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC22", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC23", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC23", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC24", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC24", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC25", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC25", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC26", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC26", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC27", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC27", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC28", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC28", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC29", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC29", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC30", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC30", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC31", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC31", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC0", O_RDONLY)    = 3
open("/dev/snd/controlC0", O_RDONLY)    = 3
open("/dev/snd/controlC0", O_RDWR)      = 3
open("/dev/snd/controlC0", O_RDONLY)    = 3
open("/dev/snd/controlC0", O_RDWR)      = 3
open("/dev/snd/pcmC0D3p", O_RDWR|O_NONBLOCK) = -1 ENOENT (No such file
or directory)
audio open error: No such file or directory
Process 11545 detached

-- /dev/snd/pcmC0D3p ???

My understanding of alsa is quite limited, so any pointers would be very
welcome.

If I'm barking up the wrong tree, and should move this to the user list,
just let
me know.

Regards
Blacky



-- too much information follows

root@mythtv:/proc# find asound -type f|xargs grep .
asound/card0/oss_mixer:VOLUME "Master" 0
asound/card0/oss_mixer:BASS "" 0
asound/card0/oss_mixer:TREBLE "" 0
asound/card0/oss_mixer:SYNTH "" 0
asound/card0/oss_mixer:PCM "" 0
asound/card0/oss_mixer:SPEAKER "" 0
asound/card0/oss_mixer:LINE "Line" 0
asound/card0/oss_mixer:MIC "Mic" 0
asound/card0/oss_mixer:CD "" 0
asound/card0/oss_mixer:IMIX "" 0
asound/card0/oss_mixer:ALTPCM "Headphone" 0
asound/card0/oss_mixer:RECLEV "" 0
asound/card0/oss_mixer:IGAIN "Capture" 0
asound/card0/oss_mixer:OGAIN "" 0
asound/card0/oss_mixer:LINE1 "" 0
asound/card0/oss_mixer:LINE2 "" 0
asound/card0/oss_mixer:LINE3 "" 0
asound/card0/oss_mixer:DIGITAL1 "IEC958" 0
asound/card0/oss_mixer:DIGITAL2 "" 0
asound/card0/oss_mixer:DIGITAL3 "" 0
asound/card0/oss_mixer:PHONEIN "" 0
asound/card0/oss_mixer:PHONEOUT "" 0
asound/card0/oss_mixer:VIDEO "" 0
asound/card0/oss_mixer:RADIO "" 0
asound/card0/oss_mixer:MONITOR "" 0
asound/card0/id:NVidia
asound/card0/codec#0:Codec: Realtek ALC888
asound/card0/codec#0:Address: 0
asound/card0/codec#0:Vendor Id: 0x10ec0888
asound/card0/codec#0:Subsystem Id: 0x10438321
asound/card0/codec#0:Revision Id: 0x100101
asound/card0/codec#0:No Modem Function Group found
asound/card0/codec#0:Default PCM:
asound/card0/codec#0:    rates [0x560]: 44100 48000 96000 192000
asound/card0/codec#0:    bits [0xe]: 16 20 24
asound/card0/codec#0:    formats [0x1]: PCM
asound/card0/codec#0:Default Amp-In caps: N/A
asound/card0/codec#0:Default Amp-Out caps: N/A
asound/card0/codec#0:GPIO: io=2, o=0, i=0, unsolicited=1, wake=0
asound/card0/codec#0:  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0
asound/card0/codec#0:  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0
asound/card0/codec#0:Node 0x02 [Audio Output] wcaps 0x11: Stereo
asound/card0/codec#0:  Converter: stream=0, channel=0
asound/card0/codec#0:  PCM:
asound/card0/codec#0:    rates [0x560]: 44100 48000 96000 192000
asound/card0/codec#0:    bits [0xe]: 16 20 24
asound/card0/codec#0:    formats [0x1]: PCM
asound/card0/codec#0:Node 0x03 [Audio Output] wcaps 0x11: Stereo
asound/card0/codec#0:  Converter: stream=0, channel=0
asound/card0/codec#0:  PCM:
asound/card0/codec#0:    rates [0x560]: 44100 48000 96000 192000
asound/card0/codec#0:    bits [0xe]: 16 20 24
asound/card0/codec#0:    formats [0x1]: PCM
asound/card0/codec#0:Node 0x04 [Audio Output] wcaps 0x11: Stereo
asound/card0/codec#0:  Converter: stream=0, channel=0
asound/card0/codec#0:  PCM:
asound/card0/codec#0:    rates [0x560]: 44100 48000 96000 192000
asound/card0/codec#0:    bits [0xe]: 16 20 24
asound/card0/codec#0:    formats [0x1]: PCM
asound/card0/codec#0:Node 0x05 [Audio Output] wcaps 0x11: Stereo
asound/card0/codec#0:  Converter: stream=0, channel=0
asound/card0/codec#0:  PCM:
asound/card0/codec#0:    rates [0x560]: 44100 48000 96000 192000
asound/card0/codec#0:    bits [0xe]: 16 20 24
asound/card0/codec#0:    formats [0x1]: PCM
asound/card0/codec#0:Node 0x06 [Audio Output] wcaps 0x211: Stereo
Digital
asound/card0/codec#0:  Converter: stream=0, channel=0
asound/card0/codec#0:  Digital: Enabled GenLevel
asound/card0/codec#0:  Digital category: 0x2
asound/card0/codec#0:  PCM:
asound/card0/codec#0:    rates [0x5e0]: 44100 48000 88200 96000 192000
asound/card0/codec#0:    bits [0x1e]: 16 20 24 32
asound/card0/codec#0:    formats [0x1]: PCM
asound/card0/codec#0:Node 0x07 [Vendor Defined Widget] wcaps 0xf00000:
Mono
asound/card0/codec#0:Node 0x08 [Audio Input] wcaps 0x10011b: Stereo
Amp-In
asound/card0/codec#0:  Amp-In caps: ofs=0x0b, nsteps=0x1f,
stepsize=0x05, mute=1
asound/card0/codec#0:  Amp-In vals:  [0x18 0x18]
asound/card0/codec#0:  Converter: stream=0, channel=0
asound/card0/codec#0:  SDI-Select: 0
asound/card0/codec#0:  PCM:
asound/card0/codec#0:    rates [0x160]: 44100 48000 96000
asound/card0/codec#0:    bits [0x6]: 16 20
asound/card0/codec#0:    formats [0x1]: PCM
asound/card0/codec#0:  Connection: 1
asound/card0/codec#0:     0x23
asound/card0/codec#0:Node 0x09 [Audio Input] wcaps 0x10011b: Stereo
Amp-In
asound/card0/codec#0:  Amp-In caps: ofs=0x0b, nsteps=0x1f,
stepsize=0x05, mute=1
asound/card0/codec#0:  Amp-In vals:  [0x00 0x00]
asound/card0/codec#0:  Converter: stream=0, channel=0
asound/card0/codec#0:  SDI-Select: 0
asound/card0/codec#0:  PCM:
asound/card0/codec#0:    rates [0x160]: 44100 48000 96000
asound/card0/codec#0:    bits [0x6]: 16 20
asound/card0/codec#0:    formats [0x1]: PCM
asound/card0/codec#0:  Connection: 1
asound/card0/codec#0:     0x22
asound/card0/codec#0:Node 0x0a [Audio Input] wcaps 0x100391: Stereo
Digital
asound/card0/codec#0:  Converter: stream=5, channel=0
asound/card0/codec#0:  SDI-Select: 0
asound/card0/codec#0:  Digital:
asound/card0/codec#0:  Digital category: 0x0
asound/card0/codec#0:  PCM:
asound/card0/codec#0:    rates [0x160]: 44100 48000 96000
asound/card0/codec#0:    bits [0x1e]: 16 20 24 32
asound/card0/codec#0:    formats [0x1]: PCM
asound/card0/codec#0:  Unsolicited: tag=00, enabled=0
asound/card0/codec#0:  Connection: 1
asound/card0/codec#0:     0x1f
asound/card0/codec#0:Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo
Amp-In
asound/card0/codec#0:  Amp-In caps: ofs=0x17, nsteps=0x1f,
stepsize=0x05, mute=1
asound/card0/codec#0:  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80]
[0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
[0x80 0x80]
asound/card0/codec#0:  Connection: 10
asound/card0/codec#0:     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16
0x17
asound/card0/codec#0:Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo
Amp-In Amp-Out
asound/card0/codec#0:  Amp-In caps: ofs=0x00, nsteps=0x00,
stepsize=0x00, mute=1
asound/card0/codec#0:  Amp-In vals:  [0x00 0x00] [0x00 0x00]
asound/card0/codec#0:  Amp-Out caps: ofs=0x1f, nsteps=0x1f,
stepsize=0x05, mute=0
asound/card0/codec#0:  Amp-Out vals:  [0x0f 0x0f]
asound/card0/codec#0:  Connection: 2
asound/card0/codec#0:     0x02 0x0b
asound/card0/codec#0:Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo
Amp-In Amp-Out
asound/card0/codec#0:  Amp-In caps: ofs=0x00, nsteps=0x00,
stepsize=0x00, mute=1
asound/card0/codec#0:  Amp-In vals:  [0x80 0x80] [0x80 0x80]
asound/card0/codec#0:  Amp-Out caps: ofs=0x1f, nsteps=0x1f,
stepsize=0x05, mute=0
asound/card0/codec#0:  Amp-Out vals:  [0x00 0x00]
asound/card0/codec#0:  Connection: 2
asound/card0/codec#0:     0x03 0x0b
asound/card0/codec#0:Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo
Amp-In Amp-Out
asound/card0/codec#0:  Amp-In caps: ofs=0x00, nsteps=0x00,
stepsize=0x00, mute=1
asound/card0/codec#0:  Amp-In vals:  [0x80 0x80] [0x80 0x80]
asound/card0/codec#0:  Amp-Out caps: ofs=0x1f, nsteps=0x1f,
stepsize=0x05, mute=0
asound/card0/codec#0:  Amp-Out vals:  [0x00 0x00]
asound/card0/codec#0:  Connection: 2
asound/card0/codec#0:     0x04 0x0b
asound/card0/codec#0:Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo
Amp-In Amp-Out
asound/card0/codec#0:  Amp-In caps: ofs=0x00, nsteps=0x00,
stepsize=0x00, mute=1
asound/card0/codec#0:  Amp-In vals:  [0x80 0x80] [0x80 0x80]
asound/card0/codec#0:  Amp-Out caps: ofs=0x1f, nsteps=0x1f,
stepsize=0x05, mute=0
asound/card0/codec#0:  Amp-Out vals:  [0x00 0x00]
asound/card0/codec#0:  Connection: 2
asound/card0/codec#0:     0x05 0x0b
asound/card0/codec#0:Node 0x10 [Audio Output] wcaps 0x211: Stereo
Digital
asound/card0/codec#0:  Converter: stream=0, channel=0
asound/card0/codec#0:  Digital:
asound/card0/codec#0:  Digital category: 0x0
asound/card0/codec#0:  PCM:
asound/card0/codec#0:    rates [0x5e0]: 44100 48000 88200 96000 192000
asound/card0/codec#0:    bits [0x1e]: 16 20 24 32
asound/card0/codec#0:    formats [0x1]: PCM
asound/card0/codec#0:Node 0x11 [Pin Complex] wcaps 0x400300: Mono
Digital
asound/card0/codec#0:  Pincap 0x00000010: OUT
asound/card0/codec#0:  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
asound/card0/codec#0:    Conn = 1/8, Color = Black
asound/card0/codec#0:    DefAssociation = 0xf, Sequence = 0x0
asound/card0/codec#0:    Misc = NO_PRESENCE
asound/card0/codec#0:  Pin-ctls: 0x40: OUT
asound/card0/codec#0:  Connection: 1
asound/card0/codec#0:     0x10
asound/card0/codec#0:Node 0x12 [Vendor Defined Widget] wcaps 0xf00000:
Mono
asound/card0/codec#0:Node 0x13 [Vendor Defined Widget] wcaps 0xf00000:
Mono
asound/card0/codec#0:Node 0x14 [Pin Complex] wcaps 0x40018f: Stereo
Amp-In Amp-Out
asound/card0/codec#0:  Amp-In caps: ofs=0x00, nsteps=0x03,
stepsize=0x27, mute=0
asound/card0/codec#0:  Amp-In vals:  [0x00 0x00]
asound/card0/codec#0:  Amp-Out caps: ofs=0x00, nsteps=0x00,
stepsize=0x00, mute=1
asound/card0/codec#0:  Amp-Out vals:  [0x00 0x00]
asound/card0/codec#0:  Pincap 0x0000003e: IN OUT HP Detect Trigger
asound/card0/codec#0:  Pin Default 0x01014010: [Jack] Line Out at Ext
Rear
asound/card0/codec#0:    Conn = 1/8, Color = Green
asound/card0/codec#0:    DefAssociation = 0x1, Sequence = 0x0
asound/card0/codec#0:  Pin-ctls: 0x40: OUT
asound/card0/codec#0:  Unsolicited: tag=00, enabled=0
asound/card0/codec#0:  Connection: 5
asound/card0/codec#0:     0x0c* 0x0d 0x0e 0x0f 0x26
asound/card0/codec#0:Node 0x15 [Pin Complex] wcaps 0x40018f: Stereo
Amp-In Amp-Out
asound/card0/codec#0:  Amp-In caps: ofs=0x00, nsteps=0x03,
stepsize=0x27, mute=0
asound/card0/codec#0:  Amp-In vals:  [0x00 0x00]
asound/card0/codec#0:  Amp-Out caps: ofs=0x00, nsteps=0x00,
stepsize=0x00, mute=1
asound/card0/codec#0:  Amp-Out vals:  [0x00 0x00]
asound/card0/codec#0:  Pincap 0x0000003e: IN OUT HP Detect Trigger
asound/card0/codec#0:  Pin Default 0x01011012: [Jack] Line Out at Ext
Rear
asound/card0/codec#0:    Conn = 1/8, Color = Black
asound/card0/codec#0:    DefAssociation = 0x1, Sequence = 0x2
asound/card0/codec#0:  Pin-ctls: 0x40: OUT
asound/card0/codec#0:  Unsolicited: tag=00, enabled=0
asound/card0/codec#0:  Connection: 5
asound/card0/codec#0:     0x0c 0x0d* 0x0e 0x0f 0x26
asound/card0/codec#0:Node 0x16 [Pin Complex] wcaps 0x40018f: Stereo
Amp-In Amp-Out
asound/card0/codec#0:  Amp-In caps: ofs=0x00, nsteps=0x03,
stepsize=0x27, mute=0
asound/card0/codec#0:  Amp-In vals:  [0x00 0x00]
asound/card0/codec#0:  Amp-Out caps: ofs=0x00, nsteps=0x00,
stepsize=0x00, mute=1
asound/card0/codec#0:  Amp-Out vals:  [0x00 0x00]
asound/card0/codec#0:  Pincap 0x00000036: IN OUT Detect Trigger
asound/card0/codec#0:  Pin Default 0x01016011: [Jack] Line Out at Ext
Rear
asound/card0/codec#0:    Conn = 1/8, Color = Orange
asound/card0/codec#0:    DefAssociation = 0x1, Sequence = 0x1
asound/card0/codec#0:  Pin-ctls: 0x40: OUT
asound/card0/codec#0:  Unsolicited: tag=00, enabled=0
asound/card0/codec#0:  Connection: 5
asound/card0/codec#0:     0x0c 0x0d 0x0e* 0x0f 0x26
asound/card0/codec#0:Node 0x17 [Pin Complex] wcaps 0x40018f: Stereo
Amp-In Amp-Out
asound/card0/codec#0:  Amp-In caps: ofs=0x00, nsteps=0x03,
stepsize=0x27, mute=0
asound/card0/codec#0:  Amp-In vals:  [0x00 0x00]
asound/card0/codec#0:  Amp-Out caps: ofs=0x00, nsteps=0x00,
stepsize=0x00, mute=1
asound/card0/codec#0:  Amp-Out vals:  [0x00 0x00]
asound/card0/codec#0:  Pincap 0x00000036: IN OUT Detect Trigger
asound/card0/codec#0:  Pin Default 0x01012014: [Jack] Line Out at Ext
Rear
asound/card0/codec#0:    Conn = 1/8, Color = Grey
asound/card0/codec#0:    DefAssociation = 0x1, Sequence = 0x4
asound/card0/codec#0:  Pin-ctls: 0x40: OUT
asound/card0/codec#0:  Unsolicited: tag=00, enabled=0
asound/card0/codec#0:  Connection: 5
asound/card0/codec#0:     0x0c 0x0d 0x0e 0x0f* 0x26
asound/card0/codec#0:Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo
Amp-In Amp-Out
asound/card0/codec#0:  Amp-In caps: ofs=0x00, nsteps=0x03,
stepsize=0x27, mute=0
asound/card0/codec#0:  Amp-In vals:  [0x00 0x00]
asound/card0/codec#0:  Amp-Out caps: ofs=0x00, nsteps=0x00,
stepsize=0x00, mute=1
asound/card0/codec#0:  Amp-Out vals:  [0x80 0x80]
asound/card0/codec#0:  Pincap 0x0000373e: IN OUT HP Detect Trigger
asound/card0/codec#0:    Vref caps: HIZ 50 GRD 80 100
asound/card0/codec#0:  Pin Default 0x01a19840: [Jack] Mic at Ext Rear
asound/card0/codec#0:    Conn = 1/8, Color = Pink
asound/card0/codec#0:    DefAssociation = 0x4, Sequence = 0x0
asound/card0/codec#0:  Pin-ctls: 0x24: IN VREF_80
asound/card0/codec#0:  Unsolicited: tag=00, enabled=0
asound/card0/codec#0:  Connection: 5
asound/card0/codec#0:     0x0c* 0x0d 0x0e 0x0f 0x26
asound/card0/codec#0:Node 0x19 [Pin Complex] wcaps 0x40018f: Stereo
Amp-In Amp-Out
asound/card0/codec#0:  Amp-In caps: ofs=0x00, nsteps=0x03,
stepsize=0x27, mute=0
asound/card0/codec#0:  Amp-In vals:  [0x00 0x00]
asound/card0/codec#0:  Amp-Out caps: ofs=0x00, nsteps=0x00,
stepsize=0x00, mute=1
asound/card0/codec#0:  Amp-Out vals:  [0x80 0x80]
asound/card0/codec#0:  Pincap 0x0000373e: IN OUT HP Detect Trigger
asound/card0/codec#0:    Vref caps: HIZ 50 GRD 80 100
asound/card0/codec#0:  Pin Default 0x02a19c50: [Jack] Mic at Ext Front
asound/card0/codec#0:    Conn = 1/8, Color = Pink
asound/card0/codec#0:    DefAssociation = 0x5, Sequence = 0x0
asound/card0/codec#0:  Pin-ctls: 0x24: IN VREF_80
asound/card0/codec#0:  Unsolicited: tag=00, enabled=0
asound/card0/codec#0:  Connection: 5
asound/card0/codec#0:     0x0c* 0x0d 0x0e 0x0f 0x26
asound/card0/codec#0:Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo
Amp-In Amp-Out
asound/card0/codec#0:  Amp-In caps: ofs=0x00, nsteps=0x03,
stepsize=0x27, mute=0
asound/card0/codec#0:  Amp-In vals:  [0x00 0x00]
asound/card0/codec#0:  Amp-Out caps: ofs=0x00, nsteps=0x00,
stepsize=0x00, mute=1
asound/card0/codec#0:  Amp-Out vals:  [0x80 0x80]
asound/card0/codec#0:  Pincap 0x0000373e: IN OUT HP Detect Trigger
asound/card0/codec#0:    Vref caps: HIZ 50 GRD 80 100
asound/card0/codec#0:  Pin Default 0x0181304f: [Jack] Line In at Ext
Rear
asound/card0/codec#0:    Conn = 1/8, Color = Blue
asound/card0/codec#0:    DefAssociation = 0x4, Sequence = 0xf
asound/card0/codec#0:  Pin-ctls: 0x20: IN VREF_HIZ
asound/card0/codec#0:  Unsolicited: tag=00, enabled=0
asound/card0/codec#0:  Connection: 5
asound/card0/codec#0:     0x0c* 0x0d 0x0e 0x0f 0x26
asound/card0/codec#0:Node 0x1b [Pin Complex] wcaps 0x40018f: Stereo
Amp-In Amp-Out
asound/card0/codec#0:  Amp-In caps: ofs=0x00, nsteps=0x03,
stepsize=0x27, mute=0
asound/card0/codec#0:  Amp-In vals:  [0x00 0x00]
asound/card0/codec#0:  Amp-Out caps: ofs=0x00, nsteps=0x00,
stepsize=0x00, mute=1
asound/card0/codec#0:  Amp-Out vals:  [0x00 0x00]
asound/card0/codec#0:  Pincap 0x0000373e: IN OUT HP Detect Trigger
asound/card0/codec#0:    Vref caps: HIZ 50 GRD 80 100
asound/card0/codec#0:  Pin Default 0x02214c20: [Jack] HP Out at Ext
Front
asound/card0/codec#0:    Conn = 1/8, Color = Green
asound/card0/codec#0:    DefAssociation = 0x2, Sequence = 0x0
asound/card0/codec#0:  Pin-ctls: 0xc0: OUT HP VREF_HIZ
asound/card0/codec#0:  Unsolicited: tag=04, enabled=1
asound/card0/codec#0:  Connection: 5
asound/card0/codec#0:     0x0c* 0x0d 0x0e 0x0f 0x26
asound/card0/codec#0:Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
asound/card0/codec#0:  Pincap 0x00000020: IN
asound/card0/codec#0:  Pin Default 0x593301f0: [N/A] CD at Int ATAPI
asound/card0/codec#0:    Conn = ATAPI, Color = Unknown
asound/card0/codec#0:    DefAssociation = 0xf, Sequence = 0x0
asound/card0/codec#0:    Misc = NO_PRESENCE
asound/card0/codec#0:  Pin-ctls: 0x20: IN
asound/card0/codec#0:Node 0x1d [Pin Complex] wcaps 0x400000: Mono
asound/card0/codec#0:  Pincap 0x00000020: IN
asound/card0/codec#0:  Pin Default 0x4015e601: [N/A] Speaker at Ext N/A
asound/card0/codec#0:    Conn = Optical, Color = White
asound/card0/codec#0:    DefAssociation = 0x0, Sequence = 0x1
asound/card0/codec#0:  Pin-ctls: 0x20: IN
asound/card0/codec#0:Node 0x1e [Pin Complex] wcaps 0x400300: Mono
Digital
asound/card0/codec#0:  Pincap 0x00000010: OUT
asound/card0/codec#0:  Pin Default 0x01447130: [Jack] SPDIF Out at Ext
Rear
asound/card0/codec#0:    Conn = RCA, Color = Yellow
asound/card0/codec#0:    DefAssociation = 0x3, Sequence = 0x0
asound/card0/codec#0:    Misc = NO_PRESENCE
asound/card0/codec#0:  Pin-ctls: 0x40: OUT
asound/card0/codec#0:  Connection: 1
asound/card0/codec#0:     0x06
asound/card0/codec#0:Node 0x1f [Pin Complex] wcaps 0x400200: Mono
Digital
asound/card0/codec#0:  Pincap 0x00000020: IN
asound/card0/codec#0:  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
asound/card0/codec#0:    Conn = 1/8, Color = Black
asound/card0/codec#0:    DefAssociation = 0xf, Sequence = 0x0
asound/card0/codec#0:    Misc = NO_PRESENCE
asound/card0/codec#0:  Pin-ctls: 0x20: IN
asound/card0/codec#0:Node 0x20 [Vendor Defined Widget] wcaps 0xf00040:
Mono
asound/card0/codec#0:  Processing caps: benign=0, ncoeff=17
asound/card0/codec#0:Node 0x21 [Vendor Defined Widget] wcaps 0xf00000:
Mono
asound/card0/codec#0:Node 0x22 [Audio Mixer] wcaps 0x20010b: Stereo
Amp-In
asound/card0/codec#0:  Amp-In caps: ofs=0x00, nsteps=0x00,
stepsize=0x00, mute=1
asound/card0/codec#0:  Amp-In vals:  [0x00 0x00] [0x80 0x80] [0x80 0x80]
[0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
[0x80 0x80] [0x80 0x80]
asound/card0/codec#0:  Connection: 11
asound/card0/codec#0:     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16
0x17 0x0b
asound/card0/codec#0:Node 0x23 [Audio Mixer] wcaps 0x20010b: Stereo
Amp-In
asound/card0/codec#0:  Amp-In caps: ofs=0x00, nsteps=0x00,
stepsize=0x00, mute=1
asound/card0/codec#0:  Amp-In vals:  [0x00 0x00] [0x80 0x80] [0x80 0x80]
[0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
[0x80 0x80] [0x80 0x80]
asound/card0/codec#0:  Connection: 11
asound/card0/codec#0:     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16
0x17 0x0b
asound/card0/codec#0:Node 0x24 [Vendor Defined Widget] wcaps 0xf00000:
Mono
asound/card0/codec#0:Node 0x25 [Audio Output] wcaps 0x11: Stereo
asound/card0/codec#0:  Converter: stream=0, channel=0
asound/card0/codec#0:  PCM:
asound/card0/codec#0:    rates [0x560]: 44100 48000 96000 192000
asound/card0/codec#0:    bits [0xe]: 16 20 24
asound/card0/codec#0:    formats [0x1]: PCM
asound/card0/codec#0:Node 0x26 [Audio Mixer] wcaps 0x20010f: Stereo
Amp-In Amp-Out
asound/card0/codec#0:  Amp-In caps: ofs=0x00, nsteps=0x00,
stepsize=0x00, mute=1
asound/card0/codec#0:  Amp-In vals:  [0x00 0x00] [0x00 0x00]
asound/card0/codec#0:  Amp-Out caps: ofs=0x1f, nsteps=0x1f,
stepsize=0x05, mute=0
asound/card0/codec#0:  Amp-Out vals:  [0x00 0x00]
asound/card0/codec#0:  Connection: 2
asound/card0/codec#0:     0x25 0x0b
asound/card0/codec#3:Codec: Generic 10de NVIDIA MCP78 HDMI
asound/card0/codec#3:Address: 3
asound/card0/codec#3:Vendor Id: 0x10de0002
asound/card0/codec#3:Subsystem Id: 0x10de0101
asound/card0/codec#3:Revision Id: 0x100000
asound/card0/codec#3:No Modem Function Group found
asound/card0/codec#3:Default PCM:
asound/card0/codec#3:    rates [0x0]:
asound/card0/codec#3:    bits [0x0]:
asound/card0/codec#3:    formats [0x0]:
asound/card0/codec#3:Default Amp-In caps: N/A
asound/card0/codec#3:Default Amp-Out caps: N/A
asound/card0/codec#3:GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
asound/card0/codec#3:Node 0x04 [Audio Output] wcaps 0x211: Stereo
Digital
asound/card0/codec#3:  Converter: stream=0, channel=0
asound/card0/codec#3:  Digital: Enabled
asound/card0/codec#3:  Digital category: 0x0
asound/card0/codec#3:  PCM:
asound/card0/codec#3:    rates [0xc0]: 48000 88200
asound/card0/codec#3:    bits [0xf]: 8 16 20 24
asound/card0/codec#3:    formats [0x1]: PCM
asound/card0/codec#3:Node 0x05 [Pin Complex] wcaps 0x400381: Stereo
Digital
asound/card0/codec#3:  Pincap 0x00000014: OUT Detect
asound/card0/codec#3:  Pin Default 0x18560110: [Jack] Digital Out at Int
HDMI
asound/card0/codec#3:    Conn = Digital, Color = Unknown
asound/card0/codec#3:    DefAssociation = 0x1, Sequence = 0x0
asound/card0/codec#3:    Misc = NO_PRESENCE
asound/card0/codec#3:  Pin-ctls: 0x40: OUT
asound/card0/codec#3:  Unsolicited: tag=00, enabled=0
asound/card0/codec#3:  Connection: 1
asound/card0/codec#3:     0x04
asound/card0/codec#3:Node 0x06 [Audio Output] wcaps 0x211: Stereo
Digital
asound/card0/codec#3:  Converter: stream=0, channel=0
asound/card0/codec#3:  Digital:
asound/card0/codec#3:  Digital category: 0x0
asound/card0/codec#3:  PCM:
asound/card0/codec#3:    rates [0xc0]: 48000 88200
asound/card0/codec#3:    bits [0xf]: 8 16 20 24
asound/card0/codec#3:    formats [0x1]: PCM
asound/card0/codec#3:Node 0x07 [Pin Complex] wcaps 0x400381: Stereo
Digital
asound/card0/codec#3:  Pincap 0x00000014: OUT Detect
asound/card0/codec#3:  Pin Default 0x58560121: [N/A] Digital Out at Int
HDMI
asound/card0/codec#3:    Conn = Digital, Color = Unknown
asound/card0/codec#3:    DefAssociation = 0x2, Sequence = 0x1
asound/card0/codec#3:    Misc = NO_PRESENCE
asound/card0/codec#3:  Pin-ctls: 0x00:
asound/card0/codec#3:  Unsolicited: tag=00, enabled=0
asound/card0/codec#3:  Connection: 1
asound/card0/codec#3:     0x06
asound/card0/codec#3:Node 0x08 [Audio Output] wcaps 0x211: Stereo
Digital
asound/card0/codec#3:  Converter: stream=0, channel=0
asound/card0/codec#3:  Digital:
asound/card0/codec#3:  Digital category: 0x0
asound/card0/codec#3:  PCM:
asound/card0/codec#3:    rates [0xc0]: 48000 88200
asound/card0/codec#3:    bits [0xf]: 8 16 20 24
asound/card0/codec#3:    formats [0x1]: PCM
asound/card0/codec#3:Node 0x09 [Pin Complex] wcaps 0x400381: Stereo
Digital
asound/card0/codec#3:  Pincap 0x00000014: OUT Detect
asound/card0/codec#3:  Pin Default 0x58560122: [N/A] Digital Out at Int
HDMI
asound/card0/codec#3:    Conn = Digital, Color = Unknown
asound/card0/codec#3:    DefAssociation = 0x2, Sequence = 0x2
asound/card0/codec#3:    Misc = NO_PRESENCE
asound/card0/codec#3:  Pin-ctls: 0x00:
asound/card0/codec#3:  Unsolicited: tag=00, enabled=0
asound/card0/codec#3:  Connection: 1
asound/card0/codec#3:     0x08
asound/card0/codec#3:Node 0x0a [Audio Output] wcaps 0x211: Stereo
Digital
asound/card0/codec#3:  Converter: stream=0, channel=0
asound/card0/codec#3:  Digital:
asound/card0/codec#3:  Digital category: 0x0
asound/card0/codec#3:  PCM:
asound/card0/codec#3:    rates [0xc0]: 48000 88200
asound/card0/codec#3:    bits [0xf]: 8 16 20 24
asound/card0/codec#3:    formats [0x1]: PCM
asound/card0/codec#3:Node 0x0b [Pin Complex] wcaps 0x400381: Stereo
Digital
asound/card0/codec#3:  Pincap 0x00000014: OUT Detect
asound/card0/codec#3:  Pin Default 0x58560123: [N/A] Digital Out at Int
HDMI
asound/card0/codec#3:    Conn = Digital, Color = Unknown
asound/card0/codec#3:    DefAssociation = 0x2, Sequence = 0x3
asound/card0/codec#3:    Misc = NO_PRESENCE
asound/card0/codec#3:  Pin-ctls: 0x00:
asound/card0/codec#3:  Unsolicited: tag=00, enabled=0
asound/card0/codec#3:  Connection: 1
asound/card0/codec#3:     0x0a
asound/card0/codec#3:Node 0x0c [Audio Output] wcaps 0x211: Stereo
Digital
asound/card0/codec#3:  Converter: stream=0, channel=0
asound/card0/codec#3:  Digital:
asound/card0/codec#3:  Digital category: 0x0
asound/card0/codec#3:  PCM:
asound/card0/codec#3:    rates [0xc0]: 48000 88200
asound/card0/codec#3:    bits [0xf]: 8 16 20 24
asound/card0/codec#3:    formats [0x1]: PCM
asound/card0/codec#3:Node 0x0d [Pin Complex] wcaps 0x400381: Stereo
Digital
asound/card0/codec#3:  Pincap 0x00000014: OUT Detect
asound/card0/codec#3:  Pin Default 0x58560124: [N/A] Digital Out at Int
HDMI
asound/card0/codec#3:    Conn = Digital, Color = Unknown
asound/card0/codec#3:    DefAssociation = 0x2, Sequence = 0x4
asound/card0/codec#3:    Misc = NO_PRESENCE
asound/card0/codec#3:  Pin-ctls: 0x00:
asound/card0/codec#3:  Unsolicited: tag=00, enabled=0
asound/card0/codec#3:  Connection: 0
asound/card0/pcm4p/sub0/prealloc_max:32768
asound/card0/pcm4p/sub0/prealloc:64
asound/card0/pcm4p/sub0/status:closed
asound/card0/pcm4p/sub0/sw_params:closed
asound/card0/pcm4p/sub0/hw_params:closed
asound/card0/pcm4p/sub0/info:card: 0
asound/card0/pcm4p/sub0/info:device: 4
asound/card0/pcm4p/sub0/info:subdevice: 0
asound/card0/pcm4p/sub0/info:stream: PLAYBACK
asound/card0/pcm4p/sub0/info:id: NVIDIA HDMI
asound/card0/pcm4p/sub0/info:name: NVIDIA HDMI
asound/card0/pcm4p/sub0/info:subname: subdevice #0
asound/card0/pcm4p/sub0/info:class: 0
asound/card0/pcm4p/sub0/info:subclass: 0
asound/card0/pcm4p/sub0/info:subdevices_count: 1
asound/card0/pcm4p/sub0/info:subdevices_avail: 1
asound/card0/pcm4p/xrun_debug:0
asound/card0/pcm4p/info:card: 0
asound/card0/pcm4p/info:device: 4
asound/card0/pcm4p/info:subdevice: 0
asound/card0/pcm4p/info:stream: PLAYBACK
asound/card0/pcm4p/info:id: NVIDIA HDMI
asound/card0/pcm4p/info:name: NVIDIA HDMI
asound/card0/pcm4p/info:subname: subdevice #0
asound/card0/pcm4p/info:class: 0
asound/card0/pcm4p/info:subclass: 0
asound/card0/pcm4p/info:subdevices_count: 1
asound/card0/pcm4p/info:subdevices_avail: 1
asound/card0/pcm2c/sub0/prealloc_max:32768
asound/card0/pcm2c/sub0/prealloc:64
asound/card0/pcm2c/sub0/status:closed
asound/card0/pcm2c/sub0/sw_params:closed
asound/card0/pcm2c/sub0/hw_params:closed
asound/card0/pcm2c/sub0/info:card: 0
asound/card0/pcm2c/sub0/info:device: 2
asound/card0/pcm2c/sub0/info:subdevice: 0
asound/card0/pcm2c/sub0/info:stream: CAPTURE
asound/card0/pcm2c/sub0/info:id: ALC888 Analog
asound/card0/pcm2c/sub0/info:name: ALC888 Analog
asound/card0/pcm2c/sub0/info:subname: subdevice #0
asound/card0/pcm2c/sub0/info:class: 0
asound/card0/pcm2c/sub0/info:subclass: 0
asound/card0/pcm2c/sub0/info:subdevices_count: 1
asound/card0/pcm2c/sub0/info:subdevices_avail: 1
asound/card0/pcm2c/xrun_debug:0
asound/card0/pcm2c/info:card: 0
asound/card0/pcm2c/info:device: 2
asound/card0/pcm2c/info:subdevice: 0
asound/card0/pcm2c/info:stream: CAPTURE
asound/card0/pcm2c/info:id: ALC888 Analog
asound/card0/pcm2c/info:name: ALC888 Analog
asound/card0/pcm2c/info:subname: subdevice #0
asound/card0/pcm2c/info:class: 0
asound/card0/pcm2c/info:subclass: 0
asound/card0/pcm2c/info:subdevices_count: 1
asound/card0/pcm2c/info:subdevices_avail: 1
asound/card0/pcm1p/sub0/prealloc_max:32768
asound/card0/pcm1p/sub0/prealloc:64
asound/card0/pcm1p/sub0/status:closed
asound/card0/pcm1p/sub0/sw_params:closed
asound/card0/pcm1p/sub0/hw_params:closed
asound/card0/pcm1p/sub0/info:card: 0
asound/card0/pcm1p/sub0/info:device: 1
asound/card0/pcm1p/sub0/info:subdevice: 0
asound/card0/pcm1p/sub0/info:stream: PLAYBACK
asound/card0/pcm1p/sub0/info:id: ALC888 Digital
asound/card0/pcm1p/sub0/info:name: ALC888 Digital
asound/card0/pcm1p/sub0/info:subname: subdevice #0
asound/card0/pcm1p/sub0/info:class: 0
asound/card0/pcm1p/sub0/info:subclass: 0
asound/card0/pcm1p/sub0/info:subdevices_count: 1
asound/card0/pcm1p/sub0/info:subdevices_avail: 1
asound/card0/pcm1p/xrun_debug:0
asound/card0/pcm1p/info:card: 0
asound/card0/pcm1p/info:device: 1
asound/card0/pcm1p/info:subdevice: 0
asound/card0/pcm1p/info:stream: PLAYBACK
asound/card0/pcm1p/info:id: ALC888 Digital
asound/card0/pcm1p/info:name: ALC888 Digital
asound/card0/pcm1p/info:subname: subdevice #0
asound/card0/pcm1p/info:class: 0
asound/card0/pcm1p/info:subclass: 0
asound/card0/pcm1p/info:subdevices_count: 1
asound/card0/pcm1p/info:subdevices_avail: 1
asound/card0/pcm0c/sub0/prealloc_max:32768
asound/card0/pcm0c/sub0/prealloc:64
asound/card0/pcm0c/sub0/status:closed
asound/card0/pcm0c/sub0/sw_params:closed
asound/card0/pcm0c/sub0/hw_params:closed
asound/card0/pcm0c/sub0/info:card: 0
asound/card0/pcm0c/sub0/info:device: 0
asound/card0/pcm0c/sub0/info:subdevice: 0
asound/card0/pcm0c/sub0/info:stream: CAPTURE
asound/card0/pcm0c/sub0/info:id: ALC888 Analog
asound/card0/pcm0c/sub0/info:name: ALC888 Analog
asound/card0/pcm0c/sub0/info:subname: subdevice #0
asound/card0/pcm0c/sub0/info:class: 0
asound/card0/pcm0c/sub0/info:subclass: 0
asound/card0/pcm0c/sub0/info:subdevices_count: 1
asound/card0/pcm0c/sub0/info:subdevices_avail: 1
asound/card0/pcm0c/xrun_debug:0
asound/card0/pcm0c/info:card: 0
asound/card0/pcm0c/info:device: 0
asound/card0/pcm0c/info:subdevice: 0
asound/card0/pcm0c/info:stream: CAPTURE
asound/card0/pcm0c/info:id: ALC888 Analog
asound/card0/pcm0c/info:name: ALC888 Analog
asound/card0/pcm0c/info:subname: subdevice #0
asound/card0/pcm0c/info:class: 0
asound/card0/pcm0c/info:subclass: 0
asound/card0/pcm0c/info:subdevices_count: 1
asound/card0/pcm0c/info:subdevices_avail: 1
asound/card0/pcm0p/sub0/prealloc_max:32768
asound/card0/pcm0p/sub0/prealloc:64
asound/card0/pcm0p/sub0/status:closed
asound/card0/pcm0p/sub0/sw_params:closed
asound/card0/pcm0p/sub0/hw_params:closed
asound/card0/pcm0p/sub0/info:card: 0
asound/card0/pcm0p/sub0/info:device: 0
asound/card0/pcm0p/sub0/info:subdevice: 0
asound/card0/pcm0p/sub0/info:stream: PLAYBACK
asound/card0/pcm0p/sub0/info:id: ALC888 Analog
asound/card0/pcm0p/sub0/info:name: ALC888 Analog
asound/card0/pcm0p/sub0/info:subname: subdevice #0
asound/card0/pcm0p/sub0/info:class: 0
asound/card0/pcm0p/sub0/info:subclass: 0
asound/card0/pcm0p/sub0/info:subdevices_count: 1
asound/card0/pcm0p/sub0/info:subdevices_avail: 1
asound/card0/pcm0p/xrun_debug:0
asound/card0/pcm0p/info:card: 0
asound/card0/pcm0p/info:device: 0
asound/card0/pcm0p/info:subdevice: 0
asound/card0/pcm0p/info:stream: PLAYBACK
asound/card0/pcm0p/info:id: ALC888 Analog
asound/card0/pcm0p/info:name: ALC888 Analog
asound/card0/pcm0p/info:subname: subdevice #0
asound/card0/pcm0p/info:class: 0
asound/card0/pcm0p/info:subclass: 0
asound/card0/pcm0p/info:subdevices_count: 1
asound/card0/pcm0p/info:subdevices_avail: 1
asound/pcm:00-00: ALC888 Analog : ALC888 Analog : playback 1 : capture 1
asound/pcm:00-01: ALC888 Digital : ALC888 Digital : playback 1
asound/pcm:00-02: ALC888 Analog : ALC888 Analog : capture 1
asound/pcm:00-04: NVIDIA HDMI : NVIDIA HDMI : playback 1
asound/hwdep:00-03: HDA Codec 3
asound/hwdep:00-00: HDA Codec 0
asound/timers:G0: system timer : 4000.000us (10000000 ticks)
asound/timers:P0-0-0: PCM playback 0-0-0 : SLAVE
asound/timers:P0-0-1: PCM capture 0-0-1 : SLAVE
asound/timers:P0-1-0: PCM playback 0-1-0 : SLAVE
asound/timers:P0-2-1: PCM capture 0-2-1 : SLAVE
asound/timers:P0-4-0: PCM playback 0-4-0 : SLAVE
asound/meminfo:kmalloc: 51107 bytes
asound/modules: 0 snd_hda_intel
asound/cards: 0 [NVidia         ]: HDA-Intel - HDA NVidia
asound/cards:                      HDA NVidia at 0xfe020000 irq 21
asound/devices:  0: [ 0]   : control
asound/devices:  1:        : sequencer
asound/devices:  4: [ 0- 0]: hardware dependent
asound/devices:  7: [ 0- 3]: hardware dependent
asound/devices: 16: [ 0- 0]: digital audio playback
asound/devices: 17: [ 0- 1]: digital audio playback
asound/devices: 20: [ 0- 4]: digital audio playback
asound/devices: 24: [ 0- 0]: digital audio capture
asound/devices: 26: [ 0- 2]: digital audio capture
asound/devices: 33:        : timer
asound/version:Advanced Linux Sound Architecture Driver Version
1.0.18rc3.
asound/version:Compiled on Oct 14 2008 for kernel 2.6.24-19-generic
(SMP).
asound/seq/oss:OSS sequencer emulation version 0.1.8
asound/seq/oss:ALSA client number 15
asound/seq/oss:ALSA receiver port 0
asound/seq/oss:Number of applications: 0
asound/seq/oss:Number of synth devices: 0
asound/seq/oss:Number of MIDI devices: 0
asound/seq/clients:Client info
asound/seq/clients:  cur  clients : 2
asound/seq/clients:  peak clients : 2
asound/seq/clients:  max  clients : 192
asound/seq/clients:Client   0 : "System" [Kernel]
asound/seq/clients:  Port   0 : "Timer" (Rwe-)
asound/seq/clients:  Port   1 : "Announce" (R-e-)
asound/seq/clients:    Connecting To: 15:0
asound/seq/clients:Client  15 : "OSS sequencer" [Kernel]
asound/seq/clients:  Port   0 : "Receiver" (-we-)
asound/seq/clients:    Connected From: 0:1
asound/seq/drivers:snd-seq-oss,loaded,0
asound/oss/sndstat:Sound Driver:3.8.1a-980706 (ALSA v1.0.18rc3 emulation
code)
asound/oss/sndstat:Kernel: Linux mythtv 2.6.24-19-generic #1 SMP Wed Aug
20 17:53:40 UTC 2008 x86_64
asound/oss/sndstat:Config options: 0
asound/oss/sndstat:Installed drivers:
asound/oss/sndstat:Type 10: ALSA emulation
asound/oss/sndstat:Card config:
asound/oss/sndstat:HDA NVidia at 0xfe020000 irq 21
asound/oss/sndstat:Audio devices:
asound/oss/sndstat:0: ALC888 Analog (DUPLEX)
asound/oss/sndstat:Synth devices: NOT ENABLED IN CONFIG
asound/oss/sndstat:Midi devices: NOT ENABLED IN CONFIG
asound/oss/sndstat:Timers:
asound/oss/sndstat:7: system timer
asound/oss/sndstat:Mixers:
asound/oss/sndstat:0: Generic 10de NVIDIA MCP78 HDMI
asound/oss/devices:  0: [0- 0]: mixer
asound/oss/devices:  1:       : sequencer
asound/oss/devices:  3: [0- 0]: digital audio
asound/oss/devices:  4: [0- 0]: digital audio
asound/oss/devices:  8:       : sequencer
asound/oss/devices: 12: [0- 1]: digital audio

There is also an /etc/asound.state file...
 

Also, a new bios for my board (M3N-H HDMI) was released yesterday, but
its for fixing boot
problems on machines with way more memory than I have.  I'll update
anyway, but I d

Anything else?
