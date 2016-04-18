From: Xing Zheng <zhengxing@rock-chips.com>
Subject: [PATCH 1/3] ASoC: jack: Add a jack detect callback via codec
Date: Mon, 18 Apr 2016 16:17:30 +0800
Message-ID: <1460967452-24574-2-git-send-email-zhengxing@rock-chips.com>
References: <1460967452-24574-1-git-send-email-zhengxing@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460967452-24574-1-git-send-email-zhengxing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de, Adam.Thomson@diasemi.com, sugar.zhang@rock-chips.com, jay.xu@rock-chips.com, broonie@kernel.org, Xing Zheng <zhengxing@rock-chips.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch add a callback when a codec have the jack detect feature.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

 include/sound/soc.h  |    6 ++++++
 sound/soc/soc-jack.c |    8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 02b4a21..ff105a4 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -547,6 +547,10 @@ static inline void snd_soc_jack_free_gpios(struct snd_soc_jack *jack, int count,
 }
 #endif
 
+/* init jack detect via codec */
+void snd_soc_jack_codec_detect(struct snd_soc_codec *codec,
+				struct snd_soc_jack *jack);
+
 /* codec register bit access */
 int snd_soc_update_bits(struct snd_soc_codec *codec, unsigned int reg,
 				unsigned int mask, unsigned int value);
@@ -920,6 +924,8 @@ struct snd_soc_codec_driver {
 			     enum snd_soc_dapm_type, int);
 
 	bool ignore_pmdown_time;  /* Doesn't benefit from pmdown delay */
+
+	void (*detect_jack)(struct snd_soc_codec *codec, struct snd_soc_jack *jack);
 };
 
 /* SoC platform interface */
diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index fbaa1bb..e292fb4 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -436,3 +436,11 @@ void snd_soc_jack_free_gpios(struct snd_soc_jack *jack, int count,
 }
 EXPORT_SYMBOL_GPL(snd_soc_jack_free_gpios);
 #endif	/* CONFIG_GPIOLIB */
+
+void snd_soc_jack_codec_detect(struct snd_soc_codec *codec,
+				struct snd_soc_jack *jack)
+{
+	if (codec && codec->driver && codec->driver->detect_jack)
+		codec->driver->detect_jack(codec, jack);
+}
+EXPORT_SYMBOL_GPL(snd_soc_jack_codec_detect);
-- 
1.7.9.5
