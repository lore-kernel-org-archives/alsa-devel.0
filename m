Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F5CCD3442
	for <alsa-devel@archiver.kernel.org>; Thu,  7 May 2026 18:15:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7992C601F9;
	Thu,  7 May 2026 20:15:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7992C601F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778177741;
	bh=QltTvM/bP+sVk9zmZXyyAZfCyUYU7RJfJxJkGJVmK+Y=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Nf4xWUjzeQU2U4gjleIyGUINh4aP8m4e/lnH4FCAdvbCmGLhcJO1iJDTKGnim+zEy
	 FHif/Q9DwBDCksi0WW2udPdvmQXhPbJv9FW3UYTA5yESomUDJjWg4SfR+wC/mzo+94
	 oLrvBFdwIG7kzGSXKEK1c+LlQ6jPfo3hH6X6jfSc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7672BF806B8; Thu,  7 May 2026 20:13:48 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 566D6F806B9;
	Thu,  7 May 2026 20:13:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CE389F8064C; Thu,  7 May 2026 20:13:41 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010016.outbound.protection.outlook.com [52.101.201.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C777AF80651
	for <alsa-devel@alsa-project.org>; Thu,  7 May 2026 20:13:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C777AF80651
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=dA4PloeC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yS4H5NvJC8fxeZDp7/Qi16nqlsOj4soKLl7Q0knDNjJI8QwSf2BlNbHaHSpwj8BqiQ0489MEQsj3SpNZeUCoFYGRb8W9iRU54CiB6kWHaJQTvQB8hb7dh8mfXwpj0wKWk8DLDzCkgNftm/5mINpb7XpQcS9nT2sJ+opyrMx+A9vJkjdCgYR9QkvYSPzo+npe111n0tpeQR/CgpBAgOn8zr73ZO/ZEey3Eq3MYzGBFPLwms4sagf5YjkZjKF4cgxOvkyteenbuvbWCUIcEpSHJJRU4zTM/AiRMwMqOKvPhVL+SKV9f8W26dNaD6AOkc3h6jqZIrcbTMezTyXYDplHQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncugrAq60r37LtrIRlthJkFbusCoJ60T60JGpmHrl4g=;
 b=UsBLO3BYEEOak2IU4IfFjZyCtqIWVzWt+FnWRtV72iJPDdqdCwu9L9xsU0AdxCgMVxdQ1N04kPgVBvyGen+xa4w0srhqE9rK8ABS95jPr7r/oiY8IAWS2zmsoq8y3ehhjcnIq5oKj5iuUUIbx87Nyrudvb6Mtdp3KbL/d5/g/q+r9guhqmGyJHNlECYduJC9ICNFOjz+GNi9gQPNvOS8CSvwgcQQ1sQRwyDoqx/FtEuzn/1JX8n2dKJzLoR/Lx8PNBvPhzfmVT365LWC4aOIf9ml+tnO/PUkRoWdIHkpEvsVkDIbTNfTdtZSUjd8Mycqbms6FzpaIZxQI+6AFlxqww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncugrAq60r37LtrIRlthJkFbusCoJ60T60JGpmHrl4g=;
 b=dA4PloeCQjbx0X5XT7oWQbnrf73rKEntqwFSt9L/+Xl8jnRW/vnk/ZVtmAWI7aGwI1wPY7cy1Kiu4Q2abaVeqw0S2icsXcVESRt6R4kWNrm0dEgqDPkCp5AkXRrzyDpz1TFLwBh2klB+j5QNCBbe8fd+bs6SmrOboKT7wsGMEa8=
Received: from BLAPR05CA0043.namprd05.prod.outlook.com (2603:10b6:208:335::23)
 by DS0PR12MB7656.namprd12.prod.outlook.com (2603:10b6:8:11f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 18:13:27 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:208:335:cafe::3f) by BLAPR05CA0043.outlook.office365.com
 (2603:10b6:208:335::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.7 via Frontend Transport; Thu, 7
 May 2026 18:13:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 18:13:27 +0000
Received: from vijendar-linux.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 7 May
 2026 13:13:23 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <mario.limonciello@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH 5/5] ASoC: amd: acp7x: add system and runtime PM ops
Date: Thu, 7 May 2026 23:41:33 +0530
Message-ID: <20260507181251.20594-6-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|DS0PR12MB7656:EE_
X-MS-Office365-Filtering-Correlation-Id: 587c02a2-e087-4704-949e-08deac645649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	945TMoDxWyeABfu3TkzXbk/C/NQh5LRIwnAfSw4897iVHgKYOPA6qSovv1E2+q9rlL2kddJJbRcXeb12LebC65Oep7g3hm9SbKHIuOW7wTzltW7tA5bniDX8lix8RWl2cnPmfjGbYPGjmzyY6eCJRwsLNbH1XmszFmC24XnHTd2KinKm1vmsixjmF+9GdCIH2x9l7ABorAyN3ZpWBpwO72qWSrDRmYPZN1NzPwWJKxb55kZ7QfuMPkgPajqea6j/qtVIRYdtJCfFUeOzMdvIsvca1hDbC5SIE2etKMVOp+yLIRd5fVQCJWHQTOdpUu9PO3iq7RKvO4RtmLhbPU2dhVQFbgbbsRYcu/LTiJSJTS0IF21SzcxTXJDj/05XqquVoB1ji9qqjy1dOljmYqMfVNiOFuY1POOzf46iJXfiDF1+1F/92oEn+fPF5QoFXAAnGlRRSFggXBg9czgOxt/YtOnZAxYBrc2GK/R3IcdqcTmQqxmZ65BgaeocB7XbwfQ8AjlNYrhARvHjdrYl2ORLAAvGdrx9uSjJdTWxnRc7NEsOaGZgfvlkZGY+PBEfEU8AZw6vkjvOu/O1KOkqruHzXyRhrLo1rC7deU9iG9TZB6HHND4EHNa+KPiSdnM3McnwxCMDt0vjJLo0HFCHTKIUrHU430GSnt6X4OccCgS80g1fiwzEQ1PNE9ZBvhTPTFmXjYZMjasTNe82CqfKjw+caUiiOIVQmQ8N2YRpvhcWDf0=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	Yikv4hP93xxRFYI4NF3RezIBreuRhjdCp4/YrdJ8brkqViCrXU5j00lJg0XDdxXS2h8ARDOlHrNxCgPFCZ8my7tePtQ9AXL3qJLyocQmqvTzRdd3N4h45COO7CvHVZWhMSv6N8aMpyHbyqoM0p1r+inTb2uvM5/X2bL6Nk63vqGkPJaR6dq0DUj40uBFHZTEQYmfTFKO9gLfm+T2ZKIj8JIb44Be9vQ4KmNX5R7TQvQtYZQYMe6PHTYb3OOU3unSluc5Hlt2kAAbR+Rlul+rteV3qgC5uoRtaZ11n4pHRgNHBiBhEDe7z9T3ULoBqXHWr4S4Qyv9PbLt/M/N2Z19LMYIWqN8oCOXkOM/flVARBBprfPK2ZAIXx3RRQ9oGtcfsJvrVF6m498Mkrt+DjFuW5EKZj+HHqVvmQX5NoKxyZd1MCtk134ZuqfX2d5LNrvk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 18:13:27.7124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 587c02a2-e087-4704-949e-08deac645649
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7656
Message-ID-Hash: 2QFR242SOXOMYGWJEXTKULJN54KQZD3Y
X-Message-ID-Hash: 2QFR242SOXOMYGWJEXTKULJN54KQZD3Y
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2QFR242SOXOMYGWJEXTKULJN54KQZD3Y/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add ACP7.x PM callbacks and hook up system sleep and runtime PM ops for
the PCI driver.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp7x/acp7x-common.c | 43 ++++++++++++++++++++++++++++++
 sound/soc/amd/acp7x/acp7x.h        |  3 +++
 sound/soc/amd/acp7x/pci-acp7x.c    | 31 +++++++++++++++++++++
 3 files changed, 77 insertions(+)

diff --git a/sound/soc/amd/acp7x/acp7x-common.c b/sound/soc/amd/acp7x/acp7x-common.c
index 68f9b47766c4..df94864a1693 100644
--- a/sound/soc/amd/acp7x/acp7x-common.c
+++ b/sound/soc/amd/acp7x/acp7x-common.c
@@ -75,8 +75,51 @@ static int acp7x_deinit(void __iomem *acp_base, struct device *dev)
 	return 0;
 }
 
+static int __maybe_unused snd_acp7x_suspend(struct device *dev)
+{
+	struct acp7x_dev_data *adata;
+	int ret;
+
+	adata = dev_get_drvdata(dev);
+	ret = acp_hw_deinit(adata, dev);
+	if (ret)
+		dev_err(dev, "ACP de-init failed\n");
+	return ret;
+}
+
+static int __maybe_unused snd_acp7x_runtime_resume(struct device *dev)
+{
+	struct acp7x_dev_data *adata;
+	int ret;
+
+	adata = dev_get_drvdata(dev);
+	ret = acp_hw_init(adata, dev);
+	if (ret) {
+		dev_err(dev, "ACP init failed\n");
+		return ret;
+	}
+	return 0;
+}
+
+static int __maybe_unused snd_acp7x_resume(struct device *dev)
+{
+	struct acp7x_dev_data *adata;
+	int ret;
+
+	adata = dev_get_drvdata(dev);
+	ret = acp_hw_init(adata, dev);
+	if (ret)
+		dev_err(dev, "ACP init failed\n");
+
+	return ret;
+}
+
 void acp7x_hw_init_ops(struct acp_hw_ops *hw_ops)
 {
 	hw_ops->acp_init = acp7x_init;
 	hw_ops->acp_deinit = acp7x_deinit;
+	hw_ops->acp_suspend = snd_acp7x_suspend;
+	hw_ops->acp_resume = snd_acp7x_resume;
+	hw_ops->acp_suspend_runtime = snd_acp7x_suspend;
+	hw_ops->acp_resume_runtime = snd_acp7x_runtime_resume;
 }
diff --git a/sound/soc/amd/acp7x/acp7x.h b/sound/soc/amd/acp7x/acp7x.h
index d3a57705385a..ddb5eabf6828 100644
--- a/sound/soc/amd/acp7x/acp7x.h
+++ b/sound/soc/amd/acp7x/acp7x.h
@@ -33,6 +33,9 @@
 #define ACP7X_PGFSM_CNTL_POWER_ON_MASK		7
 #define ACP7X_PGFSM_STATUS_MASK			0x3F
 
+/* time in ms for runtime suspend delay */
+#define ACP_SUSPEND_DELAY_MS			2000
+
 struct acp_hw_ops {
 	int (*acp_init)(void __iomem *acp_base, struct device *dev);
 	int (*acp_deinit)(void __iomem *acp_base, struct device *dev);
diff --git a/sound/soc/amd/acp7x/pci-acp7x.c b/sound/soc/amd/acp7x/pci-acp7x.c
index 237eb06e3cad..d29a149cf175 100644
--- a/sound/soc/amd/acp7x/pci-acp7x.c
+++ b/sound/soc/amd/acp7x/pci-acp7x.c
@@ -11,6 +11,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 
@@ -92,6 +93,11 @@ static int snd_acp7x_probe(struct pci_dev *pci,
 	ret = acp_hw_init(adata, &pci->dev);
 	if (ret)
 		goto release_regions;
+
+	pm_runtime_set_autosuspend_delay(&pci->dev, ACP_SUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(&pci->dev);
+	pm_runtime_put_noidle(&pci->dev);
+	pm_runtime_allow(&pci->dev);
 	return 0;
 
 release_regions:
@@ -102,6 +108,26 @@ static int snd_acp7x_probe(struct pci_dev *pci,
 	return ret;
 }
 
+static int __maybe_unused snd_acp_suspend(struct device *dev)
+{
+	return acp_hw_suspend(dev);
+}
+
+static int __maybe_unused snd_acp_runtime_resume(struct device *dev)
+{
+	return acp_hw_runtime_resume(dev);
+}
+
+static int __maybe_unused snd_acp_resume(struct device *dev)
+{
+	return acp_hw_resume(dev);
+}
+
+static const struct dev_pm_ops acp7x_pm_ops = {
+	SET_RUNTIME_PM_OPS(snd_acp_suspend, snd_acp_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(snd_acp_suspend, snd_acp_resume)
+};
+
 static void snd_acp7x_remove(struct pci_dev *pci)
 {
 	struct acp7x_dev_data *adata;
@@ -111,6 +137,8 @@ static void snd_acp7x_remove(struct pci_dev *pci)
 	ret = acp_hw_deinit(adata, &pci->dev);
 	if (ret)
 		dev_err(&pci->dev, "ACP de-init failed\n");
+	pm_runtime_forbid(&pci->dev);
+	pm_runtime_get_noresume(&pci->dev);
 	pci_release_regions(pci);
 	pci_disable_device(pci);
 }
@@ -128,6 +156,9 @@ static struct pci_driver acp7x_pci_driver  = {
 	.id_table = snd_acp7x_ids,
 	.probe = snd_acp7x_probe,
 	.remove = snd_acp7x_remove,
+	.driver = {
+		.pm = &acp7x_pm_ops,
+	}
 };
 
 module_pci_driver(acp7x_pci_driver);
-- 
2.45.2

