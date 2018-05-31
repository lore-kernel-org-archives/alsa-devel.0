From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] [PATCH v4] ASoC: Intel: kbl: Move codec
 sysclk config to codec_init function
Date: Thu, 31 May 2018 16:16:47 -0500
Message-ID: <17ac8c69-a726-568c-1b7c-c08ac63db89d@linux.intel.com>
References: <1527579790-1666-1-git-send-email-mac.chiang@intel.com>
 <1527787112-17493-1-git-send-email-mac.chiang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 92C5A267252
 for <alsa-devel@alsa-project.org>; Thu, 31 May 2018 23:16:50 +0200 (CEST)
In-Reply-To: <1527787112-17493-1-git-send-email-mac.chiang@intel.com>
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
To: mac.chiang@intel.com, alsa-devel@alsa-project.org
Cc: kuninori.morimoto.gx@renesas.com, tiwai@suse.de, broonie@kernel.org, naveen.m@intel.com, Adam.Thomson.Opensource@diasemi.com, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org



On 05/31/2018 12:18 PM, mac.chiang@intel.com wrote:
> From: Mac Chiang <mac.chiang@intel.com>
>
> On APL, commit fd0f237572ad
> ("ASoC: Intel: bxt: Move codec sysclk config to codec_init function")
> fixed an issue related to jack detection.
>
> The MCLK for DA7219 does not change in this platform, but is
> currently being configured everytime as part of the platform_clock
> event handler for DAPM. The upshot of this is that we have
> unnecessary calls to this function, and it also means that if
> a stream hasn't yet been started, DA7219 driver does not have the
> correct MCLK rates programmed and so the HP detection feature does
> not operate as expected.
>
> The same fix is needed on KBL.
>
> This patch rectifies this issue by moving the sysclk call to
> codec_init function so it's only called once at initialisation.
>
> Signed-off-by: Mac Chiang <mac.chiang@intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>
> ---
> Notes(changelog):
>    v2:
>      - correct the MCLK to 24.576M
>    v3:
>      - described the comments clearly
>    v4:
>      - move the notes at the end
>
>   sound/soc/intel/boards/kbl_da7219_max98357a.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/sound/soc/intel/boards/kbl_da7219_max98357a.c b/sound/soc/intel/boards/kbl_da7219_max98357a.c
> index c332a32..ad3029d 100644
> --- a/sound/soc/intel/boards/kbl_da7219_max98357a.c
> +++ b/sound/soc/intel/boards/kbl_da7219_max98357a.c
> @@ -66,14 +66,6 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
>   		return -EIO;
>   	}
>   
> -	/* Configure sysclk for codec */
> -	ret = snd_soc_dai_set_sysclk(codec_dai, DA7219_CLKSRC_MCLK, 24576000,
> -				     SND_SOC_CLOCK_IN);
> -	if (ret) {
> -		dev_err(card->dev, "can't set codec sysclk configuration\n");
> -		return ret;
> -	}
> -
>   	if (SND_SOC_DAPM_EVENT_OFF(event)) {
>   		ret = snd_soc_dai_set_pll(codec_dai, 0,
>   				     DA7219_SYSCLK_MCLK, 0, 0);
> @@ -170,9 +162,18 @@ static int kabylake_da7219_codec_init(struct snd_soc_pcm_runtime *rtd)
>   {
>   	struct kbl_codec_private *ctx = snd_soc_card_get_drvdata(rtd->card);
>   	struct snd_soc_component *component = rtd->codec_dai->component;
> +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
>   	struct snd_soc_jack *jack;
>   	int ret;
>   
> +	/* Configure sysclk for codec */
> +	ret = snd_soc_dai_set_sysclk(codec_dai, DA7219_CLKSRC_MCLK, 24576000,
> +						SND_SOC_CLOCK_IN);
> +	if (ret) {
> +		dev_err(rtd->dev, "can't set codec sysclk configuration\n");
> +		return ret;
> +	}
> +
>   	/*
>   	 * Headset buttons map to the google Reference headset.
>   	 * These can be configured by userspace.
