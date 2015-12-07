From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v3 11/15] ASoC: hdac_hdmi: Add infoframe
	support for dp audio
Date: Tue,  8 Dec 2015 02:54:25 +0530
Message-ID: <1449523469-4395-11-git-send-email-subhransu.s.prusty@intel.com>
References: <1449523078-4311-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449523469-4395-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 8ED18265611
 for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2015 16:54:23 +0100 (CET)
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

This uses the get_conn_type API added in the previous patch to
identify the type of display connected and fills the infoframe
accordingly.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 70 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 60 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 2d971c4..32d1938 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -238,27 +238,71 @@ hdac_hdmi_set_dip_index(struct hdac_ext_device *hdac, hda_nid_t pin_nid,
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
-	u8 *dip = (u8 *)&frame;
+	struct dp_audio_infoframe dp_ai;
+	struct hdac_hdmi_priv *hdmi = hdac->private_data;
+	struct hdac_hdmi_pin *pin;
+	u8 *dip;
 	int ret;
 	int i;
+	const u8 *eld_buf;
+	u8 conn_type;
+	int channels = 2;
 
-	hdmi_audio_infoframe_init(&frame);
+	list_for_each_entry(pin, &hdmi->pin_list, head) {
+		if (pin->nid == pin_nid)
+			break;
+	}
 
-	/* Default stereo for now */
-	frame.channels = 2;
+	eld_buf = pin->eld.eld_buffer;
+	conn_type = drm_eld_get_conn_type(eld_buf);
 
 	/* setup channel count */
 	snd_hdac_codec_write(&hdac->hdac, cvt_nid, 0,
-			    AC_VERB_SET_CVT_CHAN_COUNT, frame.channels - 1);
+			    AC_VERB_SET_CVT_CHAN_COUNT, channels - 1);
 
-	ret = hdmi_audio_infoframe_pack(&frame, buffer, sizeof(buffer));
-	if (ret < 0)
-		return ret;
+	if (conn_type == DRM_ELD_CONN_TYPE_HDMI) {
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
+	} else if (conn_type == DRM_ELD_CONN_TYPE_DP) {
+		memset(&dp_ai, 0, sizeof(dp_ai));
+		dp_ai.type	= 0x84;
+		dp_ai.len	= 0x1b;
+		dp_ai.ver	= 0x11 << 2;
+		dp_ai.CC02_CT47	= channels - 1;
+		dp_ai.CA	= 0;
+
+		dip = (u8 *)&dp_ai;
+	} else {
+		dev_err(&hdac->hdac.dev, "Invalid connection type: %d\n",
+						conn_type);
+		return -EIO;
+	}
 
 	/* stop infoframe transmission */
 	hdac_hdmi_set_dip_index(hdac, pin_nid, 0x0, 0x0);
@@ -268,9 +312,15 @@ static int hdac_hdmi_setup_audio_infoframe(struct hdac_ext_device *hdac,
 
 	/*  Fill infoframe. Index auto-incremented */
 	hdac_hdmi_set_dip_index(hdac, pin_nid, 0x0, 0x0);
-	for (i = 0; i < sizeof(frame); i++)
-		snd_hdac_codec_write(&hdac->hdac, pin_nid, 0,
+	if (conn_type == DRM_ELD_CONN_TYPE_HDMI) {
+		for (i = 0; i < sizeof(frame); i++)
+			snd_hdac_codec_write(&hdac->hdac, pin_nid, 0,
 				AC_VERB_SET_HDMI_DIP_DATA, dip[i]);
+	} else {
+		for (i = 0; i < sizeof(dp_ai); i++)
+			snd_hdac_codec_write(&hdac->hdac, pin_nid, 0,
+				AC_VERB_SET_HDMI_DIP_DATA, dip[i]);
+	}
 
 	/* Start infoframe */
 	hdac_hdmi_set_dip_index(hdac, pin_nid, 0x0, 0x0);
-- 
1.9.1
