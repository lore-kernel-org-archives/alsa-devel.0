From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 4/5] ASoC: Intel: bytcr_rt5651: Disable
 jack-detect over suspend/resume
Date: Mon, 9 Jul 2018 17:57:37 -0500
Message-ID: <c5ead62d-0d0c-d720-30fc-a1a7187227c4@linux.intel.com>
References: <20180704225935.7902-1-hdegoede@redhat.com>
 <20180704225935.7902-4-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id A49622675CF
 for <alsa-devel@alsa-project.org>; Tue, 10 Jul 2018 00:57:41 +0200 (CEST)
In-Reply-To: <20180704225935.7902-4-hdegoede@redhat.com>
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
To: Hans de Goede <hdegoede@redhat.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org



On 07/04/2018 05:59 PM, Hans de Goede wrote:
> Disable jack-detection and thus the codec IRQ over suspend/resume.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   sound/soc/intel/boards/bytcr_rt5651.c | 49 ++++++++++++++++++++++++---
>   1 file changed, 44 insertions(+), 5 deletions(-)
>
> diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
> index 5301205496be..2a8f86dfe4cb 100644
> --- a/sound/soc/intel/boards/bytcr_rt5651.c
> +++ b/sound/soc/intel/boards/bytcr_rt5651.c
> @@ -676,6 +676,48 @@ static struct snd_soc_dai_link byt_rt5651_dais[] = {
>   };
>   
>   /* SoC card */
> +static char byt_rt5651_codec_name[SND_ACPI_I2C_ID_LEN];
> +static char byt_rt5651_codec_aif_name[12]; /*  = "rt5651-aif[1|2]" */
> +static char byt_rt5651_cpu_dai_name[10]; /*  = "ssp[0|2]-port" */
> +static char byt_rt5651_long_name[40]; /* = "bytcr-rt5651-*-mic[-swapped-hp]" */
> +
> +static int byt_rt5651_suspend(struct snd_soc_card *card)
> +{
> +	struct snd_soc_component *component;
> +
> +	if (!BYT_RT5651_JDSRC(byt_rt5651_quirk))
> +		return 0;
> +
> +	list_for_each_entry(component, &card->component_dev_list, card_list) {
> +		if (!strcmp(component->name, byt_rt5651_codec_name)) {
> +			dev_dbg(component->dev, "disabling jack detect before suspend\n");
> +			snd_soc_component_set_jack(component, NULL, NULL);
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int byt_rt5651_resume(struct snd_soc_card *card)
> +{
> +	struct byt_rt5651_private *priv = snd_soc_card_get_drvdata(card);
> +	struct snd_soc_component *component;
> +
> +	if (!BYT_RT5651_JDSRC(byt_rt5651_quirk))
> +		return 0;
> +
> +	list_for_each_entry(component, &card->component_dev_list, card_list) {
> +		if (!strcmp(component->name, byt_rt5651_codec_name)) {
> +			dev_dbg(component->dev, "re-enabling jack detect after resume\n");
> +			snd_soc_component_set_jack(component, &priv->jack, NULL);
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   static struct snd_soc_card byt_rt5651_card = {
>   	.name = "bytcr-rt5651",
>   	.owner = THIS_MODULE,
> @@ -686,13 +728,10 @@ static struct snd_soc_card byt_rt5651_card = {
>   	.dapm_routes = byt_rt5651_audio_map,
>   	.num_dapm_routes = ARRAY_SIZE(byt_rt5651_audio_map),
>   	.fully_routed = true,
> +	.suspend_pre = byt_rt5651_suspend,
> +	.resume_post = byt_rt5651_resume,
>   };
>   
> -static char byt_rt5651_codec_name[SND_ACPI_I2C_ID_LEN];
> -static char byt_rt5651_codec_aif_name[12]; /*  = "rt5651-aif[1|2]" */
> -static char byt_rt5651_cpu_dai_name[10]; /*  = "ssp[0|2]-port" */
> -static char byt_rt5651_long_name[40]; /* = "bytcr-rt5651-*-mic[-swapped-hp]" */
> -
>   static const struct x86_cpu_id baytrail_cpu_ids[] = {
>   	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ATOM_SILVERMONT1 }, /* Valleyview */
>   	{}
