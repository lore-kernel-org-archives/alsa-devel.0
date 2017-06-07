From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/2] ALSA: firewire: process packets in 'struct
	snd_pcm_ops.ack' callback
Date: Wed,  7 Jun 2017 09:38:05 +0900
Message-ID: <20170607003806.27196-2-o-takashi@sakamocchi.jp>
References: <20170607003806.27196-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id C76AC26718A
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

In recent commit for ALSA PCM core, some arrangement is done for
'struct snd_pcm_ops.ack' callback. This is called when appl_ptr is
explicitly moved in intermediate buffer for PCM frames, except for
some cases described later.

For drivers in ALSA firewire stack, usage of this callback has a merit to
reduce latency between time of PCM frame queueing and handling actual
packets in recent isochronous cycle, because no need to wait for software
IRQ context from isochronous context of OHCI 1394.

If this works well in a case that mapped page frame is used for the
intermediate buffer, user process should execute some commands for ioctl(2)
to tell the number of handled PCM frames in the intermediate buffer just
after handling them. Therefore, at present, with a combination of below
conditions, this doesn't work as expected and user process should wait for
the software IRQ context as usual:
 - when ALSA PCM core judges page frame mapping is available for status
   data (struct snd_pcm_mmap_status) and control data
   (struct snd_pcm_mmap_control).
 - user process handles PCM frames by loop just with 'snd_pcm_mmap_begin()'
   and 'snd_pcm_mmap_commit()'.
 - user process uses PCM hw plugin in alsa-lib to operate I/O without
   'sync_ptr_ioctl' option.

Unfortunately, major use case include these three conditions.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c            | 19 +++++++++++++++++++
 sound/firewire/amdtp-stream.h            |  1 +
 sound/firewire/bebob/bebob_pcm.c         | 16 ++++++++++++++++
 sound/firewire/dice/dice-pcm.c           | 18 ++++++++++++++++++
 sound/firewire/digi00x/digi00x-pcm.c     | 16 ++++++++++++++++
 sound/firewire/fireface/ff-pcm.c         | 16 ++++++++++++++++
 sound/firewire/fireworks/fireworks_pcm.c | 16 ++++++++++++++++
 sound/firewire/motu/motu-pcm.c           | 16 ++++++++++++++++
 sound/firewire/oxfw/oxfw-pcm.c           | 16 ++++++++++++++++
 sound/firewire/tascam/tascam-pcm.c       | 16 ++++++++++++++++
 10 files changed, 150 insertions(+)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 9e6f54f8c45d..4316d9db404d 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -929,6 +929,25 @@ unsigned long amdtp_stream_pcm_pointer(struct amdtp_stream *s)
 EXPORT_SYMBOL(amdtp_stream_pcm_pointer);
 
 /**
+ * amdtp_stream_pcm_ack - acknowledge queued PCM frames
+ * @s: the AMDTP stream that transfers the PCM frames
+ *
+ * Returns zero always.
+ */
+int amdtp_stream_pcm_ack(struct amdtp_stream *s)
+{
+	/*
+	 * Process isochronous packets for recent isochronous cycle to handle
+	 * queued PCM frames.
+	 */
+	if (amdtp_stream_running(s))
+		fw_iso_context_flush_completions(s->context);
+
+	return 0;
+}
+EXPORT_SYMBOL(amdtp_stream_pcm_ack);
+
+/**
  * amdtp_stream_update - update the stream after a bus reset
  * @s: the AMDTP stream
  */
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index 7e8831722821..6d613f2eb612 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -168,6 +168,7 @@ int amdtp_stream_add_pcm_hw_constraints(struct amdtp_stream *s,
 
 void amdtp_stream_pcm_prepare(struct amdtp_stream *s);
 unsigned long amdtp_stream_pcm_pointer(struct amdtp_stream *s);
+int amdtp_stream_pcm_ack(struct amdtp_stream *s);
 void amdtp_stream_pcm_abort(struct amdtp_stream *s);
 
 extern const unsigned int amdtp_syt_intervals[CIP_SFC_COUNT];
diff --git a/sound/firewire/bebob/bebob_pcm.c b/sound/firewire/bebob/bebob_pcm.c
index e2f023f3cd9f..657e15a27e5c 100644
--- a/sound/firewire/bebob/bebob_pcm.c
+++ b/sound/firewire/bebob/bebob_pcm.c
@@ -355,6 +355,20 @@ pcm_playback_pointer(struct snd_pcm_substream *sbstrm)
 	return amdtp_stream_pcm_pointer(&bebob->rx_stream);
 }
 
+static int pcm_capture_ack(struct snd_pcm_substream *substream)
+{
+	struct snd_bebob *bebob = substream->private_data;
+
+	return amdtp_stream_pcm_ack(&bebob->tx_stream);
+}
+
+static int pcm_playback_ack(struct snd_pcm_substream *substream)
+{
+	struct snd_bebob *bebob = substream->private_data;
+
+	return amdtp_stream_pcm_ack(&bebob->rx_stream);
+}
+
 int snd_bebob_create_pcm_devices(struct snd_bebob *bebob)
 {
 	static const struct snd_pcm_ops capture_ops = {
@@ -366,6 +380,7 @@ int snd_bebob_create_pcm_devices(struct snd_bebob *bebob)
 		.prepare	= pcm_capture_prepare,
 		.trigger	= pcm_capture_trigger,
 		.pointer	= pcm_capture_pointer,
+		.ack		= pcm_capture_ack,
 		.page		= snd_pcm_lib_get_vmalloc_page,
 	};
 	static const struct snd_pcm_ops playback_ops = {
@@ -377,6 +392,7 @@ int snd_bebob_create_pcm_devices(struct snd_bebob *bebob)
 		.prepare	= pcm_playback_prepare,
 		.trigger	= pcm_playback_trigger,
 		.pointer	= pcm_playback_pointer,
+		.ack		= pcm_playback_ack,
 		.page		= snd_pcm_lib_get_vmalloc_page,
 		.mmap		= snd_pcm_lib_mmap_vmalloc,
 	};
diff --git a/sound/firewire/dice/dice-pcm.c b/sound/firewire/dice/dice-pcm.c
index b633805a885f..2dda74695069 100644
--- a/sound/firewire/dice/dice-pcm.c
+++ b/sound/firewire/dice/dice-pcm.c
@@ -294,6 +294,22 @@ static snd_pcm_uframes_t playback_pointer(struct snd_pcm_substream *substream)
 	return amdtp_stream_pcm_pointer(stream);
 }
 
+static int capture_ack(struct snd_pcm_substream *substream)
+{
+	struct snd_dice *dice = substream->private_data;
+	struct amdtp_stream *stream = &dice->tx_stream[substream->pcm->device];
+
+	return amdtp_stream_pcm_ack(stream);
+}
+
+static int playback_ack(struct snd_pcm_substream *substream)
+{
+	struct snd_dice *dice = substream->private_data;
+	struct amdtp_stream *stream = &dice->rx_stream[substream->pcm->device];
+
+	return amdtp_stream_pcm_ack(stream);
+}
+
 int snd_dice_create_pcm(struct snd_dice *dice)
 {
 	static const struct snd_pcm_ops capture_ops = {
@@ -305,6 +321,7 @@ int snd_dice_create_pcm(struct snd_dice *dice)
 		.prepare   = capture_prepare,
 		.trigger   = capture_trigger,
 		.pointer   = capture_pointer,
+		.ack       = capture_ack,
 		.page      = snd_pcm_lib_get_vmalloc_page,
 		.mmap      = snd_pcm_lib_mmap_vmalloc,
 	};
@@ -317,6 +334,7 @@ int snd_dice_create_pcm(struct snd_dice *dice)
 		.prepare   = playback_prepare,
 		.trigger   = playback_trigger,
 		.pointer   = playback_pointer,
+		.ack       = playback_ack,
 		.page      = snd_pcm_lib_get_vmalloc_page,
 		.mmap      = snd_pcm_lib_mmap_vmalloc,
 	};
diff --git a/sound/firewire/digi00x/digi00x-pcm.c b/sound/firewire/digi00x/digi00x-pcm.c
index 6379f67416d7..f76cf5e383db 100644
--- a/sound/firewire/digi00x/digi00x-pcm.c
+++ b/sound/firewire/digi00x/digi00x-pcm.c
@@ -324,6 +324,20 @@ static snd_pcm_uframes_t pcm_playback_pointer(struct snd_pcm_substream *sbstrm)
 	return amdtp_stream_pcm_pointer(&dg00x->rx_stream);
 }
 
+static int pcm_capture_ack(struct snd_pcm_substream *substream)
+{
+	struct snd_dg00x *dg00x = substream->private_data;
+
+	return amdtp_stream_pcm_ack(&dg00x->tx_stream);
+}
+
+static int pcm_playback_ack(struct snd_pcm_substream *substream)
+{
+	struct snd_dg00x *dg00x = substream->private_data;
+
+	return amdtp_stream_pcm_ack(&dg00x->rx_stream);
+}
+
 int snd_dg00x_create_pcm_devices(struct snd_dg00x *dg00x)
 {
 	static const struct snd_pcm_ops capture_ops = {
@@ -335,6 +349,7 @@ int snd_dg00x_create_pcm_devices(struct snd_dg00x *dg00x)
 		.prepare	= pcm_capture_prepare,
 		.trigger	= pcm_capture_trigger,
 		.pointer	= pcm_capture_pointer,
+		.ack		= pcm_capture_ack,
 		.page		= snd_pcm_lib_get_vmalloc_page,
 	};
 	static const struct snd_pcm_ops playback_ops = {
@@ -346,6 +361,7 @@ int snd_dg00x_create_pcm_devices(struct snd_dg00x *dg00x)
 		.prepare	= pcm_playback_prepare,
 		.trigger	= pcm_playback_trigger,
 		.pointer	= pcm_playback_pointer,
+		.ack		= pcm_playback_ack,
 		.page		= snd_pcm_lib_get_vmalloc_page,
 		.mmap		= snd_pcm_lib_mmap_vmalloc,
 	};
diff --git a/sound/firewire/fireface/ff-pcm.c b/sound/firewire/fireface/ff-pcm.c
index 93cee1978e8e..adb5c87f492f 100644
--- a/sound/firewire/fireface/ff-pcm.c
+++ b/sound/firewire/fireface/ff-pcm.c
@@ -365,6 +365,20 @@ static snd_pcm_uframes_t pcm_playback_pointer(struct snd_pcm_substream *sbstrm)
 	return amdtp_stream_pcm_pointer(&ff->rx_stream);
 }
 
+static int pcm_capture_ack(struct snd_pcm_substream *substream)
+{
+	struct snd_ff *ff = substream->private_data;
+
+	return amdtp_stream_pcm_ack(&ff->tx_stream);
+}
+
+static int pcm_playback_ack(struct snd_pcm_substream *substream)
+{
+	struct snd_ff *ff = substream->private_data;
+
+	return amdtp_stream_pcm_ack(&ff->rx_stream);
+}
+
 static struct snd_pcm_ops pcm_capture_ops = {
 	.open		= pcm_open,
 	.close		= pcm_close,
@@ -374,6 +388,7 @@ static struct snd_pcm_ops pcm_capture_ops = {
 	.prepare	= pcm_capture_prepare,
 	.trigger	= pcm_capture_trigger,
 	.pointer	= pcm_capture_pointer,
+	.ack		= pcm_capture_ack,
 	.page		= snd_pcm_lib_get_vmalloc_page,
 };
 
@@ -386,6 +401,7 @@ static struct snd_pcm_ops pcm_playback_ops = {
 	.prepare	= pcm_playback_prepare,
 	.trigger	= pcm_playback_trigger,
 	.pointer	= pcm_playback_pointer,
+	.ack		= pcm_playback_ack,
 	.page		= snd_pcm_lib_get_vmalloc_page,
 	.mmap		= snd_pcm_lib_mmap_vmalloc,
 };
diff --git a/sound/firewire/fireworks/fireworks_pcm.c b/sound/firewire/fireworks/fireworks_pcm.c
index f10aec117998..346e2647ed1f 100644
--- a/sound/firewire/fireworks/fireworks_pcm.c
+++ b/sound/firewire/fireworks/fireworks_pcm.c
@@ -379,6 +379,20 @@ static snd_pcm_uframes_t pcm_playback_pointer(struct snd_pcm_substream *sbstrm)
 	return amdtp_stream_pcm_pointer(&efw->rx_stream);
 }
 
+static int pcm_capture_ack(struct snd_pcm_substream *substream)
+{
+	struct snd_efw *efw = substream->private_data;
+
+	return amdtp_stream_pcm_ack(&efw->tx_stream);
+}
+
+static int pcm_playback_ack(struct snd_pcm_substream *substream)
+{
+	struct snd_efw *efw = substream->private_data;
+
+	return amdtp_stream_pcm_ack(&efw->rx_stream);
+}
+
 int snd_efw_create_pcm_devices(struct snd_efw *efw)
 {
 	static const struct snd_pcm_ops capture_ops = {
@@ -390,6 +404,7 @@ int snd_efw_create_pcm_devices(struct snd_efw *efw)
 		.prepare	= pcm_capture_prepare,
 		.trigger	= pcm_capture_trigger,
 		.pointer	= pcm_capture_pointer,
+		.ack		= pcm_capture_ack,
 		.page		= snd_pcm_lib_get_vmalloc_page,
 	};
 	static const struct snd_pcm_ops playback_ops = {
@@ -401,6 +416,7 @@ int snd_efw_create_pcm_devices(struct snd_efw *efw)
 		.prepare	= pcm_playback_prepare,
 		.trigger	= pcm_playback_trigger,
 		.pointer	= pcm_playback_pointer,
+		.ack		= pcm_playback_ack,
 		.page		= snd_pcm_lib_get_vmalloc_page,
 		.mmap		= snd_pcm_lib_mmap_vmalloc,
 	};
diff --git a/sound/firewire/motu/motu-pcm.c b/sound/firewire/motu/motu-pcm.c
index 94558f3d218b..e3ef89cee565 100644
--- a/sound/firewire/motu/motu-pcm.c
+++ b/sound/firewire/motu/motu-pcm.c
@@ -356,6 +356,20 @@ static snd_pcm_uframes_t playback_pointer(struct snd_pcm_substream *substream)
 	return amdtp_stream_pcm_pointer(&motu->rx_stream);
 }
 
+static int capture_ack(struct snd_pcm_substream *substream)
+{
+	struct snd_motu *motu = substream->private_data;
+
+	return amdtp_stream_pcm_ack(&motu->tx_stream);
+}
+
+static int playback_ack(struct snd_pcm_substream *substream)
+{
+	struct snd_motu *motu = substream->private_data;
+
+	return amdtp_stream_pcm_ack(&motu->rx_stream);
+}
+
 int snd_motu_create_pcm_devices(struct snd_motu *motu)
 {
 	static struct snd_pcm_ops capture_ops = {
@@ -367,6 +381,7 @@ int snd_motu_create_pcm_devices(struct snd_motu *motu)
 		.prepare   = capture_prepare,
 		.trigger   = capture_trigger,
 		.pointer   = capture_pointer,
+		.ack       = capture_ack,
 		.page      = snd_pcm_lib_get_vmalloc_page,
 		.mmap      = snd_pcm_lib_mmap_vmalloc,
 	};
@@ -379,6 +394,7 @@ int snd_motu_create_pcm_devices(struct snd_motu *motu)
 		.prepare   = playback_prepare,
 		.trigger   = playback_trigger,
 		.pointer   = playback_pointer,
+		.ack       = playback_ack,
 		.page      = snd_pcm_lib_get_vmalloc_page,
 		.mmap      = snd_pcm_lib_mmap_vmalloc,
 	};
diff --git a/sound/firewire/oxfw/oxfw-pcm.c b/sound/firewire/oxfw/oxfw-pcm.c
index d4594f7115ae..bc1a3a36ab06 100644
--- a/sound/firewire/oxfw/oxfw-pcm.c
+++ b/sound/firewire/oxfw/oxfw-pcm.c
@@ -382,6 +382,20 @@ static snd_pcm_uframes_t pcm_playback_pointer(struct snd_pcm_substream *sbstm)
 	return amdtp_stream_pcm_pointer(&oxfw->rx_stream);
 }
 
+static int pcm_capture_ack(struct snd_pcm_substream *substream)
+{
+	struct snd_oxfw *oxfw = substream->private_data;
+
+	return amdtp_stream_pcm_ack(&oxfw->tx_stream);
+}
+
+static int pcm_playback_ack(struct snd_pcm_substream *substream)
+{
+	struct snd_oxfw *oxfw = substream->private_data;
+
+	return amdtp_stream_pcm_ack(&oxfw->rx_stream);
+}
+
 int snd_oxfw_create_pcm(struct snd_oxfw *oxfw)
 {
 	static const struct snd_pcm_ops capture_ops = {
@@ -393,6 +407,7 @@ int snd_oxfw_create_pcm(struct snd_oxfw *oxfw)
 		.prepare   = pcm_capture_prepare,
 		.trigger   = pcm_capture_trigger,
 		.pointer   = pcm_capture_pointer,
+		.ack       = pcm_capture_ack,
 		.page      = snd_pcm_lib_get_vmalloc_page,
 		.mmap      = snd_pcm_lib_mmap_vmalloc,
 	};
@@ -405,6 +420,7 @@ int snd_oxfw_create_pcm(struct snd_oxfw *oxfw)
 		.prepare   = pcm_playback_prepare,
 		.trigger   = pcm_playback_trigger,
 		.pointer   = pcm_playback_pointer,
+		.ack       = pcm_playback_ack,
 		.page      = snd_pcm_lib_get_vmalloc_page,
 		.mmap      = snd_pcm_lib_mmap_vmalloc,
 	};
diff --git a/sound/firewire/tascam/tascam-pcm.c b/sound/firewire/tascam/tascam-pcm.c
index 6207588d7c73..3c4482aa7231 100644
--- a/sound/firewire/tascam/tascam-pcm.c
+++ b/sound/firewire/tascam/tascam-pcm.c
@@ -263,6 +263,20 @@ static snd_pcm_uframes_t pcm_playback_pointer(struct snd_pcm_substream *sbstrm)
 	return amdtp_stream_pcm_pointer(&tscm->rx_stream);
 }
 
+static int pcm_capture_ack(struct snd_pcm_substream *substream)
+{
+	struct snd_tscm *tscm = substream->private_data;
+
+	return amdtp_stream_pcm_ack(&tscm->tx_stream);
+}
+
+static int pcm_playback_ack(struct snd_pcm_substream *substream)
+{
+	struct snd_tscm *tscm = substream->private_data;
+
+	return amdtp_stream_pcm_ack(&tscm->rx_stream);
+}
+
 int snd_tscm_create_pcm_devices(struct snd_tscm *tscm)
 {
 	static const struct snd_pcm_ops capture_ops = {
@@ -274,6 +288,7 @@ int snd_tscm_create_pcm_devices(struct snd_tscm *tscm)
 		.prepare	= pcm_capture_prepare,
 		.trigger	= pcm_capture_trigger,
 		.pointer	= pcm_capture_pointer,
+		.ack		= pcm_capture_ack,
 		.page		= snd_pcm_lib_get_vmalloc_page,
 	};
 	static const struct snd_pcm_ops playback_ops = {
@@ -285,6 +300,7 @@ int snd_tscm_create_pcm_devices(struct snd_tscm *tscm)
 		.prepare	= pcm_playback_prepare,
 		.trigger	= pcm_playback_trigger,
 		.pointer	= pcm_playback_pointer,
+		.ack		= pcm_playback_ack,
 		.page		= snd_pcm_lib_get_vmalloc_page,
 		.mmap		= snd_pcm_lib_mmap_vmalloc,
 	};
-- 
2.11.0
