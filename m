Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277D6C61DD3
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Sep 2026 06:02:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB73E60238;
	Fri,  4 Sep 2026 08:02:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB73E60238
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788501740;
	bh=kG31+1O0yStJP+OG8h/YACHEuIOR8QC4Qic3m6VSOis=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=ZlglwCP0nC/yAMINQA/6BEsueFdNHgapLXCv/W7DUa+NqI1wDUxKQ0ZYuwvsQasPx
	 Lusb/KRD3nNAzH13Q+T9NRxIQzZsjTy+NPVeRseuvjkIV0daI7FxNkBUeXY7hR6NXj
	 eu1l3SPLeINymITXHJC3ElsusDEX1h9jN2DPC87U=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 14950F80640; Fri,  4 Sep 2026 08:01:20 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4409EF8063E;
	Fri,  4 Sep 2026 08:01:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B47C9F80604; Fri,  4 Sep 2026 08:01:09 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.27
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1788501667;
	b=Ji6qwZrgJFwaLRDugpEKfb+j0UXQ/3rQi0qHBIBTaFhASr3vtrnRp96+rwxXcpqVQWEe
	 L4yd48/HhPlZKYqzR3VxT1doEOUA7LgRcugUCH0j9jVaswC06+SqCOZ5jxk41DP5GOANl
	 ISQKy28nX0/OpX8ECZUOmUU+PYYLzMkMAxudPCfxYqli0+Jo3OzSKbkk5d8U5dWQT7KLm
	 b/Q/jG7FeZuCAYuLndoDCGd3vUVPjZPTr9YlgRMSq+kj0H5VV88wdYj6rN68RhzosSEE8
	 sRHYXakphsbSxfbZcYKjtlqet3eu8rgLS6JrDW2jyWfUSdyi8c3Y8cSfk+uz4wg/RtA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788501667;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=kG31+1O0yStJP+OG8h/YACHEuIOR8QC4Qic3m6VSOis=;
	b=evRh18rtPQ9dn9YoHnYM+l6V1o7m8GjVgOeZU4WwSnGjrKCQ7fedas4IKuU/u0HPBL+N
	 sirHsJnO6sogQ5CU0d2YwUHIXTKBINC2CgXkuopA9pp8V0pcEBTIYDlovYhiRdyaLdZM6
	 bUB4NSEasL/P20lqy7KeZiJ+Ju140T81uq2dU5YbX692DxA4I0BYZiPixxNsY2+8y8Kbh
	 88ReFCzqI+wH2WacuyjlUR7j/w44yvZhbvLy4FYRUnWdaGioOVt9yacHvVnf88QWcTuAD
	 IQzXN62Py5IBwotMgjb8TX4XtgEG98nf9/XFI2UPN+cxY992XPh3idVjSH7KbVGn+kg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=YG5q2I4J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.27
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazon11012027.outbound.protection.outlook.com [40.107.75.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 691BCF805C2
	for <alsa-devel@alsa-project.org>; Fri,  4 Sep 2026 08:01:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 691BCF805C2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=YG5q2I4J
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2zI52Zja7XgUjvPsjwzfmzzPYpcA2oE50kmJhCgdIUEuIx1fz62q9WOH2O0H79fRIigSlqPUHlsebUSSasqe6+1zqtqE0ZCG6QkTwIlef4G4b3lh3BtEn6JoXebAjwnM5Q0KoV1AHMBlIHVVYsXOIZLosdvbZt2RciNQNPZldN9VU5IdSHkooa3cM7QNB/N0IWd45B/k4MphI/TiXq+Xr5Ka7wLAASmOi/btNCUU0DZ6zohifuuK1hZtxuG1cS+wpcIeqsHS4pgji6ITeCBj90OUpDZ2LV/2iprwek1zEfXH6nl7oF2AgYIbbUb8ARBOhh0Daz0vPOoMGcIGhSu6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ofc1XQVLHenHrhb9JsjZWxefrnTXPq6wTPO/WIGPpI=;
 b=ZUeKAJgL/tT5/dRojaurWHyvGOgbx9g/5SIp4lpCaWbYuvurVHLn5JdxdmpMCiM66B+QCfjRuYJJqJ5zTXO05jconn+2CnfRdliKzizUAT+16e0JsEo+MnSISNIdPfF91z1JwgYUgQ1KB+m1Go9dHT2JOHT8bGNprBFRKf3Ry+XlsYPR+c8cGX1sqt2dsVDKMa0eomP/G1eAz+5crlKQV+gQek7VAIwZuvO73LrQrxgMXTl2OscKRHXdu3SWI2kBmFHOhG8lVe11FaP476AJm+zYbqRBeJaPejY5OI7dbBQ35T24SwbCXvCO8tLInp0PG689cMIamAUVnxv6aUXNoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ofc1XQVLHenHrhb9JsjZWxefrnTXPq6wTPO/WIGPpI=;
 b=YG5q2I4JoCCWXU6KIJPhTAbAFf9/JkJZRLWB3ihp3qhgPoI4aT3wVn4a8JiSUjY2u+8zsiHddX6ANmmdOlrt9/EzFQMwnQzbW5V3vvJjXEnRxTR8hSw5WmpE5EYzeNZvXAVlVhxWylaXbzwWCjcgGowbR9pAtc3JoWcuhkQFVQudYk9mO7YAb/CvKPxuR5+9mzXbyDtO1Zs5MG8gpi7olyantqdSV462kb8rYu3wGHh0edgF4K1jYv4N0Db030MhRC+jkHMHW1xzFXXCsXJ/g813h2QTsiG9meFPmm/tprUAqdNlZ4lxHiBA5wt1kmFYfH85EfWR14yYTZGBjQ02IQ==
Received: from SI3PR02CA0008.apcprd02.prod.outlook.com (2603:1096:4:295::16)
 by SI2PR03MB6712.apcprd03.prod.outlook.com (2603:1096:4:1ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 06:00:53 +0000
Received: from OSA0EPF000000C6.apcprd02.prod.outlook.com
 (2603:1096:4:295:cafe::67) by SI3PR02CA0008.outlook.office365.com
 (2603:1096:4:295::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 06:00:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 OSA0EPF000000C6.mail.protection.outlook.com (10.167.240.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 06:00:52 +0000
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Fri, 4 Sep
 2026 14:00:36 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Fri, 4 Sep
 2026 14:00:36 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Fri, 4 Sep 2026 14:00:36 +0800
From: Neo Chang <YLCHANG2@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <perex@perex.cz>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<neo.chang70@gmail.com>, <kchsu0@nuvoton.com>, <sjlin0@nuvoton.com>, "Neo
 Chang" <YLCHANG2@nuvoton.com>
Subject: [PATCH v2 0/2] ASoC: codecs: nau8360: Add DSP fallback and PEQ band
 initialization
Date: Fri, 4 Sep 2026 14:00:33 +0800
Message-ID: <20260904060035.196399-1-YLCHANG2@nuvoton.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C6:EE_|SI2PR03MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e18c0ec-536e-40d1-43b4-08df0a49e0be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|10067099003|56012099006|5023799004|11063799006|3023799007|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 
	sKNZmYxzh6HfmIFefPq6GLQsfNeshOLSqtudW18nOaRKJp9ErFfUQH9xCG8En0+h0PtiED01yTJHzNSQZsrTOaWs+4i5Ba42s0PF+1boDOUfVofzk5xdbGij8ObW7pYIw9/B9PyXS4KYFTDZzPSw1hLj20l7uBwMuMpLaQxjh1YaR/5PgEaBW2aaRf2HChBEUsW9XSK8+gvSt0GqyawNEOBClhHg7AHATwzEOqZGk8NBtPkC8WomJlaD2BpXJ4CdjyaJ2qvX07mMmVH4b5T8k+te5T2B8WJbsW/C99H5HqEjvtisqCLnIusuLICNDtHtNyWmdruXi/tpNnNnKeWXJaU8DOJefOdcxbCcxnn26R/T7fdm4RZQGRdjKE9Vi8NRlceSHB9YMSIFmuRo4dXbNq/ZTYzMYPV7Y6mrcgJyYWSmnYzFRVjQzrq0QRMYe4rk8+bqs/tdnoZJwLPSS+myuJyeKs+RBWHUaXElrLrDTRthbY0gPJ9zVodWQan1q09odgwkKQ4a45jv4lWbGl6zPBGiMJdPbTClCwa73qUYNdLdyE5eF5jHreoTBunTx3AlIY2Rae58o+AxAO+EGzQhM4K6gZHURwHz5hGSF9tob/LYuRY+meLU94RKZpPfTEP60pSCjPNY8JDhqc6bYx7j69Wfx2VoHY3CVlXCYYt7PY67X+QYfKugRm97zkKAocsK
X-Forefront-Antispam-Report: 
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(10067099003)(56012099006)(5023799004)(11063799006)(3023799007)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	q5qEgGGSre/CETmXMGosEzS3AR04DkwYZOi1tdHkWBBQ7Tpy6th2WAb4BrYgT+WzFl7q2oBW07yZwFRE42C32OZhsR6sJPE5BOTRaKv9ZhVYRUw99uIIw8HP91Vx+PK8UZA9EbtVXlWIqnCaQKy2+S0Jazfj9224okpQc7gqe8lV7LHYjzrhxiIXAj90pbIQGjq9il111TzLnn3g9Al1R0MUK5aj1ejoJPBKflmdAQ0oLo8w9QOjS9JHJwx/GsiWwFklsbbNFz56vosafCHHj2ApAA9RivSd4NpqkwXMIWr55IL2mokcrNeop4maSqLpEJMhTsxxTtHaudRebwCfoxWm347SMrM0YO4mcswV0O0A2RpMraFZ9OxDU61q9LZV5zf5pChPzPdDUAUJ6WyLnXhEPqWovfPDSV8NVShdwmrCL5w1BnkC0fx+1p9HD7IL
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 06:00:52.8393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 9e18c0ec-536e-40d1-43b4-08df0a49e0be
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	OSA0EPF000000C6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6712
Message-ID-Hash: BBB3MW6K3G3VIZRNTDMHZ3PBJ3MK5JGN
X-Message-ID-Hash: BBB3MW6K3G3VIZRNTDMHZ3PBJ3MK5JGN
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BBB3MW6K3G3VIZRNTDMHZ3PBJ3MK5JGN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This patch series adds a fallback mechanism for the NAU8360 DSP during 
firmware load failure and ensures proper initialization for PEQ bands.

It includes the following changes:
- Fallback to bypass mode automatically when DSP firmware fails to load,
  ensuring basic audio playback remains functional.
- Set a default PEQ band number during DSP initialization to prevent
  invalid state or uninitialized parameters before user configuration
  is applied.

Changes in v2:
- Use snd_soc_component_update_bits() to prevent register overwriting.
(Reported by Sashiko AI)
- Fix missing bit shift for default PEQ band. (Reported by Sashiko AI)

Neo Chang (2):
  ASoC: codecs: nau8360: Set DAC path to bypass mode when DSP firmware
    load fails
  ASoC: codecs: nau8360: Add default PEQ band number for DSP init

 sound/soc/codecs/nau8360.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.25.1

