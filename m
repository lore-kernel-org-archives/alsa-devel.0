Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C75CC6B08
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:06:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A2A8760224;
	Tue, 13 Oct 2026 12:06:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A2A8760224
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791885986;
	bh=GmRwoPOWDtyCBJDlmOk6BtFuTmB30+W2JBmwalus0pU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=MjHltFBxRexk1KnE7UnLM8KkTe3EunZd+kaTqDTfGxqIEVVnHkPcYnMaydBsddoZp
	 hxEDPKIcmt5Y7Lwj0S/hWSFCWiZyDgqiGMpKUI8SW9DUKFXyOlbXLFMtKUgi3AVeol
	 ONFaAKHDR6qIi3h+l7bhg5M1EwV8gU/EgPbpbLmw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5A9F7F806B5; Tue, 13 Oct 2026 12:05:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8C2BFF806A0;
	Tue, 13 Oct 2026 12:05:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6959CF8063B; Tue, 13 Oct 2026 12:04:46 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.57
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791885880;
	b=pC4uLADTqzNIwDg+ndnBpdtPws7uEQz23tIYms/QGzoQK6b1frfpHM6ArM5n1hsOxE13
	 cEBiGWMLi0tA0AZrTzdK/8BQI4rsVU8hGUIkQeBSB0PCrb/7ysKpCPCz4Lm2jWt+9WcXn
	 /AhRvmLPYsTQFY5py2CH5mh3vvqZpHrGGU/S6QWV+yM4Q0QLHEA4OSISeOAsYI0l3QDiS
	 Ws5+94dmAa8fhwymUFoE+tsk6fSTcvX6s3NMOf+RPCaR205KJns4KTcyvqCDb0j2EMWK+
	 cAq8E5f0kpXZmwxozPODPXzB8sSlzx3+PaPPOvRfmlhflqTeba/qPhIqfNSaAziO1zQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791885880;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=GmRwoPOWDtyCBJDlmOk6BtFuTmB30+W2JBmwalus0pU=;
	b=l6pwGqCceYqnhN5JH2NkUEPmDEokLrW2JJQ65WZxZjxgEB4Ka3LTZQscNZsdGvqSnus0
	 89UDELLk3FTrRpQjbZnYBAFhDFyDTet2hloUFMbbogJq+9LuPWY5QdhvP14WbmJoPmoqQ
	 TzJr7SpsuymJvhKZhrRPvnD0mnuBNFbasQRker/oCnDWlY5Si/hsxOBHi5VPmby37qTN+
	 29kt4gBFtS2X41xS+bWlxsRp/4sQwA9MnnZ4oYoXs2paN/x3g0gfP+Z7P9q70EsjnEq3G
	 dFvejxtT7Bptg6UGl/AzCK09uvm9uB1D7Ft1Qr0nE9TrtlbVMsF8muhLdUL0d9ulu/Q==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=fuUZMH6V;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.57
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013057.outbound.protection.outlook.com
 [40.107.201.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6BF88F805C9
	for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2026 12:04:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6BF88F805C9
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=fuUZMH6V
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HiTJ4Tdd4I9k0XkscDm6GZCcbBID07TO1xIHGzkMtpZyHPUmUBEbweCwuOPs25kwuQtqAkqfTaTTH+iaXT1NcFZj4YRaJaWyIAgpcf+2ERwQB60aKJM9VjWh2dNIgXYaFG15B2KKs60jSGnwaH9l3WlVB39g2iWDdJxV5TeVdJ/4jOOG/JZY7+q+wyL6csNB6K1FrqbtjLxGLd8LQObB7Ql8NquS/94ATN3+bUkYKOwMz+08fKKE52iCtMr0hzO5acnG/gtxPpR/v3MUMo7SOVgVKHwAuqCIgGI5xAAh7NGmtq6e46T21YUeakkPnrOlRTJwwhb2+6pbC7vEd8J5bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCcwqrf6IeaD2fzfsI+bMLX5ammykOU1Tfiss0Z5pXw=;
 b=wWgOwUFGuNKIGZUU87Jysa1ttaFBZJxoY5q6ZA/zztnm3tLqLnmiUWXIzXDPqQxHF9CGCTGBdXXfb5bqc1iQm8mMwFnsabwAFORsW3M2X7rnRkK2Xq51Gk/Y+Fi6BqxjceDn56EeH2BAn9euFP2gPmi4XQeI/6p0ZgGdfNOJRdnhqfR7p/yLMoLHKtpbE9c6ZIVckiMHSC+15JCyXAulzl6tQzwTegonEFQ0kA0eXZhurO7XukBvvNiJzEipGzAtM2/S593TJsKy4A+gPwuZBQAhPBve6LBO+olju3vlDJY21FIdHs7/xGfyd48ecOzKFXOfmcb4pT78L9QwJAwppw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCcwqrf6IeaD2fzfsI+bMLX5ammykOU1Tfiss0Z5pXw=;
 b=fuUZMH6VsPjTKRZDfpKrSZ1Cr7Gy3kuuFoOydwY8E0VZuZvT7OK2l33LqWao+tTYUWO1VSgEn7PaRRa1Mc++zjH1LmGq4R9IP8Qkab+mlGuwyvDHZQT1dxuxLlstBaN6H8s18kKfCTJz9HUuzZFilyvPmlRg8BsywQ+xBnonvj4=
Received: from PH8PR15CA0003.namprd15.prod.outlook.com (2603:10b6:510:2d2::25)
 by SJ2PR12MB7896.namprd12.prod.outlook.com (2603:10b6:a03:4c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Tue, 13 Oct
 2026 10:04:31 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:510:2d2:cafe::f) by PH8PR15CA0003.outlook.office365.com
 (2603:10b6:510:2d2::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue,
 13 Oct 2026 10:04:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 10:04:31 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 05:04:24 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 05:04:22 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Tue, 13 Oct 2026 05:04:18 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <vkoul@kernel.org>
CC: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<Vijendar.Mukunda@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V2 6/9] soundwire: amd: introduce struct amd_sdw_hw_ops
 dispatch framework
Date: Tue, 13 Oct 2026 15:28:52 +0530
Message-ID: <20261013100306.2921771-7-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261013100306.2921771-1-Vijendar.Mukunda@amd.com>
References: <20261013100306.2921771-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|SJ2PR12MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d90937a-6e48-43e9-5a50-08df2911603c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|10067099003|261009223027099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	GqR04XaDLkoMZ5L7hwbYqDDF0Rj4pC9zOygAtbmeU/nT3QFvxOYB0w4Y0m2wA7+Qfi3dfpT+/jGERzXduwu3R4vqTIkcg9ftG34IxI1sh/rq0vwbosPbLLnIrYMJW2RCiz8ApG1XQSYsfpYSq9P9hrvh5OTUB1vpDU1InrLzGtZvG4IsQLkvdHcxYPwVWQcvmJOmFq+jqCwcN9Jfn281GEDltdbiH6Rhz5yi8aQ2TMrfPgNuh6823UKEjQhYZQL7DMdk1A0GbMkB9En961laSEnmT8W5TuxrJqTYuobe1tZf8bn7ahwhKiSUFPHisMoyiODeKKRmn/poJuurZZhMn0sq+E2IdMTCoNSTiiENWxcwokY1/DhhZqDLM1UMbdDvz79up+TxdtxsT7WnLbm/AdP2aEYLw1+2gaslzSVDMjLiK6BZAWfmQPzhJpGxNeI03w9Pu5d0j9+aZmebOXC4UFj7mCPNUaqHisVCMUqG9w7JGxlbBreaTNJBHve75fpFKAYi1uiv3fl8TUx+hQ6xbwVMuranFeEIgAQg6rH20qV903zhD27GWu7x8ZXTt0tehD0YIM1YcdjSgM8os+8gomNr6d292XQCtjO23TOGT/Giy+sIfeLpW5sdDd/nibwAPVcuwmFGqUaCgXKGu6DeGK7+3GZj/euZPgVLsU6xwwn1HuU7vzZClbumbXjsok/imV2aVPNvcbHemJA7w5aRvA==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(10067099003)(261009223027099003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	QvqlRXK6YLNIZFZo/MGLro9Kn+WB1CsZUHEiaXpO5Yx7Cl7MQdRyjz/U7kgcaKp3U33IZVLDR+ffLVmAKLnsNX5JKy+XBGpDZbanEpLq0qwzXyk0CDQ/j8M/UaUuwUtvSU5le9uqL9m9IloHCa1zQIMQeSoQvLzbU1bXdO7GvBNhga48uYE7YBdQVGqPYQvrSLG2pRegHt08mXLWItimiLXaKoTXjJRR1cDLd1S/oO4pzwjmYAtCPjtwS3Et25KC3iBp5eZ54zArztM8grdJvN8/evhgtPZx5aRtNpExSYsHGRS1XZwLn9fqP4tG0L1XcEb0FRcWdHK6QQwtVjXC7jow+KDnsfEzRsEQxz7+1kidXgzvYsuEfX/6D8ZDE6+rM8PYejRbVo2mTjTvZyFGHzpKSFXR/qt7eGzz8xZNXFwIO0npkcB6kWjCDu5+GuD7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 10:04:31.4984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 3d90937a-6e48-43e9-5a50-08df2911603c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7896
Message-ID-Hash: NCRIK2SINIXYLLTPEVVEW7QTKQU4T7FU
X-Message-ID-Hash: NCRIK2SINIXYLLTPEVVEW7QTKQU4T7FU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NCRIK2SINIXYLLTPEVVEW7QTKQU4T7FU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add struct amd_sdw_hw_ops, a function-pointer dispatch table for
hardware-revision-specific SoundWire manager operations, including
register-level init/enable/disable, interrupt masking, frameshape,
wake/host-wake, command/response, ping handling, clock-stop exit,
and the PM suspend/resume paths. Add inline dispatch helpers for
each callback and a const hw_ops pointer in struct amd_sdw_manager.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/amd_manager.h   | 175 ++++++++++++++++++++++++++++++
 include/linux/soundwire/sdw_amd.h |   4 +
 2 files changed, 179 insertions(+)

diff --git a/drivers/soundwire/amd_manager.h b/drivers/soundwire/amd_manager.h
index 63fecff62079..d66b8d6f41c1 100644
--- a/drivers/soundwire/amd_manager.h
+++ b/drivers/soundwire/amd_manager.h
@@ -274,4 +274,179 @@ static u32 sdw_manager_reg_mask_array[AMD_ACP63_SDW_MAX_MANAGER_COUNT] =  {
 		AMD_SDW0_EXT_INTR_MASK,
 		AMD_SDW1_EXT_INTR_MASK
 };
+
+#define AMD_SDW_HW_OPS(amd_manager, cb)	((amd_manager)->hw_ops->cb)
+
+/**
+ * struct amd_sdw_hw_ops - hardware-revision-specific SoundWire manager ops
+ *
+ * @init_sdw_manager: enable the SoundWire manager hardware and perform bus reset
+ * @enable_sdw_manager: set the manager enable bit and wait for it to assert
+ * @disable_sdw_manager: clear the manager enable bit and wait for it to deassert
+ * @enable_sdw_interrupts: unmask ACP-level and per-manager interrupt bits
+ * @disable_sdw_interrupts: mask ACP-level and per-manager interrupt bits
+ * @set_frameshape: write the row/column frame-shape register
+ * @send_cmd_get_resp: issue an immediate command and return the response;
+ *   returns 0 on success with the raw u64 response in @response,
+ *   or negative on hardware timeout
+ * @wake_enable: enable or disable the in-band SoundWire wake interrupt
+ * @host_wake_enable: enable or disable the host-side wake interrupt
+ * @set_device_state: write the D0/D3 device power state for the manager instance
+ * @read_and_process_ping_status: issue a PING command and process the slave
+ *   attach/detach status; called from the IRQ work path
+ * @process_wake_event: handle an in-band wake notification from a slave
+ * @clk_init_ctrl: set the clock divider and update the frame shape registers
+ *   based on the current bus clock frequency
+ * @clock_stop_exit: restart the SoundWire bus clock after a CLK_STOP_MODE
+ *   suspend; implementation differs across ACP revisions
+ * @suspend: system-suspend hook; stops the bus and powers down the manager
+ * @suspend_runtime: runtime-suspend hook; same sequence as @suspend
+ * @resume_runtime: runtime-resume hook; reinitialises the manager and restarts
+ *   the bus after a POWER_OFF_MODE or CLK_STOP_MODE suspend
+ */
+struct amd_sdw_hw_ops {
+	int (*init_sdw_manager)(struct amd_sdw_manager *amd_manager);
+	int (*enable_sdw_manager)(struct amd_sdw_manager *amd_manager);
+	int (*disable_sdw_manager)(struct amd_sdw_manager *amd_manager);
+	void (*enable_sdw_interrupts)(struct amd_sdw_manager *amd_manager);
+	void (*disable_sdw_interrupts)(struct amd_sdw_manager *amd_manager);
+	void (*set_frameshape)(struct amd_sdw_manager *amd_manager);
+	int (*send_cmd_get_resp)(struct amd_sdw_manager *amd_manager, u32 lower_data,
+				 u32 upper_data, u64 *response);
+	void (*wake_enable)(struct amd_sdw_manager *amd_manager, bool enable);
+	int (*host_wake_enable)(struct amd_sdw_manager *amd_manager, bool enable);
+	int (*set_device_state)(struct amd_sdw_manager *amd_manager, u32 target_device_state);
+	void (*read_and_process_ping_status)(struct amd_sdw_manager *amd_manager);
+	void (*process_wake_event)(struct amd_sdw_manager *amd_manager);
+	int (*clk_init_ctrl)(struct amd_sdw_manager *amd_manager);
+	int (*clock_stop_exit)(struct amd_sdw_manager *amd_manager);
+	int (*suspend)(struct amd_sdw_manager *amd_manager);
+	int (*suspend_runtime)(struct amd_sdw_manager *amd_manager);
+	int (*resume_runtime)(struct amd_sdw_manager *amd_manager);
+};
+
+static inline int acp_init_sdw_manager(struct amd_sdw_manager *amd_manager)
+{
+	if (amd_manager && amd_manager->hw_ops && amd_manager->hw_ops->init_sdw_manager)
+		return AMD_SDW_HW_OPS(amd_manager, init_sdw_manager)(amd_manager);
+	return -EOPNOTSUPP;
+}
+
+static inline int acp_enable_sdw_manager(struct amd_sdw_manager *amd_manager)
+{
+	if (amd_manager && amd_manager->hw_ops && amd_manager->hw_ops->enable_sdw_manager)
+		return AMD_SDW_HW_OPS(amd_manager, enable_sdw_manager)(amd_manager);
+	return -EOPNOTSUPP;
+}
+
+static inline int acp_disable_sdw_manager(struct amd_sdw_manager *amd_manager)
+{
+	if (amd_manager && amd_manager->hw_ops && amd_manager->hw_ops->disable_sdw_manager)
+		return AMD_SDW_HW_OPS(amd_manager, disable_sdw_manager)(amd_manager);
+	return -EOPNOTSUPP;
+}
+
+static inline void acp_enable_sdw_interrupts(struct amd_sdw_manager *amd_manager)
+{
+	if (amd_manager && amd_manager->hw_ops && amd_manager->hw_ops->enable_sdw_interrupts)
+		AMD_SDW_HW_OPS(amd_manager, enable_sdw_interrupts)(amd_manager);
+}
+
+static inline void acp_disable_sdw_interrupts(struct amd_sdw_manager *amd_manager)
+{
+	if (amd_manager && amd_manager->hw_ops && amd_manager->hw_ops->disable_sdw_interrupts)
+		AMD_SDW_HW_OPS(amd_manager, disable_sdw_interrupts)(amd_manager);
+}
+
+static inline void acp_sdw_set_frameshape(struct amd_sdw_manager *amd_manager)
+{
+	if (amd_manager && amd_manager->hw_ops && amd_manager->hw_ops->set_frameshape)
+		AMD_SDW_HW_OPS(amd_manager, set_frameshape)(amd_manager);
+}
+
+static inline int acp_sdw_send_cmd_get_resp(struct amd_sdw_manager *amd_manager,
+					    u32 lower_data, u32 upper_data, u64 *response)
+{
+	if (amd_manager && amd_manager->hw_ops && amd_manager->hw_ops->send_cmd_get_resp)
+		return AMD_SDW_HW_OPS(amd_manager, send_cmd_get_resp)(amd_manager,
+								      lower_data, upper_data,
+								      response);
+	return -EOPNOTSUPP;
+}
+
+static inline void acp_sdw_wake_enable(struct amd_sdw_manager *amd_manager, bool enable)
+{
+	if (amd_manager && amd_manager->hw_ops && amd_manager->hw_ops->wake_enable)
+		AMD_SDW_HW_OPS(amd_manager, wake_enable)(amd_manager, enable);
+}
+
+static inline int acp_sdw_host_wake_enable(struct amd_sdw_manager *amd_manager, bool enable)
+{
+	if (amd_manager && amd_manager->hw_ops && amd_manager->hw_ops->host_wake_enable)
+		return AMD_SDW_HW_OPS(amd_manager, host_wake_enable)(amd_manager, enable);
+	return -EOPNOTSUPP;
+}
+
+static inline int acp_sdw_set_device_state(struct amd_sdw_manager *amd_manager,
+					   u32 target_device_state)
+{
+	if (amd_manager && amd_manager->hw_ops && amd_manager->hw_ops->set_device_state)
+		return AMD_SDW_HW_OPS(amd_manager, set_device_state)(amd_manager,
+								      target_device_state);
+	return -EOPNOTSUPP;
+}
+
+static inline void acp_sdw_read_and_process_ping_status(struct amd_sdw_manager *amd_manager)
+{
+	if (amd_manager && amd_manager->hw_ops && amd_manager->hw_ops->read_and_process_ping_status)
+		AMD_SDW_HW_OPS(amd_manager, read_and_process_ping_status)(amd_manager);
+}
+
+static inline void acp_sdw_process_wake_event(struct amd_sdw_manager *amd_manager)
+{
+	if (amd_manager && amd_manager->hw_ops && amd_manager->hw_ops->process_wake_event)
+		AMD_SDW_HW_OPS(amd_manager, process_wake_event)(amd_manager);
+}
+
+static inline int acp_sdw_clk_init_ctrl(struct amd_sdw_manager *amd_manager)
+{
+	if (amd_manager && amd_manager->hw_ops && amd_manager->hw_ops->clk_init_ctrl)
+		return AMD_SDW_HW_OPS(amd_manager, clk_init_ctrl)(amd_manager);
+	return -EOPNOTSUPP;
+}
+
+static inline int acp_sdw_clock_stop_exit(struct amd_sdw_manager *amd_manager)
+{
+	if (amd_manager && amd_manager->hw_ops && amd_manager->hw_ops->clock_stop_exit)
+		return AMD_SDW_HW_OPS(amd_manager, clock_stop_exit)(amd_manager);
+	return -EOPNOTSUPP;
+}
+
+static inline int acp_sdw_suspend(struct device *dev)
+{
+	struct amd_sdw_manager *amd_manager = dev_get_drvdata(dev);
+
+	if (amd_manager && amd_manager->hw_ops && amd_manager->hw_ops->suspend)
+		return AMD_SDW_HW_OPS(amd_manager, suspend)(amd_manager);
+	return -EOPNOTSUPP;
+}
+
+static inline int acp_sdw_suspend_runtime(struct device *dev)
+{
+	struct amd_sdw_manager *amd_manager = dev_get_drvdata(dev);
+
+	if (amd_manager && amd_manager->hw_ops && amd_manager->hw_ops->suspend_runtime)
+		return AMD_SDW_HW_OPS(amd_manager, suspend_runtime)(amd_manager);
+	return -EOPNOTSUPP;
+}
+
+static inline int acp_sdw_resume_runtime(struct device *dev)
+{
+	struct amd_sdw_manager *amd_manager = dev_get_drvdata(dev);
+
+	if (amd_manager && amd_manager->hw_ops && amd_manager->hw_ops->resume_runtime)
+		return AMD_SDW_HW_OPS(amd_manager, resume_runtime)(amd_manager);
+	return -EOPNOTSUPP;
+}
+
 #endif
diff --git a/include/linux/soundwire/sdw_amd.h b/include/linux/soundwire/sdw_amd.h
index 476de2c30389..cbfa3d6b3460 100644
--- a/include/linux/soundwire/sdw_amd.h
+++ b/include/linux/soundwire/sdw_amd.h
@@ -55,10 +55,13 @@ struct sdw_amd_dai_runtime {
 	enum sdw_stream_type stream_type;
 };
 
+struct amd_sdw_hw_ops;
+
 /**
  * struct amd_sdw_manager - amd manager driver context
  * @bus: bus handle
  * @dev: linux device
+ * @hw_ops: pointer to hardware-revision-specific dispatch table
  * @mmio: SoundWire registers mmio base
  * @acp_mmio: acp registers mmio base
  * @amd_sdw_irq_thread: SoundWire manager irq workqueue
@@ -85,6 +88,7 @@ struct sdw_amd_dai_runtime {
 struct amd_sdw_manager {
 	struct sdw_bus bus;
 	struct device *dev;
+	const struct amd_sdw_hw_ops *hw_ops;
 
 	void __iomem *mmio;
 	void __iomem *acp_mmio;
-- 
2.48.1

