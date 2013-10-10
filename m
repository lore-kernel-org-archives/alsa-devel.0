From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: Re: [PATCH] ASoC: mc13783: add mixer controls
Date: Thu, 10 Oct 2013 09:36:47 +0200
Message-ID: <20131010073647.GG14042@pengutronix.de>
References: <1381330904-26389-1-git-send-email-s.trumtrar@pengutronix.de>
 <52557484.1070808@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 56DB52619D7
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2013 09:36:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <52557484.1070808@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 09, 2013 at 05:21:40PM +0200, Lars-Peter Clausen wrote:
> On 10/09/2013 05:01 PM, Steffen Trumtrar wrote:
> > [...]
> > +
> > +static const struct soc_enum mc13783_enum_asp =
> > +	SOC_ENUM_SINGLE(MC13783_AUDIO_RX0, 4, ARRAY_SIZE(mc13783_alsp),
> > +			mc13783_alsp);
> > +
> > +static const struct soc_enum mc13783_enum_alsp =
> > +	SOC_ENUM_SINGLE(MC13783_AUDIO_RX0, 7, ARRAY_SIZE(mc13783_alsp),
> > +			mc13783_alsp);
> > +
> > +static const struct soc_enum mc13783_enum_ahs =
> > +	SOC_ENUM_SINGLE(MC13783_AUDIO_RX0, 11, ARRAY_SIZE(mc13783_ahs),
> > +			mc13783_ahs);
> > +
> > +static const struct soc_enum mc13783_enum_arxout =
> > +	SOC_ENUM_SINGLE(MC13783_AUDIO_RX0, 17, ARRAY_SIZE(mc13783_ahs),
> > +			mc13783_ahs);
> > +
> > +static const struct soc_enum mc13783_enum_codec =
> > +	SOC_ENUM_SINGLE(MC13783_AUDIO_RX1, 4, ARRAY_SIZE(mc13783_alsp),
> > +			mc13783_alsp);
> 
> For bonus points use SOC_ENUM_SINGLE_DECL(...) ;)
> 

Yay, bonus points. I will change that.

Thanks,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
