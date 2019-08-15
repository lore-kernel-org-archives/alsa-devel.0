From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ASoC: intel: cht_bsw_max98090_ti: Add all Chromebooks
 that need pmc_plt_clk_0 quirk
Date: Thu, 15 Aug 2019 19:24:30 +0200
Message-ID: <175edc67-e0e0-f690-704e-b74b110eda16@redhat.com>
References: <20190815171300.30126-1-daniel.stuart14@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190815171300.30126-1-daniel.stuart14@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Stuart <daniel.stuart14@gmail.com>
Cc: cezary.rojewski@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Daniel Stuart <daniel.stuart@pucpr.edu.br>, Thomas Gleixner <tglx@linutronix.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 15-08-19 19:12, Daniel Stuart wrote:
> Every single baytrail chromebook sets PMC to 0, as can be seeing
> below by searching through coreboot source code:
> 	$ grep -rl "PMC_PLT_CLK\[0\]" .
> 	./rambi/variants/glimmer/devicetree.cb
> 	./rambi/variants/clapper/devicetree.cb
> 	./rambi/variants/swanky/devicetree.cb
> 	./rambi/variants/enguarde/devicetree.cb
> 	./rambi/variants/winky/devicetree.cb
> 	./rambi/variants/kip/devicetree.cb
> 	./rambi/variants/squawks/devicetree.cb
> 	./rambi/variants/orco/devicetree.cb
> 	./rambi/variants/ninja/devicetree.cb
> 	./rambi/variants/heli/devicetree.cb
> 	./rambi/variants/sumo/devicetree.cb
> 	./rambi/variants/banjo/devicetree.cb
> 	./rambi/variants/candy/devicetree.cb
> 	./rambi/variants/gnawty/devicetree.cb
> 	./rambi/variants/rambi/devicetree.cb
> 	./rambi/variants/quawks/devicetree.cb
> 
> Plus, Cyan (only non-baytrail chromebook with max98090) also needs
> this patch for audio to work.
> 
> Thus, this commit adds all the missing devices to bsw_max98090 quirk
> table, implemented by commit a182ecd3809c ("ASoC: intel:
> cht_bsw_max98090_ti: Add quirk for boards using pmc_plt_clk_0").
> 
> Signed-off-by: Daniel Stuart <daniel.stuart14@gmail.com>

Thank you for catching this, this patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   sound/soc/intel/boards/cht_bsw_max98090_ti.c | 98 ++++++++++++++++++++
>   1 file changed, 98 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
> index 33eb72545be6..83b978e7b4c4 100644
> --- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
> +++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
> @@ -399,6 +399,20 @@ static struct snd_soc_card snd_soc_card_cht = {
>   };
>   
>   static const struct dmi_system_id cht_max98090_quirk_table[] = {
> +	{
> +		/* Banjo model Chromebook */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Banjo"),
> +		},
> +		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
> +	},
> +	{
> +		/* Candy model Chromebook */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Candy"),
> +		},
> +		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
> +	},
>   	{
>   		/* Clapper model Chromebook */
>   		.matches = {
> @@ -406,6 +420,27 @@ static const struct dmi_system_id cht_max98090_quirk_table[] = {
>   		},
>   		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
>   	},
> +	{
> +		/* Cyan model Chromebook */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Cyan"),
> +		},
> +		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
> +	},
> +	{
> +		/* Enguarde model Chromebook */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Enguarde"),
> +		},
> +		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
> +	},
> +	{
> +		/* Glimmer model Chromebook */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Glimmer"),
> +		},
> +		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
> +	},
>   	{
>   		/* Gnawty model Chromebook (Acer Chromebook CB3-111) */
>   		.matches = {
> @@ -413,6 +448,62 @@ static const struct dmi_system_id cht_max98090_quirk_table[] = {
>   		},
>   		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
>   	},
> +	{
> +		/* Heli model Chromebook */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Heli"),
> +		},
> +		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
> +	},
> +	{
> +		/* Kip model Chromebook */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Kip"),
> +		},
> +		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
> +	},
> +	{
> +		/* Ninja model Chromebook */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Ninja"),
> +		},
> +		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
> +	},
> +	{
> +		/* Orco model Chromebook */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Orco"),
> +		},
> +		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
> +	},
> +	{
> +		/* Quawks model Chromebook */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Quawks"),
> +		},
> +		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
> +	},
> +	{
> +		/* Rambi model Chromebook */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Rambi"),
> +		},
> +		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
> +	},
> +	{
> +		/* Squawks model Chromebook */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Squawks"),
> +		},
> +		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
> +	},
> +	{
> +		/* Sumo model Chromebook */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Sumo"),
> +		},
> +		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
> +	},
>   	{
>   		/* Swanky model Chromebook (Toshiba Chromebook 2) */
>   		.matches = {
> @@ -420,6 +511,13 @@ static const struct dmi_system_id cht_max98090_quirk_table[] = {
>   		},
>   		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
>   	},
> +	{
> +		/* Winky model Chromebook */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Winky"),
> +		},
> +		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
> +	},
>   	{}
>   };
>   
> 
