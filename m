Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028D7C88E72
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:08:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E37A9601DB;
	Thu, 17 Sep 2026 11:08:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E37A9601DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789636102;
	bh=UhjWIzn5/ZPIkzuw909f480Q7xih7UyW4h9cIYXgnkU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=q9i+BXCj69j75VlFNueUmqBZRqRfjUuPNkrrcPRBjomJDxqWqlAmltp8dnSShiHki
	 qqMTj5VvETnbB8OWVTNxwhXtppbhrbANjs4qhhsUxBi75k9SFl9Q5iRlRLgisk5SPs
	 hro7VoAEHs9bJTmEc+bZVFc3yyv+vx+8BJ0j2Yfw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 40072F80726; Thu, 17 Sep 2026 11:06:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6812BF80715;
	Thu, 17 Sep 2026 11:06:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 87E69F80692; Thu, 17 Sep 2026 11:06:08 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.52
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789635965;
	b=H9OkXjBXs0XyTlpOBnkesO7CotA3R+Pw2DsTMg+GG7AbObVU7rtnES0nlmZbIEnMLS/o
	 vJowezJyY46kZ+12awGvhcKWBa34fRlEJlXPNO3Pb+R2V5t/GrituHlbqh0Od2dZuYm7m
	 m5L5cuyc/1oKE+JDW+9EE5SRvDjCM3FWeGqwN8a2XSAyX+rhY+R0Od7hyRIS2E6lac9yw
	 qQ1vnGbpMZZ3VCUC9N0LJg70lMVz5gZdREWP9vq1T/HkcAT3Ucb9lQNsSJwkndTRDSmVL
	 JNMSqyEWTzUaWXmvLExU+HM0Uj8exaq3aC+iR2N761YtpnBOTmrw/GGUkQj9tnUi6eA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789635965;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=UhjWIzn5/ZPIkzuw909f480Q7xih7UyW4h9cIYXgnkU=;
	b=IubnHhpwoBgQiVM5Wl8P1j7XBD2g8oN/lVv7zd5iaiXEAsqSN9pESjbqDmZvvqlU8Q3T
	 QrUyyYE9C23abSWQm62Uf4TQrHbtOwWgyOudKFoiwgc2vkZ0LpNoaNtp6dRzFUAObXop6
	 pF/D03qMDP8ASTDM9cuyL3TBSYnBf2qwCOKXC5T3tLBBIJauOvTAsyY66bIpvgFKv/lZJ
	 D5t6mSfX3/oWwpeFKn/bsDHibWkpawLLMATwVxlrYCp0oi0yWJARSmuthragrn2CjxHe5
	 L367dgmlWnuWUyrU+PKGGuSFmtVowUAjhqqCk9fhtGUOnijpfBY4AhNPEbk/E6+ePZQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=k274PZzf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.52
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012052.outbound.protection.outlook.com [52.101.53.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6959BF800C1
	for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2026 11:06:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6959BF800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=k274PZzf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Plbm2+jki2y2zW8PBP9/pFYRYHqSjZZCm98M16KZPLO9K1HCxy7qToqIFX9m6pMDnYj/gKyvYiPHk8yZWwJat4dr6B2PXqELH9Rz0bmN5fRuVEIF9oGCCQKwK4WDkOUrIAMVELwN+fGCtCdKC6K0nhMzkZifxYlgqwEFaM+Tk3+uOz+rpeTR7TR+ZQHgz1hSdxkXe8AcwjybmDUNvc/u8I0+oHqB4t0iPKHSnVKkfqOx7AqAz4RndRU4c49gVPzmFgsf9xp3LwibbntrqxNZ2xpzCjm9jzE0HK+O2M1nOAmrMCy8Fc1vBLSINn5l+sUH6wV7afUG4bbetS3K7p56Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiZdtUHq+sTdMD1m+VkCV+FlkQm555kdMdF/d/ZP1Ik=;
 b=xfgTrOJAdOEA23DAPRloK8NRhd6YFSlj/6Uh92KKCWWgFARbyWDUc7EOjgc7neLkCYXPNdvJ2/ipoO2Gm9RqxKjjT0yutmi7Ap+7enrYq4S4bKXiXjw+Ynnz2DuzeLBkc53JKlqSBxf6FR9N6isW/hCJ9nmjmkJqnLVsJDYk3r6qCu1xCDN7QK09FaCHooC5KOsvufRSHZBPU6AtVrZGU0DdjLcn8hxUDTbVIq8Moa8Qoktg6/eL3NS88InrE1CaAm2fi4zusttGDSN37srBLXWupvOKGVmQf3Miv7e3kEai6Z0a+nhVHNYOSc8pcb5yi+tqIZG8ClCSzWSVum40RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiZdtUHq+sTdMD1m+VkCV+FlkQm555kdMdF/d/ZP1Ik=;
 b=k274PZzfMHKRdaDGE+nw0m0cT2k9yGYQJrgsyWun2DahyNeh88KnnGENEBPvfUvIf3C7T2QU9aH0W3T2XsCGLWJW9oo3pJp+KF5VWwViN2xWECBLayBdFTyvs3v/ZuBa+vPjPQQF8Xzc7lA8v/7q8Hxdbef2zVXiNoZ4QTXGROA=
Received: from PH8PR21CA0009.namprd21.prod.outlook.com (2603:10b6:510:2ce::26)
 by BN7PPFD91879A44.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 09:05:56 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::6c) by PH8PR21CA0009.outlook.office365.com
 (2603:10b6:510:2ce::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.7 via Frontend Transport; Thu, 17
 Sep 2026 09:05:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 09:05:56 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 04:05:47 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49
 via Frontend Transport; Thu, 17 Sep 2026 04:05:43 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <vkoul@kernel.org>
CC: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH 7/9] soundwire: amd: convert irq/work handlers to hw_ops
 callbacks
Date: Thu, 17 Sep 2026 14:32:55 +0530
Message-ID: <20260917090407.3828816-8-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260917090407.3828816-1-Vijendar.Mukunda@amd.com>
References: <20260917090407.3828816-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|BN7PPFD91879A44:EE_
X-MS-Office365-Filtering-Correlation-Id: ded98634-e645-433a-8c73-08df149ae234
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|10067099003|56012099006|6133799003|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	L4f5BU0qaF1v86nji+JNChsgGREk4GY7vB8q8SZgCXDrrca+EHBwKXN1e88rX7bzRS3Do4bBnNaiDv/YBblzLq1c4pegiJZpSt6oeOMAs5SRkcEuGqnEr6zRm4Nzndv/QhxGilQW7cQt5azQbmsmUyjwjdqph4MSgVI0Zg29PHbeAcxvXx9ns5eRY4lCSUe6nJsJtVZb6gTp8oY3H4SmzFxNN2h3U+wBEVoxL3PwkuxoduGS8jy7xRYHdJdmhPZDOONhtKUkFaOfqC6ci8JDficCik/W7vmvenk5/uzIEhb0XlXTKBy6ZgFoh4DmKJdOYFBD+tTsqesTYRCoaYmxH4XhIgNAQmNre7rxl8cj7okGvoPsbnu8lXdkdnpainfilUsgCGfK7FxGXm8u8DuGlzJMCg++XzoCELrTQ9iWVYH57flSA18vocq1CFqReQWfdJcg1sfOFgTYi56r8+PD+qjnKxbW3LcmQTDvOE13Fsq3d96QTpYl6S4J836a6J4PJZiPHrM6ZCy89k+qYYPXbKXkb7/1LEoOzZ805uKzdU22SDOR+nRs8b/0FSLwWs3Ewee0AduTa7lZewFh95FuK6qXtOqsV6ItxAB4QAlkwkrncaphWTXPj0oy+1+IjsbMSC4f2p8UCKasfIxmD/aL/Tp1pZkpucRcOA82r22rR4mLqs9zD5HFglXcxQRra5O+WKU0XrqCPMLvdXM8fmWqpg==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(10067099003)(56012099006)(6133799003)(11063799006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	ewUj7IBFrUgEMaexDbfBKpI89L+U4swnM3tRQeQLReJuhAYodJP6JOlX1lTkIjcRgRzSU7HEJVKTvlDHMq26N+JFxP3ouV0X8LrNHUmANdofy9g0Odo1EiUnMgwfAjzW+3+Noc68wFLkHpEPRWjXm0l2hCM3ZcU4SdjZ1rMbp92EZHDYeyT/lfG0VJadSVFwMaavpx+Z2qBwopuU/LZsTo/5JWdAicitZdgX/RgV8vAAgr3Nl730vo5HMraL4J9c7kao7tzAkRWmcftKQafZxrju3QhJ2EVM3fOjyNZY6ZoBcXr8XoUQP9jDNNaecUraWmHkmwBqKcp2lhaNqIMQmiZQ0O46jXgblCX2vGJurLGZmBunenb6tQ7Nd9klGOK3hMyAsY6VjpHZ5jl9xhUHARu3HBkxyYSz7S3RPKvFQJLxMpKLORGfNT/m/o9rWpXM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:05:56.1253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ded98634-e645-433a-8c73-08df149ae234
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFD91879A44
Message-ID-Hash: O5FECZYW76IEJ62O5UQMQM3EKNGA4S5Q
X-Message-ID-Hash: O5FECZYW76IEJ62O5UQMQM3EKNGA4S5Q
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/O5FECZYW76IEJ62O5UQMQM3EKNGA4S5Q/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Convert amd_acp63_sdw_irq_thread() and
amd_acp63_sdw_update_slave_status_work() from work_struct handlers
(taking struct work_struct *) to hw_ops callbacks (taking
struct amd_sdw_manager *).

Introduce thin work_struct wrappers that recover the manager pointer
via container_of and invoke the refactored functions directly. The
wrappers are wired through the acp_sdw_*() dispatch helpers in the
subsequent patch once hw_ops is populated.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/amd_manager.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 669044430a0b..87a2e779dd4e 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -17,6 +17,7 @@
 #include <linux/soundwire/sdw_registers.h>
 #include <linux/pm_runtime.h>
 #include <linux/wait.h>
+#include <linux/workqueue.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include "bus.h"
@@ -949,10 +950,8 @@ static int amd_sdw_register_dais(struct amd_sdw_manager *amd_manager)
 					       dais, num_dais);
 }
 
-static void amd_acp63_sdw_update_slave_status_work(struct work_struct *work)
+static void amd_acp63_sdw_update_slave_status_work(struct amd_sdw_manager *amd_manager)
 {
-	struct amd_sdw_manager *amd_manager =
-		container_of(work, struct amd_sdw_manager, amd_sdw_work);
 	int retry_count = 0;
 
 	if (amd_manager->status[0] == SDW_SLAVE_ATTACHED) {
@@ -985,6 +984,14 @@ static void amd_acp63_sdw_update_slave_status_work(struct work_struct *work)
 	}
 }
 
+static void amd_sdw_update_slave_status_work(struct work_struct *work)
+{
+	struct amd_sdw_manager *amd_manager =
+		container_of(work, struct amd_sdw_manager, amd_sdw_work);
+
+	amd_acp63_sdw_update_slave_status_work(amd_manager);
+}
+
 static void amd_sdw_update_slave_status(u32 status_change_0to7, u32 status_change_8to11,
 					struct amd_sdw_manager *amd_manager)
 {
@@ -1017,10 +1024,8 @@ static void amd_acp63_sdw_process_wake_event(struct amd_sdw_manager *amd_manager
 	writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_8TO11);
 }
 
-static void amd_acp63_sdw_irq_thread(struct work_struct *work)
+static void amd_acp63_sdw_irq_thread(struct amd_sdw_manager *amd_manager)
 {
-	struct amd_sdw_manager *amd_manager =
-			container_of(work, struct amd_sdw_manager, amd_sdw_irq_thread);
 	u32 status_change_8to11;
 	u32 status_change_0to7;
 
@@ -1046,6 +1051,14 @@ static void amd_acp63_sdw_irq_thread(struct work_struct *work)
 	writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_0TO7);
 }
 
+static void amd_sdw_interrupt_thread(struct work_struct *work)
+{
+	struct amd_sdw_manager *amd_manager =
+			container_of(work, struct amd_sdw_manager, amd_sdw_irq_thread);
+
+	amd_acp63_sdw_irq_thread(amd_manager);
+}
+
 int amd_sdw_manager_start(struct amd_sdw_manager *amd_manager)
 {
 	struct sdw_master_prop *prop;
@@ -1164,8 +1177,8 @@ static int amd_sdw_manager_probe(struct platform_device *pdev)
 		return ret;
 	}
 	dev_set_drvdata(dev, amd_manager);
-	INIT_WORK(&amd_manager->amd_sdw_irq_thread, amd_acp63_sdw_irq_thread);
-	INIT_WORK(&amd_manager->amd_sdw_work, amd_acp63_sdw_update_slave_status_work);
+	INIT_WORK(&amd_manager->amd_sdw_irq_thread, amd_sdw_interrupt_thread);
+	INIT_WORK(&amd_manager->amd_sdw_work, amd_sdw_update_slave_status_work);
 	return 0;
 }
 
-- 
2.48.1

