From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8825: assign DAC Ch to match headset
	L/R" to the asoc tree
Date: Thu, 31 Mar 2016 10:20:24 -0700
Message-ID: <E1algGe-0003gi-KE@finisterre>
References: <1459321031-2365-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6822D2666D6
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 19:20:31 +0200 (CEST)
In-Reply-To: <1459321031-2365-1-git-send-email-KCHSU0@nuvoton.com>
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

   ASoC: nau8825: assign DAC Ch to match headset L/R

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

>From c5a85d8a61a91c13278e3c4ca32fecbc86dc2ede Mon Sep 17 00:00:00 2001
From: John Hsu <KCHSU0@nuvoton.com>
Date: Wed, 30 Mar 2016 14:57:11 +0800
Subject: [PATCH] ASoC: nau8825: assign DAC Ch to match headset L/R

The default value of DAC channel select is reverse in codec.
For normal usage, switch the channel select when codec bootup.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8825.c | 5 +++++
 sound/soc/codecs/nau8825.h | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 106c391f9ec3..f35019a0db1d 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -930,6 +930,11 @@ static void nau8825_init_regs(struct nau8825 *nau8825)
 		NAU8825_RDAC_CLK_DELAY_MASK | NAU8825_RDAC_VREF_MASK,
 		(0x2 << NAU8825_RDAC_CLK_DELAY_SFT) |
 		(0x3 << NAU8825_RDAC_VREF_SFT));
+	/* Config L/R channel */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_DACL_CTRL,
+		NAU8825_DACL_CH_SEL_MASK, NAU8825_DACL_CH_SEL_L);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_DACR_CTRL,
+		NAU8825_DACL_CH_SEL_MASK, NAU8825_DACL_CH_SEL_R);
 }
 
 static const struct regmap_config nau8825_regmap_config = {
diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
index 4427df99de24..9e6cb6262bf2 100644
--- a/sound/soc/codecs/nau8825.h
+++ b/sound/soc/codecs/nau8825.h
@@ -257,9 +257,15 @@
 
 /* DACL_CTRL (0x33) */
 #define NAU8825_DACL_CH_SEL_SFT	9
+#define NAU8825_DACL_CH_SEL_MASK (0x1 << NAU8825_DACL_CH_SEL_SFT)
+#define NAU8825_DACL_CH_SEL_L    (0x0 << NAU8825_DACL_CH_SEL_SFT)
+#define NAU8825_DACL_CH_SEL_R    (0x1 << NAU8825_DACL_CH_SEL_SFT)
 
 /* DACR_CTRL (0x34) */
 #define NAU8825_DACR_CH_SEL_SFT	9
+#define NAU8825_DACR_CH_SEL_MASK (0x1 << NAU8825_DACR_CH_SEL_SFT)
+#define NAU8825_DACR_CH_SEL_L    (0x0 << NAU8825_DACR_CH_SEL_SFT)
+#define NAU8825_DACR_CH_SEL_R    (0x1 << NAU8825_DACR_CH_SEL_SFT)
 
 /* CLASSG_CTRL (0x50) */
 #define NAU8825_CLASSG_TIMER_SFT	8
-- 
2.8.0.rc3
