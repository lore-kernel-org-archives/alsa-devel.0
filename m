From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_asrc: sound is wrong after
	suspend/resume
Date: Fri, 11 Dec 2015 21:30:27 -0800
Message-ID: <20151212053025.GB3564@Asurada-CZ80>
References: <1449745370-18960-1-git-send-email-zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 by alsa0.perex.cz (Postfix) with ESMTP id A420C26549F
 for <alsa-devel@alsa-project.org>; Sat, 12 Dec 2015 06:30:31 +0100 (CET)
Received: by obciw8 with SMTP id iw8so98241926obc.1
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2015 21:30:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1449745370-18960-1-git-send-email-zidan.wang@freescale.com>
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.com, Xiubo.Lee@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 10, 2015 at 07:02:48PM +0800, Zidan Wang wrote:

> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index 3e404ba..942e74bc 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -990,6 +990,9 @@ static int fsl_asrc_suspend(struct device *dev)
>  {
>  	struct fsl_asrc *asrc_priv = dev_get_drvdata(dev);
>  
> +	regmap_read(asrc_priv->regmap, REG_ASRCFG,
> +				&asrc_priv->regcache_cfg);

Indentation.

> +
>  	regcache_cache_only(asrc_priv->regmap, true);
>  	regcache_mark_dirty(asrc_priv->regmap);
>  
> @@ -1010,6 +1013,9 @@ static int fsl_asrc_resume(struct device *dev)
>  	regcache_cache_only(asrc_priv->regmap, false);
>  	regcache_sync(asrc_priv->regmap);
>  
> +	regmap_update_bits(asrc_priv->regmap, REG_ASRCFG,
> +				0x1FFFC0, asrc_priv->regcache_cfg);

Either add a macro or a comment for the magic number.

> +
>  	/* Restart enabled pairs */
>  	regmap_update_bits(asrc_priv->regmap, REG_ASRCTR,
>  			   ASRCTR_ASRCEi_ALL_MASK, asrctr);
> diff --git a/sound/soc/fsl/fsl_asrc.h b/sound/soc/fsl/fsl_asrc.h
> index 68802cd..3695ca9 100644
> --- a/sound/soc/fsl/fsl_asrc.h
> +++ b/sound/soc/fsl/fsl_asrc.h
> @@ -453,6 +453,8 @@ struct fsl_asrc {
>  
>  	int asrc_rate;
>  	int asrc_width;
> +
> +	u32 regcache_cfg;
>  };
>  
>  extern struct snd_soc_platform_driver fsl_asrc_platform;
> -- 
> 1.9.1
> 
