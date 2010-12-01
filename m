From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC: Remove unused aic3x_i2c_init and aic3x_i2c_exit
 functions
Date: Wed, 1 Dec 2010 09:43:16 +0200
Message-ID: <20101201094316.6751d3a1.jhnikula@gmail.com>
References: <1291185504.5563.1.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1291185504.5563.1.camel@mola>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Vladimir Barinov <vbarinov@embeddedalley.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 01 Dec 2010 14:38:24 +0800
Axel Lin <axel.lin@gmail.com> wrote:

> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  sound/soc/codecs/tlv320aic3x.c |   15 ---------------
>  1 files changed, 0 insertions(+), 15 deletions(-)
> 
> diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
> index fc5abdf..8cd4cf5 100644
> --- a/sound/soc/codecs/tlv320aic3x.c
> +++ b/sound/soc/codecs/tlv320aic3x.c
> @@ -1545,21 +1545,6 @@ static struct i2c_driver aic3x_i2c_driver = {
>  	.remove = aic3x_i2c_remove,
>  	.id_table = aic3x_i2c_id,
>  };
> -
> -static inline void aic3x_i2c_init(void)
> -{
> -	int ret;
> -
> -	ret = i2c_add_driver(&aic3x_i2c_driver);
> -	if (ret)
> -		printk(KERN_ERR "%s: error regsitering i2c driver, %d\n",
> -		       __func__, ret);
> -}
> -
> -static inline void aic3x_i2c_exit(void)
> -{
> -	i2c_del_driver(&aic3x_i2c_driver);
> -}
>  #endif
>  
True, these are unused nowadays.

Acked-by: Jarkko Nikula <jhnikula@gmail.com>
