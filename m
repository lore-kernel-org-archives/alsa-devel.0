From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 5/9] ALSA: compres: wakeup the poll thread on
	pause
Date: Tue, 27 Aug 2013 12:10:35 +0530
Message-ID: <1377585639-29516-6-git-send-email-vinod.koul@intel.com>
References: <1377585639-29516-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id B4240264F47
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 09:25:46 +0200 (CEST)
In-Reply-To: <1377585639-29516-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

this allows the poll to be unblocked, if it is blocked and yeilds the control
of userthread blocked

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/core/compress_offload.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 1e722c2..417a456 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -629,9 +629,12 @@ static int snd_compr_pause(struct snd_compr_stream *stream)
 
 	if (stream->runtime->state != SNDRV_PCM_STATE_RUNNING)
 		return -EPERM;
+
 	retval = stream->ops->trigger(stream, SNDRV_PCM_TRIGGER_PAUSE_PUSH);
-	if (!retval)
+	if (!retval) {
 		stream->runtime->state = SNDRV_PCM_STATE_PAUSED;
+		wake_up(&stream->runtime->sleep);
+	}
 	return retval;
 }
 
-- 
1.7.0.4
