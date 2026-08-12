Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 258B5C5AD5A
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Aug 2026 10:02:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B885601E9;
	Wed, 12 Aug 2026 12:02:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B885601E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786528959;
	bh=o3s9clQoU1kJZeGsB1OOGIQUBwg+FfnBAreMDVPraXI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=tz/hq1G8GILL2ruIGEGhzTqvRDZQuF53u0fNN3WmXx+Qv9ZxDivFAajiPC0ZWMHBw
	 w/EkvxD/cSB2lExrc+ai8qQCeL27h6yaSmc+VXhS7eQlJiZRj0yJnu7C/d7uYdyaKl
	 ypjsN5Trh31/UMgtkON41ofsudwEc0N2OfMiUT6I=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A0414F805F6; Wed, 12 Aug 2026 12:01:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CEE9AF805F2;
	Wed, 12 Aug 2026 12:01:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E8EADF804CF; Wed, 12 Aug 2026 12:01:48 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1786528908;
	b=J/vurvMlFZrCs9oCRIPzL6pGWgF2Acyq1HCJUkq+11UpwklP7YHS26ljq7ysKacOArxJ
	 fENxMyrdBhtKkWmKGDlif6dLeZ9RxlGK4GBNOGBMP0SzdE3n4x9A2u5HrHTtsso7JS1b7
	 2ZKG1f8MT94wpsxrSNcYLZzCHbVtEpxt6Ok9AGYLTxWklk8IRTPc2wBP7ER0D+jPVJnUr
	 0Ve0jwfnnNn1Wd9pRIMyC+c+AoN5cq2UO1S9VE2M9lA8kaJpCLObEuGnqi7QdCESWSuqC
	 1oednvPK9zBgccvSu+2iCb4yIzdZtxYeLZ+1c42B4FWGg2c3QluBFdPqCdqKaJU3s+g==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786528908;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:
	 To:From;
	bh=o3s9clQoU1kJZeGsB1OOGIQUBwg+FfnBAreMDVPraXI=;
	b=kG3A49qIdEwxxzWJkna/A1KESTwrmkugpm6ni4oWjvQMuhMfu3ZV+fALbnBhTTyl0SyU
	 Nopp30kTDhXoQUcAm5GSQjNyrFm5UmvJ6shvHKE0+PIX5G7rrtDCHcOMNUEY2548ZenkR
	 kjvFtS7hA5Uc5mwDCUTHj/1pxqTWuUilfRshDAhDG9PIQWrEwP7YszcSVpdwAojuKZ9iL
	 XZCNHBI2Zso0IQJkfIo86CV7AULqd1b0vJkNaRkJU4XrYcwlxjXjLdJMjJBHI4OKV9VAN
	 +QlhrWV1ITgpwer/qBOgcIPM2JUAoS+1LGi8to8o0QwI9Jtvz+xMMvop/xdIez+7yFQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=SYRBKXhP;
	dkim=pass header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=UB+7XViu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9E7DCF8014C
	for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2026 12:01:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9E7DCF8014C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=SYRBKXhP;
	dkim=pass (1024-bit key,
 unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=UB+7XViu
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C4kVQO3064920;
	Wed, 12 Aug 2026 05:01:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=//ozmJlABNL585BHoj6Ie/iNG0IUCLJTtfsY54zR46c=; b=
	SYRBKXhPh2N4f9MGyio9B9hDBbnn0m+MMgCa6rhytjBkAtAk64Jbn3/owh9PUVQY
	dXIAVvMpRgDosjocCOXLNEcb3VSg8XI3GzSFemZ3PtDGbxrGkM/cy3QLS11h2SF3
	0V4/uhxUvRuPJIozM41YYk2YblAquUAswIRNX7Jla9tQqKqxRwciTYshPxqK+SRX
	naihJaWeFdamNNCEm2yC7IEnjWI+5gE0cYc9tGauvdnT+RhSRilNhLS4yg4Ffsbz
	7pK2xicwAWBuXoFJFdXmZQvigmo+/N0A4cOHZliDsEJO4jdZiPYorT7Z9inmKCm0
	lizazdYnBPPq7xeFw2OVVQ==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023132.outbound.protection.outlook.com
 [40.107.201.132])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4fx1v0yfkp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 05:01:43 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWYtHpJ6Oor6Z9fJH/zjH28KsjiwKf5oCApsGJp185eBswKfoHaz9vQQo+sl2jUyDNwKJ1m8ZcGJYEU1L1E+QYhEyfepqcAjMweMIOAj7A6hZ7kPfi1llvBqPDO0bsqzBYHj9D6lB3nfTT+O70NE/b7bck4nmXS6S2q1C6dX8CKA4c1Q56wJtR91OzuU5zg+9KuC9fD7KWq6Rb+iAnDbdSY7yrr6N/b6lBNrx/rQw8j3GNmygqg//tsuBGsROGsGBzNJNSSt5fBK8l6yEWWFesSVfP2hlzsXMw6iF+S+eSKwn1LvG5t3Hqb9+UnpNOUQkUktxREq5KYrowGAPJXg9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//ozmJlABNL585BHoj6Ie/iNG0IUCLJTtfsY54zR46c=;
 b=a2FoJ87ncvnNbd4uCFnp+jkhAnOGmccj927VuM3UCVZOyFquckrzgjMFw/k/50AnAnKVgw26HePY1FcwSb06OfgOhuS508eGccwZD8T9J+d3yyHyh2G8p0sC4nxHpZshYZ0AILj6YXyK6wUzhTHfuBthyhr7khEae+a/ihugGJJ5ymzMRl9nxhxclolt7Vn8yEu3/jXMJnsybWEbNwqY2riy29n9wlc9svh69zfyq6zOytZcIndXkChTB5FHi8b4/174JKixx5xK2lmygsZfFehIfrd1ZLllnwRsUyV6aRElMyyttWR7ejZBk1VMTK4/t8/3nltnMz3QYdsgrRI5gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//ozmJlABNL585BHoj6Ie/iNG0IUCLJTtfsY54zR46c=;
 b=UB+7XViu+jng97JFNvUwdg4a955CsZ8cjdmJhZ6pZg3+ExMoggpnk4wgkk+Zo5tDfvNQF5bC1gcDKotpVXCDfR/ngU3i7D0szq2VDaVJUYdFk/3Y4ToTr8bU9ESE6BSX/y3pOkDPZtW8I2yGZngBImpWvADbj3q1Ahwc9pjjkEg=
Received: from SJ0PR13CA0157.namprd13.prod.outlook.com (2603:10b6:a03:2c7::12)
 by SA1PR19MB8116.namprd19.prod.outlook.com (2603:10b6:806:38c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 10:01:38 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::67) by SJ0PR13CA0157.outlook.office365.com
 (2603:10b6:a03:2c7::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Wed,
 12 Aug 2026 10:01:38 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.6
 via Frontend Transport; Wed, 12 Aug 2026 10:01:37 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com
 [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 7F66F406544;
	Wed, 12 Aug 2026 10:01:35 +0000 (UTC)
Received: from [198.90.251.23] (EDIN4WRCFY3.ad.cirrus.com [198.90.251.23])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 72D8982025A;
	Wed, 12 Aug 2026 10:01:35 +0000 (UTC)
Message-ID: <83752479-abf7-4b15-bfe4-2ceefba8e542@opensource.cirrus.com>
Date: Wed, 12 Aug 2026 11:01:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Missing Cirrus CS35L56 firmware for Lenovo Xiaoxin Pro 14 ASP10
 (SSID 17aa:3912) causes distorted/crackling audio
To: Viktor Menshin <ripeeerr@gmail.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de
References: <20260809073540.17923-1-ripeeerr@gmail.com>
Content-Language: en-GB
From: Stuart Henderson <stuarth@opensource.cirrus.com>
In-Reply-To: <20260809073540.17923-1-ripeeerr@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|SA1PR19MB8116:EE_
X-MS-Office365-Filtering-Correlation-Id: d79486e3-5c70-496e-7bb2-08def858b2e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|61400799027|82310400026|23010399003|376014|18002099003|22082099003|16102099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	syBMNEDNOeArm07kbvkUt3bL0U5ADD3K8fxpAxjmU4SjorMj37TMJ7NEqgKPICB0yg4/D66P+yfmqqruzzl88gwNw8nLmS81lCEH58aTNwyFs+V/UcFVcaHAlRwLMzfOknUDgwcNYqmcs7oAE8b1WlbS7FzsSs/fRExmd6gvpzeC9mWzXV7z6Cs7JazqeMTWMbEH2khma45sqXrsQ7IUS67NP7CiyHFbee5w9vPeaTgw3/qeSn9haUVNOg1ercwIxNgX28uCIB/5Pc9axssAopTiTIswqVyT9ynDq8VQJeZapngayUxtkff/0FKENVUnV/qrgJMxhPQME2KFDlz5jlvxYzoiCSrZeGlXEbiylJGIR11DxDM7k6V3BAEF9DJ9xxn+MM+8dnM9PESWUzPJ4KLdc4kxLiWUCWqBhEQQhDPvB8+ALPh3NUtyKLFVbju3LuFjUOSNA9S8lOahyr6EtfGqYu3hOVN4XkCPhCGGNxFXbmui9nowYy7WSfSzS/6wdFqlE+f9AqhZ1Fq7X9IjV2ftHi07UEbuTiL5oOD/avzBMKkV8TyJr2kSCy+bfTHY6B6hg+rfeIUfcdP0iTONpXasFDQFUYMOiMuVm7mUX9oA/ya7ggAnVnFpYaG4/kTUXMzHQ5F2aHj88kWY01JWgx8Wz1wM0vUwLGEgRI/HAsz7x384R7tVTLpF5P/EWwqZ
X-Forefront-Antispam-Report: 
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(61400799027)(82310400026)(23010399003)(376014)(18002099003)(22082099003)(16102099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	+436WxW6hsWgV/Xn/MAU9o0t9YCDFvEffdqS/MG3q9ItVn82X0c9Nv66L341Ez55MQtWUJkJMGrYK5WWQUMpLiYAjAzSdPHEnNpUxChuexAV1df9FFYSXed5Ba7ipSDntEAYCej+EXhAhjs1+zYW0G/8NttaeNglSmCoGlCaScrq1D5uA980v7j4W9menEzZXYXwGO1Klp/EzDHHl83u74/YG8vxABhrzzby1x0hhojblhKNlacb5+2ySk0cA4mSndSEeO5pgcWpvkwwhPKu1wOaMhbX/IxeT7GvSgFOkOfgDq3CMenQ+ql8Uq/ZjB+YCUrh6pUfh7so16mk3GFlPyGAs4a6odar9QxSe5//hwODDSMiRcm7T0XDIfPH0CBAHgeDYfCyTixqJaWsuL5xfFt31Uj/My+nETBaSTqWqh0ki9sHEPQT7TOPhDYDdIxM
X-Exchange-RoutingPolicyChecked: 
	ZXZmPaWkTY0geF4g2f7B/YZYrCMedBLveQQW/IzBlKyDAEZewIlZtK06KeV8qcKoNR36qH3W1N3zD+TbsSIw1PYhJfO0co5/rro7Hyo1JpaHZb2TCgmirAN4WFNOxEONPUlCEfNq0Jc28ZGrkFR6rl3tvUFA9ocGAppp/tHkyoBLyBZ7ZgNgqPMu0BZqEKIsIMMMtvJDYHBYc5saar4r2U6rus0pn/u8QikdFxXmUbiGiHBUtlyOTTXxkPnTjpXtE28T7VHhI2hbAiv8zb36AtN+oh5Zrl8OvyGLwnASHIFFd664/sPrHndadnvVZAKqgqlo/+VmCk5o0DNao/kt7g==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 10:01:37.2009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 d79486e3-5c70-496e-7bb2-08def858b2e5
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: 
 TreatMessagesAsInternal-SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB8116
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA3OSBTYWx0ZWRfXzkYejby8/V4P
 /1zatBpGrnPxvCY5R14QxeaaXj2Lsm428fXx6J8E1Hp3naZSKvfwaoEGvcjJZ7ujQsk7rIxL0oL
 Q1YNLLKOgyYsvd2Pfv4lK/lB41sUYRw=
X-Proofpoint-ORIG-GUID: p4CkjNovqs0mnng82YrJzstAwzItYgTV
X-Proofpoint-GUID: p4CkjNovqs0mnng82YrJzstAwzItYgTV
X-Authority-Analysis: v=2.4 cv=ZMrnX37b c=1 sm=1 tr=0 ts=6a7c4487 cx=c_pps
 a=QUIaisbnC9uoo+9AoKvuvw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=kfRJQMtzsn0ixFsMZPEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA3OSBTYWx0ZWRfX6MgzNCqyGODc
 RTRRpeJy9rJVT6M+1VcrGCAbk0TqBywYTyadiQb93jqGRnt34PIK7QctjBK7gkRf9o+te0oaWzd
 tWVDZqZ2GTQfRUmVjr4WW4H9EjVZSfaZ9oh0EngwQNcdEMZLrNe+OGeiRAlou3oOvU/Lsmh66+k
 BiwDh93ZPoJTB5gRzGWs4LFA67Nvp8wmR7tLY6eCwJLye73XLA4P0coG0doWOJQu0OWD+3dL09z
 fM7fSvq1BrPVA7NJfgh3iGwpgkVUoZsuUo4eAXSru/5GZVpO6YT2kE3F6eDN1a598QhZ7ZEyZUv
 CgQ1dVtFVkpLHeVYRBSUX+RF3kj4WC5cItVLfUuspMPHl/b5Bit9Zi4kNqvKpl22DMiMU/R2Etv
 gRuLXRQzeNKs7+LqdtIPIxacCeY+Zj+JRtJgqI7sp/5WhBxLfsbDFgKwdsyBVk63Q/j+VYWzRIx
 uDnZwa52YMNAaTBHwhw==
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: 2ZCYFZI2O2TCHLAVD3TCHDWI27OTFLDN
X-Message-ID-Hash: 2ZCYFZI2O2TCHLAVD3TCHDWI27OTFLDN
X-MailFrom: prvs=9684f921f9=stuarth@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2ZCYFZI2O2TCHLAVD3TCHDWI27OTFLDN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Viktor,

On 2026-08-09 08:35, Viktor Menshin wrote:
> Codec: Realtek ALC287, Subsystem ID 17aa:3912 (reported by /proc/asound/card1/codec#0)
> Amplifier: Cirrus Logic amp present via ACPI HID CIRQ1080

I'm afraid I have no record of this laptop in our systems.  A quick 
search suggests CIRQ1080 is a touchpad:

 >-------/* CIRQ1080 or SYNA2BA6 */
 >-------touchpad@2c {

Is there another reason you believe there is a Cirrus amp in this laptop?

Stu

