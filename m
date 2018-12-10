From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/2] ASoC: Intel: bytcr_rt5640: Add quirk
 for the Prowise PT301 tablet
Date: Mon, 10 Dec 2018 08:35:01 -0600
Message-ID: <d79e64b3-72bc-9ae6-7ad5-5b50d7ab3585@linux.intel.com>
References: <20181208130114.6612-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 14AA6267AF7
 for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2018 15:35:03 +0100 (CET)
In-Reply-To: <20181208130114.6612-1-hdegoede@redhat.com>
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
To: Hans de Goede <hdegoede@redhat.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 12/8/18 7:01 AM, Hans de Goede wrote:
> Add a quirk for the Prowise PT301 tablet, this BYTCR tablet has no CHAN
> package in its ACPI tables and uses SSP0-AIF1 rather then SSP0-AIF2 which
> is the default for BYTCR devices.
>
> Also it uses IN1 for its MIC and JD2 for jack-detect, rather then the
> default IN3 and JD1.

Looks like someone was trying hard to avoid using defaults...Oh well.

Both patch 1 and 2

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   sound/soc/intel/boards/bytcr_rt5640.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
> index 8587bd3d1cc1..6df902e3a380 100644
> --- a/sound/soc/intel/boards/bytcr_rt5640.c
> +++ b/sound/soc/intel/boards/bytcr_rt5640.c
> @@ -674,6 +674,20 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
>   					BYT_RT5640_SSP0_AIF2 |
>   					BYT_RT5640_MCLK_EN),
>   	},
> +	{
> +		/* Prowise PT301 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Prowise"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "PT301"),
> +		},
> +		.driver_data = (void *)(BYT_RT5640_IN1_MAP |
> +					BYT_RT5640_JD_SRC_JD2_IN4N |
> +					BYT_RT5640_OVCD_TH_2000UA |
> +					BYT_RT5640_OVCD_SF_0P75 |
> +					BYT_RT5640_DIFF_MIC |
> +					BYT_RT5640_SSP0_AIF1 |
> +					BYT_RT5640_MCLK_EN),
> +	},
>   	{
>   		.matches = {
>   			DMI_MATCH(DMI_BOARD_VENDOR, "TECLAST"),
