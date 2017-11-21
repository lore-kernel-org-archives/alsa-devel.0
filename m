From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] ASoC: amd: Add error checking to probe function
Date: Tue, 21 Nov 2017 04:47:13 +0000
Message-ID: <BN6PR12MB16524EF04A6F7050D60AC602F7230@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1511238476-10314-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1511238476-10314-1-git-send-email-linux@roeck-us.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: 'Guenter Roeck' <linux@roeck-us.net>, Liam Girdwood <lgirdwood@gmail.com>, "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>, "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Cc: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dominik Behr <dbehr@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter
> Roeck
> Sent: Monday, November 20, 2017 11:28 PM
> To: Liam Girdwood
> Cc: Mark Brown; Jaroslav Kysela; Takashi Iwai; alsa-devel@alsa-project.or=
g;
> linux-kernel@vger.kernel.org; Guenter Roeck; Deucher, Alexander; Dominik
> Behr; Daniel Kurtz
> Subject: [PATCH] ASoC: amd: Add error checking to probe function
>=20
> The acp_audio_dma does not perform sufficient error checking in its probe
> function. This can result in crashes if a critical error path is
> encountered.
>=20
> Fixes: 7c31335a03b6a ("ASoC: AMD: add AMD ASoC ACP 2.x DMA driver")
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Dominik Behr <dbehr@chromium.org>
> Cc: Daniel Kurtz <djkurtz@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> I didn't add an error check to acp_init() since I was not sure if
> its return value is ignored on purpose.

Vijendar, Akshu can you comment?

The patch looks good to me.
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>=20
>  sound/soc/amd/acp-pcm-dma.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-
> dma.c
> index 9f521a55d610..b5e41df6bb3a 100644
> --- a/sound/soc/amd/acp-pcm-dma.c
> +++ b/sound/soc/amd/acp-pcm-dma.c
> @@ -1051,6 +1051,11 @@ static int acp_audio_probe(struct platform_device
> *pdev)
>  	struct resource *res;
>  	const u32 *pdata =3D pdev->dev.platform_data;
>=20
> +	if (!pdata) {
> +		dev_err(&pdev->dev, "Missing platform data\n");
> +		return -ENODEV;
> +	}
> +
>  	audio_drv_data =3D devm_kzalloc(&pdev->dev, sizeof(struct
> audio_drv_data),
>  					GFP_KERNEL);
>  	if (audio_drv_data =3D=3D NULL)
> @@ -1058,6 +1063,8 @@ static int acp_audio_probe(struct platform_device
> *pdev)
>=20
>  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	audio_drv_data->acp_mmio =3D devm_ioremap_resource(&pdev-
> >dev, res);
> +	if (IS_ERR(audio_drv_data->acp_mmio))
> +		return PTR_ERR(audio_drv_data->acp_mmio);
>=20
>  	/* The following members gets populated in device 'open'
>  	 * function. Till then interrupts are disabled in 'acp_init'
> --
> 2.7.4
