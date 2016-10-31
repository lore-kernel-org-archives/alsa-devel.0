From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add rt5665 codec driver
Date: Mon, 31 Oct 2016 12:19:33 -0600
Message-ID: <20161031181933.vya7yy5fniaimxvw@sirena.org.uk>
References: <1477903079-11883-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1841799390692723692=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 23E93266D48
 for <alsa-devel@alsa-project.org>; Mon, 31 Oct 2016 19:19:55 +0100 (CET)
In-Reply-To: <1477903079-11883-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============1841799390692723692==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qubvd33c7flhekna"
Content-Disposition: inline


--qubvd33c7flhekna
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 31, 2016 at 04:37:59PM +0800, Bard Liao wrote:

> +	{"TDM2 Data Mux", "1324", "IF1_2 ADC TDM"},
> +	{"TDM2 Data Mux", "1342", "IF1_2 ADC TDM"},

These aren't really done properly - they're squashing all the data paths
down into one.  Ideally there'd be a separate AIF widget for each
channel.  It's not super urgent right now since it won't make a
practical difference.

> +	regulator_1v8 = devm_regulator_get_optional(&i2c->dev,
> +						rt5665->pdata.regulator_1v8);
> +	if (IS_ERR(regulator_1v8))
> +		dev_err(&i2c->dev, "Fail to get regulator_1v8\n");
> +	else if (regulator_enable(regulator_1v8))
> +		dev_err(&i2c->dev, "Fail to enable regulator_1v8\n");

This isn't good, while we log if we fail to enable the regulator we
don't otherwise handle the error.  If the we failed to power on a power
supply the chances are that the device isn't going to work so I'd expect
us to fail the proble.

> +	regulator_3v3 = devm_regulator_get_optional(&i2c->dev,
> +						rt5665->pdata.regulator_3v3);

> +	regulator_5v = devm_regulator_get_optional(&i2c->dev,
> +						rt5665->pdata.regulator_5v);

I also just don't believe that *all* of the regulators the device has
are optional.

--qubvd33c7flhekna
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYF4s0AAoJECTWi3JdVIfQjpMH/RWWRSbLmwZf42kz2q9gu3kH
k+HL8GeqeD8+Rv296DqlMbatezul1I91S/7KGBRnK/ghLHyljsegbIjqyMZKZS85
VFPr9hiy/tL0FzVQh4rcdHhX1B5RoV1oT8q0Uly0b6ipDv83ZcAnpeqXERThnZmO
9p5rQIRPuOn029qSUyNrBrW5eeANfL7cBVVMQe80Dvyls1n3tRofA9DjzHFqbvTs
PgFqp5Rd5+DDx5QKbBOyiQ8IrDHojMBC1e1osJowgihlsryVgTKg4P8EzlosKRI4
iPHrK5nhtyPJegXSIEMiL6eNJPVmvaAy+E7yQl11N1VT33diM/KR11qORnN1+ls=
=pPRB
-----END PGP SIGNATURE-----

--qubvd33c7flhekna--

--===============1841799390692723692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1841799390692723692==--
