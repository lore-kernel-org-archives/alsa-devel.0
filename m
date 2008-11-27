From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: Fix word wrapping in OMAP Kconfig
Date: Thu, 27 Nov 2008 15:16:40 +0000
Message-ID: <1227799001-16074-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081127151553.GA15999@rakim.wolfsonmicro.main>
	<1227799001-16074-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CD06324354
	for <alsa-devel@alsa-project.org>; Thu, 27 Nov 2008 16:16:42 +0100 (CET)
In-Reply-To: <1227799001-16074-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/omap/Kconfig |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 1cd0176..9a86939 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -44,6 +44,5 @@ config SND_OMAP_SOC_SDP3430
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_TWL4030
 	help
-	  Say Y if you want to add support for SoC audio on Texas Instruments SDP3430.
-
-
+	  Say Y if you want to add support for SoC audio on Texas Instruments
+	  SDP3430.
-- 
1.5.6.5
