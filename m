From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFT] ASoC: cs4271: Split SPI and I2C code
 into different modules
Date: Mon, 6 Oct 2014 17:03:55 +0100
Message-ID: <20141006160355.GQ4609@sirena.org.uk>
References: <1412608187.4950.5.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3746084874635359933=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B4B39260579
 for <alsa-devel@alsa-project.org>; Mon,  6 Oct 2014 18:04:26 +0200 (CEST)
In-Reply-To: <1412608187.4950.5.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Brian Austin <brian.austin@cirrus.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Alexander Sverdlin <subaparts@yandex.ru>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org


--===============3746084874635359933==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6tPipYVl+OcoAvSh"
Content-Disposition: inline


--6tPipYVl+OcoAvSh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 06, 2014 at 11:09:47PM +0800, Axel Lin wrote:
> Currently the cs4271 driver depends on SND_SOC_I2C_AND_SPI.
> So the driver cannot be built as built-in if CONFIG_I2C=m.
> Split SPI and I2C code into different modules to avoid this issue.

Applied, thanks.

>  #ifdef CONFIG_OF
> -static const struct of_device_id cs4271_dt_ids[] = {
> +const struct of_device_id cs4271_dt_ids[] = {
>  	{ .compatible = "cirrus,cs4271", },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, cs4271_dt_ids);
> +EXPORT_SYMBOL_GPL(cs4271_dt_ids);
>  #endif

I do now find myself wondering if this actually does the right thing (it
could if the tools are smart enough) but it's not like this is the first
driver to do this so not a problem here.

--6tPipYVl+OcoAvSh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUMr1qAAoJECTWi3JdVIfQPqIH/0I2Ur0YBvMBX2R3BmJakSvZ
g4Mg14DPZ/7YXGjQ7eXHVKsaa4KRxZKlLpu/wWT1PWFDYvjWvtYTN7/ZdfCwBreY
Ven8mU+s2wHLTpB8aXSxkCU0FEGGDQBfmnwti8ny3NunB0s73n8cQAz9Z2huwPy0
2ZR9cbwSCuRlE0PZY79EPJ5GEugzSLbGqtLiBTCwNehnQvAHw5DC9LIkERvSFvKW
or2VKI3OFysDjLBvX1yVYcHoqrh3QElOb1PY/+s7PoImr5eTVsHU681h5ULlEZ8c
Ee1C8UDzzG3wH4aKt5T6YDjbBN4GqAaR/kQUB97UyTkSw/En5WZmjjnxpnbK0YA=
=+NMH
-----END PGP SIGNATURE-----

--6tPipYVl+OcoAvSh--

--===============3746084874635359933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3746084874635359933==--
