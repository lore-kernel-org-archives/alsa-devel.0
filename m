From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/2] ASoC: cs35l33: Initial commit of
 the cs35l33 CODEC driver.
Date: Fri, 13 May 2016 23:28:48 +0100
Message-ID: <20160513222848.GW22038@sirena.org.uk>
References: <1463172629-559-1-git-send-email-Paul.Handrigan@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4791287865418291658=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 89CBE265019
 for <alsa-devel@alsa-project.org>; Sat, 14 May 2016 00:28:57 +0200 (CEST)
In-Reply-To: <1463172629-559-1-git-send-email-Paul.Handrigan@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Paul.Handrigan@cirrus.com
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4791287865418291658==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6B5oiwbC31sfIr4n"
Content-Disposition: inline


--6B5oiwbC31sfIr4n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 13, 2016 at 03:50:28PM -0500, Paul.Handrigan@cirrus.com wrote:

> +static struct regmap *cs35l33_get_regmap(struct device *dev)
> +{
> +	struct cs35l33_private *cs35l33 = dev_get_drvdata(dev);
> +
> +	return cs35l33->regmap;
> +}

Doesn't the default work for you?

> +	for (i = 0; i < CS35L33_INT_ATTEMPTS; i++) {
> +		/* ack the irq by reading both status registers */

Why do we need this...?

> +		if (sticky_val1 & CS35L33_AMP_SHORT) {
> +			dev_err(codec->dev, "Amp short error\n");
> +			if (!(current_val & CS35L33_AMP_SHORT)) {

dev_crit()

> +		if (sticky_val1 & CS35L33_OTE) {
> +			dev_err(codec->dev, "Over temperature error\n");


Same here - these are extremely serious and probably indicate very
serious physical problems.

> +	} else if (IS_ERR(cs35l33->reset_gpio)) {
> +	dev_err(&i2c_client->dev, "%s ERROR: Can't get reset GPIO\n",
> +			__func__);
> +		return PTR_ERR(cs35l33->reset_gpio);

Indentation is messed up here.

--6B5oiwbC31sfIr4n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXNlUfAAoJECTWi3JdVIfQEc8H/AnjVwBdmiONhvdsj0rXFCyg
Q9AyKqt1digSvkx3GK8aVLBuj/Ob3OZBx0ov70wBmoWZnnMJRrqX/98kuFcD5GWS
uhRfgP2G4L678bbn3JJe11AirZnD/BtMxbxD2ZRRbyJILqBHGkugCvwZCwkVE2kP
x+S39aZvqwuBH8QFhLy8gUr5kPVL8vrXp+7gIsEVdtNw+/RT4Gpl/pfSPAFdNtmu
PvQQNUwFLp0TLJQOOPVrAtxZfsOxIQJqsKcQoUf0ggYduSFy0dflYdfpxhu04dDz
kp7WidtbYoG7NR1uD5FbFtUiynGdGQQzxP4fXySOahHEm/YCUyCeTJXIH6frVBI=
=3LHg
-----END PGP SIGNATURE-----

--6B5oiwbC31sfIr4n--

--===============4791287865418291658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4791287865418291658==--
