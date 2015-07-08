From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/6] ASoC: Intel: fix kconfig,
	symbols and sparse
Date: Wed, 8 Jul 2015 19:24:23 +0100
Message-ID: <20150708182423.GW11162@sirena.org.uk>
References: <1434738331-12518-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8321865166752456932=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 89FF5265065
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 20:24:30 +0200 (CEST)
In-Reply-To: <1434738331-12518-1-git-send-email-vinod.koul@intel.com>
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


--===============8321865166752456932==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AUHDRRu7c4EIRU83"
Content-Disposition: inline


--AUHDRRu7c4EIRU83
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 19, 2015 at 11:55:25PM +0530, Vinod Koul wrote:

> Vinod Koul (6):
>   ASoC: Intel: use CONFIG_SND_SOC for intel boards
>   ASoC: Intel: kconfig - Move DW_DMAC_CORE dependency to machines
>   ASoC: intel - kconfig: remove SND_SOC_INTEL_SST prompt
>   ASOC: intel - hsw: fix sparse unused varible warn
>   ASoC: intel - atom: statify sst_slot_enum_info
>   ASoC: Intel -atom: fix sst_platform_compr_ops declaration

Please try to use commit message styles that are consistent with that
for the subsystem, these aren't even consistent within the series :(

--AUHDRRu7c4EIRU83
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVnWrXAAoJECTWi3JdVIfQH4wH/07jeOAtVbsuPRP/YSXhNz9s
aX+qVmzm9+VIFvdlxryIcIs8lw7RWPHx0txIGPClvetzJlfGlNY9c8b+J7jnFzea
HDqz/KiLMLECCq+Kt+UkqkexllPrGu/fLXvb7lHdLRBZqdf/rf1XWog081A+N4uE
YmD6GFyvX96gFCauRdezsXT6r5rIU9H33V4Jdu7DO22cJDN6eMnIvf/6oWufGq5U
zr621K+IHSlv9a3z1fMiTAJDrH9B6cT9G87tUGNDp+jJSt+1XBHSqgl4tSjhZYPx
0DwJmNmjtzKtVxo7vlV0HTbSwgRFrMUMroOZu0iR019/n6J5NHwyF9cB/ZEo8j0=
=VtIT
-----END PGP SIGNATURE-----

--AUHDRRu7c4EIRU83--

--===============8321865166752456932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8321865166752456932==--
