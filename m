From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: ssm2518: Add explicit device tree
 support
Date: Mon, 17 Aug 2015 10:28:55 -0700
Message-ID: <20150817172854.GP10748@sirena.org.uk>
References: <alpine.DEB.2.02.1508131456110.27635@lnxricardw1.se.axis.com>
 <20150814155304.GP10748@sirena.org.uk>
 <alpine.DEB.2.02.1508170841190.27635@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5570722048516164655=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from p2012.superclick.com (unknown [216.4.250.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E55D2606F9
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 19:28:59 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1508170841190.27635@lnxricardw1.se.axis.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5570722048516164655==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fcasAdn045BL8lzs"
Content-Disposition: inline


--fcasAdn045BL8lzs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2015 at 08:43:23AM +0200, Ricard Wanderlof wrote:
> On Fri, 14 Aug 2015, Mark Brown wrote:

> > > Add OF match table to SSM2518 to allow direct matching without going
> > > through I2C subsystem.

> > > Signed-off-by: Ricard Wanderlof <ricardw@axis.com>

> > > ---
> > >  sound/soc/codecs/ssm2518.c |    9 +++++++++
> > >  1 file changed, 9 insertions(+)

> > You should document all new DT bindings (even if they did implicitly
> > happen to work before).

> Do you mean in the commit message then? (The patch doesn't implement any=
=20
> bindings not already described in=20
> Documentation/devicetree/bindings/sound/ssm2518.txt).

No, I mean the binding file.  In the unusual case that there's one
already that's not had the driver side changes made then you should
mention that it exists in the changelog.

--fcasAdn045BL8lzs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV0hnWAAoJECTWi3JdVIfQRvUH/jAhfYv70mgZfpbSK4+V44Vi
z2y395o7BDfimSN5Rqq1sizmQCaohKJ2JDdhnvJS/yuIr1SvbB5gwUrCmVn2hodr
oxJfX9K8xZv/INKLfk1eQY71+xAHWF9YYtOT6mmy9a7gDfzTcMPSU6WRKHwbdLEU
35gRMJTovL+R45R4sPYz9iO4oIeDtap5saN8T02F386h+zC3at0JdnJIc7CS3sIO
IypFEtClfmo038OcZwOXS5r0T2qQyBBW05UPvUCDzvuJsuc+ankYY1z26njVY+LJ
SVLmhs50+j5DybhRaUA9vdgdZlupPEDS5cWNM//6VZ0H1BXrZBi92raiB3Cbpbg=
=sULx
-----END PGP SIGNATURE-----

--fcasAdn045BL8lzs--

--===============5570722048516164655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5570722048516164655==--
