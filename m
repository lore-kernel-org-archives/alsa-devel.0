From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH 2/2 v2] rate: dynamic update avail_min on slave
Date: Mon, 19 Dec 2016 12:37:51 +0900
Message-ID: <20161219033751.30848-3-jiada_wang@mentor.com>
References: <20161219033751.30848-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 8876A2665B6
 for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2016 04:37:47 +0100 (CET)
In-Reply-To: <20161219033751.30848-1-jiada_wang@mentor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, lgirdwood@gmail.com, broonie@kernel.org, wens@csie.org
Cc: jiada_wang@mentor.com, alsa-devel@alsa-project.org, apape@de.adit-jv.com
List-Id: alsa-devel@alsa-project.org

From: Andreas Pape <apape@de.adit-jv.com>

Signed-off-by: Andreas Pape <apape@de.adit-jv.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 src/pcm/pcm_plugin.c | 4 ++--
 src/pcm/pcm_plugin.h | 3 +++
 src/pcm/pcm_rate.c   | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/pcm/pcm_plugin.c b/src/pcm/pcm_plugin.c
index 5b65ac3..ad4a102 100644
--- a/src/pcm/pcm_plugin.c
+++ b/src/pcm/pcm_plugin.c
@@ -535,8 +535,8 @@ static int snd_pcm_plugin_status(snd_pcm_t *pcm, snd_pcm_status_t * status)
 	return 0;
 }
 
-static int snd_pcm_plugin_may_wait_for_avail_min(snd_pcm_t *pcm,
-						 snd_pcm_uframes_t avail)
+int snd_pcm_plugin_may_wait_for_avail_min(snd_pcm_t *pcm,
+					  snd_pcm_uframes_t avail)
 {
 	if (pcm->stream == SND_PCM_STREAM_CAPTURE &&
 	    pcm->access != SND_PCM_ACCESS_RW_INTERLEAVED &&
diff --git a/src/pcm/pcm_plugin.h b/src/pcm/pcm_plugin.h
index 217f075..95aacb3 100644
--- a/src/pcm/pcm_plugin.h
+++ b/src/pcm/pcm_plugin.h
@@ -50,6 +50,8 @@ typedef struct {
 /* make local functions really local */
 #define snd_pcm_plugin_init \
 	snd1_pcm_plugin_init
+#define snd_pcm_plugin_may_wait_for_avail_min \
+	snd1_pcm_plugin_may_wait_for_avail_min
 #define snd_pcm_plugin_fast_ops \
 	snd1_pcm_plugin_fast_ops
 #define snd_pcm_plugin_undo_read_generic \
@@ -64,6 +66,7 @@ typedef struct {
 void snd_pcm_plugin_init(snd_pcm_plugin_t *plugin);
 snd_pcm_sframes_t snd_pcm_plugin_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t frames);
 snd_pcm_sframes_t snd_pcm_plugin_forward(snd_pcm_t *pcm, snd_pcm_uframes_t frames);
+int snd_pcm_plugin_may_wait_for_avail_min(snd_pcm_t *pcm, snd_pcm_uframes_t avail);
 
 extern const snd_pcm_fast_ops_t snd_pcm_plugin_fast_ops;
 
diff --git a/src/pcm/pcm_rate.c b/src/pcm/pcm_rate.c
index 6184def..b0a1a48 100644
--- a/src/pcm/pcm_rate.c
+++ b/src/pcm/pcm_rate.c
@@ -1156,7 +1156,7 @@ static const snd_pcm_fast_ops_t snd_pcm_rate_fast_ops = {
 	.poll_descriptors_count = snd_pcm_generic_poll_descriptors_count,
 	.poll_descriptors = snd_pcm_generic_poll_descriptors,
 	.poll_revents = snd_pcm_rate_poll_revents,
-	.may_wait_for_avail_min = snd_pcm_generic_may_wait_for_avail_min,
+	.may_wait_for_avail_min = snd_pcm_plugin_may_wait_for_avail_min,
 };
 
 static const snd_pcm_ops_t snd_pcm_rate_ops = {
-- 
2.9.3
