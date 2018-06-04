From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/2] ASoC: Intel: bytcr_rt5640: Add quirk
 for the Nuvison/TMax TM800W560 tablet
Date: Mon, 4 Jun 2018 08:57:58 -0500
Message-ID: <ddb258d0-e8c4-fda7-f45f-fc396fc31acc@linux.intel.com>
References: <20180603134232.677-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id D689F267866
 for <alsa-devel@alsa-project.org>; Mon,  4 Jun 2018 15:58:00 +0200 (CEST)
In-Reply-To: <20180603134232.677-1-hdegoede@redhat.com>
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

On 6/3/18 8:42 AM, Hans de Goede wrote:
> Add a quirk for the Nuvison/TMax TM800W560 tablet, this tablet uses IN1
> for the internal mic rather then the default IN3 and it uses JD2 rather
> then JD1 for its not-inverted jack-detect switch.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Both
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

BTW maybe we should move those quirks to a separate file, the quirk 
definitions will become larger than actual code pretty soon ...

> ---
>   sound/soc/intel/boards/bytcr_rt5640.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
> index d675d550f6c1..27a05778584f 100644
> --- a/sound/soc/intel/boards/bytcr_rt5640.c
> +++ b/sound/soc/intel/boards/bytcr_rt5640.c
> @@ -549,6 +549,20 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
>   					BYT_RT5640_DIFF_MIC |
>   					BYT_RT5640_MCLK_EN),
>   	},
> +	{	/* Nuvison/TMax TM800W560 */
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "TMAX"),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "TM800W560L"),
> +		},
> +		.driver_data = (void *)(BYT_RT5640_IN1_MAP |
> +					BYT_RT5640_JD_SRC_JD2_IN4N |
> +					BYT_RT5640_OVCD_TH_2000UA |
> +					BYT_RT5640_OVCD_SF_0P75 |
> +					BYT_RT5640_JD_NOT_INV |
> +					BYT_RT5640_DIFF_MIC |
> +					BYT_RT5640_SSP0_AIF1 |
> +					BYT_RT5640_MCLK_EN),
> +	},
>   	{	/* Pipo W4 */
>   		.matches = {
>   			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
> 
