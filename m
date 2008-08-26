From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: [PATCH] ASoC: Convert wm8731 to a new-style
	i2c	driver (testers wanted)
Date: Tue, 26 Aug 2008 21:20:43 +0200
Message-ID: <20080826192043.GA3812@roarinelk.homelinux.net>
References: <20080826182437.4c5e2f3e@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from roarinelk.homelinux.net (fnoeppeil48.netpark.at
	[217.175.205.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BEC224360
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Aug 2008 21:20:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080826182437.4c5e2f3e@hyperion.delvare>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jean Delvare <khali@linux-fr.org>
Cc: alsa-devel@alsa-project.org, Dmitry Baryshkov <dbaryshkov@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Richard Purdie <rpurdie@rpsys.net>, Eric Miao <eric.miao@marvell.com>, Andrew Victor <linux@maxim.org.za>, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Jean,

On Tue, Aug 26, 2008 at 06:24:37PM +0200, Jean Delvare wrote:
> Convert the wm8731 codec driver to the new (standard) device driver
> binding model.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> Warning: this assumes that the corgi, poodle and eti_b1 have their
> codec chips on I2C bus 0, which may or may not be the case. Someone
> with these machines please test and report.
> 
> Note that you can safely ignore patch failures in i2c-id.h.
> 
>  include/linux/i2c-id.h         |    1 
>  sound/soc/at91/eti_b1_wm8731.c |    1 
>  sound/soc/codecs/wm8731.c      |  111 +++++++++++++++++++---------------------
>  sound/soc/codecs/wm8731.h      |    1 
>  sound/soc/pxa/corgi.c          |    1 
>  sound/soc/pxa/poodle.c         |    1 
>  6 files changed, 59 insertions(+), 57 deletions(-)

>  static struct wm8731_setup_data eti_b1_wm8731_setup = {
> +	.i2c_bus = 0,
>  	.i2c_address = 0x1a,
>  };
[...]  
> --- linux-2.6.27-rc4.orig/sound/soc/codecs/wm8731.c	2008-08-26 16:40:44.000000000 +0200
> +++ linux-2.6.27-rc4/sound/soc/codecs/wm8731.c	2008-08-26 17:11:50.000000000 +0200
[...]
> +static int wm8731_add_i2c_device(struct platform_device *pdev,
> +				 const struct wm8731_setup_data *setup)
> +{
> +	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
> +	struct i2c_board_info info;
> +	struct i2c_adapter *adapter;
> +	struct i2c_client *client;
> +	int ret;
> +
> +	ret = i2c_add_driver(&wm8731_i2c_driver);
> +	if (ret != 0) {
> +		dev_err(&pdev->dev, "can't add i2c driver\n");
> +		return ret;
> +	}
> +
> +	memset(&info, 0, sizeof(struct i2c_board_info));
> +	info.addr = setup->i2c_address;
> +	strlcpy(info.type, "wm8731", I2C_NAME_SIZE);

I don't know about other wm8731 users, but I'd prefer to let the board
code register the codec i2c device.  Then you could also get rid
of "struct wm8731_setup_data" altogether.

The patch works on a MIPS testboard.

Thanks!
	Manuel Lauss
