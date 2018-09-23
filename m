From: Mark Hills <mark@xwax.org>
Subject: Pinpoint audio audio corruption (Layla3G)
Date: Sun, 23 Sep 2018 14:24:31 +0100 (BST)
Message-ID: <1809231313590.18573@stax.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jazz.pogo.org.uk (jazz.pogo.org.uk [213.138.114.167])
 by alsa0.perex.cz (Postfix) with ESMTP id 55D4F267736
 for <alsa-devel@alsa-project.org>; Sun, 23 Sep 2018 15:24:32 +0200 (CEST)
Received: from cpc1-hari17-2-0-cust102.20-2.cable.virginm.net ([86.18.4.103]
 helo=stax.localdomain)
 by jazz.pogo.org.uk with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
 (Exim 4.91 (FreeBSD)) (envelope-from <mark@xwax.org>)
 id 1g44ND-000Fkx-CL
 for alsa-devel@alsa-project.org; Sun, 23 Sep 2018 14:24:31 +0100
Received: from mark (helo=localhost)
 by stax.localdomain with local-esmtp (Exim 4.84)
 (envelope-from <mark@xwax.org>) id 1g44ND-0007lB-3O
 for alsa-devel@alsa-project.org; Sun, 23 Sep 2018 14:24:31 +0100
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

I have a bug in ALSA somewhere; playback is corrupted. Nothing is 
pro-actively telling me of a problem (eg. underrun)

I could use some assistance getting to the bottom of this.

Listen to [1] for what it sounds like -- analogue recording from the 
output.

Look at the waveform [2] in Baudlien and it seems both L+R channels geting 
zero'd for some buffer period of 2.5 or 5 milliseconds.

This is Layla3G, snd-echo3g.

This problem has been rare, but persisted for many years. I've finally got 
something reproducable to investigate.

It began ~10 years ago where very occasionally recordings or playback 
would do this. This was a simple self-contained application in production 
use; written by me, using plughw:Layla3G,0,0 (no desktops, browsers, dmix 
etc.)

Problems were frequent enough to be annoying, but infrequent enough that I 
just had to put it down to 'cosmic rays', with no useful bug report.

These days I am on a desktop using dmix; and more recently with Google 
Chrome and found I can reliably 'trigger' it.

To reset, I must close all applications using /dev/snd, and re-open.

It seems to be:

* whether or not Google Chrome is first to open the device

* about 10-60 minutes after Chrome has opened the device

* more prone to happening if other applications are using the dmix

* not related to buffer sizes; I use larger sizes in the asoundrc it 
  doesn't affect the likelihood, or the 'sound' when it does happen

* I've seen two Layla's affected

* I've had many kernels and PCs over the years

There's a bug somewhere, and with nothing printed to dmesg, console etc., 
I'm at a loss here, imagining my problem could be anywhere between dmix, 
alsa-lib, snd-echo3g or even the firmware itself.

Whatever the case, I've finally got some combination I can do in userland 
as a trigger.

Below is:

- .asoundrc describing today's setup (previously I used stereo with no 
  route, still with problems)

- output of the 'aplay' that produced the recording above; and

- some other stats.

[1] http://www.pogo.org.uk/~mark/tmp/layla-glitch.flac
[2] http://www.pogo.org.uk/~mark/tmp/layla-glitch.png

Many thanks

-- 
Mark


pcm.!default {
        type plug
        slave.pcm layla_multi
}


pcm.layla_multi {
        type route

        slave.pcm {
                type dmix
                ipc_key 1742
                slave {
                        pcm "hw:Layla3G,0,0"
                        period_size 992
                        buffer_size 10912
                        channels 5
                        rate 48000
                        format S16_LE
                }
        }

        ttable {
                # Headphones

                0.0 1
                1.1 1

                # Speakers

                0.2 1
                1.3 1

                # Subwoofer; mono mix

                0.4 0.5
                1.4 0.5
        }
}


$ uname -a
Linux stax 4.18.5 #113 SMP PREEMPT Mon Sep 3 23:14:59 BST 2018 x86_64 Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz GenuineIntel GNU/Linux


$ head -99l /proc/asound/Layla3G/pcm0p/sub0/*
==> /proc/asound/Layla3G/pcm0p/sub0/hw_params <==
access: MMAP_INTERLEAVED
format: S16_LE
subformat: STD
channels: 6
rate: 48000 (48000/1)
period_size: 992
buffer_size: 10912

==> /proc/asound/Layla3G/pcm0p/sub0/info <==
card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: Analog PCM
name: Layla3G
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 8
subdevices_avail: 7

==> /proc/asound/Layla3G/pcm0p/sub0/prealloc <==
128

==> /proc/asound/Layla3G/pcm0p/sub0/prealloc_max <==
256

==> /proc/asound/Layla3G/pcm0p/sub0/status <==
state: RUNNING
owner_pid   : 9250
trigger_time: 663739.627559736
tstamp      : 680208.555428028
delay       : -790500256
avail       : 790511168
avail_max   : 790511168
-----
hw_ptr      : 790500256
appl_ptr    : 0

==> /proc/asound/Layla3G/pcm0p/sub0/sw_params <==
tstamp_mode: ENABLE
period_step: 1
avail_min: 1
start_threshold: 1
stop_threshold: 6142909891733356544
silence_threshold: 0
silence_size: 6142909891733356544
boundary: 6142909891733356544





$ aplay -vv all48000.wav 
Playing WAVE 'all48000.wav' : Float 32 bit Little Endian, Rate 48000 Hz, 
Stereo
Plug PCM: Linear Integer <-> Linear Float conversion PCM (S16_LE)
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : FLOAT_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 32
  buffer_size  : 10912
  period_size  : 992
  period_time  : 20666
  tstamp_mode  : NONE
  tstamp_type  : MONOTONIC
  period_step  : 1
  avail_min    : 992
  period_event : 0
  start_threshold  : 10912
  stop_threshold   : 10912
  silence_threshold: 0
  silence_size : 0
  boundary     : 6142909891733356544
Slave: Route conversion PCM (sformat=S16_LE)
  Transformation table:
    0 <- 0
    1 <- 1
    2 <- none
    3 <- none
    4 <- none
    5 <- none
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 10912
  period_size  : 992
  period_time  : 20666
  tstamp_mode  : NONE
  tstamp_type  : MONOTONIC
  period_step  : 1
  avail_min    : 992
  period_event : 0
  start_threshold  : 10912
  stop_threshold   : 10912
  silence_threshold: 0
  silence_size : 0
  boundary     : 6142909891733356544
Slave: Route conversion PCM
  Transformation table:
    0 <- 0
    1 <- 1
    2 <- 0
    3 <- 1
    4 <- 0*0.5 + 1*0.5
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 6
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 10912
  period_size  : 992
  period_time  : 20666
  tstamp_mode  : NONE
  tstamp_type  : MONOTONIC
  period_step  : 1
  avail_min    : 992
  period_event : 0
  start_threshold  : 10912
  stop_threshold   : 10912
  silence_threshold: 0
  silence_size : 0
  boundary     : 6142909891733356544
Slave: Direct Stream Mixing PCM
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 6
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 10912
  period_size  : 992
  period_time  : 20666
  tstamp_mode  : NONE
  tstamp_type  : MONOTONIC
  period_step  : 1
  avail_min    : 992
  period_event : 0
  start_threshold  : 10912
  stop_threshold   : 10912
  silence_threshold: 0
  silence_size : 0
  boundary     : 6142909891733356544
Hardware PCM card 0 'Layla3G' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 6
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 10912
  period_size  : 992
  period_time  : 20666
  tstamp_mode  : ENABLE
  tstamp_type  : MONOTONIC
  period_step  : 1
  avail_min    : 992
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 0
  silence_threshold: 0
  silence_size : 0
  boundary     : 6142909891733356544
  appl_ptr     : 0
  hw_ptr       : 807111136
############################ +                     | 56%^C
Aborted by signal Interrupt...
aplay: pcm_write:2004: write error: Interrupted system call
