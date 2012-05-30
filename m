From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: fsi: use PIO handler if DMA handler
	was invalid
Date: Wed, 30 May 2012 10:44:29 +0100
Message-ID: <20120530094429.GC9947@opensource.wolfsonmicro.com>
References: <87pq9skaun.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8166997187450119999=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 87AA42434D
	for <alsa-devel@alsa-project.org>;
	Wed, 30 May 2012 11:44:31 +0200 (CEST)
In-Reply-To: <87pq9skaun.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8166997187450119999==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DIOMP1UsTsWJauNi"
Content-Disposition: inline


--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 24, 2012 at 11:56:19PM -0700, Kuninori Morimoto wrote:
> PIO handler is not good performance, but works on all platform.
> So, switch to PIO handler if DMA handler was invalid case.

Applied, thanks.

--DIOMP1UsTsWJauNi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPxevIAAoJEBus8iNuMP3dBkIP+QFGQJITFX0ZVfLisCZV/9f0
XK7yPFJGGfwdd0X9VNO3sVDO1lAzkXbi4rxFsZNW35OMf8E5YpE/9WgSZSuc2oXF
nlKbYzDtYFxJdzzCm4JurjyvrWGN1pJOfmbCOsa1D/4bsPPc3EKUGXkjjn4ZyZxc
yCIIagxQEc0bGeOWahh1d7l81ug0YWILFmgCML6TG5BnsDawcTgRxw3jrXjKRhzZ
8jUyhSYgZIJ3TJniITu9DoIeIrpEwKnyEgRHjRLxZNF6PYS69fCJzgigV7h5pGMs
w6DEnEaNkoW5Dk1J5SkWOO7xsockRjA5AwXsBU7VbtNc3Uugd9ruasAr/0kNW7qI
okbo8Qbh4yNjUH6UQ7XDEHqpewkqmLzi4RjS90sfoT3jyf0uEGGqcWNTezuZTaDy
29ANwkbwntvb7emHZYOkUiYb3iEmth8DvZjMVY7d2Fztq5aTKUODww8dYw9f6/3S
WPHLkByb5tvWVJEciwUdccr/mFWOrkkGDpe7YcLNfCkzNW1FOrOaznfriLc1pOgP
/3Co/An+DTKmeLaFDLkhDBXKS+RdgolOJUtFkEma4B4e45EkqdHtZ2Fau96SZANy
+u6VoNf/uOgdwrIqG3+shD4Rp9e85A+N7JIIAP+lGi6OMBHizbaDRB5L8zC9FLGV
PZdiW7sv/BLIr34S6a1C
=u2nL
-----END PGP SIGNATURE-----

--DIOMP1UsTsWJauNi--

--===============8166997187450119999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8166997187450119999==--
