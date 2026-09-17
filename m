Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B67C982D2
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:08:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0DE1D6020B;
	Thu, 17 Sep 2026 11:07:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0DE1D6020B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789636087;
	bh=RZ74wEs6mPz7eNZRir7t5JGWXKTFTB3kqvlYRAuPuw0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=uSlY2gcO1lugQuWaSnYa4VN6D1CzG4zrm5D+aTDsaIEOgBSRE20bz8pNKwIIhHERv
	 ZaXep3NC487P9sUgJF1Stoo88zcCvLVvB2EmA/kIVT9ZUOBU6nkKtM45bYU/OFiBpp
	 w7W+IanLJeSy7XEfO1hmoE2w8X8w9liD7X2kMxAk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B36F4F805F2; Thu, 17 Sep 2026 11:06:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CDD47F805F2;
	Thu, 17 Sep 2026 11:06:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 15146F80579; Thu, 17 Sep 2026 11:06:04 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.40
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789635959;
	b=B4LSgl3aheIx0NnsKQ+XN3qTWwZT6PrDjvAk+R2/UtvJEy1Yaw2IY5z0CjoaacK7htjw
	 RuDaDw/8EswFPmb6lDXzLQDvD2GGeDwzSlaqSka+Gr112bpzawds01uBiMPyZEwa3mVbO
	 ujHcci4BpyRVL0gSnIOr8WzsMKujs8Y7rmeqfbw6ZF8dvL+cRoI5zSVzFuck/XAX+wFH/
	 If3oIbC4JMHOLJzQdwlXw11xHQHpRPQyCHrYQqK98Y1+9gaDgwxs+siueKW2GA1FjTNIl
	 opYFc1MEvyzPsTKPbe2qk1gcyyvirhFWSKu0AoOQso5kBg6XcA1gV+oK+C2EuokAxPw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789635959;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=RZ74wEs6mPz7eNZRir7t5JGWXKTFTB3kqvlYRAuPuw0=;
	b=T3IitTrVDMXYU19XSkUC1OqnDJM5Q+1k2PlK1HN1aGtJPSc8ZPBRgBzGtAitH7MXHcXC
	 L3nIUW5ouzF7wBfN/21b0VoxbKw2OzsbVO1zbqGDTqtaOYMi2p8GGF7ke0jF51NJUndrk
	 yw8KJgmDr9wbJjBWmnzgU0yk/9QjvioLpG5iquqGtyIhIyV1C0zauZp2dJF2vojfN+wBB
	 vtUgk2x+YMfrTBEr0/T1AnG3Yw8ZLAvB0BSgAwcJDpR8GPsefqCmXdvpF4BGGUW3ExAPS
	 uoICE7x5J9xaIYzi2p7TTKEdPlZ9DOz0tO0tsZxqF1eTXofER7e1MC6D976ZE18PiFA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=w+Ss7msK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.40
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012040.outbound.protection.outlook.com [52.101.48.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 57EB5F80688
	for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2026 11:05:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 57EB5F80688
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=w+Ss7msK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ocbcmxEwy9T6qOBj4oJbVCEID6KG9xw+do96mxhbfh2XL7R6JVopPyFHM47WLtnKhGgaXJDAQ5dQo8XhC2mNKtmZwejjbOUgs6T931mxwZVQrqG5KUh/pnoN4IdDg9n+ZUMjn+t8H8hCnWTNu/5YTATcEHaA/qSJwxScGe3205oi0t5kSK6rLQxhe20jFKm+RZZzp7dBU+aSzbKLCOe3kiAMyChxcmEPnywD4qs/uJH0gTQmdTG01gyE8djW1prH/ZsXV6JC4pSYQG/KCk5jQj2oUMaKCHyzRX3aLvm3RuHf+6U0KFKZ8bs7KR5NNnvQdgdrq4wTDWf/+o1gN7LQnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gxDgMo8qA5zmcUJKB06FY1z+RbqnFOpdOmI3fMdFPA=;
 b=uwrubB3eHGeY1tk9/SrXWC1WlsTMHfw9IcC9SIN0arr52Tnqb5KTOVvJzI8Va0H0wG541UnMoF7Jw9j74jacAtjoElu/KTi/FGjsuSkWhqwylt15d9jTzvwAIEHI0qNu3Iq1Fw0saUqxCC4PRFTAtXs+fU+9u4xIFpKIRRKDREokN/OyCY0LCBp87j/4I74vE5Bz3PQmWM5PB/S2CuHsLro3pgt9zfyDOiqVm+7UbIo6Iv0DibrJ3JN1JFCln1A2C51+tcrl0paBQWqp9f//d8y8P3q6fotIch22yoNR8BWRGyDNzOVA38PW9FR5XtHdNf7K+6DiXfiaGdoDmAOsbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gxDgMo8qA5zmcUJKB06FY1z+RbqnFOpdOmI3fMdFPA=;
 b=w+Ss7msKsRJU61cKVCJsrBPA/6h7pZUm3sra+MdWZ81fpoBHypVma3l3h8Inc4q/gedEyggFZjzjnCEYeg2lpvi0AjlCmz6404K3gw/4n0uibRANwd+huGYe+vQSl6s6LlcPDVL/Ho150F2qN7yhlIbhTwGLFH0ZivJBZb7qGNA=
Received: from PH8PR21CA0014.namprd21.prod.outlook.com (2603:10b6:510:2ce::28)
 by MW4PR12MB5643.namprd12.prod.outlook.com (2603:10b6:303:188::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 09:05:48 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::a3) by PH8PR21CA0014.outlook.office365.com
 (2603:10b6:510:2ce::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.7 via Frontend Transport; Thu, 17
 Sep 2026 09:05:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 09:05:48 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 04:05:43 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49
 via Frontend Transport; Thu, 17 Sep 2026 04:05:39 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <vkoul@kernel.org>
CC: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH 6/9] soundwire: amd: introduce struct amd_sdw_hw_ops dispatch
 framework
Date: Thu, 17 Sep 2026 14:32:54 +0530
Message-ID: <20260917090407.3828816-7-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260917090407.3828816-1-Vijendar.Mukunda@amd.com>
References: <20260917090407.3828816-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|MW4PR12MB5643:EE_
X-MS-Office365-Filtering-Correlation-Id: d9f72a1e-b788-4e1d-605a-08df149addb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|6133799003|18002099003|22082099003|10067099003|5023799004|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	LuwmEa/Ucnzn4U+3Z1ONlgqqMjYlcKoqwI9DqSEGo6rJTIvynyzWqHbTDZlx+m62S+5I8wZcu3wJ8Uj2SLXihGZ1/6Qjja8xUF+trKvQe2LusgrbQPUIPbwImhwDjwxBuX00KXjra0V89ST2lQcqjX8Ea1waga/W1WQnuUa6J9kIYh11Fu7JewW0q5skQd6ts/n0/MmPp3GIWQkTcXZumehWNqkZ4+cWqhe0H+mvoT4Ono4neHAaMRUWDchxMokICST0jQU6BgBwNGXzWyV/OkkCbmpLFzWnIh+jz4Z+P/yhx/2DvRu9TlAjU8gefG0/zM5B1nWylZW1hIZlRs0+nHvxQC1onHQOUL3EBV5c7KH/scTK/JUUokbN4S89m2PtAi4lKC+Ygkb7AIhlySiGBteLJ99NCPQjZqpaVrGSZCe/OYjt83rs3P6R1sg1fP/uKUPN7QNcLPrdPzuRIfO8/5MksR0TXadG6DmjFGIxTV8V1uszQUD/ZHeDdcFA8MHZk/ufX6ffyisO0ZVG4Y3rJppiYUnf0aROeqO5lHDo2M5/Kd1lrMzYo2F1jxHKBrIwJh4vznrRbsS4Bua7j4m64kvhDRDwJpUn3osWwPWxYCV3Aud8B9NRWiXVv/pdnC5y+23MXbQkrviICO9mZCj/QNM1EGf9lpGoyMUcruz666dM6oHm6e4l7UP3slQnXpfmF+eLgjp1gxSpz07ivFuEkA==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(6133799003)(18002099003)(22082099003)(10067099003)(5023799004)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	VptxpKKS6laJx+hv50dNow0RkQxp1QNSvhGH8PoF4GeHnPmSM1TgXhPp2nfGvQtUKUAPJo61lR9+wz1x9kIRQB+B8emNB8nt4TqPsqfln4+7Vngu9WCoOOnrIfGgSh99sPyyE73dmzj5WDzVuVYVXDt/SpGJ2GlZGPWKzeqOPLeH7qCqhPQRLp9GSb9BR8tuOIIfde5shOyqr/AwrgWQtKC5UDroVtXNX7Cmngng9COwGAgUFcyGHaWYmQafyPDp66MHmtfOlHbK7RAre+BacgXfYr+0H8Vvak3ONpkxFmyIKmGKvgfyA3r67dEFHw42Ybe3pY8vZzQzlrMhFzTbakUX7C8222N03vKDOEimXf4DyJE57tAn0ugtVAksRfEB7KjUYD+yhuukkkmF7owzyQCOZcUzqrLvTly54p7h2bEXXPqL1ALkKiZ7bbuJ96mS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:05:48.6404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 d9f72a1e-b788-4e1d-605a-08df149addb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5643
Message-ID-Hash: AQNSVGPAOMXWDGVRMJ6EOIKQKJHPPOT7
X-Message-ID-Hash: AQNSVGPAOMXWDGVRMJ6EOIKQKJHPPOT7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AQNSVGPAOMXWDGVRMJ6EOIKQKJHPPOT7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add struct amd_sdw_hw_ops, a function-pointer dispatch table for
hardware-revision-specific SoundWire manager operations. Add inline
dispatch helpers for each callback and a const hw_ops pointer in
struct amd_sdw_manager.

The irq_thread and update_slave_status_work slots take
struct amd_sdw_manager * so that different ACP revisions can register
different handler logic. hw_ops is populated and call sites are wired
through the dispatch helpers in subsequent patches.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/amd_manager.h   | 193 ++++++++++++++++++++++++++++++
 include/linux/soundwire/sdw_amd.h |   4 +
 2 files changed, 197 insertions(+)

diff --git a/drivers/soundwire/amd_manager.h b/drivers/soundwire/amd_manager.h
index 63fecff62079..2d08c6edd018 100644
--- a/drivers/soundwire/amd_manager.h
+++ b/drivers/soundwire/amd_manager.h
@@ -274,4 +274,197 @@ static u32 sdw_manager_reg_mask_array[AMD_ACP63_SDW_MAX_MANAGER_COUNT] =  {
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
+ * @irq_thread: hw_ops callback invoked by the thin work_struct wrapper on
+ *   each interrupt; reads status registers and dispatches slave events
+ * @update_slave_status_work: hw_ops callback invoked by the status-update
+ *   work item; reads slave status and updates the SoundWire core
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
+	void (*irq_thread)(struct amd_sdw_manager *amd_manager);
+	void (*update_slave_status_work)(struct amd_sdw_manager *amd_manager);
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
+static inline void acp_sdw_irq_thread(struct amd_sdw_manager *amd_manager)
+{
+	if (amd_manager && amd_manager->hw_ops && amd_manager->hw_ops->irq_thread)
+		AMD_SDW_HW_OPS(amd_manager, irq_thread)(amd_manager);
+}
+
+static inline void acp_sdw_update_slave_status_work(struct amd_sdw_manager *amd_manager)
+{
+	if (amd_manager && amd_manager->hw_ops && amd_manager->hw_ops->update_slave_status_work)
+		AMD_SDW_HW_OPS(amd_manager, update_slave_status_work)(amd_manager);
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

