From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Convert max9850 to table based DAPM and
	control init
Date: Mon, 19 Dec 2011 13:13:31 +0800
Message-ID: <1324271611.12952.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id EB92724717
	for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2011 06:13:44 +0100 (CET)
Received: by ghrr11 with SMTP id r11so3324736ghr.38
	for <alsa-devel@alsa-project.org>; Sun, 18 Dec 2011 21:13:42 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Christian Glindkamp <christian.glindkamp@taskit.de>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/max9850.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/max9850.c b/sound/soc/codecs/max9850.c
index 7dfd6e8..47060d2 100644
--- a/sound/soc/codecs/max9850.c
+++ b/sound/soc/codecs/max9850.c
@@ -86,7 +86,7 @@ SND_SOC_DAPM_INPUT("INL"),
 SND_SOC_DAPM_INPUT("INR"),
 };
 
-static const struct snd_soc_dapm_route intercon[] = {
+static const struct snd_soc_dapm_route max9850_dapm_routes[] = {
 	/* output mixer */
 	{"Output Mixer", NULL, "DAC"},
 	{"Output Mixer", "Line In Switch", "Line Input"},
@@ -293,7 +293,6 @@ static int max9850_resume(struct snd_soc_codec *codec)
 
 static int max9850_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret;
 
 	ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_I2C);
@@ -309,13 +308,6 @@ static int max9850_probe(struct snd_soc_codec *codec)
 	/* set slew-rate 125ms */
 	snd_soc_update_bits(codec, MAX9850_CHARGE_PUMP, 0xff, 0xc0);
 
-	snd_soc_dapm_new_controls(dapm, max9850_dapm_widgets,
-				  ARRAY_SIZE(max9850_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
-
-	snd_soc_add_controls(codec, max9850_controls,
-			ARRAY_SIZE(max9850_controls));
-
 	return 0;
 }
 
@@ -328,6 +320,13 @@ static struct snd_soc_codec_driver soc_codec_dev_max9850 = {
 	.reg_word_size = sizeof(u8),
 	.reg_cache_default = max9850_reg,
 	.volatile_register = max9850_volatile_register,
+
+	.controls = max9850_controls,
+	.num_controls = ARRAY_SIZE(max9850_controls),
+	.dapm_widgets = max9850_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(max9850_dapm_widgets),
+	.dapm_routes = max9850_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(max9850_dapm_routes),
 };
 
 static int __devinit max9850_i2c_probe(struct i2c_client *i2c,
-- 
1.7.5.4
