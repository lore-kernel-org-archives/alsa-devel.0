From: Joachim =?ISO-8859-1?Q?F=F6rster?= <mls.JOFT@gmx.de>
Subject: ALSA always writes _whole_ periods, right?
Date: Wed, 13 Jun 2007 18:23:38 +0200
Message-ID: <1181751818.5752.13.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2595423178214930337=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 11AD6103864
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jun 2007 18:23:42 +0200 (CEST)
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


--===============2595423178214930337==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YA6srMpFICh3+8KbIRDk"


--=-YA6srMpFICh3+8KbIRDk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi ALSA devs,

I have a quick question regarding the filling of the usual ring buffer
in RAM (used by sound controllers via DMA), just to be really sure:

Is it true, that ALSA always writes (via mmap'ing) _whole_ periods?

I took snd-dummy and modified it to use "ack()" method and tried to
confirm, if the above is true _without_ memory mapping (classical
read/write). It seem's to be true, ALSA is "filling up" the last (not
always complete) period - e.g. if the played wav file is not a multiple
of periodsize in length.
But well, with mmap, I cannot see the copying action (done by ALSA
library, right?) ... so, thus my question ;-) .

Thanks,
 Joachim


--=-YA6srMpFICh3+8KbIRDk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBGcBoKZY86bR8HqNwRAsZ+AJ9bd1a0QH9NKnYnaJL5hn3jh1QaAwCfTQ7g
u43kfMr6EhZ+ku3av20TUIA=
=f7S9
-----END PGP SIGNATURE-----

--=-YA6srMpFICh3+8KbIRDk--


--===============2595423178214930337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2595423178214930337==--
