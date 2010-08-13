From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] ASoC: Only tweak WM8994 chip configuration
	on devices up to rev D
Date: Fri, 13 Aug 2010 14:39:24 +0100
Message-ID: <1281706766-5991-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1281706766-5991-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 37347103809
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Aug 2010 15:39:30 +0200 (CEST)
In-Reply-To: <1281706766-5991-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Ian Lartey <ian@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Any subsequent revisions will have these configuration changes applied
by default.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 2dc9daa..522249d 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -95,6 +95,7 @@ struct wm8994_priv {
 
 	struct wm8994_micdet micdet[2];
 
+	int revision;
 	struct wm8994_pdata *pdata;
 };
 
@@ -3070,6 +3071,8 @@ static int wm8994_set_dai_sysclk(struct snd_soc_dai *dai,
 static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		break;
@@ -3084,10 +3087,14 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 		if (codec->bias_level == SND_SOC_BIAS_OFF) {
 			/* Tweak DC servo and DSP configuration for
 			 * improved performance. */
-			snd_soc_write(codec, 0x102, 0x3);
-			snd_soc_write(codec, 0x56, 0x3);
-			snd_soc_write(codec, 0x817, 0);
-			snd_soc_write(codec, 0x102, 0);
+			if (wm8994->revision < 4) {
+				/* Tweak DC servo and DSP configuration for
+				 * improved performance. */
+				snd_soc_write(codec, 0x102, 0x3);
+				snd_soc_write(codec, 0x56, 0x3);
+				snd_soc_write(codec, 0x817, 0);
+				snd_soc_write(codec, 0x102, 0);
+			}
 
 			/* Discharge LINEOUT1 & 2 */
 			snd_soc_update_bits(codec, WM8994_ANTIPOP_1,
@@ -3920,7 +3927,6 @@ static int wm8994_codec_probe(struct platform_device *pdev)
 	struct wm8994_priv *wm8994;
 	struct snd_soc_codec *codec;
 	int i;
-	u16 rev;
 
 	if (wm8994_codec) {
 		dev_err(&pdev->dev, "Another WM8994 is registered\n");
@@ -3974,8 +3980,8 @@ static int wm8994_codec_probe(struct platform_device *pdev)
 			wm8994->reg_cache[i] = 0;
 
 	/* Set revision-specific configuration */
-	rev = snd_soc_read(codec, WM8994_CHIP_REVISION);
-	switch (rev) {
+	wm8994->revision = snd_soc_read(codec, WM8994_CHIP_REVISION);
+	switch (wm8994->revision) {
 	case 2:
 	case 3:
 		wm8994->hubs.dcs_codes = -5;
-- 
1.7.1
