From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 21/21] ASoC: Sort WM9090 in with the CODEC
	drivers
Date: Sat,  3 Dec 2011 21:33:29 +0000
Message-ID: <1322948009-27658-21-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1322948009-27658-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6E17D10385A
	for <alsa-devel@alsa-project.org>; Sat,  3 Dec 2011 22:33:43 +0100 (CET)
In-Reply-To: <1322948009-27658-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The driver itself has been a regular CODEC driver for a while now.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/Kconfig  |    6 +++---
 sound/soc/codecs/Makefile |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 087cc12..665dd73 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -418,6 +418,9 @@ config SND_SOC_WM8996
 config SND_SOC_WM9081
 	tristate
 
+config SND_SOC_WM9090
+	tristate
+
 config SND_SOC_WM9705
 	tristate
 
@@ -436,6 +439,3 @@ config SND_SOC_MAX9877
 
 config SND_SOC_TPA6130A2
 	tristate
-
-config SND_SOC_WM9090
-	tristate
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 15f187a..b2a8011 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -91,6 +91,7 @@ snd-soc-wm8993-objs := wm8993.o
 snd-soc-wm8994-objs := wm8994.o wm8958-dsp2.o
 snd-soc-wm8995-objs := wm8995.o
 snd-soc-wm9081-objs := wm9081.o
+snd-soc-wm9090-objs := wm9090.o
 snd-soc-wm9705-objs := wm9705.o
 snd-soc-wm9712-objs := wm9712.o
 snd-soc-wm9713-objs := wm9713.o
@@ -100,7 +101,6 @@ snd-soc-wm-hubs-objs := wm_hubs.o
 # Amp
 snd-soc-max9877-objs := max9877.o
 snd-soc-tpa6130a2-objs := tpa6130a2.o
-snd-soc-wm9090-objs := wm9090.o
 
 obj-$(CONFIG_SND_SOC_88PM860X)	+= snd-soc-88pm860x.o
 obj-$(CONFIG_SND_SOC_AC97_CODEC)	+= snd-soc-ac97.o
@@ -195,6 +195,7 @@ obj-$(CONFIG_SND_SOC_WM8993)	+= snd-soc-wm8993.o
 obj-$(CONFIG_SND_SOC_WM8994)	+= snd-soc-wm8994.o
 obj-$(CONFIG_SND_SOC_WM8995)	+= snd-soc-wm8995.o
 obj-$(CONFIG_SND_SOC_WM9081)	+= snd-soc-wm9081.o
+obj-$(CONFIG_SND_SOC_WM9090)	+= snd-soc-wm9090.o
 obj-$(CONFIG_SND_SOC_WM9705)	+= snd-soc-wm9705.o
 obj-$(CONFIG_SND_SOC_WM9712)	+= snd-soc-wm9712.o
 obj-$(CONFIG_SND_SOC_WM9713)	+= snd-soc-wm9713.o
@@ -204,4 +205,3 @@ obj-$(CONFIG_SND_SOC_WM_HUBS)	+= snd-soc-wm-hubs.o
 # Amp
 obj-$(CONFIG_SND_SOC_MAX9877)	+= snd-soc-max9877.o
 obj-$(CONFIG_SND_SOC_TPA6130A2)	+= snd-soc-tpa6130a2.o
-obj-$(CONFIG_SND_SOC_WM9090)	+= snd-soc-wm9090.o
-- 
1.7.7.3
