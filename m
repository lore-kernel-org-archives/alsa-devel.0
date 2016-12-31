From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8825: correct the function name of
	register" to the asoc tree
Date: Sat, 31 Dec 2016 19:18:58 +0000
Message-ID: <E1cNPBC-0003qC-LW@debutante>
References: <1482223627-23547-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D2C852670BE
 for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2016 20:19:04 +0100 (CET)
In-Reply-To: <1482223627-23547-1-git-send-email-KCHSU0@nuvoton.com>
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
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, benzh@chromium.org, WTLI@nuvoton.com, lgirdwood@gmail.com, YHCHuang@nuvoton.com, broonie@kernel.org, CTLIN0@nuvoton.com, yong.zhi@intel.com, mhkuo@nuvoton.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8825: correct the function name of register

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

>From a33b56a6a824fa5cd89c74f85cbeb9af1dcef87e Mon Sep 17 00:00:00 2001
From: John Hsu <KCHSU0@nuvoton.com>
Date: Tue, 20 Dec 2016 16:47:06 +0800
Subject: [PATCH] ASoC: nau8825: correct the function name of register

Change to correct name of the register function.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8825.c | 6 +++---
 sound/soc/codecs/nau8825.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index efe3a44658d5..abf77dd422f4 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -561,9 +561,9 @@ static void nau8825_xtalk_prepare(struct nau8825 *nau8825)
 	nau8825_xtalk_backup(nau8825);
 	/* Config IIS as master to output signal by codec */
 	regmap_update_bits(nau8825->regmap, NAU8825_REG_I2S_PCM_CTRL2,
-		NAU8825_I2S_MS_MASK | NAU8825_I2S_DRV_MASK |
+		NAU8825_I2S_MS_MASK | NAU8825_I2S_LRC_DIV_MASK |
 		NAU8825_I2S_BLK_DIV_MASK, NAU8825_I2S_MS_MASTER |
-		(0x2 << NAU8825_I2S_DRV_SFT) | 0x1);
+		(0x2 << NAU8825_I2S_LRC_DIV_SFT) | 0x1);
 	/* Ramp up headphone volume to 0dB to get better performance and
 	 * avoid pop noise in headphone.
 	 */
@@ -657,7 +657,7 @@ static void nau8825_xtalk_clean(struct nau8825 *nau8825)
 		NAU8825_IRQ_RMS_EN, NAU8825_IRQ_RMS_EN);
 	/* Recover default value for IIS */
 	regmap_update_bits(nau8825->regmap, NAU8825_REG_I2S_PCM_CTRL2,
-		NAU8825_I2S_MS_MASK | NAU8825_I2S_DRV_MASK |
+		NAU8825_I2S_MS_MASK | NAU8825_I2S_LRC_DIV_MASK |
 		NAU8825_I2S_BLK_DIV_MASK, NAU8825_I2S_MS_SLAVE);
 	/* Restore value of specific register for cross talk */
 	nau8825_xtalk_restore(nau8825);
diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
index 5d1704e73241..b6b21b312854 100644
--- a/sound/soc/codecs/nau8825.h
+++ b/sound/soc/codecs/nau8825.h
@@ -247,8 +247,8 @@
 
 /* I2S_PCM_CTRL2 (0x1d) */
 #define NAU8825_I2S_TRISTATE	(1 << 15) /* 0 - normal mode, 1 - Hi-Z output */
-#define NAU8825_I2S_DRV_SFT	12
-#define NAU8825_I2S_DRV_MASK	(0x3 << NAU8825_I2S_DRV_SFT)
+#define NAU8825_I2S_LRC_DIV_SFT	12
+#define NAU8825_I2S_LRC_DIV_MASK	(0x3 << NAU8825_I2S_LRC_DIV_SFT)
 #define NAU8825_I2S_MS_SFT	3
 #define NAU8825_I2S_MS_MASK	(1 << NAU8825_I2S_MS_SFT)
 #define NAU8825_I2S_MS_MASTER	(1 << NAU8825_I2S_MS_SFT)
-- 
2.11.0
