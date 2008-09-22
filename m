From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] ASoC: Fix cs4270 error path
Date: Mon, 22 Sep 2008 14:29:51 +0200
Message-ID: <20080922142951.5a9e5efb@hyperion.delvare>
References: <20080831144214.62a17be6@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 62C44243C3
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Sep 2008 14:29:17 +0200 (CEST)
In-Reply-To: <20080831144214.62a17be6@hyperion.delvare>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Timur,

Any news about this fix? This should go in kernel 2.6.28.

On Sun, 31 Aug 2008 14:42:14 +0200, Jean Delvare wrote:
> The error path in cs4270_probe/cs4270_remove is pretty broken:
> * If cs4270_probe fails, codec is leaked.
> * If snd_soc_register_card fails, cs4270_i2c_driver stays registered.
> * If I2C support is enabled but no I2C device is found, i2c_del_driver
>   is never called (neither in cs4270_probe nor in cs4270_remove.)
> 
> Fix the first 2 problems by implementing a clean error path in
> cs4270_probe and jumping to its labels as needed. Fix the 3rd problem
> by removing the condition to call i2c_del_driver in cs4270_remove.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
> Timur, can you please review and test this patch? I do not have the
> hardware so I couldn't test it myself.
> 
>  sound/soc/codecs/cs4270.c |   25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> --- linux-2.6.27-rc5.orig/sound/soc/codecs/cs4270.c	2008-08-31 13:59:17.000000000 +0200
> +++ linux-2.6.27-rc5/sound/soc/codecs/cs4270.c	2008-08-31 14:23:34.000000000 +0200
> @@ -727,7 +727,7 @@ static int cs4270_probe(struct platform_
>  	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
>  	if (ret < 0) {
>  		printk(KERN_ERR "cs4270: failed to create PCMs\n");
> -		return ret;
> +		goto error_free_codec;
>  	}
>  
>  #ifdef USE_I2C
> @@ -736,8 +736,7 @@ static int cs4270_probe(struct platform_
>  	ret = i2c_add_driver(&cs4270_i2c_driver);
>  	if (ret) {
>  		printk(KERN_ERR "cs4270: failed to attach driver");
> -		snd_soc_free_pcms(socdev);
> -		return ret;
> +		goto error_free_pcms;
>  	}
>  
>  	/* Did we find a CS4270 on the I2C bus? */
> @@ -759,10 +758,23 @@ static int cs4270_probe(struct platform_
>  	ret = snd_soc_register_card(socdev);
>  	if (ret < 0) {
>  		printk(KERN_ERR "cs4270: failed to register card\n");
> -		snd_soc_free_pcms(socdev);
> -		return ret;
> +		goto error_del_driver;
>  	}
>  
> +	return 0;
> +
> +error_del_driver:
> +#ifdef USE_I2C
> +	i2c_del_driver(&cs4270_i2c_driver);
> +
> +error_free_pcms:
> +#endif
> +	snd_soc_free_pcms(socdev);
> +
> +error_free_codec:
> +	kfree(socdev->codec);
> +	socdev->codec = NULL;
> +
>  	return ret;
>  }
>  
> @@ -773,8 +785,7 @@ static int cs4270_remove(struct platform
>  	snd_soc_free_pcms(socdev);
>  
>  #ifdef USE_I2C
> -	if (socdev->codec->control_data)
> -		i2c_del_driver(&cs4270_i2c_driver);
> +	i2c_del_driver(&cs4270_i2c_driver);
>  #endif
>  
>  	kfree(socdev->codec);
> 
> 


-- 
Jean Delvare
