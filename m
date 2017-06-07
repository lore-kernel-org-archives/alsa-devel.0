From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/2] ALSA: fireface: constify ALSA specific
	operations
Date: Wed,  7 Jun 2017 09:38:06 +0900
Message-ID: <20170607003806.27196-3-o-takashi@sakamocchi.jp>
References: <20170607003806.27196-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id C748F26717C
 for <alsa-devel@alsa-project.org>; Wed,  7 Jun 2017 02:38:11 +0200 (CEST)
In-Reply-To: <20170607003806.27196-1-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

ALSA fireface driver has ALSA specific operations for MIDI/PCM data.
Structured data for the operations can be constified. Additionally,
The structured data can be function local.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/ff-midi.c | 22 ++++++++---------
 sound/firewire/fireface/ff-pcm.c  | 52 +++++++++++++++++++--------------------
 2 files changed, 35 insertions(+), 39 deletions(-)

diff --git a/sound/firewire/fireface/ff-midi.c b/sound/firewire/fireface/ff-midi.c
index 29ee0a7365c3..949ee56b4e0e 100644
--- a/sound/firewire/fireface/ff-midi.c
+++ b/sound/firewire/fireface/ff-midi.c
@@ -74,18 +74,6 @@ static void midi_playback_trigger(struct snd_rawmidi_substream *substream,
 	spin_unlock_irqrestore(&ff->lock, flags);
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
 static void set_midi_substream_names(struct snd_rawmidi_str *stream,
 				     const char *const name)
 {
@@ -99,6 +87,16 @@ static void set_midi_substream_names(struct snd_rawmidi_str *stream,
 
 int snd_ff_create_midi_devices(struct snd_ff *ff)
 {
+	static const struct snd_rawmidi_ops midi_capture_ops = {
+		.open		= midi_capture_open,
+		.close		= midi_capture_close,
+		.trigger	= midi_capture_trigger,
+	};
+	static const struct snd_rawmidi_ops midi_playback_ops = {
+		.open		= midi_playback_open,
+		.close		= midi_playback_close,
+		.trigger	= midi_playback_trigger,
+	};
 	struct snd_rawmidi *rmidi;
 	struct snd_rawmidi_str *stream;
 	int err;
diff --git a/sound/firewire/fireface/ff-pcm.c b/sound/firewire/fireface/ff-pcm.c
index adb5c87f492f..ad974b5a2561 100644
--- a/sound/firewire/fireface/ff-pcm.c
+++ b/sound/firewire/fireface/ff-pcm.c
@@ -379,35 +379,33 @@ static int pcm_playback_ack(struct snd_pcm_substream *substream)
 	return amdtp_stream_pcm_ack(&ff->rx_stream);
 }
 
-static struct snd_pcm_ops pcm_capture_ops = {
-	.open		= pcm_open,
-	.close		= pcm_close,
-	.ioctl		= snd_pcm_lib_ioctl,
-	.hw_params	= pcm_capture_hw_params,
-	.hw_free	= pcm_capture_hw_free,
-	.prepare	= pcm_capture_prepare,
-	.trigger	= pcm_capture_trigger,
-	.pointer	= pcm_capture_pointer,
-	.ack		= pcm_capture_ack,
-	.page		= snd_pcm_lib_get_vmalloc_page,
-};
-
-static struct snd_pcm_ops pcm_playback_ops = {
-	.open		= pcm_open,
-	.close		= pcm_close,
-	.ioctl		= snd_pcm_lib_ioctl,
-	.hw_params	= pcm_playback_hw_params,
-	.hw_free	= pcm_playback_hw_free,
-	.prepare	= pcm_playback_prepare,
-	.trigger	= pcm_playback_trigger,
-	.pointer	= pcm_playback_pointer,
-	.ack		= pcm_playback_ack,
-	.page		= snd_pcm_lib_get_vmalloc_page,
-	.mmap		= snd_pcm_lib_mmap_vmalloc,
-};
-
 int snd_ff_create_pcm_devices(struct snd_ff *ff)
 {
+	static const struct snd_pcm_ops pcm_capture_ops = {
+		.open		= pcm_open,
+		.close		= pcm_close,
+		.ioctl		= snd_pcm_lib_ioctl,
+		.hw_params	= pcm_capture_hw_params,
+		.hw_free	= pcm_capture_hw_free,
+		.prepare	= pcm_capture_prepare,
+		.trigger	= pcm_capture_trigger,
+		.pointer	= pcm_capture_pointer,
+		.ack		= pcm_capture_ack,
+		.page		= snd_pcm_lib_get_vmalloc_page,
+	};
+	static const struct snd_pcm_ops pcm_playback_ops = {
+		.open		= pcm_open,
+		.close		= pcm_close,
+		.ioctl		= snd_pcm_lib_ioctl,
+		.hw_params	= pcm_playback_hw_params,
+		.hw_free	= pcm_playback_hw_free,
+		.prepare	= pcm_playback_prepare,
+		.trigger	= pcm_playback_trigger,
+		.pointer	= pcm_playback_pointer,
+		.ack		= pcm_playback_ack,
+		.page		= snd_pcm_lib_get_vmalloc_page,
+		.mmap		= snd_pcm_lib_mmap_vmalloc,
+	};
 	struct snd_pcm *pcm;
 	int err;
 
-- 
2.11.0
