From: Lee Jones <lee.jones@linaro.org>
Subject: Re: Applied "ASoC: wcd9335: add CLASS-H Controller support" to the
 asoc tree
Date: Thu, 2 Aug 2018 07:31:30 +0100
Message-ID: <20180802063130.GJ4662@dell>
References: <20180801112000.DC6B51124241@debutante.sirena.org.uk>
 <d7c2e466-9f60-9347-bc62-7ed0dc3df91b@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d7c2e466-9f60-9347-bc62-7ed0dc3df91b@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, 01 Aug 2018, Srinivas Kandagatla wrote:

> Hi Mark,
> 
> On 01/08/18 12:20, Mark Brown wrote:
> >   snd-soc-wm0010-objs := wm0010.o
> > diff --git a/sound/soc/codecs/wcd-clsh.c b/sound/soc/codecs/wcd-clsh.c
> > new file mode 100644
> > index 000000000000..2393456cbd97
> > --- /dev/null
> > +++ b/sound/soc/codecs/wcd-clsh.c
> > @@ -0,0 +1,605 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (c) 2015-2016, The Linux Foundation. All rights reserved.
> > +// Copyright (c) 2017-2018, Linaro Limited
> > +
> > +#include <linux/slab.h>
> > +#include <sound/soc.h>
> > +#include <linux/kernel.h>
> > +#include <linux/delay.h>
> > +#include <linux/mfd/wcd9335/wcd9335.h>
> > +#include <linux/mfd/wcd9335/registers.h>
> Without the "[PATCH v2 02/10] mfd: wcd9335: add support to wcd9335 core" It
> would break the build.

This is not a run-time dependency.

Without 02/10 there is no build. :)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
