From: Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] ASoC: remove dead makefile about sn95031
Date: Mon, 29 Jan 2018 12:28:54 +0000
Message-ID: <1517228934-1754-1-git-send-email-clabbe@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
List-Id: alsa-devel@alsa-project.org

All sn95031 stuff was removed in commit 987da3fe1759 ("ASoC: sn95031: remove this code")
Since SND_SOC_SN95031 was gone, remove makefile about it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 sound/soc/codecs/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index da1571336f1e..4053c72d852b 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -387,7 +387,6 @@ obj-$(CONFIG_SND_SOC_SIGMADSP)	+= snd-soc-sigmadsp.o
 obj-$(CONFIG_SND_SOC_SIGMADSP_I2C)	+= snd-soc-sigmadsp-i2c.o
 obj-$(CONFIG_SND_SOC_SIGMADSP_REGMAP)	+= snd-soc-sigmadsp-regmap.o
 obj-$(CONFIG_SND_SOC_SI476X)	+= snd-soc-si476x.o
-obj-$(CONFIG_SND_SOC_SN95031)	+=snd-soc-sn95031.o
 obj-$(CONFIG_SND_SOC_SPDIF)	+= snd-soc-spdif-rx.o snd-soc-spdif-tx.o
 obj-$(CONFIG_SND_SOC_SIRF_AUDIO_CODEC) += sirf-audio-codec.o
 obj-$(CONFIG_SND_SOC_SSM2518)	+= snd-soc-ssm2518.o
-- 
2.13.6
