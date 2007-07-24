From: Jan Zuchhold <Jan@zuchhold.com>
Subject: Re: YMFPCI: IEC958 volume does not work anymore
	(2.6.18->2.6.21)
Date: Tue, 24 Jul 2007 20:41:31 +0200
Message-ID: <200707242041.39538.Jan@zuchhold.com>
References: <200707200922.48147.Jan@zuchhold.com>
	<1185206160.23070.1201588859@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1789912118567679133=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.dmz.labffm.de (ad96e004c.dsl.de.colt.net [217.110.0.76])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E2A61038BB
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Jul 2007 20:41:41 +0200 (CEST)
Received: from localhost (smtp.dmz.labffm.de [192.168.10.73])
	by smtp.dmz.labffm.de (Postfix) with ESMTP id C9913179E7
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Jul 2007 20:41:40 +0200 (CEST)
Received: from smtp.dmz.labffm.de ([192.168.10.73])
	by localhost (smtp [192.168.10.73]) (amavisd-new, port 10024)
	with ESMTP id 08887-03 for <alsa-devel@alsa-project.org>;
	Tue, 24 Jul 2007 20:41:40 +0200 (CEST)
Received: from echo.ke.zuchhold.de (unknown [192.168.10.34])
	by smtp.dmz.labffm.de (Postfix) with ESMTP id 8F10716907
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Jul 2007 20:41:40 +0200 (CEST)
In-Reply-To: <1185206160.23070.1201588859@webmail.messagingengine.com>
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

--===============1789912118567679133==
Content-Type: multipart/signed;
  boundary="nextPart3890747.yVzOn0c0gs";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3890747.yVzOn0c0gs
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

> > i'm using a Hoontech Soundtrack Digital-XG (YMF744) and after i've
> > upgraded to kernel 2.6.21, i can't control the IEC958 volume (using "Wa=
ve
> > volume") any longer.
>
> This happens only for 44.1 kHz data.
>
> Try the attached patch.

great, it's working!

Could you please mail me a way to reward you (Paypal account? Amazon wishli=
st=20
etc?)?

Thank you,
Jan

--nextPart3890747.yVzOn0c0gs
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGpkfhQ65WEO0u/U4RAhP1AKDBQ28E627IgefYlY+NoHoc/sMPUACfeVe9
bpCHjgoRwzzPy99hR1foTuM=
=59VS
-----END PGP SIGNATURE-----

--nextPart3890747.yVzOn0c0gs--

--===============1789912118567679133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1789912118567679133==--
