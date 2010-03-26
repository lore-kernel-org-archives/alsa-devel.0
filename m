From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] WM8750: Convert to new API
Date: Fri, 26 Mar 2010 10:08:12 +0000
Message-ID: <1269598092.3757.48.camel@odin>
References: <1269570193-8151-1-git-send-email-marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4629910380D
	for <alsa-devel@alsa-project.org>; Fri, 26 Mar 2010 11:08:17 +0100 (CET)
Received: by gwb15 with SMTP id 15so3849565gwb.38
	for <alsa-devel@alsa-project.org>; Fri, 26 Mar 2010 03:08:15 -0700 (PDT)
In-Reply-To: <1269570193-8151-1-git-send-email-marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-03-26 at 03:23 +0100, Marek Vasut wrote:
> Register the WM8750 as a SPI or I2C device. This patch mostly shuffles code
> around. Hugely inspired by WM8753 which was already converted.
> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> ---
>  sound/soc/codecs/wm8750.c |  411 +++++++++++++++++++++++++--------------------
>  1 files changed, 232 insertions(+), 179 deletions(-)
> 

This looks mostly fine. Just a comment on the codec IO.

> diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
> index 475c67a..c7ee6d2 100644
> --- a/sound/soc/codecs/wm8750.c
> +++ b/sound/soc/codecs/wm8750.c
> @@ -29,13 +29,6 @@
>  
>  #include "wm8750.h"
>  
> -#define WM8750_VERSION "0.12"
> -
> -/* codec private data */
> -struct wm8750_priv {
> -	unsigned int sysclk;
> -};
> -
>  /*
>   * wm8750 register cache
>   * We can't read the WM8750 register space when we
> @@ -55,6 +48,59 @@ static const u16 wm8750_reg[] = {
>  	0x0079, 0x0079, 0x0079,          /* 40 */
>  };
>  
> +/* codec private data */
> +struct wm8750_priv {
> +	unsigned int sysclk;
> +	struct snd_soc_codec codec;
> +	u16 reg_cache[ARRAY_SIZE(wm8750_reg)];
> +};
> +
> +/*
> + * read wm8750 register cache
> + */
> +static inline unsigned int wm8750_read_reg_cache(struct snd_soc_codec *codec,
> +	unsigned int reg)
> +{
> +	u16 *cache = codec->reg_cache;
> +	if (reg < 1 || reg >= (ARRAY_SIZE(wm8750_reg) + 1))
> +		return -1;
> +	return cache[reg - 1];
> +}
> +
> +/*
> + * write wm8750 register cache
> + */
> +static inline void wm8750_write_reg_cache(struct snd_soc_codec *codec,
> +	unsigned int reg, unsigned int value)
> +{
> +	u16 *cache = codec->reg_cache;
> +	if (reg < 1 || reg >= (ARRAY_SIZE(wm8750_reg) + 1))
> +		return;
> +	cache[reg - 1] = value;
> +}
> +
> +/*
> + * write to the WM8750 register space
> + */
> +static int wm8750_write(struct snd_soc_codec *codec, unsigned int reg,
> +	unsigned int value)
> +{
> +	u8 data[2];
> +
> +	/* data is
> +	 *   D15..D9 WM8750 register offset
> +	 *   D8...D0 register data
> +	 */
> +	data[0] = (reg << 1) | ((value >> 8) & 0x0001);
> +	data[1] = value & 0x00ff;
> +
> +	wm8750_write_reg_cache(codec, reg, value);
> +	if (codec->hw_write(codec->control_data, data, 2) == 2)
> +		return 0;
> +	else
> +		return -EIO;
> +}
> +

We should probably use the codec IO helpers in soc-cache.c for codec
read/write() e.g.

snd_soc_codec_set_cache_io(codec, 7, 9, wm8750->control_type);

This can set up the WM8750 for 7 address bits and 9 data bits and mean
less code in the driver.

Thanks

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
