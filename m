From: ruchi sirauthiya <ruchisirauthiya@gmail.com>
Subject: Audio cutoff when playing using dmix
Date: Tue, 8 Sep 2009 12:50:38 +0530
Message-ID: <3a2444df0909080020u3ab777f1m83a9d38675743b0d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f193.google.com (mail-iw0-f193.google.com
	[209.85.223.193])
	by alsa0.perex.cz (Postfix) with ESMTP id 09D98244B9
	for <alsa-devel@alsa-project.org>;
	Tue,  8 Sep 2009 09:20:59 +0200 (CEST)
Received: by iwn31 with SMTP id 31so12786iwn.16
	for <alsa-devel@alsa-project.org>; Tue, 08 Sep 2009 00:20:58 -0700 (PDT)
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

Hi,

I am facing audio clipping issues when dmix is used for playback. For the
test we used a full scale sine wave tone generated using software and
encoded as "Signed 16 bit Little Endian, Rate 44100 Hz, Mono". The audio is
getting cut out at a 2-3 second interval during playback. This happens only
for a fraction of second but it is consistent. This does not happen when
audio is played back on the device directly but only when going through
dmix. We have observed that there were differences in audio cutting off when
the sampling rate was set to 8000Hz and 32000 Hz in asound.conf.

The contents of asound.conf is pasted below for your reference:

pcm.dmixer {
    type dmix
    ipc_key 2048
    ipc_key_add_uid true

    slave {
        pcm hw:0
        rate 8000
        channels 2
    }
}

pcm.asymed {
    type asym
    playback.pcm "dmixer"
    capture.pcm "hw:0,0"
}

pcm.rateConvert {
    type plug
    slave.pcm "asymed"
}

The configuration given above works fine with dmix in 2.6.29 kernel, I am
using kernel 2.6.22.18.

I have compared the configuration differences (buffers and periods) with and
without using dmix. I tried applying some parameters (like buffer_size,
period_time and period_size) which was in use when audio was
played directly to the hardware device by aplay using the following command:

aplay -D rateConvert --period-time=92879 --buffer-size=65536
--period-size=4096 /mnt/test.wav -vvv -d 5

There was come improvement in the audio cutting off issue but it was not
eliminated completely.

Given below are the logs for aplay (-vvv) with and without using dmix (with
audio cutoff issue on kernel 2.6.22):
Without using dmix:

[root@OMAP3 tests]# aplay /mnt/test.wav -vvv -d 5 5
Playing WAVE '/mnt/test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Mono
Plug PCM: Hardware PCM card 0 'TWL4030' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 16
  buffer_size  : 65536
  period_size  : 4096
  period_time  : 92879
  tick_time    : 7812
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 4096
  xfer_align   : 4096
  start_threshold  : 65536
  stop_threshold   : 65536
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
Max peak (4096 samples): 0x00006665 ################     79%
Max peak (4096 samples): 0x00006665 ################     79%
...Same text repeats 50 times...
Max peak (4096 samples): 0x00006665 ################     79%
Max peak (4096 samples): 0x00006665 ################     79%

Using dmix:

[root@OMAP3 tests]# aplay -D rateConvert /mnt/test.wav -vvv -d 5
Playing WAVE '/mnt/test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Mono
Plug PCM: Rate conversion PCM (8000, sformat=S16_LE)
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 16
  buffer_size  : 22050
  period_size  : 5512
  period_time  : 125000
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 5512
  xfer_align   : 5512
  start_threshold  : 22048
   stop_threshold   : 22050
  silence_threshold: 0
  silence_size : 0
  boundary     : 1445068800
Slave: Route conversion PCM (sformat=S16_LE)
  Transformation table:
    0 <- 0
    1 <- 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 16
  buffer_size  : 4000
  period_size  : 1000
  period_time  : 125000
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 1000
  xfer_align   : 1000
  start_threshold  : 4000
  stop_threshold   : 4000
  silence_threshold: 0
  silence_size : 0
  boundary     : 2097152000
Slave: Direct Stream Mixing PCM
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 16
  buffer_size  : 4000
  period_size  : 1000
  period_time  : 125000
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 1000
  xfer_align   : 1000
  start_threshold  : 4000
  stop_threshold   : 4000
  silence_threshold: 0
  silence_size : 0
  boundary     : 2097152000
Hardware PCM card 0 'TWL4030' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 16
  buffer_size  : 16000
  period_size  : 1000
  period_time  : 125000
  tick_time    : 7812
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 1000
  xfer_align   : 1000
  start_threshold  : 1
  stop_threshold   : 2097152000
  silence_threshold: 0
  silence_size : 2097152000
  boundary     : 2097152000
Max peak (5512 samples): 0x00006665 ################     79%
Max peak (5512 samples): 0x00006665 ################     79%
...Same text repeats 36 times...
Max peak (5512 samples): 0x00006665 ################     79%
Max peak (5512 samples): 0x00006665 ################     79%
Max peak (5512 samples): 0x00005f1a ###############      74%

Please help me fix this issue. Does this occur due to non-optimal settings
of the parameters (buffers, periods) in the configuration or is it some
other issue with the ALSA library or the kernel? Please ask if any more
setup/configuration settings are required for reference.

Thanks and Regards,

Ruchi Sirauthiya
