From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: dapm: Check return value of
	snd_soc_cnew()
Date: Thu, 1 Aug 2013 14:37:16 +0100
Message-ID: <20130801133715.GS9858@sirena.org.uk>
References: <1375358887-9160-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9217727757568246927=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2072C260818
 for <alsa-devel@alsa-project.org>; Thu,  1 Aug 2013 15:37:23 +0200 (CEST)
In-Reply-To: <1375358887-9160-1-git-send-email-lars@metafoo.de>
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
Cc: Olof Johansson <olof@lixom.net>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org


--===============9217727757568246927==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0P9TaaCeWEe02mc8"
Content-Disposition: inline


--0P9TaaCeWEe02mc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 01, 2013 at 02:08:06PM +0200, Lars-Peter Clausen wrote:
> snd_soc_cnew() can return NULL, so we should check the result before trying to
> use it.

Applied, thanks.

--0P9TaaCeWEe02mc8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR+mSIAAoJELSic+t+oim9EvYP/RoKeKSBWQqtRjLK4qrU9MW2
ZcH1IG3DSEyHkbQ5HQs0XbBixMQvZLsQjoTQUF8gz/cRM1fxAs8MjTgTVpiGY0yZ
VOHUBwElT9L33m8oVw0B1QXoXRYt/RTdxrHSYCPjbMsizBaBdX40KsnuTLKhq3tG
z8XnLzlqhvGFYyXGKQHbzZaBrOuXTfInyr6d9pzgOKS5bV71tRuJq8YbGsTbqlus
mXqcCrS3fWRYtffPIO/kI/ZmOEqQ0Q9Vlgu0+uyTDS8IwlsG0KDF6llgacpWBfqC
pOeJRy+aopMxEZ8piGck2zoDUkk7+0p2wyWBLzt9IzrIfODJQ39VkQO2nqczDzwY
yhp3MQVw1RIZgtI0iWBDnLf+WwGfbEZr6FMr6ReFB/S9o9v3MsYfkCHXkBhd0BkM
oXZ/U0rI5VhbnW7mMwxL82O2QwPJxRfEJb4k8j8tIQA9GFguzP1czGcKFws6ibuN
xIwzMtCFAvyDuUiRTXiVj4zkn/tWwIjhfpT4N1VSzxgz+A5XnTS/nZYQZmmLblZs
bWquP+B2HpA2ssgebbNw9UpBVtZADfgSvqjGI+V4UqEhDXioBrMB3bK5JuS5LmS+
FtX9jlnrfqiyDSj+SE8mw3SPY06gUKSBhoyfmJj9gAG1BLJbeYIAbeYDTKboXaum
Kd7n/DaML0/5qre4NY9T
=vBWx
-----END PGP SIGNATURE-----

--0P9TaaCeWEe02mc8--

--===============9217727757568246927==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9217727757568246927==--
