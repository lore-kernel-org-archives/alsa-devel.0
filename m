From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 2/8] ASoC: cs35l32: Constify struct regmap_config and
 snd_soc_codec_driver
Date: Mon, 05 Jan 2015 10:18:22 +0100
Message-ID: <1420449508-10701-2-git-send-email-k.kozlowski@samsung.com>
References: <1420449508-10701-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1420449508-10701-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

The regmap_config struct may be const because it is not modified by the
driver and regmap_init() accepts pointer to const. Make struct
snd_soc_codec_driver const as well (snd_soc_register_codec() accepts
pointer to const).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Brian Austin <brian.austin@cirrus.com>
Cc: Paul Handrigan <Paul.Handrigan@cirrus.com>
---
 sound/soc/codecs/cs35l32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs35l32.c b/sound/soc/codecs/cs35l32.c
index ec55c590afd0..f2b8aad21274 100644
--- a/sound/soc/codecs/cs35l32.c
+++ b/sound/soc/codecs/cs35l32.c
@@ -264,7 +264,7 @@ static int cs35l32_codec_set_sysclk(struct snd_soc_codec *codec,
 			CS35L32_MCLK_DIV2_MASK | CS35L32_MCLK_RATIO_MASK, val);
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_cs35l32 = {
+static const struct snd_soc_codec_driver soc_codec_dev_cs35l32 = {
 	.set_sysclk = cs35l32_codec_set_sysclk,
 
 	.dapm_widgets = cs35l32_dapm_widgets,
@@ -288,7 +288,7 @@ static const struct reg_default cs35l32_monitor_patch[] = {
 	{ 0x00, 0x00 },
 };
 
-static struct regmap_config cs35l32_regmap = {
+static const struct regmap_config cs35l32_regmap = {
 	.reg_bits = 8,
 	.val_bits = 8,
 
-- 
1.9.1
