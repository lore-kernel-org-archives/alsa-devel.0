From: Dinesh Ravindran <rite2dinesh@gmail.com>
Subject: Alsa Crackling Noise
Date: Fri, 6 Nov 2015 10:59:35 +0100
Message-ID: <CAGX90YUOKi4rSJvbTUGCzTow6tgtoBkkRhYuzdYqnnzLcComtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 85A24260423
 for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2015 10:59:35 +0100 (CET)
Received: by wmec201 with SMTP id c201so13025189wme.1
 for <alsa-devel@alsa-project.org>; Fri, 06 Nov 2015 01:59:35 -0800 (PST)
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

We have been facing a weird issue with Alsa recently. Sometimes the audio
plays out with out any noise and sometimes it has lot of cracking noise,
really a lot. The weird situation is when another application is printing
out some debug statements to a console it sounds good. The behavior is same
with a custom developed alsa application and also with aplay. Any thoughts?
If we have a really big buffer size of around 2sec it works somehow, but we
really want to analyze why alsa exhibits this strange behavior. Is it the
alsa itself or is it just a symptom of a bigger issue at system level?

All the test we are carrying out it at 8KHz, at higher sampling rate(48k)
we do not see this behaviour.


These are the scenarios in which it sounds good:
1. If any application is printing to the console while audio is being
played out or even just holding the return button on the console helps.
2. If we enable xrun debug with echo 29 >
/proc/asound/card0/pcm0p/xrun_debug it sounds good.
3. If we have really big buffer size around 2 seconds.
4. Or sometimes on fresh start of the machine until it enters xrun state
once.



We have the following setup:

Processor: ARM926EJ-S
Kernel: 3.14.53
Alsa-lib: 1.0.29
Alsa-Util: 1.0.29
Audio Chip: CONEXANT USB AUDIO

> aplay -Dplughw:0,0 8kz_8000.wav  #to play file


cat /proc/asound/card0/stream0
----------------------------------------

Playback:
  Status: Stop
  Interface 2
    Altset 1
    Format: S16_LE
    Channels: 2
    Endpoint: 1 OUT (ADAPTIVE)
    Rates: 8000, 16000, 24000, 32000, 44100, 48000

Hw params:
--------------

access: MMAP_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 8000 (8000/1)
period_size: 1000
buffer_size: 4000

sw params:
-------------

tstamp_mode: NONE
period_step: 1
avail_min: 1000
start_threshold: 4000
stop_threshold: 4000
silence_threshold: 0
silence_size: 0
boundary: 2097152000

status:
--------

state: RUNNING
owner_pid   : 1852
trigger_time: 3667.436640852
tstamp      : 3756.680343977
delay       : 3296
avail       : 720
avail_max   : 1000
-----
hw_ptr      : 712720
appl_ptr    : 716000
