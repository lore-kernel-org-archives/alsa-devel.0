From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5665: move rt5665_set_jack_detect to
	.set_jack
Date: Tue, 11 Apr 2017 20:07:47 +0800
Message-ID: <1491912467-19241-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id E118D2666E1
 for <alsa-devel@alsa-project.org>; Tue, 11 Apr 2017 14:08:34 +0200 (CEST)
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

Now, we can use .set_jack callback function on codec level. So we
don't need export rt5665_set_jack_detect.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5665.c | 6 +++---
 sound/soc/codecs/rt5665.h | 2 --
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 42bb5fd..8cd2230 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -1260,8 +1260,8 @@ static void rt5665_jd_check_handler(struct work_struct *work)
 	}
 }
 
-int rt5665_set_jack_detect(struct snd_soc_codec *codec,
-	struct snd_soc_jack *hs_jack)
+static int rt5665_set_jack_detect(struct snd_soc_codec *codec,
+	struct snd_soc_jack *hs_jack, void *data)
 {
 	struct rt5665_priv *rt5665 = snd_soc_codec_get_drvdata(codec);
 
@@ -1288,7 +1288,6 @@ int rt5665_set_jack_detect(struct snd_soc_codec *codec,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(rt5665_set_jack_detect);
 
 static void rt5665_jack_detect_handler(struct work_struct *work)
 {
@@ -4567,6 +4566,7 @@ static struct snd_soc_codec_driver soc_codec_dev_rt5665 = {
 	},
 	.set_sysclk = rt5665_set_codec_sysclk,
 	.set_pll = rt5665_set_codec_pll,
+	.set_jack = rt5665_set_jack_detect,
 };
 
 
diff --git a/sound/soc/codecs/rt5665.h b/sound/soc/codecs/rt5665.h
index a30f5e6..1db5c6a 100644
--- a/sound/soc/codecs/rt5665.h
+++ b/sound/soc/codecs/rt5665.h
@@ -1984,7 +1984,5 @@ enum {
 
 int rt5665_sel_asrc_clk_src(struct snd_soc_codec *codec,
 		unsigned int filter_mask, unsigned int clk_src);
-int rt5665_set_jack_detect(struct snd_soc_codec *codec,
-	struct snd_soc_jack *hs_jack);
 
 #endif /* __RT5665_H__ */
-- 
2.7.4
