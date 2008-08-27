From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 3/4] ASOC: WM8731 codec: add SPI support as
	well as I2C
Date: Wed, 27 Aug 2008 12:01:44 +0100
Message-ID: <20080827110143.GB10834@sirena.org.uk>
References: <1219829968-6431-1-git-send-email-cooloney@kernel.org>
	<1219829968-6431-4-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 21E3C10385F
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Aug 2008 13:01:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1219829968-6431-4-git-send-email-cooloney@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bryan Wu <cooloney@kernel.org>
Cc: linux-kernel@vger.kernel.org, Cliff Cai <cliff.cai@analog.com>, alsa-devel@alsa-project.org, lrg@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 27, 2008 at 05:39:27PM +0800, Bryan Wu wrote:

This looks good, thanks but...

> -#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
> +#if defined (CONFIG_I2C) || defined (CONFIG_I2C_MODULE) && !defined (CONFIG_SND_SOC_WM8731_SPI)
>  	if (setup->i2c_address) {
>  		normal_i2c[0] = setup->i2c_address;
>  		codec->hw_write = (hw_write_t)i2c_master_send;
> @@ -688,8 +745,14 @@ static int wm8731_probe(struct platform_device *pdev)
>  		if (ret != 0)
>  			printk(KERN_ERR "can't add i2c driver");
>  	}
> +#elif defined (CONFIG_SPI_MASTER) && defined (CONFIG_SND_SOC_WM8731_SPI)
> +	codec->hw_write = (hw_write_t)wm8731_spi_write;
> +	ret = spi_register_driver(&wm8731_spi_driver);
> +	if (ret != 0)
> +		printk(KERN_ERR "can't add spi driver");

...as for the SSM2602 it'd be good if it were possible to build a kernel
which supports both I2C and SPI.  If you like I could do this for you -
there's likely to be merge issues due to the update to the new I2C API
anyway?
