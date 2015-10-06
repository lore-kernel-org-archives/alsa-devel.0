From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 07/18] ALSA: hda: move hda_proc to use hdac
	helpers
Date: Tue,  6 Oct 2015 16:07:44 +0100
Message-ID: <1444144075-28963-8-git-send-email-vinod.koul@intel.com>
References: <1444144075-28963-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 85E8A26574E
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 17:08:46 +0200 (CEST)
In-Reply-To: <1444144075-28963-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

Move hda_proc to use newly moved snd_hdac_read/write_codec() and
snd_hdac_check_power_state APIs.

This was done using coccinelle script

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/pci/hda/hda_proc.c | 80 +++++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 38 deletions(-)

diff --git a/sound/pci/hda/hda_proc.c b/sound/pci/hda/hda_proc.c
index 033aa84365b9..297e4501fa4c 100644
--- a/sound/pci/hda/hda_proc.c
+++ b/sound/pci/hda/hda_proc.c
@@ -157,14 +157,14 @@ static void print_amp_vals(struct snd_info_buffer *buffer,
 	dir = dir == HDA_OUTPUT ? AC_AMP_GET_OUTPUT : AC_AMP_GET_INPUT;
 	for (i = 0; i < indices; i++) {
 		snd_iprintf(buffer, " [");
-		val = snd_hda_codec_read(codec, nid, 0,
-					 AC_VERB_GET_AMP_GAIN_MUTE,
-					 AC_AMP_GET_LEFT | dir | i);
+		val = snd_hdac_codec_read(&codec->core, nid, 0,
+					  AC_VERB_GET_AMP_GAIN_MUTE,
+					  AC_AMP_GET_LEFT | dir | i);
 		snd_iprintf(buffer, "0x%02x", val);
 		if (stereo) {
-			val = snd_hda_codec_read(codec, nid, 0,
-						 AC_VERB_GET_AMP_GAIN_MUTE,
-						 AC_AMP_GET_RIGHT | dir | i);
+			val = snd_hdac_codec_read(&codec->core, nid, 0,
+						  AC_VERB_GET_AMP_GAIN_MUTE,
+						  AC_AMP_GET_RIGHT | dir | i);
 			snd_iprintf(buffer, " 0x%02x", val);
 		}
 		snd_iprintf(buffer, "]");
@@ -374,8 +374,8 @@ static void print_pin_caps(struct snd_info_buffer *buffer,
 	} else
 		*supports_vref = 0;
 	if (caps & AC_PINCAP_EAPD) {
-		val = snd_hda_codec_read(codec, nid, 0,
-					 AC_VERB_GET_EAPD_BTLENABLE, 0);
+		val = snd_hdac_codec_read(&codec->core, nid, 0,
+					  AC_VERB_GET_EAPD_BTLENABLE, 0);
 		snd_iprintf(buffer, "  EAPD 0x%x:", val);
 		if (val & AC_EAPDBTL_BALANCED)
 			snd_iprintf(buffer, " BALANCED");
@@ -385,7 +385,8 @@ static void print_pin_caps(struct snd_info_buffer *buffer,
 			snd_iprintf(buffer, " R/L");
 		snd_iprintf(buffer, "\n");
 	}
-	caps = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_CONFIG_DEFAULT, 0);
+	caps = snd_hdac_codec_read(&codec->core, nid, 0,
+				   AC_VERB_GET_CONFIG_DEFAULT, 0);
 	snd_iprintf(buffer, "  Pin Default 0x%08x: [%s] %s at %s %s\n", caps,
 		    jack_conns[(caps & AC_DEFCFG_PORT_CONN) >> AC_DEFCFG_PORT_CONN_SHIFT],
 		    get_jack_type(caps),
@@ -417,8 +418,8 @@ static void print_pin_ctls(struct snd_info_buffer *buffer,
 {
 	unsigned int pinctls;
 
-	pinctls = snd_hda_codec_read(codec, nid, 0,
-				     AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+	pinctls = snd_hdac_codec_read(&codec->core, nid, 0,
+				      AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
 	snd_iprintf(buffer, "  Pin-ctls: 0x%02x:", pinctls);
 	if (pinctls & AC_PINCTL_IN_EN)
 		snd_iprintf(buffer, " IN");
@@ -455,8 +456,8 @@ static void print_vol_knob(struct snd_info_buffer *buffer,
 	unsigned int cap = param_read(codec, nid, AC_PAR_VOL_KNB_CAP);
 	snd_iprintf(buffer, "  Volume-Knob: delta=%d, steps=%d, ",
 		    (cap >> 7) & 1, cap & 0x7f);
-	cap = snd_hda_codec_read(codec, nid, 0,
-				 AC_VERB_GET_VOLUME_KNOB_CONTROL, 0);
+	cap = snd_hdac_codec_read(&codec->core, nid, 0,
+				  AC_VERB_GET_VOLUME_KNOB_CONTROL, 0);
 	snd_iprintf(buffer, "direct=%d, val=%d\n",
 		    (cap >> 7) & 1, cap & 0x7f);
 }
@@ -465,14 +466,14 @@ static void print_audio_io(struct snd_info_buffer *buffer,
 			   struct hda_codec *codec, hda_nid_t nid,
 			   unsigned int wid_type)
 {
-	int conv = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_CONV, 0);
+	int conv = snd_hdac_codec_read(&codec->core, nid, 0, AC_VERB_GET_CONV, 0);
 	snd_iprintf(buffer,
 		    "  Converter: stream=%d, channel=%d\n",
 		    (conv & AC_CONV_STREAM) >> AC_CONV_STREAM_SHIFT,
 		    conv & AC_CONV_CHANNEL);
 
 	if (wid_type == AC_WID_AUD_IN && (conv & AC_CONV_CHANNEL) == 0) {
-		int sdi = snd_hda_codec_read(codec, nid, 0,
+		int sdi = snd_hdac_codec_read(&codec->core, nid, 0,
 					     AC_VERB_GET_SDI_SELECT, 0);
 		snd_iprintf(buffer, "  SDI-Select: %d\n",
 			    sdi & AC_SDI_SELECT);
@@ -482,7 +483,7 @@ static void print_audio_io(struct snd_info_buffer *buffer,
 static void print_digital_conv(struct snd_info_buffer *buffer,
 			       struct hda_codec *codec, hda_nid_t nid)
 {
-	unsigned int digi1 = snd_hda_codec_read(codec, nid, 0,
+	unsigned int digi1 = snd_hdac_codec_read(&codec->core, nid, 0,
 						AC_VERB_GET_DIGI_CONVERT_1, 0);
 	unsigned char digi2 = digi1 >> 8;
 	unsigned char digi3 = digi1 >> 16;
@@ -538,7 +539,7 @@ static void print_power_state(struct snd_info_buffer *buffer,
 	};
 
 	int sup = param_read(codec, nid, AC_PAR_POWER_STATE);
-	int pwr = snd_hda_codec_read(codec, nid, 0,
+	int pwr = snd_hdac_codec_read(&codec->core, nid, 0,
 				     AC_VERB_GET_POWER_STATE, 0);
 	if (sup != -1) {
 		int i;
@@ -567,7 +568,7 @@ static void print_power_state(struct snd_info_buffer *buffer,
 static void print_unsol_cap(struct snd_info_buffer *buffer,
 			      struct hda_codec *codec, hda_nid_t nid)
 {
-	int unsol = snd_hda_codec_read(codec, nid, 0,
+	int unsol = snd_hdac_codec_read(&codec->core, nid, 0,
 				       AC_VERB_GET_UNSOLICITED_RESPONSE, 0);
 	snd_iprintf(buffer,
 		    "  Unsolicited: tag=%02x, enabled=%d\n",
@@ -598,15 +599,18 @@ static void print_proc_caps(struct snd_info_buffer *buffer,
 
 	/* Note: This is racy - another process could run in parallel and change
 	   the coef index too. */
-	oldindex = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_COEF_INDEX, 0);
+	oldindex = snd_hdac_codec_read(&codec->core, nid, 0,
+				       AC_VERB_GET_COEF_INDEX, 0);
 	for (i = 0; i < ncoeff; i++) {
 		unsigned int val;
-		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_COEF_INDEX, i);
-		val = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_PROC_COEF,
-					 0);
+		snd_hdac_codec_write(&codec->core, nid, 0,
+				     AC_VERB_SET_COEF_INDEX, i);
+		val = snd_hdac_codec_read(&codec->core, nid, 0,
+					  AC_VERB_GET_PROC_COEF, 0);
 		snd_iprintf(buffer, "    Coeff 0x%02x: 0x%04x\n", i, val);
 	}
-	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_COEF_INDEX, oldindex);
+	snd_hdac_codec_write(&codec->core, nid, 0, AC_VERB_SET_COEF_INDEX,
+			     oldindex);
 }
 
 static void print_conn_list(struct snd_info_buffer *buffer,
@@ -622,8 +626,8 @@ static void print_conn_list(struct snd_info_buffer *buffer,
 	    wid_type != AC_WID_AUD_MIX &&
 	    wid_type != AC_WID_VOL_KNB &&
 	    wid_type != AC_WID_POWER)
-		curr = snd_hda_codec_read(codec, nid, 0,
-					  AC_VERB_GET_CONNECT_SEL, 0);
+		curr = snd_hdac_codec_read(&codec->core, nid, 0,
+					   AC_VERB_GET_CONNECT_SEL, 0);
 	snd_iprintf(buffer, "  Connection: %d\n", conn_len);
 	if (conn_len > 0) {
 		snd_iprintf(buffer, "    ");
@@ -666,18 +670,18 @@ static void print_gpio(struct snd_info_buffer *buffer,
 	max = gpio & AC_GPIO_IO_COUNT;
 	if (!max || max > 8)
 		return;
-	enable = snd_hda_codec_read(codec, nid, 0,
-				    AC_VERB_GET_GPIO_MASK, 0);
-	direction = snd_hda_codec_read(codec, nid, 0,
-				       AC_VERB_GET_GPIO_DIRECTION, 0);
-	wake = snd_hda_codec_read(codec, nid, 0,
-				  AC_VERB_GET_GPIO_WAKE_MASK, 0);
-	unsol  = snd_hda_codec_read(codec, nid, 0,
+	enable = snd_hdac_codec_read(&codec->core, nid, 0,
+				     AC_VERB_GET_GPIO_MASK, 0);
+	direction = snd_hdac_codec_read(&codec->core, nid, 0,
+					AC_VERB_GET_GPIO_DIRECTION, 0);
+	wake = snd_hdac_codec_read(&codec->core, nid, 0,
+				   AC_VERB_GET_GPIO_WAKE_MASK, 0);
+	unsol = snd_hdac_codec_read(&codec->core, nid, 0,
 				    AC_VERB_GET_GPIO_UNSOLICITED_RSP_MASK, 0);
-	sticky = snd_hda_codec_read(codec, nid, 0,
-				    AC_VERB_GET_GPIO_STICKY_MASK, 0);
-	data = snd_hda_codec_read(codec, nid, 0,
-				  AC_VERB_GET_GPIO_DATA, 0);
+	sticky = snd_hdac_codec_read(&codec->core, nid, 0,
+				     AC_VERB_GET_GPIO_STICKY_MASK, 0);
+	data = snd_hdac_codec_read(&codec->core, nid, 0,
+				   AC_VERB_GET_GPIO_DATA, 0);
 	for (i = 0; i < max; ++i)
 		snd_iprintf(buffer,
 			    "  IO[%d]: enable=%d, dir=%d, wake=%d, "
@@ -706,8 +710,8 @@ static void print_device_list(struct snd_info_buffer *buffer,
 	if (devlist_len <= 0)
 		return;
 
-	curr = snd_hda_codec_read(codec, nid, 0,
-				AC_VERB_GET_DEVICE_SEL, 0);
+	curr = snd_hdac_codec_read(&codec->core, nid, 0,
+				   AC_VERB_GET_DEVICE_SEL, 0);
 
 	for (i = 0; i < devlist_len; i++) {
 		if (i == curr)
-- 
2.4.3
