From: Luca Bruno <lucab@debian.org>
Subject: Re: [PATCH] ALSA: hda - Add quirk and model 'vaio' for
 ALC269-based Sony Vaio E Series
Date: Sat, 10 Apr 2010 20:35:30 +0200
Message-ID: <20100410203530.1fc8fde8.lucab@debian.org>
References: <1270216442-5632-1-git-send-email-lucab@debian.org>
	<s5hiq87h5j7.wl%tiwai@suse.de>
	<20100404133802.25104e02.lucab@debian.org>
	<s5haatigt0t.wl%tiwai@suse.de>
	<20100406122136.c38ce959.lucab@debian.org>
	<s5heiis7u16.wl%tiwai@suse.de>
	<20100406144706.8d12c144.lucab@debian.org>
	<s5h1ves64c0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4247149995668954906=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.unstable.it (host-93-93-202-11.planetacomnetwork.com
	[93.93.202.11]) by alsa0.perex.cz (Postfix) with ESMTP id C1F851037F9
	for <alsa-devel@alsa-project.org>;
	Sat, 10 Apr 2010 20:35:34 +0200 (CEST)
In-Reply-To: <s5h1ves64c0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============4247149995668954906==
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sat__10_Apr_2010_20_35_30_+0200_Wy.EaCWjiJmZt0Yj"

--Signature=_Sat__10_Apr_2010_20_35_30_+0200_Wy.EaCWjiJmZt0Yj
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Takashi Iwai scrisse:

> Do you mean setting the pinctl 0x22 (PIN_VREFGRD) to NID 0x19?

Yes. It was mentioned that PIN_VREFHIZ works too.

> Changing this via hda-verb with model=3Dauto state also fixes the issue?

Yes, that's how the quirk-patch came out (I've zero knowledge of
sound/alsa development, I was just asked to cook a patch based on that
suggestion, as nobody was doing it).
=20
> For the kernel, try:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git=20
> For alsa-driver snapshot, try:
>   ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver=
-snapshot.tar.gz

Tried latest of both, yet no luck out-of-the-box.
Still have to apply the quirk-patch or manually change via hda-verb
each time to have a working sound output.=20

Ciao, Luca

--=20
 .''`.  ** Debian GNU/Linux **  | Luca Bruno (kaeso)
: :'  :   The Universal O.S.    | lucab (AT) debian.org
`. `'`  			| GPG Key ID: 3BFB9FB3
  `-     http://www.debian.org 	| Debian GNU/Linux Developer

--Signature=_Sat__10_Apr_2010_20_35_30_+0200_Wy.EaCWjiJmZt0Yj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkvAxPIACgkQRqobajv7n7NcOACgrERX+sUOLIF0s7x5hNO1Vnh4
sucAnR0tgvWclMYFqqENwF0I4O1+ShzS
=LlLa
-----END PGP SIGNATURE-----

--Signature=_Sat__10_Apr_2010_20_35_30_+0200_Wy.EaCWjiJmZt0Yj--

--===============4247149995668954906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4247149995668954906==--
