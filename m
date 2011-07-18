From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v3 00/10] ARM: mxs: add audio support
Date: Mon, 18 Jul 2011 22:38:16 +0200
Message-ID: <20110718203816.GA9457@pengutronix.de>
References: <1310731780-1645-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2447258061856673316=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 61577247DC
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Jul 2011 22:38:19 +0200 (CEST)
In-Reply-To: <1310731780-1645-1-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <b29396@freescale.com>
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, u.kleine-koenig@pengutronix.de, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============2447258061856673316==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 15, 2011 at 08:09:30PM +0800, Dong Aisheng wrote:

> This patch series is to add audio support based on saif for mxs platform.
> The driver only supports playback currently.
> For capturing, due to hardware limitation that we have to use two saif
> instances to implement full duplex (playback & recording), we need to
> figure out a good design to fit in ASoC as the following work.

So, since the codec problems seem to be resolved now (and they were luckily
really just codec-problems):

For the ASoC-patches (1-4):

Tested-by: Wolfram Sang <w.sang@pengutronix.de>

For the mach-mxs-Patches (5-9, 10 is already picked up), assuming patch 6 w=
ill
lose the DIGCTRL-handling:

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

I think this series is good for 3.1. Now we just need the mxs-dma bugfix on
top, but that's a different patch...

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk4kmbgACgkQD27XaX1/VRuzIwCgp2dQtU9wL/MsoAf7YePVkSuS
2FUAn1S47hs9MpBlSydzWqvLCFQCRXXs
=14Z/
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--

--===============2447258061856673316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2447258061856673316==--
