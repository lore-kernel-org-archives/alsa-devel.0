From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] dmaengine: imx-sdma: advertise all
 supported slave bus widths
Date: Fri, 13 Oct 2017 12:25:03 +0100
Message-ID: <20171013112503.5h25exymttetowbk@sirena.co.uk>
References: <20171013104346.16818-1-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8932423150043558759=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E8D8A266D12
 for <alsa-devel@alsa-project.org>; Fri, 13 Oct 2017 13:25:16 +0200 (CEST)
In-Reply-To: <20171013104346.16818-1-l.stach@pengutronix.de>
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


--===============8932423150043558759==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ofl55m6qfyzanb36"
Content-Disposition: inline


--ofl55m6qfyzanb36
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 13, 2017 at 12:43:46PM +0200, Lucas Stach wrote:

> The commit [1] which changed imx-pcm-dma to derive the pcm_config from the
> attached dmaengine introduced a regression on the supported sample formats,
> as imx-sdma doesn't properly advertise all the supported slave bus widths.

How did this work previously - shouldn't we have failed to use the
unadvertised bus widths?  I'd expect the framework to be providing error
checking for the clients here.

--ofl55m6qfyzanb36
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlngoo8ACgkQJNaLcl1U
h9Bc0wf9EwypumAYedGxNpitPsexS8KY9aw3GSw3kF+WWk+Mgk/pGFWm3UiQMdPh
uESPDqoggZpmNFAGUpafyheTh/5sD9g7Jvv0mWB9egDI2W4jdOLQqjgAR3EdLtJm
QYCwFKNmh5NQpTpRyWPiq2XbmA2pGhQ98Ln2UfLRlmLSk4BpHeH8dLGnrkE+sKhD
u+QIwO3M/DecBdJsGl8kgyVgqDCgFCRiBmcdD3rgdmKqPgCOG9dCzpK92Oi9Cfwd
5R+Ot4awTkUoXif+8gqhtb/SKj397DYfjauHlxYnLiDImAhLoN1oaIP2aeoKvhBn
2gWF0MBbonVU5q7dmZRQr/gP96suKA==
=bVGv
-----END PGP SIGNATURE-----

--ofl55m6qfyzanb36--

--===============8932423150043558759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8932423150043558759==--
