From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: io: Remove hw_read() operation
Date: Tue, 04 Mar 2014 10:20:16 +0100
Message-ID: <53159AD0.5000800@metafoo.de>
References: <1393924251-6754-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-014.synserver.de (smtp-out-147.synserver.de
 [212.40.185.147])
 by alsa0.perex.cz (Postfix) with ESMTP id 03D1726573F
 for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2014 10:19:57 +0100 (CET)
In-Reply-To: <1393924251-6754-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 03/04/2014 10:10 AM, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
>
> We now no longer have any users of hw_read() in the kernel so remove the
> code in order to prevent any new users being added. Users should be using
> regmap.
>
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>   include/sound/soc.h |  1 -
>   sound/soc/soc-io.c  | 13 -------------
>   2 files changed, 14 deletions(-)
>
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index 56c4c71..dc36331 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -706,7 +706,6 @@ struct snd_soc_codec {
>   	/* codec IO */
>   	void *control_data; /* codec control (i2c/3wire) data */
>   	hw_write_t hw_write;
> -	unsigned int (*hw_read)(struct snd_soc_codec *, unsigned int);

This part is OK.

>   	unsigned int (*read)(struct snd_soc_codec *, unsigned int);
>   	int (*write)(struct snd_soc_codec *, unsigned int, unsigned int);
>   	void *reg_cache;
> diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
> index c3b6a0a..3c1de9c 100644
> --- a/sound/soc/soc-io.c
> +++ b/sound/soc/soc-io.c
> @@ -26,18 +26,6 @@ static int hw_write(struct snd_soc_codec *codec, unsigned int reg,
>   	return regmap_write(codec->control_data, reg, value);
>   }
>
> -static unsigned int hw_read(struct snd_soc_codec *codec, unsigned int reg)
> -{
> -	int ret;
> -	unsigned int val;
> -
> -	ret = regmap_read(codec->control_data, reg, &val);
> -	if (ret == 0)
> -		return val;
> -	else
> -		return -1;
> -}
> -
>   /**
>    * snd_soc_codec_set_cache_io: Set up standard I/O functions.
>    *
> @@ -64,7 +52,6 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
>   	int ret;
>
>   	codec->write = hw_write;
> -	codec->read = hw_read;

But this part will break snd_soc_read() and with it basically every driver 
that has any controls or DAPM widgets.

I do have a set of patches that moves IO to the component level that will 
clean this all up quite a bit. I'm just waiting for Xiubo Li 
snd_soc_codec_set_cache_io() cleanup to be merged first, since it will make 
things a bit simpler.

>
>   	switch (control) {
>   	case SND_SOC_REGMAP:
>
