From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4] ASoC: rt286: add jack detection disable
 with NULL jack passed
Date: Wed, 25 Feb 2015 00:06:18 +0900
Message-ID: <20150224150618.GS6236@finisterre.sirena.org.uk>
References: <1423558916-19084-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3292929127997447714=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 394652604BB
 for <alsa-devel@alsa-project.org>; Tue, 24 Feb 2015 16:07:16 +0100 (CET)
In-Reply-To: <1423558916-19084-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============3292929127997447714==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aMfmUgCNW/aonds3"
Content-Disposition: inline


--aMfmUgCNW/aonds3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 10, 2015 at 05:01:56PM +0800, Jie Yang wrote:
> Some platforms, e.g. WSB, don't need jack detection when
> system is in Suspend, for power save reason.

Applied, thanks.

--aMfmUgCNW/aonds3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU7JNqAAoJECTWi3JdVIfQvdUH/0vumwylSzOnYEp0GhZiLghq
CdCP8gnQBl1k7pFG0YGfv51wMaSuGfWNnMYJkhoynerxMeQz56bkgoWLHORTgflM
qi+QWmqUfa5QuwgAeBxNYcMxGLx+EdSBfQdCaBrbSwWDV2bR/sbL4qC01RIu1fsZ
jVjClhRwFxTmjI5OYMGVRoPbdVjp97FcnbUVKN5xFR3m0lz3X15+mDeCM5WG20/5
Rac2Yt98nxR8TcQiTKrKZZ4rpL4KMXmKZHcDSuP5q6ZMDiaIoE/cK99nRuSMiMIv
EZRkymxkJyOTm9XRo/KnwhYik1k2yHi+55r4wZ2AeB9jo6EIgYXSkNs5uHYmbgM=
=RidO
-----END PGP SIGNATURE-----

--aMfmUgCNW/aonds3--

--===============3292929127997447714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3292929127997447714==--
