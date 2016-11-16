From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 03/19] ASoC: wm8580: Convert to
 module_i2c_driver()
Date: Wed, 16 Nov 2016 09:41:25 +0000
Message-ID: <20161116094125.GT1575@localhost.localdomain>
References: <871syd9vq9.wl%kuninori.morimoto.gx@renesas.com>
 <87wpg58h3o.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 018AB2665B0
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2016 10:41:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87wpg58h3o.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 15, 2016 at 05:09:57AM +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> wm8580 driver doesn't work without CONFIG_I2C anyway.
> Let's depend on it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  sound/soc/codecs/wm8580.c | 25 +------------------------
>  1 file changed, 1 insertion(+), 24 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
> index faa7287..243451f 100644
> --- a/sound/soc/codecs/wm8580.c
> +++ b/sound/soc/codecs/wm8580.c
> @@ -932,7 +932,6 @@ static int wm8580_remove(struct snd_soc_codec *codec)
>  	.volatile_reg = wm8580_volatile,
>  };
>  
> -#if IS_ENABLED(CONFIG_I2C)
>  static int wm8580_i2c_probe(struct i2c_client *i2c,
>  			    const struct i2c_device_id *id)
>  {
> @@ -987,30 +986,8 @@ static int wm8580_i2c_remove(struct i2c_client *client)
>  	.remove =   wm8580_i2c_remove,
>  	.id_table = wm8580_i2c_id,
>  };
> -#endif
>  
> -static int __init wm8580_modinit(void)
> -{
> -	int ret = 0;
> -
> -#if IS_ENABLED(CONFIG_I2C)
> -	ret = i2c_add_driver(&wm8580_i2c_driver);
> -	if (ret != 0) {
> -		pr_err("Failed to register WM8580 I2C driver: %d\n", ret);
> -	}
> -#endif
> -
> -	return ret;
> -}
> -module_init(wm8580_modinit);
> -
> -static void __exit wm8580_exit(void)
> -{
> -#if IS_ENABLED(CONFIG_I2C)
> -	i2c_del_driver(&wm8580_i2c_driver);
> -#endif
> -}
> -module_exit(wm8580_exit);
> +module_i2c_driver(wm8580_i2c_driver);

Again here the patch looks fine but commit message is a bit
different from the patch, this converts the driver to use
module_i2c_driver as the title of the commit message states but
the body of the commit message seems to imply we are adding a
dependency into the Kconfig which we arn't doing.

Thanks,
Charles
