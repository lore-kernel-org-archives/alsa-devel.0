From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/5] ASoC: dapm: Use
 snd_soc_dapm_add_path() in connect_dai_link_widgets()
Date: Mon, 12 May 2014 21:35:45 +0100
Message-ID: <20140512203545.GK12304@sirena.org.uk>
References: <1399472428-11034-1-git-send-email-lars@metafoo.de>
 <1399472428-11034-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7796428327031494136=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8612626510A
 for <alsa-devel@alsa-project.org>; Mon, 12 May 2014 22:35:52 +0200 (CEST)
In-Reply-To: <1399472428-11034-3-git-send-email-lars@metafoo.de>
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
Cc: Songhee Baek <sbaek@nvidia.com>, Arun Shamanna Lakshmi <aruns@nvidia.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7796428327031494136==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YrX/q501D8XiO19W"
Content-Disposition: inline


--YrX/q501D8XiO19W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 07, 2014 at 04:20:26PM +0200, Lars-Peter Clausen wrote:
> We already know which two widgets should be connected, so use
> snd_soc_dapm_add_path() instead of snd_soc_dapm_add_route() in
> snd_soc_dapm_connect_dai_link_widgets().

Applied, thanks.

--YrX/q501D8XiO19W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTcTCeAAoJELSic+t+oim9hqsQAJRUCgrkY+c8lYXudPyysARR
bZjf71CWTwhNYpUplj06RjSIqMcZSK+G2WQDfUL3FRj0P/PZ/1NRcAl061nwf/tT
bUtj1BUI5LuC2heis53U5ifOEvdLfLgmYZiHxneMJWhCZY9MPmQ/kzVgAvjhrRnj
l8wnZu3xg35joG2rbpGP5fJ5qpEjruCu9kAOq2laEJb+t86sFEw9XhDHgFCLxkWl
5Gm6FCVUpGq6LKeNA104nnm6WTGJJMh+uunTZQ0sDfqT0XWiHNjr/GUCqmlnAWVs
/jE9n+jhT02bTeRNb9y9CbpNyRwrKfbHyi0li8hS0aVz8T20LXkOLj40Yi2kqAKa
5lGRZT7ilXP+WaEwwqEIgVD1IAQ/Z3UHmJ+exPNVRSNeNT83b53lpwVpNEky9010
ExC8WKORgMVyqxhGEYUwlwKoWLHFiDlgHxSE14Kl11eUe9D3PK34bZm1S0VGWsof
C4AYZaBv7N2f2ZIdJ00uSMKkqOSAJEXf7N3vDSNv/5dJAc+/sjYt0387KBdBBUHl
LfYNZ2/luzLhJqiRKRa/gP3ZrOUpjpD9kOEBT5Ckw9MKdLHh4fjUFH4RhK2W7bIL
S1ud8Ud4BcP8oJyXtXheFjaCYYLTr6UPgIwNT6mBRsxfJHcGI1gIp762Ugf6WHgc
HtWe1RPngGBMwlK/KpuT
=NSlD
-----END PGP SIGNATURE-----

--YrX/q501D8XiO19W--

--===============7796428327031494136==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7796428327031494136==--
