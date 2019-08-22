From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] soundwire: Fix -Wunused-function warning
Date: Thu, 22 Aug 2019 22:54:08 +0800
Message-ID: <20190822145408.76272-1-yuehaibing@huawei.com>
References: <20190816141409.49940-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190816141409.49940-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vkoul@kernel.org, sanyog.r.kale@intel.com, pierre-louis.bossart@linux.intel.com, ladis@linux-mips.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: alsa-devel@alsa-project.org

If CONFIG_ACPI is not set, gcc warning this:

drivers/soundwire/slave.c:16:12: warning:
 'sdw_slave_add' defined but not used [-Wunused-function]

Now all code in slave.c is only used on ACPI enabled,
so compiles it while CONFIG_ACPI is set.

Reported-by: Hulk Robot <hulkci@huawei.com>
Suggested-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: use obj-$(CONFIG_ACPI) += slave.o
---
 drivers/soundwire/Makefile | 3 ++-
 drivers/soundwire/slave.c  | 3 ---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
index 45b7e50..a28bf3e 100644
--- a/drivers/soundwire/Makefile
+++ b/drivers/soundwire/Makefile
@@ -4,8 +4,9 @@
 #
 
 #Bus Objs
-soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o stream.o
+soundwire-bus-objs := bus_type.o bus.o mipi_disco.o stream.o
 obj-$(CONFIG_SOUNDWIRE) += soundwire-bus.o
+obj-$(CONFIG_ACPI) += slave.o
 
 #Cadence Objs
 soundwire-cadence-objs := cadence_master.o
diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index f39a581..0dc188e 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -60,7 +60,6 @@ static int sdw_slave_add(struct sdw_bus *bus,
 	return ret;
 }
 
-#if IS_ENABLED(CONFIG_ACPI)
 /*
  * sdw_acpi_find_slaves() - Find Slave devices in Master ACPI node
  * @bus: SDW bus instance
@@ -110,5 +109,3 @@ int sdw_acpi_find_slaves(struct sdw_bus *bus)
 
 	return 0;
 }
-
-#endif
-- 
2.7.4
