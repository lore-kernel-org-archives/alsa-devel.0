From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v6 4/4] ASoC: compress: Pass error out of
	soc_compr_pointer
Date: Fri, 22 Apr 2016 16:15:26 +0100
Message-ID: <1461338126-25998-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1461338126-25998-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EC2C265041
 for <alsa-devel@alsa-project.org>; Fri, 22 Apr 2016 17:15:21 +0200 (CEST)
In-Reply-To: <1461338126-25998-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vinod.koul@intel.com, tiwai@suse.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Both soc_compr_pointer and the platform driver pointer callback return
ints but current soc_compr_pointer always returns 0. Update this so we
return the actual value from the platform driver callback. This doesn't
fix any issues simply makes the code more consistent.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/soc-compress.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 875733c..d2df46c 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -530,14 +530,15 @@ static int soc_compr_pointer(struct snd_compr_stream *cstream,
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
+	int ret = 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
 	if (platform->driver->compr_ops && platform->driver->compr_ops->pointer)
-		 platform->driver->compr_ops->pointer(cstream, tstamp);
+		ret = platform->driver->compr_ops->pointer(cstream, tstamp);
 
 	mutex_unlock(&rtd->pcm_mutex);
-	return 0;
+	return ret;
 }
 
 static int soc_compr_copy(struct snd_compr_stream *cstream,
-- 
2.1.4
