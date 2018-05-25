From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 1/8] slimbus: core: rearrange slim_eaddr
	structure
Date: Fri, 25 May 2018 15:36:11 +0100
Message-ID: <20180525143618.820-2-srinivas.kandagatla@linaro.org>
References: <20180525143618.820-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 31F5B267669
 for <alsa-devel@alsa-project.org>; Fri, 25 May 2018 16:38:22 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id x2-v6so7864457wmh.5
 for <alsa-devel@alsa-project.org>; Fri, 25 May 2018 07:38:22 -0700 (PDT)
In-Reply-To: <20180525143618.820-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: alsa-devel@alsa-project.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Rearrange struct slim_eaddr so that the structure is packed correctly
to be able to send in SLIMBus messages.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/linux/slimbus.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/slimbus.h b/include/linux/slimbus.h
index c36cf121d2cd..90af9eb26615 100644
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
