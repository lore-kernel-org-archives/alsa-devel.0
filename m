From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: AMD: add missing include
Date: Mon, 11 Jan 2016 13:03:28 +0000
Message-ID: <20160111130328.GB6588@sirena.org.uk>
References: <4595844.NIUnxKiA0y@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wDZUCI/4a1lIuQdD"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4595844.NIUnxKiA0y@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>, Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>, Murali Krishna Vemuri <murali-krishna.vemuri@amd.com>
List-Id: alsa-devel@alsa-project.org


--wDZUCI/4a1lIuQdD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 11, 2016 at 01:13:01PM +0100, Arnd Bergmann wrote:
> The newly added AMD acp driver is missing an include for linux/io.h
> and fails to build on ARM:

Guenter sent a fix for this first.

--wDZUCI/4a1lIuQdD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWk6gfAAoJECTWi3JdVIfQL/AH/RHKKTdU9aBHhZSVY9PWUcHq
wceXUb/40QK8n8q74dJEPiYdLPmym3n5vLvhNDPtT2+xSS467JCQ3S3wOr+4rZ5Y
H+f2CWlkciRaMSyAc3KNDd4oL5fmqHCWnpQsoliRel8E/070lvByu/zBIT8lLtIa
4nlXfXj9kxyDsmVWdZrDBX2JOmzm/YanO6uF76IpTSjJAIuwF6dMfSAUrRRFeYnv
v50bsFbv8ci1dY4dnfGNmBWXSYnhV7DN3GmjMeCwdGbyI4CejqIZ9zugJkHgGKXJ
JOO8uvSthtN+H4j0a3ZzLlWXbAZkEuTEFXa/HUHfIg2SSXA6SvAxhrni2JXVwnU=
=ceUC
-----END PGP SIGNATURE-----

--wDZUCI/4a1lIuQdD--
