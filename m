From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: codecs: Add support for
	AK5558 ADC driver
Date: Fri, 2 Feb 2018 21:33:18 +0200
Message-ID: <CAHp75VfyVfGdCfjV_iaXFcRcanbgwFSgJRfu8eojdbMONMUOaQ@mail.gmail.com>
References: <1517588406-3295-1-git-send-email-daniel.baluta@nxp.com>
 <1517588406-3295-2-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f194.google.com (mail-qt0-f194.google.com
 [209.85.216.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 5823526791F
 for <alsa-devel@alsa-project.org>; Fri,  2 Feb 2018 20:33:20 +0100 (CET)
Received: by mail-qt0-f194.google.com with SMTP id x27so32277691qtm.12
 for <alsa-devel@alsa-project.org>; Fri, 02 Feb 2018 11:33:20 -0800 (PST)
In-Reply-To: <1517588406-3295-2-git-send-email-daniel.baluta@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: devicetree <devicetree@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, wakasugi.jb@om.asahi-kasei.co.jp, Cosmin Samoila <cosmin.samoila@nxp.com>, Mark Brown <broonie@kernel.org>, Daniel Baluta <daniel.baluta@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Mihai Serban <mihai.serban@nxp.com>, Mihai Serban <mihai.serban@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 2, 2018 at 6:20 PM, Daniel Baluta <daniel.baluta@nxp.com> wrote:
> AK5558 is a 32-bit, 768 kHZ sampling, differential input ADC
> for digital audio systems.
>
> Datasheet is available at:
>
> https://www.akm.com/akm/en/file/datasheet/AK5558VN.pdf
>
> Initial patch includes support for normal and TDM modes.
>
> Signed-off-by: Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>
> [initial coding for 3.18 kernel]
> Signed-off-by: Mihai Serban <mihai.serban@nxp.com>
> [cleanups and porting to 4.9 kernel]
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> [tdm support]
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> [pm support, cleanups and porting to latest kernel]

Thanks for an update.

Couple of nitpicks below, otherwise FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>


> @@ -0,0 +1,626 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*

> + * ak5558.c  --  audio driver for AK5558 ADC

I would remove filename. If file is ever be renamed this will make an
additional noise.

> + *
> + * Copyright (C) 2015 Asahi Kasei Microdevices Corporation
> + * Copyright 2018 NXP
> + */

> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/slab.h>
> +#include <linux/gpio/consumer.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dapm.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <linux/pm_runtime.h>
> +#include <sound/initval.h>
> +#include <linux/i2c.h>
> +#include <sound/tlv.h>
> +#include <linux/of_gpio.h>
> +#include <linux/regmap.h>

I would rather keep it sorted

 +#include <linux/delay.h>
 +#include <linux/gpio/consumer.h>
 +#include <linux/i2c.h>
 +#include <linux/module.h>
 +#include <linux/pm_runtime.h>
 +#include <linux/regmap.h>
 +#include <linux/slab.h>
      // yeah keep an empty line here to split groups
 +#include <sound/initval.h>
 +#include <sound/pcm.h>
 +#include <sound/pcm_params.h>
 +#include <sound/soc.h>
 +#include <sound/soc-dapm.h>
 +#include <sound/tlv.h>

+#include <linux/of_gpio.h>

This one is redundant.

> +static int ak5558_set_dai_mute(struct snd_soc_dai *dai, int mute)
> +{
> +       struct snd_soc_codec *codec = dai->codec;
> +       struct ak5558_priv *ak5558 = snd_soc_codec_get_drvdata(codec);

> +       int ndt = 0;

It might be even

      int ndt = max(ak5558->fs ? 583000 / ak5558->fs : 5, 5);

> +       if (!mute)
> +               return 0;
> +

> +       if (ak5558->fs != 0)
> +               ndt = 583000 / ak5558->fs;
> +
> +       msleep(max(ndt, 5));

...and here just

       msleep(ndt);

But I don't know if Mark is okay with that.

> +
> +       return 0;
> +}

> +       pm_runtime_enable(&i2c->dev);
> +       pm_runtime_disable(&client->dev);

I'm also not sure about these calls, but I leave it to you.

> +static const struct i2c_device_id ak5558_i2c_id[] = {
> +       { "ak5558", 0 },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(i2c, ak5558_i2c_id);

I dunno if it's really helpful to have. Though it's up to Mark and you.

-- 
With Best Regards,
Andy Shevchenko
