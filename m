From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v4 5/6] ASoC: hdac_hdmi: Setup and start
	infoframe
Date: Tue, 10 Nov 2015 18:42:09 +0530
Message-ID: <1447161130-24889-6-git-send-email-vinod.koul@intel.com>
References: <1447161130-24889-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 089AB26519F
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2015 14:08:59 +0100 (CET)
In-Reply-To: <1447161130-24889-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

This patch uses hdmi framework in video to fill audio infoframe.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 61 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index f96bd2fb634b..c02e6d3a6314 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -21,6 +21,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
+#include <linux/hdmi.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/hdaudio_ext.h>
@@ -89,6 +90,60 @@ static int hdac_hdmi_setup_stream(struct hdac_ext_device *hdac,
 	return 0;
 }
 
+static void
+hdac_hdmi_set_dip_index(struct hdac_ext_device *hdac, hda_nid_t pin_nid,
+				int packet_index, int byte_index)
+{
+	int val;
+
+	val = (packet_index << 5) | (byte_index & 0x1f);
+
+	snd_hdac_codec_write(&hdac->hdac, pin_nid, 0,
+				AC_VERB_SET_HDMI_DIP_INDEX, val);
+}
+
+static int hdac_hdmi_setup_audio_infoframe(struct hdac_ext_device *hdac,
+				hda_nid_t cvt_nid, hda_nid_t pin_nid)
+{
+	uint8_t buffer[HDMI_INFOFRAME_HEADER_SIZE + HDMI_AUDIO_INFOFRAME_SIZE];
+	struct hdmi_audio_infoframe frame;
+	u8 *dip = (u8 *)&frame;
+	int ret;
+	int i;
+
+	hdmi_audio_infoframe_init(&frame);
+
+	/* Default stereo for now */
+	frame.channels = 2;
+
+	/* setup channel count */
+	snd_hdac_codec_write(&hdac->hdac, cvt_nid, 0,
+			    AC_VERB_SET_CVT_CHAN_COUNT, frame.channels - 1);
+
+	ret = hdmi_audio_infoframe_pack(&frame, buffer, sizeof(buffer));
+	if (ret < 0)
+		return ret;
+
+	/* stop infoframe transmission */
+	hdac_hdmi_set_dip_index(hdac, pin_nid, 0x0, 0x0);
+	snd_hdac_codec_write(&hdac->hdac, pin_nid, 0,
+			AC_VERB_SET_HDMI_DIP_XMIT, AC_DIPXMIT_DISABLE);
+
+
+	/*  Fill infoframe. Index auto-incremented */
+	hdac_hdmi_set_dip_index(hdac, pin_nid, 0x0, 0x0);
+	for (i = 0; i < sizeof(frame); i++)
+		snd_hdac_codec_write(&hdac->hdac, pin_nid, 0,
+				AC_VERB_SET_HDMI_DIP_DATA, dip[i]);
+
+	/* Start infoframe */
+	hdac_hdmi_set_dip_index(hdac, pin_nid, 0x0, 0x0);
+	snd_hdac_codec_write(&hdac->hdac, pin_nid, 0,
+			AC_VERB_SET_HDMI_DIP_XMIT, AC_DIPXMIT_BEST);
+
+	return 0;
+}
+
 static void hdac_hdmi_set_power_state(struct hdac_ext_device *edev,
 		struct hdac_hdmi_dai_pin_map *dai_map, unsigned int pwr_state)
 {
@@ -110,6 +165,7 @@ static int hdac_hdmi_playback_prepare(struct snd_pcm_substream *substream,
 	struct hdac_hdmi_priv *hdmi = hdac->private_data;
 	struct hdac_hdmi_dai_pin_map *dai_map;
 	struct hdac_ext_dma_params *dd;
+	int ret;
 
 	if (dai->id > 0) {
 		dev_err(&hdac->hdac.dev, "Only one dai supported as of now\n");
@@ -122,6 +178,11 @@ static int hdac_hdmi_playback_prepare(struct snd_pcm_substream *substream,
 	dev_dbg(&hdac->hdac.dev, "stream tag from cpu dai %d format in cvt 0x%x\n",
 			dd->stream_tag,	dd->format);
 
+	ret = hdac_hdmi_setup_audio_infoframe(hdac, dai_map->cvt.nid,
+						dai_map->pin.nid);
+	if (ret < 0)
+		return ret;
+
 	return hdac_hdmi_setup_stream(hdac, dai_map->cvt.nid, dai_map->pin.nid,
 					dd->stream_tag, dd->format);
 }
-- 
1.9.1
