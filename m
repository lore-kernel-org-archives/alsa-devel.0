Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC22C61DD3
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2026 03:40:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CBBAC601D0;
	Thu,  3 Sep 2026 05:40:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CBBAC601D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788406810;
	bh=RrJYjx9t7wBA9NVou8n4AwUEjWgUypBAq/RrQ1B3aDs=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=BFpMY2dMuIqP3t4ypurD667lUemd1lN+Fd4UyCY/nfVLG41yXR9b0pYN/1m9KzNEa
	 QjcymKIJtZSgpIT0yrKZmH2Qx1rbKUQT1GpfJdOAhaZTVsT1PBBsogZA22Hk32tObv
	 0va83ay/EDLc6coHNKHsaFtH573oVgLPpTcf1jRM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A2130F8060B; Thu,  3 Sep 2026 05:39:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5E2FCF80618;
	Thu,  3 Sep 2026 05:39:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 500BDF805A8; Thu,  3 Sep 2026 05:39:06 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.17
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1788406741;
	b=fUf8JSJebDCYE25JuIXOm4/YRIeI6RM0Ho0/M81oUW8h5uTfdOFKtyeoZRQlc+NsLOsW
	 chuzvMOmPz3DydJiVchcQVBaV7QaeVgB9FQ+e7iBoJPRPfdsDm37kp+XQUNozyp/IASF8
	 WfZm0kbw6YvuSfS1bRwAzz5GcRJLOwuy2N3gMojbTj3ANgbyaXRhI7MbLZ4rDS7ij2aKA
	 U68p2uaPqXE12llpP963PrJGwwExoKHT3undMALOig1V/w5QGMWSWDNTZp3/MnGTJQCHZ
	 raJv3lSKNgUugQ1jBHkBn8LCeL4gGg0XbCW7qyqK3IwMTkbZEZeBWSXrR++KUnIkvXA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788406741;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=RrJYjx9t7wBA9NVou8n4AwUEjWgUypBAq/RrQ1B3aDs=;
	b=VAJ5v+j3fDSPf9AOfiWPG/5lBNbWbJuRVkhMjs494tI4iGYSNXtTaUmpxZ2kmkIHk23O
	 97zOF7YuRdyCQNr5sGGU4IHFN8FLl5k9uC+eEOeTwh+V9+94RUATlpVBKZ9tNc0jsGJ6e
	 RhSwnxWwxzb2VIlFiA5T17KbOG17RXM7ASBb0/3xw47Fb1Mv8nE7LDmIN43SWsF58eSJG
	 VQGBWmNjfmNBIm38CEFQonZWv7+hiH5o5CsdKiVIwE/rjWTSyEPpPMBXtrXYPWEXBgiZk
	 R0Ta+AqadksRDvzt4iIC4bcweGyp6AWFVmAb5HDAllyCseaear+K2MPvY7GnaE6W3kQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=nQ3gCst8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.17
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11013017.outbound.protection.outlook.com
 [40.107.44.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 248B8F80149
	for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2026 05:38:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 248B8F80149
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=nQ3gCst8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJQXvcXWjH0wRLNorVI5hhZ/pcVqsVMCsxtRFUjDZNnmHRDvYYoTb1DHfKv6EfcAyu1Ikmw0e3ctEb0pKEI3Z3NGvOpzHw5qOh3/v+JPFveOZ1eMUNt4NRlu2GuaS5isOYuItN8VL5nbAwRn+ALPkPfaaBDWepwUlxHJ6rL8bGSEh9oK56FHiNwncsO9WBy6IJ2w12fC6GzZXTvEYCVDmqQQ+7yxxOLhh8XhvY8htEp/ZJCeG/AQlHsHQAXo3t7SYiiWfVEr+hp29f2mzwcJkRASVMNHUxXWKAXCisDL6E6iwyAvauxfAtc2nURS7yprY/4BfGrMKjzny9Mi2DrxMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hop0qcppkvAfUPAft1Kaprx56rb41kyffZBt8FyywXA=;
 b=bhnvYjtTuhVD/TldM5d0e9rgA7XTIg374p4nyoIyH6lfCPYQ6yGGX0BCgUu41Dg/TxrBsJ/v0n0kPJSiO4FhhNR5DYEaStyZEC3oBGTYrsBn0EUDTNKOjwiNVNeFIlEgQr5Swrh+s3Bwzt9XIXj3bPfZf++rmJWASFF5/7zKXoIda6fig4fkQpShEieZkGF1Ci0IiwHyMfKDarqdnyeT6AbJiuI0rMTWI39M7sm10j8mAQR4i7rRS1GdMJipjKUjCgTmkA9t4xds5S2b/gCvk40RvgMoyBMxIPTlSjhKdg4acBH4Tjs3LDuxfGT6p8zZsuq+Mtzmm/fu/gBVIVnpkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hop0qcppkvAfUPAft1Kaprx56rb41kyffZBt8FyywXA=;
 b=nQ3gCst8sW7jPSaVPyDVm8WA6hoVYtwMQNHYumHr7Jl+pNScL7NAosu5u4+EQpTqpxOsOwcki15of9d7MFwYl6M9tBXOovEZqnrFFaWLrUfbVUDazkw6dH1XnHN8d1B81+SG7/fe/4hSNYSRE+wsS/ueKek0GNsD1ebB7Jt5jRkAHbakbLva4EJVXuT4/vK9pUDNlozq2wPLKtsrgQFynYPqU5KHSjeXzr1IerqBqWAUzOqcnNq+0iWsKOWDu2I2z+Tf+/zYMO8sSyPyrwkcCswSLOz/PAS8SYUCXDp+1ZkYM6w4AnTznYudzmMSPmDrkAPe4DKI0a3M6ewu+SNq1A==
Received: from TYWPR01CA0013.jpnprd01.prod.outlook.com (2603:1096:400:a9::18)
 by KUYPR03MB10582.apcprd03.prod.outlook.com (2603:1096:d10:74::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 03:38:49 +0000
Received: from TY2PEPF0000AB87.apcprd03.prod.outlook.com
 (2603:1096:400:a9:cafe::19) by TYWPR01CA0013.outlook.office365.com
 (2603:1096:400:a9::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Thu, 3
 Sep 2026 03:38:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS02.nuvoton.com; pr=C
Received: from NTHCCAS02.nuvoton.com (175.98.123.7) by
 TY2PEPF0000AB87.mail.protection.outlook.com (10.167.253.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 3 Sep 2026 03:38:49 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Thu, 3 Sep
 2026 11:38:47 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Thu, 3 Sep 2026 11:38:47 +0800
From: Neo Chang <YLCHANG2@nuvoton.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>, <linux-sound@vger.kernel.org>
CC: <perex@perex.cz>, <krzysztof.kozlowski@oss.qualcomm.com>,
	<linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<lkp@intel.com>, <neo.chang70@gmail.com>, <kchsu0@nuvoton.com>, Neo Chang
	<YLCHANG2@nuvoton.com>
Subject: [PATCH 1/2] ASoC: codecs: nau8360: Fix static declarations and
 endianness
Date: Thu, 3 Sep 2026 11:38:44 +0800
Message-ID: <20260903033845.76540-1-YLCHANG2@nuvoton.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB87:EE_|KUYPR03MB10582:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d6f916e-1540-409f-a4e8-08df096cddd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|10067099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	ip15ZMke3aX0aNLyBE8vxeVHe/gnULg9kZID9Rk6LFYssCGjlnfJZY3Gvtvsln2GCkvdg4xB28UTvgF/2Vjl4XNjuF0EL+wAO8Yvg7guNL+vnbUJPRdD+XDO+cFpg+PyJ7rV6sEQc8ITCU+2LtXE5phijvpFEFnl97KwRNRgPe56ArA8Nu+m/3TtFQoYCAKz/nR+SuFNJV/XTb6UzCi7vOcqA8CNADxeooz9HXWwCBNlqBKIfXXDYjmBsOpeaYMr7bEQFJTjN8nJsiwnqg1il6juI/m4Eh+WXJRZsFakIITZdKTdTt5E6mCvRBXqffPi7z9RGfS6e2PWo83qsmsZ44cuU9XB4MwXMxoYJCa4mObrNO80PwqDf7nnTdnhB1JxbnlFuay5zzBTP+Xpa4tjS1Adc2qazC0m7RDB9D8DOj+PMuLl5oOy1yMPZBL2EcvcVbK3NfJ+jttAT6d1pnjgOVoqMdpExGQVKtFUACSH13UWqx63EYJ9n9J7zVHUiQ1CpIfgzFqm2Q/R7BXWI4Luxt2HC/ioFfMNcs+MQxA3OdVxC4Ipdu235a+OYwJhkLHdWEa+svCwrWFPiQxKmbeIckaqV86H4LjPwtCGrcQxsa6wkYQiH/cenfbV3KFtjqsJCpTTTfHMN0N3w7K5Mx0Gtc48uR79NGz6ulPD33x/XF29lMy4WQbOlwKEBzilNLI+17+xrjoXnpPVCNw2FIHOdg==
X-Forefront-Antispam-Report: 
	CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS02.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(10067099003)(56012099006)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	CkqCVrupOFqn0uEWj+KPV5w9mah2p3vC5cKhi7pyOEN9yVx1NfmFlNjJdO4yddPKwurSdTexevYfpfrOaDqPJAshvoqxd3YOD7tYPoX1tAqQJIxusEiTd41GTPigE+SKWlDA0CuhZebtwKo96L5TFm62rq8ubBXEgsrxFcmLqE0JH9pj5BFJsCB88bSW2QfGMZsNSD3mUMRBQaFAg/d96YrAMAjfmc8VOd0lKWSXGGUBzu87ojSbAXrnzdohIi2xbDpfypQVM9p2Y50JaCZraIVbNWXsYz79dst+gqw9CVPXXnLuB5h1FGpyphifjMoW+HGyw9u74v0ujkjaD+gTvPVLkluACyFPYUNVTljzaB2Lawkc+r8LdEvABTxUhmu7u6xD21w5LEwxGhzO29xtkcmplGPaGJ6aKBkTp84vtwh6vJbzj21U7NrUozQtvmsh
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 03:38:49.1738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 7d6f916e-1540-409f-a4e8-08df096cddd1
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS02.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	TY2PEPF0000AB87.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR03MB10582
Message-ID-Hash: SCY6ULNHM3OTTKKXJ7HGNYXADPGUPC3D
X-Message-ID-Hash: SCY6ULNHM3OTTKKXJ7HGNYXADPGUPC3D
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SCY6ULNHM3OTTKKXJ7HGNYXADPGUPC3D/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Fix warnings reported by the kernel test robot:
1. Make the 'nau8360_dsp_addr' array static to resolve namespace pollution.
2. Change the variable type to '__be16' to fix the incorrect type.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202609021121.a4mHPAyZ-lkp@intel.com/
Signed-off-by: Neo Chang <YLCHANG2@nuvoton.com>
---
 sound/soc/codecs/nau8360-dsp.c | 2 +-
 sound/soc/codecs/nau8360.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/nau8360-dsp.c b/sound/soc/codecs/nau8360-dsp.c
index 2d6bc2962229..41afccbea2c0 100644
--- a/sound/soc/codecs/nau8360-dsp.c
+++ b/sound/soc/codecs/nau8360-dsp.c
@@ -20,7 +20,7 @@
 #include "nau8360.h"
 
 #define NAU8360_DSP_IDLE_RETRY 10
-const unsigned short nau8360_dsp_addr[NAU8360_DSP_FW_NUM] = {
+static const unsigned short nau8360_dsp_addr[NAU8360_DSP_FW_NUM] = {
 	NAU8360_RF000_DSP_COMM, NAU8360_RF002_DSP_COMM };
 
 static int nau8360_dsp_chan_kcs_setup(struct snd_soc_component *cp,
diff --git a/sound/soc/codecs/nau8360.c b/sound/soc/codecs/nau8360.c
index d7af2dffb749..802806d92fc4 100644
--- a/sound/soc/codecs/nau8360.c
+++ b/sound/soc/codecs/nau8360.c
@@ -409,7 +409,7 @@ static int nau8360_peq_coeff_get(struct snd_kcontrol *kcontrol,
 	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(cp);
 	struct soc_bytes_ext *params = (void *)kcontrol->private_value;
 	int i, value, reg, ret = 0;
-	u16 *val = (u16 *)ucontrol->value.bytes.data;
+	__be16 *val = (__be16 *)ucontrol->value.bytes.data;
 
 	/* Use the DAPM lock to prevent race conditions during DAPM power-up
 	 * state transitions, and check component active status to prohibit
-- 
2.25.1

