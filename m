From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: core: fix .info for SND_SOC_BYTES_TLV
Date: Mon, 18 Aug 2014 09:00:14 -0500
Message-ID: <20140818140014.GW14537@sirena.org.uk>
References: <1408353783-8740-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7338577009230006374=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A2A04265565
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 16:01:12 +0200 (CEST)
In-Reply-To: <1408353783-8740-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7338577009230006374==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l5oECiFRo5dp+2y7"
Content-Disposition: inline


--l5oECiFRo5dp+2y7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2014 at 02:53:03PM +0530, Vinod Koul wrote:
> From: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
>=20
> Commit 7523a271 - "ASoC: core: add a helper for extended byte controls us=
ing
> TLV" introduced support for TLV byte controls but had a typo for the info
> function, so fix the same
>=20
> Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>

Applied, thanks.  Please remember to use the Fixes: tag when fixing
things.

--l5oECiFRo5dp+2y7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT8gbqAAoJELSic+t+oim9rGYP/0D56f6re6bcbzIaV7/6x03W
wXeVH31PNKCK4fmRem7P3IsoZAp1ldQOmCOF45I4CfLmUg6+2aEbknTm/WNsqZTT
YnEjhrheKtpF+hdjTqobiJP9tBjJKQFkRR3j5aoNDiwdGM4kQJSi69sLm5mZi8fh
Ewp7zhMv8X0zET1S5w9ZaN9Bc/xZUDssd0WJcCt5mwummIHvr6ppdxuB+vyTwswT
GbjhTGi4Q43peZzuBKLekjPZW5ygTLFAOu7CL5F2ZjIHUgRo5NecjjoXnGoqF1/6
hVn/nuE50fJ5sQutbsiVR0d5yxUq21bU2wyRD+zvsqjcRvU44ZvX5IEHSoNNfOH/
xqPeIyLyvv9aAIPvX7NM2y1ghIzuWuZ/UlurG3JuWzsvN6EoVMgG29QYtc5dfFgR
zYgDd0FuFk+DBuyGw2V8BxOpqeP5L74LEMn4QsJwXN6fEbcM3VH65HKeHwKm0T9p
Gyu69EcvuWXeWWLDxctFa5SNGfs8K1qmCt+0kj4xwBucgTvn1BJLnXZRh93Th5H0
qOQD+l7KFY13m6kkM9PgsfwWK0eDBEyWGNCrEPzMlSWws0znAmyP7dnsgmHhpbuh
O4KnTDYuyTQJnY+6T6+uUMsR2X+hw0rQIz14p33TfhBJiBxC91Z5bCepQWNH7E/D
HXzq/mxl77kFqpuHC3zL
=lmwR
-----END PGP SIGNATURE-----

--l5oECiFRo5dp+2y7--

--===============7338577009230006374==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7338577009230006374==--
