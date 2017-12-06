From: Mark Brown <broonie@kernel.org>
Subject: Re: Multiple codecs on the same DAI
Date: Wed, 6 Dec 2017 15:45:52 +0000
Message-ID: <20171206154552.iqcdtyhuj7oyfwcg@sirena.org.uk>
References: <alpine.DEB.2.11.1711231533480.27895@lnxricardw1.se.axis.com>
 <20171124123921.ajhxztwypujty6ps@sirena.org.uk>
 <alpine.DEB.2.11.1711241456420.27895@lnxricardw1.se.axis.com>
 <20171124180456.6c63tkph4e7ahuid@sirena.org.uk>
 <alpine.DEB.2.11.1712061352160.22247@lnxricardw1.se.axis.com>
 <20171206130323.GG1827@finisterre>
 <alpine.DEB.2.11.1712061521180.22247@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6111651757734801070=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D159F267991
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 16:45:53 +0100 (CET)
In-Reply-To: <alpine.DEB.2.11.1712061521180.22247@lnxricardw1.se.axis.com>
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


--===============6111651757734801070==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lzagntv37owiqof3"
Content-Disposition: inline


--lzagntv37owiqof3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2017 at 03:26:47PM +0100, Ricard Wanderlof wrote:
> On Wed, 6 Dec 2017, Mark Brown wrote:

> > That just sounds like a regulator?  I'd expect that just to be used as a
> > supply as normal.

> You mean as a DAPM widget?

Or via a device which uses it.

> >  What audio specific control would this device be provdiing?

> What it does provide is current sensing if the connected device draws too=
=20
> much power, although it does not automatically shut off the connected=20
> device if that is the case, so a small driver is required to shut down th=
e=20
> output in the case of overcurrent. There's also a requirement to be able=
=20
> to read the overcurrent status. One approach is to implementet the whole=
=20
> thing as an auxilliary device, with one ALSA control to control the power=
,=20
> and a read only control to read the overcurrent status.

That does sound like an auxiliary device that's a regulator consumer.

--lzagntv37owiqof3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlooEK8ACgkQJNaLcl1U
h9AIagf/eB46qEwQ3aDR3/CWSokjiN2mgeq6Mx5thmru7f+6RsLr7B2VEb6s+5ws
pXi/rLGpHb5sqQobfdbq1XMigw1qn4fKfC6YHYMuf+SBh6XrVKgBAuKLT8hOIGJ1
cKlwcQkMxOAcEk4FFp0sr/mBnae0kwoatniAamPLGyTgeTv7uUuXjrl9yEiqwp3M
bdUPxCqXEVSSNEGdnBg/fiHPGveogC7rhr7Kf+Ap0e9G4kb+ek4jWDjwkcT2Sf6s
ltCDumFvNRp90q6CHKcoLxWUb9/K6keJBONXpZvfkrbalj5ykBkaYLoKzyFXCJ7h
HizlWgwOMOfKrIJuAwJ9KFW1VtSUlA==
=Y9RJ
-----END PGP SIGNATURE-----

--lzagntv37owiqof3--

--===============6111651757734801070==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6111651757734801070==--
