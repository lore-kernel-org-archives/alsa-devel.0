From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] tlv320aic3x symmetric rates
Date: Wed, 18 Aug 2010 13:54:40 +0100
Message-ID: <1282136080.3117.384.camel@odin>
References: <AANLkTimG1yR48_hZiKJrG_kuXK0d5EHXA8DnCun4Eq2A@mail.gmail.com>
	<20100818091928.GA5719@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 142A61037FC
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Aug 2010 14:54:44 +0200 (CEST)
Received: by wyb42 with SMTP id 42so729823wyb.38
	for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2010 05:54:43 -0700 (PDT)
In-Reply-To: <20100818091928.GA5719@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Randolph Chung <rchung42@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-08-18 at 10:19 +0100, Mark Brown wrote:
> On Wed, Aug 18, 2010 at 05:09:45PM +0800, Randolph Chung wrote:
> > The tlv320aic3x codec driver only supports symmetric rates for
> > capture/playback. Set the flag in the DAI accordingly.
> > 
> > Signed-off-by: Randolph Chung <tausq@parisc-linux.org>
> 
> Please remember to always CC maintainers on patches.
> 
> > diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
> > index 71a6990..63cad43 100644
> > --- a/sound/soc/codecs/tlv320aic3x.c
> > +++ b/sound/soc/codecs/tlv320aic3x.c
> > @@ -1116,6 +1116,7 @@ struct snd_soc_dai aic3x_dai = {
> >                 .rates = AIC3X_RATES,
> >                 .formats = AIC3X_FORMATS,},
> >         .ops = &aic3x_dai_ops,
> > +       .symmetric_rates = 1,
> >  };
> >  EXPORT_SYMBOL_GPL(aic3x_dai);
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > 
> 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
