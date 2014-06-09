From: Oder Chiou <oder_chiou@realtek.com>
Subject: Re: [PATCH] ASoC: rl6231: Remove unneeded inclusion of
	header files
Date: Mon, 9 Jun 2014 05:41:25 +0000
Message-ID: <7EB0DE829A537248AF2ED30C97D12694371374@RTITMBSV03.realtek.com.tw>
References: <1401778595.19083.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CB6B2655FF
 for <alsa-devel@alsa-project.org>; Mon,  9 Jun 2014 07:41:37 +0200 (CEST)
In-Reply-To: <1401778595.19083.1.camel@phoenix>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Axel Lin [mailto:axel.lin@ingics.com]
> Sent: Tuesday, June 03, 2014 2:57 PM
> To: Mark Brown
> Cc: Oder Chiou; Liam Girdwood; alsa-devel@alsa-project.org
> Subject: [PATCH] ASoC: rl6231: Remove unneeded inclusion of header files
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  sound/soc/codecs/rl6231.c | 19 -------------------
>  1 file changed, 19 deletions(-)
> 
> diff --git a/sound/soc/codecs/rl6231.c b/sound/soc/codecs/rl6231.c
> index 7b82fbe..56650d6 100644
> --- a/sound/soc/codecs/rl6231.c
> +++ b/sound/soc/codecs/rl6231.c
> @@ -11,25 +11,6 @@
>   */
> 
>  #include <linux/module.h>
> -#include <linux/moduleparam.h>
> -#include <linux/init.h>
> -#include <linux/delay.h>
> -#include <linux/pm.h>
> -#include <linux/gpio.h>
> -#include <linux/i2c.h>
> -#include <linux/regmap.h>
> -#include <linux/of.h>
> -#include <linux/of_gpio.h>
> -#include <linux/platform_device.h>
> -#include <linux/spi/spi.h>
> -#include <linux/acpi.h>
> -#include <sound/core.h>
> -#include <sound/pcm.h>
> -#include <sound/pcm_params.h>
> -#include <sound/soc.h>
> -#include <sound/soc-dapm.h>
> -#include <sound/initval.h>
> -#include <sound/tlv.h>
> 
>  #include "rl6231.h"
> 
> --
> 1.8.3.2
> 

Tested-by: Oder Chiou <oder_chiou@realtek.com>

Thanks
