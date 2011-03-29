From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: Problems with snd_hda_intel in Linux kernel 2.6.38
Date: Tue, 29 Mar 2011 13:10:34 +0200
Message-ID: <1301397034.15348.33.camel@mattotaupa>
References: <1301394280.3906.29.camel@s1499.it.kth.se>
	<s5haage43qz.wl%tiwai@suse.de>
	<1301396296.32453.1.camel@s1499.it.kth.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7206751095771984092=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 74798243D5
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Mar 2011 13:10:36 +0200 (CEST)
Received: from f053045115.adsl.alicedsl.de ([78.53.45.115]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1Q4Wom-0001Tf-4r
	for alsa-devel@alsa-project.org; Tue, 29 Mar 2011 11:10:36 +0000
In-Reply-To: <1301396296.32453.1.camel@s1499.it.kth.se>
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


--===============7206751095771984092==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-s8XAXKHg6JKO864XeKXL"


--=-s8XAXKHg6JKO864XeKXL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Dienstag, den 29.03.2011, 12:58 +0200 schrieb Svante Signell:
> On Tue, 2011-03-29 at 12:31 +0200, Takashi Iwai wrote:
> > At Tue, 29 Mar 2011 12:24:40 +0200, Svante Signell wrote:
> > >=20
> > > > This problem was also reported as Debian bug #613979, as kernel tic=
ket
> > > >=20
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=3D30552
> >=20
> > Did you look at this?
>=20
> Yes I did. So you recommend me to compile a new kernel?

Yes, with the ALSA source from Linux kernel 2.6.32.

> > Also, please try to decode the line from the code shown in the Oops.
> > It's a bit too little information to analyze, unfortunately.
>=20
> I know there is little information, but the computer hangs during boot
> as shown in the bug report and the information there is copied manually
> during the timeout period. Then everything is blanked out since the boot
> continues. Any ideas?

I got these messages from `dmesg` or `/var/log/syslog`.


Thanks,

Paul

--=-s8XAXKHg6JKO864XeKXL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk2RvioACgkQPX1aK2wOHVgnLQCeO6uGqkXygdbK5JXUjZ9H4j9u
GC8AoIb+kmnOdH+6ZZdOiRlCT//d5O1b
=NlT3
-----END PGP SIGNATURE-----

--=-s8XAXKHg6JKO864XeKXL--


--===============7206751095771984092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7206751095771984092==--
