From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 13/15] ASoC: hdac_hdmi: Add infoframe support
	for dp audio
Date: Tue,  1 Dec 2015 23:17:09 +0530
Message-ID: <1448992031-8271-13-git-send-email-subhransu.s.prusty@intel.com>
References: <1448991749-8091-1-git-send-email-subhransu.s.prusty@intel.com>
 <1448992031-8271-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 72621265D2C
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 13:16:57 +0100 (CET)
In-Reply-To: <1448992031-8271-1-git-send-email-subhransu.s.prusty@intel.com>
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

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 70 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 60 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 4cb4262..68e310e 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/hdmi.h>
+#include <drm/drm_edid.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/hdaudio_ext.h>
@@ -126,27 +127,70 @@ hdac_hdmi_set_dip_index(struct hdac_ext_device *hdac, hda_nid_t pin_nid,
 				AC_VERB_SET_HDMI_DIP_INDEX, val);
 }
 
+struct dp_audio_infoframe {
+	u8 type; /* 0x84 */
+	u8 len;  /* 0x1b */
+	u8 ver;  /* 0x11 << 2 */
+
+	u8 CC02_CT47;	/* match with HDMI infoframe from this on */
+	u8 SS01_SF24;
+	u8 CXT04;
+	u8 CA;
+	u8 LFEPBL01_LSV36_DM_INH7;
+};
+
 static int hdac_hdmi_setup_audio_infoframe(struct hdac_ext_device *hdac,
 				hda_nid_t cvt_nid, hda_nid_t pin_nid)
 {
 	uint8_t buffer[HDMI_INFOFRAME_HEADER_SIZE + HDMI_AUDIO_INFOFRAME_SIZE];
 	struct hdmi_audio_infoframe frame;
+	struct dp_audio_infoframe dp_ai;
+	struct hdac_hdmi_priv *hdmi = hdac->private_data;
+	struct hdac_hdmi_pin *pin;
 	u8 *dip = (u8 *)&frame;
 	int ret;
-	int i;
+	int i, conn_type;
+	const u8 *eld_buf;
+	int channels = 2;
 
-	hdmi_audio_infoframe_init(&frame);
+	list_for_each_entry(pin, &hdmi->pin_list, head) {
+		if (pin->nid == pin_nid)
+			break;
+	}
+
+	eld_buf = pin->eld.eld_buffer;
+	conn_type = drm_eld_get_conn_type(eld_buf);
 
-	/* Default stereo for now */
-	frame.channels = 2;
+	/* 0 is hdmi and 1 is DP */
+	if (conn_type > 1)
+		return -EIO;
 
 	/* setup channel count */
 	snd_hdac_codec_write(&hdac->hdac, cvt_nid, 0,
-			    AC_VERB_SET_CVT_CHAN_COUNT, frame.channels - 1);
+			    AC_VERB_SET_CVT_CHAN_COUNT, channels - 1);
 
-	ret = hdmi_audio_infoframe_pack(&frame, buffer, sizeof(buffer));
-	if (ret < 0)
-		return ret;
+	if (conn_type == 0) {
+		hdmi_audio_infoframe_init(&frame);
+
+		/* Default stereo for now */
+		frame.channels = channels;
+
+		ret = hdmi_audio_infoframe_pack(&frame, buffer, sizeof(buffer));
+		if (ret < 0)
+			return ret;
+
+		dip = (u8 *)&frame;
+
+	} else {
+		memset(&dp_ai, 0, sizeof(dp_ai));
+		dp_ai.type	= 0x84;
+		dp_ai.len	= 0x1b;
+		dp_ai.ver	= 0x11 << 2;
+		dp_ai.CC02_CT47	= channels - 1;
+		dp_ai.CA	= 0;
+
+		dip = (u8 *)&dip;
+	}
 
 	/* stop infoframe transmission */
 	hdac_hdmi_set_dip_index(hdac, pin_nid, 0x0, 0x0);
@@ -156,9 +200,15 @@ static int hdac_hdmi_setup_audio_infoframe(struct hdac_ext_device *hdac,
 
 	/*  Fill infoframe. Index auto-incremented */
 	hdac_hdmi_set_dip_index(hdac, pin_nid, 0x0, 0x0);
-	for (i = 0; i < sizeof(frame); i++)
-		snd_hdac_codec_write(&hdac->hdac, pin_nid, 0,
+	if (conn_type == 0) {
+		for (i = 0; i < sizeof(frame); i++)
+			snd_hdac_codec_write(&hdac->hdac, pin_nid, 0,
+				AC_VERB_SET_HDMI_DIP_DATA, dip[i]);
+	} else {
+		for (i = 0; i < sizeof(dp_ai); i++)
+			snd_hdac_codec_write(&hdac->hdac, pin_nid, 0,
 				AC_VERB_SET_HDMI_DIP_DATA, dip[i]);
+	}
 
 	/* Start infoframe */
 	hdac_hdmi_set_dip_index(hdac, pin_nid, 0x0, 0x0);
-- 
1.9.1
