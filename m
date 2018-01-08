From: "Zhang, Keqiao" <keqiao.zhang@intel.com>
Subject: Re: [PATCH 2/4] ASoC: Intel: bytcr-rt5651:
	enable	MinnowBoard Turbot quirks
Date: Mon, 8 Jan 2018 08:25:03 +0000
Message-ID: <57E804B13068CF489D6E1F6E5365559B5762CA7F@SHSMSX103.ccr.corp.intel.com>
References: <20180105192023.11229-1-pierre-louis.bossart@linux.intel.com>
 <20180105192023.11229-4-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CAF1266DCD
 for <alsa-devel@alsa-project.org>; Mon,  8 Jan 2018 09:25:07 +0100 (CET)
In-Reply-To: <20180105192023.11229-4-pierre-louis.bossart@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, Keyon Jie <yang.jie@linux.intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "Koul,
 Vinod" <vinod.koul@intel.com>, "broonie@kernel.org" <broonie@kernel.org>, Carlo Caione <carlo@caione.org>, "bardliao@realtek.com" <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-bounces@alsa-
> project.org] On Behalf Of Pierre-Louis Bossart
> Sent: Saturday, January 6, 2018 3:20 AM
> To: alsa-devel@alsa-project.org
> Cc: tiwai@suse.de; Keyon Jie <yang.jie@linux.intel.com>; Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com>; liam.r.girdwood@linux.intel.com; Koul,
> Vinod <vinod.koul@intel.com>; broonie@kernel.org; Carlo Caione
> <carlo@caione.org>; bardliao@realtek.com
> Subject: [alsa-devel] [PATCH 2/4] ASoC: Intel: bytcr-rt5651: enable
> MinnowBoard Turbot quirks
> 
> Define DMI quirk for rt5651 eval board connected to MinnowBoard Turbot. The
> only difference with a MinnowBoard MAX is that the MCLK pin is enabled on the
> LSE connector
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Tested-by: Keqiao.Zhang <Keqiao.zhang@intel.com>
> ---
>  sound/soc/intel/boards/bytcr_rt5651.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/bytcr_rt5651.c
> b/sound/soc/intel/boards/bytcr_rt5651.c
> index de3758b2aac1..7d95008f1795 100644
> --- a/sound/soc/intel/boards/bytcr_rt5651.c
> +++ b/sound/soc/intel/boards/bytcr_rt5651.c
> @@ -266,6 +266,15 @@ static const struct dmi_system_id
> byt_rt5651_quirk_table[] = {
>  		},
>  		.driver_data = (void *)(BYT_RT5651_IN3_MAP),
>  	},
> +	{
> +		.callback = byt_rt5651_quirk_cb,
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ADI"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Minnowboard
> Turbot"),
> +		},
> +		.driver_data = (void *)(BYT_RT5651_MCLK_EN |
> +					BYT_RT5651_IN3_MAP),
> +	},
>  	{
>  		.callback = byt_rt5651_quirk_cb,
>  		.matches = {
> --
> 2.14.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
