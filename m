From: Mark Brown <broonie@kernel.org>
Subject: Re: [RESEND RFC PATCH 1/3] ASoC: mediatek: Add binding support for
 AFE driver
Date: Sat, 18 Apr 2015 18:34:07 +0100
Message-ID: <20150418173407.GE26185@sirena.org.uk>
References: <1428653649-38200-1-git-send-email-koro.chen@mediatek.com>
 <1428653649-38200-2-git-send-email-koro.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yUw0eFUXHKnFujKq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1428653649-38200-2-git-send-email-koro.chen@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Koro Chen <koro.chen@mediatek.com>
Cc: robh+dt@kernel.org, matthias.bgg@gmail.com, perex@perex.cz, tiwai@suse.de, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, s.hauer@pengutronix.de, galak@codeaurora.org, lgirdwood@gmail.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--yUw0eFUXHKnFujKq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 10, 2015 at 04:14:07PM +0800, Koro Chen wrote:

> +Each external interface (called "IO" in this driver) is presented as a
> +DAI to ASoC. An IO must be connected via the interconnect to a memif.
> +The connection paths are configured through the device tree.

Why are these connection paths configured via device tree?  I would
expect that either there would be runtime configurability of these
things (particularly if loopback configurations within the hardware are
possible) or we'd just allocate memory interfaces to DAIs automatically
as DAIs come into use.

> +- mem-interface-playback:
> +  mem-interface-capture: property of memif, format is: <memif irq use_sram>;
> +	                 memif: which memif to be used
> +			        (defined in include/dt-bindings/sound/mtk-afe.h)
> +		         irq: which irq to be used
> +			      (defined in include/dt-bindings/sound/mtk-afe.h)
> +		         use_sram: 1 is yes, 0 is no

Again, this looks like stuff we should be able to figure out at runtime
- the use of SRAM in particular looks like something we might want to
change depending on use case.  Assuming it adds buffering then for a
VoIP application we might not want to use SRAM to minimize latency but
during music playback we might want to enable SRAM to minimize power
consumption.

--yUw0eFUXHKnFujKq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVMpWOAAoJECTWi3JdVIfQuWwH/08PJh1EXixYY1yYRWtSNW45
JXWlvj8FAyKmtS7RkFz8osufXvfrNtsfc8J1Q9wHlNZ1eRKqXsj1x6HnfRHnJpF2
oRU/p4BE0vWDS3tlBSJH+yLs+GXlyn5DYHREq6hSsLguYgvusTYi3zhqcF9fKNDB
42gO5vVD/ZfN/Wp0qHC5D9ZPZAnPXF6yfih63PraSBSYRkf9EkEL7V30Y1xESO+z
x645zIeZSecuvsX1J/rtusRzT9Fro/Lzi+rLwscUZNmeIaFksywmwcAmtj3xb7xt
gLJde1efCvsMcPTx15WIcVzykiBP/iRSRhEmOgkO4AYKdIGXIQrp/ktbH3K8Hno=
=GAGs
-----END PGP SIGNATURE-----

--yUw0eFUXHKnFujKq--
