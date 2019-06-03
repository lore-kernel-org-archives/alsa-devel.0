From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-core: fix ifnullfree.cocci
	warnings
Date: Mon, 3 Jun 2019 18:58:43 +0100
Message-ID: <20190603175843.GA30701@sirena.org.uk>
References: <alpine.DEB.2.21.1905301904530.2500@hadrien>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3399619187531891029=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0D645F80CC4
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2019 19:58:48 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.21.1905301904530.2500@hadrien>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org


--===============3399619187531891029==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2019 at 07:06:11PM -0400, Julia Lawall wrote:
> From: kbuild test robot <lkp@intel.com>
>=20
> sound/soc/soc-core.c:391:2-7: WARNING: NULL check before some freeing fun=
ctions is not needed.
>=20
>  NULL check before some freeing functions is not needed.

This doesn't apply against current code, please check and resend.

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz1X9IACgkQJNaLcl1U
h9CjqAf/dHMmaH160jKSA3JntU1LqgMdZeChArVfnwMLbNzKgFHsL3QKbmUKc4AG
Tr2UTEkqrx9bWisFr6QHitR8Cn4J65tJd11GlgbtKhbIp4SzA0R91QBgwIq11Ydf
be3a/fPLacVITJLzpB6HXX84NbutITX7NXO3UBrHdvGungUBdp8Y+v7fEtQslP4u
jJjMISUqPyM7zZzKR53beoKqjHQpfyKXaEyM/zJwvj/1kQzOLfw2CXQ7qEfIs0B0
im0OuQfsVNFiOwzP5Ns10p96TbTJ+pTFuuT0jbiMwmKjNDgETC9chUUljIsZZwM+
mCFTYM80ltgY0iT3MjGFN/GPtxoUqA==
=kyDr
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--

--===============3399619187531891029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3399619187531891029==--
