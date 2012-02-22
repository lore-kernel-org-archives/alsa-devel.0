From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 4/7] ASoC: Add dmaengine PCM helper functions
Date: Wed, 22 Feb 2012 13:00:27 +0000
Message-ID: <20120222130027.GC7340@opensource.wolfsonmicro.com>
References: <1329904151-5927-1-git-send-email-lars@metafoo.de>
	<1329904151-5927-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4541261520593989951=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AFC68103EF0
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 14:00:29 +0100 (CET)
In-Reply-To: <1329904151-5927-5-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Wolfram Sang <w.sang@pengutronix.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mika Westerberg <mika.westerberg@iki.fi>, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============4541261520593989951==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t0UkRYy7tHLRMCai"
Content-Disposition: inline


--t0UkRYy7tHLRMCai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 22, 2012 at 10:49:08AM +0100, Lars-Peter Clausen wrote:
> This patch adds a set of functions which are intended to be used when
> implementing a dmaengine based sound PCM driver.

Adding Morimoto-san as he has just implemented dmaengine support for
fsi which should also be able to use the same framework.  Not cutting
any of the text so he can see it.

>=20
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Tested-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  include/sound/dmaengine_pcm.h |   49 +++++++
>  sound/soc/Kconfig             |    3 +
>  sound/soc/Makefile            |    3 +
>  sound/soc/soc-dmaengine-pcm.c |  287 +++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 342 insertions(+), 0 deletions(-)
>  create mode 100644 include/sound/dmaengine_pcm.h
>  create mode 100644 sound/soc/soc-dmaengine-pcm.c
>=20
> diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
> new file mode 100644
> index 0000000..a8fcaa6
> --- /dev/null
> +++ b/include/sound/dmaengine_pcm.h
> @@ -0,0 +1,49 @@
> +/*
> + *  Copyright (C) 2012, Analog Devices Inc.
> + *	Author: Lars-Peter Clausen <lars@metafoo.de>
> + *
> + *  This program is free software; you can redistribute it and/or modify=
 it
> + *  under  the terms of the GNU General  Public License as published by =
the
> + *  Free Software Foundation;  either version 2 of the License, or (at y=
our
> + *  option) any later version.
> + *
> + *  You should have received a copy of the GNU General Public License al=
ong
> + *  with this program; if not, write to the Free Software Foundation, In=
c.,
> + *  675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + */
> +#ifndef __SOUND_DMAENGINE_PCM_H__
> +#define __SOUND_DMAENGINE_PCM_H__
> +
> +#include <sound/pcm.h>
> +#include <linux/dmaengine.h>
> +
> +/**
> + * snd_pcm_substream_to_dma_direction - Get dma_transfer_direction for a=
 PCM
> + *   substream
> + * @substream: PCM substream
> + */
> +static inline enum dma_transfer_direction
> +snd_pcm_substream_to_dma_direction(const struct snd_pcm_substream *subst=
ream)
> +{
> +	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
> +		return DMA_MEM_TO_DEV;
> +	else
> +		return DMA_DEV_TO_MEM;
> +}
> +
> +void snd_dmaengine_pcm_set_data(struct snd_pcm_substream *substream, voi=
d *data);
> +void *snd_dmaengine_pcm_get_data(struct snd_pcm_substream *substream);
> +
> +int snd_hwparams_to_dma_slave_config(const struct snd_pcm_substream *sub=
stream,
> +	const struct snd_pcm_hw_params *params, struct dma_slave_config *slave_=
config);
> +int snd_dmaengine_pcm_trigger(struct snd_pcm_substream *substream, int c=
md);
> +snd_pcm_uframes_t snd_dmaengine_pcm_pointer(struct snd_pcm_substream *su=
bstream);
> +
> +int snd_dmaengine_pcm_open(struct snd_pcm_substream *substream,
> +	dma_filter_fn filter_fn, void *filter_data);
> +int snd_dmaengine_pcm_close(struct snd_pcm_substream *substream);
> +
> +struct dma_chan *snd_dmaengine_pcm_get_chan(struct snd_pcm_substream *su=
bstream);
> +
> +#endif
> diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
> index 35e662d..91c9855 100644
> --- a/sound/soc/Kconfig
> +++ b/sound/soc/Kconfig
> @@ -25,6 +25,9 @@ if SND_SOC
>  config SND_SOC_AC97_BUS
>  	bool
> =20
> +config SND_SOC_DMAENGINE_PCM
> +	bool
> +
>  # All the supported SoCs
>  source "sound/soc/atmel/Kconfig"
>  source "sound/soc/au1x/Kconfig"
> diff --git a/sound/soc/Makefile b/sound/soc/Makefile
> index 9ea8ac8..2feaf37 100644
> --- a/sound/soc/Makefile
> +++ b/sound/soc/Makefile
> @@ -1,6 +1,9 @@
>  snd-soc-core-objs :=3D soc-core.o soc-dapm.o soc-jack.o soc-cache.o soc-=
utils.o
>  snd-soc-core-objs +=3D soc-pcm.o soc-io.o
> =20
> +snd-soc-dmaengine-pcm-objs :=3D soc-dmaengine-pcm.o
> +obj-$(CONFIG_SND_SOC_DMAENGINE_PCM) +=3D snd-soc-dmaengine-pcm.o
> +
>  obj-$(CONFIG_SND_SOC)	+=3D snd-soc-core.o
>  obj-$(CONFIG_SND_SOC)	+=3D codecs/
>  obj-$(CONFIG_SND_SOC)	+=3D atmel/
> diff --git a/sound/soc/soc-dmaengine-pcm.c b/sound/soc/soc-dmaengine-pcm.c
> new file mode 100644
> index 0000000..0526cf8
> --- /dev/null
> +++ b/sound/soc/soc-dmaengine-pcm.c
> @@ -0,0 +1,287 @@
> +/*
> + *  Copyright (C) 2012, Analog Devices Inc.
> + *	Author: Lars-Peter Clausen <lars@metafoo.de>
> + *
> + *  Based on:
> + *	imx-pcm-dma-mx2.c, Copyright 2009 Sascha Hauer <s.hauer@pengutronix.d=
e>
> + *	mxs-pcm.c, Copyright (C) 2011 Freescale Semiconductor, Inc.
> + *	ep93xx-pcm.c, Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofl=
y.org>
> + *		      Copyright (C) 2006 Applied Data Systems
> + *
> + *  This program is free software; you can redistribute it and/or modify=
 it
> + *  under  the terms of the GNU General  Public License as published by =
the
> + *  Free Software Foundation;  either version 2 of the License, or (at y=
our
> + *  option) any later version.
> + *
> + *  You should have received a copy of the GNU General Public License al=
ong
> + *  with this program; if not, write to the Free Software Foundation, In=
c.,
> + *  675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + */
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/dmaengine.h>
> +#include <linux/slab.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +
> +#include <sound/dmaengine_pcm.h>
> +
> +struct dmaengine_pcm_runtime_data {
> +	struct dma_chan *dma_chan;
> +
> +	unsigned int pos;
> +
> +	void *data;
> +};
> +
> +static inline struct dmaengine_pcm_runtime_data *substream_to_prtd(
> +	const struct snd_pcm_substream *substream)
> +{
> +	return substream->runtime->private_data;
> +}
> +
> +/**
> + * snd_dmaengine_pcm_set_data - Set dmaengine substream private data
> + * @substream: PCM substream
> + * @data: Data to set
> + */
> +void snd_dmaengine_pcm_set_data(struct snd_pcm_substream *substream, voi=
d *data)
> +{
> +	struct dmaengine_pcm_runtime_data *prtd =3D substream_to_prtd(substream=
);
> +
> +	prtd->data =3D data;
> +}
> +EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_set_data);
> +
> +/**
> + * snd_dmaengine_pcm_get_data - Get dmaeinge substream private data
> + * @substream: PCM substream
> + *
> + * Returns the data previously set with snd_dmaengine_pcm_set_data
> + */
> +void *snd_dmaengine_pcm_get_data(struct snd_pcm_substream *substream)
> +{
> +	struct dmaengine_pcm_runtime_data *prtd =3D substream_to_prtd(substream=
);
> +
> +	return prtd->data;
> +}
> +EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_get_data);
> +
> +struct dma_chan *snd_dmaengine_pcm_get_chan(struct snd_pcm_substream *su=
bstream)
> +{
> +	struct dmaengine_pcm_runtime_data *prtd =3D substream_to_prtd(substream=
);
> +
> +	return prtd->dma_chan;
> +}
> +EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_get_chan);
> +
> +/**
> + * snd_hwparams_to_dma_slave_config - Convert hw_params to dma_slave_con=
fig
> + * @substream: PCM substream
> + * @params: hw_params
> + * @slave_config: DMA slave config
> + *
> + * This function can be used to initialize a dma_slave_config from a sub=
stream
> + * and hw_params in a dmaengine based PCM driver implementation.
> + */
> +int snd_hwparams_to_dma_slave_config(const struct snd_pcm_substream *sub=
stream,
> +	const struct snd_pcm_hw_params *params,
> +	struct dma_slave_config *slave_config)
> +{
> +	enum dma_slave_buswidth buswidth;
> +
> +	switch (params_format(params)) {
> +	case SNDRV_PCM_FORMAT_S8:
> +		buswidth =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
> +		break;
> +	case SNDRV_PCM_FORMAT_S16_LE:
> +		buswidth =3D DMA_SLAVE_BUSWIDTH_2_BYTES;
> +		break;
> +	case SNDRV_PCM_FORMAT_S18_3LE:
> +	case SNDRV_PCM_FORMAT_S20_3LE:
> +	case SNDRV_PCM_FORMAT_S24_LE:
> +	case SNDRV_PCM_FORMAT_S32_LE:
> +		buswidth =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
> +		slave_config->direction =3D DMA_MEM_TO_DEV;
> +		slave_config->dst_addr_width =3D buswidth;
> +	} else {
> +		slave_config->direction =3D DMA_DEV_TO_MEM;
> +		slave_config->src_addr_width =3D buswidth;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(snd_hwparams_to_dma_slave_config);
> +
> +static void dmaengine_pcm_dma_complete(void *arg)
> +{
> +	struct snd_pcm_substream *substream =3D arg;
> +	struct dmaengine_pcm_runtime_data *prtd =3D substream_to_prtd(substream=
);
> +
> +	prtd->pos +=3D snd_pcm_lib_period_bytes(substream);
> +	if (prtd->pos >=3D snd_pcm_lib_buffer_bytes(substream))
> +		prtd->pos =3D 0;
> +
> +	snd_pcm_period_elapsed(substream);
> +}
> +
> +static int dmaengine_pcm_prepare_and_submit(struct snd_pcm_substream *su=
bstream)
> +{
> +	struct dmaengine_pcm_runtime_data *prtd =3D substream_to_prtd(substream=
);
> +	struct dma_chan *chan =3D prtd->dma_chan;
> +	struct dma_async_tx_descriptor *desc;
> +	enum dma_transfer_direction direction;
> +
> +	direction =3D snd_pcm_substream_to_dma_direction(substream);
> +
> +	desc =3D chan->device->device_prep_dma_cyclic(chan,
> +		substream->runtime->dma_addr,
> +		snd_pcm_lib_buffer_bytes(substream),
> +		snd_pcm_lib_period_bytes(substream), direction);
> +
> +	if (!desc)
> +		return -ENOMEM;
> +
> +	desc->callback =3D dmaengine_pcm_dma_complete;
> +	desc->callback_param =3D substream;
> +	dmaengine_submit(desc);
> +
> +	return 0;
> +}
> +
> +/**
> + * snd_dmaengine_pcm_trigger - dmaengine based PCM trigger implementation
> + * @substream: PCM substream
> + * @cmd: Trigger command
> + *
> + * Returns 0 on success, a negative error code otherwise.
> + *
> + * This function can be used as the PCM trigger callback for dmaengine b=
ased PCM
> + * driver implementations.
> + */
> +int snd_dmaengine_pcm_trigger(struct snd_pcm_substream *substream, int c=
md)
> +{
> +	struct dmaengine_pcm_runtime_data *prtd =3D substream_to_prtd(substream=
);
> +	int ret;
> +
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +		ret =3D dmaengine_pcm_prepare_and_submit(substream);
> +		if (ret)
> +			return ret;
> +		dma_async_issue_pending(prtd->dma_chan);
> +		break;
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		dmaengine_resume(prtd->dma_chan);
> +		break;
> +	case SNDRV_PCM_TRIGGER_SUSPEND:
> +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +		dmaengine_pause(prtd->dma_chan);
> +		break;
> +	case SNDRV_PCM_TRIGGER_STOP:
> +		dmaengine_terminate_all(prtd->dma_chan);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_trigger);
> +
> +/**
> + * snd_dmaengine_pcm_pointer - dmaengine based PCM pointer implementation
> + * @substream: PCM substream
> + *
> + * This function can be used as the PCM pointer callback for dmaengine b=
ased PCM
> + * driver implementations.
> + */
> +snd_pcm_uframes_t snd_dmaengine_pcm_pointer(struct snd_pcm_substream *su=
bstream)
> +{
> +	struct dmaengine_pcm_runtime_data *prtd =3D substream_to_prtd(substream=
);
> +	return bytes_to_frames(substream->runtime, prtd->pos);
> +}
> +EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_pointer);
> +
> +static int dmaengine_pcm_request_channel(struct dmaengine_pcm_runtime_da=
ta *prtd,
> +	dma_filter_fn filter_fn, void *filter_data)
> +{
> +	dma_cap_mask_t mask;
> +
> +	dma_cap_zero(mask);
> +	dma_cap_set(DMA_SLAVE, mask);
> +	dma_cap_set(DMA_CYCLIC, mask);
> +	prtd->dma_chan =3D dma_request_channel(mask, filter_fn, filter_data);
> +
> +	if (!prtd->dma_chan)
> +		return -ENXIO;
> +
> +	return 0;
> +}
> +
> +/**
> + * snd_dmaengine_pcm_open - Open a dmaengine based PCM substream
> + * @substream: PCM substream
> + * @filter_fn: Filter function used to request the DMA channel
> + * @filter_data: Data passed to the DMA filter function
> + *
> + * Returns 0 on success, a negative error code otherwise.
> + *
> + * This function will request a DMA channel using the passed filter func=
tion and
> + * data. The function should usually be called from the pcm open callbac=
k.
> + *
> + * Note that this function will use private_data field of the substream's
> + * runtime. So it is not availabe to your pcm driver implementation. If =
you need
> + * to keep additional data attached to a substream use
> + * snd_dmaeinge_pcm_{set,get}_data.
> + */
> +int snd_dmaengine_pcm_open(struct snd_pcm_substream *substream,
> +	dma_filter_fn filter_fn, void *filter_data)
> +{
> +	struct dmaengine_pcm_runtime_data *prtd;
> +	int ret;
> +
> +	ret =3D snd_pcm_hw_constraint_integer(substream->runtime,
> +					    SNDRV_PCM_HW_PARAM_PERIODS);
> +	if (ret < 0)
> +		return ret;
> +
> +	prtd =3D kzalloc(sizeof(*prtd), GFP_KERNEL);
> +	if (!prtd)
> +		return -ENOMEM;
> +
> +	ret =3D dmaengine_pcm_request_channel(prtd, filter_fn, filter_data);
> +	if (ret < 0) {
> +		kfree(prtd);
> +		return ret;
> +	}
> +
> +	substream->runtime->private_data =3D prtd;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_open);
> +
> +/**
> + * snd_dmaengine_pcm_close - Close a dmaengine based PCM substream
> + * @substream: PCM substream
> + */
> +int snd_dmaengine_pcm_close(struct snd_pcm_substream *substream)
> +{
> +	struct dmaengine_pcm_runtime_data *prtd =3D substream_to_prtd(substream=
);
> +
> +	dma_release_channel(prtd->dma_chan);
> +	kfree(prtd);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_close);
> --=20
> 1.7.9
>=20

--t0UkRYy7tHLRMCai
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPRObjAAoJEBus8iNuMP3drm0P/jvTmWMl2Yh5/3SQxy38ccaM
cBToAtn41/zNJasREFs0x8Ot4PWw81S1v8hy3l+yx3kUCSJnCeOLDQgbXfTGrq8W
ToN0IuhpHPffd33XZ3j8ksZOrVxfrc9cjjNjL9MWBr0l8RLrD6XYDMM3EVZCac9o
OGgT+CCpknNPrSAWbz90HV+3iM1o/A3tHqplZ85InNZZFQ6HgtH9/T1ErQkV4Tnt
VEpmXpui6Q8OJoQi1e2lXgSNhG6/1YmAg8iCBzXRkv4uSUjIJA6VarxCp+MXWl2v
5RIrHr1dn+48gadL2OLXKgDmsQnPT20g9Zoq/2Ic0rwWJL1dTjUSPkMyIAO/Go7X
v6eh6QtDfuqlGXRiadad5QPP8CfeWf1ZY1ndNAjI7TEWhzB1xsrF2BaiuwW/FHbu
7w4XYz9s/PWRXVr2SijIak/kSC1vVORbIMkn2ekUxIerPE4okzppnnpliSilUnIl
3lz2haotnYtdtZAu7a+zU0Qgj6V/8NcKqbv+4BgXAq5EFIVPlUMaf0RdQyM6N8J1
2yBE1eJyLOKDIVi7E4NEXneCpkRNkK75bgGH3bY5cwByuoO7o8or/JOfgSOazMjg
QJGz1yJABvT0iom51E6H6rSbq9x3qIEXPk/dBX0+lU8vHTgEJmO0cshEz/est0/k
+6JTRRvG3gXD1yU5W3Ow
=qP6H
-----END PGP SIGNATURE-----

--t0UkRYy7tHLRMCai--

--===============4541261520593989951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4541261520593989951==--
