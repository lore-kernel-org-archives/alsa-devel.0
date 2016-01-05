From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] Revert "ASoC: Intel: Skylake: fix
	memory leak"
Date: Tue, 5 Jan 2016 12:11:41 +0000
Message-ID: <20160105121141.GZ16023@sirena.org.uk>
References: <1451994364-29338-1-git-send-email-vinod.koul@intel.com>
 <20160105114622.GY16023@sirena.org.uk>
 <20160105115417.GL2940@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2495286709995031965=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E90692606D3
 for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2016 13:11:49 +0100 (CET)
In-Reply-To: <20160105115417.GL2940@localhost>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2495286709995031965==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AVsU0XxfC6ed1aQ6"
Content-Disposition: inline


--AVsU0XxfC6ed1aQ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 05, 2016 at 05:24:17PM +0530, Vinod Koul wrote:
> On Tue, Jan 05, 2016 at 11:46:22AM +0000, Mark Brown wrote:

> > Please use subject lines matching the style for the subsystem.

> Is this an automated mail :) but its signed!

No, I type those out by hand.

> Btw am not sure why this is not proper, isn't revert followed by old patch
> title the right style for revert patches..? what did i miss...

Patches are patches are patches, reverts are patches like any other and
should still have subject lines matching the style for the subsystem.

--AVsU0XxfC6ed1aQ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWi7L9AAoJECTWi3JdVIfQX1gH/3i152eme5j35VNfMF1Wgw/f
paXYvTrJJY7vimtLZIzir2RQTgDfu4WHA9Ij27DVal06ZRbaVOuqZtruF6MpvqSH
1jMfDbVGrtcecLPslgR2ietxJSu9wOUWEdFH393IRZc/UJgYNVEET+lzoggc+PZ3
01lcgmXUhq7Ypp3UrAdx9ibcDqSiQ7h632qIUa10MpoesGlpY0R2Ta7ZMezAoEsQ
e+Ag10BMdEP9h0iIuRcfH3jqe17Hb+LptLXbziy+KER+FkmVftS0s+cE3oDI/CBH
DmNGHoG7A/XgbPnscDHIu0r1F8bhxH22ybajCV08B4SNnU21y8LDQRTlHD+wDDs=
=KIko
-----END PGP SIGNATURE-----

--AVsU0XxfC6ed1aQ6--

--===============2495286709995031965==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2495286709995031965==--
