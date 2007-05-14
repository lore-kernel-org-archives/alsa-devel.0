From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Meaning of this Plug PCM Transformation table?
Date: Mon, 14 May 2007 12:53:14 +0530
Message-ID: <8d6898730705140023j1c91656fyd7cf4e0addf506a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 4301D2432D
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2007 09:23:16 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id l8so1598715nzf
	for <alsa-devel@alsa-project.org>; Mon, 14 May 2007 00:23:15 -0700 (PDT)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Plug PCM: Route conversion PCM (sformat=S16_LE)
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
  period_size  : 256
  period_time  : 32000
  tick_time    : 10000
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 256
  xfer_align   : 256
  start_threshold  : 3840
  stop_threshold   : 4000
  silence_threshold: 0
  silence_size : 0
  boundary     : 2097152000
Slave: Hardware PCM card 0 'IDENTITY' device 0 subdevice 0
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
  period_size  : 256
  period_time  : 32000
  tick_time    : 10000
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 256
  xfer_align   : 256
  start_threshold  : 3840
  stop_threshold   : 4000
  silence_threshold: 0
  silence_size : 0
  boundary     : 2097152000



This is capture Handle logs

Plug PCM: Route conversion PCM (sformat=S16_LE)
  Transformation table:
    0 <- 0*0.5 + 1*0.5
Its setup is:
  stream       : CAPTURE
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 16
  buffer_size  : 4000
  period_size  : 256
  period_time  : 32000
  tick_time    : 10000
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 256
  xfer_align   : 256
  start_threshold  : 1
  stop_threshold   : 4000
  silence_threshold: 0
  silence_size : 0
  boundary     : 2097152000
Slave: Hardware PCM card 0 'IDENTITY' device 0 subdevice 0
Its setup is:
  stream       : CAPTURE
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 16
  buffer_size  : 4000
  period_size  : 256
  period_time  : 32000
  tick_time    : 10000
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 256
  xfer_align   : 256
  start_threshold  : 1
  stop_threshold   : 4000
  silence_threshold: 0
  silence_size : 0
  boundary     : 2097152000


I am having an application which does capture and playback
simultaneously and is single threaded?

What is the meaning of this Transformation table?
