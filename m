From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: Boards: move the codec PLL
 configuration to _init
Date: Wed, 19 Dec 2018 07:55:45 -0600
Message-ID: <34d685bb-2a5b-7c56-eadc-8ddf56fa22fe@linux.intel.com>
References: <1544004679-8122-1-git-send-email-mac.chiang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 8347B26782E
 for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2018 14:55:44 +0100 (CET)
In-Reply-To: <1544004679-8122-1-git-send-email-mac.chiang@intel.com>
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
Cc: naveen.m@intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 12/5/18 4:11 AM, mac.chiang@intel.com wrote:
> From: Mac Chiang <mac.chiang@intel.com>
> 
> move the codec PLL to rt5682_codec_init, because codec only need to config the clock source/PLL once.
> As the result, remove the platform_clock_controls since no need to control clock anymore.
> 
> Signed-off-by: Shuming Fan <shumingf@realtek.com>
> Signed-off-by: Mac Chiang <mac.chiang@intel.com>

Looks like I forgot to ack this patch which was reviewed internally and 
feedback from Bard Liao applied.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


> ---
>   sound/soc/intel/boards/glk_rt5682_max98357a.c | 45 +++++----------------------
>   1 file changed, 7 insertions(+), 38 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/glk_rt5682_max98357a.c b/sound/soc/intel/boards/glk_rt5682_max98357a.c
> index c74c4f1..8f83b18 100644
> --- a/sound/soc/intel/boards/glk_rt5682_max98357a.c
> +++ b/sound/soc/intel/boards/glk_rt5682_max98357a.c
> @@ -55,39 +55,6 @@ enum {
>   	GLK_DPCM_AUDIO_HDMI3_PB,
>   };
>   
> -static int platform_clock_control(struct snd_soc_dapm_widget *w,
> -					struct snd_kcontrol *k, int  event)
> -{
> -	struct snd_soc_dapm_context *dapm = w->dapm;
> -	struct snd_soc_card *card = dapm->card;
> -	struct snd_soc_dai *codec_dai;
> -	int ret = 0;
> -
> -	codec_dai = snd_soc_card_get_codec_dai(card, GLK_REALTEK_CODEC_DAI);
> -	if (!codec_dai) {
> -		dev_err(card->dev, "Codec dai not found; Unable to set/unset codec pll\n");
> -		return -EIO;
> -	}
> -
> -	if (SND_SOC_DAPM_EVENT_OFF(event)) {
> -		ret = snd_soc_dai_set_sysclk(codec_dai, 0, 0, 0);
> -		if (ret)
> -			dev_err(card->dev, "failed to stop sysclk: %d\n", ret);
> -	} else if (SND_SOC_DAPM_EVENT_ON(event)) {
> -		ret = snd_soc_dai_set_pll(codec_dai, 0, RT5682_PLL1_S_MCLK,
> -					GLK_PLAT_CLK_FREQ, RT5682_PLL_FREQ);
> -		if (ret < 0) {
> -			dev_err(card->dev, "can't set codec pll: %d\n", ret);
> -			return ret;
> -		}
> -	}
> -
> -	if (ret)
> -		dev_err(card->dev, "failed to start internal clk: %d\n", ret);
> -
> -	return ret;
> -}
> -
>   static const struct snd_kcontrol_new geminilake_controls[] = {
>   	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
>   	SOC_DAPM_PIN_SWITCH("Headset Mic"),
> @@ -102,14 +69,10 @@ static const struct snd_soc_dapm_widget geminilake_widgets[] = {
>   	SND_SOC_DAPM_SPK("HDMI1", NULL),
>   	SND_SOC_DAPM_SPK("HDMI2", NULL),
>   	SND_SOC_DAPM_SPK("HDMI3", NULL),
> -	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
> -			platform_clock_control, SND_SOC_DAPM_PRE_PMU |
> -			SND_SOC_DAPM_POST_PMD),
>   };
>   
>   static const struct snd_soc_dapm_route geminilake_map[] = {
>   	/* HP jack connectors - unknown if we have jack detection */
> -	{ "Headphone Jack", NULL, "Platform Clock" },
>   	{ "Headphone Jack", NULL, "HPOL" },
>   	{ "Headphone Jack", NULL, "HPOR" },
>   
> @@ -117,7 +80,6 @@ static const struct snd_soc_dapm_route geminilake_map[] = {
>   	{ "Spk", NULL, "Speaker" },
>   
>   	/* other jacks */
> -	{ "Headset Mic", NULL, "Platform Clock" },
>   	{ "IN1P", NULL, "Headset Mic" },
>   
>   	/* digital mics */
> @@ -177,6 +139,13 @@ static int geminilake_rt5682_codec_init(struct snd_soc_pcm_runtime *rtd)
>   	struct snd_soc_jack *jack;
>   	int ret;
>   
> +	ret = snd_soc_dai_set_pll(codec_dai, 0, RT5682_PLL1_S_MCLK,
> +					GLK_PLAT_CLK_FREQ, RT5682_PLL_FREQ);
> +	if (ret < 0) {
> +		dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
> +		return ret;
> +	}
> +
>   	/* Configure sysclk for codec */
>   	ret = snd_soc_dai_set_sysclk(codec_dai, RT5682_SCLK_S_PLL1,
>   					RT5682_PLL_FREQ, SND_SOC_CLOCK_IN);
> 
