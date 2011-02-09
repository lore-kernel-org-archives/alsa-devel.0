From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: [PATCH 1/3] ASoC: sn95031: Add jack support in the
	codec
Date: Wed,  9 Feb 2011 14:42:25 +0530
Message-ID: <1297242747-18632-2-git-send-email-vinod.koul@intel.com>
References: <1297242747-18632-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 75A83103942
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2011 10:05:10 +0100 (CET)
In-Reply-To: <1297242747-18632-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@opensource.wolfsonmicro.com, Harsha Priya <priya.harsha@intel.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

This patch adds support for jack detection and reporting in the codec
It however is not fully functional as it doesn't measure adc to figure
out what got inserted which will be added later

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>
---
 sound/soc/codecs/sn95031.c |   57 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/sn95031.h |   10 +++++++
 2 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
index 40e285d..3cd812d 100644
--- a/sound/soc/codecs/sn95031.c
+++ b/sound/soc/codecs/sn95031.c
@@ -34,6 +34,7 @@
 #include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
+#include <sound/jack.h>
 #include "sn95031.h"
 
 #define SN95031_RATES (SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_44100)
@@ -649,6 +650,62 @@ struct snd_soc_dai_driver sn95031_dais[] = {
 },
 };
 
+void disable_jack_btn(struct snd_soc_codec *codec)
+{
+	snd_soc_write(codec, SN95031_BTNCTRL2, 0x00);
+}
+EXPORT_SYMBOL_GPL(disable_jack_btn);
+
+static inline void enable_jack_btn(struct snd_soc_codec *codec)
+{
+	snd_soc_write(codec, SN95031_BTNCTRL1, 0x77);
+	snd_soc_write(codec, SN95031_BTNCTRL2, 0x01);
+}
+
+static int sn95031_get_headset_state(struct snd_soc_jack *mfld_jack)
+{
+	/* Defaulting to HEADSET for now.
+	 * will change after adding soc-jack detection apis */
+	int jack_type = SND_JACK_HEADSET;
+
+	pr_debug("jack type detected = %d\n", jack_type);
+	if (jack_type == SND_JACK_HEADSET)
+		enable_jack_btn(mfld_jack->codec);
+	return jack_type;
+}
+
+void sn95031_jack_detection(struct mfld_jack_data *jack_data)
+{
+	unsigned int status;
+	unsigned int mask = SND_JACK_BTN_0 | SND_JACK_BTN_1 | SND_JACK_HEADSET;
+
+	pr_debug("interrupt id read in sram = 0x%x\n", jack_data->intr_id);
+	if (jack_data->intr_id & 0x1) {
+		pr_debug("short_push detected\n");
+		status = SND_JACK_HEADSET | SND_JACK_BTN_0;
+	} else if (jack_data->intr_id & 0x2) {
+		pr_debug("long_push detected\n");
+		status = SND_JACK_HEADSET | SND_JACK_BTN_1;
+	} else if (jack_data->intr_id & 0x4) {
+		pr_debug("headset or headphones inserted\n");
+		status = sn95031_get_headset_state(jack_data->mfld_jack);
+	} else if (jack_data->intr_id & 0x8) {
+		pr_debug("headset or headphones removed\n");
+		status = 0;
+		disable_jack_btn(jack_data->mfld_jack->codec);
+	} else {
+		pr_err("unidentified interrupt\n");
+		return;
+	}
+
+	snd_soc_jack_report(jack_data->mfld_jack, status, mask);
+	/*button pressed and released so we send explicit button release */
+	if ((status & SND_JACK_BTN_0) | (status & SND_JACK_BTN_1))
+		snd_soc_jack_report(jack_data->mfld_jack,
+				SND_JACK_HEADSET, mask);
+}
+EXPORT_SYMBOL_GPL(sn95031_jack_detection);
+
 /* codec registration */
 static int sn95031_codec_probe(struct snd_soc_codec *codec)
 {
diff --git a/sound/soc/codecs/sn95031.h b/sound/soc/codecs/sn95031.h
index e2b17d9..3d6f9bb 100644
--- a/sound/soc/codecs/sn95031.h
+++ b/sound/soc/codecs/sn95031.h
@@ -96,4 +96,14 @@
 #define SN95031_SSR5			0x384
 #define SN95031_SSR6			0x385
 
+#define SN95031_AUDIO_GPIO_CTRL 0x070
+struct mfld_jack_data {
+	int intr_id;
+	int micbias_vol;
+	struct snd_soc_jack *mfld_jack;
+};
+
+extern void sn95031_jack_detection(struct mfld_jack_data *jack_data);
+
+extern void disable_jack_btn(struct snd_soc_codec *codec);
 #endif
-- 
1.7.2.3
