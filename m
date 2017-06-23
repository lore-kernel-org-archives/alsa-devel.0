From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH 0/6] add support for Sama5d2 audio PLL and
	enable ClassD
Date: Fri, 23 Jun 2017 11:00:53 +0200
Message-ID: <20170623090059.8371-1-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 99865266D46
 for <alsa-devel@alsa-project.org>; Fri, 23 Jun 2017 11:01:18 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mturquette@baylibre.com, sboyd@codeaurora.org, robh+dt@kernel.org, mark.rutland@arm.com, nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com, linux@armlinux.org.uk, boris.brezillon@free-electrons.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: thomas.petazzoni@free-electrons.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Quentin Schulz <quentin.schulz@free-electrons.com>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This patch series adds support for the audio PLL and enables ClassD that
can be found in ATMEL Sama5d2 SoCs.

There are two audio PLLs (PMC and PAD) that shares the same parent (FRAC).
FRAC can output between 620 and 700MHz and only multiply the rate of its
parent. The two audio PLLs then divide the FRAC rate to best match the
asked rate.

I basically took an old patch series posted by Nicolas on December, 6th
2016[1][2][3] and the comments Boris did on the first version[4] Nicolas
sent on July, 15th 2015.

I also fixed the function used to compute the divisors, removed useless
spinlocks and added a range to the audio frac PLL to stay within vendor's
supported range. Clocks that are children of gclk (generated-clk) are now
able to propagate rate to the audio PLL clocks when needed. However, since
there is no rate locking, we enforce that classd_gclk be the only child of
audio_pll_pmc so we avoid multiple children modifiying parent's rate, and
classd driver modifying parent's rate which would impact the rate of each
of parent's children.

Thanks,
Quentin

[1] https://patchwork.kernel.org/patch/9462351/
[2] https://patchwork.kernel.org/patch/9462347/
[3] https://patchwork.kernel.org/patch/9462349/
[4] https://www.spinics.net/lists/arm-kernel/msg436120.html

Cyrille Pitchen (2):
  ARM: dts: at91: sama5d2: add classd nodes
  ARM: dts: at91: sama5d2_xplained: add pin muxing and enable classd

Nicolas Ferre (1):
  clk: at91: add audio pll clock driver

Quentin Schulz (3):
  clk: at91: clk-generated: remove useless divisor loop
  clk: at91: clk-generated: create function to find best_diff
  clk: at91: clk-generated: make gclk determine audio_pll rate

 .../devicetree/bindings/clock/at91-clock.txt       |  10 +
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        |  16 ++
 arch/arm/boot/dts/sama5d2.dtsi                     |  39 +++-
 arch/arm/mach-at91/Kconfig                         |   4 +
 drivers/clk/at91/Makefile                          |   2 +
 drivers/clk/at91/clk-audio-pll-pad.c               | 204 ++++++++++++++++++
 drivers/clk/at91/clk-audio-pll-pmc.c               | 175 +++++++++++++++
 drivers/clk/at91/clk-audio-pll.c                   | 237 +++++++++++++++++++++
 drivers/clk/at91/clk-generated.c                   |  79 +++++--
 include/linux/clk/at91_pmc.h                       |  25 +++
 sound/soc/atmel/atmel-classd.c                     |  20 +-
 11 files changed, 772 insertions(+), 39 deletions(-)
 create mode 100644 drivers/clk/at91/clk-audio-pll-pad.c
 create mode 100644 drivers/clk/at91/clk-audio-pll-pmc.c
 create mode 100644 drivers/clk/at91/clk-audio-pll.c

-- 
2.11.0
