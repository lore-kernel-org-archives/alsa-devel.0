From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: arizona: Exit startup early if no
	runtime
Date: Thu, 24 Dec 2015 19:41:05 +0000
Message-ID: <20151224194105.GK579@sirena.org.uk>
References: <1450874881-31458-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7128175467672760060=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 874D4260686
 for <alsa-devel@alsa-project.org>; Thu, 24 Dec 2015 20:41:18 +0100 (CET)
In-Reply-To: <1450874881-31458-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: vinod.koul@intel.com, jeeja.kp@intel.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7128175467672760060==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fUvfsPTz/SzOZDdw"
Content-Disposition: inline


--fUvfsPTz/SzOZDdw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 23, 2015 at 12:48:01PM +0000, Charles Keepax wrote:
> commit 9b8ef9f6b3fc ("ASoC: dapm: Add startup & shutdown for dai_links")
>=20
> Added support for calling startup on CODEC to CODEC links, however this
> is called with a NULL runtime pointer. There isn't really a sensible way
> to pass a valid runtime pointer to a CODEC to CODEC link at the moment,
> so we need to make the startup function safe for NULL runtimes.  This
> patch returns from the Arizona startup function early if there is no
> runtime.

We need a bit more here about why it's safe to just skip this code - it
is actually safe since we're just setting constraints for userspace but
that's not something the reader can tell without looking for more
context.

--fUvfsPTz/SzOZDdw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWfEpQAAoJECTWi3JdVIfQcdEH/2+G76jiI6MqJ1fvaaWoEkVe
hi1WUmzRk3UUWjhmZVJOhgS4q5dnngzisRVfoLN0R29TSQINFQpRSoWaZNRwYBJZ
uSFXPalm1U0pEvGrAo4SrCPf67hHAcx34iY4mKmSWkBDl52Sh1bZ1KLpW5IjPmco
YXt5IaoGv9HEW2mJkw5O/hKKSvcyBwHGXE57ifIgDFn9URH/KZ4JWFIBt3hdkyNs
fHzDb4nzQzAyf3B9pGQ0O+5xu35oDhXt63zCcpY2k+tM5ZdWPESMKnuW7EW1frPj
vqzqVQzVt82+xFRUvEkJRIpnE+IHW4kyxSQGJRMVk9vA/g9rPaCeu7QZZt5hpJc=
=ETNQ
-----END PGP SIGNATURE-----

--fUvfsPTz/SzOZDdw--

--===============7128175467672760060==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7128175467672760060==--
