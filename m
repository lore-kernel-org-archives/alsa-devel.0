From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: Remove 'const' from the
	device_node pointers
Date: Tue, 25 Nov 2014 13:13:51 +0000
Message-ID: <20141125131351.GC7712@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4192869409827974951=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D8BC265756
 for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2014 14:16:06 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Russell King <linux@arm.linux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============4192869409827974951==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cmojth4sdaU3VRJa"
Content-Disposition: inline


--cmojth4sdaU3VRJa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2014 at 12:14:48PM +0100, Jean-Francois Moine wrote:
> As Russell King's explained it, there should not be pointers to
> struct device_node:
>=20
> "struct device_node is a ref-counted structure.  That means if you
>  store a reference to it, you should "get" it, and you should "put"
>  it once you've done.  The act of "put"ing the pointed-to structure
>  involves writing to that structure, so it is totally unappropriate
>  to store a device_node structure as a const pointer.  It forces you
>  to have to cast it back to a non-const pointer at various points
>  in time to use various OF function calls."

So, we're not holding references here (we're just doing comparisons, the
references need to be owned before we get into the core) and I'm not
seeing anything here removing casts?

--cmojth4sdaU3VRJa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdICOAAoJECTWi3JdVIfQcggH/jVqi1O/AWH3tQmTsDEkFXT4
et8yGx03au/zpgWbEr+UFD5jFLTep1StgnZD5kgAmpzierEAkxbYf0/GJ68QKSzl
8zZgniyrhHsZosYwfId9d8hk0OuXLEAtX2U9F4LjPrTKOjebd/vzzaTmloaBVfXI
DlZmVYv2U3qaxDhD5tnG0qClG3ae86cSkZLKu99F4ktSmKPex5PCVn3bR/y1vwgP
2uc+n1q27Va9NF2fS3E3IJxdtJbvv1itlpTcNE7F6Z+8ydtUX3pbbSCYQbEA5Uud
V1vlEzZZvrkINEQArmho90MZPzs5ba13o/t2Bd96Rvss5vURvQSQQ10pB6BZjgQ=
=Hdvy
-----END PGP SIGNATURE-----

--cmojth4sdaU3VRJa--

--===============4192869409827974951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4192869409827974951==--
