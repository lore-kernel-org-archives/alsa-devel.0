From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cirrus: i2s: Fix {TX|RX}LinCtrlData
	setup" to the asoc tree
Date: Tue,  1 May 2018 22:07:40 +0100 (BST)
Message-ID: <20180501210740.739C144007A@finisterre.ee.mobilebroadband>
References: <20180428205142.31921-3-alexander.sverdlin@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1574457840242232783=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E39F1266F4E
 for <alsa-devel@alsa-project.org>; Tue,  1 May 2018 23:07:45 +0200 (CEST)
In-Reply-To: <20180428205142.31921-3-alexander.sverdlin@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: alsa-devel@alsa-project.org, Ryan Mallon <rmallon@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, stable@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

--===============1574457840242232783==
Content-Type: text/plain

The patch

   ASoC: cirrus: i2s: Fix {TX|RX}LinCtrlData setup

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 5d302ed3cc80564fb835bed5fdba1e1250ecc9e5 Mon Sep 17 00:00:00 2001
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Date: Sat, 28 Apr 2018 22:51:39 +0200
Subject: [PATCH] ASoC: cirrus: i2s: Fix {TX|RX}LinCtrlData setup
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

According to "EP93xx User’s Guide", I2STXLinCtrlData and I2SRXLinCtrlData
registers actually have different format. The only currently used bit
(Left_Right_Justify) has different position. Fix this and simplify the
whole setup taking into account the fact that both registers have zero
default value.

The practical effect of the above is repaired SND_SOC_DAIFMT_RIGHT_J
support (currently unused).

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/cirrus/ep93xx-i2s.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/sound/soc/cirrus/ep93xx-i2s.c b/sound/soc/cirrus/ep93xx-i2s.c
index 38c240c97041..0dc3852c4621 100644
--- a/sound/soc/cirrus/ep93xx-i2s.c
+++ b/sound/soc/cirrus/ep93xx-i2s.c
@@ -51,7 +51,9 @@
 #define EP93XX_I2S_WRDLEN_24		(1 << 0)
 #define EP93XX_I2S_WRDLEN_32		(2 << 0)
 
-#define EP93XX_I2S_LINCTRLDATA_R_JUST	(1 << 2) /* Right justify */
+#define EP93XX_I2S_RXLINCTRLDATA_R_JUST	BIT(1) /* Right justify */
+
+#define EP93XX_I2S_TXLINCTRLDATA_R_JUST	BIT(2) /* Right justify */
 
 #define EP93XX_I2S_CLKCFG_LRS		(1 << 0) /* lrclk polarity */
 #define EP93XX_I2S_CLKCFG_CKP		(1 << 1) /* Bit clock polarity */
@@ -170,25 +172,25 @@ static int ep93xx_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 				  unsigned int fmt)
 {
 	struct ep93xx_i2s_info *info = snd_soc_dai_get_drvdata(cpu_dai);
-	unsigned int clk_cfg, lin_ctrl;
+	unsigned int clk_cfg;
+	unsigned int txlin_ctrl = 0;
+	unsigned int rxlin_ctrl = 0;
 
 	clk_cfg  = ep93xx_i2s_read_reg(info, EP93XX_I2S_RXCLKCFG);
-	lin_ctrl = ep93xx_i2s_read_reg(info, EP93XX_I2S_RXLINCTRLDATA);
 
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		clk_cfg |= EP93XX_I2S_CLKCFG_REL;
-		lin_ctrl &= ~EP93XX_I2S_LINCTRLDATA_R_JUST;
 		break;
 
 	case SND_SOC_DAIFMT_LEFT_J:
 		clk_cfg &= ~EP93XX_I2S_CLKCFG_REL;
-		lin_ctrl &= ~EP93XX_I2S_LINCTRLDATA_R_JUST;
 		break;
 
 	case SND_SOC_DAIFMT_RIGHT_J:
 		clk_cfg &= ~EP93XX_I2S_CLKCFG_REL;
-		lin_ctrl |= EP93XX_I2S_LINCTRLDATA_R_JUST;
+		rxlin_ctrl |= EP93XX_I2S_RXLINCTRLDATA_R_JUST;
+		txlin_ctrl |= EP93XX_I2S_TXLINCTRLDATA_R_JUST;
 		break;
 
 	default:
@@ -237,8 +239,8 @@ static int ep93xx_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	/* Write new register values */
 	ep93xx_i2s_write_reg(info, EP93XX_I2S_RXCLKCFG, clk_cfg);
 	ep93xx_i2s_write_reg(info, EP93XX_I2S_TXCLKCFG, clk_cfg);
-	ep93xx_i2s_write_reg(info, EP93XX_I2S_RXLINCTRLDATA, lin_ctrl);
-	ep93xx_i2s_write_reg(info, EP93XX_I2S_TXLINCTRLDATA, lin_ctrl);
+	ep93xx_i2s_write_reg(info, EP93XX_I2S_RXLINCTRLDATA, rxlin_ctrl);
+	ep93xx_i2s_write_reg(info, EP93XX_I2S_TXLINCTRLDATA, txlin_ctrl);
 	return 0;
 }
 
-- 
2.17.0


--===============1574457840242232783==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1574457840242232783==--
