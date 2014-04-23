From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: [PATCH] Fix forward/rewind support in iec958 plugin
Date: Thu, 24 Apr 2014 00:40:27 +0600
Message-ID: <1398278427-10637-1-git-send-email-patrakov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
 [209.85.217.179])
 by alsa0.perex.cz (Postfix) with ESMTP id A27192650DD
 for <alsa-devel@alsa-project.org>; Wed, 23 Apr 2014 20:43:49 +0200 (CEST)
Received: by mail-lb0-f179.google.com with SMTP id q8so1146226lbi.10
 for <alsa-devel@alsa-project.org>; Wed, 23 Apr 2014 11:43:49 -0700 (PDT)
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
Cc: tiwai@suse.de, "Alexander E. Patrakov" <patrakov@gmail.com>
List-Id: alsa-devel@alsa-project.org

When forwarding or rewinding, the frame counter was not updated. This
could result in corrupted channel status words or misplaced Z-type
preamble.
---
I found the issue by inspecting the code. However, I have no hardware
to test this fix on.

 src/pcm/pcm_iec958.c | 64 +++++++++++++++++++++++++++++++++++++++++++++-
 src/pcm/pcm_plugin.c | 28 ++++++++++----------
 src/pcm/pcm_plugin.h | 72 +++++++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 145 insertions(+), 19 deletions(-)

diff --git a/src/pcm/pcm_iec958.c b/src/pcm/pcm_iec958.c
index d81b0a1..facf683 100644
--- a/src/pcm/pcm_iec958.c
+++ b/src/pcm/pcm_iec958.c
@@ -416,6 +416,35 @@ static void snd_pcm_iec958_dump(snd_pcm_t *pcm, snd_output_t *out)
 	snd_pcm_dump(iec->plug.gen.slave, out);
 }
 
+static snd_pcm_sframes_t snd_pcm_iec958_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
+{
+	unsigned int counter_decrement;
+	snd_pcm_iec958_t *iec = pcm->private_data;
+	snd_pcm_sframes_t result = snd_pcm_plugin_rewind(pcm, frames);
+	if (result <= 0)
+		return result;
+
+	counter_decrement = result % 192;
+	iec->counter += 192 - counter_decrement;
+	iec->counter %= 192;
+	return result;
+}
+
+static snd_pcm_sframes_t snd_pcm_iec958_forward(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
+
+{
+	unsigned int counter_increment;
+	snd_pcm_iec958_t *iec = pcm->private_data;
+	snd_pcm_sframes_t result = snd_pcm_plugin_rewind(pcm, frames);
+	if (result <= 0)
+		return result;
+
+	counter_increment = result % 192;
+	iec->counter += counter_increment;
+	iec->counter %= 192;
+	return result;
+}
+
 static const snd_pcm_ops_t snd_pcm_iec958_ops = {
 	.close = snd_pcm_generic_close,
 	.info = snd_pcm_generic_info,
@@ -434,6 +463,39 @@ static const snd_pcm_ops_t snd_pcm_iec958_ops = {
 	.set_chmap = snd_pcm_generic_set_chmap,
 };
 
+
+static const snd_pcm_fast_ops_t snd_pcm_iec958_fast_ops = {
+	.status = snd_pcm_plugin_status,
+	.state = snd_pcm_generic_state,
+	.hwsync = snd_pcm_generic_hwsync,
+	.delay = snd_pcm_plugin_delay,
+	.prepare = snd_pcm_plugin_prepare,
+	.reset = snd_pcm_plugin_reset,
+	.start = snd_pcm_generic_start,
+	.drop = snd_pcm_generic_drop,
+	.drain = snd_pcm_generic_drain,
+	.pause = snd_pcm_generic_pause,
+	.rewindable = snd_pcm_plugin_rewindable,
+	.rewind = snd_pcm_iec958_rewind,
+	.forwardable = snd_pcm_plugin_forwardable,
+	.forward = snd_pcm_iec958_forward,
+	.resume = snd_pcm_generic_resume,
+	.link = snd_pcm_generic_link,
+	.link_slaves = snd_pcm_generic_link_slaves,
+	.unlink = snd_pcm_generic_unlink,
+	.writei = snd_pcm_plugin_writei,
+	.writen = snd_pcm_plugin_writen,
+	.readi = snd_pcm_plugin_readi,
+	.readn = snd_pcm_plugin_readn,
+	.avail_update = snd_pcm_plugin_avail_update,
+	.mmap_commit = snd_pcm_plugin_mmap_commit,
+	.htimestamp = snd_pcm_generic_htimestamp,
+	.poll_descriptors_count = snd_pcm_generic_poll_descriptors_count,
+	.poll_descriptors = snd_pcm_generic_poll_descriptors,
+	.poll_revents = snd_pcm_generic_poll_revents,
+	.may_wait_for_avail_min = snd_pcm_generic_may_wait_for_avail_min,
+};
+
 /**
  * \brief Creates a new IEC958 subframe conversion PCM
  * \param pcmp Returns created PCM handle
@@ -495,7 +557,7 @@ int snd_pcm_iec958_open(snd_pcm_t **pcmp, const char *name, snd_pcm_format_t sfo
 		return err;
 	}
 	pcm->ops = &snd_pcm_iec958_ops;
-	pcm->fast_ops = &snd_pcm_plugin_fast_ops;
+	pcm->fast_ops = &snd_pcm_iec958_fast_ops;
 	pcm->private_data = iec;
 	pcm->poll_fd = slave->poll_fd;
 	pcm->poll_events = slave->poll_events;
diff --git a/src/pcm/pcm_plugin.c b/src/pcm/pcm_plugin.c
index 17157e8..022d908 100644
--- a/src/pcm/pcm_plugin.c
+++ b/src/pcm/pcm_plugin.c
@@ -137,7 +137,7 @@ void snd_pcm_plugin_init(snd_pcm_plugin_t *plugin)
 	snd_atomic_write_init(&plugin->watom);
 }
 
-static int snd_pcm_plugin_delay(snd_pcm_t *pcm, snd_pcm_sframes_t *delayp)
+int snd_pcm_plugin_delay(snd_pcm_t *pcm, snd_pcm_sframes_t *delayp)
 {
 	snd_pcm_plugin_t *plugin = pcm->private_data;
 	snd_pcm_sframes_t sd;
@@ -154,7 +154,7 @@ static int snd_pcm_plugin_delay(snd_pcm_t *pcm, snd_pcm_sframes_t *delayp)
 	return 0;
 }
 
-static int snd_pcm_plugin_prepare(snd_pcm_t *pcm)
+int snd_pcm_plugin_prepare(snd_pcm_t *pcm)
 {
 	snd_pcm_plugin_t *plugin = pcm->private_data;
 	int err;
@@ -175,7 +175,7 @@ static int snd_pcm_plugin_prepare(snd_pcm_t *pcm)
 	return 0;
 }
 
-static int snd_pcm_plugin_reset(snd_pcm_t *pcm)
+int snd_pcm_plugin_reset(snd_pcm_t *pcm)
 {
 	snd_pcm_plugin_t *plugin = pcm->private_data;
 	int err;
@@ -196,12 +196,12 @@ static int snd_pcm_plugin_reset(snd_pcm_t *pcm)
 	return 0;
 }
 
-static snd_pcm_sframes_t snd_pcm_plugin_rewindable(snd_pcm_t *pcm)
+snd_pcm_sframes_t snd_pcm_plugin_rewindable(snd_pcm_t *pcm)
 {
 	return snd_pcm_mmap_hw_avail(pcm);
 }
 
-static snd_pcm_sframes_t snd_pcm_plugin_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
+snd_pcm_sframes_t snd_pcm_plugin_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
 {
 	snd_pcm_plugin_t *plugin = pcm->private_data;
 	snd_pcm_sframes_t n = snd_pcm_mmap_hw_avail(pcm);
@@ -224,12 +224,12 @@ static snd_pcm_sframes_t snd_pcm_plugin_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t
 	return (snd_pcm_sframes_t) sframes;
 }
 
-static snd_pcm_sframes_t snd_pcm_plugin_forwardable(snd_pcm_t *pcm)
+snd_pcm_sframes_t snd_pcm_plugin_forwardable(snd_pcm_t *pcm)
 {
 	return snd_pcm_mmap_avail(pcm);
 }
 
-static snd_pcm_sframes_t snd_pcm_plugin_forward(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
+snd_pcm_sframes_t snd_pcm_plugin_forward(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
 {
 	snd_pcm_plugin_t *plugin = pcm->private_data;
 	snd_pcm_sframes_t n = snd_pcm_mmap_avail(pcm);
@@ -347,7 +347,7 @@ static snd_pcm_sframes_t snd_pcm_plugin_read_areas(snd_pcm_t *pcm,
 }
 
 
-static snd_pcm_sframes_t
+snd_pcm_sframes_t
 snd_pcm_plugin_writei(snd_pcm_t *pcm, const void *buffer, snd_pcm_uframes_t size)
 {
 	snd_pcm_channel_area_t areas[pcm->channels];
@@ -356,7 +356,7 @@ snd_pcm_plugin_writei(snd_pcm_t *pcm, const void *buffer, snd_pcm_uframes_t size
 				   snd_pcm_plugin_write_areas);
 }
 
-static snd_pcm_sframes_t
+snd_pcm_sframes_t
 snd_pcm_plugin_writen(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size)
 {
 	snd_pcm_channel_area_t areas[pcm->channels];
@@ -365,7 +365,7 @@ snd_pcm_plugin_writen(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size)
 				   snd_pcm_plugin_write_areas);
 }
 
-static snd_pcm_sframes_t
+snd_pcm_sframes_t
 snd_pcm_plugin_readi(snd_pcm_t *pcm, void *buffer, snd_pcm_uframes_t size)
 {
 	snd_pcm_channel_area_t areas[pcm->channels];
@@ -374,7 +374,7 @@ snd_pcm_plugin_readi(snd_pcm_t *pcm, void *buffer, snd_pcm_uframes_t size)
 				  snd_pcm_plugin_read_areas);
 }
 
-static snd_pcm_sframes_t
+snd_pcm_sframes_t
 snd_pcm_plugin_readn(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size)
 {
 	snd_pcm_channel_area_t areas[pcm->channels];
@@ -383,7 +383,7 @@ snd_pcm_plugin_readn(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size)
 				  snd_pcm_plugin_read_areas);
 }
 
-static snd_pcm_sframes_t
+snd_pcm_sframes_t
 snd_pcm_plugin_mmap_commit(snd_pcm_t *pcm,
 			   snd_pcm_uframes_t offset ATTRIBUTE_UNUSED,
 			   snd_pcm_uframes_t size)
@@ -452,7 +452,7 @@ snd_pcm_plugin_mmap_commit(snd_pcm_t *pcm,
 	return xfer;
 }
 
-static snd_pcm_sframes_t snd_pcm_plugin_avail_update(snd_pcm_t *pcm)
+snd_pcm_sframes_t snd_pcm_plugin_avail_update(snd_pcm_t *pcm)
 {
 	snd_pcm_plugin_t *plugin = pcm->private_data;
 	snd_pcm_t *slave = plugin->gen.slave;
@@ -516,7 +516,7 @@ static snd_pcm_sframes_t snd_pcm_plugin_avail_update(snd_pcm_t *pcm)
 	}
 }
 
-static int snd_pcm_plugin_status(snd_pcm_t *pcm, snd_pcm_status_t * status)
+int snd_pcm_plugin_status(snd_pcm_t *pcm, snd_pcm_status_t * status)
 {
 	snd_pcm_plugin_t *plugin = pcm->private_data;
 	snd_pcm_sframes_t err;
diff --git a/src/pcm/pcm_plugin.h b/src/pcm/pcm_plugin.h
index 7ee7c7f..7734369 100644
--- a/src/pcm/pcm_plugin.h
+++ b/src/pcm/pcm_plugin.h
@@ -50,14 +50,42 @@ typedef struct {
 } snd_pcm_plugin_t;	
 
 /* make local functions really local */
-#define snd_pcm_plugin_init \
-	snd1_pcm_plugin_init
-#define snd_pcm_plugin_fast_ops \
-	snd1_pcm_plugin_fast_ops
 #define snd_pcm_plugin_undo_read_generic \
 	snd1_pcm_plugin_undo_read_generic
 #define snd_pcm_plugin_undo_write_generic \
 	snd1_pcm_plugin_undo_write_generic
+#define snd_pcm_plugin_init \
+	snd1_pcm_plugin_init
+#define snd_pcm_plugin_delay \
+	snd1_pcm_plugin_delay
+#define snd_pcm_plugin_prepare \
+	snd1_pcm_plugin_prepare
+#define snd_pcm_plugin_reset \
+	snd1_pcm_plugin_reset
+#define snd_pcm_plugin_rewindable \
+	snd1_pcm_plugin_rewindable
+#define snd_pcm_plugin_rewind \
+	snd1_pcm_plugin_rewind
+#define snd_pcm_plugin_forwardable \
+	snd1_pcm_plugin_forwardable
+#define snd_pcm_plugin_forward \
+	snd1_pcm_plugin_forward
+#define snd_pcm_plugin_writei \
+	snd1_pcm_plugin_writei
+#define snd_pcm_plugin_writen \
+	snd1_pcm_plugin_writen
+#define snd_pcm_plugin_readi \
+	snd1_pcm_plugin_readi
+#define snd_pcm_plugin_readn \
+	snd1_pcm_plugin_readn
+#define snd_pcm_plugin_mmap_commit \
+	snd1_pcm_plugin_mmap_commit
+#define snd_pcm_plugin_avail_update \
+	snd1_pcm_plugin_avail_update
+#define snd_pcm_plugin_status \
+	snd1_pcm_plugin_status
+#define snd_pcm_plugin_fast_ops \
+	snd1_pcm_plugin_fast_ops
 
 void snd_pcm_plugin_init(snd_pcm_plugin_t *plugin);
 
@@ -77,6 +105,42 @@ snd_pcm_sframes_t snd_pcm_plugin_undo_write_generic
       snd_pcm_uframes_t res_size,		/* size of result areas */
       snd_pcm_uframes_t slave_undo_size);
 
+int snd_pcm_plugin_delay(snd_pcm_t *pcm, snd_pcm_sframes_t *delayp);
+int snd_pcm_plugin_prepare(snd_pcm_t *pcm);
+int snd_pcm_plugin_reset(snd_pcm_t *pcm);
+snd_pcm_sframes_t snd_pcm_plugin_rewindable(snd_pcm_t *pcm);
+snd_pcm_sframes_t snd_pcm_plugin_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t frames);
+snd_pcm_sframes_t snd_pcm_plugin_forwardable(snd_pcm_t *pcm);
+snd_pcm_sframes_t snd_pcm_plugin_forward(snd_pcm_t *pcm, snd_pcm_uframes_t frames);
+
+snd_pcm_sframes_t snd_pcm_plugin_writei
+      (snd_pcm_t *pcm,
+       const void *buffer,
+       snd_pcm_uframes_t size);
+
+snd_pcm_sframes_t snd_pcm_plugin_writen
+      (snd_pcm_t *pcm,
+       void **bufs,
+       snd_pcm_uframes_t size);
+
+snd_pcm_sframes_t snd_pcm_plugin_readi
+      (snd_pcm_t *pcm,
+       void *buffer,
+       snd_pcm_uframes_t size);
+
+snd_pcm_sframes_t snd_pcm_plugin_readn
+      (snd_pcm_t *pcm,
+       void **bufs,
+       snd_pcm_uframes_t size);
+
+snd_pcm_sframes_t snd_pcm_plugin_mmap_commit
+      (snd_pcm_t *pcm,
+       snd_pcm_uframes_t offset,
+       snd_pcm_uframes_t size);
+
+snd_pcm_sframes_t snd_pcm_plugin_avail_update(snd_pcm_t *pcm);
+int snd_pcm_plugin_status(snd_pcm_t *pcm, snd_pcm_status_t * status);
+
 /* make local functions really local */
 #define snd_pcm_linear_get_index	snd1_pcm_linear_get_index
 #define snd_pcm_linear_put_index	snd1_pcm_linear_put_index
-- 
1.9.2
