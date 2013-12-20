From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 07/19] ASoC: intel: Don't set unused struct
	snd_pcm_hardware fields
Date: Fri, 20 Dec 2013 14:20:13 +0100
Message-ID: <1387545625-19240-7-git-send-email-lars@metafoo.de>
References: <1387545625-19240-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-044.synserver.de (smtp-out-122.synserver.de
 [212.40.185.122])
 by alsa0.perex.cz (Postfix) with ESMTP id 71A2C265667
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 15:19:38 +0100 (CET)
In-Reply-To: <1387545625-19240-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vinod.koul@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The ASoC core assumes that the PCM component of the ASoC card transparently
moves data around and does not impose any restrictions on the memory layout or
the transfer speed. It ignores all fields from the snd_pcm_hardware struct for
the PCM driver that are related to this. Setting these fields in the PCM driver
might suggest otherwise though, so rather not set them.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Vinod Koul <vinod.koul@linux.intel.com>
---
 sound/soc/intel/sst_platform.c | 10 ----------
 sound/soc/intel/sst_platform.h |  4 ----
 2 files changed, 14 deletions(-)

diff --git a/sound/soc/intel/sst_platform.c b/sound/soc/intel/sst_platform.c
index b6b5eb6..f465a81 100644
--- a/sound/soc/intel/sst_platform.c
+++ b/sound/soc/intel/sst_platform.c
@@ -89,16 +89,6 @@ static struct snd_pcm_hardware sst_platform_pcm_hw = {
 			SNDRV_PCM_INFO_MMAP_VALID |
 			SNDRV_PCM_INFO_BLOCK_TRANSFER |
 			SNDRV_PCM_INFO_SYNC_START),
-	.formats = (SNDRV_PCM_FMTBIT_S16 | SNDRV_PCM_FMTBIT_U16 |
-			SNDRV_PCM_FMTBIT_S24 | SNDRV_PCM_FMTBIT_U24 |
-			SNDRV_PCM_FMTBIT_S32 | SNDRV_PCM_FMTBIT_U32),
-	.rates = (SNDRV_PCM_RATE_8000|
-			SNDRV_PCM_RATE_44100 |
-			SNDRV_PCM_RATE_48000),
-	.rate_min = SST_MIN_RATE,
-	.rate_max = SST_MAX_RATE,
-	.channels_min =	SST_MIN_CHANNEL,
-	.channels_max =	SST_MAX_CHANNEL,
 	.buffer_bytes_max = SST_MAX_BUFFER,
 	.period_bytes_min = SST_MIN_PERIOD_BYTES,
 	.period_bytes_max = SST_MAX_PERIOD_BYTES,
diff --git a/sound/soc/intel/sst_platform.h b/sound/soc/intel/sst_platform.h
index cacc906..bee64fb 100644
--- a/sound/soc/intel/sst_platform.h
+++ b/sound/soc/intel/sst_platform.h
@@ -33,10 +33,6 @@
 #define SST_STEREO		2
 #define SST_MAX_CAP		5
 
-#define SST_MIN_RATE		8000
-#define SST_MAX_RATE		48000
-#define SST_MIN_CHANNEL		1
-#define SST_MAX_CHANNEL		5
 #define SST_MAX_BUFFER		(800*1024)
 #define SST_MIN_BUFFER		(800*1024)
 #define SST_MIN_PERIOD_BYTES	32
-- 
1.8.0
