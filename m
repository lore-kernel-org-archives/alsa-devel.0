From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V4 1/5] regmap: Add a helper function for regcache sync
 test
Date: Wed, 6 May 2015 13:01:50 +0100
Message-ID: <20150506120150.GN22845@sirena.org.uk>
References: <1430864057-3848-1-git-send-email-cernekee@chromium.org>
 <1430864057-3848-2-git-send-email-cernekee@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="D4ISUdLHQrdNYE8w"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430864057-3848-2-git-send-email-cernekee@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Cernekee <cernekee@chromium.org>
Cc: lgirdwood@gmail.com, lars@metafoo.de, dgreid@chromium.org, abrestic@chromium.org, olofj@chromium.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--D4ISUdLHQrdNYE8w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 05, 2015 at 03:14:13PM -0700, Kevin Cernekee wrote:
> We're going to add another "does this register need syncing?" check, so
> rather than repeating it in three places, we'll separate all of the
> relevant logic into a helper function.

Applied, thanks.

--D4ISUdLHQrdNYE8w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVSgKuAAoJECTWi3JdVIfQ7EkH+weW2otekmhT/tsWr3Bw0wYj
NboXsNp+gN6CqA3rWjAHIeW6SSChOW2WChDcBTP3WqeuvVk9VRAJZOkCvEyp5uEM
/pyoE0Pc02zMdlxTSWk+g5Y2rGZfYQySv3XuH2K6rkQKO/kNicwCff2PBkxN4M9O
q6kQmD6M0qdNa8xEdQCd5XnamWTZbUb6KYNPs6f9aGVWB90/PtAsopEsAL+Ck5WF
woFwQlZVBhBTXfN740i8uu3Q/2jcDrAu4hjI97vhT9xpdx/+lsvYh0m90p4ur0bR
SrdbaUyUvszggRYGIelSf3X47ruOTFBJ7BBdWGAiVwYXeN5cbvlw6RaH3vxEiJQ=
=jcIj
-----END PGP SIGNATURE-----

--D4ISUdLHQrdNYE8w--
