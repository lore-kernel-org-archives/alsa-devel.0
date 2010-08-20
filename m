From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Add build infrastructure for WL1273
Date: Fri, 20 Aug 2010 17:25:57 +0100
Message-ID: <1282321557-453-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 98585103915
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 18:26:07 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
List-Id: alsa-devel@alsa-project.org

The Makefile and Kconfig updates for WL1273 appear to have been mising
from the patch posted, add them.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/Kconfig  |    4 ++++
 sound/soc/codecs/Makefile |    2 ++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index a3cfc18..155c127 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -41,6 +41,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_TWL6040 if TWL4030_CORE
 	select SND_SOC_UDA134X
 	select SND_SOC_UDA1380 if I2C
+	select SND_SOC_WL1273 if WL1273_CORE
 	select SND_SOC_WM2000 if I2C
 	select SND_SOC_WM8350 if MFD_WM8350
 	select SND_SOC_WM8400 if MFD_WM8400
@@ -193,6 +194,9 @@ config SND_SOC_UDA134X
 config SND_SOC_UDA1380
         tristate
 
+config SND_SOC_WL1273
+	tristate
+
 config SND_SOC_WM8350
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index b9c4358..10d468e 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -27,6 +27,7 @@ snd-soc-twl4030-objs := twl4030.o
 snd-soc-twl6040-objs := twl6040.o
 snd-soc-uda134x-objs := uda134x.o
 snd-soc-uda1380-objs := uda1380.o
+snd-soc-wl1273-objs := wl1273.o
 snd-soc-wm8350-objs := wm8350.o
 snd-soc-wm8400-objs := wm8400.o
 snd-soc-wm8510-objs := wm8510.o
@@ -98,6 +99,7 @@ obj-$(CONFIG_SND_SOC_TWL4030)	+= snd-soc-twl4030.o
 obj-$(CONFIG_SND_SOC_TWL6040)	+= snd-soc-twl6040.o
 obj-$(CONFIG_SND_SOC_UDA134X)	+= snd-soc-uda134x.o
 obj-$(CONFIG_SND_SOC_UDA1380)	+= snd-soc-uda1380.o
+obj-$(CONFIG_SND_SOC_WL1273)	+= snd-soc-wl1273.o
 obj-$(CONFIG_SND_SOC_WM8350)	+= snd-soc-wm8350.o
 obj-$(CONFIG_SND_SOC_WM8400)	+= snd-soc-wm8400.o
 obj-$(CONFIG_SND_SOC_WM8510)	+= snd-soc-wm8510.o
-- 
1.7.1
