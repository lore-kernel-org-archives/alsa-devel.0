From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 05/32] ASoC: wm8580: Cleanup manual bias
	level transitions
Date: Mon, 24 Nov 2014 18:19:30 +0000
Message-ID: <20141124181930.GY7712@sirena.org.uk>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
 <1416746269-4935-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2069761775198178141=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 936992652B7
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 19:21:34 +0100 (CET)
In-Reply-To: <1416746269-4935-5-git-send-email-lars@metafoo.de>
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


--===============2069761775198178141==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9QtXyXGM8HCrXlir"
Content-Disposition: inline


--9QtXyXGM8HCrXlir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 23, 2014 at 01:37:21PM +0100, Lars-Peter Clausen wrote:
> Since the ASoC core now takes care of setting the bias level to
> SND_SOC_BIAS_OFF when removing the CODEC there is no need to do it manually
> anymore either.

Applied, thanks.

--9QtXyXGM8HCrXlir
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc3axAAoJECTWi3JdVIfQBAMH/1fJqm9E8XcDnRHOwnvHCtaf
qNTvNpQvlxAxx7eLeH8VT0ix/iWOcokX19Ota7jITpaTXfHFzl/lS6Lv3dIpqbf1
aOcdJk46vu7MnokMBy0sMkEcqKVi7kbV0ZPjyJkJUG4hERkdIpC+Z9YTK7PiLcCB
n+38KcjgZEDVErmunMcSuHfzcaX65G5ZWLD9kX2nFTgNMgxC+W5BuVXe8TUWAcU4
dnUK1RF7S/12zWKJIgn9yZAEaE0AQ5YpuzOkqMt4spbjLrQgYvLDiFx5M/59O3kb
U578BVzVU9E7MJ3MrpoHcz04IojYatBgLWlZpv1hhgPQktaAwTQb+f/GwKPQtkc=
=yTOs
-----END PGP SIGNATURE-----

--9QtXyXGM8HCrXlir--

--===============2069761775198178141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2069761775198178141==--
