From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: amd: use DMA addr rather than CPU pa for audio
 buffer
Date: Thu, 1 Aug 2019 13:59:08 +0100
Message-ID: <20190801125908.GD5488@sirena.org.uk>
References: <1564402115-5043-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RYJh/3oyKhIjGcML"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1564402115-5043-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
Cc: Alexander.Deucher@amd.com, Vijendar Mukunda <vijendar.mukunda@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>, YueHaibing <yuehaibing@huawei.com>, Colin Ian King <colin.king@canonical.com>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--RYJh/3oyKhIjGcML
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2019 at 05:38:29PM +0530, Ravulapati Vishnu vardhan rao wro=
te:
> We shouldn't assume CPU physical address we get from page_to_phys()
> is same as DMA address we get from dma_alloc_coherent(). On x86_64,
> we won't run into any problem with the assumption when dma_ops is
> nommu_dma_ops. However, DMA address is IOVA when IOMMU is enabled.
> And it's most likely different from CPU physical address when AMD
> IOMMU is not in passthrough mode.

This doesn't build for me:

sound/soc/amd/raven/acp3x-pcm-dma.c: In function =E2=80=98acp3x_dma_hw_para=
ms=E2=80=99:
sound/soc/amd/raven/acp3x-pcm-dma.c:356:2: error: =E2=80=98pg=E2=80=99 unde=
clared (first use in this function)
  pg =3D virt_to_page(substream->dma_buffer.area);
  ^~
sound/soc/amd/raven/acp3x-pcm-dma.c:356:2: note: each undeclared identifier=
 is reported only once for each function it appears in

Please check and resend.

--RYJh/3oyKhIjGcML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1C4hwACgkQJNaLcl1U
h9C3Fwf7BOfEN4vmffpRJH10Vx7KKitOuorUGoZ4MzdoFmDEvZdkppuWO4WKlp1s
KoulKALI7savBZjmK+EgHjLCgxfg+hDlXd06YhxKf3RRAA0ocYtbMkjpCbzuu1Oi
+9ov2FjktSCXcGTH2/ozG7EBkUsj4BYcMAHRxrjM9RL25BLY0ZnGdBzNfxQUOId4
joH3Z68hx0+X32BPAELE9/8aujIOta+AIeDcMc7mHED2g2HjdeK6IaRRGYAr49CU
pDoQe1N+gw+rzO5IYG4E9q4+ptdLGWxMkeX16vPem/21TWsXZJln0ybieo9XRBI0
bd//ujEu7ChIeKelc2b+VjO+A++Ojg==
=BI5i
-----END PGP SIGNATURE-----

--RYJh/3oyKhIjGcML--
