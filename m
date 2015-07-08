From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/2] ASoC: Intel: skylake - match braces
	for if-else
Date: Wed, 8 Jul 2015 19:27:23 +0100
Message-ID: <20150708182723.GX11162@sirena.org.uk>
References: <1435079413-28094-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8988278209987209668=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 12B602650C0
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 20:27:29 +0200 (CEST)
In-Reply-To: <1435079413-28094-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============8988278209987209668==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cnUHsqv9fxRVMt2T"
Content-Disposition: inline


--cnUHsqv9fxRVMt2T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2015 at 10:40:11PM +0530, Vinod Koul wrote:
> Coding style mandates that if-else should match braces even if one of them
> is a single line statement. Fix it in two places missed earlier
>=20
> Mark, you can also fold these two patches with SKL driver series (1st and
> 2nd patch can fold in 1st and 2nd patch respectively) or apply independet=
ly,
> either way okay

I really don't know what that series is any more, sorry.  I've got two
pending serieses both identified as Sky Lake and sent after this one.

--cnUHsqv9fxRVMt2T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVnWuLAAoJECTWi3JdVIfQmf8H/17bVuLYLYBMofMcZMo4E9sY
ZXFDtvCdqubiuSLqs47cEqdWZO6uWNW2dE8Q0zet5dl/Wr4hktjelkP1y0Qi1xzT
fPwSCPzZXu6Thk6nNnTLR5/X/nje6b6gJ3WsZa8c+AcqDg0jUV/H6AFEDfOdN64s
yhuqSZYvTR6ZszywcQCaZp6rM5RtneNPiDccaO9YQ9SRVFPjjG7fOmiOin6yWIYQ
jPAkuivzmETgsYc29Z0Q5YgDoOJmyRvyZrs6csXRLlFk40sXWURTfTT6yTS0YpEt
B1+Qu8dak2wwDNJ0q3bchKqYkHoHJe+Cxb6jPAQX78Gs0GSEouslNUWqjApvRus=
=jGB0
-----END PGP SIGNATURE-----

--cnUHsqv9fxRVMt2T--

--===============8988278209987209668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8988278209987209668==--
