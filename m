Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F0ECD343F
	for <alsa-devel@archiver.kernel.org>; Thu,  7 May 2026 18:14:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 94B78601F8;
	Thu,  7 May 2026 20:14:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 94B78601F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778177665;
	bh=yoxt369I0cO1vkmYo50bOzhH4TvfNedLyv8ygkf5t3s=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=MFEO9m3I1CPw1ns1Uf09tBw/L86g9RDgCu1arFh3bVnWMLr65f5gWOUulaIQkClJ8
	 aYWofQzSnGELY/nD+NXTBtHwbxLn15k5IEuFvhR5RErR4imberTXhmReK+VjRZQ8Zq
	 olEV7yNeHk0l/yy0fXIriQ8mvDV5mOXvXVm0eIi0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EC546F80614; Thu,  7 May 2026 20:13:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 55816F8060F;
	Thu,  7 May 2026 20:13:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 64490F8051F; Thu,  7 May 2026 20:13:27 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010061.outbound.protection.outlook.com [52.101.61.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A579DF80518
	for <alsa-devel@alsa-project.org>; Thu,  7 May 2026 20:13:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A579DF80518
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=qwplAa17
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdihRPgaTyk4c7CSLlNJWDUt0NCMcy5cp9u3e1X5ss9SlWZt+16qZWIx2I3iZb4RhMprRzbRdtknXI+n9H9V/oSM5jW2AjLPNJMEfE81q53Lc+R2PSDtMZYjYxvhXTAlE/ogIf1xg90LlxHW+edh/hk29OohALwZEQJ+IBzfYVzM+MBV4GqQQ5P2t46oPLct5opCrVf9mEtCAGj9huTn2ztxBo+d7zbPi/lChvad3sgbzbS7V514ocYS8TZkE9bXU65ZR0I0BeDm4Fxbh69zT/NFU+XReQsziXIyMB+pl7nErU4dqlBd5Uf81FCN97TAREDuEFqe1hRTKpwnOGyksg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ap6mHRzXirA6Zbf5ZwN/pgDYP7EpOctEhaE3JNVn3IA=;
 b=msIDBMK8f0dqNFtV+MPF8jJsBUIoQWHM6UqAshUKkQyGmNO9jJXaaP8cwFLFn/oFKmldvm2HdC/qx/fFkBvtI6Tww64cvcjwTSlDEencke+yyjw+136FKqLmkZa1fHBAWMGWAjyK6DK5I41VysPpSxsvpPamFCIhHh0ukT8LYkKSXci7xkD50tJhAwmB/Qic31V2dCmFTx5wsjq8KLiTCcbz4cFEMhJMO4Q21m3EmDgTdeAxkFZ1lBxcYN+L/uQ3aVLj1MIZwqpTeC76rzibNkU4m72vFx9HnIfX9GNbGTFNuKszLP24igwXpBdVGoPlomxhSeTTH6pCexn0aaERjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ap6mHRzXirA6Zbf5ZwN/pgDYP7EpOctEhaE3JNVn3IA=;
 b=qwplAa17Msk5nZ5ci502anzImAmOnCooXKwhYRgHi4Wkua/WCO8J5/myDuFrtPbarTEmjL2xbb3hQ/Jo6vCG8BsaSmbfZm7uVopR6t2tFQaoJ7XLr6lhDqrbdWnImELduIVaf1K3vgE8SI8VqI1C1i4I2oVTWS2TKfbr55UFsqs=
Received: from BL1PR13CA0170.namprd13.prod.outlook.com (2603:10b6:208:2bd::25)
 by CH8PR12MB999203.namprd12.prod.outlook.com (2603:10b6:610:35a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Thu, 7 May
 2026 18:13:17 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::b7) by BL1PR13CA0170.outlook.office365.com
 (2603:10b6:208:2bd::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.10 via Frontend Transport; Thu, 7
 May 2026 18:13:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 18:13:17 +0000
Received: from vijendar-linux.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 7 May
 2026 13:13:14 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <mario.limonciello@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH 2/5] ASoC: amd: acp7x: add ACP PCI driver probe/remove
 sequence
Date: Thu, 7 May 2026 23:41:30 +0530
Message-ID: <20260507181251.20594-3-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260507181251.20594-1-Vijendar.Mukunda@amd.com>
References: <20260507181251.20594-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|CH8PR12MB999203:EE_
X-MS-Office365-Filtering-Correlation-Id: 11811f7a-6885-4907-91a5-08deac645025
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	Hs277AlDk24AMAcmSyuVAKfNEjdsXOyh67TcQv+fYfYkTIh06ic59Tg2B7y23NrQDTZWfu/BqhZaGNWIkUHmNCr9vd6eTkq/VESDoHTpTG5GmOHAGn1h5GTzwm890TweNBjQx777cNxvmi4Fe8B1G8uKOsqePHHeb08UOWmDEKZb8EHswnDmImf2Gvxxt3jWi7W3TTBBNL1q/RNcIg1Zih3mD+mAGyYQ5DnMmaMtjf2/fBzsHCqWoECqym+r6L5SHHQLTBZ4Y2iwicJ9ED2W5UIJhofkHIKVC6PKGpc/ShHEhsjgxnGyHtmfr+bTGO7w2SqHfaj0Y0udlSTnNURuo+eMHwfSnNMbPEGZ/DFPAzF3ozHAvlebx4cD1bUSOuyY/tP3h1CwWLcLJPUed3sMquTX3N+MOFCphwfMvjdLL/pUAThJigOg7MpzZFUoEZqneoyId+v7GqEdgRy6gL8WYZ4raNsWSY0aY+50njCVrYx5ggUfOOw9/dvt2VYqVTtEFVQGg0MYXqVoZDS6rrw+Xq1kar9VWNYrKCRJWT8kZyPNUd1puLoApw6kusmdeQJ1WnP7xJ1xc3YyGqkIagkHvMrrKDyxmmccQDytI02pTHoDxYvt5CpnV7M/OKeWxSBrW90ovqWdIX+4+28cWwjPkiYsB5D0Gtp3R85FI8QcgxfdYl5ssg0K6VV7dJgzC+qWlqDprGGf1UoBJdxPiyxEwrtt5g5dSEZr/eVFzm52AvI=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	PqOnSagJmcJji5jizl9lC45oPFhTWupxLUo19pbfkd3sGtJwWGG5r3c2QYVwpCC9+CA9VuxtwSzUiYkFA/b1p23rlf88zsVhGQqddC9KTe8HmkFxSIlElmRTt7nNmDzRIWesUOhXRqDQtSHuFQdga//gri+Le76GnKyBsjvFFqe/hQVJe6Z6eo4luQEbmIyGfBFw5Ro/D8h8MhAnEQZ92r9IdzW7esne1XbR+UXcoE98PuNSKBZ297pVhwOfuXpDMs6QiORA3YHm57HxOZXTAbdBc3CawTAm+Kr3gwmuYaGtH5tuGbXSset/1CcvUKIg9FBguELmr9m/F0t7HnY9gWJMr8gLC1Ye0m0mG3DCpNMHaQjcXZyR2V0+vWCKPo+7AvWA+LG3FK85u456+cEjKx6uG5v1G+1x2ebYE2YN3mBPUInp2IR35qeNJ6AiFgTe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 18:13:17.4095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 11811f7a-6885-4907-91a5-08deac645025
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB999203
Message-ID-Hash: D54DRVBUNATQTS2DN4XX6E4KWYCZIVXC
X-Message-ID-Hash: D54DRVBUNATQTS2DN4XX6E4KWYCZIVXC
X-MailFrom: Vijendar.Mukunda@amd.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/D54DRVBUNATQTS2DN4XX6E4KWYCZIVXC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add ACP7.x PCI driver probe and remove sequence for ACP7.D/7.E/7.F
variants.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp7x/acp7x.h     |  31 ++++++++++
 sound/soc/amd/acp7x/pci-acp7x.c | 100 ++++++++++++++++++++++++++++++++
 2 files changed, 131 insertions(+)
 create mode 100644 sound/soc/amd/acp7x/acp7x.h
 create mode 100644 sound/soc/amd/acp7x/pci-acp7x.c

diff --git a/sound/soc/amd/acp7x/acp7x.h b/sound/soc/amd/acp7x/acp7x.h
new file mode 100644
index 000000000000..b4586a2afae4
--- /dev/null
+++ b/sound/soc/amd/acp7x/acp7x.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * AMD Common ACP header file for ACP7.X variants(ACP7.D/7.E/7.F)
+ *
+ * Copyright (C) 2026 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#ifndef __SOUND_SOC_AMD_ACP7X_H
+#define __SOUND_SOC_AMD_ACP7X_H
+
+#include <linux/io.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+
+#include <sound/acp7x_chip_offset_byte.h>
+
+#define ACP_DEVICE_ID		0x15E2
+#define ACP7X_REG_START		0x1240000
+#define ACP7X_REG_END		0x125C000
+
+#define ACP7D_PCI_REV		0x7D
+#define ACP7E_PCI_REV		0x7E
+#define ACP7F_PCI_REV		0x7F
+
+int snd_amd_acp_find_config(struct pci_dev *pci);
+
+struct acp7x_dev_data {
+	void __iomem *acp7x_base;
+};
+
+#endif /* __SOUND_SOC_AMD_ACP7X_H */
diff --git a/sound/soc/amd/acp7x/pci-acp7x.c b/sound/soc/amd/acp7x/pci-acp7x.c
new file mode 100644
index 000000000000..476b3ae52634
--- /dev/null
+++ b/sound/soc/amd/acp7x/pci-acp7x.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMD common ACP PCI driver for ACP7.x variants
+ * which includes ACP7.D/7.E/7.F and future variants
+ * with same register layout.
+ *
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include "acp7x.h"
+
+static int snd_acp7x_probe(struct pci_dev *pci,
+			   const struct pci_device_id *pci_id)
+{
+	struct acp7x_dev_data *adata;
+	u32 addr;
+	u32 flag;
+	int ret;
+
+	flag = snd_amd_acp_find_config(pci);
+	if (flag)
+		return -ENODEV;
+
+	/* ACP PCI revision id check for ACP7.x platforms */
+	switch (pci->revision) {
+	case ACP7D_PCI_REV:
+	case ACP7E_PCI_REV:
+	case ACP7F_PCI_REV:
+		break;
+	default:
+		return -ENODEV;
+	}
+	if (pci_enable_device(pci)) {
+		dev_err(&pci->dev, "pci_enable_device failed\n");
+		return -ENODEV;
+	}
+
+	ret = pci_request_regions(pci, "AMD ACP7.x audio");
+	if (ret < 0) {
+		dev_err(&pci->dev, "pci_request_regions failed\n");
+		goto disable_pci;
+	}
+	adata = devm_kzalloc(&pci->dev, sizeof(struct acp7x_dev_data),
+			     GFP_KERNEL);
+	if (!adata) {
+		ret = -ENOMEM;
+		goto release_regions;
+	}
+	addr = pci_resource_start(pci, 0);
+	adata->acp7x_base = devm_ioremap(&pci->dev, addr,
+					 pci_resource_len(pci, 0));
+	if (!adata->acp7x_base) {
+		ret = -ENOMEM;
+		goto release_regions;
+	}
+	pci_set_master(pci);
+	pci_set_drvdata(pci, adata);
+	return 0;
+
+release_regions:
+	pci_release_regions(pci);
+disable_pci:
+	pci_disable_device(pci);
+
+	return ret;
+}
+
+static void snd_acp7x_remove(struct pci_dev *pci)
+{
+	pci_release_regions(pci);
+	pci_disable_device(pci);
+}
+
+static const struct pci_device_id snd_acp7x_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, ACP_DEVICE_ID),
+	.class = PCI_CLASS_MULTIMEDIA_OTHER << 8,
+	.class_mask = 0xffffff },
+	{ 0, },
+};
+MODULE_DEVICE_TABLE(pci, snd_acp7x_ids);
+
+static struct pci_driver acp7x_pci_driver  = {
+	.name = KBUILD_MODNAME,
+	.id_table = snd_acp7x_ids,
+	.probe = snd_acp7x_probe,
+	.remove = snd_acp7x_remove,
+};
+
+module_pci_driver(acp7x_pci_driver);
+
+MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
+MODULE_DESCRIPTION("AMD ACP PCI driver for ACP7.X");
+MODULE_LICENSE("GPL");
-- 
2.45.2

