From: Padmavathi Venna <padma.v@samsung.com>
Subject: [PATCH 0/2] ARM: Exynos: Enable I2S platform support for Exynos5
Date: Wed, 25 Jul 2012 17:41:23 +0530
Message-ID: <1343218285-30535-1-git-send-email-padma.v@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org
Cc: padma.v@samsung.com, rcsekar@samsung.com, sbkim73@samsung.com, sangsu4u.park@samsung.com, ben-linux@fluff.org, kgene.kim@samsung.com, olofj@google.com, thutt@chromium.org, joshi@samsung.com
List-Id: alsa-devel@alsa-project.org

This patch set enables device tree based platform support for the three I2S
controllers on Samsung's Exynos5 SoC's.

Padmavathi Venna (2):
  ARM: dts: Add nodes for i2s controllers for Samsung Exynos5 platforms
  ARM: EXYNOS: Enable platform support for I2S controllers

 arch/arm/boot/dts/exynos5250-smdk5250.dts |   15 +++++++++++++++
 arch/arm/boot/dts/exynos5250.dtsi         |   28 ++++++++++++++++++++++++++++
 arch/arm/mach-exynos/mach-exynos5-dt.c    |    6 ++++++
 3 files changed, 49 insertions(+), 0 deletions(-)

-- 
1.7.4.4
