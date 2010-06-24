From: Vladimir Zapolskiy <vzapolskiy@gmail.com>
Subject: [PATCH 2/2] ASoC: uda134x: fix bias level setup on
	initialization and runtime
Date: Thu, 24 Jun 2010 15:17:08 +0400
Message-ID: <1277378228-29658-2-git-send-email-vzapolskiy@gmail.com>
References: <1277378228-29658-1-git-send-email-vzapolskiy@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D80A510381F
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jun 2010 13:17:51 +0200 (CEST)
Received: by mail-fx0-f51.google.com with SMTP id 13so1914587fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 24 Jun 2010 04:17:51 -0700 (PDT)
In-Reply-To: <1277378228-29658-1-git-send-email-vzapolskiy@gmail.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Vladimir Zapolskiy <vzapolskiy@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

For UDA1341 codec power control is managed in STATUS1 register, and
for all other codecs in DATA011 register.

On initialization ADC/DAC are enabled only for UDA1341, that's why
bias_level shall be set to off, otherwise dapm is misinformed about
bias_level on startup.

Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>
---
 sound/soc/codecs/uda134x.c |   29 ++++++++++++++++++++++-------
 1 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index e770029..0e9a945 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -353,8 +353,13 @@ static int uda134x_set_bias_level(struct snd_soc_codec *codec,
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		/* ADC, DAC on */
-		reg = uda134x_read_reg_cache(codec, UDA134X_STATUS1);
-		uda134x_write(codec, UDA134X_STATUS1, reg | 0x03);
+		if (pd->model == UDA134X_UDA1341) {
+			reg = uda134x_read_reg_cache(codec, UDA134X_STATUS1);
+			uda134x_write(codec, UDA134X_STATUS1, reg | 0x03);
+		} else {
+			reg = uda134x_read_reg_cache(codec, UDA134X_DATA011);
+			uda134x_write(codec, UDA134X_DATA011, reg | 0x03);
+		}
 		break;
 	case SND_SOC_BIAS_PREPARE:
 		/* power on */
@@ -367,8 +372,13 @@ static int uda134x_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		/* ADC, DAC power off */
-		reg = uda134x_read_reg_cache(codec, UDA134X_STATUS1);
-		uda134x_write(codec, UDA134X_STATUS1, reg & ~(0x03));
+		if (pd->model == UDA134X_UDA1341) {
+			reg = uda134x_read_reg_cache(codec, UDA134X_STATUS1);
+			uda134x_write(codec, UDA134X_STATUS1, reg & ~(0x03));
+		} else {
+			reg = uda134x_read_reg_cache(codec, UDA134X_DATA011);
+			uda134x_write(codec, UDA134X_DATA011, reg & ~(0x03));
+		}
 		break;
 	case SND_SOC_BIAS_OFF:
 		/* power off */
@@ -531,9 +541,7 @@ static int uda134x_soc_probe(struct platform_device *pdev)
 	codec->num_dai = 1;
 	codec->read = uda134x_read_reg_cache;
 	codec->write = uda134x_write;
-#ifdef POWER_OFF_ON_STANDBY
-	codec->set_bias_level = uda134x_set_bias_level;
-#endif
+
 	INIT_LIST_HEAD(&codec->dapm_widgets);
 	INIT_LIST_HEAD(&codec->dapm_paths);
 
@@ -544,6 +552,13 @@ static int uda134x_soc_probe(struct platform_device *pdev)
 
 	uda134x_reset(codec);
 
+#ifdef POWER_OFF_ON_STANDBY
+	codec->set_bias_level = uda134x_set_bias_level;
+	uda134x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+#else
+	uda134x_set_bias_level(codec, SND_SOC_BIAS_ON);
+#endif
+
 	/* register pcms */
 	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
 	if (ret < 0) {
-- 
1.7.0.4
