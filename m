From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: QEMU 0.14.0 and aplay: pcm_write:1603: write
 error: Input/output error
Date: Fri, 04 Mar 2011 13:11:11 +0100
Message-ID: <1299240671.4029.5.camel@mattotaupa>
References: <AANLkTimjLhXMU-urzL8jPSRNedUrCBWtCNagbe0B5gWp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1295653230008110220=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id DCA3424475
	for <alsa-devel@alsa-project.org>; Fri,  4 Mar 2011 13:11:14 +0100 (CET)
Received: from f053039171.adsl.alicedsl.de ([78.53.39.171]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1PvTqj-0003OT-5P
	for alsa-devel@alsa-project.org; Fri, 04 Mar 2011 12:11:13 +0000
In-Reply-To: <AANLkTimjLhXMU-urzL8jPSRNedUrCBWtCNagbe0B5gWp@mail.gmail.com>
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


--===============1295653230008110220==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-3rLGcqEhi/0wZUEzvdYX"


--=-3rLGcqEhi/0wZUEzvdYX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Asim,


Am Freitag, den 04.03.2011, 15:01 +0530 schrieb asim khan:

>    Iam using Qemu 0.14.0 and linux 2.6.33 but whenever Iam playing any wa=
v
> file with aplay Iam getting error
> *"aplay: pcm_write:1603: write error: Input/output error*"..donno whats
> going wrong..I googled but not much help...its bit urgent plz update me a=
s
> soon as possible.

sorry, I cannot help you. I think you should at least provide what is
written in the ALSA Wiki [1], i. e. at least attach the output of
`alsa-info.sh`.

I guess you should also try to ask people on the QEMU list and you could
also try to use more recent versions of the Linux kernel.


Thanks and good luck,

Paul


[1] http://alsa-project.org/main/index.php/Help_To_Debug

--=-3rLGcqEhi/0wZUEzvdYX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk1w1toACgkQPX1aK2wOHVix9QCfZu4vmz8eaQsJOPY1AUhVTC5S
+Q4An3SLEoIiJQD8uX0cExQqeLP3tRJX
=oCks
-----END PGP SIGNATURE-----

--=-3rLGcqEhi/0wZUEzvdYX--


--===============1295653230008110220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1295653230008110220==--
