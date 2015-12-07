From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v3 14/15] ASoC: hdac_hdmi: Add jack reporting
	for user space
Date: Tue,  8 Dec 2015 02:54:28 +0530
Message-ID: <1449523469-4395-14-git-send-email-subhransu.s.prusty@intel.com>
References: <1449523078-4311-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449523469-4395-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 2151F2659BF
 for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2015 16:54:31 +0100 (CET)
In-Reply-To: <1449523469-4395-1-git-send-email-subhransu.s.prusty@intel.com>
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

User space also need be notified of HDMI hotplug notification so
that it can select the appropriate device to route audio.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 008a29f..cce2af0 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -24,6 +24,7 @@
 #include <linux/hdmi.h>
 #include <drm/drm_edid.h>
 #include <sound/pcm_params.h>
+#include <sound/jack.h>
 #include <sound/soc.h>
 #include <sound/hdaudio_ext.h>
 #include <sound/hda_i915.h>
@@ -73,6 +74,7 @@ struct hdac_hdmi_pin {
 	struct hdac_ext_device *edev;
 	int repoll_count;
 	struct delayed_work work;
+	struct snd_jack *jack;
 };
 
 struct hdac_hdmi_dai_pin_map {
@@ -905,6 +907,7 @@ static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin, int repoll)
 	pin->eld.eld_valid = !!(val & AC_PINSENSE_ELDV);
 
 	if (!pin->eld.monitor_present || !pin->eld.eld_valid) {
+		snd_jack_report(pin->jack, 0);
 		dev_info(&edev->hdac.dev, "%s: disconnect or eld_invalid\n",
 				__func__);
 		goto put_hdac_device;
@@ -915,6 +918,7 @@ static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin, int repoll)
 		if (hdac_hdmi_get_eld(&edev->hdac, pin->nid,
 				pin->eld.eld_buffer,
 				&pin->eld.eld_size) == 0) {
+			snd_jack_report(pin->jack, SND_JACK_AVOUT);
 			print_hex_dump_bytes("Eld: ", DUMP_PREFIX_OFFSET,
 					pin->eld.eld_buffer, pin->eld.eld_size);
 		} else {
@@ -1173,6 +1177,7 @@ static int hdmi_codec_probe(struct snd_soc_codec *codec)
 	struct snd_soc_dapm_context *dapm =
 		snd_soc_component_get_dapm(&codec->component);
 	struct hdac_hdmi_pin *pin;
+	char jack_name[NAME_SIZE];
 	int ret;
 
 	edev->scodec = codec;
@@ -1189,8 +1194,12 @@ static int hdmi_codec_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	list_for_each_entry(pin, &hdmi->pin_list, head)
+	list_for_each_entry(pin, &hdmi->pin_list, head) {
+		sprintf(jack_name, "HDMI/DP, Pin=%d Jack", pin->nid);
+		snd_jack_new(dapm->card->snd_card, jack_name, SND_JACK_AVOUT,
+				&pin->jack, true, false);
 		hdac_hdmi_present_sense(pin, 1);
+	}
 
 	/* Imp: Store the card pointer in hda_codec */
 	edev->card = dapm->card->snd_card;
-- 
1.9.1
