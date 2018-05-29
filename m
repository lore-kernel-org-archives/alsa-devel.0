From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: bytcr_rt5640: Add quirk for
 the ARCHOS 80 Cesium 8" windows tablet
Date: Tue, 29 May 2018 08:48:18 -0500
Message-ID: <f5aa3bac-958a-d301-1b89-2f3f4c1cb40e@linux.intel.com>
References: <20180528202649.2406-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 10FDD2676D6
 for <alsa-devel@alsa-project.org>; Tue, 29 May 2018 15:48:22 +0200 (CEST)
In-Reply-To: <20180528202649.2406-1-hdegoede@redhat.com>
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

On 5/28/18 3:26 PM, Hans de Goede wrote:
> Add a quirk for the ARCHOS 80 Cesium 8" windows tablet, this device mostly
> works with the default settings, except that it has only one speaker.
> So add a quirk with the default settings + the mono-speaker flag.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

This MONO_SPEAKER quirk was initially an optimization to avoid enabling 
unnecessary amplifiers, but now it's needed to apply the right UCM config.


> ---
>   sound/soc/intel/boards/bytcr_rt5640.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
> index 828be866fb00..d675d550f6c1 100644
> --- a/sound/soc/intel/boards/bytcr_rt5640.c
> +++ b/sound/soc/intel/boards/bytcr_rt5640.c
> @@ -419,6 +419,16 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
>   						 BYT_RT5640_SSP0_AIF1),
>   
>   	},
> +	{
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ARCHOS"),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ARCHOS 80 Cesium"),
> +		},
> +		.driver_data = (void *)(BYTCR_INPUT_DEFAULTS |
> +					BYT_RT5640_MONO_SPEAKER |
> +					BYT_RT5640_SSP0_AIF1 |
> +					BYT_RT5640_MCLK_EN),
> +	},
>   	{
>   		.matches = {
>   			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> 
