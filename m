Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 400C4C79FB6
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:36:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F3C38602A8;
	Wed,  9 Sep 2026 15:36:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F3C38602A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788961005;
	bh=nqlwVbBjqU5J58cya9eQ22r2t8n43CiarbN7+cjY0oU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=awBc28gaxRzE5SvF5ODgogXARde1jKHPmAHO3bX4MX0YefPAI0DJphOlORVwYnvCF
	 frm/KLabYy8Bic9MwAHtaVVwqN2ySmcHKlDnnjBHnLEt+xZoBv6B4iGFEs5zp5CxvC
	 PGvnA/DbsyCZRdjYSFPUxEY2of/u7hc01oiUSrD4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 05739F8063A; Wed,  9 Sep 2026 11:58:53 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A36DDF80639;
	Wed,  9 Sep 2026 11:58:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E4694F80615; Wed,  9 Sep 2026 11:58:47 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1788947924;
	b=cx/P/J+75966geBc11XJOcsNOMt80LV4so+hlSORiU9DMsrKYNNPCwnyZfUSI8kSiWLA
	 Kq5NJjLPV6Go8TNHDqVWNwQuPCWImFvl0ZXOsGIkm3tG/ObET5He2c0XJgzmJ8W1rkxlU
	 BFc4NSFnQytOBhsegqHwblRzAqHisxG06SEcKQ6ZqFFJrzzJLMogSmuI4ERe9Q6P0rBQO
	 k5Hk2SIpexZhe1uR0+fNckwUEzKuhl8ocmYoueHblWRPGOjdO3ev3EHuJ5GluV2KrzJlb
	 iCDFF1Jb8YNJ/1sl6ST8dbuOUgXZ0Y1eMSCvQjO+OaI5JzzbBp+t0KDDHocd1JvWyJQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788947924;
	h=DKIM-Signature:DKIM-Signature:Date:From:To:Subject:Message-ID:
	 MIME-Version;
	bh=nqlwVbBjqU5J58cya9eQ22r2t8n43CiarbN7+cjY0oU=;
	b=nrN3UobQmszigeW6fvXDw7O6CBq/6otCi/pNYXq50cQGng37rAoRUqUPCDc8jovlbf7g
	 marxhmIu6fMBJah8gWp1IXQja622OI6CN7rsUi//j1S6d0uXU59Yk1OElg25E2HyuOO2A
	 SQRM9RKvn3XiEBLq/fRNtNFUFgFVphqKka4tou3A7eZ92aZjOkeDSZmZSKykyzcUGo/XO
	 rvPGfFVAuSoanArGAhYr4IkpWLujBlkk8MmeWjQeuR8sMkF0fMAtNUOw7IP9JrSKdOpkH
	 4rCrtRverAwqS42Z6IMGjYY4CPk3w3s/c45Lr538CYAEvB+tVoBgyC7KlNfBcy4Nm7Q==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=dyBUTxqO;
	dkim=pass header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=qnuYgLcH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9CEE5F8060C
	for <alsa-devel@alsa-project.org>; Wed,  9 Sep 2026 11:58:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9CEE5F8060C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=dyBUTxqO;
	dkim=pass (1024-bit key,
 unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=qnuYgLcH
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6893npOc1578475;
	Wed, 9 Sep 2026 04:58:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=p2CrLP8rMixlPQoljr
	J9Kgry93vDI1N0llbNUPBnizU=; b=dyBUTxqOwvRGG7FBylN63FlN/Cu0iAhRWi
	wWUu+SBg69Rmlh6qS4rGj1lSvj6lFz3yU/0OYsKrOf5iHiTuisIHn0K1BO1ERtn3
	G72lpxdA/kKsQb5gTXapTtA2X1WPHErhvNRh9P9S7hBK/NBjDww2BXH3KOoVaN1X
	yElUs/1AHfsxFxgnYVfZuyE5PRHr3QzDh0V8hFSLyvKUQJ39r5VjYgsJ40tDYmMS
	oAwakehwfq7L6f1ZahIBWII1qBat0DKcklRIJJawyjnzB8nMlwFS8K8oXj7F1f5/
	SK89+k/4vs19dXaBp1BBMTgRIUm8/2St4O+2oEp0/+yZzGBwr8Rw==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021130.outbound.protection.outlook.com
 [40.93.194.130])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4gggfwmuww-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 04:58:39 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJKHp/P5qm1WJ+Xc8ptHkvyzMWbC23daDMr0vdYSqCW6VVTx4qA6U+J8i/eEZVDUg570+hlb7KA2elkY7/V0uDscGa2r0xbtBj6KNWMRrP3c79+Pz8mpxCXtKIy610BpH3tHjBnu7eYzT3WVBI3sJIlwDIf61m0Pbs6ErQeym2pRXELCJgpL7XlDaJEjgCvgCIe/3EggZAVB2U0okVHdvBi/c8dSe4gLoj/1snkeedghAOYYXfYl4W4B+NWt9DjUJXE52VjszDH7GtPVgCmpinkwW29+e6T5S9oK7s7XeDsldOEBRTr1/N8OHCwKK8JTfc4DKgXblQTkQKviqMKl9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2CrLP8rMixlPQoljrJ9Kgry93vDI1N0llbNUPBnizU=;
 b=nBtdh2410vtcbgHEHkrnYTzwWI8szE+6T4uhsOUO6DDfSYCJ5BXF912KMwLqL05Ntn3IBo+HSb8kfOG+7BjKjaNohNcuSUftXAWIImy4Hr2mRHoQ2WMqhabTWR/h1HHGdrth0mQjXhycZbBCz2FtTO4wywXvroQaGKtHWPz1inU61O936bSvyfIZOCq/Q2k3FJGAFIHp1pA8Zg9TYDqchQitMXDKAHF+w6AzeO5p/iwDDFus2OBKcpN6LcbiIkoq+a4FiLlyhV0L47OBBjB8UZOgyKaYsx3JVlfYHE6rjkLATkt7EclR1aOQSLpagOXVAr5+aZngxhr8x0Faf7BA4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2CrLP8rMixlPQoljrJ9Kgry93vDI1N0llbNUPBnizU=;
 b=qnuYgLcHChAAey4PFSRvUx6V1VSPYALIRySP4wGu6+QDMCLsuo7CPfCSsLLlLBiudU58CeSeUpeTVzHJCAv47REFnQtdcjMf9JtnGxcrfd8N+sgpnYd9t6aa3J7k/If4qTcPbZ1e1GrUdk6r8i71wzcNUc2g2W9rqf9fuvH0ZA4=
Received: from BL1P221CA0038.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::9)
 by IA0PPFD8D997F51.namprd19.prod.outlook.com (2603:10b6:20f:fc04::cd2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 09:58:35 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:5b5:cafe::51) by BL1P221CA0038.outlook.office365.com
 (2603:10b6:208:5b5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.8 via Frontend Transport; Wed, 9
 Sep 2026 09:58:35 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Wed, 9 Sep 2026 09:58:33 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com
 [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 1AE36406543;
	Wed,  9 Sep 2026 09:58:33 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 02A8E82024B;
	Wed,  9 Sep 2026 09:58:33 +0000 (UTC)
Date: Wed, 9 Sep 2026 10:58:31 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Maxime Douailin <maxime.douailin@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: wm8962: Do not clear SYSCLK_ENA owned by DAPM in
 configure_bclk()
Message-ID: <aqEtx/wIwdo+D3tl@opensource.cirrus.com>
References: <20260908175802.604262-1-maxime.douailin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908175802.604262-1-maxime.douailin@gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|IA0PPFD8D997F51:EE_
X-MS-Office365-Filtering-Correlation-Id: c20c5a7c-1eac-4580-e517-08df0e58e926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|376014|61400799027|82310400026|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003|16102099003;
X-Microsoft-Antispam-Message-Info: 
	vGc1sZQ2Ie48V0bcqD8lF4kr1h8tWJ6MLw1Lw1dWc95sX7exQD4tJmghkBtqW0Znem46FWkbTquidP0ragTMBCkKJxy32yd3BREYYxa3DWUX1WV7iP6WqK11xtuMy7P9c/Jp1QDaxeHHr5XPcpdIzyCVuvUa3YCS4fEZWC9YTIhHxl3Chk1IUS7Zvoo7PE9NupNL50lX3iMoxILb1TZ09n5TFj4Oa8+qO0HicsJts89n23Vl+kS8DsImTQn1BsBLBA/6/qDoXzf3JjSRMMucCrHK2/3vkDsohPzevouDqtCX25AZ7RhnA3IaKsY8J4z5DnX8DtflA+RWZl1+42xEXbc0asyCwlE0B67gTKemfO0TDUqWJzyP+qkbVSTylgFmsMpmBZfmCopBhDeErmV2s4mS5+ZMsikXNm4tD1UtK/MKktpjZyk2D3mg7+Uf9lIGzQnHfCU2MAmJwl3Rr9DFLF6+5Dcp99dwPVclws3eGAEhpb9BOsvKNtTn070FAOZZNJk/iMetn0vmOCUCj7R2pAmwBh8zJihvtzHLYd+5d9sPzaylVRoe4FokcRJlfQf5Ra4QHlivbhto3GPUyx2yqYay9NvnGxWqT9qmuHPoeVPhzeuGQC2MbuuDydiu4WdWqhyfAZa0XNbnUHdVf4JGtyqSllw+BkG3FJmv07+3PxSaF/DaPUweI5x1TX2Iml3OuHfA91QjzHaeptcyI7Y+rw==
X-Forefront-Antispam-Report: 
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(61400799027)(82310400026)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(16102099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	ZwklGhR4Sy47TKpfBF8dwBn4Jz6jcSNqqx6Mu1WS2s/oGlAeBQi8062BjzJnq9d22lwcQz89an46y1QoSL/XqGk21GpnDk4kPnUteaE4gDHIE2mMQVlitB+X7o8InAEdWw+fzPgjPNyU8uVRsVE/6lMQIP4wh+T7tLQZ92HGQoO3P8M2SZCougJp6/E5xwSncv6gKxYoG0pYhAeF+SCO0D/X1m8+tmuy/exAR9w9rlx3KVQaUol27vzko4InSFWBj/dgMTzU3uuRwbpsretRJdo7qvDBYgxnM64ywiNK0ZeELQ5muqu0iHv54RF+x3xIptOjVW3osltoCHXvp1x0OmZM/litq2mjbRvYxmVk2K9y/YI76aXvxM1iljEUy651x6G4ELn4btEz3+/Orgro90bZKnVgtDzq0fdSieuoF2ehVnklFK4oUvr40bCQipaX
X-Exchange-RoutingPolicyChecked: 
	1R5ZXt97bYHvT0PMwxeCMKoqC2YMHsMvegUDjhs3OGEofvx6Wyi9xU093axolRp9AZ7i2fy+6+4r27NAOp4drxT/9b2FIOMVghvAZvn7GKdsHvG6j206xx/2d4N0CS1BYtwCqqDmfRiGgBOvUzxpiucsBxNaBQ0rPrRoPFtXumRYGY4OQDK1/zDlCqbtSxF3qKdlNCJuqsuDwV1UJ7YvSQTzev2Pc0lSYAEP5rAtZl1EcvFwKTxdtThajESLz9s/Bp4m3FyZT5gIcpHXKC0SqO9t64Xp60WXoPmM+uVXcS4uRNNKUa5Hfrzj1BcnT+/dDfJB79b2CCEQ6IQXg2VkpA==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 09:58:33.9396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c20c5a7c-1eac-4580-e517-08df0e58e926
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: 
 TreatMessagesAsInternal-BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFD8D997F51
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEwOSBTYWx0ZWRfX24XBR1VliKzH
 iBysXrWWCkIRQX0nSVF7PAmo3xLy+JkVJtVrAy4wUkLK8NXdWeBm/HT46Ye0AIFZcBieLXWfdEL
 gbS/c+vYDunKTS3sISuKIDJiwYMqpbA=
X-Proofpoint-ORIG-GUID: 9rmR07eAfNK8Gu6fax2vtU6fndalzJUa
X-Proofpoint-GUID: 9rmR07eAfNK8Gu6fax2vtU6fndalzJUa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEwOSBTYWx0ZWRfX7+s/6F/Tudcn
 KbJhHhsF8C031PoC6YKQqcdMREOj7NMJwhUK7x3Rdf3gCYi3jgWtivk2hukhboLy6eWptsiQZrt
 6AWywaBL9rC2Z7SSBLOqz93jVH0DBeG65s6IlKX4xKcZFEsVMxJS5vx56PWl8OVYY5DrkIaMUtb
 0n1fyxAX+ji1xvIwrZmrsbWWNHnbyt+zMWFrO+hyjzUx/AFZz1AFIlWNftGNACDvqBHkFoyhz2d
 a0HPebhNLXLKzwmFRVT+9JkqMerDfesI3f/6dGjxC2AAnHllWEQlejggy+KVyYfgOdo9mjRlYsj
 bG1usaZbD5v+EgJZ0nlDupwP9ifyfbCfcanr9N2QMJnpcIdOY1GE2vIZsbxWQVKt752S1wGx4ft
 Yu8zHZOgSIMGFLgeH5xqCLj0e8DRMkm3NTSwV+PW6zMD/GJ55373+na+6ZCaQrnJKiJZpZNyFUk
 yoMYkae/Fp9upC6Pmnw==
X-Authority-Analysis: v=2.4 cv=fK4JG5ae c=1 sm=1 tr=0 ts=6aa12dcf cx=c_pps
 a=Pb7wY1jdxbaV20HAOOqOTg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=FqiTXvJd9dB-97X6klcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: Z27FXOC7WRCQCSZGGXFXJ2HOZWQGAS7M
X-Message-ID-Hash: Z27FXOC7WRCQCSZGGXFXJ2HOZWQGAS7M
X-MailFrom: prvs=0712d89377=ckeepax@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Z27FXOC7WRCQCSZGGXFXJ2HOZWQGAS7M/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, Sep 08, 2026 at 07:58:02PM +0200, Maxime Douailin wrote:
> +	int sysclk;
> +	bool sysclk_was_ena;
>  
>  	if (!wm8962->sysclk_rate) {
>  		dev_dbg(component->dev, "No SYSCLK configured\n");
> @@ -2504,8 +2506,19 @@ static void wm8962_configure_bclk(struct snd_soc_component *component)
>  	/* DSPCLK_DIV can be only generated correctly after enabling SYSCLK.
>  	 * So we here provisionally enable it and then disable it afterward
>  	 * if current bias_level hasn't reached SND_SOC_BIAS_ON.
> +	 *
> +	 * SYSCLK_ENA is owned by the "SYSCLK" DAPM supply widget, which may
> +	 * already have it set even below SND_SOC_BIAS_ON: wm8962_mic_detect()
> +	 * force-enables that pin, so on boards using it (the Tegra machine
> +	 * driver) the bit is set once at card init and DAPM never writes it
> +	 * again. If we unconditionally clear it here, SYSCLK stays off for
> +	 * every stream, DAPM still believes it is on, and the codec is
> +	 * silent with "DC servo timed out" errors. Only undo what we did.
>  	 */
> -	if (snd_soc_dapm_get_bias_level(dapm) != SND_SOC_BIAS_ON)
> +	sysclk = snd_soc_component_read(component, WM8962_CLOCKING2);

Probably should error out if we fail the read here.

> +	sysclk_was_ena = sysclk >= 0 && (sysclk & WM8962_SYSCLK_ENA);
> +	if (!sysclk_was_ena &&
> +	    snd_soc_dapm_get_bias_level(dapm) != SND_SOC_BIAS_ON)

Do we still need the get_bias_level here? I feel like it was just
a proxy for if the sysclk is enabled so can just be replaced now.

>  		snd_soc_component_update_bits(component, WM8962_CLOCKING2,
>  				WM8962_SYSCLK_ENA_MASK, WM8962_SYSCLK_ENA);
>  
> @@ -2519,7 +2532,8 @@ static void wm8962_configure_bclk(struct snd_soc_component *component)
>  	usleep_range(500, 1000);
>  	dspclk = snd_soc_component_read(component, WM8962_CLOCKING1);
>  
> -	if (snd_soc_dapm_get_bias_level(dapm) != SND_SOC_BIAS_ON)
> +	if (!sysclk_was_ena &&
> +	    snd_soc_dapm_get_bias_level(dapm) != SND_SOC_BIAS_ON)

Ditto here, just restore the original state. In fact, probably a
neater way to do the whole thing would be to store the original
state, unconditionally enable the sysclk, then restore the
original state.

Also do we need to hold the dapm mutex across the call to call to
wm8962_configure_bclk() in hw_params? I would worry slightly that
can race with a DAPM sequence.

Thanks,
Charles
