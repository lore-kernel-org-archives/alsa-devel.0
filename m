From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: rt5665: Make SND_SOC_RT5665 entry sort
	in Kconfig and Makefile
Date: Fri,  9 Dec 2016 16:56:24 +0800
Message-ID: <20161209085624.9315-1-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f68.google.com (mail-pg0-f68.google.com [74.125.83.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 8785E2676B2
 for <alsa-devel@alsa-project.org>; Fri,  9 Dec 2016 09:56:38 +0100 (CET)
Received: by mail-pg0-f68.google.com with SMTP id 3so1708367pgd.0
 for <alsa-devel@alsa-project.org>; Fri, 09 Dec 2016 00:56:38 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Axel Lin <axel.lin@ingics.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/Kconfig  | 10 +++++-----
 sound/soc/codecs/Makefile |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 9e1718a..cfc108e 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -117,8 +117,8 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_RT5651 if I2C
 	select SND_SOC_RT5659 if I2C
 	select SND_SOC_RT5660 if I2C
-	select SND_SOC_RT5665 if I2C
 	select SND_SOC_RT5663 if I2C
+	select SND_SOC_RT5665 if I2C
 	select SND_SOC_RT5670 if I2C
 	select SND_SOC_RT5677 if I2C && SPI_MASTER
 	select SND_SOC_SGTL5000 if I2C
@@ -668,8 +668,8 @@ config SND_SOC_RL6231
 	default y if SND_SOC_RT5651=y
 	default y if SND_SOC_RT5659=y
 	default y if SND_SOC_RT5660=y
-	default y if SND_SOC_RT5665=y
 	default y if SND_SOC_RT5663=y
+	default y if SND_SOC_RT5665=y
 	default y if SND_SOC_RT5670=y
 	default y if SND_SOC_RT5677=y
 	default m if SND_SOC_RT5514=m
@@ -679,8 +679,8 @@ config SND_SOC_RL6231
 	default m if SND_SOC_RT5651=m
 	default m if SND_SOC_RT5659=m
 	default m if SND_SOC_RT5660=m
-	default m if SND_SOC_RT5665=m
 	default m if SND_SOC_RT5663=m
+	default m if SND_SOC_RT5665=m
 	default m if SND_SOC_RT5670=m
 	default m if SND_SOC_RT5677=m
 
@@ -728,10 +728,10 @@ config SND_SOC_RT5659
 config SND_SOC_RT5660
 	tristate
 
-config SND_SOC_RT5665
+config SND_SOC_RT5663
 	tristate
 
-config SND_SOC_RT5663
+config SND_SOC_RT5665
 	tristate
 
 config SND_SOC_RT5670
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 7e1dad7..2624c73 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -118,8 +118,8 @@ snd-soc-rt5645-objs := rt5645.o
 snd-soc-rt5651-objs := rt5651.o
 snd-soc-rt5659-objs := rt5659.o
 snd-soc-rt5660-objs := rt5660.o
-snd-soc-rt5665-objs := rt5665.o
 snd-soc-rt5663-objs := rt5663.o
+snd-soc-rt5665-objs := rt5665.o
 snd-soc-rt5670-objs := rt5670.o
 snd-soc-rt5677-objs := rt5677.o
 snd-soc-rt5677-spi-objs := rt5677-spi.o
@@ -346,8 +346,8 @@ obj-$(CONFIG_SND_SOC_RT5645)	+= snd-soc-rt5645.o
 obj-$(CONFIG_SND_SOC_RT5651)	+= snd-soc-rt5651.o
 obj-$(CONFIG_SND_SOC_RT5659)	+= snd-soc-rt5659.o
 obj-$(CONFIG_SND_SOC_RT5660)	+= snd-soc-rt5660.o
-obj-$(CONFIG_SND_SOC_RT5665)	+= snd-soc-rt5665.o
 obj-$(CONFIG_SND_SOC_RT5663)	+= snd-soc-rt5663.o
+obj-$(CONFIG_SND_SOC_RT5665)	+= snd-soc-rt5665.o
 obj-$(CONFIG_SND_SOC_RT5670)	+= snd-soc-rt5670.o
 obj-$(CONFIG_SND_SOC_RT5677)	+= snd-soc-rt5677.o
 obj-$(CONFIG_SND_SOC_RT5677_SPI)	+= snd-soc-rt5677-spi.o
-- 
2.9.3
