From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: Problems with snd_hda_intel in Linux kernel 2.6.38
Date: Tue, 29 Mar 2011 13:09:00 +0200
Message-ID: <1301396940.15348.32.camel@mattotaupa>
References: <1301394280.3906.29.camel@s1499.it.kth.se>
	<s5haage43qz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6255822059654242326=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id CBF5F243D3
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Mar 2011 13:09:03 +0200 (CEST)
Received: from f053045115.adsl.alicedsl.de ([78.53.45.115]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1Q4WnG-0001Qs-6b
	for alsa-devel@alsa-project.org; Tue, 29 Mar 2011 11:09:02 +0000
In-Reply-To: <s5haage43qz.wl%tiwai@suse.de>
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


--===============6255822059654242326==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-lOzsBz0HHdkH0CKh3sfF"


--=-lOzsBz0HHdkH0CKh3sfF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Dienstag, den 29.03.2011, 12:31 +0200 schrieb Takashi Iwai:
> At Tue, 29 Mar 2011 12:24:40 +0200, Svante Signell wrote:
> >=20
> > > This problem was also reported as Debian bug #613979, as kernel ticke=
t
> > >=20
> > > https://bugzilla.kernel.org/show_bug.cgi?id=3D30552
>=20
> Did you look at this?
>=20
> Also, please try to decode the line from the code shown in the Oops.
> It's a bit too little information to analyze, unfortunately.

Unfortunately I have not yet had time to compile a Linux kernel 2.6.38,
where this problem is also present, with the ALSA source from 2.6.32.


Thanks,

Paul


PS: Svante, for the Debian BTS please always put the submitter into CC
because otherwise they do not get the message. To keep threading please
import the mbox file retrieved by `bts show --mbox #bugnumber`.

--=-lOzsBz0HHdkH0CKh3sfF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk2RvcwACgkQPX1aK2wOHVhASwCff7J5temByngQHtffyZBj7ycM
AxUAnj0CSOOhtSnUr8OjZ0TeqYpaCiUi
=ubqW
-----END PGP SIGNATURE-----

--=-lOzsBz0HHdkH0CKh3sfF--


--===============6255822059654242326==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6255822059654242326==--
