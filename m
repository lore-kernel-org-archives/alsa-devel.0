From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: cht_bsw_max98090_ti: Remove unused
 function cht_get_codec_dai()
Date: Tue, 23 May 2017 12:25:17 -0700
Message-ID: <6f941eb4-04b9-89ea-a791-c65c939581cf@linux.intel.com>
References: <20170523190509.59212-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170523190509.59212-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Yang A Fang <yang.a.fang@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>
List-Id: alsa-devel@alsa-project.org

On 5/23/17 12:05 PM, Matthias Kaehlcke wrote:
> Looks like the function has never been used since it was added by commit
> 17119a465706 ("ASoC: Intel: Add Cherrytrail & Braswell machine driver
> cht_bsw_max98090_ti"). Removing it fixes the following warning when
> building with clang:
>
> sound/soc/intel/boards/cht_bsw_max98090_ti.c:42:35: error: unused
>     function 'cht_get_codec_dai' [-Werror,-Wunused-function]

Fine but it'll have to be re-added when I finally find the time to 
support Baytrail with this driver.

>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  sound/soc/intel/boards/cht_bsw_max98090_ti.c | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
> index 742bc0d4e681..20755ecc7f9e 100644
> --- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
> +++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
> @@ -39,18 +39,6 @@ struct cht_mc_private {
>  	bool ts3a227e_present;
>  };
>
> -static inline struct snd_soc_dai *cht_get_codec_dai(struct snd_soc_card *card)
> -{
> -	struct snd_soc_pcm_runtime *rtd;
> -
> -	list_for_each_entry(rtd, &card->rtd_list, list) {
> -		if (!strncmp(rtd->codec_dai->name, CHT_CODEC_DAI,
> -			     strlen(CHT_CODEC_DAI)))
> -			return rtd->codec_dai;
> -	}
> -	return NULL;
> -}
> -
>  static const struct snd_soc_dapm_widget cht_dapm_widgets[] = {
>  	SND_SOC_DAPM_HP("Headphone", NULL),
>  	SND_SOC_DAPM_MIC("Headset Mic", NULL),
>
