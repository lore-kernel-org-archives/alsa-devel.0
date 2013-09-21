From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH v2 1/2] ASoC: kirkwood: clk: probe defer when clock not
 yet ready
Date: Sat, 21 Sep 2013 19:06:24 +0200
Message-ID: <20130921190624.1435c26b@armhf>
References: <20130921120006.47b00fe7@armhf>
	<20130921104734.GJ12758@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130921104734.GJ12758-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 21 Sep 2013 11:47:34 +0100
Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:

> On Sat, Sep 21, 2013 at 12:00:06PM +0200, Jean-Francois Moine wrote:
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index a004769..582abc8 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -2181,7 +2181,7 @@ EXPORT_SYMBOL_GPL(of_clk_del_provider);
> >  struct clk *of_clk_get_from_provider(struct of_phandle_args *clksp=
ec)
> >  {
> >  	struct of_clk_provider *provider;
> > -	struct clk *clk =3D ERR_PTR(-ENOENT);
> > +	struct clk *clk =3D ERR_PTR(-EPROBE_DEFER);
> > =20
> >  	/* Check if we have such a provider in our array */
> >  	mutex_lock(&of_clk_lock);
> > diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
> > index 442a313..f8b28d9 100644
> > --- a/drivers/clk/clkdev.c
> > +++ b/drivers/clk/clkdev.c
> > @@ -157,8 +157,13 @@ struct clk *clk_get(struct device *dev, const =
char *con_id)
> > =20
> >  	if (dev) {
> >  		clk =3D of_clk_get_by_name(dev->of_node, con_id);
> > -		if (!IS_ERR(clk) && __clk_get(clk))
> > -			return clk;
> > +		if (!IS_ERR(clk)) {
> > +			if (__clk_get(clk))
> > +				return clk;
> > +		} else {
> > +			if (PTR_ERR(clk) =3D=3D -EPROBE_DEFER)
> > +				return clk;
> > +		}
>=20
> Another comment.  This is broken - it will never fall through if a
> 'dev' is given, because of_clk_get_by_name() will always return an
> -EPROBE_DEFER error pointer in that case.
>=20
> So this approach is unworkable.

> And another comment:
>=20
> This whole approach is broken - while Mark is correct that we should
> find a way to return -EPROBE_DEFER if a clock is specified, the solut=
ion
> here does not allow that - it will return -EPROBE_DEFER whenever the
> clock is not found _or_ is not specified.
>=20
> This has the effect of making the external clock *non*optional for th=
e
> kirkwood-i2s driver, which is also completely broken.

It works fine for me (I tried both cases, with and without the external
clock).

The scheme is as follows:

- kirkwood-i2s kirkwood_i2s_dev_probe() calls:

	priv->extclk =3D &pdev->dev, "extclk");

- devm_clk_get() calls:

	clk =3D clk_get(dev, id);

- clk_get() does:

	if (dev)			// this is the case
		clk =3D of_clk_get_by_name(dev->of_node, con_id);

- of_clk_get_by_name() does:

	if (name)			// this is the case
		index =3D of_property_match_string(np, "clock-names", name);

  Here, if the external clock is declared in the DT, index is >=3D 0.
  If there is no externel clock in the DT, index is < 0.

	clk =3D of_clk_get(np, index);
 	if (!IS_ERR(clk))
		break;
	else if (name && index >=3D 0) {
		pr_err("ERROR: could not get clock %s:%s(%i)\n",
 			np->full_name, name ? name : "", index); =20
 		return clk;
 	}

- If the index is < 0, of_clk_get() immediately returns -EINVAL.

  So, kirkwood-i2s knows there is no external clock. DONE.

- otherwise, if the index is >=3D 0 (the external clock is declared in
  the DT), of_clk_get() gets the phandle (of_parse_phandle_with_args())
  and gets the clock (of_clk_get_from_provider()).

  This last function returns either the clock (device initialized),
  a -EPROBE_DEFER error (clock not yet initialized) or some other
  error (bad DT or clock error).

  So, kirkwood-i2s knows there is a declared external clock and it acts
  according to the return code (accept, defer or ignore). DONE.

Did I miss something?

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
