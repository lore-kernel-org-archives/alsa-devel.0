From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Undefined Symbols: snd-aoa-codec-tas.c:944
	warning: implicit	declaration of function 'of_get_property'
Date: Fri, 11 May 2007 22:20:47 +0200
Message-ID: <1178914848.31156.2.camel@johannes.berg>
References: <20070511201459.GA28331@frodo.home.lxtec.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5429205098381705184=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa0.perex.cz (Postfix) with ESMTP id 45C2C244AF
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2007 22:18:20 +0200 (CEST)
In-Reply-To: <20070511201459.GA28331@frodo.home.lxtec.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Elimar Riesebieter <riesebie@lxtec.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============5429205098381705184==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-TFD0RSSkrjJx3vOjb263"


--=-TFD0RSSkrjJx3vOjb263
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-05-11 at 22:14 +0200, Elimar Riesebieter wrote:

> the aoa drivers in 1.0.14rc4 are not usable. Compiling the modules
> there are much warnings "implicit declaration of function
> 'of_get_property'" Loading the module dmesg tells: snd_aoa: Unknown
> symbol of_get_property. rc3 out of 2.6.21 works fine.

You probably need a more current kernel to run that against, the
of_get_property things were changed to be shared between powerpc and
sparc iirc. ISTR that of_get_property is now a macro for something else
but I haven't checked.

johannes

--=-TFD0RSSkrjJx3vOjb263
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGRNAf/ETPhpq3jKURAqgfAJ9vu3ZhXMmwMMOCNYOX7P3vhqXKAwCgoQom
UJg0mYQuLrtbjsa8S3+cDMA=
=03gp
-----END PGP SIGNATURE-----

--=-TFD0RSSkrjJx3vOjb263--


--===============5429205098381705184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5429205098381705184==--
