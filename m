From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt286: Restore default in probe
Date: Thu, 9 Apr 2015 11:32:08 +0100
Message-ID: <20150409103208.GS6023@sirena.org.uk>
References: <1428549632-27893-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4181360060115324010=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 149D026051B
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2015 12:32:15 +0200 (CEST)
In-Reply-To: <1428549632-27893-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, john.lin@realtek.com, han.lu@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============4181360060115324010==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iYOBPcVA6aqRzaCT"
Content-Disposition: inline


--iYOBPcVA6aqRzaCT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 09, 2015 at 11:20:32AM +0800, Bard Liao wrote:
> RT286 can't do register reset. If the hardware power is still existing
> in power off, rt286 will keep the register settings. So, we need to
> restore the default register value in probe to make sure the cache value
> is the same as the real register value.

That's really unfortunate but OK, applied.

--iYOBPcVA6aqRzaCT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJlUoAAoJECTWi3JdVIfQbpEIAIRlxV6AXWEWzX+s/XrM49ZX
DIh1JChbb0EOcynLlmk5Gui9mAnNHH7P3Env+fywQDfleut4TejCZH+gkNtsrLGG
wEfdgxZ3y2gKxkEPodsfbJjtNpn72ryPjz2A8yxkaO9tNArr5lkWKYQU991rClHy
Iz/KGrVFBh03B7ptqoIehalq+r1d5ptZEJJ55MkfdSOhlOS1sjuxd4FM6LDRDwKZ
RthgDm10nFco5YU1mMUddja9zBBOJY/i+DkiowHPgOwJl3o2CbfRpzh68ajKS6v4
5uABa7q2Yck1C7THvOXb9nVoi/TlOGQ+Ypv26P0Ey5TS2YtvAqzRsy9cQIyas+4=
=9B2G
-----END PGP SIGNATURE-----

--iYOBPcVA6aqRzaCT--

--===============4181360060115324010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4181360060115324010==--
