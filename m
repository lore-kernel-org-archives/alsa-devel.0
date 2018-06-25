From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ALSA: ac97: add bus binding for
	codecs
Date: Mon, 25 Jun 2018 12:23:30 +0100
Message-ID: <20180625112330.GD9413@sirena.org.uk>
References: <20180622192834.7797-1-robert.jarzmik@free.fr>
 <s5h36xbe1cp.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7630951723015768665=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D30826777E
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 13:23:37 +0200 (CEST)
In-Reply-To: <s5h36xbe1cp.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: alsa-devel@alsa-project.org


--===============7630951723015768665==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3Gf/FFewwPeBMqCJ"
Content-Disposition: inline


--3Gf/FFewwPeBMqCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 25, 2018 at 10:07:02AM +0200, Takashi Iwai wrote:
> On Fri, 22 Jun 2018 21:28:33 +0200,
> Robert Jarzmik wrote:
> >=20
> > Add the generic ac97 bus binding, especially for ac97 codecs discovered
> > by ac97 hardware probing.
> >=20
> > Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>=20
> OK, now I applied both patches.
>=20
> Mark, if you need these changes, pull topic/ac97-bus branch from my
> tree.  It's a clean branch from 4.18-rc1.

Thanks!

--3Gf/FFewwPeBMqCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsw0LEACgkQJNaLcl1U
h9DfrAf9GlxyEFEs2pxqfLQp4kmb6cd1fA5N3twtiLq0KnqFUsIX95MX0ZT37p+V
cFSoD5v+C+bvhvjeEP0ASkFWqo+C45LsR6yh7nyAzrpahjCaKcWXscx0wh7v/A5+
gHB4e+kb58vi49pTptg1uMhY7osfqX1UpO11Sw3xK4kUnrTRGrFh2ahxIUbySx9U
taK4MBGBrEJnstdevxGesPRxuMXcQuv7bG5wUbAFX9e4STQIqVFpKy7pgO99XMzQ
P8kVQAAxUP6kOf61KsnSfSCHJZAIR0uLNFNU+l1RRCjDOi4BOr/sKnF14jptTXzK
pRq5FPsDVuOimrbmg/iqP3OPawUHMA==
=VlxG
-----END PGP SIGNATURE-----

--3Gf/FFewwPeBMqCJ--

--===============7630951723015768665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7630951723015768665==--
