From: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH v4 0/9] add support for Sama5d2 audio PLLs
 and enable ClassD
Date: Tue, 25 Jul 2017 17:44:19 +0200
Message-ID: <194d2fc6-4c88-bc3b-1127-b4c0bdb7c6a1@microchip.com>
References: <cover.c8ce78c15296190b2aa5c452c0c4512528e28518.1500968090.git-series.quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from esa2.microchip.iphmx.com (esa2.microchip.iphmx.com
 [68.232.149.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 28160266CFE
 for <alsa-devel@alsa-project.org>; Tue, 25 Jul 2017 17:43:39 +0200 (CEST)
In-Reply-To: <cover.c8ce78c15296190b2aa5c452c0c4512528e28518.1500968090.git-series.quentin.schulz@free-electrons.com>
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
To: Quentin Schulz <quentin.schulz@free-electrons.com>, mturquette@baylibre.com, sboyd@codeaurora.org, robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org, alexandre.belloni@free-electrons.com, linux@armlinux.org.uk, boris.brezillon@free-electrons.com, perex@perex.cz, tiwai@suse.com
Cc: thomas.petazzoni@free-electrons.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, cyrille.pitchen@wedev4u.fr, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 25/07/2017 at 09:37, Quentin Schulz wrote:
> This patch series adds support for the audio PLLs and enables ClassD that
> can be found in ATMEL Sama5d2 SoC.
> 
> There are two audio PLLs (PMC and PAD) that shares the same parent (FRAC).
> FRAC can output between 620 and 700MHz and only multiply the rate of its
> parent. The two audio PLLs then divide the FRAC rate to best match the
> asked rate.
> 
> I basically took an old patch series posted by Nicolas on December, 6th
> 2016[1][2][3] and the comments Boris did on the first version[4] Nicolas
> sent on July, 15th 2015.
> 
> I also fixed the function used to compute the divisors, removed useless
> spinlocks and added a range to the audio frac PLL to stay within vendor's
> supported range. Clocks that are children of gclk (generated-clk) are now
> able to propagate rate to the audio PLL clocks when needed.
> 
> However, there are multiple children clocks that could technically
> change the rate of audio_pll (via gck). With the rate locking introduced
> in Jerome Brunet's patch series[5], the first consumer to enable the clock
> will be the one definitely setting the rate of the clock. Without the rate
> locking, the last consumer to set the rate will be able to mess with the
> rate.
> Since audio IPs are most likely to request the same rate, we enforce
> that the only clks able to modify gck rate are those of audio IPs.
> 
> To remain consistent, we deny other clocks to be children of audio_pll.

Quentin,

Thanks for having revived this series. Everything's okay on my side for
this v4. I think that my tag isn't missing from any patch of this
series. Now we surely need to define which path it must take...

Best regards,


> v4:
>  - initialized the clk_init_data structure,
>  - switched to of_clk_parent_fill instead of manually setting
>  parent_names,
>  - removed include of clkdev.h in favor of slab.h,
>  - removed unnecessary second cast in operation,
>  - used clamp instead of two conditions,
>  - removed dependency on clock-output-names, the name is gotten from DT
>  node,
>  - merged all three drivers for audio PLLs (FRAC, PMC, PAD) into one,
> 
> v3:
>  - added a flag per generated clock to know which one is allowed to
>  modify audio_pll rate,
>  - set the flag in setup function depending on the compatible and the
>  clock ID,
> 
> v2:
>  - split big patch containing dt-binding, pll drivers and classd
>  modifications,
>  - removed unused AUDIO_PLL_*FOUT* defines from clk-audio-pll-pmc,
>  - added conditions for audio pll rate setting restriction for SSC and
>  I2S,
>  - renamed all mentions of ACLK to GCLK in classD driver,
> 
> Thanks,
> Quentin
> 
> [1] https://patchwork.kernel.org/patch/9462351/
> [2] https://patchwork.kernel.org/patch/9462347/
> [3] https://patchwork.kernel.org/patch/9462349/
> [4] https://www.spinics.net/lists/arm-kernel/msg436120.html
> [5] http://www.spinics.net/lists/linux-clk/msg17927.html
> 
> Cyrille Pitchen (2):
>   ARM: dts: at91: sama5d2: add classd nodes
>   ARM: dts: at91: sama5d2_xplained: add pin muxing and enable classd
> 
> Quentin Schulz (7):
>   clk: at91: clk-generated: remove useless divisor loop
>   dt-bindings: clk: at91: add audio plls to the compatible list
>   clk: at91: add audio pll clock drivers
>   clk: at91: clk-generated: create function to find best_diff
>   clk: at91: clk-generated: make gclk determine audio_pll rate
>   ASoC: atmel-classd: remove aclk clock from DT binding
>   ASoC: atmel-classd: remove aclk clock
> 
>  Documentation/devicetree/bindings/clock/at91-clock.txt   |  10 +-
>  Documentation/devicetree/bindings/sound/atmel-classd.txt |   9 +-
>  arch/arm/boot/dts/at91-sama5d2_xplained.dts              |  16 +-
>  arch/arm/boot/dts/sama5d2.dtsi                           |  39 +-
>  arch/arm/mach-at91/Kconfig                               |   4 +-
>  drivers/clk/at91/Makefile                                |   1 +-
>  drivers/clk/at91/clk-audio-pll.c                         | 531 ++++++++-
>  drivers/clk/at91/clk-generated.c                         | 101 +-
>  include/linux/clk/at91_pmc.h                             |  25 +-
>  sound/soc/atmel/atmel-classd.c                           |  47 +-
>  10 files changed, 724 insertions(+), 59 deletions(-)
>  create mode 100644 drivers/clk/at91/clk-audio-pll.c
> 
> base-commit: 047a0f692a9354d730dad30f25e1ebd8437b32b1
> 


-- 
Nicolas Ferre
