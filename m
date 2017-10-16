From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] dmaengine: imx-sdma: advertise all
 supported slave bus widths
Date: Mon, 16 Oct 2017 10:19:58 +0100
Message-ID: <20171016091958.x5ilu6w5vcojnljp@sirena.co.uk>
References: <20171013104346.16818-1-l.stach@pengutronix.de>
 <20171013112503.5h25exymttetowbk@sirena.co.uk>
 <1507894543.5860.7.camel@pengutronix.de>
 <20171013143901.t5wtxesho2wip4d7@sirena.co.uk>
 <1507906201.5860.9.camel@pengutronix.de>
 <20171013171303.ardykpvxg5tm5q3v@sirena.co.uk>
 <20171016062836.GJ30097@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7596063230877363248=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 54454266DCF
 for <alsa-devel@alsa-project.org>; Mon, 16 Oct 2017 11:20:04 +0200 (CEST)
In-Reply-To: <20171016062836.GJ30097@localhost>
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
Cc: alsa-devel@alsa-project.org, patchwork-lst@pengutronix.de, kernel@pengutronix.de, peter.seiderer.ext@zeiss.com, dmaengine@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>, LW@KARO-electronics.de
List-Id: alsa-devel@alsa-project.org


--===============7596063230877363248==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ahrnh7vmeblzqasl"
Content-Disposition: inline


--ahrnh7vmeblzqasl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 16, 2017 at 11:58:36AM +0530, Vinod Koul wrote:
> On Fri, Oct 13, 2017 at 06:13:03PM +0100, Mark Brown wrote:

> > That can should be able to be handled cleanly by enforcing any caps that
> > are advertised but if the driver doesn't declare anything at all then
> > just accepting anything and leaving it up to the driver to cope.

> well DMAengine core cannot guess what hardware supports, but if not provided
> we may want to go back to a saner default values which people might support.

That's why I say "any caps that are advertised" - if the driver said
something I'd expect it to be enforced.

--ahrnh7vmeblzqasl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnkeb0ACgkQJNaLcl1U
h9A4cwf/YVScMPrxamTYP5fEP/wJZVt4rh2cQxnB+M7mb0jKlV5sYch++xzXdoMH
Tj+aqcq6kyXQoRZ92uOwHaHUmC624NLQ5BGcDj+ooBF3HkGF0kbzE+i9Z0MXLJyo
H13ICmhkO8Zs7RktmOO/a8/wFz+sdymRFEmdDZ0uwTm8f6VSwuafkz5sHUX1CjjK
iJ2mkRhceaZWIApdwhwgAFoDZXcO2AC1lPfqVY/lLVtUEmjoYdjMabM5d0vCcUNb
iYaBdlQMpcTzFF0ismnpeZchrnQiZo8Zh3NOaznHVMAVy86Q1FGD+z24zsiXrvql
m15j1h9S8qGPaCcJpoLrN9oILWR7HQ==
=ocSJ
-----END PGP SIGNATURE-----

--ahrnh7vmeblzqasl--

--===============7596063230877363248==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7596063230877363248==--
