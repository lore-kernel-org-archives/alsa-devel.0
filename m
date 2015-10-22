From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: Codec: wm8962: declare ALC Coefficients as 4
 separate registers
Date: Thu, 22 Oct 2015 13:38:30 +0100
Message-ID: <20151022123830.GF8232@sirena.org.uk>
References: <1445309232-24094-1-git-send-email-jiada_wang@mentor.com>
 <1445309232-24094-3-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="65ImJOski3p8EhYV"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445309232-24094-3-git-send-email-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--65ImJOski3p8EhYV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2015 at 11:47:12AM +0900, Jiada Wang wrote:
> As ALC2 register is volatile, declare it as one of ALC Coefficients
> register together with other non-volatile registers will cause issue,
> in case wm8962 has enter suspend mode, and cache_only flag is set,
> any attempt to read from ALC2 will fail.
>=20
> Instead of declaring one ALC Coefficients register which contains
> ALC1 ~ ALC3 and Noise Gate, this patch declares 4 separate registers,
> so that regmap can handle these registers differently based on their
> classification.

In addition to the issue with the ABI change that Charles raised this
also doesn't entirely fix the issue in that we still have a control that
is going to give an error in suspend mode.  Charles' suggestion seems
like it's more likely to be helpful to users.

--65ImJOski3p8EhYV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWKNjFAAoJECTWi3JdVIfQ5AsIAIKbX4kH9GcoKhCepo6Cje19
NHZZSKW1IN6mCiwfDVBLBi8+FgMex07kzTRrrpAVZaIP//fWDJt6ja3BhJ93Scfh
VzPxG//CFSLN8eqNDXjWtxd3dcUSP89yTVoa0T2aLXCjv70nFgIHBB5FWNiJarMv
13OEtZT0bNgO7hdV1sRyNI3Wh8we8dTYjshz9tagbpb4CQnkH/tdCQCMbQd5Bv6E
CXEOc0WTs4zAbHJnJaa6E4RbsD+HYBzX/cwQgX0z08bnV8keBi/8z0vF7naFQJSu
mKpC0tSruBsNI47Smkulc0aI0WdO0W+JiKQG/mXKFzd1cCJbn7C8Lnt/7u9CgrI=
=P21t
-----END PGP SIGNATURE-----

--65ImJOski3p8EhYV--
