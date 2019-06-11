From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 3/5] soundwire: add module_sdw_driver helper macro
Date: Tue, 11 Jun 2019 11:40:41 +0100
Message-ID: <20190611104043.22181-4-srinivas.kandagatla@linaro.org>
References: <20190611104043.22181-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190611104043.22181-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, vkoul@kernel.org
Cc: robh+dt@kernel.org, devicetree@vger.kernel.org, mark.rutland@arm.com, pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, bgoswami@quicinc.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This Helper macro is for SoundWire drivers which do not do anything special in
module init/exit. This eliminates a lot of boilerplate. Each module may only
use this macro once, and calling it replaces module_init() and module_exit()

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/linux/soundwire/sdw_type.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/soundwire/sdw_type.h b/include/linux/soundwire/sdw_type.h
index 9c756b5a0dfe..aaa7f4267c14 100644
--- a/include/linux/soundwire/sdw_type.h
+++ b/include/linux/soundwire/sdw_type.h
@@ -16,4 +16,15 @@ void sdw_unregister_driver(struct sdw_driver *drv);
 
 int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size);
 
+/**
+ * module_sdw_driver() - Helper macro for registering a Soundwire driver
+ * @__sdw_driver: soundwire slave driver struct
+ *
+ * Helper macro for Soundwire drivers which do not do anything special in
+ * module init/exit. This eliminates a lot of boilerplate. Each module may only
+ * use this macro once, and calling it replaces module_init() and module_exit()
+ */
+#define module_sdw_driver(__sdw_driver) \
+	module_driver(__sdw_driver, sdw_register_driver, \
+			sdw_unregister_driver)
 #endif /* __SOUNDWIRE_TYPES_H */
-- 
2.21.0
