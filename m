From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re:
	=?windows-1252?q?Warning/error_from_ALSA=92s_pcm=5Fm?=
	=?windows-1252?q?in=2Ec_example=2E_Possible_problem=3F?=
Date: Fri, 29 Oct 2010 11:49:29 +0800
Message-ID: <AANLkTinTsGB4WB16xfkrvjueMGhQtTWPBbUNAuYVbZVv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 72282244CD
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Oct 2010 05:49:34 +0200 (CEST)
Received: by eyg24 with SMTP id 24so1688979eyg.38
	for <alsa-devel@alsa-project.org>; Thu, 28 Oct 2010 20:49:30 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>> On Sat, 30 Jan 2010, Louise Hoffman wrote:

>> Dear ALSA developers,
>>
>> When I compile ALSA's pcm_min.c[0] example with
>>
>> gcc -Wall -lasound pcm_min.c -o pcm_min
>>
>> Everything is fine, but running it, I get the white noise as expected,
>> but I also get this warning/error:
>>
>> Short write (expected 16384, wrote 7616)

>It was a bug in alsa-lib. I fixed it in patch bellow. Thank you for your
>report.

> http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=2e48439ad93f6c8d99a2d72928ac71285b5211bb <http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=2e48439ad93f6c8d99a2d72928ac71285b5211bb>

Add snd_pcm_dump() after call snd_pcm_set_params in pcm_min.c

The start threshold is equal to buffer size , so there should be a
short write at the second write since
16384 + 7616 = 24000  ( start threshold )

your patch had changed the behaviour


 ./pcm_min
ALSA <-> PulseAudio PCM I/O Plugin
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : U8
  subformat    : STD
  channels     : 1
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 8
  buffer_size  : 24000
  period_size  : 6000
  period_time  : 125000
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 6000
  period_event : 0
  start_threshold  : 24000
  stop_threshold   : 24000
  silence_threshold: 0
  silence_size : 0
  boundary     : 1572864000
state = 2
write 16384 frames
state = 2
write 16384 frames
state = 3
write 16384 frames
state = 3
write 16384 frames
state = 3
