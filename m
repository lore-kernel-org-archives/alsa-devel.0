Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0068C88E72
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:40:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E8F4F60201;
	Thu, 17 Sep 2026 10:40:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E8F4F60201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789634420;
	bh=Rm9H71A5N5k3fihz6Ax+UCQNsa3jrJWj7f410fO4wec=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=cFPpVWipJjUKOrI2rhpRngS2iiNQEl2gTUCFdVC5SUdWuzAOm2qy2qHXxA3KELG25
	 VOToZ3plE/4U/4UHsMAzF2VMyUhMdbnkGLeB9dffcqNHuEjpjYJKvrsN63NsYTDb3H
	 Zi1qhUj/zy84dyjJBgm0zaeZj+rvVieULoIx6Zb4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8D4CBF805ED; Thu, 17 Sep 2026 10:39:20 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8FAB4F80651;
	Thu, 17 Sep 2026 10:39:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 719B9F80606; Thu, 17 Sep 2026 10:39:11 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.19
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789634347;
	b=eL7XZ3SCaq/dKYlPz2qCFKhH/7g9gieFJ+AJKoUSUkU+Fh/6Smza/RK4BgvRzrrfx3zq
	 l15umRBCPs6K+BijdPEvi/LW+6t6y5MbwETuZkhvSV9TM0VqAjxSr3xGTSXAalLeTdzXu
	 Tn/D28VKtOZsorQGwxrXjRmBwR1PRaiSKS18yN2WlE+E5doVnZLDYH4pVS0UrQGdiUUvp
	 V9es4acB7gdWOCMPO6ZP5jxyoCx/XqoA94r5WGRQ6uUxZ+Gvll9KHWBVj8ZnncUHHJtzm
	 LfFWmK6H4NjC+HAiBK0Jhne1KWuvWbe4QTnOFhDNnURxnJPAwXWXFnnsprSpC/UJYTg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789634347;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Rm9H71A5N5k3fihz6Ax+UCQNsa3jrJWj7f410fO4wec=;
	b=ArF2l5eckGqVmqw4JSeuST251NFcKEzvuWyv0CpwUIg/4zvl1mAr5VN9RmHgeE5DSiHq
	 NN2XmjYCCSdZ3JYaBv0QBGVLYsGsYT8wLI8YAFS0fWBMrh0jf52NjEgSTwN0Ikrv3dpfu
	 REUstPFiD0NkIpjkXVpISZ5k5BpcUcTGs5cpr76Feym2l9R08K17LKwT3KLSTfNFNrfkl
	 RZqLcRV+9iiwUmS0CIB18BuQa9GVVRFnpSnBeITJqfNzoBy/gdUTjmXhpJG9k5qT6BmeF
	 b4QkoEqyOs5Fa6RMfeaWt250Sl25WDuRwssskI3P2xbal2+v8EUmRLNkmFw6/fI19Rg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=4QgtgJ0W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.19
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013019.outbound.protection.outlook.com
 [40.107.201.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A46EEF80007
	for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2026 10:39:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A46EEF80007
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=4QgtgJ0W
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdsqKY6BmAqALALkP7y0jwdcplE9t1tB+q52wp20w2RIOC3SCLzKHqOq9lNt5sEBEWN/sx8UdXTW17d7NKkoZ969DeoYymXD/a+3nbRdk7sP4yBs+HJwcCzBmuK8/5veKsXD1lXjOf5eaEgyJQ+GgU0SI2T1JokJNrBBxRzCkF4DrNkVtkfhSew/Mhv3xoWrnyeExraEkW6Snq+h/hjmksh99v1AD8gdvLHw7MHky8dI/XnmUMddPBAcDATHhgt1p7EM+H6vCmPxy/SQOBrIaZasNa8g8IJceFeXjRkgImSNVYd5bnkm9diYLaEQNkqQmm8p3XcclSCT+gO0+y+JAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGC+G1CYXb8swVH8qBXU8LDIXrTTeP4o+shmXKOn1DE=;
 b=fz6+hQqn7jXarsc8brKymR7v6C61Kg5xsN1OWjAOYmJpEVHkZ/srk5NH7mPX47pG5MIYmAyFVr2YfcGujavoFgUPtJC96xRXMZ7kV7GhymZI5xCQXW679gxXa1VCsMKj2JCZmE1ssDsuESGR/XkFD9fyIlzXCOfquqlr3b2Ii9uYKQZZyxqnDnaA6SO4u/gbC00pH5Hsga1Ag7HgV2+x9+DEHmT35YIUaRksVnRY3TQnnB0R7EMPmk6uST7kKDzZp/wOEV0YbmZjS11pOZcq0USJnjWrHBSWQO0JUijNZFSnl0wu39kN6vvZNuP3aDiBckj76Njy1pFfxZKjNuqnhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGC+G1CYXb8swVH8qBXU8LDIXrTTeP4o+shmXKOn1DE=;
 b=4QgtgJ0WW1h4FtNPjWaF1GsjlOKHWvz6bK3C6sJ3uh+KuWvcxiFEPHlESLZBEAezbXwJxxvw9iIOs0XXlCEX92nt7Uqar2HV782S96b7qZDvEaYf++J4doeLzDhObHhbar4gXa39DlwfiN8zrybDpBBekyR3f127CnaQj6sOs4k=
Received: from SJ2P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:a03:5db::16)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 08:38:46 +0000
Received: from MWH0EPF000C618E.namprd02.prod.outlook.com
 (2603:10b6:a03:5db:cafe::37) by SJ2P221CA0012.outlook.office365.com
 (2603:10b6:a03:5db::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 08:38:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C618E.mail.protection.outlook.com (10.167.249.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 08:38:45 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 03:38:44 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 03:38:44 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49
 via Frontend Transport; Thu, 17 Sep 2026 03:38:40 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <vkoul@kernel.org>
CC: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH V2 0/9] soundwire: amd: SoundWire manager driver bug fixes
Date: Thu, 17 Sep 2026 14:04:11 +0530
Message-ID: <20260917083732.3803526-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618E:EE_|SN7PR12MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: 731b1af4-fa7c-4465-6bfb-08df1497165c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|10067099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	bGRkLnP4M5MgppwkRPxnQMqSboZ02oM/8XSWPmqHarGpnRL1XaothXHP3qdmrGdZ7ZHoIfpr+meeLLm54Xa5sVWqHZy8j0sqmTvD46htOWByFdPfi0Q+EIENfuORy3ZnwYApQVK971QH55QsOcOIDHz3jW7v2EfbuCIWGDkRqe/VWL09waEtI74L5riEdtp5KTBtbhHxkV6Bm7BA6Kfslh4lyI+siZ87qfPbBHQWGS+p9G6Tf1l5sqTrtN6b1KC4vaIwVG/4iv8giYwbjRmGM+0YOHRBp5lOmtsNLyiXIiB1ocIHbxWnUgEM0xX6a/s3FykV7c71Ta3btDKYW036+vIhX1chv/jFLTPdu0+G60ZYk9ofEbnlJGKTSgjLoWa1TclkNaePioeCwI2kAiXzUeWoygRNpaDwpwBQZ32gb7CQ5NsxTyJa5owA8N5Qey2alwaoacC1Q1ru0PYZ9gs36mHUXrO/4R0Ck7T6Wo9si9vDApF4bxDrQLUJBZauVGzzYKzFcfN7DSYeJhVRJt5ID9n3LDWbRrssX2LpVyFStUtdf8pIsylIEHDT8+gjVKYIxMqt8v/YqUV5Orqh55ZYDQZwUhFZoCovj4+WRr7bz91pqtEmIeWHlYZKErCtsC0PNN+yBAzM4g0NfvUj3AMoPY+tO+t+lCwz91k0+/MJ+w6nH+9HZk4SEpU6f+2U4PgulPnBqcdjXKyINqTDz1LbCg==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(10067099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	wnLOuvROurRwZsag9KnWixn47Z+tGcEtSXP2dzBaiyndOXDhEs4mTZI+7a75XIKTw9evwVaSRE+rIrSGVL6kginyduDF4vV7It2hhJ2UUWBqoihG2iW35KYwCC0UnHYrQfpFg43rYtRFit0KViPRLfqCCQ+DBLpcirWJ+l10x18xMySWLGoIQhIuJ5L8TpefYE56gNUrlRpafusxr83gPVkZl9YaIfXbDBiWH65HCcZYdBgLfyDF309O2TacRDDB2SvJ0g/lJ0OIyBRq0r7C+x8HtNCgxLxpE4NALTR8d30MykHtBBEI76L3nYX5qWIqMJJOhGWoAG0vJueKii3ke0K20RtdiR3efP2sWkx0N7nEodAOs3kf1uGUNJIzSbI2oXXBm6dLwvGyd0pQpy0qJCxZYKtAioH6Y2mJFtFIpN1FAaNxvS/HZJ3ZpZYr2L2B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 08:38:45.6330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 731b1af4-fa7c-4465-6bfb-08df1497165c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MWH0EPF000C618E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201
Message-ID-Hash: KAIBZ7W7IBEM3VUFNJBKKDSWRDLF3SBA
X-Message-ID-Hash: KAIBZ7W7IBEM3VUFNJBKKDSWRDLF3SBA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KAIBZ7W7IBEM3VUFNJBKKDSWRDLF3SBA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This series collects bug fixes for the AMD SoundWire manager
driver (ACP6.3/7.0/7.1/7.2). The patches address correctness issues
in command response handling, slave status caching, work-queue teardown
ordering, resource cleanup on probe failure, and power-management
suspend/resume sequences.

Changes since v1:
- Update comment for ping_slave_stat variable description in patch 2/9.
- split the remove path work drain and pm ops guard patch into separate
  patches (patches 3/9 and 4/9) to improve clarity and maintainability.

Vijendar Mukunda (9):
  soundwire: amd: fix SDW command timeout return value handling
  soundwire: amd: cache ping slave status to avoid spurious disconnect
    on timeout
  soundwire: amd: fix work drain ordering in remove path
  soundwire: amd: pm_runtime guard in remove path
  soundwire: amd: fix ctx leak when sdw_amd_startup() fails
  soundwire: amd: propagate amd_init_sdw_manager() error on resume
  soundwire: amd: drop amd_deinit_sdw_manager() in POWER_OFF suspend
  soundwire: amd: replace >= ACP70 with explicit switch/case in PM paths
  soundwire: amd: fix interrupt gate and work drain ordering in PM ops

 drivers/soundwire/amd_init.c      |   9 +-
 drivers/soundwire/amd_manager.c   | 204 ++++++++++++++++++++----------
 include/linux/soundwire/sdw_amd.h |   4 +
 3 files changed, 149 insertions(+), 68 deletions(-)

-- 
2.48.1

