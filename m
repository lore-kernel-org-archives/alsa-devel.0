Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6763FC61DD3
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Sep 2026 02:46:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DBC7D6021B;
	Fri,  4 Sep 2026 04:46:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DBC7D6021B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788489991;
	bh=MyvBh1oD0Br8rukTlZHllGS28v2iTBrN9rFdmtIc+yk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=afUdEbK81OnDwwfr5DuwBVFsXZf/w64DQloPrAJK0B51FH2bKbJT8z46Sb3dgfyDU
	 li35uBl+SeQbniKncneqgnRKV7Ak7MQmpMvysYLXUHTkaJQhZDvvhZY9EhZv/osQ/8
	 +Yb01DHL8ka8tgn8yP/UPEZjkRKpuYkxqTNmJoek=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5A96DF80649; Fri,  4 Sep 2026 04:45:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9A78BF80671;
	Fri,  4 Sep 2026 04:45:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 097E2F802BE; Fri,  4 Sep 2026 04:45:19 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.70
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1788489912;
	b=gX6hbd27QKU99DkFPsLq4xP0TnCdkI6eGv4UESb9NSqzx60XG6tWDnnPtjlhWw4YySRn
	 79DwHa4FVTQZXS6a8Vzi78qZMExVrO/PiHSCCqc/bPkVYnJTodaQqc+Ce8TOP+0VN5eUd
	 MSRewGpRXc3J9MQeNUTkqTjXYkz6ghBGoJopAbQlcjppcN5R/dUjQf2pivfGQMSN0lhUG
	 hBwkPtzzQ0fiaNMV94tnZH9EmTwwUbZ94XJCbPxsZJKKrPj1Vnenrm76waDqZcHzX+U8O
	 2fiYk55UFRsT2z8vjmCKvW0t4B+Jz2iUeKlAx7QbXx3ztUHoh/9AsbFEpPhp7La8CYw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788489912;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=MyvBh1oD0Br8rukTlZHllGS28v2iTBrN9rFdmtIc+yk=;
	b=pmxAs2XXooezyHbPGhsBb1gB31dd0W5EMURTlFOOGxVcgBJAsbTFIsX7x46Gpknyb5zl
	 JU9xZECh9xmd/IUIu1OviSln7Q9gdMtqsjUrP8QmgEopqoxtlwP8iEkUcuNCng6PUuAMU
	 sBw/Gupw1zdw0mvlmr8QjhlwnubhdNsZvTsc+wvn8SX5FYUSgJ1TdEjaRYve8g/NVv0UC
	 HUUMY53y8EwhYimg7DjcbUfzWmo68ZJhfj6R9C6jSKo0puNaciaTLP2GtZKm+ECef/grv
	 yNncXGVJ7rW0T3Hf9J2o1zRORcgXkAL4f25G7+nmqlhaRhaoyKmF++e7qUaOIMq4QCA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=GEQidIeP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.70
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11012070.outbound.protection.outlook.com [52.101.126.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CD696F8049C
	for <alsa-devel@alsa-project.org>; Fri,  4 Sep 2026 04:45:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CD696F8049C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=GEQidIeP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3BgXPe31ODyUFsElk3vAyI50npePXWIQAgCAS9JQy0oGOvzfgl8RnKVjrpjiFFj/skV2R2brJ9ay0hZ9M+7li9lFyl4c4vYSqqo07lSCo4MsCEssSG1K+BN3PTkaiNHuK0TkpoLU5Oclptdi8bvwmkueoYWeCY2keYmGdeALM853zpeTNpwNmUEyXhPmo13qqitvuqqvEMd/ZR0InvGAfym36Syv1jmaCYeOhVA/jJlmXAMo7DldJCcyVKestZk8dwTsxN4wzyJoOz8og5VASmKylNh46ZcG0pQSqkzsU669jBtCvcjxi1rylPucibjUHZtaXI63DG2wiLpcJ8EVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rFK36kMw2U4sWlG+vfhHAzJ2dK6rFCSBIllSD8D0/I=;
 b=g1KgrGx5H4wazp62f7T4ZJ0OkYxPLrnkxdPHrI435YQBNDOhJMS91y0tQ9JNsDLx3i1PHNQDJBOYR7UKel07WpvgjcIblcklRt5k/O4ger4HRCA/UBjU+Dxht8ujDs49Z+n2Bx1hwiTxEkAElTgY6zBPsewNdfJwa4jTeI4rDhLROc1icdFx/Zsvnz9R07TFePS90yGc+NlzpzD2AjI7OV6EueZhPTfEd5Vo3aqsCdLWiBhIRl1qsR8X+xO6aTB8t1P985skniis9gjmErBGtPMTiGBxxSi3o/FXroCoQP/6Va06RqtPSob9mA7ouS2yJuilo02Cp6XbVbvphtOuPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rFK36kMw2U4sWlG+vfhHAzJ2dK6rFCSBIllSD8D0/I=;
 b=GEQidIeP8QGccoLVh9CInq9hN/nLXIT0sWelkmSzphWBls6Pt7JWEyaha3LDVyUhvviFb+ADfyr3aBowZ+ch6DLrQqOOW5lp7SBVhe0R0AOvBXK0Bnce/AmbM/JHjlGCWRbhm99sub/TFeH/h16QTtaK64ygjdnHWx9G+nEJuGekt4T+xwanssgfx0voBncYozm1LGZ5W3gVEzjFlm4MEDIKRZ1TJ96NUy/CBT4flDe4W3fdKWPBdCLYwzldlmkvT2JDME8+/a7hhB3jpo4I/mUH8SFYWLY27BeOzlOT8Zpes8pzXp76NjwTUNCA/DTpm78w+ajXxN83fZvuDh3Mug==
Received: from JH0PR01CA0146.apcprd01.prod.exchangelabs.com
 (2603:1096:990:5b::14) by TYUPR03MB7162.apcprd03.prod.outlook.com
 (2603:1096:400:346::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 02:45:01 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:990:5b:cafe::4a) by JH0PR01CA0146.outlook.office365.com
 (2603:1096:990:5b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 02:45:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 02:45:00 +0000
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Fri, 4 Sep
 2026 10:44:58 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Fri, 4 Sep
 2026 10:44:57 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Fri, 4 Sep 2026 10:44:57 +0800
From: Neo Chang <YLCHANG2@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <perex@perex.cz>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<neo.chang70@gmail.com>, <kchsu0@nuvoton.com>, <sjlin0@nuvoton.com>, "Neo
 Chang" <YLCHANG2@nuvoton.com>
Subject: [PATCH 1/2] ASoC: codecs: nau8360: Set DAC path to bypass mode when
 DSP firmware load fails
Date: Fri, 4 Sep 2026 10:44:55 +0800
Message-ID: <20260904024456.193528-2-YLCHANG2@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260904024456.193528-1-YLCHANG2@nuvoton.com>
References: <20260904024456.193528-1-YLCHANG2@nuvoton.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|TYUPR03MB7162:EE_
X-MS-Office365-Filtering-Correlation-Id: 40e1ccce-0b1e-4bf9-54c2-08df0a2e83fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|10067099003|11063799006|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	qI735DaghGLrlFckB4MeKIDxrs1QmEZ8RUjplGMZ1nvHGx8CG2QJRLTSyVsvdw++80ZTZ6HVMEYeUFgKAuANbrwVffNgBscFFAYwojy8AJ1QAiaGx2UAM4KYx2Y9Ai5vNH4MdfRmv+sdWsNFybvpy+EMFlQqHUIaRP1XivxvyTaNHjTZjJaQRmumf3vt6n+yOy6yuue4fY3y1rkxFJjo4OkN0pN3KtrJhuMx7Km26aMJXrHszPJPjhg/jokk0aXyK9VN9DfBTUJsbgM09gMQzHrbR7ct+V0Wh52GyuhCgoaHf7ozCR8KFz47juYn1shPGZd+Tr9fAIbZ5tKXvQaXmf3n/1hXhbdrVkDnhBLPwqvgrJDUtD6Gl92eAp7CX2Fgj4Pwy3/hutFGccWy4FtqTdzfEe27OtEfAPGwZwYPhyHA8CG4rpXwmRYrbF4d0fT0zX8L0+7YP7FWF2JbLuOJ9pCRzEee+64nCIoD+7H3QVJAsTwR55gD8uVTtqWDuiCPg3ugepHinzIxPDjvJWB2dYs4vbs+DvesNMwztNyo1Uxi32n6J7Flfx1/NnF/qrpW7J1tmbDp1OEAs59DmRjPEAXkgwgS3CYBm9u0ztUeKqXSBYl3f5Ca9YvGGECoqBV6G7iGOrJyW33Zwsu8WhcaVemCHPrVn6vCcqOK5I/Vs5hJM9Bp5T01BS2Hks7Apl14UCUCObEsrKplAZwg3dBtmw==
X-Forefront-Antispam-Report: 
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(10067099003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	ewDMe6wFNEg5fPJfy2TkVmVfI3j0gs5cMJxhfyps1uq/H5HdSFzmV0HfrxOgUxiqoFbyI+I6e+PZKFO91BIEqifXMS/2Ia5rEyvyKSRhtQxvhVXmrAa2zh/eZ30giapeXJUQ2tR+auLznN5zZEzcHa77U7r4Ah/5JTJKkvFqfAJrisSmIDdILv+O86xtjku2LEdboQv0Xc0d7yI8Kh0wdFtbkaHupjMeQ2Umfs8Eb9Mrfg29eAXj9JRBls/Pxt0FnFazWfHvBT8dXnhjJN2K3q6XX4PUDjp3SfND5cgrEoQnrb+Dm7R/t6iaV1OhlyfY5x9igA4HHtX5yxuuTa8Q/rBCINRMBj+xR7kL9+aQdLwcLNJOfgBo4d1MogxcZdUD6JKNF5BHHh/RgbMGU1KUpYTIpiMXqErVuDz2lhCwFkjeO+WldeZF58dKb39m8P31
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 02:45:00.7610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 40e1ccce-0b1e-4bf9-54c2-08df0a2e83fe
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7162
Message-ID-Hash: MZN5Q7O675ORVBL7VOYYCWAYT56G4DGD
X-Message-ID-Hash: MZN5Q7O675ORVBL7VOYYCWAYT56G4DGD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MZN5Q7O675ORVBL7VOYYCWAYT56G4DGD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Automatically route the DAC path to bypass mode if DSP firmware fails
to load, ensuring basic audio playback remains functional.

Signed-off-by: Neo Chang <YLCHANG2@nuvoton.com>
---
 sound/soc/codecs/nau8360.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/nau8360.c b/sound/soc/codecs/nau8360.c
index d7af2dffb749..b3cf207eea86 100644
--- a/sound/soc/codecs/nau8360.c
+++ b/sound/soc/codecs/nau8360.c
@@ -1702,6 +1702,7 @@ static void nau8360_load_fw_work(struct work_struct *work)
 	if (ret) {
 		dev_err(nau8360->dev, "Failed to initialize DSP: %d\n", ret);
 		nau8360_dsp_enable(nau8360->regmap, false);
+		snd_soc_component_write(cp, NAU8360_R12_PATH_CTRL, NAU8360_DAC_SEL_BYP);
 		return;
 	}
 	nau8360->load_fw_done = true;
-- 
2.25.1

