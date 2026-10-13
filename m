Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B179CC6B08
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:07:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC1D160255;
	Tue, 13 Oct 2026 12:06:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC1D160255
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791886020;
	bh=EtOgveru09+KITIPtZK8c51Mi7slJYxrsxpTIUQG5sM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=l7JatOwG56s78q85+uhEMFFg//DI4xg3M07RM5T76VFnHBIHfPFZEXLn1MpNKHeVN
	 68zmQnQlq7zRzlVq4OjUOlTd7j+zd6dmLSXAPo2cgoQvP3v5ScNW73EjgQF1qjNuLL
	 17NYrv9lfuxiROtDZALFsxWlmDTR69et0XQ7CZnY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BA946F8061C; Tue, 13 Oct 2026 12:05:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 56B9EF80615;
	Tue, 13 Oct 2026 12:05:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F05C6F80615; Tue, 13 Oct 2026 12:05:11 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.35
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791885892;
	b=KpQqritmsXllTik5K20aDQ+/0Lyfgtq5a/ZHsFxnww+QR2HsEjF+tWEeDYsCK569dJyV
	 cMUihmGUMFngn1qxjmBjmPBNj3dQNjxNiixTkUSY3tEvrzFVjIoyynOMRLwRY/Vx5qC0p
	 jKf/gbZeMOI5fZOh6g1oMv4L6FGqFGZUSwp+CMFUAGen9dVWEqgHmfjvOJOjWyHR4s13T
	 +XC9ytBpHTtfsyvOmbn30F+JZh989v9364kGXwr5FXKeCRNebC88fYLnApjN8GqkYQpp2
	 0E++37ezy3LqGa0+r2iy4RBZJEO37n4KDVbbw4G6ot4KrVV5v8BnDA9JmFpO5c2fpaw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791885892;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=EtOgveru09+KITIPtZK8c51Mi7slJYxrsxpTIUQG5sM=;
	b=bJJDyjTsPcAHC+6PIMoKDnZU5CfcY4y2mAc8koCehse8v3JmVJ32NrHYp+aoTBdbw1ns
	 yFPOBDvMXEP4L4bsHWwi1SbRvYu8qELNPhHQa3IQR7ooaeuhlnKoJfVKyJbXjTw1GvLrz
	 cme+amiVo/atGE+204LuDltcCeEbr6fPoLhR9CcFDlU4tmmJUDvQLn0hUyXBthSMiIRdW
	 TddhEFrwmXLG3Y/hd6Cre8Fnj8+ZKQ55dirsJnDWgaVqUBPYOBY30ohM7hljOcFlr59dU
	 hhyynTVSLogJPfkauIMJEv6WlMNbjBXfIkaEqor7kQ7jUTU2X3QHyBmBoxVKFipE1yA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=lrRQ8y7Y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.35
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010035.outbound.protection.outlook.com [52.101.56.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A2CB7F80681
	for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2026 12:04:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A2CB7F80681
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=lrRQ8y7Y
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udO5hRITfKo0TW6K1ZpCEQZ3GScTBH/l03TQWBSd5D5EP7nEXhjMrFZPZ9IH2xoslQ2uH3e77BAYO2B7RJ8FDh4nDNtq34q8+8/Mqjwpahfx1rZhabFbJl//X49hmSjgDQFUbyTRPgnKEznAPNgxp0+0qSK3JamQKKGMPfc9wP7ms/+OCz76mV3clsqzfdMuxLfps/abBaVisiB64Sz15NF2bFKwAAqB3xXYd/ACmGduG9QtSCLfreeoANkPh805mRD52zT9luzzP0uAuyvI7X04tdn54R4zVkSvo3hZBmup/63EvZExu/kDX7aHu5ROJn6HI3JNyWzV7aHBaaswIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdmV8vmXC4Q3VRNmhGLnyL+xtiirpUE0lHkivsAEQeY=;
 b=ZcHw+HklYvtscaNHB5n9BtaPvYIMz6KGAlvjD/YoI2Tr5ZsiW6iGVbyFzI9paWMubT+UZNHQOar0DObH4F/0ppD4b2oUvkh/Q0t65Qhu2Gjv34ObZkVfKgvsnHkECyCR35ozv9nHQ2hIfB7SlBKbEAkuN4M1wwQhHlB5A7de2VH1/eE9yezzjqHXzc1YccVJhhlAqO4TUKJXBL4R34dVtDkYC6s1XK6IgmPUhCSiQ8aWE/iPjTd61F4g30cnxG1g/IFujkXX9SpJdSGm3F8kWPs7GNYa8Ktg8f1PnXub0NYnTX5mz8UrJIG1BTVCFDY1fKsWhxQ8h70G5MevRTe9vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdmV8vmXC4Q3VRNmhGLnyL+xtiirpUE0lHkivsAEQeY=;
 b=lrRQ8y7Y+ALkozCUuI60sgJcthkhvh5CnK5wrYfUJ/gU4eTMll/E9cLnEKbfH4+Y5Kt9lniagK1qAWAI1UCQMDuQCqO2NkOEY/RDG4xC17H1sLFcJa4GFG06akBGl/3Tk+K1nMKaE068bHxnQGY5hZotfbAqRteapYmijslTDlI=
Received: from SJ0PR03CA0104.namprd03.prod.outlook.com (2603:10b6:a03:333::19)
 by MW4PR12MB7032.namprd12.prod.outlook.com (2603:10b6:303:1e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 10:04:41 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::5d) by SJ0PR03CA0104.outlook.office365.com
 (2603:10b6:a03:333::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.15 via Frontend Transport; Tue,
 13 Oct 2026 10:04:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 10:04:40 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 05:04:30 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Tue, 13 Oct 2026 05:04:26 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <vkoul@kernel.org>
CC: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<Vijendar.Mukunda@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V2 8/9] soundwire: amd: populate hw_ops and wire all call
 sites through acp_*() helpers
Date: Tue, 13 Oct 2026 15:28:54 +0530
Message-ID: <20261013100306.2921771-9-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261013100306.2921771-1-Vijendar.Mukunda@amd.com>
References: <20261013100306.2921771-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|MW4PR12MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: ae85bcd3-05a2-4c8b-0203-08df291165e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|6133799003|10067099003|22082099003|18002099003|11063799006|261009223027099003|261009221727099003|261009220027099003|261009221227099003|261009223327099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	l7xk2aW3X11T/boT89Vu6i063KIaoUzn1MpBHl5CR+fAyjnSvM2rVIJgpQadQz2CcjvoTFGzSu0skfyz8sBNQhK3HBJBV5fTnwIeQYqgIVRhZHAjqJ2CndjFvIYp/arSQxNXJ8dgYJWhsBiMrV5mHr8STkuhUA20iD2SgfnxuVyIQpnU3UsdlN6qvmy7H/8rjer96y2MjiYqFITuFKo+skr+ePVgjUZ8X16UObq0InZ9YPwpxFvajMiKBjQM9h0S+YsYr1vYHGAwzmGIn5lLMoADwvGS1S6YG92VkguSjfZ1IV9NhlOyOyT9zj5wDqK27i5+IxRRb9X3pC4PTLHqHv4HhsDHI9wUc2CU73ivE7UQKUN6hRQP4EPwiNSMEzpjCNGsxHhPP0X6czOCRXgwo79CAaTCLnZbCB7IL4HGExrMX+5ZTekN83QlrXec9NFJX9RgVqd5pwLETRIRdWJYk60TorqMPkzzTlNZP43To0YyvKtw0jFdL6+vVXXKTRjpcdf3tT7yUsjvbmw5QMHiwgbJ/qvc+xntMHqEx01A3D1crOQyxJP1H3QViEdwneo0Y+wI7Ssjm3kkl05DLq8H7XSAHDmGsgi6xI9/eRiK5cGH1qU6/9m2HxLPPijJ559UkvqvQjZJ/XXOuycn95Va4zUCokd4VeA1W2d7Vbncai4ZqK8clNQRL7hT+JiN3eBTlOaYJRMFWipGs9i4gHYrhQ==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(6133799003)(10067099003)(22082099003)(18002099003)(11063799006)(261009223027099003)(261009221727099003)(261009220027099003)(261009221227099003)(261009223327099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	aYB4OwnktNW7f159XHG3249iL/99/tRiEXlgHvShnz3cv0hm1ztqZ/G2W/8+7GtvXbVQUwtPQZJ0qqY6HvApIWBTmXGsnC0bKo8FTjGyrPl9hIkr0uH5fppviBwThTzkkbqmDV7iEQtfLV6CYlE2UecFwmxFUkVafXNITNU6N35FUz3Yv+bLq7luIfIfF4BAbP5Uaw8gVe7T8gCogojucFqFYEh/3dFS5kYLPEKj0Y227hXKHetHuAy+BWAtOJul8Qv5t2mFLcwUTZNIbLS4y6kmt80JLOf98MxUMZs4r6ivjONjSOVjFgglCKdu7eTnmt+xwKvGSwnPnz1wnSkrKD4Z1UuEx7nphBrCjPfcYu1IjeUGFw6Y9W81f0pP9vCG+vPx1glwzr7yxW3nZ1oXo+UMbZw9d4YSapgw5VCoKMPGE+DSN3/R3TE7VcKaA978
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 10:04:40.9501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ae85bcd3-05a2-4c8b-0203-08df291165e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7032
Message-ID-Hash: PQEPGH37R6RB3BX5WJBEEJSE6UMLHHXC
X-Message-ID-Hash: PQEPGH37R6RB3BX5WJBEEJSE6UMLHHXC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PQEPGH37R6RB3BX5WJBEEJSE6UMLHHXC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Populate the amd_sdw_hw_ops dispatch table introduced in the previous
patch and convert every direct amd_acp63_*() call site in the driver to
use the corresponding acp_*() inline helper.

Introduce a static const struct amd_sdw_hw_ops amd_acp63_hw_ops table
that registers all amd_acp63_*() callbacks. Add amd_sdw_hw_init_ops()
which assigns the table pointer based on acp_rev, and call it from
amd_sdw_manager_probe() so hw_ops is set before any dispatch helper is
reached.

Extract the PM suspend/resume logic into amd_acp63_sdw_suspend(),
amd_acp63_sdw_suspend_runtime() and amd_acp63_sdw_resume_runtime()
hw_ops callbacks (taking struct amd_sdw_manager * instead of
struct device *). The existing amd_suspend(), amd_suspend_runtime() and
amd_resume_runtime() device-PM entry points become thin one-liners that
delegate to the corresponding acp_sdw_*() helpers.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/amd_manager.c | 360 ++++++++++++++++++--------------
 1 file changed, 206 insertions(+), 154 deletions(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 90bf5d4e5ba2..2e78d68cb37a 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -302,8 +302,7 @@ amd_program_scp_addr(struct amd_sdw_manager *amd_manager, struct sdw_msg *msg)
 	scp_msg.buf = &msg->addr_page1;
 	scp_msg.flags = SDW_MSG_FLAG_WRITE;
 	amd_sdw_ctl_word_prep(&lower_data, &upper_data, &scp_msg, 0);
-	if (amd_acp63_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data,
-					    &response_buf[0])) {
+	if (acp_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data, &response_buf[0])) {
 		dev_err_ratelimited(amd_manager->dev,
 				    "SCP_addrpage command timeout for Slave %d\n", msg->dev_num);
 		return SDW_CMD_TIMEOUT;
@@ -311,8 +310,7 @@ amd_program_scp_addr(struct amd_sdw_manager *amd_manager, struct sdw_msg *msg)
 	scp_msg.addr = SDW_SCP_ADDRPAGE2;
 	scp_msg.buf = &msg->addr_page2;
 	amd_sdw_ctl_word_prep(&lower_data, &upper_data, &scp_msg, 0);
-	if (amd_acp63_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data,
-					    &response_buf[1])) {
+	if (acp_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data, &response_buf[1])) {
 		dev_err_ratelimited(amd_manager->dev,
 				    "SCP_addrpage command timeout for Slave %d\n", msg->dev_num);
 		return SDW_CMD_TIMEOUT;
@@ -385,7 +383,7 @@ static unsigned int _amd_sdw_xfer_msg(struct amd_sdw_manager *amd_manager, struc
 	u32 upper_data = 0, lower_data = 0;
 
 	amd_sdw_ctl_word_prep(&lower_data, &upper_data, msg, cmd_offset);
-	if (amd_acp63_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data, &response)) {
+	if (acp_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data, &response)) {
 		dev_err_ratelimited(amd_manager->dev, "command timeout for Slave %d\n",
 				    msg->dev_num);
 		return SDW_CMD_TIMEOUT;
@@ -448,7 +446,7 @@ static void amd_acp63_sdw_read_and_process_ping_status(struct amd_sdw_manager *a
 	u64 response;
 
 	mutex_lock(&amd_manager->bus.msg_lock);
-	if (amd_acp63_sdw_send_cmd_get_resp(amd_manager, 0, 0, &response)) {
+	if (acp_sdw_send_cmd_get_resp(amd_manager, 0, 0, &response)) {
 		mutex_unlock(&amd_manager->bus.msg_lock);
 		dev_err_ratelimited(amd_manager->dev, "SDW%x ping status timeout\n",
 				    amd_manager->instance);
@@ -470,7 +468,7 @@ static u32 amd_acp63_sdw_read_ping_status(struct sdw_bus *bus)
 	/* Called by sdw_show_ping_status() which holds msg_lock. */
 	lockdep_assert_held(&bus->msg_lock);
 
-	if (amd_acp63_sdw_send_cmd_get_resp(amd_manager, 0, 0, &response)) {
+	if (acp_sdw_send_cmd_get_resp(amd_manager, 0, 0, &response)) {
 		dev_err_ratelimited(amd_manager->dev, "SDW%x ping status timeout\n",
 				    amd_manager->instance);
 		return amd_manager->ping_slave_stat == U32_MAX ? 0 : amd_manager->ping_slave_stat;
@@ -973,7 +971,7 @@ static void amd_acp63_sdw_update_slave_status_work(struct amd_sdw_manager *amd_m
 			       ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
 			writel(AMD_SDW_IRQ_MASK_8TO11, amd_manager->mmio +
 			       ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
-			amd_acp63_sdw_read_and_process_ping_status(amd_manager);
+			acp_sdw_read_and_process_ping_status(amd_manager);
 			goto update_status;
 		} else {
 			dev_err_ratelimited(amd_manager->dev,
@@ -1046,12 +1044,12 @@ static void amd_acp63_sdw_irq_thread(struct amd_sdw_manager *amd_manager)
 		amd_manager->instance, status_change_0to7, status_change_8to11);
 
 	if (status_change_8to11 & AMD_SDW_WAKE_STAT_MASK) {
-		amd_acp63_sdw_process_wake_event(amd_manager);
+		acp_sdw_process_wake_event(amd_manager);
 		status_change_8to11 &= ~AMD_SDW_WAKE_STAT_MASK;
 	}
 
 	if (status_change_8to11 & AMD_SDW_PREQ_INTR_STAT) {
-		amd_acp63_sdw_read_and_process_ping_status(amd_manager);
+		acp_sdw_read_and_process_ping_status(amd_manager);
 	} else {
 		/* Check for the updated status on peripheral device */
 		amd_sdw_update_slave_status(status_change_0to7, status_change_8to11, amd_manager);
@@ -1087,17 +1085,17 @@ int amd_sdw_manager_start(struct amd_sdw_manager *amd_manager)
 
 	prop = &amd_manager->bus.prop;
 	if (!prop->hw_disabled) {
-		ret = amd_acp63_sdw_clk_init_ctrl(amd_manager);
+		ret = acp_sdw_clk_init_ctrl(amd_manager);
 		if (ret)
 			return ret;
-		ret = amd_acp63_init_sdw_manager(amd_manager);
+		ret = acp_init_sdw_manager(amd_manager);
 		if (ret)
 			return ret;
-		amd_acp63_enable_sdw_interrupts(amd_manager);
-		ret = amd_acp63_enable_sdw_manager(amd_manager);
+		acp_enable_sdw_interrupts(amd_manager);
+		ret = acp_enable_sdw_manager(amd_manager);
 		if (ret)
 			return ret;
-		amd_acp63_sdw_set_frameshape(amd_manager);
+		acp_sdw_set_frameshape(amd_manager);
 	}
 	/* Enable runtime PM */
 	pm_runtime_set_autosuspend_delay(amd_manager->dev, AMD_SDW_MASTER_SUSPEND_DELAY_MS);
@@ -1108,117 +1106,6 @@ int amd_sdw_manager_start(struct amd_sdw_manager *amd_manager)
 	return 0;
 }
 
-static int amd_sdw_manager_probe(struct platform_device *pdev)
-{
-	const struct acp_sdw_pdata *pdata = pdev->dev.platform_data;
-	struct resource *res;
-	struct device *dev = &pdev->dev;
-	struct sdw_master_prop *prop;
-	struct amd_sdw_manager *amd_manager;
-	int ret;
-
-	amd_manager = devm_kzalloc(dev, sizeof(struct amd_sdw_manager), GFP_KERNEL);
-	if (!amd_manager)
-		return -ENOMEM;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENOMEM;
-
-	amd_manager->acp_mmio = devm_ioremap(dev, res->start, resource_size(res));
-	if (!amd_manager->acp_mmio) {
-		dev_err(dev, "mmio not found\n");
-		return -ENOMEM;
-	}
-	amd_manager->ping_slave_stat = U32_MAX;
-	amd_manager->instance = pdata->instance;
-	amd_manager->mmio = amd_manager->acp_mmio +
-			    (amd_manager->instance * ACP63_SDW_MANAGER_REG_OFFSET);
-	amd_manager->acp_sdw_lock = pdata->acp_sdw_lock;
-	amd_manager->acp_rev = pdata->acp_rev;
-	amd_manager->cols_index = sdw_find_col_index(AMD_SDW_DEFAULT_COLUMNS);
-	amd_manager->rows_index = sdw_find_row_index(AMD_SDW_DEFAULT_ROWS);
-	amd_manager->dev = dev;
-	amd_manager->bus.ops = &amd_acp63_sdw_ops;
-	amd_manager->bus.port_ops = &amd_acp63_sdw_port_ops;
-	amd_manager->bus.compute_params = &amd_acp63_sdw_compute_params;
-	amd_manager->bus.clk_stop_timeout = 200;
-	amd_manager->bus.link_id = amd_manager->instance;
-
-	/*
-	 * Due to BIOS compatibility, the two links are exposed within
-	 * the scope of a single controller. If this changes, the
-	 * controller_id will have to be updated with drv_data
-	 * information.
-	 */
-	amd_manager->bus.controller_id = 0;
-	dev_dbg(dev, "acp_rev:0x%x\n", amd_manager->acp_rev);
-	switch (amd_manager->acp_rev) {
-	case ACP63_PCI_REV_ID:
-		switch (amd_manager->instance) {
-		case ACP_SDW0:
-			amd_manager->num_dout_ports = AMD_ACP63_SDW0_MAX_TX_PORTS;
-			amd_manager->num_din_ports = AMD_ACP63_SDW0_MAX_RX_PORTS;
-			break;
-		case ACP_SDW1:
-			amd_manager->num_dout_ports = AMD_ACP63_SDW1_MAX_TX_PORTS;
-			amd_manager->num_din_ports = AMD_ACP63_SDW1_MAX_RX_PORTS;
-			break;
-		default:
-			return -EINVAL;
-		}
-		break;
-	case ACP70_PCI_REV_ID:
-	case ACP71_PCI_REV_ID:
-	case ACP72_PCI_REV_ID:
-		amd_manager->num_dout_ports = AMD_ACP70_SDW_MAX_TX_PORTS;
-		amd_manager->num_din_ports = AMD_ACP70_SDW_MAX_RX_PORTS;
-		break;
-	default:
-		return -EINVAL;
-	}
-	amd_manager->max_ports = amd_manager->num_dout_ports + amd_manager->num_din_ports;
-	amd_manager->port_offset_map = devm_kcalloc(dev, amd_manager->max_ports,
-						    sizeof(int), GFP_KERNEL);
-	if (!amd_manager->port_offset_map)
-		return -ENOMEM;
-
-	prop = &amd_manager->bus.prop;
-	prop->mclk_freq = AMD_SDW_BUS_BASE_FREQ;
-
-	ret = sdw_bus_master_add(&amd_manager->bus, dev, dev->fwnode);
-	if (ret) {
-		dev_err(dev, "Failed to register SoundWire manager(%d)\n", ret);
-		return ret;
-	}
-	ret = amd_sdw_register_dais(amd_manager);
-	if (ret) {
-		dev_err(dev, "CPU DAI registration failed\n");
-		sdw_bus_master_delete(&amd_manager->bus);
-		return ret;
-	}
-	dev_set_drvdata(dev, amd_manager);
-	INIT_WORK(&amd_manager->amd_sdw_irq_thread, amd_sdw_irq_thread);
-	INIT_WORK(&amd_manager->amd_sdw_work, amd_sdw_update_slave_status_work);
-	return 0;
-}
-
-static void amd_sdw_manager_remove(struct platform_device *pdev)
-{
-	struct amd_sdw_manager *amd_manager = dev_get_drvdata(&pdev->dev);
-	int ret;
-
-	if (pm_runtime_enabled(&pdev->dev))
-		pm_runtime_disable(&pdev->dev);
-	amd_acp63_disable_sdw_interrupts(amd_manager);
-	cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
-	cancel_work_sync(&amd_manager->amd_sdw_work);
-	sdw_bus_master_delete(&amd_manager->bus);
-	ret = amd_acp63_disable_sdw_manager(amd_manager);
-	if (ret)
-		dev_err(&pdev->dev, "Failed to disable device (%pe)\n", ERR_PTR(ret));
-}
-
 /*
  * AMD SoundWire clock-stop sequence shared across all ACP revisions.
  * Differences between revisions in this path are minimal; a switch/case
@@ -1348,7 +1235,7 @@ static int amd_sdw_host_wake_enable_by_rev(struct amd_sdw_manager *amd_manager,
 	case ACP70_PCI_REV_ID:
 	case ACP71_PCI_REV_ID:
 	case ACP72_PCI_REV_ID:
-		return amd_acp63_sdw_host_wake_enable(amd_manager, enable);
+		return acp_sdw_host_wake_enable(amd_manager, enable);
 	default:
 		dev_err(amd_manager->dev, "unexpected acp_rev 0x%x\n", amd_manager->acp_rev);
 		return -EINVAL;
@@ -1356,9 +1243,8 @@ static int amd_sdw_host_wake_enable_by_rev(struct amd_sdw_manager *amd_manager,
 	return 0;
 }
 
-static int __maybe_unused amd_suspend(struct device *dev)
+static int amd_acp63_sdw_suspend(struct amd_sdw_manager *amd_manager)
 {
-	struct amd_sdw_manager *amd_manager = dev_get_drvdata(dev);
 	struct sdw_bus *bus = &amd_manager->bus;
 	int ret;
 
@@ -1369,22 +1255,22 @@ static int __maybe_unused amd_suspend(struct device *dev)
 	}
 
 	if (amd_manager->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
-		amd_acp63_disable_sdw_interrupts(amd_manager);
+		acp_disable_sdw_interrupts(amd_manager);
 		cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
 		cancel_work_sync(&amd_manager->amd_sdw_work);
-		amd_acp63_sdw_wake_enable(amd_manager, false);
+		acp_sdw_wake_enable(amd_manager, false);
 		ret = amd_sdw_host_wake_enable_by_rev(amd_manager, false);
 		if (ret)
 			return ret;
 		ret = amd_sdw_clock_stop(amd_manager);
 		if (ret)
 			return ret;
-		amd_acp63_enable_sdw_interrupts(amd_manager);
+		acp_enable_sdw_interrupts(amd_manager);
 	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
-		amd_acp63_disable_sdw_interrupts(amd_manager);
+		acp_disable_sdw_interrupts(amd_manager);
 		cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
 		cancel_work_sync(&amd_manager->amd_sdw_work);
-		amd_acp63_sdw_wake_enable(amd_manager, false);
+		acp_sdw_wake_enable(amd_manager, false);
 		ret = amd_sdw_host_wake_enable_by_rev(amd_manager, false);
 		if (ret)
 			return ret;
@@ -1395,7 +1281,7 @@ static int __maybe_unused amd_suspend(struct device *dev)
 		ret = amd_sdw_clock_stop(amd_manager);
 		if (ret)
 			return ret;
-		ret = amd_acp63_disable_sdw_manager(amd_manager);
+		ret = acp_disable_sdw_manager(amd_manager);
 		if (ret)
 			return ret;
 	}
@@ -1405,7 +1291,7 @@ static int __maybe_unused amd_suspend(struct device *dev)
 	case ACP70_PCI_REV_ID:
 	case ACP71_PCI_REV_ID:
 	case ACP72_PCI_REV_ID:
-		ret = amd_acp63_sdw_set_device_state(amd_manager, AMD_SDW_DEVICE_STATE_D3);
+		ret = acp_sdw_set_device_state(amd_manager, AMD_SDW_DEVICE_STATE_D3);
 		if (ret)
 			return ret;
 		break;
@@ -1416,9 +1302,8 @@ static int __maybe_unused amd_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused amd_suspend_runtime(struct device *dev)
+static int amd_acp63_sdw_suspend_runtime(struct amd_sdw_manager *amd_manager)
 {
-	struct amd_sdw_manager *amd_manager = dev_get_drvdata(dev);
 	struct sdw_bus *bus = &amd_manager->bus;
 	int ret;
 	u32 val;
@@ -1429,29 +1314,29 @@ static int __maybe_unused amd_suspend_runtime(struct device *dev)
 		return 0;
 	}
 	if (amd_manager->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
-		amd_acp63_disable_sdw_interrupts(amd_manager);
+		acp_disable_sdw_interrupts(amd_manager);
 		cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
 		cancel_work_sync(&amd_manager->amd_sdw_work);
-		amd_acp63_sdw_wake_enable(amd_manager, true);
+		acp_sdw_wake_enable(amd_manager, true);
 		ret = amd_sdw_host_wake_enable_by_rev(amd_manager, true);
 		if (ret)
 			return ret;
 		ret = amd_sdw_clock_stop(amd_manager);
 		if (ret)
 			return ret;
-		amd_acp63_enable_sdw_interrupts(amd_manager);
+		acp_enable_sdw_interrupts(amd_manager);
 	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
-		amd_acp63_disable_sdw_interrupts(amd_manager);
+		acp_disable_sdw_interrupts(amd_manager);
 		cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
 		cancel_work_sync(&amd_manager->amd_sdw_work);
-		amd_acp63_sdw_wake_enable(amd_manager, true);
+		acp_sdw_wake_enable(amd_manager, true);
 		ret = amd_sdw_host_wake_enable_by_rev(amd_manager, true);
 		if (ret)
 			return ret;
 		ret = amd_sdw_clock_stop(amd_manager);
 		if (ret)
 			return ret;
-		ret = amd_acp63_disable_sdw_manager(amd_manager);
+		ret = acp_disable_sdw_manager(amd_manager);
 		if (ret)
 			return ret;
 	}
@@ -1461,7 +1346,7 @@ static int __maybe_unused amd_suspend_runtime(struct device *dev)
 	case ACP70_PCI_REV_ID:
 	case ACP71_PCI_REV_ID:
 	case ACP72_PCI_REV_ID:
-		ret = amd_acp63_sdw_set_device_state(amd_manager, AMD_SDW_DEVICE_STATE_D3);
+		ret = acp_sdw_set_device_state(amd_manager, AMD_SDW_DEVICE_STATE_D3);
 		if (ret)
 			return ret;
 		if (amd_manager->wake_en_mask) {
@@ -1480,9 +1365,8 @@ static int __maybe_unused amd_suspend_runtime(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused amd_resume_runtime(struct device *dev)
+static int amd_acp63_sdw_resume_runtime(struct amd_sdw_manager *amd_manager)
 {
-	struct amd_sdw_manager *amd_manager = dev_get_drvdata(dev);
 	struct sdw_bus *bus = &amd_manager->bus;
 	int ret;
 	u32 val;
@@ -1494,7 +1378,7 @@ static int __maybe_unused amd_resume_runtime(struct device *dev)
 	}
 
 	if (amd_manager->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
-		ret = amd_acp63_sdw_clock_stop_exit(amd_manager);
+		ret = acp_sdw_clock_stop_exit(amd_manager);
 		if (ret)
 			return ret;
 		ret = amd_sdw_host_wake_enable_by_rev(amd_manager, false);
@@ -1529,17 +1413,17 @@ static int __maybe_unused amd_resume_runtime(struct device *dev)
 			}
 		}
 		sdw_clear_slave_status(bus, SDW_UNATTACH_REQUEST_MASTER_RESET);
-		ret = amd_acp63_sdw_clk_init_ctrl(amd_manager);
+		ret = acp_sdw_clk_init_ctrl(amd_manager);
 		if (ret)
 			return ret;
-		ret = amd_acp63_init_sdw_manager(amd_manager);
+		ret = acp_init_sdw_manager(amd_manager);
 		if (ret)
 			return ret;
-		amd_acp63_enable_sdw_interrupts(amd_manager);
-		ret = amd_acp63_enable_sdw_manager(amd_manager);
+		acp_enable_sdw_interrupts(amd_manager);
+		ret = acp_enable_sdw_manager(amd_manager);
 		if (ret)
 			return ret;
-		amd_acp63_sdw_set_frameshape(amd_manager);
+		acp_sdw_set_frameshape(amd_manager);
 	}
 	switch (amd_manager->acp_rev) {
 	case ACP63_PCI_REV_ID:
@@ -1547,7 +1431,7 @@ static int __maybe_unused amd_resume_runtime(struct device *dev)
 	case ACP70_PCI_REV_ID:
 	case ACP71_PCI_REV_ID:
 	case ACP72_PCI_REV_ID:
-		ret = amd_acp63_sdw_set_device_state(amd_manager, AMD_SDW_DEVICE_STATE_D0);
+		ret = acp_sdw_set_device_state(amd_manager, AMD_SDW_DEVICE_STATE_D0);
 		if (ret)
 			return ret;
 		break;
@@ -1558,6 +1442,174 @@ static int __maybe_unused amd_resume_runtime(struct device *dev)
 	return 0;
 }
 
+static int __maybe_unused amd_suspend(struct device *dev)
+{
+	return acp_sdw_suspend(dev);
+}
+
+static int __maybe_unused amd_suspend_runtime(struct device *dev)
+{
+	return acp_sdw_suspend_runtime(dev);
+}
+
+static int __maybe_unused amd_resume_runtime(struct device *dev)
+{
+	return acp_sdw_resume_runtime(dev);
+}
+
+static int amd_sdw_hw_init_ops(struct amd_sdw_manager *amd_manager);
+
+static int amd_sdw_manager_probe(struct platform_device *pdev)
+{
+	const struct acp_sdw_pdata *pdata = pdev->dev.platform_data;
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+	struct sdw_master_prop *prop;
+	struct amd_sdw_manager *amd_manager;
+	int ret;
+
+	amd_manager = devm_kzalloc(dev, sizeof(struct amd_sdw_manager), GFP_KERNEL);
+	if (!amd_manager)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENOMEM;
+
+	amd_manager->acp_mmio = devm_ioremap(dev, res->start, resource_size(res));
+	if (!amd_manager->acp_mmio) {
+		dev_err(dev, "mmio not found\n");
+		return -ENOMEM;
+	}
+	amd_manager->ping_slave_stat = U32_MAX;
+	amd_manager->instance = pdata->instance;
+	amd_manager->mmio = amd_manager->acp_mmio +
+			    (amd_manager->instance * ACP63_SDW_MANAGER_REG_OFFSET);
+	amd_manager->acp_sdw_lock = pdata->acp_sdw_lock;
+	amd_manager->acp_rev = pdata->acp_rev;
+	amd_manager->cols_index = sdw_find_col_index(AMD_SDW_DEFAULT_COLUMNS);
+	amd_manager->rows_index = sdw_find_row_index(AMD_SDW_DEFAULT_ROWS);
+	amd_manager->dev = dev;
+	amd_manager->bus.ops = &amd_acp63_sdw_ops;
+	amd_manager->bus.port_ops = &amd_acp63_sdw_port_ops;
+	amd_manager->bus.compute_params = &amd_acp63_sdw_compute_params;
+	amd_manager->bus.clk_stop_timeout = 200;
+	amd_manager->bus.link_id = amd_manager->instance;
+	ret = amd_sdw_hw_init_ops(amd_manager);
+	if (ret) {
+		dev_err(dev, "Failed to initialize hw ops (%d)\n", ret);
+		return ret;
+	}
+
+	/*
+	 * Due to BIOS compatibility, the two links are exposed within
+	 * the scope of a single controller. If this changes, the
+	 * controller_id will have to be updated with drv_data
+	 * information.
+	 */
+	amd_manager->bus.controller_id = 0;
+	dev_dbg(dev, "acp_rev:0x%x\n", amd_manager->acp_rev);
+	switch (amd_manager->acp_rev) {
+	case ACP63_PCI_REV_ID:
+		switch (amd_manager->instance) {
+		case ACP_SDW0:
+			amd_manager->num_dout_ports = AMD_ACP63_SDW0_MAX_TX_PORTS;
+			amd_manager->num_din_ports = AMD_ACP63_SDW0_MAX_RX_PORTS;
+			break;
+		case ACP_SDW1:
+			amd_manager->num_dout_ports = AMD_ACP63_SDW1_MAX_TX_PORTS;
+			amd_manager->num_din_ports = AMD_ACP63_SDW1_MAX_RX_PORTS;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case ACP70_PCI_REV_ID:
+	case ACP71_PCI_REV_ID:
+	case ACP72_PCI_REV_ID:
+		amd_manager->num_dout_ports = AMD_ACP70_SDW_MAX_TX_PORTS;
+		amd_manager->num_din_ports = AMD_ACP70_SDW_MAX_RX_PORTS;
+		break;
+	default:
+		return -EINVAL;
+	}
+	amd_manager->max_ports = amd_manager->num_dout_ports + amd_manager->num_din_ports;
+	amd_manager->port_offset_map = devm_kcalloc(dev, amd_manager->max_ports,
+						    sizeof(int), GFP_KERNEL);
+	if (!amd_manager->port_offset_map)
+		return -ENOMEM;
+
+	prop = &amd_manager->bus.prop;
+	prop->mclk_freq = AMD_SDW_BUS_BASE_FREQ;
+
+	ret = sdw_bus_master_add(&amd_manager->bus, dev, dev->fwnode);
+	if (ret) {
+		dev_err(dev, "Failed to register SoundWire manager(%d)\n", ret);
+		return ret;
+	}
+	ret = amd_sdw_register_dais(amd_manager);
+	if (ret) {
+		dev_err(dev, "CPU DAI registration failed\n");
+		sdw_bus_master_delete(&amd_manager->bus);
+		return ret;
+	}
+	dev_set_drvdata(dev, amd_manager);
+	INIT_WORK(&amd_manager->amd_sdw_irq_thread, amd_sdw_irq_thread);
+	INIT_WORK(&amd_manager->amd_sdw_work, amd_sdw_update_slave_status_work);
+	return 0;
+}
+
+static void amd_sdw_manager_remove(struct platform_device *pdev)
+{
+	struct amd_sdw_manager *amd_manager = dev_get_drvdata(&pdev->dev);
+	int ret;
+
+	if (pm_runtime_enabled(&pdev->dev))
+		pm_runtime_disable(&pdev->dev);
+	acp_disable_sdw_interrupts(amd_manager);
+	cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
+	cancel_work_sync(&amd_manager->amd_sdw_work);
+	sdw_bus_master_delete(&amd_manager->bus);
+	ret = acp_disable_sdw_manager(amd_manager);
+	if (ret)
+		dev_err(&pdev->dev, "Failed to disable device (%pe)\n", ERR_PTR(ret));
+}
+
+static const struct amd_sdw_hw_ops amd_acp63_hw_ops = {
+	.init_sdw_manager		= amd_acp63_init_sdw_manager,
+	.enable_sdw_manager		= amd_acp63_enable_sdw_manager,
+	.disable_sdw_manager		= amd_acp63_disable_sdw_manager,
+	.enable_sdw_interrupts		= amd_acp63_enable_sdw_interrupts,
+	.disable_sdw_interrupts		= amd_acp63_disable_sdw_interrupts,
+	.set_frameshape			= amd_acp63_sdw_set_frameshape,
+	.send_cmd_get_resp		= amd_acp63_sdw_send_cmd_get_resp,
+	.wake_enable			= amd_acp63_sdw_wake_enable,
+	.host_wake_enable		= amd_acp63_sdw_host_wake_enable,
+	.set_device_state		= amd_acp63_sdw_set_device_state,
+	.read_and_process_ping_status	= amd_acp63_sdw_read_and_process_ping_status,
+	.process_wake_event		= amd_acp63_sdw_process_wake_event,
+	.clk_init_ctrl			= amd_acp63_sdw_clk_init_ctrl,
+	.clock_stop_exit		= amd_acp63_sdw_clock_stop_exit,
+	.suspend			= amd_acp63_sdw_suspend,
+	.suspend_runtime		= amd_acp63_sdw_suspend_runtime,
+	.resume_runtime			= amd_acp63_sdw_resume_runtime,
+};
+
+static int amd_sdw_hw_init_ops(struct amd_sdw_manager *amd_manager)
+{
+	switch (amd_manager->acp_rev) {
+	case ACP63_PCI_REV_ID:
+	case ACP70_PCI_REV_ID:
+	case ACP71_PCI_REV_ID:
+	case ACP72_PCI_REV_ID:
+		amd_manager->hw_ops = &amd_acp63_hw_ops;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static const struct dev_pm_ops amd_pm = {
 	.prepare = amd_pm_prepare,
 	SET_SYSTEM_SLEEP_PM_OPS(amd_suspend, amd_resume_runtime)
-- 
2.48.1

