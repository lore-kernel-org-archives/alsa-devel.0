From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8540: new codec driver
Date: Thu, 26 Jan 2017 12:36:35 +0000
Message-ID: <20170126123635.aume3q44wns5hbft@sirena.org.uk>
References: <1483597244-9761-1-git-send-email-KCHSU0@nuvoton.com>
 <20170109200052.szyldvyxnki2jggj@sirena.org.uk>
 <58881F56.3080007@nuvoton.com>
 <20170125125049.aml35ei6oc4kwguu@sirena.org.uk>
 <5889977B.4090202@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4809150888754569474=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 188392666F2
 for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2017 13:36:43 +0100 (CET)
In-Reply-To: <5889977B.4090202@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: WTLI@nuvoton.com, YHCHuang@nuvoton.com, alsa-devel@alsa-project.org, CTLIN0@nuvoton.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4809150888754569474==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gw6lgiwhhe7l5sgp"
Content-Disposition: inline


--gw6lgiwhhe7l5sgp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 26, 2017 at 02:30:19PM +0800, John Hsu wrote:
> On 1/25/2017 8:50 PM, Mark Brown wrote:
> > On Wed, Jan 25, 2017 at 11:45:26AM +0800, John Hsu wrote:

> > Why not on resume?  While it won't always happen system suspend does
> > frequently mean that the device will have lost power so anything done on
> > boot will have been lost.

> Yes, I can move it to resume.
> By the way, is it better to do cache sync instead for the situation?

Yes, adding a cache sync on resume would also do the trick if it's just
writing values in and the ordering doesn't matter.

--gw6lgiwhhe7l5sgp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliJ7VMACgkQJNaLcl1U
h9BjrAf+JPUffXN/3qP5GbjcyMnfow2yZESW/1xY7yv47LNdtY8zxJGXKAHfi+NS
25cfG5jl/tsFVrXJ6uXnazDt1Mj91TNh3bekogPzNRD5ahZioRBiNiXM9UTcTh8v
TKeYPDEyxyAJBm8Dyb6k0UFUG6tsKAj+S8N12PxXOzvrDr1Nap4l9qY+PybMRPCT
IwSMWF86bgDXR3JWf9/ILxqghNJqfzCg9nBPargadb9gjrNtt0vAe0GWZNROFEQ1
QWhFa3HB2xc2Yd2IYXyRGZPGB04T09ECXiU9HWvHcTTObnjzGrR4ixeOKajeKXPS
hHfIxrEsjRNnDze6GAO1xYOYsgmI9w==
=BkTN
-----END PGP SIGNATURE-----

--gw6lgiwhhe7l5sgp--

--===============4809150888754569474==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4809150888754569474==--
