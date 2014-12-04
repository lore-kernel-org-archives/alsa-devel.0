From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_ssi: Fix module unbound
Date: Thu, 4 Dec 2014 22:47:45 +0000
Message-ID: <20141204224745.GH11764@sirena.org.uk>
References: <1417471034-28880-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4053794418993158233=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 229F226042C
 for <alsa-devel@alsa-project.org>; Thu,  4 Dec 2014 23:47:59 +0100 (CET)
In-Reply-To: <1417471034-28880-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, lars@metafoo.de, arnd@arndb.de, timur@tabi.org, nicoleotsuka@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4053794418993158233==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hlh2aiwFLCZwGcpw"
Content-Disposition: inline


--Hlh2aiwFLCZwGcpw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 01, 2014 at 07:57:14PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Trying to remove the snd-soc-fsl-ssi module leads to the following warnin=
g:

Applied, thanks.

> [   31.515336] ------------[ cut here ]------------
> [   31.520091] WARNING: CPU: 2 PID: 434 at fs/proc/generic.c:521 remove_p=
roc_entry+0x14c/0x16c()
> [   31.528708] remove_proc_entry: removing non-empty directory 'irq/79', =
leaking at least '202c000.ss'

Please don't include full backtraces in commits, they're rather verbose
and don't add that much - relevant bits are good but the whole thing can
be excessive.

--Hlh2aiwFLCZwGcpw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUgOSQAAoJECTWi3JdVIfQYw8H/3EMjALICauAB9/I/nZfyTQP
FgMly+sJPu2Y1jwSY4nEJ7D/DE9sB6yMB6kJUMp4HRFMioLa1y5/TFBTM7D5T9d5
mXqdQfzRBa1Dj+ZLzLrYwUaE3I6BKwKfS8Mvcei35nWvXPQZ05hLaGe5BYiJutJ/
fWQUuO1Wz408O0DhZcgaZDnRonJr4dBC9BOBJHPqytEiL5n+BzaGKA9KmC0xBEis
U3vdvhDT7sDgM9fxLs766xNWNT4DMGk9S9B4BtuUJKli0ySgCq+xtxGr+qXhWmX1
aKilvF4YENH721IeNXV0e0Dnc1GBOLQz1sB6zj8Nv2t2ZgtWjLvpDUbLpFXPZC8=
=0z3U
-----END PGP SIGNATURE-----

--Hlh2aiwFLCZwGcpw--

--===============4053794418993158233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4053794418993158233==--
