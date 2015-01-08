From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: Intel: Add stream direction for
	pcm-module map
Date: Thu, 8 Jan 2015 18:32:58 +0000
Message-ID: <20150108183258.GV2634@sirena.org.uk>
References: <1420698741-26016-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8078845769050534851=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C3ECE260490
 for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2015 19:33:04 +0100 (CET)
In-Reply-To: <1420698741-26016-1-git-send-email-yang.jie@intel.com>
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
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============8078845769050534851==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nnMoK2AbBw/2F3ti"
Content-Disposition: inline


--nnMoK2AbBw/2F3ti
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 08, 2015 at 02:32:20PM +0800, Jie Yang wrote:
> A DAI may have 2 streams(playback/capture) and different modules
> may be needed for them respectively, so we need add a stream
> direction here, the combination(dai_id + stream) can tell us
> which module we really need here.

Applied, thanks.

--nnMoK2AbBw/2F3ti
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUrs1ZAAoJECTWi3JdVIfQO4MH/Rctj0MY1oImPEjEH5jRLR8Y
xeCiZb1wQYa1HVLaF747U5yGXhUyoIDyaLPZsLq26mCVU7BYvwUynEj32Z8DS6gD
hpGj2iP/u5ifdmrHoU+qMYv2FRCHMIYK5Fk1t7IPC+Y+9jte+oUD1DhhtxjD6ARl
cLGAEakbIAd5S8nbfFlOWBeXaCX2sY3zgjJewxWhjm0Y7L2KjXapq6kcBTmMBPyX
XgIWy57hGO94KOxhRv5bodwDjO8Yae60GJGlh+vMn1kkJtoesXaGh0ZGxcuMiChi
9aaX/G1Z20ZQ5Tw7O9GfkW458kwL6mbYv79D1xpBLU1K6HAWZIVU8vp6o6f+e0w=
=9Xcs
-----END PGP SIGNATURE-----

--nnMoK2AbBw/2F3ti--

--===============8078845769050534851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8078845769050534851==--
