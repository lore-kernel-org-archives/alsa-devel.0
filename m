From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] mfd: arizona: Move regulator disable to after
	marking cache only
Date: Wed,  3 Jul 2013 15:01:01 +0100
Message-ID: <1372860061-13548-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A727D2655C5
 for <alsa-devel@alsa-project.org>; Wed,  3 Jul 2013 16:14:36 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: sameo@linux.intel.com
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

If we disable DCVDD before we mark the cache as cache only, we might
attempt to write to the chip whilst it is powered down and lose a write.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 drivers/mfd/arizona-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index 6ab0304..aa47709 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -388,9 +388,9 @@ static int arizona_runtime_suspend(struct device *dev)
 
 	dev_dbg(arizona->dev, "Entering AoD mode\n");
 
-	regulator_disable(arizona->dcvdd);
 	regcache_cache_only(arizona->regmap, true);
 	regcache_mark_dirty(arizona->regmap);
+	regulator_disable(arizona->dcvdd);
 
 	return 0;
 }
-- 
1.7.2.5
