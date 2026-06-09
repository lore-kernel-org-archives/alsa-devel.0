Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCC4CD98C5
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2026 16:10:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 123CA601CC;
	Tue,  9 Jun 2026 18:10:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 123CA601CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781021447;
	bh=LGKBRb5zw1huFOOvnE+VAIAVATZRGJm6hvC0Ban25+s=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=F6EkSN1ofCGFQoCrITg8zO5N3aH6mVLL43ltgFkDV+Q5MaQT2TBiYYdQpIQ30c8aF
	 enBFIVL/VZruUj3cGulAR+jrwYZFFsIctbtCCVr7ow7GONEOjxTQCAgKNfrJiFE/mV
	 bDDNfclvB3Yb08aGztMG4GnLyNbJbSbu3UeS+w6s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4887CF80601; Tue,  9 Jun 2026 18:10:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6CE5DF805FA;
	Tue,  9 Jun 2026 18:10:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 689E7F80496; Tue,  9 Jun 2026 18:10:05 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.45
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1781021404;
	b=nxYpt89ISD6RtpAiQtHgLkMedPzcw/XaXdintSKig8L/nYzZ9OE4P6Y5xD2K+w/ipVQA
	 TuTuidCwRvGMi7H9/S/TA7v1vB8F6JeWikd+oayzEa9VMDYWIZ3HeZAFz1cUgXOkFE5wU
	 6Gb0r1J6ZOSlWL5KM9xJ5AS7mRXLy7KYhBxVep/+NMwE9M/uZK46pBG8Sz74DqAaRHj8A
	 fLydx4GWkmEJFo+0AMje5f73ZUO0woN7PRab/JCHK95qDkY0i21sT4Z0hJEaEOXEjn8of
	 qoQip4NpDI3h0RYioBI2oqSvdR6gjwZawmApNjlX+o3Qp4VxRs7temJ0J5BccjRwc/w==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781021404;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=LGKBRb5zw1huFOOvnE+VAIAVATZRGJm6hvC0Ban25+s=;
	b=ZXAWM7SFvALc3JF1mCrGaE4Q0aUPyl7XnXkVw3DaC5DcythwQF3Rqx397obr116MENPF
	 0PwCi2/vCJt+VXtXfK282ft1LT51zRHuD41aLXejPLTXxz9aH3hh8EpCyQhbuzvkvSRBy
	 DTZ6OvNIPzbqSPgIboGwCOpRjplQfxl3in47P0cCgKSHrnAG76SuvEsi6gI0ipq6T7wSJ
	 XisGgubX5QPLzoXqXXtAheO0H6JiKHq1C5ZsSxY6CJf8zD8EWwAeq+IdrIg2z1Nk293ch
	 H/ECXdAjUQQCs8SxHypq+OC0WZEJ8sKoyiha7DhgCqYKZDwi4DWbSycHn36xYFoYyVQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=2nA8G1Cn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.45
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010045.outbound.protection.outlook.com [52.101.56.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 56405F801F5;
	Tue,  9 Jun 2026 18:10:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 56405F801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=2nA8G1Cn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXrPvFfag2CzHEY/GXSn5dGs16HP/nI63t309CzzDejvkhfqrYvUU8G06fUYEfUQDAvDy580BECvSnfm6z4bFfMhO2ArqEvYhKJQtjp7cO5aPlJwrRAL3oJELCbkoC86npyQWes7k+/nGgs9oHGSg65jdiQ2I8dEu3Ejxd3YJRnbYS+CZI24tnpcMz5r+IU4VVrporEh3GFBvtPshxkxp8bbNFkVwLsEHTPeCy1Ye+BoKNfzG0ViV8fxnn/+5iajVqJMKQxTkUSx9lVeuH/dvEKlQ9bE7/oXLPo0uoRbQgfIrwIkj0XUPyOdJNnH6ozldBe0xqLovvpN59onrJmTig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPgaKcoxTo17IQWhvNSixf6xZ0UKs8S8qVqxvRYa4/4=;
 b=Vff7HkpFKpLHkpS9bfm1XOWYeAYN119P9YJWQtwu6rzFjcdBQ9q0fJn5fjDytHAS+lEccOrEyw00zCqq6p4C62GNSHp8Fn/imPxzTsi4rulYr2J1hMoyNNoEVyOhAghqkXElPqcaGa9LBbv6LwZ5MPfZqf63XiFjnRnXvaSeXYBXqbsC88M5XiVg77N4JgIhI/JeMVR2leJns0FAUcUjmrr5THHPmP2dHmZWt1bzKeF1WmMfbO2LqCx9oFC+fyAd83iV/OCH6Mzq0mCKcCUBLhM3X1r5x4umzW4Hzmy/+e4QKZ5qZL8EYQtVM+w3NjwKHcCbN7vQfLU4Pr0gE/7lng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPgaKcoxTo17IQWhvNSixf6xZ0UKs8S8qVqxvRYa4/4=;
 b=2nA8G1Cn2mOrqKcR670XzHb67+PW2lriB26m7PUR1Dt6D8gdDM+G67+HGBHqFHI8JdktGEL2I+GM5M5nkSmUyUkdScXunAfOTaqfDWNnkpdnHGfaxYUIY9pqQs6aDagmYgplXkweA/tkd8oxiCxO6TnNF4dww20qsvr12Cp9Xrg=
Received: from SJ0PR13CA0116.namprd13.prod.outlook.com (2603:10b6:a03:2c5::31)
 by SJ0PR12MB5633.namprd12.prod.outlook.com (2603:10b6:a03:428::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Tue, 9 Jun
 2026 16:09:54 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::42) by SJ0PR13CA0116.outlook.office365.com
 (2603:10b6:a03:2c5::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 16:09:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 16:09:54 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 11:09:53 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Tue, 9 Jun 2026 11:09:49 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>,
	<yung-chuan.liao@linux.intel.com>, <ranjani.sridharan@linux.intel.com>,
	<pierre-louis.bossart@linux.dev>, <perex@perex.cz>, <tiwai@suse.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<Basavaraj.Hiregoudar@amd.com>, <mario.limonciello@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<uajain@igalia.com>, <sound-open-firmware@alsa-project.org>, Vijendar Mukunda
	<Vijendar.Mukunda@amd.com>
Subject: [PATCH 1/2] ASoC: SOF: amd: fix for ipc flags check
Date: Tue, 9 Jun 2026 21:38:44 +0530
Message-ID: <20260609160938.3717513-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|SJ0PR12MB5633:EE_
X-MS-Office365-Filtering-Correlation-Id: 637fb0b2-b0ee-438d-7e9a-08dec6418b2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|7416014|56012099006|11063799006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	c/cT+NCl/GmLmoVsq/cbkmzavthJ9Uq9kv1RsgMOkgVCu7MmzESRUPJeIc5Cxbr4M8H43/ep2uqCuHVJnyl6dqDTf+D+sKFKYpIA/BHRCQju3cGHU27n8AuOHUTmNJsVQto1WlZY5t4V+1+gt+wyfAL5cjD7BDSbfzbJ7ha0Y3RRlqqkvzzbL4zXVOoFsuBtrrRwxcxn4XU706ddbY994+dRtPbI6GxRftiAI10lnF96txawLr6vOf7/yv0Ji4zGg9sKHfk2q20JZuuPrjxIOzwgDDbiNFGWMPNSXzWNnawY9K44Qhzm2FvRq6z47BdwrF2WQLFuCc0SnA9bEBibrHRIRNPs6IfeoTtnksR6MbxMas1kkXEbob4YVrM1RvA+J/P+ytL4x7foo+TTR8CqwbAMR3fuzUSJx1Ma4UOXPrJpknS4p1jV7wjfkIeLgjBN604F5UUc72mbtluZtWZeoa2aMl2mo3aibqD8cfBZHiXLLqvOWZq1aUYzWNGRLMecIs2SRfWMbvKXKiaDpAHx8KQRZSz3PQdr3oyhfa4/0gf90+q3+++rKarLkZtH57RupEBtUUHrUn1Bv6IvXJ6pRokSh6WpWG6itnIH0n6dvUekmpkEGKU4gQUkZ5E4oAhfdcskYd+ro80C4aNTzg1BR6maEuuZYBAM6MBlWSlho1//px3C9nuqi5j5eqArMgJI2S7CEArp2be3cmCbwttBq2+LU8iRWbXxe7n9kaS1PGI=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(7416014)(56012099006)(11063799006)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	M3sgabYT/mYVoDOZPDpuPFn0XoaTGBrgE4Hacqy33x/e0EZD0ZZjTUDSqffqpDLo811mSFNcO/TZ1zSsVLhnruFJzktzP98vOOnaK5LTPpDsU9FvobSQ1M5Eg8I7Mz4WN1sHgw0NPX5/2coWFSzjnVDi76K3II/Q5DM2cgjpTX9jLykrVUIQ0s6Q/w56amz6ERsqLZXze+Vjdf4bWH7sz3PxT92eFJsF6dTsx1pnQUfmsCG7M+sZr4ppr+ZZOKxNDJlBQMfOrK58AJwTq4k7Abi+wHkKtFCYHennGbezbtkoB+nuoNi+cNn5EWzPbZIyP/rz5IafmUAv4j1CSouQ825+IYBamrM1dLA7NXE13fKJHTjjrvoFXl/M2zqKcBZRhJvLCqCSLQR55t7LnPf/MHBxNMzybK7cYOERyFyyI5p9fTjb+068E+jLLWhq21Iz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 16:09:54.1952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 637fb0b2-b0ee-438d-7e9a-08dec6418b2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5633
Message-ID-Hash: 22MS65XACENIUZ7ST6PCXKHTYXI4PETN
X-Message-ID-Hash: 22MS65XACENIUZ7ST6PCXKHTYXI4PETN
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/22MS65XACENIUZ7ST6PCXKHTYXI4PETN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Firmware will set dsp_ack to 1 when firmware sends response for the IPC
command issued by host. Similarly dsp_msg flag will be updated to 1.

During ACP D0 entry, the value read from the sof_dsp_ack_write scratch
flag can be uninitialized. A non-zero garbage value is treated as a
pending DSP IPC ack before SOF_FW_BOOT_COMPLETE, causing a spurious
"IPC reply before FW_BOOT_COMPLETE" log.

Fix the condition checks for ipc flags.

Fixes: 738a2b5e2cc9 ("ASoC: SOF: amd: Add IPC support for ACP IP block")
Link: https://github.com/thesofproject/linux/pull/5642
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Tested-by: Umang Jain <uajain@igalia.com>
---
 sound/soc/sof/amd/acp-ipc.c | 4 ++--
 sound/soc/sof/amd/acp.h     | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/amd/acp-ipc.c b/sound/soc/sof/amd/acp-ipc.c
index 3cd4674dd800..94025bc799ea 100644
--- a/sound/soc/sof/amd/acp-ipc.c
+++ b/sound/soc/sof/amd/acp-ipc.c
@@ -181,14 +181,14 @@ irqreturn_t acp_sof_ipc_irq_thread(int irq, void *context)
 	}
 
 	dsp_msg = snd_sof_dsp_read(sdev, ACP_DSP_BAR, ACP_SCRATCH_REG_0 + dsp_msg_write);
-	if (dsp_msg) {
+	if (dsp_msg == ACP_DSP_MSG_SET) {
 		snd_sof_ipc_msgs_rx(sdev);
 		acp_dsp_ipc_host_done(sdev);
 		ipc_irq = true;
 	}
 
 	dsp_ack = snd_sof_dsp_read(sdev, ACP_DSP_BAR, ACP_SCRATCH_REG_0 + dsp_ack_write);
-	if (dsp_ack) {
+	if (dsp_ack == ACP_DSP_ACK_SET) {
 		if (likely(sdev->fw_state == SOF_FW_BOOT_COMPLETE)) {
 			guard(spinlock_irq)(&sdev->ipc_lock);
 
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index 2b7ea8c64106..7bcb76676a98 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -116,6 +116,8 @@
 #define ACP_SRAM_PAGE_COUNT			128
 #define ACP6X_SDW_MAX_MANAGER_COUNT		2
 #define ACP70_SDW_MAX_MANAGER_COUNT		ACP6X_SDW_MAX_MANAGER_COUNT
+#define ACP_DSP_MSG_SET				1
+#define ACP_DSP_ACK_SET				1
 
 enum clock_source {
 	ACP_CLOCK_96M = 0,
-- 
2.48.1

