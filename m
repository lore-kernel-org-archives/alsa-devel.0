Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42B2C44527
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jul 2026 10:36:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4B7106020D;
	Mon, 20 Jul 2026 12:36:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4B7106020D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784543795;
	bh=NRDiFtyZhtwBxcJpGDSQtmNjhzWU5G+k2Crs34vlR/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=cHVC7eVwduiyCX3QAOB3Dq9nMB0H8E3AKYsR/GC1b0BdwuMQE5hOItGyGK78roRnF
	 MHEV2T3+A5wVHh+pgBR5NU4i75plpyBdJlSVuc8vvjyRJHNcXy8e2KCqH2m1FO1Av6
	 AUpR0oiAl6MmeAAsR7Kp3dM2oSmtUSWRNMuUWSCs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C7CF1F8060D; Mon, 20 Jul 2026 12:35:50 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 49451F8061D;
	Mon, 20 Jul 2026 12:35:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D8FDAF80496; Mon, 20 Jul 2026 12:35:43 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1784543741;
	b=LwoBHhXJwzJZd8r90SoddV5BbKiWPjGAMAfXNRrvPbfMJIa5pQRkN5FSgpoinQ+zwwo1
	 v5+iTjjPzOs53ixpYcbRnk2CoCO5JAqane3/SLmq1y+FJ6/WiGwViMrRujPfyID7goNaG
	 OjI0ulYD+0zSbGGF/V0kNIeo7MwV+EWeCexzSl7eliy3TJJ5xHlTQWCnDrdgzDn0AmQU/
	 Eq7Qt+93OqeLQkGKaNJolFJwFTyv4bmWgounTiwaP3AIm8PCJjvPOr01DTi0d7KNmGSKv
	 0LVHNrEbT2xEN1yLTSzkBornWFNfC40TZwD/+rtIH/DFydj03QRJYjQffio0QL2KI4Q==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784543741;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version;
	bh=NRDiFtyZhtwBxcJpGDSQtmNjhzWU5G+k2Crs34vlR/g=;
	b=lnALPphPpcU/NUC56DndZTAt1sd47huw6NZ9PUE5lHj/o1pffIVxUcaJ2anxbFdXFfiO
	 sgGr9+sVUSjId0FLwthqIYDCDY74e01t/obkX5Zywi7FnsarQ2pv0Mo+tnE33S6BQgY7w
	 YOOLDYyyqREt9QUGH3nPofeLy64ne7QyDszMFqgc/Xln5XsgBrIjeQlJxHPsiYokGBX4Q
	 jjyMcExf5yTQX/BwF5oFBtgqZQGJ9jO2rYPLbigviG7Sam68mckowWwt1XgbCbzYZxalr
	 7xsqQLGt/M9j4v7YpCeZEuXuH+473vmVeVaGASHO8MQKfSHkwRnWHI/nKojy88+puIw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=Do3eJ5Op;
	dkim=pass header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=b9limmA2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DE1EBF80423
	for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2026 12:35:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DE1EBF80423
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=Do3eJ5Op;
	dkim=pass (1024-bit key,
 unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=b9limmA2
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K5THoo3684283;
	Mon, 20 Jul 2026 05:35:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=BT7JH1stDxx6Ngv+FvOtmxvzjOS7lhPD+T03Ys5t73Y=; b=
	Do3eJ5Op2nxPqfmsavSEHvy2AFT0erJ50f8uqT5SqbzqObgH4tU1FGL7xFRITmZx
	jw9B3zZemjRm1Et2muywAi8AkqO18V/xgJtid8ABFtt/GtIPDL4YGEMDOehU1FHX
	5rlXPFfBSqob2cvwem6FS9ai2FNSD/mFm6dhtV1wrsMerVtSAmWW3gVdlX4KeVuP
	g2VMeC33y/6PH1LcOcFgpNEk5nlFgkdYYMB0LUShuGFalFNOpJHLkD9uWCD7+7Zt
	2+TVnVtlu7RvWkkd3gMJqfg4rRvGpJuk9rxCT9kiV6hi/mDH48ceuxZNRuUMceen
	/D9J/KAxlnagJdIo3Z0vYQ==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020087.outbound.protection.outlook.com [52.101.201.87])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4fg6vyj9hh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 05:35:37 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqYfaab51u4JsJMB8n5uWD52VxqEPK7VBo/+ngzNxItIAfTATFMLHMPHIN5nUkOZqaKF7Uz2RJtNJayraslPTPv0TFJcdcgSLSxiTdRmh7rlUtz/+ncTKpXqa5c9j5vnzXzYtUTTO6lRNLhoXbJmrR8k12UaDwzGi3DRaKrgo9s1vbo8AltJYfjdu2R39ujVGw0r5pndtW2dCJ5ZTkv1ggojVjFf2KnkDudIyE+lZ09H5MCXw0vsVHlzgK5EB/wtFco9B4AwgPyUHlmn285F3n5MQSS8T9gODN4kLwjAKfi8qigu+X1HaR1L4NvsrNAf3SIEPD73EM+SWCR1wCPhHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BT7JH1stDxx6Ngv+FvOtmxvzjOS7lhPD+T03Ys5t73Y=;
 b=N2YO5ayLsbJmgAlVfeSrBHDlPedTQQ90PETDcCZaYiUz2xo/iWpfhoXVLi6VSdz1/4XSTwUY7qJlAIc7kmO1gfQlbjFGRuiGv51zppAKDO/HEYDTWhYB5eKl/qi+NIOghXPuXrJF8EXDBRLRt+RyzIy5qoJJN4VEWYAM7KpGMXXjA0ABLwMmTMUGOaZtalOueRkPjXPjOR0Z98+4bTAl4BLbGKxpt2IGPcju4IG5z6DBNWeEGuDU9Y/wYYFFlR8AEtc1nm3U21r6NU1Y6GjMSm/PxBbCmI3FukAubM0e48jAe4FZC+3KwQ6yOQcAwkapkk95ybpV1gPA2g/BAWHjAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BT7JH1stDxx6Ngv+FvOtmxvzjOS7lhPD+T03Ys5t73Y=;
 b=b9limmA2taqlmTwRHFLSLDJsmCReC7s/CGf52zUV94ka1gXsBHSxZNDPCOcwQFCaFL/KlwZ4SPTlHRW4xNqmQbHm6/asYIKTm8G1Ueu/HxoteWEwkcfAVXPH3DibPzHVILNDBcPvIRBx3Qzn7fJ5yLwmWp+IKpPYk8h5FXmpFK4=
Received: from MN0PR02CA0021.namprd02.prod.outlook.com (2603:10b6:208:530::23)
 by PH8PR19MB6882.namprd19.prod.outlook.com (2603:10b6:510:1be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.15; Mon, 20 Jul
 2026 10:35:31 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:530:cafe::1a) by MN0PR02CA0021.outlook.office365.com
 (2603:10b6:208:530::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.18 via Frontend Transport; Mon,
 20 Jul 2026 10:35:30 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Mon, 20 Jul 2026 10:35:29 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com
 [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 14F16406542;
	Mon, 20 Jul 2026 10:35:28 +0000 (UTC)
Received: from upx-mtl-008.ad.cirrus.com (upx-mtl-008.ad.cirrus.com
 [198.90.251.5])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 0DA29820244;
	Mon, 20 Jul 2026 10:35:28 +0000 (UTC)
From: Maciej Strozek <mstrozek@opensource.cirrus.com>
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        Maciej Strozek <mstrozek@opensource.cirrus.com>
Subject: [PATCH v6 2/2] ALSA: control: add ioctl to retrieve full card
 components
Date: Mon, 20 Jul 2026 11:35:05 +0100
Message-ID: <20260720103505.1860399-2-mstrozek@opensource.cirrus.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260720103505.1860399-1-mstrozek@opensource.cirrus.com>
References: <20260720103505.1860399-1-mstrozek@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|PH8PR19MB6882:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ac482d5b-e7ab-4045-b0e4-08dee64a9e68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|61400799027|23010399003|376014|22082099003|18002099003|16102099003|3023799007|13003099007|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	L9qE8m48gfswzJ5nqu2IIA/YjVx7GQ6lgRHzND1zahNTqTcMVOdGPaU7NAqiGSdHF058EfNsCnaj1MNDXYPtY4fS80a3vkSByy7NnkLQpAlSKGSk8gDYu7Un97pIMQadTMGglzmJR1XFKyR819CFY6D1OrPDKINxaYkbkUvPn0nK52f9INvToiZaTwUKDO3yJ0fXpqjlisPKVLil+xezaXfSB6Yf5YE88kZD8CQ2kAybtWhZyBeMso6K13j2kRIXSADylJ/hwPidFvCsNIIS3MISSmAqp+uU4Lk4zyzVThz9Tromv2h1SRLTwLc78B4PxSroVffybtJKOy7qzE83w1QcXhfIJOrrFhaoJclQMA3A6lmrEoAucv4hI0qKzFi7/soJid0hdLpGUmLR4Xsbaz3HKc43Y7JNbyGHNfHGUfK1Q1BAYvCXWkBS40LjWE+rYQUiyLdZZTJNpmeYW5EyOvAh7THvR5+1fVas/ys8UCmmkGzViIuiEsZEFpn5Ds+nXJiLYAg4D94ZUQ+wwJjILdkKfx/4qXXfa8xLwqL8gSEzhdNWBvt6LE94VO/jDc4rNCNTO2TGPlTt/1Hp8yX+15Gv85kCqUAFJCllTZpH4duGD667WYWTeJ9BHXWAKt1K7v0sggWjjymwGOFfxK3F65ZpTxSU3KHknQ4KCAst1Q73iEsTwWIEXFqpwvGMQTHawvpmCKQvrxxlwLY90IX0YA==
X-Forefront-Antispam-Report: 
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(61400799027)(23010399003)(376014)(22082099003)(18002099003)(16102099003)(3023799007)(13003099007)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	OX2zbjLEZ5y9dcjIak0TsOS1Ppw3S+Ctf4RyoLouECbW2doI60yZ3ArYLLvlel8F3KX3EQU5mOOa94aqiiF0toTaIpMzqJvuAlWaVV3hgCq97yF1kNC/h49FDS16I8Rc41exxdF4mUAHRdWAK+bgxOOjwfjUoDzuRaFtmkM1F1BtNhylLBSwtLt9RsUIs9GSedKTXpRbZv4hwZF076aMQ17rrX+opA5dZFrZ2lRddA/aSPRhL4bju/2TZKoGnbqMXxA2pmYzrxx1QX9XM5cMcxxcktU7VDE+kvyl3v/j5sT2LuPfzGBz65J1twgPeFc+OtAuX/MsqwXnBgRjIUPwHAUKyiYXiyuc6y2GsKHXmFHiJwAix/hUAmK/1q3k+YUDFgsW8Hsp5xUDm/j2nbg4SjWQ7nBhrqg93gHz8j2SLCMb/HfEe+ducqvMhRbA4iOr
X-Exchange-RoutingPolicyChecked: 
	rr3TXKRELOGDZWdwvWvyqmaiO3ef27NeVVxFcsY9lfsrhUWZ/+Ta1bcrN+LynW8zc6lzaK+uxn5c3PayOwXySPS5T9YiLOW6eL+Mt7O06vyqILGajBEjt5rzUPOlc13JaAoNFxeUIuy2732FQ4UNKpaT80b+SS2Oza2o/OgBAMCG63Gqd51qpomk4LbLIVCByBZiCSivlq6T848qJbGsSYAhec6T+yod14H5RS+lj62blJvf9lalp5M+Muh4H0MX86M3DW+aML9IeIHKAO0Nqfzi4QBAqO0Uelm7mAfIvVESgEdi72JBS7qoIzYdqNnD7TDh7xCmEHEu9SDblbeSkQ==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 10:35:29.0771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ac482d5b-e7ab-4045-b0e4-08dee64a9e68
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: 
 TreatMessagesAsInternal-BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB6882
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDExOCBTYWx0ZWRfX4A/F3dYDApSm
 6dkf+HV3SzIhXM6ahP2WXzelSrsTSntRQS1S3zPyR5sM169VxESuoQ/emi1B/TacPTpbLcogmz8
 bJpykwMc/BOSxEIL75qtxQ3tTAyBNr0=
X-Authority-Analysis: v=2.4 cv=f5l4wuyM c=1 sm=1 tr=0 ts=6a5df9f9 cx=c_pps
 a=M3VJd0sitle1370pw5NXFA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=NEAV23lmAAAA:8 a=iox4zFpeAAAA:8 a=w1d2syhTAAAA:8 a=sefg8_7nxHGFjYeqZrUA:9
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDExOCBTYWx0ZWRfX5tm8FXVYe9C3
 6mRw8SwLBkKeol3ov1rGODYc+cTR/byzcXIUbVQmY8u37HcNbrSIy5myQ2PM+xwG+mg9G56hGy1
 Hok8KT8NxKHDD9E3vV+cOsdkma0avxUCT2KR0hOJDXUlp402b7iCU0ZNmWoTk+9+aqsKqQoE06c
 VG9ItK8XnBsNi4wY6XCjGXJyC8tbAHwyWi2Dn+1ayfPSt4wqWR9M1NwWn5U72QNZxgT2OF5UABb
 /eOfzQEkUAhF/lUlogJOysNjYW+1uJo4ebAPs2oqeIx7hw16Vm8y0UchUyGPBKPhRavaOnbJ3+O
 y+APaq4/0zNVMQQYtbDNRMbXC8azdpGI55QMw+bZJ2FBImkhlqW1VCoia+27fEnjfS6NnW6+rM1
 g84YqwC65a15BgKclvBbc34bssSPt6TR+2Q/e2d0ZV4tax+GckXpB6Ww72Yu1jXrS6/suOlnjF9
 j/J7O5sUcIRN/xTTH6Q==
X-Proofpoint-ORIG-GUID: bxOKSuf1XIbuUT399-7bKceEdzq2zU3G
X-Proofpoint-GUID: bxOKSuf1XIbuUT399-7bKceEdzq2zU3G
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: WESEZ62QECD5ZWLOILC3KXSALBTU33PR
X-Message-ID-Hash: WESEZ62QECD5ZWLOILC3KXSALBTU33PR
X-MailFrom: prvs=86616132ea=mstrozek@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WESEZ62QECD5ZWLOILC3KXSALBTU33PR/>
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
Changes for v6:
 - take the snd_ioctl_rwsem write lock in snd_component_add()
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
 include/sound/control.h     |  3 ++
 include/sound/core.h        |  4 +--
 include/uapi/sound/asound.h | 22 ++++++++++++-
 sound/core/control.c        | 64 +++++++++++++++++++++++++++++++++++--
 sound/core/control_compat.c |  1 +
 sound/core/init.c           | 36 ++++++++++++++++++---
 6 files changed, 120 insertions(+), 10 deletions(-)

diff --git a/include/sound/control.h b/include/sound/control.h
index e07f6b960641..909db0d0485d 100644
--- a/include/sound/control.h
+++ b/include/sound/control.h
@@ -7,6 +7,7 @@
  *  Copyright (c) by Jaroslav Kysela <perex@perex.cz>
  */
 
+#include <linux/rwsem.h>
 #include <linux/wait.h>
 #include <linux/nospec.h>
 #include <sound/asound.h>
@@ -167,6 +168,8 @@ snd_ctl_find_id_mixer(struct snd_card *card, const char *name)
 
 int snd_ctl_create(struct snd_card *card);
 
+extern struct rw_semaphore snd_ioctl_rwsem;
+
 int snd_ctl_register_ioctl(snd_kctl_ioctl_func_t fcn);
 int snd_ctl_unregister_ioctl(snd_kctl_ioctl_func_t fcn);
 #ifdef CONFIG_COMPAT
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
index 1116a40d11ae..78ce7bc936d2 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -38,7 +38,7 @@ struct snd_kctl_ioctl {
 	snd_kctl_ioctl_func_t fioctl;
 };
 
-static DECLARE_RWSEM(snd_ioctl_rwsem);
+DECLARE_RWSEM(snd_ioctl_rwsem);
 static DECLARE_RWSEM(snd_ctl_layer_rwsem);
 static LIST_HEAD(snd_control_ioctls);
 #ifdef CONFIG_COMPAT
@@ -872,23 +872,81 @@ static int snd_ctl_card_info(struct snd_card *card, struct snd_ctl_file * ctl,
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
@@ -1986,6 +2044,8 @@ static long snd_ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg
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
index 0372756048cd..19ec68db561b 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -589,6 +589,9 @@ static int snd_card_do_free(struct snd_card *card)
 		snd_mixer_oss_notify_callback(card, SND_MIXER_OSS_NOTIFY_FREE);
 #endif
 	snd_device_free_all(card);
+	kfree(card->components);
+	card->components = NULL;
+	card->components_alloc_size = 0;
 	if (card->private_free)
 		card->private_free(card);
 #ifdef CONFIG_SND_CTL_DEBUG
@@ -1035,16 +1038,39 @@ int snd_component_add(struct snd_card *card, const char *component)
 {
 	char *ptr;
 	int len = strlen(component);
+	unsigned int cur_len, need_len;
 
-	ptr = strstr(card->components, component);
-	if (ptr != NULL) {
-		if (ptr[len] == '\0' || ptr[len] == ' ')	/* already there */
-			return 1;
+	guard(rwsem_write)(&snd_ioctl_rwsem);
+
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

