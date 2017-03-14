From: Bard Liao <bardliao@realtek.com>
Subject: Create a general function for codec jack detection
Date: Tue, 14 Mar 2017 05:54:35 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D701C3ED04@RTITEXTEMP.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 64682266E13
 for <alsa-devel@alsa-project.org>; Tue, 14 Mar 2017 06:54:45 +0100 (CET)
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "tiwai@suse.de" <tiwai@suse.de>, "xiaoxiang@pinecone.net" <xiaoxiang@pinecone.net>, "zhongan@pinecone.net" <zhongan@pinecone.net>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

Mark,

There are many codecs with the capability of jack detection. Usually, we
create a jack on machine driver and call an exported codec function,
like rt5670_set_jack_detect, to use the jack and report the jack type.
Could we create a general function for such exported functions?
The benefit is we don't need to use different function names for each
codecs. So we can have a general machine driver with jack detection
function.

Below is what I am thinking the patch will look like.

diff --git a/include/sound/soc.h b/include/sound/soc.h
index cdfb55f..e5a863a 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -434,6 +434,8 @@ int snd_soc_codec_set_sysclk(struct snd_soc_codec *codec, int clk_id,
                             int source, unsigned int freq, int dir);
 int snd_soc_codec_set_pll(struct snd_soc_codec *codec, int pll_id, int source,
                          unsigned int freq_in, unsigned int freq_out);
+int snd_soc_codec_set_jack(struct snd_soc_codec *codec,
+                          struct snd_soc_jack *jack);

 int snd_soc_register_card(struct snd_soc_card *card);
 int snd_soc_unregister_card(struct snd_soc_card *card);
@@ -913,6 +915,7 @@ struct snd_soc_codec_driver {
                          int clk_id, int source, unsigned int freq, int dir);
        int (*set_pll)(struct snd_soc_codec *codec, int pll_id, int source,
                unsigned int freq_in, unsigned int freq_out);
+       int (*set_jack)(struct snd_soc_codec *codec, struct snd_soc_jack *jack);

        /* codec IO */
        struct regmap *(*get_regmap)(struct device *);
diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index fbaa1bb..ec49577 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -22,6 +22,23 @@
 #include <trace/events/asoc.h>

 /**
+ * snd_soc_codec_set_jack - configure codec jack.
+ * @codec: CODEC
+ * @jack: structure to use for the jack
+ *
+ * Configures and enables jack detection function.
+ */
+int snd_soc_codec_set_jack(struct snd_soc_codec *codec,
+       struct snd_soc_jack *jack)
+{
+       if (codec->driver->set_jack)
+               return codec->driver->set_jack(codec, jack);
+       else
+               return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_codec_set_jack);
+
+/**
  * snd_soc_card_jack_new - Create a new jack
  * @card:  ASoC card
  * @id:    an identifying string for this jack
--

Thanks.

Bard Liao
