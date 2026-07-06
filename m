Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2038C43602
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jul 2026 14:16:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 76C8F60204;
	Mon,  6 Jul 2026 16:16:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 76C8F60204
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783347377;
	bh=OtjCKAGlR6iyaO/EJsuyUyVVJbhpqjt2MpRxqCmjzmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ZhgstLd20DmGta0DDEOsGozN2HaATMhvOLK+flBFMxr83P2ffEFQl7Gu172uNp1iu
	 jAzNrHSQdUEjCIeI1AKHJrSqP+8A5AdnC87PiLbI3qkBPBh/wVvzwBUs4sM1MUkdWw
	 r1Cv+xO0KsOwafEYajKSIJdBW2AZqWSgnKMuL3sg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9D658F805FB; Mon,  6 Jul 2026 16:15:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E00CDF805FB;
	Mon,  6 Jul 2026 16:15:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9C476F80524; Mon,  6 Jul 2026 16:15:28 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1783347326;
	b=Fx6iMuezE4qPqPdVpIUU+aTWN2kP0C/7EQeeTNECzLpuOLaVcr4Hb4EV4IVJRRSdludy
	 dW72v0Fg5jFZmJaSqn4y85De0I/d3FJQuOAdSimzBKOUqXcH46FT1pDeeAo43FE3nTv/Q
	 YrnarCIeSqQ6NzvjJbVp2hExvzp1/5ailpxIwUchliGm04cgG0IYpyhjMn4ZCRkve8L+J
	 a3M7dZcFj01cSaZ7MRrsaWbgSKimgdhqdlHAkOqgYIlEsQHFo2vZQPx1S08FrrVfSkIqP
	 aDnu4fTV1M6E7/sRym250y0cq7XoATbx/TtZElrokBXesPhP5/9W66Ndx9kTc1BWZuQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783347326;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version;
	bh=OtjCKAGlR6iyaO/EJsuyUyVVJbhpqjt2MpRxqCmjzmU=;
	b=NK0GI5MwUb2SWtNE2phD+FPgBnoewcjWCrjfSv9CSh76M7rplN2uMo2c8xG8hxIYz4hc
	 y9AkHe3hg3aidMHoJwwrDzB/AaE95V4tksoqMqwe/dTX3ctozk6XxsDvg8rfKwVh/JKV3
	 NvMAXeYHpf/QjoVZ4nFwYLo5KACXcnLL0pPBM+m4NwrWeGq4G0qKJwaDOjmstmOAvb0JP
	 GeA5esGx06xoktYleg0ge13Z3tA9wanqdTSMOoAPodaon4oFx0J+2i+nuoR92HSGo2uds
	 0mU6VBDmZ0PA8/Zv+b8Ug/O7qtLcYpDVcVVty240EzS7H6VsomSMQFkctJ3Zmp2X1MA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=RMrKnEIz;
	dkim=pass header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=hQGKogDd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DA9D8F8025A
	for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2026 16:15:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DA9D8F8025A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=RMrKnEIz;
	dkim=pass (1024-bit key,
 unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=hQGKogDd
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6664orkY154747;
	Mon, 6 Jul 2026 09:15:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=bNkGr13oAHiv6mn+HNmPXOtxf/Wc0x/rhX9ZAFBtE9w=; b=
	RMrKnEIz5L+2/GRI3OFDXvDUAMHsl/Hv2awQbZP5fVh7JjVTeFIrbDcn4U/HXrBL
	Wq1vOf23qigY2fEAF8DJFpe4oMEQFWYRXhzEKCGctFdx0GRQRPALSePE3wNQC8Hr
	D50/SMkosmFuT5HWCOhKyMGbv7Lk6/JSoULj6KmmO324+gtVlCarFhjkgwS/BCc/
	R32521uoMh8tIlV9h57TjNhmV7+RTiG9YVBZ5nn8tQxE7yLITuVNloohCyra77K8
	qcgVPg3gtKg9po2mdCxLGA0pnXoRQu04lzgcRHKa2hlDezD/PjrdKsK0RsY7Fs05
	+A8/B8IynrksMu2dWFlaIw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022136.outbound.protection.outlook.com
 [40.93.195.136])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4f6yjxjffg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 09:15:21 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CsLYsyA7Zw2QwzuiD4YM0JX1ufPZrozohux4DqbYfBPRlvyg2aiKWKYZoF7qIYSLxJybVO9D1lJXEZFC5lnkAgiLMNnIhfwAD1j2nIEJD1U2k9YRrD31HIwAYR0uzoM4CbsTtkgL2aa/dUCVY63sTHsd/gssFC4wHwLbL3J+Wy++YhkJ959Co0M9hAk89GsijfA/IaT/DJdlMkJt5sWaYvGJkLYi/2TTDehqMwIkUYW19wvvJt4qDS/JV48K/4S1U52uBwZNGCZe0+a8Ma2CSX3/uVZKdZHN3YFVikrX6BYQ76EIRBeE9FAQ0JV6+HphejrVMl+ebwit9uRxJ2icqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNkGr13oAHiv6mn+HNmPXOtxf/Wc0x/rhX9ZAFBtE9w=;
 b=GoCpkcL+eYpWg+enKH7qGgSQQaYbPDMTerJedGmE13j63stWSd8ToYI/GK/Mqb0jNml90FfHq1YksnTNA0wpyjfPCrWbo5xcaVDJqBIQAWDMp7pAG/HmkpEtv0B98QdbDPfG96KtZCVqNPcgxH8NBaAKk56HWbWUlXkGpgLlhg3d7cekbd6Ug1mc2xZErNAVQ7WzeRQ+i95FvvJ11n0DhXUjVdY6PsPkUJC8CnNbRhgrr9UMMvrVMzgzwQjm1asMeA87L88DoFz2LacLRKDFRm8NfVp62pi6uqreBtcKx3iCYBuws2VQ4yoNpTSGbaKbJlun+nhIuEiiOc0MRx/Pzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNkGr13oAHiv6mn+HNmPXOtxf/Wc0x/rhX9ZAFBtE9w=;
 b=hQGKogDd5WYjNyLtYIMq1aDv553QbVl58+9JPD0mz/yKpb35jWTgB9nwcRX9JzqLVixTi7y1ZfCPqWaHo731ceitiruLFP2lMxuNJqcr+JEklY0MerINM42o9dpJqLgJFX9JJF2zrtaq96tnA46cWBPz0a8wq6/nOUVu58FAjzc=
Received: from DS7PR03CA0022.namprd03.prod.outlook.com (2603:10b6:5:3b8::27)
 by PH0PR19MB4790.namprd19.prod.outlook.com (2603:10b6:510:28::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 14:15:15 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:3b8:cafe::95) by DS7PR03CA0022.outlook.office365.com
 (2603:10b6:5:3b8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon, 6
 Jul 2026 14:15:14 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Mon, 6 Jul 2026 14:15:13 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com
 [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id CF92C406542;
	Mon,  6 Jul 2026 14:15:11 +0000 (UTC)
Received: from upx-mtl-008.ad.cirrus.com (upx-mtl-008.ad.cirrus.com
 [198.90.251.5])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id BDE0182026C;
	Mon,  6 Jul 2026 14:15:11 +0000 (UTC)
From: Maciej Strozek <mstrozek@opensource.cirrus.com>
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        Maciej Strozek <mstrozek@opensource.cirrus.com>
Subject: [PATCH v5 2/2] ALSA: control: add ioctl to retrieve full card
 components
Date: Mon,  6 Jul 2026 15:14:57 +0100
Message-ID: <20260706141457.51736-2-mstrozek@opensource.cirrus.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260706141457.51736-1-mstrozek@opensource.cirrus.com>
References: <20260706141457.51736-1-mstrozek@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|PH0PR19MB4790:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5713331b-9522-4385-dbc1-08dedb68feea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|82310400026|376014|61400799027|23010399003|16102099003|18002099003|22082099003|13003099007|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	XwfOm8UtZ3oJDVqY20qysZ+BkE5Tgyszgd157h6hguFeEOHL2ut2h6vQX/vA6vMHEE6pZwyVgS49C6pntdjadoMaSynpjIqjeDe6vIjiS2A1vKvaVzLA273ss7ZiQFlp3tQzX6aU5HMcrLEOzMEfkoc/l5h9omxT9nD0FWG6vvHP1qL1rO3l9LsJ9GMyKCpd09bNKJ/uddB0QPlo1cJ3q4T3JJ5Xi5HGr0JTz2urEqlCr+PKLwhM5rExrZSHDwCuIRR7zRQhoaBNmB3XoTMw8VuvQO4xbUSB7IyJyXqCcyldDBR3/kt8xRgMdL8Pt7F/0ouEz15H9zlg1qcxHgTs3BmuDNcS5UnsEeEVVUUf+ouJH1RpBd/2nmJ2QdrUkJRTG89kU3AxjekuRim6uiymGGE55GkPcvdR3VM+4bjiMEVKYG05sdBKtm2eSc5OEpVk8Cs75bm4Y5cBu1P9q0FbyZHto65B2A6AfQ+2ZGMsbOHZt6xVEn0SkAF8pQGkM2Z/vBaZPXZ+ok1ERTFGPx4jyva8JpmM+YHHQarIwxGJNuBnf0slirHwsM8YapWKeRAcED1ui31k8cc8J7nNH0VQtLc3ZGX4rXbHdo8PTHljmSvjuf0sxaH7ht6lMAtbqTIrnMnudWEzLYUvRqDI1Q+KGaTkm7sB/algaKXmfTsABXX7kgexQcMgO3XprFcKhAe/7Sp9kks2gHvfdKs6uzmMlg==
X-Forefront-Antispam-Report: 
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(61400799027)(23010399003)(16102099003)(18002099003)(22082099003)(13003099007)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	CrRo8hea6h/9hronnTQZgiRFcyojps4jBaXhx+91Ze3OzBCUnSuGnYtvRR3Te7xCcSf3lmnomE7f7a2PxAfRPcRd4p+chlSyAOLjpW95PaS/PJTg6FLOH9OlLlZUwPvkN8Lw7qCiElZINZfOaf4ogf2EP1h/yUk0shV/g6WouQcQPYA8xu1fwDqbvWxvH/oqEYzKfqXnj0BU++mkA+GzYZLm6y5V6t6swB30HHPfDuUURDsHQgmggAa0d68lKGEqxAX6ppgI7plDIBG6shUzaO9iFU9qWnBGdaAj+1N+G7v7JXIIX62k2ezOzkwomCP9lVaDCnBFbls5kiNomgxQRmiRrxlKUf2dMmw+7S2xdaNT9lVC9ii/I+uN2SZihb0WuTk64L/fcpbf8EqY528R7IgKY1tIrTuLbzeBuseVgHkCK0iSuUb1QqadkM+cgHmN
X-Exchange-RoutingPolicyChecked: 
	Ty0O+UMUQdsBEAb3GFKu8+wcngw8rRQwzr12PtxZbp8c5flqwWDLtbP433Sd516p15fYeQpLuNVH/Dtgmo1SpSYPuwQWx5wlCwctbem1tP8NFiPzzveHPbmBb7+K1nzzDF/jMB8y4R/aiWcz7EPaJJjtRZto0coM8GfM3nxVyay7c9I6FtaMEA9V4/0vsxw+NTDOV9BSez5EcBFsNDs5QfBNtX4stZm9Fxzoosvyevwo96PW62CNVEN8YzvZ4h+DwE5mL93espFD4Kj4gSTMKwPsubssdQELnqTJCKo1V+DB7LHJ2C5JTzWCkRFUT+/bSi2faZvJoCnagfDAg5aPuA==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 14:15:13.0303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 5713331b-9522-4385-dbc1-08dedb68feea
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: 
 TreatMessagesAsInternal-DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB4790
X-Authority-Analysis: v=2.4 cv=Fo81OWrq c=1 sm=1 tr=0 ts=6a4bb879 cx=c_pps
 a=2hJN3FG5vRdYsizhUtvj5Q==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=NEAV23lmAAAA:8 a=iox4zFpeAAAA:8 a=w1d2syhTAAAA:8 a=vCTZ8rO4qcJ3_uquDMcA:9
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0NSBTYWx0ZWRfX4AZhyoeUghx8
 Z9GsSkKFbAxnwb4C6BhMCke9BK0CjNxxO19ADXTfMBE39Ml8Yv3OekY8i+h4ePqTug9CNfg5i33
 sApxqnS2bc4QHQcaGPo0FXG7ODy9RWU=
X-Proofpoint-GUID: YxqkbGmFsYNh8L16dHm4b2bKyeqUeYuN
X-Proofpoint-ORIG-GUID: YxqkbGmFsYNh8L16dHm4b2bKyeqUeYuN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0NSBTYWx0ZWRfX5afsQn7tMfiP
 s7hu2ser7u7w9Oa8b/0cmgMUHDP8hhAFxT49eY8sENMip8USqjOK5/hYwJjc/2zIHcUKDsThHwL
 5RkVO8aVl5WoKt0IceOY78t56rCGOs48mIg8MprS5ybRLd8uw13kWXx1Q8FjvdcS6ilwd3ILSBe
 1HtiVYdidnlX57lf34fNztDOvLDLNvqAn6/amJM3ixCDI/1rgku7KkdoHGeL4m3rJHW88UGw+mM
 pDQtLk7qicJWE30X7E8wuhyiqyFcw2KkPwG8psAEn/aRtQZUlJ30gRy+UvgLFdfb2hYNiienk0e
 vJ4Q58MTc8Hh+JxOYs4tA7ARtX7lVIrGwMlTyZetUAmKtlKomKlkMJzj6PS54uAqqqkp2dfYUzj
 VdGOJcncGrZbervzxviXR70l6nAOhdrUhpW6zXLzFQwuSEqfN5yHbmwToy77VzOXIxXlV8BZ7V0
 4NHhUh3zIUt0c0GX1eQ==
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: QUBCCSTZOEDL6A2LC7HDG3OPQK3WVTHN
X-Message-ID-Hash: QUBCCSTZOEDL6A2LC7HDG3OPQK3WVTHN
X-MailFrom: prvs=864750db1b=mstrozek@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QUBCCSTZOEDL6A2LC7HDG3OPQK3WVTHN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The fixed-size components field in SNDRV_CTL_IOCTL_CARD_INFO can be too
small on systems with many audio devices.

Keep the existing struct snd_ctl_card_info ABI intact and add a new
ioctl SNDRV_CTL_IOCTL_CARD_BYTES that carries a variable-length payload
selected by a type discriminator. The first defined type
SND_CTL_CARD_BTYPE_COMPONENTS returns the full components string. The
ioctl is designed to be reused for other variable-length card payloads
in the future.

The user-space caller may set data_allocated == 0 (or data == NULL) to
query the required length; otherwise the kernel copies the payload into
the user buffer and writes back the actual length in data_len.

When the legacy components field in struct snd_ctl_card_info is
truncated, '>' is written just before the NUL terminator to signal to
user-space that the full string is available via the new ioctl.

card->components is now dynamically allocated and grown in 32 byte
increments via krealloc(), capped at 512 bytes.

Link: https://github.com/alsa-project/alsa-lib/pull/494
Suggested-by: Jaroslav Kysela <perex@perex.cz>
Suggested-by: Takashi Iwai <tiwai@suse.com>
Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
---
Changes for v5:
 - use __u64 and u64_to_user_ptr() instead of 32bit compat layer
 - handle a NULL card->components
Changes for v4:
 - replaced snd_ctl_card_components with snd_ctl_card_bytes for possible
   future extensions
 - support query mode (data_allocated == 0 or data == NULL)
 - added compat 32-bit
 - renamed card->components_ptr / components_ptr_alloc_size to
   card->components / components_alloc_size
Changes for v3:
 - change components field to a dynamic array resizable in 32 byte
   increments
 - removed SNDRV_CTL_COMPONENTS_LEN define
 - sanity check if 'components' requests more than 512 bytes
 - added a commit to clean up trailing whitespaces
 - alsa-utils link no longer needed
Changes for v2:
 - do not modify existing card->components field
 - add a new ioctl and struct to keep the full components string
 - handle the split/trim in snd_ctl_card_info()
---
 include/sound/core.h        |  4 +--
 include/uapi/sound/asound.h | 22 ++++++++++++-
 sound/core/control.c        | 62 ++++++++++++++++++++++++++++++++++++-
 sound/core/control_compat.c |  1 +
 sound/core/init.c           | 34 +++++++++++++++++---
 5 files changed, 114 insertions(+), 9 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index 404785b7d885..2ca24ac7e37f 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -108,8 +108,8 @@ struct snd_card {
 	char longname[80];		/* name of this soundcard */
 	char irq_descr[32];		/* Interrupt description */
 	char mixername[80];		/* mixer name */
-	char components[128];		/* card components delimited with
-								space */
+	char *components;		/* card components, space-delimited */
+	unsigned int components_alloc_size;	/* current allocation size of components */
 	struct module *module;		/* top-level module */
 
 	void *private_data;		/* private data for soundcard */
diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index d3ce75ba938a..500599213f93 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -1058,7 +1058,7 @@ struct snd_timer_tread {
  *                                                                          *
  ****************************************************************************/
 
-#define SNDRV_CTL_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 9)
+#define SNDRV_CTL_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 10)
 
 struct snd_ctl_card_info {
 	int card;			/* card number */
@@ -1072,6 +1072,25 @@ struct snd_ctl_card_info {
 	unsigned char components[128];	/* card components / fine identification, delimited with one space (AC97 etc..) */
 };
 
+/*
+ * Card components can exceed the fixed 128 bytes in snd_ctl_card_info.
+ * Use SNDRV_CTL_IOCTL_CARD_BYTES with type SND_CTL_CARD_BTYPE_COMPONENTS
+ * to retrieve the full string.
+ */
+
+/* Type values for struct snd_ctl_card_bytes::type */
+enum {
+	SND_CTL_CARD_BTYPE_COMPONENTS	= 1,	/* full card components string */
+};
+
+struct snd_ctl_card_bytes {
+	__u32 type;				/* SND_CTL_CARD_BTYPE_* */
+	__u32 data_allocated;	/* size of @data buffer in bytes */
+	__u32 data_len;			/* in/out: actual data length in bytes */
+	__u32 reserved;			/* explicit pad */
+	__u64 data;				/* user buffer (pointer stored as __u64) */
+};
+
 typedef int __bitwise snd_ctl_elem_type_t;
 #define	SNDRV_CTL_ELEM_TYPE_NONE	((__force snd_ctl_elem_type_t) 0) /* invalid */
 #define	SNDRV_CTL_ELEM_TYPE_BOOLEAN	((__force snd_ctl_elem_type_t) 1) /* boolean type */
@@ -1198,6 +1217,7 @@ struct snd_ctl_tlv {
 
 #define SNDRV_CTL_IOCTL_PVERSION	_IOR('U', 0x00, int)
 #define SNDRV_CTL_IOCTL_CARD_INFO	_IOR('U', 0x01, struct snd_ctl_card_info)
+#define SNDRV_CTL_IOCTL_CARD_BYTES	_IOWR('U', 0x02, struct snd_ctl_card_bytes)
 #define SNDRV_CTL_IOCTL_ELEM_LIST	_IOWR('U', 0x10, struct snd_ctl_elem_list)
 #define SNDRV_CTL_IOCTL_ELEM_INFO	_IOWR('U', 0x11, struct snd_ctl_elem_info)
 #define SNDRV_CTL_IOCTL_ELEM_READ	_IOWR('U', 0x12, struct snd_ctl_elem_value)
diff --git a/sound/core/control.c b/sound/core/control.c
index 7a8dc506221e..5e9f68c96f4b 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -876,23 +876,81 @@ static int snd_ctl_card_info(struct snd_card *card, struct snd_ctl_file * ctl,
 {
 	struct snd_ctl_card_info *info __free(kfree) =
 		kzalloc(sizeof(*info), GFP_KERNEL);
+	ssize_t n;
 
 	if (! info)
 		return -ENOMEM;
+
+	static_assert(sizeof(info->components) >= 2);
+
 	scoped_guard(rwsem_read, &snd_ioctl_rwsem) {
+		const char *components = card->components;
+
+		if (!components)
+			components = "";
+
 		info->card = card->number;
 		strscpy(info->id, card->id, sizeof(info->id));
 		strscpy(info->driver, card->driver, sizeof(info->driver));
 		strscpy(info->name, card->shortname, sizeof(info->name));
 		strscpy(info->longname, card->longname, sizeof(info->longname));
 		strscpy(info->mixername, card->mixername, sizeof(info->mixername));
-		strscpy(info->components, card->components, sizeof(info->components));
+		n = strscpy(info->components, components, sizeof(info->components));
+		if (n < 0) // mark the truncation with '>' before NULL terminator
+			info->components[sizeof(info->components) - 2] = '>';
 	}
 	if (copy_to_user(arg, info, sizeof(struct snd_ctl_card_info)))
 		return -EFAULT;
 	return 0;
 }
 
+static int snd_ctl_card_bytes(struct snd_card *card,
+			      struct snd_ctl_card_bytes *info,
+			      unsigned int __user *data_len_out)
+{
+	unsigned int data_len;
+
+	switch (info->type) {
+	case SND_CTL_CARD_BTYPE_COMPONENTS:
+		scoped_guard(rwsem_read, &snd_ioctl_rwsem) {
+			const char *components = card->components;
+
+			if (!components)
+				components = "";
+
+			data_len = strlen(components) + 1;
+
+			if (!info->data || info->data_allocated == 0)
+				break;
+
+			if (info->data_allocated < data_len)
+				return -ENOMEM;
+
+			if (copy_to_user(u64_to_user_ptr(info->data), components, data_len))
+				return -EFAULT;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (put_user(data_len, data_len_out))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int snd_ctl_card_bytes_user(struct snd_card *card,
+				   struct snd_ctl_card_bytes __user *_info)
+{
+	struct snd_ctl_card_bytes info;
+
+	if (copy_from_user(&info, _info, sizeof(info)))
+		return -EFAULT;
+
+	return snd_ctl_card_bytes(card, &info, &_info->data_len);
+}
+
 static int snd_ctl_elem_list(struct snd_card *card,
 			     struct snd_ctl_elem_list *list)
 {
@@ -1990,6 +2048,8 @@ static long snd_ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg
 		return put_user(SNDRV_CTL_VERSION, ip) ? -EFAULT : 0;
 	case SNDRV_CTL_IOCTL_CARD_INFO:
 		return snd_ctl_card_info(card, ctl, cmd, argp);
+	case SNDRV_CTL_IOCTL_CARD_BYTES:
+		return snd_ctl_card_bytes_user(card, argp);
 	case SNDRV_CTL_IOCTL_ELEM_LIST:
 		return snd_ctl_elem_list_user(card, argp);
 	case SNDRV_CTL_IOCTL_ELEM_INFO:
diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index 4ad571087ff5..f14d9f5e94be 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -446,6 +446,7 @@ static inline long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd, uns
 	switch (cmd) {
 	case SNDRV_CTL_IOCTL_PVERSION:
 	case SNDRV_CTL_IOCTL_CARD_INFO:
+	case SNDRV_CTL_IOCTL_CARD_BYTES:
 	case SNDRV_CTL_IOCTL_SUBSCRIBE_EVENTS:
 	case SNDRV_CTL_IOCTL_POWER:
 	case SNDRV_CTL_IOCTL_POWER_STATE:
diff --git a/sound/core/init.c b/sound/core/init.c
index 1ff340ee6884..15a8209469c7 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -590,6 +590,9 @@ static int snd_card_do_free(struct snd_card *card)
 		snd_mixer_oss_notify_callback(card, SND_MIXER_OSS_NOTIFY_FREE);
 #endif
 	snd_device_free_all(card);
+	kfree(card->components);
+	card->components = NULL;
+	card->components_alloc_size = 0;
 	if (card->private_free)
 		card->private_free(card);
 #ifdef CONFIG_SND_CTL_DEBUG
@@ -1036,16 +1039,37 @@ int snd_component_add(struct snd_card *card, const char *component)
 {
 	char *ptr;
 	int len = strlen(component);
+	unsigned int cur_len, need_len;
 
-	ptr = strstr(card->components, component);
-	if (ptr != NULL) {
-		if (ptr[len] == '\0' || ptr[len] == ' ')	/* already there */
-			return 1;
+	if (card->components) {
+		ptr = strstr(card->components, component);
+		if (ptr) {
+			if (ptr[len] == '\0' || ptr[len] == ' ')	/* already there */
+				return 1;
+		}
+		cur_len = strlen(card->components) + 1;
+	} else {
+		cur_len = 0;
 	}
-	if (strlen(card->components) + 1 + len + 1 > sizeof(card->components)) {
+
+	need_len = cur_len + len + 1;
+	if (need_len > 512) {
 		snd_BUG();
 		return -ENOMEM;
 	}
+
+	if (need_len > card->components_alloc_size) {
+		unsigned int new_alloc = roundup(need_len, 32);
+
+		ptr = krealloc(card->components, new_alloc, GFP_KERNEL);
+		if (!ptr)
+			return -ENOMEM;
+		if (!card->components)
+			ptr[0] = '\0';
+		card->components = ptr;
+		card->components_alloc_size = new_alloc;
+	}
+
 	if (card->components[0] != '\0')
 		strcat(card->components, " ");
 	strcat(card->components, component);
-- 
2.48.1

