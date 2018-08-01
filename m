From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: Applied "ASoC: wcd9335: add CLASS-H Controller
 support" to the asoc tree
Date: Wed, 1 Aug 2018 13:26:52 +0100
Message-ID: <d7c2e466-9f60-9347-bc62-7ed0dc3df91b@linaro.org>
References: <20180801112000.DC6B51124241@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com [74.125.82.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 02F902677D3
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2018 14:26:54 +0200 (CEST)
Received: by mail-wm0-f48.google.com with SMTP id f21-v6so6765034wmc.5
 for <alsa-devel@alsa-project.org>; Wed, 01 Aug 2018 05:26:54 -0700 (PDT)
In-Reply-To: <20180801112000.DC6B51124241@debutante.sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, vkoul@kernel.org, robh+dt@kernel.org, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 01/08/18 12:20, Mark Brown wrote:
>   snd-soc-wm0010-objs := wm0010.o
> diff --git a/sound/soc/codecs/wcd-clsh.c b/sound/soc/codecs/wcd-clsh.c
> new file mode 100644
> index 000000000000..2393456cbd97
> --- /dev/null
> +++ b/sound/soc/codecs/wcd-clsh.c
> @@ -0,0 +1,605 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2015-2016, The Linux Foundation. All rights reserved.
> +// Copyright (c) 2017-2018, Linaro Limited
> +
> +#include <linux/slab.h>
> +#include <sound/soc.h>
> +#include <linux/kernel.h>
> +#include <linux/delay.h>
> +#include <linux/mfd/wcd9335/wcd9335.h>
> +#include <linux/mfd/wcd9335/registers.h>
Without the "[PATCH v2 02/10] mfd: wcd9335: add support to wcd9335 core" 
It would break the build.


--srini
