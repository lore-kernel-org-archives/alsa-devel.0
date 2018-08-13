From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: bytcr_rt5640: Add quirks for
 2 more devices
Date: Mon, 13 Aug 2018 10:52:30 -0500
Message-ID: <698987a0-8f09-d7a7-7e03-d28c0d56db87@linux.intel.com>
References: <20180812114206.10826-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id F3EDD2677AE
 for <alsa-devel@alsa-project.org>; Mon, 13 Aug 2018 17:52:53 +0200 (CEST)
In-Reply-To: <20180812114206.10826-1-hdegoede@redhat.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 8/12/18 6:42 AM, Hans de Goede wrote:
> Add quirks to select the right input-map, jack-detect pin, etc. for:
> 
> Linx Linx7 tablet
> Onda V975w tablet
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   sound/soc/intel/boards/bytcr_rt5640.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
> index d32844f94d74..b6dc524830b2 100644
> --- a/sound/soc/intel/boards/bytcr_rt5640.c
> +++ b/sound/soc/intel/boards/bytcr_rt5640.c
> @@ -575,6 +575,17 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
>   					BYT_RT5640_MONO_SPEAKER |
>   					BYT_RT5640_MCLK_EN),
>   	},
> +	{	/* Linx Linx7 tablet */
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LINX"),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "LINX7"),
> +		},
> +		.driver_data = (void *)(BYTCR_INPUT_DEFAULTS |
> +					BYT_RT5640_MONO_SPEAKER |
> +					BYT_RT5640_JD_NOT_INV |
> +					BYT_RT5640_SSP0_AIF1 |
> +					BYT_RT5640_MCLK_EN),
> +	},
>   	{	/* MSI S100 tablet */
>   		.matches = {
>   			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Micro-Star International Co., Ltd."),
> @@ -602,6 +613,21 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
>   					BYT_RT5640_SSP0_AIF1 |
>   					BYT_RT5640_MCLK_EN),
>   	},
> +	{	/* Onda v975w */
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Aptio CRB"),
> +			/* The above are too generic, also match BIOS info */
> +			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "5.6.5"),
> +			DMI_EXACT_MATCH(DMI_BIOS_DATE, "07/25/2014"),
> +		},
> +		.driver_data = (void *)(BYT_RT5640_IN1_MAP |
> +					BYT_RT5640_JD_SRC_JD2_IN4N |
> +					BYT_RT5640_OVCD_TH_2000UA |
> +					BYT_RT5640_OVCD_SF_0P75 |
> +					BYT_RT5640_DIFF_MIC |
> +					BYT_RT5640_MCLK_EN),
> +	},
>   	{	/* Pipo W4 */
>   		.matches = {
>   			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
> 
