From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] wcd9335: fix a incorrect use of kstrndup()
Date: Wed, 5 Jun 2019 06:57:02 +0200
Message-ID: <7573d8ce-7160-39b1-8901-be9155c451a1@suse.cz>
References: <20190529015305.GA4700@zhanggen-UX430UQ>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190529015305.GA4700@zhanggen-UX430UQ>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Gen Zhang <blackgod016574@gmail.com>, broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, wen.yang99@zte.com.cn
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 29. 05. 19, 3:53, Gen Zhang wrote:
> In wcd9335_codec_enable_dec(), 'widget_name' is allocated by kstrndup().
> However, according to doc: "Note: Use kmemdup_nul() instead if the size
> is known exactly."

Except the size is not known exactly. It is at most 15, not 15. Right?

> So we should use kmemdup_nul() here instead of
> kstrndup().
> 
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> ---
> diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
> index a04a7ce..85737fe 100644
> --- a/sound/soc/codecs/wcd9335.c
> +++ b/sound/soc/codecs/wcd9335.c
> @@ -2734,7 +2734,7 @@ static int wcd9335_codec_enable_dec(struct snd_soc_dapm_widget *w,
>  	char *dec;
>  	u8 hpf_coff_freq;
>  
> -	widget_name = kstrndup(w->name, 15, GFP_KERNEL);
> +	widget_name = kmemdup_nul(w->name, 15, GFP_KERNEL);
>  	if (!widget_name)
>  		return -ENOMEM;
>  

thanks,
-- 
js
suse labs
