Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42ED6CC6B03
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:53:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C12FF6020F;
	Tue, 13 Oct 2026 10:52:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C12FF6020F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791881587;
	bh=ZKuWWTIxu/Ud6TZmMc46vnK29MCBiWRu26Yx6p8ZfiU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=gATM5Xi4nqakjjCwtNx/VkGvPVqnDAVdgmG1Knsb0Af/cLvwc0MXalBxVI+3kaN7k
	 /YcDRpnfiMS/hsctY3YmQ2vLyxouZBfNRFfKKycg8X0/ziS+0G0Xzn5IaamyMLKZAE
	 SW1pEoml2ZbJt7qR+TuPBYVgDlhZMO0UJ13Yzje4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 83621F805FD; Tue, 13 Oct 2026 10:52:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8ECE8F805F8;
	Tue, 13 Oct 2026 10:52:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 53CAEF80495; Tue, 13 Oct 2026 10:52:26 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.1
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791881542;
	b=d3fq/8UoyYSWexqJKIlEXfjnYzP+Y8Alp50oS4epIdBwzdc3E6PqOxTKs3b9uKTWQIv7
	 Tv73ys0c8khCXU8BLVU9F6IS4Ekt+4eUDcGU2M3iL+OuqAhjd5dq+s+z4s0UdrcEHIIGa
	 WwdIUQlhF9t5CqGmL//6a3nCjFi8aaDtb0RQv7E+4bwpawGKqJb4nC4izEWZx7zg6+r5L
	 nPfCpoNld1DdMGqPkZjDVSW5/wtogje1C/8Fa1CrAG9LYssGMqgxFGFWmdSY3Uq80X2H9
	 nN0wym+9HOcFVRaXjIgCWzZTaXkfUfVPPC6UqqNsso5omC9Dr8k/XklFjlkIxHaxVrw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791881542;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ZKuWWTIxu/Ud6TZmMc46vnK29MCBiWRu26Yx6p8ZfiU=;
	b=NTU2/cyqQjlHBR/Cb/SqvHziy1d+OkVw0P22iqSDiMC1ETNKL2MEvrn6uROdgT4xOkXn
	 +sqVg8nMxmdQ9oGXcgZJW92Y7K4kM3edwsTxVc+uhx5nkB9YbLeFqrapoOQ5OFs7AMPTx
	 P2xoHOtPWR3jvNl35dvKX2cduAniPcmHfv/oCL9I68P0UxVJUHuG/QsvWvzSjN6n09rOt
	 NQltfadQUsa8Z3yoBXmsIP4Jr4hYG9th1a/oNaL/II72nIVdc5EjV2MH++k6jniraqO5T
	 85BY2Un1ScXdHX1vCFJQeLN9RGpY8HSFgslg4Z1KTspwcw2NIzuFOcPk5U9H1KKuPpw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=g01Z8R0Y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.1
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010001.outbound.protection.outlook.com [52.101.85.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B7932F800EE
	for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2026 10:52:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7932F800EE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=g01Z8R0Y
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MImzsrT7TtftM4GqW4cACxtT3SgJ5ckbqHDUHdTrw9VXRap++wzCQ6F9/D29rUFJQAbcKU9vxeiDMlgzqOQMgO+h9O+CErmMU5MAwD2kBwjTLvorN4zgvdtbNDzhmjpxMaPf+Tzr0zApK7fglnRf8A+S67RsTF4/x3QMgnHh01NecPoNHkH+BkKKlEg/wf82PkO3L8HHKAIOfCvg3rIL0I8EBorVZMv4Q07OLPP2k4ya1cOr8UZGlXmBwV31a+YNW2qgJrd2qI1zBAcOUA7qdcRB8MuxC0jracWnrWa/TCK7OWJV7/Qh7Vp33PrMxrcPhe3ldqS0eg7f7htYixpCPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuaCfIoV0IQbSRxWRy4R0KsnVQNCZn6kMmI6GBuuzfI=;
 b=D/jlz5OD3FMtRU65vhZNdQUnTjbhEKwmo1M3WqNw3OnyKJNmbkcmUkiMCWNyxfrQ6gGNgYyr3rsuk+iJ3b2C83Oy6DJEBu57eJJaZG7ogPfx/EIzh0CTG+ABtjmpRU/2/8y0DN0eN/JEE0Mcbx9AF6FCWMzM/tGXGMmbPmtwkhlKzdh7RxDScyxnJXZ0RFryXlAfp4ESyAKEJgQ8FAtVejEyNvsUaBc6sGrzL8Owj9h+KlH3tcfuHYPgWBplKCtK/Mkl/qMDwCvpzoT596bR6n1EmRFZdgzopDHi9RfOFVpf6LryxyAQHqVwL/yItVjib6tuAq9m3Hn1bUFaq+zxYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuaCfIoV0IQbSRxWRy4R0KsnVQNCZn6kMmI6GBuuzfI=;
 b=g01Z8R0YCJrW9HnKrnJZpGPP9NFMD7XFVLXuXvVZm9L9a75qpx7LEVOIgrFWTfgWXh4JJ9U06BlCsfliyQSwNtVKak6d+JsdPxy8zadTkauUMgLa9XOclqAqzIzHOlvzT0xnMLhULKbd6qQB6jcgqUmPOGsYwi8lMD1g7+DOBSo=
Received: from BN9PR03CA0573.namprd03.prod.outlook.com (2603:10b6:408:10d::8)
 by PH0PR12MB5648.namprd12.prod.outlook.com (2603:10b6:510:14b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 08:52:14 +0000
Received: from BN6PEPF00000074.namprd03.prod.outlook.com
 (2603:10b6:408:10d:cafe::66) by BN9PR03CA0573.outlook.office365.com
 (2603:10b6:408:10d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 08:52:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN6PEPF00000074.mail.protection.outlook.com (10.167.248.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 08:52:13 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 03:52:07 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Tue, 13 Oct 2026 03:52:04 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <vkoul@kernel.org>
CC: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH V3 01/10] soundwire: amd: fix SDW command timeout return value
 handling
Date: Tue, 13 Oct 2026 14:19:22 +0530
Message-ID: <20261013085111.2009061-2-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261013085111.2009061-1-Vijendar.Mukunda@amd.com>
References: <20261013085111.2009061-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF00000074:EE_|PH0PR12MB5648:EE_
X-MS-Office365-Filtering-Correlation-Id: 979fed69-bdb3-442a-0e62-08df290746d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|56012099006|11063799006|261009223027099003|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	DaVPNsb2tYOKB2N6TKxm+OT23WHLnN2YjajB6WHfgpvu6P7aLm3XMJ0zST8FDIEux/2MYclU6F3x3CPE+6FN7JN1//op4IBt9kEojbesCezeZnJ+3nzflRFSd3tB4Ya1+OMCM2g6jLVHysNFI4imnySSz1nIxxszydK5ZQ7qIROceEckJaTR1FTYQdTnVytZ+yH7PZzY/FluDz695vw1PN30+bxDFtgbi27FlLwbnwck2jtYnUZu6v2JzTV3NfHckahXvWVCGZxy/Th8ozK3cGzSP+3n8cJPpAWslAwj9KZx6+PW+2y12cN4BWONTOgMPcFZ5q6y2JDczqckC4YMt2TSF7W4bKJdTHZRPNr7JZJaSkrs/k940JwBqnO00Th/sw75+4jnqUo6pr/mTGQgcNYpRvFglf4z7RJLCLDM5E4Iy6D8V3Ljbdsysi5X4UUNnV2ztUDESs+6uSgh5s7KOov6RnT0sPwaxG7x/QyJKYv0vXqUhcm/EfRqfzQjvidn9YACMZb6AFPXShmeHz+E371+D+5hYS4kSUsZtifmE7pi8A0B7FyeWZc586q/Xw2ersYtP1ktRR4J3w5UybCpvPVbJvqUucpyV88PPohioLyhS2akmtOMYEMNbvDXCMhEKBoooF/fl3G4oLI4IO14DENfJH3v/wiVzJdtITuE4Fm/3NpRUEs1shxN9dTuODHGv9fQoMnIA1N7P90ID3OxSA==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	WWHniI9XKTwBeCZJk9SGQ26APyA6WR1ndkU7as97XQ5EZNXXjey9iTtfWJf0m3zN5OnpPGs3swMGgFd79G9qt/AGSwJoOlLwbptudnfdQCp4dqf+GdateUdp6zhdip8jKTCJwTAB7uW/Jks/Kur5R6rAn0l4NkXn226CpAZmUe+B3bn0EfboHRNOqY5ffl1mgitxdUJ0rH7e2DWwurkIs6ZsRNFjNKEgFgdzimVw0AQkNa7H1npw8lk1gFyFfxrUbQqL7Jo+GdSw/1JEBBpNvE2MDria2t5nYp08swWaRb+xjr/XwVQ8pQUEQeNFlwPMxpXbi7WOMC8ZJKkt+uhexxd5MiWQOmIl1WhtMrjYNVOU4DAsdsRtBYsRTjYh2Zz1dphH7aK5NYQz7aDQklCBmh209hNrIstAyUe++NijZrOkV7GjxMpjNYlb9wv7x5r6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 08:52:13.9007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 979fed69-bdb3-442a-0e62-08df290746d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN6PEPF00000074.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5648
Message-ID-Hash: PBWM4IRQRSL5AVKWNXHBPPS2HC25TDU6
X-Message-ID-Hash: PBWM4IRQRSL5AVKWNXHBPPS2HC25TDU6
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PBWM4IRQRSL5AVKWNXHBPPS2HC25TDU6/>
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

