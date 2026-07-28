Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D81C54F51
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Jul 2026 14:01:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A4A8E60201;
	Tue, 28 Jul 2026 16:01:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A4A8E60201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785247300;
	bh=WeiXmQ3jDUIhBsL86NprLTy24yeSlUgfuVe/7qhvgSk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=gdIGj33jt8xSBoA94NI2nhi37JVkoHcn3pVGbtq1YF0ofFsHsJLdMDVPpid4+mYFL
	 1o3WnqSOnggHtXuiZuNI8dWMRUpGOijk52xD3E0fm5UQl8g4qXqmbjCUwlmDY2RTkD
	 /L6vYyL862ggBC9s2l/UXUJMuEv6kNSHsHdZxCLU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CAB4EF80601; Tue, 28 Jul 2026 16:01:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D4F68F805EE;
	Tue, 28 Jul 2026 16:01:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4252CF80526; Tue, 28 Jul 2026 16:00:59 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.168
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1785247255;
	b=SIOgknrQDr9Tdr2+6GG5LI2IWtOOwMsxynh1zu/6EWAJkGyIodsKqynRkXEpHW+wIkvs
	 FneQYq/BIi7nttrGlqQfZ2Zbueygnrb42/SmB2tUUulVyXkahSNMtGaUHQPyFYQknr6af
	 /J7CTyO3rx2tiCUGjRlwxdYZSLftlhUaaxtPlDfjZItnRKTE9cn3nO0VwIhm3y4JzGmxc
	 6TSe/uxrXnBIqK4NfOKVum33SpV5xgGyxgFcfD9nzPPIwXyAKnB3Cj1YEwg9D4hOpJk4a
	 GzXQZ3LEpZr8dLsWdFl+ikvHz35RO/roJktY969VS8Mt/yXlN97coHOiJJ6vRnYTVYA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785247255;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:
	 To:From;
	bh=WeiXmQ3jDUIhBsL86NprLTy24yeSlUgfuVe/7qhvgSk=;
	b=aPBMNhWAAwu4oPk2qyYl1voNOvXEBRh+lk8/w3rIybsBKyedXlrM3t95BSigqZ6NsIZl
	 JpxDpsR3n3kIg5mgCQfK+xg5XXo9maP58uw191AkQzzcE0GnOLHizUjRm5RD+dcIN5izN
	 eppgy9GI1rPGaA4zaN2LOf3nW9leCjhp2nSKbYHX+aT4eKToI3qBV7kEVbadJUDbWcczK
	 5XxhuE9YtU1NT8+Y19UcwzIGTHL8UoF4P1Ug1LGx0MWKIxOHoXjDXDUWUePiXOd1T0/xr
	 XkADakbnvpxrkzHlxz6YIS5Zpq2rSQROK228FfcWKbT0iLK2Ln2465AmxbvlTH+sU0A==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=FqREAVl4;
	dkim=pass header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=NseTzE0w;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.168
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CC817F801F7
	for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2026 16:00:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CC817F801F7
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=FqREAVl4;
	dkim=pass (1024-bit key,
 unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=NseTzE0w
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66SCWSCR680728;
	Tue, 28 Jul 2026 09:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=xbllLxOC9CtMNeryP6zgkjoyc5/RCKjEcxAdB7v1xQU=; b=
	FqREAVl4EBB0qX/q9QP/HC62DY1mGWaQ5en4KDMzTGbQ8Tir4kdm2+134EH0fG4e
	tbUmCJiWqiRGDlSORoX21E79mRFFI6cqcC8lgUKShRJURxNeQ3iHBu2iZ9BUQlTb
	gXfmYpY75Mjba4VVSRjq8HdNAwoqDs0RvUbS+q5l4EfFbcyZC/OySNXSmJCpVXWV
	NtIc8sRNy0Nb0XVa9dvq+9ON4LJ+aJ+F9MDwmIVEr+nVli/LNbf/MVcKzDS4hhwa
	tY+QxU0B7AWrSU4xw2f552uZBbY42hICjl4sYhOFou/yMukmHcTUfPDHBsaQDMDU
	TXt1DtKCUpYNbmzHdNVd7Q==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11022143.outbound.protection.outlook.com [40.107.209.143])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4fmsjg3wjc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 09:00:48 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PbX1pjIjErnU5Vl6gsXISEoL94m4Cuwj94fhOE29C21MmDgyapvaMrPVc5Sa1VBKNhBgGwWjPi+utOKotp2jYPUrQcIeZNAa+LtO2MoZTRUjWFXWT900mOuH4h4lh6Y/PQcCPU8H0FFqp6wxSegaCoVrpcffVykb3ZkckGdNxbyztua0sB6kTm0TDeR9ACZFguD+9GU/Iz3Vj3uDh6Ba4oqXvNZIiylpKCNwOkKV0QneNx1w4/W4Dul5Rt//8eh1nrBQoeRb0AN69LCVqZwwrSnOVVP5/QD9caHzV3ZQn8UxTa8qXbr+h4lMGWL0Q37Ut0XY27PdhwIC+19GT0zgjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbllLxOC9CtMNeryP6zgkjoyc5/RCKjEcxAdB7v1xQU=;
 b=orntzDajxwICoAH1JDYXW19Jm8eUQff9px+AGgzXS0H22TgXLWkk7nRowBrBrvVHTDJ4FMSXWHP6Q1WPOw6f8c6HAwWldMog5qKB7vY8RECfoO2REsX9ChBrt4GSYSNcGSslgIuguEjds54HcjDKnjb4nC9cy2XUFrbqWkIS+G7As/zNsLgr1rBYAoiAFVRNFRPTNqu9+eBl1AFv9Rn4KfD8wF5ulGodY13BzimWl324F20Baa4lJ0Laqi5JQiYY9VhYXO2/EiO0H6FnH/uvYLuSLDAq/wM6pqoLaoWcsNbJdqXI7FDLpWuMlUNaoIs/AOqIR/XOPYOzHQy4++03KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbllLxOC9CtMNeryP6zgkjoyc5/RCKjEcxAdB7v1xQU=;
 b=NseTzE0wdjRRvq2pZeIemmBjRAgNlC03/3d3ISQ7c959Z5XQZfbULztWbRiT7eFTj0ULxUGYvZsTHFPGF0H0PS99l8hKH4Hzz2xFmkTj4XNKJ2fZSWZLepdiQ5CDzDUvw+IoQtkWExm7qRTAybhMRaP+eAdQwaKPrcN90T6q3EE=
Received: from CH0PR03CA0448.namprd03.prod.outlook.com (2603:10b6:610:10e::11)
 by BY5PR19MB3987.namprd19.prod.outlook.com (2603:10b6:a03:22a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 14:00:34 +0000
Received: from DM2PEPF00003FC8.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::1e) by CH0PR03CA0448.outlook.office365.com
 (2603:10b6:610:10e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend
 Transport; Tue, 28 Jul 2026 14:00:34 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 DM2PEPF00003FC8.mail.protection.outlook.com (10.167.23.26) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5
 via Frontend Transport; Tue, 28 Jul 2026 14:00:32 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com
 [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 48CA1406541;
	Tue, 28 Jul 2026 14:00:31 +0000 (UTC)
Received: from [198.90.208.11] (ediswws06.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 34ADA82024C;
	Tue, 28 Jul 2026 14:00:31 +0000 (UTC)
Message-ID: <7a7e609e-574e-482b-9eb3-816cdda0795a@opensource.cirrus.com>
Date: Tue, 28 Jul 2026 15:00:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] ALC285 + CS35L56 (ASUS ROG Zephyrus G14 2025, GA403WR, SSID
 1043:1024), no speaker output despite correct routing, gain, and DSP state
To: Aditya Sharma <aditya122sharma@gmail.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de
References: 
 <CAEF4ZLNsnnATjgGAFYim3t-0qn=LHx=LeEid-jQULEDvN4aQYg@mail.gmail.com>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: 
 <CAEF4ZLNsnnATjgGAFYim3t-0qn=LHx=LeEid-jQULEDvN4aQYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC8:EE_|BY5PR19MB3987:EE_
X-MS-Office365-Filtering-Correlation-Id: e0d5e13d-c3e8-43b4-75f0-08deecb0975c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|23010399003|376014|61400799027|82310400026|11063799006|56012099006|10067099003|18002099003|16102099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	6QvZtb+CIK3wyb5PWI240m4MWXe4r4QN4LwwCJ4JavZT6FJrK69qgONj2qwQToCAWde87JDt0mJ/QBU8volZnKoPZc6jJ24aLQngmgh/d4wqWeE4OrxJEWCsPnOl6EJGsEpBxe5R6dqCnkMAKWU40e9fJppvMmPWjBpaNQ9y7oG84ihGVPgba6S6XcyzAvz5ftfOMoB4fDF2DADipBFNCn0eBhl1aaZWaORX/ilSPGdhz0aKl3vAaxWcerEEMUPCgWSB297hWt2ckTuSFPtNPJkOCGgViREaCF7K5Ip2cVDqWKfnacdq7MpnGsqP+HB26hnOKeY6f8wUBAp84bex0vsTIlsSbb5SQmLoLYFMSEb0ypKisg9dbv2c+Al7YPnmHJWBILFeCwggUQDJ51E6/dsPu++1RJeqv/xkU7pf4NjWBN1ORaBRWAwc/DAwRETB9a3pWHOK06ns/1J8FplB9wSst5ZyCKw6rVyCvDKZJEDZU1hsrCBAIlnP1230Ex6NNs3NnNtwqDNVCU5s2+7YuOnUNi2smWsHOYBdtN4dwY3CW1AFKY74W9mNWhUWatjILBLs4d+dQgjYKzog+EK5Fakt3UPRN8pRIIVdAPGdvL6HE56fOdDuzGK1VhF9qgKh39H7vklRS+nXtoMnm9eYk8rVfF8nUO83vb3YA3xpK6n4hiq0mCSpNufIV0BQBWICKeExlcH5cIBscfNbSp38Fg==
X-Forefront-Antispam-Report: 
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(61400799027)(82310400026)(11063799006)(56012099006)(10067099003)(18002099003)(16102099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	uuYbtUy4e0FTDcyJOCThy7WAEPzTSEwSmiHO0QMLrwJfnTzn8+g0U3WnVY3gLRMmo1VBgVSLdcCLO5MBxc1e23QB3aHRF9CeSgKpOkb/ssRyeUh4mwt1frxHKWWh8+0JI0ZNZ/z7jCChzf7VzjUW/ZZ8fB7/aXHX7eNt+Cou1KK+r9hdvn1WmiV8QsMiWKiMRKbOHUlwbXgLaurQWEy0c2TSNj3KS8/H5q2dTw0xSfbtrLuMX2ksGXfgTcK/PpL9ai7FG3UcouOg5Srq/BJxdtxZXQXgm74KLJguTEmFeBPR5sNQ7yd5ytu3zdF6CGa53twlKbtImSCvBoCcGyEPnaPPgj9eJ+TK48W21drhQqEQId1p8tbM2oJPKPFRSYdLlKLRloCHzg5I812yz+COxnkDAETAhGXNjxYh2JWTUZSvEtMMS5MisAUKB6HV0U/L
X-Exchange-RoutingPolicyChecked: 
	sL1nX1jvzxZ9Vut+FxTcvagJT5vsL4tWvcG5b1HtJMlsGJmI886OUBAvkt4vDSkSPny9K52C+Idm2RALwghMW/8pFt5coYTNwywbc5giRtcK2Uxr2u+EKJWe9JNpel5yE4mxu9mjE0121mNHFOIyO5RW51dOCetxPvykKONFZ4SOj5RjeGqdeJ6EZ14pVfr9IAqWUQWGY14DUdJGap1RMnFphjQ80vIEPvfTEA5lHsb5BVxheG+k3fn5i5zune314D8Be3Ba2WT/Ve+XcSpShXNJGRUXXFSxsv5O572wNmaF7CmLHYoHhWg/bBHbihPuha8QsTYZSMbVTVMXj0TyPQ==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 14:00:32.7702
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e0d5e13d-c3e8-43b4-75f0-08deecb0975c
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: 
 TreatMessagesAsInternal-DM2PEPF00003FC8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB3987
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDEyNCBTYWx0ZWRfXzfpJbsUmTEhU
 WGdSfc58aJ4u2dUZ7CaBrocn+3DeaHMHEgQRFxLnb07PMuMlQgPoy9Mvm7OEUV2wVdYI2tQ8HEo
 gUJ0eiFjuUyKaYzt4abIoofNdkPJhF8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDEyNCBTYWx0ZWRfX86YZzFLPZmbK
 Rd9y+QEB5/Pe3gsvFJhkfZmRZwv+qdC/michNDfZpoGm8wqKJH5V5ymnUj9yqqHMwg9PcpQMylh
 kDMuTH3q7NaD4tc3g0jt0uFaTlNtITmRKjUKUWQvYyI9JQz+7i1BvcQf9I5OuP8kb3ibEwFlUSZ
 XY6aVLbRqvwDZnTnTlSPdY8CQykbwBVJeVFoT4WPKCHZu+RxZkGcEzR1yqsL8heuSg0+8aVlSDz
 efUSNH7hF5RkiKKHmlOaSC+0Uqgw94tXCAqhRDyifFslYy9MgsjxQgWt3nUvrGMzCTdQ54T4a5L
 uS9hnkWj6S+5e1hCZvYT7d7xg22ShTpQ/aJUEI3/9tnn9eKFJtzkJPpHS7gxoAHAybW/57BOi5+
 d5CCwjVF63XvJrROqWfRh+kjSi9Go+lOplgHO0/VZerXG3oI/l20nxnvSf+ALXRGRZvfNGMy2st
 B7hC79elYrKzAQeGYbg==
X-Proofpoint-GUID: STs87fU3qBScUoeYKvF_PPLhmFO9Taxc
X-Proofpoint-ORIG-GUID: STs87fU3qBScUoeYKvF_PPLhmFO9Taxc
X-Authority-Analysis: v=2.4 cv=XLwAjwhE c=1 sm=1 tr=0 ts=6a68b612 cx=c_pps
 a=btghaJn+yvodkV72VlSluQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=MEZ8rWnTcSKzUFmcpS8A:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: WNHQYJLCVN7E6PQDLFH33IGAMRDJGFB3
X-Message-ID-Hash: WNHQYJLCVN7E6PQDLFH33IGAMRDJGFB3
X-MailFrom: prvs=96693516e0=rf@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WNHQYJLCVN7E6PQDLFH33IGAMRDJGFB3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 28/07/2026 1:57 pm, Aditya Sharma wrote:
> Hi,
> 
> I'm seeing complete silence from the built-in speakers on an ASUS ROG
> Zephyrus G14 2025 (GA403WR), despite every layer of the audio signal chain
> checking out correct on inspection. Headphones work perfectly. The same
> physical hardware produces normal speaker output under Windows (dual-boot),
> which rules out a hardware fault.

If you have "Fast Startup" enabled in Windows, try disabling that. It's
known to cause problems when dual-booting with Linux.
