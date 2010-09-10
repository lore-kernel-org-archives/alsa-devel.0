From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: crash with assertion (?)
Date: Fri, 10 Sep 2010 09:53:52 +0800
Message-ID: <AANLkTi=DVhWmzSvSDQW8+_vzCCDPp+aquy8LcTEFq0xY@mail.gmail.com>
References: <4C8662AD.1040607@iem.at> <4C8670FD.5020906@ladisch.de>
	<4C874C1E.8040007@iem.at>
	<AANLkTi=5nxDDyfsUrvF3z+EpApiAjau6hbLK=a08WnKr@mail.gmail.com>
	<4C88AC51.9030803@iem.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F049103805
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 03:53:53 +0200 (CEST)
Received: by eye27 with SMTP id 27so387172eye.38
	for <alsa-devel@alsa-project.org>; Thu, 09 Sep 2010 18:53:53 -0700 (PDT)
In-Reply-To: <4C88AC51.9030803@iem.at>
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

2010/9/9 IOhannes m zmoelnig <zmoelnig@iem.at>

> On 2010-09-09 03:30, Raymond Yau wrote:
>
> >
> http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m___h_w___params.htm
> l
>
> > what is the minimum rate returned by snd_pcm_hw_params_get_rate_min()
> when
> > using hw:0,0 ?
>
> for hw:0,0 it is 48000, direction=0
> for plughw:0,0 i get 4000(sic!), direction=0
>


Are there any reason which you need to use snd_pcm_hw_params_set_rate_min()
instead of snd_pcm_hw_params_set_rate_near() ?


set_rate_min( 44100) only restrict a configuration space with a minimum rate
and this is not sufficient for alsa-lib to refine the parameters of
snd_pcm_hw_params() to unique value when the device is plughw and your sound
card only support 48000Hz and 96000Hz

Yes, I can reprodued the assertion with a patched intel8x0 driver inside
virtualbox
since there is no error when using the emulated ac97 controller and codec
which support 8000Hz<->48000Hz

There is no error when change to use set_rate_near instead of set_rate_min



>
> >
> > To debug , you will need to enable RULES_DEBUG In pcm_params.c
> >
> > add snd_pcm_dump() after snd_pcm_hw_params in your program
> >
> > export LIBASOUND_DEBUG=1
> >
> > and post the output of your program
>
> ok, i tried that.
> there's of course the little problem with havind snd_pcm_dump() after
> snd_pcm_hw_params(), since the latter crashes...
> so i added it before i start configuring the device as well. here's the
> pseudocode:
> <snip>
> open(PLAYBACK);
> dump();
> nonblock(1); get_rate(); set_rate(44100); set_period(64);
> dump();
> close();
> open(CAPTURE);
> dump();
> nonblock(1); get_rate(); set_rate(44100); set_period(64); /* CRASH */
> dump();
> close();
> </snip>
>
> i prefixed all the printout of my application with "JMZ", so you can
> easily filter it out.
>
> fgmasdr
> IOhannes
>
>
>
schange 'plughw:0,0' (slave)
ACCESS:  MMAP_INTERLEAVED RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: [32 128]
CHANNELS: [2 8]
RATE: [48000 96000]
PERIOD_TIME: (20 341334)
PERIOD_SIZE: [2 16384]
PERIOD_BYTES: [32 131072]
PERIODS: [1 1024]
BUFFER_TIME: (20 341334)
BUFFER_SIZE: [2 16384]
BUFFER_BYTES: [32 65536]
TICK_TIME: ALL
ALSA ERROR hw_params: set (RATE)
           value = 44100 : Invalid argument
ACCESS:  MMAP_INTERLEAVED RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: [32 128]
CHANNELS: [2 8]
RATE: [48000 96000]
PERIOD_TIME: (20 341334)
PERIOD_SIZE: [2 16384]
PERIOD_BYTES: [32 131072]
PERIODS: [1 1024]
BUFFER_TIME: (20 341334)
BUFFER_SIZE: [2 16384]
BUFFER_BYTES: [32 65536]
TICK_TIME: ALL
ALSA ERROR hw_params: set (RATE)
           value = 88200 : Invalid argument
ACCESS:  MMAP_INTERLEAVED RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: [32 128]
CHANNELS: [2 8]
RATE: [48000 96000]
PERIOD_TIME: (20 341334)
PERIOD_SIZE: [2 16384]
PERIOD_BYTES: [32 131072]
PERIODS: [1 1024]
BUFFER_TIME: (20 341334)
BUFFER_SIZE: [2 16384]
BUFFER_BYTES: [32 65536]
TICK_TIME: ALL
srefine 'plughw:0,0' (client)
ACCESS:  MMAP_INTERLEAVED
FORMAT:  S8
SUBFORMAT:  STD
SAMPLE_BITS: 8
FRAME_BITS: 8
CHANNELS: 1
RATE: [44100 44100]
PERIOD_TIME: (83 1452)
PERIOD_SIZE: 64
PERIOD_BYTES: 64
PERIODS: (0 4113)
BUFFER_TIME: (3 5968186)
BUFFER_SIZE: [3 263197]
BUFFER_BYTES: [3 263197]
TICK_TIME: ALL
srefine 'plughw:0,0' (slave)
ACCESS:  MMAP_INTERLEAVED RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 48000
PERIOD_TIME: (166 1452)
PERIOD_SIZE: [8 16384]
PERIOD_BYTES: [32 65536]
PERIODS: [1 1024]
BUFFER_TIME: (166 341334)
BUFFER_SIZE: [8 16384]
BUFFER_BYTES: [32 65536]
TICK_TIME: ALL
cchange 'plughw:0,0'

The assertion occur becacuse  RATE=44100 -> NONE

Rule 5 (0xb7773aa0): FRAME_BITS=8 -> 8 BUFFER_BYTES=[3 263197]
BUFFER_SIZE=[7 15052]
Rule 7 (0xb7773aa0): RATE=44100 -> NONE PERIOD_SIZE=64 PERIOD_TIME=(166
1438)

alsatest: interval_inline.h:52: snd_interval_single: Assertion
`!snd_interval_empty(i)' failed.
