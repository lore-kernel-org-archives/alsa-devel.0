From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH v2] ASoC: soc-core: add snd_soc_of_parse_master_clkdir()
 for dt
Date: Mon, 6 Jan 2014 05:41:59 +0000
Message-ID: <23375d0ac7734f37be9928d6add885f7@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1388630905-1321-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1388630905-1321-1-git-send-email-Li.Xiubo@freescale.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
Cc: "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

Hi

I would like to know the current status of this patch, and there are some
other patches that for simple-card are depended on this one.

Thanks,


--
> This patch adds snd_soc_of_parse_master_clkdir() and supports below
> style on dt:
> 
> master-clkdir-out;
> 
> If this property is absent 0 will be returned, 1 otherwise.
> 0 : SND_SOC_CLOCK_IN
> 1 : SND_SOC_CLOCK_OUT
> 
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> ---
>  include/sound/soc.h  |  1 +
>  sound/soc/soc-core.c | 11 +++++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index 5a049d9..690f4f6 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -1170,6 +1170,7 @@ int snd_soc_of_parse_card_name(struct snd_soc_card *card,
>  			       const char *propname);
>  int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
>  				   const char *propname);
> +unsigned int snd_soc_of_parse_master_clkdir(struct device_node *np);
>  unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
>  				     const char *prefix);
>  int snd_soc_of_get_dai_name(struct device_node *of_node,
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index be88df5..f155207 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -4472,6 +4472,17 @@ int snd_soc_of_parse_audio_routing(struct snd_soc_card
> *card,
>  }
>  EXPORT_SYMBOL_GPL(snd_soc_of_parse_audio_routing);
> 
> +unsigned int snd_soc_of_parse_master_clkdir(struct device_node *np)
> +{
> +	/*
> +	 * check "master-clkdir-out"
> +	 * false means SND_SOC_CLOCK_IN
> +	 * true means SND_SOC_CLOCK_OUT
> +	 */
> +	return !!of_property_read_bool(np, "master-clkdir-out");
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_of_parse_master_clkdir);
> +
>  unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
>  				     const char *prefix)
>  {
> --
> 1.8.4
> 
