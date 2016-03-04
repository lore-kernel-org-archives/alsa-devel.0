From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/2] ALSA: compress: Add
	SNDRV_PCM_STATE_PREPARED state explanation
Date: Fri,  4 Mar 2016 20:25:29 +0530
Message-ID: <1457103330-18135-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FD0E260673
 for <alsa-devel@alsa-project.org>; Fri,  4 Mar 2016 15:51:30 +0100 (CET)
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

Stream states were explained in the code comments but
SNDRV_PCM_STATE_PREPARED was missed so add it

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/core/compress_offload.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 7fac3cae8abd..51a8eb495f54 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -74,6 +74,9 @@ struct snd_compr_file {
  * SNDRV_PCM_STATE_SETUP: When stream has been initialized. This is done by
  *	calling SNDRV_COMPRESS_SET_PARAMS. running streams will come to this
  *	state at stop by calling SNDRV_COMPRESS_STOP, or at end of drain.
+ * SNDRV_PCM_STATE_PREPARED: When a stream has been written to (for
+ *	playback only). User after setting up stream writes the data buffer
+ *	before starting the stream.
  * SNDRV_PCM_STATE_RUNNING: When stream has been started and is
  *	decoding/encoding and rendering/capturing data.
  * SNDRV_PCM_STATE_DRAINING: When stream is draining current data. This is done
-- 
1.9.1
