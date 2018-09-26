From: Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH 4/5] ASoC: max98088: Add master clock
	handling
Date: Wed, 26 Sep 2018 12:00:30 +0200
Message-ID: <20180926100030.tzn6hx6qqbjseopw@pengutronix.de>
References: <20180925142352.24106-1-m.felsch@pengutronix.de>
 <20180925142352.24106-5-m.felsch@pengutronix.de>
 <20180925171742.GR20825@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [85.220.165.71])
 by alsa0.perex.cz (Postfix) with ESMTP id D2652267730
 for <alsa-devel@alsa-project.org>; Wed, 26 Sep 2018 12:00:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180925171742.GR20825@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, robh+dt@kernel.org, kernel@pengutronix.de, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Tushar Behera <tushar.behera@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

thanks for review.

On 18-09-25 10:17, Mark Brown wrote:
> On Tue, Sep 25, 2018 at 04:23:51PM +0200, Marco Felsch wrote:
> > From: Andreas F=E4rber <afaerber@suse.de>
> > =

> > If master clock is provided through device tree, then update
> > the master clock frequency during set_sysclk.
> =

> This changelog suggests that the clock is optional...

Your are right, it was my fail to make it not optional.
> =

> > +	if (!IS_ERR(max98088->mclk)) {
> > +		freq =3D clk_round_rate(max98088->mclk, freq);
> > +		clk_set_rate(max98088->mclk, freq);
> > +	}
> =

> ...as does much of the code (note BTw that this ignores errors setting
> the clock)...
> =

> > +	max98088->mclk =3D devm_clk_get(&i2c->dev, "mclk");
> > +	if (IS_ERR(max98088->mclk)) {
> > +		if (PTR_ERR(max98088->mclk) =3D=3D -EPROBE_DEFER)
> > +			return -EPROBE_DEFER;
> > +		dev_err(&i2c->dev, "Invalid MCLK\n");
> > +		return -EINVAL;
> > +	}
> > +
> =

> ...but the probe function makes it mandatory (and also throws away the
> error code from clk_get() if it's not -EPROBE_DEFER).  Is this the best
> choice?  It seems inconsistent anyway.

One question, should it optional or not? If not I will fix it to return
the clk_get error else I will drop it. It shouldn't be optional In my
point of view, since it is needed by the chip.

Regards,
Marco
