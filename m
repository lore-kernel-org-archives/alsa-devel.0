From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 3/5] ASoC: Intel: Add Geminilake Dialog
 Maxim machine driver support
Date: Wed, 11 Apr 2018 11:20:10 -0500
Message-ID: <8fefaa36-2682-a604-4af9-6d4a2575c4f9@linux.intel.com>
References: <1523442303-12710-1-git-send-email-naveen.m@intel.com>
 <1523442303-12710-4-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B645266E30
 for <alsa-devel@alsa-project.org>; Wed, 11 Apr 2018 18:20:15 +0200 (CEST)
In-Reply-To: <1523442303-12710-4-git-send-email-naveen.m@intel.com>
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
To: Naveen Manohar <naveen.m@intel.com>, alsa-devel@alsa-project.org
Cc: vinod.koul@intel.com, harshapriya.n@intel.com, broonie@kernel.org, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

  geminilake audio machine driver for SPT + DA7219 */
> +static struct snd_soc_card glk_audio_card_da7219_m98357a = {
> +	.name = "glkda7219max",
> +	.owner = THIS_MODULE,
> +	.dai_link = broxton_dais,
> +	.num_links = ARRAY_SIZE(broxton_dais),
> +	.controls = broxton_controls,
> +	.num_controls = ARRAY_SIZE(broxton_controls),
> +	.dapm_widgets = broxton_widgets,
> +	.num_dapm_widgets = ARRAY_SIZE(broxton_widgets),
> +	.dapm_routes = audio_map,
> +	.num_dapm_routes = ARRAY_SIZE(audio_map),
> +	.fully_routed = true,
> +	.late_probe = bxt_card_late_probe,
> +};
> +
> +static char glk_spk_dai_name[10];
> +static char glk_hs_dai_name[10];

Off-by-one? "SSPx-Codec" would be 11 chars if you include null termination.

> +
>   static int broxton_audio_probe(struct platform_device *pdev)
>   {
>   	struct bxt_card_private *ctx;
> +	int dai_index = 8;

maybe better to do an explicit search that hard-code values?
This will actually not work if you have an additional FE for headset on 
GLK, or you are assuming a dependency on a patch added later in the 
series - not good.

>   
>   	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_ATOMIC);
>   	if (!ctx)
> @@ -584,18 +638,54 @@ static int broxton_audio_probe(struct platform_device *pdev)
>   
>   	INIT_LIST_HEAD(&ctx->hdmi_pcm_list);
>   
> -	broxton_audio_card.dev = &pdev->dev;
> -	snd_soc_card_set_drvdata(&broxton_audio_card, ctx);
> +	audio_card =
> +		(struct snd_soc_card *)pdev->id_entry->driver_data;
> +
> +	audio_card->dev = &pdev->dev;
> +	snd_soc_card_set_drvdata(audio_card, ctx);
> +
> +	if (is_geminilake()) {
> +		/* fixup name & cpu_dai_name for SPK */
> +		snprintf(glk_spk_dai_name,
> +			sizeof(glk_spk_dai_name), "%s", "SSP1-Codec");
> +		broxton_dais[dai_index].name = glk_spk_dai_name;
> +		snprintf(glk_spk_dai_name,
> +			sizeof(glk_spk_dai_name), "%s", "SSP1 Pin");
> +		broxton_dais[dai_index].cpu_dai_name = glk_spk_dai_name;

does this work? You have the dai_name and cpu_dai_name pointing to the 
same string?

> +		/* fixup name & cpu_dai_name for HS*/
> +		dai_index++;
> +		snprintf(glk_hs_dai_name,
> +			sizeof(glk_hs_dai_name), "%s", "SSP2-Codec");
> +		broxton_dais[dai_index].name = glk_hs_dai_name;
> +		snprintf(glk_hs_dai_name,
> +			sizeof(glk_hs_dai_name), "%s", "SSP2 Pin");
> +		broxton_dais[dai_index].cpu_dai_name = glk_hs_dai_name;

same here?

> +	}
>   
> -	return devm_snd_soc_register_card(&pdev->dev, &broxton_audio_card);
> +	return devm_snd_soc_register_card(&pdev->dev, audio_card);
>   }
>   
> +static const struct platform_device_id bxt_board_ids[] = {
> +	{
> +		.name = "bxt_da7219_max98357a",
> +		.driver_data =
> +			(kernel_ulong_t)&bxt_audio_card_da7219_m98357a,
> +	},
> +	{
> +		.name = "glk_da7219_max98357a",
> +		.driver_data =
> +			(kernel_ulong_t)&glk_audio_card_da7219_m98357a,
> +	},
> +	{ }
> +};
> +
>   static struct platform_driver broxton_audio = {
>   	.probe = broxton_audio_probe,
>   	.driver = {
>   		.name = "bxt_da7219_max98357a",
>   		.pm = &snd_soc_pm_ops,
>   	},
> +	.id_table = bxt_board_ids,
>   };
>   module_platform_driver(broxton_audio)
>   
> @@ -605,5 +695,7 @@ MODULE_AUTHOR("Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>");
>   MODULE_AUTHOR("Rohit Ainapure <rohit.m.ainapure@intel.com>");
>   MODULE_AUTHOR("Harsha Priya <harshapriya.n@intel.com>");
>   MODULE_AUTHOR("Conrad Cooke <conrad.cooke@intel.com>");
> +MODULE_AUTHOR("Naveen Manohar <naveen.m@intel.com>");
>   MODULE_LICENSE("GPL v2");
>   MODULE_ALIAS("platform:bxt_da7219_max98357a");
> +MODULE_ALIAS("platform:glk_da7219_max98357a");
> 
