From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 10/17] soundwire: add new mclk_freq field for properties
Date: Mon,  5 Aug 2019 19:55:15 -0500
Message-ID: <20190806005522.22642-11-pierre-louis.bossart@linux.intel.com>
References: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, Blauciak@vger.kernel.org, Slawomir <slawomir.blauciak@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

To help pass platform-specific values, add a new field that can either
be set by the Master driver or read from firmware (BIOS/DT).

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/linux/soundwire/sdw.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 31d1e8acf25b..b6acc436ac80 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -379,6 +379,7 @@ struct sdw_slave_prop {
  * @dynamic_frame: Dynamic frame shape supported
  * @err_threshold: Number of times that software may retry sending a single
  * command
+ * @mclk_freq: clock reference passed to SoundWire Master, in Hz.
  */
 struct sdw_master_prop {
 	u32 revision;
@@ -393,6 +394,7 @@ struct sdw_master_prop {
 	u32 default_col;
 	bool dynamic_frame;
 	u32 err_threshold;
+	u32 mclk_freq;
 };
 
 int sdw_master_read_prop(struct sdw_bus *bus);
-- 
2.20.1
