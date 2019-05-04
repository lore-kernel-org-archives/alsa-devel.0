From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/8] soundwire: mipi_disco: fix master/link error
Date: Fri,  3 May 2019 19:29:20 -0500
Message-ID: <20190504002926.28815-3-pierre-louis.bossart@linux.intel.com>
References: <20190504002926.28815-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190504002926.28815-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

The MIPI DisCo specification for SoundWire defines the
"mipi-sdw-link-N-subproperties", not the master-N properties. Fix to
parse firmware information.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/mipi_disco.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
index c1f51d6a23d2..6df68584c963 100644
--- a/drivers/soundwire/mipi_disco.c
+++ b/drivers/soundwire/mipi_disco.c
@@ -40,7 +40,7 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 
 	/* Find master handle */
 	snprintf(name, sizeof(name),
-		 "mipi-sdw-master-%d-subproperties", bus->link_id);
+		 "mipi-sdw-link-%d-subproperties", bus->link_id);
 
 	link = device_get_named_child_node(bus->dev, name);
 	if (!link) {
-- 
2.17.1
