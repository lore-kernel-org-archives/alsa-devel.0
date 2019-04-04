From: Jan Kotas <jank@cadence.com>
Subject: [PATCH] soundwire: cdns: Fix compilation error on arm64
Date: Thu, 4 Apr 2019 09:12:21 +0100
Message-ID: <20190404081221.341-1-jank@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vkoul@kernel.org, sanyog.r.kale@intel.com, pierre-louis.bossart@linux.intel.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jan Kotas <jank@cadence.com>
List-Id: alsa-devel@alsa-project.org

On arm64 the cadence_master.c file doesn't compile.

readl and writel are undefined.
This patch fixes that by including io.h.

Signed-off-by: Jan Kotas <jank@cadence.com>
---
 drivers/soundwire/cadence_master.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index cb6a331f4..0b5bcc209 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -9,6 +9,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/soundwire/sdw_registers.h>
-- 
2.15.0
