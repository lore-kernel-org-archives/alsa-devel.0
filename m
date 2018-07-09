From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: bytcr_rt5640: Add quirk for
 the Lenovo Miix2 8 tablet
Date: Mon, 9 Jul 2018 17:58:30 -0500
Message-ID: <42abb6a5-a84c-694c-fcdc-87ca339699e4@linux.intel.com>
References: <20180707102210.15633-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 757252676FD
 for <alsa-devel@alsa-project.org>; Tue, 10 Jul 2018 00:58:33 +0200 (CEST)
In-Reply-To: <20180707102210.15633-1-hdegoede@redhat.com>
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
To: Hans de Goede <hdegoede@redhat.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: russianneuromancer@ya.ru, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 07/07/2018 05:22 AM, Hans de Goede wrote:
> Add a quirk for the Lenovo Miix2 8 tablet, this tablet uses a digital
> mic on DMIC1 and has a mono-speaker. The jack-detect uses the default
> settings..
>
> Reported-and-tested-by: russianneuromancer@ya.ru
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   sound/soc/intel/boards/bytcr_rt5640.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
> index 718f022b3aa0..d32844f94d74 100644
> --- a/sound/soc/intel/boards/bytcr_rt5640.c
> +++ b/sound/soc/intel/boards/bytcr_rt5640.c
> @@ -562,6 +562,19 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
>   					BYT_RT5640_SSP0_AIF1 |
>   					BYT_RT5640_MCLK_EN),
>   	},
> +	{	/* Lenovo Miix 2 8 */
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "20326"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Hiking"),
> +		},
> +		.driver_data = (void *)(BYT_RT5640_DMIC1_MAP |
> +					BYT_RT5640_JD_SRC_JD2_IN4N |
> +					BYT_RT5640_OVCD_TH_2000UA |
> +					BYT_RT5640_OVCD_SF_0P75 |
> +					BYT_RT5640_MONO_SPEAKER |
> +					BYT_RT5640_MCLK_EN),
> +	},
>   	{	/* MSI S100 tablet */
>   		.matches = {
>   			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Micro-Star International Co., Ltd."),
