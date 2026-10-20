Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B590606A322
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Oct 2026 16:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=iElsH/6j;
	dkim=pass (2048-bit key, unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=O/I5O12c;
	dkim=pass (1024-bit key, unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=mP6FwbAL
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 12E8660216;
	Wed, 21 Oct 2026 18:18:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 12E8660216
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792599500;
	bh=TSR9N2FsGYlO6IAlqaW//k1FAUuGYp1GYhW2wfLHlik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=iElsH/6jJ80uX/JvpLiUC/3zDXMzoqpFXcNw1qt966vYZOzEBB8NMKYxnuaTprsDW
	 1MAkGUgrbMcN6VYt8b4ZtJK9Ca7hzfsibVlsEvAYRIPpaFLZrV4IF+BC9eecMtFWyP
	 PArtydFY7TaFuHL/TfDm5EctsuhAaS0zT+iBgQuk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A3B46F805FE; Wed, 21 Oct 2026 18:17:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DCF63F80600;
	Wed, 21 Oct 2026 18:17:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DDEE0F800B6; Wed, 21 Oct 2026 18:17:37 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DFC37F8003A
	for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2026 18:17:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DFC37F8003A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=O/I5O12c;
	dkim=pass (1024-bit key,
 unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=mP6FwbAL
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JNi6BC3322721;
	Tue, 20 Oct 2026 05:15:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=F0nRg6DarXbJ7PLNTJ
	jNFqgOBSBcBU7E+Qn8QGb2BjI=; b=O/I5O12cPSfPO8WGhAaMMNEf0HT23u+0pf
	EzhF/60M24Irv4vc8J0PKxqUnohxudBwy6G/tWNg3RGgAPh2wvOBSz2zEvFeXKs8
	OTcfnLQ983rCnucYbPPodPJvLcb6klghrna/Uco32OcU9ObTRhoaSsNmyBzmRoa5
	dEZcDTqlMUvSCyVC66GX3MjdG9wHyBBbXFXn137aE3iNIsyp1zS/esfWH8uiO7Mm
	pUpAsx/ZgZkhoOnLbnmx3KianOaondtYW5cHkpmXJGmSwTJ/0JKRN+8sTPQEInnj
	SOJT3hj6IvJ3qXQ9SZOJg0jwuCFuyBsouQMih7ug25WmcBVEqXdw==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021075.outbound.protection.outlook.com [52.101.62.75])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4hdw4vrmv5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 05:15:07 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6WWwesWlrOVCt5Wgkl7/s2VlIPitO8cR4huArdyWZ+UIOXmnsToldjwiCYmnXuY4Th63h0lMW5iCICW6a+g33C1dWsQVFmIUkCU+7H/eju/poJTcgy0hYun8VwS9aQDdWPOIf2NiqC1TinILHXa4xKQrAc6eFc0OM+zxJUlCFQG9lKS4m8DfmFzCac9dPrAwO8VJHWhPuPh3o60qUgC4RtU+dQPaV1n1vIv6iGVD2hVBPehZjugKcSFVKs0fgcWYbV1EZbWpSEF994qISCZ0Lus6yGXg5cwJcQauMPEkT3EZQneoNViD4jvCAEUNVczapBXwe92kRSNbx1s+SONsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0nRg6DarXbJ7PLNTJjNFqgOBSBcBU7E+Qn8QGb2BjI=;
 b=wJWGA8FHGiH/ICZofesrewIpcO5kzLQZa40PiSJRRPxWoPm7ZsYEMWfNuLsi9abM8b92StHLa04RyXQOBx6wm5eseEZThgz/WMCtePjoP5RxBxs2vUATh2aYkh3FkDdenriOl8eHLWPuSouvROAsN1P5y0SVYTfRbVl7SDTheCC623d1JRxvpnPH3n3d714ctcmyn8ys5Pd5y5CFFGgt9cQR+sWoOQCpigKDHHs/KYw3bkP8U1GLV9eAwF4eVtPxo+wR9YQjGEDYf/Tb9LNq8yHzGIA12cu6YoQaFYCVAWKg8L0fa5rCOVb4IZqQ57o9jA7CGUAX4I2ZRAnqSw/qDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0nRg6DarXbJ7PLNTJjNFqgOBSBcBU7E+Qn8QGb2BjI=;
 b=mP6FwbALtnp8hTPjg8X/d0gQhvwWIgDz8l0P8vOqp548ph/ym3GOV3FFWLtMQREaT5qRmI5CEL+Xu0Ii2VPQKqA6LxYN1aA2h18K0RcF2THQsexWNIiY33sPfKT0pyFJU2ntdiBuslsv9ie4uyhCV2Bhr92wDMfo82ks3Hzoxmw=
Received: from MW4PR04CA0148.namprd04.prod.outlook.com (2603:10b6:303:84::33)
 by IA1PR19MB7231.namprd19.prod.outlook.com (2603:10b6:208:42c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 10:14:45 +0000
Received: from MW3PEPF00001657.namprd21.prod.outlook.com
 (2603:10b6:303:84:cafe::a3) by MW4PR04CA0148.outlook.office365.com
 (2603:10b6:303:84::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Tue,
 20 Oct 2026 10:14:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 MW3PEPF00001657.mail.protection.outlook.com (10.167.249.201) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.0
 via Frontend Transport; Tue, 20 Oct 2026 10:14:44 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com
 [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 32C83406540;
	Tue, 20 Oct 2026 10:14:43 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 1907882026C;
	Tue, 20 Oct 2026 10:14:43 +0000 (UTC)
Date: Tue, 20 Oct 2026 11:14:42 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
        Maciej Strozek <mstrozek@opensource.cirrus.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Sanyog Kale <sanyog.r.kale@intel.com>, Takashi Iwai <tiwai@suse.com>,
        patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] ASoC: SDCA: add sdca_asoc_dai_is_pdm() helper
Message-ID: <atc/EirmsA8P47Ay@opensource.cirrus.com>
References: <20261020073856.1177749-1-srinivas.kandagatla@oss.qualcomm.com>
 <20261020073856.1177749-5-srinivas.kandagatla@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020073856.1177749-5-srinivas.kandagatla@oss.qualcomm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PEPF00001657:EE_|IA1PR19MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a8019b7-b9d4-4225-a270-08df2e92f6ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|61400799027|23010399003|7416014|376014|82310400026|36860700016|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003|16102099003|6133799003;
X-Microsoft-Antispam-Message-Info: 
	3zeWqzMUmLQgAYxTToocjHFjOCPdsSakuDqyNp8FzWCB1kbIkSrnvASE31CwYWMCi3Xl0BmJAZhh9IuPe5d9awsPEMd2IIJdng6KKamSeFQVOAj30zA7xC0IKO767ZqyoqM4QMiyseEs0pcquKRVfTkTbuyQAwOvgewwOYrp3iwGNVPLfzKNzuPian84dcTIVNYv/+df5g2qIOtb/oo6c4J+mbHa41n+9yNppDx5eXK76LKV2jc0roedEppAGuYQApTq8ZFluI11d0taSRFxtXEU5+88tVS5hIuALYSdbeeKwTYnCJLt+aOYzS5JXqrwME4ueIsJZ3XMm6CfziyAX2HOYLDri8LyZZyP5NTSoii6NW5g95TZzpzMWEnkEGRBEadWf1DbhWGBSixHaiZac7L5Th9Cunm9y8au/qGWl/vJTLzh7naSDnVIcuZoIeQ11ibFWNm49eGqkPvNrGWhIJfxGqVAZlWok8NVJMS34LCuRcE/jV2bhWfdxdbGs2UvXgqyPWi2eLdTJhXsB2q5qFpY3z6hORrKGLgG1nZF21FBdk7lD1jkrEwvkq5NVPobv5cFqdeVIFIi2TCuS8OqxqMG2r1pvTx8tgdLcG+nNa46DLpPBr9wzLtRlpGVp+Q+zQ5fVIMdMVxcAPLg8fSML3IfMA82fozCmj6TNqlTbde8lfzLagEbsWA/hNSoEaVQL5QZ5yNClge6rL7dmDSS7w==
X-Forefront-Antispam-Report: 
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(61400799027)(23010399003)(7416014)(376014)(82310400026)(36860700016)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(16102099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	Our34fwdguKt+xW99vgtu6XufNrNQRMHqQhfZakGghLYnRjNngbK7XnszLkuuplGO8zEEQi9DeJXWEnzO8T+WvlxH+IZFB+uMTiWASlrrT9/yLd20Z4yXzQOONbptWuTrxhcnxEclPGFEj7XaEge/wyVmKL94fPrzFyeRcMi3oNdtS7pEbRllw8gOXOFW9SY7KDE/dcyIZWYNUHow/Cr0VzUfG7umvBfrRsdKnl/ZDS67+yUoHJmKZAd7w30PQPtMCw3qHrR0Db9n9nGMVBLw86jxTqKL9wd8Y+JuncNPIg3MARoJqPomWVfNP4O+tYrRQ/pFfxvWz2+Ul4uMJPkK4VchhrDUt5BtFetdeB/NB9889dr9+rArp4muqSvb5dPFO8TdZpYStHmQdNNZMN8DArdRpzu1Tp84nv5P/Pv54M1xfgjJP2YW0fAsBycjG/Q
X-Exchange-RoutingPolicyChecked: 
	FRpnLGF1ErdfaZThPL7bQT+ykwLJvpp4TbkdUoPZzeJlurgNSYijOtETW9aX9uTYJO+cd7qV6l5M2xUeK4UR4cvHlDZTIfLGKrUzBhJUgOrnaCdx0PgkqgVCQvkOQ6au3YBrR8435oTGHvdpIbyH8Sgca0yXkjJNSlblvL115p7zrUWqSp5PFDJAx41zX01BgZuinSIxS5oV4rp5v44Z3jY0KcrlleEYdzpwmG2b6owxuPK1Z0gCTSIQVHgpmamiwQRDd/IMWVy1TF7SiLnZ9wmIijiEnc0bTC7d5/VxbcIiFBSwS8XQrIMWqxDgCentsAp6sCA7qLxZ8NQ/hBDbaQ==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 10:14:44.5246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 3a8019b7-b9d4-4225-a270-08df2e92f6ac
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: 
 TreatMessagesAsInternal-MW3PEPF00001657.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR19MB7231
X-Proofpoint-ORIG-GUID: yJwrdRFekFQlONn1x6soExwAOBfmq781
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA0MCBTYWx0ZWRfXwjQf3ueL7uKC
 yfeTruGrqik/AqI96t81dRei6vMondwuofpAAjf7jYh50kwqHSWF89qaiVpE7NmIU8MTj2Hv1h0
 bgtRXx4dFWib4+FdiIntCLtpjGIiIzI=
X-Authority-Analysis: v=2.4 cv=H7tOUOYi c=1 sm=1 tr=0 ts=6ad73f2b cx=c_pps
 a=APgIdIbuBBIe7PXa++EYhg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=EUspDBNiAAAA:8 a=w1d2syhTAAAA:8 a=PMMAhKxhBvsIc1GxJQ8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: yJwrdRFekFQlONn1x6soExwAOBfmq781
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA0MCBTYWx0ZWRfX1UWTTgLbFMAu
 9mRfOg6qXf7YTiSHPsM4LNTTxIB6IhtQ2zcDoQH/XxPpuGiU0PjmGammyz6q+HJgVASVRih+qJg
 RM/0tlF9tPYtijS2VBQmL4Oks2aJSBDGH5X0M2KM3uSeeCFoPuxXj+1PEx7Ea1yF9sXCNe33b6H
 MHM9p0yWzBSwbET3W/9yID+4JYEedWCgNaTmkVjfIzzBaNP8IBqIzI/s7+c/FAHJEgqDMAb1s4C
 c9I5PLqBJzaRFqvtU0cBeS3tUyfU2J7hVoZH1Y4uczJefVpR9K+vArlQuvWekntg16OsuCI5fZf
 ZQk1WGaiLYHkhBXlBIXF6ah6MlhFGDFz7A6Czd947g4ZKm2sc3dL+5GFle0IvZ6iRuIfjJ+udSH
 sUbLe3QdnC+rmR34KKMVICHh0B0txI6FPFByN1oobIvZmMqc8J0t1Wu64MyRKhMV3GoQv957+lY
 Vw7HhbtQXWa9XHpByzg==
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: VKKFXACCLI3LBLOXUGMXD4SY7P5OPTO7
X-Message-ID-Hash: VKKFXACCLI3LBLOXUGMXD4SY7P5OPTO7
X-MailFrom: prvs=1753b3f352=ckeepax@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VKKFXACCLI3LBLOXUGMXD4SY7P5OPTO7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On Tue, Oct 20, 2026 at 08:38:54AM +0100, Srinivas Kandagatla wrote:
> Resolve the SDCA terminal type for a DAI and return true for the
> spec-defined PDM terminals (SDCA_TERM_TYPE_RAW_PDM_MIC and
> SDCA_TERM_TYPE_PDM_RENDER_STREAM).
> 
> Used by sdca_class_function to tag PDM streams; expose it so other
> SDCA codec drivers can share the check.
> 
> Assisted-by: LLM
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
