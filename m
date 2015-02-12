From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 05/13] ASoC: Intel: add support for pcm stream
	suspend/resume
Date: Thu, 12 Feb 2015 09:59:57 +0530
Message-ID: <1423715405-4562-6-git-send-email-vinod.koul@intel.com>
References: <1423715405-4562-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 47F8726513B
 for <alsa-devel@alsa-project.org>; Thu, 12 Feb 2015 05:32:58 +0100 (CET)
In-Reply-To: <1423715405-4562-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The driver didn't implement support for pcm stream suspend and resume, so
add it

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst-mfld-platform-pcm.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/sst-mfld-platform-pcm.c b/sound/soc/intel/sst-mfld-platform-pcm.c
index 7523cbef8780..ea0fa4b90bb0 100644
--- a/sound/soc/intel/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/sst-mfld-platform-pcm.c
@@ -594,11 +594,13 @@ static int sst_platform_pcm_trigger(struct snd_pcm_substream *substream,
 		ret_val = stream->ops->stream_drop(sst->dev, str_id);
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
 		dev_dbg(rtd->dev, "sst: in pause\n");
 		status = SST_PLATFORM_PAUSED;
 		ret_val = stream->ops->stream_pause(sst->dev, str_id);
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+	case SNDRV_PCM_TRIGGER_RESUME:
 		dev_dbg(rtd->dev, "sst: in pause release\n");
 		status = SST_PLATFORM_RUNNING;
 		ret_val = stream->ops->stream_pause_release(sst->dev, str_id);
-- 
1.7.9.5
