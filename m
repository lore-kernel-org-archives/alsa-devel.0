From: Jenny TC <jenny.tc@intel.com>
Subject: [PATCH 1/2] ASoC: dmic: introduce mode switch delay
Date: Wed, 28 Nov 2018 12:22:45 +0530
Message-ID: <1543387966-2708-2-git-send-email-jenny.tc@intel.com>
References: <1543387966-2708-1-git-send-email-jenny.tc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A3DC267AF1
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2018 07:52:58 +0100 (CET)
In-Reply-To: <1543387966-2708-1-git-send-email-jenny.tc@intel.com>
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
Cc: Jairaj Arava <jairaj.arava@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Harshapriya N <harshapriya.n@intel.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Matthias Kaehlcke <mka@chromium.org>, Jenny TC <jenny.tc@intel.com>
List-Id: alsa-devel@alsa-project.org

On startup, applications such as PulseAudio or CRAS enable playback or
capture on all PCM devices to verify that configurations are correct,
and close them immediately. For DMICs, this can result in the clock
being turned off very quickly, which may not compatible with internal
state machine transition requirements.

This patch add a mode-switch delay which will prevent the clock from
being turned off without complying with manufacturer timing
specifications. While the DMIC clock may be controlled at a lower level,
be it with hardware or firmware, applying the delay during the
STOP_TRIGGER phase ensures that there is no race condition, e.g. with
the hardware/firmware turning off the clock earlier

Signed-off-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Signed-off-by: Jairaj Arava <jairaj.arava@intel.com>
Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
Signed-off-by: Jenny TC <jenny.tc@intel.com>
---
 Documentation/devicetree/bindings/sound/dmic.txt |  2 ++
 sound/soc/codecs/dmic.c                          | 35 ++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/dmic.txt b/Documentation/devicetree/bindings/sound/dmic.txt
index e957b41..32e8710 100644
--- a/Documentation/devicetree/bindings/sound/dmic.txt
+++ b/Documentation/devicetree/bindings/sound/dmic.txt
@@ -9,6 +9,7 @@ Optional properties:
 	- dmicen-gpios: GPIO specifier for dmic to control start and stop
 	- num-channels: Number of microphones on this DAI
 	- wakeup-delay-ms: Delay (in ms) after enabling the DMIC
+	- modeswitch-delay-ms: Delay (in ms) to complete DMIC mode switch
 
 Example node:
 
@@ -17,4 +18,5 @@ Example node:
 		dmicen-gpios = <&gpio4 3 GPIO_ACTIVE_HIGH>;
 		num-channels = <1>;
 		wakeup-delay-ms <50>;
+		modeswitch-delay-ms <35>;
 	};
diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
index 8c4926d..2ee7690 100644
--- a/sound/soc/codecs/dmic.c
+++ b/sound/soc/codecs/dmic.c
@@ -30,9 +30,36 @@
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 
+#define MAX_MODESWITCH_DELAY 70
+static int modeswitch_delay;
+module_param(modeswitch_delay, uint, 0644);
+
 struct dmic {
 	struct gpio_desc *gpio_en;
 	int wakeup_delay;
+	/* Delay after DMIC mode switch */
+	int modeswitch_delay;
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
+		if (dmic->modeswitch_delay)
+			mdelay(dmic->modeswitch_delay);
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
@@ -68,6 +95,7 @@ static int dmic_aif_event(struct snd_soc_dapm_widget *w,
 			| SNDRV_PCM_FMTBIT_S24_LE
 			| SNDRV_PCM_FMTBIT_S16_LE,
 	},
+	.ops    = &dmic_dai_ops,
 };
 
 static int dmic_component_probe(struct snd_soc_component *component)
@@ -85,6 +113,13 @@ static int dmic_component_probe(struct snd_soc_component *component)
 
 	device_property_read_u32(component->dev, "wakeup-delay-ms",
 				 &dmic->wakeup_delay);
+	device_property_read_u32(component->dev, "modeswitch-delay-ms",
+				 &dmic->modeswitch_delay);
+	if (modeswitch_delay)
+		dmic->modeswitch_delay  = modeswitch_delay;
+
+	if (dmic->modeswitch_delay > MAX_MODESWITCH_DELAY)
+		dmic->modeswitch_delay = MAX_MODESWITCH_DELAY;
 
 	snd_soc_component_set_drvdata(component, dmic);
 
-- 
1.9.1
