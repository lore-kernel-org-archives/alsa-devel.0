Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1BADC61DD3
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2026 03:39:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C3AA7601D7;
	Thu,  3 Sep 2026 05:39:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C3AA7601D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788406790;
	bh=DziRhQJV4R4d79dR+FNMTeDbdNVfNlPxv6Vl1/YfwWQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qhAzC0J4bpo+z9qDdSb8nWcd+8GwQmAyr+YWU240Fz8UZ5NzVVydWSpQzpuT3jWAe
	 uQeIQQl26IWDzVzefxtwO6wn3uWIeGNt9PHpkk1Wh/IONI2aplnFo6ZZDlFO4iA+1H
	 TCuJH8HmTNdHDd1l5L4ET1zrw7lLQyDziaZafDk8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4365EF805F1; Thu,  3 Sep 2026 05:39:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A097EF805EC;
	Thu,  3 Sep 2026 05:39:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 41BCDF805B3; Thu,  3 Sep 2026 05:39:05 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.58
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1788406741;
	b=GaGtg/42GgVVtGR3ZeWZw7YuHGB3SI/0ZXA23kLbkqXSoijXR6ShmU9evT1GmqoXeOX9
	 iIhtkd6vFSqN9ikCvCiS/BcbwyYzcdgtzRRNJn21bkmnISMidCxxr55hDVJ1ej+G+TzUT
	 OR20N8M2OgYVcvCi/TPVUYtpdYBSA+tL3AhXcfNuarbjPGXyqSFi8do08HRBohS2Li8m7
	 Z/U+kQ7664WaoVQF/EYgdDLWu6Fopd1Hhp9V71zgYeeh4bTajrhiLwsi4KbcxKJGkZ+/l
	 lU7rGX6TJLBw9m0vlEMPJaSaNyVxMDs2fmiSIaVWCDdgj9c/8Htc1KRCnd8DUAv1+Ew==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788406741;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=DziRhQJV4R4d79dR+FNMTeDbdNVfNlPxv6Vl1/YfwWQ=;
	b=MC1hFRG4q8dXsmtD1GzxWHK87TpxQkJ7JnG3tt3ThBLiMuJnZFV5cmao8MQ7ranPAFSw
	 5fDu4v4xboeEKBFA66VK3BV5CpQdQ0lugcz1SPLpmDQd0ipZkDF1PTh7YqXbTNknUln/F
	 rcT2VOmSd8aQUylRxENYZpwaTLLP5je0Q6zPiYT4HfzoHussiBQF9RLp3GbbVeoSj9suL
	 P+QAXig6dL4dCa8Fl9yejoAEmy6Ah2dFANYtAoQclIKKcnLIxGPohkkgpfWzJbvrSww8Z
	 GsiRxAGK4ff6NFhPats/9gfE1FLxorLa4QnDm13WL5kO2bICEM3MgkBAYwdoM+zbdPA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=S33C4ZwS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.58
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11012058.outbound.protection.outlook.com [52.101.126.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9DEB1F80568
	for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2026 05:38:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9DEB1F80568
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=S33C4ZwS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wT4z72/oHpsDFrT7856stzMQfWI7gPMYpFEtNkTqjsWNLLgssk01YBKYHUhpoCS2liW2W3xljYqDBnU1UJ43pXG4axp+rBr3O12pjsYVjLm7vXz/a2fKW3DsIuIqBbwip1AWyebcAtH9b+vRaawmMIWuUBGYebZBTMzlkjZyW9mbC9dnF1WD4sMgNxAJtuMgTYt6R35Vrl5Q/PGw/AFiLJwRPh8HLgZaTTQbaJHznwyteYe+qBUeBqpyvnP4Uu4NOx+o028XMewnRoMBpWqjLO9jQmSmeVetEaqioCbVMzPch3bnzghAXp6xRaSaOojBQ68klRZ0QGfOskCXe28i8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGwqWbUmqdL5t/OuYRWH/pbfxzlJpeAtdwpoMXRhuhY=;
 b=odVNc+E6cvPIy46JU1i7zeAwYgpykeYCkBtuSGTxwmhwcYaq5t25NHiornimUxJxTuVenQ909orSb+03RgZvBzBM97VxS9+MQ+ou5f6JqznCI2tqA1bb5f0oEblLwu0Y25rvE7wYKkw0QQK+nYxkae8mrHI2shLyiqLtlvz5R1Go1iahtGjD7lKm8PkaRUuPg75vk+GW2WGn1F56GooKp8SBT/sniBTqX/c3t1Bphs4qQszbscs4SF2I5mFUM2b15syqSfzoPh9Zx3x6A5o8rhwDRM05PCGhp+O7EykZpYvEbHHkUhe474YxeTXLH2Yt5yW94gTkLVkt3zHdD5dHJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGwqWbUmqdL5t/OuYRWH/pbfxzlJpeAtdwpoMXRhuhY=;
 b=S33C4ZwSwOSTyY2Q3J4IUGPBrtulvZw/E29jstWFoHxiTWnK0Z1uNjTZWbGO3HOy0OdhlUdg7YhtpDP7bVtSJxFP3aU4FKPFTcyawAs+OrTf/WEXNNFHxC+KVqSOK43/nMiaf5pukU9qQX15NyvzgmEMDFhZDMwwugR0PRxvvIpHm7vdSdGEGXRxopFDjZGQFiBa3GWiuP+t2qxDCkfBHsMmK61IoUxVXEM7oQrBntq8FOB3dhwAQah3V0ntvEZRZuUsVd5Hr3b9up+DMJFwJjV7mLqyZK0fxLI0gYvs0faCn0PNryfGkbmsC8CFJXZVJOlf491beWAy/3Roasyacw==
Received: from TY4P286CA0032.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:2b2::10)
 by OSQPR03MB8385.apcprd03.prod.outlook.com (2603:1096:604:283::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 03:38:51 +0000
Received: from TY2PEPF0000AB85.apcprd03.prod.outlook.com
 (2603:1096:405:2b2:cafe::13) by TY4P286CA0032.outlook.office365.com
 (2603:1096:405:2b2::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Thu, 3
 Sep 2026 03:38:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 TY2PEPF0000AB85.mail.protection.outlook.com (10.167.253.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 3 Sep 2026 03:38:51 +0000
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Thu, 3 Sep
 2026 11:38:49 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Thu, 3 Sep
 2026 11:38:49 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Thu, 3 Sep 2026 11:38:49 +0800
From: Neo Chang <YLCHANG2@nuvoton.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>, <linux-sound@vger.kernel.org>
CC: <perex@perex.cz>, <krzysztof.kozlowski@oss.qualcomm.com>,
	<linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<lkp@intel.com>, <neo.chang70@gmail.com>, <kchsu0@nuvoton.com>, Neo Chang
	<YLCHANG2@nuvoton.com>
Subject: [PATCH 2/2] ASoC: codecs: nau8360: Fix kernel-doc issues
Date: Thu, 3 Sep 2026 11:38:45 +0800
Message-ID: <20260903033845.76540-2-YLCHANG2@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260903033845.76540-1-YLCHANG2@nuvoton.com>
References: <20260903033845.76540-1-YLCHANG2@nuvoton.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB85:EE_|OSQPR03MB8385:EE_
X-MS-Office365-Filtering-Correlation-Id: d4033555-a811-462e-4fca-08df096cdef0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|10067099003|3023799007|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	LZe/+TuzVm7takwRS1AiBGOVsqvq6v8EhSutapKH590SD71NjwK3qpW99ThNPq4+RwkLpllGqsRspINIsJ5mwCc7y5owMd/L7f05RSmLp/P86qWofVDopz6Cl0+l8lgx9aUkvfLT9/n6g5AL8C/25G4AybF70RUERTU4xCXoPcw2arS7J6/cbqpQr5v9tzjAKJIaYVWZVSqV/gidsVpj8nOi4E0D9t8YRI4nf+KQl91tXHWV2mJhHkbQ+DZc2WD6ZHO4yVMuDqrBq65pJ8xFCQGTXBDFbXsIzq3uv1S0ji119qSyRmvbzmq0SUcUlofHWq69PpPmzUU0frxUrpWd29IWwE/dmMJ5rVXnELpneEA12c50LkEYyfKE/duaYqfuMzS7nJFzQmSreUhyqOWa1UKp66f8Dj2xJ4W/kVXBrbcA/tGZc+AnRhqNm73ODPup2REQq5nyuH1lxqu4XZFsWq/hoRtMooT6Gx1TEPWvDNP/pw62EsVmIHcu9Awk3tYeeDWjT73qR/n5M6SldTGsp78Y2q9npD6Rm5soFKEWo3G1cuYqhd10kVEAHo2LvQmQvkHz13vsMAqQXVrM8cC7I25xKeBljNs815VEYT1FHiAI9rX+MN5tfs0F3nfgIibLR4XR6B0uGbDyBJNdG0Z1Y9VaD3O8IQKMus2iJmiOMV5wyOhIm0rRqPc2h0WJXpCGI3DwOMkLd1i+QNRmWeGGMQ==
X-Forefront-Antispam-Report: 
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(10067099003)(3023799007)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	brP2Mj79qs8jIyKIbi9Gu1/EAyIFZORMbtBcud4kQBwl/B/Wwq9lqBaBnkCFGbUelNpcqhjxjwsvr7G7/QE1DI6NVdokBoq78Y28RmyshhZA+jyDlwPXZQFn8vzXgKg4u6QrUkWVygGUKkywqkuzZHegtwJch7RoHaSn/TJYcgWUmwj020AP0SxeYDb8wrcbAQ7OTLof+C7+iH8uN3AgsF0GC+2Gjzw2LLl0MckaNnG8D3paXSls4HsRPLvG9aF/zNmFy4skCnZ2O3FnJKM/LFgHdRske/EbQ9Z1AYl0kxf+pJKZuVpX11PDGP+6aoxYHwpHHtjF1lLu2SvzujUCtcdfBJkk2oH/n28gGbPp6q813c1cJ8ohn3vbRAnwrGGrJWX+bJb2PEIqJbfAbaAjLKhVL157Wo66dBgbaUmRueXQ3XzTKuZAbOBf2dnCx/Pr
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 03:38:51.0252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 d4033555-a811-462e-4fca-08df096cdef0
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	TY2PEPF0000AB85.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8385
Message-ID-Hash: PWSJYGBSQJXGUT2NUULIZDXVUMEQCTR2
X-Message-ID-Hash: PWSJYGBSQJXGUT2NUULIZDXVUMEQCTR2
X-MailFrom: YLCHANG2@nuvoton.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PWSJYGBSQJXGUT2NUULIZDXVUMEQCTR2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Fix various warnings reported by the kernel test robot:
Correct kernel-doc formatting and warnings.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202609021537.D6X4Dz93-lkp@intel.com/
Signed-off-by: Neo Chang <YLCHANG2@nuvoton.com>
---
 sound/soc/codecs/nau8360-dsp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/nau8360-dsp.c b/sound/soc/codecs/nau8360-dsp.c
index 41afccbea2c0..2e5b61bfc303 100644
--- a/sound/soc/codecs/nau8360-dsp.c
+++ b/sound/soc/codecs/nau8360-dsp.c
@@ -39,7 +39,7 @@ static int nau8360_dsp_chan_kcs_setup(struct snd_soc_component *cp,
 		.cmd_id = _id, \
 	}
 
-/**
+/*
  * Preamble Fragment Masks:
  * FIELD           | BITS   | SHIFT | MASK | DETAILS
  * ----------------|--------|-------|------|---------------------------------
@@ -53,7 +53,7 @@ static int nau8360_dsp_chan_kcs_setup(struct snd_soc_component *cp,
 #define NAU8360_HOST_LEN_LOW_MASK	GENMASK(17, 16)
 #define NAU8360_HOST_PREAMBLE_MASK	GENMASK(15, 0)
 
-/**
+/*
  * Payload Fragment Masks:
  * FIELD           | BITS   | SHIFT | MASK | DETAILS
  * ----------------|--------|-------|------|---------------------------------
@@ -63,7 +63,7 @@ static int nau8360_dsp_chan_kcs_setup(struct snd_soc_component *cp,
 #define NAU8360_HOST_PARAM_SIZE_MASK	GENMASK(31, 16)
 #define NAU8360_HOST_PARAM_OFFSET_MASK	GENMASK(15, 0)
 
-/**
+/*
  * Trailing Fragment Masks:
  * FIELD           | BITS   | SHIFT | MASK | DETAILS
  * ----------------|--------|-------|------|---------------------------------
@@ -76,7 +76,7 @@ static int nau8360_dsp_chan_kcs_setup(struct snd_soc_component *cp,
 #define NAU8360_TRAIL_PAD_MASK		GENMASK(13, 12)
 #define NAU8360_TRAIL_LEN_HIGH_MASK	GENMASK(15, 14)
 
-/**
+/*
  * Reply Preamble Masks:
  * FIELD           | BITS   | SHIFT | MASK | DETAILS
  * ----------------|--------|-------|------|---------------------------------
@@ -364,7 +364,7 @@ static int nau8360_reply_from_dsp(struct snd_soc_component *cp,
 /**
  * nau8360_send_dsp_command - Send command to DSP
  *
- * @component:  component to register
+ * @cp:  component to register
  * @cmd_id:  DSP supported command ID
  * @kcs_setup: KCS setup structure
  * @dsp_addr: DSP address
@@ -454,7 +454,7 @@ static inline int nau8360_send_dsp_broadcast(struct snd_soc_component *cp, int c
 /**
  * nau8360_dsp_kcs_setup - Send KCS setup command to DSP
  *
- * @component:  component to register
+ * @cp:  component to register
  * @offset: address offset relative to KCS start
  * @size: size of data writen to KCS
  * @data: data writen to KCS setup
-- 
2.25.1

