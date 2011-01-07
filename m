From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: [PATCH 2/3] ASoC: sst platform - fix the style
	inconsistency
Date: Fri,  7 Jan 2011 16:20:56 +0530
Message-ID: <1294397456-8761-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id A7D6524341
	for <alsa-devel@alsa-project.org>; Fri,  7 Jan 2011 11:50:56 +0100 (CET)
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
Cc: tiwai@suse.de, broonie@opensource.wolfsonmicro.com, Vinod Koul <vinod.koul@intel.com>, Harsha Priya <priya.harsha@intel.com>, lrg@slimlogic.co.uk, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

this patch fixes the style inconsistency by removing empty space in MODULE_ALIAS
also removes a redundant return statement

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>
---
 sound/soc/mid-x86/sst_platform.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mid-x86/sst_platform.c b/sound/soc/mid-x86/sst_platform.c
index 189d546..0e994c1 100644
--- a/sound/soc/mid-x86/sst_platform.c
+++ b/sound/soc/mid-x86/sst_platform.c
@@ -176,7 +176,6 @@ static void sst_period_elapsed(void *mad_substream)
 	}
 	spin_unlock(&stream->status_lock);
 	snd_pcm_period_elapsed(substream);
-	return;
 }
 
 static int sst_platform_init_stream(struct snd_pcm_substream *substream)
@@ -481,4 +480,4 @@ MODULE_DESCRIPTION("ASoC Intel(R) MID Platform driver");
 MODULE_AUTHOR("Vinod Koul <vinod.koul@intel.com>");
 MODULE_AUTHOR("Harsha Priya <priya.harsha@intel.com>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platfrom: sst-platform");
+MODULE_ALIAS("platform:sst-platform");
-- 
1.7.2.3
