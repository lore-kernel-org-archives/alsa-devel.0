From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 11/15] soundwire: cadence_master: log Slave status mask on errors
Date: Wed, 22 May 2019 14:47:27 -0500
Message-ID: <20190522194732.25704-12-pierre-louis.bossart@linux.intel.com>
References: <20190522194732.25704-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190522194732.25704-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

The Slave status mask exposes 4 sticky bits. When the device loses
sync, the IP will report two status but the log will only show that
the device lost sync. The status mask has all the information needed
so let's report it instead.

Also change the resolution of the mask, using 64 bits is not needed
when you need 4.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 6f4184f5256c..a505d74ab461 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -486,7 +486,8 @@ static int cdns_update_slave_status(struct sdw_cdns *cdns,
 {
 	enum sdw_slave_status status[SDW_MAX_DEVICES + 1];
 	bool is_slave = false;
-	u64 slave, mask;
+	u64 slave;
+	u32 mask;
 	int i, set_status;
 
 	/* combine the two status */
@@ -526,7 +527,7 @@ static int cdns_update_slave_status(struct sdw_cdns *cdns,
 		if (set_status > 1) {
 			dev_warn_ratelimited(cdns->dev,
 					     "Slave reported multiple Status: %d\n",
-					     status[i]);
+					     mask);
 			/*
 			 * TODO: we need to reread the status here by
 			 * issuing a PING cmd
-- 
2.20.1
