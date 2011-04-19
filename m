From: Simon Horman <simon@horms.net>
Subject: Re: [PATCH 1/2] ASoC: sh: fsi: add fsi_is_clk_master
	function
Date: Wed, 20 Apr 2011 08:34:24 +0900
Message-ID: <20110419233424.GG6418@verge.net.au>
References: <w3psjtespdm.wl%kuninori.morimoto.gx@renesas.com>
	<w3pr58yspcd.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 705F7103893
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Apr 2011 01:34:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <w3pr58yspcd.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: yoshii <takashi.yoshii.zj@renesas.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Magnus <magnus.damm@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 19, 2011 at 03:54:42PM +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Hi Morimoto-san,

this looks good, but it would be nice if your patch description
was a bit longer :-)

Reviewed-by: Simon Horman <simon@horms.net>

> ---
>  sound/soc/sh/fsi.c |   33 +++++++++++++++++++++++++--------
>  1 files changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
> index a40d15b..faca6ad 100644
> --- a/sound/soc/sh/fsi.c
> +++ b/sound/soc/sh/fsi.c
> @@ -146,10 +146,12 @@ struct fsi_priv {
>  	void __iomem *base;
>  	struct fsi_master *master;
>  
> -	int chan_num;
>  	struct fsi_stream playback;
>  	struct fsi_stream capture;
>  
> +	int chan_num:16;
> +	int clk_master:1;
> +
>  	long rate;
>  
>  	/* for suspend/resume */
> @@ -258,6 +260,11 @@ static struct fsi_master *fsi_get_master(struct fsi_priv *fsi)
>  	return fsi->master;
>  }
>  
> +static int fsi_is_clk_master(struct fsi_priv *fsi)
> +{
> +	return fsi->clk_master;
> +}
> +
>  static int fsi_is_port_a(struct fsi_priv *fsi)
>  {
>  	return fsi->master->base == fsi->base;
> @@ -807,14 +814,15 @@ static void fsi_dai_shutdown(struct snd_pcm_substream *substream,
>  	struct fsi_priv *fsi = fsi_get_priv(substream);
>  	int is_play = fsi_is_play(substream);
>  	struct fsi_master *master = fsi_get_master(fsi);
> -	set_rate_func set_rate;
> +	set_rate_func set_rate = fsi_get_info_set_rate(master);
>  
>  	fsi_irq_disable(fsi, is_play);
> -	fsi_clk_ctrl(fsi, 0);
>  
> -	set_rate = fsi_get_info_set_rate(master);
> -	if (set_rate && fsi->rate)
> +	if (fsi_is_clk_master(fsi)) {
> +		fsi_clk_ctrl(fsi, 0);
>  		set_rate(dai->dev, fsi_is_port_a(fsi), fsi->rate, 0);
> +	}
> +
>  	fsi->rate = 0;
>  
>  	pm_runtime_put_sync(dai->dev);
> @@ -890,6 +898,8 @@ static int fsi_set_fmt_spdif(struct fsi_priv *fsi)
>  static int fsi_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>  {
>  	struct fsi_priv *fsi = fsi_get_priv_frm_dai(dai);
> +	struct fsi_master *master = fsi_get_master(fsi);
> +	set_rate_func set_rate = fsi_get_info_set_rate(master);
>  	u32 flags = fsi_get_info_flags(fsi);
>  	u32 data = 0;
>  	int ret;
> @@ -900,6 +910,7 @@ static int fsi_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>  	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
>  	case SND_SOC_DAIFMT_CBM_CFM:
>  		data = DIMD | DOMD;
> +		fsi->clk_master = 1;
>  		break;
>  	case SND_SOC_DAIFMT_CBS_CFS:
>  		break;
> @@ -907,6 +918,13 @@ static int fsi_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>  		ret = -EINVAL;
>  		goto set_fmt_exit;
>  	}
> +
> +	if (fsi_is_clk_master(fsi) && !set_rate) {
> +		dev_err(dai->dev, "platform doesn't have set_rate\n");
> +		ret = -EINVAL;
> +		goto set_fmt_exit;
> +	}
> +
>  	fsi_reg_mask_set(fsi, CKG1, (DIMD | DOMD), data);
>  
>  	/* set format */
> @@ -933,13 +951,12 @@ static int fsi_dai_hw_params(struct snd_pcm_substream *substream,
>  {
>  	struct fsi_priv *fsi = fsi_get_priv(substream);
>  	struct fsi_master *master = fsi_get_master(fsi);
> -	set_rate_func set_rate;
> +	set_rate_func set_rate = fsi_get_info_set_rate(master);
>  	int fsi_ver = master->core->ver;
>  	long rate = params_rate(params);
>  	int ret;
>  
> -	set_rate = fsi_get_info_set_rate(master);
> -	if (!set_rate)
> +	if (!fsi_is_clk_master(fsi))
>  		return 0;
>  
>  	ret = set_rate(dai->dev, fsi_is_port_a(fsi), rate, 1);
> -- 
> 1.7.1
> 
