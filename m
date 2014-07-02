From: Daniel Mack <daniel@zonque.org>
Subject: Re: [alsa-devel] [PATCH v3] ASoC: tas2552: Support TI TAS2552 Amplifier
Date: Wed, 02 Jul 2014 15:47:01 +0200
Message-ID: <53B40D55.6000602@zonque.org>
References: <1404307852-10456-1-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404307852-10456-1-git-send-email-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, linux-sound@vger.kernel.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Dan,

On 07/02/2014 03:30 PM, Dan Murphy wrote:
> +	if (np) {
> +		data->power_gpio = of_get_named_gpio(np, "enable-gpio", 0);
> +	} else if (pdata) {
> +		data->power_gpio = pdata->enable_gpio;
> +	} else {
> +		dev_err(dev, "Platform or dev tree data not set\n");
> +		return -ENODEV;
> +	}

New code for GPIO handling should use the new gpiod interface.
See include/linux/gpio/consumer.h, or the sta350 codec driver.

For that to work, you also need to rename the property to
'enable-gpios', even though there's only one.


Daniel
