From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/4] soundwire: bus: check if pm runtime is
	enabled before calling
Date: Thu, 28 Mar 2019 13:41:33 +0000
Message-ID: <20190328134134.22479-4-srinivas.kandagatla@linaro.org>
References: <20190328134134.22479-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0FC7EF89708
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2019 14:42:05 +0100 (CET)
Received: by mail-wr1-x441.google.com with SMTP id r4so15273203wrq.8
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2019 06:42:05 -0700 (PDT)
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

Check the device has pm runtime enabled before returning error.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/bus.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 1cbfedfc20ef..101562a6fb0d 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -327,9 +327,11 @@ int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
 	if (ret < 0)
 		return ret;
 
-	ret = pm_runtime_get_sync(slave->bus->dev);
-	if (ret < 0)
-		return ret;
+	if (pm_runtime_enabled(slave->bus->dev)) {
+		ret = pm_runtime_get_sync(slave->bus->dev);
+		if (ret < 0)
+			return ret;
+	}
 
 	ret = sdw_transfer(slave->bus, &msg);
 	pm_runtime_put(slave->bus->dev);
@@ -355,9 +357,11 @@ int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
 	if (ret < 0)
 		return ret;
 
-	ret = pm_runtime_get_sync(slave->bus->dev);
-	if (ret < 0)
-		return ret;
+	if (pm_runtime_enabled(slave->bus->dev)) {
+		ret = pm_runtime_get_sync(slave->bus->dev);
+		if (ret < 0)
+			return ret;
+	}
 
 	ret = sdw_transfer(slave->bus, &msg);
 	pm_runtime_put(slave->bus->dev);
-- 
2.21.0
