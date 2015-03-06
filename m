From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/6] ASoC: sgtl5000: fix regulator
	support
Date: Fri, 6 Mar 2015 20:04:15 +0000
Message-ID: <20150306200415.GW21293@sirena.org.uk>
References: <1424991273-10081-1-git-send-email-eric.nelson@boundarydevices.com>
 <1424991273-10081-2-git-send-email-eric.nelson@boundarydevices.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8037921975042035985=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F1F91265E17
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2015 21:04:29 +0100 (CET)
In-Reply-To: <1424991273-10081-2-git-send-email-eric.nelson@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eric Nelson <eric.nelson@boundarydevices.com>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, lars@metafoo.de, tiwai@suse.de, lgirdwood@gmail.com, rmk+kernel@arm.linux.org.uk, jean-michel.hautbois@vodalys.com, troy.kisky@boundarydevices.com
List-Id: alsa-devel@alsa-project.org


--===============8037921975042035985==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XMHnf4PRplAxZBfX"
Content-Disposition: inline


--XMHnf4PRplAxZBfX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2015 at 03:54:28PM -0700, Eric Nelson wrote:

> Since the internal LDO can only be enabled after I2C is available,
> there's no benefit in treating it as a regulator, so this patch
> removes the regulator structure surrounding it.

The expected benefit would be that it is possible to then have the code
that uses the regulator be constant:

>  	case SND_SOC_BIAS_STANDBY:
>  		if (codec->dapm.bias_level =3D=3D SND_SOC_BIAS_OFF) {
>  			ret =3D regulator_bulk_enable(
> -						ARRAY_SIZE(sgtl5000->supplies),
> +						sgtl5000->num_supplies,
>  						sgtl5000->supplies);

so we avoid stuff like this.

> @@ -1115,7 +938,9 @@ static int sgtl5000_set_power_regs(struct snd_soc_co=
dec *codec)
> =20
>  	vdda  =3D regulator_get_voltage(sgtl5000->supplies[VDDA].consumer);
>  	vddio =3D regulator_get_voltage(sgtl5000->supplies[VDDIO].consumer);
> -	vddd  =3D regulator_get_voltage(sgtl5000->supplies[VDDD].consumer);
> +	vddd  =3D (sgtl5000->num_supplies > VDDD)
> +		? regulator_get_voltage(sgtl5000->supplies[VDDD].consumer)
> +		: LDO_VOLTAGE;

Please write a normal if statement, this is not legible (and the test is
more than a little obscure).

> -	/* External VDDD only works before revision 0x11 */
> -	if (sgtl5000->revision < 0x11) {
> -		vddd =3D regulator_get_optional(codec->dev, "VDDD");

It'd be good to keep at least a warning about this (not that there's one
now but it's a good idea).

> -	ret =3D regulator_bulk_get(codec->dev, ARRAY_SIZE(sgtl5000->supplies),
> +	sgtl5000->num_supplies =3D ARRAY_SIZE(sgtl5000->supplies)
> +				 - 1 + external_vddd;

This is a bit obscure, why not just do this sooner (with a comment for
the - 1) and increment num_supplies when we add the external regulator.
A comment on the supply list saying that VDDD must be last would be good
too.

> +	ret =3D regulator_bulk_enable(sgtl5000->num_supplies,
> +				    sgtl5000->supplies);
> +	if (!ret)
> +		usleep_range(10, 20);

This is a separate change...

> +	else
> +		regulator_bulk_free(sgtl5000->num_supplies,
> +				    sgtl5000->supplies);

Convert to using devm_ since you're doing all this stuff.


>  	ret =3D clk_prepare_enable(sgtl5000->mclk);
> -	if (ret)
> -		return ret;
> +	if (ret) {
> +		dev_err(&client->dev, "Error  enabling clock %d\n", ret);
> +		goto disable_regs;
> +	}

This is a separate fix as far as I can tell?

> +	/* Follow section 2.2.1.1 of AN3663 */
> +	if (sgtl5000->num_supplies <=3D VDDD) {
> +		/* internal VDDD at 1.2V */

These checks are just far too obscure, please set a flag or something.

--XMHnf4PRplAxZBfX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+gg/AAoJECTWi3JdVIfQFAAH/Rc/jW3RdwOuW89d9SixNGTp
3prmcmZbMsuoAIapdD0PBYCidSxKp0v1DWEktvOMAIX+PU4a+/aovwlw8hZITt0E
7mLYKjlCC51a3qr8RGZgFezpbliVI0yecv3Y7k5R/4OasOx4SPPTl8fRSk02Wp3T
tu28lJ2LeyDmgY7MppOu6qtOfo03wcbfn76gE0vS22S3G5eHK8d3oNPv2atEbcml
C4pl2ACLcfi/8wpIDeVIc7kjHIbKhYeJ+fYaIjRBHFjiN2F+siLEhObk1vT3I+Mn
QDDpUa9GulQndsXQzqKqf2vj/JD+X3jbO8TzbDm72cpTi7SrHj0EtOOUcOVZPOc=
=DKer
-----END PGP SIGNATURE-----

--XMHnf4PRplAxZBfX--

--===============8037921975042035985==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8037921975042035985==--
