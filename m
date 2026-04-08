Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4439FD5F79
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Apr 2026 05:27:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D1B79601F8;
	Wed,  8 Apr 2026 07:27:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D1B79601F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775626067;
	bh=2i3xkMWAlO3FzKUOuEJZyOxzrRdKJ2l63IGTxkbHpa8=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=W2YDsErIfjmR8DeGe28ycofzZ7ZAIDeItAvHptCymTvKLmJmWBtGyfEOD7K14rCDP
	 1/RYsLjaVpGjs8xgw6u/uNtsc3EdSA3YGUAOCQo8TgqIH5jNlyiebPDZbeNwQIPz4E
	 C9a09LIa/OgRhTs42cMtJiYlYhvk/n2KxeYXMwJw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CD5C9F805ED; Wed,  8 Apr 2026 07:27:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2386DF805ED;
	Wed,  8 Apr 2026 07:27:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A49B7F804CF; Wed,  8 Apr 2026 07:27:00 +0200 (CEST)
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazon11012001.outbound.protection.outlook.com [40.107.75.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 27CEBF8024C
	for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2026 07:26:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 27CEBF8024C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=kqj/nHfM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yaGhqFCL9j3Px1lE6v2zzNvewJEDIskghUUxr9+Md2tbjjor5g4Yl3pEEBdBO9YtgDvBu58Q64/tDzByavj8NDGACKUQcNd+/zSmNUjX0OsedO4NM+vTPlfvNq5sCBNj3MaUIYAxKx8+T17lr6jf3seZdwXnl+bdz03WO83blAGrNFVMfUN3CrIapbAdxEdmoBr9oSyYDiqwa65c8Ao30dYBntBoCxXp1SmN1CjNgDy3yT7jt9USOLO/TMxsEoZ17IHZ1Kjkfz1ryuIQdhBlLpf0a2NlipyaNxexQ2cOyRZM+L2rVZvW2T1mGa46C64on9w1QEc/MfEP0fj6Naq3Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wo3thyiIaYV7FOCeUCGfcSfNViTrLYgJ/JBmtkhUqZQ=;
 b=Az3ZZCsdIYwGa2/ohlQ7pNovZtQafstnPeWC+ZG/ss9VyxPfi79eTbyZYslkDHBb1z/5TYkgvHF73k7qwyaiLt4x2N/KkPdKhMMYb9Fh4N+8jKvNa4gK99OG4vJEBygHe170dN26hsDMiDGvM1XVrT1VoEqnz2b5dO3cLRdQfHp7tmHPRIpCmAglMykxt1qIkJtpGH4pRG8e5c8RTFRjko+TYlOjb2Xp+aowy+mA670Hh+fsVkfv07STpmWTVZq2Ae7EqsGqPHPWSez3mry59pslt8lDJw1Z6UJ0B7vlTB0zSBZQlx2NQSD2X5ZIR7/p7aywmAR8c2rsl/BRTYc5mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wo3thyiIaYV7FOCeUCGfcSfNViTrLYgJ/JBmtkhUqZQ=;
 b=kqj/nHfMG/xLBgt//6iI3YrCpHgjb1H2q6RpAN/tI4cTCuahfwf25eJzxmbeWCm0oNPJdscBuJxyK2WZdSi/2Yc0Nbxy6wo5ezZZB5hN4NsB9fmu5/m4ZwJEq0NGbtJr/PIfHcyrIlNfpyvnkDeKiG47XVyN2g2c8u8JvlDE+xp4eFr9/ZV8DUbNJiF1cxPXVc3+n85bmMs+rMnSIzdCVAWIXRc1vcbgM+Y9ja9ZhyRNrQdxKy961Z/6Cf++6Iz4U84lieWH9kQOz3azKBYe4kCFSjHWNr95vAUhkr04CLQqj+RMjvUFW/xI7dnBoQZUa4INQqRFCZUt2o75YQt+3w==
Received: from TYCPR01CA0055.jpnprd01.prod.outlook.com (2603:1096:405:2::19)
 by TYSPR03MB8735.apcprd03.prod.outlook.com (2603:1096:405:62::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Wed, 8 Apr
 2026 05:26:45 +0000
Received: from TY2PEPF0000AB84.apcprd03.prod.outlook.com
 (2603:1096:405:2:cafe::92) by TYCPR01CA0055.outlook.office365.com
 (2603:1096:405:2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.33 via Frontend Transport; Wed,
 8 Apr 2026 05:26:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 TY2PEPF0000AB84.mail.protection.outlook.com (10.167.253.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 05:26:45 +0000
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Wed, 8 Apr
 2026 13:26:44 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Wed, 8 Apr
 2026 13:26:43 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Wed, 8 Apr 2026 13:26:43 +0800
From: Neo Chang <YLCHANG2@nuvoton.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>, <linux-sound@vger.kernel.org>
CC: <perex@perex.cz>, <tiwai@suse.com>,
	<krzysztof.kozlowski@oss.qualcomm.com>, <dan.carpenter@linaro.org>,
	<linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<neo.chang70@gmail.com>, <kchsu0@nuvoton.com>, Neo Chang
	<YLCHANG2@nuvoton.com>
Subject: [PATCH] ASoC: nau8325: Add software reset during probe
Date: Wed, 8 Apr 2026 13:26:39 +0800
Message-ID: <20260408052639.187149-1-YLCHANG2@nuvoton.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB84:EE_|TYSPR03MB8735:EE_
X-MS-Office365-Filtering-Correlation-Id: bcee5f10-16e4-4d0a-80cc-08de952f6ce6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|7416014|36860700016|82310400026|376014|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	v7RtGNrTeTA01aFGWWPfqvBGySTtizVlBFtSbaFR96T5wjqa6uKTVf0RdtEdMX7YyLU7oEsv0XwBaDUfNJ0e5C56T4fBlgT1Yk3U30+w6NGDdvQzRDPsbVL++HLIXPgiRXG5mAxLQrVyd/j9hWMZPEhRMkynORPad9R7boLnXqhzhjvl8ObB1Xq4FIW3R5VIYCeO2RZtpIr5SF3wD7cM00L5UDqss8QgW+C7JjO+I+2b+IDJHUx1fwO3Im7Il3NwLcQ5Ilu+gz2IDkV4PeGXFjfWwgjxgaKfWtfF0VhtN/Nxq4up/AMqhEEMJV5iAiPbs3a2zaBJszJGc8gAREHzVq9IILN4v9rIgg2fF7j65NT/j4CDsRh3v9xKRW6mNuZRqxNDODBAAUhqsXLsxV4jyz21gSFLef1fib98p0RHoXe8s+oHSIvn1hP4XxYe6ZgYz6XR95M3OFXXBohTcTmGU66qbWSpaI10rJpR4IgUPemm0ZrokD1TRvHQEd730t+Ks9vZ3W3PZdm1ThW/R9GQGJy6dmN72s+VXMj5oN42XgEOi5tE7k6HhBhYnUe6d4BX6AIjHCSOn0nIzJw/SIe1Td6m8b7CLNsgtsEgHnCPKOLiTmGQaa4VrZWKOiVSfvrcy5gwR3GwqaRwnbbu2AefxEakbR/FywRkGP6qx5EdVv1B08Ff76U4nJdAcfim2Zc65XaT77o98B/0+Oi5bLWppP08uu+SzggOcq7u/Cnzthop76PK5rhKFuZSOvw5ORrFdnmjnln2iiWVSOX/1zZ1Tw==
X-Forefront-Antispam-Report: 
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	eRzoo/7JwBDbU2v5PhH+ydu1rOeySeWLbus1VwJWCvvJopmmIyDwB8gTZYsELy2VtiWuMd72y7v6PRrtdkdFJ2sfnD1PmTrk8rcCSmUVe2IxBzkZDHLSTZVRZnsqMvS9ElPFO7UCSfTbhJVIslqSGRmy2CoGEqlhLvKaZdwqVPXtEIk7ss/qO0CPWVSbE6UZWbUHpqP0rsg+GF3vaBsdXqvCNaqtB/f7teaZdmGRVzGEw4bcZy6Zbt0U/IzmNW8VjGj5VtrVxgsfGy80I3++Vkb5m/SszPMdHGLleKIHfx8kIJgTcQYgOqFYEaSIl9qeGb/7IHey3pB/BVry8xIKgo/1Teq0rMPUz7f9r/ShNyP8Wy1WJ7efHpYJWzISBBmmWfeQLRGyW8CfpnS5/Od7B53b9YSyptFEcv64zQG/EtJWnFxL6Wf2S58nIAzWPZrc
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 05:26:45.5385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 bcee5f10-16e4-4d0a-80cc-08de952f6ce6
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	TY2PEPF0000AB84.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8735
Message-ID-Hash: NCEXGOZODQ7MPR2OLDPFDPV3QE4FYT6Y
X-Message-ID-Hash: NCEXGOZODQ7MPR2OLDPFDPV3QE4FYT6Y
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NCEXGOZODQ7MPR2OLDPFDPV3QE4FYT6Y/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Currently, the driver only performs a hardware reset during the I2C probe
sequence. To ensure all internal states of the codec are properly cleared
without affecting the configuration registers, a software reset is also
required.

According to the hardware specification, writing to the Software Reset
register (R01) twice will reset all internal states safely.

This patch adds the nau8325_software_reset() function, executes it right
after the hardware reset in the probe function, and marks the R01 register
as writeable in the regmap configuration.

Signed-off-by: Neo Chang <YLCHANG2@nuvoton.com>
---
 sound/soc/codecs/nau8325.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8325.c b/sound/soc/codecs/nau8325.c
index e651263a9812..58ef5c493835 100644
--- a/sound/soc/codecs/nau8325.c
+++ b/sound/soc/codecs/nau8325.c
@@ -142,7 +142,7 @@ static bool nau8325_readable_reg(struct device *dev, unsigned int reg)
 static bool nau8325_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case NAU8325_R00_HARDWARE_RST:
+	case NAU8325_R00_HARDWARE_RST ... NAU8325_R01_SOFTWARE_RST:
 	case NAU8325_R03_CLK_CTRL ... NAU8325_R06_INT_CLR_STATUS:
 	case NAU8325_R09_IRQOUT ... NAU8325_R13_DAC_VOLUME:
 	case NAU8325_R29_DAC_CTRL1 ... NAU8325_R2A_DAC_CTRL2:
@@ -670,6 +670,12 @@ static void nau8325_reset_chip(struct regmap *regmap)
 	regmap_write(regmap, NAU8325_R00_HARDWARE_RST, 0x0000);
 }
 
+static void nau8325_software_reset(struct regmap *regmap)
+{
+	regmap_write(regmap, NAU8325_R01_SOFTWARE_RST, 0x0000);
+	regmap_write(regmap, NAU8325_R01_SOFTWARE_RST, 0x0000);
+}
+
 static void nau8325_init_regs(struct nau8325 *nau8325)
 {
 	struct regmap *regmap = nau8325->regmap;
@@ -856,6 +862,7 @@ static int nau8325_i2c_probe(struct i2c_client *i2c)
 	nau8325_print_device_properties(nau8325);
 
 	nau8325_reset_chip(nau8325->regmap);
+	nau8325_software_reset(nau8325->regmap);
 	ret = regmap_read(nau8325->regmap, NAU8325_R02_DEVICE_ID, &value);
 	if (ret) {
 		dev_dbg(dev, "Failed to read device id (%d)", ret);
-- 
2.25.1

