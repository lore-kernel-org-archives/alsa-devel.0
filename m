From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: max98090: Replace w->codec
 snd_soc_dapm_to_codec(w->dapm)
Date: Fri, 21 Nov 2014 18:17:00 +0000
Message-ID: <20141121181700.GD3815@sirena.org.uk>
References: <1416514915-29836-1-git-send-email-lars@metafoo.de>
 <1416514915-29836-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1197700553187247929=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E757265DD3
 for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2014 19:18:29 +0100 (CET)
In-Reply-To: <1416514915-29836-2-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1197700553187247929==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8j73UBLm1TZSxxfa"
Content-Disposition: inline


--8j73UBLm1TZSxxfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 20, 2014 at 09:21:54PM +0100, Lars-Peter Clausen wrote:
> The codec field of the snd_soc_widget struct is eventually going to be
> removed, use snd_soc_dapm_to_codec(w->dapm) instead.

Applied, thanks.

--8j73UBLm1TZSxxfa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUb4GbAAoJECTWi3JdVIfQZ9YH/ilFmrHUthNBqzaP/dNd7QkD
7y5ispSUYgbNvphcp1TYPqgCfDenEUB1q8271pr2xS9Whn4ELccAeh/8OMtyvnG3
KJ4ELdNblbNmrvDjpUD592IMABo3/G0gHDEEi420tiZKSY2a3wS13c04Rk53v5xi
NHxa3h/kGGoPW4Q9Hk2jIhkbm8fCAICn87MZOqAHWRsKqBp72Vwl6/9s0aYW4A9T
iDVIzFtXVRwLEAOuH5+gFLboGnu4W/Nw1hlHEzenD7BhGd+aVIsagfra4cpaKl6X
j4GZykC8g5CnheOrvsIpA01K61X2DZLWSEPBkeRkPd7XZP4Jqdgr461MpH02oDs=
=7IQ2
-----END PGP SIGNATURE-----

--8j73UBLm1TZSxxfa--

--===============1197700553187247929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1197700553187247929==--
