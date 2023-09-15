Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920FBEE0214
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Sep 2023 14:30:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A6E6984B;
	Fri, 15 Sep 2023 16:29:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A6E6984B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694788237;
	bh=mFuVTHNTwysC+UqtSfPrMCCVxmvM03yVhC5AfvBpgaA=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=BdqTOQCeFT4kyxy558YYJm6YN+CL2jdQxIgg+aGuFxG7TFW0o1b+cxOy+JMaa/DUc
	 YpcqfkaEPfbUccegb3yZA2QfaCyRpq1dx5WIgBF+MVkZizFMwoNcRjW4gB/kHH2jfI
	 IP84AsWZ4EJYInpXb4BKX1+tKbHKUl5AmmCztyvw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1797DF80431; Fri, 15 Sep 2023 16:29:17 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4DA42F8007C;
	Fri, 15 Sep 2023 16:29:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6140AF80425; Fri, 15 Sep 2023 16:29:10 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 034B4F8007C
	for <alsa-devel@alsa-project.org>; Fri, 15 Sep 2023 16:29:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 034B4F8007C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=eQWyeMKk
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 38FC3mvV012750;
	Fri, 15 Sep 2023 09:29:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=T
	rz4kyXVUWgb16VKCTRJ4EijKbpUCL5Y3dKsrQduNlA=; b=eQWyeMKkCdDWxT/ig
	Ufc7P3zTqlfaHz7mt3AxHxDZxqoWUemlLCVvZHQiKK6hhTQmWOR5fBdwQglLp5SL
	b/ejYZQu2/ZBA3VyIlGsdwAUvEKljyuNIwhdsNvEP675NOLyqZL1Db7ywhKpz70A
	4hyetptgLYV1y0AF27fQNz8sUTVMph4Z5o1Jx4Mgv/5Ty44S5jURSmC5LjJpS3w4
	p6EABKeecLRzW63DqmA1RBDjWT+7LzqqgpOIra6YbEgmih/h6EPlklR7X2YQJGaU
	LOlngY3gE8M5Q4tSTv801D6Vi5WjYRqwY3dMitnRvUq2G451pcA3roEGE3fFnpJa
	rOyzg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3t2y7skhur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Sep 2023 09:29:01 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Fri, 15 Sep
 2023 15:29:00 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Fri, 15 Sep 2023 15:29:00 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5DFED3563;
	Fri, 15 Sep 2023 14:29:00 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <vkoul@kernel.org>
CC: <yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.intel.com>,
        <sanyog.r.kale@intel.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] soundwire: bus: Add explicit include for irqdomain.h
Date: Fri, 15 Sep 2023 15:29:00 +0100
Message-ID: <20230915142900.34498-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: CD4twaIgADeMT_VdDTyjJplg3AtC74Jh
X-Proofpoint-ORIG-GUID: CD4twaIgADeMT_VdDTyjJplg3AtC74Jh
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: JC4GW6UUE2WGSRXDXG5UVA4EYHN7IU52
X-Message-ID-Hash: JC4GW6UUE2WGSRXDXG5UVA4EYHN7IU52
X-MailFrom: prvs=4622e418f9=ckeepax@opensource.cirrus.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JC4GW6UUE2WGSRXDXG5UVA4EYHN7IU52/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This header should be explicitly included, to make sure it is included
for all Kconfigs.

Fixes: 12a95123bfe1 ("soundwire: bus: Allow SoundWire peripherals to register IRQ handlers")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309150522.MoKeF4jx-lkp@intel.com/
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/soundwire/bus.c      | 1 +
 drivers/soundwire/bus_type.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 1720031f35a35..5869b71f10923 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -4,6 +4,7 @@
 #include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/mod_devicetable.h>
 #include <linux/pm_runtime.h>
 #include <linux/soundwire/sdw_registers.h>
diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index fafbc284e82da..dc9c508f48a4b 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright(c) 2015-17 Intel Corporation.
 
+#include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/pm_domain.h>
-- 
2.30.2

