From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/3] ASoC: SOF: trace: move to opt-in
 with Kconfig and module parameter
Date: Thu, 13 Jun 2019 19:44:31 +0100
Message-ID: <20190613184431.GU5316@sirena.org.uk>
References: <20190612164726.26768-1-pierre-louis.bossart@linux.intel.com>
 <20190612164726.26768-2-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7583036222592169043=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0E614F80794
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2019 20:44:33 +0200 (CEST)
In-Reply-To: <20190612164726.26768-2-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7583036222592169043==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dg6Tyglv1qyvGx3q"
Content-Disposition: inline


--dg6Tyglv1qyvGx3q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 12, 2019 at 11:47:24AM -0500, Pierre-Louis Bossart wrote:

> +	    (sof_core_debug & SOF_CORE_ENABLE_TRACE)) {
> +		sdev->dtrace_is_supported = true;

Given that dtrace is a widely known product with a Linux implementation
can we not call this dtrace?  use_dma_trace or something?  A long name
doesn't seem too bad here but a collision with the more common usage of
the name isn't great.

--dg6Tyglv1qyvGx3q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0CmY8ACgkQJNaLcl1U
h9DH7Qf+LBSCocEMiYGm0Qmvor+WGSM7KmmY7kUw37/U3x0xKzxVM2HTtaqP0unn
py3PReTytj6bdBlum4PEX7DldtNFgcXPAc+5AHqgtt/4suWVZW0NQCIpbpcFTLZr
TkqMcuXD/i33zSEJw1BhFVOsSvnasBrwySJEXR5TBKADlae/6DZn2kEJ0Af2D8uI
BbhtNvqsBPi6MVJOxdhnuIMw/ep01KyPtYv8nF2LSAgVIz3AK4o9LoZlj/dtnump
MFNL3TpjSmjOprgFPN2sWtiIB14JKZsm2iGpUo3nucS4mhIAAPuOm0BIpz0rymy0
2ope1MP883EMohzgO8SZeedIfUBd/g==
=umP/
-----END PGP SIGNATURE-----

--dg6Tyglv1qyvGx3q--

--===============7583036222592169043==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7583036222592169043==--
