From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] dmaengine: imx-sdma: advertise all
 supported slave bus widths
Date: Fri, 13 Oct 2017 18:13:03 +0100
Message-ID: <20171013171303.ardykpvxg5tm5q3v@sirena.co.uk>
References: <20171013104346.16818-1-l.stach@pengutronix.de>
 <20171013112503.5h25exymttetowbk@sirena.co.uk>
 <1507894543.5860.7.camel@pengutronix.de>
 <20171013143901.t5wtxesho2wip4d7@sirena.co.uk>
 <1507906201.5860.9.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5300495666335783013=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id AD9F4266E90
 for <alsa-devel@alsa-project.org>; Fri, 13 Oct 2017 19:13:17 +0200 (CEST)
In-Reply-To: <1507906201.5860.9.camel@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, patchwork-lst@pengutronix.de, kernel@pengutronix.de, peter.seiderer.ext@zeiss.com, dmaengine@vger.kernel.org, LW@KARO-electronics.de
List-Id: alsa-devel@alsa-project.org


--===============5300495666335783013==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bthuxty2tscilbwh"
Content-Disposition: inline


--bthuxty2tscilbwh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2017 at 04:50:01PM +0200, Lucas Stach wrote:
> Am Freitag, den 13.10.2017, 15:39 +0100 schrieb Mark Brown:

> > ...I'm talking about the constraints supported on the DMA side.=A0=A0I =
would
> > not expect the DMA side to be accepting things it said it didn't suppor=
t.

> AFAIR the caps for the supported slave bus width were introduced later
> than other caps and not all drivers did implement them properly, so
> validation at the core level at this time would probably have broken a
> lot of existing users.

> That said the dmaengine core warns since kernel 4.0 if a driver doesn't
> set those caps, so it's probably fine if we cook up a patch to do the
> validation now.

That can should be able to be handled cleanly by enforcing any caps that
are advertised but if the driver doesn't declare anything at all then
just accepting anything and leaving it up to the driver to cope.

--bthuxty2tscilbwh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlng9B4ACgkQJNaLcl1U
h9DFPQf+JuobkL7hzVF9TwyuAo3lN30JlEfzvEfmsiXaRK6CTrXfVow7i710rbO3
BG6UdvOw+b1MEfSQTqqpprfqYc+QI8JZ8/ehiEEAMXvI7IKvFF5eLmQGMfgVikeD
+Paa4PJUsRvFfmX4+mjilWoXAIcpRueiG+AxqxQmyjnOsZgxasIcIs/b82ve1Qar
D++x8V//xFwpwuGvui2K+ecS9iOfdZxyay6KB3wBujPE0xXczCGw2fCsExh4GZb8
W0BShieVGC3BmuadHeOgoziQwDWiDxYQ5tXkp5qxPCCfBAb1DtkP0TBHEDmmnTLN
BCkEpQVaUCqkv77wQPm57A1ssa1Ytg==
=UjP4
-----END PGP SIGNATURE-----

--bthuxty2tscilbwh--

--===============5300495666335783013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5300495666335783013==--
