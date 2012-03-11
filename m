From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: mx27vis-aic32x4: Convert it to
	platform driver
Date: Sun, 11 Mar 2012 20:46:20 +0000
Message-ID: <20120311204620.GD3171@opensource.wolfsonmicro.com>
References: <1331496516-6578-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4169321458033011455=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 09FAD2456F
	for <alsa-devel@alsa-project.org>; Sun, 11 Mar 2012 21:46:22 +0100 (CET)
In-Reply-To: <1331496516-6578-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, javier.martin@vista-silicon.com, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============4169321458033011455==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2iBwrppp/7QCDedR"
Content-Disposition: inline


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 11, 2012 at 05:08:36PM -0300, Fabio Estevam wrote:

> +MODULE_ALIAS("mx27vis_aic32x4");

This needs to be platform:mx27vis_aic32x4 (though for style it'd be
probably better to rename to just mx27vis, since that's a specific board
rather than a generic class of them the CODEC name is redundant).

Otherwise looks good.

--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPXQ6+AAoJEBus8iNuMP3dhNsP/iWa9coCMLrNNGXw6KUSc/fb
dA8XpX+2bSr2jMy2XzpuqccsqZEAqfyb3MQQ1Th9RaN/02EMP5zj+sxxh5HTiLX7
BPKLhjO2Ug+d9MtEbHSi1TUY15UODnGNXDeSmTEzvVes8sOA9z5Fr6yeNDEAYj6B
Hjq8FJAcBK49NpVwJG+p3Ek7gIsErM6o9kvhJwdGxcUh7wDmY1MHXxqUzsIjQ0fz
lO12HgomYO60M1YVqEPFxDvesBpW549jRX4XepGbYCfhgoalzdOvWdudrvYZ1Ff3
EgxYFduZbf7CaBSh4E37Qh6Aqx7LpoToiCDZHv5oP5l6vpEEmUw6oVXkannNAvG2
N6y8JznG6pRVCuLQju/LAwtECgLfw4XMO9UWx0fgDG+GFZb70nNOtd/R5Q2Axfq0
uFC2qGJ71WRW7mvwergjnBGt1qUKw0Wpz7Ad71QEMBAnU7Mt9CdrXonSR8vGkX4p
6wcnUObeugSrfCswQAFfEHhqrsdTwzF5A3YDu5/BnK4J4EdEHP2sWyetJTUg83TW
/cOP+DNpost/hX2tWVi2LJ2kHTqrPkYtkEYgeHW0/05jpYtcXhQtiaGnPLA4pdUi
pOZGkUG94s6I0sFhL+T4n6OwlXiE5XH0imKyXgp2EbfQ76ep3Jig50hDAPYDCI9C
4V8o3QO4H3kFXuK/Thge
=6sDw
-----END PGP SIGNATURE-----

--2iBwrppp/7QCDedR--

--===============4169321458033011455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4169321458033011455==--
