From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Propagate errors from
	arizona_spk_init
Date: Wed, 18 Jan 2017 15:27:05 +0000
Message-ID: <1484753225-24188-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id E8E11266569
 for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2017 16:26:34 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

arizona_spk_init uses snd_soc_dapm_new_control which since
commit 37e1df8c95e2 ("ASoC: dapm: handle probe deferrals") will
occasionally request a probe deferral. Which means we should propagate the
error out of our driver from it.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/cs47l24.c | 5 ++++-
 sound/soc/codecs/wm5102.c  | 5 ++++-
 sound/soc/codecs/wm5110.c  | 5 ++++-
 sound/soc/codecs/wm8997.c  | 6 +++++-
 sound/soc/codecs/wm8998.c  | 6 +++++-
 5 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index 0dd721e..47e6fdd 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -1124,7 +1124,10 @@ static int cs47l24_codec_probe(struct snd_soc_codec *codec)
 
 	priv->core.arizona->dapm = dapm;
 
-	arizona_init_spk(codec);
+	ret = arizona_init_spk(codec);
+	if (ret < 0)
+		return ret;
+
 	arizona_init_gpio(codec);
 	arizona_init_mono(codec);
 	arizona_init_notifiers(codec);
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 9edd239..1fe358e 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1946,7 +1946,10 @@ static int wm5102_codec_probe(struct snd_soc_codec *codec)
 	if (ret)
 		goto err_adsp2_codec_probe;
 
-	arizona_init_spk(codec);
+	ret = arizona_init_spk(codec);
+	if (ret < 0)
+		return ret;
+
 	arizona_init_gpio(codec);
 	arizona_init_notifiers(codec);
 
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 01b5b6c..1bc9421 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -2284,7 +2284,10 @@ static int wm5110_codec_probe(struct snd_soc_codec *codec)
 
 	priv->core.arizona->dapm = dapm;
 
-	arizona_init_spk(codec);
+	ret = arizona_init_spk(codec);
+	if (ret < 0)
+		return ret;
+
 	arizona_init_gpio(codec);
 	arizona_init_mono(codec);
 	arizona_init_notifiers(codec);
diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index ee0c863..49401a8 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -1062,8 +1062,12 @@ static int wm8997_codec_probe(struct snd_soc_codec *codec)
 	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
 	struct wm8997_priv *priv = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
+	ret = arizona_init_spk(codec);
+	if (ret < 0)
+		return ret;
 
-	arizona_init_spk(codec);
 	arizona_init_notifiers(codec);
 
 	snd_soc_component_disable_pin(component, "HAPTICS");
diff --git a/sound/soc/codecs/wm8998.c b/sound/soc/codecs/wm8998.c
index 3694f59..44f4471 100644
--- a/sound/soc/codecs/wm8998.c
+++ b/sound/soc/codecs/wm8998.c
@@ -1321,10 +1321,14 @@ static int wm8998_codec_probe(struct snd_soc_codec *codec)
 	struct wm8998_priv *priv = snd_soc_codec_get_drvdata(codec);
 	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
+	int ret;
 
 	priv->core.arizona->dapm = dapm;
 
-	arizona_init_spk(codec);
+	ret = arizona_init_spk(codec);
+	if (ret < 0)
+		return ret;
+
 	arizona_init_gpio(codec);
 	arizona_init_notifiers(codec);
 
-- 
2.1.4
