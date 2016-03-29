From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8825: reduce standby power
	consumption" to the asoc tree
Date: Tue, 29 Mar 2016 00:38:51 -0700
Message-ID: <E1akoEl-0007Ca-I7@finisterre>
References: <1458619025-28306-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E6E7926066B
 for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2016 09:39:05 +0200 (CEST)
In-Reply-To: <1458619025-28306-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8825: reduce standby power consumption

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

>From 5a78e7c37d5d27702fdc019d610361c95491f989 Mon Sep 17 00:00:00 2001
From: John Hsu <KCHSU0@nuvoton.com>
Date: Tue, 22 Mar 2016 11:57:05 +0800
Subject: [PATCH] ASoC: nau8825: reduce standby power consumption

Decrease internal clock frequency for power saving when standby.
But clock divider needs restore when MCLK as system clock in playback.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8825.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 3e7bee29eed4..4c8572cdec94 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1116,6 +1116,9 @@ static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
 		regmap_update_bits(regmap, NAU8825_REG_CLK_DIVIDER,
 			NAU8825_CLK_SRC_MASK, NAU8825_CLK_SRC_MCLK);
 		regmap_update_bits(regmap, NAU8825_REG_FLL6, NAU8825_DCO_EN, 0);
+		/* MCLK not changed by clock tree */
+		regmap_update_bits(regmap, NAU8825_REG_CLK_DIVIDER,
+			NAU8825_CLK_MCLK_SRC_MASK, 0);
 		ret = nau8825_mclk_prepare(nau8825, freq);
 		if (ret)
 			return ret;
@@ -1126,6 +1129,13 @@ static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
 			NAU8825_DCO_EN);
 		regmap_update_bits(regmap, NAU8825_REG_CLK_DIVIDER,
 			NAU8825_CLK_SRC_MASK, NAU8825_CLK_SRC_VCO);
+		/* Decrease the VCO frequency for power saving */
+		regmap_update_bits(regmap, NAU8825_REG_CLK_DIVIDER,
+			NAU8825_CLK_MCLK_SRC_MASK, 0xf);
+		regmap_update_bits(regmap, NAU8825_REG_FLL1,
+			NAU8825_FLL_RATIO_MASK, 0x10);
+		regmap_update_bits(regmap, NAU8825_REG_FLL6,
+			NAU8825_SDM_EN, NAU8825_SDM_EN);
 		if (nau8825->mclk_freq) {
 			clk_disable_unprepare(nau8825->mclk);
 			nau8825->mclk_freq = 0;
-- 
2.8.0.rc3
