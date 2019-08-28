From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: rt1011: ADCDAT pin config
	modification
Date: Wed, 28 Aug 2019 11:49:38 +0100
Message-ID: <20190828104938.GF4298@sirena.co.uk>
References: <20190826090120.1937-1-shumingf@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6149617110266277293=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 99F05F8974C
 for <alsa-devel@alsa-project.org>; Wed, 28 Aug 2019 12:49:44 +0200 (CEST)
In-Reply-To: <20190826090120.1937-1-shumingf@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, cychiang@google.com, lgirdwood@gmail.com, derek.fang@realtek.com, sathya.prakash.m.r@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============6149617110266277293==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SnV5plBeK2Ge1I9g"
Content-Disposition: inline


--SnV5plBeK2Ge1I9g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2019 at 05:01:20PM +0800, shumingf@realtek.com wrote:
> From: Shuming Fan <shumingf@realtek.com>
>=20
> ADCDAT pin config sets to output mode in default.
> And the driver creates the kcontrol to control ADCDAT pin configuration.

Why would this change at runtime?  I'd expect this to be controlled by
the machine driver or a DT property.

--SnV5plBeK2Ge1I9g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1mXEEACgkQJNaLcl1U
h9BARQf7B+igTrQh/wu3MSJ+gfpTm0twpKyaZRXGaeqfKdEvy3t+lvYrdH2sHhJh
d4FN7QnapUkjMMPJTaeoRwtYjEWPaGfacIUoaYcZxF2k1blvq0q2IA+yXs+GTEh0
ANXhanQThTLsDTLN1RaagcQuoPDyLb1Sr++5BbEJrZyQq9wtjC3dQwbevmD/U546
SZB//BJWyljTEGYwaquEFX3IG/WD77aIJ2bw7lk3CoRBNadUb9PEj26sKlVejVUk
UhgFCivZJwcEsnrEGUYZFirP7yHVA/YG5OYnSCc6aFT3z2jgwmNvI8INfgwa2q2b
y9rNQu49eXwAiWCvCVhpuducmm6rlQ==
=M3WZ
-----END PGP SIGNATURE-----

--SnV5plBeK2Ge1I9g--

--===============6149617110266277293==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6149617110266277293==--
