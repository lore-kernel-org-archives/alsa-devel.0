Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BF5606A33A
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Oct 2026 16:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=bwbo368l;
	dkim=pass (2048-bit key, unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=ZdQUu9g7;
	dkim=pass (1024-bit key, unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=bdnkD1Cq
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 82A0160229;
	Wed, 21 Oct 2026 18:18:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 82A0160229
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792599520;
	bh=bw9UvdhOnE1qQHk1tqu9vtOZ2jmT0E+W80ex5wwBVlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=bwbo368lMzuLkEe+8nkBoJBdEymenJJejLTImofcAWei9dLn2Zv1g1Yg7W9x8IoZP
	 VOc/FzUCCH5rtntLurZ9OSSY3s0G401NRhtBlhRtK9Kd94UopDjwQ26Qd8mQ7EcAuq
	 NqtNCxJF14BudcdeLDJGdhHhGzTNkD2SSOTm/xl0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 360F7F80605; Wed, 21 Oct 2026 18:18:01 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2FAA0F80605;
	Wed, 21 Oct 2026 18:18:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DFB66F804B4; Wed, 21 Oct 2026 18:17:54 +0200 (CEST)
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
	by alsa1.perex.cz (Postfix) with ESMTPS id AC5BCF805E2
	for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2026 18:17:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AC5BCF805E2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=ZdQUu9g7;
	dkim=pass (1024-bit key,
 unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=bdnkD1Cq
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K597543871095;
	Tue, 20 Oct 2026 05:17:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=sUK3PIVSGfzFH6L++G
	WJ3b4b5TDyBBwNzOPcRi1VmUE=; b=ZdQUu9g7sKSCD2YXlxAFhqYX5s37rNg1UT
	XDB45JQwQapETSXHchtF7sBcScGvTnJ87hgxXNLGE30grhueymPKTP28lyXxbY3i
	pwTsdd+HQvw81hgjK/j/FzHCmyTwzt4p4GCe+6S3F1H4uP8koGqiTQklMD2/+A/9
	5qDg4Nf7IlJYTsgs4NvM40XbpAQQTBjadhFxqApqJvsR2ai/gGjgzo7H5joM1hSh
	7zY1yRSvqtIBH3vsW5UiUk2NwbX0TpsRLNITTTw9pAbr95q3Ojs1LdY83UrcY/WL
	eEwNPHEpYVYLORrC8WH+SFjeSxeWlq74G4kEE57sYtS8nMf7u1Yw==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022141.outbound.protection.outlook.com [52.101.53.141])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4hdw4vrn0m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 05:17:28 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=riJKl9ruF/ZLyooNx8zu/RW0LxKfszoE6/fgMDtagAug+bteJk6j+DG4vfDfAgf0Qo9Ya0ExvHHOC5vQ6l9C1/GFclCms6jDBwfhURj+x0xET7XeklqXYKVRIlpeiBRFvFm73l4UHNYJ78UGTMEZDh/nYyeJk73RB9fUvbX70FOzIX4u8NcMETP0k46LdgwymkuTq9qhx5Gir3XP8FHuI2flkwoGYRqUuqXcp1iDOusFFSDftCZgVQkvfJEEo1JAffAKSnf/WiYMSBGWhZvjwCHCKu/hWkS+uCZZbCvVR6qqKFlSpNvdAuU2Wg85wwNBxzp0R8LkmMZCvVx910Fagw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUK3PIVSGfzFH6L++GWJ3b4b5TDyBBwNzOPcRi1VmUE=;
 b=UTpolcWipIUFBrwoUqsrdaLVjsOE+z5iqd8iC+TK6JV9Juxx5Jc1v/nRpuvXwA/RZ+d1K1Bd4dhCLerWifWUcbyk4VXFOrFQQkYwAWhg3oVz/up+dHOGkDEAqoGwaXUf3tRBIA/J/tn7qn+Fu7epbmzZjgfjBB6B8wpA1+3mui/tZmeM3B4vzBoFC2BRBqcZg65gRQZGSgynpA22tayOG2ffya0eEqUjXN+z5ylqFiy8c//K+xr8LCxmbUq75SbAC6KrzZOZ/PVGVOHSYTUTLbOBg01dCanyOyXG14o80dd4YhYrUnhocsdCW31JRNtI/XwC1okwaWceUBpZMrXyXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUK3PIVSGfzFH6L++GWJ3b4b5TDyBBwNzOPcRi1VmUE=;
 b=bdnkD1CqW3k+pC6KAYkMFMisl/MV7+84mIdTavuTOxpRFgQmDh6l1FCNQv6S54qVZ2aJLaFEPECngpj9JCm396OhEjSlAKVmS5AvlxEVfigGycW+2GMvzC1dCqslyqBWyKi30hpSZyWlXDxaKtAw0DJefCO4r7pjHKHpd7V3Skw=
Received: from BN1PR10CA0015.namprd10.prod.outlook.com (2603:10b6:408:e0::20)
 by LVUPR19MB997322.namprd19.prod.outlook.com (2603:10b6:408:3a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 10:15:24 +0000
Received: from BN2PEPF0000A993.namprd04.prod.outlook.com
 (2603:10b6:408:e0:cafe::4) by BN1PR10CA0015.outlook.office365.com
 (2603:10b6:408:e0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Tue,
 20 Oct 2026 10:15:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN2PEPF0000A993.mail.protection.outlook.com (10.167.248.135) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Tue, 20 Oct 2026 10:15:22 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com
 [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 4F4A5406540;
	Tue, 20 Oct 2026 10:15:21 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 3EE7082024C;
	Tue, 20 Oct 2026 10:15:21 +0000 (UTC)
Date: Tue, 20 Oct 2026 11:15:20 +0100
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
Subject: Re: [PATCH v2 6/6] ASoC: SDCA: class_function: mark PDM data-port
 terminals
Message-ID: <atc/OElmZHeq7SbX@opensource.cirrus.com>
References: <20261020073856.1177749-1-srinivas.kandagatla@oss.qualcomm.com>
 <20261020073856.1177749-7-srinivas.kandagatla@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020073856.1177749-7-srinivas.kandagatla@oss.qualcomm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A993:EE_|LVUPR19MB997322:EE_
X-MS-Office365-Filtering-Correlation-Id: d0bf2d0d-7162-4369-90e8-08df2e930d68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700016|7416014|61400799027|23010399003|82310400026|261009223027099003|10067099003|56012099006|22082099003|16102099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	TXfZlK6mxhFW2u4KX+JjvAankhg1PmYk2+/WLTMyT1ImsqXHjfrpm2ZUHUO8zwxSTsZNcJ5vft4fzRN6uiSXH9uvm9xHvugIMtAZygpcOlQfvGwbqXy48Z22Jo3tNpoTUJLOif1lV/mhxz4uBJ5GtId1OiAqr3lTba+DWeHbOcxSKMR3jMvUm9SNbXsrh6AubWczpyf8K4+4YDzHomKocNMyjEaUce/tYUw+0lEMZbQmwaqoj/UhN1dCQWbPBviqE0CrEqYD0oypvmbUUz7XK4KUVKbjndddkb+pv+PsGP7wJFPLYSH1sxP5MPdiOL0yIwgTit6NvPPs1fSECWwT7emRoBxpsgFFx6eaCWwVKC2BmoB2ntoKMiTK7LcX1LvADSmGSIUHswJZYo5FO4uVdL0Cb219fI6zvGYemAzWRHjygQvsSJgGAe2qynqqJYyJ0AdF80WLStaVBV6oeLjrThVwHXPwejd/9kg0LYktP4KC3wHMiRC0Q1pInY2MWsQNtdMIMAsNXIXWYb+3afbhTBwYhhWqmciVorKtbHCvBvFG7xZ/7mLH4N/5gBZm1KpnZZraXLWzkalSEbkakjMJ121AkqnBtNo7Of4E9Z6tv+4XOi1Fzb/0UVs5v0iIZW7E4cw4puARgdQlfQkvTYK27UyofhRYYqf8c1glHcGWVcwvKFkrPnoH5tOOEwWo0tnEviQn8fiASGGoy1Q6gFaAsg==
X-Forefront-Antispam-Report: 
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(61400799027)(23010399003)(82310400026)(261009223027099003)(10067099003)(56012099006)(22082099003)(16102099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	fqDw1mkEk1IanJ3MzhIt3hrdQMDcOY44DBEaPFw1WSnbs/rst8Tv5lIgsDRVQYcCWBi856k2X/Nv1ViSGXGcIUWk1JW6aGJcsAxEE76sn1VVycLO+pLZpOISt/KGtzXrMIMyNxh/JsLQ7eSNCeCA/s+erI9WbFeBnNIvk/hGrDhAqPvV0N4ISx14OghNX1sg9w6fqPfBv3SEwVnrHacT9n8B7VLxrQ9vz1Ifk7G5ZN3Nw4JP7xfQUAYeY3bHVhwUkMtceM1M/OOMOaD4Ak/ZllCkR795cPEGWI3TvycbYVYZN5riD3988JI+M+zRTMQ3uO+j21hhpcOZ/hBry2lr2gOd1+ebFvCNd5pLtzUe18zQsWyEmP6SLRYoVEDIfgf41lFhOcnRTGvHtedAiD6YwHyRVjAI7pXhQ57IP3EsMaiP7GioXAvl+BWPfYiwxJiT
X-Exchange-RoutingPolicyChecked: 
	rH2NT8rlh0n55VIAyKmTO4EowlgUh2dgdUyD368C2CioUzJTqObFNHmLwiovf0PzW85k3wc8pNDRn8eHaNB0aVFvcxOWsdbf7R4ptjaRDXiDw442+4iFjts4VR9/MQb6bxN9WAMfjaCdXd8CHY3FZ6x9uQoXdoeb43gVPcVsG42zGjAyIuaMKq77eGfKLiwNICcD3DNyoZEa88xYeO2lHTh8W0chtikV2Na570v62KBzWNXeHh+QcLc9ZUwBtU1wDzWlrZS9y5m2gs7xHhHTJgu/CY/b7V4JyJ908k7nCNAkoBPUlPWY/2XmTOgXrS/3bFB+mUSamtrFuN57xs9jDQ==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 10:15:22.7667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 d0bf2d0d-7162-4369-90e8-08df2e930d68
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: 
 TreatMessagesAsInternal-BN2PEPF0000A993.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR19MB997322
X-Proofpoint-ORIG-GUID: QTn16Z_NiWC1Kt6MB5nFUqiikosH_w1O
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA0MCBTYWx0ZWRfX04rLA41Y7cQG
 QGdzJ8mQQO7k1krlkc5VoN/C7HpDsrp6j9ySe34XoHmSzpibI0FagWvtLJs/YIKD3XCaQRo7fBZ
 KAT2sMqapo1BbmPvwMMACbzN9ylPxfc=
X-Authority-Analysis: v=2.4 cv=H7tOUOYi c=1 sm=1 tr=0 ts=6ad73fb8 cx=c_pps
 a=wck1Q1pII696GML7qL2HzQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=EUspDBNiAAAA:8 a=w1d2syhTAAAA:8 a=TSVlg5FyD961pMgYlTkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: QTn16Z_NiWC1Kt6MB5nFUqiikosH_w1O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA0MCBTYWx0ZWRfX6ptY01GM362Y
 dGpXB7MR5YV5iho01FWZUt2EgYuB3hsBDfo40boHREryFM396Sq/k3vl3LXqaI6ncsWiJokKuEy
 N1J/XzRG+8mNI1mK1cPEg8vYzq7oLiBcM6riIhYsOb9T3yDmTZPtgIyqfSVwvZH/sf7G/cxcRZp
 59bhgF44oHGLWrZucFctmc1i8jcqhfkFX5+PFghArNd6DqEfyEhWHYx8p8as1OLMohF6GNp5OY/
 51VUjLTTgDYMrCVMXOSGe4PRellnusoJySuaO2xRXeZB8owXlPn7SRCa9wVMe3R8afGeRKVPa2N
 c2Zq409Kg7dOdH2/C2WoDTkGMhrk2wNV1w1JbzvEkxY3Am0StSyPxJyUhSw41AwSmoFlT/FIAJr
 g5SySw0ztMFgzekZ9JTsUTlD5CWEU6JAjEGptehCVCrXgmuzBo0CSBNchjm8cQiukcCD4O0+MJw
 UcyqWKlF4sjTSCBZ0mg==
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: Z4FHDHOVKVNQQXWNTPFJWDVN35GDVRAW
X-Message-ID-Hash: Z4FHDHOVKVNQQXWNTPFJWDVN35GDVRAW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Z4FHDHOVKVNQQXWNTPFJWDVN35GDVRAW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On Tue, Oct 20, 2026 at 08:38:56AM +0100, Srinivas Kandagatla wrote:
> snd_sdw_params_to_config() leaves sconfig.type at SDW_STREAM_PCM,
> which is wrong when the DAI is routed to a PDM data-port terminal.
> 
> Set sconfig.type to SDW_STREAM_PDM for PDM terminals so the SoundWire
> core sees the right type and does not enforce bps match against the
> PCM-container-width value stamped by the helper.
> 
> Assisted-by: LLM
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
