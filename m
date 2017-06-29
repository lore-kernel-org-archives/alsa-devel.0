From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/6] clk: at91: add audio pll clock driver
Date: Thu, 29 Jun 2017 16:47:58 -0500
Message-ID: <20170629214758.7a55wtssikekjjh4@rob-hp-laptop>
References: <20170623090059.8371-1-quentin.schulz@free-electrons.com>
 <20170623090059.8371-3-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170623090059.8371-3-quentin.schulz@free-electrons.com>
Sender: linux-clk-owner@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: mturquette@baylibre.com, sboyd@codeaurora.org, mark.rutland@arm.com, nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com, linux@armlinux.org.uk, boris.brezillon@free-electrons.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, thomas.petazzoni@free-electrons.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 23, 2017 at 11:00:55AM +0200, Quentin Schulz wrote:
> From: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> This new clock driver set allows to have a fractional divided clock that
> would generate a precise clock particularly suitable for audio
> applications.
> 
> The main audio pll clock has two children clocks: one that is connected
> to the PMC, the other that can directly drive a pad. As these two routes
> have different enable bits and different dividers and divider formula,
> they are handled by two different drivers. Each of them could modify the
> rate of the main audio pll parent.
> The main audio pll clock can output 620MHz to 700MHz.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  .../devicetree/bindings/clock/at91-clock.txt       |  10 +

It would be nice to see at91 to transition away from a node per clock to 
just clock controller nodes. In any case:

Acked-by: Rob Herring <robh@kernel.org>

>  arch/arm/mach-at91/Kconfig                         |   4 +
>  drivers/clk/at91/Makefile                          |   2 +
>  drivers/clk/at91/clk-audio-pll-pad.c               | 204 ++++++++++++++++++
>  drivers/clk/at91/clk-audio-pll-pmc.c               | 175 +++++++++++++++
>  drivers/clk/at91/clk-audio-pll.c                   | 237 +++++++++++++++++++++
>  include/linux/clk/at91_pmc.h                       |  25 +++
>  sound/soc/atmel/atmel-classd.c                     |  20 +-
>  8 files changed, 658 insertions(+), 19 deletions(-)
>  create mode 100644 drivers/clk/at91/clk-audio-pll-pad.c
>  create mode 100644 drivers/clk/at91/clk-audio-pll-pmc.c
>  create mode 100644 drivers/clk/at91/clk-audio-pll.c
