From: Pierre Ossman <drzeus@drzeus.cx>
Subject: Re: looping S/PDIF data
Date: Mon, 30 Jun 2008 19:11:33 +0200
Message-ID: <20080630191133.7f7c349d@mjolnir.drzeus.cx>
References: <20080531112606.5884a1c9@mjolnir.drzeus.cx>
	<20080617215504.3203a5ed@mjolnir.drzeus.cx>
	<4858B84B.4030800@keyaccess.nl> <s5hej6t91u1.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0806191435270.1798@tm8103-a.perex-int.cz>
	<s5hskv97fqk.wl%tiwai@suse.de>
	<20080620214516.28e9d3f3@mjolnir.drzeus.cx>
	<485C0A97.7020909@keyaccess.nl>
	<20080621000050.43160d47@mjolnir.drzeus.cx>
	<485C2DF7.7080408@keyaccess.nl>
	<20080621010910.018f880d@mjolnir.drzeus.cx>
	<485CF0AE.3020204@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3343978620548301860=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.drzeus.cx (server.drzeus.cx [85.8.24.28])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E9DA2470D
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Jun 2008 19:11:42 +0200 (CEST)
In-Reply-To: <485CF0AE.3020204@keyaccess.nl>
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

--===============3343978620548301860==
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=PGP-SHA1; boundary="=_freyr.drzeus.cx-9717-1214845266-0001-2"

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.drzeus.cx-9717-1214845266-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 21 Jun 2008 14:14:38 +0200
Rene Herman <rene.herman@keyaccess.nl> wrote:

> On 21-06-08 01:09, Pierre Ossman wrote:
>=20
> > trident: pause s/pdif output
> >=20
> > Stop the S/PDIF DMA engine and output when the device is told to pause.
> > It will keep on looping the current buffer contents if this isn't done.
> >=20
> > Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
>=20
> Verified to fix the reported pause problem on a 4DWaveNX (and indeed to=20
> not affect a 4DWaveDX). The Trident SPDIF doesn't seem capable of 44100=20
> which for me means it's not all that useful but you no doubt know=20
> yourself that/if it is for you...
>=20
> Tested-by: Rene Herman <rene.herman@gmail.com>


Sooo.... ack? nak? limbo?

--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.drzeus.cx-9717-1214845266-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkhpE8sACgkQ7b8eESbyJLg17QCfXfHsi/d+P6UenxdmiLyAmBGw
OVEAmgLJq9jIFYpx+N/nXnk1iUbP7RUR
=GHVX
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-9717-1214845266-0001-2--

--===============3343978620548301860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3343978620548301860==--
