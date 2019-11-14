Return-Path: <SRS0=S9OM=ZG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03C1C432C3
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Nov 2019 18:01:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 688C22071B
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Nov 2019 18:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OaMve9YT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 688C22071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7536E166E;
	Thu, 14 Nov 2019 19:00:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7536E166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573754505;
	bh=HKRoaWFmGzauR/dO86EhCocIQVIUBL2Rjh3HiYirD7M=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OaMve9YT9M7Upi4YBzAuoWRRHnwhSpUDu3iH1LvFVN30COBL57ebzs/1ptrQuK6EL
	 9nmc+oVjCU6+eEAe4Toa1+LQ9BPkLv4eaH1P7UY4uIt6LcZT7yaD9f/Utbx1gItBU1
	 NbQR/yzMdVRrnAiyQ85ixAjZzfwFiGonStKxLSP4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F57DF800CC;
	Thu, 14 Nov 2019 19:00:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2E067F800EF; Thu, 14 Nov 2019 18:59:59 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 99678F800CF
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2019 18:59:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 99678F800CF
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Nov 2019 09:59:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,304,1569308400"; d="scan'208";a="207871420"
Received: from chiahuil-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.228.77])
 by orsmga003.jf.intel.com with ESMTP; 14 Nov 2019 09:59:48 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Thu, 14 Nov 2019 11:59:19 -0600
Message-Id: <20191114175933.21992-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191114175933.21992-1-pierre-louis.bossart@linux.intel.com>
References: <20191114175933.21992-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com,
 slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: [alsa-devel] [PATCH v3 01/15] soundwire: renames to prepare support
	for master drivers/devices
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Add clearer references to sdw_slave_driver for internal macros

No change for sdw_driver and module_sdw_driver to avoid compatibility
issues with existing codec devices

No functionality change.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus_type.c       | 21 +++++++++++----------
 include/linux/soundwire/sdw_type.h | 18 ++++++++++--------
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 4a465f55039f..370b94752662 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -34,7 +34,7 @@ sdw_get_device_id(struct sdw_slave *slave, struct sdw_driver *drv)
 static int sdw_bus_match(struct device *dev, struct device_driver *ddrv)
 {
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
-	struct sdw_driver *drv = drv_to_sdw_driver(ddrv);
+	struct sdw_driver *drv = drv_to_sdw_slave_driver(ddrv);
 
 	return !!sdw_get_device_id(slave, drv);
 }
@@ -70,7 +70,7 @@ EXPORT_SYMBOL_GPL(sdw_bus_type);
 static int sdw_drv_probe(struct device *dev)
 {
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
-	struct sdw_driver *drv = drv_to_sdw_driver(dev->driver);
+	struct sdw_driver *drv = drv_to_sdw_slave_driver(dev->driver);
 	const struct sdw_device_id *id;
 	int ret;
 
@@ -116,7 +116,7 @@ static int sdw_drv_probe(struct device *dev)
 static int sdw_drv_remove(struct device *dev)
 {
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
-	struct sdw_driver *drv = drv_to_sdw_driver(dev->driver);
+	struct sdw_driver *drv = drv_to_sdw_slave_driver(dev->driver);
 	int ret = 0;
 
 	if (drv->remove)
@@ -130,20 +130,21 @@ static int sdw_drv_remove(struct device *dev)
 static void sdw_drv_shutdown(struct device *dev)
 {
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
-	struct sdw_driver *drv = drv_to_sdw_driver(dev->driver);
+	struct sdw_driver *drv = drv_to_sdw_slave_driver(dev->driver);
 
 	if (drv->shutdown)
 		drv->shutdown(slave);
 }
 
 /**
- * __sdw_register_driver() - register a SoundWire Slave driver
+ * __sdw_register_slave_driver() - register a SoundWire Slave driver
  * @drv: driver to register
  * @owner: owning module/driver
  *
  * Return: zero on success, else a negative error code.
  */
-int __sdw_register_driver(struct sdw_driver *drv, struct module *owner)
+int __sdw_register_slave_driver(struct sdw_driver *drv,
+				struct module *owner)
 {
 	drv->driver.bus = &sdw_bus_type;
 
@@ -164,17 +165,17 @@ int __sdw_register_driver(struct sdw_driver *drv, struct module *owner)
 
 	return driver_register(&drv->driver);
 }
-EXPORT_SYMBOL_GPL(__sdw_register_driver);
+EXPORT_SYMBOL_GPL(__sdw_register_slave_driver);
 
 /**
- * sdw_unregister_driver() - unregisters the SoundWire Slave driver
+ * sdw_unregister_slave_driver() - unregisters the SoundWire Slave driver
  * @drv: driver to unregister
  */
-void sdw_unregister_driver(struct sdw_driver *drv)
+void sdw_unregister_slave_driver(struct sdw_driver *drv)
 {
 	driver_unregister(&drv->driver);
 }
-EXPORT_SYMBOL_GPL(sdw_unregister_driver);
+EXPORT_SYMBOL_GPL(sdw_unregister_slave_driver);
 
 static int __init sdw_bus_init(void)
 {
diff --git a/include/linux/soundwire/sdw_type.h b/include/linux/soundwire/sdw_type.h
index aaa7f4267c14..abaa21278152 100644
--- a/include/linux/soundwire/sdw_type.h
+++ b/include/linux/soundwire/sdw_type.h
@@ -6,13 +6,15 @@
 
 extern struct bus_type sdw_bus_type;
 
-#define drv_to_sdw_driver(_drv) container_of(_drv, struct sdw_driver, driver)
+#define drv_to_sdw_slave_driver(_drv) \
+	container_of(_drv, struct sdw_driver, driver)
 
-#define sdw_register_driver(drv) \
-	__sdw_register_driver(drv, THIS_MODULE)
+#define sdw_register_slave_driver(drv) \
+	__sdw_register_slave_driver(drv, THIS_MODULE)
 
-int __sdw_register_driver(struct sdw_driver *drv, struct module *owner);
-void sdw_unregister_driver(struct sdw_driver *drv);
+int __sdw_register_slave_driver(struct sdw_driver *drv,
+				struct module *owner);
+void sdw_unregister_slave_driver(struct sdw_driver *drv);
 
 int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size);
 
@@ -24,7 +26,7 @@ int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size);
  * module init/exit. This eliminates a lot of boilerplate. Each module may only
  * use this macro once, and calling it replaces module_init() and module_exit()
  */
-#define module_sdw_driver(__sdw_driver) \
-	module_driver(__sdw_driver, sdw_register_driver, \
-			sdw_unregister_driver)
+#define module_sdw_driver(__sdw_slave_driver) \
+	module_driver(__sdw_slave_driver, sdw_register_slave_driver, \
+			sdw_unregister_slave_driver)
 #endif /* __SOUNDWIRE_TYPES_H */
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
