From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH] ASoC: mt6797: switch to SPDX license tag
Date: Thu, 26 Apr 2018 12:46:54 +0200
Message-ID: <7071d4e1-daf1-4847-1dbd-e5c77c709724@gmail.com>
References: <20180426025605.31874-1-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f51.google.com (mail-pg0-f51.google.com [74.125.83.51])
 by alsa0.perex.cz (Postfix) with ESMTP id C632926722C
 for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2018 12:47:00 +0200 (CEST)
Received: by mail-pg0-f51.google.com with SMTP id i29so14118435pgn.12
 for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2018 03:47:00 -0700 (PDT)
In-Reply-To: <20180426025605.31874-1-kaichieh.chuang@mediatek.com>
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
To: KaiChieh Chuang <kaichieh.chuang@mediatek.com>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, ryder.lee@mediatek.com, wsd_upstream@mediatek.com, chipeng.chang@mediatek.com, garlic.tseng@mediatek.com, linux-mediatek@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi KaiChieh,

On 04/26/2018 04:56 AM, KaiChieh Chuang wrote:
> diff --git a/sound/soc/mediatek/mt6797/mt6797-mt6351.c b/sound/soc/mediatek/mt6797/mt6797-mt6351.c
> index d42a9d9fbf3e..c3f58bac0960 100644
> --- a/sound/soc/mediatek/mt6797/mt6797-mt6351.c
> +++ b/sound/soc/mediatek/mt6797/mt6797-mt6351.c
> @@ -1,17 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * mt6797-mt6351.c  --  MT6797 MT6351 ALSA SoC machine driver
>   *
>   * Copyright (c) 2018 MediaTek Inc.
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
> + * Author: KaiChieh Chuang <kaichieh.chuang@mediatek.com>

I think you don't want to delete the first author but add you as a second one.
I've seen this in other parts of the patch as well. Please check.

Regards,
Matthias

>   */
>  
>  #include <linux/module.h>
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
>   */
>  
>  #ifndef _MT6797_REG_H_
> 
