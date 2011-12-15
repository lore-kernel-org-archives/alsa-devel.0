From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] OMAP4: McBSP: ASoC: Fix FIFO configuration
Date: Thu, 15 Dec 2011 11:32:25 +0200
Message-ID: <1323941547-7714-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hello,

All McBSP ports in OMAP4 has 128 word long FIFO which is not taken into account.
Fix the configuration so we can configure the FIFO for McBSP in OMAP4.

Regards,
Peter
---
Peter Ujfalusi (2):
  OMAP4: mcbsp: Enable FIFO usage
  ASoC: omap-mcbsp: Enable FIFO usage on OMAP4

 arch/arm/mach-omap2/mcbsp.c |    3 +++
 sound/soc/omap/omap-mcbsp.c |    2 +-
 2 files changed, 4 insertions(+), 1 deletions(-)

-- 
1.7.8

