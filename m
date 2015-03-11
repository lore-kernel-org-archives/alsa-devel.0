From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH v2 2/2] ASoC: rt5670: export jack
	suspend/resume APIs
Date: Wed, 11 Mar 2015 11:39:15 +0800
Message-ID: <1426045155-15900-2-git-send-email-bardliao@realtek.com>
References: <1426045155-15900-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id CD7C6265044
 for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2015 04:39:28 +0100 (CET)
In-Reply-To: <1426045155-15900-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, mengdong.lin@intel.com, john.lin@realtek.com, Jin Yao <yao.jin@linux.intel.com>, Bard Liao <bardliao@realtek.com>, yao.jin@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

We force enable "Mic Det Power" when a jack is inserted. Also, we
set codec idle_bias_off = true. As a result, codec driver will not
suspend as we expect.

On Braswell, we don't need the jack detection when suspend but need
it after resume, so export the jack suspend/resume APIs which are
provided for machine driver to control during suspend/resume.

Signed-off-by: Jie Yang <yang.jie@intel.com>
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5670.c | 18 ++++++++++++++++++
 sound/soc/codecs/rt5670.h |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 23ca049..5999512 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -461,6 +461,24 @@ static int rt5670_headset_detect(struct snd_soc_codec *codec, int jack_insert)
 	return rt5670->jack_type;
 }
 
+void rt5670_jack_suspend(struct snd_soc_codec *codec)
+{
+	struct rt5670_priv *rt5670 = snd_soc_codec_get_drvdata(codec);
+
+	rt5670->jack_type_saved = rt5670->jack_type;
+	rt5670_headset_detect(codec, 0);
+}
+EXPORT_SYMBOL_GPL(rt5670_jack_suspend);
+
+void rt5670_jack_resume(struct snd_soc_codec *codec)
+{
+	struct rt5670_priv *rt5670 = snd_soc_codec_get_drvdata(codec);
+
+	if (rt5670->jack_type_saved)
+		rt5670_headset_detect(codec, 1);
+}
+EXPORT_SYMBOL_GPL(rt5670_jack_resume);
+
 static int rt5670_button_detect(struct snd_soc_codec *codec)
 {
 	int btn_type, val;
diff --git a/sound/soc/codecs/rt5670.h b/sound/soc/codecs/rt5670.h
index 0f3255a..dc2b462 100644
--- a/sound/soc/codecs/rt5670.h
+++ b/sound/soc/codecs/rt5670.h
@@ -2004,8 +2004,11 @@ struct rt5670_priv {
 	int dsp_sw; /* expected parameter setting */
 	int dsp_rate;
 	int jack_type;
+	int jack_type_saved;
 };
 
+void rt5670_jack_suspend(struct snd_soc_codec *codec);
+void rt5670_jack_resume(struct snd_soc_codec *codec);
 int rt5670_set_jack_detect(struct snd_soc_codec *codec,
 	struct snd_soc_jack *jack);
 #endif /* __RT5670_H__ */
-- 
1.8.1.1.439.g50a6b54
