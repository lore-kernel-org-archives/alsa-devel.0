From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re:
 =?iso-8859-1?q?No_sound_captured_with_SGTL5000_on_i?=
 =?iso-8859-1?q?=2EMX6_in_I=B2S_master_mode?=
Date: Thu, 18 Sep 2014 11:13:38 -0700
Message-ID: <20140918181338.GD6432@Asurada>
References: <CAOMZO5CReW7-8L7zx=z1TshwJSzcfGThCjws7fTfbZJKCnCZLg@mail.gmail.com>
 <CAOf5uwmrsuXSCpUXhf3pTCRt0=4pprwfiP5MDDukE=WRzOk2WA@mail.gmail.com>
 <CAL8zT=jw4QQSzoq_8d0j-SXYEWzsNgz279dhDzjTHHr-jutP=Q@mail.gmail.com>
 <CAOf5uw=R0oHGDyFhueepoftfDb_d4vccO_751apBLg7S3gzGjg@mail.gmail.com>
 <CAL8zT=gcYkCRE9TU+2w+qBDtM+gYKqr-0KRDy7UxQXJ0P3LutQ@mail.gmail.com>
 <CAL8zT=igU9F=MZ0dQSgqgkq-T=PV-jbXAZeYAaMDs1ot_1MjCg@mail.gmail.com>
 <20140918170524.GA6080@Asurada> <20140918172611.GA17048@panicking>
 <20140918174526.GA6432@Asurada> <20140918180331.GA19033@panicking>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f178.google.com (mail-pd0-f178.google.com
 [209.85.192.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 96F092654C5
 for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2014 20:13:45 +0200 (CEST)
Received: by mail-pd0-f178.google.com with SMTP id p10so1911805pdj.9
 for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2014 11:13:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140918180331.GA19033@panicking>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Shengjiu Wang <shengjiu.wang@freescale.com>, Markus Pargmann <mpa@pengutronix.de>, Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>, Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawn.guo@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 18, 2014 at 08:03:31PM +0200, Michael Trimarchi wrote:
> > Ah, this is a problem. We should not use ssi_private->pdev->dev here.
> > I think it'll be better if adding a new parameter of *dev pointer to
> > this _set_dai_fmt() -- passing pdev->dev in probe() and cpu_dai->dev
> > in fsl_ssi_set_dai_fmt().
> > 
> 
> Somenthing like this?

Yes, would you like to send a separate patch? I think other people
and maintainers'd like to take a look at it and decide if it's a
good shoot. I'll also take a further look at it after I finish my
laundry :)

Thank you
Nicolin

> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 87eb577..de6ab06 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -748,8 +748,9 @@ static int fsl_ssi_hw_free(struct snd_pcm_substream *substream,
>  	return 0;
>  }
>  
> -static int _fsl_ssi_set_dai_fmt(struct fsl_ssi_private *ssi_private,
> -		unsigned int fmt)
> +static int _fsl_ssi_set_dai_fmt(struct device *dev,
> +				struct fsl_ssi_private *ssi_private,
> +				unsigned int fmt)
>  {
>  	struct regmap *regs = ssi_private->regs;
>  	u32 strcr = 0, stcr, srcr, scr, mask;
> @@ -758,7 +759,7 @@ static int _fsl_ssi_set_dai_fmt(struct fsl_ssi_private *ssi_private,
>  	ssi_private->dai_fmt = fmt;
>  
>  	if (fsl_ssi_is_i2s_master(ssi_private) && IS_ERR(ssi_private->baudclk)) {
> -		dev_err(&ssi_private->pdev->dev, "baudclk is missing which is necessary for master mode\n");
> +		dev_err(dev, "baudclk is missing which is necessary for master mode\n");
>  		return -EINVAL;
>  	}
>  
> @@ -913,7 +914,7 @@ static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
>  {
>  	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
>  
> -	return _fsl_ssi_set_dai_fmt(ssi_private, fmt);
> +	return _fsl_ssi_set_dai_fmt(cpu_dai->dev, ssi_private, fmt);
>  }
>  
>  /**
> @@ -1387,7 +1388,8 @@ static int fsl_ssi_probe(struct platform_device *pdev)
>  
>  done:
>  	if (ssi_private->dai_fmt)
> -		_fsl_ssi_set_dai_fmt(ssi_private, ssi_private->dai_fmt);
> +		_fsl_ssi_set_dai_fmt(&pdev->dev, ssi_private,
> +				     ssi_private->dai_fmt);
>  
>  	return 0;
>  
> > Nicolin
> 
> -- 
> | Michael Nazzareno Trimarchi                     Amarula Solutions BV |
> | COO  -  Founder                                      Cruquiuskade 47 |
> | +31(0)851119172                                 Amsterdam 1018 AM NL |
> |                  [`as] http://www.amarulasolutions.com               |
