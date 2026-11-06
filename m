Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06037606A326
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Nov 2026 11:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=cAA/3Iqi;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=u5wN2Irt
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4282760212;
	Fri,  6 Nov 2026 12:48:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4282760212
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793965742;
	bh=X6/mgo3bJnOexQGtqEtD0bBToj88AnSS0+bSNsOPCKs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=cAA/3IqiV52NBbCfN3TtVufr6bOvTTBmipdCmqwdnbnXJOnGmQEF5qN0saUomhcK3
	 +xKgYkGeOgmOx4xmzvAmzwC1RkTL5r7X25poXKXHXXxMFPHPGWxNcaIiq/N4Je33Rd
	 xy64bEViaqoKdvMnRFSxwvSmzWuAhN7f1WGV216Y=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ACB9BF8065E; Fri,  6 Nov 2026 12:48:09 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 04A3AF80659;
	Fri,  6 Nov 2026 12:48:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 109BCF80510; Fri,  6 Nov 2026 12:48:03 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.20
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1793965681;
	b=mMCUsyDwIlmiX0gKMz54ZZEnb6bzDOVqpfPkpkxSW9hvBrHuACULQeEnOSnQsaPEHWVy
	 MaC5M8sBKip7tObP6pyMxvVWg2LIPqDKSlZ/iepPCS6zNG7ivKboRPXA2BAo+bx7f7uCm
	 OMeEgZy7f7uJb2nNtMutnIjSsf9oKcQm3awMHw3WF8qHWy1/YDB1TVNdwquwqPtjfEPNJ
	 qUUUlaiVxVrA07/v9GNRnSyCZkCMHSnlpSwYA6Vdz5gUsmlRApieYjHoo0K9D4EAbS/ni
	 /AXtdDAPmWCp34OiOtNJrRx35U3w0pNN71l8q3m4e0GwtxRlPNhMpZw0t/YGbqgRsBg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793965681;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=X6/mgo3bJnOexQGtqEtD0bBToj88AnSS0+bSNsOPCKs=;
	b=gWYzjjzLB2Qs4FotB6aV5eZPlqGHLR1cR7KqsPbxCJkKsSc/rpEps6tpy8xU4B5LbaUH
	 LMwVNA4J6gj5LvOWCcPfBt60H7clI2+0XF7aTEWaf0tLQKK3gaemOiVc3jxNWzumbWyAK
	 wk+B3LAuZUV0YurK0W+mi9vcmzWwFpcQQKZdGKz50xyZFnJYOMsdeunM8fBeQ1M4N+tC0
	 aUSIxKrJoXo/ZluKYb/GA739+GRFp3UIawcBcbHfrH5lZAKTI/foUQ569X+NNi6S5SPJl
	 XmnimpBVQ4GM3PpyBJkQJlRmVmoXfB3uS31uB0GBbb3dt+hBXv9iLkFrjZfYXQmgF0w==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=u5wN2Irt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.20
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010020.outbound.protection.outlook.com
 [40.93.198.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 78FA2F80620
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2026 12:48:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 78FA2F80620
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=u5wN2Irt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mCPFjMmIMurERPkBR9mCZNgFgp10xRiHy7NU+Uxp/+z7/8L5dp7IJt0Q9/Rs3m670pQAHwYX85N25LWSmLquXl79Svvej7MUFV7zQF2rJ/ees/mn+8hf93LtNDRyxdIzrzitMtgfrxqSwx/uhIKuRjtUFGKETK6k0BTKF2h86XepHwrahHvxAYS95yeEtumiRQTfvAO5qGOi55hM3RXq2aPc/ivuYsZcrMFtt/KvTkBWzgysGX9b0NEsx1PLKZufR6C+zdElzGHhZGEZXA83/jbYtORrf/0JH9Cv+06TZ/YnCyBA2tqhvsvmutZrHbPS2NvWZiGdX3E8/Vx9ybGBbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzBpCKFbDYsh8blKc2pumbkoQfmuj4eqLhrPJrAx864=;
 b=AMe7NzEYYfYrFY8kg9kh6LWrYMndWYQXN8nzVaFVrGSDeAs4z609RUjgJ14XnPT5tmDaiqA+pOa/dXnyZWvTkn5sGUyLvpVwA16e8OWHCYJjcuL3ZCqV5x1UVsOszIEgQ+C8onLurz7gFUYFdTfiZ0ehkjk13tK4FTeFwBcsvnc37qaFDLBhFBgDvTtMrVWusyRgCN4V7yUaPacQWeihN/rteZbHp7dpOpLbaJpICUt/g7QzgRtL4V/7AtAlIMtzZe1cxKpoZgYdIZUTn/2pCTm3/PQDy1aponzWPU3esIY4/sOeo0k9xz2NQSvSPJ0H1no9RswZu4GMfGDTGNJ7ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzBpCKFbDYsh8blKc2pumbkoQfmuj4eqLhrPJrAx864=;
 b=u5wN2IrtDdlOX/IfxSlV/r210c2n7NGtfxFc8lJuCfegLHQjJN4IKWQSd9CSEQYBpYw3NFag7XBNYkWG68Qq9+VdGIwqHMR/8oqGRdzh+aJPcYE4N+Xmcvuz8yOLnaDvwf+4aFpOC7Em4PjKTEJjjTwYPgB97P2rzHikl2+LEqc=
Received: from DSZP220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::9) by
 SJ1PR12MB6170.namprd12.prod.outlook.com (2603:10b6:a03:45b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Fri, 6 Nov 2026
 11:47:50 +0000
Received: from DM3PEPF000265BF.namprd03.prod.outlook.com
 (2603:10b6:5:280:cafe::61) by DSZP220CA0008.outlook.office365.com
 (2603:10b6:5:280::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 11:47:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM3PEPF000265BF.mail.protection.outlook.com (10.167.23.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 11:47:50 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 05:47:49 -0600
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Fri, 6 Nov 2026 05:47:40 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <pierre-louis.bossart@linux.dev>, <vijendar.mukunda@amd.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Mario.Limonciello@amd.com>,
	<Richard.Gong@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<Syed.SabaKareem@amd.com>, <alsa-devel@alsa-project.org>,
	<lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
	<venkataprasad.potturu@amd.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 2/2] ASoC: amd: acp: document PDM controller topology for
 ACP7.B/7.F
Date: Fri, 6 Nov 2026 17:16:22 +0530
Message-ID: <20261106114622.219126-3-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106114622.219126-1-Vijendar.Mukunda@amd.com>
References: <20261030094714.1123396-1-Vijendar.Mukunda@amd.com>
 <20261106114622.219126-1-Vijendar.Mukunda@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BF:EE_|SJ1PR12MB6170:EE_
X-MS-Office365-Filtering-Correlation-Id: e49b7abc-1b94-42e4-97e9-08df3bfbc8d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|261009223027099003|261021123027099003|261021121427099003|56012099006|4143699003|11063799006|261102123227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	lz2cvKhB/2Ed64ANiLI6QZ7MLeD5uRwSZGv5mba9Zu7BqI9KoyIRaxYymb1ZuznVRGbGSzAhsxVZdp3AssFnM4ZFM28mReQbnNSrU2Q4U1YccvI7hUVnYfkctvHlXfyaD7KhzKPdZys70OrMSlYvSffI+VgUMd+xK8xH6Fb3yoz/LLX91Zh2OKrIOqfiEZP6NJWpjCVFh+BtgmNbqapJJwXWUpXegTxNdE/91bibYCuux2CO5VDC9CBKM4lsSphtvkjMKqq4ZdLJRNbAZD5aQU9HVS5COdV0auiqX33ceS70TE+Wmmj9KbxSr2jl91GV643HtitxljZQfyH0FbKGS3yBhivd9BIhVUo+E7b/9vsZ7tZs0a4/DnPqm8gj8KLusfd6UBZGVGqPX17WPsazXP0Mf/kVZgQyWGGYn4rMCQDPF8dZZKUNriHymU/yR3xJjr5gi+PT1gFyDwaI0VeihoCksaGdb2F/YZf/K/xWV5XYTmhogj4+KJ/5nZjSM+mxW/3YC54kCR8Yb4mS7/46HC+nqy3xOssQBysTfwQERMm8Oz82Q3NtJACwaI8iwxPOd7rOFuDmj5atHB91bgFRQS4PPI1kD8N0K83FSy2T8s/GLQ0s3IPiGQ11Ogu7AEkNaIquQ2p3oR9F7kxynnmN/GGnQe9IWoVz7PjanlBH+Br5xqDz/GSygi3fre64rXtt8h0b/phe9xRRJhjmoA7WTQ==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(261009223027099003)(261021123027099003)(261021121427099003)(56012099006)(4143699003)(11063799006)(261102123227099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	VUrEt4HhMvA6nBp2kzzgrm+aazJH22ye9smIZUyJkvV8vcctnwe5k2DoomZ81Q+G7p0WiS8h6VBFKI+mOTxKEC8mTAOUKZz0aIVUTb0w++4AoUT2hqKzt47mMBcI9oiXa7QyuhMJFNkosY9Oq2c5ZngfBZ5MiiIHPNjgJw+RxAUcc1a8pv4A1BTtfIeC/uJJLL1sH41B5vqrKh59SgUVJ4AP7+ihoBN4rNZQWXIwsABU+P4oADa3AHUMKY9XQoPBQxNFKOIR87muS4obpVKCXe8BB0eg84G7MqXltykbyXtT5uI/YR2BvUoBTYey7NTW1nYW0b/PR+ASgWb76N5eyOXlxMarGBM/eGIP5OyA/ZwKYfiS9jN1STzWXCgSby26ZmmJKtsJgedxSq7Gi3D0bjJ8e/G56r2e2rh3CQkk7icotP2Dz9r8KitusvXPU8qo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 11:47:50.1649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e49b7abc-1b94-42e4-97e9-08df3bfbc8d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DM3PEPF000265BF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6170
Message-ID-Hash: 5JZDZDSSTZGLGRJRDRTR4UVE2IWIQTUC
X-Message-ID-Hash: 5JZDZDSSTZGLGRJRDRTR4UVE2IWIQTUC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5JZDZDSSTZGLGRJRDRTR4UVE2IWIQTUC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

Add a block comment above the ASOC_SDW_ACP_DMIC / ASOC_SDW_ACP_DMIC1
quirk bits and annotate each bit with its role.

ASOC_SDW_ACP_DMIC (BIT(5)) is a generic DMIC-enable flag used across
all ACP platforms; on ACP7.B/7.F it additionally identifies the PDM0
controller.  ASOC_SDW_ACP_DMIC1 (BIT(6)) selects the PDM1 controller
and is ACP7.B/7.F-specific. Both ACP7.B/7.F controllers support a
2-channel stereo capture path, and BIOS wires exactly one per platform.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/soc_amd_sdw_common.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/acp/soc_amd_sdw_common.h b/sound/soc/amd/acp/soc_amd_sdw_common.h
index 07837a2cfa54..21b059b74626 100644
--- a/sound/soc/amd/acp/soc_amd_sdw_common.h
+++ b/sound/soc/amd/acp/soc_amd_sdw_common.h
@@ -28,8 +28,15 @@
 
 #define SOC_JACK_JDSRC(quirk)		((quirk) & GENMASK(3, 0))
 #define ASOC_SDW_FOUR_SPK		BIT(4)
-#define ASOC_SDW_ACP_DMIC		BIT(5)
-#define ASOC_SDW_ACP_DMIC1		BIT(6)	/* select DMIC1 controller for ACP7.B/7.F */
+/*
+ * ASOC_SDW_ACP_DMIC is a generic DMIC-enable flag used across all ACP
+ * platforms. On ACP7.B/7.F it additionally identifies the PDM0 controller;
+ * ASOC_SDW_ACP_DMIC1 selects PDM1 on ACP7.B/7.F instead. Both ACP7.B/7.F
+ * controllers support a 2-channel stereo capture path, and BIOS wires exactly
+ * one per platform.
+ */
+#define ASOC_SDW_ACP_DMIC		BIT(5)	/* enable DMIC; PDM0 on ACP7.B/7.F */
+#define ASOC_SDW_ACP_DMIC1		BIT(6)	/* PDM1 / DMIC1, ACP7.B/7.F only */
 #define ASOC_SDW_CODEC_SPKR		BIT(15)
 
 #define AMD_SDW0	0
-- 
2.53.0

