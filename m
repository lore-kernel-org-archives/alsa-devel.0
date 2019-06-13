From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: Re: [PATCH v1 1/6] ASoC: sgtl5000: Fix definition of
	VAG Ramp Control
Date: Thu, 13 Jun 2019 09:05:09 +0000
Message-ID: <79fa1a0855bfcc1abad348aa047e7a69fffb8225.camel@toradex.com>
References: <20190521103619.4707-1-oleksandr.suvorov@toradex.com>
 <20190521103619.4707-2-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50118.outbound.protection.outlook.com [40.107.5.118])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BAD70F80794
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2019 11:05:13 +0200 (CEST)
In-Reply-To: <20190521103619.4707-2-oleksandr.suvorov@toradex.com>
Content-Language: en-US
Content-ID: <076A28A3E55D844EA3B5769359C1B9E2@eurprd05.prod.outlook.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "festevam@gmail.com" <festevam@gmail.com>, Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc: Igor Opaniuk <igor.opaniuk@toradex.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2019-05-21 at 13:36 +0300, Oleksandr Suvorov wrote:
> SGTL5000_SMALL_POP is a bit mask, not a value. Usage of
> correct definition makes device probing code more clear.
> 
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

> ---
> 
>  sound/soc/codecs/sgtl5000.c | 2 +-
>  sound/soc/codecs/sgtl5000.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git sound/soc/codecs/sgtl5000.c sound/soc/codecs/sgtl5000.c

I'm not sure how exactly you generated this patch set but usually git
format-patch inserts an additional folder level called a/b which is
what git am accepts by default e.g.

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c

> index a6a4748c97f9..5e49523ee0b6 100644
> --- sound/soc/codecs/sgtl5000.c
> +++ sound/soc/codecs/sgtl5000.c

Of course, the same a/b stuff applies here:

--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c

> @@ -1296,7 +1296,7 @@ static int sgtl5000_probe(struct
> snd_soc_component *component)
>  
>  	/* enable small pop, introduce 400ms delay in turning off */
>  	snd_soc_component_update_bits(component,
> SGTL5000_CHIP_REF_CTRL,
> -				SGTL5000_SMALL_POP, 1);
> +				SGTL5000_SMALL_POP,
> SGTL5000_SMALL_POP);
>  
>  	/* disable short cut detector */
>  	snd_soc_component_write(component, SGTL5000_CHIP_SHORT_CTRL,
> 0);
> diff --git sound/soc/codecs/sgtl5000.h sound/soc/codecs/sgtl5000.h
> index 18cae08bbd3a..a4bf4bca95bf 100644
> --- sound/soc/codecs/sgtl5000.h
> +++ sound/soc/codecs/sgtl5000.h
> @@ -273,7 +273,7 @@
>  #define SGTL5000_BIAS_CTRL_MASK			0x000e
>  #define SGTL5000_BIAS_CTRL_SHIFT		1
>  #define SGTL5000_BIAS_CTRL_WIDTH		3
> -#define SGTL5000_SMALL_POP			1
> +#define SGTL5000_SMALL_POP			0x0001
>  
>  /*
>   * SGTL5000_CHIP_MIC_CTRL
> -- 
> 2.20.1
