From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ASoC: Intel: atom: fix missing breaks that
	would cause the wrong operation to execute
Date: Thu, 23 Jun 2016 22:07:03 +0530
Message-ID: <1466699823-27891-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BBD9265361
 for <alsa-devel@alsa-project.org>; Thu, 23 Jun 2016 18:30:30 +0200 (CEST)
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Alan Cox <alan@linux.intel.com>

Now we correctly error an attempt to execute an unsupported operation.

Signed-off-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/atom/sst-mfld-platform-compress.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/atom/sst-mfld-platform-compress.c b/sound/soc/intel/atom/sst-mfld-platform-compress.c
index 395168986462..1bead81bb510 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-compress.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-compress.c
@@ -182,24 +182,29 @@ static int sst_platform_compr_trigger(struct snd_compr_stream *cstream, int cmd)
 	case SNDRV_PCM_TRIGGER_START:
 		if (stream->compr_ops->stream_start)
 			return stream->compr_ops->stream_start(sst->dev, stream->id);
+		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 		if (stream->compr_ops->stream_drop)
 			return stream->compr_ops->stream_drop(sst->dev, stream->id);
+		break;
 	case SND_COMPR_TRIGGER_DRAIN:
 		if (stream->compr_ops->stream_drain)
 			return stream->compr_ops->stream_drain(sst->dev, stream->id);
+		break;
 	case SND_COMPR_TRIGGER_PARTIAL_DRAIN:
 		if (stream->compr_ops->stream_partial_drain)
 			return stream->compr_ops->stream_partial_drain(sst->dev, stream->id);
+		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		if (stream->compr_ops->stream_pause)
 			return stream->compr_ops->stream_pause(sst->dev, stream->id);
+		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		if (stream->compr_ops->stream_pause_release)
 			return stream->compr_ops->stream_pause_release(sst->dev, stream->id);
-	default:
-		return -EINVAL;
+		break;
 	}
+	return -EINVAL;
 }
 
 static int sst_platform_compr_pointer(struct snd_compr_stream *cstream,
-- 
1.9.1
