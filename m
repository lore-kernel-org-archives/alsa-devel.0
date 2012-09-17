From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] hda-emu: Add support for channel mapping API
Date: Mon, 17 Sep 2012 11:56:37 +0200
Message-ID: <1347875797-10408-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 03570261681
 for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2012 11:56:40 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

---

Hi Takashi,

I tried to make hda-emu compile with the latest changes to the HDA driver.
This is the result. It compiles, but when running any codec, I get the error
"Control element Playback Channel Map:0 already exists!".
I'm unsure whether this is a problem in the driver or in my simple copy-paste
attempt to make this work.
Can you offer some insight?

Thanks.


 include/sound/asound.h |   57 +++++++++++++
 include/sound/pcm.h    |   58 +++++++++++++
 include/sound/tlv.h    |    8 ++
 snd-wrapper.c          |  214 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 337 insertions(+)

diff --git a/include/sound/asound.h b/include/sound/asound.h
index 25e90ed..61f1440 100644
--- a/include/sound/asound.h
+++ b/include/sound/asound.h
@@ -164,3 +164,60 @@ struct snd_ctl_event {
 		unsigned char data8[60];
 	} data;
 };
+
+typedef int __bitwise snd_pcm_state_t;
+#define	SNDRV_PCM_STATE_OPEN		((snd_pcm_state_t) 0) /* stream is open */
+#define	SNDRV_PCM_STATE_SETUP		((snd_pcm_state_t) 1) /* stream has a setup */
+#define	SNDRV_PCM_STATE_PREPARED	((snd_pcm_state_t) 2) /* stream is ready to start */
+#define	SNDRV_PCM_STATE_RUNNING		((snd_pcm_state_t) 3) /* stream is running */
+#define	SNDRV_PCM_STATE_XRUN		((snd_pcm_state_t) 4) /* stream reached an xrun */
+#define	SNDRV_PCM_STATE_DRAINING	((snd_pcm_state_t) 5) /* stream is draining */
+#define	SNDRV_PCM_STATE_PAUSED		((snd_pcm_state_t) 6) /* stream is paused */
+#define	SNDRV_PCM_STATE_SUSPENDED	((snd_pcm_state_t) 7) /* hardware is suspended */
+#define	SNDRV_PCM_STATE_DISCONNECTED	((snd_pcm_state_t) 8) /* hardware is disconnected */
+#define	SNDRV_PCM_STATE_LAST		SNDRV_PCM_STATE_DISCONNECTED
+
+struct snd_pcm_mmap_status {
+	snd_pcm_state_t state;		/* RO: state - SNDRV_PCM_STATE_XXXX */
+};
+
+
+/* channel positions */
+enum {
+	SNDRV_CHMAP_UNKNOWN = 0,
+	SNDRV_CHMAP_NA,		/* N/A, silent */
+	SNDRV_CHMAP_MONO,	/* mono stream */
+	/* this follows the alsa-lib mixer channel value + 3 */
+	SNDRV_CHMAP_FL,		/* front left */
+	SNDRV_CHMAP_FR,		/* front right */
+	SNDRV_CHMAP_RL,		/* rear left */
+	SNDRV_CHMAP_RR,		/* rear right */
+	SNDRV_CHMAP_FC,		/* front center */
+	SNDRV_CHMAP_LFE,	/* LFE */
+	SNDRV_CHMAP_SL,		/* side left */
+	SNDRV_CHMAP_SR,		/* side right */
+	SNDRV_CHMAP_RC,		/* rear center */
+	/* new definitions */
+	SNDRV_CHMAP_FLC,	/* front left center */
+	SNDRV_CHMAP_FRC,	/* front right center */
+	SNDRV_CHMAP_RLC,	/* rear left center */
+	SNDRV_CHMAP_RRC,	/* rear right center */
+	SNDRV_CHMAP_FLW,	/* front left wide */
+	SNDRV_CHMAP_FRW,	/* front right wide */
+	SNDRV_CHMAP_FLH,	/* front left high */
+	SNDRV_CHMAP_FCH,	/* front center high */
+	SNDRV_CHMAP_FRH,	/* front right high */
+	SNDRV_CHMAP_TC,		/* top center */
+	SNDRV_CHMAP_TFL,	/* top front left */
+	SNDRV_CHMAP_TFR,	/* top front right */
+	SNDRV_CHMAP_TFC,	/* top front center */
+	SNDRV_CHMAP_TRL,	/* top rear left */
+	SNDRV_CHMAP_TRR,	/* top rear right */
+	SNDRV_CHMAP_TRC,	/* top rear center */
+	SNDRV_CHMAP_LAST = SNDRV_CHMAP_TRC,
+};
+
+#define SNDRV_CHMAP_POSITION_MASK	0xffff
+#define SNDRV_CHMAP_PHASE_INVERSE	(0x01 << 16)
+#define SNDRV_CHMAP_DRIVER_SPEC		(0x02 << 16)
+
diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index f1719cb..4980c69 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -45,6 +45,8 @@ struct snd_pcm_runtime {
 	unsigned int info;
 	unsigned int rate_num;
 	unsigned int rate_den;
+	/* -- mmap -- */
+	struct snd_pcm_mmap_status *status;
 
 	void *private_data;
 	void (*private_free)(struct snd_pcm_runtime *runtime);
@@ -62,12 +64,21 @@ struct snd_pcm_substream {
 	struct snd_pcm_ops *ops;
 	/* -- runtime information -- */
 	struct snd_pcm_runtime *runtime;
+	/* -- next substream -- */
+	struct snd_pcm_substream *next;
 	void *file;
 	int ref_count;
+
 };
 
 struct snd_pcm_str {
+	/* -- substreams -- */
 	unsigned int substream_opened;
+	unsigned int substream_count;
+	struct snd_pcm_substream *substream;
+
+	struct snd_kcontrol *chmap_kctl; /* channel-mapping controls */
+
 };
 
 struct snd_pcm {
@@ -241,5 +252,52 @@ static inline int snd_pcm_hw_constraint_list(struct snd_pcm_runtime *run,
 
 int snd_pcm_format_width(int fmt);
 
+/*
+ * PCM channel-mapping control API
+ */
+/* array element of channel maps */
+struct snd_pcm_chmap_elem {
+	unsigned char channels;
+	unsigned char map[15];
+};
+
+/* channel map information; retrieved via snd_kcontrol_chip() */
+struct snd_pcm_chmap {
+	struct snd_pcm *pcm;	/* assigned PCM instance */
+	int stream;		/* PLAYBACK or CAPTURE */
+	struct snd_kcontrol *kctl;
+	const struct snd_pcm_chmap_elem *chmap;
+	unsigned int max_channels;
+	unsigned int channel_mask;	/* optional: active channels bitmask */
+	void *private_data;	/* optional: private data pointer */
+};
+
+/* get the PCM substream assigned to the given chmap info */
+static inline struct snd_pcm_substream *
+snd_pcm_chmap_substream(struct snd_pcm_chmap *info, unsigned int idx)
+{
+	struct snd_pcm_substream *s;
+	for (s = info->pcm->streams[info->stream].substream; s; s = s->next)
+		if (s->number == idx)
+			return s;
+	return NULL;
+}
+
+/* ALSA-standard channel maps (RL/RR prior to C/LFE) */
+extern const struct snd_pcm_chmap_elem snd_pcm_std_chmaps[];
+/* Other world's standard channel maps (C/LFE prior to RL/RR) */
+extern const struct snd_pcm_chmap_elem snd_pcm_alt_chmaps[];
+
+/* bit masks to be passed to snd_pcm_chmap.channel_mask field */
+#define SND_PCM_CHMAP_MASK_24	((1U << 2) | (1U << 4))
+#define SND_PCM_CHMAP_MASK_246	(SND_PCM_CHMAP_MASK_24 | (1U << 6))
+#define SND_PCM_CHMAP_MASK_2468	(SND_PCM_CHMAP_MASK_246 | (1U << 8))
+
+int snd_pcm_add_chmap_ctls(struct snd_pcm *pcm, int stream,
+			   const struct snd_pcm_chmap_elem *chmap,
+			   int max_channels,
+			   unsigned long private_value,
+			   struct snd_pcm_chmap **info_ret);
+
 #endif /* __SOUND_PCM_H */
 
diff --git a/include/sound/tlv.h b/include/sound/tlv.h
index 7067e2d..de36aaa 100644
--- a/include/sound/tlv.h
+++ b/include/sound/tlv.h
@@ -73,4 +73,12 @@
 
 #define TLV_DB_GAIN_MUTE	-9999999
 
+/*
+ * channel-mapping TLV items
+ *  TLV length must match with num_channels
+ */
+#define SNDRV_CTL_TLVT_CHMAP_FIXED	0x101	/* fixed channel position */
+#define SNDRV_CTL_TLVT_CHMAP_VAR	0x102	/* channels freely swappable */
+#define SNDRV_CTL_TLVT_CHMAP_PAIRED	0x103	/* pair-wise swappable */
+
 #endif /* __SOUND_TLV_H */
diff --git a/snd-wrapper.c b/snd-wrapper.c
index aaa2467..7716e67 100644
--- a/snd-wrapper.c
+++ b/snd-wrapper.c
@@ -257,3 +257,217 @@ void mylock_unlock(int *lock, const char *file, int line)
 		break;
 	}
 }
+
+/*
+ * standard channel mapping helpers
+ */
+#include <sound/tlv.h>
+
+/* default channel maps for multi-channel playbacks, up to 8 channels */
+const struct snd_pcm_chmap_elem snd_pcm_std_chmaps[] = {
+	{ .channels = 1,
+	  .map = { SNDRV_CHMAP_MONO } },
+	{ .channels = 2,
+	  .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR } },
+	{ .channels = 4,
+	  .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR,
+		   SNDRV_CHMAP_RL, SNDRV_CHMAP_RR } },
+	{ .channels = 6,
+	  .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR,
+		   SNDRV_CHMAP_RL, SNDRV_CHMAP_RR,
+		   SNDRV_CHMAP_FC, SNDRV_CHMAP_LFE } },
+	{ .channels = 8,
+	  .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR,
+		   SNDRV_CHMAP_RL, SNDRV_CHMAP_RR,
+		   SNDRV_CHMAP_FC, SNDRV_CHMAP_LFE,
+		   SNDRV_CHMAP_SL, SNDRV_CHMAP_SR } },
+	{ }
+};
+EXPORT_SYMBOL_GPL(snd_pcm_std_chmaps);
+
+/* alternative channel maps with CLFE <-> surround swapped for 6/8 channels */
+const struct snd_pcm_chmap_elem snd_pcm_alt_chmaps[] = {
+	{ .channels = 1,
+	  .map = { SNDRV_CHMAP_MONO } },
+	{ .channels = 2,
+	  .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR } },
+	{ .channels = 4,
+	  .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR,
+		   SNDRV_CHMAP_RL, SNDRV_CHMAP_RR } },
+	{ .channels = 6,
+	  .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR,
+		   SNDRV_CHMAP_FC, SNDRV_CHMAP_LFE,
+		   SNDRV_CHMAP_RL, SNDRV_CHMAP_RR } },
+	{ .channels = 8,
+	  .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR,
+		   SNDRV_CHMAP_FC, SNDRV_CHMAP_LFE,
+		   SNDRV_CHMAP_RL, SNDRV_CHMAP_RR,
+		   SNDRV_CHMAP_SL, SNDRV_CHMAP_SR } },
+	{ }
+};
+EXPORT_SYMBOL_GPL(snd_pcm_alt_chmaps);
+
+static bool valid_chmap_channels(const struct snd_pcm_chmap *info, int ch)
+{
+	if (ch > info->max_channels)
+		return false;
+	return !info->channel_mask || (info->channel_mask & (1U << ch));
+}
+
+static int pcm_chmap_ctl_info(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_info *uinfo)
+{
+	struct snd_pcm_chmap *info = snd_kcontrol_chip(kcontrol);
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 0;
+	uinfo->count = info->max_channels;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = SNDRV_CHMAP_LAST;
+	return 0;
+}
+
+/* get callback for channel map ctl element
+ * stores the channel position firstly matching with the current channels
+ */
+static int pcm_chmap_ctl_get(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_pcm_chmap *info = snd_kcontrol_chip(kcontrol);
+	unsigned int idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
+	struct snd_pcm_substream *substream;
+	const struct snd_pcm_chmap_elem *map;
+
+	if (snd_BUG_ON(!info->chmap))
+		return -EINVAL;
+	substream = snd_pcm_chmap_substream(info, idx);
+	if (!substream)
+		return -ENODEV;
+	memset(ucontrol->value.integer.value, 0,
+	       sizeof(ucontrol->value.integer.value));
+	if (!substream->runtime)
+		return 0; /* no channels set */
+	for (map = info->chmap; map->channels; map++) {
+		int i;
+		if (map->channels == substream->runtime->channels &&
+		    valid_chmap_channels(info, map->channels)) {
+			for (i = 0; i < map->channels; i++)
+				ucontrol->value.integer.value[i] = map->map[i];
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+
+/* tlv callback for channel map ctl element
+ * expands the pre-defined channel maps in a form of TLV
+ */
+static int pcm_chmap_ctl_tlv(struct snd_kcontrol *kcontrol, int op_flag,
+			     unsigned int size, unsigned int __user *tlv)
+{
+	struct snd_pcm_chmap *info = snd_kcontrol_chip(kcontrol);
+	const struct snd_pcm_chmap_elem *map;
+	unsigned int __user *dst;
+	int c, count = 0;
+
+	if (snd_BUG_ON(!info->chmap))
+		return -EINVAL;
+	if (size < 8)
+		return -ENOMEM;
+	if (put_user(SNDRV_CTL_TLVT_CONTAINER, tlv))
+		return -EFAULT;
+	size -= 8;
+	dst = tlv + 2;
+	for (map = info->chmap; map->channels; map++) {
+		int chs_bytes = map->channels * 4;
+		if (!valid_chmap_channels(info, map->channels))
+			continue;
+		if (size < 8)
+			return -ENOMEM;
+		if (put_user(SNDRV_CTL_TLVT_CHMAP_FIXED, dst) ||
+		    put_user(chs_bytes, dst + 1))
+			return -EFAULT;
+		dst += 2;
+		size -= 8;
+		count += 8;
+		if (size < chs_bytes)
+			return -ENOMEM;
+		size -= chs_bytes;
+		count += chs_bytes;
+		for (c = 0; c < map->channels; c++) {
+			if (put_user(map->map[c], dst))
+				return -EFAULT;
+			dst++;
+		}
+	}
+	if (put_user(count, tlv + 1))
+		return -EFAULT;
+	return 0;
+}
+
+static void pcm_chmap_ctl_private_free(struct snd_kcontrol *kcontrol)
+{
+	struct snd_pcm_chmap *info = snd_kcontrol_chip(kcontrol);
+	info->pcm->streams[info->stream].chmap_kctl = NULL;
+	kfree(info);
+}
+
+/**
+ * snd_pcm_add_chmap_ctls - create channel-mapping control elements
+ * @pcm: the assigned PCM instance
+ * @stream: stream direction
+ * @chmap: channel map elements (for query)
+ * @max_channels: the max number of channels for the stream
+ * @private_value: the value passed to each kcontrol's private_value field
+ * @info_ret: store struct snd_pcm_chmap instance if non-NULL
+ *
+ * Create channel-mapping control elements assigned to the given PCM stream(s).
+ * Returns zero if succeed, or a negative error value.
+ */
+int snd_pcm_add_chmap_ctls(struct snd_pcm *pcm, int stream,
+			   const struct snd_pcm_chmap_elem *chmap,
+			   int max_channels,
+			   unsigned long private_value,
+			   struct snd_pcm_chmap **info_ret)
+{
+	struct snd_pcm_chmap *info;
+	struct snd_kcontrol_new knew = {
+		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
+		.access = SNDRV_CTL_ELEM_ACCESS_READ |
+			SNDRV_CTL_ELEM_ACCESS_TLV_READ |
+			SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK,
+		.info = pcm_chmap_ctl_info,
+		.get = pcm_chmap_ctl_get,
+		.tlv.c = pcm_chmap_ctl_tlv,
+	};
+	int err;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+	info->pcm = pcm;
+	info->stream = stream;
+	info->chmap = chmap;
+	info->max_channels = max_channels;
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+		knew.name = "Playback Channel Map";
+	else
+		knew.name = "Capture Channel Map";
+	knew.device = pcm->device;
+	knew.count = pcm->streams[stream].substream_count;
+	knew.private_value = private_value;
+	info->kctl = snd_ctl_new1(&knew, info);
+	if (!info->kctl) {
+		kfree(info);
+		return -ENOMEM;
+	}
+	info->kctl->private_free = pcm_chmap_ctl_private_free;
+	err = snd_ctl_add(pcm->card, info->kctl);
+	if (err < 0)
+		return err;
+	pcm->streams[stream].chmap_kctl = info->kctl;
+	if (info_ret)
+		*info_ret = info;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_pcm_add_chmap_ctls);
-- 
1.7.9.5
