From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 3/4] ASoC: Intel - add makefile support
	for SKL driver
Date: Fri, 19 Jun 2015 16:27:48 +0100
Message-ID: <20150619152748.GJ14071@sirena.org.uk>
References: <1434546055-28866-1-git-send-email-vinod.koul@intel.com>
 <1434546055-28866-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0826343527882337926=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FCFD2605AF
 for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2015 17:27:56 +0200 (CEST)
In-Reply-To: <1434546055-28866-4-git-send-email-vinod.koul@intel.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0826343527882337926==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="X0hJ4E3r/0nQXmJY"
Content-Disposition: inline


--X0hJ4E3r/0nQXmJY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 17, 2015 at 06:30:54PM +0530, Vinod Koul wrote:

> +config SND_SOC_INTEL_SKYLAKE
> +	tristate
> +	select SND_HDA_EXT_CORE

Should this be _SKYLAKE_HDA or something?  I may be confused on product
naming and terminology but I thought these processors had both HDA and
non-HDA support (possibly in the same silicon at times)?

--X0hJ4E3r/0nQXmJY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVhDTzAAoJECTWi3JdVIfQoF0H/2mN2Lx9TZAgPkOBrGCxIndx
TThAM0Ch/Hv2/5o5QOw/29NPUD2Sr9FBYydJlxGqSmukxGMzqZapdaQFEeQjGe3M
hK4QMbbiwUSg9c4ca8wzFRd25E6FBjM5T7I2WYT32BMKQ+5YU0U0LS3vuUgiN89m
rMhjVmGU1cNyHRLYUlvJkPv5m/F6Cb1vT+lC6aKWS3CxvLffzowquFhewx6ZUcHy
zXWUINiB2Ze5MaXyqt5e1pLP7QcIpt/atQZtxNDEJZxhScpPxhkj/B7vuISm8MSQ
y2/Mk6QVCy8dYiATru7pSXWDexVnaurswl3Jr7HUduckfuGYSHN+qCmKIUJ4Tlc=
=R0oi
-----END PGP SIGNATURE-----

--X0hJ4E3r/0nQXmJY--

--===============0826343527882337926==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0826343527882337926==--
