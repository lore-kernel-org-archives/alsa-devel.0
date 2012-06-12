From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: [PATCH 2/2] audio: compress_core: cleanup pointers on
	stop
Date: Tue, 12 Jun 2012 16:16:18 +0530
Message-ID: <1339497978-12213-2-git-send-email-vinod.koul@linux.intel.com>
References: <1339497978-12213-1-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 52C9724427
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Jun 2012 12:54:44 +0200 (CEST)
In-Reply-To: <1339497978-12213-1-git-send-email-vinod.koul@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@linux.intel.com>, broonie@opensource.wolfsonmicro.com, Namarta Kohli <namartax.kohli@intel.com>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

as the start can be called after stop again, we need to reset state

Signed-off-by: Namarta Kohli <namartax.kohli@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
---
 sound/core/compress_offload.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 375f7a0..ec2118d 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -542,6 +542,10 @@ static int snd_compr_stop(struct snd_compr_stream *stream)
 	if (!retval) {
 		stream->runtime->state = SNDRV_PCM_STATE_SETUP;
 		wake_up(&stream->runtime->sleep);
+		stream->runtime->hw_pointer = 0;
+		stream->runtime->app_pointer = 0;
+		stream->runtime->total_bytes_available = 0;
+		stream->runtime->total_bytes_transferred = 0;
 	}
 	return retval;
 }
-- 
1.7.0.4
