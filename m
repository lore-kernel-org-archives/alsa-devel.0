Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882CBCC6B03
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:53:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B9490601FF;
	Tue, 13 Oct 2026 10:53:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B9490601FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791881607;
	bh=Vc7AC3/pKTeErOhnmNkmmWCswzDSFbLaoB0HQjACKVQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Fa81ZU8NLsbFXlMhRehLEI0P4hZMrF37XKBcjZZomG5SvFZBNIeDl7NkkzvcORMFn
	 jkjXZJp+cZ+7EXpZjRHfDYLiJyruZBpnk5gENoQPSyL/nmksoJXh2oaHL0IGc7DgZE
	 6zF4hjKISkUVW5WoJ7sr6a52uRsOkQccMxAY2efY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EF8C2F8061D; Tue, 13 Oct 2026 10:52:39 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1F682F80618;
	Tue, 13 Oct 2026 10:52:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A40E5F80495; Tue, 13 Oct 2026 10:52:29 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.71
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791881547;
	b=T/++2iAQvBZFfHltR0AJ98qFb73GFypyMWu/nTM8n6T27QwULyE3L+EGiUbaU4XFJsBy
	 t+6KWZA0YiPRpHV0qxJRfVmLLS0Kjm0VWDs0ICiEqCXNH0YGjZ1AoThFCyLEZ34NSLLdw
	 TLf2j3bgg2SnEx+5X+HGU0vBT9YLmY4j+46vsIayX1ucMN6pBhHXgPGiLb2LvH6M77kia
	 Qsp40vWoSidcr0uGZkW6oFJ9zRfq51HDeASIik+rHQmJ8AL0yGuwn3joY4N3T5LqaG2SP
	 zWupLesjrANd5FvLecxUvfBuaKO3osEVy2WdjyyE4yinn8qNrwBwgq63ly6NquIquGw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791881547;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Vc7AC3/pKTeErOhnmNkmmWCswzDSFbLaoB0HQjACKVQ=;
	b=rSqXFmg0S2BzmAd2L8iCkqgXbG1TNJ3w/BA0IwltPV5XG4Jeci5ku2Dvu2GewIx38ljm
	 /+Ql5poUlj1qSI0AGit+WtTo/VrI1Z8hwnaFt7DoofEvY5T1XsY/C3qYIgj59BcEhg7wS
	 WxxecU36VmqTOWPdEWPKBy5GyrLqRPWy1QgEWUvx8cHMBZUGRptQPUUgosDooYnx7TRcY
	 llN55etkd3GXpDI50fnAuJY4zgEY9t6p93Z9tM1rtXvFe7l4DSNj3cy7MtSAWs0gDdjur
	 rDRjlCSRk3G4fTTR35t0pVDRMYOq6plQzsLPbqBJ4Y+ByUt8hhBp2y65j/FJh8CPjeQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=CU65nH3T;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.71
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011071.outbound.protection.outlook.com [52.101.57.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5FE47F800B0
	for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2026 10:52:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5FE47F800B0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=CU65nH3T
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IyBzH8uoWEjd89A7a1t/cLPRJ+/urpU4/lVCR4/A750/g9XhyA3KFeTvh+htDBX5Pp5qSWoapj68fanHUc6cAoRBgFDTiTkrU7dTGXSHouOkRousS7yetut9sgu13Nb8AkDYQb1R+rwEuM81EBFPHzXYo/g8RuPB54Y/rOloCOZeDs7XtPu1XNhtgDX2c5JLPWJPRZcDCBf8M4H4KN6VgAUidLS+Ni149uslyquiTjUR9tD7j9nRoCvfzBOnYA4WXOeAitRK8R1IruzYfLdXaje6HiCtX+wKSdcLinOXmQAxttIS/mJYXRR30Xl//IfSNfsCOnx3uvbWrLNePCWAlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lZoLuzAa2+32cj+bNSjogB9DmBnhywviMNGKwNQyiQ=;
 b=Lj5dVS8B2NWqrVnPZGfeTvQHky6lY8w+GKz8HDW4BwwaG5bI2UJI5p4ZSZZMajkAqXhyy47j6hYcZ1ECK0Q+yVYUTPYlra8ZIeCH5oGnUrqw0+ZE05nk29kXbcBnnNUQK24OZX9u+997SDMVZo9obNDWxNyGJBq2/0bngH7ORUfGBhCm4Dwd0eheJsBFks+J96rpsHTpdoZibDVqHIJrBxYPrMUGxXj9jvAAQUIdpX3OzV3MDgsSnJoxr4PkYJx1XuXBAPA9+IX3AHMsjZOyiP8UPfz3XMdQpUoZBL3ZGbsJ6uYwQYTejMfo2wnmB8xdVOQttkrPe20FyI8GN5Ta2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lZoLuzAa2+32cj+bNSjogB9DmBnhywviMNGKwNQyiQ=;
 b=CU65nH3TdESYB9kcd9rwOkTQfAiFQa1QFG1dIKdxdhjMKI5XnBUj6KALsqjWZAYVb59S9aYCvBxC6W6rv/iqiBCkmD4dTP5x9/K7U2Fehzx+ZQUW6xlDgy5Zcm59AUOwhGeqEGbBD4cNNedRLmaNqHHQWhiDtW2LyeiWwM+tw+U=
Received: from BN9PR03CA0613.namprd03.prod.outlook.com (2603:10b6:408:106::18)
 by CYYPR12MB9013.namprd12.prod.outlook.com (2603:10b6:930:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 13 Oct
 2026 08:52:19 +0000
Received: from BN6PEPF00000072.namprd03.prod.outlook.com
 (2603:10b6:408:106:cafe::3f) by BN9PR03CA0613.outlook.office365.com
 (2603:10b6:408:106::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 08:52:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN6PEPF00000072.mail.protection.outlook.com (10.167.248.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 08:52:19 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 03:52:11 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Tue, 13 Oct 2026 03:52:08 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <vkoul@kernel.org>
CC: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH V3 02/10] soundwire: amd: cache ping slave status to avoid
 spurious disconnect on timeout
Date: Tue, 13 Oct 2026 14:19:23 +0530
Message-ID: <20261013085111.2009061-3-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261013085111.2009061-1-Vijendar.Mukunda@amd.com>
References: <20261013085111.2009061-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF00000072:EE_|CYYPR12MB9013:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c1c1368-911c-4947-eaae-08df290749fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|56012099006|10067099003|11063799006|18002099003|22082099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 
	bI29q8ByR3wqx3NzY3ChGzU8aZjbU5dQCrBjyWeoWifh7BABpq0F6dTq62oqq6zuhmKdvC5FWZgYvd38zlcwhJvjwH8Ac8Bv6lvyDL+8P8d25tbBDmlQUKpgFUuQOm8zt5/aypDeNu+oy7R3x2nP+h5r4SCNy1BZJj2/ZrEzktkUFbnw7uqzWnrH384+0cA0s2N08mmBsm+F9nqrQhj8aRydMRc6Ts/JIs3NVu+Rx3dlLBTHpvhNHv4GipUlE78TfcZexJuPAw4lWM2cmX6XfD5I02eLgFYUOiX3g1GChYTF3rj7o8a3bY0ZrS8ZJRamOVCOdy+TUSGl5jxAzXLuBHpNnfUT1o3Uji4UatsEXRFuFasJvS43OIKOCoLhAviVPepKnCUjWCxs9PvlpCrcCvA+DqgzbqMbc+rL4f9b6x2A4xaY0D7G+4yvwuZVzxOWxrAC20MmtkCWVp8BHYb9YdFH1D2cgpQ514LRBTgEHYb7EUr06BqkW4bc0S9MfWl6cVz9xVEwlX1RhmLoQf7JOVKXXH6LIFUszOCQ9BcStv0OcOLGCF8bCRTgwv2tbkH1cAzNxOKXyVsbYTd47F3Eq8ZV0Hf2Sd/UEISjpQolVqZ5ri5DpzoX38uN4uaGJsHa+Ncz9DrphHJav1BWC2aGJxPGgexneCbV/U6E/Kfv+sRLZBQS5C7K/6oPUOc+YZHICwZjkTGsef+1quKHwt1MEg==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	xRV9BGE/QEkakNoJKAB2vmhd7Ezf5ZE/PUE2q4/rOvK2HuJ3m22hDiqMx7tKN9726Jf+k+G0DRF0HtHjtrF+RKJyLUnNLZinuMWHgdt9hdXD7K4Vh6To8+4Ae9vreA9f6yCZwXMX1u1jw8IdBI27CshzNm99BaANkpkTdSk8D1z2YCPs90U2ITc6M7NDMrv0S32BYAAW3fmc4fXqpawdC21OB7vH2UE8HQXaJVVfwLccS4bcVQBglitLlmqjqnk+UtmdiAH/q4H0CE77Y7vFzxv+EJNOJBWgbTnqO8hztn9bg9/mTIl85uN2+f23QoAiblYl+VfZT0+al8bFU0Z5jwt5kKoGnNzU5T7V78MRFbG2vzyQ85oAc3kPK5AbxwwbGnqeTMGz8xOGYL1RLJ6oQ0A7r/werhKQT/88MyJWhSGetFyQQPHSd64W4pMqXy2r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 08:52:19.2372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 5c1c1368-911c-4947-eaae-08df290749fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN6PEPF00000072.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9013
Message-ID-Hash: QLGOZGS4WEI5QOMKDVD36LTIDKFFAK6N
X-Message-ID-Hash: QLGOZGS4WEI5QOMKDVD36LTIDKFFAK6N
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QLGOZGS4WEI5QOMKDVD36LTIDKFFAK6N/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add ping_slave_stat to struct amd_sdw_manager to cache the slave_stat
from the last successful ping response. On timeout,
amd_sdw_read_ping_status() returns the cached value (or 0 if no
successful response yet) to avoid the spurious "no peripherals
attached" warning from sdw_show_ping_status().

ping_slave_stat is initialised to U32_MAX in probe and reset to
U32_MAX under msg_lock on entry to the POWER_OFF_MODE resume path,
before any hardware step that can fail and return early, so that a
partially-failed resume cannot leave a stale pre-suspend value behind
for a subsequent ping timeout to report.

Add lockdep_assert_held() in amd_sdw_read_ping_status() to document
that the caller must hold msg_lock.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/amd_manager.c   | 21 ++++++++++++++++++++-
 include/linux/soundwire/sdw_amd.h |  4 ++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index fa3f4e797edd..a57b59609bfe 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -453,6 +453,9 @@ static void amd_sdw_read_and_process_ping_status(struct amd_sdw_manager *amd_man
 				    amd_manager->instance);
 		return;
 	}
+	amd_manager->ping_slave_stat =
+		FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_0_3, response) |
+		(FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_4_11, response) << 8);
 	amd_sdw_process_ping_status(response, amd_manager);
 	mutex_unlock(&amd_manager->bus.msg_lock);
 }
@@ -463,15 +466,19 @@ static u32 amd_sdw_read_ping_status(struct sdw_bus *bus)
 	u64 response;
 	u32 slave_stat;
 
+	/* Called by sdw_show_ping_status() which holds msg_lock. */
+	lockdep_assert_held(&bus->msg_lock);
+
 	if (amd_sdw_send_cmd_get_resp(amd_manager, 0, 0, &response)) {
 		dev_err_ratelimited(amd_manager->dev, "SDW%x ping status timeout\n",
 				    amd_manager->instance);
-		return 0;
+		return amd_manager->ping_slave_stat == U32_MAX ? 0 : amd_manager->ping_slave_stat;
 	}
 	/* slave status from ping response */
 	slave_stat = FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_0_3, response);
 	slave_stat |= FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_4_11, response) << 8;
 	dev_dbg(amd_manager->dev, "slave_stat:0x%x\n", slave_stat);
+	amd_manager->ping_slave_stat = slave_stat;
 	return slave_stat;
 }
 
@@ -1087,6 +1094,7 @@ static int amd_sdw_manager_probe(struct platform_device *pdev)
 		dev_err(dev, "mmio not found\n");
 		return -ENOMEM;
 	}
+	amd_manager->ping_slave_stat = U32_MAX;
 	amd_manager->instance = pdata->instance;
 	amd_manager->mmio = amd_manager->acp_mmio +
 			    (amd_manager->instance * SDW_MANAGER_REG_OFFSET);
@@ -1414,6 +1422,17 @@ static int __maybe_unused amd_resume_runtime(struct device *dev)
 		}
 	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
 		writel(0x00, amd_manager->acp_mmio + ACP_SW_WAKE_EN(amd_manager->instance));
+		/*
+		 * POWER_OFF_MODE tears the bus down completely; invalidate the
+		 * cached ping status on entry, before any step that can fail and
+		 * return early, so that a partially-failed resume leaves the first
+		 * post-resume ping timeout returning 0 rather than stale
+		 * pre-suspend data. CLK_STOP_MODE leaves peripherals attached, so
+		 * the cache remains valid there.
+		 */
+		mutex_lock(&amd_manager->bus.msg_lock);
+		amd_manager->ping_slave_stat = U32_MAX;
+		mutex_unlock(&amd_manager->bus.msg_lock);
 		if (amd_manager->acp_rev >= ACP70_PCI_REV_ID) {
 			ret = amd_sdw_host_wake_enable(amd_manager, false);
 			if (ret)
diff --git a/include/linux/soundwire/sdw_amd.h b/include/linux/soundwire/sdw_amd.h
index 470360a2723c..d0e97007e3ff 100644
--- a/include/linux/soundwire/sdw_amd.h
+++ b/include/linux/soundwire/sdw_amd.h
@@ -76,6 +76,9 @@ struct sdw_amd_dai_runtime {
  * @acp_rev: acp pci device revision id
  * @clk_stopped: flag set to true when clock is stopped
  * @power_mode_mask: flag interprets amd SoundWire manager power mode
+ * @ping_slave_stat: cached slave status from the last ping
+ *		     transaction that returned a response;
+ *                   initialised to U32_MAX ("no valid reading yet")
  * @dai_runtime_array: dai runtime array
  */
 struct amd_sdw_manager {
@@ -105,6 +108,7 @@ struct amd_sdw_manager {
 	u32 wake_en_mask;
 	u32 power_mode_mask;
 	u32 acp_rev;
+	u32 ping_slave_stat;
 	bool clk_stopped;
 
 	struct sdw_amd_dai_runtime **dai_runtime_array;
-- 
2.48.1

