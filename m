Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDA3606A32C
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=OlCtYHT5;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=L0JBG4yv
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 120C160209;
	Fri,  6 Nov 2026 14:10:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 120C160209
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793970639;
	bh=X6/mgo3bJnOexQGtqEtD0bBToj88AnSS0+bSNsOPCKs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=OlCtYHT5R7G9E0hTcvTErBcAoCyco2sJ27+nfoJD4c8sg+fPH3hqhcPvWzyIPTBrb
	 F4Bo7/tkVZxl80GRZ+txnDfo+ZW96EB7hl3qfopaFl76JBIGRHMf5lm5WiKgSRtRfk
	 EVgeUTGEqmwwVHZwqhjHxTGmTEXDFMUNZbIar2j0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2E4ADF805F3; Fri,  6 Nov 2026 14:09:53 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D75EF80641;
	Fri,  6 Nov 2026 14:09:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 720E9F80620; Fri,  6 Nov 2026 14:09:47 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.26
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1793970583;
	b=Qvb/m5SXsopPLiYf0PotBpd7rK8GBiWV8zrV8kllyjGMWc95euNLzD518e/qDZfrOUrB
	 cB8fidrfa77bFglBr6uwl74SXiIIvjiWxeClny/4XvLIwwFJVAB7UICerN70brZvXxHxX
	 ND6SNfqriOvja5qtjCcEmL6HmqtMMr9tFAfVgQPdE7/ZV+IRsFTFwKDlcHnqUeuKYY56l
	 BWwt+EY5ELK/SVep8aJ54rYskWkvZ8Y2tGGCdGOZxr7kv2YpcjkWyoN/8x65IsV+zfeao
	 VcsqFgwrKqE8R0IqbjApJDW06f44UAk5xqIjyZF6nqLJzhIrkXTnhOmpjsy9Ra5tJCg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793970583;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=X6/mgo3bJnOexQGtqEtD0bBToj88AnSS0+bSNsOPCKs=;
	b=UvuoMqvkSt0DDNi7anP2izm1WJ92aJVBCk0FVmYgx/cItupCPoebYVAhrCsvnrpvUOQ0
	 twOcowwQHBeSxbfj+Ymc+wUZMiHMlDkg6hlbEezwrnC96HKwnXjpwrWM9idiilWZti4HU
	 +1Eccql+psRAtSbQXszDf+O4NxxefFl1d48oH9IFxmDlRQM5wUqQ/ynDXJWQoLqlyu0Bg
	 Zuw3v6IWjD1oaXUo/zNjmyf+lCXQE1A4owQLgLEw9KSwBZdO1uPCtkz4FqzxoBzUeZSER
	 xVIsgJFNgR+hQgCtG0MnFEi0AoASSEFFbIt0ls1QujsgF9sp5RsMeI2DensQD3Gm3/g==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=L0JBG4yv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.26
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012026.outbound.protection.outlook.com
 [40.93.195.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 289B9F805F6
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2026 14:09:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 289B9F805F6
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=L0JBG4yv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UQ/9sAfFrYO5A0INMRFQzZoZ4lZtFEE7bapxXL87pEGL8w5zMWM5512a+HuKWUMFVO/+L60TodsShJzpiV3YCIklzvMOIUEcWhX+HUIgNr3j8zjLEVkgdrbmZ0CfTjKJwJIE1k3696c/NEVApvyBR7ZIvpcu1ROKN1+MEY+sG/Khgv/itqbYPmhEtCmWQZifVYWORfKPS3nFP17dCdMRnQfNm1UbaHkGBpJX0DU0qwKO0mA2xHcRYvFbHiE0m+yQm8fX97SW8uhfpa19qGKSVPidoJ1BiHCGp5ty40GC9qLK3JjAFlW1ly1x9s6nsNRKKVozMlg2bXIlH7K+moirFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzBpCKFbDYsh8blKc2pumbkoQfmuj4eqLhrPJrAx864=;
 b=aNMh/I/7ewEuiummPh0fsVqDkJhPjRSXMQs6UhNDqnUajDePVQWMDrWsnRZ8bvCkP8aMuMF84mx7LlAinEPpxFL1jfy4xxqu+o3Kjq127KnwGLGaQvwkZBAXU13k20XtF84XEuVR2TMaBJ9GyFZwqEqvZr9dHIbe3ihXWW0FcznVKMgwnYi0rBQNxrYbyiPA0cvoTxhUzr8ZYyiON7n7Dvn/UWkrVTZifporRNN129wdmzWFQWMtWSpzV+F0rEX3lvv3XNPgDfT/UqHTg78PBE9lTjyTzGTmujn395OoYae+OYapXlLDDqxq32ntpwyZllNaDNXpGAtx3YcNwjXAlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzBpCKFbDYsh8blKc2pumbkoQfmuj4eqLhrPJrAx864=;
 b=L0JBG4yvmUeKcV6r4vGlxa86S7uHkFu3NuD3+2FTlF2VkkZXbX9ymNP01Bv4Ik8sz7EIUxLLJZze3yKxMAZxwgUeL/KjVBeu4rvcBQbjiGGwJIr/QCCXbLQr6yuo0G3g8PwjpiYFLH1Nn4USeRgf9SK/9mWZQUt2klu8a7j/418=
Received: from CH2PR14CA0047.namprd14.prod.outlook.com (2603:10b6:610:56::27)
 by PH0PR12MB7789.namprd12.prod.outlook.com (2603:10b6:510:283::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 13:09:25 +0000
Received: from DM3PEPF000265B2.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::4e) by CH2PR14CA0047.outlook.office365.com
 (2603:10b6:610:56::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 13:09:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265B2.mail.protection.outlook.com (10.167.23.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 13:09:20 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 07:09:19 -0600
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Fri, 6 Nov 2026 07:09:15 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <pierre-louis.bossart@linux.dev>,
	<yung-chuan.liao@linux.intel.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<Syed.SabaKareem@amd.com>, <Mario.Limonciello@amd.com>,
	<Richard.Gong@amd.com>, <Vijendar.Mukunda@amd.com>, <Poojitha.N@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] ASoC: amd: acp: document PDM controller topology for
 ACP7.B/7.F
Date: Fri, 6 Nov 2026 18:37:29 +0530
Message-ID: <20261106130801.506026-3-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106130801.506026-1-Vijendar.Mukunda@amd.com>
References: <20261106130801.506026-1-Vijendar.Mukunda@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265B2:EE_|PH0PR12MB7789:EE_
X-MS-Office365-Filtering-Correlation-Id: 447c5988-cc4a-4554-d7b8-08df3c072bd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|18002099003|22082099003|10067099003|11063799006|261102123227099003|261021123027099003|261021121427099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: 
	90hZVLj5QPU+prihBvzTd6Dsa0byHXFW8BVgXdHdAH2FpFaD4ay9sbOOI5raS9rgb96gmNC4MdpSzATOjTqaAbKy+1W6QWBW4L96CkQhxDdx3DGMuU8I0p4rYe1hUUAEv65EW2AutRz6W5mFr6RZ4eSht+NzxVmXk1eqcPKiRBhphzqcyfNEfxA/XgQKQegQtEA9J81gugHbO681bP+z1hPvm8rB5Og7Hw845t0daDsS92zImK4bRGKZgNyPJjL50Rq/ilMJNa8GLO0u2ThXsRv0hs11a2doVkXT+1IoDmrM7mL+vmvvLduXFpxG7nGFGQOgV3GwXj4JpYboZBN7Pzk1NdiqTdE4d1zn4Q6e6Cel5GWF77Nf2ag53d9+wvbtxmMYRD1jyB6oURh3LqZiekvsSETs1N1wytjPJ4qP9+6DqcHRz/pnao0Ru4HmNUgApm+H4nIP5pIGpf85F2exiJHLFg1BAXjdIHwR1YYuF+FqP97XCYVNbdFHbiy3JCVZHjltIutEhDZJgIzGlUw+UfrDNch3QJ2Edo4zOXYHM/kniogA4IRkmDp0O0+TNPY3V15UpCVLtP5yIhflbXyR6n1Rl+So0PhfL4JP4YIbNc9X6xykz6IZssUCsd3azxyETMKtBJC74TWhEjW+nIVuWxZL1XyRa7lRs1z+BMHkbPG9nfFUoA+HGpf5DVWQVv22OssacW04ujUsrDhzbqDy8w==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(261102123227099003)(261021123027099003)(261021121427099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	KsUYw4867GS34Gt4VbTMJ2zHDUH2PBIIDeOznJn/sWWhaGonYjYeC/oXLa9P2aoJKaFwGj9ZaUos731GmIMOtD8Mir/VSE/Wtx3LqYNu9PMNSyjlMxn1AQ9SQFs5qXZV7xOJIa79jy2M0SP+F6W448aNA8NQjBWwtCk5yXPK47rYtQIFM0p7OWauETQUuwvlrYORldc3BdfaqkX1Z48K72K/sEYhq/DKA2u1NxDbkGEroqTYCoTkpUbe1lnsBOgm7AXSFwgS3OE+hTTAh5tDQaG2Jjwsw+9JenOm5vy/86HPWToT5xlz8wxssrnD/zEG4DCkm0WqUGf7eTwmtw3c/4+pE2Th+wRhpkY4UdxszPj9f2tsyNm6RxL3vpjk4aWuk2NoXSioDpwQc1snTf7Ven4UnI40MuN/nQaTDcfUdoVtOj96YmtF1MBCnUCIDh2I
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 13:09:20.6707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 447c5988-cc4a-4554-d7b8-08df3c072bd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DM3PEPF000265B2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7789
Message-ID-Hash: LFXOOZQVI3YIKXICNOUCBKUFJXUA74F3
X-Message-ID-Hash: LFXOOZQVI3YIKXICNOUCBKUFJXUA74F3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LFXOOZQVI3YIKXICNOUCBKUFJXUA74F3/>
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

