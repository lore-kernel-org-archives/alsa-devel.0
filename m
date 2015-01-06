From: Bo Shen <voice.shen@atmel.com>
Subject: Re: [PATCH] sound: soc: atmel sam9g20_wm8731: remove
	useless include
Date: Tue, 6 Jan 2015 18:14:12 +0800
Message-ID: <54ABB574.30602@atmel.com>
References: <1420536080-29181-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eusmtp01.atmel.com (eusmtp01.atmel.com [212.144.249.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A87B2604AE
 for <alsa-devel@alsa-project.org>; Tue,  6 Jan 2015 11:17:12 +0100 (CET)
In-Reply-To: <1420536080-29181-1-git-send-email-alexandre.belloni@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Alexandre Belloni,

On 01/06/2015 05:21 PM, Alexandre Belloni wrote:
> A mach/ header is included but never used. Simply remove it.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Thanks for your patch.

Acked-by: Bo Shen <voice.shen@atmel.com>

> ---
>   sound/soc/atmel/sam9g20_wm8731.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
> index 66b66d0e7514..531728975bbb 100644
> --- a/sound/soc/atmel/sam9g20_wm8731.c
> +++ b/sound/soc/atmel/sam9g20_wm8731.c
> @@ -47,7 +47,6 @@
>   #include <sound/soc.h>
>
>   #include <asm/mach-types.h>

Btw, do you consider to remove this also?

> -#include <mach/hardware.h>
>
>   #include "../codecs/wm8731.h"
>   #include "atmel-pcm.h"
>

Best Regards,
Bo Shen
