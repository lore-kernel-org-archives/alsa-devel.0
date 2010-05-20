From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: First 50 milliseconds of audio clipping with dmix
Date: Thu, 20 May 2010 12:04:06 +0800
Message-ID: <AANLkTineIe45MEv8juotPw_wOaDu79islnJeplkgj42I@mail.gmail.com>
References: <FB2A216B-BAA3-4E07-828A-218F9855D418@taser.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by alsa0.perex.cz (Postfix) with ESMTP id 71E03244BD
	for <alsa-devel@alsa-project.org>;
	Thu, 20 May 2010 06:04:08 +0200 (CEST)
Received: by pvc22 with SMTP id 22so2351336pvc.38
	for <alsa-devel@alsa-project.org>; Wed, 19 May 2010 21:04:07 -0700 (PDT)
In-Reply-To: <FB2A216B-BAA3-4E07-828A-218F9855D418@taser.com>
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

2010/5/20 Tyler Conant <tconant@taser.com>

> I'm trying to use dmix on an OMAP processor. I'm experiencing the first 50
> ms of the sample getting clipped. When I aplay directly to the hw:0 I don't
> get the clipping. The difference I see between the alsa configuration
> between dmix and hw:0 is the start_threshold, stop_threshold and
> silence_size. When it's direct to hw:0 the start and stop threshold are
> equal to the buffer size. For dmix the start threshold is 1 and the stop
> threshold is 1445199872. Is this dmix which is setting the start and stop or
> is this aplay. I'm only guessing this is the reason why the first part is
> clipping. The only bug which seem similar is
> http://bugs.gentoo.org/show_bug.cgi?id=218641 and it's already been closed
> out. I'm using alsa lib 1.0.23
>
>
> with hw:0
>
> Audio_Prompts # aplay -v -D hw:0 Click03.wav
> Playing WAVE 'Click03.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
> Mono
> Hardware PCM card 0 'TWL4030' device 0 subdevice 0
> Its setup is:
>  stream       : PLAYBACK
>  access       : RW_INTERLEAVED
>  format       : S16_LE
>  subformat    : STD
>  channels     : 1
>  rate         : 44100
>  exact rate   : 44100 (44100/1)
>  msbits       : 16
>  buffer_size  : 22052
>  period_size  : 5513
>  period_time  : 125011
>  tstamp_mode  : NONE
>  period_step  : 1
>  avail_min    : 5513
>  period_event : 0
>  start_threshold  : 22052
>  stop_threshold   : 22052
>  silence_threshold: 0
>  silence_size : 0
>  boundary     : 1445199872
>  appl_ptr     : 0
>  hw_ptr       : 0
> /opt/axonapp/Audio_Prompts #
>
>
> With dmix:
>
> /Audio_Prompts # aplay -v Click03.wav
> Playing WAVE 'Click03.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
> Mono
> Plug PCM: Direct Stream Mixing PCM
> Its setup is:
>  stream       : PLAYBACK
>  access       : RW_INTERLEAVED
>  format       : S16_LE
>  subformat    : STD
>  channels     : 1
>  rate         : 44100
>  exact rate   : 44100 (44100/1)
>  msbits       : 16
>  buffer_size  : 22052
>  period_size  : 5513
>  period_time  : 125011
>  tstamp_mode  : NONE
>  period_step  : 1
>  avail_min    : 5513
>  period_event : 0
>  start_threshold  : 22052
>  stop_threshold   : 22052
>  silence_threshold: 0
>  silence_size : 0
>  boundary     : 1445199872
> Hardware PCM card 0 'TWL4030' device 0 subdevice 0
> Its setup is:
>  stream       : PLAYBACK
>  access       : MMAP_INTERLEAVED
>  format       : S16_LE
>  subformat    : STD
>  channels     : 1
>  rate         : 44100
>  exact rate   : 44100 (44100/1)
>  msbits       : 16
>  buffer_size  : 22052
>  period_size  : 5513
>  period_time  : 125011
>  tstamp_mode  : ENABLE
>  period_step  : 1
>  avail_min    : 5513
>  period_event : 0
>  start_threshold  : 1
>  stop_threshold   : 1445199872
>  silence_threshold: 0
>  silence_size : 1445199872
>  boundary     : 1445199872
>  appl_ptr     : 0
>  hw_ptr       : 0
> /opt/axonapp/Audio_Prompts #
>
>
> asound.conf:
> pcm.dmixer {
>  type dmix
>  ipc_key 2048
>  ipc_key_add_uid true
>  slave {
>
>      channels 1
>      pcm hw:0
>      rate 44100
>      period_time 125011
>      period_size 5513
>      buffer_size 22052
>  }
> }
>
> pcm.asymed {
>  type asym
>  playback.pcm "dmixer"
>  capture.pcm "hw:0,0"
> }
>
> pcm.!default {
>  type plug
>  slave.pcm "asymed"
> }
>
>
>
The major difference is  access       : MMAP_INTERLEAVED
