From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH] ASoC: Intel: kbl: Move codec sysclk config
 to	codec_init function
Date: Fri, 25 May 2018 08:17:10 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1EEDC9@SW-EX-MBX01.diasemi.com>
References: <1527056028-12552-1-git-send-email-mac.chiang@intel.com>
 <1527234447-1384-1-git-send-email-mac.chiang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta26.messagelabs.com (mail1.bemta26.messagelabs.com
 [85.158.142.114])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EDF1267646
 for <alsa-devel@alsa-project.org>; Fri, 25 May 2018 10:17:12 +0200 (CEST)
In-Reply-To: <1527234447-1384-1-git-send-email-mac.chiang@intel.com>
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
To: "mac.chiang@intel.com" <mac.chiang@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 25 May 2018 08:47, Mac Chiang wrote:

You really need to run 'getmaintainers.pl' on this patch. If you want a
maintainer to see your change, the e-mail has to be directly addressed to them
as well as CC'd to the mailing list, otherwise chances are they won't see it.

Also, as this is the second iteration of the patch, the title should be
versioned, i.e. "[PATCH v2] ..."

> From: Mac Chiang <mac.chiang@intel.com>
> 
> fix an issue on KBL which applied the merged solution from
> broonie's tree
> commit fd0f237572ad
> ("ASoC: Intel: bxt: Move codec sysclk config to codec_init function")
> 
> The MCLK for DA7219 does not change in this platform, but is
> currently being configured everytime as part of the platform_clock
> event handler for DAPM. The upshot of this is that we have
> unnecessary calls to this function, and it also means that if
> a stream hasn't yet been started, DA7219 driver does not have the
> correct MCLK rates programmed and so the HP detection feature does
> not operate as expected.
> 
> This patch rectifies this issue by moving the sysclk call to
> codec_init function so it's only called once at initialisation.
> 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Acked-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Mac Chiang <mac.chiang@intel.com>

As Pierre mentioned yesterday, this is not an existing patch being reapplied, so
you cannot assume people's 'Signed-off-by' on this. Mark certainly won't add his
'Signed-off-by' tag until he merges it into his tree. Also, has Sathya actually
seen this actual change? If not how can you add his 'Acked-by' tag?

If you can make this patch format in-line with normal expectations, then the
code below looks ok to me.

> ---
>  sound/soc/intel/boards/kbl_da7219_max98357a.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/kbl_da7219_max98357a.c
> b/sound/soc/intel/boards/kbl_da7219_max98357a.c
> index c332a32..ad3029d 100644
> --- a/sound/soc/intel/boards/kbl_da7219_max98357a.c
> +++ b/sound/soc/intel/boards/kbl_da7219_max98357a.c
> @@ -66,14 +66,6 @@ static int platform_clock_control(struct
> snd_soc_dapm_widget *w,
>  		return -EIO;
>  	}
> 
> -	/* Configure sysclk for codec */
> -	ret = snd_soc_dai_set_sysclk(codec_dai, DA7219_CLKSRC_MCLK, 24576000,
> -				     SND_SOC_CLOCK_IN);
> -	if (ret) {
> -		dev_err(card->dev, "can't set codec sysclk configuration\n");
> -		return ret;
> -	}
> -
>  	if (SND_SOC_DAPM_EVENT_OFF(event)) {
>  		ret = snd_soc_dai_set_pll(codec_dai, 0,
>  				     DA7219_SYSCLK_MCLK, 0, 0);
> @@ -170,9 +162,18 @@ static int kabylake_da7219_codec_init(struct
> snd_soc_pcm_runtime *rtd)
>  {
>  	struct kbl_codec_private *ctx = snd_soc_card_get_drvdata(rtd->card);
>  	struct snd_soc_component *component = rtd->codec_dai->component;
> +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
>  	struct snd_soc_jack *jack;
>  	int ret;
> 
> +	/* Configure sysclk for codec */
> +	ret = snd_soc_dai_set_sysclk(codec_dai, DA7219_CLKSRC_MCLK, 24576000,
> +						SND_SOC_CLOCK_IN);
> +	if (ret) {
> +		dev_err(rtd->dev, "can't set codec sysclk configuration\n");
> +		return ret;
> +	}
> +
>  	/*
>  	 * Headset buttons map to the google Reference headset.
>  	 * These can be configured by userspace.
> --
> 2.7.4
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
