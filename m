Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27DDC56208
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Aug 2026 13:39:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D770060242;
	Thu,  6 Aug 2026 15:39:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D770060242
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786023575;
	bh=2I44bCQmoYiQKM39tIyJZ9ATAY2m9r9rS9cFdse4Jn8=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=VSCyYQ61KxhxL2Sr+1ABjqtOVL/7PStS1QgEGCtx3gF/kTs8Tl8ZqbUjcI1uBlMMU
	 tL70fQkmup9huZeJqDaHJIGaCT++/jQz67pHkDc7P3AXio/EKDxvRXpAxIJew1DCGk
	 gGs412xRys6DVWWHqvTElVt/hpNZ3Z3ghGE+99ps=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EEABAF805C1; Thu,  6 Aug 2026 15:39:01 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 55E0EF805FD;
	Thu,  6 Aug 2026 15:39:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0D07CF8055A; Thu,  6 Aug 2026 15:38:56 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.168
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1786023531;
	b=ZCrvsCWtNV2pyIqG++yWfYktgzT0mGQb2bFUID2GobLYbuf/sLH5KCDe0SqtKHURJTBB
	 GKFs9joC9w+97S3/zIbwPvUKo21tC8vA9mZn6jIYQ7vrrBgUGVlzilp+jixktCTrQd6us
	 ABNNzDk7MCkHcGzdn9+F4hJYl48XLMPo0kqwSu7HWIm9vgRfSnoig8J8yP8bATLZ8BlJL
	 r6mwPkrH0tbrS65BQX5mx5YMdKM6I4iDB7aq9rxcRC3m12Ib3OSGNFsv34OSHJ5TVF2KI
	 4gJbBW+shUSMrZk5kOAOhYzQ2939RyLxQNGzKXgq3NLwW08dm6telwOTZcSFEQ+vB5Q==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786023531;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version;
	bh=2I44bCQmoYiQKM39tIyJZ9ATAY2m9r9rS9cFdse4Jn8=;
	b=DPBfG2sKJi1gcrhiyfEgsjoOukEUpaRfNC6ghkv1ZXH///Yqzl99FFVTShD9L8gOuqDQ
	 W5qx4uBl6eOHUpnlJLc6z5846DBK9bc27W77zTCliuhMKk7jcAWvCsZ6d59fAVGx6isu3
	 ii9jp0/3WoY9Kg+2mn4DhRrMLH8seaEmu3ZzIvkuG6FdyEoJSbnxZ8cwMRXAWie0q5pwJ
	 ipHslAy+cpVJXZOHri8wwWdy51ppFQpEUtZ9Y5vOepWiLm+KzIu8gc0NFDvYuWKpx0v30
	 4RcK/wtKKT98Wmx+w59MVswUd5WD79kswEoejScaMOLpmSyE8BQ46yEd6q7MdsncETA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=ZYy5es6V;
	dkim=pass header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=pk4deTEg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.168
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 85DEFF800BA
	for <alsa-devel@alsa-project.org>; Thu,  6 Aug 2026 15:38:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 85DEFF800BA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=ZYy5es6V;
	dkim=pass (1024-bit key,
 unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=pk4deTEg
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 676CEm6H1550846;
	Thu, 6 Aug 2026 08:38:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=CD+o9X2ZolBY+hrVtFv12gcfYNsVTCTymY2hU0Uxx3w=; b=
	ZYy5es6VU7bs1+HfyUWbE3jje7tZAlYh3umECJ9+KHuaEIRaM0M9HYHWv4AGY5Kz
	vSNWdivqMwr537rnovdF+C8CcBj167BhphDIdQ5IldipiNI5+ucZgbYFMTY8Lbkx
	Uq1SR6mLagJK5eHdM9H0Az9/SCUFSopNAzPZTDcSn3R/y4BpWbcLmMf8bpwxJKQd
	zWDwImkInbCvLvJbNPWfmwZaqZbqA4kSjIqEfAAfYSGsNi2Ivf/Vqf1bKDaHc5z3
	SK5tOu3syKBH6J7yq6CW6/gc+mn6G+yslaWcpnXRNzqsd8Pj3x09JH0aPa7cutYv
	o8YzxmVc9ynz/oFjm7wd8Q==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020075.outbound.protection.outlook.com
 [52.101.193.75])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4fv9s4hp3c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 08:38:48 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hP/WJvrOK1U+y1wMKaiQevP9yrGGb49WOGmOwSbmpNL2jPWufVMmDAMB31ogXkYo2NeIeiRhZLEyO80iIuFvJuYiGz05dDrmtvZgBFM6ipeN8B5cF7jOUICrDVyC/WbnVSdFEtR2VMPU6lkt+X1F+Oq2T4Rpz8QMifPBtdG5NxficwWRaLnOGQ9iYSvb+t9BdzidfhcBawymJT+gGfasu1iOUb1QaYLWNafVv0m131LB2lybGHufeT+Dp09ipmmKFtra6CrfBZCychgucbER33BirJS4umxCEOkySRdHXX9cBq4939Ux/OMrJIVWKB0yVvT2aLiE1zIC1AcDMuxDlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CD+o9X2ZolBY+hrVtFv12gcfYNsVTCTymY2hU0Uxx3w=;
 b=BlhfMqINEaOOOyQI7uamVRKpWngk+d2XYJPzjvwhL09DCBB/c4NUY4AYUghhB0fnMQn2nuJkxY23cY67KGAXFt4DqUvhNXCResJWpkK3pynuMbizWz7Mdu8MgH8QRnOTKu0hXrBDhkiIr+63G22eW/HbCp1xrBEMa5FZWmlsp89Dl2vTSIzEbpwOjPu0NO4kj/kFFAba5xmTd4qYpaZcK2as6Rt45uVmYuTMsD6v+uzjFIr2BXGP+JRoUEswtPvJWRfw1SsIuQOVbMt4fHamdKvSfW2HrTi9hcW/ayXXLJXmuXk+yzWeWUS2Nd+lg4XLYLG2wuOzyw6NT35k8ndqnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CD+o9X2ZolBY+hrVtFv12gcfYNsVTCTymY2hU0Uxx3w=;
 b=pk4deTEgGUCUOtXhqIORLRmhH/EDJ5m0bV1DOH1Par9RzqpH4hIqZcFyJyT2avsSHSpxydgiz2BQYUeHiTJ8jVhxoni2jXAgCKV7CkowWiSJxFmbs2+JEFWPvFNFpk/7flFBaC/5isK17LK1R3BeE73RdvF192guh1tesJuwXiA=
Received: from BY5PR03CA0008.namprd03.prod.outlook.com (2603:10b6:a03:1e0::18)
 by CH6PR19MB465148.namprd19.prod.outlook.com (2603:10b6:610:306::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 13:38:43 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::1e) by BY5PR03CA0008.outlook.office365.com
 (2603:10b6:a03:1e0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.21 via Frontend Transport; Thu, 6
 Aug 2026 13:38:43 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.6
 via Frontend Transport; Thu, 6 Aug 2026 13:38:41 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com
 [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 22F2B406544;
	Thu,  6 Aug 2026 13:38:40 +0000 (UTC)
Received: from LONNCK4V044 (LONNCK4V044.ad.cirrus.com [198.61.68.151])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id ED40A82025A;
	Thu,  6 Aug 2026 13:38:39 +0000 (UTC)
From: "Stefan Binding \(Opensource\)" <sbinding@opensource.cirrus.com>
To: "'Takashi Iwai'" <tiwai@suse.de>
Cc: "'Gemayel Lira'" <gemayellira@gmail.com>, <alsa-devel@alsa-project.org>
References: 
 <CAD96ZT+SnRnGr4Xd+NJkkVNpj8XrzL3Ete=pRgz05mqxAzbU2w@mail.gmail.com>
 <87pkzveg4g.wl-tiwai@suse.de>
In-Reply-To: <87pkzveg4g.wl-tiwai@suse.de>
Subject: RE: [PATCH] ALSA: hda/cs35l41: Add DSD property override for ASUS
 UX3405CA
Date: Thu, 6 Aug 2026 14:38:39 +0100
Message-ID: <003401dd25a8$e3f8f4e0$abeadea0$@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQI0JzVTOiqtde3ISIDmPSzuMFxPwwIeELfhtdHSeGA=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|CH6PR19MB465148:EE_
X-MS-Office365-Filtering-Correlation-Id: 002d4d4c-b8e5-4e81-30ec-08def3c00783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|376014|61400799027|13003099007|56012099006|11063799006|10067099003|4143699003|3023799007|16102099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	UjuKoZbYvkVx817xll8y4PpgmfNyZGWZl1zJ6c2FeCjRVi6XM3WgCUioYVuB0i0C/6kRHjgIuxmxjIm4V2f3ZEH8FWNWQwFy07oDpYSq7DhGstTKH5Urnv/n5bG2AdoU6XVLS7aZL5qN76br7qJ24HWzAyJkbalmiVRPkq85XZK0LJOTtO8zV1JhWSQkHu/T5w92c3G68Cy8uUGel6TiHDCjJujTvqI8zkbqg+YD3mAI0sZsOYo72BTNF5N3IAGAeuxLxjog0VD978fSnTa+OAaeDVpFUFDXoog1/D28uQV146G3dfaghbk8T85xEzt3bZuRaj7bgyGbDJUvcASuWUA5XZ/62/mBMdaX0my8GvNado2KXrb7r3Pg8aVWuqKSCxqwB9WK5wT+VqX+3MWMWJXz3QxKR5nPd3b6t1ZNwwMLWOo/lOp2B5F556iu9d71oBrGXVMaKaTCc/FgTqJKb2BdP4OX27Y+0nCVct4WPPg5lkldpKCFD+s8Y6wZeJh+n/VCKzcEzDP3uQ/eKG8cCeUR3QdlmzHAIZUjQ9I6CdstCHQqJNF2wXPlSa8VLTbpoY/ZmC04lwctiW6ttu+jaSVLvWUnoKHmbQtmEhNNpCgPkDhhkYXUySHGwbbU96b0Y9WDR6lMO+vlabNv/3aLu6M1ECz398TJ88MvPUu3TcMHUOR1s6TAxxRlI34oqGT8lmFZwZoKKLM3LzUIhgMiFA==
X-Forefront-Antispam-Report: 
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(61400799027)(13003099007)(56012099006)(11063799006)(10067099003)(4143699003)(3023799007)(16102099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	52QvGcJ/UrDE83AVe1/Cfscl4qNwt/o+p8T03ioQhLGrofefKEuHNrbAbgMRkRgpmGvUuM2SM55fuE2ZlTjTgYrMCbppKWWsdKTKZxkkVh37nfsNwfbIeZ0ls3D2czw4AFPfIH++DCRMwxtm+ZyeZb44FiJ83A6+zB2JkVmhEj0nMZfICZzCj5cyiasxXOGShS7aw64dAQB3AheHCvnFsqOfw3uVWcci0yqKORprbI53ihwMKWSMwVYpNFwbpdt5E4uuX775lU7tTgb+kpyrUeE2XMjbyqq13sOFj2lbnAyNXvFASSDOHAYqE6pIVq2M1AMFEHMt/8/tR0dZr1OSlGiClBHw3WpyIj5O1bcjPJBCd0sC6WPETIk3eobCTpmjCortzDy1Ae1VJriyNnNnkZFQG0rfXSkSmrr3vcRZq3qQwfH/uQocCqnRjkqBz/uw
X-Exchange-RoutingPolicyChecked: 
	nu3ByoK5F7WGKgc01y5wf0tcN7//D5mZyx3/dqPNqCWBc8pXcMbKw2OjV6o3f9FFbYaOLKLIm7q23936BUT3YYAjZsI3nC7QA/1O5MdUU+fYqQBLol2TySlz3HTcHbHONn+WOj629MP3Pveo4vn49EUdnjwoja7Lmi37k8lwOhje7b7b6984Sf2dDnpj6J+//ZhTV7ACdvwSIEWM1ynDtByiBQZubc/e/IFPdyttvfFXsnyAdu3ufZVM9J5OCOtizdhvL08LIacaMuiSMNSuM0jl+rnI5+3jrEPY+bSP8zKhMq5sTlu+VBVMjJnpfBtIM0vEpdYUSpacZWk7CSKMDw==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 13:38:41.5294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 002d4d4c-b8e5-4e81-30ec-08def3c00783
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: 
 TreatMessagesAsInternal-BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH6PR19MB465148
X-Proofpoint-GUID: B5qX-vo0eYauKqamhTXH89swTOgSHrY3
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEwNyBTYWx0ZWRfX+vwKlNvBgXYh
 W5701Oe4DUNZOzE6AnFN0pyVwZGs7UnYRL3HyPBsI1eSS78aIm0/BKBBnUQde67nr6PHuLkB8iO
 7GUgmsaUqcrmZxNgqxde4V8/GcUNBKg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEwNyBTYWx0ZWRfX0dorgopAce19
 PrPgUc/sKI5lrbxisQbrKAb0uOF8N2RM8Fk2YhctLSgIGODKZKDAf9mjXzCnzE7iRIe2+cc+MVo
 Aqprzps3M/cCnW7CyIwr3NVQIndU/rwr/OqQdSud+Lep+nXfIULfUPmKRIJbcQszUMHLt9gM5W6
 +J/x0EnjAFqQHkduwZjuZ6ktcMN5hFEVyZ+hwP3BK868MZtlg7bSq4A5r3u6xxckZRs8vxYblOg
 gJbaW4/q1hYr8l2vwhNeo6XT/txixb+tnCHVU6BAoKxL0I6llN6taFmDTv9J+4KfW9FbzTBz2wb
 foltzH5NE/yqD00F+HBremEvZCfXPVsV00k6jLgfnYl8nDX42S09U9aMUpvUwncY9W5fu+56tcw
 QD3jkPE2TAj3r+yhoD3idx/w+KAEwUR+3pOrqOGS7gRGBoow0xeRgbEW5u/ym7D+n8OtrYwvgQm
 tPl2LaGj4VninoHTsXQ==
X-Proofpoint-ORIG-GUID: B5qX-vo0eYauKqamhTXH89swTOgSHrY3
X-Authority-Analysis: v=2.4 cv=G5cs1dk5 c=1 sm=1 tr=0 ts=6a748e68 cx=c_pps
 a=dTGz0tuhMYfsSU3NwIzouA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=NEAV23lmAAAA:8 a=w1d2syhTAAAA:8 a=pGLkceISAAAA:8 a=foHCeV_ZAAAA:8
 a=VwQbUJbxAAAA:8 a=9GVN7SviHOdzNpnSBpsA:9 a=CjuIK1q_8ugA:10
 a=h8a9FgHX5U4dIE3jaWyr:22
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: WON4UTFRTPZ4MYHY6NVTJUYTGUGYNFTP
X-Message-ID-Hash: WON4UTFRTPZ4MYHY6NVTJUYTGUGYNFTP
X-MailFrom: prvs=96780f502a=sbinding@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WON4UTFRTPZ4MYHY6NVTJUYTGUGYNFTP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Takashi,

Unfortunately, this does not look like an ACPI issue.
This laptop is an external boost laptop, but this patch is changing the
properties to redefine it as internal boost.
This could cause issues with the amplifiers.

It looks like speaker protection is kicking in after 1s, but I don't know
why.
I recommend the OP create a BugZilla so we can investigate this separately.
I also recommend we do not take this patch, as it might damage this laptop.

Thanks,
Stefan

> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Thursday, August 6, 2026 10:46 AM
> To: sbinding@opensource.cirrus.com
> Cc: Gemayel Lira <gemayellira@gmail.com>; alsa-devel@alsa-project.org
> Subject: Re: [PATCH] ALSA: hda/cs35l41: Add DSD property override for ASUS
> UX3405CA
> 
> On Sun, 02 Aug 2026 01:00:22 +0200,
> Gemayel Lira wrote:
> >
> >
> > The ASUS Zenbook 14 UX3405CA (SSID 1043:1A63) has internal CS35L41
> > amplifiers, but was using the missing_speaker_id_gpio2 fallback entry.
> > This caused the right speaker channel to bind with VSPK voltage switch
> > disabled
> > (VSPK: 0), leading to a volume drop ~1 second after starting playback
> > due to power imbalance protection.
> >
> > Add an explicit entry for 10431A63 in cs35l41_config_table with
> > internal boost type, 4500mA peak current, and switch its model mapping
to
> generic_dsd_config.
> > This resolves the volume drop issue and enables proper internal boost
> > for both channels.
> >
> > Pull Request on SOF Project:
> > https://github.com/thesofproject/linux/pull/5866
> >
> > Signed-off-by: Gemayel Lira <gemayellira@gmail.com>
> >
> > From 10431A6300000000000000000000000000000000 Mon Sep 17
> 00:00:00 2001
> > From: Gemayel Lira <gemayellira@gmail.com>
> > Date: Sat, 1 Aug 2026 19:15:00 -0300
> > Subject: [PATCH] ALSA: hda/cs35l41: Add DSD property override for ASUS
> > UX3405CA
> >
> > The ASUS Zenbook 14 UX3405CA (SSID 1043:1A63) has internal CS35L41
> > amplifiers, but was using the `missing_speaker_id_gpio2` fallback entry.
> > This caused the right speaker channel to bind with VSPK voltage switch
> > disabled
> > (VSPK: 0), leading to a volume drop ~1 second after starting playback
> > due to power imbalance protection.
> >
> > Add an explicit entry for 10431A63 in cs35l41_config_table with
> > internal boost type, 4500mA peak current, and switch its model mapping
to
> `generic_dsd_config`.
> > This resolves the volume drop issue and enables proper internal boost
for
> both channels.
> >
> > Signed-off-by: Gemayel Lira <gemayellira@gmail.com>
> 
> Stefan, is this also covered in your side?
> Or shall we just take this?
> 
> 
> BTW, Gemayel, at the next time, please submit to linux-
> sound@vger.kernel.org.  It's the place for kernel patches, while
alsa-devel ML is
> mostly for only user-space stuff.
> 
> 
> thanks,
> 
> Takashi
> 
> 
> > ---
> >  sound/hda/codecs/side-codecs/cs35l41_hda_property.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
> > b/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
> > index 416d7bf..1cf12f8 100644
> > --- a/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
> > +++ b/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
> > @@ -104,6 +104,7 @@ static const struct cs35l41_config
> cs35l41_config_table[] = {
> >  	{ "104317F3", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 },
> 0, 1, -1, 1000, 4500, 24 },
> >  	{ "10431863", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 },
> 1, 2, 0, 1000, 4500, 24 },
> >  	{ "104318D3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 },
> 0,
> > 1, -1, 0, 0, 0 },
> > +	{ "10431A63", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 },
> > +-1, 2, -1, 1000, 4500, 24 },
> >  	{ "10431A83", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 },
> 0, 1, -1, 1000, 4500, 24 },
> >  	{ "10431B93", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 },
> 1, 2, 0, 1000, 4500, 24 },
> >  	{ "10431C9F", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 },
> 1,
> > 2, 0, 1000, 4500, 24 }, @@ -530,7 +531,7 @@ static const struct
> cs35l41_prop_model cs35l41_prop_model_table[] = {
> >  	{ "CSC3551", "104317F3", generic_dsd_config },
> >  	{ "CSC3551", "10431863", generic_dsd_config },
> >  	{ "CSC3551", "104318D3", generic_dsd_config },
> > -	{ "CSC3551", "10431A63", missing_speaker_id_gpio2 },
> > +	{ "CSC3551", "10431A63", generic_dsd_config },
> >  	{ "CSC3551", "10431A83", generic_dsd_config },
> >  	{ "CSC3551", "10431B93", generic_dsd_config },
> >  	{ "CSC3551", "10431C9F", generic_dsd_config },
> > --
> > 2.43.0

