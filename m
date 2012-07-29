From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 17/18] ARM: ux500: Add all encompassing
 Sound node to DB8500 Device Tree
Date: Sun, 29 Jul 2012 21:52:28 +0100
Message-ID: <20120729205227.GL4384@opensource.wolfsonmicro.com>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
 <1343393162-11938-18-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8983B265218
 for <alsa-devel@alsa-project.org>; Sun, 29 Jul 2012 22:52:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1343393162-11938-18-git-send-email-lee.jones@linaro.org>
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

On Fri, Jul 27, 2012 at 01:46:01PM +0100, Lee Jones wrote:

>  arch/arm/boot/dts/db8500.dtsi |    8 ++++++++

This is a generic DT include file but...

> +		sound {
> +			compatible = "stericsson,snd-soc-mop500";
> +
> +			stericsson,platform-pcm-dma = <&pcm>;
> +			stericsson,cpu-dai = <&msp1 &msp3>;
> +			stericsson,audio-codec = <&codec>;
> +		};

...this is clearly the board-specific setup for the system, showing how
the CPU and CODEC are hooked up.  This should therefore be in the DT for
whatever board this is you're working on.
