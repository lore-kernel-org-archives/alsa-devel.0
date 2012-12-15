From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Prevent pop_wait overwrite
Date: Sat, 15 Dec 2012 23:45:38 +0900
Message-ID: <20121215144537.GC22033@opensource.wolfsonmicro.com>
References: <1355422985-17100-1-git-send-email-misael.lopez@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1174100140899470194=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BE43F26077D
 for <alsa-devel@alsa-project.org>; Sat, 15 Dec 2012 15:45:42 +0100 (CET)
In-Reply-To: <1355422985-17100-1-git-send-email-misael.lopez@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Misael Lopez Cruz <misael.lopez@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============1174100140899470194==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Content-Disposition: inline


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 13, 2012 at 12:23:05PM -0600, Misael Lopez Cruz wrote:
> pop_wait is used to determine if a deferred playback close
> needs to be cancelled when the a PCM is open or if after
> the power-down delay expires it needs to run. pop_wait is
> associated with the CODEC DAI, so the CODEC DAI must be
> unique. This holds true for most CODECs, except for the
> dummy CODEC and its DAI.

Applied, thanks.

--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQzI0FAAoJELSic+t+oim9PFYQAJnPccF9p/48njU7fNDW+25X
WwmdhuCaaCrcjofBfq6WfByPWsrTx/g/To3XPu32qzdXQiQTq6mkHuHBZ3VFGgWX
agaxGi+T9C/NCn8fIG8Q7QJp6ebblw68m/oPlffa+bwW1ZNlZJc3o6pnm6aao9Hk
tiPoVDiVoQTuaOFy5q3PEjnO3u+6Cdx+XzwnD8+918rZvzoe82b5rMVdDqJn5KmJ
pkbaJHcEW9/VQq6joL5smPBmEYpyZ0z7M1AiWKLeQeftTNmzIM71WMvb+PXAp+9v
/BdNabCLZlXhFce6mQQp7+lq4uIqIfPs12hpcJ88IExuJ2GrhWsdjbKQanFw1rpY
2q/CCPYn0uZVoLcM5nUuqfJ4rWtwWQ1M+7/JcD7OvPyIzUcEGxKnCXc9MlFsiSdJ
ut3IytlyLvEPk+V6BOFMEVXr6kVJ4hzJNNhthUs/DKTRwEggerUEee7nUVQytGG+
i5Af6f7iO5t5w9ShCysa88DiZoO8Ayhd6zH3ComMWwcnXEvRuNE0ooTw8+3UhrPr
83EX2JPDAq3x+wYap5jTDJNYO13H6FzNmibCfhev9ETTdISO8ElUAFB0rRSd+rpg
UKNHFBIQBS8NWzixuPmNNnL2Bov1JtMwZw8Kb7r4OZt77HDlIqfautlwASJWjGCV
CVtpeX4362MZuhwOQwJC
=lL7r
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--

--===============1174100140899470194==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1174100140899470194==--
