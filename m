From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: handling rate change on digital inputs?
Date: Wed, 31 May 2006 14:42:31 +0200
Message-ID: <1149079351.8877.23.camel@johannes>
References: <1148997314.4372.16.camel@johannes>
	<Pine.LNX.4.61.0605301559330.9178@tm8103.perex-int.cz>
	<1148998283.4372.18.camel@johannes>
	<Pine.LNX.4.61.0605311241550.9226@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1102430113=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 57BDAC8
	for <alsa-devel@alsa-project.org>;
	Wed, 31 May 2006 14:43:00 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.61.0605311241550.9226@tm8103.perex-int.cz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============1102430113==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-XwtGJ9xfDi6Z+2b4zSIk"


--=-XwtGJ9xfDi6Z+2b4zSIk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-05-31 at 12:43 +0200, Jaroslav Kysela wrote:
> > Do you know if there's any sample code for this somewhere? Or if any
> > drivers implement this properly?
>=20
> Check pdaudiocf_pcm.c and i2c/other/ak4117.c.

Thanks, I'll take a look.

johannes

--=-XwtGJ9xfDi6Z+2b4zSIk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARH2PNaVg1VMiehFYAQKcxg/+JQkeuwBKm+AQgHLx4HbPUtxDVUB4udNo
tTnZaNqBwYtKeKAYjfzsvwU+TmOLw6DbKvdq0manNMWKwpiWSomldH4WvI/WRpGT
N96o1Hbu7ggmK5OQMSBjfai9yWhn+OWcN8DqCMpIGQDsn2SI0o81WSvcSU4epabK
1fhDDfzUP78XR8BVpRAtJywrR0RFow2gr88XS0G+I8aq9FrHhGZRyKcjL0T8A1eV
KZQQ7tErTYMXrn0cMExvTbJllyXF4uQgFO1ZdN/63Ua2l0eLY6GyKy7xvurR1s0b
7/QbrNgTkTTUk9P3fe73qgFCpHeSDj7tsVO+IKMCpqKKyk1S0AncdaRf7949HSvL
+Nm3bSyxuFY+yJMhwHZsltcOqLFvbxKXzGKt5R2uVF45+nE6k2APg8WrfF0VCbxY
nsPlpLAS5V47QK36L4uXeM+0a6V8qLinU4mYSwKl0VH8eVUYpVZSHxahAB3nENW/
f72DYuvjf9gE2EGCOv2SGItrLnvEpZlMftMDotd73ud4CjuQaa9eGjeegunuMFkb
TAeN2JFza6Wm5WLHvy+o0Aqax8hn1xHQuiOKGE+Tx7DY05Q45R3zpFuc6ucjF+qw
c8qkI+PD+F/socLey++hvW3Xr85f6GXYacKZOPZrb1pADTp1qcHC/EYyYq1W29pI
LQ0KIbJpmUs=
=xPMP
-----END PGP SIGNATURE-----

--=-XwtGJ9xfDi6Z+2b4zSIk--



--===============1102430113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1102430113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1102430113==--
