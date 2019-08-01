From: Roeland Jansen <roeland.jansen69@gmail.com>
Subject: snd_pcm_delay in snd_usb_audio
Date: Thu, 1 Aug 2019 09:15:21 +0200
Message-ID: <CAJ2u8oasenxQZFv+sddUw6nkWm-f-VOHgEfFxm8kuPooQ4yTxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1BD67F80214
 for <alsa-devel@alsa-project.org>; Thu,  1 Aug 2019 09:15:34 +0200 (CEST)
Received: by mail-io1-xd29.google.com with SMTP id o9so38505276iom.3
 for <alsa-devel@alsa-project.org>; Thu, 01 Aug 2019 00:15:34 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

just subscribed to the list (I hope).


while troubleshooting a different thing in audio I stumbled across the
following and it's in the logs more than once.

what do you need from me? this is opensuse 15.1 leap.


warn:2019-07-31T19:12:58.207893+02:00 taplop pulseaudio[28164]:
[alsa-source-USB Audio] alsa-util.c: Most likely this is a bug in the ALSA
driver 'snd_usb_audio'. Please report this issue to the ALSA developers.
warn:2019-07-31T19:12:58.208183+02:00 taplop pulseaudio[28164]:
[alsa-source-USB Audio] alsa-util.c: snd_pcm_dump():
warn:2019-07-31T19:12:58.208473+02:00 taplop pulseaudio[28164]:
[alsa-source-USB Audio] alsa-util.c: Hardware PCM card 2 'USB Audio CODEC'
device 0 subdevice 0
warn:2019-07-31T19:12:58.208760+02:00 taplop pulseaudio[28164]:
[alsa-source-USB Audio] alsa-util.c: Its setup is:
warn:2019-07-31T19:12:58.209071+02:00 taplop pulseaudio[28164]:
[alsa-source-USB Audio] alsa-util.c:   stream       : CAPTURE
warn:2019-07-31T19:12:58.209366+02:00 taplop pulseaudio[28164]:
[alsa-source-USB Audio] alsa-util.c:   access       : MMAP_INTERLEAVED
warn:2019-07-31T19:12:58.209671+02:00 taplop pulseaudio[28164]:
[alsa-source-USB Audio] alsa-util.c:   format       : S16_LE
warn:2019-07-31T19:12:58.209958+02:00 taplop pulseaudio[28164]:
[alsa-source-USB Audio] alsa-util.c:   subformat    : STD
warn:2019-07-31T19:12:58.210245+02:00 taplop pulseaudio[28164]:
[alsa-source-USB Audio] alsa-util.c:   channels     : 2
warn:2019-07-31T19:12:58.210588+02:00 taplop pulseaudio[28164]:
[alsa-source-USB Audio] alsa-util.c:   rate         : 48000
warn:2019-07-31T19:12:58.210880+02:00 taplop pulseaudio[28164]:
[alsa-source-USB Audio] alsa-util.c:   exact rate   : 48000 (48000/1)
warn:2019-07-31T19:12:58.211198+02:00 taplop pulseaudio[28164]:
[alsa-source-USB Audio] alsa-util.c:   msbits       : 16
warn:2019-07-31T19:12:58.211746+02:00 taplop pulseaudio[28164]:
[alsa-source-USB Audio] alsa-util.c:   buffer_size  : 88200
warn:2019-07-31T19:12:58.212028+02:00 taplop pulseaudio[28164]:
[alsa-source-USB Audio] alsa-util.c:   period_size  : 44100
warn:2019-07-31T19:12:58.212261+02:00 taplop pulseaudio[28164]:
[alsa-source-USB Audio] alsa-util.c:   period_time  : 918750
warn:2019-07-31T19:12:58.212548+02:00 taplop pulseaudio[28164]:
[alsa-source-USB Audio] alsa-util.c:   tstamp_mode  : ENABLE
warn:2019-07-31T19:12:58.212785+02:00 taplop pulseaudio[28164]:
[alsa-source-USB Audio] alsa-util.c:   tstamp_type  : MONOTONIC
warn:2019-07-31T19:12:58.213014+02:00 taplop pulseaudio[28164]:
[alsa-source-USB Audio] alsa-util.c:   period_step  : 1
warn:2019-07-31T19:12:58.213238+02:00 taplop pulseaudio[28164]:
[alsa-source-USB Audio] alsa-util.c:   avail_min    : 44100
warn:2019-07-31T19:12:58.213470+02:00 taplop pulseaudio[28164]:
[alsa-source-USB Audio] alsa-util.c:   period_event : 0
warn:2019-07-31T19:12:58.213722+02:00 taplop pulseaudio[28164]:
[alsa-source-USB Audio] alsa-util.c:   start_threshold  : -1
warn:2019-07-31T19:12:58.213995+02:00 taplop pulseaudio[28164]:
[alsa-source-USB Audio] alsa-util.c:   stop_threshold   :
6206523236469964800
warn:2019-07-31T19:12:58.214465+02:00 taplop pulseaudio[28164]:
[alsa-source-USB Audio] alsa-util.c:   silence_threshold: 0
warn:2019-07-31T19:12:58.214730+02:00 taplop pulseaudio[28164]:
[alsa-source-USB Audio] alsa-util.c:   silence_size : 0
warn:2019-07-31T19:12:58.214971+02:00 taplop pulseaudio[28164]:
[alsa-source-USB Audio] alsa-util.c:   boundary     : 6206523236469964800
warn:2019-07-31T19:12:58.215228+02:00 taplop pulseaudio[28164]:
[alsa-source-USB Audio] alsa-util.c:   appl_ptr     : 45284903
warn:2019-07-31T19:12:58.215510+02:00 taplop pulseaudio[28164]:
[alsa-source-USB Audio] alsa-util.c:   hw_ptr       : 55414415
warn:2019-07-31T21:55:16.513279+02:00 taplop pulseaudio[28164]:
[alsa-sink-USB Audio] alsa-util.c: Got POLLNVAL from ALSA
warn:2019-07-31T21:55:16.513748+02:00 taplop pulseaudio[28164]:
[alsa-sink-USB Audio] alsa-util.c: Could not recover from
POLLERR|POLLNVAL|POLLHUP with snd_pcm_prepare(): No such device
