Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6ADCDE001
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2026 12:09:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 76B59601E7;
	Thu, 25 Jun 2026 14:08:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 76B59601E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782389345;
	bh=HOxGg4odz5v+aLmI+3SI9pNfUV7zejJ322f5nIj08yA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=lo6n5SiTWdEI9Aa6SNTaJze7LuLqDjTDk2ae/jY98trPFitpLOR04tdpNlmJdgDX+
	 RAijT0pyN7NjGhr70rPBOkEdxJHVeqZ3hDHDfWidqKIxQv+hHlHcwkNdrbPsLCiZ3v
	 KNU6+/us4cfONaVQxw2ITNWtglM4fo18yuq1h7EM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2EFEBF8061C; Thu, 25 Jun 2026 14:08:17 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D7F2EF8061C;
	Thu, 25 Jun 2026 14:08:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9899FF80605; Thu, 25 Jun 2026 14:08:11 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1782389288;
	b=FobWnoxEA3HKrolxr4TypPghCe00gAwZJFjPzLVmA38sQvyNk5xUgtygAzBJNVX83P+i
	 eGhrNqHn5qgz9rAScAMZ36unfpa5nCCgwTfZAqD/qKUlUTU20bJOo6C33gRhHHSNfdqxr
	 sXltVDwJ0DyjmcRLMSFmFilBW/clSnETpAiQAXWJrXB3qgOolYXbiFxsNLR2Vwb4Smki9
	 SG74b8hr/cYivZN/X5jJcpJ8zTh89Z4KtWmXYycC41QSb8dHfGjaHnbEIdSUMoqO0F/73
	 dgwTCCtDFkQMHvpBkLOInDBIvgSr5/8Cgz4PpTM7RzU+oJ8TerMcnMnXhngJ9rrKPOQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782389288;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version;
	bh=HOxGg4odz5v+aLmI+3SI9pNfUV7zejJ322f5nIj08yA=;
	b=RI5vOzLWTQfWjQvaSwrlMOL4Gr9NUY/ZiXGGA/UBEUQ+yuWUHQUWhoZ+VupvHJAazG9B
	 H+ruaYr7ckXAHBN9UXJLgq8bJYqwgeqm+goCji3udhRrVBv4v4XMSi1ahNbaRmI4o24gs
	 /v22D7pAXB92DrVF4lO6J1ec/nM2K9jSXfnHxOQsEpABYDtwSRgWpkOl+3m2LfWTrCMlt
	 my46QGsMPykbOACeerQ6BrPNoHeY7M2yei8lmfF+XjHmtvlA7KUODEF7u2DUgmEU1May8
	 A/gDzroaArTbZkRaKf+KZ/CeCXJT/CJkibzqUCcv/qmjmt4ZrZw6mzwzHeLoXkk37BQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=lw8F8YC6;
	dkim=pass header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=H719lUGq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2730DF80217
	for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2026 14:08:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2730DF80217
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=lw8F8YC6;
	dkim=pass (1024-bit key,
 unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=H719lUGq
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P1fsTv3747681;
	Thu, 25 Jun 2026 07:08:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=VuD0tP6V0Cqaw5E3cgOc/oIDj3D2LuoqlkqzWcthOiM=; b=
	lw8F8YC6fUHIR5uo0luap0xsEhH50s8Yq2pUYRjYoQLbRiur+cotfYnT9gY3TVcP
	CtifNQ1pfEZJrvAdLna7IiLjKZl6ZMIxn0r9qJaGOhMP1HlQl72w2AL5h9hZ8tts
	Xq+WYS85IIHSQyZU8tqNRP0w7r0nwx3wOvZso3PRrr13/e2Uj3/ZR9T2ybhPIzm+
	q25BAr2pxRq6kNrwFpnxP6gJ7zEfAnbJg98v66MnaLrb5qq5ZLjoMvQLGnvHuhuW
	rjCO24R7AI5Bg7fTtxqYmxnbP7HVrqO3r4Ft1gGMC5UNb5QO0sCiGqAqvdod+RZu
	ptDIgexsuvzul7UB7ZRYag==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022130.outbound.protection.outlook.com
 [40.107.200.130])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4ewr8x6j33-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 07:08:03 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIFvqEJfgNV4n39Se3WAkrRnB1Rs/xtEoK12epnVMt0IkTvXuD9wnQXNe4+6omNc7qcYWELAMYWk1TM5UKIuSwMSi6YQ1u78EGhVjF0hFKDgMd9+G6TIo+U+dOF/kxckZj9yE1yk/k0k+r8m0Nldy4Tpvzy0BtO/TbUIIi5+QK8oe1uI50zfi1oNUR45gJvZc7fuDCIoBBIaQ4N3w4eHsTwdfg9SUzAthYhpIr3+Yw9BghJD2cfaXvvX2fItKVI2j7A9S3isbdmIG1wx3RuHPuE747tbNYaN1ZmH0eYB102FLRJOM+yZja1F24fRNr2FE4RBbUiejD/YR4ptySHWew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuD0tP6V0Cqaw5E3cgOc/oIDj3D2LuoqlkqzWcthOiM=;
 b=ocMqgnvaimJPSMpeLD1ZrP2gofkFyx1VzJETPjvUJMkDIONe9mLh/VuOMhaoR6qDTxEEZVvmRmeKH1tdvYEMOMj5cFiGlMF07Eb2Yd6YU7t3IYhwSsd9wo+tJ0AjVy3RLfE1cKTBalGe3tWkicQjwRGlxq7AkutBwhb1vBxJ2kIYxyhImErwrTdKeZCm7xvoyTxPZm7QE6rW76BkOHFbiVlhFLTVG1eydDjzGPSUKSymi7JCmMtzQk5UEfw6cji+fL1cPeTiaeJcBgB7zHyqiabibwKylSUwu+CIPEa+kcrKGAsVvnWORLd8b6uyLNwSYoE805NHbdjT2Ky9dyEeFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuD0tP6V0Cqaw5E3cgOc/oIDj3D2LuoqlkqzWcthOiM=;
 b=H719lUGqu+8doYWuCn351jfmtuv790d2mGd3chEDNeGvd030PNl5yUSUmnGcB+CFvCd5ebk1NxOAFdf331WMhxXatHq/YkB7a1PaQ67D1e85nzGDFTU7epD//Pp76UNOAv3/w05J9akVU3rk0VSmyzaz3o4vksMHX7mieQPpcuc=
Received: from PH1PEPF00013303.namprd07.prod.outlook.com (2603:10b6:518:1::12)
 by CH2PR19MB8876.namprd19.prod.outlook.com (2603:10b6:610:283::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 12:07:57 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2a01:111:f403:f910::2) by PH1PEPF00013303.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.15 via Frontend Transport; Thu,
 25 Jun 2026 12:07:57 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 25 Jun 2026 12:07:55 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com
 [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 0EF8D406542;
	Thu, 25 Jun 2026 12:07:54 +0000 (UTC)
Received: from ediswws03.ad.cirrus.com (ediswws03.ad.cirrus.com
 [198.90.251.35])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id EEC7C82254D;
	Thu, 25 Jun 2026 12:07:53 +0000 (UTC)
From: Maciej Strozek <mstrozek@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        Maciej Strozek <mstrozek@opensource.cirrus.com>
Subject: [PATCH RESEND v4 2/2] ALSA: control: add ioctl to retrieve full card
 components
Date: Thu, 25 Jun 2026 13:07:41 +0100
Message-ID: <20260625120741.3404473-2-mstrozek@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625120741.3404473-1-mstrozek@opensource.cirrus.com>
References: <20260625120741.3404473-1-mstrozek@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|CH2PR19MB8876:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6803087b-afc3-4047-89b3-08ded2b2641c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|61400799027|376014|3023799007|56012099006|11063799006|13003099007|16102099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	TaV01e/TfSrwBcP8pghXifkhJ2oTRTGBbYXy918fnxA6dCoukauXKFXSXhg5vC2N3aWcOSFTsMCuruNHeMkobjjpJifp/yIf60YlvZhHIiVDOCUz84U2V6MtoBBB7JTAmmw+vDOgyJD1w/IpnalO9zH3RLuIz5yWq+TSTYL9QQLwbbEul7kjzrkJOw4pM2DXpcL1a/yzcnb6zlzM2EOjSdcWbU8iSgfFUPC14sSFRSUdaCCQIdKaolcdAUPwtelJAGGhMXFnYdWihu9k54IGPXrLQIFz8Gx8Q2QS49Tn68qGYmUAiIRfzGHUQ7dXctxlY26DDGIGpGN4yDeGCtgUrjZmjQsNnii2lhQS2BWpcHVsYEHEbk8Yol6UlK2QhzAnUYaopSlnc4a8AzAneZX1F+RROkDDpd60xLbZQK+BU8XkmZi/1PFScDKYCxyyKoxh3wBdG/F5SfYYm1pnT5hBgO0qBOxxc+8YIgdhDBP3wkAd0R3SVjXtmj6I0Ui4LCzB19JwLYKcI5OUX1Fd8zazrOHWANtqQEle/lNtrwX4u4bfjpYz7jaw5pDdl5RAiodd27Rj2wxmh+DL1nCWJW/m0tJkYzV6nAqlOjaAvCLxNiyruu5Y7XWe+qfS5YC+mkK2hNJQ76THkFsT8V8JA6VcYakbhanRhwsWoI81Pd67Na7LR2Jtih0eJ9LuMYkxeDD3DfctSznY4yaoNiwTt2OSmg==
X-Forefront-Antispam-Report: 
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(61400799027)(376014)(3023799007)(56012099006)(11063799006)(13003099007)(16102099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	Jbc+leqQxxT5pZLu0RG6hLX1rhprvmd3XwbgJwzRQ/A1XcJE4VNhOs3TxIsTrfudA56KLD6n5pWxZ8RITwwZDsrkG7uybUMWcRHsHfoqqGCZnX5XIpPvCyNjpPUYVLGPHdo5JrAEQg7Epqbk+0dgcWMHmHkZd/mNzoY+q19MYmKJSyGBuj0Tp+Ix9c/SzX8XWdXvd4M57qYwEan5J9gdz1m3RfrZBzYLHQODYzbnhEwbthQkIY3XJq91nq5NNYCk1Wj75U+v9O8oZwY2ySBL6HZYD/h2gqnxPqEfm3536kKc8ieABbZtnjT38F32ifIvyNeIcZCXgDCBvZkU3eCAZZBRDlq79Ni7L6DwgBcC0jmQi7IOSydnlE8oxi2kZU+e8KGNi3f/Y7jvoAJjbHQeUuNH7cMl5TsFKVrPuqPkyV0Py5S/Hma8Pe7S89O0gWJn
X-Exchange-RoutingPolicyChecked: 
	dnaRk3EygoruEfFeC10uB9Poh2m0vZ5T3fvbNWHoRt0hylku7cc1akCCeILl3GVCdfFM2Xt4JpmDDeX7gjR7ja8dWFraj0byFLMqDJI2xFqFdMyLUsq/GvF5v4udujR4JsRjZ8X1+QaOHYwusAniTYjWZJexVZ0zvWlEWYp5F8V/vTQbuyKqo8k+Cj+xK5ORFGHl7z8Ncm1If70xxSR/eWwMHButGIo5xh6QH2WN7XZn35BJell+17sG9LslPahB6qNdicTgLp/8Ru5QHV45+oXlvNNxPerzRxCckRViXzBq2yCVgau/swWt/tpJOjymYbgeO5ftFW5xBzcWj9Kqkg==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 12:07:55.5827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6803087b-afc3-4047-89b3-08ded2b2641c
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: 
 TreatMessagesAsInternal-CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB8876
X-Authority-Analysis: v=2.4 cv=UJ3t2ify c=1 sm=1 tr=0 ts=6a3d1a23 cx=c_pps
 a=7Y9AH4c8mdD7Nc6D4wSrFQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=FelO9ux0wxsA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=NEAV23lmAAAA:8 a=iox4zFpeAAAA:8 a=w1d2syhTAAAA:8 a=sefg8_7nxHGFjYeqZrUA:9
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEwMyBTYWx0ZWRfX7ORSxtCTYc3d
 1aXP+myXqnt7B0q7j7u2MRI3UIjnImAa+QJwaopMB7DleplXVxR6GdjwqWNL5a+Zds7Yfd/MP9/
 2+Ek95m5Gl2wKFfgJmwMqWnH1sJJmGU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEwMyBTYWx0ZWRfX74NUukdHUZHP
 OK6KvctULqaYZcxD/Kj9XkXzQSGr6NdtnsRXM63xYkfAJyb6Nzsace7ykoCXaBbzNL47z5vCR5L
 dWWGeUASqNomnoPujkGbEd12DEAeCEdKU3CPt4e0ZDBC/yWrFCRL2i3E72Zj25cPZL8SPiCSNLB
 AxbSSpkhCEypTrw+EekM2ClaZrcJc0As4gs8I2cFe8FIpmsp/mddRkEWhL9mJfv1eHGWHiWpqNz
 DrO1nN1ms1j0GrvlBjTalFSKbiqzOC0BO6fmQo0dc4/m/DPRqVIQeuKCA3dVPijfmZ4jCZyANrL
 vRQt6bO/AEGpXF+GUFyCPhtd7rO0efNKXyKafuvepfsASMKspNmNkV+NGgpXwOZDWBAUFvhdL9N
 m7PFNO2E3+jWsXVZscCWxIOCIk+yTg==
X-Proofpoint-GUID: c_P2_yCkCWTCnfsH2yvYY12OS5JxwndL
X-Proofpoint-ORIG-GUID: c_P2_yCkCWTCnfsH2yvYY12OS5JxwndL
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: J4YPKZXXXQ77M2TMHZRDIJWYTNM4I4CU
X-Message-ID-Hash: J4YPKZXXXQ77M2TMHZRDIJWYTNM4I4CU
X-MailFrom: prvs=763683fa41=mstrozek@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/J4YPKZXXXQ77M2TMHZRDIJWYTNM4I4CU/>
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
 include/sound/core.h        |  4 +--
 include/uapi/sound/asound.h | 21 ++++++++++++++-
 sound/core/control.c        | 52 ++++++++++++++++++++++++++++++++++++-
 sound/core/control_compat.c | 27 +++++++++++++++++++
 sound/core/init.c           | 34 ++++++++++++++++++++----
 5 files changed, 129 insertions(+), 9 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index 4093ec82a0a12..8a6a0e86da5e5 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -87,8 +87,8 @@ struct snd_card {
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
index d3ce75ba938a8..a6b695a798f07 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -1058,7 +1058,7 @@ struct snd_timer_tread {
  *                                                                          *
  ****************************************************************************/
 
-#define SNDRV_CTL_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 9)
+#define SNDRV_CTL_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 10)
 
 struct snd_ctl_card_info {
 	int card;			/* card number */
@@ -1072,6 +1072,24 @@ struct snd_ctl_card_info {
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
+	unsigned int type;		/* SND_CTL_CARD_BTYPE_* */
+	unsigned int data_allocated;	/* size of @data buffer in bytes */
+	unsigned int data_len;		/* in/out: actual data length in bytes */
+	unsigned char *data;		/* user buffer */
+};
+
 typedef int __bitwise snd_ctl_elem_type_t;
 #define	SNDRV_CTL_ELEM_TYPE_NONE	((__force snd_ctl_elem_type_t) 0) /* invalid */
 #define	SNDRV_CTL_ELEM_TYPE_BOOLEAN	((__force snd_ctl_elem_type_t) 1) /* boolean type */
@@ -1198,6 +1216,7 @@ struct snd_ctl_tlv {
 
 #define SNDRV_CTL_IOCTL_PVERSION	_IOR('U', 0x00, int)
 #define SNDRV_CTL_IOCTL_CARD_INFO	_IOR('U', 0x01, struct snd_ctl_card_info)
+#define SNDRV_CTL_IOCTL_CARD_BYTES	_IOWR('U', 0x02, struct snd_ctl_card_bytes)
 #define SNDRV_CTL_IOCTL_ELEM_LIST	_IOWR('U', 0x10, struct snd_ctl_elem_list)
 #define SNDRV_CTL_IOCTL_ELEM_INFO	_IOWR('U', 0x11, struct snd_ctl_elem_info)
 #define SNDRV_CTL_IOCTL_ELEM_READ	_IOWR('U', 0x12, struct snd_ctl_elem_value)
diff --git a/sound/core/control.c b/sound/core/control.c
index 5e51857635e62..9a3772f1126d8 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -876,9 +876,13 @@ static int snd_ctl_card_info(struct snd_card *card, struct snd_ctl_file * ctl,
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
 		info->card = card->number;
 		strscpy(info->id, card->id, sizeof(info->id));
@@ -886,13 +890,57 @@ static int snd_ctl_card_info(struct snd_card *card, struct snd_ctl_file * ctl,
 		strscpy(info->name, card->shortname, sizeof(info->name));
 		strscpy(info->longname, card->longname, sizeof(info->longname));
 		strscpy(info->mixername, card->mixername, sizeof(info->mixername));
-		strscpy(info->components, card->components, sizeof(info->components));
+		n = strscpy(info->components, card->components, sizeof(info->components));
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
+			data_len = strlen(card->components) + 1;
+
+			if (!info->data || info->data_allocated == 0)
+				break;
+
+			if (info->data_allocated < data_len)
+				return -ENOMEM;
+
+			if (copy_to_user(info->data, card->components, data_len))
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
@@ -1992,6 +2040,8 @@ static long snd_ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg
 		return put_user(SNDRV_CTL_VERSION, ip) ? -EFAULT : 0;
 	case SNDRV_CTL_IOCTL_CARD_INFO:
 		return snd_ctl_card_info(card, ctl, cmd, argp);
+	case SNDRV_CTL_IOCTL_CARD_BYTES:
+		return snd_ctl_card_bytes_user(card, argp);
 	case SNDRV_CTL_IOCTL_ELEM_LIST:
 		return snd_ctl_elem_list_user(card, argp);
 	case SNDRV_CTL_IOCTL_ELEM_INFO:
diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index 4ad571087ff59..9077482d67440 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -19,6 +19,30 @@ struct snd_ctl_elem_list32 {
 	unsigned char reserved[50];
 } /* don't set packed attribute here */;
 
+struct snd_ctl_card_bytes32 {
+	u32 type;
+	u32 data_allocated;
+	u32 data_len;
+	u32 data;
+};
+
+static int snd_ctl_card_bytes_compat(struct snd_card *card,
+				     struct snd_ctl_card_bytes32 __user *data32)
+{
+	struct snd_ctl_card_bytes data = {};
+	compat_caddr_t ptr;
+
+	/* type, data_allocated, data_len */
+	if (copy_from_user(&data, data32, 3 * sizeof(u32)))
+		return -EFAULT;
+	/* data */
+	if (get_user(ptr, &data32->data))
+		return -EFAULT;
+	data.data = compat_ptr(ptr);
+
+	return snd_ctl_card_bytes(card, &data, &data32->data_len);
+}
+
 static int snd_ctl_elem_list_compat(struct snd_card *card,
 				    struct snd_ctl_elem_list32 __user *data32)
 {
@@ -426,6 +450,7 @@ enum {
 	SNDRV_CTL_IOCTL_ELEM_WRITE32 = _IOWR('U', 0x13, struct snd_ctl_elem_value32),
 	SNDRV_CTL_IOCTL_ELEM_ADD32 = _IOWR('U', 0x17, struct snd_ctl_elem_info32),
 	SNDRV_CTL_IOCTL_ELEM_REPLACE32 = _IOWR('U', 0x18, struct snd_ctl_elem_info32),
+	SNDRV_CTL_IOCTL_CARD_BYTES32 = _IOWR('U', 0x02, struct snd_ctl_card_bytes32),
 #ifdef CONFIG_X86_X32_ABI
 	SNDRV_CTL_IOCTL_ELEM_READ_X32 = _IOWR('U', 0x12, struct snd_ctl_elem_value_x32),
 	SNDRV_CTL_IOCTL_ELEM_WRITE_X32 = _IOWR('U', 0x13, struct snd_ctl_elem_value_x32),
@@ -456,6 +481,8 @@ static inline long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd, uns
 	case SNDRV_CTL_IOCTL_TLV_WRITE:
 	case SNDRV_CTL_IOCTL_TLV_COMMAND:
 		return snd_ctl_ioctl(file, cmd, (unsigned long)argp);
+	case SNDRV_CTL_IOCTL_CARD_BYTES32:
+		return snd_ctl_card_bytes_compat(ctl->card, argp);
 	case SNDRV_CTL_IOCTL_ELEM_LIST32:
 		return snd_ctl_elem_list_compat(ctl->card, argp);
 	case SNDRV_CTL_IOCTL_ELEM_INFO32:
diff --git a/sound/core/init.c b/sound/core/init.c
index 593c05895e118..a683803bcf96a 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -590,6 +590,9 @@ static int snd_card_do_free(struct snd_card *card)
 		snd_mixer_oss_notify_callback(card, SND_MIXER_OSS_NOTIFY_FREE);
 #endif
 	snd_device_free_all(card);
+	kfree(card->components);
+	card->components = NULL;
+	card->components_alloc_size = 0;
 	if (card->private_free)
 		card->private_free(card);
 #ifdef CONFIG_SND_CTL_DEBUG
@@ -1036,16 +1039,37 @@ int snd_component_add(struct snd_card *card, const char *component)
 {
 	char *ptr;
 	int len = strlen(component);
+	unsigned int cur_len, need_len;
 
-	ptr = strstr(card->components, component);
-	if (ptr != NULL) {
-		if (ptr[len] == '\0' || ptr[len] == ' ')	/* already there */
-			return 1;
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
2.47.3

