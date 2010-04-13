From: Luca Bruno <lucab@debian.org>
Subject: Re: [PATCH] ALSA: hda - Add quirk and model 'vaio' for
 ALC269-based Sony Vaio E Series
Date: Tue, 13 Apr 2010 07:58:57 +0200
Message-ID: <20100413075857.b4b75893.lucab@debian.org>
References: <1270216442-5632-1-git-send-email-lucab@debian.org>
	<s5hiq87h5j7.wl%tiwai@suse.de>
	<20100404133802.25104e02.lucab@debian.org>
	<s5haatigt0t.wl%tiwai@suse.de>
	<20100406122136.c38ce959.lucab@debian.org>
	<s5heiis7u16.wl%tiwai@suse.de>
	<20100406144706.8d12c144.lucab@debian.org>
	<s5h1ves64c0.wl%tiwai@suse.de>
	<20100410203530.1fc8fde8.lucab@debian.org>
	<s5h8w8tb150.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8378643710793644691=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.unstable.it (host-93-93-202-11.planetacomnetwork.com
	[93.93.202.11]) by alsa0.perex.cz (Postfix) with ESMTP id D5AEC1037F8
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Apr 2010 07:59:03 +0200 (CEST)
Received: from localhost (213-156-35-243.ip.fastwebnet.it [213.156.35.243])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.unstable.it (Postfix) with ESMTPSA id 6CD02120070
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Apr 2010 07:59:44 +0200 (CEST)
In-Reply-To: <s5h8w8tb150.wl%tiwai@suse.de>
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

--===============8378643710793644691==
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__13_Apr_2010_07_58_57_+0200_LQqwzJVoK_DgG3GY"

--Signature=_Tue__13_Apr_2010_07_58_57_+0200_LQqwzJVoK_DgG3GY
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Takashi Iwai scrisse:

> > Tried latest of both, yet no luck out-of-the-box.
> > Still have to apply the quirk-patch or manually change via hda-verb
> > each time to have a working sound output.=20
>=20
> OK, could you try the patch below?

Fine, it worked perfectly. Thanks a lot.

Ciao, Luca

--=20
 .''`.  ** Debian GNU/Linux **  | Luca Bruno (kaeso)
: :'  :   The Universal O.S.    | lucab (AT) debian.org
`. `'`  			| GPG Key ID: 3BFB9FB3
  `-     http://www.debian.org 	| Debian GNU/Linux Developer

--Signature=_Tue__13_Apr_2010_07_58_57_+0200_LQqwzJVoK_DgG3GY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkvECCEACgkQRqobajv7n7PJpQCfforb4SHxVkziraoOFuRqc4px
FOUAn11cH2Zoov1H9+py4Nr+EPUKsXp5
=EktT
-----END PGP SIGNATURE-----

--Signature=_Tue__13_Apr_2010_07_58_57_+0200_LQqwzJVoK_DgG3GY--

--===============8378643710793644691==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8378643710793644691==--
