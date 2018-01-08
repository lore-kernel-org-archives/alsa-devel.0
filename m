From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rockchip: i2s: fix playback after
	runtime resume
Date: Mon, 8 Jan 2018 15:26:41 +0000
Message-ID: <20180108152641.GF11698@sirena.org.uk>
References: <20180108122301.18255-1-john@metanate.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3562364147575516600=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CCDB2673AF
 for <alsa-devel@alsa-project.org>; Mon,  8 Jan 2018 16:26:45 +0100 (CET)
In-Reply-To: <20180108122301.18255-1-john@metanate.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Keeping <john@metanate.com>
Cc: Sugar Zhang <sugar.zhang@rock-chips.com>, linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3562364147575516600==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A9z/3b/E4MkkD+7G"
Content-Disposition: inline


--A9z/3b/E4MkkD+7G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 08, 2018 at 12:23:01PM +0000, John Keeping wrote:

> @@ -527,6 +531,7 @@ static bool rockchip_i2s_volatile_reg(struct device *dev, unsigned int reg)
>  static bool rockchip_i2s_precious_reg(struct device *dev, unsigned int reg)
>  {
>  	switch (reg) {
> +	case I2S_RXDR:
>  	default:
>  		return false;
>  	}

This doesn't look right?

--A9z/3b/E4MkkD+7G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpTjbAACgkQJNaLcl1U
h9DZNgf/UkNTJsa9Ncd9Ks1DbbntTX+dcWdGBdcPHuuV3EfBeokxtnt4+JBCrmcn
r1lHhRrgo4CtLN+oOss6JhWidPXppqPUR6YLzKEjciaTFwNNTVfsazCFm0Mdk8Iv
5mRGg2NEcsqieLLmk03So1xibiyz+mL35fwa4mgCL1bVd+IUIsMp/L7kJygEzeXO
cPOgrl10wmt83Zys2QNEdw7vFjWqVk5JFWpXolGGtT2lU3EL37kbFI3Zb7j/tDdI
NDpUf9KdSoDwi5hXfOqBgM0eHaZfIr8xJ++nkDSOsRFN6OFIlIDVd6sKA9WqOuAJ
RutBnqW++ktq70M6V6Q0IWmG4VG8/w==
=jsEB
-----END PGP SIGNATURE-----

--A9z/3b/E4MkkD+7G--

--===============3562364147575516600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3562364147575516600==--
