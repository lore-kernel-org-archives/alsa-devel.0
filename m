From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] soundwire: Fix -Wunused-function warning
Date: Fri, 16 Aug 2019 22:14:09 +0800
Message-ID: <20190816141409.49940-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 466C8F80110
 for <alsa-devel@alsa-project.org>; Fri, 16 Aug 2019 16:15:26 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: vkoul@kernel.org, sanyog.r.kale@intel.com, pierre-louis.bossart@linux.intel.com
Cc: alsa-devel@alsa-project.org, YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

If CONFIG_ACPI is not set, gcc warning this:

drivers/soundwire/slave.c:16:12: warning:
 'sdw_slave_add' defined but not used [-Wunused-function]

move them to #ifdef CONFIG_ACPI block.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/soundwire/slave.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index f39a581..34c7e65 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -6,6 +6,7 @@
 #include <linux/soundwire/sdw_type.h>
 #include "bus.h"
 
+#if IS_ENABLED(CONFIG_ACPI)
 static void sdw_slave_release(struct device *dev)
 {
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
@@ -60,7 +61,6 @@ static int sdw_slave_add(struct sdw_bus *bus,
 	return ret;
 }
 
-#if IS_ENABLED(CONFIG_ACPI)
 /*
  * sdw_acpi_find_slaves() - Find Slave devices in Master ACPI node
  * @bus: SDW bus instance
-- 
2.7.4
