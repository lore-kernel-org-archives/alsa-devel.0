From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Add support for PM ops in
 bxt-da7219_max98357a
Date: Fri, 17 Jun 2016 12:14:07 +0100
Message-ID: <20160617111407.GE26099@sirena.org.uk>
References: <1466138010-27740-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1810832396114889338=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B1E20265826
 for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2016 13:14:13 +0200 (CEST)
In-Reply-To: <1466138010-27740-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1810832396114889338==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cYtjc4pxslFTELvY"
Content-Disposition: inline


--cYtjc4pxslFTELvY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 17, 2016 at 10:03:30AM +0530, Vinod Koul wrote:

> +static void broxton_complete(struct device *dev)
> +{
> +	snd_soc_resume(dev);
> +}
> +
> +#else
> +#define broxton_complete NULL
> +#endif

Just use snd_soc_resume() directly.

--cYtjc4pxslFTELvY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXY9t+AAoJECTWi3JdVIfQhRYH/2m8ZNmJMmxNUzNE0dxzI54B
XCtkOReL+CY5gNTIeEIHdQHjNn6GzxPYvckmmem1wy/qLLGCTLOyX63PR+salu/f
l41J5TuVer0h69e6qNzbjog8hXMIigjpLLLvkg921UGLyop1PtRDjipVs9aKpxYO
tzwgnNGRdu8hJvgLnB/sT8wJev3PaKFDP5mQCsfEHKTbpGzrHL/lRyPdC66W6a8c
bKaQoLsb6PsMIFEEKCsMXuD2yXMX20WRCHQ4Lj/rZgrus5I9Tn7CTbgnVLu9Z3Mm
snq0Pzjdyt/tG6bTCPfDrds0avbSfXBi3AolYg8IU/GhL/U8vqs/rLAunF38yYc=
=ZdVE
-----END PGP SIGNATURE-----

--cYtjc4pxslFTELvY--

--===============1810832396114889338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1810832396114889338==--
