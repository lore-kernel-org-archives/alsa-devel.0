Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464BDC88E72
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:39:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9AA32601E7;
	Thu, 17 Sep 2026 10:39:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9AA32601E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789634381;
	bh=ZKuWWTIxu/Ud6TZmMc46vnK29MCBiWRu26Yx6p8ZfiU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=PObBW481r2yE/hKWWTxH4WwKkC+NWDwjUjBw2sGKTP0gAmD4ljSjnsvSEUcM+GVjY
	 /bamdyQNZuS4vJ0G6jX4fS5qCNBRcWY6h1Hz3woLMCFMPt/0LoxqbiKaXfxaESBDTw
	 2+e0xTvYjZ1bPwdlg2/YRHPQbDsuSN0VUInmJwSk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 420F6F805FC; Thu, 17 Sep 2026 10:39:09 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 289BBF80603;
	Thu, 17 Sep 2026 10:39:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 12ACFF80537; Thu, 17 Sep 2026 10:39:01 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.58
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789634339;
	b=Quskv1WL9EjdLjlXAZxfMfBjHxwDMy5A2rYpxSxJ8Uucsq+y11Z93ch2HjMlL/31MS4J
	 k8Pu8f+sSSQKO7CWT68drwheUsbeB5nxLi1olaxJcpGSfp2AFokfnRbvSvNZnm1aHMlIC
	 vv8lIpZhX5/omiRxjzK7SjxLz/Op++8PfrGD33OX0xuP2bwq8jrd+vZ1rm3c3RnXb5LFk
	 XRv/NQkleKW1nZq9VPymCHqwG0liSEPMDiFc/pID3l4cUIeOOqNdxlsstt9XGYh2UM6dq
	 UQEJaZ4ARaf3s7tryRAh/PbUm1yNoB396olsMtSSBjpADm0NmUsjEZc8I/fUmlHhYZQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789634339;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ZKuWWTIxu/Ud6TZmMc46vnK29MCBiWRu26Yx6p8ZfiU=;
	b=jj7iZAFtRnjW12+jFxM7swhlRScecOkdw8kiWtbkJ8pud08fknZ5zoPmXFX7Pgd6NSy+
	 xiC7c3bu1QZKWM6tPD+0vjjroWw820Q45Cw0UPPW7paTN4WKL5bwocy3UfOBP5zdxVJmt
	 XTiINkHEr/YVIF0l+8HphNeN2ZYjtXkYoz47JHosIGZIgt5Y0xmT/8ZXrYtpiAZE8SSe3
	 GQxwHtefum8By7qCfbtYA9hKcAfRYDU52Inr8jhfST0xkupSw5KMbuKyQ9+aJWc1RJDIz
	 jN+xvF8J7zkgQocJ1YB41G9jdBeENNeMvIwiQm/xetTsWy+AsxHA4rWJeqWKCmMy+fA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=n7dobRZV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.58
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012058.outbound.protection.outlook.com [52.101.43.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 49514F80007
	for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2026 10:38:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 49514F80007
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=n7dobRZV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y35MsgjTWOEHMRe01QeQOfNrcNXLk0dJes5LPc0BhlCVlaigUq3mwCfgo775RJJtne2Xr8Cergh+1qWmLeX1vRoce1vuHTKPPYZaO6Iy2VjMsSwpCTegDPQXvFC935AEU7U+IOXEravVgU/EqHQxsVmdLbMChFgCUEvu7p9r9s9WjvUy4fBa9fFsyAPra3BWgo5YNUmWXluw6Q9xssJSGn3EHPPrOY3NpocR+wfgi2FrdNwBfkGF76/tpnxuaxV/4k7CFYeVXTfeJlJ01KnG8ZImZMaBvhV4EYPPJNJ6IH8ZqBs9xQQuW0+5ckRfLD9Qiy4pz2Fa8v0qGVC3sdtQjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuaCfIoV0IQbSRxWRy4R0KsnVQNCZn6kMmI6GBuuzfI=;
 b=nHg+kdpMtaQ3Lbavjn7CV/TZzw1NWlj/FATrCai8HQRnUmkTlmS0s+ga6vgkiyXHG5xAGVWeUmvNyjrnQzgJv9xIRuu3482Tzl97RUiUJ9wymenebXXhOQLY73F0zdC2tkJLop8j1HmHJ3L6zejzzy5N15wi2Ae3eJ5samQ7P/QL8wpLC+PPx+w717OH0NDqqoEy8Lrn6mJF4dMTNtngCxBaH3lVvFBp1RyU29Y5YCsDcAlEGa7420q5h80s0iUik8ZPeTEpmXFhgNh6yep+0Q6/kSQ85UkHhghUCT0UMtqvFSqw3XTdH7KAJMdWEFdwrZ9VztRnf2vYbKJv05lipg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuaCfIoV0IQbSRxWRy4R0KsnVQNCZn6kMmI6GBuuzfI=;
 b=n7dobRZVUhF07ryzCSwfWkdUy9EBgcLRpPbqGB0joQ7JaTQDG6QGmLdvSlEJTAghnL5CSK6h/VzgXHZ8BkF2c5qhSx+abZci47gih1AP8MIAeBouehkGZhzdBBAPBoGlkDrIr+TUgiHliDD0QAKhJdpYiGW9RaxAFnnJV9I0Jpk=
Received: from BN9PR03CA0571.namprd03.prod.outlook.com (2603:10b6:408:10d::6)
 by DM4PR12MB7549.namprd12.prod.outlook.com (2603:10b6:8:10f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 08:38:49 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:10d:cafe::6b) by BN9PR03CA0571.outlook.office365.com
 (2603:10b6:408:10d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 08:38:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 08:38:48 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 03:38:48 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 03:38:48 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49
 via Frontend Transport; Thu, 17 Sep 2026 03:38:44 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <vkoul@kernel.org>
CC: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH V2 1/9] soundwire: amd: fix SDW command timeout return value
 handling
Date: Thu, 17 Sep 2026 14:04:12 +0530
Message-ID: <20260917083732.3803526-2-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260917083732.3803526-1-Vijendar.Mukunda@amd.com>
References: <20260917083732.3803526-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|DM4PR12MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 82f37166-8f17-4ebe-bddf-08df14971831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	fnE9N/eadQEIp4vAesfCeIAPIdJS/oMAyzeH6yqJ95T44TFMN3hU+6BWDKdys8YLeyWn7MI1VXafwxulkzz3/F4B/mEW1gSSKygdiutB4WrZyGUFCK07GexxE4eqRi4zHN/VEoTwM8y5euS3lH1hjZ3jQdAYLMBgJ0N5eNVyO0q+1LG7V+oWs0XLv0mJLBF+yCvFM87ktbb4tNlipRZcubNzZJv5FrEWz0CYhiURUc9gchuEzKn9iU1tMKE13yHz5McTSPai63+9fCIuoz1uQW/Am5RRLbDvRx8ip9midVDm/Ae4MaHwEcWhfpK5vakhi3u0/7AEL898TWRjnuyrSn7UCkoe+4lhjZ4zDc/MLl1JfBEDCoUh9UHMy4U+Eq4MXhKL0Lw8pdMYFVF6BVUmvW42TVbflGKQHiRA2vN6G5K/44rS6daERUPVXoKMLoDZDoWtdU4TdqW+zUkHlcRmDZQ0Vwb4dsDgsiwrKIkVNww8vtLPqB6UbjQGS4rQC1/KOkeEsAY3YnFwPdSiM9k4iSHcs67kwYQTSYLCpCAcAPi82OuBnjfhCp9U52pSUQ/UTwB4zdDlM9ac7xOVpm34bbm9q1MjItguGes/VhnSV9NT4rrmVwFl+Kutpuegrynl5vVckiUaFpqKGKp6OA++aE5/Qn0eKyxgcM2Yv0VznD98pw4n4uBwd+PpiltuBuxcm1EA0rAZmnHtGsExxZL/hg==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	8KiQC/tG8gLIgGFcabQbln77OoJOvOkNUpn9sTuHmDZpTV4y1i5sn1ZqpR0t7fldDQzYb/micZfCxqUSljnKQxuRum71r/xmMk2dTrccnVJ/LrW4mqnk8OgUJppgSe0IsgiFbQ1IsMsTpR3wnOePVqaDv4MXlOyLrZtG4i9yuNElj/4nLkUwD4dH/yFOVEqQm3zjKZbMV8+qSPM0XJxZn/oj8V1e3N6gNEBCL59sV8uKUNDY5fY2d4AAv8pNPhZzu4nT2NsY6wfvWJG7VjzPTLumdF3FGwoEPfM3lJCXU84S1YbaJ2nu+ji32rRh0Smv2QWwxD19CkIngaUN9clE3NOMCOJB2R59CkZbj9yZcjxEIo6bWqPiGwUfeWYMszdolxsYBN+vq767HfFUZ+oFSz12ktBOtaOwaSlyobWciPO7/eYgpDc9Vh9YvT3wHAki
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 08:38:48.8036
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 82f37166-8f17-4ebe-bddf-08df14971831
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7549
Message-ID-Hash: C2S6Q57UAOQSPU2WBD3SYMTWKR7FI3AI
X-Message-ID-Hash: C2S6Q57UAOQSPU2WBD3SYMTWKR7FI3AI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/C2S6Q57UAOQSPU2WBD3SYMTWKR7FI3AI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

amd_sdw_send_cmd_get_resp() returned u64 but was returning -ETIMEDOUT
(a negative int) on readl_poll_timeout() failures, which silently
widens to a large u64 value.

Change the return type to int and pass the raw u64 response through an
out-parameter. Timeout is detected directly from readl_poll_timeout()
return value.

Update all callers: amd_program_scp_addr(), _amd_sdw_xfer_msg(),
amd_sdw_read_and_process_ping_status(), and amd_sdw_read_ping_status()
to check the return value and handle timeout explicitly. In
amd_sdw_read_and_process_ping_status(), the mutex unlock is also moved
to after amd_sdw_process_ping_status() so the lock is held across the
full status processing step.

Fixes: d8f48fbdfd9a ("soundwire: amd: Add support for AMD Manager driver")
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/amd_manager.c | 56 +++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 23 deletions(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index a3316efdf8ac..fa3f4e797edd 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -250,10 +250,9 @@ static void amd_sdw_ctl_word_prep(u32 *lower_word, u32 *upper_word, struct sdw_m
 	*lower_word = lower_data;
 }
 
-static u64 amd_sdw_send_cmd_get_resp(struct amd_sdw_manager *amd_manager, u32 lower_data,
-				     u32 upper_data)
+static int amd_sdw_send_cmd_get_resp(struct amd_sdw_manager *amd_manager, u32 lower_data,
+				     u32 upper_data, u64 *response)
 {
-	u64 resp;
 	u32 lower_resp, upper_resp;
 	u32 sts;
 	int ret;
@@ -291,9 +290,8 @@ static u64 amd_sdw_send_cmd_get_resp(struct amd_sdw_manager *amd_manager, u32 lo
 			amd_manager->instance);
 		return ret;
 	}
-	resp = upper_resp;
-	resp = (resp << 32) | lower_resp;
-	return resp;
+	*response = ((u64)upper_resp << 32) | lower_resp;
+	return 0;
 }
 
 static enum sdw_command_response
@@ -309,19 +307,22 @@ amd_program_scp_addr(struct amd_sdw_manager *amd_manager, struct sdw_msg *msg)
 	scp_msg.buf = &msg->addr_page1;
 	scp_msg.flags = SDW_MSG_FLAG_WRITE;
 	amd_sdw_ctl_word_prep(&lower_data, &upper_data, &scp_msg, 0);
-	response_buf[0] = amd_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data);
+	if (amd_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data, &response_buf[0])) {
+		dev_err_ratelimited(amd_manager->dev,
+				    "SCP_addrpage command timeout for Slave %d\n", msg->dev_num);
+		return SDW_CMD_TIMEOUT;
+	}
 	scp_msg.addr = SDW_SCP_ADDRPAGE2;
 	scp_msg.buf = &msg->addr_page2;
 	amd_sdw_ctl_word_prep(&lower_data, &upper_data, &scp_msg, 0);
-	response_buf[1] = amd_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data);
+	if (amd_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data, &response_buf[1])) {
+		dev_err_ratelimited(amd_manager->dev,
+				    "SCP_addrpage command timeout for Slave %d\n", msg->dev_num);
+		return SDW_CMD_TIMEOUT;
+	}
 
 	for (index = 0; index < 2; index++) {
-		if (response_buf[index] == -ETIMEDOUT) {
-			dev_err_ratelimited(amd_manager->dev,
-					    "SCP_addrpage command timeout for Slave %d\n",
-					    msg->dev_num);
-			return SDW_CMD_TIMEOUT;
-		} else if (!(response_buf[index] & AMD_SDW_MCP_RESP_ACK)) {
+		if (!(response_buf[index] & AMD_SDW_MCP_RESP_ACK)) {
 			if (response_buf[index] & AMD_SDW_MCP_RESP_NACK) {
 				dev_err_ratelimited(amd_manager->dev,
 						    "SCP_addrpage NACKed for Slave %d\n",
@@ -366,11 +367,7 @@ static enum sdw_command_response amd_sdw_fill_msg_resp(struct amd_sdw_manager *a
 		if (msg->flags == SDW_MSG_FLAG_READ)
 			msg->buf[offset] = FIELD_GET(AMD_SDW_MCP_RESP_RDATA, response);
 	} else {
-		if (response == -ETIMEDOUT) {
-			dev_err_ratelimited(amd_manager->dev, "command timeout for Slave %d\n",
-					    msg->dev_num);
-			return SDW_CMD_TIMEOUT;
-		} else if (response & AMD_SDW_MCP_RESP_NACK) {
+		if (response & AMD_SDW_MCP_RESP_NACK) {
 			dev_err_ratelimited(amd_manager->dev,
 					    "command response NACK received for Slave %d\n",
 					    msg->dev_num);
@@ -390,7 +387,11 @@ static unsigned int _amd_sdw_xfer_msg(struct amd_sdw_manager *amd_manager, struc
 	u32 upper_data = 0, lower_data = 0;
 
 	amd_sdw_ctl_word_prep(&lower_data, &upper_data, msg, cmd_offset);
-	response = amd_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data);
+	if (amd_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data, &response)) {
+		dev_err_ratelimited(amd_manager->dev, "command timeout for Slave %d\n",
+				    msg->dev_num);
+		return SDW_CMD_TIMEOUT;
+	}
 	return amd_sdw_fill_msg_resp(amd_manager, msg, response, cmd_offset);
 }
 
@@ -446,9 +447,14 @@ static void amd_sdw_read_and_process_ping_status(struct amd_sdw_manager *amd_man
 	u64 response;
 
 	mutex_lock(&amd_manager->bus.msg_lock);
-	response = amd_sdw_send_cmd_get_resp(amd_manager, 0, 0);
-	mutex_unlock(&amd_manager->bus.msg_lock);
+	if (amd_sdw_send_cmd_get_resp(amd_manager, 0, 0, &response)) {
+		mutex_unlock(&amd_manager->bus.msg_lock);
+		dev_err_ratelimited(amd_manager->dev, "SDW%x ping status timeout\n",
+				    amd_manager->instance);
+		return;
+	}
 	amd_sdw_process_ping_status(response, amd_manager);
+	mutex_unlock(&amd_manager->bus.msg_lock);
 }
 
 static u32 amd_sdw_read_ping_status(struct sdw_bus *bus)
@@ -457,7 +463,11 @@ static u32 amd_sdw_read_ping_status(struct sdw_bus *bus)
 	u64 response;
 	u32 slave_stat;
 
-	response = amd_sdw_send_cmd_get_resp(amd_manager, 0, 0);
+	if (amd_sdw_send_cmd_get_resp(amd_manager, 0, 0, &response)) {
+		dev_err_ratelimited(amd_manager->dev, "SDW%x ping status timeout\n",
+				    amd_manager->instance);
+		return 0;
+	}
 	/* slave status from ping response */
 	slave_stat = FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_0_3, response);
 	slave_stat |= FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_4_11, response) << 8;
-- 
2.48.1

