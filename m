From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 15/32] ASoC: wm8940: Cleanup manual bias
	level transitions
Date: Mon, 24 Nov 2014 18:27:51 +0000
Message-ID: <20141124182751.GI7712@sirena.org.uk>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
 <1416746269-4935-15-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7639243503886353942=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 57B95265497
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 19:29:57 +0100 (CET)
In-Reply-To: <1416746269-4935-15-git-send-email-lars@metafoo.de>
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


--===============7639243503886353942==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A3bjmUvO/1DXpqhN"
Content-Disposition: inline


--A3bjmUvO/1DXpqhN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 23, 2014 at 01:37:31PM +0100, Lars-Peter Clausen wrote:
> Set the CODEC driver's suspend_bias_off flag rather than manually going to
> SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
> the code a bit shorter and cleaner.

Applied, thanks.

--A3bjmUvO/1DXpqhN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc3imAAoJECTWi3JdVIfQzKMH/1el4OhwZyPAgvmxByunj46X
1IPK2rZVaufQEX30J6ItT18RHHAKdVkjtt3RWHDFR7FlZmTLy0VjTHjUgloTeJPp
6OEREj37NFwCxlLvUAarpLTt9r074H8tVFDW08731fMjnM6vEvsyX/ZEXJqBPzuJ
RyoHvtRh5jouQKOgd+2y5SN7Y1gSgwykhi6v1AnbClLsauQoFox4cXYYkLFuCQ2A
1P7QzlXgsoDCy58kUa5P73+AanvgiSejztSRRF/FoT8SI4OgD3/3pfC1OIYnl5eb
RU0imd45mgTJ3ezDQ1hPqvWWMA6OR7sP9VKYEKTrCB74bZ+/Mh+uf+KK8vhG3E4=
=QWGU
-----END PGP SIGNATURE-----

--A3bjmUvO/1DXpqhN--

--===============7639243503886353942==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7639243503886353942==--
