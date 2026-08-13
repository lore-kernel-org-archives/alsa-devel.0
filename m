Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A183C5DF70
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2026 16:58:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9248A60259;
	Mon, 17 Aug 2026 18:57:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9248A60259
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786985884;
	bh=lXnTVptwBbnMfg4lW2Z9MagHiJNByx6m7jpNp1JlSgA=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=XJ98KxLwDdvFKiJSeE3TH5xj0eNlGDknu7+RuXKKddWz9xn4XQAvlW33oiVbwanur
	 cGhLzu2TkSW3bXL0C+iNwaRwQ/iwkMTKSP9Iu4pkI2zGTo1Zz2XgY3Sm39Nmt06b04
	 4ewTCmSzTIB4byS9PqcTCmMEKxlVJATa0+RDJ2bI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8E198F805F6; Mon, 17 Aug 2026 18:57:28 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3AA37F805FD;
	Mon, 17 Aug 2026 18:57:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3DDB6F80553; Thu, 13 Aug 2026 04:15:14 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1786587313;
	b=bQfyGk8FYySkfOEYslq4UDHTs4BEDiunjFmaHFia67U7dmRygmZLCOulfOVeaMlxmndJ
	 hmw9QV/ACUBSJ0yMGtG3UxpO4hkBBWwULDDQGqikt8mKiLsht686/mGxDvUeyHU0holZU
	 bcZm8eSnOqARlD7GbovF25TMhP1M6NSpIH+38SpFb4mkODhR2WoYzS6zlFEyIkprp8g/B
	 OVylZ1FxgrmpJr15KsrurpRtHkH6dgxrfg7QvMYVD7PfinjA0LOO8Uabooqem0At5ecTj
	 yv7kZ1rF9c3X9qwJH6rT7fgT09nUv4VJKElWiXl4ZdDgk20cqMpxkHitbO4OeQZW7Tw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786587313;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version;
	bh=lXnTVptwBbnMfg4lW2Z9MagHiJNByx6m7jpNp1JlSgA=;
	b=kub7FkXVQIMpDILvae7aF8ScqCY3gwsxrYiCdkZvWbVlvY1I/sZEkwg39bgJ1m1DSldr
	 0WcuLrQYm2YtSozz/Qgy3dNKdKlGOvPIIWEAQQhEhwyuim6UYFkznm/novHoE84P/2T7v
	 mOkJbuoyDiCMdLrUnir+dA5/mixsOATBba39tT3e0sSSqLEDuxzgpUJIa1T3Ob+nAxisQ
	 jlp9MEZRQ9qSkfinf0HQJasHSVWvH20OzS0mdkwZZb/bSOLh0PS+Ded2PsMM4e2AaBnFF
	 j3w2+Zdl62K0aFeEia/8fZN832oJiwkFOtQfNVEGzHDfc3E1bYG5foLAUXoUuNYSbdQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=okP4+Q7r;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b="B0RAi/cn";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8BAC3F80027
	for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2026 04:15:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8BAC3F80027
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=okP4+Q7r;
	dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=B0RAi/cn
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CNJwe31588222;
	Wed, 12 Aug 2026 21:15:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=LuqE0Bmmdd8V4
	P2tVhFXjwPcSFC3M8/Dp6zVgwCFyYg=; b=okP4+Q7rY4AfPdX498A0BDTAMcp5a
	r+HugO7zyW+cqbwB9C2LX7mqmdz0dbxBMn/v2xlG3yzxZk3oRZpZJhHeJL7Tsj5Z
	HLAD/ZqlJ11CZ2Y7WVbisctFW+lPPT5LEAVBAlLkrISOmwrJUztWBFG9K190fzub
	Pg4rI56723oQ9wI8VpynR49JkYk9huJkZg4/EWJv7kHOLo0Er5kLjwjGH81QvFzK
	z3LLIVJYeZrlCktH+9Zl53zhARJFAeRf5qY9IQk2LhIXOcko7DxV3vK7T6BrhBw6
	+dZWjf0q6PC2EQRyToEOE2B0QYDSpcamqIxIxYERu8imOL1ONSc8QV0vg==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g0mun62h1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 21:15:05 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a27bSwVw04IKjsnWiDzEpsHr02uptAgwg32+yYSSoljS/NbHclycaV+TCWIGgdFkgxhCe5VtlX1upX//8qKlXhROdRnw9B3/qNY2Q+tOjWfCc3oUwBPSpBa9GEU5OuTN5RyuYI/c3YETlFkDwqU68OTOzUHtLjAbI49h0mTCSOJGDRTGNDdow5U+nQjGwdhz+2TxJI5DDXLC3LIly6CY8Q1HwY4y9b3HH7ly5DY9kPNNahPUr7j3Mg73zcWxthX17lg8qSSTMJ+F01X3LYp/p4HjC5PkmTezpygDlIdM1H8NfszGMk7iWJW7vKXhndseEN4EkcHu6+LZLdP0kR2nZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuqE0Bmmdd8V4P2tVhFXjwPcSFC3M8/Dp6zVgwCFyYg=;
 b=IO2/XRBa2dRD2hdqn9kg8suB7HgM/Kkc+BoEzraCXi56wT+X7IfA9Hvoju8RlqI2MHlXuVmNLe1mG2/fEnqzu1Bnn68xwfsJ5zH7IDbFEzS+v9ByjOZ9cyS2qYpL894a/tYbZDbhMNF0Ykb2kr0jsihBaaZJKfJKhFqvUmSmeGT9kjk/gK42is4/IvCRUWZgv6o3SchjWxpegF1CA7XTOU83uRYjlhqPskpJRoQYQdkpvmKHjqAxjSTrrzFgQ6P5SL0zQADn6IyEK6q6BwiZqNhdNJXJRY8qwUsDUwKL0AMKtuhNm1VPrNqAR0nENIy2vfbLvRRy0tuACbn78hZ+KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=amd.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuqE0Bmmdd8V4P2tVhFXjwPcSFC3M8/Dp6zVgwCFyYg=;
 b=B0RAi/cnBM7Uekm3+91ABdqHARwqjb64YZNZElI+oXhzdkEApogERW3u1KLBR6dfZkZEf1ykd9BdnU11ZsIaT6DUSG06Ch6qrpyePiUUoNnsvLuGxDNf3FkMTCC88WcEl+DoCcm91O/pdV2tpqFLSUWqfWteiavfrIuzUUOAeiU=
Received: from CH2PR17CA0009.namprd17.prod.outlook.com (2603:10b6:610:53::19)
 by SA1PR10MB6366.namprd10.prod.outlook.com (2603:10b6:806:256::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Thu, 13 Aug
 2026 02:15:01 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::84) by CH2PR17CA0009.outlook.office365.com
 (2603:10b6:610:53::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Thu,
 13 Aug 2026 02:15:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 02:15:01 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 21:15:00 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 21:15:00 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 12 Aug 2026 21:15:00 -0500
Received: from LAPTOP-70RJ5B8Q ([10.250.165.249])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67D2Erbj3155494;
	Wed, 12 Aug 2026 21:14:54 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <broonie@kernel.org>
CC: <tiwai@suse.de>, <andriy.shevchenko@linux.intel.com>,
        <13916275206@139.com>, <alsa-devel@alsa-project.org>,
        <shenghao-ding@ti.com>, <baojun.xu@ti.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <k-yi@ti.com>, <henry.lo@ti.com>, <robinchen@ti.com>,
        <niranjan.hy@ti.com>, <pin-hao.huang@hp.com>,
        <Syed.SabaKareem@amd.com>
Subject: [PATCH v2] ASoC: tas2783-sdw: add firmware download status check
Date: Thu, 13 Aug 2026 10:14:50 +0800
Message-ID: <20260813021450.1897-1-baojun.xu@ti.com>
X-Mailer: git-send-email 2.55.0.windows.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|SA1PR10MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: 73b9aa62-f0a5-456b-bf42-08def8e0ae39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|56012099006|10067099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	leaO2NX7h9GKdvbZBd6pIWLgt96PJoCG1qfbhxQBcJvEgFAaJJnQaqmMsUGcwe2K92oYsDSZrmGa9kqmuEbRoiG5b/2CuyJYZSXDsUd7l0AYa4yJ3GIifTNDZ/n9Cz+1VS9f4WQUF1X6rN5RtEhVnnKt/X/zVfrywup53gNATelhwz+XknLdOR6UMmPQcUu3GAh5jxf+wzxB5Aif82cBlKDt/nraRocjWvN3AmEpQluzzyjL+h6Fsll3m+Qe43JV5saFnRyHpH28b2kBh7wVvIlMdrKNZd1qByU/Bam9PpsMTka0KNN8unbhOmmTY5dCjRpIpc7UT9ly6K6pjqiUsgJv7R64CL7Bjrnz+P2YnonfBF068igtkxc4l4iPA4P5lP8Fj4PD5gQx4DT87wAIzcmC8gIkyuwkBoVzZmiPhX/2aJ8cOFLpJ13Ir3cOJwCvkbJ8t1PsdvmyYKbsE5K5gzHmyoHqP/cl6+wrdC0uAdhxuVbcV5ushbt0nNGJUHsipjUJKnotMOg5enyzIqSYc40chBkhQAnLdvbDw8Rr2b2z0oT72XXdU25WRA2DK8LCUND28YQ53uWHeY35MPFJN/0BWHeMR1WvtYWJVF5LaUkIKZLlbSjv2ceN4c24vTn974ooCSh/yIgU0dbNZJb3lw+Y1yfIirIRIYpGOs26o2t7QY63mzinliPRpZ8JSwSJWxjPMzgwYVswAUU45sNb1A==
X-Forefront-Antispam-Report: 
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(56012099006)(10067099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	kYgqq+paqiwp3xMdCRJgfMGA9cA+1BNSOuQnUzNu2fSZfzh8arpY2/g4GoGx8cPy7c9aMhuZILbjy7UIf5HEKp1ASCeHWHwS1F1CsXsd6H8G+V//00bMBTSjH8qgu9RNJp6YCenSwXG9s2oMnPYrElJdCqhc6Gi5RI4Xavfc/jl3NMHMQzvRJKCvnsqANtMJwurtdmQ/Jv0hxNA+bka1otDQpySwhDJqT0yxEGko3ge/DzfH9m//sDay2yH5YuC6SfIIRynH1eY/Zzo/QpVC7IQbjOjHVtJjRWTigbWC+7uLZpXSQT+lglJ5Jr8fIv96rEFq+UqtPAkFHYgUHMIvmv7RB69wCxzlKssqV1TgSiFe3HltFq+3Nqqtl2Cc+QFoCNrKOb5crYLYVCNOnhzAJE6en/8TNMCRZ+R1pm+fxgk0sDOfXpxX28SMWXi9Nrt5
X-Exchange-RoutingPolicyChecked: 
	HSISaARxKAVPie+D6QzNxqE8VCAWtqeSGraABAw4jyQuhpvfvlvYQ1b2Sd9Sf9gF1nOpL6ITprFaPCS67nKl19sT7mleTEE/8oxt1x866ACadfMVX9m0UBiJCE6L0XVCbWhNARPWaTkga++OeJlkP/Ju41BRwyR346aogFee+T8wFzQwcogrGGtLLSVvtPjDcc1DtroE3VBYd6vf4m3G33/mKwTErJq2nTNJcPmerb90hvsdTr3PIoFuWX0t0m6AIkA7EDalBoCGKncaG78epD1te8KHu2q1hdmT12/BnIGiIXJqMa0fezq4V1dtepmrusTrpZt1dZCeSpZ6xzuWCg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 02:15:01.1551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 73b9aa62-f0a5-456b-bf42-08def8e0ae39
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6366
X-Authority-Analysis: v=2.4 cv=JPQLdcKb c=1 sm=1 tr=0 ts=6a7d28a9 cx=c_pps
 a=fY0JyvE1RNjZr0fjhzOn9Q==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=JsoGBFPoK0t6TsxPe1EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDAxNCBTYWx0ZWRfX33br18Rz1iJn
 x/Jo7k/Q2Yq/p+rHX0XU7Fd0Iw5QiuXe4FBXPfBkWF4XKwSi54Tt2jlY5HUcIAh+nvd4aiQujqU
 j4D23cR/xhjDEMue2pwDRuyDz9fjLZI=
X-Proofpoint-GUID: 0pg5DrtS4XOZoOK3P_0-uv7q9qk42YTw
X-Proofpoint-ORIG-GUID: 0pg5DrtS4XOZoOK3P_0-uv7q9qk42YTw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDAxNCBTYWx0ZWRfX59mlgdAbC8SH
 rJZd8Evr1J0JWOF3+BPTphsiTAhstyBhidlccQvVKnWYTl0gXnN+ltDGN6A1vZYSh64u2o+WDOh
 O7a/WgvQdWgF+H3FQHj47p/FrBQ1Q6Y22m62EvCsvOcfadAJFaR5Lb7tuuSl9GeXi8/rjj7kDvK
 ZLG6pOluSUya4H6VbdRvTBJebQjxDgz2aWp/U4ze13AVnTmNoF6SqMkblHb57w4EhzyhiOw5f95
 l44ig7NzvFVyeyQhqtUrpuSH38Uic0pVUqg2WsObEi0mW3gomILL4mZuEaG/ESQDzKkTVW5JKh8
 y2ADDhHKlDbA3R9QQAGhdu2v5iOnHFHV/gaBmib+7eDDSc0wxecs4F2LZhUR2X/1SLF8uynCAsJ
 8w4LvEN4hDC69ltMVmTd2KIeBSc4MMU5s7ZAQcTPDuGZVnrKKwjFm+j1uXcKwDD6ImHar6gtZ5r
 +ank6sl/wtcw0T031Fg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_07,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130014
X-MailFrom: baojun.xu@ti.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: K7H57QHEE6XK7PTJ6R6NWMSSLN53MYV7
X-Message-ID-Hash: K7H57QHEE6XK7PTJ6R6NWMSSLN53MYV7
X-Mailman-Approved-At: Mon, 17 Aug 2026 16:57:23 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/K7H57QHEE6XK7PTJ6R6NWMSSLN53MYV7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Currently, the firmware download is unnecessarily triggered on every
system resume from suspend, causing significant wake-up latency. However,
this step is redundant if the AMP remains powered on. Furthermore, certain
memory pages (addresses > 0xc60000) are skipped even after an AMP reset.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
v2:
 - Update register address from 0x07 to 7 and keep the line within the
   80-character limit.‌
 - ‌Remove stray/unnecessary changes.‌
 - ‌Change variable type to unsigned int to comply with API requirements.‌
 - ‌Replace usleep_range() with fsleep().‌
 - ‌Set idle_bias_on to 0 to enable low-power mode.
 - Reactivate the AMP after resume.
---
 sound/soc/codecs/tas2783-sdw.c | 55 ++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/tas2783-sdw.c b/sound/soc/codecs/tas2783-sdw.c
index c217da5fccdf..8fc679d460d9 100644
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
@@ -783,14 +784,16 @@ static void tas2783_fw_ready(const struct firmware *fmw, void *context)
 			file->version, file->length,
 			file->dest_addr, file->fw_data);
 
-		ret = sdw_nwrite_no_pm(tas_dev->sdw_peripheral,
-				       file->dest_addr,
-				       file->length,
-				       file->fw_data);
-		if (ret < 0) {
-			dev_err(tas_dev->dev,
-				"FW download failed: %d", ret);
-			break;
+		if (!tas_dev->first_hw_init || file->dest_addr < 0xc60000) {
+			ret = sdw_nwrite_no_pm(tas_dev->sdw_peripheral,
+					       file->dest_addr,
+					       file->length,
+					       file->fw_data);
+			if (ret < 0) {
+				dev_err(tas_dev->dev,
+					"FW download failed: %d", ret);
+				break;
+			}
 		}
 		cur_file++;
 	}
@@ -801,6 +804,8 @@ static void tas2783_fw_ready(const struct firmware *fmw, void *context)
 		ret = -EINVAL;
 	} else {
 		tas2783_update_calibdata(tas_dev);
+		regmap_write(tas_dev->regmap, TASDEV_REG_SDW(0, 0, 7), 0x22);
+		tas_dev->first_hw_init = true;
 	}
 
 out:
@@ -940,7 +945,7 @@ static s32 tas_sdw_hw_params(struct snd_pcm_substream *substream,
 							TAS2783_SDCA_POW_STATE_ON);
 			if (!ret)
 				break;
-			usleep_range(2000, 2200);
+			fsleep(2200);
 		} while (retry--);
 	}
 
@@ -1038,7 +1043,7 @@ static const struct snd_soc_component_driver soc_codec_driver_tasdevice = {
 	.num_dapm_widgets = ARRAY_SIZE(tas_dapm_widgets),
 	.dapm_routes = tas_audio_map,
 	.num_dapm_routes = ARRAY_SIZE(tas_audio_map),
-	.idle_bias_on = 1,
+	.idle_bias_on = 0,
 	.endianness = 1,
 };
 
@@ -1171,25 +1176,29 @@ static s32 tas_fw_load(struct tas2783_prv *tas_dev, struct sdw_slave *slave)
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
@@ -1197,7 +1206,8 @@ static s32 tas_io_init(struct device *dev, struct sdw_slave *slave)
 		else
 			ret = regmap_multi_reg_write(tas_dev->regmap, tas2783_init_seq,
 						     ARRAY_SIZE(tas2783_init_seq));
-
+		/* Re-active AMP after resume. */
+		regmap_write(tas_dev->regmap, TASDEV_REG_SDW(0, 0, 2), 0);
 		if (ret)
 			dev_err(tas_dev->dev,
 				"init writes failed, err=%d", ret);
@@ -1357,6 +1367,7 @@ static s32 tas_sdw_probe(struct sdw_slave *peripheral,
 	tas_dev->dev = dev;
 	tas_dev->sdw_peripheral = peripheral;
 	tas_dev->hw_init = false;
+	tas_dev->first_hw_init = false;
 	mutex_init(&tas_dev->calib_lock);
 	mutex_init(&tas_dev->pde_lock);
 
-- 
2.25.1

