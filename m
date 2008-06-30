From: Pierre Ossman <drzeus@drzeus.cx>
Subject: Re: looping S/PDIF data
Date: Mon, 30 Jun 2008 21:22:32 +0200
Message-ID: <20080630212232.15b379cf@mjolnir.drzeus.cx>
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
	<20080630191133.7f7c349d@mjolnir.drzeus.cx>
	<48692415.3070204@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0032462219545066391=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.drzeus.cx (server.drzeus.cx [85.8.24.28])
	by alsa0.perex.cz (Postfix) with ESMTP id 4669124736
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Jun 2008 21:22:39 +0200 (CEST)
In-Reply-To: <48692415.3070204@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>, mulix@mulix.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--===============0032462219545066391==
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=PGP-SHA1; boundary="=_freyr.drzeus.cx-10645-1214853122-0001-2"

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.drzeus.cx-10645-1214853122-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 30 Jun 2008 20:21:09 +0200
Rene Herman <rene.herman@keyaccess.nl> wrote:

>=20
> Your fix is commit f19a62ecba9d0963cee2b673f0ad34917b5e57ad in the=20
> "sound-2.6" git repo (Takashi Iwai's tree), branch "master", at
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
>=20
> also viewable at:
>=20
> http://git.kernel.org/?p=3Dlinux/kernel/git/tiwai/sound-2.6.git;a=3Dcommi=
t;h=3Df19a62ecba9d0963cee2b673f0ad34917b5e57ad
>=20
> That commit is pre the 1.0.17-rc3 release/tag so it's in. Will find its=20
> way into the kernel during the next merge window no doubt...
>=20

Delightful. :)

Now I just need to poke my vendor of choice to backport it aswell...

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.drzeus.cx-10645-1214853122-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkhpMn0ACgkQ7b8eESbyJLi+DgCeJzk+uslCvmqO5kbPCBjVPu2K
6CcAoLiYvvp8crPV5Hm9EbyrPQgQz/12
=W2Ka
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-10645-1214853122-0001-2--

--===============0032462219545066391==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0032462219545066391==--
