From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] ASoC: imx-sgtl5000.c: Add support for
 specifying PDCR_TXRXEN
Date: Thu, 24 Apr 2014 13:56:55 +0800
Message-ID: <20140424055653.GD9816@dragon>
References: <1398268218-31897-1-git-send-email-david@protonic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0185.outbound.protection.outlook.com [207.46.163.185])
 by alsa0.perex.cz (Postfix) with ESMTP id 367D526518A
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 07:57:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1398268218-31897-1-git-send-email-david@protonic.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Jander <david@protonic.nl>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 23, 2014 at 05:50:18PM +0200, David Jander wrote:
> This enables effectively swapping RX/TX pins on the external audio port
> 
> Signed-off-by: David Jander <david@protonic.nl>

You should copy Mark Brown <broonie@kernel.org> and
devicetree@vger.kernel.org on this patch.

Shawn

> ---
>  Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt | 4 ++++
>  sound/soc/fsl/imx-sgtl5000.c                                   | 5 ++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt b/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
> index e4acdd8..3afea85 100644
> --- a/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
> +++ b/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
> @@ -29,6 +29,10 @@ Required properties:
>  - mux-int-port : The internal port of the i.MX audio muxer (AUDMUX)
>  - mux-ext-port : The external port of the i.MX audio muxer
>  
> +Optional properties:
> +- ext-port-txrxen : Flag. Set to swap RX/TX signals on external port (set the
> +  IMX_AUDMUX_V2_PDCR_TXRXEN bit in the PDC register of the external port)
> +
>  Note: The AUDMUX port numbering should start at 1, which is consistent with
>  hardware manual.
>  
> diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
> index 1cb22dd..b543fa6 100644
> --- a/sound/soc/fsl/imx-sgtl5000.c
> +++ b/sound/soc/fsl/imx-sgtl5000.c
> @@ -63,6 +63,7 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
>  	struct i2c_client *codec_dev;
>  	struct imx_sgtl5000_data *data = NULL;
>  	int int_port, ext_port;
> +	unsigned int ext_txrxen = 0;
>  	int ret;
>  
>  	ret = of_property_read_u32(np, "mux-int-port", &int_port);
> @@ -75,6 +76,8 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "mux-ext-port missing or invalid\n");
>  		return ret;
>  	}
> +	if (of_property_read_bool(np, "ext-port-txrxen"))
> +		ext_txrxen = IMX_AUDMUX_V2_PDCR_TXRXEN;
>  
>  	/*
>  	 * The port numbering in the hardware manual starts at 1, while
> @@ -95,7 +98,7 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
>  	}
>  	ret = imx_audmux_v2_configure_port(ext_port,
>  			IMX_AUDMUX_V2_PTCR_SYN,
> -			IMX_AUDMUX_V2_PDCR_RXDSEL(int_port));
> +			IMX_AUDMUX_V2_PDCR_RXDSEL(int_port) | ext_txrxen);
>  	if (ret) {
>  		dev_err(&pdev->dev, "audmux external port setup failed\n");
>  		return ret;
> -- 
> 1.9.1
> 
