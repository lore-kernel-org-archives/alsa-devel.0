From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Rate or plug plugin issue with snd-pcsp
Date: Thu, 5 Jun 2014 12:53:34 +0800
Message-ID: <CAN8cciZ0dNvA+SYJ2xTRadC2LdrcuhO7UK8CMCrF+zm+d6q6qw@mail.gmail.com>
References: <538D7F4B.8090009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f53.google.com (mail-qg0-f53.google.com
 [209.85.192.53])
 by alsa0.perex.cz (Postfix) with ESMTP id F092A2651D2
 for <alsa-devel@alsa-project.org>; Thu,  5 Jun 2014 06:53:35 +0200 (CEST)
Received: by mail-qg0-f53.google.com with SMTP id f51so750945qge.26
 for <alsa-devel@alsa-project.org>; Wed, 04 Jun 2014 21:53:35 -0700 (PDT)
In-Reply-To: <538D7F4B.8090009@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> While testing application support for weird-rate cards (such as
snd-pcsp), I found a bug in alsa-lib. Alsa-plugins are installed, so the
"libspeex (builtin)" rate converter is used. This bug already exists in
alsa-plugins 1.0.27.2, so not a regression and thus should not block 1.0.28.
>
> $ file test.wav
> test.wav: RIFF (little-endian) data, WAVE audio, Microsoft PCM, 16 bit,
stereo 32000 Hz
>
> $ aplay -vvv -D plughw:pcsp test.wav
> Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 32000 Hz,
Stereo
> aplay: set_params:1297: Unable to install hw params:
> ACCESS:  RW_INTERLEAVED
> FORMAT:  S16_LE
> SUBFORMAT:  STD
> SAMPLE_BITS: 16
> FRAME_BITS: 32
> CHANNELS: 2
> RATE: NONE
> PERIOD_TIME: (125006 125007)
> PERIOD_SIZE: NONE
> PERIOD_BYTES: (16000 16004)
> PERIODS: (3 4)
> BUFFER_TIME: 500000
> BUFFER_SIZE: 16000
> BUFFER_BYTES: 64000
> TICK_TIME: 0
>
> The pcsp device supports the sample rate of 37286 Hz.

PERIOD_SIZE: NONE

Seem driver bug which use sndrv_pcm_rate_knot when only support single rate
and

The constraint refinement  need driver  usIng equal size periods

snd_pcm_hw_constraint_integer(runtime,
   SNDRV_PCM_HW_PARAM_PERIODS)
