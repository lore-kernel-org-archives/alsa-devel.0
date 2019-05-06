From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: bytcr_rt5651.c: remove string buffers
 'byt_rt5651_cpu_dai_name' and 'byt_rt5651_cpu_dai_name'
Date: Mon, 6 May 2019 10:24:48 -0500
Message-ID: <ea3ac342-c3a2-6054-77f7-0f13d0e9d593@linux.intel.com>
References: <20190504151652.5213-1-user@elitebook-localhost>
 <20190504151652.5213-4-user@elitebook-localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190504151652.5213-4-user@elitebook-localhost>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nariman <narimantos@gmail.com>, linux-kernel@vger.kernel.org
Cc: hdegoede@redhat.com, liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, Jordy Ubink <jordyubink@hotmail.nl>
List-Id: alsa-devel@alsa-project.org

On 5/4/19 10:16 AM, Nariman wrote:
> From: Jordy Ubink <jordyubink@hotmail.nl>
> 
> The snprintf calls filling byt_rt5651_cpu_dai_name / byt_rt5651_cpu_dai_name always fill them with the same string (ssp0-port" resp "rt5651-aif2"). So instead of keeping these buffers around and making the cpu_dai_name / codec_dai_name point to this, simply update the foo_dai_name pointers to directly point to a string constant containing the desired string.
> 
> Signed-off-by: Jordy Ubink <jordyubink@hotmail.nl>
> ---
>   sound/soc/intel/boards/bytcr_rt5651.c | 24 ++++--------------------
>   1 file changed, 4 insertions(+), 20 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
> index e528995668b7..2e1bf43820d8 100644
> --- a/sound/soc/intel/boards/bytcr_rt5651.c
> +++ b/sound/soc/intel/boards/bytcr_rt5651.c
> @@ -730,8 +730,6 @@ static struct snd_soc_dai_link byt_rt5651_dais[] = {
>   
>   /* SoC card */
>   static char byt_rt5651_codec_name[SND_ACPI_I2C_ID_LEN];
> -static char byt_rt5651_codec_aif_name[12]; /*  = "rt5651-aif[1|2]" */
> -static char byt_rt5651_cpu_dai_name[10]; /*  = "ssp[0|2]-port" */
>   static char byt_rt5651_long_name[50]; /* = "bytcr-rt5651-*-spk-*-mic[-swapped-hp]" */
>   
>   static int byt_rt5651_suspend(struct snd_soc_card *card)
> @@ -1009,26 +1007,12 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
>   	log_quirks(&pdev->dev);
>   
>   	if ((byt_rt5651_quirk & BYT_RT5651_SSP2_AIF2) ||
> -	    (byt_rt5651_quirk & BYT_RT5651_SSP0_AIF2)) {
> -		/* fixup codec aif name */
> -		snprintf(byt_rt5651_codec_aif_name,
> -			sizeof(byt_rt5651_codec_aif_name),
> -			"%s", "rt5651-aif2");
> -
> -		byt_rt5651_dais[dai_index].codec_dai_name =
> -			byt_rt5651_codec_aif_name;
> -	}
> +	    (byt_rt5651_quirk & BYT_RT5651_SSP0_AIF2))
> +		byt_rt5651_dais[dai_index].codec_dai_name = "rt5651-aif2";
>   
>   	if ((byt_rt5651_quirk & BYT_RT5651_SSP0_AIF1) ||
> -	    (byt_rt5651_quirk & BYT_RT5651_SSP0_AIF2)) {
> -		/* fixup cpu dai name name */
> -		snprintf(byt_rt5651_cpu_dai_name,
> -			sizeof(byt_rt5651_cpu_dai_name),
> -			"%s", "ssp0-port");
> -
> -		byt_rt5651_dais[dai_index].cpu_dai_name =
> -			byt_rt5651_cpu_dai_name;
> -	}
> +	    (byt_rt5651_quirk & BYT_RT5651_SSP0_AIF2))
> +		byt_rt5651_dais[dai_index].cpu_dai_name = "ssp0-port";

same issues with Signed-off-by and missing quirks.

>   
>   	if (byt_rt5651_quirk & BYT_RT5651_MCLK_EN) {
>   		priv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
> 
