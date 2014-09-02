From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv3 6/9] WM8971 uses msleep to replace work
	queue
Date: Tue, 2 Sep 2014 11:00:50 +0100
Message-ID: <20140902100050.GG12043@opensource.wolfsonmicro.com>
References: <1409628470-13059-1-git-send-email-xavier.hsu@linaro.org>
 <1409628470-13059-6-git-send-email-xavier.hsu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0249F26528B
 for <alsa-devel@alsa-project.org>; Tue,  2 Sep 2014 12:00:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1409628470-13059-6-git-send-email-xavier.hsu@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xavier Hsu <xavier.hsu@linaro.org>
Cc: Andy Green <andy.green@linaro.org>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 02, 2014 at 11:27:47AM +0800, Xavier Hsu wrote:
> This patch improves WM8971.
> We use msleep to replace work queue.
> "As suggested by Mark Brown"
> 
> Any comments about improving the patch are welcome.
> Thanks.
> 
> Signed-off-by: Xavier Hsu <xavier.hsu@linaro.org>
> Signed-off-by: Andy Green <andy.green@linaro.org>
> ---
>  sound/soc/codecs/wm8971.c |   25 ++-----------------------
>  1 file changed, 2 insertions(+), 23 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
> index 20cfdd3..68b4f52 100755
> --- a/sound/soc/codecs/wm8971.c
> +++ b/sound/soc/codecs/wm8971.c
> @@ -36,8 +36,6 @@
>  
>  #define	WM8971_REG_COUNT	43
>  
> -static struct workqueue_struct *wm8971_workq;
> -
>  /* codec private data */
>  struct wm8971_priv {
>  	unsigned int sysclk;
> @@ -774,16 +772,6 @@ static struct snd_soc_dai_driver wm8971_dai = {
>  	.ops = &wm8971_dai_ops,
>  };
>  
> -static void wm8971_work(struct work_struct *work)
> -{
> -	struct snd_soc_dapm_context *dapm =
> -		container_of(work, struct snd_soc_dapm_context,
> -			     delayed_work.work);
> -	struct snd_soc_codec *codec = dapm->codec;
> -
> -	wm8971_set_bias_level(codec, codec->dapm.bias_level);
> -}
> -
>  static int wm8971_suspend(struct snd_soc_codec *codec)
>  {
>  	wm8971_set_bias_level(codec, SND_SOC_BIAS_OFF);
> @@ -801,8 +789,7 @@ static int wm8971_resume(struct snd_soc_codec *codec)
>  		reg = snd_soc_read(codec, WM8971_PWR1) & 0xfe3e;
>  		snd_soc_write(codec, WM8971_PWR1, reg | 0x01c0);
>  		codec->dapm.bias_level = SND_SOC_BIAS_ON;
> -		queue_delayed_work(wm8971_workq, &codec->dapm.delayed_work,
> -				   msecs_to_jiffies(1000));
> +		msleep(100);
>  	}
>  
>  	return 0;
> @@ -813,19 +800,13 @@ static int wm8971_probe(struct snd_soc_codec *codec)
>  	int ret = 0;
>  	u16 reg;
>  
> -	INIT_DELAYED_WORK(&codec->dapm.delayed_work, wm8971_work);
> -	wm8971_workq = create_workqueue("wm8971");
> -	if (wm8971_workq == NULL)
> -		return -ENOMEM;
> -
>  	wm8971_reset(codec);
>  
>  	/* charge output caps - set vmid to 5k for quick power up */
>  	reg = snd_soc_read(codec, WM8971_PWR1) & 0xfe3e;
>  	snd_soc_write(codec, WM8971_PWR1, reg | 0x01c0);
>  	codec->dapm.bias_level = SND_SOC_BIAS_STANDBY;
> -	queue_delayed_work(wm8971_workq, &codec->dapm.delayed_work,
> -			   msecs_to_jiffies(1000));
> +	msleep(100);

Does this patch actually work? You have taken out the
queue_delayed_work and replaced it with a delay (which is 10x
shorter than the delayed work version), but you  haven't replaced
the call to wm8971_set_bias_level that used to be in the delayed
work?

>  
>  	/* set the update bits */
>  	snd_soc_update_bits(codec, WM8971_LDAC, 0x0100, 0x0100);
> @@ -846,8 +827,6 @@ static int wm8971_remove(struct snd_soc_codec *codec)
>  {
>  	wm8971_set_bias_level(codec, SND_SOC_BIAS_OFF);
>  
> -	if (wm8971_workq)
> -		destroy_workqueue(wm8971_workq);
>  	return 0;
>  }
>  
> -- 

Thanks,
Charles
