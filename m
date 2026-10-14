Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1571BCC6B1A
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2026 10:14:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3A60260330;
	Wed, 14 Oct 2026 12:14:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3A60260330
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791972865;
	bh=QqDdy2ZBQYqlTT9eFO64LHphl6o8ovGmnNeUuo/UtlE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=rmGjIuP4DtnSk9pTobKRkz2Hwc89AzB54HlRw216n8xbr9y2Mt2fjRZntNjnq5/N7
	 DybAzPLFsgf8/t37DzBsmsUUz6ads3gePFVp8RjcvJG/8b8Ka5JgekGYqrXCTAfR2O
	 0vTCQHlAF+jljonlx7Ald9c7fuEcn1B0rIZYYdtk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7034BF8085E; Wed, 14 Oct 2026 12:11:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D54EBF80863;
	Wed, 14 Oct 2026 12:11:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F0551F80642; Wed, 14 Oct 2026 12:11:22 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.57
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791972661;
	b=EBS7O5ZwonODgsjKvY/ACjybzL0V31Vb7C/xx9JRRoT58BFVIl8H73Q8TXgdUsic7Coo
	 HNxN6hBGEfuIOQd6KncFghxu3bc/23NGf27B7WpLvKfg98AV+l6EH71S/QXyXj1Y0Ch5z
	 wlRc7li4NZLysnbgj0jaI93/9/5YlaGiBOrBOcpGCUVpl9+6zAz1gx1fc4xZYmt9EsWIl
	 WI6jasXkxNwTev3Dh9ouu+hMqzfNwM3BHplcjf3/O/Qc44X2KpOlvCJNh9px1XcGmNDdq
	 Qm3eh0n8axadrxR4Zin/sgPxsDioX9+qtnywA/8LFh3Qvh+cvr1qmkgk4SyQNpSxnFw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791972661;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=QqDdy2ZBQYqlTT9eFO64LHphl6o8ovGmnNeUuo/UtlE=;
	b=AZnfu0GqY1TFHyMyEJwPlSeC4MpS9IrwrxxE2dtn0J4RSt5esX0zJH/FSWWOf/n6/TGF
	 GC/kkKVzvb5k6fUF674RRdoWAD5mcOOcQvieKB7pUFbUePKlt+fjXHJFAhyL9l1cX5TrH
	 TBrVLDBZn/34OV1uLf3eojOS9mX1P14/RR4I86TEBX3eQbT97/9hnb7SJZHNLS5MYN28Z
	 t4hSvTvNkP3S2SmYLjVtQwzl8s3DHqBU6brdtO6drRV9dGIhRnG2pib/1OcK7PyXdjKvQ
	 pcUEgHnEyQpYk1X76ev2VOmBSqePuw2sPg23yULIXoX+kowxUwfBNfUqk+Gm3ZAnO9Q==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b="YTNG/vKi";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.57
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010057.outbound.protection.outlook.com [52.101.201.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EB5C9F805FD;
	Wed, 14 Oct 2026 12:10:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EB5C9F805FD
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=YTNG/vKi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syzW9gxNQgb8mtpZ+2UyEIbfbYJGTeUURzdnX7UcWxvlaRXMflMNKEwHEFfZT71MJ6HxSM510Q/kf7+8VPqlXgh/iuhXxIyhZo9oxTKlYGYhQiloKjUNnyq+q2L9/MZZOXKcY08AxqMVE34N3H7tk4uSeEIFLNBpOYwhbgH++hLv1ozk7Bg9sl5aU/kwm13csZObYRhJ2EyiLI/+Vd3Vrb9CyZqWx3a/+l73t6wo4ywbBsYweYVzxxJaAr2pJaPnH4hfisRICUr3LKIRy7JKSvbTQ5rJfXvSe/+DTkhmy+uMyf7o549Pte2YMmngTnR6AfqZpgsN0/mKaKecG5i6Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pv/I57lnZKMwSHP36e2RkTLA2ej0xXOelIYEj6RAays=;
 b=vT1IP7prPZiqeoomB8vSxSslFSL8G8DtEPkrg1ZSkUb0GzV7wFTQOMkXbKMhXLoxeYSOKfFme8uOXdqhaqNOP8d2yLNsfABaWNnpvbY5Wd3Wgj7b8p45XPde8vhjka4compfG5sMy5p9qJ3oQhmAPt97ZDKgoyjjxq/kgDERWVc+YMW4ABW4/oNnACXLtooVndbrEcsC4yfikBx5Xzahl4fThqHw5a5GrDguhUaLRJHQ74Q+uNBKiBoGGDJnVDmOsSAtAeCOPgcj+IBGcu3Far+yy2qMoQup7UKfXiySLtejkYn9tBkI2m76DcWg3iN8mjodmu6xvZEfn/e6bFJhxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pv/I57lnZKMwSHP36e2RkTLA2ej0xXOelIYEj6RAays=;
 b=YTNG/vKiFxLoM7HM0j+dv3fxi6c2WVaUz341e7eF3CcT8c0lXdBP0DaB+QsZw9vkwjeVUYcJsRVrnbakKei6WsI8ukz0Sz6lCDSy2b55eUKCV4ubZCKliuHPAmwCPBsLYINsjhAIIgmgTEJ6CLli9CXhEDYCJYKVdLP9/kFdlfo=
Received: from BN9PR03CA0368.namprd03.prod.outlook.com (2603:10b6:408:f7::13)
 by CH3PR12MB9431.namprd12.prod.outlook.com (2603:10b6:610:1c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 10:10:50 +0000
Received: from BN3PEPF00022BC1.namprd04.prod.outlook.com
 (2603:10b6:408:f7:cafe::39) by BN9PR03CA0368.outlook.office365.com
 (2603:10b6:408:f7::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed,
 14 Oct 2026 10:10:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC1.mail.protection.outlook.com (10.167.248.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 10:10:50 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 05:10:42 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 05:10:41 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Wed, 14 Oct 2026 05:10:37 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <yung-chuan.liao@linux.intel.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<Vijendar.Mukunda@amd.com>, <Poojitha.N@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<sound-open-firmware@alsa-project.org>
Subject: [PATCH v2 10/10] ASoC: SOF: amd: add ASP carveout firmware loading
 for ACP7.B/7.F
Date: Wed, 14 Oct 2026 15:29:18 +0530
Message-ID: <20261014100902.1215212-11-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261014100902.1215212-1-Vijendar.Mukunda@amd.com>
References: <20261014100902.1215212-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC1:EE_|CH3PR12MB9431:EE_
X-MS-Office365-Filtering-Correlation-Id: d3e08e0b-02de-476b-2f19-08df29db6c74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|36860700016|23010399003|1800799024|11063799006|56012099006|18002099003|22082099003|6133799003|261009223027099003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: 
	7GSqIs7Pvi4KzCs43f/qSLclfirC+kR+ZeBI2eDy0EvFTTDXPOGWblATb5Wlrpyeb62H5BaQsNx9GEIgXWf7etjHtPHPE7tG0BmDUwGh/12C5xJeePz91WwqhivlZTg7rmrU+iCsvzzcSUVif/n7e2wRf9OuTu4pB1PRaB6ZvOaWb+/zwGfcROATNzwlHhsqlS5lHIK3BLhdEszhu2d5ksXDqLagmHFvpJ6iRTjOrHeRn9SIBAdHKQmtgT1ZcXaHm1uK3mWhSQNAknhmuxo50AR/6UtWXFWKXM4QAqy7KBrMSQ9K2ouaNQ1ZbMY+4qtfTzKoxIrNyXjLh9S7BMmlf8Fx9wW1mD4Bxg9cy/hrtKBvUPvzK3cmhJcJwItJ63ybjT3Ll8z9SREoj/MvYZG/cFTrhvnEJUDBm4Y8/8Il0nhZ/GC+dwUWSYWENH7UF8TpnRLHVOjM6FbfKYt/186R9wx3GENNTb6/e48ye8RAWVlyVteHTZ3xkDI85BQ0nBE8T43Mc4MBRCkfir3eH9mQ8Nl2kdszRvAUXU5uD7bJaBrDiM2z7UUduLJvDMBsi7QMkT7kv/8NmCVrn8iMqUJIMzVpKBDyZ/SfbLkjpsBf5WwJb9gs22AEcx+b0KORbJhm0L3H+SsY+2RL3k1fPMCgPTj/bW/6hWqKG1LBrCSivAD7Q27gZ6k99xfpOoJ6gFEF2aYg7Eg6n24NiZNWUnViHg==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003)(6133799003)(261009223027099003)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	DdBmdkkS+xQpXraePzrDyrfKv/fHJuOv5EU9a4twhfMEuTq+sR3VCf3lblHjkvc+HR31C+R5DTWRhXJy3hWnsy4DvwEZk7MNDYl5V5Pp6KLiwbSM+Mu0Xe2vmrdGIUVGZu5MOkTAOE8qLEhAReScmuikZQwpcV4MZnsNEM4Vvz/iPggMA+efHYWPjRbcJkJoH3eZM46qNlAR8kBj9B4q2j1wEpp8PZ6PQ//dpFYwSmYgaNRofjNTbIVoTnugxURY3wTcp6tkMkjEfe5bR5k7aL1SbRMpxwR4v+8dYq1rbUdMOioE3Fkw6zIngvzMzepz1GX1AGkMw0JAU8kIkmMltlqv858yCGiEb3Zu5pagKA5izBcWaQ+vmQZ5h8uvkDqSf4HRnGR4lM4q7fQGIvxnoOohWbNwIRkqZDpkdXyGlpTNhxY4ZToKUNzdDHdU7oyV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 10:10:50.3619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 d3e08e0b-02de-476b-2f19-08df29db6c74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN3PEPF00022BC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9431
Message-ID-Hash: U6PLDQPH7WAMCOMAJEK24BIS47EQJTHI
X-Message-ID-Hash: U6PLDQPH7WAMCOMAJEK24BIS47EQJTHI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/U6PLDQPH7WAMCOMAJEK24BIS47EQJTHI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

ACP7.B and ACP7.F require signed firmware to be authenticated by the
AMD Security Processor (ASP) before the DSP can execute it. Implement
a new two-stage firmware load path via the ASP MPASP mailbox.

Stage 1 (probe time): query ASP for the physical base address and ATU
group assignment of a pre-allocated 32 MB MALL carveout region. If
ASP does not support carveout, probe fails immediately.

Stage 2 (load time): load the signed image from disk, send it to ASP
via VALIDATE_IMAGE; ASP authenticates the image and deposits the raw
binary into the carveout. The driver then SHA-DMAs the raw binary from
the carveout into DSP IRAM.

On D3->D0 resume the raw binary is preserved in the carveout; the
driver skips the filesystem load and ASP authentication and restores
directly from the saved carveout address.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/Makefile          |   2 +-
 sound/soc/sof/amd/acp-dsp-offset.h  |  58 +++
 sound/soc/sof/amd/acp-loader.c      |  64 ++++
 sound/soc/sof/amd/acp-stream.c      |   9 -
 sound/soc/sof/amd/acp.c             |  77 +++-
 sound/soc/sof/amd/acp.h             | 105 ++++++
 sound/soc/sof/amd/acp7x.c           |  11 +-
 sound/soc/sof/amd/acp_asp_mailbox.c | 558 ++++++++++++++++++++++++++++
 8 files changed, 868 insertions(+), 16 deletions(-)
 create mode 100644 sound/soc/sof/amd/acp_asp_mailbox.c

diff --git a/sound/soc/sof/amd/Makefile b/sound/soc/sof/amd/Makefile
index bb1c0ddef69d7..3a7d230a4c461 100644
--- a/sound/soc/sof/amd/Makefile
+++ b/sound/soc/sof/amd/Makefile
@@ -4,7 +4,7 @@
 #
 # Copyright(c) 2021, 2023, 2024 Advanced Micro Devices, Inc. All rights reserved.
 
-snd-sof-amd-acp-y := acp.o acp-loader.o acp-ipc.o acp-pcm.o acp-stream.o acp-trace.o acp-common.o
+snd-sof-amd-acp-y := acp.o acp-loader.o acp_asp_mailbox.o acp-ipc.o acp-pcm.o acp-stream.o acp-trace.o acp-common.o
 snd-sof-amd-acp-$(CONFIG_SND_SOC_SOF_ACP_PROBES) += acp-probes.o
 snd-sof-amd-renoir-y := pci-rn.o renoir.o
 snd-sof-amd-rembrandt-y := pci-rmb.o rembrandt.o
diff --git a/sound/soc/sof/amd/acp-dsp-offset.h b/sound/soc/sof/amd/acp-dsp-offset.h
index 3984cd627db6d..0bcccf27d1336 100644
--- a/sound/soc/sof/amd/acp-dsp-offset.h
+++ b/sound/soc/sof/amd/acp-dsp-offset.h
@@ -37,6 +37,30 @@
 
 /* Registers from ACP_DSP_0 block */
 #define ACP_DSP0_RUNSTALL			0x414
+/*
+ * ATU group registers for groups 9 to 16.
+ * ACPAXI2AXI_ATU_CTRL (0xC40) sits between GRP_8 and GRP_9,
+ * so groups 9 to 16 are offset by 4 bytes relative to a simple stride.
+ */
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_9		0xC44
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_9		0xC48
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_10	0xC4C
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_10	0xC50
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_11	0xC54
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_11	0xC58
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_12	0xC5C
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_12	0xC60
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_13	0xC64
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_13	0xC68
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_14	0xC6C
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_14	0xC70
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_15	0xC74
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_15	0xC78
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_16	0xC7C
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_16	0xC80
+
+/* ATU page size value for 2 MB pages - used for carveout groups */
+#define PAGE_SIZE_2M_ENABLE			0x0
 
 /* Registers from ACP_AXI2AXIATU block */
 #define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_1		0xC00
@@ -132,6 +156,40 @@
 #define ACP_SHA_DMA_INCLUDE_HDR         0x1CCC
 #define ACP_SHA_PSP_ACK                         0x1C74
 
+/* ACP7.B/7.F MALL/Carveout configuration registers (ACP MMIO offsets) */
+#define ACP7X_MALL_ADDR_VALID			0x114C
+#define ACP7X_MALL_BASE_ADDR_LOW		0x1150
+#define ACP7X_MALL_BASE_ADDR_HIGH		0x1154
+#define ACP7X_MALL_SIZE				0x1158
+#define ACP7X_MALL_VALID			0x115C
+
+/* ASP MPASP mailbox SMN addresses for ACP7.B/7.F carveout firmware load */
+#define MPASP_C2PMSG_173_REG			0x03810BB4
+#define MPASP_C2PMSG_174_REG			0x03810BB8
+#define MPASP_C2PMSG_175_REG			0x03810BBC
+#define MPASP_C2PMSG_73_REG			0x03810A24
+
+/* ASP mailbox command IDs */
+#define ASP_MBOX_CMD_VALIDATE_IMAGE		0x0001
+#define ASP_MBOX_CMD_CALC_HMAC			0x0002
+#define ASP_MBOX_CMD_VALIDATE_HMAC		0x0003
+#define ASP_MBOX_CMD_GET_CARVEOUT_ADDR		0x0004
+
+/* MPASP_C2PMSG_173 control register bit definitions */
+#define ASP_MBOX_READY_BIT			BIT(31)
+#define ASP_MBOX_CMD_ID_MASK			0xFFFF
+
+/* ASP mailbox timeout: 5 seconds per ASP firmware load specification */
+#define ASP_MBOX_TIMEOUT_US			5000000
+/* Short timeout for the initial GET_CARVEOUT_ADDR probe: fail fast when
+ * ASP does not support carveout rather than blocking probe for 5 seconds.
+ */
+#define ASP_MBOX_PROBE_TIMEOUT_US		50000
+#define ASP_MBOX_POLL_INTERVAL_US		1000
+
+/* ASP mailbox payload cookie "ACPB" */
+#define ASP_MBOX_COOKIE				0x41435042
+
 #define ACP_SCRATCH_REG_0			0x10000
 #define ACP6X_DSP_FUSION_RUNSTALL		0x0644
 #define ACP70_DSP_FUSION_RUNSTALL		ACP6X_DSP_FUSION_RUNSTALL
diff --git a/sound/soc/sof/amd/acp-loader.c b/sound/soc/sof/amd/acp-loader.c
index f1ec856943238..abd080484804c 100644
--- a/sound/soc/sof/amd/acp-loader.c
+++ b/sound/soc/sof/amd/acp-loader.c
@@ -168,12 +168,76 @@ int acp_dsp_pre_fw_run(struct snd_sof_dev *sdev)
 	struct pci_dev *pci = to_pci_dev(sdev->dev);
 	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
 	struct acp_dev_data *adata;
+	u64 carveout_offset;
 	unsigned int src_addr, size_fw, dest_addr;
 	u32 page_count, dma_size;
+	u32 acp_logical_addr;
 	int ret;
 
 	adata = sdev->pdata->hw_pdata;
 
+	if (adata->asp_carveout_base) {
+		size_fw = adata->fw_code_raw_size;
+		page_count = PAGE_ALIGN(size_fw) >> PAGE_SHIFT;
+		adata->fw_bin_page_count = page_count;
+
+		if (adata->fw_code_carveout_addr < adata->asp_carveout_base ||
+		    adata->fw_code_carveout_addr - adata->asp_carveout_base +
+		    size_fw > adata->asp_carveout_size) {
+			dev_err(sdev->dev,
+				"carveout addr 0x%llx out of window [0x%llx+0x%x]\n",
+				adata->fw_code_carveout_addr,
+				adata->asp_carveout_base,
+				adata->asp_carveout_size);
+			return -EINVAL;
+		}
+		carveout_offset = adata->fw_code_carveout_addr - adata->asp_carveout_base;
+		acp_logical_addr = ACP_SYSTEM_MEMORY_WINDOW +
+				   (adata->asp_carveout_group_start * 8 * SZ_1M) +
+				   (u32)carveout_offset;
+
+		ret = configure_and_run_sha_dma(adata, NULL,
+						acp_logical_addr,
+						ACP_IRAM_BASE_ADDRESS, size_fw);
+		if (ret < 0) {
+			dev_err(sdev->dev, "SHA DMA from carveout failed: %d\n", ret);
+			return ret;
+		}
+
+		if (adata->is_sram_in_use) {
+			configure_pte_for_fw_loading(FW_SRAM_DATA_BIN,
+						     ACP_SRAM_PAGE_COUNT, adata);
+			src_addr = ACP_SYSTEM_MEMORY_WINDOW + ACP_DEFAULT_SRAM_LENGTH +
+				   (page_count * ACP_PAGE_SIZE);
+			dest_addr = ACP7X_SRAM_BASE_ADDRESS;
+			ret = configure_and_run_dma(adata, src_addr, dest_addr,
+						    adata->fw_sram_data_bin_size);
+			if (ret < 0) {
+				dev_err(sdev->dev, "SRAM DMA failed: %d\n", ret);
+				dma_free_coherent(&pci->dev, ACP_DEFAULT_SRAM_LENGTH,
+						  adata->sram_data_buf, adata->sram_dma_addr);
+				adata->sram_data_buf = NULL;
+				return ret;
+			}
+			ret = acp_dma_status(adata, 0);
+			if (ret < 0)
+				dev_err(sdev->dev, "SRAM DMA status error: %d\n", ret);
+		}
+
+		/* Enable cache window */
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_DSP0_CACHE_OFFSET0,
+				  desc->sram_pte_offset);
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_DSP0_CACHE_SIZE0,
+				  SRAM1_SIZE | BIT(31));
+
+		if (adata->is_sram_in_use) {
+			dma_free_coherent(&pci->dev, ACP_DEFAULT_SRAM_LENGTH,
+					  adata->sram_data_buf, adata->sram_dma_addr);
+			adata->sram_data_buf = NULL;
+		}
+		return ret;
+	}
+
 	if (adata->pci_rev >= ACP7B_PCI_ID) {
 		if (adata->acp_sof_signed_firmware_image) {
 			if (adata->fw_bin_size <= ACP_IMAGE_HEADER_SIZE) {
diff --git a/sound/soc/sof/amd/acp-stream.c b/sound/soc/sof/amd/acp-stream.c
index 9212a3137cfd2..a751ffdb0adf3 100644
--- a/sound/soc/sof/amd/acp-stream.c
+++ b/sound/soc/sof/amd/acp-stream.c
@@ -15,15 +15,6 @@
 #include "acp-dsp-offset.h"
 #include "acp.h"
 
-#define PTE_GRP1_OFFSET		0x00000000
-#define PTE_GRP2_OFFSET		0x00800000
-#define PTE_GRP3_OFFSET		0x01000000
-#define PTE_GRP4_OFFSET		0x01800000
-#define PTE_GRP5_OFFSET		0x02000000
-#define PTE_GRP6_OFFSET		0x02800000
-#define PTE_GRP7_OFFSET		0x03000000
-#define PTE_GRP8_OFFSET		0x03800000
-
 int acp_dsp_stream_config(struct snd_sof_dev *sdev, struct acp_dsp_stream *stream)
 {
 	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 790af65be34a2..86e2402b8ffd2 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -279,11 +279,18 @@ int configure_and_run_sha_dma(struct acp_dev_data *adata, void *image_addr,
 	unsigned int tx_count, fw_qualifier, val;
 	int ret;
 
-	if (!image_addr) {
+	if (!image_addr &&
+	    !adata->asp_carveout_base) {
 		dev_err(sdev->dev, "SHA DMA image address is NULL\n");
 		return -EINVAL;
 	}
 
+	/*
+	 * Flush the ATU cache before programming SHA DMA registers
+	 * to guarantee coherency at SHA DMA start time.
+	 */
+	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACPAXI2AXI_ATU_CTRL, ACP_ATU_CACHE_INVALID);
+
 	val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, ACP_SHA_DMA_CMD);
 	if (val & ACP_SHA_RUN) {
 		snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SHA_DMA_CMD, ACP_SHA_RESET);
@@ -297,8 +304,13 @@ int configure_and_run_sha_dma(struct acp_dev_data *adata, void *image_addr,
 		}
 	}
 
-	if ((adata->quirks && adata->quirks->signed_fw_image) ||
-	    adata->acp_sof_signed_firmware_image)
+	/*
+	 * The signing header must NOT be included for the carveout path: ASP
+	 * stripped it when depositing the raw binary during VALIDATE_IMAGE.
+	 */
+	if (((adata->quirks && adata->quirks->signed_fw_image) ||
+	     adata->acp_sof_signed_firmware_image) &&
+	    !adata->asp_carveout_base)
 		snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SHA_DMA_INCLUDE_HDR, ACP_SHA_HEADER);
 
 	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SHA_DMA_STRT_ADDR, start_addr);
@@ -316,7 +328,17 @@ int configure_and_run_sha_dma(struct acp_dev_data *adata, void *image_addr,
 		if (ret)
 			return ret;
 	}
-	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SHA_DMA_CMD, ACP_SHA_RUN);
+	/*
+	 * SHA_IOC_En triggers an interrupt-on-completion to ASP for source
+	 * address validation.  Only set it on the carveout path; enabling it
+	 * on the legacy ATU-window path breaks PSP validation.
+	 */
+	if (adata->asp_carveout_base) {
+		reinit_completion(&adata->sha_dma_complete);
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SHA_DMA_CMD, ACP_SHA_RUN_WITH_IOC);
+	} else {
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SHA_DMA_CMD, ACP_SHA_RUN);
+	}
 
 	ret = snd_sof_dsp_read_poll_timeout(sdev, ACP_DSP_BAR, ACP_SHA_TRANSFER_BYTE_CNT,
 					    tx_count, tx_count == image_length,
@@ -333,6 +355,23 @@ int configure_and_run_sha_dma(struct acp_dev_data *adata, void *image_addr,
 			return ret;
 	}
 
+	if (adata->asp_carveout_base) {
+		/*
+		 * Wait for the SHA IOC interrupt which fires after ASP validates
+		 * the source address.  Use ASP_MBOX_TIMEOUT_US to match the
+		 * budget used for all other ASP mailbox operations.
+		 * usecs_to_jiffies() can round to 0 at low HZ so clamp to at
+		 * least 1 jiffy.
+		 */
+		unsigned long timeout_jiffies =
+			max(1UL, usecs_to_jiffies(ASP_MBOX_TIMEOUT_US));
+
+		if (!wait_for_completion_timeout(&adata->sha_dma_complete,
+						 timeout_jiffies))
+			dev_warn(sdev->dev,
+				 "SHA DMA interrupt not received within timeout, continuing\n");
+	}
+
 	ret = snd_sof_dsp_read_poll_timeout(sdev, ACP_DSP_BAR, ACP_SHA_DSP_FW_QUALIFIER,
 					    fw_qualifier, fw_qualifier & DSP_FW_RUN_ENABLE,
 					    ACP_REG_POLL_INTERVAL, ACP_DMA_COMPLETE_TIMEOUT_US);
@@ -768,6 +807,20 @@ static irqreturn_t acp7x_irq_handler(int irq, void *dev_id)
 
 	if (adata->sdw)
 		wake_irq_flag = sof_amd_check_and_handle_acp7x_sdw_wake_irq(sdev);
+	/*
+	 * SHA DMA completion interrupt (ACP_SHA_STAT, bit 15 of ext_intr_stat).
+	 * ACP_SHA_STAT has no dedicated mask bit in ACP_EXTERNAL_INTR_CNTL;
+	 * it is always enabled by default and fires only when SHA DMA completes
+	 * with SHA_IOC_En set.  SHA DMA is triggered exclusively during firmware
+	 * loading, so this interrupt is only asserted in that context.
+	 * Acknowledge and signal sha_dma_complete so configure_and_run_sha_dma()
+	 * can proceed to poll ACP_SHA_DSP_FW_QUALIFIER.
+	 */
+	if (ext_intr_stat & ACP_SHA_STAT) {
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->ext_intr_stat, ACP_SHA_STAT);
+		complete(&adata->sha_dma_complete);
+		irq_flag = 1;
+	}
 
 	if (ext_intr_stat & ACP7X_ERROR_IRQ) {
 		snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->ext_intr_stat, ACP7X_ERROR_IRQ);
@@ -1200,6 +1253,7 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
 	adata->subsystem_vendor = pci->subsystem_vendor;
 	adata->subsystem_device = pci->subsystem_device;
 	mutex_init(&adata->acp_lock);
+	init_completion(&adata->sha_dma_complete);
 	sdev->pdata->hw_pdata = adata;
 
 	ret = acp_init(sdev);
@@ -1339,6 +1393,7 @@ int amd_sof_acp7x_probe(struct snd_sof_dev *sdev)
 	adata->subsystem_vendor = pci->subsystem_vendor;
 	adata->subsystem_device = pci->subsystem_device;
 	mutex_init(&adata->acp_lock);
+	init_completion(&adata->sha_dma_complete);
 	sdev->pdata->hw_pdata = adata;
 
 	ret = acp_init(sdev);
@@ -1411,6 +1466,20 @@ int amd_sof_acp7x_probe(struct snd_sof_dev *sdev)
 	acp_memory_init(sdev);
 	acp_dsp_stream_init(sdev);
 
+	/*
+	 * Carveout is the only supported signed firmware load path on
+	 * ACP7.B/7.F. Query ASP now when signed firmware is enabled so
+	 * probe fails cleanly if carveout is unavailable.
+	 */
+	if (adata->acp_sof_signed_firmware_image) {
+		ret = acp7x_query_asp_carveout(sdev);
+		if (ret) {
+			dev_err(sdev->dev,
+				"ASP carveout unavailable, cannot load firmware: %d\n", ret);
+			goto free_ipc_irq;
+		}
+	}
+
 	return 0;
 
 free_ipc_irq:
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index e48a6cc64b6df..b17a36b31ee0d 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -49,10 +49,14 @@
 #define ACP_PAGE_SIZE				0x1000
 #define ACP_DMA_CH_RUN				0x02
 #define ACP_MAX_DESC_CNT			0x02
+#define ACP_DSP_RUN				0x00
 #define DSP_FW_RUN_ENABLE			0x01
 #define ACP_SHA_RUN				0x01
 #define ACP_SHA_RESET				0x02
 #define ACP_SHA_HEADER				0x01
+/* SHA_IOC_En (bit 2): interrupt-on-completion to ASP; must be set alongside sha_run */
+#define ACP_SHA_IOC_EN				0x04
+#define ACP_SHA_RUN_WITH_IOC			(ACP_SHA_RUN | ACP_SHA_IOC_EN)
 #define ACP_DMA_CH_RST				0x01
 #define ACP_DMA_CH_GRACEFUL_RST_EN		0x10
 #define ACP_ATU_CACHE_INVALID			0x01
@@ -115,6 +119,28 @@
 #define ACP_FIRMWARE_SIGNATURE			0x100
 #define ACP_IMAGE_HEADER_SIZE			ACP_FIRMWARE_SIGNATURE
 #define ACP_IMAGE_HDR_SIZE_FW_SIGNED_OFF	0x14
+#define ACP_ASP_SIGNATURE_LENGTH		512
+
+/*
+ * ACP7.B/7.F carveout: 32 MB region mapped at 2 MB page granularity.
+ * Use AXI2AXIATU_PAGE_SIZE_Mask2MB (value 0x0) for carveout ATU
+ * groups giving 32MB / 2MB = 16 PTEs. 4KB pages would require 8192 PTEs and
+ * is not how the hardware carveout path is configured.
+ */
+#define ACP7X_CARVEOUT_MAX_SIZE			(32 * SZ_1M)
+#define ACP7X_CARVEOUT_PAGE_SIZE		(2 * SZ_1M)
+#define ACP7X_CARVEOUT_PAGE_COUNT		(ACP7X_CARVEOUT_MAX_SIZE / ACP7X_CARVEOUT_PAGE_SIZE)
+/*
+ * PTE high-word flags for ATU entries:
+ *   bit[31]: PAGE_Enable  - entry is valid
+ *   bit[30]: MALL_Enable  - route accesses through carveout (MALL) memory,
+ *            not standard DRAM. Required for ASP to recognise the SHA DMA
+ *            source as within the carveout and grant ACP_SHA_DSP_FW_QUALIFIER.
+ *            (PAGE_Enable | MALL_Enable ATU entry flags)
+ */
+#define ACP_ATU_PTE_PAGE_ENABLE			BIT(31)
+#define ACP_ATU_PTE_MALL_ENABLE			BIT(30)
+#define ACP_ATU_PTE_CARVEOUT_FLAGS		(ACP_ATU_PTE_PAGE_ENABLE | ACP_ATU_PTE_MALL_ENABLE)
 
 #define ACP_ERROR_IRQ_MASK			BIT(29)
 #define ACP_SDW0_IRQ_MASK			BIT(21)
@@ -136,6 +162,30 @@
 #define ACP_DSP_MSG_SET				1
 #define ACP_DSP_ACK_SET				1
 
+/*
+ * ATU PTE group ACP logical address offsets.
+ * Each group covers 8 MB (0x00800000).  Groups 1-8 are used for PCM
+ * streams; groups 9-16 are extended groups.
+ *
+ *   GRP_N_OFFSET = (N - 1) * 8 MB
+ */
+#define PTE_GRP1_OFFSET		0x00000000
+#define PTE_GRP2_OFFSET		0x00800000
+#define PTE_GRP3_OFFSET		0x01000000
+#define PTE_GRP4_OFFSET		0x01800000
+#define PTE_GRP5_OFFSET		0x02000000
+#define PTE_GRP6_OFFSET		0x02800000
+#define PTE_GRP7_OFFSET		0x03000000
+#define PTE_GRP8_OFFSET		0x03800000
+#define PTE_GRP9_OFFSET		0x04000000
+#define PTE_GRP10_OFFSET	0x04800000
+#define PTE_GRP11_OFFSET	0x05000000
+#define PTE_GRP12_OFFSET	0x05800000
+#define PTE_GRP13_OFFSET	0x06000000
+#define PTE_GRP14_OFFSET	0x06800000
+#define PTE_GRP15_OFFSET	0x07000000
+#define PTE_GRP16_OFFSET	0x07800000
+
 enum clock_source {
 	ACP_CLOCK_96M = 0,
 	ACP_CLOCK_48M,
@@ -149,6 +199,29 @@ struct  acp_atu_grp_pte {
 	u32 high;
 };
 
+/* ASP mailbox payload for GET_CARVEOUT_ADDR command (0x04) */
+struct asp_get_carveout_payload {
+	u32 cookie;		/* [0x00] Driver: ASP_MBOX_COOKIE */
+	u32 status;		/* [0x04] ASP:    0 = success */
+	u64 carveout_addr;	/* [0x08] ASP:    carveout physical base address */
+	u32 carveout_size;	/* [0x10] ASP:    ACP_MALL_SIZE register value */
+	u32 mall_addr_valid;	/* [0x14] ASP:    ACP_MALL_ADDR_VALID register value */
+	u32 mall_valid;		/* [0x18] ASP:    ACP_MALL_VALID register value */
+};
+
+/*
+ * ASP mailbox payload for VALIDATE_IMAGE command (0x01).
+ * Driver fills src/dest fields; ASP fills carveout_dest_addr and status.
+ */
+struct asp_validate_image_payload {
+	u32 cookie;		/* [0x00] Driver: ASP_MBOX_COOKIE */
+	u32 status;		/* [0x04] ASP:    0 = success */
+	u64 carveout_dest_addr;	/* [0x08] ASP:    physical addr of raw binary in carveout */
+	u64 dest_offset;	/* [0x10] Driver: destination offset within carveout */
+	u64 src_phys_addr;	/* [0x18] Driver: signed FW source physical addr in DDR */
+	u32 fw_image_size;	/* [0x20] Driver: total signed image size in bytes */
+};
+
 union dma_tx_cnt {
 	struct {
 		unsigned int count : 19;
@@ -296,6 +369,33 @@ struct acp_dev_data {
 	u32 subsystem_vendor;
 	u32 subsystem_device;
 	int acp_sof_signed_firmware_image;
+	/* ACP7.F ASP carveout firmware load state */
+	u64  asp_carveout_base;
+	u32  asp_carveout_size;
+	u32  asp_carveout_group_start;  /* first ATU group index for carveout (from ASP) */
+	u32  asp_carveout_group_count;  /* number of consecutive ATU groups for carveout */
+	/*
+	 * Physical address and raw size of each validated DSP code binary
+	 * within the carveout region (returned by ASP VALIDATE_IMAGE).
+	 * Preserved across suspend/resume so that SHA DMA can reload DSP IRAM
+	 * from the carveout without re-authenticating from disk.
+	 */
+	u64  fw_code_carveout_addr;
+	u32  fw_code_raw_size;
+	/* Real CPU physical address of the ASP MPASP mailbox payload page */
+	phys_addr_t asp_mbox_buf_phys;
+	void       *asp_mbox_buf;
+	/*
+	 * SHA DMA completion for the carveout path.
+	 * ACP_SHA_STAT (bit 15 of ACP_EXTERNAL_INTR_STAT) has no dedicated
+	 * mask bit in ACP_EXTERNAL_INTR_CNTL - it is always enabled by default.
+	 * SHA DMA is triggered exclusively during firmware loading, so no
+	 * spurious ACP_SHA_STAT interrupts are expected outside that window.
+	 * acp7x_irq_handler signals sha_dma_complete when ACP_SHA_STAT fires;
+	 * configure_and_run_sha_dma() waits on it before polling
+	 * ACP_SHA_DSP_FW_QUALIFIER to ensure ASP has validated the source.
+	 */
+	struct completion sha_dma_complete;
 };
 
 void memcpy_to_scratch(struct snd_sof_dev *sdev, u32 offset, unsigned int *src, size_t bytes);
@@ -318,6 +418,11 @@ int acp_dsp_pre_fw_run(struct snd_sof_dev *sdev);
 int acp_sof_load_signed_firmware(struct snd_sof_dev *sdev);
 int acp_get_bar_index(struct snd_sof_dev *sdev, u32 type);
 
+/* ACP7.B/7.F ASP carveout firmware load helper functions */
+int acp7x_query_asp_carveout(struct snd_sof_dev *sdev);
+int acp7x_load_firmware_carveout(struct snd_sof_dev *sdev);
+int acp7x_configure_carveout_pte(struct snd_sof_dev *sdev);
+
 /* Block IO callbacks */
 int acp_dsp_block_write(struct snd_sof_dev *sdev, enum snd_sof_fw_blk_type blk_type,
 			u32 offset, void *src, size_t size);
diff --git a/sound/soc/sof/amd/acp7x.c b/sound/soc/sof/amd/acp7x.c
index b6722d11168cb..521b7c00c7612 100644
--- a/sound/soc/sof/amd/acp7x.c
+++ b/sound/soc/sof/amd/acp7x.c
@@ -170,8 +170,15 @@ int sof_acp7x_ops_init(struct snd_sof_dev *sdev)
 			acp_sof_post_fw_run_delay = obj->integer.value;
 	}
 
-	if (acp_sof_signed_firmware_image)
-		sof_acp7x_ops.load_firmware = acp_sof_load_signed_firmware;
+	if (acp_sof_signed_firmware_image) {
+		/*
+		 * This driver handles only ACP7.B/7.F which both use the ASP
+		 * carveout firmware load path. Assign unconditionally rather
+		 * than rechecking the revision so the correct loader is always
+		 * selected when signed firmware is enabled.
+		 */
+		sof_acp7x_ops.load_firmware = acp7x_load_firmware_carveout;
+	}
 
 	if (acp_sof_post_fw_run_delay)
 		sof_acp7x_ops.post_fw_run = sof_acp7x_post_fw_run_delay;
diff --git a/sound/soc/sof/amd/acp_asp_mailbox.c b/sound/soc/sof/amd/acp_asp_mailbox.c
new file mode 100644
index 0000000000000..bc183814b9738
--- /dev/null
+++ b/sound/soc/sof/amd/acp_asp_mailbox.c
@@ -0,0 +1,558 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license. When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2026 Advanced Micro Devices, Inc. All rights reserved.
+//
+// Authors: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
+
+/*
+ * ASP (AMD Security Processor) mailbox communication and ACP7.B/7.F carveout
+ * memory firmware load/restore for the ACP7.B/7.F platform.
+ */
+
+#include <linux/acpi.h>
+#include <linux/firmware.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/unaligned.h>
+#include <asm/amd/node.h>
+
+#include "../ops.h"
+#include "acp-dsp-offset.h"
+#include "acp.h"
+
+/*
+ * acp7x_asp_send_cmd - send one ASP mailbox command via the ACPI AMSG method.
+ *
+ * The ACPI method "AMSG" (stored as 'GSMA' LE) is used to
+ * proxy commands to ASP. Direct SMN writes to MPASP_C2PMSG_* do not work
+ * because the BIOS gates host access to those registers and requires all
+ * ASP mailbox traffic to go through this ACPI method.
+ *
+ * The caller must fill adata->asp_mbox_buf with the payload before calling.
+ * On return the same buffer contains ASP's response fields.
+ *
+ * ACPI method signature: AMSG(CommandId, PayloadPhysAddrHi, PayloadPhysAddrLo)
+ * GET_CARVEOUT_ADDR uses a short 50 ms probe timeout; other commands use 5 s.
+ */
+static int acp7x_asp_send_cmd(struct snd_sof_dev *sdev, u16 cmd_id)
+{
+	struct pci_dev *pci = to_pci_dev(sdev->dev);
+	struct acp_dev_data *adata = sdev->pdata->hw_pdata;
+	struct acpi_device *adev = ACPI_COMPANION(&pci->dev);
+	union acpi_object args[3];
+	struct acpi_object_list arg_list = { ARRAY_SIZE(args), args };
+	unsigned long timeout;
+	acpi_handle handle;
+	acpi_status status;
+	unsigned int ready_timeout;
+	u32 ctrl;
+	int ret, smn_ret;
+
+	if (!adev) {
+		dev_err(sdev->dev, "ASP cmd 0x%04x: no ACPI companion device\n", cmd_id);
+		return -ENODEV;
+	}
+
+	handle = adev->handle;
+
+	/* Short timeout for GET_CARVEOUT_ADDR to fail fast if ASP lacks carveout support. */
+	ready_timeout = (cmd_id == ASP_MBOX_CMD_GET_CARVEOUT_ADDR) ?
+			ASP_MBOX_PROBE_TIMEOUT_US : ASP_MBOX_TIMEOUT_US;
+
+	timeout = jiffies + usecs_to_jiffies(ready_timeout);
+	ret = -ETIMEDOUT;
+	do {
+		smn_ret = amd_smn_read(0, MPASP_C2PMSG_173_REG, &ctrl);
+		if (smn_ret) {
+			dev_err(sdev->dev, "ASP mailbox SMN read failed: %d\n", smn_ret);
+			return smn_ret;
+		}
+		if (ctrl & ASP_MBOX_READY_BIT) {
+			ret = 0;
+			break;
+		}
+		usleep_range(ASP_MBOX_POLL_INTERVAL_US, ASP_MBOX_POLL_INTERVAL_US + 100);
+	} while (!time_after(jiffies, timeout));
+
+	if (ret) {
+		dev_err(sdev->dev, "ASP mailbox not ready before cmd 0x%04x\n", cmd_id);
+		return -ETIMEDOUT;
+	}
+
+	args[0].type = ACPI_TYPE_INTEGER;
+	args[0].integer.value = cmd_id;
+	args[1].type = ACPI_TYPE_INTEGER;
+	args[1].integer.value = upper_32_bits(adata->asp_mbox_buf_phys);
+	args[2].type = ACPI_TYPE_INTEGER;
+	args[2].integer.value = lower_32_bits(adata->asp_mbox_buf_phys);
+
+	status = acpi_evaluate_object(handle, "AMSG", &arg_list, NULL);
+	if (ACPI_FAILURE(status)) {
+		dev_err(sdev->dev, "ASP AMSG cmd 0x%04x: ACPI method failed: %s\n",
+			cmd_id, acpi_format_exception(status));
+		return -EIO;
+	}
+	return 0;
+}
+
+/*
+ * acp7x_configure_carveout_pte - program ATU groups for ACP7.B/7.F carveout.
+ *
+ * Programs PAGE_SIZE, BASE_ADDR and PTE entries for each ATU group covering
+ * the carveout region using 2 MB pages with PAGE_Enable | MALL_Enable flags.
+ * Must be called after GET_CARVEOUT_ADDR and on every D0 resume since
+ * acp_init() resets the scratch SRAM and ATU registers.
+ */
+int acp7x_configure_carveout_pte(struct snd_sof_dev *sdev)
+{
+	struct acp_dev_data *adata = sdev->pdata->hw_pdata;
+	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
+	u64 phys_addr;
+	u32 grp_start = adata->asp_carveout_group_start;
+	u32 grp_count = adata->asp_carveout_group_count;
+	u32 total_pages, pages_per_group;
+	u32 grp, page_in_grp, page_idx;
+	u32 pte_scratch_offset, page_size_reg, base_addr_reg, reg_val;
+	u32 pte_lo_addr, pte_hi_addr;
+	u32 low, high;
+	u32 abs_grp;
+
+	if (!adata->asp_carveout_base) {
+		dev_err(sdev->dev, "carveout PTE: no valid carveout address\n");
+		return -EINVAL;
+	}
+
+	if (!grp_count || grp_start < 8 || grp_start + grp_count > 16) {
+		dev_err(sdev->dev, "carveout PTE: invalid ATU group range %u+%u\n",
+			grp_start, grp_count);
+		return -EINVAL;
+	}
+
+	/*
+	 * ASP is expected to allocate exactly four contiguous 8 MB ATU groups
+	 * for the fixed 32 MB carveout. Warn if the response differs so that
+	 * unexpected firmware behaviour is clearly visible in the log.
+	 */
+	if (grp_count != 4)
+		dev_warn(sdev->dev, "carveout PTE: expected 4 ATU groups, got %u\n",
+			 grp_count);
+
+	total_pages = adata->asp_carveout_size / ACP7X_CARVEOUT_PAGE_SIZE;
+	pages_per_group = total_pages / grp_count;
+	page_idx = 0;
+
+	for (grp = 0; grp < grp_count; grp++) {
+		abs_grp = grp_start + grp;
+
+		/*
+		 * asp_carveout_group_start is the 0-based index from
+		 * __ffs(mall_addr_valid): bit N in MallGroupEntries represents
+		 * hardware GRP_(N+1), so abs_grp is 0-based and GRP number is
+		 * (abs_grp + 1). Example: bits 11-14 set -> abs_grp 11..14 ->
+		 * programs GRP_12..GRP_15 (registers 0xC5C..0xC74).
+		 * ATU_CTRL (0xC40) sits between GRP_8 and GRP_9, adding a
+		 * 4-byte gap for abs_grp >= 8 (i.e. GRP_9 and above).
+		 */
+		if (abs_grp < 8)
+			page_size_reg = ACPAXI2AXI_ATU_PAGE_SIZE_GRP_1 + abs_grp * 8;
+		else
+			page_size_reg = ACPAXI2AXI_ATU_PAGE_SIZE_GRP_1 + abs_grp * 8 + 4;
+
+		base_addr_reg = page_size_reg + 4;
+
+		pte_scratch_offset = abs_grp * 0x20;
+		reg_val = desc->sram_pte_offset + pte_scratch_offset;
+
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, page_size_reg, PAGE_SIZE_2M_ENABLE);
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, base_addr_reg, reg_val | BIT(31));
+
+		dev_dbg(sdev->dev,
+			"carveout ATU: abs_grp=%u PAGE_SIZE_reg=0x%x BASE_ADDR_reg=0x%x val=0x%x\n",
+			abs_grp, page_size_reg, base_addr_reg,
+			(u32)(reg_val | BIT(31)));
+
+		for (page_in_grp = 0; page_in_grp < pages_per_group;
+		     page_in_grp++, page_idx++) {
+			pte_lo_addr = ACP_SCRATCH_REG_0 + pte_scratch_offset + (page_in_grp * 8);
+			pte_hi_addr = pte_lo_addr + 4;
+			phys_addr = adata->asp_carveout_base +
+				    ((u64)page_idx * ACP7X_CARVEOUT_PAGE_SIZE);
+			low  = lower_32_bits(phys_addr);
+			high = upper_32_bits(phys_addr) | ACP_ATU_PTE_CARVEOUT_FLAGS;
+
+			snd_sof_dsp_write(sdev, ACP_DSP_BAR, pte_lo_addr, low);
+			snd_sof_dsp_write(sdev, ACP_DSP_BAR, pte_hi_addr, high);
+		}
+	}
+
+	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACPAXI2AXI_ATU_CTRL, ACP_ATU_CACHE_INVALID);
+
+	dev_dbg(sdev->dev,
+		"carveout PTE done: %u groups [%u..%u] covering 0x%llx..0x%llx\n",
+		grp_count, grp_start, grp_start + grp_count - 1,
+		adata->asp_carveout_base,
+		adata->asp_carveout_base + (u64)adata->asp_carveout_size);
+	return 0;
+}
+EXPORT_SYMBOL_NS(acp7x_configure_carveout_pte, "SND_SOC_SOF_AMD_COMMON");
+
+/*
+ * acp7x_alloc_asp_payload - allocate a physically contiguous buffer below 4 GB.
+ *
+ * ASP accesses memory via the SoC fabric, bypassing the IOMMU, so the buffer
+ * must be below 4 GB and page_to_phys() must return the real CPU physical
+ * address.  Use __GFP_DMA32/__GFP_DMA as hard zone constraints (not hints)
+ * to guarantee the physical address fits in 32 bits.
+ */
+static void *acp7x_alloc_asp_payload(struct snd_sof_dev *sdev, phys_addr_t *phys_out)
+{
+	struct page *page;
+	void *vaddr;
+
+	page = alloc_page(GFP_KERNEL | __GFP_DMA32 | __GFP_ZERO);
+	if (!page)
+		page = alloc_page(GFP_KERNEL | __GFP_DMA | __GFP_ZERO);
+	if (!page) {
+		dev_err(sdev->dev, "ASP mbox: failed to allocate below-4GB payload page\n");
+		return NULL;
+	}
+
+	vaddr = page_address(page);
+	*phys_out = page_to_phys(page);
+
+	if (*phys_out > 0xFFFFFFFFULL) {
+		dev_err(sdev->dev, "ASP mbox: page at phys=0x%llx still exceeds 4 GB\n",
+			(u64)*phys_out);
+		__free_page(page);
+		return NULL;
+	}
+
+	return vaddr;
+}
+
+static void acp7x_free_asp_payload(void *vaddr)
+{
+	if (vaddr)
+		__free_page(virt_to_page(vaddr));
+}
+
+int acp7x_query_asp_carveout(struct snd_sof_dev *sdev)
+{
+	struct acp_dev_data *adata = sdev->pdata->hw_pdata;
+	struct asp_get_carveout_payload *co_payload;
+	phys_addr_t phys;
+	u32 group_bits, first_bit, count;
+	int ret = 0;
+
+	co_payload = acp7x_alloc_asp_payload(sdev, &phys);
+	if (!co_payload)
+		return -ENOMEM;
+
+	co_payload->cookie       = ASP_MBOX_COOKIE;
+	/* Sentinel: ASP overwrites on success; 0xFFFFFFFF after the call means no carveout */
+	co_payload->carveout_size   = 0xFFFFFFFF;
+	co_payload->mall_addr_valid = 0xFFFFFFFF;
+	co_payload->mall_valid      = 0xFFFFFFFF;
+
+	adata->asp_mbox_buf     = co_payload;
+	adata->asp_mbox_buf_phys = phys;
+
+	ret = acp7x_asp_send_cmd(sdev, ASP_MBOX_CMD_GET_CARVEOUT_ADDR);
+
+	dev_dbg(sdev->dev,
+		"GET_CARVEOUT response: status=0x%x addr=0x%llx size=0x%x mall_valid=0x%x mall_addr_valid=0x%x\n",
+		 co_payload->status, co_payload->carveout_addr,
+		 co_payload->carveout_size, co_payload->mall_valid,
+		 co_payload->mall_addr_valid);
+
+	if (ret)
+		goto out_free;
+
+	if (co_payload->status || !co_payload->carveout_addr ||
+	    !co_payload->carveout_size || co_payload->carveout_size == 0xFFFFFFFF) {
+		dev_warn(sdev->dev,
+			 "ASP GET_CARVEOUT_ADDR: status=0x%x addr=0x%llx size=0x%x - no carveout\n",
+			 co_payload->status, co_payload->carveout_addr,
+			 co_payload->carveout_size);
+		ret = -ENODATA;
+		goto out_free;
+	}
+
+	if (!IS_ALIGNED(co_payload->carveout_addr, ACP7X_CARVEOUT_PAGE_SIZE) ||
+	    co_payload->carveout_size != ACP7X_CARVEOUT_MAX_SIZE) {
+		dev_warn(sdev->dev,
+			 "ASP carveout: unexpected base alignment or size (addr=0x%llx size=0x%x, expected 0x%x)\n",
+			 co_payload->carveout_addr, co_payload->carveout_size,
+			 ACP7X_CARVEOUT_MAX_SIZE);
+		ret = -ENODATA;
+		goto out_free;
+	}
+	/*
+	 * Extract ATU group start and count from MallGroupEntries bits[15:0].
+	 * Scan to find first set bit (start), then count
+	 * contiguous set bits. Example: 0x7800 -> start=11, count=4.
+	 * Defer committing asp_carveout_base/size until all validation passes
+	 * so adata is never left with a non-zero base but zero group_count.
+	 */
+	group_bits = co_payload->mall_addr_valid & 0xFFFF;
+	first_bit = 0;
+	count = 0;
+
+	if (group_bits) {
+		first_bit = __ffs(group_bits);
+		while ((group_bits >> (first_bit + count)) & 1)
+			count++;
+		/* Validate contiguous run - reject non-contiguous masks */
+		if (group_bits != (((1u << count) - 1) << first_bit)) {
+			dev_warn(sdev->dev,
+				 "ASP carveout: non-contiguous mall_addr_valid 0x%x unsupported\n",
+				 group_bits);
+			ret = -ENODATA;
+			goto out_free;
+		}
+	}
+	if (!count) {
+		dev_warn(sdev->dev, "ASP carveout: no valid ATU groups in mall_addr_valid\n");
+		ret = -ENODATA;
+		goto out_free;
+	}
+	adata->asp_carveout_base = co_payload->carveout_addr;
+	adata->asp_carveout_size = co_payload->carveout_size;
+	adata->asp_carveout_group_start = first_bit;
+	adata->asp_carveout_group_count = count;
+
+	dev_dbg(sdev->dev, "ASP carveout: base=0x%llx size=0x%x grp_start=%u grp_count=%u\n",
+		adata->asp_carveout_base, adata->asp_carveout_size,
+		adata->asp_carveout_group_start, adata->asp_carveout_group_count);
+
+out_free:
+	adata->asp_mbox_buf = NULL;
+	adata->asp_mbox_buf_phys = 0;
+	acp7x_free_asp_payload(co_payload);
+	return ret;
+}
+EXPORT_SYMBOL_NS(acp7x_query_asp_carveout, "SND_SOC_SOF_AMD_COMMON");
+
+int acp7x_load_firmware_carveout(struct snd_sof_dev *sdev)
+{
+	struct snd_sof_pdata *plat_data = sdev->pdata;
+	struct acp_dev_data *adata = plat_data->hw_pdata;
+	struct asp_validate_image_payload *vi_payload;
+	const char *fw_filename;
+	struct page *fw_page;
+	phys_addr_t vi_phys;
+	u64 dest;
+	u32 page_count, dma_size;
+	u32 size_fw_signed;
+	unsigned int order;
+	int ret;
+
+	/*
+	 * Carveout query was already done in amd_sof_acp7x_probe() via
+	 * acp7x_query_asp_carveout(). If ASP did not return a valid carveout
+	 * address, fail immediately - no fallback to legacy path.
+	 */
+
+	/* Program PTEs for the entire carveout region before any DMA into it.
+	 * acp_init() in resume clears the scratch SRAM so PTEs must be reprogrammed
+	 * on every boot including D3->D0 resume.
+	 */
+	ret = acp7x_configure_carveout_pte(sdev);
+	if (ret)
+		return ret;
+
+	/*
+	 * On D3->D0 resume the raw binary is already in the carveout region
+	 * (placed by ASP during the previous VALIDATE_IMAGE call). Skip the
+	 * filesystem load and VALIDATE_IMAGE - go directly to the data binary
+	 * path. acp_dsp_pre_fw_run() will SHA-DMA from the preserved carveout
+	 * address into DSP IRAM.
+	 *
+	 * On first boot fw_code_carveout_addr is 0 so the condition below is
+	 * false and the full firmware load path executes.
+	 */
+	if (adata->fw_code_carveout_addr)
+		goto load_data_binary;
+
+	fw_filename = kasprintf(GFP_KERNEL, "%s/%s",
+				plat_data->fw_filename_prefix, adata->fw_code_bin);
+	if (!fw_filename)
+		return -ENOMEM;
+
+	/* Release any previously loaded firmware before requesting again */
+	if (sdev->basefw.fw) {
+		release_firmware(sdev->basefw.fw);
+		sdev->basefw.fw = NULL;
+	}
+
+	ret = request_firmware(&sdev->basefw.fw, fw_filename, sdev->dev);
+	kfree(fw_filename);
+	if (ret < 0) {
+		dev_err(sdev->dev, "request_firmware %s failed: %d\n",
+			adata->fw_code_bin, ret);
+		return ret;
+	}
+
+	page_count = PAGE_ALIGN(sdev->basefw.fw->size) >> PAGE_SHIFT;
+	dma_size = page_count * ACP_PAGE_SIZE;
+
+	/*
+	 * Allocate the firmware staging buffer below 4 GB using alloc_pages so
+	 * virt_to_phys() gives the real CPU physical address that ASP can read
+	 * via the SoC fabric (bypassing the IOMMU). dma_alloc_coherent() gives
+	 * an IOMMU-remapped DMA address which ASP cannot use.
+	 *
+	 * get_order() gives the smallest power-of-2 number of pages covering
+	 * dma_size; alloc_pages() allocates that contiguous range.
+	 */
+	order = get_order(dma_size);
+	fw_page = alloc_pages(GFP_KERNEL | __GFP_DMA32 | __GFP_ZERO, order);
+	if (!fw_page)
+		fw_page = alloc_pages(GFP_KERNEL | __GFP_DMA | __GFP_ZERO, order);
+	if (!fw_page) {
+		dev_err(sdev->dev, "failed to allocate FW staging buffer\n");
+		release_firmware(sdev->basefw.fw);
+		sdev->basefw.fw = NULL;
+		return -ENOMEM;
+	}
+	adata->bin_buf     = page_address(fw_page);
+	adata->sha_dma_addr = page_to_phys(fw_page);
+
+	if (adata->sha_dma_addr > 0xFFFFFFFFULL) {
+		dev_err(sdev->dev,
+			"FW staging buffer at phys=0x%llx exceeds 4 GB\n",
+			(u64)adata->sha_dma_addr);
+		__free_pages(fw_page, order);
+		adata->bin_buf = NULL;
+		release_firmware(sdev->basefw.fw);
+		sdev->basefw.fw = NULL;
+		return -ENOMEM;
+	}
+
+	memcpy(adata->bin_buf, sdev->basefw.fw->data, sdev->basefw.fw->size);
+	adata->fw_bin_size = sdev->basefw.fw->size;
+
+	if (adata->fw_bin_size <= ACP_IMAGE_HEADER_SIZE) {
+		dev_err(sdev->dev, "signed FW too small: %u\n", adata->fw_bin_size);
+		ret = -EINVAL;
+		goto free_bin;
+	}
+	/*
+	 * SizeFWSigned (header[0x14]) is the size of the signed payload
+	 * including the ASP signature trailer.  ASP strips the ACP image
+	 * header (0x100 bytes) but preserves the signature, so the raw
+	 * binary deposited in carveout has size = SizeFWSigned and the
+	 * SHA DMA length must equal SizeFWSigned.
+	 */
+	size_fw_signed = get_unaligned_le32(adata->bin_buf + ACP_IMAGE_HDR_SIZE_FW_SIGNED_OFF);
+
+	if (size_fw_signed <= ACP_ASP_SIGNATURE_LENGTH ||
+	    size_fw_signed > adata->fw_bin_size - ACP_IMAGE_HEADER_SIZE) {
+		dev_err(sdev->dev,
+			"invalid SizeFWSigned 0x%x in carveout firmware header\n",
+			size_fw_signed);
+		ret = -EINVAL;
+		goto free_bin;
+	}
+	adata->fw_code_raw_size = size_fw_signed;
+	vi_payload = acp7x_alloc_asp_payload(sdev, &vi_phys);
+	if (!vi_payload) {
+		ret = -ENOMEM;
+		goto free_bin;
+	}
+
+	vi_payload->cookie = ASP_MBOX_COOKIE;
+	vi_payload->dest_offset = 0;
+	/*
+	 * ASP bypasses the CPU IOMMU and accesses memory via the SoC
+	 * fabric directly, so it must be given a real CPU physical
+	 * address for the staging buffer (not an IOMMU/DMA-translated
+	 * address). Use virt_to_phys(bin_buf) which returns the real
+	 * CPU physical address, same as for mailbox payload buffers.
+	 */
+	vi_payload->src_phys_addr = (u64)virt_to_phys(adata->bin_buf);
+	vi_payload->fw_image_size = adata->fw_bin_size;
+
+	adata->asp_mbox_buf = vi_payload;
+	adata->asp_mbox_buf_phys = vi_phys;
+
+	dev_dbg(sdev->dev, "sending VALIDATE_IMAGE(0x01): src=0x%llx size=0x%x dest_offset=0x%llx phys=0x%llx\n",
+		vi_payload->src_phys_addr, vi_payload->fw_image_size,
+		vi_payload->dest_offset, (u64)adata->asp_mbox_buf_phys);
+
+	ret = acp7x_asp_send_cmd(sdev, ASP_MBOX_CMD_VALIDATE_IMAGE);
+
+	/* Read result before freeing payload */
+	if (!ret && !vi_payload->status) {
+		dest = vi_payload->carveout_dest_addr;
+
+		if (dest < adata->asp_carveout_base ||
+		    dest - adata->asp_carveout_base + adata->fw_code_raw_size >
+		    adata->asp_carveout_size) {
+			dev_err(sdev->dev,
+				"VALIDATE_IMAGE: dest 0x%llx outside carveout window\n",
+				dest);
+			ret = -EIO;
+		} else {
+			adata->fw_code_carveout_addr = dest;
+		}
+	} else if (!ret && vi_payload->status) {
+		ret = -EIO;
+	}
+
+	adata->asp_mbox_buf     = NULL;
+	adata->asp_mbox_buf_phys = 0;
+	acp7x_free_asp_payload(vi_payload);
+
+	if (ret) {
+		if (ret == -EIO)
+			dev_err(sdev->dev, "ASP VALIDATE_IMAGE failed\n");
+		goto free_bin;
+	}
+
+	dev_dbg(sdev->dev, "ASP VALIDATE_IMAGE: raw binary at carveout 0x%llx size 0x%x\n",
+		adata->fw_code_carveout_addr, adata->fw_code_raw_size);
+
+	/* DDR staging buffer is no longer needed - raw binary is in carveout */
+	free_pages((unsigned long)adata->bin_buf, get_order(dma_size));
+	adata->bin_buf = NULL;
+
+load_data_binary:
+	fw_filename = kasprintf(GFP_KERNEL, "%s/%s",
+				plat_data->fw_filename_prefix, adata->fw_data_bin);
+	if (!fw_filename) {
+		release_firmware(sdev->basefw.fw);
+		sdev->basefw.fw = NULL;
+		return -ENOMEM;
+	}
+
+	ret = request_firmware(&adata->fw_dbin, fw_filename, sdev->dev);
+	kfree(fw_filename);
+	if (ret < 0) {
+		dev_err(sdev->dev, "request_firmware %s failed: %d\n",
+			adata->fw_data_bin, ret);
+		release_firmware(sdev->basefw.fw);
+		sdev->basefw.fw = NULL;
+		return ret;
+	}
+
+	ret = snd_sof_dsp_block_write(sdev, SOF_FW_BLK_TYPE_SRAM, 0,
+				      (void *)adata->fw_dbin->data,
+				      adata->fw_dbin->size);
+	release_firmware(adata->fw_dbin);
+	adata->fw_dbin = NULL;
+	release_firmware(sdev->basefw.fw);
+	sdev->basefw.fw = NULL;
+	return ret;
+
+free_bin:
+	free_pages((unsigned long)adata->bin_buf, get_order(dma_size));
+	adata->bin_buf = NULL;
+	release_firmware(sdev->basefw.fw);
+	sdev->basefw.fw = NULL;
+	return ret;
+}
+EXPORT_SYMBOL_NS(acp7x_load_firmware_carveout, "SND_SOC_SOF_AMD_COMMON");
-- 
2.48.1

