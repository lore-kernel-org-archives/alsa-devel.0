From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V5 3/3] ASoC: AMD: add AMD ASoC ACP-I2S
	driver
Date: Thu, 20 Aug 2015 16:18:48 -0700
Message-ID: <20150820231848.GX12027@sirena.org.uk>
References: <1440106594-29564-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6278207298852297319=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 47ED126538B
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2015 01:19:02 +0200 (CEST)
In-Reply-To: <1440106594-29564-1-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alsa-devel@alsa-project.org, maruthi.bayyavarapu@amd.com, tiwai@suse.de, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, airlied@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6278207298852297319==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YG0IFkGWIt6MbjRk"
Content-Disposition: inline


--YG0IFkGWIt6MbjRk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2015 at 05:36:34PM -0400, Alex Deucher wrote:
> From: Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>
>=20
> ACP IP block consists of dedicated DMA and I2S blocks. The PCM driver
> provides the DMA and CPU DAI components to ALSA core.

This is flagged as patch 3/3 but appears to be sent as a single patch.
Please don't do this, the purpose of numbering patches is to help people
tell which order they are in.  Numbering only makes sense when you send
more than one patch, if you are sending a single patch there is no need
to number.

> +++ b/sound/soc/amd/Kconfig
> @@ -0,0 +1,5 @@
> +config SND_SOC_AMD_ACP
> +	tristate "AMD Audio Coprocessor support"
> +	depends on MFD_CORE

What is the dependency on the MFD core?

> +/*
> + * AMD ALSA SoC PCM Driver
> + *
> + * Copyright 2014-2015 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.

Still not happy with the licensing.

> +static const struct snd_soc_component_driver dw_i2s_component =3D {
> +	.name =3D "dw-i2s",
> +};

We already have a driver for the DesignWare I2S controller.  To repeat
the concern I raised in a slightly different bit of the code last time:

| This doesn't appear to be a designware-i2s driver, we already have one
| of those? =20

Like I say please stop ignoring review comments.  The hw_params()
certainly seems to bear more than a passing resemblance.

> +static void acp_pcm_period_elapsed(struct device *dev, u16 play_intr,
> +							u16 capture_intr)
> +{
> +	struct snd_pcm_substream *substream;
> +	struct audio_drv_data *irq_data =3D dev_get_drvdata(dev);
> +
> +	/* Inform ALSA about the period elapsed (one out of two periods) */
> +	if (play_intr)
> +		substream =3D irq_data->play_stream;
> +	else
> +		substream =3D irq_data->capture_stream;

So you've replaced the two if statements with an if/else which means
subsstream is now guaranteed to be initialized but perhaps not in the
way the caller intended...  I did find the caller (which got moved into
another patch in this version) and it appears that the two u16s are
actually used to pass boolean flags.  The whole interface here now
seems odd, what is going on here?

> +	if (NULL !=3D pg) {

We still normally write these checks more like (pg !=3D NULL) or even just
(pg).

> +		/* Save for runtime private data */
> +		rtd->pg =3D pg;
> +		rtd->order =3D get_order(size);
> +
> +		/* Let ACP know the Allocated memory */
> +		num_of_pages =3D PAGE_ALIGN(size) >> PAGE_SHIFT;
> +
> +		/* Fill the page table entries in ACP SRAM */
> +		rtd->pg =3D pg;
> +		rtd->size =3D size;
> +		rtd->num_of_pages =3D num_of_pages;
> +		rtd->direction =3D substream->stream;
> +
> +		acp_dev->config_dma(acp_dev, rtd);
> +		status =3D 0;
> +	} else {
> +		status =3D -ENOMEM;
> +	}
> +	return status;
> +}
> +
> +static int acp_dma_hw_free(struct snd_pcm_substream *substream)
> +{
> +	return snd_pcm_lib_free_pages(substream);
> +}

hw_free() doesn't seem to undo everything that we did on allocation?

> +		/* Now configure DMA to transfer only first half of System RAM
> +		 * buffer before playback is triggered. This will overwrite
> +		 * zero-ed second half of SRAM buffer */
> +		acp_dev->config_dma_channel(acp_dev, SYSRAM_TO_ACP_CH_NUM,
> +					PLAYBACK_START_DMA_DESCR_CH12,
> +					1, 0);

| Why?  The comments describe what's happening but it's not clear why it's
| happening.

> +static struct snd_soc_dai_driver i2s_dai_driver =3D {
> +	.playback =3D {
> +		     .stream_name =3D "I2S Playback",
> +		     .channels_min =3D 2,
> +		     .channels_max =3D 2,

Elsewhere support for 8 channels was declared and handled.

> +		     .rates =3D SNDRV_PCM_RATE_8000_96000,
> +		     .formats =3D SNDRV_PCM_FMTBIT_S24_LE |
> +				SNDRV_PCM_FMTBIT_S32_LE,

Elsewhere there was 16 bit support declared and handled.

> +	pm_rts =3D pm_runtime_status_suspended(dev);
> +	if (pm_rts =3D=3D true) {

There seem to be a lot of variables in here that have only one
assignment and one user immediately next to them.  I'm not sure it's
adding much.

--YG0IFkGWIt6MbjRk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV1mBXAAoJECTWi3JdVIfQTrwH/084e8BHZIUySowBJC1XuepX
+HS+KI569PlGrmFHUJ59sWiya3INocgLoGeCbGSN9xfGfHR117t/hOlTAp96WK6l
K09SZvczBQr07sAxdTBZdmabeCFsNE0CDwc8c/yH97ZOHRsH/BvAVvFclDhe9zza
lcx1kf0xNQnZBtYYp9N/hlQd2ui8sgkJMEEv1Ez7h5m45VfByaAtNdoKG7ScQv01
OECWG91nbM4yG0HU3t/zUA8oCE5ptyDDf/ZMNefow9Oa8flejcob55OEzPGZ4Xqj
8OpOfCkKwXTLwflJQRRLKSoIhJpiZWj+QwNKHgEnGsuYlwevTNB6qrRJ9go/ADI=
=E1k9
-----END PGP SIGNATURE-----

--YG0IFkGWIt6MbjRk--

--===============6278207298852297319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6278207298852297319==--
