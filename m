From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 1/4] ASoC: da7213: Default to 64 BCLKs per WCLK to support all
 formats
Date: Thu, 4 Aug 2016 15:35:37 +0100
Message-ID: <a8c37924c9193e760f7488370cb80cb616696c12.1470318378.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1470318378.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1470318378.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Support Opensource <support.opensource@diasemi.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Previously code defaulted to 32 BCLKS per WCLK which meant 24 and
32 bit DAI formats would not work properly. This patch fixes the
issue by defaulting to 64 BCLKs per WCLK.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/codecs/da7213.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index e5527bc..bcf1834 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -1247,8 +1247,8 @@ static int da7213_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	/* By default only 32 BCLK per WCLK is supported */
-	dai_clk_mode |= DA7213_DAI_BCLKS_PER_WCLK_32;
+	/* By default only 64 BCLK per WCLK is supported */
+	dai_clk_mode |= DA7213_DAI_BCLKS_PER_WCLK_64;
 
 	snd_soc_write(codec, DA7213_DAI_CLK_MODE, dai_clk_mode);
 	snd_soc_update_bits(codec, DA7213_DAI_CTRL, DA7213_DAI_FORMAT_MASK,
-- 
1.9.3
