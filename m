From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Re: Undefined Symbols: snd-aoa-codec-tas.c:944
	warning: implicit	declaration of function 'of_get_property'
Date: Sat, 12 May 2007 23:59:37 +0200
Message-ID: <20070512215937.GA22641@frodo.home.lxtec.de>
References: <20070511201459.GA28331@frodo.home.lxtec.de>
	<1178914848.31156.2.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1748706953026678799=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpout.hostsharing.net (smtpout.hostsharing.net [83.223.95.15])
	by alsa0.perex.cz (Postfix) with ESMTP id AED7B245E4
	for <alsa-devel@alsa-project.org>;
	Sat, 12 May 2007 23:59:42 +0200 (CEST)
In-Reply-To: <1178914848.31156.2.camel@johannes.berg>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============1748706953026678799==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 11 May 2007 the mental interface of
Johannes Berg told:

> On Fri, 2007-05-11 at 22:14 +0200, Elimar Riesebieter wrote:
>=20
> > the aoa drivers in 1.0.14rc4 are not usable. Compiling the modules
> > there are much warnings "implicit declaration of function
> > 'of_get_property'" Loading the module dmesg tells: snd_aoa: Unknown
> > symbol of_get_property. rc3 out of 2.6.21 works fine.
>=20
> You probably need a more current kernel to run that against, the
> of_get_property things were changed to be shared between powerpc and
> sparc iirc. ISTR that of_get_property is now a macro for something else
> but I haven't checked.

Hmm, we want to run the alsa-drivers on distributed kernels as well
i.e. the Debian one.

Isn't 2.6.2(0|1) hot enough?

Elimar


--=20
  Never make anything simple and efficient when a way=20
  can be found to make it complex and wonderful ;-)

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD4DBQFGRjjJ3Ig8bsVPf7ARAlKSAJ0Rc13CzaOVKzDq9n2rPe1GRy8KgwCYo1qy
aDqy8MaEQkothXbVxT8lsQ==
=HmsX
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--

--===============1748706953026678799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1748706953026678799==--
