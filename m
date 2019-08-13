From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 3/6] soundwire: intel: add helper for initialization
Date: Tue, 13 Aug 2019 16:32:23 -0500
Message-ID: <20190813213227.5163-4-pierre-louis.bossart@linux.intel.com>
References: <20190813213227.5163-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190813213227.5163-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

Move code to helper for reuse in power management routines

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 5f14c6acce80..3d22c9023a9b 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -993,6 +993,15 @@ static struct sdw_master_ops sdw_intel_ops = {
 	.post_bank_switch = intel_post_bank_switch,
 };
 
+static int intel_init(struct sdw_intel *sdw)
+{
+	/* Initialize shim and controller */
+	intel_link_power_up(sdw);
+	intel_shim_init(sdw);
+
+	return sdw_cdns_init(&sdw->cdns);
+}
+
 /*
  * probe and init
  */
@@ -1035,11 +1044,8 @@ static int intel_probe(struct platform_device *pdev)
 		return 0;
 	}
 
-	/* Initialize shim and controller */
-	intel_link_power_up(sdw);
-	intel_shim_init(sdw);
-
-	ret = sdw_cdns_init(&sdw->cdns);
+	/* Initialize shim, controller and Cadence IP */
+	ret = intel_init(sdw);
 	if (ret)
 		goto err_init;
 
-- 
2.20.1
