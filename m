From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/29] ASoC: arizona: Replace w->codec
 snd_soc_dapm_to_codec(w->dapm)
Date: Wed, 14 Jan 2015 19:54:29 +0000
Message-ID: <20150114195429.GL3043@sirena.org.uk>
References: <1421141255-21477-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0287823413254227723=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 106E226525F
 for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2015 20:54:39 +0100 (CET)
In-Reply-To: <1421141255-21477-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0287823413254227723==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rVkomL2febZOZtGQ"
Content-Disposition: inline


--rVkomL2febZOZtGQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 13, 2015 at 10:27:07AM +0100, Lars-Peter Clausen wrote:
> The codec field of the snd_soc_widget struct is eventually going to be
> removed, use snd_soc_dapm_to_codec(w->dapm) instead.

Applied all, thanks.

--rVkomL2febZOZtGQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUtsl0AAoJECTWi3JdVIfQmCgH/0KJBCufjwAOlc7LSPvhLOjl
QYI/TGpXCkUI5/1RCrfLMtDjnXGd1lAY1aW/0V3/0S93M0IcQuhDu0phHejMe3qV
0aYiuoRHEI3zdHu3k1fuaTIBhdFROvqt45fGFMjf/NPXseX5oVHhRmjj4aQU68lB
fbUkrAgIN0Jl6QD3b9fc4ax5NONDky4uJl/jp/qErUwbUGHqAIMlWVCT5QglTKX1
uOsnBkt/Wt/CnGf1eCpdePkLaXJF9Pl/YJ6GmUwAPjeG5djDnjDAwPXPVPI4QGjN
GctUQn9B5wEmUJlwUuJxod/Tl1CpZFYK18kT33gcovukF08r4/xNOlUqDALYwoU=
=DTA6
-----END PGP SIGNATURE-----

--rVkomL2febZOZtGQ--

--===============0287823413254227723==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0287823413254227723==--
