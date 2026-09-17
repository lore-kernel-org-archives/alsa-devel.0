Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72E2C982D0
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:07:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EAC7B601FE;
	Thu, 17 Sep 2026 11:07:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EAC7B601FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789636051;
	bh=Az1O6u+Pq/5R1/2j5wX5FIVY8Ixh5i/6S4cYzv4aZ18=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qxRu8E/NObfvQ4+Nfxsg/Z/SuVNWe2HjtE+lh/QZrQE6W5Mc2Jr48Zl3vXyPFIOm8
	 yLUl1mWTcKp7DE5vrl0EBI5PjzBTuzjwmNTy+xeW2zGsJ/epQF9Vw4FMwlXT4T875h
	 UXKbonlrOnugpjYlifWToHe0I+fiImMwwm70r+xc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EFFCEF800C1; Thu, 17 Sep 2026 11:06:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0E8C8F806A7;
	Thu, 17 Sep 2026 11:06:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B189EF80694; Thu, 17 Sep 2026 11:06:01 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.25
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789635954;
	b=L2ydHdx1t5NczTez6/nalcOSTPIDAVSKnsmvHDPAv5oWoo21846qm87jv6eQzlexC/eV
	 AieoVYhN7u2Ve6W6NGKsfInN471xUC+1Ad3sr7ZlmtLD+fGJyeD7EZ5QjFto0kemNPKim
	 xjSWJJ+gnoMBqBuCdI6LFmpjgIDlbCz8HAgA83ojXns3hJ7Ebg4oQ3jQdoMdixeYbfuV1
	 BAWt817KHOtFOSbShdIsBV+SvbzmP5kdRDdk9m2nVlQU/rk4NG/dWItPej+SJ2HrCzne8
	 Vt8Qz0XTwzdzU+8RynV2j7x7mzf0fzwE+7II0oGFeas1FM703AAWkjFRkSYQ/iV4G2g==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789635954;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Az1O6u+Pq/5R1/2j5wX5FIVY8Ixh5i/6S4cYzv4aZ18=;
	b=BFqlS/0gfgCydFEQxj/QeqY7qKbOWfjKt5ebmL74NfP2gOz1EmFw7UaEaCoAYoe5eZZa
	 OAEDaoX0ZLQk1OaHTu+77Ll+eKDO3xDCxfDJsiVyVf0a6ERg58+77sto4jEDIHAYGFWyb
	 LGj3fXNBXYZCNTojEW6z/YwJBMSneFxXccLOgiBZ13BeUqgWDbxuIb4tru73X10xLaRgw
	 5uTF4gTCpz6n9ljaOJnP1iqBX9XsHHh48l/Ucs42qI74iXD2djvpIfpF3X4OtON9wnpV5
	 zjuq+gRLkh1Duf3Zj72An/qJOgVzCHg9TOC4jIGzvOEVSNID8Y3GkhR/cr7ch6Xq8og==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=HZbhQXib;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.25
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013025.outbound.protection.outlook.com
 [40.93.201.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 69E70F80655
	for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2026 11:05:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 69E70F80655
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=HZbhQXib
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HnGHKcIceTujQXVGpqxRHC3L6Djpg5KcoCIMzXPVVcrmbOdnb0vy/Mr3cgcHCoa8+rZAWQKwh2eFDPPF7W0gbIOSnD2A7JOYoFWW7bSoJ20DU5HI9f1RE6HjSHBu0Nrm9QWpkAkQ55/U5eWldupjUMrXViPePkuaBlfp8OWYgNpDKi6KS/Hz/jT5a1kKQR98WMW8ZDvrPfbpmYGZhZp1RDw8mL5Anpf8CGceTiCerE7iKZ0Qnij19uGslH6lVN5XDKQQN1FXu2CbXvsmy8z8CypPEaLqUsw4p43wt3q7o5FL6k2/aR19xOz820/qz1b2pa4CNvh2hhvIbn9Mmdt33w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5zZ3XcPDzunod4i3Q8KPeCdgcq7x28gnaHbhY8OQuM=;
 b=Uf/FFBCngbC7czzZz769deR/g3PS2OitBhzJaPgtsMTGFUSLJhg9biMslK55PQOssRx2e1u97TklnM/Wo8cUnKLtWsNvg8XbO4/kCofjJIo2MaDJU2iqsjnjGWRAR/z30O/fsq5GHhr+uT5lahdLpfPbQeO8Li+p6F6hb3gcGdSZuoIsZeb9GbysYdS+6W1qp5csFwefntexy1B732fSpVdW/DNs+LWoQvIFWjydcuFxB2Mt0hG1QJDeYlyz0sujv2F/oWhkIKD7bmzwa0f6j2qsq6CT5u29NUTQPmkrD5mSu3/c0yDard1PIY8OklomNsUctMB/I6DIt6rarpzLjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5zZ3XcPDzunod4i3Q8KPeCdgcq7x28gnaHbhY8OQuM=;
 b=HZbhQXibdOxyLHxBLmbfT1wn4qyAnxvpexwl2p5r68cV1RSLq71uCed5deSQOOr6MoZMliL+sCN7g9dthb9ZjjvDH+JwNUarXuOisNM+wWjtzxnsJ7iNY4mFu+JGjFcrjWtvtvoPoqZ24ZFKBC7AvcQaM/Cy2xd5GxRr7vJHuwU=
Received: from SJ2PR07CA0001.namprd07.prod.outlook.com (2603:10b6:a03:505::11)
 by SJ2PR12MB7918.namprd12.prod.outlook.com (2603:10b6:a03:4cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Thu, 17 Sep
 2026 09:05:41 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::5e) by SJ2PR07CA0001.outlook.office365.com
 (2603:10b6:a03:505::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 09:05:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 09:05:41 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 04:05:35 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49
 via Frontend Transport; Thu, 17 Sep 2026 04:05:31 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <vkoul@kernel.org>
CC: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH 4/9] soundwire: amd: rename hardware backend functions to
 amd_acp63_*() prefix
Date: Thu, 17 Sep 2026 14:32:52 +0530
Message-ID: <20260917090407.3828816-5-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260917090407.3828816-1-Vijendar.Mukunda@amd.com>
References: <20260917090407.3828816-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|SJ2PR12MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: c8d4036d-9a8e-48f5-8f53-08df149ad986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|10067099003|56012099006|11063799006|6133799003|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info: 
	VnXOw9x2pI+XPSE0Qv9161TJ5LKTmpfH1FuC5yQziRfZaw7N4rSk13bQbH4EcAlrIkY1mrg0HRkx7t2pfJWnvAFp6pVglwuwSNuUek80GEHrRGxJ6qiSGgh8+sUnbz6RNdtB4ReEb0n3eSv02h4Z83LRfzYAsW3yv8e3WIDh7rVKIrT8TyUcvKt49t3H0tw1FuePvJv8ingrAJCPFYmzmYxngBMM5lgjFIWU1yvYSKO3as2loPnvAFB25NH3lxZCL4JgGQgDeH6+/AAiocRwAYuWRSSdThk88sOlgDdrv4YV/bLAHfW8OKEBTVPnKeJO6buZjw9LX7fk8ecKykb8XTSQVS0CgHHOZBsLgqup5RQF+LKbx1heoh8X5WfUTDooUwCj17vJNXmpoM8gLsUVTwn99Wcg2V0pybcoYJ2uKGobgoMTwHa21d9PX3sve6n0H3Yn6ll5SwLdq6LfEbZMxFRv0v/LY899kc4hJRcPRRLdVClfQkdJ7VxEO2at4UJjLvENbiVrP4smCtyHbn0W8F/SgUKIfeG//cOUzR/c21Cuc9J3Z8WU2ewif2FKy75MHJu0bo/KOhG85GwRvr2r7L18MnJ6DWwUf7S7IdNCQA9DOKWmkqJ/568lckUqevp035FWG8uNxpsPilIcEHoNxzXedwPAY/qzH4qDn4hFr7OpIGo8YCKBat7JVTLNvfnNu3i5TQ7a9Mj/8AwA+gnOQw==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(3023799007)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	lkQ/t9qPMSFVaZBar2abY9uiiM4oZpHp2jFtGUowwyK3fwzAo/we1ZuPpYN77v+4O9JvWe/Mll4cA0kpUMCO7NvU5lA0wivaBD9ILNrzhQDqLF6gOToRhdQH/wLp8Y8+5lpoeiA8DbtkOJQA+cIedH44qospeVI/5IqYA4jCkybyu44RctAjY+EYstBYgDHmUOUsLZqGkTH11xrfGdoiamWVuTDLcFGVMHRE20R9PtqayaBaDYYyaimXI6AlGXKYmeVQiaw6/rSwmDBVuJ8NyGY0/C0z555PcrsJjWJ+ZeEX8atqAM+h8DViNeW1W6HnIcHuFH48+80NJCKCvHY3WunyDoiUB8i0rPjmTGMo1Bbuf9+oSpmrTJs5ZvQEQ++ZSt66JMCUyT2sFvk/8HOaMTz1DGfTDp8/CTqN6ej0VjGy0xn5QimGHdteA8evlON6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:05:41.6236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c8d4036d-9a8e-48f5-8f53-08df149ad986
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7918
Message-ID-Hash: U5FLDAVG3UW2XX7XVOLMV6LMJG5EQT5L
X-Message-ID-Hash: U5FLDAVG3UW2XX7XVOLMV6LMJG5EQT5L
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/U5FLDAVG3UW2XX7XVOLMV6LMJG5EQT5L/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

In preparation for the hw_ops dispatch framework introduced later in
this series, rename the revision-specific hardware-access functions in
amd_manager.c to the amd_acp63_*() prefix. These functions form the
ACP6.3-base-family hardware backend shared by the ACP6.3, ACP7.0,
ACP7.1 and ACP7.2 revisions and are dispatched per revision through the
amd_sdw_hw_ops table (and the sdw_master_ops structure).

The amd_acp63_ prefix denotes ACP6.3 as the base revision of this shared
IP block, not ACP6.3-only support.

Generic SoundWire protocol and bus helpers that are revision-independent
-- for example amd_sdw_xfer_msg(), amd_prop_read() and
amd_sdw_clock_stop() -- intentionally keep the amd_sdw_*() prefix, as
they are not part of the per-revision dispatch path.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/amd_manager.c | 166 +++++++++++++++++---------------
 drivers/soundwire/amd_manager.h |   7 +-
 2 files changed, 96 insertions(+), 77 deletions(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 400fa05456a1..669044430a0b 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -27,7 +27,7 @@
 
 #define to_amd_sdw(b)	container_of(b, struct amd_sdw_manager, bus)
 
-static int amd_sdw_clk_init_ctrl(struct amd_sdw_manager *amd_manager)
+static int amd_acp63_sdw_clk_init_ctrl(struct amd_sdw_manager *amd_manager)
 {
 	struct sdw_bus *bus = &amd_manager->bus;
 	struct sdw_master_prop *prop = &bus->prop;
@@ -57,7 +57,7 @@ static int amd_sdw_clk_init_ctrl(struct amd_sdw_manager *amd_manager)
 	return 0;
 }
 
-static int amd_init_sdw_manager(struct amd_sdw_manager *amd_manager)
+static int amd_acp63_init_sdw_manager(struct amd_sdw_manager *amd_manager)
 {
 	u32 val;
 	int ret;
@@ -89,7 +89,7 @@ static int amd_init_sdw_manager(struct amd_sdw_manager *amd_manager)
 				  AMD_SDW_TIMEOUT);
 }
 
-static int amd_enable_sdw_manager(struct amd_sdw_manager *amd_manager)
+static int amd_acp63_enable_sdw_manager(struct amd_sdw_manager *amd_manager)
 {
 	u32 val;
 
@@ -98,7 +98,7 @@ static int amd_enable_sdw_manager(struct amd_sdw_manager *amd_manager)
 				  AMD_SDW_TIMEOUT);
 }
 
-static int amd_disable_sdw_manager(struct amd_sdw_manager *amd_manager)
+static int amd_acp63_disable_sdw_manager(struct amd_sdw_manager *amd_manager)
 {
 	u32 val;
 
@@ -115,7 +115,7 @@ static int amd_disable_sdw_manager(struct amd_sdw_manager *amd_manager)
 				  AMD_SDW_TIMEOUT);
 }
 
-static void amd_enable_sdw_interrupts(struct amd_sdw_manager *amd_manager)
+static void amd_acp63_enable_sdw_interrupts(struct amd_sdw_manager *amd_manager)
 {
 	u32 val;
 
@@ -131,7 +131,7 @@ static void amd_enable_sdw_interrupts(struct amd_sdw_manager *amd_manager)
 	writel(AMD_SDW_IRQ_ERROR_MASK, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
 }
 
-static void amd_disable_sdw_interrupts(struct amd_sdw_manager *amd_manager)
+static void amd_acp63_disable_sdw_interrupts(struct amd_sdw_manager *amd_manager)
 {
 	u32 irq_mask;
 
@@ -146,7 +146,7 @@ static void amd_disable_sdw_interrupts(struct amd_sdw_manager *amd_manager)
 	writel(0x00, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
 }
 
-static void amd_sdw_set_frameshape(struct amd_sdw_manager *amd_manager)
+static void amd_acp63_sdw_set_frameshape(struct amd_sdw_manager *amd_manager)
 {
 	u32 frame_size;
 
@@ -154,7 +154,7 @@ static void amd_sdw_set_frameshape(struct amd_sdw_manager *amd_manager)
 	writel(frame_size, amd_manager->mmio + ACP_SW_FRAMESIZE);
 }
 
-static void amd_sdw_wake_enable(struct amd_sdw_manager *amd_manager, bool enable)
+static void amd_acp63_sdw_wake_enable(struct amd_sdw_manager *amd_manager, bool enable)
 {
 	u32 wake_ctrl;
 
@@ -167,7 +167,8 @@ static void amd_sdw_wake_enable(struct amd_sdw_manager *amd_manager, bool enable
 	writel(wake_ctrl, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
 }
 
-static int amd_sdw_set_device_state(struct amd_sdw_manager *amd_manager, u32 target_device_state)
+static int amd_acp63_sdw_set_device_state(struct amd_sdw_manager *amd_manager,
+					  u32 target_device_state)
 {
 	u32 sdw_dev_state;
 
@@ -190,7 +191,7 @@ static int amd_sdw_set_device_state(struct amd_sdw_manager *amd_manager, u32 tar
 	return 0;
 }
 
-static int amd_sdw_host_wake_enable(struct amd_sdw_manager *amd_manager, bool enable)
+static int amd_acp63_sdw_host_wake_enable(struct amd_sdw_manager *amd_manager, bool enable)
 {
 	u32 intr_cntl1;
 	u32 sdw_host_wake_irq_mask;
@@ -244,8 +245,8 @@ static void amd_sdw_ctl_word_prep(u32 *lower_word, u32 *upper_word, struct sdw_m
 	*lower_word = lower_data;
 }
 
-static int amd_sdw_send_cmd_get_resp(struct amd_sdw_manager *amd_manager, u32 lower_data,
-				     u32 upper_data, u64 *response)
+static int amd_acp63_sdw_send_cmd_get_resp(struct amd_sdw_manager *amd_manager, u32 lower_data,
+					   u32 upper_data, u64 *response)
 {
 	u32 lower_resp, upper_resp;
 	u32 sts;
@@ -301,7 +302,8 @@ amd_program_scp_addr(struct amd_sdw_manager *amd_manager, struct sdw_msg *msg)
 	scp_msg.buf = &msg->addr_page1;
 	scp_msg.flags = SDW_MSG_FLAG_WRITE;
 	amd_sdw_ctl_word_prep(&lower_data, &upper_data, &scp_msg, 0);
-	if (amd_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data, &response_buf[0])) {
+	if (amd_acp63_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data,
+					    &response_buf[0])) {
 		dev_err_ratelimited(amd_manager->dev,
 				    "SCP_addrpage command timeout for Slave %d\n", msg->dev_num);
 		return SDW_CMD_TIMEOUT;
@@ -309,7 +311,8 @@ amd_program_scp_addr(struct amd_sdw_manager *amd_manager, struct sdw_msg *msg)
 	scp_msg.addr = SDW_SCP_ADDRPAGE2;
 	scp_msg.buf = &msg->addr_page2;
 	amd_sdw_ctl_word_prep(&lower_data, &upper_data, &scp_msg, 0);
-	if (amd_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data, &response_buf[1])) {
+	if (amd_acp63_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data,
+					    &response_buf[1])) {
 		dev_err_ratelimited(amd_manager->dev,
 				    "SCP_addrpage command timeout for Slave %d\n", msg->dev_num);
 		return SDW_CMD_TIMEOUT;
@@ -374,6 +377,7 @@ static enum sdw_command_response amd_sdw_fill_msg_resp(struct amd_sdw_manager *a
 	return SDW_CMD_OK;
 }
 
+/* AMD SoundWire bus helper shared across all ACP revisions. */
 static unsigned int _amd_sdw_xfer_msg(struct amd_sdw_manager *amd_manager, struct sdw_msg *msg,
 				      int cmd_offset)
 {
@@ -381,7 +385,7 @@ static unsigned int _amd_sdw_xfer_msg(struct amd_sdw_manager *amd_manager, struc
 	u32 upper_data = 0, lower_data = 0;
 
 	amd_sdw_ctl_word_prep(&lower_data, &upper_data, msg, cmd_offset);
-	if (amd_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data, &response)) {
+	if (amd_acp63_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data, &response)) {
 		dev_err_ratelimited(amd_manager->dev, "command timeout for Slave %d\n",
 				    msg->dev_num);
 		return SDW_CMD_TIMEOUT;
@@ -389,6 +393,7 @@ static unsigned int _amd_sdw_xfer_msg(struct amd_sdw_manager *amd_manager, struc
 	return amd_sdw_fill_msg_resp(amd_manager, msg, response, cmd_offset);
 }
 
+/* AMD SoundWire bus helper shared across all ACP revisions. */
 static enum sdw_command_response amd_sdw_xfer_msg(struct sdw_bus *bus, struct sdw_msg *msg)
 {
 	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
@@ -405,6 +410,7 @@ static enum sdw_command_response amd_sdw_xfer_msg(struct sdw_bus *bus, struct sd
 	return SDW_CMD_OK;
 }
 
+/* AMD SoundWire bus helper shared across all ACP revisions. */
 static void amd_sdw_fill_slave_status(struct amd_sdw_manager *amd_manager, u16 index, u32 status)
 {
 	switch (status) {
@@ -419,6 +425,7 @@ static void amd_sdw_fill_slave_status(struct amd_sdw_manager *amd_manager, u16 i
 	}
 }
 
+/* AMD SoundWire bus helper shared across all ACP revisions. */
 static void amd_sdw_process_ping_status(u64 response, struct amd_sdw_manager *amd_manager)
 {
 	u64 slave_stat;
@@ -436,12 +443,12 @@ static void amd_sdw_process_ping_status(u64 response, struct amd_sdw_manager *am
 	}
 }
 
-static void amd_sdw_read_and_process_ping_status(struct amd_sdw_manager *amd_manager)
+static void amd_acp63_sdw_read_and_process_ping_status(struct amd_sdw_manager *amd_manager)
 {
 	u64 response;
 
 	mutex_lock(&amd_manager->bus.msg_lock);
-	if (amd_sdw_send_cmd_get_resp(amd_manager, 0, 0, &response)) {
+	if (amd_acp63_sdw_send_cmd_get_resp(amd_manager, 0, 0, &response)) {
 		mutex_unlock(&amd_manager->bus.msg_lock);
 		dev_err_ratelimited(amd_manager->dev, "SDW%x ping status timeout\n",
 				    amd_manager->instance);
@@ -454,7 +461,7 @@ static void amd_sdw_read_and_process_ping_status(struct amd_sdw_manager *amd_man
 	mutex_unlock(&amd_manager->bus.msg_lock);
 }
 
-static u32 amd_sdw_read_ping_status(struct sdw_bus *bus)
+static u32 amd_acp63_sdw_read_ping_status(struct sdw_bus *bus)
 {
 	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
 	u64 response;
@@ -463,7 +470,7 @@ static u32 amd_sdw_read_ping_status(struct sdw_bus *bus)
 	/* Called by sdw_show_ping_status() which holds msg_lock. */
 	lockdep_assert_held(&bus->msg_lock);
 
-	if (amd_sdw_send_cmd_get_resp(amd_manager, 0, 0, &response)) {
+	if (amd_acp63_sdw_send_cmd_get_resp(amd_manager, 0, 0, &response)) {
 		dev_err_ratelimited(amd_manager->dev, "SDW%x ping status timeout\n",
 				    amd_manager->instance);
 		return amd_manager->ping_slave_stat == U32_MAX ? 0 : amd_manager->ping_slave_stat;
@@ -476,7 +483,7 @@ static u32 amd_sdw_read_ping_status(struct sdw_bus *bus)
 	return slave_stat;
 }
 
-static int amd_sdw_compute_params(struct sdw_bus *bus, struct sdw_stream_runtime *stream)
+static int amd_acp63_sdw_compute_params(struct sdw_bus *bus, struct sdw_stream_runtime *stream)
 {
 	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
 	struct sdw_transport_data t_data = {0};
@@ -562,8 +569,8 @@ static int amd_sdw_compute_params(struct sdw_bus *bus, struct sdw_stream_runtime
 	return 0;
 }
 
-static int amd_sdw_port_params(struct sdw_bus *bus, struct sdw_port_params *p_params,
-			       unsigned int bank)
+static int amd_acp63_sdw_port_params(struct sdw_bus *bus, struct sdw_port_params *p_params,
+				     unsigned int bank)
 {
 	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
 	u32 frame_fmt_reg, dpn_frame_fmt;
@@ -599,9 +606,9 @@ static int amd_sdw_port_params(struct sdw_bus *bus, struct sdw_port_params *p_pa
 	return 0;
 }
 
-static int amd_sdw_transport_params(struct sdw_bus *bus,
-				    struct sdw_transport_params *params,
-				    enum sdw_reg_bank bank)
+static int amd_acp63_sdw_transport_params(struct sdw_bus *bus,
+					  struct sdw_transport_params *params,
+					  enum sdw_reg_bank bank)
 {
 	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
 	u32 dpn_frame_fmt;
@@ -676,9 +683,9 @@ static int amd_sdw_transport_params(struct sdw_bus *bus,
 	return 0;
 }
 
-static int amd_sdw_port_enable(struct sdw_bus *bus,
-			       struct sdw_enable_ch *enable_ch,
-			       unsigned int bank)
+static int amd_acp63_sdw_port_enable(struct sdw_bus *bus,
+				     struct sdw_enable_ch *enable_ch,
+				     unsigned int bank)
 {
 	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
 	u32 dpn_ch_enable;
@@ -755,6 +762,7 @@ static int sdw_master_read_amd_prop(struct sdw_bus *bus)
 	return 0;
 }
 
+/* AMD SoundWire bus helper shared across all ACP revisions. */
 static int amd_prop_read(struct sdw_bus *bus)
 {
 	sdw_master_read_prop(bus);
@@ -762,16 +770,16 @@ static int amd_prop_read(struct sdw_bus *bus)
 	return 0;
 }
 
-static const struct sdw_master_port_ops amd_sdw_port_ops = {
-	.dpn_set_port_params = amd_sdw_port_params,
-	.dpn_set_port_transport_params = amd_sdw_transport_params,
-	.dpn_port_enable_ch = amd_sdw_port_enable,
+static const struct sdw_master_port_ops amd_acp63_sdw_port_ops = {
+	.dpn_set_port_params = amd_acp63_sdw_port_params,
+	.dpn_set_port_transport_params = amd_acp63_sdw_transport_params,
+	.dpn_port_enable_ch = amd_acp63_sdw_port_enable,
 };
 
-static const struct sdw_master_ops amd_sdw_ops = {
+static const struct sdw_master_ops amd_acp63_sdw_ops = {
 	.read_prop = amd_prop_read,
 	.xfer_msg = amd_sdw_xfer_msg,
-	.read_ping_status = amd_sdw_read_ping_status,
+	.read_ping_status = amd_acp63_sdw_read_ping_status,
 };
 
 static int amd_sdw_hw_params(struct snd_pcm_substream *substream,
@@ -941,7 +949,7 @@ static int amd_sdw_register_dais(struct amd_sdw_manager *amd_manager)
 					       dais, num_dais);
 }
 
-static void amd_sdw_update_slave_status_work(struct work_struct *work)
+static void amd_acp63_sdw_update_slave_status_work(struct work_struct *work)
 {
 	struct amd_sdw_manager *amd_manager =
 		container_of(work, struct amd_sdw_manager, amd_sdw_work);
@@ -967,7 +975,7 @@ static void amd_sdw_update_slave_status_work(struct work_struct *work)
 			       ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
 			writel(AMD_SDW_IRQ_MASK_8TO11, amd_manager->mmio +
 			       ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
-			amd_sdw_read_and_process_ping_status(amd_manager);
+			amd_acp63_sdw_read_and_process_ping_status(amd_manager);
 			goto update_status;
 		} else {
 			dev_err_ratelimited(amd_manager->dev,
@@ -1001,7 +1009,7 @@ static void amd_sdw_update_slave_status(u32 status_change_0to7, u32 status_chang
 	}
 }
 
-static void amd_sdw_process_wake_event(struct amd_sdw_manager *amd_manager)
+static void amd_acp63_sdw_process_wake_event(struct amd_sdw_manager *amd_manager)
 {
 	dev_dbg(amd_manager->dev, "SoundWire Wake event reported\n");
 	pm_request_resume(amd_manager->dev);
@@ -1009,7 +1017,7 @@ static void amd_sdw_process_wake_event(struct amd_sdw_manager *amd_manager)
 	writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_8TO11);
 }
 
-static void amd_sdw_irq_thread(struct work_struct *work)
+static void amd_acp63_sdw_irq_thread(struct work_struct *work)
 {
 	struct amd_sdw_manager *amd_manager =
 			container_of(work, struct amd_sdw_manager, amd_sdw_irq_thread);
@@ -1024,10 +1032,10 @@ static void amd_sdw_irq_thread(struct work_struct *work)
 	dev_dbg(amd_manager->dev, "[SDW%d] SDW INT: 0to7=0x%x, 8to11=0x%x\n",
 		amd_manager->instance, status_change_0to7, status_change_8to11);
 	if (status_change_8to11 & AMD_SDW_WAKE_STAT_MASK)
-		return amd_sdw_process_wake_event(amd_manager);
+		return amd_acp63_sdw_process_wake_event(amd_manager);
 
 	if (status_change_8to11 & AMD_SDW_PREQ_INTR_STAT) {
-		amd_sdw_read_and_process_ping_status(amd_manager);
+		amd_acp63_sdw_read_and_process_ping_status(amd_manager);
 	} else {
 		/* Check for the updated status on peripheral device */
 		amd_sdw_update_slave_status(status_change_0to7, status_change_8to11, amd_manager);
@@ -1045,17 +1053,17 @@ int amd_sdw_manager_start(struct amd_sdw_manager *amd_manager)
 
 	prop = &amd_manager->bus.prop;
 	if (!prop->hw_disabled) {
-		ret = amd_sdw_clk_init_ctrl(amd_manager);
+		ret = amd_acp63_sdw_clk_init_ctrl(amd_manager);
 		if (ret)
 			return ret;
-		ret = amd_init_sdw_manager(amd_manager);
+		ret = amd_acp63_init_sdw_manager(amd_manager);
 		if (ret)
 			return ret;
-		amd_enable_sdw_interrupts(amd_manager);
-		ret = amd_enable_sdw_manager(amd_manager);
+		amd_acp63_enable_sdw_interrupts(amd_manager);
+		ret = amd_acp63_enable_sdw_manager(amd_manager);
 		if (ret)
 			return ret;
-		amd_sdw_set_frameshape(amd_manager);
+		amd_acp63_sdw_set_frameshape(amd_manager);
 	}
 	/* Enable runtime PM */
 	pm_runtime_set_autosuspend_delay(amd_manager->dev, AMD_SDW_MASTER_SUSPEND_DELAY_MS);
@@ -1091,15 +1099,15 @@ static int amd_sdw_manager_probe(struct platform_device *pdev)
 	amd_manager->ping_slave_stat = U32_MAX;
 	amd_manager->instance = pdata->instance;
 	amd_manager->mmio = amd_manager->acp_mmio +
-			    (amd_manager->instance * SDW_MANAGER_REG_OFFSET);
+			    (amd_manager->instance * ACP63_SDW_MANAGER_REG_OFFSET);
 	amd_manager->acp_sdw_lock = pdata->acp_sdw_lock;
 	amd_manager->acp_rev = pdata->acp_rev;
 	amd_manager->cols_index = sdw_find_col_index(AMD_SDW_DEFAULT_COLUMNS);
 	amd_manager->rows_index = sdw_find_row_index(AMD_SDW_DEFAULT_ROWS);
 	amd_manager->dev = dev;
-	amd_manager->bus.ops = &amd_sdw_ops;
-	amd_manager->bus.port_ops = &amd_sdw_port_ops;
-	amd_manager->bus.compute_params = &amd_sdw_compute_params;
+	amd_manager->bus.ops = &amd_acp63_sdw_ops;
+	amd_manager->bus.port_ops = &amd_acp63_sdw_port_ops;
+	amd_manager->bus.compute_params = &amd_acp63_sdw_compute_params;
 	amd_manager->bus.clk_stop_timeout = 200;
 	amd_manager->bus.link_id = amd_manager->instance;
 
@@ -1156,8 +1164,8 @@ static int amd_sdw_manager_probe(struct platform_device *pdev)
 		return ret;
 	}
 	dev_set_drvdata(dev, amd_manager);
-	INIT_WORK(&amd_manager->amd_sdw_irq_thread, amd_sdw_irq_thread);
-	INIT_WORK(&amd_manager->amd_sdw_work, amd_sdw_update_slave_status_work);
+	INIT_WORK(&amd_manager->amd_sdw_irq_thread, amd_acp63_sdw_irq_thread);
+	INIT_WORK(&amd_manager->amd_sdw_work, amd_acp63_sdw_update_slave_status_work);
 	return 0;
 }
 
@@ -1168,15 +1176,21 @@ static void amd_sdw_manager_remove(struct platform_device *pdev)
 
 	if (pm_runtime_enabled(&pdev->dev))
 		pm_runtime_disable(&pdev->dev);
-	amd_disable_sdw_interrupts(amd_manager);
+	amd_acp63_disable_sdw_interrupts(amd_manager);
 	cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
 	cancel_work_sync(&amd_manager->amd_sdw_work);
 	sdw_bus_master_delete(&amd_manager->bus);
-	ret = amd_disable_sdw_manager(amd_manager);
+	ret = amd_acp63_disable_sdw_manager(amd_manager);
 	if (ret)
 		dev_err(&pdev->dev, "Failed to disable device (%pe)\n", ERR_PTR(ret));
 }
 
+/*
+ * AMD SoundWire clock-stop sequence shared across all ACP revisions.
+ * Differences between revisions in this path are minimal; a switch/case
+ * on acp_rev is sufficient to accommodate any variant-specific additions
+ * needed for future platforms.
+ */
 static int amd_sdw_clock_stop(struct amd_sdw_manager *amd_manager)
 {
 	u32 val;
@@ -1208,7 +1222,7 @@ static int amd_sdw_clock_stop(struct amd_sdw_manager *amd_manager)
 	return 0;
 }
 
-static int amd_sdw_clock_stop_exit(struct amd_sdw_manager *amd_manager)
+static int amd_acp63_sdw_clock_stop_exit(struct amd_sdw_manager *amd_manager)
 {
 	int ret;
 	u32 val;
@@ -1300,7 +1314,7 @@ static int amd_sdw_host_wake_enable_by_rev(struct amd_sdw_manager *amd_manager,
 	case ACP70_PCI_REV_ID:
 	case ACP71_PCI_REV_ID:
 	case ACP72_PCI_REV_ID:
-		return amd_sdw_host_wake_enable(amd_manager, enable);
+		return amd_acp63_sdw_host_wake_enable(amd_manager, enable);
 	default:
 		dev_err(amd_manager->dev, "unexpected acp_rev 0x%x\n", amd_manager->acp_rev);
 		return -EINVAL;
@@ -1321,22 +1335,22 @@ static int __maybe_unused amd_suspend(struct device *dev)
 	}
 
 	if (amd_manager->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
-		amd_disable_sdw_interrupts(amd_manager);
+		amd_acp63_disable_sdw_interrupts(amd_manager);
 		cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
 		cancel_work_sync(&amd_manager->amd_sdw_work);
-		amd_sdw_wake_enable(amd_manager, false);
+		amd_acp63_sdw_wake_enable(amd_manager, false);
 		ret = amd_sdw_host_wake_enable_by_rev(amd_manager, false);
 		if (ret)
 			return ret;
 		ret = amd_sdw_clock_stop(amd_manager);
 		if (ret)
 			return ret;
-		amd_enable_sdw_interrupts(amd_manager);
+		amd_acp63_enable_sdw_interrupts(amd_manager);
 	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
-		amd_disable_sdw_interrupts(amd_manager);
+		amd_acp63_disable_sdw_interrupts(amd_manager);
 		cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
 		cancel_work_sync(&amd_manager->amd_sdw_work);
-		amd_sdw_wake_enable(amd_manager, false);
+		amd_acp63_sdw_wake_enable(amd_manager, false);
 		ret = amd_sdw_host_wake_enable_by_rev(amd_manager, false);
 		if (ret)
 			return ret;
@@ -1347,7 +1361,7 @@ static int __maybe_unused amd_suspend(struct device *dev)
 		ret = amd_sdw_clock_stop(amd_manager);
 		if (ret)
 			return ret;
-		ret = amd_disable_sdw_manager(amd_manager);
+		ret = amd_acp63_disable_sdw_manager(amd_manager);
 		if (ret)
 			return ret;
 	}
@@ -1357,7 +1371,7 @@ static int __maybe_unused amd_suspend(struct device *dev)
 	case ACP70_PCI_REV_ID:
 	case ACP71_PCI_REV_ID:
 	case ACP72_PCI_REV_ID:
-		ret = amd_sdw_set_device_state(amd_manager, AMD_SDW_DEVICE_STATE_D3);
+		ret = amd_acp63_sdw_set_device_state(amd_manager, AMD_SDW_DEVICE_STATE_D3);
 		if (ret)
 			return ret;
 		break;
@@ -1381,29 +1395,29 @@ static int __maybe_unused amd_suspend_runtime(struct device *dev)
 		return 0;
 	}
 	if (amd_manager->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
-		amd_disable_sdw_interrupts(amd_manager);
+		amd_acp63_disable_sdw_interrupts(amd_manager);
 		cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
 		cancel_work_sync(&amd_manager->amd_sdw_work);
-		amd_sdw_wake_enable(amd_manager, true);
+		amd_acp63_sdw_wake_enable(amd_manager, true);
 		ret = amd_sdw_host_wake_enable_by_rev(amd_manager, true);
 		if (ret)
 			return ret;
 		ret = amd_sdw_clock_stop(amd_manager);
 		if (ret)
 			return ret;
-		amd_enable_sdw_interrupts(amd_manager);
+		amd_acp63_enable_sdw_interrupts(amd_manager);
 	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
-		amd_disable_sdw_interrupts(amd_manager);
+		amd_acp63_disable_sdw_interrupts(amd_manager);
 		cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
 		cancel_work_sync(&amd_manager->amd_sdw_work);
-		amd_sdw_wake_enable(amd_manager, true);
+		amd_acp63_sdw_wake_enable(amd_manager, true);
 		ret = amd_sdw_host_wake_enable_by_rev(amd_manager, true);
 		if (ret)
 			return ret;
 		ret = amd_sdw_clock_stop(amd_manager);
 		if (ret)
 			return ret;
-		ret = amd_disable_sdw_manager(amd_manager);
+		ret = amd_acp63_disable_sdw_manager(amd_manager);
 		if (ret)
 			return ret;
 	}
@@ -1413,7 +1427,7 @@ static int __maybe_unused amd_suspend_runtime(struct device *dev)
 	case ACP70_PCI_REV_ID:
 	case ACP71_PCI_REV_ID:
 	case ACP72_PCI_REV_ID:
-		ret = amd_sdw_set_device_state(amd_manager, AMD_SDW_DEVICE_STATE_D3);
+		ret = amd_acp63_sdw_set_device_state(amd_manager, AMD_SDW_DEVICE_STATE_D3);
 		if (ret)
 			return ret;
 		if (amd_manager->wake_en_mask) {
@@ -1446,7 +1460,7 @@ static int __maybe_unused amd_resume_runtime(struct device *dev)
 	}
 
 	if (amd_manager->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
-		ret = amd_sdw_clock_stop_exit(amd_manager);
+		ret = amd_acp63_sdw_clock_stop_exit(amd_manager);
 		if (ret)
 			return ret;
 		ret = amd_sdw_host_wake_enable_by_rev(amd_manager, false);
@@ -1481,17 +1495,17 @@ static int __maybe_unused amd_resume_runtime(struct device *dev)
 			}
 		}
 		sdw_clear_slave_status(bus, SDW_UNATTACH_REQUEST_MASTER_RESET);
-		ret = amd_sdw_clk_init_ctrl(amd_manager);
+		ret = amd_acp63_sdw_clk_init_ctrl(amd_manager);
 		if (ret)
 			return ret;
-		ret = amd_init_sdw_manager(amd_manager);
+		ret = amd_acp63_init_sdw_manager(amd_manager);
 		if (ret)
 			return ret;
-		amd_enable_sdw_interrupts(amd_manager);
-		ret = amd_enable_sdw_manager(amd_manager);
+		amd_acp63_enable_sdw_interrupts(amd_manager);
+		ret = amd_acp63_enable_sdw_manager(amd_manager);
 		if (ret)
 			return ret;
-		amd_sdw_set_frameshape(amd_manager);
+		amd_acp63_sdw_set_frameshape(amd_manager);
 	}
 	switch (amd_manager->acp_rev) {
 	case ACP63_PCI_REV_ID:
@@ -1499,7 +1513,7 @@ static int __maybe_unused amd_resume_runtime(struct device *dev)
 	case ACP70_PCI_REV_ID:
 	case ACP71_PCI_REV_ID:
 	case ACP72_PCI_REV_ID:
-		ret = amd_sdw_set_device_state(amd_manager, AMD_SDW_DEVICE_STATE_D0);
+		ret = amd_acp63_sdw_set_device_state(amd_manager, AMD_SDW_DEVICE_STATE_D0);
 		if (ret)
 			return ret;
 		break;
diff --git a/drivers/soundwire/amd_manager.h b/drivers/soundwire/amd_manager.h
index 76ecaceb3ee5..adde192f61fe 100644
--- a/drivers/soundwire/amd_manager.h
+++ b/drivers/soundwire/amd_manager.h
@@ -8,7 +8,12 @@
 
 #include <linux/soundwire/sdw_amd.h>
 
-#define SDW_MANAGER_REG_OFFSET				0xc00
+/*
+ * Register offset between successive SoundWire manager instances.
+ * This value applies to ACP6.3, ACP7.0, ACP7.1, and ACP7.2. A new
+ * revision with a different offset must define its own constant.
+ */
+#define ACP63_SDW_MANAGER_REG_OFFSET				0xc00
 #define AMD_SDW_DEFAULT_ROWS				50
 #define AMD_SDW_DEFAULT_COLUMNS				10
 #define ACP_PAD_PULLDOWN_CTRL				0x0001448
-- 
2.48.1

