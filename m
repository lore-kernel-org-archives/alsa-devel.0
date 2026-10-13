Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962D3CC6B03
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:04:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A075601F9;
	Tue, 13 Oct 2026 12:04:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A075601F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791885895;
	bh=Q1sGDx3DZPC3poSgY46yqFRCpioY4YK4P6erdhAokgM=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=qdmwQSpaoKIxkMSEVIhLk99u8v2BXOEGyoYVMQ0GWJ4erXnXAl+euEOV8vDhFma0l
	 1ICsUWwQHPyMBxk+AjtmdaviTVoG7QMmFpyXQz6fqQIxgabaexmACj7w9jk6LX4L5v
	 hhhZGpurQUegxc+twNLrxgTy4IAg+fffSUA4aNMY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A4D92F80600; Tue, 13 Oct 2026 12:04:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EC64FF805EC;
	Tue, 13 Oct 2026 12:04:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9E0A7F80495; Tue, 13 Oct 2026 12:04:15 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.44
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791885851;
	b=gpRJKAFtp2G3+R7Da/Q0E9S0uJ8NtCXKcev7RZFKb66xeCNB9d8A0r36Fb1YhX1FdJ+J
	 yVBy/chdpguBOvEULawPgRImizjkH3ylqr232guXErxCHT/mCGJ7K9qmWHQrRFj9ye6y1
	 lyXkasV+JRUNCbaVJYcdBDDpthH3vTz7bpzm+mbgy8YFoMZDSyVdxyCvwT5BWaPouhlen
	 MipoTRNej98VcA5g7Ns84PmWMqt7cmkAOMidNT24icyCZlbsYJVUBXZKv0n6vQn+2kqIx
	 hihQxk1lZCx/fC+FegJHr+YeieeLuf3rjU6Twj42mEFfl6aX0YD6m8xBI5CClcp1AhA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791885851;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Q1sGDx3DZPC3poSgY46yqFRCpioY4YK4P6erdhAokgM=;
	b=Axkvli+JC0fdP5+25SyH/uGP60s1aDJi9g1IM0e94buTsUZNUK0I38o2iOV3urk1eIR5
	 7EVQxOu/3vpa//09tj8r44blb1PlmK0LYGqgyJK9mFkWV+IYS3XrYI9cEN3wVKzvZstBa
	 l8R7DQrl7PMcLZJOFEWBzC9jaK+JBwzuK+T4k7BMVezZ6taebF7G4cdKAdmv31FAEgIrO
	 omPOv3Ee0lw1QDEdur48LHmImFf3WYwElSaRPhD6xS+Y8E8DlP0WqiUTdunHAjPazk0S5
	 /gv5p9IMy8hcQiIEcIMhHqm+SwH69ATLlUMilh25I63vhoFSC/7Pm+G39gkMZ1iDAYQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=zszoz346;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.44
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010044.outbound.protection.outlook.com [52.101.56.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 819C5F800EE
	for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2026 12:04:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 819C5F800EE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=zszoz346
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QBbCZYSky3wfHJujGZUD2QX077VrRb9fyuHumqttCgogjro6VToWJ+S8xTAWqJmUIsUFEnyo4nv3sbHw+aG7gLZpx4fZ6e6lp3lE60LH+EleJ4k+E8UW6XZ68dv8CqlOlTBDCyZBqWiuT0Z73042c+zE3bSiNJe+RdCk9MyYPP6Cz0fiMmkFYlVYDiLQiuqcc7B5npTPloq3xdGpvFty4zhPsIoFPLcpeepKNAzB5sqUwbKTR0yVEyu3L3TERTH39TvtgzsixPKo42KDBwU/1sPINyBMMrhug5V1BY9HZSY2/Y5JJeNnI/Qv13mCF9L9QfWbJ2c37gc0PZHk2IWPOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2ZexJVDJTHFEq1w+ffVEOuvV+N7JKR3GnzgU8ABwTw=;
 b=b9n9zChinJdsV/ebBlfkacrql+vNeqbNbB1C4Cept1mBJpvnxrB8c0gc2Z+04GqXbQpAb3a2ejLhSrzqGi7dTGLZlPUq3AQfzqbsAZlEXlGjendT0boBa9egEu2/XG23MprzFT43xQ+VGjpDBh3FhmFKQXG5NOf3R4WBBuFPhjhqxPZBYLYql8YafGlbZkynRKTG/BTQuLfeCal7iN/b2RxCGggpDOdF+8S/SArsyv75biN353xrxw036vhwMgB4+5uLV90Zzy6ChlrLMnHhQ1RED0hmU/f/mTSgDWQHD0o1yhjRrRUBBLpoXVDnwSlxKq0ugV4MALGjEA32TvKNRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2ZexJVDJTHFEq1w+ffVEOuvV+N7JKR3GnzgU8ABwTw=;
 b=zszoz346pDpsAzZEkwsE4v8kMUb5cqf+sLPEF/EwLmBg7Z713I6gIST4W+tIvMi9IQ5TyVwZ6RAQ5lXIP8kRBp98yCSPmTep3IbYoCdzWZAnTCHgDG3EpIydY+04Z/T7pXzzmuYBJk8q8vNKBr5kAc7ABL0hLS673OyzjzXz38Y=
Received: from SJ0PR13CA0062.namprd13.prod.outlook.com (2603:10b6:a03:2c4::7)
 by DM6PR12MB4419.namprd12.prod.outlook.com (2603:10b6:5:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 10:04:04 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::3a) by SJ0PR13CA0062.outlook.office365.com
 (2603:10b6:a03:2c4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 13
 Oct 2026 10:04:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 10:04:04 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 05:03:58 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Tue, 13 Oct 2026 05:03:54 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <vkoul@kernel.org>
CC: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<Vijendar.Mukunda@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V2 0/9] soundwire: amd: introduce hw_ops dispatch and split
 driver into revision-specific files
Date: Tue, 13 Oct 2026 15:28:46 +0530
Message-ID: <20261013100306.2921771-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|DM6PR12MB4419:EE_
X-MS-Office365-Filtering-Correlation-Id: a465d63b-6507-4252-1f63-08df2911500d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|6133799003|10067099003|18002099003|13003099007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	gYTBB8xmnQ5spelBssiZEFfinqTQuD3DBRdgTKQBfS8NGAanAbGbyyvejH2Zm/xsO2XxfOo7cCTj2TmxXwvf8Oou8Qc4reVJgbPrnpd1Bk5MRD45VkCEsOUae3jwGXHF8BmVe3mC9Bn+7IqfDI6kZH8zLGD1gfTAp9r/DGpYpgSlKYRw/8kgFSANil/wSefkPCJB4yn8CHaWiTl5Z+AxZPaBOH3MlxRcRlTWR0iBk2g9fw5SWFMmnQhqH/ERNRMwuKB6sZZgRHd9Inp+2mRxO/O0EvYlcsqmJP5Q2ZSo2JBdTxpdmP5MlZ5VwFEI+mYnkKHn4EUnFFx/9JDWPkUqoWeB7BmPgx2xehfl3zrHQ4Ze6IbSNA8KWI6kye6IgkYKkGSG0WrULonw2J9x/n5zjzy1G2BbennBCIYzrIBH5+8xRlFF0PdNXbcgr5NLP+VDN8omIP+KiyauGu8J7uo4cIcJ54Kug79jC+fwiMEQxdFxg78eJiDzKJgEKdKtav9mb+XyeJzJKMW1EdkFuFw1763x4Gx1AUguVMEnSMZ1DjTDnybWT/MQkgn90o4B9JRRGHuJ7RWlplM9/AR2ZZR1bjn5gEqPO1Z/PraWPy74IBriveIoI2fC6EFReCzqfM44bIN1BZcaNVJ1rk47ALD/UpNNeu61ihYt3VUn2rMTsls=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(6133799003)(10067099003)(18002099003)(13003099007)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	T63L08fbcqzT/bp9E1Y/4yrhGyTnaCu1XhQnZORGgJTObKbC4CFxvNbz2dsGRjyeenbe8dIMmkhVKpGah6LpR+11QLh45FcNVuHVCgza6/OPmg67ueaTmJK0gURY5GOdHmMgjYeA+shmhNuv3Y2K40hWENbL/+RXrqEdplMKJSbOv10bB3DYDprkRg4oCx414WRZ99YiRaqdXi6K+h+y7Qs6vBxtXFsgGCZgM12io6wHdpCzj1D3/Dk/yAuq3Af1P27/jRSZwS8zj/2baKhObyxqsvzF3GUOVVn+BxlsHWHdC5ucZINtxGvGpvKfxTseK90ydt/Qh4Kk37BbjJXse2mTkHumzwkLIF0wfiE1G8RxV2q0xXd6umXEucvKttqa5cz1z4ZyvZmk2PAqWWnHP2NIKzjvbMKRsMeAGh9eO5SVjXQBI5rW0n49KZpVas+H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 10:04:04.3103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 a465d63b-6507-4252-1f63-08df2911500d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4419
Message-ID-Hash: 7SQEIVBSDMF245DJM4AXAQVONPVVEXQ6
X-Message-ID-Hash: 7SQEIVBSDMF245DJM4AXAQVONPVVEXQ6
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7SQEIVBSDMF245DJM4AXAQVONPVVEXQ6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This is v2 of the AMD SoundWire manager driver refactor series. It
incorporates review feedback from v1 and extends the restructuring to
split the monolithic amd_manager.c into two files.

Changes since v1:
- Patch 4 subject updated: "rename hardware backend symbols" (covers
  functions, op-table instances, and the register-offset constant)
- Patch 6: removed the forward reference to "subsequent patches" from
  the commit message; dropped WARN_ONCE guards from dispatch helpers
- Patch 7: commit message corrected; #include <linux/workqueue.h>
  addition dropped (available transitively)
- Patch 8: amd_sdw_hw_init_ops() now uses a static const
  struct amd_sdw_hw_ops instead of devm_kzalloc; amd_sdw_hw_init_ops()
  moved after amd_sdw_manager_remove() with a forward declaration before
  probe to resolve ordering
- Patch 9 (new): splits amd_manager.c into amd_manager_common.c
  (shared revision-independent functions, analogous to cadence_master.c)
  and renames what remains to amd_acp63_manager.c (ACP6.3/7.x register-
  level backend, analogous to intel_auxdevice.c)

Series overview:

Patches 1-3 are preparatory: rename the manager-count macro to carry
the ACP6.3 scope, convert the pdevinfo/sdw_pdata and pdev arrays in
sdw_amd_probe_controller() from fixed-size stack arrays to heap
allocations sized by the ACP revision.

Patch 4 renames revision-specific hardware-access functions, op-table
instances, and the manager register-offset constant to the amd_acp63_*
/ACP63_* prefix.

Patch 5 removes an unused define.

Patches 6-8 introduce and wire up the hw_ops dispatch framework:
patch 6 defines struct amd_sdw_hw_ops and the inline acp_*() dispatch
helpers; patch 7 converts the irq/work handlers to dispatch per
acp_rev to their ACP6.3-family implementations; patch 8 extracts PM
callbacks into hw_ops slots, populates a static const amd_acp63_hw_ops
table, and converts all remaining direct amd_acp63_*() call sites to
use the corresponding acp_*() wrappers.

Patch 9 splits amd_manager.c: shared revision-independent functions
move to amd_manager_common.c and the ACP6.3/7.0/7.1/7.2 register-level
backend is renamed to amd_acp63_manager.c.

Dependencies:

This series applies on top of the AMD SoundWire fix series posted at:
https://lore.kernel.org/alsa-devel/20261013085111.2009061-1-Vijendar.Mukunda@amd.com/T/#t


Vijendar Mukunda (9):
  soundwire: amd: rename AMD_SDW_MAX_MANAGER_COUNT macro
  soundwire: amd: allocate pdevinfo and sdw_pdata by ACP revision in
    probe
  soundwire: amd: allocate sdw_amd_ctx pdev array dynamically
  soundwire: amd: rename hardware backend symbols to amd_acp63_*()
    prefix
  soundwire: amd: remove unused AMD_SDW_MAX_FREQ_NUM define
  soundwire: amd: introduce struct amd_sdw_hw_ops dispatch framework
  soundwire: amd: dispatch irq/work handlers to per-revision functions
  soundwire: amd: populate hw_ops and wire all call sites through
    acp_*() helpers
  soundwire: amd: extract shared functions into amd_manager_common.c

 drivers/soundwire/Makefile                    |   2 +-
 .../{amd_manager.c => amd_acp63_manager.c}    | 904 ++++--------------
 drivers/soundwire/amd_init.c                  |  49 +-
 drivers/soundwire/amd_manager.h               | 255 +++--
 drivers/soundwire/amd_manager_common.c        | 773 +++++++++++++++
 include/linux/soundwire/sdw_amd.h             |   9 +-
 6 files changed, 1183 insertions(+), 809 deletions(-)
 rename drivers/soundwire/{amd_manager.c => amd_acp63_manager.c} (50%)
 create mode 100644 drivers/soundwire/amd_manager_common.c

-- 
2.48.1

