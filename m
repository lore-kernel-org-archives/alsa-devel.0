From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/6] ASoC: alc5632: Fix compile without
	CONFIG_I2C
Date: Wed, 16 Nov 2011 10:35:21 +0000
Message-ID: <20111116103521.GA3072@opensource.wolfsonmicro.com>
References: <1321438023-29660-1-git-send-email-leon@leon.nu>
	<1321438023-29660-3-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 42BA824453
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 11:35:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1321438023-29660-3-git-send-email-leon@leon.nu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Leon Romanovsky <leon@leon.nu>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 16, 2011 at 12:06:59PM +0200, Leon Romanovsky wrote:

> +#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
>  static __devinit int alc5632_i2c_probe(struct i2c_client *client,
>  				const struct i2c_device_id *id)
>  {
> @@ -1203,24 +1204,27 @@ static struct i2c_driver alc5632_i2c_driver = {
>  	.remove =  __devexit_p(alc5632_i2c_remove),
>  	.id_table = alc5632_i2c_table,
>  };
> +#endif

This is only needed if the driver supports more than one control
interface.  If it only supports I2C then this should be sorted out at
Kconfig stage.
