From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: ssm2305: Add amplifier driver
Date: Thu, 17 May 2018 12:52:02 +0200
Message-ID: <472f8866-755a-7484-dddb-16bed933acfe@metafoo.de>
References: <20180517092245.16036-1-m.felsch@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 705DB266F88
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 12:52:07 +0200 (CEST)
In-Reply-To: <20180517092245.16036-1-m.felsch@pengutronix.de>
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
To: Marco Felsch <m.felsch@pengutronix.de>, lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On 05/17/2018 11:22 AM, Marco Felsch wrote:
> The ssm2305 is a simple Class-D audio amplifier. A application can
> turn on/off the device by a gpio. It's also possible to hardwire the
> shutdown pin.
> 
> Tested on a i.MX6 based custom board.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Hi,

Thanks for the patch. Looks mostly good, some comments inline.

> ---
>  .../devicetree/bindings/sound/adi,ssm2305.txt |  15 +++
>  sound/soc/codecs/Kconfig                      |   7 ++
>  sound/soc/codecs/Makefile                     |   2 +
>  sound/soc/codecs/ssm2305.c                    | 105 ++++++++++++++++++
>  4 files changed, 129 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/adi,ssm2305.txt
>  create mode 100644 sound/soc/codecs/ssm2305.c
> 
> diff --git a/Documentation/devicetree/bindings/sound/adi,ssm2305.txt b/Documentation/devicetree/bindings/sound/adi,ssm2305.txt
> new file mode 100644
> index 000000000000..fc4c99225538
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/adi,ssm2305.txt
> @@ -0,0 +1,15 @@
> +Analog Devices SSM2305 Speaker Amplifier
> +========================================
> +
> +Required properties:
> +  - compatible : "adi,ssm2305"
> +
> +Optional properties:
> +  - ssm2305,shutdown-gpio : the gpio connected to the shutdown pin

I think policy is to use only the -gpios suffix for new bindings.

> +
> +Example:
> +
> +ssm2305: analog-amplifier {
> +	compatible = "adi,ssm2305";
> +	ssm2305,shutdown-gpio = <&gpio3 20 GPIO_ACTIVE_LOW>;
> +};
[...]
> +
> +static int ssm2305_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct ssm2305 *priv;
> +	int err;
> +
> +	/* Allocate the private data */
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	/* Shutdown gpio is optional */

If it is really optional you should use gpiod_get_optional. But I wonder
what is the point of the driver if the GPIO is not present?

> +	priv->gpiod_shutdown = devm_gpiod_get(dev, "ssm2305,shutdown",
> +					      GPIOD_OUT_LOW);
> +	if (IS_ERR(priv->gpiod_shutdown)) {
> +		err = PTR_ERR(priv->gpiod_shutdown);
> +		if (err != -EPROBE_DEFER)
> +			dev_warn(dev, "Failed to get 'shutdown' gpio: %d\n",
> +				 err);

Should err be returned here?

> +	}
> +
> +	dev_info(dev, "probed\n");

That's a bit too much noise, imagine every driver did this.

> +
> +	return devm_snd_soc_register_component(dev, &ssm2305_component_driver,
> +					       NULL, 0);
> +}
