Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51F4C88E72
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:40:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CCCFE601EB;
	Thu, 17 Sep 2026 10:39:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CCCFE601EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789634403;
	bh=Vc7AC3/pKTeErOhnmNkmmWCswzDSFbLaoB0HQjACKVQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=rBXpvoeIQFBBOLMVt0fY4Zu5C0AADbTbkLXeZwvKGXyENBAK4cF3z/X/F1s+wpJ8K
	 qSJjp6JXLvtrPEZw/igardXUE5PGmLkUpGgVes/ihYqf+3B2IGY+qJzJ7WuYwc1cGq
	 tT6kiLHLu523fOQJPpvML1W8tQx7Ssi1ApTNC8Uw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5A5FEF8061F; Thu, 17 Sep 2026 10:39:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3F10DF80620;
	Thu, 17 Sep 2026 10:39:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 68BF8F80579; Thu, 17 Sep 2026 10:39:07 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.50
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789634343;
	b=Nd2/CqrDPsdoQDyFCQ20+5ma6dH4+pr/OMe99wY/LFNOE0bo5AL7/F8ktM2R3o2r6PSK
	 myw9XJYEU2s2dj20cTGZf6MODUknER/mVEDML3nF2VTbIvPX5Tw5r5nfVmAStnJGapvqA
	 tMFBGETwwBobt0ceKJXkBMNzSG3u2nckd06AxGeDN+59wq/kHyKscBMsU8LK33xFSPSK5
	 MgbqIFtOVgqM+U6XEnzNcJYv8crLjYhZ6fkkWgypoptz/bwGlRRq2sACbBZ/6d8WzDk6/
	 flyruV64deeLXsKQSi6Zuaa2517LxPqASwyGD6XjLd5xSVAB3CskmE4lm5HMhqq8n3g==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789634343;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Vc7AC3/pKTeErOhnmNkmmWCswzDSFbLaoB0HQjACKVQ=;
	b=Bq/Vw170/xA+03E5oxIwz9NKppFFx76izXkRWVFzq02ZQmfDN1XFTp8Gfi2JR4/Gm42g
	 ZHk+mnICdSjRb8+38HdPttiqQIl+Ehi5LQJ42T+eNgN2dg7jgmeuGW6H9IKiTE7QinCC6
	 gadlC6IoWEgIsYL1f0Qn2VMtJPeOOQffu4zX0MHveROYOATswI2B63YqcMT+RZ7vxnIW2
	 7K2pVxqtpVZkmGCIjPE9prMBA/oSTDceHbqCV8aNusuJdWp+U+7YYOpg75a+t/8dT6yMz
	 Xq0nbUDkcftsbiv0GQBqpbCHGDnhMzL2daFRVgpXmQ6daubIkr4suRjnMRYxwFX92Pw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=x6ZqtxYk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.50
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012050.outbound.protection.outlook.com
 [40.107.200.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4F6D8F8007E
	for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2026 10:39:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4F6D8F8007E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=x6ZqtxYk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cOthTMz9wtSD/tUPZi8avGWsovWA82lbYKn/wRZCvxBQseBb9URylXd4F24FA+J4IKGgu3GV8bFRdjy0k+j9FtzoZaFm5ipd/FlLECSCaKxNafbEfUWWSdqR4crgkSl+qqDP1J4sGqgdJ/ilT6igKGrPEAXfUXMyuCW+xNXrRTZfrITxNcK3rPTYTGzvpU4q/Fv5woWb7C3xRxfGEGZv9ACxZnRbl6YltDfv0cxo57hmcQY9sv0awtfG1Asva/KYgz6NbIZ7NKWBbk7XTSk3Mq/IRSb3d4mBiWhCxeVB9zvxXeo/0UEqpbCBlx+AVoj3mHyt/hg2ja/cnB3NDY3QLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lZoLuzAa2+32cj+bNSjogB9DmBnhywviMNGKwNQyiQ=;
 b=UHfBxu33V6iVU3tG5r3/pImU+5bsGt8vgN5XZW9jJ7cY2Y0jHcBv6hxec0i9URZKqwchUOCfYlVbZCzxIm9S15iSZIykAAh66rgT+2gHHMsEGgtqDgbuGrt2KTJNrSLxaopvQjB+ZCP3UIZZPVQ2onxcSrKeooI2lN51l2s9H5uvcLohECDgudy+N1r1qfahgY5fCcT4STID6MC/kzWP423BJ5kZy91UD2BP028/9WlPtcJlMowaWklkDftXu7LvWGQhf4644HCA8m/UXQ6KDY74mrn82PUfgzVqwcqOcqAETyiasrA54iiBpcBaA/i3+sXHS6gnRFIH9/jgF2IE9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lZoLuzAa2+32cj+bNSjogB9DmBnhywviMNGKwNQyiQ=;
 b=x6ZqtxYkzZcId2PY2wBiV3nourjIagtgb14MwWweLnkYAPfvOWZXD1Dmene3z965W6kNR7sixBK2/E96V0NT8IKEgrtT5XS9rUXdrYeh9dHHeswXBDfRLw7/pAl85dE9Eii+c8NOx+bB1bfRizQkr8unkl2u0qY2yQMLsRAcAYk=
Received: from CP6P284CA0026.BRAP284.PROD.OUTLOOK.COM (2603:10d6:103:15d::18)
 by DS0PR12MB6415.namprd12.prod.outlook.com (2603:10b6:8:cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 08:38:55 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10d6:103:15d:cafe::7d) by CP6P284CA0026.outlook.office365.com
 (2603:10d6:103:15d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 08:38:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 08:38:52 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 03:38:52 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49
 via Frontend Transport; Thu, 17 Sep 2026 03:38:48 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <vkoul@kernel.org>
CC: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH V2 2/9] soundwire: amd: cache ping slave status to avoid
 spurious disconnect on timeout
Date: Thu, 17 Sep 2026 14:04:13 +0530
Message-ID: <20260917083732.3803526-3-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260917083732.3803526-1-Vijendar.Mukunda@amd.com>
References: <20260917083732.3803526-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|DS0PR12MB6415:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e55398d-c1bf-45b9-6af3-08df14971a88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	QnZZx9mNiRNXt6Y6QsTVtCSZN++EahsNnPhRyU+XFSfGz6bhtxALAeGiA1aDhbbmwuJTlaSKO66/xt4RgVKlI2wRQ3lPZK7fwpdJjNXiAWZm3YZNdQm5SC2+xFooKry3deW24wDDE5w2ML9qsMRnF84VvHyBxabxMQDsOw1ISJxemZOBKl2wb3MMwEeLqKYV1DRA2Sp8VAkxQ/6MEDdBXsp8dlIN3WfA5K/XkCeHpRn/0+7XmQ92EfIWH0BQScbd51ukxD71unPZE1NmIyAtdMm87XY/ga63ToTuL37jrwSMHfZWsKkrdpfNKUrCDQyBmVfw7w9PPzhzwNDkofu6U0AQkTWy1HY7zV4DJVtK1/INMThSWjHjdilysjNkhqF0WhR0At+Z9IHE0G6IKp1Lv9RdTXvBhBqwpj/UM55U6LUmU6FaJPW05Yoq4Tw1lNwUSgGalL2ztCkYKv6jhTZRyyur3bPNa1sbmzlL5wbAzOfSlZsBJKZSCCM5qj0wsoOWVBOOHasETT/Kg0eIGZGHHbcAFRl4D8sSBVLyuTSxnTTB5a8312vYO0ngsSCN8zHRzr4N851g3YJ503tA+ub4o+BSjjNAXuzGFkjkXRlMtaZlTVU4rLD+6F6k4OG7ubp+7O/P4VfTLPdbIevnouI3IILTwgmJhhfX21qMqMF0iBOdMVPjm2FfN66trInEXR61fNO0E+FjUvOjdMXWSdHEag==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	5viub3b7rCfz546OxvfTFe1o1UtJHiVMbpVPEuFI5XajzGbvS/7yjEfBHyKcQ978B2adME+oL4CaAU8HIizEMd4ZR92G6Dt1JspIsAbajG+AUGOehjm34Te1W14ckv0ow8Tc00txna6NDCIQur5WZ5WxgbWO5BP3MxL7/trzlwwLIRWPCfbv0h3LhiJhH9Pkoj/EFCrrkp/3SlSNolqZNddGd3L8S5MGdXFf5dgWElPQtle4VjkSquuls2rmkHD9R7zDospXXL94ef6/704OsSn+VUGIbt5NNA4OTMHXizypHJYmsl/NVY1F5W89TceZriGyc28V5vzi8l7u73tODrT+5AcN98tiMSGiDUKxvGIaHCSD32ukeKdkiRITaGvHII1X2JGNEm2CKhbNXdZm7IpzTrCFUX3ZxJidwPm52AbxtdRU1BRHgctPUvgwAyl2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 08:38:52.7241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 5e55398d-c1bf-45b9-6af3-08df14971a88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6415
Message-ID-Hash: RR3HJNGUKXCWV7CMADZXHWTBBQEGA2UT
X-Message-ID-Hash: RR3HJNGUKXCWV7CMADZXHWTBBQEGA2UT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RR3HJNGUKXCWV7CMADZXHWTBBQEGA2UT/>
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

