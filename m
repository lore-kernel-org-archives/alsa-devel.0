From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: cs35l36: Add support for Cirrus
 CS35L36 Amplifier
Date: Sat, 2 Feb 2019 15:52:20 +0000
Message-ID: <20190202155220.GL20797@sirena.org.uk>
References: <1549049594-26113-1-git-send-email-james.schulman@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0456915689940014000=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 27D7B26746C
 for <alsa-devel@alsa-project.org>; Sat,  2 Feb 2019 16:52:23 +0100 (CET)
In-Reply-To: <1549049594-26113-1-git-send-email-james.schulman@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: James Schulman <james.schulman@cirrus.com>
Cc: mark.rutland@arm.com, brian.austin@cirrus.com, alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com, lgirdwood@gmail.com, paul.handrigan@cirrus.com, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org


--===============0456915689940014000==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KIbT1ud6duwZIwNL"
Content-Disposition: inline


--KIbT1ud6duwZIwNL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 01, 2019 at 01:33:14PM -0600, James Schulman wrote:

> +++ b/sound/soc/codecs/cs35l36.c
> @@ -0,0 +1,1959 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * cs35l36.c -- CS35L36 ALSA SoC audio driver

SPDX headers in C files need to be C++ comments; please make the entire
thing a C++ comment so it looks more intentional.  Headers should still
use /* */

> +static int cs35l36_ldm_sel_put(struct snd_kcontrol *kcontrol,
> +			       struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component =
> +			snd_soc_kcontrol_component(kcontrol);
> +	struct cs35l36_private *cs35l36 =
> +			snd_soc_component_get_drvdata(component);
> +	int val = (ucontrol->value.integer.value[0]) ? CS35L36_NG_AMP_EN_MASK :
> +						       0;
> +
> +	cs35l36->pdata.ldm_mode_sel = val;
> +
> +	regmap_update_bits(cs35l36->regmap, CS35L36_NG_CFG,
> +			   CS35L36_NG_AMP_EN_MASK, val);

If this can be usefully changed at runtime why is it part of the
platform data?  I'd expect control by one of these methods but not both.

> +	SOC_SINGLE("Amp Gain Zero-Cross", CS35L36_AMP_GAIN_CTRL,
> +		CS35L36_AMP_ZC_SHIFT, 1, 0),

This is an on/off switch so should have Switch at the end fo the name so
that userspace tools know how to handle it (the same thing seems to
apply to at least some of the other controls).

--KIbT1ud6duwZIwNL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxVvLMACgkQJNaLcl1U
h9ARdwf9EsPlFM1FPx8GteFRHJyWPBtYhjERLoptsNwjF2MM5qPIew3382NOVg0W
YQzUZmWLGXdLxlfvqMXEAZOfq1K0V8Be/IRd/R5cKOCc1s32K7tCKfDw6YNu5tO7
iliLxtKv+4g1xtoftOJv48Cp8ynFv72BbWW47UJ0fmYBuf4ZuKXpyZaeEZQw3Iud
yJ4AVFlOrj4nE5UxsJzDmuDrcaHrEsaOWP6/58FkFxjqsYegszkL/tT2J9J4VypS
9RRgGqehNPqBYsQIhREkqpcSuPGYnhQCyzrwxuevRPwpyyvJcjh+fVY+Ve/COZd4
fe7cgp/v5nLQUEB2MR4/RxiTkEgnvw==
=c3b7
-----END PGP SIGNATURE-----

--KIbT1ud6duwZIwNL--

--===============0456915689940014000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0456915689940014000==--
