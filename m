From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 13/13] ASoC: mxs: mxs-saif: Let device core
	handle pinctrl
Date: Mon, 6 May 2013 20:22:05 +0100
Message-ID: <20130506192205.GD7478@sirena.org.uk>
References: <1367863561-11534-1-git-send-email-fabio.estevam@freescale.com>
 <1367863561-11534-13-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7170542242095028770=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id F2AD7261B28
 for <alsa-devel@alsa-project.org>; Mon,  6 May 2013 21:22:09 +0200 (CEST)
In-Reply-To: <1367863561-11534-13-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org, shawn.guo@linaro.org, festevam@gmail.com, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============7170542242095028770==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XvKFcGCOAo53UbWW"
Content-Disposition: inline


--XvKFcGCOAo53UbWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2013 at 03:06:01PM -0300, Fabio Estevam wrote:
> Since commit ab78029 (drivers/pinctrl: grab default handles from device c=
ore),
> we can rely on device core for handling pinctrl.
>=20
> So remove devm_pinctrl_get_select_default() from the driver.=20

Applied, thanks.

--XvKFcGCOAo53UbWW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRiALZAAoJELSic+t+oim9k4gP/1E80PsbCU3wiBK31quhF97t
c68XzoC7dsHvfqCJcEhG6CgIZMTjmAfgpD/z73iDGaKZHAMEE/3kdlZyUrpggElh
dvov89seS3EVDy3ksjiOXCk9/CTYwEX/J5ElPCy951TMnDC8rMGIf8eGHuMjrPiw
wpMqKDzW5HiuIOjaCkiASt+pLsDVQ6WDPI13PM2KshQCPJ8QLNhIz2wUXNmsA0zK
b4iDp3pHytzgklb8KAUlaQpmmQxyttbA4kQTWkFMeJO3I4Hr4r8tWQ+Z5yX3v4kt
e5/6nGQxtntgcZqDOvcLbwQOwDDy9iFKOb6LveCeQKnzqthfuaQAPzo+CXTkRCoB
5qYoyvnIegFum4iGtF/skQQX2LHHQgiVdqC3cyXh3S1/dQfKbY9X8QdXdGExUH4o
7UuEOF+ajR4qoLBJoIMnnlis1y0guA+rNN+4/Ekkx8DpPdG5B8DVgmMQzxNZQseO
oRnMQle1LtOXLEeN9w6FY0C+uoa+w+oMuTmUnwQCBju1Bz2ykML7QdcLpxvSJhMw
/7J49WN0WN70aU95vvqn2BbycwnQrzFR0Sc8MkUAp76lxc2vsiSE9tzV1UTkZCvt
yLOR+240J/RAx7igsHogKJ7GwFMtZJgwFSIKF/bjL60S7XfCn4EbuKcFypIttJnp
db6/IWMdBXEWPZuFBIdb
=Wc85
-----END PGP SIGNATURE-----

--XvKFcGCOAo53UbWW--

--===============7170542242095028770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7170542242095028770==--
