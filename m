From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Rate or plug plugin issue with snd-pcsp
Date: Tue, 03 Jun 2014 13:54:51 +0600
Message-ID: <538D7F4B.8090009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f46.google.com (mail-la0-f46.google.com
 [209.85.215.46])
 by alsa0.perex.cz (Postfix) with ESMTP id EC4322655C5
 for <alsa-devel@alsa-project.org>; Tue,  3 Jun 2014 09:54:56 +0200 (CEST)
Received: by mail-la0-f46.google.com with SMTP id ec20so3252536lab.33
 for <alsa-devel@alsa-project.org>; Tue, 03 Jun 2014 00:54:53 -0700 (PDT)
Received: from [192.168.3.123] ([212.220.216.224])
 by mx.google.com with ESMTPSA id lq20sm15261419lbb.24.2014.06.03.00.54.52
 for <alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Tue, 03 Jun 2014 00:54:52 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello.

While testing application support for weird-rate cards (such as 
snd-pcsp), I found a bug in alsa-lib. Alsa-plugins are installed, so the 
"libspeex (builtin)" rate converter is used. This bug already exists in 
alsa-plugins 1.0.27.2, so not a regression and thus should not block 1.0.28.

$ file test.wav
test.wav: RIFF (little-endian) data, WAVE audio, Microsoft PCM, 16 bit, 
stereo 32000 Hz

$ aplay -vvv -D plughw:pcsp test.wav
Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 32000 Hz, Stereo
aplay: set_params:1297: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: NONE
PERIOD_TIME: (125006 125007)
PERIOD_SIZE: NONE
PERIOD_BYTES: (16000 16004)
PERIODS: (3 4)
BUFFER_TIME: 500000
BUFFER_SIZE: 16000
BUFFER_BYTES: 64000
TICK_TIME: 0

The pcsp device supports the sample rate of 37286 Hz.

Files with 44100 Hz sample rate work fine.

$ aplay -vv -D plughw:pcsp -f cd /dev/zero
Playing raw data '/dev/zero' : Signed 16 bit Little Endian, Rate 44100 
Hz, Stereo
Plug PCM: Route conversion PCM (sformat=S16_LE)
   Transformation table:
     0 <- 0*0,5 + 1*0,5
Its setup is:
   stream       : PLAYBACK
   access       : RW_INTERLEAVED
   format       : S16_LE
   subformat    : STD
   channels     : 2
   rate         : 44100
   exact rate   : 44100 (44100/1)
   msbits       : 16
   buffer_size  : 22050
   period_size  : 5512
   period_time  : 125006
   tstamp_mode  : NONE
   period_step  : 1
   avail_min    : 5512
   period_event : 0
   start_threshold  : 22050
   stop_threshold   : 22050
   silence_threshold: 0
   silence_size : 0
   boundary     : 6206523236469964800
Slave: Rate conversion PCM (37286, sformat=S16_LE)
Converter: libspeex (builtin)
Protocol version: 10002
Its setup is:
   stream       : PLAYBACK
   access       : MMAP_INTERLEAVED
   format       : S16_LE
   subformat    : STD
   channels     : 1
   rate         : 44100
   exact rate   : 44100 (44100/1)
   msbits       : 16
   buffer_size  : 22050
   period_size  : 5512
   period_time  : 125006
   tstamp_mode  : NONE
   period_step  : 1
   avail_min    : 5512
   period_event : 0
   start_threshold  : 22050
   stop_threshold   : 22050
   silence_threshold: 0
   silence_size : 0
   boundary     : 6206523236469964800
Slave: Hardware PCM card 2 'pcsp' device 0 subdevice 0
Its setup is:
   stream       : PLAYBACK
   access       : MMAP_INTERLEAVED
   format       : S16_LE
   subformat    : STD
   channels     : 1
   rate         : 37286
   exact rate   : 37286 (37286/1)
   msbits       : 16
   buffer_size  : 18644
   period_size  : 4661
   period_time  : 125006
   tstamp_mode  : NONE
   period_step  : 1
   avail_min    : 4661
   period_event : 0
   start_threshold  : 18644
   stop_threshold   : 18644
   silence_threshold: 0
   silence_size : 0
   boundary     : 5247819465793470464
   appl_ptr     : 0
   hw_ptr       : 0
#+                                                 | 00%^C

-- 
Alexander E. Patrakov
