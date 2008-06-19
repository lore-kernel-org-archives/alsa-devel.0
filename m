From: Pierre Ossman <drzeus@drzeus.cx>
Subject: Re: looping S/PDIF data
Date: Fri, 20 Jun 2008 01:02:14 +0200
Message-ID: <20080620010214.2185225e@mjolnir.drzeus.cx>
References: <20080531112606.5884a1c9@mjolnir.drzeus.cx>
	<20080617215504.3203a5ed@mjolnir.drzeus.cx>
	<4858B84B.4030800@keyaccess.nl> <s5hej6t91u1.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0806191435270.1798@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2944020893094890474=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.drzeus.cx (server.drzeus.cx [85.8.24.28])
	by alsa0.perex.cz (Postfix) with ESMTP id 759A2244B3
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Jun 2008 01:02:24 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.61.0806191435270.1798@tm8103-a.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>, Rene Herman <rene.herman@keyaccess.nl>, ALSA devel <alsa-devel@alsa-project.org>, mulix@mulix.org
List-Id: alsa-devel@alsa-project.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--===============2944020893094890474==
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=PGP-SHA1; boundary="=_freyr.drzeus.cx-21577-1213916048-0001-2"

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.drzeus.cx-21577-1213916048-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Jun 2008 14:39:05 +0200 (CEST)
Jaroslav Kysela <perex@perex.cz> wrote:

>=20
> I don't think that this patch is correct. DMA transfers should be disable=
d=20
> by:
>=20
> outl(what, TRID_REG(trident, T4D_STOP_B));
> outl(val, TRID_REG(trident, T4D_AINTEN_B));
>=20
> lines. Adding &=3D ~SPDIF_EN can disable output from AC97 to S/PDIF as we=
ll.
>=20

FWIW, the patch had zero effect on the system here.

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Use end-to-end encryption where
  possible.

--=_freyr.drzeus.cx-21577-1213916048-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkha5XsACgkQ7b8eESbyJLjGnwCgoKvMtl4xbSydjOXP5punXG3u
WOIAoJhw2GouT726EBx2kZXcSuJt0e+u
=imtr
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-21577-1213916048-0001-2--

--===============2944020893094890474==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2944020893094890474==--
