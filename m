From: "Cormier, Jonathan" <jcormier@criticallink.com>
Subject: [PATCH RFC 4/7] ASoC: tlv320aic26: Fix regmap by setting reg_defaults and reg_stride
Date: Fri, 18 Sep 2015 16:11:13 -0400
Message-ID: <1442607076-26681-5-git-send-email-jcormier@criticallink.com>
References: <1442607076-26681-1-git-send-email-jcormier@criticallink.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442607076-26681-1-git-send-email-jcormier@criticallink.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Bob Duke <bduke@criticallink.com>, Mike Williamson <michael.williamson@criticallink.com>, Mark Brown <broonie@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Greg Gluszek <greg.gluszek@criticallink.com>, "Cormier, Jonathan" <jcormier@criticallink.com>
List-Id: alsa-devel@alsa-project.org

tlv320aic26 codec wasn't being setup correctly on bootup due to misconfigured regmap cache.

Fixes: b7e9f3973279 "ASoC: tlv320aic26: Convert to direct regmap API usage"
Signed-off-by: Cormier, Jonathan <jcormier@criticallink.com>
---
 sound/soc/codecs/tlv320aic26.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index 91347727cfae..70af361a116c 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -41,6 +41,27 @@ struct aic26 {
 	int keyclick_len;
 };
 
+static const struct reg_default aic26_reg[] = {
+	/* Page 0 */
+	{ 0x00A0, 0x0000 }, { 0x00C0, 0x0000 }, { 0x00E0, 0x0000 },
+	{ 0x0120, 0x0000 }, { 0x0140, 0x0000 },
+	/* Page 1 */
+	{ 0x0800, 0x0000 }, { 0x0820, 0x8000 }, { 0x0860, 0x0002 },
+	{ 0x0880, 0xFFFF },
+	/* Page 2 */
+	{ 0x1000, 0x0000 }, { 0x1020, 0x8000 }, { 0x1040, 0xFFFF },
+	{ 0x1060, 0xC580 }, { 0x1080, 0x4410 }, { 0x10A0, 0xAFC0 },
+	{ 0x10C0, 0x0000 }, { 0x10E0,  27619 }, { 0x1100, -27034 },
+	{ 0x1120,  26461 }, { 0x1140,  27619 }, { 0x1160, -27034 },
+	{ 0x1180,  26461 }, { 0x11A0,  32131 }, { 0x11C0, -31506 },
+	{ 0x11E0,  32131 }, { 0x1200, -31506 }, { 0x1220,  27619 },
+	{ 0x1240, -27034 }, { 0x1260,  26461 }, { 0x1280,  27619 },
+	{ 0x12A0, -27034 }, { 0x12C0,  26461 }, { 0x12E0,  32131 },
+	{ 0x1300, -31506 }, { 0x1320,  32131 }, { 0x1340, -31506 },
+	{ 0x1360, 0x1004 }, { 0x1380, 0x0000 }, { 0x13A0, 0x0000 },
+	{ 0x13C0, 0xFE00 },
+};
+
 static const struct snd_soc_dapm_widget tlv320aic26_dapm_widgets[] = {
 SND_SOC_DAPM_INPUT("MICIN"),
 SND_SOC_DAPM_INPUT("AUX"),
@@ -332,6 +353,13 @@ static struct snd_soc_codec_driver aic26_soc_codec_dev = {
 static const struct regmap_config aic26_regmap = {
 	.reg_bits = 16,
 	.val_bits = 16,
+	/* AIC26_PAGE_ADDR(0, 0x01) */
+	.reg_stride = 0x20,
+
+	.max_register = AIC26_REG_AUDIO_CTRL5,
+	.reg_defaults = aic26_reg,
+	.num_reg_defaults = ARRAY_SIZE(aic26_reg),
+	.cache_type = REGCACHE_RBTREE,
 };
 
 /* ---------------------------------------------------------------------
-- 
1.9.1
