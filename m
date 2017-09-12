From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/7] ASoC: ts3a227e: add acpi table
Date: Tue, 12 Sep 2017 07:54:48 -0700
Message-ID: <20170912145448.ygzvb3em3zqp63jr@sirena.org.uk>
References: <20170908051309.19028-1-pierre-louis.bossart@linux.intel.com>
 <20170908051309.19028-6-pierre-louis.bossart@linux.intel.com>
 <20170908132705.GH3053@localhost>
 <20292830-6f66-a67e-8030-a7eaf808c3fe@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9078345641215594313=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 58F00266B23
 for <alsa-devel@alsa-project.org>; Tue, 12 Sep 2017 16:55:02 +0200 (CEST)
In-Reply-To: <20292830-6f66-a67e-8030-a7eaf808c3fe@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Thierry Escande <thierry.escande@collabora.com>, Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@linux.intel.com, tiwai@suse.de, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============9078345641215594313==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oe5ukxwyia7vzlly"
Content-Disposition: inline


--oe5ukxwyia7vzlly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 08, 2017 at 08:30:37AM -0500, Pierre-Louis Bossart wrote:

> > >   		.of_match_table = of_match_ptr(ts3a227e_of_match),
> > > +		.acpi_match_table = ACPI_PTR(ts3a227e_acpi_match),

> > but then this would give compiler error on those systems as .acpi_match_table is
> > defined in driver core... can you compile this on non acpi and check

> This is not any different from what is done for other codecs.

> And the 0day checks did not report any issues, probably because the
> pre-processor takes the table out when CONFIG_ACPI is not enabled:

> #define ACPI_PTR(_ptr)	(NULL)

> so no change...

Right, this is the whole point of the of_match_ptr() and ACPI_PTR()
macros.

--oe5ukxwyia7vzlly
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlm39TUACgkQJNaLcl1U
h9BOLAf/dhtSblgxKqJGJ+dE4/SJvvGI736J7xqJe4oCOsInPsKLp+OkEvqNHRcx
N2KR6mVur3z+w+P1za9Y8sMd3qczqPZESZKO7FUAvTvcV3YI8H9KtwfbopENIrRI
6v/B7MWl385ZvAhj5tQxRQmIV0oBCuMiblvfrrRkMpqbRrANy+4eXYoVArlTBb/3
5CqlYfUMV668E7+s2V9pIEF+nlGtrlbWoP9a1IHOArTXGEOWM47XdjJsFHKXf7L3
53qHKP00VxgHbYXw+Ix9YmwG3ijQBHTi3tevkN5ERLVerM8vXRut+QwotbmRKv9E
M6EM3dUVv8MJxvg7XL9yRrjZM70r0g==
=/pFY
-----END PGP SIGNATURE-----

--oe5ukxwyia7vzlly--

--===============9078345641215594313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9078345641215594313==--
