From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/2] ALSA: compress: fix some typos
Date: Fri,  4 Mar 2016 20:25:30 +0530
Message-ID: <1457103330-18135-2-git-send-email-vinod.koul@intel.com>
References: <1457103330-18135-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F55226147A
 for <alsa-devel@alsa-project.org>; Fri,  4 Mar 2016 15:51:32 +0100 (CET)
In-Reply-To: <1457103330-18135-1-git-send-email-vinod.koul@intel.com>
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

Found few typos while looking at code, so fix them

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/core/compress_offload.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 51a8eb495f54..c4b14b5f1b35 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -69,10 +69,10 @@ struct snd_compr_file {
 
 /*
  * a note on stream states used:
- * we use follwing states in the compressed core
+ * we use following states in the compressed core
  * SNDRV_PCM_STATE_OPEN: When stream has been opened.
  * SNDRV_PCM_STATE_SETUP: When stream has been initialized. This is done by
- *	calling SNDRV_COMPRESS_SET_PARAMS. running streams will come to this
+ *	calling SNDRV_COMPRESS_SET_PARAMS. Running streams will come to this
  *	state at stop by calling SNDRV_COMPRESS_STOP, or at end of drain.
  * SNDRV_PCM_STATE_PREPARED: When a stream has been written to (for
  *	playback only). User after setting up stream writes the data buffer
-- 
1.9.1
