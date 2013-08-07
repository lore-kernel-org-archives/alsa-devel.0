From: Mattia Bertoni <mattia.b89@gmail.com>
Subject: bug
Date: Wed, 07 Aug 2013 19:14:40 +0200
Message-ID: <52028080.4090608@gmail.com>
References: <520268D8.3000807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f53.google.com (mail-wg0-f53.google.com [74.125.82.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 240052617A6
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2013 19:14:46 +0200 (CEST)
Received: by mail-wg0-f53.google.com with SMTP id c11so1788684wgh.32
 for <alsa-devel@alsa-project.org>; Wed, 07 Aug 2013 10:14:45 -0700 (PDT)
Received: from [10.32.212.74] (93-34-185-64.ip51.fastwebnet.it. [93.34.185.64])
 by mx.google.com with ESMTPSA id fd3sm13558231wic.10.2013.08.07.10.14.43
 for <alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Wed, 07 Aug 2013 10:14:45 -0700 (PDT)
In-Reply-To: <520268D8.3000807@gmail.com>
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

finally I can report a bug which I encountered some time ago; I send you 
the important part of the entire log, which is to much big to be posted:

Jun 15 18:18:00 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c: snd_pcm_avail() returned a value that is exceptionally 
large: 420736 bytes (2191 ms).
Jun 15 18:18:00 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c: Most likely this is a bug in the ALSA driver 
'snd_intel8x0'. Please report this issue to the ALSA developers.
Jun 15 18:18:00 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c: snd_pcm_dump():
Jun 15 18:18:00 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c: Hardware PCM card 0 'NVidia CK804' device 0 subdevice 0
Jun 15 18:18:00 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c: Its setup is:
Jun 15 18:18:00 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   stream       : PLAYBACK
Jun 15 18:18:00 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   access       : MMAP_INTERLEAVED
Jun 15 18:18:00 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   format       : S16_LE
Jun 15 18:18:00 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   subformat    : STD
Jun 15 18:18:00 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   channels     : 2
Jun 15 18:18:00 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   rate         : 48000
Jun 15 18:18:00 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   exact rate   : 48000 (48000/1)
Jun 15 18:18:03 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   msbits       : 16
Jun 15 18:18:03 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   buffer_size  : 16384
Jun 15 18:18:03 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   period_size  : 16384
Jun 15 18:18:03 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   period_time  : 341333
Jun 15 18:18:03 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   tstamp_mode  : ENABLE
Jun 15 18:18:04 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   period_step  : 1
Jun 15 18:18:04 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   avail_min    : 16384
Jun 15 18:18:04 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   period_event : 0
Jun 15 18:18:04 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   start_threshold  : -1
Jun 15 18:18:04 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   stop_threshold   : 4611686018427387904
Jun 15 18:18:04 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   silence_threshold: 0
Jun 15 18:18:04 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   silence_size : 0
Jun 15 18:18:04 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   boundary     : 4611686018427387904
Jun 15 18:18:04 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   appl_ptr     : 26406104
Jun 15 18:18:04 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   hw_ptr       : 26494904
Jun 15 18:18:04 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c: snd_pcm_delay() returned a value that is exceptionally 
large: -465056 bytes (-2422 ms).
Jun 15 18:18:04 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c: Most likely this is a bug in the ALSA driver 
'snd_intel8x0'. Please report this issue to the ALSA developers.
Jun 15 18:18:04 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c: snd_pcm_dump():
Jun 15 18:18:04 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c: Hardware PCM card 0 'NVidia CK804' device 0 subdevice 0
Jun 15 18:18:04 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c: Its setup is:
Jun 15 18:18:04 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   stream       : PLAYBACK
Jun 15 18:18:04 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   access       : MMAP_INTERLEAVED
Jun 15 18:18:04 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   format       : S16_LE
Jun 15 18:18:04 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   subformat    : STD
Jun 15 18:18:04 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   channels     : 2
Jun 15 18:18:04 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   rate         : 48000
Jun 15 18:18:04 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   exact rate   : 48000 (48000/1)
Jun 15 18:18:04 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   msbits       : 16
Jun 15 18:18:04 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   buffer_size  : 16384
Jun 15 18:18:04 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   period_size  : 16384
Jun 15 18:18:04 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   period_time  : 341333
Jun 15 18:18:04 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   tstamp_mode  : ENABLE
Jun 15 18:18:04 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   period_step  : 1
Jun 15 18:18:04 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   avail_min    : 16384
Jun 15 18:18:04 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   period_event : 0
Jun 15 18:18:04 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   start_threshold  : -1
Jun 15 18:18:04 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   stop_threshold   : 4611686018427387904
Jun 15 18:18:04 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   silence_threshold: 0
Jun 15 18:18:04 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   silence_size : 0
Jun 15 18:18:04 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   boundary     : 4611686018427387904
Jun 15 18:18:04 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   appl_ptr     : 26569944
Jun 15 18:18:04 arch-dekstop pulseaudio[776]: [alsa-sink-Intel ICH] 
alsa-util.c:   hw_ptr       : 26686208
