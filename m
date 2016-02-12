From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v6 02/15] ASoC: hdac_hdmi: Apply constraints
	based on ELD
Date: Fri, 12 Feb 2016 07:46:02 +0530
Message-ID: <1455243375-16067-3-git-send-email-subhransu.s.prusty@intel.com>
References: <1455243375-16067-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 98F6F2659D3
 for <alsa-devel@alsa-project.org>; Fri, 12 Feb 2016 03:15:17 +0100 (CET)
In-Reply-To: <1455243375-16067-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

Uses the drm ELD core framework to apply rate and channel

Also compute the format to be set based on ELD.

Even though the channel constraint is based on ELD, infoframe
is set with stereo only. Multichannel support will be added
later.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/Kconfig     |  1 +
 sound/soc/codecs/hdac_hdmi.c | 51 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 4383966..a817830 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -493,6 +493,7 @@ config SND_SOC_GTM601
 config SND_SOC_HDAC_HDMI
 	tristate
 	select SND_HDA_EXT_CORE
+	select SND_PCM_ELD
 	select HDMI
 
 config SND_SOC_ICS43432
diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index fff225d..d22fa6b 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -22,10 +22,12 @@
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/hdmi.h>
+#include <drm/drm_edid.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/hdaudio_ext.h>
 #include <sound/hda_i915.h>
+#include <sound/pcm_drm_eld.h>
 #include "../../hda/local.h"
 
 #define AMP_OUT_MUTE		0xb080
@@ -90,6 +92,45 @@ static inline struct hdac_ext_device *to_hda_ext_device(struct device *dev)
 	return to_ehdac_device(hdac);
 }
 
+static unsigned int sad_format(const u8 *sad)
+{
+	return ((sad[0] >> 0x3) & 0x1f);
+}
+
+static unsigned int sad_sample_bits_lpcm(const u8 *sad)
+{
+	return (sad[2] & 7);
+}
+
+static int hdac_hdmi_eld_limit_formats(struct snd_pcm_runtime *runtime,
+						void *eld)
+{
+	u64 formats = SNDRV_PCM_FMTBIT_S16;
+	int i;
+	const u8 *sad, *eld_buf = eld;
+
+	sad = drm_eld_sad(eld_buf);
+	if (!sad)
+		goto format_constraint;
+
+	for (i = drm_eld_sad_count(eld_buf); i > 0; i--, sad += 3) {
+		if (sad_format(sad) == 1) { /* AUDIO_CODING_TYPE_LPCM */
+
+			/*
+			 * the controller support 20 and 24 bits in 32 bit
+			 * container so we set S32
+			 */
+			if (sad_sample_bits_lpcm(sad) & 0x6)
+				formats |= SNDRV_PCM_FMTBIT_S32;
+		}
+	}
+
+format_constraint:
+	return snd_pcm_hw_constraint_mask64(runtime, SNDRV_PCM_HW_PARAM_FORMAT,
+				formats);
+
+}
+
  /* HDMI ELD routines */
 static unsigned int hdac_hdmi_get_eld_data(struct hdac_device *codec,
 				hda_nid_t nid, int byte_index)
@@ -334,6 +375,7 @@ static int hdac_hdmi_pcm_open(struct snd_pcm_substream *substream,
 	struct hdac_ext_device *hdac = snd_soc_dai_get_drvdata(dai);
 	struct hdac_hdmi_priv *hdmi = hdac->private_data;
 	struct hdac_hdmi_dai_pin_map *dai_map;
+	int ret;
 
 	if (dai->id > 0) {
 		dev_err(&hdac->hdac.dev, "Only one dai supported as of now\n");
@@ -358,10 +400,13 @@ static int hdac_hdmi_pcm_open(struct snd_pcm_substream *substream,
 	snd_hdac_codec_write(&hdac->hdac, dai_map->pin->nid, 0,
 			AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
 
-	snd_pcm_hw_constraint_step(substream->runtime, 0,
-				   SNDRV_PCM_HW_PARAM_CHANNELS, 2);
+	ret = hdac_hdmi_eld_limit_formats(substream->runtime,
+				dai_map->pin->eld.eld_buffer);
+	if (ret < 0)
+		return ret;
 
-	return 0;
+	return snd_pcm_hw_constraint_eld(substream->runtime,
+				dai_map->pin->eld.eld_buffer);
 }
 
 static void hdac_hdmi_pcm_close(struct snd_pcm_substream *substream,
-- 
1.9.1
