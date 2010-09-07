From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 3/5] fbdev: sh_mobile_hdmi: add new label
 for sound error path
Date: Tue, 7 Sep 2010 09:13:57 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1009070912140.1345@axis700.grange>
References: <w3pvd6i6ois.wl%kuninori.morimoto.gx@renesas.com>
	<w3ppqwq6ofp.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by alsa0.perex.cz (Postfix) with SMTP id C2908243FF
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Sep 2010 09:13:48 +0200 (CEST)
In-Reply-To: <w3ppqwq6ofp.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hello Morimoto-san

On Tue, 7 Sep 2010, Kuninori Morimoto wrote:

> Reported-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

You have not addressed all of my comments to your sh_mobile_hdmi.c patch 
and you have not explained, why you do not address them. On the whole, I 
am still in favour of reverting that original patch and redoing it.

Thanks
Guennadi

> ---
>  drivers/video/sh_mobile_hdmi.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
> index d51f751..a2d6f7b 100644
> --- a/drivers/video/sh_mobile_hdmi.c
> +++ b/drivers/video/sh_mobile_hdmi.c
> @@ -974,7 +974,7 @@ static int __init sh_hdmi_probe(struct platform_device *pdev)
>  	ret =  snd_soc_register_codec(&pdev->dev,
>  			&soc_codec_dev_sh_hdmi, &sh_hdmi_dai, 1);
>  	if (ret < 0)
> -		goto egetclk;
> +		goto esndreg;
>  
>  	hdmi->dev = &pdev->dev;
>  
> @@ -1061,6 +1061,8 @@ eclkenable:
>  erate:
>  	clk_put(hdmi->hdmi_clk);
>  egetclk:
> +	snd_soc_unregister_codec(&pdev->dev);
> +esndreg:
>  	kfree(hdmi);
>  
>  	return ret;
> -- 
> 1.7.0.4
> 
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
