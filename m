Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF7CC5AD5A
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Aug 2026 09:27:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9CAE66026B;
	Wed, 12 Aug 2026 11:27:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9CAE66026B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786526869;
	bh=lvJeMBqNkmUF8GO3S9S+AjTNi6kl5J5nzRfNq/wJI0A=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=FFeChFd41rCD/C618/B1NgoCQ//p39G0vccjRXsqUzk2Oe3LF3ilu1wRnDmSVtbUP
	 hMZqHZ9nzXSR/4XZQJHl0yqrW2GNEFwEo57yBeEy+DFIY23nd08qa8ag7YtkR43xOx
	 KcdDGxMjCgwYJj/HyewVuQD4GFcv6A23KE+imrX4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CD4D3F80694; Wed, 12 Aug 2026 11:26:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E651FF80699;
	Wed, 12 Aug 2026 11:26:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BD203F804CF; Wed, 12 Aug 2026 07:21:54 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1786512110;
	b=n+dA5Uzyg38HkIZjBpvnsdaG5IGUAhgaGKyDmpgoQj3iJknvp7LsFwW2sHfAZ4JWbQhz
	 9aXf+BWC960NTt5AZz5e6gntb6CsszRA9nhWbKgYbBkCItmfNOU9BsVQ7Yq/D0fe3iEJd
	 BX811hNHOwqTQVNoeO0bn5FKVVzPbdKM3EsaIuSfKp9xtwZmWEOlRyDYiZJEMmlE1Z540
	 yGLuq/lIOKd1rBb3oUlTnSalzIsP4Ll4YnRVmpXM9yjnv6T8Gtp5KLbHEVQpTQf/zMys+
	 pjO0XEWhQ6C85sm5YoWeMtRedqBCgnp/E5tmLekW6u6ot9O3M4tzarwR+sOn9997qgg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786512110;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version;
	bh=lvJeMBqNkmUF8GO3S9S+AjTNi6kl5J5nzRfNq/wJI0A=;
	b=F6HEUsSWxiHy7AuwUiGkyUqK17VToxvfWcp57gaBIYBC+7CIjhJCS5jZwdZGk37lBiDu
	 dKF76QySXqE9Wb1FHOFPNQl2NOlas7k5t3Bt56RfK41nPqHVRIZDLyf3+sQglxloiiakX
	 cp8wfRs5Dd4EowqKod4sELPU8AYi4EJfJ8LVkh1Q5eqVndLkP3JFx5V8+YwUyi5XT10Ha
	 DJeNjdkGXEBybXxMtOe7HNjNfoGrPpLmXv3JcsuaN0qg/v/zDs0C0Dp6SEcRPm2smk5Gi
	 QgiVIg7Yg+fNOEKabsXblerppBONa8d/yaKZXMY3ncpU8ezlvEGpKxmQHLVFm4AGg3w==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=VvareJ6j;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=CktIit4u;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 09DE3F8010B
	for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2026 07:21:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 09DE3F8010B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=VvareJ6j;
	dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=CktIit4u
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67C4PSoA3452983;
	Wed, 12 Aug 2026 00:21:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=meRabSh0bp/Qh
	aTsZZwLxRgJYPtj5ff4kxu/5iT97oM=; b=VvareJ6jkxBggdXdRlNMogbJxz8oT
	qdDY+L3LsIbKoCtjsMqZT0Y2xVtNxiJBicUsGi7ojaAFNMg4TT/WiPWm2kAejDPl
	wBORZo0OQ22qCE796muFrWVpQ6uPlpSNhB8C28Je35S1nUkdLhBPJ/vbSsCAFASr
	KbLP5RPmFBvZBtptZQPIxUX/ew10Hz28U7U8x1bDpjMH2emef0I1xvwxKkunQ+1z
	WzNV2IWyUrDauN2G5V1SgvJbsuGdNh+M0CnNUWzlHXrghBWjyZQCOKYybSKG5r2G
	ybNt+o4gmE1DEwvDUkTP0aQGRXEjST7kgy80lpO8b6kGUgME8kmYMK9WQ==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010041.outbound.protection.outlook.com [52.101.46.41])
	by m0380145.ppops.net (PPS) with ESMTPS id 4g0d0chpkg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 00:21:42 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fW8eRf1VYrZILBdzOhIBZT+kxZ07ow2gtnr1ihHCWyMHC7N6fBRqPPURcQZnW2HkjRh9XnIPq82ZHymYYSUUEZGjKGR2AbLYjc6DUyByy50CVFLvjU2tazm85hMxjybfTfzoVD8+4SeX0ZGbucQ12bZ6dpTiw0eBvrWSBN0IycGf2wHSoL0SZ9UHlSI00IsUNIoihji1RC7IQ20agOEyiUe1wS0sTq77mqxDv1M+ppAE41ef3x9jbRzZ+9CNPksfOuKJBPoiVcRsbp0HYsmL8dY1BreQj8VUlQj+6hhtLVAojBmtbarP7luh93ANhv3377SxIAVXqg8b8x0IvkO+Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meRabSh0bp/QhaTsZZwLxRgJYPtj5ff4kxu/5iT97oM=;
 b=wUtPKGRDF1T1KlPalNFceepT0WsIIOIfFZXv5kZhtaJVmJr8Zq9pa//ZUXenbe96sI/10cE9RkOHG7DRzb4g67UPDVGRdaDviJu4ppxcEhTL7HzDAv+njcaSs7l45KPe1xfVjPAgPxH4c1smVsqBrV+MWWgrYvn5cg8WsQPmWPZx4fs11JWVM9cmr4FlCCavXLV0plmbDqC4eHSX6NeKIEsru0ivx2WxiVWRTyleABEX3nD5ph6tj++G40fFFjWHHgVNQKEqGCsEYvU1sc/UxFga+2EgmOOwhbGlsVCvcYz0xRwWNOsf+VxR584ccLJNV5El+m9szbxmlznH5SQQTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=amd.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meRabSh0bp/QhaTsZZwLxRgJYPtj5ff4kxu/5iT97oM=;
 b=CktIit4u0WMPQlpU621xFRiQl2PTZtOteDoAyszzf0PcYLRPaOm1VSGOk8QRq8sNXpQmRNq7jgnAoA0WHbWAAgyfx+OGXGyqo1YgZ30B74+ektDDw+k06uGEeQSmEgCxCK42tAHArmNpHUZp+bDv2pDZWdAD7+OZGla5Z/1ukIU=
Received: from PH0PR07CA0105.namprd07.prod.outlook.com (2603:10b6:510:4::20)
 by MW6PR10MB7638.namprd10.prod.outlook.com (2603:10b6:303:248::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 05:21:38 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:4:cafe::80) by PH0PR07CA0105.outlook.office365.com
 (2603:10b6:510:4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Wed,
 12 Aug 2026 05:21:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 05:21:37 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 00:21:37 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 12 Aug
 2026 00:21:37 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 12 Aug 2026 00:21:37 -0500
Received: from LAPTOP-70RJ5B8Q ([10.250.165.249])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67C5LTXX2507841;
	Wed, 12 Aug 2026 00:21:31 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <broonie@kernel.org>
CC: <tiwai@suse.de>, <andriy.shevchenko@linux.intel.com>,
        <13916275206@139.com>, <alsa-devel@alsa-project.org>,
        <shenghao-ding@ti.com>, <baojun.xu@ti.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <k-yi@ti.com>, <henry.lo@ti.com>, <robinchen@ti.com>,
        <niranjan.hy@ti.com>, <pin-hao.huang@hp.com>,
        <Syed.SabaKareem@amd.com>
Subject: [PATCH v1] ASoC: tas2783-sdw: add firmware download status check
Date: Wed, 12 Aug 2026 13:21:24 +0800
Message-ID: <20260812052124.1843-1-baojun.xu@ti.com>
X-Mailer: git-send-email 2.55.0.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|MW6PR10MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: a85ed66c-18da-4af4-c620-08def8319590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|6133799003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	9MJsiJBMDURbovX4cMTQWr9KJwnVVVCdtb+tm5FP31LrSgrj9fV5lsrjHz9hlCuHVqqEBGBriPCEaOjSnO6xOjW6ErMi4nM5fjUawtwaDs+T7jvFHOHX6wzBzhM7vyoDsN55MyMhg1HImIVXJlPA6eGGvotGJurS4Ng3twU39DiUkuRfS7sdjj9toMxH7rTqgyCxhlJMaYaqDuFkRtqS1LncK9cOypgS/0UZIbwHq4v9cIg+D9quez/MSYi/Mi5DgxApeOS+Vpmur1fyP4eaevfIxknZRf5hGqOM4rtFX/wDTaHsbiQF6Qi5dt3uqWDV+x6u8NeO1+0V5r9IgHQzXDQOYnfGWwFPa6AAY0X4EU89xqa0Xy9lwUoC185cIxTSDA+qo9VQqFZnTtLsNVU+Xr3NxFP8kG1whuuBjpJZjOo3K7xpt4mlbIwF6YEKDdr9/iHmGMHT5Ic9eEmtJl2m4mVvWReAddjfjXBH2BC98amdc80h5qG+oPjc6AXOfEaaig3e1cUn+JYrOPfS9RSCRpXCK8tlPFEThssEsG1pFey8T2CCt3M/7ox5h6NKsH58YmUu/hZdRuRwinpU5TgrIh5lnXLR2LrQJI5yskXTTaDkuq2xOxxkCfs7gBceYyQUzzZj+XPAUqNayiJyzXGobjkMjtGSmJ6D8vnZ0yns2XvCvxt9v1mRZ2ssnd+T3tPdxDVpGodm62i5zKpW+e1HpA==
X-Forefront-Antispam-Report: 
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(6133799003)(18002099003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	jt2r8xadaC6kTkxd/nXObOao8GdC9taMbxFRKpT+TVGS+LHIVu1mN8bONUR4NWFE1vMIlQyGDBheFRSmwcBsFB6iiiYU82E0kWdNw2S2ybHtSHBZzHlKaIWWWnVDUIxVHosv4YNQC5NVlXyyTmKjPSNoNo9QpbBJ+74p6ag5iw3FKN9h6T9bj1+lY4eGpuZHuzLjwypjMSZPIvW2NiCB0msc7uNGpIIBvdAo/ebuNSuKt+0aPOx17f+7G1/Dp0nTgBAqNYmITxLvNCvrmXHl54TKziTY2dnJJSKykJpPg0pA8FR8lgtWYx0bxB4RWY8MXTNfGmZ+O4lzm582hgdC/IwFOB7lB8mUCPgl0GayX/YLHkvKMDTpo4G4huWlN7aBqJIE/gB7AHL051ZMvJ/LzD5yG7ko+IwvParFGNFR/k2Dt6xnxbPjK0iMe7B0R3kH
X-Exchange-RoutingPolicyChecked: 
	fnj8kg0sLiVeCY4fSrzWimvsQ5e1TRTWQt0nGhyvq14wMUmMuqfNtFnZ9ilqnjLekeysY85LmRtOs1PQurJi+8SuPrwjOHazAxyJd417g2JSjM7h/mvpXgw26DbU6cIJDhfSa+7ju5M5S4i3OpK0UQ9KjhH8J5r/uu1pZOS8qwhZa/bqvI686qzgQvDTFvFvDInpjNVoPp4VCEUoFSFH/D/Qs5+qQnjNs9ZOJoFJDSJM5sy1lfDdPv15tM/JQBdJNC0Dkpz3/Z5TZZae4+lbt4bl3DnKluGY8LsYgPCSLJX/ZtKkuE7hMDhcxu01mv+gVjTADbHZ8wRj4z8ZU4EV6g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 05:21:37.8643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 a85ed66c-18da-4af4-c620-08def8319590
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7638
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDAzOSBTYWx0ZWRfXzAsy6AkTOfky
 FI26zb3CJj6M/nzLYCvmdf7iSIP8HTpBDfgpF92Ceq79UxWIBJ3zM6aEoO6jM++d8VJFUkVgYLQ
 w/rYKcZUdDOasyW/+IbtdaPT/QllpZI=
X-Proofpoint-ORIG-GUID: FXeJPr7HSOMGEnbLUV65bwnut4EpqIe3
X-Proofpoint-GUID: FXeJPr7HSOMGEnbLUV65bwnut4EpqIe3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDAzOSBTYWx0ZWRfX2H3jvjEsQsPN
 tWfeLbGTO1sjNVu6kOMpgbJQOGzjTY+/xQrvBNCCrMNpdrpP0mhRZ6dyTIxpUHHxTr41zOjXcX0
 5etvdWLsT10CDuVLXHQENH2W7UQRvC4RUP8ipcIQzuFpqoMCZ+NwMLMjyqSW48ASovbpvIxItRc
 qb5acFq4pf+sQEXJ0HmxtMZ70w7Q4CTZZnV8uWTrT1/eO9t7hFbcWvmK4L2vOnkXtaI50RNhL1U
 XNTz4AbBM4Ux8kKpo/hXWd7ZTV5uyWjgWqwL1DUPlRkK0gZv62oiCwWb1JCKi+C+6rMFJhG2uDH
 gNNlwEUGLt/UAr0phBDML/vRT925RJyLbtbMnxv/+YEALb3TUoHtpayUq7pHmUKRs6gtQDVgytN
 J+nuNP5IlRJSeiv9Pb1CfhWJm558oydrv4rGHkpp53Js9a7ggB+FQfvwtqcrTHX4JYswnBtKXyy
 89dvwvjGC/2LEy6c7BA==
X-Authority-Analysis: v=2.4 cv=Y+DIdBeN c=1 sm=1 tr=0 ts=6a7c02e6 cx=c_pps
 a=yJkyEzHMNmsTB3XYPV+H7A==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=NR1VtXSm6F_5fyvuCP4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120039
X-MailFrom: baojun.xu@ti.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: YEZ7CZYJKM62YQQ7T5HUJCLJTLAHPLF5
X-Message-ID-Hash: YEZ7CZYJKM62YQQ7T5HUJCLJTLAHPLF5
X-Mailman-Approved-At: Wed, 12 Aug 2026 09:26:11 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YEZ7CZYJKM62YQQ7T5HUJCLJTLAHPLF5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Currently, the firmware download is unnecessarily triggered on every
system resume from suspend, causing significant wake-up latency. However,
this step is redundant if the AMP remains powered on. Furthermore, certain
memory pages (addresses > 0xc60000) are skipped even after an AMP reset.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
 sound/soc/codecs/tas2783-sdw.c | 54 +++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/tas2783-sdw.c b/sound/soc/codecs/tas2783-sdw.c
index c217da5fccdf..fa206344dcde 100644
--- a/sound/soc/codecs/tas2783-sdw.c
+++ b/sound/soc/codecs/tas2783-sdw.c
@@ -97,6 +97,7 @@ struct tas2783_prv {
 	u8 rca_binaryname[64];
 	u8 dev_name[32];
 	bool hw_init;
+	bool first_hw_init;
 	/* wq for firmware download */
 	wait_queue_head_t fw_wait;
 	bool fw_dl_task_done;
@@ -782,15 +783,16 @@ static void tas2783_fw_ready(const struct firmware *fmw, void *context)
 			file->vendor_id, file->file_id,
 			file->version, file->length,
 			file->dest_addr, file->fw_data);
-
-		ret = sdw_nwrite_no_pm(tas_dev->sdw_peripheral,
-				       file->dest_addr,
-				       file->length,
-				       file->fw_data);
-		if (ret < 0) {
-			dev_err(tas_dev->dev,
-				"FW download failed: %d", ret);
-			break;
+		if (!tas_dev->first_hw_init || file->dest_addr < 0xc60000) {
+			ret = sdw_nwrite_no_pm(tas_dev->sdw_peripheral,
+					       file->dest_addr,
+					       file->length,
+					       file->fw_data);
+			if (ret < 0) {
+				dev_err(tas_dev->dev,
+					"FW download failed: %d", ret);
+				break;
+			}
 		}
 		cur_file++;
 	}
@@ -801,6 +803,10 @@ static void tas2783_fw_ready(const struct firmware *fmw, void *context)
 		ret = -EINVAL;
 	} else {
 		tas2783_update_calibdata(tas_dev);
+		/* Mark the AMP firmware download as complete. */
+		regmap_write(tas_dev->regmap, TASDEV_REG_SDW(0, 0, 0x07),
+			     0x22);
+		tas_dev->first_hw_init = true;
 	}
 
 out:
@@ -1102,7 +1108,6 @@ static s32 tas2783_sdca_dev_resume(struct device *dev)
 		regcache_mark_dirty(tas_dev->regmap);
 		return ret;
 	}
-
 	return 0;
 }
 
@@ -1171,25 +1176,28 @@ static s32 tas_fw_load(struct tas2783_prv *tas_dev, struct sdw_slave *slave)
 static s32 tas_io_init(struct device *dev, struct sdw_slave *slave)
 {
 	struct tas2783_prv *tas_dev = dev_get_drvdata(dev);
-	s32 ret;
+	s32 ret, val;
 
 	if (tas_dev->hw_init)
 		return 0;
+	regmap_read(tas_dev->regmap, TASDEV_REG_SDW(0, 0, 0x07), &val);
+	/* Check if the AMP is in reset status. */
+	if (val == 0x20) {
 
-	tas_dev->fw_dl_success = false;
+		tas_dev->fw_dl_success = false;
 
-	ret = regmap_write(tas_dev->regmap, TAS2783_SW_RESET, 0x1);
-	if (ret) {
-		dev_err(dev, "sw reset failed, err=%d", ret);
-		return ret;
-	}
-	usleep_range(2000, 2200);
+		ret = regmap_write(tas_dev->regmap, TAS2783_SW_RESET, 0x1);
+		if (ret) {
+			dev_err(dev, "sw reset failed, err=%d", ret);
+			return ret;
+		}
+		usleep_range(2000, 2200);
 
-	tas_dev->fw_use_fallback = false;
-	ret = tas_fw_load(tas_dev, slave);
-	if (!ret && tas_dev->fw_use_fallback)
+		tas_dev->fw_use_fallback = false;
 		ret = tas_fw_load(tas_dev, slave);
-
+		if (!ret && tas_dev->fw_use_fallback)
+			ret = tas_fw_load(tas_dev, slave);
+	}
 	if (!ret) {
 		if (tas_dev->sa_func_data)
 			ret = sdca_regmap_write_init(dev, tas_dev->regmap,
@@ -1197,7 +1205,6 @@ static s32 tas_io_init(struct device *dev, struct sdw_slave *slave)
 		else
 			ret = regmap_multi_reg_write(tas_dev->regmap, tas2783_init_seq,
 						     ARRAY_SIZE(tas2783_init_seq));
-
 		if (ret)
 			dev_err(tas_dev->dev,
 				"init writes failed, err=%d", ret);
@@ -1357,6 +1364,7 @@ static s32 tas_sdw_probe(struct sdw_slave *peripheral,
 	tas_dev->dev = dev;
 	tas_dev->sdw_peripheral = peripheral;
 	tas_dev->hw_init = false;
+	tas_dev->first_hw_init = false;
 	mutex_init(&tas_dev->calib_lock);
 	mutex_init(&tas_dev->pde_lock);
 
-- 
2.25.1

