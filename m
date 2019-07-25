From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 34/40] soundwire: intel: ignore disabled links for suspend/resume
Date: Thu, 25 Jul 2019 18:40:26 -0500
Message-ID: <20190725234032.21152-35-pierre-louis.bossart@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 1477c35f616f..a976480d6f36 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1161,6 +1161,12 @@ static int intel_suspend(struct device *dev)
 
 	sdw = dev_get_drvdata(dev);
 
+	if (sdw->cdns.bus.prop.hw_disabled) {
+		dev_dbg(dev, "SoundWire master %d is disabled, ignoring\n",
+			sdw->cdns.bus.link_id);
+		return 0;
+	}
+
 	ret = intel_link_power_down(sdw);
 	if (ret) {
 		dev_err(dev, "Link power down failed: %d", ret);
@@ -1179,6 +1185,12 @@ static int intel_resume(struct device *dev)
 
 	sdw = dev_get_drvdata(dev);
 
+	if (sdw->cdns.bus.prop.hw_disabled) {
+		dev_dbg(dev, "SoundWire master %d is disabled, ignoring\n",
+			sdw->cdns.bus.link_id);
+		return 0;
+	}
+
 	ret = intel_init(sdw);
 	if (ret) {
 		dev_err(dev, "%s failed: %d", __func__, ret);
-- 
2.20.1
