From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/9] ASoC: Complete Beagleboard support
Date: Fri, 23 Jan 2009 17:18:32 +0000
Message-ID: <1232731120-6144-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090123171619.GB6003@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E3F9724495
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2009 18:18:42 +0100 (CET)
In-Reply-To: <20090123171619.GB6003@rakim.wolfsonmicro.main>
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
Cc: Steve Sakoman <sakoman@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Steve Sakoman <steve@sakoman.com>
List-Id: alsa-devel@alsa-project.org

From: Steve Sakoman <sakoman@gmail.com>

Commit dc06102a0c8b5aa0dd7f9a40ce241e793c252a87 in the asoc tree
did not include the necessary Kconfig and Makefile changes.  This patch
completes the support for Beagleboard

Signed-off-by: Steve Sakoman <steve@sakoman.com>
Acked-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/omap/Kconfig  |   10 ++++++++++
 sound/soc/omap/Makefile |    2 ++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 4f7f040..ccd8973 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -55,3 +55,13 @@ config SND_OMAP_SOC_OMAP3_PANDORA
 	select SND_SOC_TWL4030
 	help
 	  Say Y if you want to add support for SoC audio on the OMAP3 Pandora.
+
+config SND_OMAP_SOC_OMAP3_BEAGLE
+	tristate "SoC Audio support for OMAP3 Beagle"
+	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP3_BEAGLE
+	select SND_OMAP_SOC_MCBSP
+	select SND_SOC_TWL4030
+	help
+	  Say Y if you want to add support for SoC audio on the Beagleboard.
+
+
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index 76fedd9..0c9e4ac 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -12,6 +12,7 @@ snd-soc-overo-objs := overo.o
 snd-soc-omap2evm-objs := omap2evm.o
 snd-soc-sdp3430-objs := sdp3430.o
 snd-soc-omap3pandora-objs := omap3pandora.o
+snd-soc-omap3beagle-objs := omap3beagle.o
 
 obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
 obj-$(CONFIG_SND_OMAP_SOC_OSK5912) += snd-soc-osk5912.o
@@ -19,3 +20,4 @@ obj-$(CONFIG_SND_OMAP_SOC_OVERO) += snd-soc-overo.o
 obj-$(CONFIG_MACH_OMAP2EVM) += snd-soc-omap2evm.o
 obj-$(CONFIG_SND_OMAP_SOC_SDP3430) += snd-soc-sdp3430.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_PANDORA) += snd-soc-omap3pandora.o
+obj-$(CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE) += snd-soc-omap3beagle.o
-- 
1.5.6.5
