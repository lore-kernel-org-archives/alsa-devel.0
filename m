From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 15/17] soundwire: intel_init: add kernel module parameter to filter out links
Date: Mon,  5 Aug 2019 19:55:20 -0500
Message-ID: <20190806005522.22642-16-pierre-louis.bossart@linux.intel.com>
References: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, Blauciak@vger.kernel.org, Slawomir <slawomir.blauciak@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

The hardware and ACPI info may report the presence of links that are
not physically enabled (e.g. due to pin-muxing or hardware reworks),
which in turn can result in errors being thrown. This shouldn't be the
case for production devices but will happen a lot on development
devices - even more so when they expose a connector.

Even when the ACPI information is correct, it's useful to be able to
only enable the links that need attention - mostly to filter out
dynamic debug messages.

Add a module parameter to filter out such links, e.g. adding the
following config to a file in /etc/modprobe.d will select the second
and third links only.

options soundwire_intel_init sdw_link_mask=0x6

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel_init.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 70637a0383d2..b74c2f144962 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -22,6 +22,10 @@
 #define SDW_LINK_BASE		0x30000
 #define SDW_LINK_SIZE		0x10000
 
+static int link_mask;
+module_param_named(sdw_link_mask, link_mask, int, 0444);
+MODULE_PARM_DESC(sdw_link_mask, "Intel link mask (one bit per link)");
+
 struct sdw_link_data {
 	struct sdw_intel_link_res res;
 	struct platform_device *pdev;
@@ -111,6 +115,13 @@ static struct sdw_intel_ctx
 
 	/* Create SDW Master devices */
 	for (i = 0; i < count; i++) {
+		if (link_mask && !(link_mask & BIT(i))) {
+			dev_dbg(&adev->dev,
+				"Link %d masked, will not be enabled\n", i);
+			link++;
+			continue;
+		}
+
 		link->res.irq = res->irq;
 		link->res.registers = res->mmio_base + SDW_LINK_BASE
 					+ (SDW_LINK_SIZE * i);
-- 
2.20.1
