Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BDFC982D0
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:07:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BB35260203;
	Thu, 17 Sep 2026 11:07:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BB35260203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789636067;
	bh=UrJLV5j22ucMTTkqxzRN3/ifOVkUnncYOyVaEaXU5Oo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=JIti9gOMeI+lKtxjd3BvcMb1XsK83Gy440wwsTJeHO4znyYPfRJgOTDNoFWAUORSz
	 tbq2EerH7K87y0xTq0DfKGvc36Atr8KrOqDUDmpZTXrHmKJF77ZXZE6qav3gxCndHN
	 jEu8On6Z/6Zt+ZL8+aRyzzx6RwKZt+ihUHtzzCCs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 68BE3F806AB; Thu, 17 Sep 2026 11:06:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 06A86F806C8;
	Thu, 17 Sep 2026 11:06:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9E4B7F8069A; Thu, 17 Sep 2026 11:06:02 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.43
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789635960;
	b=VZFj7W8sxYwScIHwyZ32l7PEPBoLlr31IeeCCDD59m7lXdfCtMhNownv8vr2VzjRlPuJ
	 8CGsWGVuR5fLL+b2zRU5IgJTwtj2BturUsCQcIo9ybfcxNPm23VnCRl5o9soYMiasaxIC
	 yMZtil3kIzVPvWehj9K0s55NaKwf92EODEKNG4D2v6mkFxivLotNrmnA7GMnoIgzlwzAn
	 Nw0oJo7juFt6ewRPsj18e2ImgjQilmLEyNa3fCYMCXkZy25XcO+u/RTxInc53HXzAP3dr
	 c208/ujZR9wOq0K8HXhh+Vkr01yiX1Vd8pt+JYiy2Ifl4mFWbH+GUq2RCnln9hAL+vg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789635960;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=UrJLV5j22ucMTTkqxzRN3/ifOVkUnncYOyVaEaXU5Oo=;
	b=T4I+QBQFa2pqpx4rWtl5TBlUd9YMpstkUTWSeqirkjAjHf8SmuwWykUps7CvJr0omHII
	 1aBS6Hkeh94H8ptK5GwkM2qJAvDZl0ev2vUezLMFlf0B/vYHKFGl4XotsPrbSBaWap2X6
	 zleYaFYKbVyb/HExK6JY6LLUp4oyprNDSKbXw7lKMU7PD/rnarOOYffnSJTNAspKW8WvT
	 e0m5SwtECO9JbxpgrME1CHzJBuMod4YFidz2iOJ1OOXkA2zXNg00pMe5FiauWy7kfb3fr
	 8tQvi+9yZpvMeLGzLeDVFfJBiaOM5IIEc9pJpxQjGweK3Dcr7ChdMlc6Qf3FpuL+q3A==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Iq+ElTfj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.43
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010043.outbound.protection.outlook.com [52.101.85.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 80DE2F80692
	for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2026 11:05:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 80DE2F80692
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Iq+ElTfj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=muAWhO9zkiKX+YzmT5Urm5ZtnP1dWLkBFmFs83mBySvxeGa1GLhq/6p/6RmTZb7K5O6OjjsqeOrBE+AnFcVWApG0EU+T7dTP5513CGufxsAiGWbiLI+oBcFCTIdB2giSfX1w9IZVAAILX0ArGVNIweZ98xzKzGgSMESF7nmv47Y81y+iSaQyAqbnSPI7kW6NyPxqw7nbc13YSX6i81SsChdHYKcBweJAXjT/CE8MBIU+sho/q5Yz3Cfo6gH90RGnexVbB1xKfuNlNdseCe+TRRppWOnHQMAg43h9CPbhzYMlazKGvnYbMgwRp5tWpzSLxUBG9FI6aWKhp8wxYAqDZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aa1yFdGIVC5IukFuOHlA2VCb3GjKpZFAkPuHbsg5pko=;
 b=HyfPi0WZKDTzEOG8A5vuFo/BFaUDhYePXOFdJhJ23k3S25WSYwnZEl2sPpf3YVQLXDjAzEQv9coFoNMSAH+GQSSZfke0DNWX5QTa5XC+kMSixztjxWMTCxqltIdOsfx5vJOkHddQ9CsVL1GqBu8IMr5/pRlcSaJ9JLvC8AaAdFkADy8Vup2RMUjbrr2GUVFviZmSy49U8Bvfx7tdLAoAQvwi0a3C2dzeLsog1E7n0St5NasJCAOCO4Q/vE0j1AvyUeeuG/WuTD5dOv29wDrtrZ8xchmWz67IqMqHVUTWc3Gm+kmw6Pzsnjilkgb/8ye2vDXSyaok35ZILKHwPyDhDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aa1yFdGIVC5IukFuOHlA2VCb3GjKpZFAkPuHbsg5pko=;
 b=Iq+ElTfjsKMVO0pUFMmWLtjWJy8WDAPRoUFQsoeYhniHFwJgH5YdPEQJYajeyGUpRPehoXyTSQTWawZ59WHkQ+1gMbgoHBNybG2/UITSf9EPs/nDaoY0OH75PC913a5sH58YbG7b8T1ogn0tTI80+eKnTN0N8chsu1ra35IfRow=
Received: from SA1P222CA0133.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::18)
 by IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 17 Sep
 2026 09:05:45 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:806:3c2:cafe::24) by SA1P222CA0133.outlook.office365.com
 (2603:10b6:806:3c2::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 09:05:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 09:05:45 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 04:05:39 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49
 via Frontend Transport; Thu, 17 Sep 2026 04:05:35 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <vkoul@kernel.org>
CC: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH 5/9] soundwire: amd: remove unused AMD_SDW_MAX_FREQ_NUM define
Date: Thu, 17 Sep 2026 14:32:53 +0530
Message-ID: <20260917090407.3828816-6-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260917090407.3828816-1-Vijendar.Mukunda@amd.com>
References: <20260917090407.3828816-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|IA1PR12MB6043:EE_
X-MS-Office365-Filtering-Correlation-Id: 5587ee74-97b1-4055-4c2f-08df149adb96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|36860700016|23010399003|1800799024|10067099003|22082099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	4sYwems6GoWq9/ozaBKBBmMOTxCF5v1ufT/rXiPlDGT41dWDmWgVKEUDS9b1SPJoNZT4UOZM5kqRyCoN0u7PdWSqYRelvDfrLsZGFi5/SaQJkr2ItZfdGU6vNI5Q7cX+AprMGTTicg+qRLLpU01+QFeRaZPFaVhF6XvBY1kppOfNLS/TmTk8JLCY9sQSDu0RCg1NQaCFMM2cu3OG7jVwW+PnCBXyBbQIiyaTsO/4zDxlNPHbprZRa7uxA3VkzTZMysqjl2jp6OuflDgXImrwpi5pTU1XbbygH5QKdYzWpxdCtGFblhgKQSYJwRBZ5ZwWCZL/3IWkrx1gI0vkOfShXpjvkSdqp3/IDK/lmzP1b9G7qL+h3wFTmqUol5m+x8YnBJOtHCAraK1RqHU/hWfYGPImiVXjHvDwVAyEVZhAiklbCAZp4rSfJKMO/yAMMd87WMEfOzja5NjVBvjZxo6CQMF2vGGnKeGRwqQ2qfQg4i7pd+ij2DffYJPEiwy2itoYqN189dBYVcZOD/gEcbxlWpp3f5dN8/sz9vFJb5VsUA1tH6zVcPUoU87JyRCAIB1J0S9lqiW4bdAwzQhO/3U4W/ZLZN/R6XXF31YPbXL9/z0wExl7YYMZnpYGsG9MvKbg/rI8wW4H+Dcisb65qdskTJ1Pn+QSeV0KHy4GoP8tZUV/MzhnfQckr2Zo+R/NkbYNl5MQ3m+Eedj14sZCclAwKQ==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(10067099003)(22082099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	5Vn4DjLgCGEo7865oMScwzb+1klP5V0BVPVIOl+r+VSoVevj9cDVOhsSVeRpN5stj6fTqrSU3Abo+EWawIQE1ccwdu3KQSQBRZI/fTzLV0f/FKOo7EvbuBVzxVZe85v1orhEtdDXUoeJ0up7jDuQnN9Ln3rmcsO16Bj2soMTnrPMoI3Ku0SEQso/tkDMG29N6Lzz1d1vMhTcOLwCxcs4fgFBFmJQCL04XrOZS7jRc4TNcmeOhQ1ctNbAECqXhmWVTml/N/0Lv7YWZPD95iZu0UpjTMstOesKR7H4ksoDSMv7vOY6QhMyRaEGaNrFyYLe8OJ0ftblg/8mqtD0b9LNA4oPEHm8Ccf0aSfv21FJwhOUeG3W5oGHy2YYddlaAVwR0W99rVdVr1aoRcNg68OQ4IBEr4ON1sm4qYI+mY3glNmyUAWE0cDzatYr6FnMzY+B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:05:45.0466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 5587ee74-97b1-4055-4c2f-08df149adb96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6043
Message-ID-Hash: 4475HDR64HDDMEJV3ZJHQMLQYMBSRFPS
X-Message-ID-Hash: 4475HDR64HDDMEJV3ZJHQMLQYMBSRFPS
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4475HDR64HDDMEJV3ZJHQMLQYMBSRFPS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The AMD_SDW_MAX_FREQ_NUM macro has no users anywhere in the driver.
Remove it as a straightforward cleanup with no functional change.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/amd_manager.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soundwire/amd_manager.h b/drivers/soundwire/amd_manager.h
index adde192f61fe..63fecff62079 100644
--- a/drivers/soundwire/amd_manager.h
+++ b/drivers/soundwire/amd_manager.h
@@ -159,7 +159,6 @@
 #define AMD_SDW_IRQ_MASK_0TO7		0x77777777
 #define AMD_SDW_IRQ_MASK_8TO11		0x000c7777
 #define AMD_SDW_IRQ_ERROR_MASK		0xff
-#define AMD_SDW_MAX_FREQ_NUM		1
 #define AMD_ACP63_SDW0_MAX_TX_PORTS		3
 #define AMD_ACP63_SDW0_MAX_RX_PORTS		3
 #define AMD_ACP63_SDW1_MAX_TX_PORTS		1
-- 
2.48.1

