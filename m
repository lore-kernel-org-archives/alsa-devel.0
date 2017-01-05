From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 2/6] ALSA: fireworks: enclose identifiers
	referred by single function
Date: Thu,  5 Jan 2017 21:48:08 +0900
Message-ID: <20170105124812.11283-3-o-takashi@sakamocchi.jp>
References: <20170105124812.11283-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id E5632266C99
 for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2017 13:48:17 +0100 (CET)
In-Reply-To: <20170105124812.11283-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Some identifiers are referred just by one functions. In this case, they
can be put into the function definition. This brings two merits; readers
can easily follow codes related to the identifiers, developers are free
from name conflict.

This commit moves such identifiers to each function definition.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireworks/fireworks_hwdep.c | 19 ++++++-----
 sound/firewire/fireworks/fireworks_midi.c  | 26 +++++++--------
 sound/firewire/fireworks/fireworks_pcm.c   | 52 ++++++++++++++----------------
 3 files changed, 46 insertions(+), 51 deletions(-)

diff --git a/sound/firewire/fireworks/fireworks_hwdep.c b/sound/firewire/fireworks/fireworks_hwdep.c
index 2e1d9a2..a3a3a16 100644
--- a/sound/firewire/fireworks/fireworks_hwdep.c
+++ b/sound/firewire/fireworks/fireworks_hwdep.c
@@ -303,17 +303,16 @@ hwdep_compat_ioctl(struct snd_hwdep *hwdep, struct file *file,
 #define hwdep_compat_ioctl NULL
 #endif
 
-static const struct snd_hwdep_ops hwdep_ops = {
-	.read		= hwdep_read,
-	.write		= hwdep_write,
-	.release	= hwdep_release,
-	.poll		= hwdep_poll,
-	.ioctl		= hwdep_ioctl,
-	.ioctl_compat	= hwdep_compat_ioctl,
-};
-
 int snd_efw_create_hwdep_device(struct snd_efw *efw)
 {
+	static const struct snd_hwdep_ops ops = {
+		.read		= hwdep_read,
+		.write		= hwdep_write,
+		.release	= hwdep_release,
+		.poll		= hwdep_poll,
+		.ioctl		= hwdep_ioctl,
+		.ioctl_compat	= hwdep_compat_ioctl,
+	};
 	struct snd_hwdep *hwdep;
 	int err;
 
@@ -322,7 +321,7 @@ int snd_efw_create_hwdep_device(struct snd_efw *efw)
 		goto end;
 	strcpy(hwdep->name, "Fireworks");
 	hwdep->iface = SNDRV_HWDEP_IFACE_FW_FIREWORKS;
-	hwdep->ops = hwdep_ops;
+	hwdep->ops = ops;
 	hwdep->private_data = efw;
 	hwdep->exclusive = true;
 end:
diff --git a/sound/firewire/fireworks/fireworks_midi.c b/sound/firewire/fireworks/fireworks_midi.c
index 3e8c4cf..2873eca 100644
--- a/sound/firewire/fireworks/fireworks_midi.c
+++ b/sound/firewire/fireworks/fireworks_midi.c
@@ -107,18 +107,6 @@ static void midi_playback_trigger(struct snd_rawmidi_substream *substrm, int up)
 	spin_unlock_irqrestore(&efw->lock, flags);
 }
 
-static struct snd_rawmidi_ops midi_capture_ops = {
-	.open		= midi_capture_open,
-	.close		= midi_capture_close,
-	.trigger	= midi_capture_trigger,
-};
-
-static struct snd_rawmidi_ops midi_playback_ops = {
-	.open		= midi_playback_open,
-	.close		= midi_playback_close,
-	.trigger	= midi_playback_trigger,
-};
-
 static void set_midi_substream_names(struct snd_efw *efw,
 				     struct snd_rawmidi_str *str)
 {
@@ -132,6 +120,16 @@ static void set_midi_substream_names(struct snd_efw *efw,
 
 int snd_efw_create_midi_devices(struct snd_efw *efw)
 {
+	static struct snd_rawmidi_ops capture_ops = {
+		.open		= midi_capture_open,
+		.close		= midi_capture_close,
+		.trigger	= midi_capture_trigger,
+	};
+	static struct snd_rawmidi_ops playback_ops = {
+		.open		= midi_playback_open,
+		.close		= midi_playback_close,
+		.trigger	= midi_playback_trigger,
+	};
 	struct snd_rawmidi *rmidi;
 	struct snd_rawmidi_str *str;
 	int err;
@@ -151,7 +149,7 @@ int snd_efw_create_midi_devices(struct snd_efw *efw)
 		rmidi->info_flags |= SNDRV_RAWMIDI_INFO_INPUT;
 
 		snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT,
-				    &midi_capture_ops);
+				    &capture_ops);
 
 		str = &rmidi->streams[SNDRV_RAWMIDI_STREAM_INPUT];
 
@@ -162,7 +160,7 @@ int snd_efw_create_midi_devices(struct snd_efw *efw)
 		rmidi->info_flags |= SNDRV_RAWMIDI_INFO_OUTPUT;
 
 		snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT,
-				    &midi_playback_ops);
+				    &playback_ops);
 
 		str = &rmidi->streams[SNDRV_RAWMIDI_STREAM_OUTPUT];
 
diff --git a/sound/firewire/fireworks/fireworks_pcm.c b/sound/firewire/fireworks/fireworks_pcm.c
index f4fbf75..9171702 100644
--- a/sound/firewire/fireworks/fireworks_pcm.c
+++ b/sound/firewire/fireworks/fireworks_pcm.c
@@ -383,33 +383,31 @@ static snd_pcm_uframes_t pcm_playback_pointer(struct snd_pcm_substream *sbstrm)
 	return amdtp_stream_pcm_pointer(&efw->rx_stream);
 }
 
-static const struct snd_pcm_ops pcm_capture_ops = {
-	.open		= pcm_open,
-	.close		= pcm_close,
-	.ioctl		= snd_pcm_lib_ioctl,
-	.hw_params	= pcm_capture_hw_params,
-	.hw_free	= pcm_capture_hw_free,
-	.prepare	= pcm_capture_prepare,
-	.trigger	= pcm_capture_trigger,
-	.pointer	= pcm_capture_pointer,
-	.page		= snd_pcm_lib_get_vmalloc_page,
-};
-
-static const struct snd_pcm_ops pcm_playback_ops = {
-	.open		= pcm_open,
-	.close		= pcm_close,
-	.ioctl		= snd_pcm_lib_ioctl,
-	.hw_params	= pcm_playback_hw_params,
-	.hw_free	= pcm_playback_hw_free,
-	.prepare	= pcm_playback_prepare,
-	.trigger	= pcm_playback_trigger,
-	.pointer	= pcm_playback_pointer,
-	.page		= snd_pcm_lib_get_vmalloc_page,
-	.mmap		= snd_pcm_lib_mmap_vmalloc,
-};
-
 int snd_efw_create_pcm_devices(struct snd_efw *efw)
 {
+	static const struct snd_pcm_ops capture_ops = {
+		.open		= pcm_open,
+		.close		= pcm_close,
+		.ioctl		= snd_pcm_lib_ioctl,
+		.hw_params	= pcm_capture_hw_params,
+		.hw_free	= pcm_capture_hw_free,
+		.prepare	= pcm_capture_prepare,
+		.trigger	= pcm_capture_trigger,
+		.pointer	= pcm_capture_pointer,
+		.page		= snd_pcm_lib_get_vmalloc_page,
+	};
+	static const struct snd_pcm_ops playback_ops = {
+		.open		= pcm_open,
+		.close		= pcm_close,
+		.ioctl		= snd_pcm_lib_ioctl,
+		.hw_params	= pcm_playback_hw_params,
+		.hw_free	= pcm_playback_hw_free,
+		.prepare	= pcm_playback_prepare,
+		.trigger	= pcm_playback_trigger,
+		.pointer	= pcm_playback_pointer,
+		.page		= snd_pcm_lib_get_vmalloc_page,
+		.mmap		= snd_pcm_lib_mmap_vmalloc,
+	};
 	struct snd_pcm *pcm;
 	int err;
 
@@ -419,8 +417,8 @@ int snd_efw_create_pcm_devices(struct snd_efw *efw)
 
 	pcm->private_data = efw;
 	snprintf(pcm->name, sizeof(pcm->name), "%s PCM", efw->card->shortname);
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &pcm_playback_ops);
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &pcm_capture_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &playback_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &capture_ops);
 end:
 	return err;
 }
-- 
2.9.3
