From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH v4 3/6] ALSA: pcm: add IEC958 channel status
	control helper
Date: Tue, 8 Mar 2016 13:53:58 +0100
Message-ID: <1457441641-7501-4-git-send-email-arnaud.pouliquen@st.com>
References: <1457441641-7501-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 94B992619D0
 for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2016 13:54:28 +0100 (CET)
In-Reply-To: <1457441641-7501-1-git-send-email-arnaud.pouliquen@st.com>
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
Cc: Jean-Francois Moine <moinejf@free.fr>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, David Airlie <airlied@linux.ie>, arnaud.pouliquen@st.com, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Moise Gergaud <moise.gergaud@st.com>
List-Id: alsa-devel@alsa-project.org

Add IEC958 channel status helper that creates control to handle the
IEC60958 status bits.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 include/sound/pcm_iec958.h |  21 ++++++++
 sound/core/pcm_iec958.c    | 125 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 146 insertions(+)

diff --git a/include/sound/pcm_iec958.h b/include/sound/pcm_iec958.h
index 0eed397..6d5e3d1 100644
--- a/include/sound/pcm_iec958.h
+++ b/include/sound/pcm_iec958.h
@@ -3,7 +3,28 @@
 
 #include <linux/types.h>
 
+/**
+ * struct snd_pcm_iec958_params: IEC 60958 controls parameters
+ * @ctrl_set: control set callback
+ * This callback is optional and shall be used to set associated driver
+ * configuration. Calls under mutex protection.
+ * @iec: Mandatory pointer to iec958 structure.
+ * @pdata: Optional pointer to driver context.
+ * @mutex: Mandatory pointer to mutex
+ *         Provided by driver to handle race conditions.
+ */
+struct snd_pcm_iec958_params {
+	int (*ctrl_set)(void *pdata, u8 *status);
+	struct snd_aes_iec958 *iec;
+	void *pdata;
+	struct mutex *mutex;
+};
+
 int snd_pcm_create_iec958_consumer(struct snd_pcm_runtime *runtime, u8 *cs,
 	size_t len);
 
+int snd_pcm_create_iec958_ctl(struct snd_pcm *pcm, int subdevice,
+			      struct snd_pcm_iec958_params *params,
+			      int stream);
+const struct snd_kcontrol_new *snd_pcm_iec958_ctl_new(int stream);
 #endif
diff --git a/sound/core/pcm_iec958.c b/sound/core/pcm_iec958.c
index 36b2d7a..24d6a8e 100644
--- a/sound/core/pcm_iec958.c
+++ b/sound/core/pcm_iec958.c
@@ -7,10 +7,97 @@
  */
 #include <linux/export.h>
 #include <linux/types.h>
+#include <linux/wait.h>
 #include <sound/asoundef.h>
+#include <sound/control.h>
 #include <sound/pcm.h>
 #include <sound/pcm_iec958.h>
 
+static int snd_pcm_iec958_info(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
+	uinfo->count = 1;
+	return 0;
+}
+
+/*
+ * IEC958 channel status default controls callbacks
+ *
+ * Callbacks are protected by a mutex provided by user.
+ */
+static int snd_pcm_iec958_get(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *uctl)
+{
+	struct snd_pcm_iec958_params *params = snd_kcontrol_chip(kcontrol);
+	int i;
+
+	if (!params->mutex)
+		return -EINVAL;
+
+	mutex_lock(params->mutex);
+	for (i = 0; i < 5; i++)
+		uctl->value.iec958.status[i] = params->iec->status[i];
+	mutex_unlock(params->mutex);
+
+	return 0;
+}
+
+static int snd_pcm_iec958_put(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *uctl)
+{
+	struct snd_pcm_iec958_params *params = snd_kcontrol_chip(kcontrol);
+	int err = 0;
+	int i, updated = 0;
+
+	if (!params->mutex)
+		return -EINVAL;
+
+	mutex_lock(params->mutex);
+	for (i = 0; i < 5; i++) {
+		if (params->iec->status[i] != uctl->value.iec958.status[i])
+			updated = 1;
+	}
+
+	if (!updated)
+		goto unlock;
+
+	if (params->ctrl_set)
+		err = params->ctrl_set(params->pdata,
+				       uctl->value.iec958.status);
+	if (err < 0) {
+		mutex_unlock(params->mutex);
+		return err;
+	}
+
+	for (i = 0; i < 5; i++)
+		params->iec->status[i] = uctl->value.iec958.status[i];
+
+ unlock:
+	mutex_unlock(params->mutex);
+	return updated;
+}
+
+static const struct snd_kcontrol_new iec958_ctls[] = {
+	{
+		.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
+			   SNDRV_CTL_ELEM_ACCESS_VOLATILE),
+		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
+		.name = SNDRV_CTL_NAME_IEC958("", PLAYBACK, DEFAULT),
+		.info = snd_pcm_iec958_info,
+		.get = snd_pcm_iec958_get,
+		.put = snd_pcm_iec958_put,
+	},
+	{
+		.access = (SNDRV_CTL_ELEM_ACCESS_READ |
+			   SNDRV_CTL_ELEM_ACCESS_VOLATILE),
+		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
+		.name = SNDRV_CTL_NAME_IEC958("", CAPTURE, DEFAULT),
+		.info = snd_pcm_iec958_info,
+		.get = snd_pcm_iec958_get,
+	},
+};
+
 /**
  * snd_pcm_create_iec958_consumer - create consumer format IEC958 channel status
  * @runtime: pcm runtime structure with ->rate filled in
@@ -93,3 +180,41 @@ int snd_pcm_create_iec958_consumer(struct snd_pcm_runtime *runtime, u8 *cs,
 	return len;
 }
 EXPORT_SYMBOL(snd_pcm_create_iec958_consumer);
+
+/**
+ * snd_pcm_create_iec958_ctl - Add a IEC958 control associated to the pcm device
+ * @pcm: pcm device to associate to the control.
+ * @subdevice: subdevice index.Must be set to 0 if unused
+ * @iec958: snd_pcm_iec958_params structure that contains callbacks
+ *          and channel status buffer.
+ * @stream: stream type SNDRV_PCM_STREAM_PLAYBACK or SNDRV_PCM_STREAM_CATURE.
+ * Returns:  negative error code if something failed.
+ */
+int snd_pcm_create_iec958_ctl(struct snd_pcm *pcm, int subdevice,
+			      struct snd_pcm_iec958_params *params, int stream)
+{
+	struct snd_kcontrol_new knew;
+
+	if (stream > SNDRV_PCM_STREAM_LAST)
+		return -EINVAL;
+
+	knew = iec958_ctls[stream];
+	knew.device = pcm->device;
+	knew.subdevice = subdevice;
+	return snd_ctl_add(pcm->card, snd_ctl_new1(&knew, params));
+}
+EXPORT_SYMBOL(snd_pcm_create_iec958_ctl);
+
+/**
+ * snd_pcm_iec958_ctl_new - create a IEC958 control instance from the template
+ * @stream: stream type SNDRV_PCM_STREAM_PLAYBACK or SNDRV_PCM_STREAM_CATURE.
+ * Returns:  pointer to snd_kcontrol_new structure, NULL if something failed.
+ */
+const struct snd_kcontrol_new *snd_pcm_iec958_ctl_new(int stream)
+{
+	if (stream > SNDRV_PCM_STREAM_LAST)
+		return NULL;
+
+	return &iec958_ctls[stream];
+}
+EXPORT_SYMBOL(snd_pcm_iec958_ctl_new);
-- 
1.9.1
