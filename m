Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A299C88E64
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Sep 2026 01:58:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0B29C601C7;
	Mon, 14 Sep 2026 03:57:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0B29C601C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789351085;
	bh=jTZ8jOHKhP9j/6auOeoUIirQSzam1rVv5zw8ppQ0B6g=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=jUJa8/S4AA/QkBmY0K1rG+qyhDcL17SdVM/P6gEBtSHkFfMeaYwVUUBXc0Oodkf6q
	 BQEVrhrqGVIufnMqUQ76iMmcGaRY0ywQ+SjPF4gh+hyhjR1Cv9l0G74YF2RPkREtrm
	 MO04tRoG+0KYPfP1Gbe9Zk3wuITvEH8cGLAujpWc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E9DC4F80617; Mon, 14 Sep 2026 03:57:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BC232F80622;
	Mon, 14 Sep 2026 03:57:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1329DF804B2; Mon, 14 Sep 2026 03:57:09 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.24
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789351027;
	b=IuLGrxiXJJUyzwI/Ng/ShmyOGxpCt8vdase2QayXuif/+asUI6akRlsrC58NON4Y3Uvw
	 BXU16uW7AWz3lbcIuts8cEiO3DY88HQqwaG6q9cH+eLSKCBauTuTzjEOrD9h8U7aHLWGp
	 spQM34k4d89eNur725eCFM5IzMOHEJAKitV0G/6Lg8KKJoa+LJaY/Bh1NNHHKcjwj/T7S
	 5HIpj6Bw3DqTxImiDRG4mq20/zskC2Rxb7XWv1xf5Vcf24fbF9J1CQbUa0mEQZigED8s7
	 GfslTcIyP4p/OrGaro9qhzOg75hI7LFg0hUqM3G4ePfTAB+Gfpg8GmebIh4sTpbucPQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789351027;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=jTZ8jOHKhP9j/6auOeoUIirQSzam1rVv5zw8ppQ0B6g=;
	b=eaeoy8AN/vcAFZaf+tT0SuaARbhl6++EqgwLIOWBtRSu8zFrJVXQmmyliBVj8x/n500w
	 RVQSvCZ4NwnR4SUqcpgonusV9twChX0YL49Cm/t8viL0mdQ6OttJyMRHtV44giFWAUseZ
	 iawQ8AMP0ckvBicLf6WYVp4n4OJddFRGh9z/PojWNrTDtqdtY+htIOlFAWcZz/SfziuN6
	 HV1DpLNmV671Mycs1ygElHobJ71J63yEaupmGiVYNUXoITc0ocbbWGkO8tqGfQCXUJgXL
	 Uc5a8XJT5xiKThil52FjvRhF6YpTs9bjcDiCWTtuOSQ2yJrUHB4jhcVgfBJORNElJsQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=wk4hWTF2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.24
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11013024.outbound.protection.outlook.com [52.101.127.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9F4ACF802BE
	for <alsa-devel@alsa-project.org>; Mon, 14 Sep 2026 03:57:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F4ACF802BE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=wk4hWTF2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rS6xe/LHub7dH52znzh/F/si00wfviHHK+vOOjrogjQAly1rU8UF/ZWQT16IST0cztY4TqkNrugYDaw3ZIUYLtUdSiHb3cpcseS+ZaYi9Ro4lObG91c288JwXulpc50tcbahb/WGjWk6oIUvjJmYYmO4yBhezFz+ZN1q+mGt6c/qNvVyMFm4R0xaOEXM6phwXi+/eBU99haZd4nLuqepAhErGiKDM6ng4KIW/On8Vybe03qY29CF07I/pqQxFOmA9R0ysi1qxUoc/KH7/Xa+hDidAWL1IpgTX5yc5izIgS10pA0sx0YAtkzMBPm2WmQaj+xwxTTpfseXc/MM2kff2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlBMfMy087QuUGv17VHuRuBSvHLBTsYbh/ie4DeIUQg=;
 b=dIM/qadSvU38tKVjJeRiRJDC92a60wvV6cLwlAeUzn6Ad+72bvXWH/1hNu63fxEY48AMZdM5p4XiaFuVwt1whEstDRs4nB7VrwhhjoJnHHSPBK/uA53corj39zj9CCVUeQLrEjotxHoJZw+iefhMJ3viaaiBp31vdL3y/d36UXCPHDOAkxNg5Dfr8fvZDPkWedxgUnp5Wap5Z/avEccK8+5c4+BPN9bY0m5bW32SmzB+I1wvuHrQm/B8cBQLWMzm7C2/Cgng3DO1YGYVBTOF5pD9sQMcISzh/SjoJWUEGT+UPfHKVi6sStmekmDUle3KJMmqOFccLU84fthOPhjjEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlBMfMy087QuUGv17VHuRuBSvHLBTsYbh/ie4DeIUQg=;
 b=wk4hWTF26L6IXvyaI9W7ter3lq9tgwr1dGa8EL5W4VP/LJUJcIdEmbaP6ctrroTEPYf/SywokNUqvlDKRpaUXTQvGGSNDY4svMjkuSPnhUM436vm0p60Q6RzqBqeUvBKWH5YnX8VI8UC1p+2ra1Fo+wCjeRGwcXuG+zeU78Rq952YRP1esBr9ALGTsBUYcz1inbnsnJV+pkjIDM2yE3Rgy2CH6w4ExCQUkxfcrvJ3AA1N4Lgn7Um1onRBUw8iFp2KyVSkoh/J+xZ9OqHhnCzvOMo1zjIymwD5NhADy86gTX+RBn6CvM6o4iR4yxQwlUeNhczlbaYHXZESZXE8UBADw==
Received: from SI2PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::10) by TYZPR03MB8190.apcprd03.prod.outlook.com
 (2603:1096:405:25::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 01:56:54 +0000
Received: from SG1PEPF000082E1.apcprd02.prod.outlook.com
 (2603:1096:4:192:cafe::11) by SI2PR01CA0025.outlook.office365.com
 (2603:1096:4:192::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.11 via Frontend Transport; Mon,
 14 Sep 2026 01:56:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG1PEPF000082E1.mail.protection.outlook.com (10.167.240.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 01:56:54 +0000
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Mon, 14 Sep
 2026 09:56:51 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Mon, 14 Sep
 2026 09:56:50 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Mon, 14 Sep 2026 09:56:50 +0800
From: Neo Chang <YLCHANG2@nuvoton.com>
To: <broonie@kernel.org>
CC: <error27@gmail.com>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<neo.chang70@gmail.com>, <kchsu0@nuvoton.com>, <sjlin0@nuvoton.com>, "Neo
 Chang" <YLCHANG2@nuvoton.com>
Subject: [PATCH v5 1/2] ASoC: codecs: nau8360: Block DSP path selection when
 firmware load fails
Date: Mon, 14 Sep 2026 09:56:47 +0800
Message-ID: <20260914015648.311986-2-YLCHANG2@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260914015648.311986-1-YLCHANG2@nuvoton.com>
References: <20260914015648.311986-1-YLCHANG2@nuvoton.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E1:EE_|TYZPR03MB8190:EE_
X-MS-Office365-Filtering-Correlation-Id: 55be663e-609d-4209-6b75-08df120373b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|7416014|376014|23010399003|1800799024|82310400026|11063799006|56012099006|10067099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	e6Jq0NVzo1deoYxGNiXq2wKonJ1oTWhQXx3nujGLaJOKO0TnTybZ7r/Srhj1imx9mpHUQu0GaGRrT9XLNLtI9HGf82fNFnjJc05uh+U366VtRNmvwjfE3slzQfSuiKHPPFC6//EYjgTdao1WOOUvhmhddTIWBD1Y7UHKe4tZQ5E/nccu1UdNFBJ0bBOFFE3AaX0Iofq7Xbrx7BhYl6HjK6ZCbdTqfaUqf0u9Cht7b9QORfBdiwljpyhQXtuobTHUnkyFnfbYF4Wk5zCCqBuZHf6q0c3SJQuU6GWiwalOYlKx6MORoCJ+9MN2AD5L/6bH9Ah7I3+LTG1D91kbuEk/uigC9VOMtpqe/kH9yE1fMofaIARTRhtKXjOpTt4tSs+4a4e/t5rXEsLlJmaIniQ8Ma26MedgCT168UL3OFSLdvc85xsFRwwOIfoWefJ2xSUM6rc3Fw9/MAARVWHXqj4C6aKiRT7OELhw5yHHTsW9cgACeKKiAEwDwIrEJq140kuTf/eE4TiVQxUAVGXfvMKePWE4KD2FvBzdsRJRVImYDiJZtiBH2h12QxY7KrGYprjMkHyr45npD7MlkdGw5N1AHaVVIcmmhqvRBjculxxqE7QhH73Rw9PyOi+C4QT2mI6Sk2DKUhL90IOKY1qUdHnMUhrdAq66QyJDC6wfaLGavYV6RxoRsrrQpmvwFhZIoeXjnA5oWac2OIEi/9RBKHVwzw==
X-Forefront-Antispam-Report: 
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(23010399003)(1800799024)(82310400026)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	srY2UlYyuXcL7F8+X4ncDxMLgoDZtAqVt27vqCK67LHbzR4/0qrLQgPDgTFpILQIr+AKYbB+8mc1QDkPxRl0ms53aFXH2BUqObdJ3oYz90yxOkxDqi2vpwOgSBoeqETEyLEkgByOPQ3Zz1l6YqH/fsvm5vaUnqEm/3TWIZeOVPbkLBi+3iG4po5O0czUznfGouBMEIHfgQyweO6PzFZm6aZ2ILNYTLsiXGp1izrtFLo9DSxKN3PufQEJKYUg4WBm4IkgtNfVRmSXkL0O/NHea9M6v4J+nvJc/U4hT2dpcU6X6+mb1mLUAxqw1B8cbuSeHsu3nlq5nhZAKoi+hSvnrZKhp/So+azV81BP9jZegZFPkkz9f/gQId9jlY994YUKrA+9kyWWwhjhoJ5yrWS2GlwwAHtjuGkR8aV/dfC8Unj4DdpgjCR0D5zVrpG4b+2Z
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 01:56:54.4468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 55be663e-609d-4209-6b75-08df120373b9
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SG1PEPF000082E1.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8190
Message-ID-Hash: WRH3US4RDAQ3MPI7WR5XWXWKDR3N5VRA
X-Message-ID-Hash: WRH3US4RDAQ3MPI7WR5XWXWKDR3N5VRA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WRH3US4RDAQ3MPI7WR5XWXWKDR3N5VRA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Block the DSP path selection if the firmware fails to load to prevent
invalid routing states.

If the firmware is not ready, nau8360_dac_mux_put_enum() will print
a rate-limited warning and return -EBUSY. This rejects the invalid
userspace request and maintains the original hardware state without
causing audio wrong status.

Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/linux-sound/aqK_oOpMAXVhxkHJ@stanley.mountain/
Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Neo Chang <YLCHANG2@nuvoton.com>
---
 sound/soc/codecs/nau8360.c | 9 +++++++--
 sound/soc/codecs/nau8360.h | 6 ++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/nau8360.c b/sound/soc/codecs/nau8360.c
index 89b8ee80d6c8..f5dee12127cd 100644
--- a/sound/soc/codecs/nau8360.c
+++ b/sound/soc/codecs/nau8360.c
@@ -715,8 +715,13 @@ static int nau8360_dac_mux_put_enum(struct snd_kcontrol *kcontrol,
 	int ret = 0;
 
 	if (snd_soc_dapm_get_bias_level(dapm) > SND_SOC_BIAS_STANDBY) {
-		dev_warn(nau8360->dev, "changing path is not allowed during playback");
-		return ret;
+		dev_warn_ratelimited(nau8360->dev, "changing path is not allowed during playback");
+		return -EBUSY;
+	}
+
+	if (item[0] == NAU8360_DAC_SRC_DSP && !nau8360->load_fw_done) {
+		dev_warn_ratelimited(nau8360->dev, "Cannot enable DSP: Firmware not ready or disabled\n");
+		return -EBUSY;
 	}
 
 	mutex_lock(&nau8360->lock);
diff --git a/sound/soc/codecs/nau8360.h b/sound/soc/codecs/nau8360.h
index cc640ba8c838..71396747c0fa 100644
--- a/sound/soc/codecs/nau8360.h
+++ b/sound/soc/codecs/nau8360.h
@@ -870,6 +870,12 @@ enum {
 	NAU8360_TDM_TXN,
 };
 
+/* DAC Source Path*/
+enum {
+	NAU8360_DAC_SRC_HW1 = 0,
+	NAU8360_DAC_SRC_DSP,
+};
+
 /* PLL Source */
 enum {
 	NAU8360_PLL_MCLK,
-- 
2.25.1

