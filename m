From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: Add infoframe support for dp
	audio" to the asoc tree
Date: Mon, 15 Feb 2016 20:58:43 +0000
Message-ID: <E1aVQEF-0007sx-Uo@finisterre>
References: <1454161428-7896-10-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 21D77265351
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 21:58:51 +0100 (CET)
In-Reply-To: <1454161428-7896-10-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hdmi: Add infoframe support for dp audio

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 478f544e5b5538ccbcfdb18b4e9860a2f61ab921 Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Fri, 12 Feb 2016 07:46:09 +0530
Subject: [PATCH] ASoC: hdac_hdmi: Add infoframe support for dp audio

For DP audio support, infoframe needs to be different. Based on
get_conn_type result we pack either HDMI or DP infoframe.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 74 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 64 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index dcd1cb6..36f1200 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -253,27 +253,75 @@ hdac_hdmi_set_dip_index(struct hdac_ext_device *hdac, hda_nid_t pin_nid,
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
+	switch (conn_type) {
+	case DRM_ELD_CONN_TYPE_HDMI:
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
+		break;
+
+	case DRM_ELD_CONN_TYPE_DP:
+		memset(&dp_ai, 0, sizeof(dp_ai));
+		dp_ai.type	= 0x84;
+		dp_ai.len	= 0x1b;
+		dp_ai.ver	= 0x11 << 2;
+		dp_ai.CC02_CT47	= channels - 1;
+		dp_ai.CA	= 0;
+
+		dip = (u8 *)&dp_ai;
+		break;
+
+	default:
+		dev_err(&hdac->hdac.dev, "Invalid connection type: %d\n",
+						conn_type);
+		return -EIO;
+	}
 
 	/* stop infoframe transmission */
 	hdac_hdmi_set_dip_index(hdac, pin_nid, 0x0, 0x0);
@@ -283,9 +331,15 @@ static int hdac_hdmi_setup_audio_infoframe(struct hdac_ext_device *hdac,
 
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
2.7.0
