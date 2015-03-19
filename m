From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] Intel: ASoC: Add condition check
 before set param to waves
Date: Thu, 19 Mar 2015 00:49:25 +0000
Message-ID: <20150319004925.GK2869@sirena.org.uk>
References: <1426725480-31645-1-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4277631939364063883=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BDF826051B
 for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2015 01:49:31 +0100 (CET)
In-Reply-To: <1426725480-31645-1-git-send-email-han.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: han.lu@intel.com
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============4277631939364063883==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pN9MePJoZbRKbUk1"
Content-Disposition: inline


--pN9MePJoZbRKbUk1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2015 at 08:38:00AM +0800, han.lu@intel.com wrote:
> From: "Lu, Han" <han.lu@intel.com>
>=20
> Check waves state before set parameter through ipc to prevent unexpected
> operation. Also remove redundant check.

Applied, thanks.

--pN9MePJoZbRKbUk1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVCh0UAAoJECTWi3JdVIfQB/EH/ROzNLCcHemDblPs0eFoR2Z0
K3PCoR3a7lfFdJr09D2vtAAMDnzkCelUroQUUeg/Ps9Eo9E2Ar/yy5ISFaIdPJTP
06zRr2O+/13S2R4zgekjLG7vMCoxrVfNZ+gm83/n7YIaCtf3pwE2sgAkzSUQ+aJg
D/b3Z2bjLWhz4kMDBRbW9NvjJiO300kJ5Cd1ld2gjTFpk8QE3r7y4RE9JneUTmW6
pGLiP8sFPcjvt4QrMnIASpecXEb7L68ruFifK1mFxvv9FYTgD4S+OIjwuGevlIjg
pCUj9oTICCSPl5TK8pL91w1gQVGD2jphW4RyWiuIMxo54lwHgyVgO7ufe6ZFtxY=
=+1wp
-----END PGP SIGNATURE-----

--pN9MePJoZbRKbUk1--

--===============4277631939364063883==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4277631939364063883==--
