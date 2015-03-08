From: Daniel <dferradal@gmail.com>
Subject: snd_usb_audio - siberia elite prism soundcard issues
Date: Sun, 8 Mar 2015 19:30:38 +0100
Message-ID: <CAHti5NHPMjxAtg_XLHD1kL4rUCAPaNGa_2ZAZwvv_Kc4u43uAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f176.google.com (mail-lb0-f176.google.com
 [209.85.217.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E7FE2604DE
 for <alsa-devel@alsa-project.org>; Sun,  8 Mar 2015 19:30:59 +0100 (CET)
Received: by lbiw7 with SMTP id w7so27527711lbi.7
 for <alsa-devel@alsa-project.org>; Sun, 08 Mar 2015 11:30:58 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

First of all, since this is my first message I hope am not mistaken
reporting this two issues about this piece of hardware  (I was pointed here
by alsa irc support channel) and bug tracker url does not seem to work, so
I decided to post it here.

Problem: Errors with mixer controls, breaking alsamixer, and not working
7.1 support.

Scenario: Siberia Elite Prism soundcard supports 7.1 channels but it seems
it can only play FRONT LEFT and FRONT RIGHT channels, no matter the setup.


Here is the alsa-info script output:
http://www.alsa-project.org/db/?f=301e6045129665d086d2571652c62648de0eac99


Additionally:

aplay -L output:
front:CARD=Elite,DEV=0
    SteelSeries Siberia Elite, USB Audio
    Front speakers
surround40:CARD=Elite,DEV=0
    SteelSeries Siberia Elite, USB Audio
    4.0 Surround output to Front and Rear speakers
surround41:CARD=Elite,DEV=0
    SteelSeries Siberia Elite, USB Audio
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=Elite,DEV=0
    SteelSeries Siberia Elite, USB Audio
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=Elite,DEV=0
    SteelSeries Siberia Elite, USB Audio
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=Elite,DEV=0
    SteelSeries Siberia Elite, USB Audio
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
iec958:CARD=Elite,DEV=0
    SteelSeries Siberia Elite, USB Audio
    IEC958 (S/PDIF) Digital Audio Output
dmix:CARD=Elite,DEV=0
    SteelSeries Siberia Elite, USB Audio
    Direct sample mixing device
dsnoop:CARD=Elite,DEV=0
    SteelSeries Siberia Elite, USB Audio
    Direct sample snooping device
hw:CARD=Elite,DEV=0
    SteelSeries Siberia Elite, USB Audio
    Direct hardware device without any conversions
plughw:CARD=Elite,DEV=0
    SteelSeries Siberia Elite, USB Audio
    Hardware device with all software conversions



and amixer output for this device:

# for i in {1..32}; do amixer -cElite cget numid=$i; done
numid=1,iface=PCM,name='Capture Channel Map'
  ; type=INTEGER,access=r----R--,values=2,min=0,max=36,step=0
  : values=0,0
  |     | chmap-fixed=FL,FR

numid=2,iface=PCM,name='Playback Channel Map'
  ; type=INTEGER,access=r----R--,values=2,min=0,max=36,step=0
  : values=0,0
  |     | chmap-fixed=FL,FR

numid=3,iface=MIXER,name='Sidetone Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=4,iface=MIXER,name='Sidetone Playback Volume'
  ; type=INTEGER,access=rw---R--,values=1,min=0,max=56,step=0
  : values=0
  | dBminmax-min=-74.00dB,max=-18.00dB
numid=5,iface=MIXER,name='PCM Volume'
  ; type=INTEGER,access=rw------,values=2,min=0,max=1,step=0
amixer: Control hw:2 element read error: Invalid argument

numid=6,iface=MIXER,name='PCM Volume',index=1
  ; type=INTEGER,access=rw------,values=1,min=0,max=1,step=0
amixer: Control hw:2 element read error: Invalid argument

numid=7,iface=MIXER,name='PCM Volume',index=2
  ; type=INTEGER,access=rw------,values=1,min=0,max=1,step=0
amixer: Control hw:2 element read error: Invalid argument

numid=8,iface=MIXER,name='PCM Volume',index=3
  ; type=INTEGER,access=rw------,values=1,min=0,max=1,step=0
amixer: Control hw:2 element read error: Invalid argument

numid=9,iface=MIXER,name='PCM Volume',index=4
  ; type=INTEGER,access=rw------,values=1,min=0,max=1,step=0
amixer: Control hw:2 element read error: Invalid argument

numid=10,iface=MIXER,name='Speaker Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=11,iface=MIXER,name='Speaker Playback Volume'
  ; type=INTEGER,access=rw---R--,values=8,min=0,max=74,step=0
  : values=54,54,54,54,54,54,54,54
  | dBminmax-min=-74.00dB,max=0.00dB
numid=12,iface=MIXER,name='Mic Capture Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=13,iface=MIXER,name='Mic Capture Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=74,step=0
  : values=73,73
  | dBminmax-min=-74.00dB,max=0.00dB
amixer: Cannot find the given element from control hw:2

amixer: Cannot find the given element from control hw:2

amixer: Cannot find the given element from control hw:2

amixer: Cannot find the given element from control hw:2

amixer: Cannot find the given element from control hw:2

amixer: Cannot find the given element from control hw:2

amixer: Cannot find the given element from control hw:2

amixer: Cannot find the given element from control hw:2

amixer: Cannot find the given element from control hw:2

amixer: Cannot find the given element from control hw:2

amixer: Cannot find the given element from control hw:2

amixer: Cannot find the given element from control hw:2

amixer: Cannot find the given element from control hw:2

amixer: Cannot find the given element from control hw:2

amixer: Cannot find the given element from control hw:2

amixer: Cannot find the given element from control hw:2

amixer: Cannot find the given element from control hw:2

amixer: Cannot find the given element from control hw:2

amixer: Cannot find the given element from control hw:2



And hw-params from aplay:

aplay --dump-hw-params -d1 -Dhw:Elite /dev/zero
Playing raw data '/dev/zero' : Unsigned 8 bit, Rate 8000 Hz, Mono
HW Params of device "hw:Elite":
--------------------
ACCESS:  MMAP_INTERLEAVED RW_INTERLEAVED
FORMAT:  S16_LE S24_3LE
SUBFORMAT:  STD
SAMPLE_BITS: [16 24]
FRAME_BITS: [32 192]
CHANNELS: [2 8]
RATE: [8000 96000]
PERIOD_TIME: [1000 16384000]
PERIOD_SIZE: [8 131072]
PERIOD_BYTES: [64 524288]
PERIODS: [2 1024]
BUFFER_TIME: (166 32768000]
BUFFER_SIZE: [16 262144]
BUFFER_BYTES: [64 1048576]
TICK_TIME: ALL
--------------------
aplay: set_params:1233: Sample format non available
Available formats:
- S16_LE
- S24_3LE

Also in syslog I often can see messages related to this device:
usb 1-1.3: 10:0: cannot get min/max values for control 3 (id 10)
usb 1-1.3: 2:1: cannot get freq at ep 0x1


Loading alsamixer and trying to select the soundcard exits the program with
this message:
cannot load mixer controls: Invalid argument


If anyone wants to check this issue, should you need any type of info
regarding this, please do not hesitate asking, I will post anything you
require.


PS: I don't think it is really necessary to say either but I don't expect
anyone to force-commit to this either, I mainly want to know if there is a
solution to this or if reporting this issue I can help to get it fixed.
Thanks for your time.


-- 
*Daniel Ferradal*
