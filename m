From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm0010: Remove unneeded linux/miscdevice.h include
Date: Thu, 15 Dec 2016 15:45:08 +0000
Message-ID: <1481816708.4317.13.camel@rf-debian.wolfsonmicro.main>
References: <20161215151943.5076-1-clabbe.montjoie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161215151943.5076-1-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2016-12-15 at 16:19 +0100, Corentin Labbe wrote:
> sound/soc/codecs/wm0010.c does not use any miscdevice so this patch
> remove this unnecessary inclusion.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  sound/soc/codecs/wm0010.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
> index 0eb5dcf..4f5f571 100644
> --- a/sound/soc/codecs/wm0010.c
> +++ b/sound/soc/codecs/wm0010.c
> @@ -21,7 +21,6 @@
>  #include <linux/firmware.h>
>  #include <linux/delay.h>
>  #include <linux/fs.h>
> -#include <linux/miscdevice.h>
>  #include <linux/gpio.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/mutex.h>
Looks ok to me.
Acked-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
