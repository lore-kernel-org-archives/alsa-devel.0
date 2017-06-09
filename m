From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 12/17] gpio: madera: Support Cirrus
	Logic Madera class codecs
Date: Fri, 9 Jun 2017 11:08:25 +0200
Message-ID: <CACRpkdYxbGcEd0wSAC8EyARSvc7Q6LJb0SLks+GPDvjKbG4=8g@mail.gmail.com>
References: <1496415790-19164-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1496415790-19164-13-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f182.google.com (mail-io0-f182.google.com
 [209.85.223.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FC0C266CB8
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 11:08:27 +0200 (CEST)
Received: by mail-io0-f182.google.com with SMTP id k93so30609307ioi.2
 for <alsa-devel@alsa-project.org>; Fri, 09 Jun 2017 02:08:27 -0700 (PDT)
In-Reply-To: <1496415790-19164-13-git-send-email-rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jason Cooper <jason@lakedaemon.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "open list:WOLFSON MICROELECTRONICS DRIVERS" <patches@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 2, 2017 at 5:03 PM, Richard Fitzgerald
<rf@opensource.wolfsonmicro.com> wrote:

> This adds support for the GPIOs on Cirrus Logic Madera class codecs.
> Any pins not used for special functions (see the pinctrl driver) can be
> used as general single-bit input or output lines. The number of available
> GPIOs varies between codecs.
>
> Signed-off-by: Nariman Poushin <nariman@opensource.wolfsonmicro.com>
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---
> Changes since V2:
> - Minor change now to use the parent MFD DT node for out DT bindings

This looks good to me
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I can also merge it through the GPIO tree once it is clear that the
MFD portions are getting merged.

> +config GPIO_MADERA
> +       bool "Cirrus Logic Madera class codecs"
> +       depends on PINCTRL_MADERA

As this guards compilation until the MFD driver arrives.

Yours,
Linus Walleij
