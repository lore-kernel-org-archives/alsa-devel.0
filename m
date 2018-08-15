From: ylhuajnu@163.com
Subject: [PATCH 2/2] ALSA: ac97: fix unbalanced
	pm_runtime_enable
Date: Wed, 15 Aug 2018 23:20:35 +0800
Message-ID: <20180815152035.24898-2-ylhuajnu@163.com>
References: <20180815152035.24898-1-ylhuajnu@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m12-16.163.com (m12-16.163.com [220.181.12.16])
 by alsa0.perex.cz (Postfix) with ESMTP id 2929126782A
 for <alsa-devel@alsa-project.org>; Wed, 15 Aug 2018 17:21:07 +0200 (CEST)
In-Reply-To: <20180815152035.24898-1-ylhuajnu@163.com>
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

Runtime PM is enabled at ac97_bus_probe() and should be disabled
at ac97_bus_remove().

Fixes: 74426fbff66e ("ALSA: ac97: add an ac97 bus")
Signed-off-by: Lihua Yao <ylhuajnu@163.com>
---
 sound/ac97/bus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/ac97/bus.c b/sound/ac97/bus.c
index c267e44fefa0..83eed9d7f679 100644
--- a/sound/ac97/bus.c
+++ b/sound/ac97/bus.c
@@ -511,6 +511,8 @@ static int ac97_bus_remove(struct device *dev)
 	if (ret == 0)
 		ac97_put_disable_clk(adev);
 
+	pm_runtime_disable(dev);
+
 	return ret;
 }
 
-- 
2.17.1
