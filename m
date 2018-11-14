From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: cs35l36: Add support for Cirrus
 CS35L36 Amplifier
Date: Wed, 14 Nov 2018 14:51:15 -0800
Message-ID: <20181114225115.GF2089@sirena.org.uk>
References: <1542134957-2395-1-git-send-email-james.schulman@cirrus.com>
 <20181113192556.GI2089@sirena.org.uk>
 <alpine.DEB.2.10.1811141254470.9698@james-tower>
 <SN2PR19MB08131DB009E1162D35CEED2DE4C30@SN2PR19MB0813.namprd19.prod.outlook.com>
 <20181114195514.GZ2089@sirena.org.uk>
 <alpine.DEB.2.10.1811141633110.8412@james-tower>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6297517519039409844=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A98E267A61
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2018 23:51:23 +0100 (CET)
In-Reply-To: <alpine.DEB.2.10.1811141633110.8412@james-tower>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Schulman, James" <James.Schulman@cirrus.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Handrigan,
 Paul" <Paul.Handrigan@cirrus.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "Keepax, Charles" <Charles.Keepax@cirrus.com>
List-Id: alsa-devel@alsa-project.org


--===============6297517519039409844==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CX2kZGZwrCIhBPP7"
Content-Disposition: inline


--CX2kZGZwrCIhBPP7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 14, 2018 at 10:39:01PM +0000, Schulman, James wrote:

> > What if something you didn't expect got unmasked by some bug?

> We make the assumption that this is not the case. This handler is modeled=
=20

On that basis we could remove all error handling...

> after our other upstreamed drivers (cs35l35.c). If there is a better=20
> example please let me know and we can try to be more consistent.A

drivers/base/regmap/regmap-irq.c

--CX2kZGZwrCIhBPP7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvspuEACgkQJNaLcl1U
h9BLVAf/YX7h7s+zkuMVeiW3yudhl/6QzG6E4SAbISg+ToN4WwJSTrjIUlSWcLDb
qNL7twetO7shmEL3C9it6GFdB1zrqoaHefOxSZ8aLyn6Ue1YL6ZjieX1Lxyc/U1E
0TuLLSVtD3yTx4w5eGbkfG6JI5hQLf9KVUMgdTEaqPlQF/8YGad1q5cAHVQKYxcO
r0eW6GjQfc2wQ+fN1rB+lQYfWXcx9BjmG4x8Eae1VNKFbxW5bXuaeobOVfjlLOJa
dZiq1Yl62HMrSfKYdKBWJrEwYvGuexiKWxnGmoS3/DeETlKHZvK43wi/I+8BbXqO
5qBX8OGAwB80A1jjgp91AXGwia5+Fw==
=6HbT
-----END PGP SIGNATURE-----

--CX2kZGZwrCIhBPP7--

--===============6297517519039409844==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6297517519039409844==--
