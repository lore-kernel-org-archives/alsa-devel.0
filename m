From: Klement Sekera <klement@klementsekera.com>
Subject: pulseaudio[1203]: E: [alsa-sink-USB Audio]
 alsa-util.c: snd_pcm_avail() returned a value that is exceptionally large
Date: Wed, 16 Mar 2016 11:49:57 +0100
Message-ID: <9dc74bc3ee5f245209f1c8717b7546bb@klementsekera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zeroone.sk (phoenix.wheel.sk [92.240.244.16])
 by alsa0.perex.cz (Postfix) with ESMTP id 596FF265DF8
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2016 11:50:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by mail.zeroone.sk (Postfix) with ESMTP id 01D928FFF2C
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2016 11:50:01 +0100 (CET)
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

Hi devs,

 I'm experiencing random hick-ups on my Carbon X1 2nd version with a
Xonar U3 USB sound card plugged into the onelink dock. When this
happens, the whole desktop freezes, whatever was last playing (second or
two) loops and after a while (~30seconds) everything recovers..

I see this in my logs: 

Mar 16 11:37:07 ksekera-arch rtkit-daemon[1207]: The canary thread is
apparently starving. Taking action.
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: snd_pcm_avail() returned a value that is exceptionally
large: 4194088 bytes (23776 ms).
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: Most likely this is a bug in the ALSA driver
'snd_usb_audio'. Please report this issue to the ALSA develop
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: snd_pcm_dump():
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: Hardware PCM card 2 'USB Advanced Audio Device' device 0
subdevice 0
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: Its setup is:
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: stream : PLAYBACK
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: access : MMAP_INTERLEAVED
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: format : S16_LE
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: subformat : STD
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: channels : 2
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: rate : 44100
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: exact rate : 44100 (44100/1)
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: msbits : 16
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: buffer_size : 88200
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: period_size : 44100
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: period_time : 1000000
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: tstamp_mode : ENABLE
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: tstamp_type : MONOTONIC
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: period_step : 1
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: avail_min : 87319
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: period_event : 0
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: start_threshold : -1
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: stop_threshold : 6206523236469964800
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: silence_threshold: 0
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: silence_size : 0
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: boundary : 6206523236469964800
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: appl_ptr : 20607492
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: hw_ptr : 21567814 

Mar 16 11:37:07 ksekera-arch rtkit-daemon[1207]: Demoting known
real-time threads.
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: snd_pcm_delay() returned a value that is exceptionally
large: -3674960 bytes (-20833 ms).
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: Most likely this is a bug in the ALSA driver
'snd_usb_audio'. Please report this issue to the ALSA develop
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: snd_pcm_dump():
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: Hardware PCM card 2 'USB Advanced Audio Device' device 0
subdevice 0
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: Its setup is:
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: stream : PLAYBACK
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: access : MMAP_INTERLEAVED
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: format : S16_LE
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: subformat : STD
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: channels : 2
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: rate : 44100
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: exact rate : 44100 (44100/1)
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: msbits : 16
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: buffer_size : 88200
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: period_size : 44100
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: period_time : 1000000
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: tstamp_mode : ENABLE
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: tstamp_type : MONOTONIC
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: period_step : 1
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: avail_min : 87319
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: period_event : 0
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: start_threshold : -1
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: stop_threshold : 6206523236469964800
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: silence_threshold: 0
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: silence_size : 0
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: boundary : 6206523236469964800
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: appl_ptr : 20653792
Mar 16 11:37:12 ksekera-arch pulseaudio[1203]: E: [alsa-sink-USB Audio]
alsa-util.c: hw_ptr : 21572797
Mar 16 11:37:07 ksekera-arch rtkit-daemon[1207]: Successfully demoted
thread 1203 of process 1203 (/usr/bin/pulseaudio).
Mar 16 11:37:07 ksekera-arch rtkit-daemon[1207]: Demoted 1 threads. 

I'm on arch linux: 

ksekera@ksekera-arch ~> cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version k4.3.6-1-ck.
ksekera@ksekera-arch ~> uname -a
Linux ksekera-arch 4.3.6-1-ck #1 SMP PREEMPT Fri Feb 19 20:24:27 EST
2016 x86_64 GNU/Linux 

Let me know if you need any more info, 

Regards, 

Klement

  
