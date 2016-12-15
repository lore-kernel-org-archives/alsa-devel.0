From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5665: Make SND_SOC_RT5665 entry sort
	in Kconfig and Makefile" to the asoc tree
Date: Thu, 15 Dec 2016 12:21:11 +0000
Message-ID: <E1cHV27-0000jp-6U@debutante>
References: <20161209085624.9315-1-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7534C266A53
 for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2016 13:21:22 +0100 (CET)
In-Reply-To: <20161209085624.9315-1-axel.lin@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5665: Make SND_SOC_RT5665 entry sort in Kconfig and Makefile

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

>From c7f87f96e384b7ecc41a6c0c8c397e095284ede0 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 9 Dec 2016 16:56:24 +0800
Subject: [PATCH] ASoC: rt5665: Make SND_SOC_RT5665 entry sort in Kconfig and
 Makefile

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig  | 10 +++++-----
 sound/soc/codecs/Makefile |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 9e1718a8cb1c..cfc108e5e5ec 100644
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
index 7e1dad79610b..2624c7324d4a 100644
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
2.11.0
