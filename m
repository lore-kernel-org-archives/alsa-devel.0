From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: A debug version of the ALSA lib?
Date: Fri, 02 Sep 2011 17:43:04 +0200
Message-ID: <1314978185.3526.44.camel@mattotaupa>
References: <4E5F4453.2586.49CC36@olivier.myriad-online.com>
	, <CACTFLANvcWLEAtPuobu3j+m2608fB5oF7A1sQu8DeXj5u=Zbyw@mail.gmail.com>
	, <1314960940.3526.27.camel@mattotaupa>
	<4E60C7A3.369.112627E@olivier.myriad-online.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8434693542080864653=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D12F244DB
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Sep 2011 17:43:07 +0200 (CEST)
In-Reply-To: <4E60C7A3.369.112627E@olivier.myriad-online.com>
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
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org


--===============8434693542080864653==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-7qcc+zXOyL5qJw4Xa7zu"


--=-7qcc+zXOyL5qJw4Xa7zu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Freitag, den 02.09.2011, 14:10 +0200 schrieb Olivier Guillion - Myriad:
> Daniel Mack, then Paul Menzel wrote:
> > > >> Or just use the binary Ubuntu packages and be done.
> > > >
> > > > Sorry, but what does it mean?
> > >=20
> > > That means that Ubuntu (as many other distros) offers you a
> > > ready-made, debug symbols enabled version of the library which you ca=
n
> > > just install and use. As you're struggeling with compiling the librar=
y
> > > youself, I'd suggest you go for this solution. In Ubuntu, the package
> > > you're looking for is called libasound2-dev.
> >=20
> > I have not followed the thread, but if you want debugging symbol you
> > need `libasound2-dbg`. (`aptitude search libasound*`)
>=20
> I installed the libasound2-dev package.=20
> I got mainly :
> - a bunch of C header files in /usr/include
> - libasound.a, libasound.la and libasound.so in /usr/lib
> (none of these libraries include the debugging symbols)
>=20
> I tried "aptitude search libasound*"
> and got:
> libasound-dev
> libasound2
> libasound2-dev
> libasound2-doc
> libasound2-plugin-equal
> libasound2-plugins
>=20
> but no libasound2-dbg.
> Any idea about where (and how) I can get it? (using Ubuntu 11.04)

I am using Debian Sid/unstable. Maybe David (put in CC) can say how to
do that in Ubuntu.


Thanks,

Paul

--=-7qcc+zXOyL5qJw4Xa7zu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk5g+YgACgkQPX1aK2wOHVg3IwCfYUnWfo8n8C2UMRxpspzOzfGD
VMEAnA++do7+/bmZXW/MqxprUHzyFBX8
=yjK2
-----END PGP SIGNATURE-----

--=-7qcc+zXOyL5qJw4Xa7zu--


--===============8434693542080864653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8434693542080864653==--
