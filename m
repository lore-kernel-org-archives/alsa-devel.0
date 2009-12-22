From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: add missing parameter to
	mx27vis_hifi_hw_free()
Date: Tue, 22 Dec 2009 10:30:49 +0000
Message-ID: <1261477849.3555.0.camel@odin>
References: <Pine.LNX.4.64.0912220923490.4919@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f212.google.com (mail-ew0-f212.google.com
	[209.85.219.212])
	by alsa0.perex.cz (Postfix) with ESMTP id D0A41243E4
	for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2009 11:30:53 +0100 (CET)
Received: by ewy4 with SMTP id 4so19510081ewy.32
	for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2009 02:30:53 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0912220923490.4919@axis700.grange>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2009-12-22 at 09:26 +0100, Guennadi Liakhovetski wrote:
> Commit 2ccafed4 added an extra parameter to the DAI .set_pll() method, but 
> it missed this call in sound/soc/imx/mx27vis_wm8974.c.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>  sound/soc/imx/mx27vis_wm8974.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/imx/mx27vis_wm8974.c b/sound/soc/imx/mx27vis_wm8974.c
> index 0267d2d..07d2a24 100644
> --- a/sound/soc/imx/mx27vis_wm8974.c
> +++ b/sound/soc/imx/mx27vis_wm8974.c
> @@ -180,7 +180,8 @@ static int mx27vis_hifi_hw_free(struct snd_pcm_substream *substream)
>  	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
>  
>  	/* disable the PLL */
> -	return codec_dai->ops->set_pll(codec_dai, IGNORED_ARG, 0, 0);
> +	return codec_dai->ops->set_pll(codec_dai, IGNORED_ARG, IGNORED_ARG,
> +				       0, 0);
>  }
>  
>  /*

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
