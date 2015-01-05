From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 8/8] ASoC: wm8804: Constify struct regmap_config and
 snd_soc_codec_driver
Date: Mon, 05 Jan 2015 10:18:28 +0100
Message-ID: <1420449508-10701-8-git-send-email-k.kozlowski@samsung.com>
References: <1420449508-10701-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1420449508-10701-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The regmap_config struct may be const because it is not modified by the
driver and regmap_init() accepts pointer to const. Make struct
snd_soc_codec_driver (snd_soc_register_codec() accepts pointer to const)
and array of default register values const as well.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: patches@opensource.wolfsonmicro.com
---
 sound/soc/codecs/wm8995.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8995.c b/sound/soc/codecs/wm8995.c
index c280f0a3a424..120228b6b596 100644
--- a/sound/soc/codecs/wm8995.c
+++ b/sound/soc/codecs/wm8995.c
@@ -44,7 +44,7 @@ static const char *wm8995_supply_names[WM8995_NUM_SUPPLIES] = {
 	"MICVDD"
 };
 
-static struct reg_default wm8995_reg_defaults[] = {
+static const struct reg_default wm8995_reg_defaults[] = {
 	{ 0, 0x8995 },
 	{ 5, 0x0100 },
 	{ 16, 0x000b },
@@ -2190,7 +2190,7 @@ static struct snd_soc_dai_driver wm8995_dai[] = {
 	}
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8995 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8995 = {
 	.probe = wm8995_probe,
 	.remove = wm8995_remove,
 	.set_bias_level = wm8995_set_bias_level,
@@ -2204,7 +2204,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8995 = {
 	.num_dapm_routes = ARRAY_SIZE(wm8995_intercon),
 };
 
-static struct regmap_config wm8995_regmap = {
+static const struct regmap_config wm8995_regmap = {
 	.reg_bits = 16,
 	.val_bits = 16,
 
-- 
1.9.1
