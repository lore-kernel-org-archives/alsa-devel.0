From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sgtl5000: only check VDDD-supply,
	not revision
Date: Mon, 6 Jun 2016 18:55:28 +0100
Message-ID: <20160606175528.GF7510@sirena.org.uk>
References: <20160602124724.7725-1-clemens.gruber@pqgruber.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8649796868084882428=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A21932658E5
 for <alsa-devel@alsa-project.org>; Mon,  6 Jun 2016 19:55:36 +0200 (CEST)
In-Reply-To: <20160602124724.7725-1-clemens.gruber@pqgruber.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: Eric Nelson <eric@nelint.com>, alsa-devel@alsa-project.org, Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============8649796868084882428==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ls2Gy6y7jbHLe9Od"
Content-Disposition: inline


--Ls2Gy6y7jbHLe9Od
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 02, 2016 at 02:47:24PM +0200, Clemens Gruber wrote:
> Instead of checking the SGTL5000 chip revision, we should only check if
> the VDDD regulator exists and only call sgtl5000_replace_vddd_with_ldo
> if the regulator is missing.

It looks like there's multiple patches needed here from the following
discussion, please resubmit as a series with everything that's needed
for review and testing.

--Ls2Gy6y7jbHLe9Od
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXVbkPAAoJECTWi3JdVIfQGqAH/3imbD5RbC9pgIW/3nkUDhMo
AfsUmiHhBJ1uS3QMdRHuz5bI//GNRUSX7d1GGsX1MJwMaWWBec0l0YhR79vy9sRJ
oMr+jEfiC4lBRBjaFU/8QBhEV0j3u5xUoDxtoq5FdvCW0MwSO004dX2ZRQXUI6Qo
+IWMyGvNkxhjE8kid4RCXfcKny+AgsdPyFLYZkSzah2xzfvmplW6yC4GeR/6LXKC
ZDV+DB1DYB6M+oKZVdIJHtnV1rLCYdmtYvIqeTQarJcyRDvlYJDQf/e7sgpsxbNV
sjBsIzvNhQQJCq1xpGL39IGyPKtjXukNd6bG4GXCzWBezyUGs5b8k1pn263OrcQ=
=RlBm
-----END PGP SIGNATURE-----

--Ls2Gy6y7jbHLe9Od--

--===============8649796868084882428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8649796868084882428==--
