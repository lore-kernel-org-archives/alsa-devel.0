From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/8] regulator: da9055: Add DT support
Date: Wed, 5 Feb 2014 18:36:42 +0000
Message-ID: <20140205183642.GH32298@sirena.org.uk>
References: <cover.1391614923.git.Adam.Thomson.Opensource@diasemi.com>
 <6d76ae40cd435eaae0323f3e806515130b06a376.1391614923.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QwZB9vYiNIzNXIj"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6d76ae40cd435eaae0323f3e806515130b06a376.1391614923.git.Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--+QwZB9vYiNIzNXIj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 05, 2014 at 05:48:35PM +0000, Adam Thomson wrote:

> +#ifdef CONFIG_OF
> +#include <linux/of.h>
> +#include <linux/regulator/of_regulator.h>
> +#endif /* CONFIG_OF */

Don't do ifdefs for includes like this, it's not worth it.

> +	for_each_child_of_node(nproot, np) {
> +		if (!of_node_cmp(np->name,
> +				 regulator->info->reg_desc.name)) {
> +			config->init_data = of_get_regulator_init_data(
> +				&pdev->dev, np);
> +			config->of_node = np;
> +			break;
> +		}
> +	}

I think you're looking for of_regulator_match() here.

>  	if (pdata && pdata->regulators)
>  		config.init_data = pdata->regulators[pdev->id];
> +	else {
> +		ret = da9055_regulator_dt_init(pdev, regulator, &config);
> +		if (ret < 0)
> +			return ret;
> +	}

Coding style, both sides of the if should have braces if one does.

>  	/* Only LDO 5 and 6 has got the over current interrupt */
>  	if (pdev->id == DA9055_ID_LDO5 || pdev->id ==  DA9055_ID_LDO6) {
> -		irq = platform_get_irq_byname(pdev, "REGULATOR");
> -		irq = regmap_irq_get_virq(da9055->irq_data, irq);
> +		irq = regmap_irq_get_virq(da9055->irq_data,
> +					  DA9055_IRQ_REGULATOR);

This seems like a bit of a step backwards - what happened in the MFD
(and why didn't it update the users to avoid breaking bisection)?

--+QwZB9vYiNIzNXIj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS8oS3AAoJELSic+t+oim9tPQP/imavOOL72wfQup37GqTgR4i
0fFPtKk9LwK1J/TBzvPI08WhEahuVIXHqAYOfYUcxgre9tGVtvoKEYybZpwDmfTb
m0lL9e78cAWSprm1ZDBazypZBFKRiQ80IUCrP38ZmkHV3X2gQm5C+IJx+6ugJFEg
qktaDr1xp69AmKOsVj9pcla0L1QCqHyPypAXCi/NbDxn23KLuy1yuhkzi01HJD0X
QJdCqFx7rWmDlQ5GjXx+PZn5cj8AsxH2VN81FlySgg0P/lSILpiRYmxbi4FKRNDG
jWDZl74sAsCnDU3Fzjz4X86tfXPn9x6NztC2UjgnL0+53kDcyMrZFeJsWyu5Pa5T
vDqlfiHW7F0lamN9Otl5MnxQUqqAfPffcGjcjLVuJvtQjRuADuPh3mrYdB/dvWKg
fu3USNFPQDk9jRO2QqtV9ec5NDf8WLg1TJvMH+RYCrR7cWJ4XGHdAoMuFdRiCvw5
hCfgWkRyU7oqDcSQFOk2qT3TzC/U21IVxwPD+ZxzCfTbIvAJ7RraN9RVQU+wnyEL
twcuEdKktx5pRyPKadeRnBj/HAi3Cp0TrwSvBtmwxim18QkIHlizOAQaQOVIqUjc
dNik28SS2Mg7Wo7Lpt45eNyNJ0Np5ZMwrg73N4fQJ3RPuS35rgwfDF2u9QfAPaeq
60z4+MMaygHeGBr3Dlpq
=vd2d
-----END PGP SIGNATURE-----

--+QwZB9vYiNIzNXIj--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
