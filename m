Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB9BCD343F
	for <alsa-devel@archiver.kernel.org>; Thu,  7 May 2026 18:14:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 341AA60221;
	Thu,  7 May 2026 20:13:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 341AA60221
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778177648;
	bh=ScHWcUzSeUppcZVljYz59olbLAOEgACrzdFd6erukjw=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=XyGYtURaBL0Vu+vJj0dZ2E1OagQb/fQ2iljR15mvwTxbYFA9fi7ajyvlOP6eXWC0J
	 Qfgx9j5iNJvlYVcY1eONpZVilFQFW2NxCPDLAb3cv8DqPbhBbDceKRVn0vsPjT+p9y
	 nCMdVOQitoDo958yEuhkjO0Hm4IumOWHkKAlSSR0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2E41DF805ED; Thu,  7 May 2026 20:13:32 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B5304F805ED;
	Thu,  7 May 2026 20:13:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7C660F80537; Thu,  7 May 2026 20:13:26 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012034.outbound.protection.outlook.com [40.107.209.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 339AFF800FE
	for <alsa-devel@alsa-project.org>; Thu,  7 May 2026 20:13:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 339AFF800FE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=y58QuB8f
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q053AjqQdzs2ya6Lt9/0NP1ziWE3UucmUCN/oxVU6sSIEZS7Dx8DOMBAGd6MV08OTrKOxB8fhmNfKJhiJ+VfM0CQUCjXNmamW68dFeHF6R7tK5WfVVyUymnbLmI82tCA7mKw9rFud+KaRpeKxK+BAlS2UwN+AfKO5qTW/ONlODYZUXHRxTyAzf8ZUfEl6TDKzvaKYVTLwH9pKXSepa4ZrxbV1EP6vI50qNUIAPbzvopnyCFfgMrxgOdaB/NGeaMMzz82tKJG+LThrxSEFPbKaX/azOAUPMoVUJr6dUeQWowh1JTkErFYGRgonhqBH14N1d1uhiXPf6xDkU3yT85Gjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/ETUd1sDiXopoRSWu8UQ4jS0yvAHe0oKSPRePTYt6A=;
 b=g6aYQd4t/j+HXZNxYMFmshqwXg+yLKF10CfYrSuSqzhJjTzSQVn1Djz4CWTMrD0O6k05dMorx3ZTtHPb8nGWFlP22MW0vFvLyWpARWGiC/ugbhbp1cHXKqB2ZpXjTSboYv/pY4dQXRyD8am7ju0/8G4dLZvLRL0Ev0iIJmzdwFEnVdyASfc2wvMWf3hL7EHUuv42LHmza8XmRfe4HWy03VeTRRjmzflcnkyA44Omg7YV2xYicRbUwHNlSCEZ+duAqBcYfq+L0gAHbAuFD2qFlXxrNTxG0aJfFb9QMEHXb8xFXjnnEea2LxGFyomHziNGxB8qM4nt+8FDNCgGiOsjAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/ETUd1sDiXopoRSWu8UQ4jS0yvAHe0oKSPRePTYt6A=;
 b=y58QuB8f8/6sZXCDiMIl6Mqk/w6Ca+iuzIBUgkLBrs/KLBQpn3ad8/vagl8zERwiZDandddStqv2q65MCoEFkSNrMsBfWJh91Txv881hdShAhmnIDnIhz6zs1xYGR7Wwu/gRXgKcljAGOzYKQ/L5kBU72Fm6H88yAeOohZmOySU=
Received: from BL1PR13CA0166.namprd13.prod.outlook.com (2603:10b6:208:2bd::21)
 by CH0PR12MB8462.namprd12.prod.outlook.com (2603:10b6:610:190::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Thu, 7 May
 2026 18:13:10 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::9c) by BL1PR13CA0166.outlook.office365.com
 (2603:10b6:208:2bd::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.6 via Frontend Transport; Thu, 7
 May 2026 18:13:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 18:13:10 +0000
Received: from vijendar-linux.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 7 May
 2026 13:13:06 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <mario.limonciello@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH 0/5] ASoC: AMD: ACP7.x initial PCI driver bring-up
Date: Thu, 7 May 2026 23:41:28 +0530
Message-ID: <20260507181251.20594-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|CH0PR12MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: 1749c8c0-7ebd-43c2-afdc-08deac644bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	gB0xHXmz3WUb9EU1cuIELmThuWz7rqnQoLpg0WbiuoksZ6d7wrKUpS3Q3U+9EgVUUvc89ZfrhwUDE6vIFvEZPfPipzVmrrNSNoFhUh3mWubNEpIPwej7KvUiT0f1exBYofon0tjWkS6l7W7D3qiDgi5qT5lrZGhrig8TY8TjxiztftF2QyCwRCsz2AY5GeBnN8doLNlrBpH+S2W8medUXsmm5YqmVKOCr9f0yCYaZkDdDnQvf9I3M5nNd0M4OiwOh3lO9WEcS73qgNHguiX71TO0H/pr5oO81nDVTUMz+LxuG864jwMF+zyECdf9/ktBJu6XLmThr7NmHUQmpIziIEOKZHtBCALauHocnE75BnPFAbO4dtTN58dUtDRziSjVy9TA05em2YypHntsS7vBxIwkoRk/F4vjrTenPwFDJLfize+F8uK+p7sKr6gJ2qzlp8uVFJKmbg+5L5NeknQ3JiTCfUtNCzY9yPQRa5ABZ7FYOd5HZRS5pWTdfdrx5tffkRQnWLjpZ3/icV9fQw54pV+m+IEGr+YYt4dSZlh74eV4aRF7AcXZxdy4d8037EyvKqoGC5DQEHiKUOcP+tBVu4l0pO09cpzBMaRoA67XyaKPk2VLQDovG890clhq4bGhkuzzhkq7YmODnbucItuJXFiJQNy/gyKfA4vtIVdMmuPjm7m+eoAgeJdHSepIX3HsR+ZmKj6MMhSfCWhvnY/NSxOSR9yZchinZNzBiflS9zU=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	RkZOXGV8lI3V7BLrmiqnuZIBb5y7kPz3dy08//7ZGWUEHXLnrVfFqFkzST8NR/iAPgojuqDPydLqIdi3geY3Un4ihzn7PdgJjQr3suDkyn+ChR21bsoTRTipCn4ZH5Eb6u2ldy9IGMgK6mVoGQX4WclaiRwVM4fnCeF0JQcVdMKeVQ55xt22QYBaF9RzNq+m0AmQb9ATUufnF3H4pmk8vr8WR8agZI5FoEshSNPeZ2BYPah3/WICu2x/Z3G9IipCVNeP0RGqGhRKkrDOv63Qte2su7wTE6Eh0FBgRKZzFhMLfQbegta27Jn6s3/KnbZV34Rwrqzn0MjrYdENYgR8wJ2OLEwPTKzFrwcfEhZvIXpIonUHA84UGRNDbsexRQpzu7/jkNDvJcN6lTiMq7rusuxZPUDpv4XE4xvfMIJHUKWpYHm1drf7aGVmLHJg8Qj1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 18:13:10.0937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 1749c8c0-7ebd-43c2-afdc-08deac644bca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8462
Message-ID-Hash: IPE7MUHGUDQAAYEIOCHKHC4OUUUO6AFB
X-Message-ID-Hash: IPE7MUHGUDQAAYEIOCHKHC4OUUUO6AFB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IPE7MUHGUDQAAYEIOCHKHC4OUUUO6AFB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This series adds initial AMD ACP 7.x support for ACP7.D / 7.E / 7.F
platforms.

Compared to earlier ACP generations, ACP7.x includes substantial design
changes, including an updated register set/layout. For that reason,
the ACP7.x implementation is placed under a separate sound/soc/amd/acp7x/
directory instead of extending older-generation code paths,
keeping ACP7.x-specific logic and register definitions cleanly separated
and easier to maintain.

This initial version is intentionally focused on the core PCI driver
bring-up: register definitions, probe/remove, basic helper wiring, and
system sleep + runtime PM integration. A follow-up series will add support
for additional Audio I/O blocks, including SoundWire and the ACP PDM
controller.

The primary goal of this series is to unblock power validation, since the
ACP IP currently does not have a driver available with PM ops support on
these platforms.

Vijendar Mukunda (5):
  include: sound: add register header file for acp7.x series
  ASoC: amd: acp7x: add ACP PCI driver probe/remove sequence
  ASoC: amd: acp7x: add helper functions and hw ops
  ASoC: amd: enable acp7.x drivers build
  ASoC: amd: acp7x: add system and runtime PM ops

 include/sound/acp7x_chip_offset_byte.h | 2519 ++++++++++++++++++++++++
 sound/soc/amd/Kconfig                  |   10 +
 sound/soc/amd/Makefile                 |    1 +
 sound/soc/amd/acp7x/Makefile           |    5 +
 sound/soc/amd/acp7x/acp7x-common.c     |  125 ++
 sound/soc/amd/acp7x/acp7x.h            |  110 ++
 sound/soc/amd/acp7x/pci-acp7x.c        |  168 ++
 7 files changed, 2938 insertions(+)
 create mode 100644 include/sound/acp7x_chip_offset_byte.h
 create mode 100644 sound/soc/amd/acp7x/Makefile
 create mode 100644 sound/soc/amd/acp7x/acp7x-common.c
 create mode 100644 sound/soc/amd/acp7x/acp7x.h
 create mode 100644 sound/soc/amd/acp7x/pci-acp7x.c

-- 
2.45.2

