From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: bytcr_rt5640: Add quirk for
 the "Connect Tablet 9" tablet
Date: Wed, 18 Jul 2018 15:36:01 -0500
Message-ID: <02ee687b-7f8c-366c-2e30-d360b0facf1e@linux.intel.com>
References: <20180701093023.6872-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A5C52677A0
 for <alsa-devel@alsa-project.org>; Wed, 18 Jul 2018 22:36:39 +0200 (CEST)
In-Reply-To: <20180701093023.6872-1-hdegoede@redhat.com>
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



On 07/01/2018 04:30 AM, Hans de Goede wrote:
> Add a quirk for the "Connect Tablet 9" tablet, this tablet has a
> mono-speaker. Otherwise it works fine with the defaults.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Sorry about the delay, I missed this patch.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>   sound/soc/intel/boards/bytcr_rt5640.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
> index 7456566c5648..718f022b3aa0 100644
> --- a/sound/soc/intel/boards/bytcr_rt5640.c
> +++ b/sound/soc/intel/boards/bytcr_rt5640.c
> @@ -486,6 +486,16 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
>   		},
>   		.driver_data = (void *)(BYT_RT5640_DMIC1_MAP),
>   	},
> +	{	/* Connect Tablet 9 */
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Connect"),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Tablet 9"),
> +		},
> +		.driver_data = (void *)(BYTCR_INPUT_DEFAULTS |
> +					BYT_RT5640_MONO_SPEAKER |
> +					BYT_RT5640_SSP0_AIF1 |
> +					BYT_RT5640_MCLK_EN),
> +	},
>   	{
>   		.matches = {
>   			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
