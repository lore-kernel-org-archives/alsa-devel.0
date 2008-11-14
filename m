From: cocala <syy.wxd@gmail.com>
Subject: Re: Why no Marco definitions for rate 24000 and 12000?
Date: Fri, 14 Nov 2008 17:01:08 +0800
Message-ID: <458a17f90811140101q7d030c69k39c25552e87d1224@mail.gmail.com>
References: <458a17f90811140032v55c958bfiec1bf69bfb022873@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 11FCD2443F
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 10:01:09 +0100 (CET)
Received: by ti-out-0910.google.com with SMTP id j3so826259tid.8
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 01:01:08 -0800 (PST)
In-Reply-To: <458a17f90811140032v55c958bfiec1bf69bfb022873@mail.gmail.com>
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

Yes, that can add supported sample rates.

but the macro definitions are still needed, actually 12000 and 24000 are
supported by most audio codecs.

in soc-core.c

runtime->hw.rates =
   codec_dai->capture->rates & cpu_dai->capture->rates;

in wm8350.c
#define WM8350_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | \
  SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 | \
        SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_32000 | \
        SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | \
        SNDRV_PCM_RATE_96000)

static const struct snd_soc_pcm_stream wm8350_hifi_dai_playback = {
 .stream_name = "Playback",
 .channels_min = 2,
 .channels_max = 2,
 .rates  = WM8350_RATES,
 .formats = WM8350_FORMATS,
};
Without the mcaro defintions, it is hard to handle the 12000 and 24000
sample rates.


2008/11/14 cocala <syy.wxd@gmail.com>

> Who can tell me why not define add SNDRV_PCM_RATE_24000 and
> SNDRV_PCM_RATE_12000?
