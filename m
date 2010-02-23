From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: [PATCH] usb/gadget/{f_audio,
 gmidi}.c: follow recent changes in audio.h
Date: Tue, 23 Feb 2010 11:14:51 +0100
Message-ID: <1266920091.3710.29.camel@mattotaupa>
References: <20100223082634.GR28972@buzzloop.caiaq.de>
	<1266917400-26397-1-git-send-email-daniel@caiaq.de>
	<s5hocjg1dqm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7345486425875426907=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A7EB1038C2
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 11:14:57 +0100 (CET)
Received: from f053034224.adsl.alicedsl.de ([78.53.34.224]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1Njrn5-0003lH-Fj
	for alsa-devel@alsa-project.org; Tue, 23 Feb 2010 10:14:55 +0000
In-Reply-To: <s5hocjg1dqm.wl%tiwai@suse.de>
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


--===============7345486425875426907==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-DYt+dTRcGTqQOtuSbWYG"


--=-DYt+dTRcGTqQOtuSbWYG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Dienstag, den 23.02.2010, 10:51 +0100 schrieb Takashi Iwai:
> At Tue, 23 Feb 2010 10:30:00 +0100,
> Daniel Mack wrote:
> >=20
> > Some structs in linux/usb/audio.h have got new names to mark them as
> > part of version 1.0 of the USB audio standard. Follow these changes
> > in the gadget drivers.
> >=20
> > Not that this header and the ALSA USB driver will undergo some

s/Not/Note/

[=E2=80=A6]

> Yep, now applied to topic/usb-v2.0 branch of sound git tree.
>=20
> If anyone has no objection, I'll merge this branch today for
> linux-next.

Sorry for this nit-picking, but I think this typo makes everyone to read
this paragraph twice.


Thanks,

Paul

--=-DYt+dTRcGTqQOtuSbWYG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkuDqpsACgkQPX1aK2wOHVj2kQCfb6FFMe9SNJzN10r+E6oqfuCy
slAAnRPH+hhdlWfOMV2Pr7CJ6i08YV2x
=uz5c
-----END PGP SIGNATURE-----

--=-DYt+dTRcGTqQOtuSbWYG--


--===============7345486425875426907==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7345486425875426907==--
