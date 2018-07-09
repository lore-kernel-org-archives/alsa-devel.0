From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] dma: add support for reporting pause and resume
 separately
Date: Mon, 9 Jul 2018 12:17:50 +0100
Message-ID: <20180709111750.GC16082@sirena.org.uk>
References: <CGME20180702130819eucas1p2e11d8fabec93ba78d9e84f4ca6e5fd65@eucas1p2.samsung.com>
 <20180702130819eucas1p2e11d8fabec93ba78d9e84f4ca6e5fd65~9jzNWZMqQ1216712167eucas1p27@eucas1p2.samsung.com>
 <20180704070033.GA22377@vkoul-mobl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180704070033.GA22377@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod <vkoul@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Lars-Peter Clausen <lars@metafoo.de>, dmaengine@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: alsa-devel@alsa-project.org


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 04, 2018 at 12:30:33PM +0530, Vinod wrote:

> > Existing clients of dma_get_slave_caps() have been checked and the only
> > driver which rely on proper channel resuming is soc-generic-dmaengine-pcm
> > driver, which has been updated to check the newly added capability.
> > Existing 'cmd_pause' now only indicates that DMA engine support pausing
> > given DMA channel.

> The change looks fine to me. I was hoping that serial would also check
> this..

> Mark, Lars you okay with this?

Acked-by: Mark Brown <broonie@kernel.org>

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltDRF4ACgkQJNaLcl1U
h9ArzQgAghDGW9+/mOESfXsKVbjaF3dY+et4k6kzf9ku4hsV+M98UUK/PnGVBt8X
Sy7kVY0pcs8gL3Vr38U5MNCAciqUIU8cSpIFmlIklR09AH/vjo0iZV6Lvwx3og5Q
Ue7WsvB+I+JETEK/skTdtPQaobPsEU1eK4nDB1RmsxSy+49XfDtVKNuTHCXGt7OM
MOxVD1zQxMbWXg8YEmhA/YFteqBSDjP88CAL1z1G3UBGNEv00k1lPbLOLcEkYMUK
tLcnHbwshBaC1odwcn6GkhBkwHIJ43YnT2QY3+p/lum9ZCBdz8Njui6c/a1cKC31
01MNm6AnUNAGo74m1s8Ojo+vLyVpqg==
=//z2
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
