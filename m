From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 19/22] ASoC: Intel: bytcr_rt5651: Add
 support for Bay Trail CR / SSP0 using boards
Date: Fri, 9 Mar 2018 17:30:16 -0600
Message-ID: <e4558b54-415e-a7f0-e696-27b9b9eb0a31@linux.intel.com>
References: <20180304143610.21125-1-hdegoede@redhat.com>
 <20180304143610.21125-20-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id D2862266D7D
 for <alsa-devel@alsa-project.org>; Sat, 10 Mar 2018 00:30:20 +0100 (CET)
In-Reply-To: <20180304143610.21125-20-hdegoede@redhat.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


Sorry about the delay, I've only found the time to look at this machine 
driver changes this afternoon while I was doing the SOF integration

> @@ -291,9 +332,16 @@ static int byt_rt5651_aif1_hw_params(struct snd_pcm_substream *substream,
>   {
>   	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>   	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +	snd_pcm_format_t format = params_format(params);
>   	int rate = params_rate(params);
> +	int bclk_ratio;
>   
> -	return byt_rt5651_prepare_and_enable_pll1(codec_dai, rate, 50);
> +	if (format == SNDRV_PCM_FORMAT_S16_LE)
> +		bclk_ratio = 32;

I don't think we can generate a 32x ratio with a 19.2 MHz clock, even 
less so with a 25MHz reference.
And in addition in the bytcr_rt5640 case we could never get any audio on 
bytcr which uses the SSP0 link without the mclk enabled, so this 
SSP0+blck mode was never tested (maybe precisely because this ratio was 
wrong...)

In other words there is a test gap here for the case using SSP0+bclk as 
a reference with the rt5651 as well. Does anyone have access to a BYT-CR 
platform w/ rt5651 to test this?

The other comment I have is that this run-time definition of the 
bclk_ratio is inconsistent with the hard-coded value I see in 
platform_clock_control()
ret = byt_rt5651_prepare_and_enable_pll1(codec_dai, 48000, 50);

Looks good otherwise.
Cheers
-Pierre
