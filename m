From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt298: Add jack suspend and resume
	functions.
Date: Mon, 13 Jun 2016 20:28:39 +0800
Message-ID: <1465820919-6105-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 120152650D1
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2016 14:28:58 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, vinod.koul@intel.com, Bard Liao <bardliao@realtek.com>, senthilnathanx.veppur@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

We need to disable jack detection before entering suspend and
enable it after resume.

This was essential as headphone jack widget will always
remain on if a jack is inserted and results in no audio
after system resumes from a suspend.

Signed-off-by: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt298.c | 20 ++++++++++++++++++++
 sound/soc/codecs/rt298.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index d403c20..629b038 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -1270,6 +1270,26 @@ static int rt298_i2c_remove(struct i2c_client *i2c)
 	return 0;
 }
 
+void rt298_jack_suspend(struct snd_soc_codec *codec)
+{
+	struct rt298_priv *rt298 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm;
+
+	dapm = snd_soc_codec_get_dapm(rt298->codec);
+	snd_soc_dapm_disable_pin(dapm, "LDO1");
+	snd_soc_dapm_sync(dapm);
+}
+EXPORT_SYMBOL_GPL(rt298_jack_suspend);
+
+void rt298_jack_resume(struct snd_soc_codec *codec)
+{
+	struct rt298_priv *rt298 = snd_soc_codec_get_drvdata(codec);
+	bool hp = false;
+	bool mic = false;
+
+	rt298_jack_detect(rt298, &hp, &mic);
+}
+EXPORT_SYMBOL_GPL(rt298_jack_resume);
 
 static struct i2c_driver rt298_i2c_driver = {
 	.driver = {
diff --git a/sound/soc/codecs/rt298.h b/sound/soc/codecs/rt298.h
index 3638f3d..2de342f 100644
--- a/sound/soc/codecs/rt298.h
+++ b/sound/soc/codecs/rt298.h
@@ -211,6 +211,8 @@ enum {
 };
 
 int rt298_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack);
+void rt298_jack_suspend(struct snd_soc_codec *codec);
+void rt298_jack_resume(struct snd_soc_codec *codec);
 
 #endif /* __RT298_H__ */
 
-- 
1.8.1.1.439.g50a6b54
