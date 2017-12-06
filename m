From: Mark Brown <broonie@kernel.org>
Subject: Re: Multiple codecs on the same DAI
Date: Wed, 6 Dec 2017 13:03:23 +0000
Message-ID: <20171206130323.GG1827@finisterre>
References: <alpine.DEB.2.11.1711231533480.27895@lnxricardw1.se.axis.com>
 <20171124123921.ajhxztwypujty6ps@sirena.org.uk>
 <alpine.DEB.2.11.1711241456420.27895@lnxricardw1.se.axis.com>
 <20171124180456.6c63tkph4e7ahuid@sirena.org.uk>
 <alpine.DEB.2.11.1712061352160.22247@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2192286405409027084=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7499B267923
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 14:03:27 +0100 (CET)
In-Reply-To: <alpine.DEB.2.11.1712061352160.22247@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2192286405409027084==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Wtrm9ATX0sn6fFKv"
Content-Disposition: inline


--Wtrm9ATX0sn6fFKv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2017 at 01:54:38PM +0100, Ricard Wanderlof wrote:

> How about non-sound devices, for instance if there is a chip solely for=
=20
> managing the microphone power but it's not actually part of the codec. Is=
=20
> it reasonable to bring it in as an aux device too, even though there's=20
> actually no sound going through it?

That just sounds like a regulator?  I'd expect that just to be used as a
supply as normal.  What audio specific control would this device be
provdiing?

--Wtrm9ATX0sn6fFKv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlon6poACgkQJNaLcl1U
h9AB8Qf7BIo2OGD1NjmXtt+JMQeyOYnAkrD9tA1jmgs2ZOpbmQvxq3ObLDptvo7v
1x6ngCe1WWLxOL4JAis6QdurSnZjK/LecGWwO5thVzLNAB9zE8t/x+thps6k93Ct
TQKxjNARIWdRpnnhiwUHHd4dyKtq46KM3nNSHDffReZOkrD9OtMXjcCn9+XSnXC7
l5LPKWBRtMNDNM6QNJxGBAEsO7FVt3ZKIBJA+zZazlKXlboE1l1a+RpRyuthE1gq
EUyZTe902lLqILbYmu9EDBQcWqh90WQhwm9xk8t1arVMjOleLtNBUHvvgaCBCmO/
fFcooHnDk1ykcCIGAvQ1drRXkrsWog==
=S7Py
-----END PGP SIGNATURE-----

--Wtrm9ATX0sn6fFKv--

--===============2192286405409027084==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2192286405409027084==--
