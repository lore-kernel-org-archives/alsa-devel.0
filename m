From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/9] ARM: dts: sun8i: add device tree for
 Lichee Pi Zero with Dock
Date: Tue, 28 Feb 2017 17:02:27 -0600
Message-ID: <CAL_JsqL_fbCpiH3jvF7UuTrWkNSJmk5UyrYBDZ9hwE29+Hrk0w@mail.gmail.com>
References: <20170225123029.55939-1-icenowy@aosc.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 06F1B266718
 for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2017 00:02:55 +0100 (CET)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id B5D5920108
 for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2017 23:02:51 +0000 (UTC)
Received: from mail-yw0-f173.google.com (mail-yw0-f173.google.com
 [209.85.161.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BDC7920274
 for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2017 23:02:48 +0000 (UTC)
Received: by mail-yw0-f173.google.com with SMTP id v200so19698570ywc.3
 for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2017 15:02:48 -0800 (PST)
In-Reply-To: <20170225123029.55939-1-icenowy@aosc.xyz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Icenowy Zheng <icenowy@aosc.xyz>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Vinod Koul <vinod.koul@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, dmaengine@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Feb 25, 2017 at 6:30 AM, Icenowy Zheng <icenowy@aosc.xyz> wrote:
> Lichee Pi Zero features a dock, which adds some functions, and should be
> soldered with the core board of Lichee Pi Zero.
>
> Add support for the dock as a new dts, as soldering is needed to make
> the dock usable and there's functions enabled on the dock that is
> unavailable at the 2.54mm pins of the core board.
>
> Currently no new feature on core board is available in the mainline
> kernel, so the dock dt file only includes the core board device tree.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
>  arch/arm/boot/dts/Makefile                         |  3 +-
>  arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts | 49 ++++++++++++++++++++++
>  2 files changed, 51 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 011808490fed..1aa365306479 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -876,7 +876,8 @@ dtb-$(CONFIG_MACH_SUN8I) += \
>         sun8i-h3-orangepi-plus.dtb \
>         sun8i-h3-orangepi-plus2e.dtb \
>         sun8i-r16-parrot.dtb \
> -       sun8i-v3s-licheepi-zero.dtb
> +       sun8i-v3s-licheepi-zero.dtb \
> +       sun8i-v3s-licheepi-zero-dock.dtb
>  dtb-$(CONFIG_MACH_SUN9I) += \
>         sun9i-a80-optimus.dtb \
>         sun9i-a80-cubieboard4.dtb
> diff --git a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
> new file mode 100644
> index 000000000000..68c114d6b939
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
> @@ -0,0 +1,49 @@
> +/*
> + * Copyright (C) 2016 Icenowy Zheng <icenowy@aosc.xyz>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.

Use SPDX tags here:

SPDX-License-Identifier: (GPL-2.0+ OR MIT)

While it says X11, this is really MIT license text.

> + */
> +
> +#include "sun8i-v3s-licheepi-zero.dts"
> +
> +/ {
> +       model = "Lichee Pi Zero with Dock";
> +       compatible = "licheepi,licheepi-zero-dock", "licheepi,licheepi-zero",
> +                    "allwinner,sun8i-v3s";
> +};
> --
> 2.11.1
>
