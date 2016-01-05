From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7218: Correct BCLK inversion for DSP
	DAI format mode" to the asoc tree
Date: Tue, 05 Jan 2016 18:27:38 +0000
Message-ID: <E1aGWKY-0004CP-LB@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 67CDE260410
 for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2016 19:27:46 +0100 (CET)
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
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7218: Correct BCLK inversion for DSP DAI format mode

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

>From f644eb62fe88a2414e5e5c1bd80e20c881f5d86a Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Tue, 5 Jan 2016 18:15:33 +0000
Subject: [PATCH] ASoC: da7218: Correct BCLK inversion for DSP DAI format mode

By default the device latches data on the falling edge of the
BCLK in DSP mode, whereas the expectation for normal BCLK is to
latch on the rising edge. This updates the driver to invert the
BCLK configuration for DSP mode, to align with expected behaviour.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7218.c | 47 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/da7218.c b/sound/soc/codecs/da7218.c
index 72686517ff54..93575f251866 100644
--- a/sound/soc/codecs/da7218.c
+++ b/sound/soc/codecs/da7218.c
@@ -1954,17 +1954,44 @@ static int da7218_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
-	case SND_SOC_DAIFMT_NB_NF:
-		break;
-	case SND_SOC_DAIFMT_NB_IF:
-		dai_clk_mode |= DA7218_DAI_WCLK_POL_INV;
-		break;
-	case SND_SOC_DAIFMT_IB_NF:
-		dai_clk_mode |= DA7218_DAI_CLK_POL_INV;
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+	case SND_SOC_DAIFMT_LEFT_J:
+	case SND_SOC_DAIFMT_RIGHT_J:
+		switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+		case SND_SOC_DAIFMT_NB_NF:
+			break;
+		case SND_SOC_DAIFMT_NB_IF:
+			dai_clk_mode |= DA7218_DAI_WCLK_POL_INV;
+			break;
+		case SND_SOC_DAIFMT_IB_NF:
+			dai_clk_mode |= DA7218_DAI_CLK_POL_INV;
+			break;
+		case SND_SOC_DAIFMT_IB_IF:
+			dai_clk_mode |= DA7218_DAI_WCLK_POL_INV |
+					DA7218_DAI_CLK_POL_INV;
+			break;
+		default:
+			return -EINVAL;
+		}
 		break;
-	case SND_SOC_DAIFMT_IB_IF:
-		dai_clk_mode |= DA7218_DAI_WCLK_POL_INV | DA7218_DAI_CLK_POL_INV;
+	case SND_SOC_DAIFMT_DSP_B:
+		switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+		case SND_SOC_DAIFMT_NB_NF:
+			dai_clk_mode |= DA7218_DAI_CLK_POL_INV;
+			break;
+		case SND_SOC_DAIFMT_NB_IF:
+			dai_clk_mode |= DA7218_DAI_WCLK_POL_INV |
+					DA7218_DAI_CLK_POL_INV;
+			break;
+		case SND_SOC_DAIFMT_IB_NF:
+			break;
+		case SND_SOC_DAIFMT_IB_IF:
+			dai_clk_mode |= DA7218_DAI_WCLK_POL_INV;
+			break;
+		default:
+			return -EINVAL;
+		}
 		break;
 	default:
 		return -EINVAL;
-- 
2.7.0.rc3
