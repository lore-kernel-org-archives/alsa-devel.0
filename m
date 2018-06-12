From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/8] ASoC: fsi: convert to SPDX identifiers
Date: Mon, 11 Jun 2018 22:15:05 -0300
Message-ID: <CAOMZO5ACWxCandV_KhR7ysR0xoAxG8KO7qYCGA42Daq94ZGOxw@mail.gmail.com>
References: <87po0wdda5.wl-kuninori.morimoto.gx@renesas.com>
 <87o9ggdd94.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f193.google.com (mail-ot0-f193.google.com
 [74.125.82.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E7BDC267253
 for <alsa-devel@alsa-project.org>; Tue, 12 Jun 2018 03:15:06 +0200 (CEST)
Received: by mail-ot0-f193.google.com with SMTP id d19-v6so20589638oti.8
 for <alsa-devel@alsa-project.org>; Mon, 11 Jun 2018 18:15:06 -0700 (PDT)
In-Reply-To: <87o9ggdd94.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Kuninori-san,

On Mon, Jun 11, 2018 at 10:11 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  sound/soc/sh/fsi.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
> index 3bae06dd121f..40bafba2f3b3 100644
> --- a/sound/soc/sh/fsi.c
> +++ b/sound/soc/sh/fsi.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Fifo-attached Serial Interface (FSI) support for SH7724
>   *
> @@ -6,10 +7,6 @@
>   *
>   * Based on ssi.c
>   * Copyright (c) 2007 Manuel Lauss <mano@roarinelk.homelinux.net>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
>   */

Mark prefers that the entire block is converted to // style:

// SPDX-License-Identifier: GPL-2.0
//
// Fifo-attached Serial Interface (FSI) support for SH7724
//
// Copyright (C) 2009 Renesas Solutions Corp.
// Kuninori Morimoto <morimoto.kuninori@renesas.com>
//
// Based on ssi.c
// Copyright (c) 2007 Manuel Lauss <mano@roarinelk.homelinux.net>
