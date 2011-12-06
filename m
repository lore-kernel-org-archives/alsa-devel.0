From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: Include linux/io.h for jz4740 codec
Date: Tue, 06 Dec 2011 09:51:00 +0100
Message-ID: <4EDDD774.3090407@metafoo.de>
References: <1323155940.22557.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-057.synserver.de (smtp-out-061.synserver.de
	[212.40.185.61]) by alsa0.perex.cz (Postfix) with SMTP id 36086103A10
	for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2011 09:50:44 +0100 (CET)
In-Reply-To: <1323155940.22557.0.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 12/06/2011 08:19 AM, Axel Lin wrote:
> Include linux/io.h to fix below build errors:
> 
>   CC      sound/soc/codecs/jz4740.o
> sound/soc/codecs/jz4740.c: In function 'jz4740_codec_read':
> sound/soc/codecs/jz4740.c:82: error: implicit declaration of function 'readl'
> sound/soc/codecs/jz4740.c: In function 'jz4740_codec_write':
> sound/soc/codecs/jz4740.c:92: error: implicit declaration of function 'writel'
> sound/soc/codecs/jz4740.c: In function 'jz4740_codec_probe':
> sound/soc/codecs/jz4740.c:373: error: implicit declaration of function 'ioremap'
> sound/soc/codecs/jz4740.c:373: warning: assignment makes pointer from integer without a cast
> sound/soc/codecs/jz4740.c:393: error: implicit declaration of function 'iounmap'
> make[3]: *** [sound/soc/codecs/jz4740.o] Error 1
> make[2]: *** [sound/soc/codecs] Error 2
> make[1]: *** [sound/soc] Error 2
> make: *** [sound] Error 2
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

> ---
>  sound/soc/codecs/jz4740.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/codecs/jz4740.c b/sound/soc/codecs/jz4740.c
> index 517e2a5..d73d283 100644
> --- a/sound/soc/codecs/jz4740.c
> +++ b/sound/soc/codecs/jz4740.c
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> +#include <linux/io.h>
>  
>  #include <linux/delay.h>
>  
