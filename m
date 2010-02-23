From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: [PATCH] ALSA: hda - Refer to macmini3 channel mode
 functions
Date: Tue, 23 Feb 2010 11:34:31 +0100
Message-ID: <1266921271.3710.41.camel@mattotaupa>
References: <1266902758-16160-1-git-send-email-themuso@ubuntu.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3775143235702525059=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id D49EF1038D8
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 11:34:32 +0100 (CET)
Received: from f053034224.adsl.alicedsl.de ([78.53.34.224]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1Njs64-00069t-HS
	for alsa-devel@alsa-project.org; Tue, 23 Feb 2010 10:34:32 +0000
In-Reply-To: <1266902758-16160-1-git-send-email-themuso@ubuntu.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3775143235702525059==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-PA6+22CalDTeWX2KV/+k"


--=-PA6+22CalDTeWX2KV/+k
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Dienstag, den 23.02.2010, 16:25 +1100 schrieb Luke Yelavich:
> From: Luke Yelavich <luke.yelavich@canonical.com>
>=20
> Refer to alc885_macmini3_{2,6}ch_mode_init functions instead of those for=
 the
> mb5 model quirk. While they are the functino contents are the same now, t=
hings

While the functions are the same now, =E2=80=A6

> may change later. This also gets rid of compiler warnings about initializ=
ed,
> but unused functions.
>=20
> Signed-off-by: Luke Yelavich <luke.yelavich@canonical.com>

Maybe you can send a v2 patch (see `--subject-prefix` in `git help
format-patch` or edit manually) and CC the maintainers (for example
`--cc`) [2] as documented in [1]. At least I was told so [3] and I think
you patch will be taken care off earlier when doing so.


Thanks,

Paul


[1] http://git.kernel.org/?p=3Dlinux/kernel/git/tiwai/sound-2.6.git;a=3Dblo=
b;f=3DDocumentation/SubmittingPatches
[2] http://git.kernel.org/?p=3Dlinux/kernel/git/tiwai/sound-2.6.git;a=3Dblo=
b;f=3DMAINTAINERS
[3] http://www.spinics.net/lists/alsa-devel/msg31371.html

--=-PA6+22CalDTeWX2KV/+k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkuDrzYACgkQPX1aK2wOHVhlEACcDJ8u62oqQ1RMCqGJGGC3Y36Q
9kIAn1rwqeI/CNNGIMktT7DH3FCK9qli
=x9G8
-----END PGP SIGNATURE-----

--=-PA6+22CalDTeWX2KV/+k--


--===============3775143235702525059==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3775143235702525059==--
