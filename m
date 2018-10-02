From: Jenny TC <jenny.tc@intel.com>
Subject: [PATCH 2/2] ASoC: dmic: Introduce mode switch delay
Date: Tue,  2 Oct 2018 11:27:31 +0530
Message-ID: <1538459851-17066-3-git-send-email-jenny.tc@intel.com>
References: <1538459851-17066-1-git-send-email-jenny.tc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 13A5926783D
 for <alsa-devel@alsa-project.org>; Tue,  2 Oct 2018 08:05:10 +0200 (CEST)
In-Reply-To: <1538459851-17066-1-git-send-email-jenny.tc@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Jairaj Arava <jairaj.arava@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Harsha Priya <harshapriya.n@intel.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Matthias Kaehlcke <mka@chromium.org>, Jenny TC <jenny.tc@intel.com>
List-Id: alsa-devel@alsa-project.org

Some DMICs require delay before stream capture to complete the mode
switching. Different modes can be power off, sleep etc. The DMIC clock
for a specified duration is needed for the DMIC to complete the mode
switching and ready for stream capture.

Signed-off-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Signed-off-by: Jairaj Arava <jairaj.arava@intel.com>
Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
---
 sound/soc/codecs/dmic.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
index ab1aa01..38d41a2 100644
--- a/sound/soc/codecs/dmic.c
+++ b/sound/soc/codecs/dmic.c
@@ -34,6 +34,29 @@
 struct dmic {
 	struct gpio_desc *gpio_en;
 	int wakeup_delay;
+	/* Delay after DMIC mode switch */
+	int modeswitch_delay_ms;
+};
+
+int dmic_daiops_trigger(struct snd_pcm_substream *substream,
+		int cmd, struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct dmic *dmic = snd_soc_component_get_drvdata(component);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_STOP:
+		if (dmic->modeswitch_delay_ms)
+			mdelay(dmic->modeswitch_delay_ms);
+
+		break;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops dmic_dai_ops = {
+	.trigger	= dmic_daiops_trigger,
 };
 
 static int dmic_aif_event(struct snd_soc_dapm_widget *w,
@@ -69,6 +92,7 @@ static int dmic_aif_event(struct snd_soc_dapm_widget *w,
 			| SNDRV_PCM_FMTBIT_S24_LE
 			| SNDRV_PCM_FMTBIT_S16_LE,
 	},
+	.ops    = &dmic_dai_ops,
 };
 
 static int dmic_component_probe(struct snd_soc_component *component)
@@ -86,6 +110,8 @@ static int dmic_component_probe(struct snd_soc_component *component)
 
 	device_property_read_u32(component->dev, "wakeup-delay-ms",
 				 &dmic->wakeup_delay);
+	device_property_read_u32(component->dev, "modeswitch_delay_ms",
+				 &dmic->modeswitch_delay_ms);
 
 	snd_soc_component_set_drvdata(component, dmic);
 
-- 
1.9.1
