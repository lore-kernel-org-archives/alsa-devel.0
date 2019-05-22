From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 05/15] soundwire: mipi-disco: remove master_count property for masters
Date: Wed, 22 May 2019 14:47:21 -0500
Message-ID: <20190522194732.25704-6-pierre-louis.bossart@linux.intel.com>
References: <20190522194732.25704-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190522194732.25704-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

The master_count is only defined for a Controller or a Slave in the
MIPI DisCo for SoundWire document.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/linux/soundwire/sdw.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 831a370eaedd..14376d8458c3 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -364,7 +364,6 @@ struct sdw_slave_prop {
 /**
  * struct sdw_master_prop - Master properties
  * @revision: MIPI spec version of the implementation
- * @master_count: Number of masters
  * @clk_stop_mode: Bitmap for Clock Stop modes supported
  * @max_freq: Maximum Bus clock frequency, in Hz
  * @num_clk_gears: Number of clock gears supported
@@ -380,7 +379,6 @@ struct sdw_slave_prop {
  */
 struct sdw_master_prop {
 	u32 revision;
-	u32 master_count;
 	enum sdw_clk_stop_mode clk_stop_mode;
 	u32 max_freq;
 	u32 num_clk_gears;
-- 
2.20.1
