From: Xing Zheng <zhengxing@rock-chips.com>
Subject: [PATCH] ASoC: da7219: make sure the valid event when startup
Date: Fri,  9 Sep 2016 22:01:35 +0800
Message-ID: <1473429695-12604-1-git-send-email-zhengxing@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-rockchip@lists.infradead.org, Adam.Thomson.Opensource@diasemi.com
Cc: cychiang@google.com, heiko@sntech.de, smbarber@google.com, hychao@google.com, Xing Zheng <zhengxing@rock-chips.com>, Support Opensource <support.opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

We need to ensure the master bias and jack detection to be enabled
before reporting event at the da7219_aad_irq_thread. Otherwise, we
may acquire the incorrect the unplug event when the DUT startup
with a plugged headphone.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

 sound/soc/codecs/da7219-aad.c | 7 +++++++
 sound/soc/codecs/da7219-aad.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index 4e369a1..cef17c0d 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -38,6 +38,7 @@ void da7219_aad_jack_det(struct snd_soc_codec *codec, struct snd_soc_jack *jack)
 
 	da7219->aad->jack = jack;
 	da7219->aad->jack_inserted = false;
+	da7219->aad->accdet_en = false;
 
 	/* Send an initial empty report */
 	snd_soc_jack_report(jack, 0, DA7219_AAD_REPORT_ALL_MASK);
@@ -46,6 +47,8 @@ void da7219_aad_jack_det(struct snd_soc_codec *codec, struct snd_soc_jack *jack)
 	snd_soc_update_bits(codec, DA7219_ACCDET_CONFIG_1,
 			    DA7219_ACCDET_EN_MASK,
 			    (jack ? DA7219_ACCDET_EN_MASK : 0));
+
+	da7219->aad->accdet_en = true;
 }
 EXPORT_SYMBOL_GPL(da7219_aad_jack_det);
 
@@ -293,6 +296,10 @@ static irqreturn_t da7219_aad_irq_thread(int irq, void *data)
 	u8 statusa;
 	int i, report = 0, mask = 0;
 
+	/* Ensure the master bias to be enabled */
+	if (!da7219_aad->accdet_en)
+		return IRQ_NONE;
+
 	/* Read current IRQ events */
 	regmap_bulk_read(da7219->regmap, DA7219_ACCDET_IRQ_EVENT_A,
 			 events, DA7219_AAD_IRQ_REG_MAX);
diff --git a/sound/soc/codecs/da7219-aad.h b/sound/soc/codecs/da7219-aad.h
index 4fccf67..5641965 100644
--- a/sound/soc/codecs/da7219-aad.h
+++ b/sound/soc/codecs/da7219-aad.h
@@ -200,6 +200,7 @@ struct da7219_aad_priv {
 
 	struct snd_soc_jack *jack;
 	bool jack_inserted;
+	bool accdet_en;
 };
 
 /* AAD control */
-- 
1.9.1
