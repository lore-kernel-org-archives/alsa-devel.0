From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Subject: Re: [PATCH] sound: soc: codecs: wcd9335: fix "conversion to bool not
 needed here"
Date: Sat, 13 Jul 2019 19:20:46 +0530
Message-ID: <20190713135045.GA15087@hari-Inspiron-1545>
References: <20190711174906.GA10867@hari-Inspiron-1545>
 <eeeb09518c8967ffd48606c3d1222553752e895d.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <eeeb09518c8967ffd48606c3d1222553752e895d.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Vinod Koul <vkoul@kernel.org>, Wen Yang <wen.yang99@zte.com.cn>, Gen Zhang <blackgod016574@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 11, 2019 at 03:00:00PM -0700, Joe Perches wrote:
> On Thu, 2019-07-11 at 23:19 +0530, Hariprasad Kelam wrote:
> > Fix below issue reported by coccicheck
> > sound/soc/codecs/wcd9335.c:3991:25-30: WARNING: conversion to bool not
> > needed here
> > 
> > Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> > ---
> >  sound/soc/codecs/wcd9335.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> > 
> > diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
> > index 1bbbe42..85a8d10 100644
> > --- a/sound/soc/codecs/wcd9335.c
> > +++ b/sound/soc/codecs/wcd9335.c
> > @@ -3988,12 +3988,7 @@ static irqreturn_t wcd9335_slimbus_irq(int irq, void *data)
> >  		regmap_read(wcd->if_regmap,
> >  				WCD9335_SLIM_PGD_PORT_INT_RX_SOURCE0 + j, &val);
> >  		if (val) {
> > -			if (!tx)
> > -				reg = WCD9335_SLIM_PGD_PORT_INT_EN0 +
> > -					(port_id / 8);
> > -			else
> > -				reg = WCD9335_SLIM_PGD_PORT_INT_TX_EN0 +
> > -					(port_id / 8);
> > +			reg = WCD9335_SLIM_PGD_PORT_INT_TX_EN0 + (port_id / 8);
> >  			regmap_read(
> >  				wcd->if_regmap, reg, &int_val);
> >  			/*
> 
> This change makes no sense and doesn't match the commit message.
> 
>Please ignore this patch. Both the statments in if/else look similar to
>me but they are not.
