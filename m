From: Andre Guedes <andre.guedes@intel.com>
Subject: [PATCH - AAF PCM plugin 7/7] aaf: Add support for
	direct read/write transfers
Date: Wed,  3 Oct 2018 16:45:47 -0700
Message-ID: <20181003234547.16839-8-andre.guedes@intel.com>
References: <20181003234547.16839-1-andre.guedes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id DB9C9267889
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2018 01:46:52 +0200 (CEST)
In-Reply-To: <20181003234547.16839-1-andre.guedes@intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

This patch adds support for direct read/write transfers (i.e. mmap
access mode) to the AAF plugin.

In order to enable direct read/write transfers, the AAF plugin is
required to implement ioplug's pseudo mmap mode. In this mode, the audio
buffer management (e.g. areas allocation, clean up, and data copy) is
handled at upper layers, making the AAF plugin simpler. So this patch
removes all code related to audio buffer management as well as the
transfer() callback from the AAF plugin.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 aaf/pcm_aaf.c | 78 +++--------------------------------------------------------
 1 file changed, 4 insertions(+), 74 deletions(-)

diff --git a/aaf/pcm_aaf.c b/aaf/pcm_aaf.c
index f3159a1..463d457 100644
--- a/aaf/pcm_aaf.c
+++ b/aaf/pcm_aaf.c
@@ -75,7 +75,7 @@ typedef struct {
 	uint64_t mclk_period;
 	uint64_t mclk_ticks;
 
-	snd_pcm_channel_area_t *audiobuf_areas;
+	const snd_pcm_channel_area_t *audiobuf_areas;
 	snd_pcm_channel_area_t *payload_areas;
 
 	snd_pcm_uframes_t hw_ptr;
@@ -532,42 +532,6 @@ err:
 	return res;
 }
 
-static int aaf_init_audiobuf_areas(snd_pcm_aaf_t *aaf)
-{
-	int res;
-	char *buf;
-	ssize_t frame_size;
-	snd_pcm_channel_area_t *areas;
-	snd_pcm_ioplug_t *io = &aaf->io;
-
-	frame_size = snd_pcm_format_size(io->format, io->channels);
-	if (frame_size < 0)
-		return frame_size;
-
-	buf = calloc(io->buffer_size, frame_size);
-	if (!buf)
-		return -ENOMEM;
-
-	areas = calloc(io->channels, sizeof(snd_pcm_channel_area_t));
-	if (!areas) {
-		res = -ENOMEM;
-		goto err_free_buf;
-	}
-
-	res = aaf_init_areas(aaf, areas, buf);
-	if (res < 0)
-		goto err_free_areas;
-
-	aaf->audiobuf_areas = areas;
-	return 0;
-
-err_free_areas:
-	free(areas);
-err_free_buf:
-	free(buf);
-	return res;
-}
-
 static void aaf_inc_ptr(snd_pcm_uframes_t *ptr, snd_pcm_uframes_t val,
 			snd_pcm_uframes_t boundary)
 {
@@ -912,6 +876,7 @@ static int aaf_set_hw_constraint(snd_pcm_aaf_t *aaf)
 	snd_pcm_ioplug_t *io = &aaf->io;
 	const unsigned int accesses[] = {
 		SND_PCM_ACCESS_RW_INTERLEAVED,
+		SND_PCM_ACCESS_MMAP_INTERLEAVED,
 	};
 	const unsigned int formats[] = {
 		SND_PCM_FORMAT_S16_BE,
@@ -1006,14 +971,8 @@ static int aaf_hw_params(snd_pcm_ioplug_t *io,
 	if (res < 0)
 		goto err_free_pdu;
 
-	res = aaf_init_audiobuf_areas(aaf);
-	if (res < 0)
-		goto err_free_payload_areas;
-
 	return 0;
 
-err_free_payload_areas:
-	free(aaf->payload_areas);
 err_free_pdu:
 	free(aaf->pdu);
 err_close_timer:
@@ -1031,8 +990,6 @@ static int aaf_hw_free(snd_pcm_ioplug_t *io)
 	close(aaf->timer_fd);
 	free(aaf->pdu);
 	free(aaf->payload_areas);
-	free(aaf->audiobuf_areas->addr);
-	free(aaf->audiobuf_areas);
 	return 0;
 }
 
@@ -1131,6 +1088,7 @@ static int aaf_prepare(snd_pcm_ioplug_t *io)
 	int res;
 	snd_pcm_aaf_t *aaf = io->private_data;
 
+	aaf->audiobuf_areas = snd_pcm_ioplug_mmap_areas(io);
 	aaf->pdu_seq = 0;
 	aaf->pdu_count = 0;
 	aaf->hw_ptr = 0;
@@ -1176,34 +1134,6 @@ static int aaf_stop(snd_pcm_ioplug_t *io)
 	return 0;
 }
 
-static snd_pcm_sframes_t aaf_transfer(snd_pcm_ioplug_t *io,
-				      const snd_pcm_channel_area_t *areas,
-				      snd_pcm_uframes_t offset,
-				      snd_pcm_uframes_t size)
-{
-	int res;
-	snd_pcm_aaf_t *aaf = io->private_data;
-
-	if (io->stream == SND_PCM_STREAM_PLAYBACK) {
-		res = snd_pcm_areas_copy_wrap(aaf->audiobuf_areas,
-					      (io->appl_ptr % io->buffer_size),
-					      io->buffer_size, areas, offset,
-					      size, io->channels, size,
-					      io->format);
-	} else {
-		res = snd_pcm_areas_copy_wrap(areas, offset, (offset + size),
-					      aaf->audiobuf_areas,
-					      (io->appl_ptr % io->buffer_size),
-					      io->buffer_size, io->channels,
-					      size, io->format);
-	}
-
-	if (res < 0)
-		return res;
-
-	return size;
-}
-
 static const snd_pcm_ioplug_callback_t aaf_callback = {
 	.close = aaf_close,
 	.dump = aaf_dump,
@@ -1217,7 +1147,6 @@ static const snd_pcm_ioplug_callback_t aaf_callback = {
 	.prepare = aaf_prepare,
 	.start = aaf_start,
 	.stop = aaf_stop,
-	.transfer = aaf_transfer,
 };
 
 SND_PCM_PLUGIN_DEFINE_FUNC(aaf)
@@ -1243,6 +1172,7 @@ SND_PCM_PLUGIN_DEFINE_FUNC(aaf)
 	aaf->io.callback = &aaf_callback;
 	aaf->io.private_data = aaf;
 	aaf->io.flags = SND_PCM_IOPLUG_FLAG_BOUNDARY_WA;
+	aaf->io.mmap_rw = 1;
 	res = snd_pcm_ioplug_create(&aaf->io, name, stream, mode);
 	if (res < 0) {
 		SNDERR("Failed to create ioplug instance");
-- 
2.14.4
