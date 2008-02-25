From: "William Juul" <william@juul.no>
Subject: new driver: 30mS interval problem
Date: Mon, 25 Feb 2008 15:46:28 +0100
Message-ID: <2563ac9e0802250646t419bdc41v3b6b10d7566fec3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.188])
	by alsa0.perex.cz (Postfix) with ESMTP id D35EA24378
	for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2008 15:46:30 +0100 (CET)
Received: by nf-out-0910.google.com with SMTP id b21so1161998nfd.32
	for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2008 06:46:30 -0800 (PST)
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

Hello

I am new to ALSA and trying to write a new driver for a DAC connected
with PCM to an AVR32 on a NGW100 reference card provided by Atmel.

The sampling rate I am currently using is 11047and the DAC is
providing 4 channels of 24bit. The HW interface is using DMA to copy
data to RAM.
By studying the audio data in hexdump or in Audacity I can verify that
the sound looks good in intervals of about 30mS, then all channels are
garbled for 30mS. This pattern repeat itself throughout the audio
capture.

I am not confident I have configured all ALSA parameters properly.
How can I go about fixing/debugging this 30mS intverval problem?

Below is the command I am using.


Best regards
William Juul

# arecord -r 11047 -c 4 -f S24_LE -s 1 -A 100 -d 5 --buffer-size 16384
-F 21333 -v > test.wav
Recording WAVE 'stdin' : Signed 24 bit Little Endian, Rate 11047 Hz, Channels 4
Plug PCM: Hardware PCM card 0 'AVR32 NGW100 external DAC' device 0 subdevice 0
pcm->setup: 1
  stream       : CAPTURE
  access       : RW_INTERLEAVED
  format       : S24_LE
  subformat    : STD
  channels     : 4
  rate         : 11047
  exact rate   : 11047 (11047/1)
  msbits       : 32
  buffer_size  : 16384
  period_size  : 490
  period_time  : 44355
  tick_time    : 4000
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 490
  xfer_align   : 490
  start_threshold  : 1
  stop_threshold   : 16384
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
