From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/7] slimbus: core: rearrange slim_eaddr structure
Date: Wed, 16 May 2018 12:36:37 +0100
Message-ID: <20180516113642.28136-3-srinivas.kandagatla@linaro.org>
References: <20180516113642.28136-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180516113642.28136-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

Rearrange struct slim_eaddr so that the structure is packed correctly
to be able to send in SLIMBus messages.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/linux/slimbus.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/slimbus.h b/include/linux/slimbus.h
index efa36a852dc3..63801bcc5e60 100644
--- a/include/linux/slimbus.h
+++ b/include/linux/slimbus.h
@@ -14,16 +14,16 @@ extern struct bus_type slimbus_bus;
 
 /**
  * struct slim_eaddr - Enumeration address for a SLIMbus device
- * @manf_id: Manufacturer Id for the device
- * @prod_code: Product code
- * @dev_index: Device index
  * @instance: Instance value
+ * @dev_index: Device index
+ * @prod_code: Product code
+ * @manf_id: Manufacturer Id for the device
  */
 struct slim_eaddr {
-	u16 manf_id;
-	u16 prod_code;
-	u8 dev_index;
 	u8 instance;
+	u8 dev_index;
+	u16 prod_code;
+	u16 manf_id;
 } __packed;
 
 /**
-- 
2.16.2
