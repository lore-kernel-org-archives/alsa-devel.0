From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 14/15] soundwire: fix typo in comments
Date: Wed, 22 May 2019 14:47:30 -0500
Message-ID: <20190522194732.25704-15-pierre-louis.bossart@linux.intel.com>
References: <20190522194732.25704-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190522194732.25704-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

Copy/paste of sdw_intel_res

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index 71050e5f643d..d923b6262330 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -5,7 +5,7 @@
 #define __SDW_INTEL_LOCAL_H
 
 /**
- * struct sdw_intel_res - Soundwire link resources
+ * struct sdw_intel_link_res - Soundwire link resources
  * @registers: Link IO registers base
  * @shim: Audio shim pointer
  * @alh: ALH (Audio Link Hub) pointer
-- 
2.20.1
