From: Mark Brown <broonie@kernel.org>
Subject: Re: RFC: support for 12 & 24Khz
Date: Thu, 25 Jul 2013 20:36:44 +0100
Message-ID: <20130725193643.GT9858@sirena.org.uk>
References: <20130724172640.GE18642@intel.com> <51F0CAC0.9090702@ladisch.de>
 <20130725154501.GN18642@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7454481208429747692=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A0D926109B
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2013 21:36:53 +0200 (CEST)
In-Reply-To: <20130725154501.GN18642@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, pierre-louis.bossart@linux.jf.intel.com, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org


--===============7454481208429747692==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ivrUthVTr0Ce7KDI"
Content-Disposition: inline


--ivrUthVTr0Ce7KDI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 25, 2013 at 09:15:01PM +0530, Vinod Koul wrote:
> On Thu, Jul 25, 2013 at 08:50:40AM +0200, Clemens Ladisch wrote:

> > > For compressed audio we also need to support the PCM rates of 12 and 24KHz.

> > > Looking at pcm.h these are not defined

> > You don't need such symbols to use a rate.  These symbols are intended
> > for often-used rates.  As long as only one or two drivers use a rate,
> > they can just set KNOT and install a constraint.

> okay so how exactly is the rate passed to driver and converted and sent to
> drivers?

Having said that 24kHz sounds awfully familiar...

--ivrUthVTr0Ce7KDI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR8X5IAAoJELSic+t+oim9pfsQAJ4PP340T3qdcoot3n+9oVMY
Hc2ijriotlHj/DDVKztgHwmHdM2NbMEgUutOgh2c6G1ylbqb5MSd539gIwI9087u
eveiG5cfFX5zYmybt2GjvMI9ljmimBRbv6ooajcxNh6D1lsRc5wQOdawvTFemBv+
mTLBlo338zAGKp7ug6Jul8Es6GaviBmzOJX6AGg+SKC4SPpTeeNgJNMVEM02AXuR
H5wHWgPYbnjZFe8GTwUxtVVQ7xXv/g4IxJr/WgUeT2hMi34YPwZqpVkTsHtubT6T
xFDwb+w0z3ksi245MMKuaJKEi6xfCAWYTDyiCYha6TgLjFPjPOn2M3FOLHyDTcCU
90bR24SrH4yIB4zpPpdWbLzv6AYV7DU/bnjWJ2aXpKLsDPnfuuTREFEkUaepLiGr
7Vz2TQg7B4OA1jR+wR1WQ4b4kFl0Bjh2FH/8hshVxpA0WCJhjsx9LqWZ/YwQoK85
TL/UbmJdUGvv8xW75D3GeODIuK7rpL7ZhhaAHmurOMsG6AHPO7Oq/kVHx3EaGxrK
OFVyT2TwEJJcQ2BTg5mIylUBtjD+e8Y5EtAoi7VqitJeu/g1EUk4DYJ/UJnBYTB1
OAYeqsYEvc3g85PGnWN0mW91l2De6r4p6V1dSYzHWmV7Uc38lMv9rwWEvYx2vC07
Xwf6Tsvd8QwOWX/i0gPk
=cXYC
-----END PGP SIGNATURE-----

--ivrUthVTr0Ce7KDI--

--===============7454481208429747692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7454481208429747692==--
