From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 04/32] ASoC: rt5651: Use standard component
	set_jack callback
Date: Sun, 25 Feb 2018 11:46:45 +0100
Message-ID: <20180225104713.4745-5-hdegoede@redhat.com>
References: <20180225104713.4745-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 17A2A267381
 for <alsa-devel@alsa-project.org>; Sun, 25 Feb 2018 11:47:24 +0100 (CET)
In-Reply-To: <20180225104713.4745-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Use the standard component set_jack callback instead of defining a codec
private API for this.

Tested-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/codecs/rt5651.c             | 6 +++---
 sound/soc/codecs/rt5651.h             | 2 --
 sound/soc/intel/boards/bytcr_rt5651.c | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 11741cdf722e..3e507f53fc13 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1593,8 +1593,8 @@ static irqreturn_t rt5651_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-int rt5651_set_jack_detect(struct snd_soc_component *component,
-			   struct snd_soc_jack *hp_jack)
+static int rt5651_set_jack(struct snd_soc_component *component,
+			   struct snd_soc_jack *hp_jack, void *data)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 	struct rt5651_priv *rt5651 = snd_soc_component_get_drvdata(component);
@@ -1658,7 +1658,6 @@ int rt5651_set_jack_detect(struct snd_soc_component *component,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(rt5651_set_jack_detect);
 
 static int rt5651_probe(struct snd_soc_component *component)
 {
@@ -1762,6 +1761,7 @@ static const struct snd_soc_component_driver soc_component_dev_rt5651 = {
 	.suspend		= rt5651_suspend,
 	.resume			= rt5651_resume,
 	.set_bias_level		= rt5651_set_bias_level,
+	.set_jack		= rt5651_set_jack,
 	.controls		= rt5651_snd_controls,
 	.num_controls		= ARRAY_SIZE(rt5651_snd_controls),
 	.dapm_widgets		= rt5651_dapm_widgets,
diff --git a/sound/soc/codecs/rt5651.h b/sound/soc/codecs/rt5651.h
index 8f128d057ff0..f3158488fc89 100644
--- a/sound/soc/codecs/rt5651.h
+++ b/sound/soc/codecs/rt5651.h
@@ -2080,6 +2080,4 @@ struct rt5651_priv {
 	bool hp_mute;
 };
 
-int rt5651_set_jack_detect(struct snd_soc_component *component,
-			   struct snd_soc_jack *hp_jack);
 #endif /* __RT5651_H__ */
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 1f8407b17d2b..8008a027cc93 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -368,7 +368,7 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 		return ret;
 	}
 
-	rt5651_set_jack_detect(codec, &priv->jack);
+	snd_soc_component_set_jack(codec, &priv->jack, NULL);
 
 	return ret;
 }
-- 
2.14.3
