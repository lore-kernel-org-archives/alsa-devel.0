From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 08/11] ASoC: SOF: Add DSP HW abstraction
	operations
Date: Mon, 30 Jul 2018 16:21:05 +0100
Message-ID: <20180730152105.GL5789@sirena.org.uk>
References: <20180719185335.30912-1-liam.r.girdwood@linux.intel.com>
 <20180719185335.30912-8-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2627768520434637349=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DE882673A0
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2018 17:21:06 +0200 (CEST)
In-Reply-To: <20180719185335.30912-8-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2627768520434637349==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f54savKjS/tSNRaU"
Content-Disposition: inline


--f54savKjS/tSNRaU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 19, 2018 at 07:53:32PM +0100, Liam Girdwood wrote:

> +int snd_sof_pci_update_bits_unlocked(struct snd_sof_dev *sdev, u32 offset,
> +				     u32 mask, u32 value)
> +{

This stuff all looks a lot like regmap (we'd need a regmap-pci but I'm
sure some other things could use it).

--f54savKjS/tSNRaU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltfLOEACgkQJNaLcl1U
h9D8Vgf/dyt+hWoRQi3PgLTYm6OUezp2lh00RiIEOowW03Z6Sr8zcQbSIeDzfsON
5QXqBViTzHzduAB1S1QL2Oh5kXBJsxXspTL4md5sLgQe14gxdZqrl2EEfXQACxny
a709EOWuAioCMDYUew1lOQg2Uts+P4P+5mwwFSGuqXapZiz+4A29hihBj+WkqmZN
kiJfiF4zO42aEkg2tnQHmWJuz3edvbgtFevKQJqHUH6RdjLucu48p9zgSYS5x2xF
7eRAtcXmclLOXL0RoTRzSVZSugUowpGlVN6Rvymysu5eqnugJC+6JDgNPduoKMAD
YrjG7829Lcl7Ghyj+3YalAHEwSuSlA==
=rVDC
-----END PGP SIGNATURE-----

--f54savKjS/tSNRaU--

--===============2627768520434637349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2627768520434637349==--
