From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dmaengine_pcm: Make FLAG_NO_RESIDUE
	internal
Date: Mon, 27 Apr 2015 20:38:14 +0100
Message-ID: <20150427193814.GZ22845@sirena.org.uk>
References: <1430131465-17991-1-git-send-email-lars@metafoo.de>
 <20150427182801.GX22845@sirena.org.uk>
 <553E8C83.4030604@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0401923364870173535=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 166B126041C
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 21:38:24 +0200 (CEST)
In-Reply-To: <553E8C83.4030604@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0401923364870173535==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vFe9IgxZ3Jt1WGP3"
Content-Disposition: inline


--vFe9IgxZ3Jt1WGP3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 27, 2015 at 09:22:43PM +0200, Lars-Peter Clausen wrote:
> On 04/27/2015 08:28 PM, Mark Brown wrote:
> >On Mon, Apr 27, 2015 at 12:44:25PM +0200, Lars-Peter Clausen wrote:

> >>This patch makes the FLAG_NO_RESIDUE internal and no longer allows audio
> >>controller drivers to manually set the flag. If a DMA driver against
> >>expectations does not support reporting its capabilities for now the generic
> >>DMAengine PCM driver will now emit a warning and simply assume that residue
> >>reporting is not supported. In the future this might be changed to aborting
> >>with an error.

> >I'm not sure it's ever going to buy us anything to error out on stuff,
> >it's not like the no residue case doesn't need to be supported anyway
> >for controllers that just can't do it.

> I'm not too sure about it either. Since it is prone to race-conditions by
> design we'd ideally eventually drop support for the fallback period counting
> mechanism in the PCM driver altogether and instead the period counting would
> be done at the DMAengine layer. At the DMAengine layer the period counting
> can usually be implemented without any race conditions and other DMAengine
> clients will also benefit from it.

Indeed, it would be much better to handle things like this further down
the stack - if we do then probably this will take care of itself anyway
since we'll always have something reported.

> A good start might be to emit a warning when we have to do this in the PCM
> driver to at least make sure that new platforms do this properly.

Yes.  It might also encourage people to update their platforms.

--vFe9IgxZ3Jt1WGP3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVPpAlAAoJECTWi3JdVIfQ45oH/3qsUEEJvvoicWpgRz49PQRL
+Fkyw3whn9F0TJfo2yN8Xrh2rRo8JCNtzvqDFrCoJMqsbZpb4gqtni8fs5JdCKg+
5qYYCPTE0VDfwELJTWEgU/f7wbqXCtRzJ4aPSqWguRw2ErM/gqjwm9WTTvwR5pde
Gf5/DFtcN20PfBRmcewLQnSaWkv2Vpd1qjdtIJYTuPJ4iKxue4CJmMV5j8Zl9Ssv
TsjmIyNk7aIqUvkg0RaoBUnYa5XondmYUbBMDN/gEb6/yeiro5yJmELhoNEfdOv0
GmJWTrVizd+7gCAGimJfg7IHXRn6LMbkfs/5TV21FP5S0prqRbab4IUdMYidZ/w=
=xDa3
-----END PGP SIGNATURE-----

--vFe9IgxZ3Jt1WGP3--

--===============0401923364870173535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0401923364870173535==--
