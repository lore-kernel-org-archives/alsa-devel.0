Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F4FC44501
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jul 2026 14:16:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 213CF60213;
	Mon,  6 Jul 2026 16:16:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 213CF60213
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783347394;
	bh=Eh3nwmFNhCgP3ot9M3nzPDV+ABdfJc6O2RlTEWHCo2g=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=FxslJuyCoiNihGH15dOnFLoNlGsb1pERcZqG9gkSMsFXkuoPHOXho6bT2W1Rd4uvJ
	 mdSaqVaQqv0mgVxFGk4+FtNAoIL9PdWLmYUJ3DrSmREVDyf+LE9ut/3UhHrDrF+LYc
	 x/pl2xmlo8YXUsxLd8D3gQ1UN+k4tTYcRqXOCvlg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 24BC1F80606; Mon,  6 Jul 2026 16:15:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2E2F6F80614;
	Mon,  6 Jul 2026 16:15:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2C0BDF804FF; Mon,  6 Jul 2026 16:15:31 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.168
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1783347326;
	b=SZmLRpNzOJHQoh1CngOXqUFnTMOqTS8wuS3FdlLjt7rwYTkXjOzMgCSRzatZltnebUwx
	 OFRR47To7jIM3b3Qkhej3dRxvf5ne4n56uruiNAgTByUi4LFyCZI2QUiiZp6hU5eMxyrq
	 N/R4suKUv6JPoY/b6MGk2QABc1zNsL1sjl5+oltvRCfV4wSgJhJ03Polvlk7iaj7zRqeZ
	 j7c91UJXydhyqtYRGKs/w1OQP9PVylQArRkN48B3cND8lniFlbUFF+RyTQ9+7+KhzWixS
	 ZwFJfIuwfb54oX42tQ57Xw54cqVoFePgfux/ATRjZd3IIB3YayjPMUNzKZcHBzhPqXA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783347326;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version;
	bh=Eh3nwmFNhCgP3ot9M3nzPDV+ABdfJc6O2RlTEWHCo2g=;
	b=iahEUdKS9sc0FuH0q8ZTm8Ux2vb7mSSm4lUg/byeWNOL6ztQ7z2eUAnUf3uB++pYTqPJ
	 8UQsEyXfI2qYotactQ759RIpcTEowK5aPoTkAA914vbbEYAw3sPiAAfJ3MNh6o+vIIvVc
	 x6WxLTc7XtXUX6ZlVJ1W9jbivuynLjyoUehg5aNU2py9w8a2nfRYWf+i1OueggmGZBK1b
	 NRKyb0vf8OLuKwSKMOE8uCEHm2MgrJ/Xyj4nrWr/DkSixk1kqdi2g1uPoNQgYOlgRUtNk
	 KmgDBjCuZi+XOLr0oSAz8yAK86KvhEBvY9amDvoS8E6LQAgm9IpfSf5y09Wjr/r8+hg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=TTVNRAtX;
	dkim=pass header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=tKh6lAWN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.168
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 99390F8047D
	for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2026 16:15:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 99390F8047D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=TTVNRAtX;
	dkim=pass (1024-bit key,
 unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=tKh6lAWN
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6669pdvX1450924;
	Mon, 6 Jul 2026 09:15:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=4iA6bqqQrF8er919
	QnjvqJp5esT41KJpGkdoA3XGuaw=; b=TTVNRAtXcnj0t0f5NXmwSG98K930kkcB
	ChBQIDEgDRuZcedqHwXqQ8t/TCHpzbZqrs3iepRtP3o+4sma7ULR3KKXkuNHKMQb
	QvbLKy/+v0l5JZZqZwpaxyxBhWxvFJDeEaq9MDVR+0tQFRWgPxIwFXIHGnvTI1zq
	S6RmvJHroH/sfyv3mZi8PhdBvIG0VJgha14vSSzSZPJoGaPL9862etAyBPidOcg4
	aOHYjGUcCHt1C2jhOMvOnR16fBvk7lGyDEanY0hZfCzsdCFjhGcFGkSTAtk7o+2a
	ob8EI53Mkgfnjv/viIByUgcbUDjYzm+VyffS/cxeixHtEw9rnCPvvQ==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020121.outbound.protection.outlook.com [52.101.61.121])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4f6xkjjgpx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 09:15:23 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hzxkug53aB5Sl2SWz3nmwZNd4EzbAl5k0JZXA02jzkfYEqoO7GN07eWl+vafO2LwLS5lY1Yl1DV3KfMV4/ePD0ffJK393B0uBbOhfy3kF6pzzuGn5PK6y7w2mN7c6Uy5iDQ70M4K31o2/3gpOU9WthzrcIicm4xapKJKaeVSeGSbbVIGHnpc9fCbacQhjvsU0cDaVe2exMsNygY2Qv8ak3jVnz6UFBANs6UEOJ67A1cbxXzM2Yfc7YtGGpeDwJPG/LWSmVYhUtnyXmC3PJRV4CU9RAKvYi5ujlZgW2roA9BM1FkJk6SHwGIFsX1DDEez2yU7m7fEPEwF/8cVJLm6fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iA6bqqQrF8er919QnjvqJp5esT41KJpGkdoA3XGuaw=;
 b=e82Ws/JMf/nYW73CaXadsOpmP5hUZlAgjS63eLgeOBWCnagYGu9RNQb/rujLQ6Sh9/Arip9SrLSN/Yj4hpdmOSRVikrO8eF7l8nh7HVaLzDNLKWiYMC86RmNZQZFIdm0juRLueYKHZWZ+CWAbuT8N3dmmBx68Q8l+SKTW3r0DOVdK3KM9LOZPNgQL6rNk1NxhHXrZV2aNvCa0qbHua7fkmtwSBO6hjf3+sdR1On2nVqQUnHMdiWreXaVhnYOLlRT0jEa2U6H7Yn/ymNfrRtshMpFR0CSM1vcBVIrsW6PTt+XhOpL89r51XkZboqaYede/+rX2s0pUbWn3jwrHaJhzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iA6bqqQrF8er919QnjvqJp5esT41KJpGkdoA3XGuaw=;
 b=tKh6lAWNBvf2l22awdHTkAAgCztj+gTUOMPvP6evjdMWRHCGm9fgwoDT0oCbuHNpTZqPCPBxTOJ6YSm6RIn2XH1nQadkvVSYohq5x3WmxgtlRMWnc1ceNZG0ZWURgmQqPee5Xu0IH73ELskMnZYj0mu+ZtYMVoW4h1ui3AU/Uzo=
Received: from CH2PR08CA0027.namprd08.prod.outlook.com (2603:10b6:610:5a::37)
 by SA1PR19MB8114.namprd19.prod.outlook.com (2603:10b6:806:373::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Mon, 6 Jul 2026
 14:15:15 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::63) by CH2PR08CA0027.outlook.office365.com
 (2603:10b6:610:5a::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Mon, 6
 Jul 2026 14:15:14 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Mon, 6 Jul 2026 14:15:13 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com
 [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id CA28B406541;
	Mon,  6 Jul 2026 14:15:11 +0000 (UTC)
Received: from upx-mtl-008.ad.cirrus.com (upx-mtl-008.ad.cirrus.com
 [198.90.251.5])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id AF6A582025A;
	Mon,  6 Jul 2026 14:15:11 +0000 (UTC)
From: Maciej Strozek <mstrozek@opensource.cirrus.com>
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        Maciej Strozek <mstrozek@opensource.cirrus.com>
Subject: [PATCH v5 1/2] ALSA: control: tidy up whitespaces
Date: Mon,  6 Jul 2026 15:14:56 +0100
Message-ID: <20260706141457.51736-1-mstrozek@opensource.cirrus.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|SA1PR19MB8114:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1a26d044-b52f-433e-8529-08dedb68ff01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|36860700016|23010399003|61400799027|11063799006|56012099006|16102099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	S/6uU5uV0rCirZvbaCW8+sR47StDqnMjVVVUMfdAUWGxvxsldF2PK3M1j7CvFXCf+86naLaaMrtPkPbg3ciyrxnwEipehmbao0rMsO6xJS34TjQd/2SlFjLrsGIX7b4IuoTOvGr6immkfdYMq+EVWSogYQCSrlv0bEfOSM4RRMW0pStob7eOdHSaptHEPla/whAuV/biZXuEkKWZILYsOHFieism1XTkr2esnxqNtgMLKXuolhr//Fob9nhmlByAN1EIsb83KQdy8LgbwCjZAEmoGYdIUSM9vGGfPVzezE2Sa2uivCMtq6FIGKU/pUZ87wK7impeZcE05iSJ+lCF6VqbjiruRDI+vErgiieur74SJSaaTxFoM0W3GDmiLfvAE2W3YhARWll23dEj9wOpGtMcdCBPLQPaOv5XHnXzNJh0v7uan3gIdQHEn9dQahWyA+auJ2XM8GHX84le+emvCZ/XEk7rCl6zyvU5EPhr05JAh48RbwF6kQ/9QQoJGF0PD2wxDO2MQ1qmLTpcuJIaahfaGBBmeruFtUcywwVdMd/mZ529xDhcBQFrArAgEK5uM3426VeQQeLiU5pwyMYK/fVlaZaFxvmDzvQSmTYfSZE3fU6rkCXRLIj9qoWU/JQhXdP/TtLLSYsdKd8INgKVO+Fx3fxGi9bxZWyrivYc/Cgh75KFwP0RjI7L+IzaMXuuHNd7Mq3Xsrz0mgtR67lnDA==
X-Forefront-Antispam-Report: 
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(61400799027)(11063799006)(56012099006)(16102099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	gtJu3YcjVHXhfCiF0kdk+WnAkW33OSTV61s/TGu82F6hMaAQHSTjxdEiLEnW2JPgFyelC1NtUjaXwMkFhmytiDzlujhvEtCsrMUacIDB0sHecYMS9Fvq7hUW+O8nzhA0UmjWrLQuSWpcNZ4BtZqHpe9WsHpJllYfeRoc+2MWc4PiyWnjHY7t88XJrjN8fk65SLIBm8EZSxYZTUcRrMgjI/kZqTvMvuGPjF6B5RfZTK+4kVDibscjJTrW3lifJssEgFTSwyMocGqbuW62IKSAtpxHb+I/5aUO2X5LUmZV0VeCvshBVzwNcoKRYg5LIvwhEYzqeL/M8qZfB3LnQBGjcJLQWtYASAst0uP/Krde1sFBj0rUd2HfQ4M9UMBkwC0JKcBVK9RSt+kVZLNAK78LD+PJqBxg1mnaUsBG9n5PNJrcH67o/TMSSd2hp/cjF0yh
X-Exchange-RoutingPolicyChecked: 
	frKCIE9yASo87pG0kqnTKKuj8pl//clGqj8jWUoMViH5/0Gl1xJmHthsB54op9UfHBOOBolSuUade233tTtGRsRSmnDxWb87HxB6Nk9QCuEuMk3KMCJ1c7b5slybJ109+HLExvbHRlyUfnxlQlnKI74HD3IACxd5/Tka+RWH8fWNqzOLK8iPVxKm/RbgfTeF+AK9i6lAUPuvz31ZU/bMufjjIegB9PsGvnj0ZSLXQThZvSVLWGw/6lmgcF2T5At2t3LKB75C8iPof/N6A3AbddeeuJeNGmMcngoI0VRxpFtCQO3YBhatca8iDgd4P6BulAg3GoXbGtkaT//786RcSQ==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 14:15:13.2202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 1a26d044-b52f-433e-8529-08dedb68ff01
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: 
 TreatMessagesAsInternal-CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB8114
X-Proofpoint-ORIG-GUID: RMjz_Pdmh507idlXNbSHCT0dIeMZhVrQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0NSBTYWx0ZWRfXzY7q+gA9UUzv
 74Mee6roZl0ltCpD5mLpjlV8DZGK248FOctkr02doy2eiJ8VM5QhlV8qj8+rpYVqto/sBbbLEzw
 0Ekcfqsa4XDQkTuXwf3bCByOtmGXpNA=
X-Authority-Analysis: v=2.4 cv=YYiNIQRf c=1 sm=1 tr=0 ts=6a4bb87b cx=c_pps
 a=gVSWREVB2+MMVoEXIx77hw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=w1d2syhTAAAA:8 a=UOLwL_aBn4USr_LkpIIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0NSBTYWx0ZWRfX1FgEphvzxtMT
 Srwxj45Z3NVbK9M/jMaCxZs1Q4hkjqxnFkPmh2o7gULBnaCagxm/aiTfLhji9fBfUNP+kZrSieN
 /JSMTf1VNd3QvproOupKI0qOSVtbvKciTk+0sNJ3jnc6iSCaumQZyfoZ3g51m3KZX9EUsKkU8xw
 rl57j8Gr9+/JqXJL5CM9CL9Xcj+nCkZn8GTRKqpDdYv4lKm0KP0Mhn00x2SklNCll80y94VjTlf
 FGp0aQx0eWAa7JQfhD9n0EfFrfNCnclHhZCmlM2KChL3kvcTsZhDPe7Hebe5MDI0KY/dIDXD7py
 8CTFyyuAD2u8SjsKXC+rgOeIq/fTq682Ry4EuFQmQui/z7xb8Tp8jNmgwXT8xmqtkTBoIxwBmon
 X/nz4hzgaVFFLfyKnPbBtmtIe/tVuv202Rdj0iWh4dS3CemVByF2V60qMV/InEUS5OJy18O3VqG
 xbHQz7gv8fO+ncVBD3A==
X-Proofpoint-GUID: RMjz_Pdmh507idlXNbSHCT0dIeMZhVrQ
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: 2FCCP6VUGQ27N335XG2MGVCE6WGROHKA
X-Message-ID-Hash: 2FCCP6VUGQ27N335XG2MGVCE6WGROHKA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2FCCP6VUGQ27N335XG2MGVCE6WGROHKA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Clean up trailing whitespace in preparation for the card components
changes.

Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
---
added in v3, no changes since then
---
 sound/core/control_compat.c | 2 +-
 sound/core/init.c           | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index 16bc80555f26..4ad571087ff5 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -417,7 +417,7 @@ static int snd_ctl_elem_add_compat(struct snd_ctl_file *file,
 		break;
 	}
 	return snd_ctl_elem_add(file, data, replace);
-}  
+}
 
 enum {
 	SNDRV_CTL_IOCTL_ELEM_LIST32 = _IOWR('U', 0x10, struct snd_ctl_elem_list32),
diff --git a/sound/core/init.c b/sound/core/init.c
index 56dde5bd73c4..1ff340ee6884 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -722,7 +722,7 @@ static void snd_card_set_id_no_lock(struct snd_card *card, const char *src,
 	int len, loops;
 	bool is_default = false;
 	char *id;
-	
+
 	copy_valid_id_string(card, src, nid);
 	id = card->id;
 
@@ -1031,7 +1031,7 @@ int __init snd_card_info_init(void)
  *
  *  Return: Zero otherwise a negative error code.
  */
-  
+
 int snd_component_add(struct snd_card *card, const char *component)
 {
 	char *ptr;
-- 
2.48.1

