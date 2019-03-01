From: mac.chiang@intel.com
Subject: [PATCH] ASoC: Intel: boards: kbl_da7219_max98927: add
	dai_trigger function
Date: Sat,  2 Mar 2019 01:14:11 +0800
Message-ID: <1551460451-24540-1-git-send-email-mac.chiang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C45E9F896C0
 for <alsa-devel@alsa-project.org>; Fri,  1 Mar 2019 18:12:54 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: harshapriya.n@intel.com, pierre-louis.bossart@linux.intel.com, jenny.tc@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mac Chiang <mac.chiang@intel.com>

s0ix entry failure is root cause by default speaker/vi sense path activate all the time
that result in the audio IPs are not power gated(checked by pch_ip_power_gating_status).
Adding the run time speaker control ensure playback widgets are going to free and off
eventually. With this func, counter works in s0ix subsequently (checked by slp_s0_residency_usc).

Signed-off-by: Jenny TC <jenny.tc@intel.com>
Signed-off-by: Harshapriya.n <harshapriya.n@intel.com>
Signed-off-by: Mac Chiang <mac.chiang@intel.com>
---
 sound/soc/intel/boards/kbl_da7219_max98927.c | 50 ++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/sound/soc/intel/boards/kbl_da7219_max98927.c b/sound/soc/intel/boards/kbl_da7219_max98927.c
index 723a493..e01ca9a 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98927.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98927.c
@@ -195,8 +195,58 @@ static int kabylake_ssp0_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int kabylake_ssp0_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	int j, ret;
+
+	for (j = 0; j < rtd->num_codecs; j++) {
+		struct snd_soc_dai *codec_dai = rtd->codec_dais[j];
+		const char *name = codec_dai->component->name;
+		struct snd_soc_component *component = codec_dai->component;
+		struct snd_soc_dapm_context *dapm =
+				snd_soc_component_get_dapm(component);
+		char pin_name[20];
+
+		if (strcmp(name, MAXIM_DEV0_NAME) &&
+			strcmp(name, MAXIM_DEV1_NAME))
+			continue;
+
+		snprintf(pin_name, ARRAY_SIZE(pin_name), "%s Spk",
+			codec_dai->component->name_prefix);
+
+		switch (cmd) {
+		case SNDRV_PCM_TRIGGER_START:
+		case SNDRV_PCM_TRIGGER_RESUME:
+		case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+			ret = snd_soc_dapm_enable_pin(dapm, pin_name);
+			if (ret) {
+				dev_err(rtd->dev, "failed to enable %s: %d\n",
+				pin_name, ret);
+				return ret;
+			}
+			snd_soc_dapm_sync(dapm);
+			break;
+		case SNDRV_PCM_TRIGGER_STOP:
+		case SNDRV_PCM_TRIGGER_SUSPEND:
+		case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+			ret = snd_soc_dapm_disable_pin(dapm, pin_name);
+			if (ret) {
+				dev_err(rtd->dev, "failed to disable %s: %d\n",
+				pin_name, ret);
+				return ret;
+			}
+			snd_soc_dapm_sync(dapm);
+			break;
+		}
+	}
+
+	return 0;
+}
+
 static struct snd_soc_ops kabylake_ssp0_ops = {
 	.hw_params = kabylake_ssp0_hw_params,
+	.trigger = kabylake_ssp0_trigger,
 };
 
 static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
-- 
2.7.4
