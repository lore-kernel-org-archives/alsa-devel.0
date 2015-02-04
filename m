From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v2] ASoC: rt286: add jack detection
	enable/disable APIs and export
Date: Wed,  4 Feb 2015 21:34:03 +0800
Message-ID: <1423056843-26490-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 90927260448
 for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2015 14:32:04 +0100 (CET)
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
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Some platforms, e.g. WSB, don't need jack detection when
system is in Suspend, for power save reason.

Here add jack detection enable/disable APIs and export them, when
disabled, it will ignore interrupt, and disable LDO1, which is
used for jack detection when headphone is plugged in.

Signed-off-by: Jie Yang <yang.jie@intel.com>
Reviewed-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt286.c | 24 ++++++++++++++++++++++++
 sound/soc/codecs/rt286.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 8104d22..9ea01d0 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -400,6 +400,30 @@ int rt286_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack)
 }
 EXPORT_SYMBOL_GPL(rt286_mic_detect);
 
+int rt286_enable_jack_detection(struct snd_soc_codec *codec)
+{
+	struct rt286_priv *rt286 = snd_soc_codec_get_drvdata(codec);
+
+	if (rt286->jack->status | SND_JACK_HEADPHONE)
+		snd_soc_dapm_force_enable_pin(&rt286->codec->dapm, "LDO1");
+	snd_soc_dapm_sync(&rt286->codec->dapm);
+	enable_irq(rt286->i2c->irq);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rt286_enable_jack_detection);
+
+int rt286_disable_jack_detection(struct snd_soc_codec *codec)
+{
+	struct rt286_priv *rt286 = snd_soc_codec_get_drvdata(codec);
+
+	disable_irq(rt286->i2c->irq);
+
+	snd_soc_dapm_disable_pin(&rt286->codec->dapm, "LDO1");
+	snd_soc_dapm_sync(&rt286->codec->dapm);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rt286_disable_jack_detection);
+
 static int is_mclk_mode(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
 {
diff --git a/sound/soc/codecs/rt286.h b/sound/soc/codecs/rt286.h
index b539b73..c958182 100644
--- a/sound/soc/codecs/rt286.h
+++ b/sound/soc/codecs/rt286.h
@@ -193,6 +193,8 @@ enum {
 };
 
 int rt286_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack);
+int rt286_enable_jack_detection(struct snd_soc_codec *codec);
+int rt286_disable_jack_detection(struct snd_soc_codec *codec);
 
 #endif /* __RT286_H__ */
 
-- 
1.9.1
