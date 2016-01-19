From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [RFC 2/6] ALSA: pcm: add IEC958 channel status control
	helper
Date: Tue, 19 Jan 2016 14:40:32 +0100
Message-ID: <1453210836-16218-3-git-send-email-arnaud.pouliquen@st.com>
References: <1453210836-16218-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 1971226058F
 for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2016 14:41:05 +0100 (CET)
In-Reply-To: <1453210836-16218-1-git-send-email-arnaud.pouliquen@st.com>
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
Cc: Jean-Francois Moine <moinejf@free.fr>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@linux.ie>, arnaud.pouliquen@st.com, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Benjamin Gaignard <benjamin.gaignard@linaro.org>
List-Id: alsa-devel@alsa-project.org

Add IEC958 channel status helper that creates control to handle the
IEC60958 status bits.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 include/sound/pcm_iec958.h | 16 +++++++++
 sound/core/pcm_iec958.c    | 90 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/include/sound/pcm_iec958.h b/include/sound/pcm_iec958.h
index 36f023a..7453ace 100644
--- a/include/sound/pcm_iec958.h
+++ b/include/sound/pcm_iec958.h
@@ -3,9 +3,25 @@
 
 #include <linux/types.h>
 
+/*
+ * IEC 60958 controls parameters
+ * Describes channel status and associated callback
+ */
+struct snd_pcm_iec958_params {
+	/* call when control is updated by user */
+	int (*ctrl_set)(void *pdata, u8 *status, u8 len);
+
+	struct snd_aes_iec958 *iec;
+	void *pdata; /* user private data to retrieve context */
+	struct mutex *mutex; /* use to avoid race condition */
+};
+
 int snd_pcm_create_iec958_consumer(struct snd_pcm_runtime *runtime, u8 *cs,
 	size_t len);
 
 int snd_pcm_create_iec958_consumer_hw_params(struct snd_pcm_hw_params *params,
 					     u8 *cs, size_t len);
+
+int snd_pcm_create_iec958_ctl(struct snd_pcm *pcm,
+			      struct snd_pcm_iec958_params *params, int stream);
 #endif
diff --git a/sound/core/pcm_iec958.c b/sound/core/pcm_iec958.c
index c9f8b66..1d426bc 100644
--- a/sound/core/pcm_iec958.c
+++ b/sound/core/pcm_iec958.c
@@ -7,11 +7,78 @@
  */
 #include <linux/export.h>
 #include <linux/types.h>
+#include <linux/wait.h>
 #include <sound/asoundef.h>
+#include <sound/control.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/pcm_iec958.h>
 
+int snd_pcm_iec958_info(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
+	uinfo->count = 1;
+	return 0;
+}
+
+static int snd_pcm_iec958_get(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *uctl)
+{
+	struct snd_pcm_iec958_params *params = snd_kcontrol_chip(kcontrol);
+
+	if (params->mutex)
+		mutex_unlock(params->mutex);
+	uctl->value.iec958.status[0] = params->iec->status[0];
+	uctl->value.iec958.status[1] = params->iec->status[1];
+	uctl->value.iec958.status[2] = params->iec->status[2];
+	uctl->value.iec958.status[3] = params->iec->status[3];
+	uctl->value.iec958.status[4] = params->iec->status[4];
+	if (params->mutex)
+		mutex_unlock(params->mutex);
+	return 0;
+}
+
+static int snd_pcm_iec958_put(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *uctl)
+{
+	struct snd_pcm_iec958_params *params = snd_kcontrol_chip(kcontrol);
+	int err = 0;
+
+	if (params->mutex)
+		mutex_lock(params->mutex);
+	if (params->ctrl_set)
+		err = params->ctrl_set(params->pdata,
+				       uctl->value.iec958.status, 5);
+	if (!err) {
+		params->iec->status[0] = uctl->value.iec958.status[0];
+		params->iec->status[1] = uctl->value.iec958.status[1];
+		params->iec->status[2] = uctl->value.iec958.status[2];
+		params->iec->status[3] = uctl->value.iec958.status[3];
+		params->iec->status[4] = uctl->value.iec958.status[4];
+	}
+	if (params->mutex)
+		mutex_unlock(params->mutex);
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new iec958_ctls[] = {
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
+		.name = SNDRV_CTL_NAME_IEC958("", PLAYBACK, DEFAULT),
+		.info = snd_pcm_iec958_info,
+		.get = snd_pcm_iec958_get,
+		.put = snd_pcm_iec958_put,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
+		.name = SNDRV_CTL_NAME_IEC958("", CAPTURE, DEFAULT),
+		.info = snd_pcm_iec958_info,
+		.get = snd_pcm_iec958_get,
+	},
+};
+
 static int create_iec958_consumer(uint rate, uint sample_width,
 				  u8 *cs, size_t len)
 {
@@ -111,3 +178,26 @@ int snd_pcm_create_iec958_consumer_hw_params(struct snd_pcm_hw_params *params,
 				      cs, len);
 }
 EXPORT_SYMBOL(snd_pcm_create_iec958_consumer_hw_params);
+
+/**
+ * snd_pcm_create_iec958_ctl - create IEC958 channel status default control
+ * pcm: pcm device to associate to the control.
+ * iec958: snd_pcm_iec958_params structure that cntains callbacks
+ *         and channel status buffer
+ * stream: stream type SNDRV_PCM_STREAM_PLAYBACK or SNDRV_PCM_STREAM_CATURE
+ * Returns:  negative error code if something failed.
+ */
+int snd_pcm_create_iec958_ctl(struct snd_pcm *pcm,
+			      struct snd_pcm_iec958_params *params, int stream)
+{
+	struct snd_kcontrol_new knew;
+
+	if (stream > SNDRV_PCM_STREAM_LAST)
+		return -EINVAL;
+
+	knew = iec958_ctls[stream];
+	knew.device = pcm->device;
+	knew.count = pcm->streams[stream].substream_count;
+	return snd_ctl_add(pcm->card, snd_ctl_new1(&knew, params));
+}
+EXPORT_SYMBOL(snd_pcm_create_iec958_ctl);
-- 
1.9.1
