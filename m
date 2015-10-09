From: Vinod Koul <vinod.koul@intel.com>
Subject: [RFC 4/4] ASoC: hdac_hdmi: Setup and start infoframe
Date: Fri,  9 Oct 2015 13:28:49 +0100
Message-ID: <1444393729-19745-5-git-send-email-vinod.koul@intel.com>
References: <1444393729-19745-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id CDB51265173
 for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2015 14:34:02 +0200 (CEST)
In-Reply-To: <1444393729-19745-1-git-send-email-vinod.koul@intel.com>
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
Cc: Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, tiwai@suse.de, Arnaud Pouliquen <arnaud.pouliquen@st.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Yakir Yang <ykk@rock-chips.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 133 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 309d84122c72..2aca9ce6f423 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -63,6 +63,39 @@ struct hdac_hdmi_priv {
 	struct hdac_hdmi_dai_pin_map dai_map[3];
 };
 
+struct hdmi_audio_infoframe {
+	u8 type; /* 0x84 */
+	u8 ver;  /* 0x01 */
+	u8 len;  /* 0x0a */
+
+	u8 checksum;
+
+	u8 CC02_CT47;	/* CC in bits 0:2, CT in 4:7 */
+	u8 SS01_SF24;
+	u8 CXT04;
+	u8 CA;
+	u8 LFEPBL01_LSV36_DM_INH7;
+};
+
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
+union audio_infoframe {
+	struct hdmi_audio_infoframe hdmi;
+	struct dp_audio_infoframe dp;
+	u8 bytes[0];
+};
+
+
 static inline struct hdac_ext_device *to_hda_ext_device(struct device *dev)
 {
 	struct hdac_device *hdac = container_of(dev, struct hdac_device, dev);
@@ -85,6 +118,104 @@ static int hdac_hdmi_setup_stream(struct hdac_ext_device *hdac, hda_nid_t cvt_ni
 	return 0;
 }
 
+static void hdac_hdmi_set_dip_index(struct hdac_ext_device *hdac, hda_nid_t pin_nid,
+				int packet_index, int byte_index)
+{
+	int val;
+
+	val = (packet_index << 5) | (byte_index & 0x1f);
+
+	snd_hdac_codec_write(&hdac->hdac, pin_nid, 0, AC_VERB_SET_HDMI_DIP_INDEX, val);
+}
+
+static void hdac_hdmi_write_dip_byte(struct hdac_ext_device *hdac, hda_nid_t pin_nid,
+				unsigned char val)
+{
+	snd_hdac_codec_write(&hdac->hdac, pin_nid, 0, AC_VERB_SET_HDMI_DIP_DATA, val);
+}
+
+static void hdac_hdmi_checksum_audio_infoframe(struct hdmi_audio_infoframe *hdmi_ai)
+{
+	u8 *bytes = (u8 *)hdmi_ai;
+	u8 sum = 0;
+	int i;
+
+	hdmi_ai->checksum = 0;
+
+	for (i = 0; i < sizeof(*hdmi_ai); i++)
+		sum += bytes[i];
+
+	hdmi_ai->checksum = -sum;
+}
+
+static void hdac_hdmi_fill_audio_infoframe(struct hdac_ext_device *hdac,
+				      hda_nid_t pin_nid,
+				      u8 *dip, int size)
+{
+	int i;
+
+	hdac_hdmi_set_dip_index(hdac, pin_nid, 0x0, 0x0);
+	for (i = 0; i < size; i++)
+		hdac_hdmi_write_dip_byte(hdac, pin_nid, dip[i]);
+}
+
+/*
+ * Enable Audio InfoFrame Transmission
+ */
+static void hdac_hdmi_start_infoframe_trans(struct hdac_ext_device *hdac,
+				       hda_nid_t pin_nid)
+{
+	hdac_hdmi_set_dip_index(hdac, pin_nid, 0x0, 0x0);
+	snd_hdac_codec_write(&hdac->hdac, pin_nid, 0, AC_VERB_SET_HDMI_DIP_XMIT,
+						AC_DIPXMIT_BEST);
+}
+
+/*
+ * Disable Audio InfoFrame Transmission
+ */
+static void hdac_hdmi_stop_infoframe_trans(struct hdac_ext_device *hdac,
+				      hda_nid_t pin_nid)
+{
+	hdac_hdmi_set_dip_index(hdac, pin_nid, 0x0, 0x0);
+	snd_hdac_codec_write(&hdac->hdac, pin_nid, 0, AC_VERB_SET_HDMI_DIP_XMIT,
+						AC_DIPXMIT_DISABLE);
+}
+
+static void hdac_hdmi_setup_audio_infoframe(struct hdac_ext_device *hdac,
+		hda_nid_t cvt_nid, hda_nid_t pin_nid)
+{
+	union audio_infoframe ai;
+	int ca = 0;	/* Default stereo for now */
+	int channels = 2;
+	struct hdmi_audio_infoframe *hdmi_ai = &ai.hdmi;
+
+	/* setup channel count */
+	snd_hdac_codec_write(&hdac->hdac, cvt_nid, 0,
+			    AC_VERB_SET_CVT_CHAN_COUNT, channels - 1);
+
+	/* Set up infoframe */
+	memset(&ai, 0, sizeof(ai));
+
+	/* Only HDMI for now */
+	hdmi_ai->type		= 0x84;
+	hdmi_ai->ver		= 0x01;
+	hdmi_ai->len		= 0x0a;
+	hdmi_ai->CC02_CT47	= channels - 1;
+	hdmi_ai->CA		= ca;
+	hdac_hdmi_checksum_audio_infoframe(hdmi_ai);
+
+	/*
+	 * sizeof(ai) is used instead of sizeof(*hdmi_ai) or
+	 * sizeof(*dp_ai) to avoid partial match/update problems when
+	 * the user switches between HDMI/DP monitors.
+	 */
+	dev_dbg(&hdac->hdac.dev, "hdmi_pin_setup_infoframe: pin=%d channels=%d ca=0x%02x\n",
+			    pin_nid, channels, ca);
+	hdac_hdmi_stop_infoframe_trans(hdac, pin_nid);
+	hdac_hdmi_fill_audio_infoframe(hdac, pin_nid, ai.bytes, sizeof(ai));
+	hdac_hdmi_start_infoframe_trans(hdac, pin_nid);
+}
+
 static void hdac_hdmi_set_power_state(struct hdac_ext_device *edev,
 		struct hdac_hdmi_dai_pin_map *dai_map, unsigned int pwr_state)
 {
@@ -118,6 +249,8 @@ static int hdac_hdmi_playback_prepare(struct snd_pcm_substream *substream,
 	dev_dbg(&hdac->hdac.dev, "stream tag from cpu dai %d format in cvt 0x%x\n",
 			dd->stream_tag,	dd->format);
 
+	hdac_hdmi_setup_audio_infoframe(hdac, dai_map->cvt.nid, dai_map->pin.nid);
+
 	return hdac_hdmi_setup_stream(hdac, dai_map->cvt.nid, dai_map->pin.nid,
 					dd->stream_tag, dd->format);
 }
-- 
2.4.3
