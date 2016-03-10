From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/4] ASoC: compress: Pass error out of
	soc_compr_pointer
Date: Thu, 10 Mar 2016 10:44:51 +0000
Message-ID: <1457606694-10985-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id CCFC8261293
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2016 11:44:56 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, tiwai@suse.com
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The soc_compr_pointer does not correctly pass any errors returned by the
driver callback back up the stack. This patch corrects this issue.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
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
