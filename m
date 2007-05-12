From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Undefined Symbols: snd-aoa-codec-tas.c:944
	warning: implicit	declaration of function 'of_get_property'
Date: Sun, 13 May 2007 00:09:26 +0200
Message-ID: <1179007766.2647.22.camel@johannes.berg>
References: <20070511201459.GA28331@frodo.home.lxtec.de>
	<1178914848.31156.2.camel@johannes.berg>
	<20070512215937.GA22641@frodo.home.lxtec.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5747240160041265396=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B10E245D5
	for <alsa-devel@alsa-project.org>;
	Sun, 13 May 2007 00:09:22 +0200 (CEST)
In-Reply-To: <20070512215937.GA22641@frodo.home.lxtec.de>
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


--===============5747240160041265396==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4qjSmpt3xkYG2y5cSnNN"


--=-4qjSmpt3xkYG2y5cSnNN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2007-05-12 at 23:59 +0200, Elimar Riesebieter wrote:
> On Fri, 11 May 2007 the mental interface of

> Hmm, we want to run the alsa-drivers on distributed kernels as well
> i.e. the Debian one.
>=20
> Isn't 2.6.2(0|1) hot enough?

I don't know how alsa drivers 1.0.14rc4 are cut. If they get updates
from the kernel tree then they got the patches that went in there and
make it not work with older kernels, if they didn't then they won't work
with newer kernels... For the value of "older" meaning older than a
recent git snapshot :)

johannes

--=-4qjSmpt3xkYG2y5cSnNN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGRjsV/ETPhpq3jKURAn15AKCzx4lg/omyncr+dwU/XT/8RTNB9QCgnNgz
VCetYjPD60TbZfQXkltiZYQ=
=d7Dc
-----END PGP SIGNATURE-----

--=-4qjSmpt3xkYG2y5cSnNN--


--===============5747240160041265396==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5747240160041265396==--
