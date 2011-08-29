From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 3/3] arm: mxs: disable clock-gates when
 setting saif-clocks
Date: Mon, 29 Aug 2011 15:50:23 +0200
Message-ID: <20110829135023.GO24524@pengutronix.de>
References: <1313946314-3891-1-git-send-email-b29396@freescale.com>
	<20110829130747.GL24524@pengutronix.de>
	<65EE16ACC360FA4D99C96DC085B3F7722274D9@039-SN1MPN1-001.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4141955282291765610=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 59DBF243A5
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Aug 2011 15:50:26 +0200 (CEST)
In-Reply-To: <65EE16ACC360FA4D99C96DC085B3F7722274D9@039-SN1MPN1-001.039d.mgd.msft.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng-B29396 <B29396@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "lrg@ti.com" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============4141955282291765610==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jozmn01XJZjDjM3N"
Content-Disposition: inline


--jozmn01XJZjDjM3N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Sorry, i know that, I failed to apply the patch from your mail directly,
> so I applied manually. But if applied manually, the sign off was changed
> to my name. I did't know how to fix it.

As said, no problem, thought you overlooked it. One way to fix it:

	git commit --amend --author=3D"The name <the@address.com>"

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--jozmn01XJZjDjM3N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk5bmR8ACgkQD27XaX1/VRvGZwCeLWViF8TUdsQgTlGzmtRTpMBc
qyYAni9seO4ynyOPRaYxpLt19ha2F0RG
=Lwdv
-----END PGP SIGNATURE-----

--jozmn01XJZjDjM3N--

--===============4141955282291765610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4141955282291765610==--
