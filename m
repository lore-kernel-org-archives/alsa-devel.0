Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDC7C44501
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2026 09:14:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B8F0C601F8;
	Thu, 16 Jul 2026 11:13:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B8F0C601F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784193241;
	bh=rMy31TSn0tM3NJfiwtplz6rA/G7pGEcMGnWagst6f/s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=u5YpYb7e7kozSssF/5jmvzr5BwOxOS7Kpc2EiKdiipHES8LgkPt/tq+fo3ReghDHQ
	 FHsc1/F6k1C/TaiB2Es3J5LlqB6xZgWaXqGbTu1hkLWLgaZT96FAVYiojTXqvMRkn2
	 /8Lf8we6Dda95w/zeCeFMqruSdo2KKI7g5nlgu8Y=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 91900F80601; Thu, 16 Jul 2026 11:13:15 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0EDAFF80603;
	Thu, 16 Jul 2026 11:13:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8C6D9F80527; Thu, 16 Jul 2026 11:13:08 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.168
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1784193187;
	b=Yg98V4LFi5CAqGbyc39z+bAVChDSYYGr8NPlPuLFFUwKBCG82ioYYsLciRa+DSE7c+Ni
	 0ZpWfa6y4yxrISemdy+cIUgxjag9/a/O3RcULuA5VbBhIgR13woP2BQ11CTIMZrpY6Lkw
	 9Fjg0pPEXWjOhNpwGlpTYYAIB8Fo3t2ZJvtGIVicE5cCjEKVE2dRMesCX4kBUipv6SndD
	 IyYRifZ+iY9qIQzvQVfVYAWiKfi2c1FNdH+Xhp/lRtC3U1zS+ZE3X9ERrgXoieHooWoR3
	 RofcQqX6CLiNd5KdU11RTjna7iLHEKy+L3XqRgbBELY5+TTVGxgJBGVB5sg0V4QXidQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784193187;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:
	 To:From;
	bh=rMy31TSn0tM3NJfiwtplz6rA/G7pGEcMGnWagst6f/s=;
	b=Sct14XxAsm/sqRYc9314VMcJRt6MxPvIE5UTMGrBJCwH0lT4YxdfOs+6Z0hrcxtPuwrl
	 4GYP+wRT2Zhc7OiP8YZtxDDniZv3GX+YonFACIWat2l+/mEd2z6dRfT39lK/HPWPCw1uL
	 EeBckM3AWTeBBHJe7vGP0GzgVwWfxFaYKatA52tbn2AMnB6bXSO8dzWy9Vdla7MPRleoQ
	 Cz+AnRqGFvcTTwFUbZczgZ02BVSIU+DNK313s7wXTsLT8Y+EEqb7dcGuWVibXQ0zR1dj9
	 OMFFy5NEC9gF5poXa17FtraalXEzoC54i8yu4NBHJK3UaRVhgJuMEX5HI5Kdm3a2CUQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=qpxNqMZY;
	dkim=pass header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=KJiULY+1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.168
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 17450F804FF
	for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2026 11:13:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 17450F804FF
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=qpxNqMZY;
	dkim=pass (1024-bit key,
 unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=KJiULY+1
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66G2A7LD4058977;
	Thu, 16 Jul 2026 04:13:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=HjwO1xC0TFecCNUn0BACRV70UD/fJAqFZ2aWSrIIdEs=; b=
	qpxNqMZY75OSuMSrymGC2G21ZAkes0gmBb4OBah9gsXT0vmX9MFwLcJ41h5LTdn4
	LgzG+CrEiGuCCgLenU4ZB4Ug1QAjJGy0caL5Agpz5AimkucGsqD0r1rHKMpRi60P
	46tg0OPFDabkb2YtMbBu7LbyBWpmmVyB5c09rY/DER9NmiemCrcICFrLBJgukVoK
	144IgoSyBbhvFnZI3tTkCgEF7vuVrpSSyeTQX0366kVZi6VPHABY1QCh5Zp8LWjm
	lYFCBgRksHKMc+AByNBz6J0tP1FZ8gCrI38rb1GP1bdmcqdT6s6GToMMb3fhknPF
	+r4LoRvrlgHJmAS46+Lw/Q==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023136.outbound.protection.outlook.com
 [40.107.201.136])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4fbj8fpx5m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 04:13:03 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=utgZMLUVu0dgNdxg701BYHr++gami8uhQyPD0avomjQtdgYmL9nspvrCjd3JTnw0I0zIugwCVngt8XuhTR/5QCFJPn9RCkBB8dDdR8vi/L+YU6JJ8VfvQc1UniPCJarKJ9ASbVjDNE31SEjlohUToLLbtBsgPG9epEaZIbB65p8F/dhKS+MP1DjGYQQfM9z+O8wNUz1J3r56ztKmh1/qnEUbrbTmjFOBLsP0B8NRqlJpWnV8ulR05PCY6tdN+j2RccIndtNX7FpX02txikYQ8Mm3FKvizW8XFKSsGVTL37+de2OSPWMP1fl3N2Roj1j85yjDEgiN2EH8W8sJEs8D2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjwO1xC0TFecCNUn0BACRV70UD/fJAqFZ2aWSrIIdEs=;
 b=uMjuTg0pbrtXkUPiEu0CEBdipJAf6VA4D9vA5/grBzsVkgTgQEg0zU9kqQC4h5UbSPN1qLvbNCMV4FoyL4qD9cxKs4wDqP44aacR1sCsyR+QtlYpiJQOnJes1Wtfll3t+jgNnGV4sLFmpXItvWPSau07uhc8erPsY8G50Bgo6e5gmpM2ChXh6pdu0nEv75F8qBDjGqSgdTQEoxwVmtwgWoSutV/OwGl9UK5jkTSh1/xsvgv/W1ggvG7o9oDL1vF4vrHWZGeqmSPu+YpAJcfBnu0W1VWyXC/8hlrFDG3n695cZvZChvqkNHsM3EoVB8PWqkMRP5ZcR+dUPDOa+ODFnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjwO1xC0TFecCNUn0BACRV70UD/fJAqFZ2aWSrIIdEs=;
 b=KJiULY+1Ub1beoK7zcpULsh6tZ04fUvIx+s3/2X7QVmGrGkDdmExbZXw+G8NXt7qMZtiSlcSA5QV1QhoGzLp+v3q7jncoaLt1Xgwtn71KPLTdrPHKsMf7+C5rEVCCq3No7BCT+qUZ8f7vTTYYBHSeswiEibLzhTmPDmmo1Bjh7k=
Received: from CY8PR19CA0030.namprd19.prod.outlook.com (2603:10b6:930:6::21)
 by PH0PR19MB4859.namprd19.prod.outlook.com (2603:10b6:510:91::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 09:12:59 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:930:6:cafe::a9) by CY8PR19CA0030.outlook.office365.com
 (2603:10b6:930:6::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 09:12:59 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Thu, 16 Jul 2026 09:12:58 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com
 [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 88869406541;
	Thu, 16 Jul 2026 09:12:56 +0000 (UTC)
Received: from [198.90.208.11] (ediswws06.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 793B6820244;
	Thu, 16 Jul 2026 09:12:56 +0000 (UTC)
Message-ID: <95c21574-97d5-4311-9263-9e174d22d22c@opensource.cirrus.com>
Date: Thu, 16 Jul 2026 10:12:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BREGRESSION_7=2E2-rc3=5D_ASoC=3A_cs35l56=3A_compo?=
 =?UTF-8?Q?nent_probe_waits_for_an_init=5Fcompletion_that_cannot_be_signalle?=
 =?UTF-8?Q?d_until_the_wait_ends_=E2=80=94_whole_sof=5Fsdw_card_fails?=
To: "Salman S. Tahir" <salman.abusaad@gmail.com>
Cc: patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <1bb9628e-3c3b-4b43-906b-0f5bc2f6e4d5@opensource.cirrus.com>
 <c730789d-2a46-4fe7-ba98-fab990361e90@gmail.com>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <c730789d-2a46-4fe7-ba98-fab990361e90@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|PH0PR19MB4859:EE_
X-MS-Office365-Filtering-Correlation-Id: 0551fb79-1657-4f68-92b6-08dee31a6ddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700016|82310400026|23010399003|61400799027|10067099003|6133799003|11063799006|56012099006|5023799004|4143699003|16102099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	n1dqhx3YaPGar/gij5LsAnq11/DM2cZFOl7e2vXkAea/AZzsfhzs90Ppo4g3XyBgyCSL0qRQz5cwOYZ0ULgN18XPZKU+hFZP7ZHC//Bwa7N0eIScXVwHntC0lOm0jP4hfVpWC+SqaDbotiZPBjQN5LlzvWXX4BbWrs5HAeiAio61hyXfvJPNErKGF7Zrqn2ujK5ib7xxepuBRvXlx8p605nWNonAMv4+paiB0Puqo/zjrhFRqmdre7FIDx3yml2cIZv4qvnLupZ+KL2PneORbUGK9M0mGQAwvGL7j6ydiL+8IRnGUsQkt8OlY96zQMFGiGShIeNh+Y30sZKOcIW/hU6gtOUNPwvi7U8+qsunFLDrs5TzwpPOxiMslVB51b39muhxfy3TxHFzMrcQcDPSXWZvHCtnzhtnvIWpGp24mGg4bwmWB9J2llWga1DbnAZ43Kjksg6WBLswsfl4zaeBduf1NQ4Xhm6gM3u5zI1T1lS7ZtGfrkZSdfgsGVObAJI7Cs/Z1GGRSgIrOnfUobH86je4waWvHZYzRBkUTFQH5X/5Aqwj1XiE3QQTSC3IR9DIwSL0Lraz6o2mtLOhZGOlGGasf9gMZXUsATM/g3EAIgzKZ/47PCFOmUS5Sy/eVTJ1FbQOCOHhdoRgiBh8dbSs66I4tsN4jJdC1XVM5JtiQMKcoikTjeNLnAhj+yC8okeE
X-Forefront-Antispam-Report: 
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(61400799027)(10067099003)(6133799003)(11063799006)(56012099006)(5023799004)(4143699003)(16102099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	SaB9J2kVybpmnLbrUTx+1WYMqQihBFQaOkFxihZnvdjCC02ikraDq2q8779rg6G9BQ2/7qiAMOSNo0SOnyqyLvJno78a2l0LvR8xRhdLReSv2ri2+kwwA23p1WZABpMOd+EpkMw0f2LmcIKbI3bvsBBQ7QUaN6D8x7HfUXvWTWYvKanzDbHOfywrM70bKwOIiutBfH+GhzDGVDoTWyywjN1X6tk/IJBfe8JO+Zo633PW57am6AGEvIDHsg87iUtz+KlA5H78ES7Q5PJ9A5KpUI5YwQ3vYyOry1cBptmy9RFAUdLpflyIytyJddc+kJEEgjlGWOrYLQp3dyBL/LC/xHvc5x19Lzkcui8ZkkLbGM1g7kDh499VqlPM1gquqFQleyWJsxqk3JXtSVYxzBxX/DCJ5lHN9JwAI9qhSq45Bpoyv+MoXl9KXQMpyPOZ/EEm
X-Exchange-RoutingPolicyChecked: 
	itKkDca0AvzeSvwXbm4qUItpskEDezXPFasa3ljVYquY+yRGTFbQfME7Has6SMijijIg4u3ljbem/hlv9x6AHouHbcfSqzSJDz+HMOjSac7dfRQXj5/c0uCErZwQI4tcsa5xGza5tsEZeHV/Zframksjx5ymW0zYv7FdjGIL/RFN3mA+psRPWBqR5cMQgyIMcz8vfCfWOaJQ1boA1lVH+F8CdCyu7adp55/I5+fD8C2Bra4+uBVBiECE4RP0U6tY2ZBxrxvXyuECiXJ24GoWQvnbxFn9DikvqZtKz52aWFTtDtGzBZhUJLqDbCLreWKJg4pskjCMA137HpvKLmuQfw==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 09:12:58.2095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 0551fb79-1657-4f68-92b6-08dee31a6ddd
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: 
 TreatMessagesAsInternal-CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB4859
X-Proofpoint-GUID: nnGSxMeewVcwZDApXJtR89AWGGMasnFR
X-Proofpoint-ORIG-GUID: nnGSxMeewVcwZDApXJtR89AWGGMasnFR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA5NCBTYWx0ZWRfXyIY3U/3h1f6w
 3gH6ueVTVtXxrH9Vw58ZL6RAIf7c2NlbhFulgYM5dmRqCXYuDDsltg7UR3klcILFjNgJiKNOYj0
 Lwv7pfA8chpZNBBa6qD/6vckw8NV23k=
X-Authority-Analysis: v=2.4 cv=M7597Sws c=1 sm=1 tr=0 ts=6a58a09f cx=c_pps
 a=Ec8ZIgkrxK8GE6F7YKoxaA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=p8B4ZfjjwVxbjijj:21 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=5KLPUuaC_9wA:10
 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22 a=Lo94P3RhqWGIF8nOVJoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA5NCBTYWx0ZWRfXyHogrIREViM2
 Fq1eOaGHS7ENV2jPjYAC5gRV9rC/w2cEH6FgOSfc7kPal8e355eoX8TeQGLjvUcAW1LCExllcfV
 XARkDEUbOst8UmM7RXrZRUy8G0B0k+s8yhdDXaC4Hu7KFCMrVKQlb39SjHN0AK/qa9s+3JkAzD+
 PKIfWDmW55Z4bm74MWgAS8NsMOI8Hxu3hnrkaruZkeP6LgqGOwzrDBY1Eu3bG4TiiNv66eaGRLF
 BdL7T4cbVrajO9M7bxjaauO6pFZYF4KIJjOH6+DkcLR+Z3IdhHRYUfw5W7pv+zWBKi5gwLfD7is
 QSoTiyrzu+MruO3opBEOPDcushoI2aiAE5hD830AFMBjTYCKPjBkw0pWL4qBjJNzp64wa2IykEl
 0/yAwt6UHfLgmRvoE9U/MEz78JWibgmbYdz1Wjfv5keXwaX584bh5Mk7TvCV7HuP3RlnVs3GchC
 43WI/VZAzuilQF7/SwQ==
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: FYC67TVICBPWSXZXL3VAIGWBO3SGEPZ7
X-Message-ID-Hash: FYC67TVICBPWSXZXL3VAIGWBO3SGEPZ7
X-MailFrom: prvs=8657838951=rf@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FYC67TVICBPWSXZXL3VAIGWBO3SGEPZ7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 16/07/2026 9:06 am, Salman S. Tahir wrote:
> Hi Richard,
> 
> Thanks for the diagnosis and the complete() -> complete_all() suggestion. I
> tested it before replying, and I'm sorry to report it does not fix the 
> failure
> on this machine (Lenovo Yoga 9i 14ILL10, two SPI CS35L56 B0 amps, 7.2-rc3).
> 

Yeah, I think I see what is going on.
This amp is normally used on SoundWire, and probing is weird on
SoundWire. The probe() must return before hardware is accessible, but it
must call snd_soc_register_component() during probe() because that might
return -EPROBE_DEFER. So we have to start in this strange state where
the ASoC component is created but the hardware isn't accessible.

We don't need this 2-stage startup on SPI or I2C so those call both
stages within probe(). The problem with this is it still calls
snd_soc_register_component() early. If that triggers ASoC to build the
soundcard it will call component_probe() to wait on
init_completion. But that would be running within the cs35l56 driver
probe() so it is blocking probe() from continuing to the point where it
signals the completion.
