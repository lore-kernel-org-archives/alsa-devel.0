From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 5/6] ALSA: firewire-digi00x: simplify symbol
	space for local linkage
Date: Tue,  3 Jan 2017 21:41:20 +0900
Message-ID: <20170103124121.17143-6-o-takashi@sakamocchi.jp>
References: <20170103124121.17143-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 56022266E40
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
 sound/firewire/digi00x/digi00x-hwdep.c | 17 ++++++-----
 sound/firewire/digi00x/digi00x-midi.c  | 52 ++++++++++++++++------------------
 sound/firewire/digi00x/digi00x-pcm.c   | 52 ++++++++++++++++------------------
 3 files changed, 57 insertions(+), 64 deletions(-)

diff --git a/sound/firewire/digi00x/digi00x-hwdep.c b/sound/firewire/digi00x/digi00x-hwdep.c
index f188e47..463c6b8 100644
--- a/sound/firewire/digi00x/digi00x-hwdep.c
+++ b/sound/firewire/digi00x/digi00x-hwdep.c
@@ -173,16 +173,15 @@ static int hwdep_compat_ioctl(struct snd_hwdep *hwdep, struct file *file,
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
 int snd_dg00x_create_hwdep_device(struct snd_dg00x *dg00x)
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
 
@@ -192,7 +191,7 @@ int snd_dg00x_create_hwdep_device(struct snd_dg00x *dg00x)
 
 	strcpy(hwdep->name, "Digi00x");
 	hwdep->iface = SNDRV_HWDEP_IFACE_FW_DIGI00X;
-	hwdep->ops = hwdep_ops;
+	hwdep->ops = ops;
 	hwdep->private_data = dg00x;
 	hwdep->exclusive = true;
 
diff --git a/sound/firewire/digi00x/digi00x-midi.c b/sound/firewire/digi00x/digi00x-midi.c
index 1a72a38..8689c3b 100644
--- a/sound/firewire/digi00x/digi00x-midi.c
+++ b/sound/firewire/digi00x/digi00x-midi.c
@@ -76,18 +76,6 @@ static void midi_phys_playback_trigger(struct snd_rawmidi_substream *substream,
 	spin_unlock_irqrestore(&dg00x->lock, flags);
 }
 
-static struct snd_rawmidi_ops midi_phys_capture_ops = {
-	.open		= midi_phys_open,
-	.close		= midi_phys_close,
-	.trigger	= midi_phys_capture_trigger,
-};
-
-static struct snd_rawmidi_ops midi_phys_playback_ops = {
-	.open		= midi_phys_open,
-	.close		= midi_phys_close,
-	.trigger	= midi_phys_playback_trigger,
-};
-
 static int midi_ctl_open(struct snd_rawmidi_substream *substream)
 {
 	/* Do nothing. */
@@ -139,18 +127,6 @@ static void midi_ctl_playback_trigger(struct snd_rawmidi_substream *substream,
 	spin_unlock_irqrestore(&dg00x->lock, flags);
 }
 
-static struct snd_rawmidi_ops midi_ctl_capture_ops = {
-	.open		= midi_ctl_open,
-	.close		= midi_ctl_capture_close,
-	.trigger	= midi_ctl_capture_trigger,
-};
-
-static struct snd_rawmidi_ops midi_ctl_playback_ops = {
-	.open		= midi_ctl_open,
-	.close		= midi_ctl_playback_close,
-	.trigger	= midi_ctl_playback_trigger,
-};
-
 static void set_midi_substream_names(struct snd_dg00x *dg00x,
 				     struct snd_rawmidi_str *str,
 				     bool is_ctl)
@@ -172,6 +148,26 @@ static void set_midi_substream_names(struct snd_dg00x *dg00x,
 
 int snd_dg00x_create_midi_devices(struct snd_dg00x *dg00x)
 {
+	static struct snd_rawmidi_ops phys_capture_ops = {
+		.open		= midi_phys_open,
+		.close		= midi_phys_close,
+		.trigger	= midi_phys_capture_trigger,
+	};
+	static struct snd_rawmidi_ops phys_playback_ops = {
+		.open		= midi_phys_open,
+		.close		= midi_phys_close,
+		.trigger	= midi_phys_playback_trigger,
+	};
+	static struct snd_rawmidi_ops ctl_capture_ops = {
+		.open		= midi_ctl_open,
+		.close		= midi_ctl_capture_close,
+		.trigger	= midi_ctl_capture_trigger,
+	};
+	static struct snd_rawmidi_ops ctl_playback_ops = {
+		.open		= midi_ctl_open,
+		.close		= midi_ctl_playback_close,
+		.trigger	= midi_ctl_playback_trigger,
+	};
 	struct snd_rawmidi *rmidi[2];
 	struct snd_rawmidi_str *str;
 	unsigned int i;
@@ -187,9 +183,9 @@ int snd_dg00x_create_midi_devices(struct snd_dg00x *dg00x)
 		 "%s MIDI", dg00x->card->shortname);
 
 	snd_rawmidi_set_ops(rmidi[0], SNDRV_RAWMIDI_STREAM_INPUT,
-			    &midi_phys_capture_ops);
+			    &phys_capture_ops);
 	snd_rawmidi_set_ops(rmidi[0], SNDRV_RAWMIDI_STREAM_OUTPUT,
-			    &midi_phys_playback_ops);
+			    &phys_playback_ops);
 
 	/* Add a pair of control midi ports. */
 	err = snd_rawmidi_new(dg00x->card, dg00x->card->driver, 1,
@@ -201,9 +197,9 @@ int snd_dg00x_create_midi_devices(struct snd_dg00x *dg00x)
 		 "%s control", dg00x->card->shortname);
 
 	snd_rawmidi_set_ops(rmidi[1], SNDRV_RAWMIDI_STREAM_INPUT,
-			    &midi_ctl_capture_ops);
+			    &ctl_capture_ops);
 	snd_rawmidi_set_ops(rmidi[1], SNDRV_RAWMIDI_STREAM_OUTPUT,
-			    &midi_ctl_playback_ops);
+			    &ctl_playback_ops);
 
 	for (i = 0; i < ARRAY_SIZE(rmidi); i++) {
 		rmidi[i]->private_data = dg00x;
diff --git a/sound/firewire/digi00x/digi00x-pcm.c b/sound/firewire/digi00x/digi00x-pcm.c
index 613f058..68d1c52 100644
--- a/sound/firewire/digi00x/digi00x-pcm.c
+++ b/sound/firewire/digi00x/digi00x-pcm.c
@@ -329,33 +329,31 @@ static snd_pcm_uframes_t pcm_playback_pointer(struct snd_pcm_substream *sbstrm)
 	return amdtp_stream_pcm_pointer(&dg00x->rx_stream);
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
 int snd_dg00x_create_pcm_devices(struct snd_dg00x *dg00x)
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
 
@@ -366,8 +364,8 @@ int snd_dg00x_create_pcm_devices(struct snd_dg00x *dg00x)
 	pcm->private_data = dg00x;
 	snprintf(pcm->name, sizeof(pcm->name),
 		 "%s PCM", dg00x->card->shortname);
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &pcm_playback_ops);
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &pcm_capture_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &playback_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &capture_ops);
 
 	return 0;
 }
-- 
2.9.3
