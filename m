From: Pierre Ossman <drzeus@drzeus.cx>
Subject: Re: looping S/PDIF data
Date: Fri, 20 Jun 2008 21:45:16 +0200
Message-ID: <20080620214516.28e9d3f3@mjolnir.drzeus.cx>
References: <20080531112606.5884a1c9@mjolnir.drzeus.cx>
	<20080617215504.3203a5ed@mjolnir.drzeus.cx>
	<4858B84B.4030800@keyaccess.nl> <s5hej6t91u1.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0806191435270.1798@tm8103-a.perex-int.cz>
	<s5hskv97fqk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0305366610059625517=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.drzeus.cx (server.drzeus.cx [85.8.24.28])
	by alsa0.perex.cz (Postfix) with ESMTP id 21F441038A8
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Jun 2008 21:45:25 +0200 (CEST)
In-Reply-To: <s5hskv97fqk.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, Rene Herman <rene.herman@keyaccess.nl>, ALSA devel <alsa-devel@alsa-project.org>, mulix@mulix.org
List-Id: alsa-devel@alsa-project.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--===============0305366610059625517==
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=PGP-SHA1; boundary="=_freyr.drzeus.cx-31735-1213990619-0001-2"

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.drzeus.cx-31735-1213990619-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Jun 2008 14:48:19 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Thu, 19 Jun 2008 14:39:05 +0200 (CEST),
> Jaroslav Kysela wrote:
> >=20
> > I don't think that this patch is correct. DMA transfers should be disab=
led=20
> > by:
> >=20
> > outl(what, TRID_REG(trident, T4D_STOP_B));
> > outl(val, TRID_REG(trident, T4D_AINTEN_B));
>=20
> They are already in the trigger callback as long as I saw the code
> quickly.  So the problem should be somewhere else.
>=20
> > lines. Adding &=3D ~SPDIF_EN can disable output from AC97 to S/PDIF as =
well.
>=20
> That's true.
>=20
> Anyway, if you are up now, I'll let you hunt further as you are the
> author of the driver :)
>=20

Are there any specs on this hardware? I could play around a bit myself,
but I can't really find any documentation on the registers.

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Use end-to-end encryption where
  possible.

--=_freyr.drzeus.cx-31735-1213990619-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkhcCNEACgkQ7b8eESbyJLjU0gCgocuIi2CrpHuOG8QDt+DIo0Pd
uqMAoO8rnZa8wfC9Tyh6O0TqtWCKbAW4
=D7TV
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-31735-1213990619-0001-2--

--===============0305366610059625517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0305366610059625517==--
