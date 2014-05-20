From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: neo1973_wm8753: Automatically
 disconnected non-connected pins
Date: Tue, 20 May 2014 23:29:39 +0100
Message-ID: <20140520222939.GN12304@sirena.org.uk>
References: <1400577208-1473-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1216194045109499756=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 44F792654B7
 for <alsa-devel@alsa-project.org>; Wed, 21 May 2014 00:29:54 +0200 (CEST)
In-Reply-To: <1400577208-1473-1-git-send-email-lars@metafoo.de>
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


--===============1216194045109499756==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NkZGSai31fN+YSZl"
Content-Disposition: inline


--NkZGSai31fN+YSZl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 20, 2014 at 11:13:28AM +0200, Lars-Peter Clausen wrote:
> The DAPM routes for this board are complete, hence we can let the core take care
> of disconnecting non-connected pins rather than doing it manually.

Applied, thanks.

--NkZGSai31fN+YSZl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTe9dQAAoJELSic+t+oim9x/oP/R2p/uVISJk0dLve0OFPgx/I
gU/dUvkTiM8OGt1csnDTmOM1CBY86Looe2Ccf5U5pLYcJEkl3HjpYpVuFcpph4Go
zpPXrUwub/wbExz1qEcy1RvyWQNyTLDjfc4UkoUFsnLDO3+ryzkpd86jd0ao4/GY
R4msEBBTJy+6H84HSITLt4lbHdoMeB77p2T5r4ydehRsJv9vUZsOCDy8myOAs0i0
dIui4GUwJWixnA1HeexXzhqf7JiPC6D80CuuUwgfM+FanlZoumxGwye11DeYC5u3
GFHCz1pYr21OpQrrxSppf2QhRjguMA3kvM89NwIy/HmHNYKuplKno21DXLuPxi7W
wGKD0ABpc/vE6IhnRcggPbU75+isaW8ncM4F/0yOnB883oe0yMBR7wbLQmqZrfZe
LpCfdPgJOJxNdoO/57sjcvFYULzOxiZ+KEfJNG8nvM8MjrK+V5Ax651ARrIHA3kv
rvHMHiXO8Cax6S9/09/GCVxI16zYpqHtVDsyd/Cs52dBujvt47jfsjWujAIl0DuC
BvS+NEfSHp2HYj0YaApoRisJZ6Wk+e3r8BwnbSpJGMu4dENu3cRNVPysKe1IiD36
G/PaQ140Z+sdYUf6uMOxSgFngcwvGlsUo2/hLAFPfDQbJa8ktPwfinyjR60TgsJL
wSqAwaGgiGBGYJkCqtk4
=R3FI
-----END PGP SIGNATURE-----

--NkZGSai31fN+YSZl--

--===============1216194045109499756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1216194045109499756==--
