From: Mark Hills <mark@pogo.org.uk>
Subject: alsa-lib: Rate conversion broken for non-S16?
Date: Sun, 1 Aug 2010 22:43:31 +0100 (BST)
Message-ID: <alpine.LNX.2.01.1008012143460.13804@fgnk.ybpnyqbznva>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wes.ijneb.com (mx.ij.cx [212.13.201.15])
	by alsa0.perex.cz (Postfix) with ESMTP id A490E1037F8
	for <alsa-devel@alsa-project.org>;
	Sun,  1 Aug 2010 23:43:37 +0200 (CEST)
Received: from cpc1-acto2-0-0-cust60.know.cable.virginmedia.com
	([82.28.218.61] helo=stax.localdomain)
	by wes.ijneb.com with esmtpa (Exim 4.71)
	(envelope-from <mark@pogo.org.uk>) id 1OfgJg-0002fR-Ch
	for alsa-devel@alsa-project.org; Sun, 01 Aug 2010 22:43:32 +0100
Received: from mark (helo=localhost)
	by stax.localdomain with local-esmtp (Exim 4.69)
	(envelope-from <mark@pogo.org.uk>) id 1OfgJg-0000C2-2C
	for alsa-devel@alsa-project.org; Sun, 01 Aug 2010 22:43:32 +0100
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

I have a device (snd-usb-caiaq) whose native sample format is S24_3BE. 
When sample rate conversion is used, the audio becomes near silent, 
distorted, and only in the left channel.

It is reproducable with aplay (see example below). Recording is not 
affected. Playback is correct if only format conversion is used.

It looks something is causing the incorrect put function to be used by the 
rate conversion.

I traced it to linear_expand() and others, alsa-lib-src/pcm_rate_linear.c.

Forcing the function to put S16 format into the destination buffer allows, 
suprisingly, the sound to be heard correctly and at full volume from both 
aplay and xwax:

  if (rate->put_idx == 10)
      rate->put_idx = 6

I suspected that linear_init() is looking in the wrong place to choose the 
attributes for the rate conversion. After some time spent I cannot see it.

But is there any reason that the output buffer for the rate conversion 
would not be in S24_3BE? And for the rate conversion to be misinformed?

$ uname -s -r -v -p -i -m
Linux 2.6.34.1-mh #83 SMP PREEMPT Wed Jul 21 23:25:33 BST 2010 i686 pentium4 i386

$ alsacap
Card 0, ID `Audio8DJ', name `Audio 8 DJ'
  Device 0, ID `Audio 8 DJ', name `Audio 8 DJ', 4 subdevices (4 available)
    2 channels, sampling rate 44100..96000 Hz
    Sample formats: S24_3BE
      Subdevice 0, name `subdevice #0'
      Subdevice 1, name `subdevice #1'
      Subdevice 2, name `subdevice #2'
      Subdevice 3, name `subdevice #3'

$ aplay -v -D plughw:Audio8DJ,0,0 halcyon-24000.wav 
Playing WAVE 'halcyon-24000.wav' : Signed 16 bit Little Endian, Rate 24000 Hz, Stereo
Plug PCM: Rate conversion PCM (48000, sformat=S24_3BE)
Converter: linear-interpolation
Protocol version: 10002
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 24000
  exact rate   : 24000 (24000/1)
  msbits       : 16
  buffer_size  : 10922
  period_size  : 2730
  period_time  : 113770
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 2730
  period_event : 0
  start_threshold  : 10922
  stop_threshold   : 10922
  silence_threshold: 0
  silence_size : 0
  boundary     : 715784192
Slave: Hardware PCM card 0 'Audio 8 DJ' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S24_3BE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 24
  buffer_size  : 21845
  period_size  : 5461
  period_time  : 113770
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 5461
  period_event : 0
  start_threshold  : 21844
  stop_threshold   : 21845
  silence_threshold: 0
  silence_size : 0
  boundary     : 1431633920
  appl_ptr     : 0
  hw_ptr       : 0

-- 
Mark
