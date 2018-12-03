From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: intel: cht_bsw_max98090_ti: Add
 pmc_plt_clk_0 quirk for Chromebook Clapper
Date: Mon, 3 Dec 2018 09:25:20 -0600
Message-ID: <f90376f4-fd8f-72db-3930-9c545b8fe4b8@linux.intel.com>
References: <20181202122122.17808-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181202122122.17808-1-hdegoede@redhat.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


On 12/2/18 6:21 AM, Hans de Goede wrote:
> The Clapper model Chromebook uses pmc_plt_clk_0 instead of pmc_plt_clk_3
> for the mclk, just like the Swanky model.
>
> This commit adds a DMI based quirk for this.
>
> This fixing audio no longer working on these devices after
> commit 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
> that commit fixes us unnecessary keeping unused clocks on, but in case of
> the Clapper that was breaking audio support since we were not using the
> right clock in the cht_bsw_max98090_ti machine driver.
>
> Cc: stable@vger.kernel.org
> Fixes: 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   sound/soc/intel/boards/cht_bsw_max98090_ti.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
> index 9d9f6e41d81c..ad0c98383853 100644
> --- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
> +++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
> @@ -389,6 +389,13 @@ static struct snd_soc_card snd_soc_card_cht = {
>   };
>   
>   static const struct dmi_system_id cht_max98090_quirk_table[] = {
> +	{
> +		/* Clapper model Chromebook */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Clapper"),
> +		},
> +		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
> +	},
>   	{
>   		/* Swanky model Chromebook (Toshiba Chromebook 2) */
>   		.matches = {
