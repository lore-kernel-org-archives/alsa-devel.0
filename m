From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH v5] ASoC: sgtl5000: Fix the cache handling
Date: Mon, 26 May 2014 10:34:20 -0300
Message-ID: <1401111260-23320-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0204.outbound.protection.outlook.com [207.46.163.204])
 by alsa0.perex.cz (Postfix) with ESMTP id 741B32651EB
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 15:34:36 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, lars@metafoo.de, shawn.guo@freescale.com
List-Id: alsa-devel@alsa-project.org

Since commit e5d80e82e32e (ASoC: sgtl5000: Convert to use regmap directly) a 
kernel oops is observed after a suspend/resume sequence.

The kernel oops happens inside sgtl5000_restore_regs() as codec->reg_cache is no
longer a valid pointer.

Add the remaining register entries into sgtl5000_reg_defaults[] and remove
sgtl5000_restore_regs() completely, which allows suspend/resume to work fine and
make the code simpler.

Tested on a im53-qsb board.

Reported-by: Shawn Guo <shawn.guo@freescale.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v4:
- Remove sgtl5000_restore_regs() as suggested by Lars-Peter

 sound/soc/codecs/sgtl5000.c | 75 +++++++++------------------------------------
 1 file changed, 15 insertions(+), 60 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 9626ee0..3d39f0b 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -36,18 +36,32 @@
 
 /* default value of sgtl5000 registers */
 static const struct reg_default sgtl5000_reg_defaults[] = {
+	{ SGTL5000_CHIP_DIG_POWER,		0x0000 },
 	{ SGTL5000_CHIP_CLK_CTRL,		0x0008 },
 	{ SGTL5000_CHIP_I2S_CTRL,		0x0010 },
 	{ SGTL5000_CHIP_SSS_CTRL,		0x0010 },
+	{ SGTL5000_CHIP_ADCDAC_CTRL,		0x020c },
 	{ SGTL5000_CHIP_DAC_VOL,		0x3c3c },
 	{ SGTL5000_CHIP_PAD_STRENGTH,		0x015f },
+	{ SGTL5000_CHIP_ANA_ADC_CTRL,		0x0000 },
 	{ SGTL5000_CHIP_ANA_HP_CTRL,		0x1818 },
 	{ SGTL5000_CHIP_ANA_CTRL,		0x0111 },
+	{ SGTL5000_CHIP_LINREG_CTRL,		0x0000 },
+	{ SGTL5000_CHIP_REF_CTRL,		0x0000 },
+	{ SGTL5000_CHIP_MIC_CTRL,		0x0000 },
+	{ SGTL5000_CHIP_LINE_OUT_CTRL,		0x0000 },
 	{ SGTL5000_CHIP_LINE_OUT_VOL,		0x0404 },
 	{ SGTL5000_CHIP_ANA_POWER,		0x7060 },
 	{ SGTL5000_CHIP_PLL_CTRL,		0x5000 },
+	{ SGTL5000_CHIP_CLK_TOP_CTRL,		0x0000 },
+	{ SGTL5000_CHIP_ANA_STATUS,		0x0000 },
+	{ SGTL5000_CHIP_SHORT_CTRL,		0x0000 },
+	{ SGTL5000_CHIP_ANA_TEST2,		0x0000 },
+	{ SGTL5000_DAP_CTRL,			0x0000 },
+	{ SGTL5000_DAP_PEQ,			0x0000 },
 	{ SGTL5000_DAP_BASS_ENHANCE,		0x0040 },
 	{ SGTL5000_DAP_BASS_ENHANCE_CTRL,	0x051f },
+	{ SGTL5000_DAP_AUDIO_EQ,		0x0000 },
 	{ SGTL5000_DAP_SURROUND,		0x0040 },
 	{ SGTL5000_DAP_EQ_BASS_BAND0,		0x002f },
 	{ SGTL5000_DAP_EQ_BASS_BAND1,		0x002f },
@@ -55,6 +69,7 @@ static const struct reg_default sgtl5000_reg_defaults[] = {
 	{ SGTL5000_DAP_EQ_BASS_BAND3,		0x002f },
 	{ SGTL5000_DAP_EQ_BASS_BAND4,		0x002f },
 	{ SGTL5000_DAP_MAIN_CHAN,		0x8000 },
+	{ SGTL5000_DAP_MIX_CHAN,		0x0000 },
 	{ SGTL5000_DAP_AVC_CTRL,		0x0510 },
 	{ SGTL5000_DAP_AVC_THRESHOLD,		0x1473 },
 	{ SGTL5000_DAP_AVC_ATTACK,		0x0028 },
@@ -1068,71 +1083,11 @@ static int sgtl5000_suspend(struct snd_soc_codec *codec)
 	return 0;
 }
 
-/*
- * restore all sgtl5000 registers,
- * since a big hole between dap and regular registers,
- * we will restore them respectively.
- */
-static int sgtl5000_restore_regs(struct snd_soc_codec *codec)
-{
-	u16 *cache = codec->reg_cache;
-	u16 reg;
-
-	/* restore regular registers */
-	for (reg = 0; reg <= SGTL5000_CHIP_SHORT_CTRL; reg += 2) {
-
-		/* These regs should restore in particular order */
-		if (reg == SGTL5000_CHIP_ANA_POWER ||
-			reg == SGTL5000_CHIP_CLK_CTRL ||
-			reg == SGTL5000_CHIP_LINREG_CTRL ||
-			reg == SGTL5000_CHIP_LINE_OUT_CTRL ||
-			reg == SGTL5000_CHIP_REF_CTRL)
-			continue;
-
-		snd_soc_write(codec, reg, cache[reg]);
-	}
-
-	/* restore dap registers */
-	for (reg = SGTL5000_DAP_REG_OFFSET; reg < SGTL5000_MAX_REG_OFFSET; reg += 2)
-		snd_soc_write(codec, reg, cache[reg]);
-
-	/*
-	 * restore these regs according to the power setting sequence in
-	 * sgtl5000_set_power_regs() and clock setting sequence in
-	 * sgtl5000_set_clock().
-	 *
-	 * The order of restore is:
-	 * 1. SGTL5000_CHIP_CLK_CTRL MCLK_FREQ bits (1:0) should be restore after
-	 *    SGTL5000_CHIP_ANA_POWER PLL bits set
-	 * 2. SGTL5000_CHIP_LINREG_CTRL should be set before
-	 *    SGTL5000_CHIP_ANA_POWER LINREG_D restored
-	 * 3. SGTL5000_CHIP_REF_CTRL controls Analog Ground Voltage,
-	 *    prefer to resotre it after SGTL5000_CHIP_ANA_POWER restored
-	 */
-	snd_soc_write(codec, SGTL5000_CHIP_LINREG_CTRL,
-			cache[SGTL5000_CHIP_LINREG_CTRL]);
-
-	snd_soc_write(codec, SGTL5000_CHIP_ANA_POWER,
-			cache[SGTL5000_CHIP_ANA_POWER]);
-
-	snd_soc_write(codec, SGTL5000_CHIP_CLK_CTRL,
-			cache[SGTL5000_CHIP_CLK_CTRL]);
-
-	snd_soc_write(codec, SGTL5000_CHIP_REF_CTRL,
-			cache[SGTL5000_CHIP_REF_CTRL]);
-
-	snd_soc_write(codec, SGTL5000_CHIP_LINE_OUT_CTRL,
-			cache[SGTL5000_CHIP_LINE_OUT_CTRL]);
-	return 0;
-}
-
 static int sgtl5000_resume(struct snd_soc_codec *codec)
 {
 	/* Bring the codec back up to standby to enable regulators */
 	sgtl5000_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-	/* Restore registers by cached in memory */
-	sgtl5000_restore_regs(codec);
 	return 0;
 }
 #else
-- 
1.8.3.2
