From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/4] soundwire: add module_sdw_driver helper
	macro
Date: Thu, 28 Mar 2019 13:41:31 +0000
Message-ID: <20190328134134.22479-2-srinivas.kandagatla@linaro.org>
References: <20190328134134.22479-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2B3E5F80C16
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2019 14:42:01 +0100 (CET)
Received: by mail-wm1-x344.google.com with SMTP id a184so3638430wma.2
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2019 06:42:01 -0700 (PDT)
In-Reply-To: <20190328134134.22479-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: vkoul@kernel.org
Cc: sanyog.r.kale@intel.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This Helper macro is for Soundwire drivers which do not do anything special in
module init/exit. This eliminates a lot of boilerplate. Each module may only
use this macro once, and calling it replaces module_init() and module_exit()

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/linux/soundwire/sdw_type.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/soundwire/sdw_type.h b/include/linux/soundwire/sdw_type.h
index 9fd553e553e9..e14843ed13a5 100644
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
