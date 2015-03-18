From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: Intel: Remove vague commit about
 slave DMA config from firmware loader
Date: Wed, 18 Mar 2015 11:44:11 +0000
Message-ID: <20150318114411.GF2869@sirena.org.uk>
References: <1426666040-1727-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1426666040-1727-2-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7091490290154921562=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 75BDC2605F2
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 12:44:15 +0100 (CET)
In-Reply-To: <1426666040-1727-2-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jin Yao <yao.jin@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============7091490290154921562==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TeJTyD9hb8KJN2Jy"
Content-Disposition: inline


--TeJTyD9hb8KJN2Jy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 18, 2015 at 10:07:20AM +0200, Jarkko Nikula wrote:
> Intel MID DMA driver is going to be removed, commit should be a few lines
> down near to dmaengine_slave_config() call in order to not confuse and at
> quick look Synopsys DesignWare does seem to use some of the slave config
> structure fields (see drivers/dma/dw/core.c: dwc_config()).

Applied both, thanks.

--TeJTyD9hb8KJN2Jy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVCWUKAAoJECTWi3JdVIfQpekH/3rWDT5OHrVoicJS1CYPFLwx
b9R2k87i4vPH4mKauuj6cmLX8pGqMikiPBzC32J7KnDZXz7SLqOTkm2hhTspfrBu
TSN6xQQphci4sL4X5EvubD/Fio0c5m/HEgOwc/DUuyNRzDDCbgw8nRBxbbTiiZth
mmqTlQtogNZ7E7Bvl8cOFCfUvSfw0ZqJcoSoUa93/BkoFWQHfYgDpXRiHCsDAph+
RTu7amSch9RJ66vu8zMKIPQXHuOgs2uIXWVvCE+NiKu0F6agd6qD+v8FWdtdz0uB
RnJ/nliJdZpK8BjNDuNWhtdG0ZawEb2Pw5FjzRVWJ7m0pE5rWkNtTCvapEQBhr8=
=omyz
-----END PGP SIGNATURE-----

--TeJTyD9hb8KJN2Jy--

--===============7091490290154921562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7091490290154921562==--
