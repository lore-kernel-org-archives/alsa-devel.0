Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B27C44514
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jul 2026 07:40:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8210E601FA;
	Fri, 17 Jul 2026 09:40:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8210E601FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784274046;
	bh=Y6ZNDU3vCf/SXPQGA+5dN2ylLY0WsYsbH4Mo9OCboZ4=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Ni9N4BYRG7ApXnUb+EXNWPEXLYwSdmhiNzR0kQGzyrwj1hqk9fZjuVo2fZFWm/PFk
	 isys3R0OIthtiw3WUXLu4huFaFU+2aYxFj+N2Nl1AQsjZ5OL4gufr0nyLEpuUR/rkE
	 oQD7a+TpKJT6x53RHy2pXFfYaw+4WONVdl0fsprw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DB545F80601; Fri, 17 Jul 2026 09:40:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6F590F805ED;
	Fri, 17 Jul 2026 09:40:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D24DBF80526; Fri, 17 Jul 2026 09:40:06 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1784274002;
	b=f6dO1MyLP6QBHUSMQIwaEsU0Q5wlFHLloex32nEfEDG+cwjyQ9jBeabo9aWiL6QRgWtF
	 Zh1uv6Qa5rw7dPfkcsZYhgAcgdgfiLLZ5ss5p4O3umX20PDtFv6yzjpN4nxrr75vG6oCS
	 7Efpo/hRGRIsWKZmGikqKuzgl/75a3LV+ZoPvJcICOGRK84CqjtT7fGLwyZ6IR9SbOoIR
	 X7yh5ehLuI69Mo1ec8CxfPtEyp4rJWaYRzOv4rcSKRzXoMzxX26gTLNH1Ny0oi5HGrDzX
	 T41VQcXMHPiRzDGG591nbRm8MXg9sYYm894eKAf0jD0NwPreb5C+KRBncW+uz/ywEsA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784274002;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version;
	bh=Y6ZNDU3vCf/SXPQGA+5dN2ylLY0WsYsbH4Mo9OCboZ4=;
	b=klYcIGKWU1NN26pJQjMEzrAmvFnoJioidwfoM77z7R39QaZGni0ObVQAygAT99T7cma3
	 3j3TPUbv6n8/BpHutqAV6DH42DksP5MNDXrU6radQoEZ8NiJr5DzO7dImMkfqm0THDlxn
	 H87dqfRO5xDwzibfME0w01YUQANKm5dBykDGaT4lAr2ZS7Zj/ZZl0kCyp7GB4TS7/I87h
	 kJMeqK9r05ZWG2WOcaGiWHIetU7wN3f1WqVZZjbEKazW7c+Yq/puApKF3z6ZrDqNePPxO
	 zuCQLf1sg3Kby3P/2j0ODnDmsOYoRVCxuCyl5KNW3ZxdZJx6vyMxmh+c+uOGmYEmgGA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=lZsvl28V;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=uiMGeue9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0CB58F8047D
	for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2026 09:40:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0CB58F8047D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=lZsvl28V;
	dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=uiMGeue9
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66H6aZvx1797945;
	Fri, 17 Jul 2026 02:39:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=dV7GgMdNpU0uK
	1tk35sA2U4QQOBEisQXkpUoWjXP9IA=; b=lZsvl28Vi0Iurp6dsKK4p29SQNrWS
	FkOBiGl1x4WlTu6zh1oaWFqrFxNKD+pwtWskGSz2J363IKhmBrWqCZqfQyMspQdI
	Z3bUN3wh+VyKGXv49ZapUGccwt76zm8VCZruJtMtlqwc9neabnXsxUUlk9huGKhq
	HmRxXr5SMUmqGggVQteyKuYWYke1ZR0kXODKfckvBLP/iulYQJ7pzS93YSZnRimt
	FkLpxK+24OvHnpFteYoNdB3XPVG51rMJq/zuycCjgm2YVpCHJJajCxdKSEtsJBiB
	L/F+OT/VeQ81Hb0ONs1zfS6BRddB3SUg0Px+1ykZNcptj+l104bKBVu3Q==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012038.outbound.protection.outlook.com
 [40.107.200.38])
	by m0380145.ppops.net (PPS) with ESMTPS id 4fex78dsk8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 02:39:53 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRsZBpCLHuvP6DEbQp+t40BLva9ztJo8UXsLvitnGmYX/2CAYgnEKre+Uneg26v3n0TJjqigAQiMcD8jLVaxO7ZR+lKIUrZmbxa5odh3uVSEhSCN+xBu1OtqivN4sYzO1zKts/75C2ftOa6Kpo1W9AdiycG1SxUSdGnEaGjZl+IoT8t05+npxGfGb79QEqVS5IzIgO4/hUYCg8YLIpGH4QRrK2sP1N/oqUSuVLcJbAG+GNTNF/2czX5g7UHT5fbPxWYXQ+1MzEvnxtd8+9vYjPAalZpTQbHhl3Q+TV26/QeBHYWHTaa7jDqvXGHEdqGzev6GAhJ0hwS0QoAF2n9Zqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dV7GgMdNpU0uK1tk35sA2U4QQOBEisQXkpUoWjXP9IA=;
 b=krZr7qrJNn+2fDaTY25xUBJrio/LTOw83FRAho1/xeghXfpMmvJ8mKG3el5NX/v6UKMa0mUBYsiO8txSjYcVHGP5OAiaq1QkYt8n3G9yYrgXq62sp4XpIfqIM1eK1iaZB8e0eO8GL8UcPVfuhSsV7c8v46dhfFF6bRQ7dF5VAvNEAHCPP/VcyiNp7wtFJRyZqnGrb9ehK+hAAV8bhyDMNnZXbk42vX0jrTWDd1XMvstDQtFpj/pCjpP87s/VdHZQBF2YMxkwQiPiiU+VPYJEY71N7OdM/8D0aPZJkFkeAJhieqGNRYStFE5EXwDZV8auMM6RU1+RhWCSdCTPORYCWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=alsa-project.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dV7GgMdNpU0uK1tk35sA2U4QQOBEisQXkpUoWjXP9IA=;
 b=uiMGeue9eC3hpqq+dAfOpZhI75OkrOmTstiWUJMr+T6zCwqriPee7apUJp4SLf4d6ynZPwgPSo9xNM6p6jPiYGx9NkF5VGvjRBSl9JowFjBjMvMaTzHrX4OSPnMyYvRvUsVdAD+jNmb2WNiqy9nCfpAjVDPVl4WbNv32LuGJBEA=
Received: from MW4PR03CA0224.namprd03.prod.outlook.com (2603:10b6:303:b9::19)
 by DS5PR10MB997731.namprd10.prod.outlook.com (2603:10b6:8:343::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 17 Jul
 2026 07:39:48 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:303:b9:cafe::a1) by MW4PR03CA0224.outlook.office365.com
 (2603:10b6:303:b9::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 07:39:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 07:39:47 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 02:39:45 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 02:39:45 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 02:39:45 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.160.253])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66H7dfMH3290886;
	Fri, 17 Jul 2026 02:39:42 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <broonie@kernel.org>
CC: <andriy.shevchenko@linux.intel.com>, <tiwai@suse.de>,
        <13916275206@139.com>, <krzk@kernel.org>,
        <alsa-devel@alsa-project.org>, <baojun.xu@ti.com>, <riyo@ti.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v1] ASoC: tas2781: Add calibration kcontrols for TAS2573
Date: Fri, 17 Jul 2026 15:39:27 +0800
Message-ID: <20260717073927.181-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|DS5PR10MB997731:EE_
X-MS-Office365-Filtering-Correlation-Id: ece123bc-b5e8-461b-1ec1-08dee3d693bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|56012099006|18002099003|10067099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: 
	4CX2TvfusyxS8tJY/FAIC7MnJAnxWvNY+PBqE2Hj6/Mdaey/34w4H2cFbxMTB7Vti8fBFYedSg7neqPOJzHRtKKfeQDZlMjQHlmlsu6vcgkvLBAcrkVwCsCCfLZSRpydFHHwxYLIGpnf5YHB14mT7dpqxu5R+H4R/rR4GciilW+Zl7rsxOg5nSXPOfkE5qwhsIWYTc7H6J9B/Qi1KfyYxPkJvmPHeIBPmhrnhcoAo0aTrwph6sxA87iPzxtYYTqx34+WgDYZgEmD2xucaCsQg1J3FW1vj+NNG8zYg25IfK33JptBQWO/gMimXaVlRmN4ufTcStAVAC0DrRvb0d6NzoSJYNT6Gtgq9MpCsVDRG4mMQW5E1mrz1ceSLzuESyvlIdXavJ+1zDxVN6JgvXtBwt/ND8ZICOm5FJPtlzVIoxKag/JIJDii58WGUOXocVrPF8kjYtjR/mjBfsrmXcG52EMQR3R0cRxGANfAsKwlGVOZNH4Vesqhh4GsBTGc6D07DDVea6LIoqDrOt4IHpMGGRe0zp5hieeS60Imh8pG7hGnBkO14pdwvwYwiUbwxWdJpy7S8wuAp85zavhd/FC2zKoFFyYk4ebRKyKCbQDZg64/ttXhYmlqGvIJf7GKJPO86WfC5EtNUV83B9mmse0ifEjb49fYqQvy4FnHo4UJ5G1YUEP9P6gHu4Z4B24NUNdnFtEHfrEXMNXOebVGWCSw6Q==
X-Forefront-Antispam-Report: 
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(56012099006)(18002099003)(10067099003)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	I/IEkIqUGVOymglHbl1ieFMAxeqX35VubkpTV8wjoM8At3cmJgLx2Nr9pQN2WyYGnBzuEnqlm/DcnhvDL3kH0WPU+0brmj0iUW8VLIDRHm7jmpy1Z0UJKw7g+jzmYwAyE472rDWyyLgS1WSNQKQwSCugc+hz79sTGmCNEhq6QeFRV0nwPWtr8jcdREPM5Wa2JdyxzALCsK63P0xRN6KXnF0qLvxSz6dWfK6vlbcQllHM/kJkYPNQ2d43+y+GPwywrZbcxcGja+WDvCIIGRQtUYJZo51sbvSU/A5fhvhMkrsVFbW3R1bsR+q8rEQLHju07Mql8S3BuK6fH77gZB7dCtQPCUK1iBAV4kxq9+ZPPN33KkDeGjTGsIwuQQOI/i5awJnWFkUgd2/767KL4Xx9VGNLZV9d/GgaKL9+FHlFWKi6xLaTLp+ax/FNY9cnG7FI
X-Exchange-RoutingPolicyChecked: 
	deZMVrhG8sr7NMSzGp3X4lV6Mllbl3h6m/iOqGKpPuhwgSsLGMJ/x0vcox6RcYMIcsB3UPKGym0TJB9ADoGiCCw5h1JjBGqz+U6GcTphmMnhjgXkRbqXvfdz+FxW53XsGhan9SZf7oR0TQE8kJFREyudteWbwhINrVd3JkpP4Mt783bh4/IWO+ZyzXwmYp1g7FcGyD/tINTzPk7qRh4NaQG0K2zfzbDlsPSJJCiDJgQ6J+Hay3qVXwkX8fecTtkOq+Gp2sybn7rvq07ULO1IdfUJbN3yExcEsMd6s2XkjMSUflAhZIB+U1jKeEbarhDR/LdU6OmpCUGzx9k9bNfaaw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 07:39:47.3078
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ece123bc-b5e8-461b-1ec1-08dee3d693bd
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PR10MB997731
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDA3NCBTYWx0ZWRfX4tu8/cGKmp6j
 1UQ021gTcGhg+akAgAoPUjCgLHWxkmD96iZRl4oo7lCmc+rZVy6rBgci9bAmIFCurrEBaDJApX2
 H9Tm4aMJkBt0KO7CvykJKvIO3oZxjAIBWOVUQPALD2aoXU0BFnhF9EUOWkR6iBrLcF5F4NlO38H
 S+NswMrw0X8j5cs6/jbfb8jtz02TfPr5dFaAxObN4QB04cJ21J+o4+HIpX7dd43ZFRhisoBC9A2
 aj/rTgq6HuQcFrnjluhVDIzx9krIwe3eoGw5FPTmJBUI+AC6/vNkavWh/p+I0uxP2VGdjM6HdrT
 DgUcjiLCLbGpYWTN6180awUudOHMkKjvCizhOm2VnLzZj1bzb3BzckgWvQB5lJfGLktUf6kBut9
 VTf9VLqte/0DkT3BTTAa3FzZmv4Lf05P5kc4GkuDMkDWLGtdEp5wjXwjarpAenOcf8khaVINAMe
 jY/uSNxYXcf/T3kh0Iw==
X-Proofpoint-GUID: liaNHX_KGJhpI3WuXoy-x_6ayUylvB_f
X-Authority-Analysis: v=2.4 cv=TeamcxQh c=1 sm=1 tr=0 ts=6a59dc49 cx=c_pps
 a=xHz2x/H0+t1Z4EfVAX8SiQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=zQe6G8QG1zcRxQ_4CB4A:9
X-Proofpoint-ORIG-GUID: liaNHX_KGJhpI3WuXoy-x_6ayUylvB_f
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDA3NCBTYWx0ZWRfXzwJ9z68otzDD
 mpShQRCRLieegNo6lBHbPo04N98p9kmmVQ6iqQso2PQMq64OSPAFX9zuuvuE8QRl/rnNtwNVOnU
 K1JDx14GRPE11YqVCWT6EXNSY5Hzn80=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 malwarescore=0 bulkscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170074
Message-ID-Hash: VTFWF5OSHCSKH5AS4FZRB6HZ7H46F4AL
X-Message-ID-Hash: VTFWF5OSHCSKH5AS4FZRB6HZ7H46F4AL
X-MailFrom: shenghao-ding@ti.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VTFWF5OSHCSKH5AS4FZRB6HZ7H46F4AL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add calibration kcontrols for TAS2573 in TAS2781 driver to support
device-specific calibration settings.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
---
 include/sound/tas2781-dsp.h       |   2 +
 include/sound/tas2781.h           |  25 +++
 sound/soc/codecs/tas2781-fmwlib.c |  28 ++-
 sound/soc/codecs/tas2781-i2c.c    | 290 +++++++++++++++++++++++++-----
 4 files changed, 295 insertions(+), 50 deletions(-)

diff --git a/include/sound/tas2781-dsp.h b/include/sound/tas2781-dsp.h
index dd6ee45ad096..5f3197f83a34 100644
--- a/include/sound/tas2781-dsp.h
+++ b/include/sound/tas2781-dsp.h
@@ -142,6 +142,7 @@ struct tasdevice_fw {
 	struct tasdevice_calibration *calibrations;
 	struct fct_param_address fct_par_addr;
 	struct device *dev;
+	int calibration_config_id;
 };
 
 enum tasdevice_fw_state {
@@ -201,6 +202,7 @@ struct tasdevice_rca {
 	int ncfgs;
 	struct tasdevice_config_info **cfg_info;
 	int profile_cfg_id;
+	int calibration_profile_id;
 	/*
 	 * Since version 0x105, the keyword 'init' was introduced into the
 	 * profile, which is used for chip initialization, particularly to
diff --git a/include/sound/tas2781.h b/include/sound/tas2781.h
index b763da613769..d9fa3e02bfd5 100644
--- a/include/sound/tas2781.h
+++ b/include/sound/tas2781.h
@@ -17,6 +17,8 @@
 #ifndef __TAS2781_H__
 #define __TAS2781_H__
 
+#define CONFIG_SND_SOC_TAS2781_ACOUST_I2C
+
 #ifdef CONFIG_SND_SOC_TAS2781_ACOUST_I2C
 #include <linux/debugfs.h>
 #endif
@@ -91,6 +93,29 @@
 /* prm_TE_1_Beta1 */
 #define TAS2563_TE_DT_REG		TASDEVICE_REG(0x00, 0x0f, 0x70)
 
+#define TAS2573_FCT_INT_LATCH		TASDEVICE_REG(0x00, 0x00, 0x67)
+// YM147
+#define TAS2573_FCT_STATUS_CTRL		TASDEVICE_REG(0x00, 0x68, 0x74)
+// YM148
+#define TAS2573_FCT_STATUS_BINNING	TASDEVICE_REG(0x00, 0x68, 0x78)
+// YM57
+#define TAS2573_FCT_OUTPUT_R0		TASDEVICE_REG(0x00, 0x65, 0x74)
+// YM58
+#define TAS2573_FCT_OUTPUT_R0_LOW	TASDEVICE_REG(0x00, 0x65, 0x78)
+// YM59
+#define TAS2573_FCT_OUTPUT_INV_R0	TASDEVICE_REG(0x00, 0x65, 0x7C)
+// YM61
+#define TAS2573_FCT_OUTPUT_POWERTOT	TASDEVICE_REG(0x00, 0x66, 0x0C)
+// YM64
+#define TAS2573_FCT_OUTPUT_F0		TASDEVICE_REG(0x00, 0x65, 0x18)
+// YM952
+#define TAS2573_SILENCE_DETECTED	TASDEVICE_REG(0x00, 0x83, 0x60)
+// YM954
+#define TAS2573_OPEN_CIRCUIT		TASDEVICE_REG(0x00, 0x83, 0x68)
+// YM955
+#define TAS2573_SHORTCKT		TASDEVICE_REG(0x00, 0x83, 0x6C)
+
+
 #define TAS2781_PRM_INT_MASK_REG	TASDEVICE_REG(0x00, 0x00, 0x3b)
 #define TAS2781_PRM_CLK_CFG_REG		TASDEVICE_REG(0x00, 0x00, 0x5c)
 #define TAS2781_PRM_RSVD_REG		TASDEVICE_REG(0x00, 0x01, 0x19)
diff --git a/sound/soc/codecs/tas2781-fmwlib.c b/sound/soc/codecs/tas2781-fmwlib.c
index bd16d5326a23..95cfcd72dfe5 100644
--- a/sound/soc/codecs/tas2781-fmwlib.c
+++ b/sound/soc/codecs/tas2781-fmwlib.c
@@ -199,14 +199,20 @@ static struct tasdevice_config_info *tasdevice_add_config(
 			goto out;
 		}
 		/* If in the RCA bin file are several profiles with the
-		 * keyword "init", init_profile_id only store the last
-		 * init profile id.
+		 * keyword "init"/"calib", init_profile_id only store the last
+		 * init profile id, and same as calibration_profile_id.
 		 */
 		if (strnstr(&config_data[config_offset], "init", 64)) {
 			tas_priv->rcabin.init_profile_id =
 				tas_priv->rcabin.ncfgs - 1;
 			dev_dbg(tas_priv->dev, "%s: init profile id = %d\n",
 				__func__, tas_priv->rcabin.init_profile_id);
+		} else if (strnstr(&config_data[config_offset], "calib", 64)) {
+			tas_priv->rcabin.calibration_profile_id =
+				tas_priv->rcabin.ncfgs - 1;
+			dev_dbg(tas_priv->dev, "%s: calib profile id = %d\n",
+				__func__,
+				tas_priv->rcabin.calibration_profile_id);
 		}
 		config_offset += 64;
 	}
@@ -631,6 +637,15 @@ static int fw_parse_configuration_data_kernel(
 			goto out;
 		}
 		memcpy(config->name, &data[offset], 64);
+		/* If in the coef bin file are several configs with the
+		 * keyword "calib", init_profile_id only store the last
+		 * init profile id, and same as calibration_profile_id.
+		 */
+		if (strnstr(config->name, "calib", 64)) {
+			tas_fmw->calibration_config_id = i;
+			dev_dbg(tas_priv->dev, "%s: calib cofig id = %d\n",
+				__func__, tas_fmw->calibration_config_id);
+		}
 		/*skip extra 16 bytes*/
 		offset += 80;
 
@@ -1371,6 +1386,15 @@ static int fw_parse_configuration_data(
 		}
 		memcpy(config->name, &data[offset], 64);
 		offset += 64;
+		/* If in the coef bin file are several configs with the
+		 * keyword "calib", init_profile_id only store the last
+		 * init profile id, and same as calibration_profile_id.
+		 */
+		if (strnstr(config->name, "calib", 64)) {
+			tas_fmw->calibration_config_id = i;
+			dev_dbg(tas_priv->dev, "%s: calib cofig id = %d\n",
+				__func__, tas_fmw->calibration_config_id);
+		}
 
 		n = strlen((char *)&data[offset]);
 		n += 15;
diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index 9e6f0ad5f05d..88a675117485 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -612,17 +612,68 @@ static void tas2563_calib_stop_put(struct tasdevice_priv *tas_priv)
 	}
 }
 
+static void tas2573_calib_stop_put(struct tasdevice_priv *tas_priv)
+{
+	// const int sum = ARRAY_SIZE(tas2563_cali_start_reg);
+	int cal_prof_id = tas_priv->rcabin.calibration_profile_id;
+
+	tasdevice_select_cfg_blk(tas_priv, cal_prof_id,
+		TASDEVICE_BIN_BLK_PRE_SHUTDOWN);
+}
+
+static int tas2573_calib_start_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *comp = snd_kcontrol_chip(kcontrol);
+	struct tasdevice_priv *tas_priv = snd_soc_component_get_drvdata(comp);
+	int cal_prof_id = tas_priv->rcabin.calibration_profile_id;
+	int cal_conf_id = tas_priv->fmw->calibration_config_id;
+
+	guard(mutex)(&tas_priv->codec_lock);
+	if (tas_priv->chip_id != TAS2573)
+		return -1;
+
+	tasdevice_select_tuningprm_cfg(tas_priv, tas_priv->cur_prog,
+		cal_conf_id, cal_prof_id);
+
+	tasdevice_select_cfg_blk(tas_priv, cal_prof_id,
+		TASDEVICE_BIN_BLK_PRE_POWER_UP);
+
+	return 1;
+}
+
+
 static int tasdev_calib_stop_put(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *comp = snd_kcontrol_chip(kcontrol);
 	struct tasdevice_priv *priv = snd_soc_component_get_drvdata(comp);
+	int i;
 
 	guard(mutex)(&priv->codec_lock);
-	if (priv->chip_id == TAS2563)
+
+	switch (priv->chip_id) {
+	case TAS2563:
 		tas2563_calib_stop_put(priv);
-	else
+		break;
+	case TAS2573:
+		tas2573_calib_stop_put(priv);
+		break;
+	case TAS2781:
 		tas2781_calib_stop_put(priv);
+		break;
+	default:
+		dev_err(priv->dev, "%s: Chip(%d) unsupports calibration\n",
+			__func__, priv->chip_id);
+		return -1;
+	}
+
+	/*
+	 * Set reloading-firmware flag after calibration, the flag will work
+	 * during next playback, then set to the program id after reloading.
+	 */
+	for (i = 0; i < priv->ndev; i++)
+		priv->tasdevice[i].cur_prog = -1;
 
 	return 1;
 }
@@ -978,6 +1029,11 @@ static const struct snd_kcontrol_new tas2563_cali_controls[] = {
 		tasdev_nop_get, tas2563_calib_start_put),
 };
 
+static const struct snd_kcontrol_new tas2573_cali_controls[] = {
+	SOC_SINGLE_EXT("Calibration Start", SND_SOC_NOPM, 0, 1, 0,
+		tasdev_nop_get, tas2573_calib_start_put),
+};
+
 static int tasdevice_set_profile_id(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
@@ -1330,6 +1386,145 @@ static void alpa_cali_update(struct bulk_reg_val *p,
 	p->val_len = 4;
 }
 
+static int create_tas2781_cali_start_ktrl(struct tasdevice_priv
+	*priv, struct snd_kcontrol_new *cali_ctrl)
+{
+	struct soc_bytes_ext *ext_cali_start;
+	char *cali_start_name;
+
+	ext_cali_start = devm_kzalloc(priv->dev,
+		sizeof(*ext_cali_start), GFP_KERNEL);
+	if (!ext_cali_start)
+		return -ENOMEM;
+
+	cali_start_name = devm_kstrdup(priv->dev,
+		"Calibration Start", GFP_KERNEL);
+	if (!cali_start_name)
+		return -ENOMEM;
+	/*
+	 * package structure for tas2781 ftc start:
+	 *	Pkg len (1 byte)
+	 *	Reg id (1 byte, constant 'r')
+	 *	book, page, register for pilot threshold, pilot tone
+	 *		and sine gain (12 bytes)
+	 *	for (i = 0; i < Device-Sum; i++) {
+	 *		Device #i index_info (1 byte)
+	 *		Sine gain for Device #i (8 bytes)
+	 *	}
+	 */
+	ext_cali_start->max = 14 + priv->ndev * 9;
+	cali_ctrl->name = cali_start_name;
+	cali_ctrl->iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	cali_ctrl->info = snd_soc_bytes_info_ext;
+	cali_ctrl->put = tas2781_calib_start_put;
+	cali_ctrl->get = tasdev_nop_get;
+	cali_ctrl->private_value = (unsigned long)ext_cali_start;
+
+	return 0;
+}
+
+static int tas2573_calib_status_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *comp = snd_kcontrol_chip(kcontrol);
+	struct tasdevice_priv *priv = snd_soc_component_get_drvdata(comp);
+	unsigned char *dst = ucontrol->value.bytes.data;
+	struct soc_bytes_ext *bytes_ext =
+		(struct soc_bytes_ext *) kcontrol->private_value;
+	unsigned int fct_status_regs[] = {
+		TAS2573_FCT_INT_LATCH,
+		TAS2573_FCT_STATUS_CTRL,
+		TAS2573_FCT_STATUS_BINNING,
+		TAS2573_SILENCE_DETECTED,
+		TAS2573_OPEN_CIRCUIT,
+		TAS2573_SHORTCKT,
+		TAS2573_FCT_OUTPUT_R0,
+		TAS2573_FCT_OUTPUT_R0_LOW,
+		TAS2573_FCT_OUTPUT_INV_R0,
+		TAS2573_FCT_OUTPUT_POWERTOT,
+		TAS2573_FCT_OUTPUT_F0,
+	};
+	unsigned int j, k, val;
+	unsigned int i = 0;
+	int rc;
+
+	guard(mutex)(&priv->codec_lock);
+	dst[i++] = bytes_ext->max;
+	dst[i++] = 'r';
+
+	for (j = 0; j < ARRAY_SIZE(fct_status_regs); j++) {
+		dst[i++] = TASDEVICE_BOOK_ID(fct_status_regs[j]);
+		dst[i++] = TASDEVICE_PAGE_ID(fct_status_regs[j]);
+		dst[i++] = TASDEVICE_PAGE_REG(fct_status_regs[j]);
+	}
+	dst[i++] = 'D';
+
+	for (j = 0; j < priv->ndev; j++) {
+		dst[i++] = j;
+		dst[i++] = 0;
+		dst[i++] = 0;
+		dst[i++] = 0;
+
+		rc = tasdevice_dev_read(priv, j, fct_status_regs[0], &val);
+		if (rc < 0)
+			dev_err(priv->dev,
+				"chn %d fct_status_regs[0] rd err = %d\n",
+				j, rc);
+		else
+			dst[i++] = val;
+
+		for (k = 1; k < ARRAY_SIZE(fct_status_regs); k++, i += 4) {
+			rc = tasdevice_dev_bulk_read(priv, j,
+				fct_status_regs[k], &dst[i], 4);
+			if (rc < 0) {
+				dev_err(priv->dev,
+					"chn %d regs[%u] bulk_rd err = %d\n",
+					j, k, rc);
+			}
+		}
+
+	}
+
+	return 0;
+}
+
+static int create_tas2573_cali_status_ktrl(struct tasdevice_priv
+	*priv, struct snd_kcontrol_new *cali_ctrl)
+{
+	struct soc_bytes_ext *ext_cali_start;
+	char *cali_start_name;
+
+	ext_cali_start = devm_kzalloc(priv->dev,
+		sizeof(*ext_cali_start), GFP_KERNEL);
+	if (!ext_cali_start)
+		return -ENOMEM;
+
+	cali_start_name = devm_kstrdup(priv->dev,
+		"Calibration Status", GFP_KERNEL);
+	if (!cali_start_name)
+		return -ENOMEM;
+	/*
+	 * package structure for tas2573 fct status:
+	 *	Pkg len (1 byte)
+	 *	Reg id (1 byte, constant 'r')
+	 *	book, page, register for fct status (total 33 bytes)
+	 *	Data Start Flag (1 byte, constant 'D')
+	 *	for (i = 0; i < Device-Sum; i++) {
+	 *		Device #i index_info (1 byte)
+	 *		Sine gain for Device #i (44 bytes)
+	 *	}
+	 */
+	ext_cali_start->max = 36 + priv->ndev * 45;
+	cali_ctrl->name = cali_start_name;
+	cali_ctrl->iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	cali_ctrl->info = snd_soc_bytes_info_ext;
+	cali_ctrl->put = NULL;
+	cali_ctrl->get = tas2573_calib_status_get;
+	cali_ctrl->private_value = (unsigned long)ext_cali_start;
+
+	return 0;
+}
+
 static int tasdevice_create_cali_ctrls(struct tasdevice_priv *priv)
 {
 	struct calidata *cali_data = &priv->cali_data;
@@ -1349,7 +1544,24 @@ static int tasdevice_create_cali_ctrls(struct tasdevice_priv *priv)
 		return rc;
 	}
 
-	if (priv->chip_id == TAS2781) {
+	switch (priv->chip_id) {
+	case TAS2563: {
+		cali_ctrls = (struct snd_kcontrol_new *)tas2563_cali_controls;
+		nctrls = ARRAY_SIZE(tas2563_cali_controls);
+		for (i = 0; i < priv->ndev; i++) {
+			tasdev[i].cali_data_backup =
+				kmemdup(tas2563_cali_start_reg,
+				sizeof(tas2563_cali_start_reg), GFP_KERNEL);
+			if (!tasdev[i].cali_data_backup)
+				return -ENOMEM;
+		}
+	}
+		break;
+	case TAS2573:
+		cali_ctrls = (struct snd_kcontrol_new *)tas2573_cali_controls;
+		nctrls = ARRAY_SIZE(tas2573_cali_controls);
+		break;
+	case TAS2781: {
 		struct fct_param_address *t = &(fmw->fct_par_addr);
 
 		cali_ctrls = (struct snd_kcontrol_new *)tas2781_cali_controls;
@@ -1370,31 +1582,32 @@ static int tasdevice_create_cali_ctrls(struct tasdevice_priv *priv)
 				}
 			}
 		}
-	} else {
-		cali_ctrls = (struct snd_kcontrol_new *)tas2563_cali_controls;
-		nctrls = ARRAY_SIZE(tas2563_cali_controls);
-		for (i = 0; i < priv->ndev; i++) {
-			tasdev[i].cali_data_backup =
-				kmemdup(tas2563_cali_start_reg,
-				sizeof(tas2563_cali_start_reg), GFP_KERNEL);
-			if (!tasdev[i].cali_data_backup)
-				return -ENOMEM;
-		}
+	}
+		break;
+	default:
+		dev_err(priv->dev, "%s: Wrong chip id = %d", __func__,
+			priv->chip_id);
+		return -EINVAL;
 	}
 
 	rc = snd_soc_add_component_controls(priv->codec, cali_ctrls, nctrls);
 	if (rc < 0) {
 		dev_err(priv->dev, "%s: Add chip cali ctrls err rc = %d",
-			__func__, rc);
+			__func__, priv->chip_id);
 		return rc;
 	}
 
 	/* index for cali_ctrls */
 	i = 0;
-	if (priv->chip_id == TAS2781)
+	switch (priv->chip_id) {
+	case TAS2573:
+	case TAS2781:
 		nctrls = 2;
-	else
+		break;
+	default:
 		nctrls = 1;
+		break;
+	}
 
 	/*
 	 * Alloc kcontrol via devm_kzalloc(), which don't manually
@@ -1447,40 +1660,21 @@ static int tasdevice_create_cali_ctrls(struct tasdevice_priv *priv)
 	 * it, for the default value is 0, which means the first device.
 	 */
 	cali_data->data[0] = 0xff;
-	if (priv->chip_id == TAS2781) {
-		struct soc_bytes_ext *ext_cali_start;
-		char *cali_start_name;
-
-		ext_cali_start = devm_kzalloc(priv->dev,
-			sizeof(*ext_cali_start), GFP_KERNEL);
-		if (!ext_cali_start)
-			return -ENOMEM;
-
-		cali_start_name = devm_kstrdup(priv->dev,
-			"Calibration Start", GFP_KERNEL);
-		if (!cali_start_name)
-			return -ENOMEM;
-		/*
-		 * package structure for tas2781 ftc start:
-		 *	Pkg len (1 byte)
-		 *	Reg id (1 byte, constant 'r')
-		 *	book, page, register for pilot threshold, pilot tone
-		 *		and sine gain (12 bytes)
-		 *	for (i = 0; i < Device-Sum; i++) {
-		 *		Device #i index_info (1 byte)
-		 *		Sine gain for Device #i (8 bytes)
-		 *	}
-		 */
-		ext_cali_start->max = 14 + priv->ndev * 9;
-		cali_ctrls[i].name = cali_start_name;
-		cali_ctrls[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
-		cali_ctrls[i].info = snd_soc_bytes_info_ext;
-		cali_ctrls[i].put = tas2781_calib_start_put;
-		cali_ctrls[i].get = tasdev_nop_get;
-		cali_ctrls[i].private_value = (unsigned long)ext_cali_start;
+
+	switch (priv->chip_id) {
+	case TAS2573:
+		rc = create_tas2573_cali_status_ktrl(priv, &cali_ctrls[i]);
+		if (rc != 0)
+			return rc;
+		i++;
+		break;
+	case TAS2781:
+		rc = create_tas2781_cali_start_ktrl(priv, &cali_ctrls[i]);
+		if (rc != 0)
+			return rc;
 		i++;
+		break;
 	}
-
 	return snd_soc_add_component_controls(priv->codec, cali_ctrls,
 		nctrls < i ? nctrls : i);
 }
-- 
2.43.0

