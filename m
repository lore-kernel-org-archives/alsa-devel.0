From: Kip Warner <kip@thevertigo.com>
Subject: Re: Patch for ALC882
Date: Mon, 21 Jan 2008 11:51:13 -0800
Message-ID: <1200945073.9440.3.camel@kip-laptop>
References: <1200361715.6964.12.camel@kip-laptop>
	<s5hsl0z2ybq.wl%tiwai@suse.de> <1200434828.8884.1.camel@kip-laptop>
	<s5htzleug4z.wl%tiwai@suse.de> <1200625227.7715.20.camel@kip-laptop>
	<s5hk5m78w2y.wl%tiwai@suse.de> <1200639924.7715.31.camel@kip-laptop>
	<s5hprvzcv2m.wl%tiwai@suse.de> <1200881047.6980.25.camel@kip-laptop>
	<s5hve5ne849.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3639652923747626677=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from defout.telus.net (defout.telus.net [199.185.220.240])
	by alsa0.perex.cz (Postfix) with ESMTP id B32F82480B
	for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2008 20:51:19 +0100 (CET)
In-Reply-To: <s5hve5ne849.wl%tiwai@suse.de>
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
Cc: pshou@realtek.com.tw, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3639652923747626677==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uKHrsdRTOJbJJVVWDaKD"


--=-uKHrsdRTOJbJJVVWDaKD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-01-21 at 12:22 +0100, Takashi Iwai wrote:
> Hm, so do you mean that the HG version works as is even without the
> patch above?  To be sure, try to reboot in both cases.
>=20
>=20
> Takashi

Granted I didn't reboot, but I am pretty confident that I had rmmod'd
the old driver, /etc/init.d/alsasound stop, sudo make install, cp module
to new ubuntu modules location (not sure why they have their modules in
a different location - but they do).

--=20
Kip Warner -- Software Engineer
OpenPGP encrypted/signed mail preferred
http://www.thevertigo.com

--=-uKHrsdRTOJbJJVVWDaKD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHlPexC5QMQlLfBOsRAreiAJ9tCV60tHs6lHRH9u/aq2bpGJ+DIwCeOhZo
pAM3xqF/3Rrzw17/hVaMiPI=
=C070
-----END PGP SIGNATURE-----

--=-uKHrsdRTOJbJJVVWDaKD--


--===============3639652923747626677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3639652923747626677==--
