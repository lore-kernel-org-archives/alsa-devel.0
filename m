From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 08/16] irqchip: Add driver for Cirrus Logic
	Madera codecs
Date: Mon, 10 Apr 2017 12:53:26 -0500
Message-ID: <20170410175326.tyz5djxrk3o3xjtr@rob-hp-laptop>
References: <1491386884-30689-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1491386884-30689-9-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
 [209.85.218.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 0EBCC266BA4
 for <alsa-devel@alsa-project.org>; Mon, 10 Apr 2017 19:53:28 +0200 (CEST)
Received: by mail-oi0-f65.google.com with SMTP id g204so13546560oib.2
 for <alsa-devel@alsa-project.org>; Mon, 10 Apr 2017 10:53:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1491386884-30689-9-git-send-email-rf@opensource.wolfsonmicro.com>
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
Cc: gnurou@gmail.com, alsa-devel@alsa-project.org, jason@lakedaemon.net, devicetree@vger.kernel.org, linus.walleij@linaro.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, broonie@kernel.org, tglx@linutronix.de, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 05, 2017 at 11:07:56AM +0100, Richard Fitzgerald wrote:
> The Cirrus Logic Madera codecs (Cirrus Logic CS47L35/85/90/91 and WM1840)
> are highly complex devices containing up to 7 programmable DSPs and many
> other internal sources of interrupts plus a number of GPIOs that can be
> used as interrupt inputs. The large number (>150) of internal interrupt
> sources are managed by an on-board interrupt controller.
> 
> This driver provides the handling for the interrupt controller. As the
> codec is accessed via regmap, we can make use of the generic IRQ
> functionality from regmap to do most of the work. Only around half of
> the possible interrupt source are currently of interest from the driver
> so only this subset is defined. Others can be added in future if needed.
> 
> The KConfig options are not user-configurable because this driver is
> mandatory so is automatically included when the parent MFD driver is
> selected.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---
>  .../interrupt-controller/cirrus,madera.txt         |  31 ++
>  MAINTAINERS                                        |   3 +
>  drivers/irqchip/Kconfig                            |   5 +
>  drivers/irqchip/Makefile                           |   1 +
>  drivers/irqchip/irq-madera.c                       | 349 +++++++++++++++++++++
>  include/linux/irqchip/irq-madera-pdata.h           |  19 ++
>  include/linux/irqchip/irq-madera.h                 |  96 ++++++
>  7 files changed, 504 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/cirrus,madera.txt
>  create mode 100644 drivers/irqchip/irq-madera.c
>  create mode 100644 include/linux/irqchip/irq-madera-pdata.h
>  create mode 100644 include/linux/irqchip/irq-madera.h
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/cirrus,madera.txt b/Documentation/devicetree/bindings/interrupt-controller/cirrus,madera.txt
> new file mode 100644
> index 0000000..4505315
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/cirrus,madera.txt
> @@ -0,0 +1,31 @@
> +Cirrus Logic Madera class audio codec IRQ driver
> +
> +The IRQ properties are members of the parent MFD node.

Just document them in the MFD binding.

> +
> +See also the core bindings for the parent MFD driver:
> +See Documentation/devicetree/bindings/mfd/madera.txt
> +
> +Required properties:
> +  - interrupt-controller : Madera class devices contain interrupt controllers
> +    and may provide interrupt services to other devices.
> +
> +  - #interrupt-cells: the number of cells to describe an IRQ, this should be 2.
> +    The first cell is the IRQ number.
> +    The second cell is the flags, encoded as the trigger masks from
> +    bindings/interrupt-controller/interrupts.txt
> +
> +  - interrupts : The interrupt line the /IRQ signal for the device is
> +    connected to.
> +
> +  - interrupt-parent : The parent interrupt controller.
> +
> +Example:
> +
> +codec: cs47l85@0 {
> +	compatible = "cirrus,cs47l85";
> +
> +	interrupt-controller;
> +	#interrupt-cells = <2>;
> +	interrupts = <&host_irq1>;
> +	interrupt-parent = <&gic>;
> +};
