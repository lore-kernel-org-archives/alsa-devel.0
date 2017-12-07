From: Mark Brown <broonie@kernel.org>
Subject: Re: Multiple codecs on the same DAI
Date: Thu, 7 Dec 2017 11:20:16 +0000
Message-ID: <20171207112016.bkiw2gi4pcmvendr@sirena.org.uk>
References: <alpine.DEB.2.11.1711231533480.27895@lnxricardw1.se.axis.com>
 <20171124123921.ajhxztwypujty6ps@sirena.org.uk>
 <alpine.DEB.2.11.1711241456420.27895@lnxricardw1.se.axis.com>
 <20171124180456.6c63tkph4e7ahuid@sirena.org.uk>
 <alpine.DEB.2.11.1712061352160.22247@lnxricardw1.se.axis.com>
 <20171206130323.GG1827@finisterre>
 <alpine.DEB.2.11.1712061521180.22247@lnxricardw1.se.axis.com>
 <20171206154552.iqcdtyhuj7oyfwcg@sirena.org.uk>
 <alpine.DEB.2.11.1712070841040.22247@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4301164437696884444=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id AA1D52670BC
 for <alsa-devel@alsa-project.org>; Thu,  7 Dec 2017 12:20:18 +0100 (CET)
In-Reply-To: <alpine.DEB.2.11.1712070841040.22247@lnxricardw1.se.axis.com>
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


--===============4301164437696884444==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lbxxxtdp7z4ij2r4"
Content-Disposition: inline


--lbxxxtdp7z4ij2r4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2017 at 08:47:03AM +0100, Ricard Wanderlof wrote:
> On Wed, 6 Dec 2017, Mark Brown wrote:

> > That does sound like an auxiliary device that's a regulator consumer.

> So essentially one would register this device as an auxiliary device,=20
> which would define a DAPM widget which in turn would be part of a DAPM=20
> route in the encompassing machine driver?

Or register a device that consumes the regulator and maps it into ASoC
like that.

--lbxxxtdp7z4ij2r4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlopI+4ACgkQJNaLcl1U
h9AkIwf9HO3YU8/GIn65jprFl1fxcfa+IByqF7mnp+f5arU/wlnRg6kXwi/Ikjg3
yK5O0nR2nIAgEOpAANEKLUAxT6+gfBBx9umDbFef8MlRm9tJoRvyvxC86Ku66kHm
qPv4SjJ9c4XS4VOPRfvSUmGkpqTY9rJxR3rl9v/y/M5Ug1Gl0WSBq3Q0ovO/AjUw
5xHg2acKvZwnsjmCR7crLwKV9zFPrAWxpjcN3qcYWmH/M5m076ZIHIAsSblBAds2
aOYiirFkqlPAHarFVO6VZm0R1Mor2Pftc10iL2iCHP7S+41n/LFkMtiV6cenkPjr
ADdS6eL+3y5s6JCbE9tyMSkcA9VsoQ==
=Pj57
-----END PGP SIGNATURE-----

--lbxxxtdp7z4ij2r4--

--===============4301164437696884444==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4301164437696884444==--
