From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8540: PGA short to ground" to the
	asoc tree
Date: Thu, 16 Nov 2017 19:29:29 +0000 (GMT)
Message-ID: <20171116192929.230B544005B@finisterre.ee.mobilebroadband>
References: <1510039399-12807-2-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CE14126779A
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 20:29:29 +0100 (CET)
In-Reply-To: <1510039399-12807-2-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, WTLI@nuvoton.com, lgirdwood@gmail.com, YHCHuang@nuvoton.com, broonie@kernel.org, CTLIN0@nuvoton.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8540: PGA short to ground

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

>From 14323ff8c21825e20810e893312f9321f9e4e72c Mon Sep 17 00:00:00 2001
From: John Hsu <KCHSU0@nuvoton.com>
Date: Tue, 7 Nov 2017 15:23:18 +0800
Subject: [PATCH] ASoC: nau8540: PGA short to ground

Change channel PGA input mode selection for better recording quality.
The patch shorts the inputs to ground with 12kOhm differentially
terminated.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8540.c |  7 +++++++
 sound/soc/codecs/nau8540.h | 12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/sound/soc/codecs/nau8540.c b/sound/soc/codecs/nau8540.c
index c10cbffa6314..8246486a588d 100644
--- a/sound/soc/codecs/nau8540.c
+++ b/sound/soc/codecs/nau8540.c
@@ -730,6 +730,13 @@ static void nau8540_init_regs(struct nau8540 *nau8540)
 	regmap_update_bits(regmap, NAU8540_REG_ADC_SAMPLE_RATE,
 		NAU8540_CH_SYNC | NAU8540_ADC_OSR_MASK,
 		NAU8540_CH_SYNC | NAU8540_ADC_OSR_64);
+	/* PGA input mode selection */
+	regmap_update_bits(regmap, NAU8540_REG_FEPGA1,
+		NAU8540_FEPGA1_MODCH2_SHT | NAU8540_FEPGA1_MODCH1_SHT,
+		NAU8540_FEPGA1_MODCH2_SHT | NAU8540_FEPGA1_MODCH1_SHT);
+	regmap_update_bits(regmap, NAU8540_REG_FEPGA2,
+		NAU8540_FEPGA2_MODCH4_SHT | NAU8540_FEPGA2_MODCH3_SHT,
+		NAU8540_FEPGA2_MODCH4_SHT | NAU8540_FEPGA2_MODCH3_SHT);
 }
 
 static int __maybe_unused nau8540_suspend(struct snd_soc_codec *codec)
diff --git a/sound/soc/codecs/nau8540.h b/sound/soc/codecs/nau8540.h
index 14339f9bb01a..7083d4821ce4 100644
--- a/sound/soc/codecs/nau8540.h
+++ b/sound/soc/codecs/nau8540.h
@@ -184,6 +184,18 @@
 #define NAU8540_PRECHARGE_DIS		(0x1 << 13)
 #define NAU8540_GLOBAL_BIAS_EN	(0x1 << 12)
 
+/* FEPGA1 (0x69) */
+#define NAU8540_FEPGA1_MODCH2_SHT_SFT	7
+#define NAU8540_FEPGA1_MODCH2_SHT	(0x1 << NAU8540_FEPGA1_MODCH2_SHT_SFT)
+#define NAU8540_FEPGA1_MODCH1_SHT_SFT	3
+#define NAU8540_FEPGA1_MODCH1_SHT	(0x1 << NAU8540_FEPGA1_MODCH1_SHT_SFT)
+
+/* FEPGA2 (0x6A) */
+#define NAU8540_FEPGA2_MODCH4_SHT_SFT	7
+#define NAU8540_FEPGA2_MODCH4_SHT	(0x1 << NAU8540_FEPGA2_MODCH4_SHT_SFT)
+#define NAU8540_FEPGA2_MODCH3_SHT_SFT	3
+#define NAU8540_FEPGA2_MODCH3_SHT	(0x1 << NAU8540_FEPGA2_MODCH3_SHT_SFT)
+
 
 /* System Clock Source */
 enum {
-- 
2.14.1
