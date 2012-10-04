From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] ASoC: omap-mcpdm updates for 3.7
Date: Thu,  4 Oct 2012 11:15:07 +0300
Message-ID: <1349338509-3440-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hello Mark, Tony,

The mcpdm driver no longer needs to include any plat/*.h file, clearing the way
for the single kernel image.

Regards,
Peter
---
Peter Ujfalusi (1):
  ASoC: omap-mcpdm: Remove OMAP revision check

Tony Lindgren (1):
  ASoC: Fix wrong include for McPDM

 sound/soc/omap/omap-mcpdm.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

-- 
1.7.12

