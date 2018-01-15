From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v3 16/17] ASoC: fsl_ssi: Move DT related
 code to a separate probe()
Date: Mon, 15 Jan 2018 22:16:39 +0100
Message-ID: <0be4b57d-cb28-896a-3d97-f36316a351c5@maciej.szmigiero.name>
References: <1515990087-11598-1-git-send-email-nicoleotsuka@gmail.com>
 <1515990087-11598-17-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F9A026760B
 for <alsa-devel@alsa-project.org>; Mon, 15 Jan 2018 22:16:45 +0100 (CET)
In-Reply-To: <1515990087-11598-17-git-send-email-nicoleotsuka@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, kernel@pengutronix.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, caleb@crome.org, timur@tabi.org, broonie@kernel.org, arnaud.mouiche@invoxia.com, lukma@denx.de, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On 15.01.2018 05:21, Nicolin Chen wrote:
> This patch cleans up probe() function by moving all Device Tree
> related code into a separate function. It allows the probe() to
> be Device Tree independent. This will be very useful for future
> integration of imx-ssi driver which has similar functionalities
> while exists only because it supports non-DT cases.
> 
> This patch also moves symmetric_channels of AC97 from the probe
> to the structure snd_soc_dai_driver for simplification.
> 
> Additionally, since PowerPC and AC97 use the same pdev pointer
> to register a platform device, this patch also unifies related
> code.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> Tested-by: Caleb Crome <caleb@crome.org>
> ---
>  sound/soc/fsl/fsl_ssi.c | 202 +++++++++++++++++++++++++-----------------------
>  1 file changed, 107 insertions(+), 95 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 20889d8..d2072de 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -1366,41 +1365,102 @@ static void fsl_ssi_imx_clean(struct platform_device *pdev, struct fsl_ssi *ssi)
>  		clk_disable_unprepare(ssi->clk);
>  }
>  
> -static int fsl_ssi_probe(struct platform_device *pdev)
> +static int fsl_ssi_probe_from_dt(struct fsl_ssi *ssi)
>  {
> -	struct fsl_ssi *ssi;
> -	int ret = 0;
> -	struct device_node *np = pdev->dev.of_node;
> -	struct device *dev = &pdev->dev;
> +	struct device *dev = ssi->dev;
> +	struct device_node *np = dev->of_node;
>  	const struct of_device_id *of_id;
>  	const char *p, *sprop;
>  	const uint32_t *iprop;
> -	struct resource *res;
> -	void __iomem *iomem;
> -	char name[64];
> -	struct regmap_config regconfig = fsl_ssi_regconfig;
> +	u32 dmas[4];
> +	int ret;
>  
>  	of_id = of_match_device(fsl_ssi_ids, dev);
>  	if (!of_id || !of_id->data)
>  		return -EINVAL;
>  
> -	ssi = devm_kzalloc(dev, sizeof(*ssi), GFP_KERNEL);
> -	if (!ssi)
> -		return -ENOMEM;
> -
>  	ssi->soc = of_id->data;
> -	ssi->dev = dev;
> +
> +	ret = of_property_match_string(np, "clock-names", "ipg");
> +	/* Get error code if not found */
> +	ssi->has_ipg_clk_name = ret >= 0;
>  
>  	/* Check if being used in AC97 mode */
>  	sprop = of_get_property(np, "fsl,mode", NULL);
> -	if (sprop) {
> -		if (!strcmp(sprop, "ac97-slave"))
> -			ssi->dai_fmt = FSLSSI_AC97_DAIFMT;
> +	if (sprop && !strcmp(sprop, "ac97-slave")) {
> +		ssi->dai_fmt = FSLSSI_AC97_DAIFMT;
> +
> +		ret = of_property_read_u32(np, "cell-index", &ssi->card_idx);
> +		if (ret) {
> +			dev_err(dev, "failed to get SSI index property\n");
> +			return -EINVAL;
> +		}
> +		strcpy(ssi->card_name, "ac97-codec");
>  	}
>  
>  	/* Select DMA or FIQ */
>  	ssi->use_dma = !of_property_read_bool(np, "fsl,fiq-stream-filter");
>  
> +	/* In synchronous mode, STCK and STFS ports are used by RX as well */
> +	if (!of_find_property(np, "fsl,ssi-asynchronous", NULL))
> +		ssi->synchronous = true;

You are setting ssi->synchronous in the AC'97 mode here, the old code
didn't do that (see the next patch hunk below).

Since in the previous patch you have replaced cpu_dai_drv.symmetric_rates
with ssi->synchronous this will likely break asymmetric rate support in
the AC'97 mode, since the driver will use STCCR for programming of both
playback and capture.

The next patch in this series (17) also looks affected by this change.

> @@ -1444,24 +1500,13 @@ static int fsl_ssi_probe(struct platform_device *pdev)
>  		return ssi->irq;
>  	}
>  
> -	/* Set software limitations for synchronous mode */
> -	if (!of_find_property(np, "fsl,ssi-asynchronous", NULL)) {
> -		if (!fsl_ssi_is_ac97(ssi)) {
> -			ssi->cpu_dai_drv.symmetric_rates = 1;
> -			ssi->cpu_dai_drv.symmetric_samplebits = 1;
> -			ssi->synchronous = true;
> -		}

You can see it here that the old code didn't set ssi->synchronous in the
AC'97 mode.

Maciej
