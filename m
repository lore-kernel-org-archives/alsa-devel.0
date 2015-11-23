From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac: Fix Makefile and Kconfig sorting"
	to the asoc tree
Date: Mon, 23 Nov 2015 14:43:34 +0000
Message-ID: <E1a0sL8-00088d-8D@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 89FE1265357
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2015 15:43:40 +0100 (CET)
In-Reply-To: 
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac: Fix Makefile and Kconfig sorting

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 9049a48a33f7e03b69589a5fbb1444cc606d3292 Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Mon, 23 Nov 2015 14:43:06 +0000
Subject: [PATCH] ASoC: hdac: Fix Makefile and Kconfig sorting

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig  | 12 ++++++------
 sound/soc/codecs/Makefile |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 5c584dad0af0..8bba374b8860 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -66,8 +66,8 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_ES8328_SPI if SPI_MASTER
 	select SND_SOC_ES8328_I2C if I2C
 	select SND_SOC_GTM601
-	select SND_SOC_ICS43432
 	select SND_SOC_HDAC_HDMI
+	select SND_SOC_ICS43432
 	select SND_SOC_ISABELLE if I2C
 	select SND_SOC_JZ4740_CODEC
 	select SND_SOC_LM4857 if I2C
@@ -455,11 +455,6 @@ config SND_SOC_BT_SCO
 config SND_SOC_DMIC
 	tristate
 
-config SND_SOC_HDAC_HDMI
-	tristate
-	select SND_HDA_EXT_CORE
-	select HDMI
-
 config SND_SOC_ES8328
 	tristate "Everest Semi ES8328 CODEC"
 
@@ -474,6 +469,11 @@ config SND_SOC_ES8328_SPI
 config SND_SOC_GTM601
 	tristate 'GTM601 UMTS modem audio codec'
 
+config SND_SOC_HDAC_HDMI
+	tristate
+	select SND_HDA_EXT_CORE
+	select HDMI
+
 config SND_SOC_ICS43432
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 6359bdcf7f89..bcd5ad6b6fb0 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -59,8 +59,8 @@ snd-soc-es8328-objs := es8328.o
 snd-soc-es8328-i2c-objs := es8328-i2c.o
 snd-soc-es8328-spi-objs := es8328-spi.o
 snd-soc-gtm601-objs := gtm601.o
-snd-soc-ics43432-objs := ics43432.o
 snd-soc-hdac-hdmi-objs := hdac_hdmi.o
+snd-soc-ics43432-objs := ics43432.o
 snd-soc-isabelle-objs := isabelle.o
 snd-soc-jz4740-codec-objs := jz4740.o
 snd-soc-l3-objs := l3.o
@@ -255,8 +255,8 @@ obj-$(CONFIG_SND_SOC_ES8328)	+= snd-soc-es8328.o
 obj-$(CONFIG_SND_SOC_ES8328_I2C)+= snd-soc-es8328-i2c.o
 obj-$(CONFIG_SND_SOC_ES8328_SPI)+= snd-soc-es8328-spi.o
 obj-$(CONFIG_SND_SOC_GTM601)    += snd-soc-gtm601.o
-obj-$(CONFIG_SND_SOC_ICS43432)	+= snd-soc-ics43432.o
 obj-$(CONFIG_SND_SOC_HDAC_HDMI) += snd-soc-hdac-hdmi.o
+obj-$(CONFIG_SND_SOC_ICS43432)	+= snd-soc-ics43432.o
 obj-$(CONFIG_SND_SOC_ISABELLE)	+= snd-soc-isabelle.o
 obj-$(CONFIG_SND_SOC_JZ4740_CODEC)	+= snd-soc-jz4740-codec.o
 obj-$(CONFIG_SND_SOC_L3)	+= snd-soc-l3.o
-- 
2.6.2
