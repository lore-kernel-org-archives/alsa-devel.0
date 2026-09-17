Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F349C982D0
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:41:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3052160234;
	Thu, 17 Sep 2026 10:41:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3052160234
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789634505;
	bh=8L7gT1lEdGSoOfEDSJdo/baG9xD5jLVvo74uyvVUDxo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=fTUooBa4GgUqSQhEaCJkTj8iMG2Zp6upg4FQ3iHGw2BQnYBF8wTpS6oiUysAyJ2+u
	 waWsmbkdpspoygniAkdjAWrNZy4qdLxllV11/mMK5zbHN40PApsXWAzoOk1WieMuZP
	 QxzWHQbnDim0mUcV+UWz9ax9bwppVpvIYx4s7UHo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 41650F805FA; Thu, 17 Sep 2026 10:39:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3E555F8070D;
	Thu, 17 Sep 2026 10:39:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CABEEF8068F; Thu, 17 Sep 2026 10:39:27 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.22
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789634365;
	b=CK74n8mumeabwmfy9dIgaeJSTLUIQuzzSdftny8lSANb+GbQI3YdsiD/Muenmg7ub10z
	 L8myEReIjN4YYGTueTfg9DJsxQOQt1juFLntmB2BMjLqOO2bLUyZ8/AcwLPGNirw+8kC/
	 ZKITRJ6TDlF0rK11wCt0iUrRJpgJaGdmrIpmGJUqMxtRU+aNaVrpi3f0gR28tqsEiXFTk
	 pu3Xx84B5VVwuX33+4rz3uwMMx+5iYVTrV8Y3DuanvZ6guV/yA+K4qhqBkKJIGl3QeHHF
	 RebuFVi2Ay8taAe0GwbtUOSZvS6K8ULxBX53/Frcy2WBWR1sXMFDjJbhH0OvXBv0KfQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789634365;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=8L7gT1lEdGSoOfEDSJdo/baG9xD5jLVvo74uyvVUDxo=;
	b=DhR2Qbc4ofVHZjphT4UgDSYG2BBUnT2H9cn5H7cFZfYzHkOvamRzdfBlazloZkonsoyI
	 NvXBGYPgnDNH/4MVPCv84kBSgWrJyuY6QaUjzeH6DDowSMSS3NkLQEcNsXAz4lXDKavy6
	 bGeAXzaPnagN5p/7XMybxaGlI29SPpNw4uYhT3Ck/Zyh1jQMzqyVqTo+deg97rJvOrifR
	 qQxoAh+RZrCIYXC13MVmVLnwuTbx7HIkr0vqPYSooXEj0ZouMMBAHZ/pspclGudBM6VZJ
	 Dtl7vorcyfTBg/VhaWP0BYo1EERF2nfEMpPsl3yZvc5rT89l7W2AGirSV6RSardRygw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=cRH+BqTi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.22
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010022.outbound.protection.outlook.com
 [40.93.198.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3AE04F80688
	for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2026 10:39:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3AE04F80688
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=cRH+BqTi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VlJXkfVeg5078ztUlrirZc8A/XIpGtFfrJNmHzwwIuB0Fm9j4d7bWY5Xwmu1OGupleCNrzjZ+R2WrNpGXYeaqNEueTKOfWfzRYIxI+n5rW4dXECc1sfYEQpstRExJpS/T9a5Pzy5iL4A4jtUUZEGcSiBeVrEiIjkNdXzoo+cXPCCZ3d/LBe6vfSNaGgSUXpyGK1n33HtenVyoPqAR2oUqyabb6xy0J8ylAaOOXRL68BsMbnLlu9sUVxvAusVQYk7xmwlcr7nsXe473kpuBq96tlwbGCumJfaxL/2cn30OfVVlAY/0cYOIy14wb2nBhlKHsQzXxqFrMQAqV2Pxu8wOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSmyffqLCbyReJQ+rBc5VPUykzYlhk+8fz+hvqCOZ40=;
 b=CLNcjZSNPyIOWc90MARzpcMBGLk56NYF8xaBgTSmKEvOpUc3l3KDe73zSDTFBioMu3cbMGKSNJJVS9Pd+Df5CzMlgFH46ZAwpAYim56JBBTWsY4sgfbmvmPCmviVf1p7+JIeRJ6J+SmrDdiI7QaUmE0zGQqdBVqCuWD89INkVxLI+cg+L2rfdezm2t0zZk0kJchHAjT4hjQQk23dXlAE+xiwhWNnYxTUhy11/zMTeVEu43zJG9uk5qUZZcvbsm4Vv5esm06F7X26ugmWfqIF/LPWY35yXuy2azCqN/TBJbSxMH4Dgc7qJkftrvZPcYxRAxFbjmOltdCpmHFuCo2bjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSmyffqLCbyReJQ+rBc5VPUykzYlhk+8fz+hvqCOZ40=;
 b=cRH+BqTie3YIs0tL9sF7oMe4CO2CPJkSubdMmqCGP+l7QHvHp2IRFnN2+slnrR+KNtJIzf5kYpu7XoptsLYFJEwhZiGTvnKxTW9vTZ3r5/Ob1UczojTuoexGWoRAZoZVsiqXKI9sIyydVOnWTbcgI2p6YzHEWdlhrbYadq/3v2E=
Received: from BY3PR04CA0002.namprd04.prod.outlook.com (2603:10b6:a03:217::7)
 by DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Thu, 17 Sep
 2026 08:39:17 +0000
Received: from MWH0EPF000C6194.namprd02.prod.outlook.com
 (2603:10b6:a03:217:cafe::9f) by BY3PR04CA0002.outlook.office365.com
 (2603:10b6:a03:217::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 08:39:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6194.mail.protection.outlook.com (10.167.249.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Thu, 17 Sep 2026 08:39:17 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 03:39:16 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49
 via Frontend Transport; Thu, 17 Sep 2026 03:39:12 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <vkoul@kernel.org>
CC: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH V2 8/9] soundwire: amd: replace >= ACP70 with explicit
 switch/case in PM paths
Date: Thu, 17 Sep 2026 14:04:19 +0530
Message-ID: <20260917083732.3803526-9-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260917083732.3803526-1-Vijendar.Mukunda@amd.com>
References: <20260917083732.3803526-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6194:EE_|DM6PR12MB4436:EE_
X-MS-Office365-Filtering-Correlation-Id: a61a0e69-b735-447a-6742-08df14972932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|6133799003|22082099003|18002099003|10067099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: 
	7nbqlVq3u43ZDUexcFUEnoufazEBxping1yaoXFOOzO294skpmu6Ri2SRMuor5Kh3CW6xMo8+wYjqbktHnPf1szbx08VNEsa5VbepzE+ReoWYh1+rIK3Zt3zY2mjgZeOD180Ppl5WBEDT+pSiZPSpo7Wd1TLtShYp5NHyJ8wC63hfCtnElGAIRrApngY2Xy0WM8AcljrlIG/0y3qA/bDVkgkcLYtZMjvWlcfeX3Oau5cYtgF7B2n6WT1u1dLpRsrPYKnRhTeCPcHAfzvDE3CANCGl9anC5FGX3OP1e+xTb51d3lk0uVnpplAZ3tGd5EjMR+AdnvLWxdZAcoW79IvF7wTBRVZJaz3xySrj9ftP/BDRHLVv1z/N/K1DahaCOkevkiYiJuxBcBYzm3CmNGoVrbN4uxqcwiq3HoN/jqJaYA1lhE1/dGzOqU+hPd22Z0FJs1j0t0q8QGjVRZ+gHMsoV7e6e6DicPmW85UGGMcz4fDCOR5Yi82/BDZAfJPe9AdHXlFxUhpFL5lpGm4gDCDSDjbhnJ46KjtfBAZYAZToA8n6bHiBs5F+1qLsOxvwfch21wTWhSvGaRQxxEFtk8NN9wLHurbvT7GhDV6mBhWlsnYEVI12Vo/TfwQjsmaIiJ7Z2XirS4OnV0L6Jg6G3m/ZL0K6d8UKUHq+y0LfJQi/Hn0uaAxxiN/RiLXCt50SqYKe4DtIFiTR/NFAcJkp8/kTw==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(6133799003)(22082099003)(18002099003)(10067099003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	6w2MeL5E710kZHznKRDr4yXAfbrt+h2saTujRWSZKMT9NGHM9/95cxoN1bYVGgVcSoa+kxipSD/jQs784+emzea0Zj/tZJv5yQ0aevrx4gQZtZTSWptjbwffdZ/51LD0PlYiiTOWFrGFoLVWw0VKdrUSjpsheHyK9HCTz19VJQKFfFYa+phAr5Mu7gh0dvh69RGfrHVmBMRmxfyRdeUiYJZVv6s4qwPEfXZ1wNSis6wLZgB8ouwEGe4+SYC8xdwtP6kRAo400NR6A5IppPKGfLmnABb593mxwN1gQg8+Z+JYUTbDd2PWynOULnCpz+7JjxNnMEX6092GOZngUZX2U+wLqp8c1D3BmQL14UWIWrieF2pfKYP/6mj1jpENtMRQC2JIeTnyYiRrrgB2jXHRsG1dFDKmtsaRvsqmYjT6QjwVdDzYYY959aKuGyHIQFRO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 08:39:17.2944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 a61a0e69-b735-447a-6742-08df14972932
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MWH0EPF000C6194.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436
Message-ID-Hash: DWR2FMSH6SSCKYZQSAAA476BI6VLLQ6C
X-Message-ID-Hash: DWR2FMSH6SSCKYZQSAAA476BI6VLLQ6C
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DWR2FMSH6SSCKYZQSAAA476BI6VLLQ6C/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Replace open-ended acp_rev >= ACP70_PCI_REV_ID comparisons in
amd_suspend(), amd_suspend_runtime(), and amd_resume_runtime() with
explicit per-revision handling enumerating ACP63, ACP70, ACP71, and
ACP72, so that every supported revision is handled explicitly.

The host wake enable step is guarded by acp_rev at six PM call sites.
Factor that repeated block into amd_sdw_host_wake_enable_by_rev() to
avoid duplicating the switch/case at every site. The remaining device
state transitions keep an inline switch/case as one of them carries
additional PME handling.

An unrecognised revision cannot reach these PM callbacks because
amd_sdw_manager_probe() already validates acp_rev with the same switch
and fails registration for anything unknown. The switch default therefore
emits dev_err() and returns -EINVAL to make the unexpected case visible
while keeping the error path consistent across all PM operations.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/amd_manager.c | 97 ++++++++++++++++++++++-----------
 1 file changed, 64 insertions(+), 33 deletions(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 6af224ca54a3..0cb5f4694e9a 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -1292,6 +1292,22 @@ static int __maybe_unused amd_pm_prepare(struct device *dev)
 	return 0;
 }
 
+static int amd_sdw_host_wake_enable_by_rev(struct amd_sdw_manager *amd_manager, bool enable)
+{
+	switch (amd_manager->acp_rev) {
+	case ACP63_PCI_REV_ID:
+		break;
+	case ACP70_PCI_REV_ID:
+	case ACP71_PCI_REV_ID:
+	case ACP72_PCI_REV_ID:
+		return amd_sdw_host_wake_enable(amd_manager, enable);
+	default:
+		dev_err(amd_manager->dev, "unexpected acp_rev 0x%x\n", amd_manager->acp_rev);
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int __maybe_unused amd_suspend(struct device *dev)
 {
 	struct amd_sdw_manager *amd_manager = dev_get_drvdata(dev);
@@ -1307,22 +1323,18 @@ static int __maybe_unused amd_suspend(struct device *dev)
 	if (amd_manager->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
 		cancel_work_sync(&amd_manager->amd_sdw_work);
 		amd_sdw_wake_enable(amd_manager, false);
-		if (amd_manager->acp_rev >= ACP70_PCI_REV_ID) {
-			ret = amd_sdw_host_wake_enable(amd_manager, false);
-			if (ret)
-				return ret;
-		}
+		ret = amd_sdw_host_wake_enable_by_rev(amd_manager, false);
+		if (ret)
+			return ret;
 		ret = amd_sdw_clock_stop(amd_manager);
 		if (ret)
 			return ret;
 	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
 		cancel_work_sync(&amd_manager->amd_sdw_work);
 		amd_sdw_wake_enable(amd_manager, false);
-		if (amd_manager->acp_rev >= ACP70_PCI_REV_ID) {
-			ret = amd_sdw_host_wake_enable(amd_manager, false);
-			if (ret)
-				return ret;
-		}
+		ret = amd_sdw_host_wake_enable_by_rev(amd_manager, false);
+		if (ret)
+			return ret;
 		/*
 		 * As per hardware programming sequence on AMD platforms,
 		 * clock stop should be invoked first before powering-off
@@ -1335,10 +1347,19 @@ static int __maybe_unused amd_suspend(struct device *dev)
 		if (ret)
 			return ret;
 	}
-	if (amd_manager->acp_rev >= ACP70_PCI_REV_ID) {
+	switch (amd_manager->acp_rev) {
+	case ACP63_PCI_REV_ID:
+		break;
+	case ACP70_PCI_REV_ID:
+	case ACP71_PCI_REV_ID:
+	case ACP72_PCI_REV_ID:
 		ret = amd_sdw_set_device_state(amd_manager, AMD_SDW_DEVICE_STATE_D3);
 		if (ret)
 			return ret;
+		break;
+	default:
+		dev_err(amd_manager->dev, "unexpected acp_rev 0x%x\n", amd_manager->acp_rev);
+		return -EINVAL;
 	}
 	return 0;
 }
@@ -1357,21 +1378,17 @@ static int __maybe_unused amd_suspend_runtime(struct device *dev)
 	}
 	if (amd_manager->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
 		amd_sdw_wake_enable(amd_manager, true);
-		if (amd_manager->acp_rev >= ACP70_PCI_REV_ID) {
-			ret = amd_sdw_host_wake_enable(amd_manager, true);
-			if (ret)
-				return ret;
-		}
+		ret = amd_sdw_host_wake_enable_by_rev(amd_manager, true);
+		if (ret)
+			return ret;
 		ret = amd_sdw_clock_stop(amd_manager);
 		if (ret)
 			return ret;
 	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
 		amd_sdw_wake_enable(amd_manager, true);
-		if (amd_manager->acp_rev >= ACP70_PCI_REV_ID) {
-			ret = amd_sdw_host_wake_enable(amd_manager, true);
-			if (ret)
-				return ret;
-		}
+		ret = amd_sdw_host_wake_enable_by_rev(amd_manager, true);
+		if (ret)
+			return ret;
 		ret = amd_sdw_clock_stop(amd_manager);
 		if (ret)
 			return ret;
@@ -1380,7 +1397,12 @@ static int __maybe_unused amd_suspend_runtime(struct device *dev)
 		if (ret)
 			return ret;
 	}
-	if (amd_manager->acp_rev >= ACP70_PCI_REV_ID) {
+	switch (amd_manager->acp_rev) {
+	case ACP63_PCI_REV_ID:
+		break;
+	case ACP70_PCI_REV_ID:
+	case ACP71_PCI_REV_ID:
+	case ACP72_PCI_REV_ID:
 		ret = amd_sdw_set_device_state(amd_manager, AMD_SDW_DEVICE_STATE_D3);
 		if (ret)
 			return ret;
@@ -1392,6 +1414,10 @@ static int __maybe_unused amd_suspend_runtime(struct device *dev)
 				dev_dbg(amd_manager->dev, "ACP_PME_EN:0x%x\n", val);
 			}
 		}
+		break;
+	default:
+		dev_err(amd_manager->dev, "unexpected acp_rev 0x%x\n", amd_manager->acp_rev);
+		return -EINVAL;
 	}
 	return 0;
 }
@@ -1413,11 +1439,9 @@ static int __maybe_unused amd_resume_runtime(struct device *dev)
 		ret = amd_sdw_clock_stop_exit(amd_manager);
 		if (ret)
 			return ret;
-		if (amd_manager->acp_rev >= ACP70_PCI_REV_ID) {
-			ret = amd_sdw_host_wake_enable(amd_manager, false);
-			if (ret)
-				return ret;
-		}
+		ret = amd_sdw_host_wake_enable_by_rev(amd_manager, false);
+		if (ret)
+			return ret;
 	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
 		writel(0x00, amd_manager->acp_mmio + ACP_SW_WAKE_EN(amd_manager->instance));
 		/*
@@ -1431,11 +1455,9 @@ static int __maybe_unused amd_resume_runtime(struct device *dev)
 		mutex_lock(&amd_manager->bus.msg_lock);
 		amd_manager->ping_slave_stat = U32_MAX;
 		mutex_unlock(&amd_manager->bus.msg_lock);
-		if (amd_manager->acp_rev >= ACP70_PCI_REV_ID) {
-			ret = amd_sdw_host_wake_enable(amd_manager, false);
-			if (ret)
-				return ret;
-		}
+		ret = amd_sdw_host_wake_enable_by_rev(amd_manager, false);
+		if (ret)
+			return ret;
 		val = readl(amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
 		if (val) {
 			val |= AMD_SDW_CLK_RESUME_REQ;
@@ -1461,10 +1483,19 @@ static int __maybe_unused amd_resume_runtime(struct device *dev)
 			return ret;
 		amd_sdw_set_frameshape(amd_manager);
 	}
-	if (amd_manager->acp_rev >= ACP70_PCI_REV_ID) {
+	switch (amd_manager->acp_rev) {
+	case ACP63_PCI_REV_ID:
+		break;
+	case ACP70_PCI_REV_ID:
+	case ACP71_PCI_REV_ID:
+	case ACP72_PCI_REV_ID:
 		ret = amd_sdw_set_device_state(amd_manager, AMD_SDW_DEVICE_STATE_D0);
 		if (ret)
 			return ret;
+		break;
+	default:
+		dev_err(amd_manager->dev, "unexpected acp_rev 0x%x\n", amd_manager->acp_rev);
+		return -EINVAL;
 	}
 	return 0;
 }
-- 
2.48.1

