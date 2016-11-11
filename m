From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8825: Disable short Frame Sync
	detection logic" to the asoc tree
Date: Fri, 11 Nov 2016 15:52:24 +0000
Message-ID: <E1c5E7s-0002hn-D3@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 90CCB2674FB
 for <alsa-devel@alsa-project.org>; Fri, 11 Nov 2016 16:52:37 +0100 (CET)
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
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8825: Disable short Frame Sync detection logic

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

>From 93dfec758ff2d0292be35cafd239e929a8973b73 Mon Sep 17 00:00:00 2001
From: John Hsu <KCHSU0@nuvoton.com>
Date: Fri, 11 Nov 2016 12:34:12 +0800
Subject: [PATCH] ASoC: nau8825: Disable short Frame Sync detection logic

If the short Frame Sync detection logic enabled, the logic will check the
short frame sync threshold. If frame sync is less than the setting;
for example, frame sync less than 252 MCLK, the short frame sync signal is
flagged, digital filter temporary mute and skip that data.

If the system was intended for sampling rate change which could create
temporary short frame sync and not enough MIPS to run the digital filter.
But the situation doesn't happen in ALSA architecure. Thus the Frame Sync
is always stable, then no require to do the detection. Therefore,
the dirver disables the function for better performance.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8825.c | 3 +++
 sound/soc/codecs/nau8825.h | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index e643be91d762..0db618b2f2b8 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1811,6 +1811,9 @@ static void nau8825_init_regs(struct nau8825 *nau8825)
 		NAU8825_DACL_CH_SEL_MASK, NAU8825_DACL_CH_SEL_L);
 	regmap_update_bits(nau8825->regmap, NAU8825_REG_DACR_CTRL,
 		NAU8825_DACL_CH_SEL_MASK, NAU8825_DACL_CH_SEL_R);
+	/* Disable short Frame Sync detection logic */
+	regmap_update_bits(regmap, NAU8825_REG_LEFT_TIME_SLOT,
+		NAU8825_DIS_FS_SHORT_DET, NAU8825_DIS_FS_SHORT_DET);
 }
 
 static const struct regmap_config nau8825_regmap_config = {
diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
index 1c63e2abafa9..6365c9c3f8d9 100644
--- a/sound/soc/codecs/nau8825.h
+++ b/sound/soc/codecs/nau8825.h
@@ -246,6 +246,11 @@
 #define NAU8825_I2S_MS_SLAVE	(0 << NAU8825_I2S_MS_SFT)
 #define NAU8825_I2S_BLK_DIV_MASK	0x7
 
+/* LEFT_TIME_SLOT (0x1e) */
+#define NAU8825_FS_ERR_CMP_SEL_SFT	14
+#define NAU8825_FS_ERR_CMP_SEL_MASK	(0x3 << NAU8825_FS_ERR_CMP_SEL_SFT)
+#define NAU8825_DIS_FS_SHORT_DET	(1 << 13)
+
 /* BIQ_CTRL (0x20) */
 #define NAU8825_BIQ_WRT_SFT   4
 #define NAU8825_BIQ_WRT_EN     (1 << NAU8825_BIQ_WRT_SFT)
-- 
2.10.2
