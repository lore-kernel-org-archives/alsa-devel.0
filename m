Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C219C4451C
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:31:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 04BD0601FA;
	Fri, 17 Jul 2026 15:31:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 04BD0601FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784295091;
	bh=748VBZ1WtSTxSXdqwWgITZ6x5VOvAQzxF3GUX92Gi/8=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=rogH7XpSBKFIe5flsm3MPsRn9993s838Q2ujuyDf6/U/GOMsm4f5ngNAO8lmjAnpl
	 Lb+U3lragXui3MbisMjW55uxJrKZ5UvGO6WcASoNwNycPTOODn4ftNe85hgcktxK6E
	 EKXLI6xC99XFcVxwKWsY9WI2A/L6q9nXSIVXl3Hc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 37D30F805F7; Fri, 17 Jul 2026 15:30:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BB247F805EB;
	Fri, 17 Jul 2026 15:30:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DF8E3F80526; Fri, 17 Jul 2026 15:30:50 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.168
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1784295046;
	b=Eh0ueuXjodFc1s2cqXBj4ICvU4hSn3kyuoQ0Lm+nj78r7qO94gfEUKco/KrR9t4HAMI9
	 d4xrkjocwWxfjg0L6ZohuX5POTQfQKrxAEsbDtGv6VWs7AatSG7xNEjMsH69VXnn+469T
	 y5+usCxoELZ/jeWRx1XlMtMcNTZTAhCMU3f3vekG4t5lGHUayrvXHBumJEaBajyDkbLE0
	 fPJYH3gnG171WPrT8Cf4dbd5bgCe1qr8x4aRgsSy00JM7vHTmrUeN5nwZcdY3Hc1C2L7d
	 zIr3FvOJaIhR4440mR7w0Wc2/OrrWFkPW6SZm/GvzEDB+xwWQzZjMJsuIaMIheotMCQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784295046;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version;
	bh=748VBZ1WtSTxSXdqwWgITZ6x5VOvAQzxF3GUX92Gi/8=;
	b=CxtfeX0oejJdkboPJbE62YTG3TsyYgKT0G1/v+BTM0eUXNARLMNoCYlCeI7r+9IVcCFd
	 0FIYPu107O+bDnawCmg6uu8bpQAhmXpYE3EdJf2fOBZ87X9744G/qDE3+hsNzphp9KqKm
	 In0DvHPF0lNdmDvuu/clJfZF7bFZCGqYx00ovM47kyMf60msMaCP6VDkKlQMf4eQkl/7N
	 7ZQg/SWQSvv40MfOjawKJylVMgbXJguLdR4w7CdCVpDT4VXAMlR9s5PCXtJZszyKt0BAG
	 WoJigib4RDwH5aC5NVrVzaTd+fLHYbO2mo6UyGQCfqiqZZRpS2IxAo86++4eB1DlHEg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=Bpng+HjM;
	dkim=pass header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=I2rWi+Iz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.168
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5D00FF8025A
	for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2026 15:30:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5D00FF8025A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=Bpng+HjM;
	dkim=pass (1024-bit key,
 unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=I2rWi+Iz
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66H5xXdd2690923;
	Fri, 17 Jul 2026 08:30:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=RIltoB5EhAI2PZhifJinAGv5Shybh10sS7s07DgQphw=; b=
	Bpng+HjM2bCfMTJPXCLbuRnWDHhvoY71j8/P1zJG0lXvOJSXSxouRwzbew5GfgcW
	5gcpulSPiOjoEP/DzREZclkEc8/NTVUU7uzNmCVOwZL6AwNH8l6IrxRfteN2PKZB
	kNFWEoBODt5naYyqeWZREQFS0YjqmBbEAMIHljBpWMU2IaP/l3I1Ir21hNTK+EPp
	iNlJXpZDNNK52LNUjcxFNtGkfztit8paCt4TXzTaXLXaHz/XJHPyNYudEoZXeKvj
	dvWJzZ7r9uvuI0+uF1EEj5mEq1bQAOlCrjqLpR1a521JCKANtw3oMvG4eX1dsK1Y
	5xr5+cBv1mCZI9YfvpJWRg==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021135.outbound.protection.outlook.com [40.107.208.135])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4ff3tt129r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 08:30:42 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gUTESnfBEFqWfKpO7Fre8ls+r/GzIlgNqq3AEclIi7zA0AlH+CBZSho423JeUMBG8vQiH0o1xsYEmjr/SM1gNN6ypHvQNIkGimyqbqYKqiYsLCbUCOPZPSpAaB6ibP2vBwkuBLis3ZohS9uojATCPtce8vnNpnZ8/RIWEMwTHQ3YS6cHWWL5ywvf0XHdW4Gm7/reX87ScMmyGb4nlDwigltbfBeOts8uNEBvlNWsiHV0NFKVfvEhQQH2g/oFms1aT4TXxkIlKGkXnjawmpR9SbibU6DNyhZ5zISJBVF+PQsqU1Vz1WLuSCLe8U1qk9s9vGH7N/NtHfQ7YClCtbfWSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIltoB5EhAI2PZhifJinAGv5Shybh10sS7s07DgQphw=;
 b=CFks8xND6ovaGULTMTugUyYUgc70gskYbrn6iNNQ45Ut0LxddQw3HpxRRWyz1C1ERr7sj0ne2HTNtssjQU7LwBmXya1EOFYdZT/wk3GoHaHUHpYT9AArCfQP/SGQnMgsXf3+G6KX8sg+OBangREixB03c+hI9sAWO2oMjoZnlZFtb4Rgzu01oQZfCgIvSQORgjC7NlMd1NSo2yhEjH/n0DFMW/et7kQ+B2AReot7KVUyphM9xdCKOK055N1Y1LaaZ6AsWCZbXaLD/VAVySjmRE8EzNvZyS/fE5jJxYBAdMV6juY0Once1Eoq43EnqoVETVzl8Wxmx21jKygg5HaJDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIltoB5EhAI2PZhifJinAGv5Shybh10sS7s07DgQphw=;
 b=I2rWi+Izqsl8AtLhOam422hWdmiu8bmvSnotgZccsOTdDVPvzLDjAAJOz9ovpX7gYP2T3tXyA1y4f1qVeLfrQlCmMwsfJGRZLDmlHgNArKf2Pp65iEDFVHfPvKqN65r2vwP2UcplN7rdyycv6WgLVoYHC3+3LOQM3pL/UD2l7UY=
Received: from IA4P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:559::16)
 by DS7PR19MB4504.namprd19.prod.outlook.com (2603:10b6:5:2cf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 13:30:39 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:208:559:cafe::21) by IA4P221CA0001.outlook.office365.com
 (2603:10b6:208:559::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 13:30:38 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Fri, 17 Jul 2026 13:30:37 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com
 [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 188B6406541;
	Fri, 17 Jul 2026 13:30:36 +0000 (UTC)
Received: from LONNCK4V044 (LONNCK4V044.ad.cirrus.com [198.61.68.151])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id E23D6820244;
	Fri, 17 Jul 2026 13:30:35 +0000 (UTC)
From: "Stefan Binding \(Opensource\)" <sbinding@opensource.cirrus.com>
To: "'Adam Powell'" <apowell41@gmail.com>, <alsa-devel@alsa-project.org>
Cc: <tiwai@suse.com>, <patches@opensource.cirrus.com>
References: 
 <CAO7fKs0Siwg1EmWjCUvaDDsR1V6E=rhT5WiCSMf8q8r0B-LBAQ@mail.gmail.com>
In-Reply-To: 
 <CAO7fKs0Siwg1EmWjCUvaDDsR1V6E=rhT5WiCSMf8q8r0B-LBAQ@mail.gmail.com>
Subject: RE: [PATCH] ALSA: hda/cs35l41: Support ASUS Zenbook 14 UM3405GA
Date: Fri, 17 Jul 2026 14:30:35 +0100
Message-ID: <002601dd15f0$7334d700$599e8500$@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQGFSxQCViBYGtDclj309sVCGPQmVrchSdhw
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|DS7PR19MB4504:EE_
X-MS-Office365-Filtering-Correlation-Id: 55332d20-b23a-4a6c-5a1a-08dee407969d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|61400799027|23010399003|82310400026|376014|36860700016|10067099003|11063799006|56012099006|6133799003|18002099003|22082099003|16102099003;
X-Microsoft-Antispam-Message-Info: 
	K6UKORkO66Plu79EKhJkccOiVSlffbokBqknmoZjZAFfIO88SVe0PY6vJZaIzpFNwYWfV+Mt9RgGEHffPI/0kega6B6RIrjoB9101Ed/EDrx9NgWUmOsKF7PlbNC0BhxR1XaAk3uZIx6SgeEIZCx2T7qkOt0o94tF2tHYWuUlbFQ7Sm8ZcNNJl9a8sZ24+Kdkk2xGKsRCSTw4b9zRGeTjtQFs5zw4eR0IOqLXfQaDxwAkKnfe5gS98mX/XKKsg9OaBK7ubmk2plyIqE/8Fsxc1ohtvg8j6XzPHgwmuFrx15ShpnpnI54/YsNss2w4ncYiwAH18e38idpy3h+o5J/EKu8ubjxc0dWE2XaevDbYWKezKQvzoYdzaNgsurDok45rpPKQ+QSWvDws5Bd6E5lryKWlLZ9w8gTo5DuyxMv9pBfCDTVuqBm7FwxLgUQ1s/zLQJJ1YrtHdaMxIivY+qsVqvD8LdnA+qHQO37//ALfLUpur+lNJakBtdgK2q/W1tLbOZKqlCEhfP+av1yAENZOdYUJ3PUQjsmoZJI76h3OrHZ6qUXakroltkVQ2ZHYkUqBmBPtMvtclNWp8nXIQzFJetoqxN7a1dBcbRTnqRC2M9dpqshXsl06sz5uxmOnOFwW3E8S+vn5sN5ddPzwvQ7MA==
X-Forefront-Antispam-Report: 
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(23010399003)(82310400026)(376014)(36860700016)(10067099003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(16102099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	7MXAuqfLXftxiKb6cuhlI7X9RPOeq3DNMZPyE0vCEOg8mM/u+Y7nnbVQ9rIzdkHTmc4vlB5TzVvPTsj70UOcZjS2yYSCN7KmUQSr+3MnjAVB/GReanSoB5cTqQ+J1+ot3ZFvtGlAXagRMwEnGN5kfMYTAYVlzhu87V5kiHdZ2g2sa9TeEzeE72+52+enyz65plGoVcbeSePNGtpZE6Gbnc96YvBaz9JDdX5pxZxgs4eYSQdkKPio6KL9MG6/fCPmbmknEiw/oLLviYdafZcADNnTVjbWy26Iw88z0qzAtrODVpbxFAu3qKwK3CGmx9aOgkLggvjoBNR/YZela96VZvSkBer1j7qhJHEC4TMuaz36NGlEPZgmie+fUyG+72UxzTFWFg2m6wZQRYQDM4Bpz48O6fj0VKxX16nPuehdc28wQMKfW1a5HHwaYKf6Ka5D
X-Exchange-RoutingPolicyChecked: 
	nog5tVDYbhN4zccVPFTI03CZLmlODeawJ/aWsU0po4m5Vcf6OAjqRuIoJw5AtqLysB14Jhn3TiPEc2IWZS+QjT5DgB0d7n8q7Eib9xliMzJSEHk5ceOWYLJWDv1EZ8OsshuRSt8QKdC4lvfGtfjC5O5AJFCeDMVTOfs3LgI45XTzQTQNVfmC8YsyMrGjWJyLSgUW5SAJIUuuSXRDzyiOO4RP5qYM+ChhhBaG2D9tFE2bK1AW+Ifzl43MYhhgMNyhkXdL1GbcYPSsu0QI33mCKl/fDOKsU2SHaoke26h9ZQ101kDiIbJiv28gFcWDWnQeCLfvDCb0GcTT8TyurOMpsA==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:30:37.3930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 55332d20-b23a-4a6c-5a1a-08dee407969d
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: 
 TreatMessagesAsInternal-BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB4504
X-Proofpoint-GUID: WU3EtMgQBZ7nw5nPh3kWgNFaCIrWH5y4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEzNyBTYWx0ZWRfX1eSL0VigpcNT
 WQoK0Dt5em8zJjmkrEbs37121Bb8z+q6+6ZdSPVc/dnygT+BRpYC+73eIlL76MJExGAjbZK1VuD
 mmmPH0IiDYUTBLvWD7tPo3OnUMzoYM2iVYcuqf+n0nIlTXTuspUsunpoenoaF5K7OCKDRHLyaKJ
 aVKGHoMSe1heiMjL5wh0UwogtARsXTIqzdfS0rxIf3tyr0fJwsVNRxxRc/RWPmV7LbE+N0YrToE
 dzMWdIFTkevLZiEZwpSMa253CeYbDcUg7ZI7NP48/WM/hwS8vUndiAp+MVtkSrLWhdvZ3T4Ppgj
 37SnLUMf5WSX8MBBIGdvtzXSrfZRGRwhAyi/lysBw4zgjkLEdYXuSJMiae3XyfobbH37SZvMD45
 clTFk5732rrg7HBhYBYacVuQPHmYJEho0DVxNMY11ec8KnXSsTgkXE4mgHtl8YOHlIvysThNSO+
 Uj+X3HpDWEWpVU26f9g==
X-Authority-Analysis: v=2.4 cv=e4Q2j6p/ c=1 sm=1 tr=0 ts=6a5a2e82 cx=c_pps
 a=49tiPNKudA41XY8u0CHlaQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=VwQbUJbxAAAA:8 a=w1d2syhTAAAA:8 a=pGLkceISAAAA:8 a=foHCeV_ZAAAA:8
 a=iox4zFpeAAAA:8 a=jMd3T52AF3Cnbd9lt8kA:9 a=QEXdDO2ut3YA:10
 a=h8a9FgHX5U4dIE3jaWyr:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEzNyBTYWx0ZWRfXwCaFhcuSyN4k
 jXx1F6fJjryIAkAx4z4OFiTrnIny4y9ihx5K/T79hxQLdSadRexz3Qbu3gQVzVIEqiTq+hij8Cx
 SfNxgVfBqF/so7SA52FxGG+8Mi+ftTg=
X-Proofpoint-ORIG-GUID: WU3EtMgQBZ7nw5nPh3kWgNFaCIrWH5y4
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: CDEEZ4WU5HLMTXI24WLSTRUZSNOAKFIV
X-Message-ID-Hash: CDEEZ4WU5HLMTXI24WLSTRUZSNOAKFIV
X-MailFrom: prvs=865814d0af=sbinding@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CDEEZ4WU5HLMTXI24WLSTRUZSNOAKFIV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

I think the Fixup needed in alc269.c for this laptop is missing, and I'd =
also like to understand what the issue with the ACPI is.

Please create a bugzilla ticket at the below address and CC Cirrus =
Patches (patches@opensource.cirrus.com) to it, we will investigate the =
issue as soon as we can.

https://bugzilla.kernel.org/

Please attach an acpi dump and dmesg of the issue to the ticket.

Creating a public Bugzilla allows others with the same laptop to find =
relevant information pertaining to this issue.

Thanks,

Stefan

> -----Original Message-----
> From: Adam Powell <apowell41@gmail.com>
> Sent: Thursday, July 16, 2026 11:20 PM
> To: alsa-devel@alsa-project.org
> Cc: sbinding@opensource.cirrus.com; tiwai@suse.com
> Subject: [PATCH] ALSA: hda/cs35l41: Support ASUS Zenbook 14 UM3405GA
>=20
> ALSA: hda/cs35l41: Support ASUS Zenbook 14 UM3405GA
>=20
> Add SSID 104319F4 to the config table for the ASUS Zenbook 14 UM3405GA
> (AMD Ryzen AI variant). This board uses two CS35L41 amplifiers over =
I2C with
> external boost, matching the same reference design as the
> UM3402YA/UM3402YAR (10431E12/10431683).
>=20
> Verified: with this entry, both amplifiers bind correctly, read ACPI =
DSD
> properties, and respond over I2C (Revision: B2 on both).
> Model-specific DSP tuning/calibration firmware for this SSID is not =
yet
> available in linux-firmware; playback has not yet been verified =
end-to-end
> pending that firmware.
>=20
> Signed-off-by: Adam Powell <apowell41@gmail.com>
> ---
>  sound/hda/codecs/side-codecs/cs35l41_hda_property.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
> b/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
> index 416d7bf3e..ec288c4eb 100644
> --- a/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
> +++ b/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
> @@ -98,6 +98,7 @@ static const struct cs35l41_config
> cs35l41_config_table[] =3D {
>   { "10431573", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, =
2, 0,
> 1000, 4500, 24 },
>   { "10431663", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, =
-1, 0,
> 1000, 4500, 24 },
>   { "10431683", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, =
1, -1,
> 0, 0, 0 },
> + { "104319F4", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0,
> 1, -1, 0, 0, 0 },
>   { "104316A3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, =
2, 0,
> 0, 0, 0 },
>   { "104316D3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, =
2, 0,
> 0, 0, 0 },
>   { "104316F3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, =
2, 0,
> 0, 0, 0 }, @@ -530,6 +531,7 @@ static const struct cs35l41_prop_model
> cs35l41_prop_model_table[] =3D {
>   { "CSC3551", "104317F3", generic_dsd_config },
>   { "CSC3551", "10431863", generic_dsd_config },
>   { "CSC3551", "104318D3", generic_dsd_config },
> + { "CSC3551", "104319F4", generic_dsd_config },
>   { "CSC3551", "10431A63", missing_speaker_id_gpio2 },
>   { "CSC3551", "10431A83", generic_dsd_config },
>   { "CSC3551", "10431B93", generic_dsd_config },
> --
> 2.55.0

