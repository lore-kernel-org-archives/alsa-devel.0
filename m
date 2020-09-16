Return-Path: <SRS0=58lj=CZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A64C433E2
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2020 20:17:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A41421582
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2020 20:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="K5drZ0A6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A41421582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4541F1676;
	Wed, 16 Sep 2020 22:16:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4541F1676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600287440;
	bh=rvFNJitadCEtFuBbcXXOlFaYfCiwQrfLFzXs64BBTDU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K5drZ0A6cMde8v7xGCDzJDTmeh/DthCJY9fUfk7Ci9CHyai5C01wUvx124n3lcr1k
	 +dIJn8kinzwcoOZoMakC66rMKK1N0qlLS4M0DuZNUjuESNG4bJIUMnS+zX7JKGYwWL
	 +svVjlJrabi8h+EQ1EBvtVV4ueFk5skIKbaE/ixA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4619FF8015C;
	Wed, 16 Sep 2020 22:15:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7095FF8015C; Wed, 16 Sep 2020 22:15:37 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 04D3BF800E8
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2020 22:15:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 04D3BF800E8
IronPort-SDR: TGept2SYSED8jgD7Gkj39HxQe4L7szLncEtT0HfCjjUtMZSdpKb01FE2BMo9G0hqJM2lrg3yE1
 LvwHUq+3jaUQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9746"; a="139567009"
X-IronPort-AV: E=Sophos;i="5.76,434,1592895600"; d="scan'208";a="139567009"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2020 13:15:17 -0700
IronPort-SDR: Vp9/OWArGgjdRPNuAmSCumwCJDoRHii4R5z480hEU3eQfF65aZZl8rtdUeFZGg4QP1d2WlhXM6
 kxhFKvB2B5fw==
X-IronPort-AV: E=Sophos;i="5.76,434,1592895600"; d="scan'208";a="451997724"
Received: from yipengwa-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.60.40])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2020 13:15:16 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org,
	srinivas.kandagatla@linaro.org
Subject: [PATCH 1/2] soundwire: bus: add enumerated Slave device to device list
Date: Wed, 16 Sep 2020 15:15:03 -0500
Message-Id: <20200916201504.52211-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200916201504.52211-1-pierre-louis.bossart@linux.intel.com>
References: <20200916201504.52211-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 tiwai@suse.de, gregkh@linuxfoundation.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Currently Slave devices are only added on startup, either from Device
Tree or ACPI entries. However Slave devices that are physically
present on the bus, but not described in platform firmware, will never
be added to the device list. The user/integrator can only know the
list of devices by looking a dynamic debug logs.

This patch suggests adding a Slave device even where there is no
matching DT or ACPI entry, so that we can see this in sysfs entry.

Initial code from Srinivas. Comments, fixes for ACPI probe and edits
of commit message by Pierre.

Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.c      | 9 +++++++++
 drivers/soundwire/bus.h      | 2 ++
 drivers/soundwire/bus_type.c | 9 +++++++++
 drivers/soundwire/slave.c    | 4 ++--
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 02574b4bb179..81807b332a12 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -741,6 +741,15 @@ static int sdw_program_device_num(struct sdw_bus *bus)
 
 		if (!found) {
 			/* TODO: Park this device in Group 13 */
+
+			/*
+			 * add Slave device even if there is no platform
+			 * firmware description. There will be no driver probe
+			 * but the user/integration will be able to see the
+			 * device, enumeration status and device number in sysfs
+			 */
+			sdw_slave_add(bus, &id, NULL);
+
 			dev_err(bus->dev, "Slave Entry not found\n");
 		}
 
diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index c53345fbc4c7..fd251c1eb925 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -19,6 +19,8 @@ static inline int sdw_acpi_find_slaves(struct sdw_bus *bus)
 int sdw_of_find_slaves(struct sdw_bus *bus);
 void sdw_extract_slave_id(struct sdw_bus *bus,
 			  u64 addr, struct sdw_slave_id *id);
+int sdw_slave_add(struct sdw_bus *bus, struct sdw_slave_id *id,
+		  struct fwnode_handle *fwnode);
 int sdw_master_device_add(struct sdw_bus *bus, struct device *parent,
 			  struct fwnode_handle *fwnode);
 int sdw_master_device_del(struct sdw_bus *bus);
diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 6fba55898cf0..575b9bad99d5 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -84,6 +84,15 @@ static int sdw_drv_probe(struct device *dev)
 	const struct sdw_device_id *id;
 	int ret;
 
+	/*
+	 * fw description is mandatory to bind
+	 */
+	if (!dev->fwnode)
+		return -ENODEV;
+
+	if (!IS_ENABLED(CONFIG_ACPI) && !dev->of_node)
+		return -ENODEV;
+
 	id = sdw_get_device_id(slave, drv);
 	if (!id)
 		return -ENODEV;
diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index 4a250d33de5d..19b012310c29 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -20,8 +20,8 @@ struct device_type sdw_slave_type = {
 	.uevent =	sdw_slave_uevent,
 };
 
-static int sdw_slave_add(struct sdw_bus *bus,
-			 struct sdw_slave_id *id, struct fwnode_handle *fwnode)
+int sdw_slave_add(struct sdw_bus *bus,
+		  struct sdw_slave_id *id, struct fwnode_handle *fwnode)
 {
 	struct sdw_slave *slave;
 	int ret;
-- 
2.25.1

