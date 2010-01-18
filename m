From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Subject: Re: [PATCH 1/2] ASoC: DaVinci: Voice Codec Support
Date: Mon, 18 Jan 2010 11:58:45 -0600
Message-ID: <4B54A155.3090504@ridgerun.com>
References: <1262902691-15059-1-git-send-email-miguel.aguilar@ridgerun.com>
	<20100108112521.GA10128@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.navvo.net (mail.navvo.net [74.208.67.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C75010380F
	for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2010 19:01:09 +0100 (CET)
In-Reply-To: <20100108112521.GA10128@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com, diego.dompe@ridgerun.com, alsa-devel@alsa-project.org, nsnehaprabha@ti.com, todd.fischer@ridgerun.com, sameo@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,

Please, see the comments below.

> 
>> +static int davinci_vc_client_dev_register(struct davinci_vc *davinci_vc,
>> +				       const char *name,
>> +				       struct platform_device **pdev)
>> +{
>> +	int ret;
>> +
>> +	*pdev = platform_device_alloc(name, -1);
>> +	if (pdev == NULL) {
>> +		dev_err(davinci_vc->dev, "failed to allocate %s\n", name);
>> +		return -ENODEV;
>> +	}
>> +
>> +	(*pdev)->dev.parent = davinci_vc->dev;
>> +	platform_set_drvdata(*pdev, davinci_vc);
> 
> Newer drivers are tending to do this by looking at dev->parent in the
> child device rather than using the

Can you tell me what is driver that is using this new tend? Is this a wrong way 
to register the clients?

> 
>> +	ret = platform_device_add(*pdev);
>> +	if (ret != 0) {
>> +		dev_err(davinci_vc->dev, "failed to register %s: %d\n", name,
>> +			ret);
>> +		platform_device_put(*pdev);
>> +		*pdev = NULL;
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +

>> --- /dev/null
>> +++ b/sound/soc/codecs/cq93vc.c
>> @@ -0,0 +1,342 @@
>> +/*
>> + * ALSA SoC CQ0093 Voice Codec Driver for DaVinci platforms
>> + *
>> + * Copyright (C) 2010 Texas Instruments, Inc
>> + *
>> + * Author: Miguel Aguilar <miguel.aguilar@ridgerun.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
>> + */
>> +#include <linux/module.h>
>> +#include <linux/moduleparam.h>
>> +#include <linux/init.h>
>> +#include <linux/io.h>
>> +#include <linux/delay.h>
>> +#include <linux/pm.h>
>> +#include <linux/i2c.h>
> 
> Not needed.
What headers are not needed?
> 
>> +#include <linux/platform_device.h>
>> +#include <linux/device.h>
>> +#include <linux/clk.h>
>> +#include <linux/mfd/davinci_voicecodec.h>
>> +
>> +#include <sound/core.h>
>> +#include <sound/pcm.h>
>> +#include <sound/pcm_params.h>
>> +#include <sound/soc.h>
>> +#include <sound/soc-dai.h>
>> +#include <sound/soc-dapm.h>
>> +#include <sound/initval.h>
>> +
>> +#include <mach/dm365.h>
>> +
>> +#include "cq93vc.h"
>> +

>> +
>> +static int cq93vc_add_controls(struct snd_soc_codec *codec)
>> +{
>> +	int err, i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(cq93vc_snd_controls); i++) {
>> +		err = snd_ctl_add(codec->card,
>> +				  snd_soc_cnew(&cq93vc_snd_controls[i],
>> +					       codec, NULL));
>> +		if (err < 0)
>> +			return err;
>> +	}
> 
> This is snd_soc_add_controls().

So I can call directly snd_soc_add_controls instead of using the function above?

>> +
>> +static int cq93vc_suspend(struct platform_device *pdev, pm_message_t state)
>> +{
>> +	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
>> +	struct snd_soc_codec *codec = socdev->card->codec;
>> +
>> +	cq93vc_set_bias_level(codec, SND_SOC_BIAS_OFF);
>> +
>> +	return 0;
>> +}
>> +
>> +static int cq93vc_resume(struct platform_device *pdev)
>> +{
>> +	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
>> +	struct snd_soc_codec *codec = socdev->card->codec;
>> +
>> +	cq93vc_set_bias_level(codec, codec->suspend_bias_level);
>> +
>> +	return 0;
>> +}
> 
> These are actually mostly redundant with this hardware - the core will
> bring the driver down to _STANDBY before suspending the driver and your
> _STANDBY and _OFF states are equivalent.  This means that both functions
> should end up being noops.  On the other hand they do no harm.
> 

This means that I can get rid of the function suspend?

>> +static int cq93vc_probe(struct platform_device *pdev)
>> +{
>> +	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
>> +	struct device *dev = &pdev->dev;
>> +	struct snd_soc_codec *codec;
>> +	int ret;
>> +
>> +	socdev->card->codec = cq93vc_codec;
>> +	codec = socdev->card->codec;
>> +
>> +	/* Set the PGA Gain to 18 dB */
>> +	cq93vc_write(codec, DAVINCI_VC_REG05, DAVINCI_VC_REG05_PGA_GAIN);
>> +
>> +	/* Set the DAC digital attenuation to 0 dB */
>> +	cq93vc_write(codec, DAVINCI_VC_REG09, DAVINCI_VC_REG09_DIG_ATTEN);
> 
> The standard thing for things like this is to leave the defaults in the
> driver as whatever the hardware default is then let either the machine
> driver or (better) userspace override it.  This avoids issues with
> defaults being good for one system and not another.

So, Should I remove the values that I seeting above, and let the hardware use 
its default values?
> 
>> +
>> +#ifdef CONFIG_PM
>> +static int cq93vc_codec_suspend(struct platform_device *pdev, pm_message_t m)
>> +{
>> +	return snd_soc_suspend_device(&pdev->dev);
>> +}
>> +
>> +static int cq93vc_codec_resume(struct platform_device *pdev)
>> +{
>> +	return snd_soc_resume_device(&pdev->dev);
>> +}
>> +#else
>> +#define cq93vc_codec_suspend NULL
>> +#define cq93vc_codec_resume NULL
>> +#endif
> 
> This has been removed in favour of relying on more generic kernel
> mechanisms (hopefully).\

What was exactly removed here the NULL version of the functions or the functions 
itself.

Thanks,
Miguel Aguilar
