From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH RESEND 1/2] ALSA SOC driver for s3c24xx
	with uda134x
Date: Fri, 14 Nov 2008 11:03:42 +0000
Message-ID: <20081114110342.GE21573@sirena.org.uk>
References: <12265909162051-git-send-email-chripell@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0D20A10380E
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 12:03:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <12265909162051-git-send-email-chripell@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Christian Pellegrin <chripell@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.arm.linux.org.uk, Christian Pellegrin <chripell@fsfe.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 13, 2008 at 04:41:56PM +0100, Christian Pellegrin wrote:

This looks OK from an ASoC point of view but one small issue...

> +	s3c24xx_uda134x_l3_pins = pdev->dev.platform_data;
> +	if (s3c24xx_uda134x_l3_pins == NULL) {
> +		printk(KERN_ERR "S3C24XX_UDA134X SoC Audio: "
> +		       "unable to find platform data\n");
> +		return -ENODEV;
> +	}
> +	s3c24xx_uda134x.power = s3c24xx_uda134x_l3_pins->power;
> +	s3c24xx_uda134x.model = s3c24xx_uda134x_l3_pins->model;
> +	gpio_direction_output(s3c24xx_uda134x_l3_pins->l3_data, 0);
> +	gpio_direction_output(s3c24xx_uda134x_l3_pins->l3_clk, 0);
> +	gpio_direction_output(s3c24xx_uda134x_l3_pins->l3_mode, 0);

You should request the GPIOs with gpio_request() before using them (and
then free them with gpio_free() when the driver exits).
