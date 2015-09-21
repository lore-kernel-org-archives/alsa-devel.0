From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [RFC 1/5] video: hdmi: add help function for N and CTS
Date: Mon, 21 Sep 2015 15:19:52 +0200
Message-ID: <1442841596-1323-2-git-send-email-arnaud.pouliquen@st.com>
References: <1442841596-1323-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 8F3CE2612BD
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2015 15:21:16 +0200 (CEST)
In-Reply-To: <1442841596-1323-1-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org
Cc: moinejf@free.fr, linux@arm.linux.org.uk, Takashi Iwai <tiwai@suse.de>, tomi.valkeinen@ti.com, arnaud.pouliquen@st.com, lgirdwood@gmail.com, Jyri Sarha <jsarha@ti.com>, peter.ujfalusi@ti.com, airlied@linux.ie, tony@atomide.com, broonie@kernel.org, bcousson@baylibre.com
List-Id: alsa-devel@alsa-project.org

Add helper function to compute CTS and N parameters base on 
table described in HDMI specification 1.4b

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/video/hdmi.c | 148 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/hdmi.h |   8 +++
 2 files changed, 156 insertions(+)

diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
index 1626892..9c487fb 100644
--- a/drivers/video/hdmi.c
+++ b/drivers/video/hdmi.c
@@ -1242,3 +1242,151 @@ int hdmi_infoframe_unpack(union hdmi_infoframe *frame, void *buffer)
 	return ret;
 }
 EXPORT_SYMBOL(hdmi_infoframe_unpack);
+
+/*
+ * audio clock regeneration (acr) parameters
+ * N and CTS computation are based on HDMI specification 1.4b
+ */
+
+enum audio_rate {
+	HDMI_AUDIO_N_CTS_32KHZ,
+	HDMI_AUDIO_N_CTS_44_1KHZ,
+	HDMI_AUDIO_N_CTS_48KHZ,
+};
+
+struct hdmi_audio_acr {
+	unsigned long pixel_clk;
+	struct hdmi_audio_n_cts n_cts;
+};
+
+static const struct hdmi_audio_acr hdmi_audio_standard_acr[3][12] = {
+	{ /*32 kHz*/
+		{  25175, {  4576,  28125 } }, /* 25,20/1.001  MHz */
+		{  25200, {  4096,  25200 } }, /* 25.20        MHz */
+		{  27000, {  4096,  27000 } }, /* 27.00        MHz */
+		{  27027, {  4096,  27027 } }, /* 27.00*1.001  MHz */
+		{  54000, {  4096,  54000 } }, /* 54.00        MHz */
+		{  54054, {  4096,  54054 } }, /* 54.00*1.001  MHz */
+		{  74176, { 11648, 310938 } }, /* 74.25/1.001  MHz */
+		{  74250, {  4096,  74250 } }, /* 74.25        MHz */
+		{ 148352, { 11648, 421875 } }, /* 148.50/1.001 MHz */
+		{ 148500, {  4096, 148500 } }, /* 148.50       MHz */
+		{ 296703, {  5824, 421875 } }, /* 297/1.001    MHz */
+		{ 297000, {  3072, 222750 } }, /* 297          MHz */
+	},
+	{ /*44.1 kHz, 88.2 kHz  176.4 kHz*/
+		{  25175, {  7007,  31250 } }, /* 25,20/1.001  MHz */
+		{  25200, {  6272,  28000 } }, /* 25.20        MHz */
+		{  27000, {  6272,  30000 } }, /* 27.00        MHz */
+		{  27027, {  6272,  30030 } }, /* 27.00*1.001  MHz */
+		{  54000, {  6272,  60000 } }, /* 54.00        MHz */
+		{  54054, {  6272,  60060 } }, /* 54.00*1.001  MHz */
+		{  74176, { 17836, 234375 } }, /* 74.25/1.001  MHz */
+		{  74250, {  6272,  82500 } }, /* 74.25        MHz */
+		{ 148352, {  8918, 234375 } }, /* 148.50/1.001 MHz */
+		{ 148500, {  6272, 165000 } }, /* 148.50       MHz */
+		{ 296703, {  4459, 234375 } }, /* 297/1.001    MHz */
+		{ 297000, {  4704, 247500 } }, /* 297          MHz */
+	},
+	{ /*48 kHz, 96 kHz  192 kHz*/
+		{  25175, {  6864,  28125 } }, /* 25,20/1.001  MHz */
+		{  25200, {  6144,  25200 } }, /* 25.20        MHz */
+		{  27000, {  6144,  27000 } }, /* 27.00        MHz */
+		{  27027, {  6144,  27027 } }, /* 27.00*1.001  MHz */
+		{  54000, {  6144,  54000 } }, /* 54.00        MHz */
+		{  54054, {  6144,  54054 } }, /* 54.00*1.001  MHz */
+		{  74176, { 11648, 140625 } }, /* 74.25/1.001  MHz */
+		{  74250, {  6144,  74250 } }, /* 74.25        MHz */
+		{ 148352, {  5824, 140625 } }, /* 148.50/1.001 MHz */
+		{ 148500, {  6144, 148500 } }, /* 148.50       MHz */
+		{ 296703, {  5824, 281250 } }, /* 297/1.001    MHz */
+		{ 297000, {  5120, 247500 } }, /* 297          MHz */
+	}
+};
+
+/**
+ * hdmi_compute_n_cts() - compute N and CTS parameters
+ * @audio_clk: audio frame clock frequency in KHz
+ * @pixel_clk: pixel cloack frequency in kHz
+ * @n_cts: N and CTS parameter returned to user
+ *
+ * Values computed are based on table described in HDMI specification 1.4b
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+
+int hdmi_audio_compute_n_cts(unsigned int audio_fs, unsigned long pixel_clk,
+			     struct hdmi_audio_n_cts *n_cts)
+{
+	int audio_freq_id, i;
+	int ratio = 1;
+	const struct hdmi_audio_acr  *acr_table;
+	const struct hdmi_audio_n_cts *predef_n_cts = NULL;
+
+	switch (audio_fs) {
+	case 32000:
+		audio_freq_id = HDMI_AUDIO_N_CTS_32KHZ;
+		n_cts->n = 4096;
+		break;
+
+	case 44100:
+		audio_freq_id = HDMI_AUDIO_N_CTS_44_1KHZ;
+		n_cts->n = 6272;
+		break;
+
+	case 48000:
+		audio_freq_id = HDMI_AUDIO_N_CTS_48KHZ;
+		n_cts->n = 6144;
+		break;
+
+	case 88200:
+		audio_freq_id = HDMI_AUDIO_N_CTS_44_1KHZ;
+		ratio = 2;
+		n_cts->n = 6272 * 2;
+		break;
+
+	case 96000:
+		audio_freq_id = HDMI_AUDIO_N_CTS_48KHZ;
+		ratio = 2;
+		n_cts->n = 6144 * 2;
+		break;
+
+	case 176400:
+		audio_freq_id = HDMI_AUDIO_N_CTS_44_1KHZ;
+		ratio = 2;
+		n_cts->n = 6272 * 4;
+		break;
+
+	case 192000:
+		audio_freq_id = HDMI_AUDIO_N_CTS_48KHZ;
+		ratio = 4;
+		n_cts->n = 6144 * 4;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	acr_table = hdmi_audio_standard_acr[audio_freq_id];
+	for (i = 0; i < ARRAY_SIZE(hdmi_audio_standard_acr[0]); i++) {
+		if (pixel_clk == acr_table[i].pixel_clk) {
+			predef_n_cts = &acr_table[i].n_cts;
+			break;
+		}
+	}
+
+	if (!predef_n_cts) {
+		/*
+		 * predifined frequency not found compute CTS using formula:
+		 * CTS = (Ftdms_clk * N) / (128* audio_fs)
+		 */
+		n_cts->cts =  pixel_clk * n_cts->n / (128 * audio_fs);
+	} else {
+		n_cts->n = predef_n_cts->n * ratio;
+		n_cts->cts = predef_n_cts->cts;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(hdmi_audio_compute_n_cts);
+
diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
index e974420..32107a0 100644
--- a/include/linux/hdmi.h
+++ b/include/linux/hdmi.h
@@ -333,4 +333,12 @@ int hdmi_infoframe_unpack(union hdmi_infoframe *frame, void *buffer);
 void hdmi_infoframe_log(const char *level, struct device *dev,
 			union hdmi_infoframe *frame);
 
+struct hdmi_audio_n_cts {
+	unsigned int n;
+	unsigned int cts;
+};
+
+int hdmi_audio_compute_n_cts(unsigned int audio_fs, unsigned long pixel_clk,
+			     struct hdmi_audio_n_cts *n_cts);
+
 #endif /* _DRM_HDMI_H */
-- 
1.9.1
