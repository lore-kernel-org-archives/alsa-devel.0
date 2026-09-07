Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398B2C79F89
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Sep 2026 08:47:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6F119601E8;
	Mon,  7 Sep 2026 10:47:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6F119601E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788770866;
	bh=A0Xbm+teOdW8sOmNCZ8N7eQBF/suFywh82BL23s0IEQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=LVWhw8xwyxOFsPqmoyhDfvaHwrfwcvG3Ryr0GQBeTtTlQj9I8yRrahuK0I4AKIAU7
	 FFXEL5TvLz/r720YS7zOx5+FcdAloTofFtQHS58CMHbXi1FzJYfiEYl1oEMOkFcSyN
	 6/P45YvIujsI9ZfLd7VufXHklDmcYyL0hqHTf4R8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CE344F805EE; Mon,  7 Sep 2026 10:47:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2C34EF80601;
	Mon,  7 Sep 2026 10:47:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6ACCEF80571; Mon,  7 Sep 2026 10:47:01 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1788770819;
	b=iLFN3L0wGWrigqVe/nLVyCEp23OmPP2Yw4THB4Z8cjnChins00XoD1y75dx6kl8zdJyQ
	 2ieexnww+4dafjqGqMHYM+Cv+QH9W2bBy0dXuwEIJ+bJoH1kImS/XhN3ucLehlSh2jC3X
	 KJxLwJS9kxYL3slWQQAzKLRfqe1YJdHKiowe+VMQxGju78NtWvi2TRZ0VCpHp/s7cEDoL
	 X/FebLGhzJ8k4thCPgaXNWK1x+K38CNvHCI/3GvdbRbfRApv8HMNclB45dFfJ6qGLPlHH
	 Earh/uebXaM5S310/QbW7Pqi5v6arr6wJwpi7A01YDkGWAhBk03arred+a7CmF5n7XQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788770819;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:
	 To:From;
	bh=A0Xbm+teOdW8sOmNCZ8N7eQBF/suFywh82BL23s0IEQ=;
	b=o4VkWnW6IahajwVZERDQh705Wf6n3iBZbThIvw85CMmfB0Itc2KtUIv7IHh4zoo9DjHB
	 iqnmR02vyaHilHipa/gpyz4y6SF3FUGX3tBDPDnB0i+UVmzBoJg4F46SypwqCXtfcm4+s
	 LcCCyPZcq7bxoZQqWi7Yy7WA9mka18xq/n4z4xMpXwpzJeur91EBo9zW3NPc0v8ObrfdC
	 BxuKqhcFYxbpJPg7huqdO+F8M6u4mdBCpsC4ObUv81lM4oPpLcBPUXZoVJenczCuJWCLc
	 RRrYbpddp2JZlCs7M+q1D69eL3W9LUiTGz9rLBKAbpIpT1ui2ZhNqlDegQOCwbYWSnQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=IP54v3OA;
	dkim=pass header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=HF1B5YSL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4A438F8011B
	for <alsa-devel@alsa-project.org>; Mon,  7 Sep 2026 10:46:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A438F8011B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=IP54v3OA;
	dkim=pass (1024-bit key,
 unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=HF1B5YSL
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6870gL2c749455;
	Mon, 7 Sep 2026 03:46:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=Xxt9+RSCE9lMo8heS6Iwcpu4F7La/xisJwWC+auyplQ=; b=
	IP54v3OACWUnsR15qxjzFkPNFZYD4JGIQmgHo2T3qvR6ICyh5miePu7Gz2sLDoeV
	hjXLRflmzzyruws0TSIwvHjRGkjsDW67BRMOllxlPGtY6wxIsGHCz2dg6e3aFm0l
	ceo+ot3I2JQ09qXYo7fEP76PoANbu4NUJoFkfJLrHsAKnYksTWYryQYej0vKKasS
	spm21JgZ2vEYvACkvYMkN3utAv7OGqTsxxgVM6VTSUYpgKGWN1F3XgNdgjUkS35H
	gd7N+KLaA5gvfjPpvXp5j3I29I5+9BMLvVxWtA5QZ39ssq8QoP8GUX3EUnJQdrbQ
	MBKe4KupQcXZn364EW/b7w==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022091.outbound.protection.outlook.com
 [40.107.200.91])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4gggfwhsce-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 03:46:55 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcVmb7Dj3OR974Y6JIJFvhpp1xi6iDSshB3niajA6xLWnUvuDoeMAJO0nUegRia+UYpqbkenBomXioa2xheEhL8ibcjhMJhKZoENJSWa/RunKHvelfgt0B2l6AXLrYCYe+SQMGuRCtsZYsGCseSmQmc8ifWtL+YCsQ4qoHOpDvE6vsgUDIGoo/JlnNfIdjZ9lCZ9QPkS3VjYIUoJ9uwDVZiMWPQsJs7YsiR2T+wr21311kzSH9MSdUAHT92tJcGAYJy7o2wJ016ZjEA+m21Po4+2uxkfrOSRJEVxbgpsbCOz5KevrgHRa+k/M2hk5lWS7Y9YydXUJvbSSFcWNOt2UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xxt9+RSCE9lMo8heS6Iwcpu4F7La/xisJwWC+auyplQ=;
 b=xNHkwi1vOrM0Zy970PinWXlSHSfDb2E9JtHA6ZnAw16uFp8tlwX6qS15UTXAUUm8m+huab7xkgg5rHmlXCmqzvx2hlVRS70iRNlOMn8fjHY2N0RBYdBDHG9ntdnx8Cj05GbCE4cBTn8uVbVocOtOvqcWPXyw3k8NMuxz7YGPCzrpOOkdgaLLA2PN+UMA7vk4TS9fRBWxIJaJBGQNLA9RxXVveg0CVooIT4SYatEJfz/YgXVIuUKDJsVwqTgJwH3Wx66XJNuZM7uAYzMAqmKU/qqZi0KzvqKoadoOG0TdyXQpQ35ngZgzq4Ky/D5qkBpBLDt1VhtCE+ttXBdm4Ac85A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xxt9+RSCE9lMo8heS6Iwcpu4F7La/xisJwWC+auyplQ=;
 b=HF1B5YSL1GlmxzeZ3ymM3oTpzELuL8yt86uvRaQx9XSMnaXjBVqOkCJImMXg8MdL6T4yo7U2blE8yA8g9ons7Z3U57xQim4vUH4IploJi6BUhsG42+RlC64d2Zco1y3YfjYeH0BsLImIugEm36LHnF2GJVFDH0miwXrLWb9hROY=
Received: from BN1PR13CA0009.namprd13.prod.outlook.com (2603:10b6:408:e2::14)
 by MW4PR19MB6823.namprd19.prod.outlook.com (2603:10b6:303:207::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 08:46:48 +0000
Received: from LV8PEPF00000069.namprd03.prod.outlook.com
 (2603:10b6:408:e2:cafe::93) by BN1PR13CA0009.outlook.office365.com
 (2603:10b6:408:e2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Mon, 7
 Sep 2026 08:46:47 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 LV8PEPF00000069.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Mon, 7 Sep 2026 08:46:46 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com
 [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id EA23C406543;
	Mon,  7 Sep 2026 08:46:44 +0000 (UTC)
Received: from [198.90.208.11] (ediswws06.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id D8CDF820247;
	Mon,  7 Sep 2026 08:46:44 +0000 (UTC)
Message-ID: <6b5f648d-10d1-4c24-aa49-06069858ce82@opensource.cirrus.com>
Date: Mon, 7 Sep 2026 09:46:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: regression: CS35L56 bridge speakers silent on 7.2.2, worked on
 7.1.13 (Dell XPS 13 DX13260, SSID 1028:0e54)
To: Matthew Hinkle <matthew@mdhinkle.net>, alsa-devel@alsa-project.org
Cc: simont@opensource.cirrus.com, broonie@kernel.org,
        linux-sound@vger.kernel.org
References: <a8a49d9e-b1c4-4169-927d-49eb936cfd0c@me.com>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <a8a49d9e-b1c4-4169-927d-49eb936cfd0c@me.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000069:EE_|MW4PR19MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: 842733ab-cf9f-4d72-70fb-08df0cbc8cbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|34020700016|82310400026|61400799027|23010399003|36860700016|6133799003|3023799007|10067099003|5023799004|11063799006|56012099006|22082099003|18002099003|16102099003;
X-Microsoft-Antispam-Message-Info: 
	gfPjBXJ6eQ9qdxHMfop0m0rYTQckWwkWZcsP1IvudqW5GL6oVUJ7QwMCxH8O/QvTLcpRe3o1TQ30NbMW8TeVChAl3ubMcYMlM7iBcf4M8zrCb25OdIfLGXI1KaCZ3H1wApIoDvGxAg6GKvkFRUyDcjv7PTCBJCntonRlHYdbOuddRfulF5AgX88d/Y9z1kWA5W6fyPcyy48Koe4kcDWI7+aUIoBSw6drS/yLSNBbJYPBvYTvkMzEh232ZfBTEayE1tI1n6MwDUEzvrFVwEQrqLO8YbUUCe3hgp3hbuD7QKAnWpE4GZLUj+9RugXNC6e6ExIvjToW7AgjxLmQP5tI4C0vLaqq8C3Te8iJJpgDGxCW4JNeokxnhgc3GfMkhCpps9zP+NelZUSL9aYiTHfXY9uN6okKIm5/zqgtG8N4dAl5/Oga/ppcURDDiYlue4bpryPK6OFIr9lJGlTOvkJShgdpzdXk7nIkQxXmKo8D0DRB/9yrnmhtrsqm1UULtMPKa9oBvq25z7XNG9cz9We7khifGIfceCD08sAPClN7+ug68smIaPEirGD01lYgieQzs6/PhuWSFsPv8+IHrtkzlM/SD8LPtFhRpZRLz0b90FZhu7fbOzVsLjq39Ya3ZBx6tYks+EI/Gd3VIzOVG7wZJuKIQ4kdDk/OHmAzW5Fy2uy6h9i6gzAnZAY71d/ysoCGkcBanrHEQJfl/t4X7iKoaQ==
X-Forefront-Antispam-Report: 
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(34020700016)(82310400026)(61400799027)(23010399003)(36860700016)(6133799003)(3023799007)(10067099003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003)(16102099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	60vCYu/MV4g5Y4AyItI0edIRIUOUZVlQZWbMpaahFCVI1P7MvlFaKe4IAhkdXvX9QyfdVN/lL3xUYLWSbEhAwYth6Kj4O6RSNmA5Vaeif7qsOCRwsxJn9yLTNUs8sSa8dIG+1V96dCldJXp/5a03FAkxIMAKAnC9ONOFADlOPbe2vre5sSnuMzr04vfT//JRxwHKYyCGHCzluyT624hYlHivX7MqCJHYXsj6YUnRswaGza920jdC3M2zkpGv3k0E3h0RpkywL1KB8JNQCI7IYQ3vzZK7+Pl8TRtNZZd/FT/Pc4UQEFhsjPrFuUG/YI+h1LLl+hGMnYJx/tpzExBWjXzPGmFPrD/arjWudpU/mmW/2ExigGcur510QfGld/eNmsUxD0FhL0mesw3G7dqN7YHvOR58bej32SNXaDQAuFtU7XLx1GNjJ72EtHgPh8uk
X-Exchange-RoutingPolicyChecked: 
	dOsi0uCDJICS0EWWmiye9tYetLbF10I1ZP0+7fSaD5o2WX/05uMlatT50BRZlDUzOgHl06AGEI5MnVGEW2OZ4vxz+sMmLW6zjgECpzQaJlgpErc4RzWHWcCvc0MeN2nkgl07fDMWvNpe14re9ALPKMkWkoUMq65Uye41x2gNyTqdAfYVrTFUpzmeq+Xk2ZgyjCchJR00MBJKXdotCuyl9EkefWo9kL+uEf3Svoa3ptXZFbOwjf+GwQwW9x5YMUgHVkPwWcR7sEGD0Cl3pGUoMrWr2H2aF3O9lVwu9/0A+JfALgr5ziXqM+VAHbZAf2km/J7k0RUKwDudFT+wsOxllA==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 08:46:46.2506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 842733ab-cf9f-4d72-70fb-08df0cbc8cbf
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: 
 TreatMessagesAsInternal-LV8PEPF00000069.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR19MB6823
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA5NSBTYWx0ZWRfXy9yur6e85HCo
 UN2A7GxyPM8YMQLQbh/yt3LH2g/CCQd+Uevex9nZB4Kc2NSvUZWX4B9w9sCXnOAwvRD2gtwHV35
 E9ZRjCKtqIxo69PzuCFDWZF6s/5pyNA=
X-Proofpoint-ORIG-GUID: th6_IBUOe9kkF5iJQ22_AIN4L6Z6PSQQ
X-Proofpoint-GUID: th6_IBUOe9kkF5iJQ22_AIN4L6Z6PSQQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA5NSBTYWx0ZWRfXxUzY5XWfsk8y
 rU/Jce31A5XMgtX8Fu8ErYW6zAczKU7f2slFtiF6aGM3d+lmjiN8jxMZCUMOAjQfP4FO9F/WoaR
 mrSam5JoxCb7SFNOB8PMtc7x6NGMjGgEEZHf1PS6MGgk2vIVxeN3fs4RnfxiQJVTeetlhbhUwuv
 n6/yjTJfuLiMXlBN/cGRKtR499vDu2IC9t/J8ONBTe3nuvVpvtVk0nN9gr3mK+xebipxWC/zE/P
 253EEHcMGdLEErem7EuB2nGi9BOMESJN9FSU1Ad9Xqd8ZDpvQJ3++/fIqpuvgtkxpO205cbenkI
 X4JveA6rNrJ8TzBaEx2ilE5L9t1hfNRVGhmYYvWTUgiVNdwTpcdG3UkCBqmm/8ztdAw3dzwnxaX
 gYOesOqUXpepLZjoGxPcC9IcznVJ7HaOyyJ5Sr+NNmQww7mGtqLHtr6O0dle7192KqtPJh19Nf/
 bUs5HB+1q9LLKcM9MBQ==
X-Authority-Analysis: v=2.4 cv=fK4JG5ae c=1 sm=1 tr=0 ts=6a9e79ff cx=c_pps
 a=70jXYUHAk1O2tkEs2HJmJw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=VwQbUJbxAAAA:8 a=V40IyS3bg1BbSX-Dy9cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: ZZIDDBQEYBMBSLTKLZXJJXM7SPFYCI5B
X-Message-ID-Hash: ZZIDDBQEYBMBSLTKLZXJJXM7SPFYCI5B
X-MailFrom: prvs=071037c1ed=rf@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZZIDDBQEYBMBSLTKLZXJJXM7SPFYCI5B/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 04/09/2026 8:27 pm, Matthew Hinkle wrote:
> Hello, just got my new Dell DX13260. Having audio issues I wanted you to 
> be aware of. The rest of this was written with the help of Claude, so I 
> apologize if its not helpful. Id be willing to test any patches you 

Can you create a ticket on bugzilla.kernel.org and attach the full
dmesg. Preferably with the linefeeds included.


> think might work. internal speakers produced audio on 7.1.13, silent on 
> 7.2.2, same hardware, no config changes. Hardware identification : Dell 
> XPS 13 DX13260, Panther Lake (Core Ultra 7 355), BIOS 1.6.0 07/16/2026, 
> DMI product SKU 0E54 , audio SSID 1028:0e54 . cs42l43 on SoundWire link 
> 2, two CS35L56 Rev B2 on SPI (left/right), bridge/sidecar topology. The 
> key evidence — this is the part that makes the report actionable. During 
> playback on 7.2.2: SOF backend SDW2-Playback-SmartAmp is in start state 
> but AMPL SDW1 Playback: Off , stream SDW1 Playback inactive while AMPL 
> ASP1 Playback: On , AMPL ASP1RX1/RX2: On , AMPL AMP: On , AMPL SPK: On → 
> Bridge Speaker i.e. the host streams over SoundWire, the amps are 
> powered and listening on ASP, nothing connects them ❯ sudo dmesg | grep 
> -iE "sof|cs42l43|cs35l56" [sudo] password for mhinkle: [ 0.031297] 
> software IO TLB: area num 8. [ 0.267502] PCI-DMA: Using software bounce 
> buffering for IO (SWIOTLB) [ 0.267503] software IO TLB: mapped [mem 
> 0x00000000575de000-0x000000005b5de000] (64MB) [ 0.396477] integrity: 
> Loaded X.509 cert 'Microsoft Corporation: Windows UEFI CA 2023: 
> aefc5fbbbe055d8f8daa585473499417ab5a5272' [ 0.396489] integrity: Loaded 
> X.509 cert 'Microsoft UEFI CA 2023: 
> 81aa6b3244c935bce0d6628af39827421e32497d' [ 0.396496] integrity: Loaded 
> X.509 cert 'Microsoft Option ROM UEFI CA 2023: 
> 514fbf937fa46fb57bf07af8bed84b3b864b1711' [ 6.499211] pps_core: Software 
> ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti < giometti@linux.it > 
> [ 6.683467] sof-audio-pci-intel-ptl 0000:00:1f.3: SoundWire enabled on 
> CannonLake+ platform, using SOF driver [ 6.683484] sof-audio-pci-intel- 
> ptl 0000:00:1f.3: enabling device (0000 -> 0002) [ 6.683630] sof-audio- 
> pci-intel-ptl 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if 
> 0x040100 [ 6.683691] sof-audio-pci-intel-ptl 0000:00:1f.3: bound 
> 0000:00:02.0 (ops intel_audio_component_bind_ops [xe]) [ 6.690773] sof- 
> audio-pci-intel-ptl 0000:00:1f.3: use msi interrupt mode [ 6.720585] 
> sof-audio-pci-intel-ptl 0000:00:1f.3: No SoundWire machine driver found 
> for the ACPI-reported configuration: [ 6.720589] sof-audio-pci-intel-ptl 
> 0000:00:1f.3: link 2 mfg_id 0x01fa part_id 0x4243 version 0x3 
> [ 6.720593] sof-audio-pci-intel-ptl 0000:00:1f.3: Use SoundWire default 
> machine driver with function topologies [ 6.720594] sof-audio-pci-intel- 
> ptl 0000:00:1f.3: hda codecs found, mask 4 [ 6.720595] sof-audio-pci- 
> intel-ptl 0000:00:1f.3: NHLT device BT(0) detected, ssp_mask 0x4 
> [ 6.720596] sof-audio-pci-intel-ptl 0000:00:1f.3: BT link detected in 
> NHLT tables: 0x4 [ 6.720597] sof-audio-pci-intel-ptl 0000:00:1f.3: DMICs 
> detected in NHLT tables: 0 [ 6.722739] sof-audio-pci-intel-ptl 
> 0000:00:1f.3: Firmware paths/files for ipc type 1: [ 6.722741] sof- 
> audio-pci-intel-ptl 0000:00:1f.3: Firmware file: intel/sof-ipc4/ptl/sof- 
> ptl.ri [ 6.722742] sof-audio-pci-intel-ptl 0000:00:1f.3: Firmware lib 
> path: intel/sof-ipc4-lib/ptl [ 6.722743] sof-audio-pci-intel-ptl 
> 0000:00:1f.3: Topology file: function topologies [ 6.722993] sof-audio- 
> pci-intel-ptl 0000:00:1f.3: Loaded firmware library: ADSPFW, version: 
> 2.14.1.1 [ 6.729220] cs42l43 sdw:0:2:01fa:4243:01: Driver needs fixing: 
> Unsorted reg_defaults, sorting the copy [ 6.729410] cs42l43 
> sdw:0:2:01fa:4243:01: supply vdd-p not found, using dummy regulator 
> [ 6.729446] cs42l43 sdw:0:2:01fa:4243:01: supply vdd-d not found, using 
> dummy regulator [ 6.729453] cs42l43 sdw:0:2:01fa:4243:01: supply vdd-a 
> not found, using dummy regulator [ 6.729464] cs42l43 
> sdw:0:2:01fa:4243:01: supply vdd-io not found, using dummy regulator 
> [ 6.729468] cs42l43 sdw:0:2:01fa:4243:01: supply vdd-cp not found, using 
> dummy regulator [ 6.732231] cs42l43 sdw:0:2:01fa:4243:01: devid: 
> 0x042a43, rev: 0xa1, otp: 0x03 [ 6.804501] cs35l56 spi-cs35l56-left: 
> supply VDD_P not found, using dummy regulator [ 6.804543] cs35l56 spi- 
> cs35l56-left: supply VDD_IO not found, using dummy regulator [ 6.804550] 
> cs35l56 spi-cs35l56-left: supply VDD_A not found, using dummy regulator 
> [ 6.851648] cs35l56 spi-cs35l56-left: Cirrus Logic CS35L56 Rev B2 OTP1 
> fw:4.2.1 (patched=0) [ 6.868742] sof-audio-pci-intel-ptl 0000:00:1f.3: 
> Loaded firmware library: ADSPFW, version: 2.14.1.1 [ 6.955323] sof- 
> audio-pci-intel-ptl 0000:00:1f.3: Booted firmware version: 2.14.1.1 
> [ 6.966310] cs35l56 spi-cs35l56-right: supply VDD_P not found, using 
> dummy regulator [ 6.966352] cs35l56 spi-cs35l56-right: supply VDD_IO not 
> found, using dummy regulator [ 6.966360] cs35l56 spi-cs35l56-right: 
> supply VDD_A not found, using dummy regulator [ 6.972793] sof_sdw 
> sof_sdw: Overriding quirk 0x10000 => 0x10000 [ 7.017625] cs35l56 spi- 
> cs35l56-right: Cirrus Logic CS35L56 Rev B2 OTP1 fw:4.2.1 (patched=0) 
> [ 7.140047] cs42l43-codec cs42l43-codec: supply vdd-amp not found, using 
> dummy regulator [ 7.143547] cs35l56 spi-cs35l56-left: supply VDD_B not 
> found, using dummy regulator [ 7.143578] cs35l56 spi-cs35l56-left: 
> supply VDD_AMP not found, using dummy regulator [ 7.150022] cs35l56 spi- 
> cs35l56-right: supply VDD_B not found, using dummy regulator [ 7.150048] 
> cs35l56 spi-cs35l56-right: supply VDD_AMP not found, using dummy 
> regulator [ 7.187752] sof-audio-pci-intel-ptl 0000:00:1f.3: Using 
> function topologies instead intel/sof-ipc4-tplg/sof-ptl-dummy.tplg 
> [ 7.187766] sof-audio-pci-intel-ptl 0000:00:1f.3: loading topology 0: 
> intel/sof-ipc4-tplg/sof-sdca-mic-id4.tplg [ 7.187837] sof-audio-pci- 
> intel-ptl 0000:00:1f.3: Topology: ABI 3:29:1 Kernel ABI 3:23:1 
> [ 7.188191] sof_sdw sof_sdw: ASoC: Parent card not yet available, widget 
> card binding deferred [ 7.188198] sof-audio-pci-intel-ptl 0000:00:1f.3: 
> loading topology 1: intel/sof-ipc4-tplg/sof-sdca-1amp-id2.tplg 
> [ 7.188250] sof-audio-pci-intel-ptl 0000:00:1f.3: Topology: ABI 3:29:1 
> Kernel ABI 3:23:1 [ 7.188524] sof_sdw sof_sdw: ASoC: Parent card not yet 
> available, widget card binding deferred [ 7.188528] sof-audio-pci-intel- 
> ptl 0000:00:1f.3: loading topology 2: intel/sof-ipc4-tplg/sof-hdmi-pcm5- 
> id5.tplg [ 7.188576] sof-audio-pci-intel-ptl 0000:00:1f.3: Topology: ABI 
> 3:29:1 Kernel ABI 3:23:1 [ 7.189670] sof_sdw sof_sdw: ASoC: Parent card 
> not yet available, widget card binding deferred [ 7.198806] cs35l56 spi- 
> cs35l56-right: DSP1: Firmware: 1a00d6 vendor: 0x2 v4.2.1, 42 algorithms 
> [ 7.312898] cs35l56 spi-cs35l56-left: Failed to schedule write: -16 
> [ 7.312905] cs35l56 spi-cs35l56-left: ASoC error (-16): at 
> snd_soc_pcm_dai_probe() on cs35l56-asp1 [ 7.312909] sof_sdw sof_sdw: 
> ASoC: failed to instantiate card -16 [ 7.385076] cs35l56 spi-cs35l56- 
> left: DSP1: Firmware: 1a00d6 vendor: 0x2 v4.2.1, 42 algorithms 
> [ 7.544038] cs35l56 spi-cs35l56-right: FIRMWARE_MISSING [ 7.555945] 
> cs35l56 spi-cs35l56-right: Calibration disabled due to missing firmware 
> controls [ 7.579327] cs35l56 spi-cs35l56-right: Can't read tuning IDs 
> [ 7.631364] cs35l56 spi-cs35l56-left: FIRMWARE_MISSING [ 7.637951] 
> cs35l56 spi-cs35l56-left: Calibration disabled due to missing firmware 
> controls [ 7.653722] cs35l56 spi-cs35l56-left: Can't read tuning IDs 
> Note that sof_sdw reports Overriding quirk 0x10000 => 0x10000 — 
> SOC_SDW_SIDECAR_AMPS is being set automatically on 7.2.2, so this isn't 
> a missing-quirk problem. Note there's no machine driver match at all : 
> No SoundWire machine driver found for the ACPI-reported configuration: 
> link 2 mfg_id 0x01fa part_id 0x4243 version 0x3 , falling back to 
> generic SDCA with function topologies ( sof-sdca-1amp-id2.tplg ). 
> Mention that on 7.1.13 you needed snd_soc_sof_sdw quirk=65536 manually 
> and that produced working (if untuned) audio. Backend SDW2-Playback- 
> SmartAmp: State: start AMPL SDW1 Playback: Off (stream SDW1 Playback 
> inactive) AMPL ASP1 Playback: On (in "static" "cs42l43-cs35l56- 
> playback") AMPL SPK: On → "Bridge Speaker" the host streams to the amps 
> over SoundWire, but the amps' SoundWire playback DAI is off while their 
> ASP receive path — fed by the cs42l43 bridge — is powered, so the output 
> stage runs with no signal.

