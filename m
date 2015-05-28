From: yang.a.fang@intel.com
Subject: [PATCH v2 3/3] ASoC: Intel: fixed TI button detection
Date: Thu, 28 May 2015 11:00:48 -0700
Message-ID: <1432836048-102175-3-git-send-email-yang.a.fang@intel.com>
References: <1432684686-14460-1-git-send-email-yang.a.fang@intel.com>
 <1432836048-102175-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id ED0AA260508
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2015 20:01:42 +0200 (CEST)
In-Reply-To: <1432836048-102175-1-git-send-email-yang.a.fang@intel.com>
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
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, vinod.koul@intel.com, praveen.k.jain@intel.com, denny.iriawan@intel.com, "Fang,
 Yang A" <yang.a.fang@intel.com>, sathyanarayana.nujella@intel.com, kevin.strasser@linux.intel.com, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org

From: "Fang, Yang A" <yang.a.fang@intel.com>

In order to make TI button interrupt working max98090 codec
Need provide mic bias all the time as long as mic is present
so SHDN and micbias pin are forced on.we also need set max98090
codec bias close or lower than TI bias.We set them in bios/coreboot
kernel reads them from device property

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c |   40 ++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index 1be0794..3e5842d 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -101,6 +101,43 @@ static int cht_aif1_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int cht_ti_jack_event(struct notifier_block *nb,
+		unsigned long event, void *data)
+{
+
+	struct snd_soc_jack *jack = (struct snd_soc_jack *)data;
+	struct snd_soc_dai *codec_dai = jack->card->rtd->codec_dai;
+	struct snd_soc_codec *codec = codec_dai->codec;
+	int pin_status;
+
+	if (event & SND_JACK_MICROPHONE) {
+
+		pin_status = snd_soc_dapm_get_pin_status(&codec->dapm, "SHDN");
+		if (!pin_status)
+			snd_soc_dapm_force_enable_pin(&codec->dapm, "SHDN");
+
+		snd_soc_dapm_force_enable_pin(&codec->dapm, "MICBIAS");
+		snd_soc_dapm_sync(&codec->dapm);
+	} else {
+
+		snd_soc_dapm_disable_pin(&codec->dapm, "MICBIAS");
+		snd_soc_dapm_sync(&codec->dapm);
+		/**
+		* SHDN is max980090 shutdown pin we can not disable
+		* it in case we are in the middle of playabck or record
+		* we mark it unlock only so dapm will take care of it
+		* next time
+		*/
+		snd_soc_dapm_disable_pin_unlocked(&codec->dapm, "SHDN");
+	}
+
+	return 0;
+}
+
+static struct notifier_block cht_jack_nb = {
+	.notifier_call = cht_ti_jack_event,
+};
+
 static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 {
 	int ret;
@@ -130,6 +167,9 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 		return ret;
 	}
 
+	if (ctx->ts3a227e_present)
+		snd_soc_jack_notifier_register(jack, &cht_jack_nb);
+
 	return ret;
 }
 
-- 
1.7.9.5
