From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] ASoC: wm8960: update pll and
	clock	setting function
Date: Mon, 10 Aug 2015 09:32:46 +0100
Message-ID: <20150810083246.GH25225@opensource.wolfsonmicro.com>
References: <ac311441efbc167953de3ab8706217c3c669f88d.1436776563.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8340E2652E7
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2015 10:32:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <ac311441efbc167953de3ab8706217c3c669f88d.1436776563.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 13, 2015 at 04:41:00PM +0800, Zidan Wang wrote:
> Add sysclk auto mode. When it's sysclk auto mode, if the MCLK is
> available for clock configure, using MCLK to provide sysclk directly,
> otherwise, search a available pll out frequcncy and set pll.
> 
> Configure clock in hw_params may cause problems when using bypass style
> paths without hw_params in machine driver getting called. So add configure
> clock to set_bias_level.
> 
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> ---
<snip>
> @@ -711,6 +785,9 @@ static int wm8960_set_bias_level_out3(struct snd_soc_codec *codec,
>  	case SND_SOC_BIAS_PREPARE:
>  		switch (snd_soc_codec_get_bias_level(codec)) {
>  		case SND_SOC_BIAS_STANDBY:
> +			ret = wm8960_configure_clocking(codec);
> +			if (ret)
> +				return ret;

Is it right that we are calling wm8960_configure_clocking before
clk_prepare_enable? As configure_clocking will enable the clocks
shouldn't mclk be available before then?

>  			if (!IS_ERR(wm8960->mclk)) {
>  				ret = clk_prepare_enable(wm8960->mclk);
>  				if (ret) {
> @@ -726,6 +803,13 @@ static int wm8960_set_bias_level_out3(struct snd_soc_codec *codec,
>  			break;
>  
>  		case SND_SOC_BIAS_ON:
> +			/*
> +			 * If it's sysclk auto mode, and the pll is enabled,
> +			 * disable the pll
> +			 */
> +			if (wm8960->clk_id == WM8960_SYSCLK_AUTO && (pm2 & 0x1))
> +				wm8960_set_pll(codec, 0, 0);
> +
>  			if (!IS_ERR(wm8960->mclk))
>  				clk_disable_unprepare(wm8960->mclk);
>  			break;
> @@ -780,6 +864,7 @@ static int wm8960_set_bias_level_capless(struct snd_soc_codec *codec,
>  					 enum snd_soc_bias_level level)
>  {
>  	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
> +	u16 pm2 = snd_soc_read(codec, WM8960_POWER2);
>  	int reg, ret;
>  
>  	switch (level) {
> @@ -822,6 +907,10 @@ static int wm8960_set_bias_level_capless(struct snd_soc_codec *codec,
>  
>  			msleep(100);
>  
> +			ret = wm8960_configure_clocking(codec);
> +			if (ret)
> +				return ret;
> +

Ditto here.

Other than that I think this looks ok to me.

Thanks,
Charles
