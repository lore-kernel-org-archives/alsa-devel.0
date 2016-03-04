From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ALSA: compress: fix more typos
Date: Fri,  4 Mar 2016 23:59:29 +0530
Message-ID: <1457116169-18952-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D86F2668DC
 for <alsa-devel@alsa-project.org>; Fri,  4 Mar 2016 19:25:25 +0100 (CET)
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

More inspection of code revealed few more typos so fix them as well

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/core/compress_offload.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index c4b14b5f1b35..7d59dbda8897 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -703,7 +703,7 @@ static int snd_compress_wait_for_drain(struct snd_compr_stream *stream)
 
 	/*
 	 * We are called with lock held. So drop the lock while we wait for
-	 * drain complete notfication from the driver
+	 * drain complete notification from the driver
 	 *
 	 * It is expected that driver will notify the drain completion and then
 	 * stream will be moved to SETUP state, even if draining resulted in an
@@ -758,7 +758,7 @@ static int snd_compr_next_track(struct snd_compr_stream *stream)
 	if (stream->runtime->state != SNDRV_PCM_STATE_RUNNING)
 		return -EPERM;
 
-	/* you can signal next track isf this is intended to be a gapless stream
+	/* you can signal next track if this is intended to be a gapless stream
 	 * and current track metadata is set
 	 */
 	if (stream->metadata_set == false)
-- 
1.9.1
