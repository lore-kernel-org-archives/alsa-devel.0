From: Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH v2 34/35] sound/soc/codecs: Use kmemdup rather than
 duplicating its implementation
Date: Thu, 4 Jul 2019 12:47:29 +0100
Message-ID: <52ee7351-19fc-4fd3-33f8-9392a4ad9526@opensource.cirrus.com>
References: <20190703163224.1029-1-huangfq.daxian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190703163224.1029-1-huangfq.daxian@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Fuqian Huang <huangfq.daxian@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Commit message title prefix should be "ASoC: wm0010:" not "sound/soc
/codecs:". Take a look at other patches to the same files.

> kmemdup is introduced to duplicate a region of memory in a neat way.
> Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
> write the size twice (sometimes lead to mistakes), kmemdup improves
> readability, leads to smaller code and also reduce the chances of mistakes.
> Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.
> 
> Acked-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
> Changes in v2:
>    - Fix a typo in commit message (memset -> memcpy)
>    - Split into two patches
> 
>   sound/soc/codecs/wm0010.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
> index 727d6703c905..807826f30f58 100644
> --- a/sound/soc/codecs/wm0010.c
> +++ b/sound/soc/codecs/wm0010.c
> @@ -515,7 +515,7 @@ static int wm0010_stage2_load(struct snd_soc_component *component)
>   	dev_dbg(component->dev, "Downloading %zu byte stage 2 loader\n", fw->size);
>   
>   	/* Copy to local buffer first as vmalloc causes problems for dma */
> -	img = kzalloc(fw->size, GFP_KERNEL | GFP_DMA);
> +	img = kmemdup(&fw->data[0], fw->size, GFP_KERNEL | GFP_DMA);
>   	if (!img) {
>   		ret = -ENOMEM;
>   		goto abort2;
> @@ -527,8 +527,6 @@ static int wm0010_stage2_load(struct snd_soc_component *component)
>   		goto abort1;
>   	}
>   
> -	memcpy(img, &fw->data[0], fw->size);
> -
>   	spi_message_init(&m);
>   	memset(&t, 0, sizeof(t));
>   	t.rx_buf = out;
> 
