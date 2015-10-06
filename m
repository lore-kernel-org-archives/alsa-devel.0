From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: Codec: wm8962: declare ALC Coefficients as 4
 separate registers
Date: Tue, 6 Oct 2015 12:01:14 +0100
Message-ID: <20151006110114.GN12635@sirena.org.uk>
References: <1444115215-4388-1-git-send-email-jiada_wang@mentor.com>
 <1444115215-4388-3-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TWB/Y4ytXnYHhyjJ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1444115215-4388-3-git-send-email-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--TWB/Y4ytXnYHhyjJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 06, 2015 at 04:06:55PM +0900, Jiada Wang wrote:

> As ALC2 register is volatile, declare it as one of ALC Coefficients
> register together with other non-volatile registers will cause issue,
> in case wm8962 has enter suspend mode, and cache_only flag is set,
> any attempt to read from ALC2 will fail.

> Instead of declaring one ALC Coefficients register which contains
> ALC1 ~ ALC3 and Noise Gate, this patch declares 4 separate registers,
> so that regmap can handle these registers differently based on their
> classification.

I don't understand this commit log.  Why does regmap care how these
registers are presented to userspace, and how does splitting the
controls up address the problem with one of the registers being volatile?
Surely that register still has the same problem?

--TWB/Y4ytXnYHhyjJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWE6n6AAoJECTWi3JdVIfQLFYH/Av9lSWit6y9EK28f9Uk+wR9
4pL2txoUREQh58bMrRJgOd95yI7KW2/OVFb9t/ne3YQVea/5OZnsZt4eCNRfldP7
BppdYQPjVbJvSp+hMgoW1jAEXgTm65HL0+Y0CpiPvBgx0kvSgzOeFeKeiEu83X+X
+ExMcfCNLrAZb0QX6iRO5WsDEfXZkumRT4UXbpvFJH5mMpVQqzNBwRVeQudXigKh
mAp2OuVG28xiBvc1EV6RZ3lWcI9wlffid4SSwW61J6kTp0cDgiDHiovElDQp+dkz
1FO3CQsrRCCfnGkArVb6iMWY3USAA5AM88muhpRs2DGQFhuzw26AyGSauecXMr4=
=M9DY
-----END PGP SIGNATURE-----

--TWB/Y4ytXnYHhyjJ--
