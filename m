From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 6/6] ALSA: firewire-tascam: simplify symbol
	space for local linkage
Date: Tue,  3 Jan 2017 21:41:21 +0900
Message-ID: <20170103124121.17143-7-o-takashi@sakamocchi.jp>
References: <20170103124121.17143-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 4A0A2266E37
 for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2017 13:41:34 +0100 (CET)
In-Reply-To: <20170103124121.17143-1-o-takashi@sakamocchi.jp>
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

This module has some implementations for operation structures which sound
subsystem defines. All of them are referred just by each local function to
register corresponding operations. In this case, it's better to put them
into the function local so that symbol space in local linkage of
translation unit is kept to be simple.

This commit moves such symbols to function local.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam-hwdep.c | 17 ++++++------
 sound/firewire/tascam/tascam-midi.c  | 26 +++++++++---------
 sound/firewire/tascam/tascam-pcm.c   | 52 +++++++++++++++++-------------------
 3 files changed, 45 insertions(+), 50 deletions(-)

diff --git a/sound/firewire/tascam/tascam-hwdep.c b/sound/firewire/tascam/tascam-hwdep.c
index 106406c..8c4437d 100644
--- a/sound/firewire/tascam/tascam-hwdep.c
+++ b/sound/firewire/tascam/tascam-hwdep.c
@@ -163,16 +163,15 @@ static int hwdep_compat_ioctl(struct snd_hwdep *hwdep, struct file *file,
 #define hwdep_compat_ioctl NULL
 #endif
 
-static const struct snd_hwdep_ops hwdep_ops = {
-	.read		= hwdep_read,
-	.release	= hwdep_release,
-	.poll		= hwdep_poll,
-	.ioctl		= hwdep_ioctl,
-	.ioctl_compat	= hwdep_compat_ioctl,
-};
-
 int snd_tscm_create_hwdep_device(struct snd_tscm *tscm)
 {
+	static const struct snd_hwdep_ops ops = {
+		.read		= hwdep_read,
+		.release	= hwdep_release,
+		.poll		= hwdep_poll,
+		.ioctl		= hwdep_ioctl,
+		.ioctl_compat	= hwdep_compat_ioctl,
+	};
 	struct snd_hwdep *hwdep;
 	int err;
 
@@ -182,7 +181,7 @@ int snd_tscm_create_hwdep_device(struct snd_tscm *tscm)
 
 	strcpy(hwdep->name, "Tascam");
 	hwdep->iface = SNDRV_HWDEP_IFACE_FW_TASCAM;
-	hwdep->ops = hwdep_ops;
+	hwdep->ops = ops;
 	hwdep->private_data = tscm;
 	hwdep->exclusive = true;
 
diff --git a/sound/firewire/tascam/tascam-midi.c b/sound/firewire/tascam/tascam-midi.c
index 41f8420..7fdc71e 100644
--- a/sound/firewire/tascam/tascam-midi.c
+++ b/sound/firewire/tascam/tascam-midi.c
@@ -68,20 +68,18 @@ static void midi_playback_trigger(struct snd_rawmidi_substream *substrm, int up)
 	spin_unlock_irqrestore(&tscm->lock, flags);
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
 int snd_tscm_create_midi_devices(struct snd_tscm *tscm)
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
 	struct snd_rawmidi_str *stream;
 	struct snd_rawmidi_substream *subs;
@@ -100,7 +98,7 @@ int snd_tscm_create_midi_devices(struct snd_tscm *tscm)
 
 	rmidi->info_flags |= SNDRV_RAWMIDI_INFO_INPUT;
 	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT,
-			    &midi_capture_ops);
+			    &capture_ops);
 	stream = &rmidi->streams[SNDRV_RAWMIDI_STREAM_INPUT];
 
 	/* Set port names for MIDI input. */
@@ -116,7 +114,7 @@ int snd_tscm_create_midi_devices(struct snd_tscm *tscm)
 
 	rmidi->info_flags |= SNDRV_RAWMIDI_INFO_OUTPUT;
 	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT,
-			    &midi_playback_ops);
+			    &playback_ops);
 	stream = &rmidi->streams[SNDRV_RAWMIDI_STREAM_OUTPUT];
 
 	/* Set port names for MIDI ourput. */
diff --git a/sound/firewire/tascam/tascam-pcm.c b/sound/firewire/tascam/tascam-pcm.c
index 79db1b6..f5dd6ce 100644
--- a/sound/firewire/tascam/tascam-pcm.c
+++ b/sound/firewire/tascam/tascam-pcm.c
@@ -268,33 +268,31 @@ static snd_pcm_uframes_t pcm_playback_pointer(struct snd_pcm_substream *sbstrm)
 	return amdtp_stream_pcm_pointer(&tscm->rx_stream);
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
 int snd_tscm_create_pcm_devices(struct snd_tscm *tscm)
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
 
@@ -305,8 +303,8 @@ int snd_tscm_create_pcm_devices(struct snd_tscm *tscm)
 	pcm->private_data = tscm;
 	snprintf(pcm->name, sizeof(pcm->name),
 		 "%s PCM", tscm->card->shortname);
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &pcm_playback_ops);
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &pcm_capture_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &playback_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &capture_ops);
 
 	return 0;
 }
-- 
2.9.3
