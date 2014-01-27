From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 6/6] ASoC: tlv320aic32x4: Support for
	regulators
Date: Mon, 27 Jan 2014 15:15:33 +0000
Message-ID: <20140127151533.GA11727@sirena.org.uk>
References: <1390824190-18376-1-git-send-email-mpa@pengutronix.de>
 <1390824190-18376-7-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7975847291033132783=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E31C261B1E
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2014 16:15:48 +0100 (CET)
In-Reply-To: <1390824190-18376-7-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============7975847291033132783==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5C/VXimrgG1HEvSQ"
Content-Disposition: inline


--5C/VXimrgG1HEvSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 27, 2014 at 01:03:10PM +0100, Markus Pargmann wrote:

> +	aic32x4->supply_ldo = devm_regulator_get_optional(dev, "ldoin");
> +	aic32x4->supply_iov = devm_regulator_get_optional(dev, "iov");
> +	aic32x4->supply_dv = devm_regulator_get_optional(dev, "dv");
> +	aic32x4->supply_av = devm_regulator_get_optional(dev, "av");

These shouldn't be optional, it seems unlikely that the device is going
to work without power.  This will also be broken for probe deferral
since the code will just ignore errors so if the error is -EPROBE_DEFER
it'll not actually defer.

Just use the normal bulk functions, as Fabio said this will be simpler
too, and there should be code to disable on device removal at least
(ideally also on suspend and resume, and while the device is idle if it
doesn't have slow startup times).

--5C/VXimrgG1HEvSQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5ngRAAoJELSic+t+oim9xugQAJeec+AIh/uRBuL1aDy6/Hls
W3pvAjWGyRmwhMomy810NOVFVNOHFFdmVhV6Kh7kuPH7X5naNzGqyLlyZiZngPwN
E+YERW6z9+5oNojAypfLGeyOB8tbCFK6zlPlcflpXX4fPr0HWIhQKpK8AjAMF1ac
xyQ7NqnFInXUJgdOIkKCPkoWDOwbzfLN9ZAwT3VRjbr5WWmx5x1EoViVcHH8Hx5z
mc7Pw8raZwyrP14Pq6DXhSHr9zu7g/46VMuGiYf9Ju/Ev7a7URx/nCyhioye0IkE
PePZhZ/oONy3qZNe4JQcKmW3lhwytjrZt4iF9C36jLXwZBlDkhWUNY6fUjZWAzj8
49jeR0FuxnpORTIFAc0NCDM4WqMi7XoYOwMcyVIfbP5enxA76sJX8q++fvO+Eajn
3P0gbgFt8xx6CjoZjr62FDB3dOHGjL/MeqEVuiRqK/kCTvQB2WXoeM3+hRrdVyBY
iub1N1QyLejgKO8mdmWHFXRNwGDTTIwOqCUck9aDXbBBPHg+aBb0gQg3cf9FCAyh
vir7tao7g2gBAOF/Fhi9u4emrUmoNj+FsNgOcAZcJH59aUaKfEJfR51e9Nc4fQoK
RlYtcETuYyIkPzsfJwHyeGW8Frpvd8imj8XN8Ks5m/92Jgdw/7SiUu8USPbraDw4
eeR1axygMbIW+rCyFvz0
=rgzO
-----END PGP SIGNATURE-----

--5C/VXimrgG1HEvSQ--

--===============7975847291033132783==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7975847291033132783==--
