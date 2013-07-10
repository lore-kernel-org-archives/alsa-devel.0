From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH v4 1/7] sound: sam9x5_wm8731: machine
 driver for at91sam9x5 wm8731 boards
Date: Wed, 10 Jul 2013 11:30:24 +0200
Message-ID: <CACQ1gAjEvrKQ8Amb_fKj-VUJqmbtGuRm6=9zdtVj9MBsVcn18Q@mail.gmail.com>
References: <1373372929-17800-1-git-send-email-richard.genoud@gmail.com>
 <1373379933-32749-1-git-send-email-richard.genoud@gmail.com>
 <1373379933-32749-2-git-send-email-richard.genoud@gmail.com>
 <51DCFB24.4080107@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f174.google.com (mail-ie0-f174.google.com
 [209.85.223.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 923002656A5
 for <alsa-devel@alsa-project.org>; Wed, 10 Jul 2013 11:30:45 +0200 (CEST)
Received: by mail-ie0-f174.google.com with SMTP id 9so14552301iec.5
 for <alsa-devel@alsa-project.org>; Wed, 10 Jul 2013 02:30:44 -0700 (PDT)
In-Reply-To: <51DCFB24.4080107@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bo Shen <voice.shen@atmel.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, devicetree-discuss@lists.ozlabs.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

2013/7/10 Bo Shen <voice.shen@atmel.com>:
> Hi Richard,
Hi !

> On 7/9/2013 22:25, Richard Genoud wrote:
> [snip]
>
>
>> +#include <linux/module.h>
>> +#include <linux/moduleparam.h>
>> +#include <linux/kernel.h>
>> +#include <linux/clk.h>
>> +#include <linux/timer.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/i2c.h>
>> +
>> +#include <linux/atmel-ssc.h>
>> +
>> +#include <sound/core.h>
>> +#include <sound/pcm.h>
>> +#include <sound/pcm_params.h>
>> +#include <sound/soc.h>
>> +
>> +#include <asm/mach-types.h>
>> +#include <mach/hardware.h>
>> +#include <mach/gpio.h>
>> +
>> +#include "../codecs/wm8731.h"
>> +#include "atmel-pcm.h"
>> +#include "atmel_ssc_dai.h"
>
>
> I think some of the header file include is not needed. I keep them as simple
> as following:
> ---8>---
> #include <linux/clk.h>
> #include <linux/module.h>
> #include <linux/of.h>
> #include <linux/of_device.h>
> #include <linux/pinctrl/consumer.h>
>
> #include <sound/soc.h>
>
> #include "../codecs/wm8731.h"
> #include "atmel_ssc_dai.h"
> ---<8---
ooopps ! I forgot to do some cleaning in those after the file rework. Thanks !

>
>> +#define MCLK_RATE 12288000
>> +
>> +#define DRV_NAME "sam9x5-snd-wm8731"
>> +
>> +/*
>> + * Authorized rates are:
>> + * Rate = MCLK_RATE / (n * 2)
>> + * Where n is in [1..4095]
>> + * (cf register SSC_CMR)
>> + */
>> +static unsigned int rates[] = {
>> +       8000,
>> +       16000,
>> +       32000,
>> +       48000,
>> +       64000,
>> +       96000,
>> +};
>
>
> This is decided by the codec, while not ssc when ssc in slave mode.
yes.

>> +static struct snd_pcm_hw_constraint_list hw_rates = {
>> +       .count = ARRAY_SIZE(rates),
>> +       .list = rates,
>> +};
>> +
>
>
> [snip]
>
>
>> +
>> +       at91sam9x5ek_dai.dai_fmt = snd_soc_of_parse_daifmt(np, "atmel,");
>
>
> We can put this into at91sam9x5ek_dai directly, not need to parse it then.
> example as following:
> ---8>---
> .dai_fmt = SND_SOC_DAIFMT_I2S
>                 | SND_SOC_DAIFMT_NB_NF
>                 | SND_SOC_DAIFMT_CBM_CFM,
> ---<8---
yes, I removed that for the older machine driver, without thinking that much.
It's better hardcorded like that.


Thanks for your comments !
