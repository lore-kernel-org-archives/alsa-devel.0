From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Fix WM8996 DC servo operation
	without IRQ
Date: Thu, 15 Sep 2011 19:06:05 +0100
Message-ID: <1316109965.3333.3.camel@odin>
References: <1316080453-3710-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog113.obsmtp.com (na3sys009aog113.obsmtp.com
	[74.125.149.209])
	by alsa0.perex.cz (Postfix) with ESMTP id 56C15103C39
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Sep 2011 20:06:10 +0200 (CEST)
Received: by mail-wy0-f180.google.com with SMTP id 26so4035728wyj.39
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2011 11:06:09 -0700 (PDT)
In-Reply-To: <1316080453-3710-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Axel Lin <axel.lin@gmail.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-09-15 at 10:54 +0100, Mark Brown wrote:
> We need to count the timneout down.
> 
> Reported-by: Axel Lin <axel.lin@gmail.com>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8996.c |    9 +++------
>  1 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
> index 0fed436..5ca9d76 100644
> --- a/sound/soc/codecs/wm8996.c
> +++ b/sound/soc/codecs/wm8996.c
> @@ -719,7 +719,7 @@ static void wait_for_dc_servo(struct snd_soc_codec *codec, u16 mask)
>  {
>  	struct i2c_client *i2c = to_i2c_client(codec->dev);
>  	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
> -	int i, ret;
> +	int ret;
>  	unsigned long timeout = 200;
>  
>  	snd_soc_write(codec, WM8996_DC_SERVO_2, mask);
> @@ -734,15 +734,12 @@ static void wait_for_dc_servo(struct snd_soc_codec *codec, u16 mask)
>  
>  		} else {
>  			msleep(1);
> -			if (--i) {
> -				timeout = 0;
> -				break;
> -			}
> +			timeout--;
>  		}
>  
>  		ret = snd_soc_read(codec, WM8996_DC_SERVO_2);
>  		dev_dbg(codec->dev, "DC servo state: %x\n", ret);
> -	} while (ret & mask);
> +	} while (timeout && ret & mask);
>  
>  	if (timeout == 0)
>  		dev_err(codec->dev, "DC servo timed out for %x\n", mask);

Acked-by: Liam Girdwood <lrg@ti.com>
