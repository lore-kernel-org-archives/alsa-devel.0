From: "Paul Kavan" <pkavan@gmail.com>
Subject: Using aplay and arecord on an ARM
Date: Tue, 19 Jun 2007 14:37:56 -0500
Message-ID: <61c0054e0706191237n666fd422wcf13f874f108e64a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by alsa0.perex.cz (Postfix) with ESMTP id B130B24407
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jun 2007 21:37:57 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id o2so188035uge
	for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2007 12:37:57 -0700 (PDT)
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
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Liam:

I have managed to get the alsa-libs and aplay, arecord, and speaker-test on
my board, but I am unsure how to get them to play. I have tried making the
device nodes and am using a simple alsa.conf, but still no joy. I am sure
there is something simple I am missing.

Trying to find some documentation on this. I am assuming there is some
disconnect between the interface and my conf file. I have my alsa.conf file
in /usr/share/alsa/ and it is:

pcm.!default {
   type hw
   card 0
}
pcm.hw {
   type hw
   card 0
   device 0
   subdevice 0
}
ctl.!default {
   type hw
   card 0
}
ctl.hw {
   type hw
   card 0
}


ctl.w6811 {
       type hw
       card 0
}
pcm.w6811 {
       type hw
       card 0
       device 0
       subdevice 0
}

ctl.!default    = ctl.w6811
pcm.!default    = pcm.w6811

ctl.hw {
       @args[ CARD ]
       @args.CARD {
               type string
               default "0"
       }
       type hw
       card $CARD
}

pcm.hw {
       @args[ CARD DEV SUBDEV ]
       @args.CARD {
               type string
               default "0"
       }
       @args.DEV {
               type integer
               default 0
       }
       @args.SUBDEV {
               type integer
               default 0
       }
       type hw
       card $CARD
       device $DEV
       subdevice $SUBDEV
}

I have some /proc/ entries:

/proc/asound $ ls
GRHEKW6811  cards       pcm         version
card0       devices     timers


/proc/asound $ cat cards
 0 [GRHEKW6811     ]: W6811 - GRH_EK_W6811
                      GRH_EK_W6811 (W6811)


/proc/asound $ cat devices
  0: [ 0]   : control
 16: [ 0- 0]: digital audio playback
 24: [ 0- 0]: digital audio capture
 33:        : timer


/proc/asound $ cat pcm
00-00: W6811 W6811-PCM-0 :  : playback 1 : capture 1


/proc/asound $ cat timers
G0: system timer : 10000.000us (10000000 ticks)
P0-0-0: PCM playback 0-0-0 : SLAVE
P0-0-1: PCM capture 0-0-1 : SLAVE


/proc/asound $ cat version
Advanced Linux Sound Architecture Driver Version 1.0.14rc4 (Wed May 09
09:51:39.


Now, into GRHEKW6811 (which takes me to card0) I get a pcm0c and pcm0p
directory. Using cat info, I get:

/proc/asound/card0/pcm0c $ cat info
card: 0
device: 0
subdevice: 0
stream: CAPTURE
id: W6811 W6811-PCM-0
name:
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1


/proc/asound/card0/pcm0c $ cd ../pcm0p/
/proc/asound/card0/pcm0p $ cat info
card: 0
device: 0
subdevice: 0
stream:
PLAYBACK
id: W6811
W6811-PCM-0
name:

subname: subdevice
#0
class:
0
subclass:
0
subdevices_count:
1
subdevices_avail: 1


I then did:

mknod -m 666 /dev/snd/pcm0p c 116 0
mknod -m 666 /dev/snd/pcm0c c 116 0

However, when I try speaker-test, I get:


/usr/lib/bin $ ./speaker-test -D pcm0p

speaker-test 1.0.14

Playback device is pcm0p
Stream parameters are 48000Hz, S16_LE, 1 channels
Using 16 octaves of pink noise
ALSA lib pcm.c:2144:(snd_pcm_open_noupdate) Unknown PCM pcm0p
Playback open error: -2,No such file or directory

Same for default:

/usr/lib/bin $ ./speaker-test -D
default


speaker-test 1.0.14



Playback device is
default
Stream parameters are 48000Hz, S16_LE, 1
channels
Using 16 octaves of pink
noise
ALSA lib pcm.c:2144:(snd_pcm_open_noupdate) Unknown PCM
default
Playback open error: -2,No such file or directory

When I try aplay -l and arecord -l, I get:

/usr/lib/bin $ ./aplay
-l
aplay: device_list:204: no soundcards
found...
/usr/lib/bin $ ./arecord
-l
arecord: device_list:204: no soundcards found...

I am at a loss here. Anyone have any advice, pointers, tips, etc......

Thanks.

Paul

-- 
***************************************
Paul David Kavan
Project Engineer
GRH Electronics, Inc.
402-734-4900
pkavan@gmail.com
***************************************
