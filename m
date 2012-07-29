From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 01/18] Documentation: Describe the ux500
 realated audio related DT nodes
Date: Sun, 29 Jul 2012 21:31:06 +0100
Message-ID: <20120729203106.GD4384@opensource.wolfsonmicro.com>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
 <1343393162-11938-2-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0911E265238
 for <alsa-devel@alsa-project.org>; Sun, 29 Jul 2012 22:31:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1343393162-11938-2-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, olalilja@yahoo.se, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 27, 2012 at 01:45:45PM +0100, Lee Jones wrote:

> +++ b/Documentation/devicetree/bindings/sound/ux500.txt
> @@ -0,0 +1,62 @@
> +* ux500 Audio Driver and ab8500 Audio CODEC
> +
> +Required properties:
> + - compatible:
> +   - Machine Driver : "stericsson,snd-soc-mop500"
> +   - CPU-side DAI   : "stericsson,ux500-msp-i2s"
> +   - DMA (platform) : "stericsson,ux500-pcm"
> +   - Audio CODEC    : "stericsson,ab8500-codec"

What is this a binding document for?  It looks like the binding for a
machine driver...

> +Optional properties:
> + - reg              : Physical base address and length of the device's registers.
> + - interrupts       : The interrupt outputs from the device.
> + - interrupt-parent : The parent interrupt controller.
> + - <name>-supply    : Phandle to the regulator <name> supply

...but these don't look anything like machine driver properties.
