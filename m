From: ylhuajnu@163.com
Subject: [PATCH 1/2] ALSA: ac97: fix check of
	pm_runtime_get_sync failure
Date: Wed, 15 Aug 2018 23:20:34 +0800
Message-ID: <20180815152035.24898-1-ylhuajnu@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m12-16.163.com (m12-16.163.com [220.181.12.16])
 by alsa0.perex.cz (Postfix) with ESMTP id 2788B2677FE
 for <alsa-devel@alsa-project.org>; Wed, 15 Aug 2018 17:21:07 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com
Cc: Lihua Yao <ylhuajnu@163.com>, alsa-devel@alsa-project.org, robert.jarzmik@free.fr
List-Id: alsa-devel@alsa-project.org

From: Lihua Yao <ylhuajnu@163.com>

pm_runtime_get_sync returns negative on failure.

Fixes: 74426fbff66e ("ALSA: ac97: add an ac97 bus")
Signed-off-by: Lihua Yao <ylhuajnu@163.com>
---
 sound/ac97/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/ac97/bus.c b/sound/ac97/bus.c
index 31f858eceffc..c267e44fefa0 100644
--- a/sound/ac97/bus.c
+++ b/sound/ac97/bus.c
@@ -503,7 +503,7 @@ static int ac97_bus_remove(struct device *dev)
 	int ret;
 
 	ret = pm_runtime_get_sync(dev);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	ret = adrv->remove(adev);
-- 
2.17.1
