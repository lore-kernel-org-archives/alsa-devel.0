From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/5] ASoC: max9867: Fix power management
Date: Mon, 26 Nov 2018 12:57:19 +0000
Message-ID: <20181126125719.GB9715@sirena.org.uk>
References: <20181123142507.GA7347@lenoch>
 <20181123142729.GC7347@lenoch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9026881543033601892=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A4AF526751A
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2018 13:57:20 +0100 (CET)
In-Reply-To: <20181123142729.GC7347@lenoch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============9026881543033601892==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 23, 2018 at 03:27:29PM +0100, Ladislav Michl wrote:

> Move device enable to probe function. Doing that from prepare
> callback allows only DAC to be enabled.

This seems like it'll be a power consumption regression - instead of
managing the power at runtime we'll just leave the power on all the
time.  The normal place to do this would be either directly through DAPM
or via set_bias_level() - the latter seems a better fit here.

> While here move suspend and resume functions to more common place.

It would be better to split this out from the rest of the change as it's
a fairly large bit of code motion relative to the rest of the patch.

> @@ -491,19 +458,40 @@ static int max9867_i2c_probe(struct i2c_client *i2c,
>  	}
>  	ret = regmap_read(max9867->regmap, MAX9867_REVISION, &reg);
>  	if (ret < 0) {
> -		dev_err(&i2c->dev, "Failed to read: %d\n", ret);
> +		dev_err(&i2c->dev, "Failed to read revision: %d\n", ret);
>  		return ret;
>  	}

This is a cosmetic change unrelated to the rest of the patch, it should
be sent separately.

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv77a4ACgkQJNaLcl1U
h9Ce4Af/ZqtLdpqN2QPeyn7fP645Z/puvwapf4KyLQx5KIoSxMHA3TJ8SUqFTR13
57hJz5U46a7yp4NJkmb4vyLyKp9PnoR16T3vgwc9GPNc3JyiNMYGPnElZQB03+zB
c6gnnuPq0ot6xFCDk9PTKVHQRLI6kqnr+AskPHIFIG900tAnuzQBHEfx9Mza9v2f
sT6fPbr4WQvzA3MYbRiqItHpzymyVsC4rSK4u4yZV1OFveP6ROe+ipREZ99B8Z6T
AznWRJBcxI+42OKxJstcFaXikgmBnDIDtl/02HsCUaGQ+wYlWAuOKS+B73Ob+fWl
8FUrwI/rKQEZg02UfgtqXTWA0dZ1Mw==
=5I7y
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--

--===============9026881543033601892==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9026881543033601892==--
