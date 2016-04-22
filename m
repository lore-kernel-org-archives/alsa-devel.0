From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tidyup alphabetical order for
	SND_SOC_Bxx" to the asoc tree
Date: Fri, 22 Apr 2016 11:49:23 +0100
Message-ID: <E1atYeJ-0002af-RT@debutante>
References: <87fuuevwut.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ADBAE264F3A
 for <alsa-devel@alsa-project.org>; Fri, 22 Apr 2016 12:49:29 +0200 (CEST)
In-Reply-To: <87fuuevwut.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tidyup alphabetical order for SND_SOC_Bxx

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

>From 54aba08f13fab00f31938993c9f7a9b0cd54f666 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 22 Apr 2016 09:09:14 +0000
Subject: [PATCH] ASoC: tidyup alphabetical order for SND_SOC_Bxx

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig  | 8 ++++----
 sound/soc/codecs/Makefile | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 649e92a252ae..f7f64bd019a5 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -43,6 +43,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_AK5386
 	select SND_SOC_ALC5623 if I2C
 	select SND_SOC_ALC5632 if I2C
+	select SND_SOC_BT_SCO
 	select SND_SOC_CQ0093VC if MFD_DAVINCI_VOICECODEC
 	select SND_SOC_CS35L32 if I2C
 	select SND_SOC_CS42L51_I2C if I2C
@@ -64,7 +65,6 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_DA732X if I2C
 	select SND_SOC_DA9055 if I2C
 	select SND_SOC_DMIC
-	select SND_SOC_BT_SCO
 	select SND_SOC_ES8328_SPI if SPI_MASTER
 	select SND_SOC_ES8328_I2C if I2C
 	select SND_SOC_GTM601
@@ -365,6 +365,9 @@ config SND_SOC_ALC5623
 config SND_SOC_ALC5632
 	tristate
 
+config SND_SOC_BT_SCO
+	tristate
+
 config SND_SOC_CQ0093VC
 	tristate
 
@@ -471,9 +474,6 @@ config SND_SOC_DA732X
 config SND_SOC_DA9055
 	tristate
 
-config SND_SOC_BT_SCO
-	tristate
-
 config SND_SOC_DMIC
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 185a712a7fe7..12a1fe22eaa1 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -32,6 +32,7 @@ snd-soc-ak4642-objs := ak4642.o
 snd-soc-ak4671-objs := ak4671.o
 snd-soc-ak5386-objs := ak5386.o
 snd-soc-arizona-objs := arizona.o
+snd-soc-bt-sco-objs := bt-sco.o
 snd-soc-cq93vc-objs := cq93vc.o
 snd-soc-cs35l32-objs := cs35l32.o
 snd-soc-cs42l51-objs := cs42l51.o
@@ -55,7 +56,6 @@ snd-soc-da7218-objs := da7218.o
 snd-soc-da7219-objs := da7219.o da7219-aad.o
 snd-soc-da732x-objs := da732x.o
 snd-soc-da9055-objs := da9055.o
-snd-soc-bt-sco-objs := bt-sco.o
 snd-soc-dmic-objs := dmic.o
 snd-soc-es8328-objs := es8328.o
 snd-soc-es8328-i2c-objs := es8328-i2c.o
@@ -241,6 +241,7 @@ obj-$(CONFIG_SND_SOC_AK5386)	+= snd-soc-ak5386.o
 obj-$(CONFIG_SND_SOC_ALC5623)    += snd-soc-alc5623.o
 obj-$(CONFIG_SND_SOC_ALC5632)	+= snd-soc-alc5632.o
 obj-$(CONFIG_SND_SOC_ARIZONA)	+= snd-soc-arizona.o
+obj-$(CONFIG_SND_SOC_BT_SCO)	+= snd-soc-bt-sco.o
 obj-$(CONFIG_SND_SOC_CQ0093VC) += snd-soc-cq93vc.o
 obj-$(CONFIG_SND_SOC_CS35L32)	+= snd-soc-cs35l32.o
 obj-$(CONFIG_SND_SOC_CS42L51)	+= snd-soc-cs42l51.o
@@ -264,7 +265,6 @@ obj-$(CONFIG_SND_SOC_DA7218)	+= snd-soc-da7218.o
 obj-$(CONFIG_SND_SOC_DA7219)	+= snd-soc-da7219.o
 obj-$(CONFIG_SND_SOC_DA732X)	+= snd-soc-da732x.o
 obj-$(CONFIG_SND_SOC_DA9055)	+= snd-soc-da9055.o
-obj-$(CONFIG_SND_SOC_BT_SCO)	+= snd-soc-bt-sco.o
 obj-$(CONFIG_SND_SOC_DMIC)	+= snd-soc-dmic.o
 obj-$(CONFIG_SND_SOC_ES8328)	+= snd-soc-es8328.o
 obj-$(CONFIG_SND_SOC_ES8328_I2C)+= snd-soc-es8328-i2c.o
-- 
2.8.0.rc3
