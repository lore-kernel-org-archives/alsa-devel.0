From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/6] ASoC: add Renesas R-Car Generation
 feature
Date: Wed, 3 Jul 2013 12:10:34 +0100
Message-ID: <20130703111034.GI27646@sirena.org.uk>
References: <87a9m6ixgp.wl%kuninori.morimoto.gx@renesas.com>
 <8761wuixf1.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6831392712458851400=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B468A26554A
 for <alsa-devel@alsa-project.org>; Wed,  3 Jul 2013 13:10:37 +0200 (CEST)
In-Reply-To: <8761wuixf1.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6831392712458851400==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MEto6KzE24Smlj/z"
Content-Disposition: inline


--MEto6KzE24Smlj/z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 30, 2013 at 11:53:10PM -0700, Kuninori Morimoto wrote:

> +u32 rsnd_read(struct rsnd_priv *priv,
> +	      struct rsnd_mod *mod, enum rsnd_reg reg)
> +{
> +	void __iomem *base = rsnd_gen_reg_get(priv, mod, reg);
> +
> +	BUG_ON(!base);
> +
> +	return ioread32(base);
> +}

regmap?  I don't know if the new regmap field API helps with the fact
that some of the registers have been moved about.

> +static void rsnd_gen2_remove(struct platform_device *pdev,
> +			     struct rsnd_priv *priv)
> +{
> +}

There's quite a few empty functions here - it'd be better to be able to
avoid them.

--MEto6KzE24Smlj/z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1AanAAoJELSic+t+oim9Yd4P/3WBrNhQasEF2WtYimwLBAye
pK+CJGrJOkclbkOWuXR7N/hMBGCisNytYB3EhHZ2w+pzEFvXMHgPz3pPEGL/wO19
oOYUchtX9NI3DQjWI/tFasx7PDZJA84q03Avk+z+w+T4L82wqqE2YPPpfyigtdya
YUiTDAwA6axIq7YS7zVdkHLlifw9kDy98TscubvAjH9h4PYTAGi9HFz59QQZCXDE
g97dCEWVBxFiQZQQGLQXe0jKgRVmkDxQpTZwTahVu+CABSAvLjVQvWfcmsPdi4Yy
+r075cII2XrDVoAuvUuV3nVVnepYleTeQo2PPYSWEKoZK7ld6ixeGOJFCIDzCIti
L2YJTfRyduE4r3qfv6sqOiIfrbrb17dZ+J2XUGpWcLAbHaeETSBYfzzAuyPf9DGF
sjy212FV+F56WMFPq/3NOm+BYZi/1ED++/0GzPD/DviCl2ilkD5pFk13KNQMArkF
6YQ+u7LS4ET3FKGEK+GLcdI/6PVrbArMTRLrUMT5bhZ1h1oL5PxEJR/5wRR5ZTKs
fOzx3kBGcI9lgzu0KfGORbWciVQuQ3TSAfkQJVEoEa6w0GKRdXds2CdnfioIFZsy
Oc3hdg+zNrVtCdO3MSm8lHuMYD98+b7IKqFUHfewOTLipVCCZevVHPcbmJov7Hka
eMweev6s4iuamCOEMR/4
=jEtY
-----END PGP SIGNATURE-----

--MEto6KzE24Smlj/z--

--===============6831392712458851400==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6831392712458851400==--
