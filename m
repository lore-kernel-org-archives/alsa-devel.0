From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/3] ASoC: max98088: Fix indentation
Date: Mon, 23 Sep 2013 17:58:24 +0100
Message-ID: <1379955506-11658-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F0282610B4
 for <alsa-devel@alsa-project.org>; Mon, 23 Sep 2013 18:58:40 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>, Chih-Chung Chang <chihchung@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/max98088.c | 46 ++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 566a367..391f669 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -38,20 +38,20 @@ struct max98088_cdata {
 };
 
 struct max98088_priv {
-       enum max98088_type devtype;
-       struct max98088_pdata *pdata;
-       unsigned int sysclk;
-       struct max98088_cdata dai[2];
-       int eq_textcnt;
-       const char **eq_texts;
-       struct soc_enum eq_enum;
-       u8 ina_state;
-       u8 inb_state;
-       unsigned int ex_mode;
-       unsigned int digmic;
-       unsigned int mic1pre;
-       unsigned int mic2pre;
-       unsigned int extmic_mode;
+	enum max98088_type devtype;
+	struct max98088_pdata *pdata;
+	unsigned int sysclk;
+	struct max98088_cdata dai[2];
+	int eq_textcnt;
+	const char **eq_texts;
+	struct soc_enum eq_enum;
+	u8 ina_state;
+	u8 inb_state;
+	unsigned int ex_mode;
+	unsigned int digmic;
+	unsigned int mic1pre;
+	unsigned int mic2pre;
+	unsigned int extmic_mode;
 };
 
 static const u8 max98088_reg[M98088_REG_CNT] = {
@@ -2066,15 +2066,15 @@ static int max98088_remove(struct snd_soc_codec *codec)
 }
 
 static struct snd_soc_codec_driver soc_codec_dev_max98088 = {
-       .probe   = max98088_probe,
-       .remove  = max98088_remove,
-       .suspend = max98088_suspend,
-       .resume  = max98088_resume,
-       .set_bias_level = max98088_set_bias_level,
-       .reg_cache_size = ARRAY_SIZE(max98088_reg),
-       .reg_word_size = sizeof(u8),
-       .reg_cache_default = max98088_reg,
-       .volatile_register = max98088_volatile_register,
+	.probe   = max98088_probe,
+	.remove  = max98088_remove,
+	.suspend = max98088_suspend,
+	.resume  = max98088_resume,
+	.set_bias_level = max98088_set_bias_level,
+	.reg_cache_size = ARRAY_SIZE(max98088_reg),
+	.reg_word_size = sizeof(u8),
+	.reg_cache_default = max98088_reg,
+	.volatile_register = max98088_volatile_register,
 	.dapm_widgets = max98088_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(max98088_dapm_widgets),
 	.dapm_routes = max98088_audio_map,
-- 
1.8.4.rc3
