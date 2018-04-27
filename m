From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: mt6797: switch to SPDX
	license tag
Date: Fri, 27 Apr 2018 11:15:23 +0200
Message-ID: <b4b51172-0de3-b866-ecaa-310adc32ee98@gmail.com>
References: <20180427015445.4334-1-kaichieh.chuang@mediatek.com>
 <20180427015445.4334-2-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id F178A267860
 for <alsa-devel@alsa-project.org>; Fri, 27 Apr 2018 11:15:25 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id t11so1472295wmt.0
 for <alsa-devel@alsa-project.org>; Fri, 27 Apr 2018 02:15:25 -0700 (PDT)
In-Reply-To: <20180427015445.4334-2-kaichieh.chuang@mediatek.com>
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
To: KaiChieh Chuang <kaichieh.chuang@mediatek.com>, garlic.tseng@mediatek.com, broonie@kernel.org, ryder.lee@mediatek.com
Cc: alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com, chipeng.chang@mediatek.com
List-Id: alsa-devel@alsa-project.org



On 04/27/2018 03:54 AM, KaiChieh Chuang wrote:
> Signed-off-by: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
> ---
>  sound/soc/mediatek/mt6797/Makefile                 | 13 +------------
>  sound/soc/mediatek/mt6797/mt6797-afe-clk.c         | 21 ++++++---------------
>  sound/soc/mediatek/mt6797/mt6797-afe-clk.h         | 10 +---------
>  sound/soc/mediatek/mt6797/mt6797-afe-common.h      | 10 +---------
>  sound/soc/mediatek/mt6797/mt6797-afe-pcm.c         | 21 ++++++---------------
>  sound/soc/mediatek/mt6797/mt6797-interconnection.h | 10 +---------
>  sound/soc/mediatek/mt6797/mt6797-mt6351.c          | 21 ++++++---------------
>  sound/soc/mediatek/mt6797/mt6797-reg.h             | 12 ++----------
>  8 files changed, 24 insertions(+), 94 deletions(-)
> 

[...]

> diff --git a/sound/soc/mediatek/mt6797/mt6797-mt6351.c b/sound/soc/mediatek/mt6797/mt6797-mt6351.c
> index d42a9d9fbf3e..9e5866d6819a 100644
> --- a/sound/soc/mediatek/mt6797/mt6797-mt6351.c
> +++ b/sound/soc/mediatek/mt6797/mt6797-mt6351.c
> @@ -1,18 +1,9 @@
> -/*
> - * mt6797-mt6351.c  --  MT6797 MT6351 ALSA SoC machine driver
> - *
> - * Copyright (c) 2018 MediaTek Inc.
> - * Author: Ryder Lee <ryder.lee@mediatek.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 and
> - * only version 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// mt6797-mt6351.c  --  MT6797 MT6351 ALSA SoC machine driver
> +//
> +// Copyright (c) 2018 MediaTek Inc.
> +// Author: KaiChieh Chuang <kaichieh.chuang@mediatek.com>

As we said in the last version, you should not delete Ryder from the author list.

>  
>  #include <linux/module.h>
>  #include <sound/soc.h>
> diff --git a/sound/soc/mediatek/mt6797/mt6797-reg.h b/sound/soc/mediatek/mt6797/mt6797-reg.h
> index 3330f73fc8bb..ffb55367f59f 100644
> --- a/sound/soc/mediatek/mt6797/mt6797-reg.h
> +++ b/sound/soc/mediatek/mt6797/mt6797-reg.h
> @@ -1,17 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * mt6797-reg.h  --  Mediatek 6797 audio driver reg definition
>   *
>   * Copyright (c) 2018 MediaTek Inc.
> - * Author: Garlic Tseng <garlic.tseng@mediatek.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 and
> - * only version 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> + * Author: KaiChieh Chuang <kaichieh.chuang@mediatek.com>

Same here, Garlic is an author as well, don't delete him from the comment.

Regards,
Matthias
