From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH 2/4] Revert "ASoC: Intel: fix broadwell module
	removing failed issue"
Date: Sat, 30 May 2015 22:33:57 +0800
Message-ID: <1432996439-8052-3-git-send-email-yang.jie@intel.com>
References: <1432996439-8052-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B43C260668
 for <alsa-devel@alsa-project.org>; Sat, 30 May 2015 16:29:58 +0200 (CEST)
In-Reply-To: <1432996439-8052-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

This reverts commit 01f202c7b4b40025f3ea4721c52e7f78545e3b07.

We shouldn't leave the device as suspended state after module freed,
it is not good to do runtime suspend at driver free, here revert
this fixing, and replace it with the procedure:
suspends firmware ==> frees runtime modules ==> unloads firmware.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/haswell/sst-haswell-pcm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/intel/haswell/sst-haswell-pcm.c b/sound/soc/intel/haswell/sst-haswell-pcm.c
index bd96629..23ae040 100644
--- a/sound/soc/intel/haswell/sst-haswell-pcm.c
+++ b/sound/soc/intel/haswell/sst-haswell-pcm.c
@@ -1118,10 +1118,8 @@ static int hsw_pcm_remove(struct snd_soc_platform *platform)
 		snd_soc_platform_get_drvdata(platform);
 	int i;
 
-	/* execute a suspend call to unload all FW resources */
-	if (!pm_runtime_status_suspended(platform->dev))
-		pm_runtime_put_sync_suspend(platform->dev);
 	pm_runtime_disable(platform->dev);
+	hsw_pcm_free_modules(priv_data);
 
 	for (i = 0; i < ARRAY_SIZE(hsw_dais); i++) {
 		if (hsw_dais[i].playback.channels_min)
-- 
1.9.1
