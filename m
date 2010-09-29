From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: WM8985: Register notifier for the
	regulator being disabled
Date: Wed, 29 Sep 2010 11:38:37 +0100
Message-ID: <1285756717-27149-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A9EB11038E4
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Sep 2010 12:38:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Make sure we get an event when the regulator is disabled so we know
we have to sync the cache afterwards.

Minor stylistic changes.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8985.c |   51 +++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8985.c b/sound/soc/codecs/wm8985.c
index 6116b42..bd109c4 100644
--- a/sound/soc/codecs/wm8985.c
+++ b/sound/soc/codecs/wm8985.c
@@ -126,11 +126,35 @@ static const int volume_update_regs[] = {
 
 struct wm8985_priv {
 	enum snd_soc_control_type control_type;
+	struct snd_soc_codec *codec;
 	struct regulator_bulk_data supplies[WM8985_NUM_SUPPLIES];
+	struct notifier_block disable_nb[WM8985_NUM_SUPPLIES];
 	unsigned int sysclk;
 	unsigned int bclk;
 };
 
+/*
+ * We can't use the same notifier block for more than one supply and
+ * there's no way I can see to get from a callback to the caller
+ * except container_of().
+ */
+#define WM8985_REGULATOR_EVENT(n) \
+static int wm8985_regulator_event_##n(struct notifier_block *nb, \
+				      unsigned long event, void *data)    \
+{ \
+	struct wm8985_priv *wm8985 = container_of(nb, struct wm8985_priv, \
+							  disable_nb[n]); \
+	if (event & REGULATOR_EVENT_DISABLE) { \
+		wm8985->codec->cache_sync = 1; \
+	} \
+	return 0; \
+}
+
+WM8985_REGULATOR_EVENT(0)
+WM8985_REGULATOR_EVENT(1)
+WM8985_REGULATOR_EVENT(2)
+WM8985_REGULATOR_EVENT(3)
+
 static const struct {
 	int div;
 	int ratio;
@@ -782,7 +806,7 @@ static int wm8985_set_pll(struct snd_soc_dai *dai, int pll_id,
 {
 	int ret;
 	struct snd_soc_codec *codec;
-	struct pll_div pll_div;
+	struct pll_div pll_div = { 0 };
 
 	codec = dai->codec;
 	if (freq_in && freq_out) {
@@ -794,7 +818,7 @@ static int wm8985_set_pll(struct snd_soc_dai *dai, int pll_id,
 	/* disable the PLL before reprogramming it */
 	snd_soc_update_bits(codec, WM8985_POWER_MANAGEMENT_1,
 			    WM8985_PLLEN_MASK, 0);
-	
+
 	if (!freq_in || !freq_out)
 		return 0;
 
@@ -932,8 +956,6 @@ static int wm8985_set_bias_level(struct snd_soc_codec *codec,
 		snd_soc_write(codec, WM8985_POWER_MANAGEMENT_2, 0);
 		snd_soc_write(codec, WM8985_POWER_MANAGEMENT_3, 0);
 
-		codec->cache_sync = 1;
-
 		regulator_bulk_disable(ARRAY_SIZE(wm8985->supplies),
 				       wm8985->supplies);
 		break;
@@ -963,9 +985,13 @@ static int wm8985_resume(struct snd_soc_codec *codec)
 static int wm8985_remove(struct snd_soc_codec *codec)
 {
 	struct wm8985_priv *wm8985;
+	int i;
 
 	wm8985 = snd_soc_codec_get_drvdata(codec);
 	wm8985_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	for (i = 0; i < ARRAY_SIZE(wm8985->supplies); i++)
+		regulator_unregister_notifier(wm8985->supplies[i].consumer,
+					      &wm8985->disable_nb[i]);
 	regulator_bulk_free(ARRAY_SIZE(wm8985->supplies), wm8985->supplies);
 	return 0;
 }
@@ -978,6 +1004,7 @@ static int wm8985_probe(struct snd_soc_codec *codec)
 	u16 *cache;
 
 	wm8985 = snd_soc_codec_get_drvdata(codec);
+	wm8985->codec = codec;
 
 	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8985->control_type);
 	if (ret < 0) {
@@ -995,6 +1022,22 @@ static int wm8985_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
+	wm8985->disable_nb[0].notifier_call = wm8985_regulator_event_0;
+	wm8985->disable_nb[1].notifier_call = wm8985_regulator_event_1;
+	wm8985->disable_nb[2].notifier_call = wm8985_regulator_event_2;
+	wm8985->disable_nb[3].notifier_call = wm8985_regulator_event_3;
+
+	/* This should really be moved into the regulator core */
+	for (i = 0; i < ARRAY_SIZE(wm8985->supplies); i++) {
+		ret = regulator_register_notifier(wm8985->supplies[i].consumer,
+						  &wm8985->disable_nb[i]);
+		if (ret != 0) {
+			dev_err(codec->dev,
+				"Failed to register regulator notifier: %d\n",
+				ret);
+		}
+	}
+
 	ret = regulator_bulk_enable(ARRAY_SIZE(wm8985->supplies),
 				    wm8985->supplies);
 	if (ret) {
-- 
1.7.3
