From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/4] ASoC: davinci-evm: Replace instances
 of rtd->codec->card with rtd->card
Date: Mon, 26 May 2014 16:35:13 +0100
Message-ID: <20140526153513.GW22111@sirena.org.uk>
References: <1400492508-2732-1-git-send-email-lars@metafoo.de>
 <1400492508-2732-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1290907522637969158=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 01880265312
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 17:35:49 +0200 (CEST)
In-Reply-To: <1400492508-2732-3-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Fabio Baltieri <fabio.baltieri@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============1290907522637969158==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DeQ9GnsEQp3CI+P2"
Content-Disposition: inline


--DeQ9GnsEQp3CI+P2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 19, 2014 at 11:41:47AM +0200, Lars-Peter Clausen wrote:
> No need to go via the CODEC to get a pointer to the card. This will help to
> eventually remove the card field from the snd_soc_codec struct.

Applied, thanks.

--DeQ9GnsEQp3CI+P2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTg18uAAoJELSic+t+oim9gaEQAJP9iWY9oLS4em1fpDo4QC9l
SRBrX3YgrMXExrVIyyKKVLmLsWREACJu22xOMBk1zpyVjr6+WLtBzC5fW1YIibfc
yS39KFjwgKGEq/AMOiDnb75mMUInn30QgCbHwh7EIbZQMmjiRjc4N1hBz/z5gCZc
Pr73XHIes2u60Jf+dkn6LuUjIpYsyCt1zvSjZ/I2lCuaOYIyA2GZxMfAjbZCiDeX
9NPbDMUrd0gc3FEya5U68F5vicQZgvCkcMz9nhwawjXiczz5y4CGccRUA4YyrQGQ
dCD+pFB6Df1Dq9F4GnL1fBGf2vPUuDcaggyw1g0XEb3/FnZgyaK0rxA1AorWPdUB
uQaN2BoGE9EbAec95ksfdzHVHYZryHmIyb0aX8Tz2L9Gc3HtsHxy5yqYsttMpHYd
mQxE3wLlWU7qwCuxC94KxkVX+ZibNPNoJ1YyhlpPU4FNb8EdHFtJnZ7tG8x9zYi3
+RfkpIK5BMxjDHHkzhJ7USVsV2/abg/X7msU41eWn5ZwOksnMZvpXNtmg4OX9K20
dEX/zvi5D3gk5KMZC2reU31gHTj6V8DhJPcU2cy4mzMJnVmaJ0ZtMVZxqH/935dZ
6YjPmp6xUVoBu8+IoJXFtjcjzV0FSu77dpL7Wwmd8r/iIpJYPRKSo7UfD+MCImh1
VcHkyFfr9eDTyaM36cw6
=qyVP
-----END PGP SIGNATURE-----

--DeQ9GnsEQp3CI+P2--

--===============1290907522637969158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1290907522637969158==--
