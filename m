From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 13/40] soundwire: cadence_master: fix register definition for SLAVE_STATE
Date: Thu, 25 Jul 2019 18:40:05 -0500
Message-ID: <20190725234032.21152-14-pierre-louis.bossart@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

wrong prefix and wrong macro.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 0f3b9c160b01..d9d9e3d964dd 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -85,8 +85,8 @@
 
 #define CDNS_MCP_INTSET				0x4C
 
-#define CDNS_SDW_SLAVE_STAT			0x50
-#define CDNS_MCP_SLAVE_STAT_MASK		BIT(1, 0)
+#define CDNS_MCP_SLAVE_STAT			0x50
+#define CDNS_MCP_SLAVE_STAT_MASK		GENMASK(1, 0)
 
 #define CDNS_MCP_SLAVE_INTSTAT0			0x54
 #define CDNS_MCP_SLAVE_INTSTAT1			0x58
-- 
2.20.1
