Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D86C5DF81
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:47:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE066602CA;
	Mon, 24 Aug 2026 13:47:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE066602CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787572050;
	bh=p/CNIybOg6ONbymeZBwgutu4kHiZZEv4J+u1Ou96Mwo=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=pqJbZGzDScOaK3zO0a4GqZylioDMRgHZfvwGY8PZ5Oz0vcqKK1zyk6IpgaytUwUOG
	 dmahvZ6TYvAgg8tKX+p3r9slYZHjGMdb8LUlObd70OAV0J+NWdUNPMj/TWRgC9OyBd
	 ZQdSKQhW6Y5rkeW8Cpf4SzmyfdWtBnUk2WH5izjY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BBDA9F806C7; Mon, 24 Aug 2026 13:45:58 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2207CF806B6;
	Mon, 24 Aug 2026 13:45:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1A3CDF804F3; Sat, 22 Aug 2026 06:25:26 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1787372722;
	b=FkZGGk5etqvQ7k339BDb2hQVRBc4saO8oUnSmd6I+xAcC7eLg3jFfsC3ijzNgOC++NYA
	 gKt5fejbBA7LtJN16xCK4XVd6Dgu9dEkQ2XtRvzy4lpm07wo9jS3pC4hW2UM60S9wQj0T
	 HmokG+8ISpoKl5LdQSXYQWtmV4n5Ieg8Es0F8Gg6dG0AVGshMJbws+8F9jurqGe6VeSlj
	 qMO/wTK3xj8gsIqp4/CDaGkBys8iqC6of+HvoLlYmiNGonofPzBUfp3bTguB6G/hiPyh5
	 w+Uxw2Fz4sMp4eElQmpYb2FTTCSu3vvHPaM8bSwfv9ZTfHKtse7VNWq11asb8Y/iVxg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787372722;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version;
	bh=p/CNIybOg6ONbymeZBwgutu4kHiZZEv4J+u1Ou96Mwo=;
	b=I85ltWDkm45pc4W7DHyOVS/TlodtLyko+sBmRV3sz74B3Zf6wNc90k5MGr4+MTNvgMes
	 q61uhrP2f8MBBUvuccrvr7A3VzvZEqLUhL0+ul9OgEjlrDoI2tsEl3FljN6hOGUQ6cJCW
	 dSMDoLSdU+WUQndnDhLrSAVARpBcO/32eLW0szDjB86uB/uN39Y64sqPy4drIX4dS/7C3
	 Nc/LV92hwp5znX1e6y5PO4NgFRYzn/rqYgl1+7HoTNFAduUshRy+SIs/LL3wLXjamEFdb
	 UhH8oAqC75n/wkUHdlTDGRNJ0oGd0JJrbffKkiSeMAqeRUwWQo9j0yU4S4KV5X0VUhg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=lWaqWu9K;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=NgGr0f1O;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 55236F8014C
	for <alsa-devel@alsa-project.org>; Sat, 22 Aug 2026 06:25:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 55236F8014C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=lWaqWu9K;
	dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=NgGr0f1O
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67M3WPS4915536;
	Fri, 21 Aug 2026 23:25:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=fi1K+udOGQVHO
	CNqIh5LzE/9E7TAb0epMTbZsuVWt0g=; b=lWaqWu9KbaOk2xAIoElCf5FjFn1g/
	8U1uoIwslsioUJwO/IBA75nQvtTM2X6HVUTfOQCQa160upvvXtPWptKtLiiiyQlK
	BUKLZaZKkDm1YEDLfAAAa9GSpi6xTEnDym6wx6QDfxPpLdgIdyMqdlJ9gmAJq7EN
	oNhfcHSjsFYLsIv7G5ixcvyRJ3Ji0UHOsweI8ypnwVdiyV2+TJcxcUreDoBl8NoL
	ydlTVYZM0q3GuJMamRHF2yXU4ipEnoQe9GLTEZIDDTgMiAlkFawl4Yip8evqI9+R
	i570DFwqEvgzomBaqgdC44cfPwiE17El6Mz7wVuhLMJMuwmxkH8SICIDg==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010038.outbound.protection.outlook.com [52.101.61.38])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g73xyg407-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 23:25:13 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETPV6qtWXMzYyAFs7RoMXdp98rf7VkN/zCAhA+MQgLrBUXK7hZHcKV1X9fX/N25SXVP+sCr31w4Y+A+cxgoMY11g0drVYpf6asNaGx4T0I7TMe3mKo4og40SA902MbN3lPXHEhWEHvTukrChhoCWXN28G/wCXZlKJ+6TETyguZti2oXh0a4gXle6z8zKVgK2enpw5jHGk2mHhTGfVcIJLZXiSHOYBaXrbYbWwZxS3eA91scVbF/KxBWyXJQGPCTV8qQO05ahznlG0LYT5a+niKi63de8jwTA8wh5BIlcw8umMAtYIRx6XsWrXF6r5kFtEXqmlSk/5RuxOrml09LTPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fi1K+udOGQVHOCNqIh5LzE/9E7TAb0epMTbZsuVWt0g=;
 b=PgwcxiwdRlyOcQ+pW4NM/pXKbUVZTRO0RV3Durouu8jskV2J2kL33tG5yRydSUopq2JFES6uzm7Jt+c1DgJy+jP6935XitELIR0pk31vx6seVm32UU6TQvfOUXOpafHL8FEx0Wgsz3kmp6tVhykHGWGSn0nwlpbkfmnhiREvhlqPJ0FK3aCGKBBWs5vtLzpPuD8u+bcOKcLF4AtXsF2fi18dw4zAy4PNaDIwgyIE1Gi1HQu4aSR+snaIVXj51UtDRX+33LUvKIBiWwBjrnzZIF0wdWcxWzJ4kjqTmX79iCnEf/Yqq3rhtrlcp/41d/YxPdis6ybXGlYVRo82ivzlMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=amd.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fi1K+udOGQVHOCNqIh5LzE/9E7TAb0epMTbZsuVWt0g=;
 b=NgGr0f1OrRgKkyqYIPC7uVG/xBHLrPozeK0IV4bFF9l9aFjCXatsbK+tF3q4ajqH8TLa3+D97CigJUpVR2ClKxOysWOCbvZh5L7GNX8P2URxisGGAyGEcaUEMwnNyJmgfXaDIZ4LHin8eVOguRuPZNyyPRX6299wwn5NwP7X65I=
Received: from DS1PR04CA0001.namprd04.prod.outlook.com (2603:10b6:8:44f::8) by
 DS0PR10MB7091.namprd10.prod.outlook.com (2603:10b6:8:14d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.11; Sat, 22 Aug 2026 04:25:06 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:8:44f:cafe::4b) by DS1PR04CA0001.outlook.office365.com
 (2603:10b6:8:44f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Sat,
 22 Aug 2026 04:25:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Sat, 22 Aug 2026 04:25:06 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 23:25:05 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 23:25:05 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 23:25:05 -0500
Received: from LAPTOP-70RJ5B8Q ([10.250.165.249])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67M4Ow8Z3271610;
	Fri, 21 Aug 2026 23:24:59 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <broonie@kernel.org>
CC: <tiwai@suse.de>, <andriy.shevchenko@linux.intel.com>,
        <13916275206@139.com>, <alsa-devel@alsa-project.org>,
        <shenghao-ding@ti.com>, <baojun.xu@ti.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <k-yi@ti.com>, <henry.lo@ti.com>, <robinchen@ti.com>,
        <niranjan.hy@ti.com>, <pin-hao.huang@hp.com>,
        <Syed.SabaKareem@amd.com>
Subject: [PATCH v3] ASoC: tas2783-sdw: add firmware download status check
Date: Sat, 22 Aug 2026 12:24:56 +0800
Message-ID: <20260822042456.2001-1-baojun.xu@ti.com>
X-Mailer: git-send-email 2.55.0.windows.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|DS0PR10MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: c2945ee8-3bc4-464a-3872-08df0005582e
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|6133799003|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 
 Psg+ZdP//tJ7TPH63iL7M7PyGu3ilHqTsOuXrt/QEYxgKsMvfkGQrzMQceB01ld4d4VcxS7uRNj3EOrt2EcppEkfgPsDBdrGFtshP0hR4ZRv9NgiHews/0L9n2eI5Z+/gGaprhGJc38P0QMcNHabitzf7ojwjyUyLfSljFVzDTR6KKvkObaPOLl5Z0zoxWtd54LjRdnJhWgbFuR7OBYS8z27JtZwoFYFBITZ6iXhDg76vmyThcimeM3WYqb1BVRSSd1hyJ080ibVE8AdHjnOVcQ22YxBuCbL5ciTkkpuhJ5eOKzitawuDSJWcATnjlBGGB2yWYg+Zie9tDGlREnGPmfLM75jY2I9NZgDx2905vzdXu6j/dUwxBQpSQ23nQ2Ay3zkXCiwSdC6k/KZXvBxnXNOatkhADsuUbna+urusM35Pwy0XouyJibUZ6zuk/LmsLZTRRCBkcOmrSnMCTgHBvbi0k3QdSsGh9xYGhLSTnlnAKUGC6CcxvmKLR+WKjWKARAaumNOYnNXh29Inv1bhcFdRI5cwk11RGyd1F+v5Lc8mYw8BcH4sL2WgDHRif1KtLF/NUchXag35xR8IWBH4WLdQfKglcu4tJWecMfOdiZ3XtlPb9FU2VEDqh4m1lypW9B3EEKIg0AbRUr4gvJTPxFV8QhKan2wu8Dj8lFQY56l2bWYG05WgfKb/kbQBO80nGQ++CPTwJA10gcmWnlihQ==
X-Forefront-Antispam-Report: 
 CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 SDUHTLrZ9jgrfTIDX6fd/YP/R904RuP9+0sYxV2kCtOgpo9Ej6ueOj7rKAlSJWt4b0ai5DKeVBhl9iDQGxyUZFSa2ZO49QKjbCqq+p20bidQKNhMYVH1JryUnpK1vS1MxyCJSbFF6oSpiEOcA0eWrdBXg3apnMGuW1kulpiZoXICgVbvDeW+9vIdaFMFhqrrudVucChDD5AeUf7r1Xevx3Jy02FFoaaddOJTRXktEik59AFYSqRgENT4LgWJUqt5TenW0/HQ7VCpFatH81grrNL+fm7wr9P7etCqBO08POHfX1Y62PyL8u2z7OJiUBbf0lxRDV3C2S708QnozVI1ccZuLibLLRe9LzEB5ouB2uvdEEDSXGLle+6lc8hVyo3rBC0uAcN3n1BOMPxUiJLgt4v7aYAs1bE0u8OvtZHYnF1oSv75swMLkeHcKJl9pfVT
X-Exchange-RoutingPolicyChecked: 
	JXt3GFsOvhpajqdwvXEA4WUDpzFza+DOUG6I0pjQSLX0ihJOjkm88p722DTlMz8EywK1vYsJ7b8Q+GK1UaX93RaKt9I/s48EYOmgmipDNaCzKSdlQlkbVzo0e0VJZDiOxtyKlW1/ytILKUpa557cY0pfAuSs7Y2FmwOkkCR/vOaFbfHCzNoDi2ho6U8S/hEwWyjWXqXQ5YYvqfQ5smVEmojcAP1UK3eG1flAQarwL1lWat28N82ncX1el0Uxo+OdDLiyAnvl4vXMSQjEbzhuBK0UDGEWu/ulh2vZMdOxsgfHh2SghOfQ3Oon2ATakerchzykfGQHYI/plA84n6xsDg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2026 04:25:06.3338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c2945ee8-3bc4-464a-3872-08df0005582e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
 CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7091
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIyMDAzMSBTYWx0ZWRfX7t2ZIk78lJZf
 XmzFTyL7kv5AbMMuQQhwBLPpUHavytByr0+FHg/Cb4MKwzSI95xwJ7thiI8XZXMIUsX+RdsvE4c
 flPlQJT8qdkyRMwDq8VB/o/R0TVG3Ck2x3KKDyjppfy6MWAmgIup1WWSWI3tfrSXhKv9Tv7WJOY
 qHqnnW//ajFJsm0nPfPkOio7Cy1zj2VVJYglJW9azFZwTSBGe2byik0ru9pxodn2zQ1koFRDyvJ
 vdO4BiJa/IYDoZCaV+diOGluomxk8IupR+QLrC3aa6zxJS1BZ/pmLK2MF4zXDiK8nw0VQio3HPq
 3oKP2/mb3bRJHWE3w/WOIeZfLPenTEaFrUthyTuUmpQGMhNRQGVjo080jJyKiqh+ttLYAB8pPlP
 YHIuq5zOM1GKx0cnoFgq15ROI35ogPnk+uuv+1CIkNRYm4eYpmpcSpT4g1Qc03CdWiZTyXaEN3t
 b4UlPqrnj+VUN0NWEzg==
X-Proofpoint-ORIG-GUID: zVhyUifVi2MoOYYgX2yI0J_uRh3kalL5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIyMDAzMSBTYWx0ZWRfX/pcd13NgcFG4
 9qHEyMw7F+GwrsLE7USbcVED3r9m6iP2mXShYVgFvy/AdjppfhIom7ia3M/jDDKcQH+PGhch8UR
 QonHUYuWPRkzfYMrIOXkODW4n08jAU4=
X-Authority-Analysis: v=2.4 cv=SbLHsPRu c=1 sm=1 tr=0 ts=6a8924aa cx=c_pps
 a=uwUl5xS/OuIXHPkYzYKLCw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8
 a=MsNS4y5GQQOSDfnsN3AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: zVhyUifVi2MoOYYgX2yI0J_uRh3kalL5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-22_01,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 adultscore=0 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608220031
X-MailFrom: baojun.xu@ti.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: ZFD446JNM6WPLPXCGHLTQ7GN2ST62W7C
X-Message-ID-Hash: ZFD446JNM6WPLPXCGHLTQ7GN2ST62W7C
X-Mailman-Approved-At: Mon, 24 Aug 2026 11:45:51 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZFD446JNM6WPLPXCGHLTQ7GN2ST62W7C/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Currently, the firmware download is unnecessarily triggered on every
system resume from suspend, causing significant wake-up latency. However,
this step is redundant if the AMP remains powered on.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
v3:
 - Updated description about memory page download reduce.
 - Removed the logic that skips memory page downloads.
v2:
 - Update register address from 0x07 to 7 and keep the line within the
   80-character limit.‌
 - ‌Remove stray/unnecessary changes.‌
 - ‌Change variable type to unsigned int to comply with API requirements.‌
 - ‌Replace usleep_range() with fsleep().‌
 - ‌Set idle_bias_on to 0 to enable low-power mode.
 - Reactivate the AMP after resume.
---
 sound/soc/codecs/tas2783-sdw.c | 36 ++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/tas2783-sdw.c b/sound/soc/codecs/tas2783-sdw.c
index eaebb0ebbe0d..2561bbc7823b 100644
--- a/sound/soc/codecs/tas2783-sdw.c
+++ b/sound/soc/codecs/tas2783-sdw.c
@@ -97,6 +97,7 @@ struct tas2783_prv {
 	u8 rca_binaryname[64];
 	u8 dev_name[32];
 	bool hw_init;
+	bool first_hw_init;
 	/* wq for firmware download */
 	wait_queue_head_t fw_wait;
 	bool fw_dl_task_done;
@@ -852,6 +853,8 @@ static void tas2783_fw_ready(const struct firmware *fmw, void *context)
 		ret = -EINVAL;
 	} else {
 		tas2783_update_calibdata(tas_dev);
+		regmap_write(tas_dev->regmap, TASDEV_REG_SDW(0, 0, 7), 0x22);
+		tas_dev->first_hw_init = true;
 	}
 
 out:
@@ -991,7 +994,7 @@ static s32 tas_sdw_hw_params(struct snd_pcm_substream *substream,
 							TAS2783_SDCA_POW_STATE_ON);
 			if (!ret)
 				break;
-			usleep_range(2000, 2200);
+			fsleep(2200);
 		} while (retry--);
 	}
 
@@ -1089,7 +1092,7 @@ static const struct snd_soc_component_driver soc_codec_driver_tasdevice = {
 	.num_dapm_widgets = ARRAY_SIZE(tas_dapm_widgets),
 	.dapm_routes = tas_audio_map,
 	.num_dapm_routes = ARRAY_SIZE(tas_audio_map),
-	.idle_bias_on = 1,
+	.idle_bias_on = 0,
 	.endianness = 1,
 };
 
@@ -1222,25 +1225,29 @@ static s32 tas_fw_load(struct tas2783_prv *tas_dev, struct sdw_slave *slave)
 static s32 tas_io_init(struct device *dev, struct sdw_slave *slave)
 {
 	struct tas2783_prv *tas_dev = dev_get_drvdata(dev);
+	unsigned int val;
 	s32 ret;
 
 	if (tas_dev->hw_init)
 		return 0;
 
-	tas_dev->fw_dl_success = false;
+	regmap_read(tas_dev->regmap, TASDEV_REG_SDW(0, 0, 7), &val);
+	/* Check if the AMP is in reset status. */
+	if (val == 0x20) {
+		tas_dev->fw_dl_success = false;
 
-	ret = regmap_write(tas_dev->regmap, TAS2783_SW_RESET, 0x1);
-	if (ret) {
-		dev_err(dev, "sw reset failed, err=%d", ret);
-		return ret;
-	}
-	usleep_range(2000, 2200);
+		ret = regmap_write(tas_dev->regmap, TAS2783_SW_RESET, 0x1);
+		if (ret) {
+			dev_err(dev, "sw reset failed, err=%d", ret);
+			return ret;
+		}
+		fsleep(2200);
 
-	tas_dev->fw_use_fallback = false;
-	ret = tas_fw_load(tas_dev, slave);
-	if (!ret && tas_dev->fw_use_fallback)
+		tas_dev->fw_use_fallback = false;
 		ret = tas_fw_load(tas_dev, slave);
-
+		if (!ret && tas_dev->fw_use_fallback)
+			ret = tas_fw_load(tas_dev, slave);
+	}
 	if (!ret) {
 		if (tas_dev->sa_func_data)
 			ret = sdca_regmap_write_init(dev, tas_dev->regmap,
@@ -1249,6 +1256,8 @@ static s32 tas_io_init(struct device *dev, struct sdw_slave *slave)
 			ret = regmap_multi_reg_write(tas_dev->regmap, tas2783_init_seq,
 						     ARRAY_SIZE(tas2783_init_seq));
 
+		/* Re-active AMP after resume. */
+		regmap_write(tas_dev->regmap, TASDEV_REG_SDW(0, 0, 2), 0);
 		if (ret)
 			dev_err(tas_dev->dev,
 				"init writes failed, err=%d", ret);
@@ -1428,6 +1437,7 @@ static s32 tas_sdw_probe(struct sdw_slave *peripheral,
 	tas_dev->dev = dev;
 	tas_dev->sdw_peripheral = peripheral;
 	tas_dev->hw_init = false;
+	tas_dev->first_hw_init = false;
 	mutex_init(&tas_dev->calib_lock);
 	mutex_init(&tas_dev->pde_lock);
 
-- 
2.25.1

