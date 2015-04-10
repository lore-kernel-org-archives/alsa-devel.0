From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/2] ASoC: davinci: Clear VCIF read FIFO on
	errors
Date: Fri, 10 Apr 2015 10:19:28 +0300
Message-ID: <55277980.5070904@ti.com>
References: <1428620479-32696-1-git-send-email-lexszero@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 6430C260502
 for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2015 09:21:04 +0200 (CEST)
In-Reply-To: <1428620479-32696-1-git-send-email-lexszero@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexey Ignatov <lexszero@gmail.com>, davinci-linux-open-source@linux.davincidsp.com
Cc: alsa-devel@alsa-project.org, Wolfram Sang <wsa@the-dreams.de>, Kevin Hilman <khilman@deeprootsystems.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 04/10/2015 02:00 AM, Alexey Ignatov wrote:
> Clearing VCIF read FIFO on overflow and underflow events fixes audio glit=
ching
> when DMA load is high. This happened when simultaneously capturing and en=
coding
> video and audio, for example.
> =

> Signed-off-by: Alexey Ignatov <lexszero@gmail.com>
> ---
>  sound/soc/davinci/davinci-vcif.c | 60 ++++++++++++++++++++++++++++++++++=
+++---
>  1 file changed, 56 insertions(+), 4 deletions(-)
> =

> diff --git a/sound/soc/davinci/davinci-vcif.c b/sound/soc/davinci/davinci=
-vcif.c
> index 5bee0427..0d8014e 100644
> --- a/sound/soc/davinci/davinci-vcif.c
> +++ b/sound/soc/davinci/davinci-vcif.c
> @@ -45,6 +45,10 @@
>  	} \
>  } while (0)
>  =

> +#define DAVINCI_VC_INT_RERR_MASK \
> +	(DAVINCI_VC_INT_RERRUDR_MASK | \
> +	 DAVINCI_VC_INT_RERROVF_MASK)
> +
>  struct davinci_vcif_dev {
>  	struct davinci_vc *davinci_vc;
>  	struct davinci_pcm_dma_params	dma_params[2];
> @@ -87,6 +91,22 @@ static void davinci_vcif_stop(struct snd_pcm_substream=
 *substream)
>  	writel(w, davinci_vc->base + DAVINCI_VC_CTRL);
>  }
>  =

> +static void davinci_vcif_interrupts(struct snd_pcm_substream *substream,
> +		int enable)
> +{
> +	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
> +	struct davinci_vcif_dev *davinci_vcif_dev =3D
> +			snd_soc_dai_get_drvdata(rtd->cpu_dai);
> +	struct davinci_vc *davinci_vc =3D davinci_vcif_dev->davinci_vc;
> +
> +	if (substream->stream =3D=3D SNDRV_PCM_STREAM_CAPTURE) {
> +		writel(DAVINCI_VC_INT_RERR_MASK,
> +				davinci_vc->base + DAVINCI_VC_INTCLR);
> +		writel(enable ? DAVINCI_VC_INT_RERR_MASK : 0,
> +				davinci_vc->base + DAVINCI_VC_INTEN);
> +	}
> +}
> +
>  static int davinci_vcif_hw_params(struct snd_pcm_substream *substream,
>  				  struct snd_pcm_hw_params *params,
>  				  struct snd_soc_dai *dai)
> @@ -104,10 +124,6 @@ static int davinci_vcif_hw_params(struct snd_pcm_sub=
stream *substream,
>  	/* General line settings */
>  	writel(DAVINCI_VC_CTRL_MASK, davinci_vc->base + DAVINCI_VC_CTRL);
>  =

> -	writel(DAVINCI_VC_INT_MASK, davinci_vc->base + DAVINCI_VC_INTCLR);
> -
> -	writel(DAVINCI_VC_INT_MASK, davinci_vc->base + DAVINCI_VC_INTEN);
> -
>  	w =3D readl(davinci_vc->base + DAVINCI_VC_CTRL);
>  =

>  	/* Determine xfer data type */
> @@ -149,6 +165,32 @@ static int davinci_vcif_hw_params(struct snd_pcm_sub=
stream *substream,
>  	return 0;
>  }
>  =

> +static irqreturn_t davinci_vcif_irq_handler(int irq, void *data)
> +{
> +	struct davinci_vcif_dev *davinci_vcif_dev =3D data;
> +	struct davinci_vc *davinci_vc =3D davinci_vcif_dev->davinci_vc;
> +	uint32_t w;
> +
> +	w =3D readl(davinci_vc->base + DAVINCI_VC_INTSTATUS);
> +
> +	if (w & DAVINCI_VC_INT_RERR_MASK) {
> +		pr_debug("vc overflow or underflow occurred, resetting fifo\n");
> +
> +		w =3D readl(davinci_vc->base + DAVINCI_VC_CTRL);
> +		MOD_REG_BIT(w, DAVINCI_VC_CTRL_RFIFOCL, 1);
> +		writel(w, davinci_vc->base + DAVINCI_VC_CTRL);
> +
> +		w =3D readl(davinci_vc->base + DAVINCI_VC_CTRL);
> +		MOD_REG_BIT(w, DAVINCI_VC_CTRL_RFIFOCL, 0);
> +		writel(w, davinci_vc->base + DAVINCI_VC_CTRL);
> +
> +		writel(DAVINCI_VC_INT_RERR_MASK,
> +				davinci_vc->base + DAVINCI_VC_INTCLR);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int davinci_vcif_trigger(struct snd_pcm_substream *substream, int=
 cmd,
>  				struct snd_soc_dai *dai)
>  {
> @@ -159,10 +201,12 @@ static int davinci_vcif_trigger(struct snd_pcm_subs=
tream *substream, int cmd,
>  	case SNDRV_PCM_TRIGGER_RESUME:
>  	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>  		davinci_vcif_start(substream);
> +		davinci_vcif_interrupts(substream, 1);
>  		break;
>  	case SNDRV_PCM_TRIGGER_STOP:
>  	case SNDRV_PCM_TRIGGER_SUSPEND:
>  	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +		davinci_vcif_interrupts(substream, 0);
>  		davinci_vcif_stop(substream);
>  		break;
>  	default:
> @@ -178,6 +222,7 @@ static int davinci_vcif_startup(struct snd_pcm_substr=
eam *substream,
>  	struct davinci_vcif_dev *dev =3D snd_soc_dai_get_drvdata(dai);
>  =

>  	snd_soc_dai_set_dma_data(dai, substream, dev->dma_params);
> +
>  	return 0;
>  }
>  =

> @@ -238,6 +283,13 @@ static int davinci_vcif_probe(struct platform_device=
 *pdev)
>  =

>  	dev_set_drvdata(&pdev->dev, davinci_vcif_dev);
>  =

> +	ret =3D devm_request_irq(&pdev->dev, IRQ_MBXINT, davinci_vcif_irq_handl=
er,
> +			0, "vcif", davinci_vcif_dev);
> +	if (ret !=3D 0) {
> +		dev_err(&pdev->dev, "could not request irq: %d\n", ret);
> +		return ret;
> +	}

I would make this optional to avoid regression if the arch patch is not pre=
sent.

> +
>  	ret =3D snd_soc_register_component(&pdev->dev, &davinci_vcif_component,
>  					 &davinci_vcif_dai, 1);
>  	if (ret !=3D 0) {
> =



-- =

P=E9ter
