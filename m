From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH RESEND] mfd: arizona: Move regulator disable to
	after marking cache only
Date: Tue,  6 Aug 2013 17:18:35 +0100
Message-ID: <1375805915-24009-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CEC2D2608CF
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2013 18:27:18 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, sameo@linux.intel.com, lee.jones@linaro.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

If we disable DCVDD before we mark the cache as cache only, we might
attempt to write to the chip whilst it is powered down and lose a write.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 drivers/mfd/arizona-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index 89a1153..5ac3aa4 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -438,9 +438,9 @@ static int arizona_runtime_suspend(struct device *dev)
 		}
 	}
 
-	regulator_disable(arizona->dcvdd);
 	regcache_cache_only(arizona->regmap, true);
 	regcache_mark_dirty(arizona->regmap);
+	regulator_disable(arizona->dcvdd);
 
 	return 0;
 }
-- 
1.7.2.5
