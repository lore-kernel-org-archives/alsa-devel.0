From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 19/20] ASoC: S3C64XX: IISv4: Add CPU driver
Date: Wed, 10 Mar 2010 11:39:22 +0000
Message-ID: <20100310113922.GJ24422@rakim.wolfsonmicro.main>
References: <1268207349-9979-10-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-11-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-12-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-13-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-14-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-15-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-16-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-17-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-18-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-19-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C7A9424417
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 12:39:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1268207349-9979-19-git-send-email-jassi.brar@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassi.brar@samsung.com>
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 10, 2010 at 04:49:08PM +0900, Jassi Brar wrote:

> +static int s3c64xx_i2sv4_probe(struct platform_device *pdev,
> +			     struct snd_soc_dai *dai)
> +{
> +	/* configure GPIO for i2s port */
> +	s3c_gpio_cfgpin(S3C64XX_GPC(4), S3C64XX_GPC4_I2S_V40_DO0);
> +	s3c_gpio_cfgpin(S3C64XX_GPC(5), S3C64XX_GPC5_I2S_V40_DO1);
> +	s3c_gpio_cfgpin(S3C64XX_GPC(7), S3C64XX_GPC7_I2S_V40_DO2);
> +	s3c_gpio_cfgpin(S3C64XX_GPH(6), S3C64XX_GPH6_I2S_V40_BCLK);
> +	s3c_gpio_cfgpin(S3C64XX_GPH(7), S3C64XX_GPH7_I2S_V40_CDCLK);
> +	s3c_gpio_cfgpin(S3C64XX_GPH(8), S3C64XX_GPH8_I2S_V40_LRCLK);
> +	s3c_gpio_cfgpin(S3C64XX_GPH(9), S3C64XX_GPH9_I2S_V40_DI);

It seems retrograde to add this rather than using the platform data
callback that you added.  We'll need some arch/arm changes for the
driver to probe anyway so it't not a big deal to add the dependency.
