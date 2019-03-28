From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/4] soundwire: remove unused struct
	sdw_bus_conf definition
Date: Thu, 28 Mar 2019 13:41:34 +0000
Message-ID: <20190328134134.22479-5-srinivas.kandagatla@linaro.org>
References: <20190328134134.22479-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5BE31F89714
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2019 14:42:06 +0100 (CET)
Received: by mail-wr1-x442.google.com with SMTP id w1so23004642wrp.2
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2019 06:42:06 -0700 (PDT)
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

struct sdw_bus_conf seems to be replaced with struct sdw_bus_params
so remove this unused data structure to avoid confusion to readers.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/linux/soundwire/sdw.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index df313913e856..a8129745b7ec 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -389,21 +389,6 @@ enum sdw_reg_bank {
 	SDW_BANK1,
 };
 
-/**
- * struct sdw_bus_conf: Bus configuration
- *
- * @clk_freq: Clock frequency, in Hz
- * @num_rows: Number of rows in frame
- * @num_cols: Number of columns in frame
- * @bank: Next register bank
- */
-struct sdw_bus_conf {
-	unsigned int clk_freq;
-	unsigned int num_rows;
-	unsigned int num_cols;
-	unsigned int bank;
-};
-
 /**
  * struct sdw_prepare_ch: Prepare/De-prepare Data Port channel
  *
-- 
2.21.0
