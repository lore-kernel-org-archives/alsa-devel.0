From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: snd-hda-intel and parameter `patch` (was: OT: applying
	patches)
Date: Fri, 08 Apr 2011 12:27:23 +0200
Message-ID: <1302258443.7217.21.camel@mattotaupa>
References: <BANLkTim-aFLPMDOsoBG+ifynovDgT8LO3g@mail.gmail.com>
	<s5h8vvnrjea.wl%tiwai@suse.de>
	<BANLkTimfTLnPCt2e1gw7tdgpd=omBzbW6A@mail.gmail.com>
	<s5hy63nq12a.wl%tiwai@suse.de>
	<BANLkTinCh8+93jgcUrVP5J=u6XK3xbZOqg@mail.gmail.com>
	<s5htyeb9180.wl%tiwai@suse.de>
	<BANLkTikVQtpzCNX4W6MxAScMHzx_f6FAeA@mail.gmail.com>
	<BANLkTikhM1i8PK8HC9yN6d8yevx982CwGw@mail.gmail.com>
	<1302254931.7217.8.camel@mattotaupa>
	<BANLkTinG09ikc551jywWUFVdQBKXr4ywiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8451983872155957677=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C6E124372
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Apr 2011 12:27:26 +0200 (CEST)
Received: from f053045107.adsl.alicedsl.de ([78.53.45.107]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1Q88uW-0004I2-MX
	for alsa-devel@alsa-project.org; Fri, 08 Apr 2011 10:27:29 +0000
In-Reply-To: <BANLkTinG09ikc551jywWUFVdQBKXr4ywiQ@mail.gmail.com>
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


--===============8451983872155957677==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-OSPYPK70uNzQNqp6rXNb"


--=-OSPYPK70uNzQNqp6rXNb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Freitag, den 08.04.2011, 11:47 +0200 schrieb Valerio tesei:

[=E2=80=A6]

> I think i misunderstood something, I already know how to patch, I was
> thinking that "patch=3Dsomething" was a parameter that I need to pass to
> modprobe while loading snd-hda-intel.

	$ sudo modinfo snd-hda-intel
	$ sudo modinfo snd-hda-intel | grep patch
	parm:           patch:Patch file for Intel HD audio interface. (array of c=
harp)

But I do not know what you have to pass as an argument either.

I know that you can change the behavior by passing the parameter `model`
[3].


Thanks,

Paul


[3] http://alsa-project.org/main/index.php/Help_To_Debug_Intel_HDA

--=-OSPYPK70uNzQNqp6rXNb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk2e4wsACgkQPX1aK2wOHVgjFwCfTcxZtfZUFUogzWLSjMsqyK3/
UTMAnAjCH/hvA1S0rPpihJfWfe1+uqUB
=2vcj
-----END PGP SIGNATURE-----

--=-OSPYPK70uNzQNqp6rXNb--


--===============8451983872155957677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8451983872155957677==--
