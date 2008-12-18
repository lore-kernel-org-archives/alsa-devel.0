From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] ASoC: Ease merge difficulties from new
	architectures
Date: Thu, 18 Dec 2008 17:30:56 +0000
Message-ID: <1229621458-2144-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081218173021.GA25332@rakim.wolfsonmicro.main>
	<1229621458-2144-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 708C21037E3
	for <alsa-devel@alsa-project.org>; Thu, 18 Dec 2008 18:30:59 +0100 (CET)
In-Reply-To: <1229621458-2144-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Rather than listing lots of architectures per line in Kconfig and
Makefile, causing merge conflicts all the time, have one per line
in alphabetical order.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/Kconfig  |   10 +++++-----
 sound/soc/Makefile |   12 ++++++++++--
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 615ebf0..ef025c6 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -22,16 +22,16 @@ if SND_SOC
 config SND_SOC_AC97_BUS
 	bool
 
-# All the supported Soc's
+# All the supported SoCs
 source "sound/soc/atmel/Kconfig"
 source "sound/soc/au1x/Kconfig"
+source "sound/soc/blackfin/Kconfig"
+source "sound/soc/davinci/Kconfig"
+source "sound/soc/fsl/Kconfig"
+source "sound/soc/omap/Kconfig"
 source "sound/soc/pxa/Kconfig"
 source "sound/soc/s3c24xx/Kconfig"
 source "sound/soc/sh/Kconfig"
-source "sound/soc/fsl/Kconfig"
-source "sound/soc/davinci/Kconfig"
-source "sound/soc/omap/Kconfig"
-source "sound/soc/blackfin/Kconfig"
 
 # Supported codecs
 source "sound/soc/codecs/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 4d475c3..86a9b1f 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -1,5 +1,13 @@
 snd-soc-core-objs := soc-core.o soc-dapm.o
 
 obj-$(CONFIG_SND_SOC)	+= snd-soc-core.o
-obj-$(CONFIG_SND_SOC)	+= codecs/ atmel/ pxa/ s3c24xx/ sh/ fsl/ davinci/
-obj-$(CONFIG_SND_SOC)	+= omap/ au1x/ blackfin/
+obj-$(CONFIG_SND_SOC)	+= codecs/
+obj-$(CONFIG_SND_SOC)	+= atmel/
+obj-$(CONFIG_SND_SOC)	+= au1x/
+obj-$(CONFIG_SND_SOC)	+= blackfin/
+obj-$(CONFIG_SND_SOC)	+= davinci/
+obj-$(CONFIG_SND_SOC)	+= fsl/
+obj-$(CONFIG_SND_SOC)	+= omap/
+obj-$(CONFIG_SND_SOC)	+= pxa/
+obj-$(CONFIG_SND_SOC)	+= s3c24xx/
+obj-$(CONFIG_SND_SOC)	+= sh/
-- 
1.5.6.5
