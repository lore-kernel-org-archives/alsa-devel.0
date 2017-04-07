From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: jack: add snd_soc_codec_set_jack
Date: Fri, 7 Apr 2017 11:26:41 +0800
Message-ID: <1491535601-23808-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D86C266961
 for <alsa-devel@alsa-project.org>; Fri,  7 Apr 2017 05:27:11 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, xiaoxiang@pinecone.net, zhongan@pinecone.net, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

There are many codecs with the capability of jack detection. Usually,
we create a jack on machine driver but there is no common function for
machine driver to deliver the jack pointer to codec driver.
snd_soc_codec_set_jack can be used for delivering the jack pointer to
codec driver and enable the jack detection function. To make it work,
codec driver need to define a callback function to receive the jack
pointer and do all necessary procedure for enabling jack detection.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 include/sound/soc.h  |  4 ++++
 sound/soc/soc-jack.c | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 77ef074..864597d 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -434,6 +434,8 @@ int snd_soc_codec_set_sysclk(struct snd_soc_codec *codec, int clk_id,
 			     int source, unsigned int freq, int dir);
 int snd_soc_codec_set_pll(struct snd_soc_codec *codec, int pll_id, int source,
 			  unsigned int freq_in, unsigned int freq_out);
+int snd_soc_codec_set_jack(struct snd_soc_codec *codec,
+			   struct snd_soc_jack *jack, void *data);
 
 int snd_soc_register_card(struct snd_soc_card *card);
 int snd_soc_unregister_card(struct snd_soc_card *card);
@@ -913,6 +915,8 @@ struct snd_soc_codec_driver {
 			  int clk_id, int source, unsigned int freq, int dir);
 	int (*set_pll)(struct snd_soc_codec *codec, int pll_id, int source,
 		unsigned int freq_in, unsigned int freq_out);
+	int (*set_jack)(struct snd_soc_codec *codec,
+			struct snd_soc_jack *jack,  void *data);
 
 	/* codec IO */
 	struct regmap *(*get_regmap)(struct device *);
diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index a03dcbb9..7daf21f 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -23,6 +23,24 @@
 #include <trace/events/asoc.h>
 
 /**
+ * snd_soc_codec_set_jack - configure codec jack.
+ * @codec: CODEC
+ * @jack: structure to use for the jack
+ * @data: can be used if codec driver need extra data for configuring jack
+ *
+ * Configures and enables jack detection function.
+ */
+int snd_soc_codec_set_jack(struct snd_soc_codec *codec,
+	struct snd_soc_jack *jack, void *data)
+{
+	if (codec->driver->set_jack)
+		return codec->driver->set_jack(codec, jack, data);
+	else
+		return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_codec_set_jack);
+
+/**
  * snd_soc_card_jack_new - Create a new jack
  * @card:  ASoC card
  * @id:    an identifying string for this jack
-- 
2.7.4
