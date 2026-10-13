Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D2ACA9ED2
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:29:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 231B560233;
	Tue, 13 Oct 2026 12:29:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 231B560233
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791887356;
	bh=ABbY0K0S31yqqrovIo+c2mZK7maBO34Yuz1R+Mf/BkI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=cjyEDjRFl2KcBrfCEZqhJYPgN6fcRTITdBlv0lngrLc4jug6uxM6Fn6TI+NNuoqUw
	 zmMZkB33tCIgrmOCaZsT86aoGcHlusOo+wm07ODNyfz0QmIuvSqIZJ0252TlaN6K9x
	 JnrDIYqZgKQfrpZqrUZ2nLN11AinxsJaka0KR0BM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8CE3CF80601; Tue, 13 Oct 2026 12:28:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D2385F805F8;
	Tue, 13 Oct 2026 12:28:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BA142F8045D; Tue, 13 Oct 2026 12:28:34 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791887310;
	b=oRzuT++S2E3eexK3zbx2zTFSeT4U2CdqJbLxmbbwIFSmskjaT0Id8g9XKYeExCDkvTXk
	 qyLZg8BoG9SmQtgWDaAF6tE8DzUDS6j+WlVo5L352NP0a1yDrDugNc8EUFGMpceBsMPrB
	 ckh9A9SJsSuLOPQgX5oBMokrFeC9uBSC46HkCT7fN+ppv+IZ7Xv6wOZdpShQA/4LgSWOv
	 7/yC4m1f8+nR07l77ffpQRxZGS6HsgIcqTuv5aAVvdB0++vR+qgsdSafuVwHMS0S+k1yc
	 KRAquVfwzIEg3vyJX30Qh8IFAD+Y5sH6djzpISbelFXr12stVvXqfICbQz9/CZLz6Bg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791887310;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:
	 To:From;
	bh=ABbY0K0S31yqqrovIo+c2mZK7maBO34Yuz1R+Mf/BkI=;
	b=sKWQNNLQ+B1q4fKIAlmdtQPPsbK+TIV9Jqq5Ghq5FNl7qlv8ohQGh+Ux+9ibnk4q3JbY
	 8U10Mp45jVZA7sArkI+NVIoLi+5vM0hkwZleRMWE1Je1vdwoejmW8rLwbB5ED0PJxNR9B
	 b1HptDmQbDmH/tT0N2cVp9RLQHUyEllYX2xNO9rK0I788jCn1+XLKSwz80NN/0KcfZwaU
	 csuwCHi6Jm8ljAeygfIHVgFJKOdS1xCD1MZsoTzhltn2bfQ8ogpsXQydksqqn7XXQjxYx
	 4tsRR+qNPFNW43Khfx9OGUspz2wLPlG4hJhDQTDqJzvCnTP5lg2JM41P7QDUcdj896g==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=lM+Vvv8u;
	dkim=pass header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=JtNRgpxQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 37E27F800B0
	for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2026 12:28:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 37E27F800B0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=lM+Vvv8u;
	dkim=pass (1024-bit key,
 unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=JtNRgpxQ
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DA60Ik2265598;
	Tue, 13 Oct 2026 05:28:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=PSV9pj3B05oe03Xn1nOgf1w6nUIG2Jqi7MYKw9vSddY=; b=
	lM+Vvv8uMRxFFm3y9SA8vo1MroiChJq/5Qfs6Ts7Gmka+dl3bvNu6l8INBxLFcY/
	Zy99zjBYH1q1ZLiOFqo0Gs+2qU/4joHzNZC7Wh96aWS1iB4V0RjNiuaaewvzqyAm
	FVOs9KxrPuPCCACkMEMUt3XK+pfsfHXjxajp6iZhV3JmV/VY0eCADt+o4kewwv66
	qA0yBQcEvRO/f4JACJP3vUsz5JFdZb3POQFQ6RR9MT7VntUagRJ0U7bGH5DhanlQ
	EwIQhC3KsXR1HvL9vOJyNkpuR19aINMBv0DbfNBJztERx3uBI6C5XlLLqKxjNWj4
	5d2aq7H9wb154JzNBgSFQw==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020133.outbound.protection.outlook.com
 [52.101.193.133])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4h7jrxbh73-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 05:28:25 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGWUu9W4Za2zSVaZ2rEiwvF0rbQ0wyCcoyK2FfTC0V9gFvjvw0rvNf+FFe5xHyBgugiKjaRxxJXvwLXTaoQ31VmDYXgODa+PGk/HhjCbGIWcCStnmbstAx/GogAJzDEMU/nOySRtj1FM6NIUPgvHaO4rZ2V4vOlYyYlFy5e1fATmJ1L2iqIMop6ZsDzRiElpv6kxHJQd85RDdZOdhRZ9Jhs2UgesO11XeT8kzPx13JFveMwT+y2CtiB8bgL1JxYjSIJhUUoirvJjNj+neAKTIg0LYc8RmzwpzrExDBysbzlpJlHoqe0/srnzPviVMpF7ks0v+UodT8WNGlnNzzy8Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSV9pj3B05oe03Xn1nOgf1w6nUIG2Jqi7MYKw9vSddY=;
 b=AG1Wa5JHB6qZTknffsJ3cJ09z91UK617Myq253Px6WjsDEmEhgs31hk0l5BeRjnUEtUWAdaFDRDtfs4Gvp3YGfsBXb1k0aA1vbke1XzrNc74iGiS/FAJAdiBwTJWzGy4fa6F4h4+rUlbTYVfwRqJAC9a32A0GcK5oNEsvxwBXUOQOTBnXi/H1EJAWj2kmDGGwMB6TIFBzw4UFh+gEE+QXicuHeoXkHII187DRVqLkVglJpisQyzY/hZ/pM3oKMoJeSD6bK6MFdbTpOQ+RArC+6uxb6Rf6Cyl8Y7Z35iB/KOAI1JeD8DRch2pAc1zHOLyWQC8S9o0J2Lkl9X6d0ZVWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSV9pj3B05oe03Xn1nOgf1w6nUIG2Jqi7MYKw9vSddY=;
 b=JtNRgpxQ8ZLMhDcBn3w5UwG765fYU8BDYnAwy82DjNoRNsy0vhksOVUaXAbfWua+HzIXCfWn6Y7mGRzXKE+IZVJbc6StuRkiidjqHA3BCjzgY7Tv4WNU43izTBcVdgBY3uh7lT+OOTKATtUJtCAcKTB4Ezs/FIX/LuXLVJ3J9XQ=
Received: from CH0PR04CA0107.namprd04.prod.outlook.com (2603:10b6:610:75::22)
 by SJ2PR19MB8027.namprd19.prod.outlook.com (2603:10b6:a03:541::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Tue, 13 Oct
 2026 10:28:21 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::5c) by CH0PR04CA0107.outlook.office365.com
 (2603:10b6:610:75::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 10:28:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Tue, 13 Oct 2026 10:28:19 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com
 [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id EE144406544;
	Tue, 13 Oct 2026 10:28:18 +0000 (UTC)
Received: from [198.90.208.11] (ediswws06.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id DD50F82024B;
	Tue, 13 Oct 2026 10:28:18 +0000 (UTC)
Message-ID: <35192938-660d-4682-8963-92f53e118ef4@opensource.cirrus.com>
Date: Tue, 13 Oct 2026 11:28:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] firmware: cs_dsp: clear dsp->running on the
 cs_dsp_run() error path
To: Mingxuan Guo <gmx472@qq.com>,
        Simon Trimmer
 <simont@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <tencent_B839C5A92D762B5717B9637A5CFA0841C608@qq.com>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <tencent_B839C5A92D762B5717B9637A5CFA0841C608@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|SJ2PR19MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: ce9819f9-a7dd-48a3-1b23-08df2914b3bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|61400799027|82310400026|36860700016|23010399003|56012099006|11063799006|16102099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	eHTJbUlLmv/6RZIRqFXCVj5yfKjIvm0omVDSh/Bvk01REGSvMrrVJv+ewW67seSEQ6keq2xe6/8l21dVfIWdJXmfTiUxAUe817DfB6CUZUV2owL166z8vRXcQ/FllpzguSzdPGfPC6C2WxPvrv44q8gHSYijbp9E+qCpO0Cd6vBastomBsCKkpiEzRA7RJgSDoHe5Q1YceTKWz/2jHcOMLZJAhJFV5DcXvfJZjqEtzkaSk12+PxS7z7MYwVqVZhbly0aLdwthO9GMLiVgosr3Q8Y1gLIQEiXWqwbNKFzhhL3w44FNLQXRbMj4+YjsJqxU7xvxhGmibSSuFOOGdjPXroalLf876bAkY76ijdf3p1KfssQC6nhhuzMPKQe4pmmb81Ay5CqVBTsoW44MKR6adqaz31JFYIzkyaPW0XJ9FLCDAhJVURW9/LEH7fFvxNHkfI1GO3FooKp4nCbkMqLpL80+oY+GXEx7jvzt6s913UEieE261L4KlRdPikSP9Np5v2WRPnMuU+NrYPvd+rwGcJoBRXK2JRIaI0hbcR3CSN4ul9n4W5rU+nnFHiKGzTX0rPlfj3b9Pwe4kA77Bu4Miz68QG6meQ1WYj2QrW8obYV4c5DlmriPl1IKKUiq9fYi4QSuG4Xh663zR7Q60YAH7d1UawynKxr9U4FnBt55af6h1P/m0QfVTHShQlKvHaQLkX4ftWIGHew7+ERS/xL/Q==
X-Forefront-Antispam-Report: 
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(61400799027)(82310400026)(36860700016)(23010399003)(56012099006)(11063799006)(16102099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	CFzZXrvJnVEaGd1gXkdGrOkCXNu3AxkABZFTPN5sm/jTf5rcbyPHO/GTxTo8BE3qyMB84YAEC6UEpE54AKP1E09eEB89a0s7KR6PLSJBaExkpGKsNEn9H+Esrg9ih9jPqVunJ8ouRNk1B3lK5UCILZt6cI0R+xTV9eFzaXnsOozGKR9KDelZsNkjuoDdU6j1OdKU8gX+jn+UC4QQ/xSoGCUU67urs+Nsjh4Vs/xMkf7Esyw+vBOIEoZxZqflNYglfmQ/CZJGt6RanSv2/kwSYQZNo3kiVECDiFyHhaGQBc/4QLxJjzLLMqlJCM4P0te+eiuXh7yuRY9bwXyfMCH5nxtyWdLA31yqtULvezltXoa1qJftqvIBZ4sbXZ/AOmu2hJWcTEsJugnRS0o8XjWodfWGJedoT4OOnkFNXq6k5MRC6zeD1pWhYqdMg2jlDztM
X-Exchange-RoutingPolicyChecked: 
	3FyTV0RWcBcrmu8t6ktcGX1BUeqA45Nx/lYHDWHAxK71vvXhrCFBP+xudUM4hsCwNNTTKqBs86o3jYNoBf6oj2wq7UKmQc9XSNzkrWfzb/wwlIKHlIXRVOeTgheqpdeKivwvMOK9btryyb3J1DMFvP33CMtkZdy+NQSOxnmK6H1dcWEmjrfLzLn+XOX2sny7BHOyXN6wIENkhVKe/hlFnPBf0Xmzaqcryutozlur9mRkZ4zzGN+/CVzccsueV8duptHF2dHc53rCL+n/FqOEzo9n2BYq1WlS56vEZPrnS1nlrIAdblm0jNQom8l9GC2wFrzptnTgNqM4iKgMwRTS3A==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 10:28:19.9221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ce9819f9-a7dd-48a3-1b23-08df2914b3bd
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: 
 TreatMessagesAsInternal-CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR19MB8027
X-Authority-Analysis: v=2.4 cv=A/n5rKWG c=1 sm=1 tr=0 ts=6ace07c9 cx=c_pps
 a=OkMMD3sknCYbbSSSOfdz/w==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=w1d2syhTAAAA:8 a=6KqoQpt3PVVccOLwCHsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Z7SZ7lOVJliCQPw6kw4tNp1inUox4OoV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0MSBTYWx0ZWRfX9lgWXlGizOgu
 2SC9Pqi0yMob6qH+Ao13Yj4mS1N0iRPNoOi0hEPdNn96pdGv91+n3j3RFUnJVyIUR9/NPAiktfe
 T4xn5G6oJN6GLakDJ6WY/hNe/2UFr4M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0MSBTYWx0ZWRfX1/CQUtGxBP6K
 NFVoRpjxwjuJOuWE1OtJU6AJvQanZ9j2m2GAhKCNHiiiqsoNjiP+VmABhrsbXvHPVKlwu7DZvOO
 Fx/H2Wv7vVEqLVuzouiUuJxHPFmEuSRFiMi45/BQ295g+9W59JSOLTMcO9eQNwQrAFzkOXeefoC
 s2TOpcYkWeGXOzhAYRYK6ESm3o5+lGvyvrhXhPbd8TBa/DM0BJdruXkyrlLpd1LYsC4d9Xa/DRh
 Xa5uN+3eVnyMqOlkSUIFSTy7o3EUjVjtY1u1PlfS3xH4rYareJRC0jbuPBcfVsCwkFhuZn42TN1
 XyxIe+PxSo3HDgxhqCV3/g+te4N6WhG5qtvVbR50JiHrvk4lgdcwQNXnNbv8auFGIluDBkgzwH+
 /f7kL1Ycz/5a8J7phGD41uWcTTZtLY4pINNJlv1T3UIJYiBtPbXbgmqocmUx2WWIZup7xi60eJz
 ywRsfdvNv2VAeguZhaA==
X-Proofpoint-ORIG-GUID: Z7SZ7lOVJliCQPw6kw4tNp1inUox4OoV
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: XJ6MZRQHFBQYCRHHNYOVTDCLGQ4DKN57
X-Message-ID-Hash: XJ6MZRQHFBQYCRHHNYOVTDCLGQ4DKN57
X-MailFrom: prvs=174672dc46=rf@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XJ6MZRQHFBQYCRHHNYOVTDCLGQ4DKN57/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 13/10/2026 11:23 am, Mingxuan Guo wrote:
> cs_dsp_run() sets dsp->running = true once the core has been started, but
> the error path below it only stops and disables the core, leaving the flag
> set.  The first thing that can fail after that point is the post_run client
> hook, and it is reachable in mainline: wm_adsp registers
> wm_adsp_event_post_run(), which can fail in wm_adsp_buffer_init().

Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>

