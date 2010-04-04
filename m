From: Luca Bruno <lucab@debian.org>
Subject: Re: [PATCH] ALSA: hda - Add quirk and model 'vaio' for
 ALC269-based Sony Vaio E Series
Date: Sun, 4 Apr 2010 13:38:02 +0200
Message-ID: <20100404133802.25104e02.lucab@debian.org>
References: <1270216442-5632-1-git-send-email-lucab@debian.org>
	<s5hiq87h5j7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8117640615870424701=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.unstable.it (host-93-93-202-11.planetacomnetwork.com
	[93.93.202.11]) by alsa0.perex.cz (Postfix) with ESMTP id 630BF1037FB
	for <alsa-devel@alsa-project.org>;
	Sun,  4 Apr 2010 13:38:14 +0200 (CEST)
Received: from localhost (host252-192-dynamic.21-79-r.retail.telecomitalia.it
	[79.21.192.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.unstable.it (Postfix) with ESMTPSA id 4490B120070
	for <alsa-devel@alsa-project.org>;
	Sun,  4 Apr 2010 13:38:37 +0200 (CEST)
In-Reply-To: <s5hiq87h5j7.wl%tiwai@suse.de>
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

--===============8117640615870424701==
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sun__4_Apr_2010_13_38_02_+0200_EE5am5GDR8ov/F5e"

--Signature=_Sun__4_Apr_2010_13_38_02_+0200_EE5am5GDR8ov/F5e
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Takashi Iwai scrisse:

> > It fixes alsa-bugs #4941, #4934 and #4945
>
> Doesn't it work with model=3Dauto with the latest version?  I'm willing
> apply your quirk patch but I also would like to avoid unnecessary
> quirks as much as possible.
> Please give alsa-info.sh output, anyway, for further analysis.=20

It doesn't seem so.
You can find all the needed details attached to
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D4934

Cheers, Luca

--=20
 .''`.  ** Debian GNU/Linux **  | Luca Bruno (kaeso)
: :'  :   The Universal O.S.    | lucab (AT) debian.org
`. `'`  			| GPG Key ID: 3BFB9FB3
  `-     http://www.debian.org 	| Debian GNU/Linux Developer

--Signature=_Sun__4_Apr_2010_13_38_02_+0200_EE5am5GDR8ov/F5e
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAku4ehoACgkQRqobajv7n7MQrgCePhPfloA0OamKmYQs+Or2Yyz3
9wgAoJdP879gB5oNzhrdxYw6QmsWFndU
=UVwV
-----END PGP SIGNATURE-----

--Signature=_Sun__4_Apr_2010_13_38_02_+0200_EE5am5GDR8ov/F5e--

--===============8117640615870424701==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8117640615870424701==--
