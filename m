Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE31CC6B03
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:56:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 093DB60210;
	Tue, 13 Oct 2026 10:55:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 093DB60210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791881764;
	bh=ZQlP9em70BAvUJm4UXPlNJ9j8gIhNWmG5YiAz14deMo=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=TwxddMpvYfOCesTbhxZ2vmgIwu58mDJ2Qah+HN/NyIoqr7CHkdbwNIsZF3izAg7Th
	 ps65OIYwaEv0geENZx5AeC5XBQRKBWaL3eK9XQx3jNxjKrWI0OaXXlYRRpBSu4Q+tC
	 i5CfRrW+7AuWTkR/AnrWUFTxfgydylOubc74EQMo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BD64EF807B6; Tue, 13 Oct 2026 10:53:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BC6ECF807D1;
	Tue, 13 Oct 2026 10:53:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A11ACF80759; Tue, 13 Oct 2026 10:53:16 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.8
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791881592;
	b=D10vyTkKQZVTzRBquPIAWB19RE772mePJcrWYjhzLwI9XSAiVlfHxOvAiG/JdoyJJeqf
	 vbUkRXDvQ23PnCy/NVXEGgXBVIwmgyqbmYHIT2oSfQoHwmptL0xaeQMrpCGCT4BvOkI8O
	 YCfdKjIQpW5BoXce1ioEwRoASRMWStHO1EZOmYi5v2LJ5AZjxr0tXqWIvT4pjGfOQD3Ua
	 s0pEOkDZnesVaNFJ7Y/Afxgi1kfaspAJwf7GamiB/bsiKTVWI6xxpIL071qf2QYNM1LZk
	 yM1uyy0e5rrc87jICDWPhSgFDr/h9l/KvoFi9siNoY/mW1nijtHyzCiUvhThYlkqjGw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791881592;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ZQlP9em70BAvUJm4UXPlNJ9j8gIhNWmG5YiAz14deMo=;
	b=fMuO8Lb8pS9IiS5e7Cn8v0mVSA00PVu1/qNGndKIEA6lv7EaptE/cHra3eKvHYjXE95f
	 NDvPvNbBSs9mz2Yo3QMITJYx2wh3kiKvzLS/Sq8Fce2cf2u0p51n1rlPqebCmfU34GXEZ
	 8BWqAlfDxvRP6AY59ZQDtMc3Gq7oPSpiCyb+59o/9JqyO9OdpqNUW0VbhU1QfEzuIdCCq
	 q3XnW+y+yEDUeqOZ9khNP6FA+cKdXgxDAz3D+ygXhbKUPbLsUNVWJtbGy2SnaO86iLYQg
	 MgTOXVg3QnsPCqHGFjj5UCqY8SpBgyCNX5vB7075iysg/2EXm6ySLPm8cf+VgDyDE0w==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Qg2HPA4f;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.8
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010008.outbound.protection.outlook.com
 [40.93.198.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 13B7DF80607
	for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2026 10:53:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 13B7DF80607
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Qg2HPA4f
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXFo9M0FB4fNCv5IzEPw5YzcS/yYR2S7XqjhmFKmaTxOKVZsB2Kwmrk7LqleV7H4EuPUfdUc3F56ZMrJQ8ZWFzsayFIDDCIXHD48ctf0pqsLAX+i0JPIhjCw7O6TdTsNmZNyPdX3PEA5LQIMqAXakZCaWDS494mQp4fIBkf217C/H3dPkdEeBlwjI0yM0RpwuPvQmbkJxS38Vly0ijqnoxizDpgs8zxZrqU21lb8EMZ1L9DzT5TCvJGtTDi7FlKaGNEA4sB0y1EscGiq+IjhhQ3qqf2Jvhzhu/0sS9QXfjOsi8kr7EZGbrpunztlBAZLYJnmYpsctkK5uHPGNXu6WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLW+nHLpbGJ8rTJ78Dz27zwIXURWI77D/18g/jA21Ws=;
 b=NzjpzRc8r999c0QYGMuKNkYk9obes0PAnKRFnoKgKfgyGgtvaqlq+7cXzMVdNHOIkQX28Al87UIrxiwb/lKPdLmZCo4B4xpDj8Ll67VoMo3vgupaIfKVEOqCPJPW4FmRs8UfvNS6RgV+t48wlZySoyEJZZRI/kSambuMyukibeSnqzP6HNMmmD0QY4Ly1jpTSBnq+hguDP4kFKGnVOuhq8rvZIW0zCYpPehKn8xY/pvkt9FHFgQ4AZqKtviBU1mFz9wcqL2hJxKcia/xAgt2B7EVEgau5VdIXV/dTQifai3WkD/a/MJM9dv/5NnuAm/CNXZNYzWOleNSvk7cZVLoBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLW+nHLpbGJ8rTJ78Dz27zwIXURWI77D/18g/jA21Ws=;
 b=Qg2HPA4f+1cG80HmGFe9OMaBrEA0DRuc6CDgLh9eja3fjQkvJ93bPqYY1wSopdm8BtQUgllSwh+D7i4ZKNuVouIvo+TzJ7xH2WCKDB33i1+sPr0/IThdl+mxUgsV4+2OhypBjjLAFyyiL8x6MVxeGgwE//tbzevNg32CPh01fK8=
Received: from PH5P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::16)
 by DS2PR12MB9589.namprd12.prod.outlook.com (2603:10b6:8:279::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 08:52:11 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:510:34b:cafe::a5) by PH5P222CA0005.outlook.office365.com
 (2603:10b6:510:34b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 13
 Oct 2026 08:52:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 08:52:10 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 03:52:03 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Tue, 13 Oct 2026 03:52:00 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <vkoul@kernel.org>
CC: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH V3 00/10] soundwire: amd: SoundWire manager driver bug fixes
Date: Tue, 13 Oct 2026 14:19:21 +0530
Message-ID: <20261013085111.2009061-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|DS2PR12MB9589:EE_
X-MS-Office365-Filtering-Correlation-Id: 8369dc03-30d8-4bf8-f6e3-08df290744d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|10067099003|261009223027099003|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	nTaoPopcNwhFamH6TJ3EvbmN9/cWqVTQYJP7Vsjle8Ogj+0sfrxHXako8KpK5Z6qd9j+JMlBvS6LJYSZVFr6yzVJq4cCp7c74LHYts1K3kwnENS3Mp0NtuY5WvAC+vI8ngTS0oRUcMfZ9J4Bm5bIZ+CPNNQ7kuMCbS1ByuHgujUgdsQIm50m9RP7A+3RKOe6h1bsB4OzJodOiiuJUkVkR6wA/OToeTERwUB+24YAKTAdZl5yiItc93PTYh2WySZOeOFV6MhAr/0xOc1e1g73GKEmkmhSJxrEk4u0luZhN/LQeb62iYJIQPrhtnxXK5A7r98rgab+g06Vtw4Gh3Myg02juwi8Juev9VbrfadxI2Ox1Dhj5M5Vj7XTzBP9k/ZImMQcqTsQGEdkkGSL3hEgZe2E8lYdXbhsJMmFDbDhSRBD7xIQFNOdR7mit4pXL/MnyoWh/xydRg2/sP/iO0hljOPhMTPIAB23YLBw27BofgD2sAHoxasJq3r6zN/Awela4RnNmZqtzoqF+V2+3vTPKBuL1EOK6cXvCtWQW/CWXgRAectrV53tEgKyTG8VNkRg5PHVQSufvuh++WJJvp1YSWQjbwPIMJx2V4GVlSOSykUX68fDLHSRYE33ZASF8BvfWQz3mPAswMsmb129i640AFrOzS7Ycjqcvdhv+3K1VnlHawUfbPmKZS2SNVgSqXUuSxUIfa2bsXjMUgy8qugo6Q==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(10067099003)(261009223027099003)(11063799006)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	egSz/VnqsFd6+Nf6M3t4QCRbN/OaYUxEHEG46ti8WwkUog9OO8Z4foNAFoj6sMSh6uiitVgLhurWRiz+KC2LuNdSYLG7Nf0uGEz9Hi86NchS8ZyziKxFXRTbm/qDsBacXmSCxTMlCz86wHhlFbEtKKEHG7xX8T/ZJdlOgJAF88K6pG+uTI+pV1vOlRvijL1E4SyCx+oufCo5vQabTaNlA31yKB8X8i01pOZVtP1VHhHRkuw4WBNmfFezr5u2YZs/CdHQR4Ha8NHTexZ8tSLXdNGkb/WUy0v6ZE0xk1TUgF6kXMf2BqRAdBcyYUyK2Slzy/PC8f9y3XP1k6xtk2RtKWSxRNPUer3XmaD71L8ghIdfN5IiQUIrJH5+9SRwpR4qEZzLZS1g+5ej03OHFvqbUji/FBsDiuHEpJns/DgnOQYz2uF7NAU4ZUPX7sVN2vyh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 08:52:10.5125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 8369dc03-30d8-4bf8-f6e3-08df290744d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9589
Message-ID-Hash: RA4R7NDMAYZ26TVSOYGSBHCA3DTA7LDY
X-Message-ID-Hash: RA4R7NDMAYZ26TVSOYGSBHCA3DTA7LDY
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RA4R7NDMAYZ26TVSOYGSBHCA3DTA7LDY/>
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
ordering, resource cleanup on probe failure, power-management
suspend/resume sequences, and IRQ thread status handling.

Changes since v2:
- Add patch 10/10 to fix the IRQ thread dropping STATUS_0TO7 when a
  device-state change and a wake event arrive simultaneously, which
  caused slave ATTACHED events to be lost during concurrent manager
  wake/re-attach.

Changes since v1:
- Update comment for ping_slave_stat variable description in patch 2/9.
- split the remove path work drain and pm ops guard patch into separate
  patches (patches 3/9 and 4/9) to improve clarity and maintainability.

Vijendar Mukunda (10):
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
  soundwire: amd: fix IRQ thread dropping STATUS_0TO7 on simultaneous
    wake

 drivers/soundwire/amd_init.c      |   9 +-
 drivers/soundwire/amd_manager.c   | 212 ++++++++++++++++++++----------
 include/linux/soundwire/sdw_amd.h |   4 +
 3 files changed, 154 insertions(+), 71 deletions(-)

-- 
2.48.1

