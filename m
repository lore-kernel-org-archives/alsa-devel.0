Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7435C44508
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jul 2026 15:50:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 64281601F6;
	Wed, 15 Jul 2026 17:50:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 64281601F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784130654;
	bh=FaDcQ8Ap56VUkMe6Pyn/5TUbMvH56Tz0GrYId0nJ7qQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=QI+sAX4tgUK8IEeOEw+qF3y6g3H/SE60LMpukpd8Z8eQBM2BQfEBs7VNtX7WxIXjd
	 fHfEcqyBPOeLQbQUPipACbnUZr/STPBDMrtltBRHzoLDd8SajnuqivzGEeYRqgZWki
	 DtFMr6b6+nLYuVAd9DHH6xe/MOhzbIUY0zo6F0p0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 71AD4F805FA; Wed, 15 Jul 2026 17:50:20 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DEC17F80600;
	Wed, 15 Jul 2026 17:50:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 26B8CF8057F; Wed, 15 Jul 2026 17:50:15 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1784130614;
	b=MRi2Hgq6AKjgUiR09b0Q/wEMEOTDeuXzGatoDXYGfTsEQcmY6PMREgfF97HGyvO+AkTD
	 NKrDAMiFSioWYVZtGRmWQs6ymYUMYhO8P2Hhk83siSLKGFRm1w7Hjp5yLOw7m2RvdJass
	 J+nKajc2HXPvjsyJip2TWyS/51gRJss911uACauyj9Czn5mCElZSHv1YRWyIYXR1uhu3c
	 xkAXMiM9VqmaMvdQttOhdR2vh2nc8asIlZZz/UiUiCm7in9bZz7QcPbFqWm8Z302zt6xP
	 opj7CMCrMCKIUECQ4rjhETjIOw81mx9kwoyFu0feLNLZ9XLH+B7WFYgckmOoZdbyVzQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784130614;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:
	 To:From;
	bh=FaDcQ8Ap56VUkMe6Pyn/5TUbMvH56Tz0GrYId0nJ7qQ=;
	b=UQfi8Jnqi9DNrloBzQ1A3p8huhHwqTON3k39+bOQqVvPGJPZhAbveCN6uFVTycRu107r
	 lh4/mfp3e1waU1Msdn1wxZ/K/g7IlvUpmqChWJI4RwTBLewYyn8owzt0C2gIZ70CN2r07
	 JDMSD8RIsKHWyXL4X6oV/Cj78WTN5V1y83qkKkxtNqRdgSyMCn1K3WBmCS2nDaeRm4dDu
	 Y26HU1WhwEBHNreR59neKKJd7Ybw5FEQGFzec5aoooDnIxtAZXatwCdIUkpeNMwyU+T5R
	 F7C6Fk61AtyZ1L3cvPp8zBQ2zh1bEwRejY+5sgUBXila++/qCh587SDsr8y9Mq7aRLg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=Pew4kwFh;
	dkim=pass header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=fqNefArN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BB42EF8051E
	for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2026 17:50:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BB42EF8051E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=Pew4kwFh;
	dkim=pass (1024-bit key,
 unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=fqNefArN
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66F1tMil031725;
	Wed, 15 Jul 2026 10:50:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=9FGbpEC0Q5AMoQ+bc3vKW37qZEAPjNM4P0aQAtUz0pM=; b=
	Pew4kwFhd5poga752WuUoD05XnGpb6gP+8Ijt+nLPeSX+hVoHgTPebyfxIpvaVrm
	yicMxDBTNtWT28YMRVPje44JyJXLjWtvcyUfYZkIleNzBFfXOhEz2P1AFYAtgvKQ
	po6UXoIsWd1Isvc82rmrz8POGN4cwnQg58zGX9TlUyr7YRCNus2I4+GfC7IOA7EY
	uBEuAseD+jNz75onWmL2Sd7wvIRwDhCPTH7uUJ7QCYw2R/lgqQl3iz/r6tI63K1M
	llD7hruOkebSuWsOWLjc7x8fGblp89PV5KA8L1/PwCRDVzoBNKchEVg5koNavlGU
	kuMNcjvCWATVpNTiPNz5JQ==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022090.outbound.protection.outlook.com [52.101.48.90])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4fbk7vws86-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 10:50:09 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPS19+GoPzAIkPEdmhk4PVBhe685PhfHu9HP4eQe+bVnt8F+5+otTyWH57qi8uGi9J3RAvWt/xJHzaJdowgEIQZIFDCuegg+jh/W8LWozA8doQhICbVKhm2iMphdMVqMbXHyxKD0hVC79UeqXuMkloWVvKyd6eKZd5cTk5alzjUB8XylRlxJQIuI0hPtN8FzJR0VVuyWYLHQZZAAVuDxMU6zs7Hs2ElgasGVYjPfZXmnpxXLH4BY/atlRoLk7ugC+K79UV3TlTacNZg+tk7EdgW6/JvrtHbz1vttEBaazgIxSqynjJRADpjDNf3O34HctVtAQwixIa26OjgMnMdilA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FGbpEC0Q5AMoQ+bc3vKW37qZEAPjNM4P0aQAtUz0pM=;
 b=gbShKuUMX4fYynd7IEXI/JlsuR5laGvoTYLmzeJyESFaWNt60S307ji2z9jsxU0qESRJUIbG4Q5222s9ayECsPViBP/YLhmYZSr6mRue4gRHhPWPZ/w9yGGekwn/LfJPACkYt4uB/0Y+KqdggLxqGbrb+16Fi3s1Q3viFlvMS7+doQIeGT7Kfvpl+haeBecBa6DBoFYpDs9+ZzZhSXbdEX8kZvsoc6/odgMHUlS/HHWDusoJWSERDbyj0+mmdrTeDX/W/T9ijnnnbXYYadc3IGs9DwoLoFlbd/Pjhoxb2iuC0MbL9qFhY8Elyh07D2MR1d2jHe5NQSl0cVQri/cB/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FGbpEC0Q5AMoQ+bc3vKW37qZEAPjNM4P0aQAtUz0pM=;
 b=fqNefArN1CwOJr08UMGTjxjm+0x/NDqKFx5RbxA8cgrR8XKLFVfjVyOwCSl572boOM3kPFDuUoyfMz9BgwUA4jSQcJO6362gtpJI4kiuOV9W0wI5l9Ykh1Dw39fziCv52M5WvPAU3qz53rfrqdo34TEV54LIZkUCWbyxMhFdwp4=
Received: from BN0PR10CA0015.namprd10.prod.outlook.com (2603:10b6:408:143::33)
 by LV0PR19MB9285.namprd19.prod.outlook.com (2603:10b6:408:324::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Wed, 15 Jul
 2026 15:50:06 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:143:cafe::48) by BN0PR10CA0015.outlook.office365.com
 (2603:10b6:408:143::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 15:50:06 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9
 via Frontend Transport; Wed, 15 Jul 2026 15:50:04 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com
 [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 0C032406542;
	Wed, 15 Jul 2026 15:50:04 +0000 (UTC)
Received: from [198.90.208.11] (ediswws06.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id E6FEB820244;
	Wed, 15 Jul 2026 15:50:03 +0000 (UTC)
Message-ID: <75034460-875b-441d-9ed1-adbaa8d9ee2d@opensource.cirrus.com>
Date: Wed, 15 Jul 2026 16:50:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BREGRESSION_7=2E2-rc3=5D_ASoC=3A_cs35l56=3A_compo?=
 =?UTF-8?Q?nent_probe_waits_for_an_init=5Fcompletion_that_cannot_be_signalle?=
 =?UTF-8?Q?d_until_the_wait_ends_=E2=80=94_whole_sof=5Fsdw_card_fails?=
To: "Salman S. Tahir" <salman.abusaad@gmail.com>,
        patches@opensource.cirrus.com
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org
References: <35264720-a5b8-4b08-8bd4-442c0bd5a8a7@gmail.com>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <35264720-a5b8-4b08-8bd4-442c0bd5a8a7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|LV0PR19MB9285:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e4ff77e-94fd-40a2-5617-08dee288bd2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|30052699003|36860700016|61400799027|23010399003|376014|3023799007|10067099003|16102099003|11063799006|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	jXzBZgjWAj0Ee21UmWFd10h13nP3AyCjOmTb/9P8b06tpbUyuLgTyPsl9vZU/JdZwXkupEMZASI5kO1npmfWtSHVmldFqKxga2TEnDnvglPexvlQbMtY0woUjIR3k8ZjLoSNAUwTIq9811SUNdJybzkvsnpT+bHGnqzczk7dT4NZ8M1OeOrq2H93G8mKD0D/dDbMQGXncywxfQfZ/tFyvLm1q64MxGqymCIogbPFTWpmzAtd7WpS9THO2PlDnEhyh5GczFYdQ91Xs9vEzSiOUWQDpTESPSgKughBqaXO5A2LhSbOJ8qNR4oTf0k4Vn9JthvZUYr4M5OeGZDBJlmVqL2A5GyQRO4B/DhnbcbIOATtyScrQq5y+Mk3KkaDwF7KF5qhRMBJF6PFopS4AZg2FkLmh2wRu9hjIEr6QqW1IIkcwK+wjRbW7f/YMY+a/QmckndMEoxd2oGaE1lFCRAGbFn6lxnEkmeJsJg9+JG95XXWCQRvRNGhNbPtGyxfCaVr57r3clYp4AygiGKmvRZjtcJ9WZASebKBzePVB2raISPHIs4+uc1FqoJLLSZEp3gSJThih0e0Nk294DOw0pjxbi3zE2wLmj+bS6hhmhuvYsZQv8hWvhoTRyz9gxmnW6FDCeqSVl3QZ1tmGDFOMdSCilMbvaAZcB9JAT5kcQ2VANFRP1UGXHfmfd1xWsn1zX1VbSCRA+9EI54C/AnoCpeT+Q==
X-Forefront-Antispam-Report: 
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(30052699003)(36860700016)(61400799027)(23010399003)(376014)(3023799007)(10067099003)(16102099003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	5PoKpmq0sCiUzZwk1ZtFd2FHYZluQZ5KgApt8ou+84DrY3KcYf6jLvNaa2CA2N4v3YSVxVeI/n2ophiDEb1jQTFWNOJhUoEkFKYa15X6oYzSpkYQV572HATBFShQZTGhhpfPEKWhIoJUEini3P4fQBHzaifHPM/5BwDegFcLt53m/kIeJncFHb1pEjAuJu6+j/wGvg0q48qmbrkNXNPbrq1bur5A8hKmycIlWgbu5pr4e4MjJH5UqLCgYYqwfLfKG5uZTdxLjYgyeZ4ow/rrv8tH9yCHELxNF6KQypsGz62E7/FAKocuPA6RBAqV05YMgOQW7M2ndhnCyk50UrGU/2KZo6DUApSoEP+qE/UpJ72hiTVQJ6qSDGdRPtrpy5odiz5JuOdtDF3CCxKUT6A5Dc55V8ADj045t5Vny1N249EK6WvBx229ZqbW8QDaxsQP
X-Exchange-RoutingPolicyChecked: 
	WrW9+Ryim+SFZyDVH/HrtpxlKdYY+XsWfD3pn7qwPchFVT5216tsY4qrdTgoEA5IWVcJ0rU3iTNoPIPEnZROc4+ZEiZ2E7CeX9isfyzGT0QhDsEnJjfP3HcBOU4ifqYHvm50ZpgF6pH3UQtROiQgo4io7Cufzc1SG2wgUXvMEX4VALz2e17Wb2SkaUHckr/luhbYxBYBwiWL0h+qvqbUw86iikYceNV6HJqpHIdbXIPl3QGzHZBzfAhj3ycCWbZNf0nnf9KCvEUKX8miJaFT+xVytkoyAEKtoFYfLAsRDIlEqpiZrJv+IY53s5F76FXb9ZAQJOOVz+xP/vK+WhTPbQ==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 15:50:04.8423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6e4ff77e-94fd-40a2-5617-08dee288bd2e
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: 
 TreatMessagesAsInternal-BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR19MB9285
X-Authority-Analysis: v=2.4 cv=V71NF+ni c=1 sm=1 tr=0 ts=6a57ac31 cx=c_pps
 a=Gbvvz3TddPyANoHKDDnYFg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=p8B4ZfjjwVxbjijj:21 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=5KLPUuaC_9wA:10
 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22 a=L8sH2ZDYEKfnGPlJEvoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: I_1M7P3J7jgTI0ZMuDWLjUc5NixFsI4o
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE1NyBTYWx0ZWRfX07ayFlIvZe6D
 1C5CC+qIwc4BNZJrhtlMIRJAf+A0d68kNU6Yt97Fpv/rtJQcnJLbjYukT5nI317iMkq4fQYv/MW
 Ay0u/s5MnqVvRSAUU8kZeY0Z2NprBJw=
X-Proofpoint-GUID: I_1M7P3J7jgTI0ZMuDWLjUc5NixFsI4o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE1NyBTYWx0ZWRfXyVxrpFg99sLS
 /Q3yTdww1Wqko2W7wIWeRVrU8wIZD0D2x95df7NlfY7ju+awNZIhqMqUZepDssyLgrt32+tkthL
 v8cr/4js644YpbTKGsN3RFpdVGY57DkHRlQxOewO3t3JQd5b1JoBZnnV7rsujhVBEw6d2r592Qv
 r8SH73qavf5tSqOA9xQF0D2ot34toK5P882c9kUY3Go5ehvQlHsqCQUepII06de/HJN9gehzXg6
 kp2PO01uw9GYujhiFPznaj5jFc0TsPohRcH8BpVX+QS6ySS0dYdbMlSlBMILy239rdFmX696Yr2
 T/Jy8fun5S2odDnIyvCdWeoHZqiz00QybTm6w10xCepipg0OVJVpYidkPLuYhqXWCNJEIMoppAr
 Hppbe1uNNdQgEba6URNAunGgxGgTzLa1g7C3RYNN3XaTnbj8Ra6NHvJ4qtnBJx0iggroNUMWmHT
 4fn/b0fyYDPnzsCLClw==
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: HW6TW6L5YS2QLMLHPXNESWMB3ZJJ5GNW
X-Message-ID-Hash: HW6TW6L5YS2QLMLHPXNESWMB3ZJJ5GNW
X-MailFrom: prvs=865608d2f4=rf@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HW6TW6L5YS2QLMLHPXNESWMB3ZJJ5GNW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 15/07/2026 4:08 pm, Salman S. Tahir wrote:
> Hi,
> 
> On a Lenovo Yoga 9 2-in-1 14ILL10 (83LC, Core Ultra 7 258V / Lunar Lake; 
> CS42L43
> plus two SPI-attached CS35L56 amps behind it) the machine has no sound 
> card at all
> on 7.2-rc3. /proc/asound/cards is empty and PipeWire falls back to a 
> null sink.
> 
> The right-hand amp's ASoC component probe times out waiting for 
> init_completion,
> returns -ENODEV, and ASoC then tears down the entire card -- so 
> speakers, internal
> mics, headset and all three HDMI outputs die because of one failed 
> component:
> 
> [ 10.301...] cs35l56 spi-cs35l56-right: _cs35l56_component_probe: 
> init_completion timed out
> [ 10.301...] cs35l56 spi-cs35l56-right: ASoC error (-19): at 
> snd_soc_component_probe() on spi-cs35l56-right
> [ 10.302...] sof_sdw sof_sdw: ASoC: failed to instantiate card -19

<SNIP>

> The hardware is fine -- the card is just built ~100 ms too early

This (and the later debug and hypothesis) doesn't actually make any
sense. The code that signals init_completion is done synchronously
during the driver probe() of the cs35l56 driver, before it returns
from probe().

However there is a bug if component_probe() can be called multiple
times.

Please try this change:

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index f365f76ce56c1..f46fd8e7bc039 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -2109,7 +2109,7 @@ int cs35l56_init(struct cs35l56_private *cs35l56)
                 return dev_err_probe(cs35l56->base.dev, ret, "Failed to 
write ASP1_CONTROL3\n");

         cs35l56->base.init_done = true;
-       complete(&cs35l56->init_completion);
+       complete_all(&cs35l56->init_completion);

         return 0;
  }


<SNIP>
> Regardless of what changed the ordering, blocking in a component probe 
> on a completion
> that a different probe must signal looks fragile by construction. Returning
> -EPROBE_DEFER instead -- letting the driver core retry the card once the 
> amp is bound

Returning -EPROBE_DEFER from component_probe() would make no difference
to that, because the code that signals the completion has already run
during probe(). Returning -EPROBE_DEFER from component_probe() won't
make probe() run again.

Also it's wrong to use -EPROBE_DEFER as a general "try again later". It
doesn't work like that. It specifically means that a dependency is not
ready yet and the driver core will try again only when something other
driver has successfully probed.

Be careful of what AI tells you.
