From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re:
 =?iso-8859-1?q?No_sound_captured_with_SGTL5000_on_i?=
 =?iso-8859-1?q?=2EMX6_in_I=B2S_master_mode?=
Date: Thu, 18 Sep 2014 20:03:31 +0200
Message-ID: <20140918180331.GA19033@panicking>
References: <CAL8zT=hSCpBZpqVGQ5uBdXJe25hqoNkmiPh_Ge3RCrGALkaoZg@mail.gmail.com>
 <CAOMZO5CReW7-8L7zx=z1TshwJSzcfGThCjws7fTfbZJKCnCZLg@mail.gmail.com>
 <CAOf5uwmrsuXSCpUXhf3pTCRt0=4pprwfiP5MDDukE=WRzOk2WA@mail.gmail.com>
 <CAL8zT=jw4QQSzoq_8d0j-SXYEWzsNgz279dhDzjTHHr-jutP=Q@mail.gmail.com>
 <CAOf5uw=R0oHGDyFhueepoftfDb_d4vccO_751apBLg7S3gzGjg@mail.gmail.com>
 <CAL8zT=gcYkCRE9TU+2w+qBDtM+gYKqr-0KRDy7UxQXJ0P3LutQ@mail.gmail.com>
 <CAL8zT=igU9F=MZ0dQSgqgkq-T=PV-jbXAZeYAaMDs1ot_1MjCg@mail.gmail.com>
 <20140918170524.GA6080@Asurada> <20140918172611.GA17048@panicking>
 <20140918174526.GA6432@Asurada>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f50.google.com (mail-wg0-f50.google.com [74.125.82.50])
 by alsa0.perex.cz (Postfix) with ESMTP id B5D9826551B
 for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2014 20:03:37 +0200 (CEST)
Received: by mail-wg0-f50.google.com with SMTP id x13so1287196wgg.33
 for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2014 11:03:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140918174526.GA6432@Asurada>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Shengjiu Wang <shengjiu.wang@freescale.com>, Markus Pargmann <mpa@pengutronix.de>, Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>, Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawn.guo@freescale.com>
List-Id: alsa-devel@alsa-project.org

Hi

On Thu, Sep 18, 2014 at 10:45:27AM -0700, Nicolin Chen wrote:
> On Thu, Sep 18, 2014 at 07:26:11PM +0200, Michael Trimarchi wrote:
> > bug was reported by Jean-Michel. I don't know if it works because I can not
> > test but seems ok. Do we need this _set_dai_fmt in probe function?
> 
> I think yes. The AC97 part might need this _set_dai_fmt call in the
> probe().
> 
> > code is a bit broken just because panic on probe path if pdev is null
> > [...]
> > 	/*
> > 	 * If codec-handle property is missing from SSI node, we assume
> > 	 * that the machine driver uses new binding which does not require
> > 	 * SSI driver to trigger machine driver's probe.
> > 	 */
> > 	if (!of_get_property(np, "codec-handle", NULL))
> > 		goto done;
> > [...]
> > 	ssi_private->pdev =
> > 		platform_device_register_data(&pdev->dev, name, 0, NULL, 0);
> > [...]
> > done:
> > 	if (ssi_private->dai_fmt)
> > 		_fsl_ssi_set_dai_fmt(ssi_private, ssi_private->dai_fmt);
> > 
> > 
> > diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> > index 87eb577..f63bc02 100644
> > --- a/sound/soc/fsl/fsl_ssi.c
> > +++ b/sound/soc/fsl/fsl_ssi.c
> > @@ -758,7 +758,8 @@ static int _fsl_ssi_set_dai_fmt(struct fsl_ssi_private *ssi_private,
> >  	ssi_private->dai_fmt = fmt;
> >  
> >  	if (fsl_ssi_is_i2s_master(ssi_private) && IS_ERR(ssi_private->baudclk)) {
> > -		dev_err(&ssi_private->pdev->dev, "baudclk is missing which is necessary for master mode\n");
> > +		pr_err("baudclk is missing which is necessary"
> > +			" for master mode\n");
> 
> Ah, this is a problem. We should not use ssi_private->pdev->dev here.
> I think it'll be better if adding a new parameter of *dev pointer to
> this _set_dai_fmt() -- passing pdev->dev in probe() and cpu_dai->dev
> in fsl_ssi_set_dai_fmt().
> 

Somenthing like this?

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 87eb577..de6ab06 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -748,8 +748,9 @@ static int fsl_ssi_hw_free(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int _fsl_ssi_set_dai_fmt(struct fsl_ssi_private *ssi_private,
-		unsigned int fmt)
+static int _fsl_ssi_set_dai_fmt(struct device *dev,
+				struct fsl_ssi_private *ssi_private,
+				unsigned int fmt)
 {
 	struct regmap *regs = ssi_private->regs;
 	u32 strcr = 0, stcr, srcr, scr, mask;
@@ -758,7 +759,7 @@ static int _fsl_ssi_set_dai_fmt(struct fsl_ssi_private *ssi_private,
 	ssi_private->dai_fmt = fmt;
 
 	if (fsl_ssi_is_i2s_master(ssi_private) && IS_ERR(ssi_private->baudclk)) {
-		dev_err(&ssi_private->pdev->dev, "baudclk is missing which is necessary for master mode\n");
+		dev_err(dev, "baudclk is missing which is necessary for master mode\n");
 		return -EINVAL;
 	}
 
@@ -913,7 +914,7 @@ static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 {
 	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
 
-	return _fsl_ssi_set_dai_fmt(ssi_private, fmt);
+	return _fsl_ssi_set_dai_fmt(cpu_dai->dev, ssi_private, fmt);
 }
 
 /**
@@ -1387,7 +1388,8 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 
 done:
 	if (ssi_private->dai_fmt)
-		_fsl_ssi_set_dai_fmt(ssi_private, ssi_private->dai_fmt);
+		_fsl_ssi_set_dai_fmt(&pdev->dev, ssi_private,
+				     ssi_private->dai_fmt);
 
 	return 0;
 
> Nicolin

-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
