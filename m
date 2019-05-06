From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] ASoC updates for v5.2
Date: Mon, 6 May 2019 23:40:00 +0900
Message-ID: <20190506144000.GV14916@sirena.org.uk>
References: <20190506141144.GR14916@sirena.org.uk>
 <s5hr29b4qas.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0689740444249494063=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3487EF80C07
 for <alsa-devel@alsa-project.org>; Mon,  6 May 2019 16:40:07 +0200 (CEST)
In-Reply-To: <s5hr29b4qas.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0689740444249494063==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ndc0uqT8Jh5ZONBY"
Content-Disposition: inline


--Ndc0uqT8Jh5ZONBY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2019 at 04:21:15PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> sound/soc/rockchip/rockchip_pdm.c: In function =E2=80=98rockchip_pdm_hw_p=
arams=E2=80=99:
> sound/soc/rockchip/rockchip_pdm.c:179:3: warning: =E2=80=98clk_out=E2=80=
=99 may be used uninitialized in this function [-Wmaybe-uninitialized]
>    rational_best_approximation(clk_out, clk_src,
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>           GENMASK(16 - 1, 0),
>           ~~~~~~~~~~~~~~~~~~~
>           GENMASK(16 - 1, 0),
>           ~~~~~~~~~~~~~~~~~~~
>           &m, &n);
>           ~~~~~~~

> Is a fix on your tree already?

No, I don't have anything I didn't sent to you.

--Ndc0uqT8Jh5ZONBY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzQRz8ACgkQJNaLcl1U
h9BXPQf+OH1RiCOpVMQUu7HLJbWirezlfu8x7SFuolrPS+ikvEiIzRF8wsB4Laa3
sQP8B+vxtvRreWBgdhL0BbvDLV4Ehe9tz/AMGMLGDXj82WtFlAu0MMMjjtjK6BiN
iqtAGQjaNC7Zz3nTnFbuolnEd1Phcsu7JRn6mqVsqALq/6PrRlos95hjZ4pU3gYE
YFTa7+wL8JmobeUkyXiawsfFF76Ni2K/RhggpaqY+kv3fxZj6e6/Wl5tnj/zsovL
ij2Oo79nXrMkik5erTudUbbEMrhJAjZJuZ03ywc46/oqs2e0qXRbhWt4JXAPaoPT
h0DNd2ZfwbO+5G6+5Iqdikmp9fZikQ==
=X7+L
-----END PGP SIGNATURE-----

--Ndc0uqT8Jh5ZONBY--

--===============0689740444249494063==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0689740444249494063==--
