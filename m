From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: rt5682: recording has no sound
	after booting
Date: Mon, 18 Mar 2019 11:27:14 +0000
Message-ID: <20190318112714.GD6221@sirena.org.uk>
References: <20190318071742.20134-1-shumingf@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8573244965565732256=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 64AD6F80792
 for <alsa-devel@alsa-project.org>; Mon, 18 Mar 2019 12:27:18 +0100 (CET)
In-Reply-To: <20190318071742.20134-1-shumingf@realtek.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: shumingf@realtek.com
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, hou-hsun.lee@intel.com, hychao@google.com, lijen@google.com, lgirdwood@gmail.com, albertchen@realtek.com, derek.fang@realtek.com, bard.liao@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============8573244965565732256==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yudcn1FV7Hsu/q59"
Content-Disposition: inline


--yudcn1FV7Hsu/q59
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2019 at 03:17:42PM +0800, shumingf@realtek.com wrote:
> From: Shuming Fan <shumingf@realtek.com>
>=20
> If ASRC turns on, HW will use clk_dac as the reference clock
> whether recording or playback.
> Both of clk_dac and clk_adc should set proper clock while using ASRC.

This also doesn't apply, please check and resend.

--yudcn1FV7Hsu/q59
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyPgJEACgkQJNaLcl1U
h9B9ZggAhLwkhJxxLyV0QXS8w9N76cWVVuw0gztsMWnnMHcOrq2jKkR5vHDXn/WC
2vipToaM/sDF0zvMDeW124TIhPyq4YeP13qbqihUSDyD8FcC+ty4SXuxoCRj5bKp
+t6QDvr82s7TksSdw7ZWsc9zBp6vXUFIiZXKqw6YDI4UXubPZKWLcdIRzCU1JbKt
miES5wP4EkGx70i45r6OwcUcGXoqw9AW/frs4fkiYai7Hn1UYA9x/RZDtAwVNcxF
Uv+DUr+aZp1BDm3qzqIRBcj7xEEvzJupiltEXy4VWBE4xbtENQTxUJyAVwLadTOw
Yf6wlwYVa2PBSUHqvSbc4akMLjOIBw==
=3Ge1
-----END PGP SIGNATURE-----

--yudcn1FV7Hsu/q59--

--===============8573244965565732256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8573244965565732256==--
