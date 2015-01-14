From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_ssi: Change irq type to 'int'
Date: Wed, 14 Jan 2015 17:16:10 +0000
Message-ID: <20150114171610.GX4160@sirena.org.uk>
References: <1421239739-7755-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0461002168157658428=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B7E3926528D
 for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2015 18:16:20 +0100 (CET)
In-Reply-To: <1421239739-7755-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org


--===============0461002168157658428==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ubca5Sl/zyRO+Ah+"
Content-Disposition: inline


--Ubca5Sl/zyRO+Ah+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2015 at 10:48:59AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Since commit 2ffa531078037a0 ("ASoC: fsl_ssi: Fix module unbound") the ir=
q=20
> number is retrieved via platform_get_irq(), which may fail and return a n=
egative
> number, so adapt its type to 'int'.

Applied, thanks.

--Ubca5Sl/zyRO+Ah+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUtqRaAAoJECTWi3JdVIfQ7VAH/3XEiOyCcFzBKqt9UXlzzm0j
1tGBqUa0xvdsj9uJP2JFd3cLQdJSJ9zHk2sm1tgmUnkAN7+vp+8HdeNnZWNhzIgv
muzHXwoDMwlDf3iga4arpjyu8tXukn1UQDKqsliNIpEPJGWQitDZhCy8tuRUDZw7
9rmXYgww6aMUr7N1GuNHRuzbitpskNA1qLvEpIIk9Npnl5dqml68E7vhpOUFBqa4
1AlqB5+KeOZUTMcECb+JH69J9eAuF7RDpUY1bTw0ObTpip1BpUnc0a7wGBAgMNat
YtHHckpIOz65jhCBqNRXIkP9w7IJGohZ7qcD1UvqWrONHloQDYfZR8U7l6bp2J8=
=QsYd
-----END PGP SIGNATURE-----

--Ubca5Sl/zyRO+Ah+--

--===============0461002168157658428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0461002168157658428==--
