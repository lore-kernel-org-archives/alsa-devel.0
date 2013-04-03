From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 8/8] ASoC: omap: Use common DAI DMA data
Date: Wed, 3 Apr 2013 12:06:43 +0200
Message-ID: <515BFF33.6070905@ti.com>
References: <1364979607-15286-1-git-send-email-lars@metafoo.de>
 <1364979965-15776-1-git-send-email-lars@metafoo.de>
 <1364979965-15776-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id EC43A265338
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 12:06:48 +0200 (CEST)
In-Reply-To: <1364979965-15776-4-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Laxman Dewangan <ldewangan@nvidia.com>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On 04/03/2013 11:06 AM, Lars-Peter Clausen wrote:
> Use the common DAI DMA data struct for omap, this allows us to use the co=
mmon
> helper function to configure the DMA slave config based on the DAI DMA da=
ta.
> =

> For omap-dmic and omap-mcpdm also move the DMA data from a global variabl=
e to
> the driver state struct.
> =

> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Looks good, works fine.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> ---
>  sound/soc/omap/am3517evm.c        |  1 -
>  sound/soc/omap/ams-delta.c        |  1 -
>  sound/soc/omap/mcbsp.c            | 14 +++++++------
>  sound/soc/omap/mcbsp.h            |  7 ++++---
>  sound/soc/omap/n810.c             |  1 -
>  sound/soc/omap/omap-abe-twl6040.c |  1 -
>  sound/soc/omap/omap-dmic.c        | 22 ++++++++++----------
>  sound/soc/omap/omap-hdmi.c        | 24 ++++++++++------------
>  sound/soc/omap/omap-mcbsp.c       |  6 +++---
>  sound/soc/omap/omap-mcpdm.c       | 31 +++++++++++++----------------
>  sound/soc/omap/omap-pcm.c         | 42 +++++----------------------------=
------
>  sound/soc/omap/omap-pcm.h         | 39 ---------------------------------=
---
>  sound/soc/omap/omap-twl4030.c     |  1 -
>  sound/soc/omap/omap3pandora.c     |  1 -
>  sound/soc/omap/osk5912.c          |  1 -
>  sound/soc/omap/rx51.c             |  1 -
>  16 files changed, 54 insertions(+), 139 deletions(-)
>  delete mode 100644 sound/soc/omap/omap-pcm.h
> =

> diff --git a/sound/soc/omap/am3517evm.c b/sound/soc/omap/am3517evm.c
> index c1900b2..994dcf3 100644
> --- a/sound/soc/omap/am3517evm.c
> +++ b/sound/soc/omap/am3517evm.c
> @@ -28,7 +28,6 @@
>  #include <linux/platform_data/asoc-ti-mcbsp.h>
>  =

>  #include "omap-mcbsp.h"
> -#include "omap-pcm.h"
>  =

>  #include "../codecs/tlv320aic23.h"
>  =

> diff --git a/sound/soc/omap/ams-delta.c b/sound/soc/omap/ams-delta.c
> index 2600447..6294464 100644
> --- a/sound/soc/omap/ams-delta.c
> +++ b/sound/soc/omap/ams-delta.c
> @@ -36,7 +36,6 @@
>  #include <linux/platform_data/asoc-ti-mcbsp.h>
>  =

>  #include "omap-mcbsp.h"
> -#include "omap-pcm.h"
>  #include "../codecs/cx20442.h"
>  =

>  =

> diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
> index 285c836..eb68c7d 100644
> --- a/sound/soc/omap/mcbsp.c
> +++ b/sound/soc/omap/mcbsp.c
> @@ -1018,9 +1018,10 @@ int omap_mcbsp_init(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  	/* RX DMA request number, and port address configuration */
> -	mcbsp->dma_data[1].name =3D "Audio Capture";
> -	mcbsp->dma_data[1].dma_req =3D res->start;
> -	mcbsp->dma_data[1].port_addr =3D omap_mcbsp_dma_reg_params(mcbsp, 1);
> +	mcbsp->dma_req[1] =3D res->start;
> +	mcbsp->dma_data[1].filter_data =3D &mcbsp->dma_req[1];
> +	mcbsp->dma_data[1].addr =3D omap_mcbsp_dma_reg_params(mcbsp, 1);
> +	mcbsp->dma_data[1].maxburst =3D 4;
>  =

>  	res =3D platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
>  	if (!res) {
> @@ -1028,9 +1029,10 @@ int omap_mcbsp_init(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  	/* TX DMA request number, and port address configuration */
> -	mcbsp->dma_data[0].name =3D "Audio Playback";
> -	mcbsp->dma_data[0].dma_req =3D res->start;
> -	mcbsp->dma_data[0].port_addr =3D omap_mcbsp_dma_reg_params(mcbsp, 0);
> +	mcbsp->dma_req[0] =3D res->start;
> +	mcbsp->dma_data[0].filter_data =3D &mcbsp->dma_req[0];
> +	mcbsp->dma_data[0].addr =3D omap_mcbsp_dma_reg_params(mcbsp, 0);
> +	mcbsp->dma_data[0].maxburst =3D 4;
>  =

>  	mcbsp->fclk =3D clk_get(&pdev->dev, "fck");
>  	if (IS_ERR(mcbsp->fclk)) {
> diff --git a/sound/soc/omap/mcbsp.h b/sound/soc/omap/mcbsp.h
> index f93e0b0..96d1b08 100644
> --- a/sound/soc/omap/mcbsp.h
> +++ b/sound/soc/omap/mcbsp.h
> @@ -24,14 +24,14 @@
>  #ifndef __ASOC_MCBSP_H
>  #define __ASOC_MCBSP_H
>  =

> -#include "omap-pcm.h"
> -
>  #ifdef CONFIG_ARCH_OMAP1
>  #define mcbsp_omap1()	1
>  #else
>  #define mcbsp_omap1()	0
>  #endif
>  =

> +#include <sound/dmaengine_pcm.h>
> +
>  /* McBSP register numbers. Register address offset =3D num * reg_step */
>  enum {
>  	/* Common registers */
> @@ -312,7 +312,8 @@ struct omap_mcbsp {
>  	struct omap_mcbsp_platform_data *pdata;
>  	struct omap_mcbsp_st_data *st_data;
>  	struct omap_mcbsp_reg_cfg cfg_regs;
> -	struct omap_pcm_dma_data dma_data[2];
> +	struct snd_dmaengine_dai_dma_data dma_data[2];
> +	unsigned int dma_req[2];
>  	int dma_op_mode;
>  	u16 max_tx_thres;
>  	u16 max_rx_thres;
> diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
> index ee7cd53..5e8d640 100644
> --- a/sound/soc/omap/n810.c
> +++ b/sound/soc/omap/n810.c
> @@ -34,7 +34,6 @@
>  #include <linux/platform_data/asoc-ti-mcbsp.h>
>  =

>  #include "omap-mcbsp.h"
> -#include "omap-pcm.h"
>  =

>  #define N810_HEADSET_AMP_GPIO	10
>  #define N810_SPEAKER_AMP_GPIO	101
> diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-=
twl6040.c
> index e7d93fa..70cd5c7 100644
> --- a/sound/soc/omap/omap-abe-twl6040.c
> +++ b/sound/soc/omap/omap-abe-twl6040.c
> @@ -34,7 +34,6 @@
>  =

>  #include "omap-dmic.h"
>  #include "omap-mcpdm.h"
> -#include "omap-pcm.h"
>  #include "../codecs/twl6040.h"
>  =

>  struct abe_twl6040 {
> diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
> index 37f4539..2ad0370 100644
> --- a/sound/soc/omap/omap-dmic.c
> +++ b/sound/soc/omap/omap-dmic.c
> @@ -39,8 +39,8 @@
>  #include <sound/pcm_params.h>
>  #include <sound/initval.h>
>  #include <sound/soc.h>
> +#include <sound/dmaengine_pcm.h>
>  =

> -#include "omap-pcm.h"
>  #include "omap-dmic.h"
>  =

>  struct omap_dmic {
> @@ -55,13 +55,9 @@ struct omap_dmic {
>  	u32 ch_enabled;
>  	bool active;
>  	struct mutex mutex;
> -};
>  =

> -/*
> - * Stream DMA parameters
> - */
> -static struct omap_pcm_dma_data omap_dmic_dai_dma_params =3D {
> -	.name		=3D "DMIC capture",
> +	struct snd_dmaengine_dai_dma_data dma_data;
> +	unsigned int dma_req;
>  };
>  =

>  static inline void omap_dmic_write(struct omap_dmic *dmic, u16 reg, u32 =
val)
> @@ -118,7 +114,7 @@ static int omap_dmic_dai_startup(struct snd_pcm_subst=
ream *substream,
>  =

>  	mutex_unlock(&dmic->mutex);
>  =

> -	snd_soc_dai_set_dma_data(dai, substream, &omap_dmic_dai_dma_params);
> +	snd_soc_dai_set_dma_data(dai, substream, &dmic->dma_data);
>  	return ret;
>  }
>  =

> @@ -203,7 +199,7 @@ static int omap_dmic_dai_hw_params(struct snd_pcm_sub=
stream *substream,
>  				    struct snd_soc_dai *dai)
>  {
>  	struct omap_dmic *dmic =3D snd_soc_dai_get_drvdata(dai);
> -	struct omap_pcm_dma_data *dma_data;
> +	struct snd_dmaengine_dai_dma_data *dma_data;
>  	int channels;
>  =

>  	dmic->clk_div =3D omap_dmic_select_divider(dmic, params_rate(params));
> @@ -230,7 +226,7 @@ static int omap_dmic_dai_hw_params(struct snd_pcm_sub=
stream *substream,
>  =

>  	/* packet size is threshold * channels */
>  	dma_data =3D snd_soc_dai_get_dma_data(dai, substream);
> -	dma_data->packet_size =3D dmic->threshold * channels;
> +	dma_data->maxburst =3D dmic->threshold * channels;
>  =

>  	return 0;
>  }
> @@ -480,7 +476,7 @@ static int asoc_dmic_probe(struct platform_device *pd=
ev)
>  		ret =3D -ENODEV;
>  		goto err_put_clk;
>  	}
> -	omap_dmic_dai_dma_params.port_addr =3D res->start + OMAP_DMIC_DATA_REG;
> +	dmic->dma_data.addr =3D res->start + OMAP_DMIC_DATA_REG;
>  =

>  	res =3D platform_get_resource(pdev, IORESOURCE_DMA, 0);
>  	if (!res) {
> @@ -488,7 +484,9 @@ static int asoc_dmic_probe(struct platform_device *pd=
ev)
>  		ret =3D -ENODEV;
>  		goto err_put_clk;
>  	}
> -	omap_dmic_dai_dma_params.dma_req =3D res->start;
> +
> +	dmic->dma_req =3D res->start;
> +	dmic->dma_data.filter_data =3D &dmic->dma_req;
>  =

>  	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "mpu");
>  	if (!res) {
> diff --git a/sound/soc/omap/omap-hdmi.c b/sound/soc/omap/omap-hdmi.c
> index 7e120cc..ced3b88 100644
> --- a/sound/soc/omap/omap-hdmi.c
> +++ b/sound/soc/omap/omap-hdmi.c
> @@ -32,15 +32,16 @@
>  #include <sound/soc.h>
>  #include <sound/asound.h>
>  #include <sound/asoundef.h>
> +#include <sound/dmaengine_pcm.h>
>  #include <video/omapdss.h>
>  =

> -#include "omap-pcm.h"
>  #include "omap-hdmi.h"
>  =

>  #define DRV_NAME "omap-hdmi-audio-dai"
>  =

>  struct hdmi_priv {
> -	struct omap_pcm_dma_data dma_params;
> +	struct snd_dmaengine_dai_dma_data dma_data;
> +	unsigned int dma_req;
>  	struct omap_dss_audio dss_audio;
>  	struct snd_aes_iec958 iec;
>  	struct snd_cea_861_aud_if cea;
> @@ -68,7 +69,7 @@ static int omap_hdmi_dai_startup(struct snd_pcm_substre=
am *substream,
>  		return -ENODEV;
>  	}
>  =

> -	snd_soc_dai_set_dma_data(dai, substream, &priv->dma_params);
> +	snd_soc_dai_set_dma_data(dai, substream, &priv->dma_data);
>  =

>  	return 0;
>  }
> @@ -88,25 +89,20 @@ static int omap_hdmi_dai_hw_params(struct snd_pcm_sub=
stream *substream,
>  	struct hdmi_priv *priv =3D snd_soc_dai_get_drvdata(dai);
>  	struct snd_aes_iec958 *iec =3D &priv->iec;
>  	struct snd_cea_861_aud_if *cea =3D &priv->cea;
> -	struct omap_pcm_dma_data *dma_data;
>  	int err =3D 0;
>  =

> -	dma_data =3D snd_soc_dai_get_dma_data(dai, substream);
> -
>  	switch (params_format(params)) {
>  	case SNDRV_PCM_FORMAT_S16_LE:
> -		dma_data->packet_size =3D 16;
> +		priv->dma_data.maxburst =3D 16;
>  		break;
>  	case SNDRV_PCM_FORMAT_S24_LE:
> -		dma_data->packet_size =3D 32;
> +		priv->dma_data.maxburst =3D 32;
>  		break;
>  	default:
>  		dev_err(dai->dev, "format not supported!\n");
>  		return -EINVAL;
>  	}
>  =

> -	dma_data->data_type =3D 32;
> -
>  	/*
>  	 * fill the IEC-60958 channel status word
>  	 */
> @@ -287,8 +283,7 @@ static int omap_hdmi_probe(struct platform_device *pd=
ev)
>  		return -ENODEV;
>  	}
>  =

> -	hdmi_data->dma_params.port_addr =3D  hdmi_rsrc->start
> -		+ OMAP_HDMI_AUDIO_DMA_PORT;
> +	hdmi_data->dma_data.addr =3D hdmi_rsrc->start + OMAP_HDMI_AUDIO_DMA_POR=
T;
>  =

>  	hdmi_rsrc =3D platform_get_resource(pdev, IORESOURCE_DMA, 0);
>  	if (!hdmi_rsrc) {
> @@ -296,8 +291,9 @@ static int omap_hdmi_probe(struct platform_device *pd=
ev)
>  		return -ENODEV;
>  	}
>  =

> -	hdmi_data->dma_params.dma_req =3D  hdmi_rsrc->start;
> -	hdmi_data->dma_params.name =3D "HDMI playback";
> +	hdmi_data->dma_req =3D hdmi_rsrc->start;
> +	hdmi_data->dma_data.filter_data =3D &hdmi_data->dma_req;
> +	hdmi_data->dma_data.addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
>  =

>  	/*
>  	 * TODO: We assume that there is only one DSS HDMI device. Future
> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
> index 1de4213..eadbfb6 100644
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -33,11 +33,11 @@
>  #include <sound/pcm_params.h>
>  #include <sound/initval.h>
>  #include <sound/soc.h>
> +#include <sound/dmaengine_pcm.h>
>  =

>  #include <linux/platform_data/asoc-ti-mcbsp.h>
>  #include "mcbsp.h"
>  #include "omap-mcbsp.h"
> -#include "omap-pcm.h"
>  =

>  #define OMAP_MCBSP_RATES	(SNDRV_PCM_RATE_8000_96000)
>  =

> @@ -224,7 +224,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_su=
bstream *substream,
>  {
>  	struct omap_mcbsp *mcbsp =3D snd_soc_dai_get_drvdata(cpu_dai);
>  	struct omap_mcbsp_reg_cfg *regs =3D &mcbsp->cfg_regs;
> -	struct omap_pcm_dma_data *dma_data;
> +	struct snd_dmaengine_dai_dma_data *dma_data;
>  	int wlen, channels, wpf;
>  	int pkt_size =3D 0;
>  	unsigned int format, div, framesize, master;
> @@ -276,7 +276,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_su=
bstream *substream,
>  		omap_mcbsp_set_threshold(substream, pkt_size);
>  	}
>  =

> -	dma_data->packet_size =3D pkt_size;
> +	dma_data->maxburst =3D pkt_size;
>  =

>  	if (mcbsp->configured) {
>  		/* McBSP already configured by another stream */
> diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
> index 06ab334..eb05c7e 100644
> --- a/sound/soc/omap/omap-mcpdm.c
> +++ b/sound/soc/omap/omap-mcpdm.c
> @@ -39,9 +39,9 @@
>  #include <sound/pcm.h>
>  #include <sound/pcm_params.h>
>  #include <sound/soc.h>
> +#include <sound/dmaengine_pcm.h>
>  =

>  #include "omap-mcpdm.h"
> -#include "omap-pcm.h"
>  =

>  struct mcpdm_link_config {
>  	u32 link_mask; /* channel mask for the direction */
> @@ -64,19 +64,14 @@ struct omap_mcpdm {
>  =

>  	/* McPDM needs to be restarted due to runtime reconfiguration */
>  	bool restart;
> +
> +	struct snd_dmaengine_dai_dma_data dma_data[2];
> +	unsigned int dma_req[2];
>  };
>  =

>  /*
>   * Stream DMA parameters
>   */
> -static struct omap_pcm_dma_data omap_mcpdm_dai_dma_params[] =3D {
> -	{
> -		.name =3D "Audio playback",
> -	},
> -	{
> -		.name =3D "Audio capture",
> -	},
> -};
>  =

>  static inline void omap_mcpdm_write(struct omap_mcpdm *mcpdm, u16 reg, u=
32 val)
>  {
> @@ -272,7 +267,7 @@ static int omap_mcpdm_dai_startup(struct snd_pcm_subs=
tream *substream,
>  	mutex_unlock(&mcpdm->mutex);
>  =

>  	snd_soc_dai_set_dma_data(dai, substream,
> -				 &omap_mcpdm_dai_dma_params[substream->stream]);
> +				 &mcpdm->dma_data[substream->stream]);
>  =

>  	return 0;
>  }
> @@ -302,7 +297,7 @@ static int omap_mcpdm_dai_hw_params(struct snd_pcm_su=
bstream *substream,
>  {
>  	struct omap_mcpdm *mcpdm =3D snd_soc_dai_get_drvdata(dai);
>  	int stream =3D substream->stream;
> -	struct omap_pcm_dma_data *dma_data;
> +	struct snd_dmaengine_dai_dma_data *dma_data;
>  	u32 threshold;
>  	int channels;
>  	int link_mask =3D 0;
> @@ -342,14 +337,14 @@ static int omap_mcpdm_dai_hw_params(struct snd_pcm_=
substream *substream,
>  		if (!mcpdm->config[!stream].link_mask)
>  			mcpdm->config[!stream].link_mask =3D 0x3;
>  =

> -		dma_data->packet_size =3D
> +		dma_data->maxburst =3D
>  				(MCPDM_DN_THRES_MAX - threshold) * channels;
>  	} else {
>  		/* If playback is not running assume a stereo stream to come */
>  		if (!mcpdm->config[!stream].link_mask)
>  			mcpdm->config[!stream].link_mask =3D (0x3 << 3);
>  =

> -		dma_data->packet_size =3D threshold * channels;
> +		dma_data->maxburst =3D threshold * channels;
>  	}
>  =

>  	/* Check if we need to restart McPDM with this stream */
> @@ -479,20 +474,22 @@ static int asoc_mcpdm_probe(struct platform_device =
*pdev)
>  	if (res =3D=3D NULL)
>  		return -ENOMEM;
>  =

> -	omap_mcpdm_dai_dma_params[0].port_addr =3D res->start + MCPDM_REG_DN_DA=
TA;
> -	omap_mcpdm_dai_dma_params[1].port_addr =3D res->start + MCPDM_REG_UP_DA=
TA;
> +	mcpdm->dma_data[0].addr =3D res->start + MCPDM_REG_DN_DATA;
> +	mcpdm->dma_data[1].addr =3D res->start + MCPDM_REG_UP_DATA;
>  =

>  	res =3D platform_get_resource_byname(pdev, IORESOURCE_DMA, "dn_link");
>  	if (!res)
>  		return -ENODEV;
>  =

> -	omap_mcpdm_dai_dma_params[0].dma_req =3D res->start;
> +	mcpdm->dma_req[0] =3D res->start;
> +	mcpdm->dma_data[0].filter_data =3D &mcpdm->dma_req[0];
>  =

>  	res =3D platform_get_resource_byname(pdev, IORESOURCE_DMA, "up_link");
>  	if (!res)
>  		return -ENODEV;
>  =

> -	omap_mcpdm_dai_dma_params[1].dma_req =3D res->start;
> +	mcpdm->dma_req[1] =3D res->start;
> +	mcpdm->dma_data[1].filter_data =3D &mcpdm->dma_req[1];
>  =

>  	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "mpu");
>  	if (res =3D=3D NULL)
> diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
> index 6c842c7..c8e272f 100644
> --- a/sound/soc/omap/omap-pcm.c
> +++ b/sound/soc/omap/omap-pcm.c
> @@ -32,8 +32,6 @@
>  #include <sound/dmaengine_pcm.h>
>  #include <sound/soc.h>
>  =

> -#include "omap-pcm.h"
> -
>  #ifdef CONFIG_ARCH_OMAP1
>  #define pcm_omap1510()	cpu_is_omap1510()
>  #else
> @@ -56,25 +54,6 @@ static const struct snd_pcm_hardware omap_pcm_hardware=
 =3D {
>  	.buffer_bytes_max	=3D 128 * 1024,
>  };
>  =

> -static int omap_pcm_get_dma_buswidth(int num_bits)
> -{
> -	int buswidth;
> -
> -	switch (num_bits) {
> -	case 16:
> -		buswidth =3D DMA_SLAVE_BUSWIDTH_2_BYTES;
> -		break;
> -	case 32:
> -		buswidth =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> -		break;
> -	default:
> -		buswidth =3D -EINVAL;
> -		break;
> -	}
> -	return buswidth;
> -}
> -
> -
>  /* this may get called several times by oss emulation */
>  static int omap_pcm_hw_params(struct snd_pcm_substream *substream,
>  			      struct snd_pcm_hw_params *params)
> @@ -105,20 +84,9 @@ static int omap_pcm_hw_params(struct snd_pcm_substrea=
m *substream,
>  	if (err)
>  		return err;
>  =

> -	/* Override the *_dma addr_width if requested by the DAI driver */
> -	if (dma_data->data_type) {
> -		int buswidth =3D omap_pcm_get_dma_buswidth(dma_data->data_type);
> -
> -		if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
> -			config.dst_addr_width =3D buswidth;
> -		else
> -			config.src_addr_width =3D buswidth;
> -	}
> -
> -	config.src_addr =3D dma_data->port_addr;
> -	config.dst_addr =3D dma_data->port_addr;
> -	config.src_maxburst =3D dma_data->packet_size;
> -	config.dst_maxburst =3D dma_data->packet_size;
> +	snd_dmaengine_pcm_set_config_from_dai_data(substream,
> +			snd_soc_dai_get_dma_data(rtd->cpu_dai, substream),
> +			&config);
>  =

>  	return dmaengine_slave_config(chan, &config);
>  }
> @@ -144,14 +112,14 @@ static snd_pcm_uframes_t omap_pcm_pointer(struct sn=
d_pcm_substream *substream)
>  static int omap_pcm_open(struct snd_pcm_substream *substream)
>  {
>  	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
> -	struct omap_pcm_dma_data *dma_data;
> +	struct snd_dmaengine_dai_dma_data *dma_data;
>  =

>  	snd_soc_set_runtime_hwparams(substream, &omap_pcm_hardware);
>  =

>  	dma_data =3D snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
>  =

>  	return snd_dmaengine_pcm_open(substream, omap_dma_filter_fn,
> -				      &dma_data->dma_req);
> +				      dma_data->filter_data);
>  }
>  =

>  static int omap_pcm_mmap(struct snd_pcm_substream *substream,
> diff --git a/sound/soc/omap/omap-pcm.h b/sound/soc/omap/omap-pcm.h
> deleted file mode 100644
> index 39e6e45..0000000
> --- a/sound/soc/omap/omap-pcm.h
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -/*
> - * omap-pcm.h
> - *
> - * Copyright (C) 2008 Nokia Corporation
> - *
> - * Contact: Jarkko Nikula <jarkko.nikula@bitmer.com>
> - *          Peter Ujfalusi <peter.ujfalusi@ti.com>
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * version 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> - * 02110-1301 USA
> - *
> - */
> -
> -#ifndef __OMAP_PCM_H__
> -#define __OMAP_PCM_H__
> -
> -struct snd_pcm_substream;
> -
> -struct omap_pcm_dma_data {
> -	char		*name;		/* stream identifier */
> -	int		dma_req;	/* DMA request line */
> -	unsigned long	port_addr;	/* transmit/receive register */
> -	int		data_type;	/* 8, 16, 32 (bits) or 0 to let omap-pcm
> -					 * to decide the sDMA data type */
> -	int		packet_size;	/* packet size only in PACKET mode */
> -};
> -
> -#endif
> diff --git a/sound/soc/omap/omap-twl4030.c b/sound/soc/omap/omap-twl4030.c
> index fd98509..2a9324f 100644
> --- a/sound/soc/omap/omap-twl4030.c
> +++ b/sound/soc/omap/omap-twl4030.c
> @@ -43,7 +43,6 @@
>  #include <sound/jack.h>
>  =

>  #include "omap-mcbsp.h"
> -#include "omap-pcm.h"
>  =

>  struct omap_twl4030 {
>  	int jack_detect;	/* board can detect jack events */
> diff --git a/sound/soc/omap/omap3pandora.c b/sound/soc/omap/omap3pandora.c
> index 9e46e1d..cf604a2 100644
> --- a/sound/soc/omap/omap3pandora.c
> +++ b/sound/soc/omap/omap3pandora.c
> @@ -34,7 +34,6 @@
>  #include <linux/platform_data/asoc-ti-mcbsp.h>
>  =

>  #include "omap-mcbsp.h"
> -#include "omap-pcm.h"
>  =

>  #define OMAP3_PANDORA_DAC_POWER_GPIO	118
>  #define OMAP3_PANDORA_AMP_POWER_GPIO	14
> diff --git a/sound/soc/omap/osk5912.c b/sound/soc/omap/osk5912.c
> index 06ef8d6..d03e57d 100644
> --- a/sound/soc/omap/osk5912.c
> +++ b/sound/soc/omap/osk5912.c
> @@ -33,7 +33,6 @@
>  #include <linux/platform_data/asoc-ti-mcbsp.h>
>  =

>  #include "omap-mcbsp.h"
> -#include "omap-pcm.h"
>  #include "../codecs/tlv320aic23.h"
>  =

>  #define CODEC_CLOCK 	12000000
> diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
> index 3cd5257..249cd23 100644
> --- a/sound/soc/omap/rx51.c
> +++ b/sound/soc/omap/rx51.c
> @@ -37,7 +37,6 @@
>  #include <asm/mach-types.h>
>  =

>  #include "omap-mcbsp.h"
> -#include "omap-pcm.h"
>  =

>  #define RX51_TVOUT_SEL_GPIO		40
>  #define RX51_JACK_DETECT_GPIO		177
> =



-- =

P=E9ter
