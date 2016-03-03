From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: wm8994: codec driver should manage
 its own MCLK
Date: Thu, 3 Mar 2016 10:14:53 -0800
Message-ID: <20160303181452.GA19755@Asurada-Nvidia>
References: <bc33ec0dcfc610657d60d4e1f381545a81147e3e.1456986779.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 8ADE72655A6
 for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2016 19:14:41 +0100 (CET)
Received: by mail-pa0-f45.google.com with SMTP id fi3so16994179pac.3
 for <alsa-devel@alsa-project.org>; Thu, 03 Mar 2016 10:14:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <bc33ec0dcfc610657d60d4e1f381545a81147e3e.1456986779.git.zidan.wang@freescale.com>
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
Cc: ckeepax@opensource.wolfsonmicro.com, broonie@kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 03, 2016 at 02:45:35PM +0800, Zidan Wang wrote:
> codec driver should manage its own master clock, MCLK1 and MCLK2.
> When bias_level change from standby to prepare, enable codec MCLK.
> When bias_level change from prepare to standby, disable codec MCLK.

Not sure the desired sequence here, would be neater to use runtime pm?

> @@ -270,6 +271,7 @@ static int wm8994_set_pdata_from_of(struct wm8994 *wm8994)
>  {
>  	struct device_node *np = wm8994->dev->of_node;
>  	struct wm8994_pdata *pdata = &wm8994->pdata;
> +	char tmp[8];
>  	int i;
>  
>  	if (!np)
> @@ -310,6 +312,11 @@ static int wm8994_set_pdata_from_of(struct wm8994 *wm8994)
>  	if (pdata->ldo[1].enable < 0)
>  		pdata->ldo[1].enable = 0;
>  
> +	for (i = 0; i < WM8994_NUM_MCLK; i++) {
> +		sprintf(tmp, "MCLK%d", i + 1);
> +		pdata->mclk[i] = devm_clk_get(wm8994->dev, tmp);

Probe defer?

> @@ -2474,6 +2475,8 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
>  {
>  	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
>  	struct wm8994 *control = wm8994->wm8994;
> +	struct wm8994_pdata *pdata = &control->pdata;
> +	int i;
>  
>  	wm_hubs_set_bias_level(codec, level);
>  
> @@ -2495,8 +2498,13 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
>  			break;
>  		}
>  
> -		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_STANDBY)
> +		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_STANDBY) {
>  			active_reference(codec);
> +
> +			for (i = 0; i < WM8994_NUM_MCLK; i++)
> +				if (!IS_ERR(pdata->mclk[i]))
> +					clk_prepare_enable(pdata->mclk[i]);

Return value? You probably should refer to wm8962 or wm8960.
