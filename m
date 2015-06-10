From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH v3 1/3] ASoC: wm_adsp: Add code_probe and
	codec_remove stubs
Date: Wed, 10 Jun 2015 16:12:46 +0100
Message-ID: <1433949168-25615-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E7E05265A8C
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2015 17:12:04 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Currently the only init function in wm_adsp is called by the
codec driver early in its probe before the codec has been
registered with SOC.

This patch adds stubs for the codec_probe and codec_remove stages
and calls them from WM5102 and WM5110 codec drivers. This allows us
to hang anything that needs setup during the codec probe stage off
these functions without further modification of the codec drivers.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5102.c  |    6 ++++++
 sound/soc/codecs/wm5110.c  |   12 +++++++++++-
 sound/soc/codecs/wm_adsp.c |   12 ++++++++++++
 sound/soc/codecs/wm_adsp.h |    2 ++
 4 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 11eba0e..341d96e 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1875,6 +1875,10 @@ static int wm5102_codec_probe(struct snd_soc_codec *codec)
 	struct wm5102_priv *priv = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
+	ret = wm_adsp2_codec_probe(&priv->core.adsp[0], codec);
+	if (ret)
+		return ret;
+
 	ret = snd_soc_add_codec_controls(codec, wm_adsp2_fw_controls, 2);
 	if (ret != 0)
 		return ret;
@@ -1893,6 +1897,8 @@ static int wm5102_codec_remove(struct snd_soc_codec *codec)
 {
 	struct wm5102_priv *priv = snd_soc_codec_get_drvdata(codec);
 
+	wm_adsp2_codec_remove(&priv->core.adsp[0], codec);
+
 	priv->core.arizona->dapm = NULL;
 
 	return 0;
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index d65364e..6e15d9c 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -1599,7 +1599,7 @@ static struct snd_soc_dai_driver wm5110_dai[] = {
 static int wm5110_codec_probe(struct snd_soc_codec *codec)
 {
 	struct wm5110_priv *priv = snd_soc_codec_get_drvdata(codec);
-	int ret;
+	int i, ret;
 
 	priv->core.arizona->dapm = &codec->dapm;
 
@@ -1607,6 +1607,12 @@ static int wm5110_codec_probe(struct snd_soc_codec *codec)
 	arizona_init_gpio(codec);
 	arizona_init_mono(codec);
 
+	for (i = 0; i < WM5110_NUM_ADSP; ++i) {
+		ret = wm_adsp2_codec_probe(&priv->core.adsp[i], codec);
+		if (ret)
+			return ret;
+	}
+
 	ret = snd_soc_add_codec_controls(codec, wm_adsp2_fw_controls, 8);
 	if (ret != 0)
 		return ret;
@@ -1621,6 +1627,10 @@ static int wm5110_codec_probe(struct snd_soc_codec *codec)
 static int wm5110_codec_remove(struct snd_soc_codec *codec)
 {
 	struct wm5110_priv *priv = snd_soc_codec_get_drvdata(codec);
+	int i;
+
+	for (i = 0; i < WM5110_NUM_ADSP; ++i)
+		wm_adsp2_codec_remove(&priv->core.adsp[i], codec);
 
 	priv->core.arizona->dapm = NULL;
 
diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 6e358b5..490edb3 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1906,6 +1906,18 @@ err:
 }
 EXPORT_SYMBOL_GPL(wm_adsp2_event);
 
+int wm_adsp2_codec_probe(struct wm_adsp *dsp, struct snd_soc_codec *codec)
+{
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wm_adsp2_codec_probe);
+
+int wm_adsp2_codec_remove(struct wm_adsp *dsp, struct snd_soc_codec *codec)
+{
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wm_adsp2_codec_remove);
+
 int wm_adsp2_init(struct wm_adsp *dsp)
 {
 	int ret;
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 0e5f07c..5584e34 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -79,6 +79,8 @@ extern const struct snd_kcontrol_new wm_adsp2_fw_controls[];
 
 int wm_adsp1_init(struct wm_adsp *dsp);
 int wm_adsp2_init(struct wm_adsp *dsp);
+int wm_adsp2_codec_probe(struct wm_adsp *dsp, struct snd_soc_codec *codec);
+int wm_adsp2_codec_remove(struct wm_adsp *dsp, struct snd_soc_codec *codec);
 int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 		   struct snd_kcontrol *kcontrol, int event);
 int wm_adsp2_early_event(struct snd_soc_dapm_widget *w,
-- 
1.7.2.5
