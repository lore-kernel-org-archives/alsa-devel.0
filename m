Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF36C43458
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jul 2026 14:30:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1949660228;
	Mon,  6 Jul 2026 16:29:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1949660228
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783348202;
	bh=bUfFj+AhxL6MAJI0gjdg1nUllMDvDUQVD5J5RtVLOrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=U1dWAUFCwQJhPSfY5H14HIO1LH5h7+jcziE1cLQcFE+vfgQ6stuiw1kU+WcNpalES
	 HOSRHKzPfhRFKwXi32Vk+brudAx9P9yjyevk/AP6lb+gXiEIDW5R9tvqKAwgNqvOho
	 bQeSrxsIDGAagEyNrm2Vo2TDocj34iWIY3YoMQVQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 52585F805FF; Mon,  6 Jul 2026 16:29:28 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id ECEB8F805FB;
	Mon,  6 Jul 2026 16:29:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F3C40F804FF; Mon,  6 Jul 2026 16:29:22 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1783348162;
	b=gaLe7NZEA3cQkh6tH5Q9qJTPaqoD0gB61DGM9dquj0BaMdWRKzT21fHRz+7/otHOjMoZ
	 K3OpPPPk46r9OeLYuP5/hzX4bxGe4g8emCem720XmUzt3X3A2GgCXKlX4v2tQML7az2qa
	 Dm4YrTeAFRWmROweQuwWXYgUkD5lqrShGyTc+yHu/L8LGxFXLoJYtC6cjVjoVMmTkT2Zz
	 aZlCxL4N8atfVRGleuSRVFU9GlRaQbV8iYI4QydQQYA9Um8vaDg7sNEHqIoD5jimefheg
	 DvvPzqgZYcwHCIXaPkQEICha+RN2fk+nE07Bt9z2mP8vk62oGflucnFWlSPrQMYRf4Q==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783348162;
	h=DKIM-Signature:DKIM-Signature:Date:From:To:Subject:Message-ID:
	 MIME-Version;
	bh=bUfFj+AhxL6MAJI0gjdg1nUllMDvDUQVD5J5RtVLOrA=;
	b=HpkvFQf123DXfuU1uH3t9GKwjU9ac8x+YDyFof1mXDsGDPfTrKFoAv4+H+NkeVFT2Ann
	 XE9IS0DU0G7OInEbPwEBibJQKWbNcS0zMv2pmcprFwn8dSvrY4pGRg3ZIJm8/26buXP9D
	 oI1YmARMr8iJbxc2wVcSTGnQ8+SfZrDPB6fA7hDnY4vNGtNsJ+3t1ZyNFlaQxGbJwt1+p
	 PkRYZhfFqRd7AnTsY39EfdeOAO3Gh53aDzTqxEOs7uY2kx42E55r4yq7ZzdXhDRr5Ixbj
	 ETxtvqIhXAi14plWeNqjMgNfpGqcscbQua9BLyWnA00iWXNS9T7lvK3FeaxVA+C22VQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=qNQmUsda;
	dkim=pass header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=S++WGluP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C649BF8025A
	for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2026 16:29:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C649BF8025A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=qNQmUsda;
	dkim=pass (1024-bit key,
 unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=S++WGluP
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6663dKTs039937;
	Mon, 6 Jul 2026 09:29:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=bUfFj+AhxL6MAJI0gj
	dg1nUllMDvDUQVD5J5RtVLOrA=; b=qNQmUsdaXlJ9H8xP6SWWEee216K4kTHx0b
	V7DwviTm1HPrY+mPhJcGPAZeq8VvHoQGuXYliDlODK9Awu0pZwAELpLYSkd5XkHm
	FGhojlWb0XxMJAW20SMZxMVl7z8fO0/jc9NWiWMVd0O9hakam+LVYaQCRkmuHGw2
	hM6sv534v2xfcMgHqqYcVyVLd4oQtjQAX4W9da166uvNByydUPwtpyK4Hm7auvFa
	OJH68iZVo29H/BPdcnA3tu32gNLXPLnHntWcBrdYJ9GCI2mP1/DYN4WyQUj+A98O
	+grh/KpNGNQxQOt29vxKAH7ozDtc67blNi29stN/6+uuJtYUdp/Q==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021085.outbound.protection.outlook.com [52.101.57.85])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4f6yjxjg17-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 09:29:18 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5rjeqvLY0mnembGKbxN2i1j6Mo/cGibVMTc7pNFbVzeU7hELaa0aDq1rtm0mbE4dT+1DM3imTLvIrBp1xuPjH6TZWP82D1icyN3ph1eWcEFGssYarWavXxRZtQDEC4YjJC2ZLhZsWcsxJJ/Ekw3IWhe0s0IgJk6JqaC0y1uJYDSH7fJ0eG/wqcpaQXtRML+LkoHwJXcscYRwTKOopYn0f7WubMUFgngr/JgKEW6rdlQcD7S1joJuFqE4hmBes6rCt+B7kuGyndtHXlmlpKRI4Dfq4bHhFq7CFL2i6aAME2Zf3pF0PYkpRWnfgubjgYWBTeVBvdBMHllHOJBDZXTOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUfFj+AhxL6MAJI0gjdg1nUllMDvDUQVD5J5RtVLOrA=;
 b=dR4a2ddprBhIK1vinGKH4SkWAqf4frxzd9YvNmKRbjRlK4jaA761Y8GKCxQBp/FrQkWA/egcg6cSy4E2cvRUvUoOET2Lfjt8Ifs0hwWRvacOmsUCRpD/+BO1KpgTxYlUHY03SlZI6Qde8B7dBP4PbB418FgNt8pMi0+7WgrfGAZfXhoMx9PwEwp4XKIxspRlCZUA1rRv0p4uuSiAWpiLIld8Y+6TSHHD/QYz1D1AROR4HeaqilBVlqcvcrwx42dsxtWzl3+jqkK06jfbHd+HsbwVWmVW4rHQZaSOJ+LEQJcDfXtMsNO/xx+R2831Wy41M9OgxqE34NyaKHvFSF7p0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUfFj+AhxL6MAJI0gjdg1nUllMDvDUQVD5J5RtVLOrA=;
 b=S++WGluPXCMvOOMlpMPjUQhZtOpRw9EJ4ojIABWv4zffg5X3mceOuTafmcXqIVSEQW9ByUR13Ld9bYI3m+Rr/MnHqIDsV5/D2iUo4iDWs/LZ+D6YJmgQBHF+KgOK/5/kO3d3qITX9uCbUACqEr69njpjRqJ7Iku7V7K8cbDnpnY=
Received: from SJ0PR13CA0229.namprd13.prod.outlook.com (2603:10b6:a03:2c1::24)
 by PH0PR19MB5225.namprd19.prod.outlook.com (2603:10b6:510:92::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 14:29:14 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::13) by SJ0PR13CA0229.outlook.office365.com
 (2603:10b6:a03:2c1::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.8 via Frontend Transport; Mon, 6
 Jul 2026 14:29:14 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Mon, 6 Jul 2026 14:29:12 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com
 [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id C7E3A406541;
	Mon,  6 Jul 2026 14:29:10 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id B429F82025A;
	Mon,  6 Jul 2026 14:29:10 +0000 (UTC)
Date: Mon, 6 Jul 2026 15:29:09 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Christoph Doppelbauer <christoph_doppelbauer@web.de>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: ThinkPad X1 Carbon Gen14 (Panther Lake): CS42L45 SoundWire jack
 detection not working, no machine driver found
Message-ID: <aku7tbb6hQAIyEv4@opensource.cirrus.com>
References: 
 <trinity-70888fc7-d6f4-4ab5-b61e-54cd5c9f09fc-1783242175358@trinity-msg-rest-webde-webde-live-584767dd64-fqqnv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: 
 <trinity-70888fc7-d6f4-4ab5-b61e-54cd5c9f09fc-1783242175358@trinity-msg-rest-webde-webde-live-584767dd64-fqqnv>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|PH0PR19MB5225:EE_
X-MS-Office365-Filtering-Correlation-Id: 60f18170-ac64-48e4-76f6-08dedb6af31e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|82310400026|36860700016|61400799027|13003099007|18002099003|16102099003|22082099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	ssudVyNqPfbIB1dONTbcfoC2gx/Wh4l0fiS2zuFefmEbvZYxeLsOzEPPDkgs1mQj5YfBJap7S1h7AT8YeFEl6u7E9DeNNyb5TTGaZ6dbL2z+e2Zi7birWe8AN9/T4ECMVGkr8/1x9MMGQt/D0VtJlOFyzGYlRys+z38twyvcnwpa26DHcWEd+5J48s2Sp/3pdf9ExvhS/6701s66CPCev+lVw5BGB3i6m78x7Tuhlq7ePThJz7s4VwneOw+xRxrEUSlzTXj+hps0whTfaO7xz2Fa3d25zswqpHU0UpOLDVfDwUyPocDT5W+v0cr08CyElbkH/029EIEx9zIWxUdq9I3ZhM2I9iu9JXj7qjHWLLNVbGU/pK02U0U7P94BySGEN+BV5UfvnrhcTOMt2GaAr1XEb6X8DtWgG5vY5H/jG/FOVFONhtZBdR+hsGuRtvuVf6SJYCT7kDgRZ9YZUoEBwCwhsgeR+QuPqhmcozUWVlrwOTrz7S9qVW1cIypipId10MduIdMiTa76jqFBqm6S+8Et3m+S4Yj+zvBHFEYLQogKMT0Q4iGafeWyTeSKd6m5lqEsueRJOOiUQ04kUA3kVWG/RAW6ooZnjmyNwWa1YwHmxuTb6LgTtRTiXQsC/UX2HI3UoximBzlwAtnopUZtvQjyPSNSJxxC8zl4Bb0W9MWhFspIXWqW+t0ExdHu0mAYk/6ZAClvbOZXhYaOwUBErw==
X-Forefront-Antispam-Report: 
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(61400799027)(13003099007)(18002099003)(16102099003)(22082099003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	5EQ8tin84zDWCWaWXUw7mfHJwscVzs0lGt7EEjcJgdU41YSZhHhCeL2YniwLW/MymoA/mVRdX6k7EOJOb6N9oCFEWEi2IRk4AgwDWrEa1+Gb5nuyJaWR/qlhvA0DpllRSXyCOKyFLG7TzrhvP4kCOWDQgXgRVNtkgZneY8aR7oCRkUx476Cw4L8/4tjPk65AwdgjGxm2yZiQiEBVfqfooxYaYwJQSC9al0sKVqHlOFUg0cEcSv/ypv8ApLmC77xLQn4aABMRT5KsUQLLmDMTFPaiv+MX3jzH02NNbDWx8JNDUSmAuyR6hFgWHfDBbDoRR9U79lMmNKtSyvQMHqRfOT7X0U4XgnXr/a8MAVNS6opjentDBEev0TIvdvd7PEEQj8kYEpBeLhuNnVOycEA33LTjF1DxAxHUMKH0gD4E0YlMf2dKcu3yeQ+PH1E99K7b
X-Exchange-RoutingPolicyChecked: 
	TWqSR/VUR1A9MtyyMT9iFfHii/mi8zcIasVgMQxB//PA2mUHufNAcveNXfKoPiTYe2AJm7oEKSwNtBKB4LKy/Gh+M96SwuHETbCCtsXJ0K2U7gAM0Ei99jDxV6OARCpr/t39KhOR7OEy28kmG4EhrBffaJ9oWp46wyfpPGxOzCdmeleo1BXVciZ48P3gC6+y+AuSdlzvzZRXLNzDSDCJQndD9hWKwyqZy9u3pgMLqcCDTxzyMJkzMAVI4ptNDcrLZjvtKWJouhyJdqBjvLoaWxzlFZuYH6Vab9y2FTZ4Xm0jwlMsYBhqpQNnq+Kg1VQvLP7qZfgJYcLCqeg7lHkTaw==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 14:29:12.1750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 60f18170-ac64-48e4-76f6-08dedb6af31e
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: 
 TreatMessagesAsInternal-SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB5225
X-Authority-Analysis: v=2.4 cv=Fo81OWrq c=1 sm=1 tr=0 ts=6a4bbbbe cx=c_pps
 a=SDOlI5lSWczX7ANjW/fhbQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=NEAV23lmAAAA:8 a=XjVYAknsuNU1FQWFVowA:9 a=X9Ho9_PqhNXTlP-s:21
 a=lqcHg5cX4UMA:10 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0NyBTYWx0ZWRfX34Y7WEbCajtP
 7wFusxXVvNog7NAsH6oxFyUgWWz7hgAYW2YONsKLlisLjDHrtXj+LhIhu/7fV9o8tZU2Q/oOnTx
 pUhpS0w9Ykb1IoaCWjnBjHgY57q7Pcc=
X-Proofpoint-GUID: dK5g-AAO24pjXCAM2OapfOnXA6wFN0zw
X-Proofpoint-ORIG-GUID: dK5g-AAO24pjXCAM2OapfOnXA6wFN0zw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0NyBTYWx0ZWRfXxqMNooBofusp
 +uDAQ6aGcNAHv9hUbiakuaGcEqNChVi9ytWFPAru4v9aZrrZDzPZybBwulnBe3FFX2NcKYZIqzY
 4e6+tz9j3Amk3xFlXr6iE5mP/8w4elQT6QlP4ZXqP87Z1WryHuMDNNa7MiBCdDxpATNDlB+QIXj
 W1ZoYRJdsDGwp7f3SE5oSJJM4+o/1eBGd6RWT+ZVYsveGN6ev6qi+4h6cmHMPD66UwImlF2hcvl
 xei/76DRJo/LsTIw05weOJ0HlUM0u6YqZ/fhP/04dhrlvMhhOL3a2Brp7wKTtHSOFHDWU60d8lp
 lRTqh9ld2CA5xxhgxtETktDli8pczDiHY8rTvSEnIzyoVxl5uBmiZCk1s1nWyqWnErd2B3Nfvhz
 mEGdsBcj3o8Vd7fV7OZXZBkEpWwwPBil+jO3JH4Iftc8pwHshliPW7r7x/Ceo6sQyFBBC42uYBH
 2+6gj9UxfiCoCNBdJ2w==
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: XU4HVZC5I4LIKXJFKPELEBZ2XMV4SV47
X-Message-ID-Hash: XU4HVZC5I4LIKXJFKPELEBZ2XMV4SV47
X-MailFrom: prvs=864701fac8=ckeepax@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XU4HVZC5I4LIKXJFKPELEBZ2XMV4SV47/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sun, Jul 05, 2026 at 09:02:56AM +0000, Christoph Doppelbauer wrote:
> <div>Hardware:<br>- Lenovo ThinkPad X1 Carbon Gen 14 (Aura Edition)<br>- Machine type: 21V70071GE<br>- BIOS: N4OET47W (1.10)<br>- Intel Panther Lake<br>- Kubuntu 26.04<br>- Kernel: 7.0.0-27-generic</div>
> <div>Problem:</div>
> <div>The internal speakers work.</div>
> <div>However, the 3.5 mm headset jack is completely non-functional.</div>
> <div>When a headset or headphones are plugged in:</div>
> <div>- no jack detection event occurs<br>- speakers remain active<br>- headphones are not detected<br>- headset microphone is not detected<br>- no new dmesg messages appear when plugging or unplugging</div>
> <div style="font-family: verdana; font-size: 12px; color: #000000;">&nbsp;</div>
> <div>Relevant kernel messages:</div>
> <div>sof-audio-pci-intel-ptl:<br>No SoundWire machine driver found for the ACPI-reported configuration<br>Use SoundWire default machine driver with function topologies</div>
> <div>Later:</div>
> <div>cs42l45 PDE 11 event failed: -110<br>snd_soc_sdca_class_function SmartMic:<br>power transition failed<br>soundwire_intel:<br>prepare clock stop failed -110</div>
> <div>The loaded topologies include:</div>
> <div>sof-sdca-jack-id0.tplg<br>sof-sdca-mic-id4.tplg</div>
> <div>The kernel creates:</div>
> <div>input: sof-soundwire Jack</div>
> <div>but no jack events are generated when inserting or removing a headset.</div>
> <div>The analog codec is also not exposed correctly via /proc/asound/card0/codec* (only HDMI codec is listed).</div>
> <div>This appears to be related to the lack of a dedicated SoundWire machine driver for this Panther Lake platform, causing the driver to fall back to the default SoundWire machine driver.</div>
> </div></body></html>

Please use plain text for upstream emails. This device needs a
BIOS update to get things working:

https://github.com/thesofproject/linux/issues/5770

That BIOS update should be available now, so you likely just need
to install that.

Thanks,
Charles
