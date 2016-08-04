From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 4/4] ASoC: da7213: Improve 32KHz mode PLL locking
Date: Thu, 4 Aug 2016 15:35:41 +0100
Message-ID: <497bb3724104ba16dc3588287f6071f0b7cce09e.1470318378.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1470318378.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1470318378.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Support Opensource <support.opensource@diasemi.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

To aid PLL in locking on to a 32KHz MCLK, some register mods
are made during PLL configuration, and when enabling the DAI,
to achieve the full range of sample rates.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/codecs/da7213.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 79b8324..095fe40 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -750,11 +750,18 @@ static int da7213_dai_event(struct snd_soc_dapm_widget *w,
 		snd_soc_update_bits(codec, DA7213_PC_COUNT,
 				    DA7213_PC_FREERUN_MASK, 0);

-		/* Slave mode, if SRM not enabled no need for status checks */
+		/* If SRM not enabled then nothing more to do */
 		pll_ctrl = snd_soc_read(codec, DA7213_PLL_CTRL);
 		if (!(pll_ctrl & DA7213_PLL_SRM_EN))
 			return 0;

+		/* Assist 32KHz mode PLL lock */
+		if (pll_ctrl & DA7213_PLL_32K_MODE) {
+			snd_soc_write(codec, 0xF0, 0x8B);
+			snd_soc_write(codec, 0xF2, 0x03);
+			snd_soc_write(codec, 0xF0, 0x00);
+		}
+
 		/* Check SRM has locked */
 		do {
 			pll_status = snd_soc_read(codec, DA7213_PLL_STATUS);
@@ -771,6 +778,14 @@ static int da7213_dai_event(struct snd_soc_dapm_widget *w,

 		return 0;
 	case SND_SOC_DAPM_POST_PMD:
+		/* Revert 32KHz PLL lock udpates if applied previously */
+		pll_ctrl = snd_soc_read(codec, DA7213_PLL_CTRL);
+		if (pll_ctrl & DA7213_PLL_32K_MODE) {
+			snd_soc_write(codec, 0xF0, 0x8B);
+			snd_soc_write(codec, 0xF2, 0x01);
+			snd_soc_write(codec, 0xF0, 0x00);
+		}
+
 		/* PC free-running */
 		snd_soc_update_bits(codec, DA7213_PC_COUNT,
 				    DA7213_PC_FREERUN_MASK,
@@ -1428,6 +1443,14 @@ static int da7213_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 			    DA7213_PLL_INDIV_MASK | DA7213_PLL_MODE_MASK,
 			    pll_ctrl);

+	/* Assist 32KHz mode PLL lock */
+	if (source == DA7213_SYSCLK_PLL_32KHZ) {
+		snd_soc_write(codec, 0xF0, 0x8B);
+		snd_soc_write(codec, 0xF1, 0x03);
+		snd_soc_write(codec, 0xF1, 0x01);
+		snd_soc_write(codec, 0xF0, 0x00);
+	}
+
 	return 0;
 }

--
1.9.3
