Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2F5CA5FA7
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Sep 2026 19:03:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AA609601EA;
	Tue, 29 Sep 2026 21:03:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AA609601EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790708609;
	bh=pcYCbD2dnXwEJlar83uj04CBrqgiOweaNAJFH5IW/U0=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=ps9MVWRYTl2Gm6GQbCV8E8yFVSwrmR1Q07VJowyPqxj2MVlMPhtjBLX1FzR4JezB0
	 TFmuy0Qi341kL+imtiiNVvsM1Fu0YJkg8FBMdRD2uRuQekDp5uT6FSigP/9pGoesSK
	 fKseOgWzy+WXNgap8+k/smp/ALu6KTxxXRwniKXs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BC419F805FB; Tue, 29 Sep 2026 21:02:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 43280F805F6;
	Tue, 29 Sep 2026 21:02:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9CDBCF804F3; Mon, 21 Sep 2026 08:41:34 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789972890;
	b=WhmHerpppHtmyilDasEFP13Nyid5WMd6HIYwHptYVeIwgdd82/XI1zqiGVNk4EkUyFTy
	 F3uGqyOhtmkltTFFz+++TEoL9gSQOiYfjxtxmA9+47ikrlapuS3kL69hPkNzUCCItG8pS
	 oL2qS4hKYlWQqAimMJBynsQ/kvqWYSI55Q+vRsuWwjRP8DRY/u8utCxBWoeVjl7lJgLe/
	 /gPzU0kcyirY22/nzDfCo5C0h8k8pFgSnu7Ixeuoy45CE/fF3ctkE6xWT/HkpulLxjk9x
	 O6hOv5tHJwzCXOJQ+6uJIH1azYF3QwNQ3zgISgfOOAUZ/gbgdwIk9E1Kgeg2lCpDJbg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789972890;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version;
	bh=pcYCbD2dnXwEJlar83uj04CBrqgiOweaNAJFH5IW/U0=;
	b=DRs0uDENkXYwzsw45lP5JY7ShDzDMGe+zO66huWAVTwt1J7HhCHPWwYqqRFjFUc+exAF
	 o0yken1yC2XoO+TZgQW31ThKqbc+06JJTTN2zfVscZwC8DgwYgjpERoSd9KMuct9lyz2c
	 qPp2zBqFuWaWYAT99l5zBSmzB1Qz1avqoY05vvrfGdjVhCUrun77e/WNKquODZYTP6Kh5
	 QGM8WRUAou8BRT/P56IXbuznlOD/p+pA63cjdl/0R/G3OqFesy9askW+MCgyEi/3FzDkN
	 jzcmKixMe2lL/2vvHbuZyI0w4B9OH8zfOPk24Dcs3sOpMCd58K/vhjetqOPMa23ClVQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=qO85jQFn;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=tkoupHHb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6BF97F801F7
	for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2026 08:41:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6BF97F801F7
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=qO85jQFn;
	dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=tkoupHHb
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68L3Zho14049388;
	Mon, 21 Sep 2026 01:41:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=DEVSBES28QEy2
	uAZYZT6Q+jAMpuPxonohsrrMDApaBI=; b=qO85jQFnoxq4Uwbg2Himfq1PIgOxj
	KTQiVFTgzHqF4gcFcL+l7un6O3puXx5QqCV9WwOEaPlF3uF6/nyoClt6nfJv44yk
	6CVJioD/vlUnXgjUW2v5TsaJUCs+QoQLIwDUn3yLcfrqK95o775Glg37YxQW8mgq
	zBE5zznHkUo4tL2bNCaIljBc0Sc0n4FW3NpLzTNjkwLTj7EvrX582TEAoTa7orHs
	7KHo94aWM4k/pTjnoYUYPaZ5lE5z5mxAbA683drvobIaZ/EP9DeQQRHLw0ce04Uv
	xx7459xKZa5ztGBrHPqAJTz4DHmYPqLVboE0YxTSjPLtTIR6e2MY5pN+A==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
	by m0384305.ppops.net (PPS) with ESMTPS id 4gtcbnmmej-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 01:41:21 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzKopScl7Fd7B7b/cLfz9ODyioEvdTPXh14PtWwut7XlgpLJE30ca1CEXSqmcZQ+zRzk7CAcqC8HilpWSefmVHNmTM/wBYIrK5Mee/7EFNQjuaAK3tlOhxSo7R0TJtusT9IwvQYmCZO5s+Rm3uhl6aQEgdzYbFOIjhFAsfg6efc4+CMQ8VZySZZmN5aPCQyfHY2GrVjzS8YjE8ov2Hxr/0WbQxpOuO4rnDT0056pfugw5JF27rz4wsYG7HjczB22Aw8vRnQ3MpdslsIVlWhegAn5xL4FoSIpQ8q6A+kXMjv0l7r5pdkrZL/7aUtSW5n7QUwq+xgpIu6GDNl2VGUlOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEVSBES28QEy2uAZYZT6Q+jAMpuPxonohsrrMDApaBI=;
 b=gAJCRMJq0NvKlxS8r/r2h10SPZVvl3/YFz/72MUx2/KS5dnNNdz90Lfx0idAsadPHzHHEBasprcMfZoiMzSronhVbBdAIugqpA94oSbv3aeo/FwdBQ212cMpnnZs2ldNnaEoUSexhWn0atHuLWJ1ZubMd9kf0BzAoao2CuBYT/QYAJnqd1ChGPhwrBF4mrb/QqTBQFCHEBQcAKwahKShw2GUtvjAZ8RQtUoJmf+cCeKds6al+/9Y24FlFPVQqQp3mSV7u1F8n0ERK97gl0WQFhGjgAjDFIRfUFarFzLLK5wthCHcS9CaIcqoV9AKQCER+qq2VKyevuaH/+wOU1e72w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=amd.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEVSBES28QEy2uAZYZT6Q+jAMpuPxonohsrrMDApaBI=;
 b=tkoupHHbti3IkOESDHUNd81fpxQPUPajP+VXcoIrg9osvadRdw9VjYK5QjDkggtOOCr9bji1siAhZHURnNB76MciAFHcuBFHuH43hPAgec1WmD7WXz5MUugaFVys+m5OxMEl6XN1BHoaUlMBVSn6KE8WV63KNgj2BGWLKydCqb0=
Received: from SJ2PR07CA0003.namprd07.prod.outlook.com (2603:10b6:a03:505::26)
 by IA1PR10MB7167.namprd10.prod.outlook.com (2603:10b6:208:3f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Mon, 21 Sep
 2026 06:41:16 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::a1) by SJ2PR07CA0003.outlook.office365.com
 (2603:10b6:a03:505::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Mon,
 21 Sep 2026 06:41:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 06:41:16 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 21 Sep
 2026 01:41:09 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 21 Sep
 2026 01:41:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 21 Sep 2026 01:41:09 -0500
Received: from LAPTOP-70RJ5B8Q ([10.250.165.249])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68L6f3bg2431589;
	Mon, 21 Sep 2026 01:41:04 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <broonie@kernel.org>
CC: <tiwai@suse.de>, <andriy.shevchenko@linux.intel.com>,
        <13916275206@139.com>, <alsa-devel@alsa-project.org>,
        <shenghao-ding@ti.com>, <baojun.xu@ti.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <k-yi@ti.com>, <henry.lo@ti.com>, <robinchen@ti.com>,
        <niranjan.hy@ti.com>, <pin-hao.huang@hp.com>,
        <Syed.SabaKareem@amd.com>
Subject: [PATCH v5] ASoC: tas2783-sdw: add firmware download status check
Date: Mon, 21 Sep 2026 14:40:53 +0800
Message-ID: <20260921064053.932-1-baojun.xu@ti.com>
X-Mailer: git-send-email 2.55.0.windows.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|IA1PR10MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: 22293b0c-d2c4-4106-4a97-08df17ab566d
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|10067099003|56012099006|3023799007|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: 
 Onj3k26HM0JhH8ZS9O4dbWDm9s1SK9CphD/DfT84oQm3K1FiXhmdM8bHAkYe1rP1qZ1jMeAaRDhjxMWCec546J/Pbhi0TFkaPAAWc1nkpMSH3YibRhGvVO6K4Tjbp400PIKKVFuNw9hb+lQt5Q4GQ8HYwhbYKGc5wGBbTslQ8U1IYdkaTCkhCg9lwTFmr7Hkpq0eEKGY25tahlvNebdlZPPweobVVLsW06jONH3psy8Gt14DAoOmrpgDRILeQpKhiubzGsGRd/1RngOxRRTkbW5FnBq1lyuZW2K4/AyPalAVRy01rN56WfbKD/yIXRud/rK9Kze9TSjBFmmRaCRdb9GPS3yC6SjeyDSlpY6Zfp7jhKL2BG/mb5FiqwieonZgMB9OMR8annwd18ixySBAEOsV1r64i7omqgAJN5hcaZ4UfsSx4I1W3kE2RVnfHPAP8fS7egxrVME8TxOdl0RyELvnjnZy91BWTMa8J7k+fl8BDfebr6Zq+kijExsY4sYnpAfJhHtFy8DQFf1KQJ2eNS9dFGT9FUDiY3eVaCEOkMkH64rD7PyPYw/XcUvX5w2zFJ8wqVnKcGjfaZ1Xmd9dL9abuD2I8q5ZQoedExChZapuHY6xzl3RjzEbAKZHuAW6gaPeiqHE+GRcKDLYArWtMLrwFSuTsnrP4MI0LCd0ZKtaPqbpEG+xyQ3t2PDjjh3lvG6/NbEIj96pGUCWXHBxuQ==
X-Forefront-Antispam-Report: 
 CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(10067099003)(56012099006)(3023799007)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 H3Eb/QI/AGUYu3hdsNx7TyFWPpYVKjcHnYZeYcjydnRdDun5ivr4gm73DLjIuYZIR6tB5UTbxWxv1wnCCP7BFMLlAdybcKLKWhF8VIt6xf6drj7mAlIUeYMPdrJglT6A6HJZ+QJyutoS/UIwH7Ar91CKpdmthsCOthnX8f2H7XBM8gCYGmYQSfUpTe/MoCcqCKIlOYtlOlOcbSqA7gQYVR4YAACF+w9tiIyAdsygNWY7AaahtfCa/49dFQCrYrbLmh4iYJ+HKNR7ELTLcaQQuadETB6r2qVyEkGVq4KbAewWcj/aWFKoI+IOA6pnhX9GXu60idfxP98wk5b/Spf7AJL0Z+d5C/7UddjCeN/SCfbD0tO/PY7GrmjbHAGQ/PTKo7shTX++TlcOy6WY6S2X5wj2M1nSoer0bwSbVJQvccOulpXnK9AmaDbrrLZJZ84P
X-Exchange-RoutingPolicyChecked: 
	4Y1Qgk3vHvdrML7/KQxyQzkoz81/2I7gLkGn/rYy3JhWFteRNBOH97CfhXBJLbxOT9nf85xCxeFWe3oIVkeTWmqeRX3vxAGDb2MR16+l35XuPTpRfrY9d/fuk0jIMBSSxAD5gpSe2pjE6BHmSQ7gp4edbTfUyY86t8EY2HHODHbrnGQM1DFAu+EkVLNOtNSmw0l8wrFIYGkoSGbX/Yjgu9fwOLPoYUm8+UC9d98PEjaaWWtmEQCWcrpqYE45uyJJyFv2m48C75li0IQml40uY28g05v7uECDCw6zr7HMOE6DMQZQl5zPaOKTZGMRMTN/dkd9Yo7DdF4d7k2wOVUzKQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 06:41:16.5486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 22293b0c-d2c4-4106-4a97-08df17ab566d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
 SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7167
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDA5NCBTYWx0ZWRfXzspyWNcN4TkL
 6VvnbsZIniAe/vJvMVrHV6+s6KLIyvWtsD8QuWSME7VrgJyZmlcT+dW/vmOaL9gF54p2zhfXDqd
 U9V+6auSTttX3WD+zsB8eC+tkmaY4ig=
X-Authority-Analysis: v=2.4 cv=P7CvFSAu c=1 sm=1 tr=0 ts=6ab0d191 cx=c_pps
 a=oQiTq6cBShE1BE+bdGc2Dw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8
 a=Mo2TJmvQneBMscMcN9kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDA5NCBTYWx0ZWRfX0RU4+QV5UQSX
 kgb6uqmwmmoFP17DhCxWe5uCl97qf0jGyhWLJuEI7dYEL/Vb6ErGxHNBPBZ8ind2hZmgpzeyDvx
 OxcUOYc3uxKsqKBOTzTjiDJfyRHfHSB9AVyuCeToZNv0HxKMAb9ajt0ORUpL7CaGs4kALQtz1SH
 kHKwdwsAFYuNXs8L2yst52db5COzF7T6mD5HODeS0ph17Y7CEOKzO+7+qwU7bdx5lmUYYsKkMML
 62WasRo6G4uZ+RC8Yp1Aw9SOWWPXY/2F7LVqYAXJe0lOS8hJAt/3nQY26VN3dBoguP1U4V9aunk
 N0qGUszb2BN6NIGUVOjbl5r7Mz/fgz7MFXrU9KkLkLn/D7H2Vo0KJ63HQ40KeedKdYSaDmltprw
 p0dX02zA0bXPNcq83SlUf8N3rIsOjkqPNmnlNiNxzQDBGPrtFTkUqmwip6a7FkxtcLDjvFHwbJI
 erS2ZdtVBQ/DV3D3FWA==
X-Proofpoint-GUID: ppkS7OHk0ckCY_EWqCzdvHGQPCwynQs3
X-Proofpoint-ORIG-GUID: ppkS7OHk0ckCY_EWqCzdvHGQPCwynQs3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210094
X-MailFrom: baojun.xu@ti.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: LJ3PJOAM2N7X5ZPJG7HSMDASSU6JHJZV
X-Message-ID-Hash: LJ3PJOAM2N7X5ZPJG7HSMDASSU6JHJZV
X-Mailman-Approved-At: Tue, 29 Sep 2026 19:02:49 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LJ3PJOAM2N7X5ZPJG7HSMDASSU6JHJZV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Currently, the firmware download is unnecessarily triggered on every
system resume from suspend, causing significant wake-up latency. However,
this step is redundant if the AMP remains powered on.
Furthermore, PRAM access is skipped if the firmware version read from
registers matches the expected value, indicating that the memory content
was retained across the AMP reset.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
v5:
- Add fw_version field for PRAM status check.
- Adjust register range from pages 1–127, 253 to pages 0–1, 253.
- Include PRAM and YRAM ranges in tas2783_sdca_mbq_size.
- Set max_register to the end of PRAM.
- Add PRAM status check before firmware download to skip reloading if PRAM
  content is retained.
- Add a retry mechanism after download failure to handle register write
  issues on initial power-up.
- Call regcache_drop_region() after firmware download to ensure correct
  firmware version reading.
- Read firmware version after download for subsequent comparison.
- Remove the "separate two monos to stereo" workaround as it causes missing
  audio on the right channel; stereo configuration should be handled by the
  DisCo table.
- Add AMP reset in the driver remove path.
- Update PRAM_ADDR_END from 0x7f to 0x80 in tas2783.h.
- Add address definition for the firmware version register in tas2783.h.
v4:
 - Since first_hw_init is only required for download reduction, remove it
   when this feature is not enabled.
v3:
 - Updated description about memory page download reduce.
 - Removed the logic that skips memory page downloads.
v2:
 - Update register address from 0x07 to 7 and keep the line within the
   80-character limit.‌
 - ‌Remove stray/unnecessary changes.‌
 - ‌Change variable type to unsigned int to comply with API requirements.‌
 - ‌Replace usleep_range() with fsleep().‌
 - ‌Set idle_bias_on to 0 to enable low-power mode.
 - Reactivate the AMP after resume.
---
 sound/soc/codecs/tas2783-sdw.c | 100 +++++++++++++++++++--------------
 sound/soc/codecs/tas2783.h     |   4 +-
 2 files changed, 62 insertions(+), 42 deletions(-)

diff --git a/sound/soc/codecs/tas2783-sdw.c b/sound/soc/codecs/tas2783-sdw.c
index 85ab3fd83c7b..1a88a15bcb02 100644
--- a/sound/soc/codecs/tas2783-sdw.c
+++ b/sound/soc/codecs/tas2783-sdw.c
@@ -97,6 +97,7 @@ struct tas2783_prv {
 	u8 rca_binaryname[64];
 	u8 dev_name[32];
 	bool hw_init;
+	unsigned int fw_version;
 	/* wq for firmware download */
 	wait_queue_head_t fw_wait;
 	bool fw_dl_task_done;
@@ -315,8 +316,8 @@ static int tas2783_sdca_mbq_size(struct device *dev, u32 reg)
 	case 0x300 ... 0x340: /* Data port 3. */
 	case 0x400 ... 0x440: /* Data port 4. */
 	case 0x500 ... 0x540: /* Data port 5. */
-	case 0x800000 ... 0x803fff: /* Page 0 ~ 127. */
-	case 0x807e80 ... 0x807eff: /* Page 253. */
+	case TASDEV_REG_SDW(0, 0, 0) ... TASDEV_REG_SDW(0x00, 0x01, 0x80):
+	case TASDEV_REG_SDW(0, 0xfd, 0) ... TASDEV_REG_SDW(0, 0xfd, 0x80):
 	case SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_UDMPU23,
 			  TAS2783_SDCA_CTL_UDMPU_CLUSTER, 0):
 	case SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_FU21, TAS2783_SDCA_CTL_FU_MUTE,
@@ -431,6 +432,8 @@ static int tas2783_sdca_mbq_size(struct device *dev, u32 reg)
 
 	case SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_XU22, 0x12, 0):
 	case SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_XU22, 0x13, 0):
+	case PRAM_ADDR_START ... PRAM_ADDR_END:
+	case YRAM_ADDR_START ... YRAM_ADDR_END:
 		return 4;
 
 	default:
@@ -517,7 +520,7 @@ static const struct regmap_config tas_regmap = {
 	.volatile_reg = tas2783_volatile_register,
 	.reg_defaults = tas2783_reg_default,
 	.num_reg_defaults = ARRAY_SIZE(tas2783_reg_default),
-	.max_register = 0x41008000 + TASDEV_REG_SDW(0xa1, 0x60, 0x7f),
+	.max_register = 0x41000000 + PRAM_ADDR_END,
 	.cache_type = REGCACHE_MAPLE,
 	.use_single_read = true,
 	.use_single_write = true,
@@ -745,6 +748,7 @@ static void tas2783_fw_ready(const struct firmware *fmw, void *context)
 	const u8 *buf = NULL;
 	s32  img_sz, ret = 0, cur_file = 0;
 	s32 offset = 0;
+	u32 val[4], fw_version;
 
 	struct tas_fw_hdr *hdr __free(kfree) = kzalloc_obj(*hdr);
 	struct tas_fw_file *file __free(kfree) = kzalloc_obj(*file);
@@ -786,6 +790,11 @@ static void tas2783_fw_ready(const struct firmware *fmw, void *context)
 	}
 
 	mutex_lock(&tas_dev->pde_lock);
+	ret = regmap_bulk_read(tas_dev->regmap, TAS2783_FW_VERSION, &val, 4);
+	fw_version = (val[0] << 24) | (val[1] << 16) | (val[2] << 8) | val[3];
+	dev_dbg(tas_dev->dev, "Get Firmware version: %08x == %08x?, err=%d",
+		fw_version, tas_dev->fw_version, ret);
+
 	while (offset < (img_sz - FW_FL_HDR)) {
 		offset += tas_fw_get_next_file(&buf[offset], file);
 		dev_dbg(tas_dev->dev,
@@ -794,6 +803,13 @@ static void tas2783_fw_ready(const struct firmware *fmw, void *context)
 			file->version, file->length,
 			file->dest_addr, file->fw_data);
 
+		if (tas_dev->fw_version == fw_version &&
+		    file->dest_addr >= PRAM_ADDR_START &&
+		    (file->dest_addr + file->length) <= PRAM_ADDR_END) {
+			cur_file++;
+			dev_dbg(tas_dev->dev, "Ignore PRAM block");
+			continue;
+		}
 		ret = sdw_nwrite_no_pm(tas_dev->sdw_peripheral,
 				       file->dest_addr,
 				       file->length,
@@ -801,17 +817,34 @@ static void tas2783_fw_ready(const struct firmware *fmw, void *context)
 		if (ret < 0) {
 			dev_err(tas_dev->dev,
 				"FW download failed: %d", ret);
-			break;
+			/*
+			 * We do retry here for some special case of download
+			 * failed after Power-On.
+			 */
+			ret = sdw_nwrite_no_pm(tas_dev->sdw_peripheral,
+					       file->dest_addr,
+					       file->length,
+					       file->fw_data);
+			if (ret < 0) {
+				dev_err(tas_dev->dev,
+					"FW download failed again: %d", ret);
+				break;
+			}
 		}
 		cur_file++;
 	}
 	mutex_unlock(&tas_dev->pde_lock);
+	regcache_drop_region(tas_dev->regmap, 0, UINT_MAX);
 
 	if (cur_file == 0) {
 		dev_err(tas_dev->dev, "fw with no files");
 		ret = -EINVAL;
 	} else {
 		tas2783_update_calibdata(tas_dev);
+		ret = regmap_bulk_read(tas_dev->regmap, TAS2783_FW_VERSION,
+					&val, 4);
+		tas_dev->fw_version = (val[0] << 24) | (val[1] << 16) |
+				       (val[2] << 8) | val[3];
 	}
 
 out:
@@ -951,7 +984,7 @@ static s32 tas_sdw_hw_params(struct snd_pcm_substream *substream,
 							TAS2783_SDCA_POW_STATE_ON);
 			if (!ret)
 				break;
-			usleep_range(2000, 2200);
+			fsleep(2200);
 		} while (retry--);
 	}
 
@@ -962,30 +995,6 @@ static s32 tas_sdw_hw_params(struct snd_pcm_substream *substream,
 	snd_sdw_params_to_config(substream, params,
 				 &stream_config, &port_config);
 
-	/*
-	 * The two mono amps each render one channel of the stereo stream:
-	 * snd_sdw_params_to_config() hands every codec the full mask for
-	 * playback, which leaves the pair in mirror mode and one channel
-	 * unreproduced.  Claim a single channel instead, keyed off the
-	 * machine-assigned component prefix rather than the SoundWire
-	 * address, which is board-specific: soc_sdw_ti_amp.c names the amps
-	 * tas2783-1..4.
-	 *
-	 * Which side an amp then renders does not follow from the bit that
-	 * is set - sdw_compute_slave_ports() advances the payload offset by
-	 * the popcount of ch_mask and never looks at which bit it is - but
-	 * from the amp's position in the codec order of the DAI link, which
-	 * on these boards matches the prefix numbering.
-	 */
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
-	    params_channels(params) == 2 && component->name_prefix) {
-		const char *idx_str = strrchr(component->name_prefix, '-');
-		unsigned long idx;
-
-		if (idx_str && !kstrtoul(idx_str + 1, 10, &idx) && idx)
-			port_config.ch_mask = (idx & 1) ? BIT(0) : BIT(1);
-	}
-
 	/* port 1 for playback */
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		port_config.num = 1;
@@ -1074,7 +1083,7 @@ static const struct snd_soc_component_driver soc_codec_driver_tasdevice = {
 	.num_dapm_widgets = ARRAY_SIZE(tas_dapm_widgets),
 	.dapm_routes = tas_audio_map,
 	.num_dapm_routes = ARRAY_SIZE(tas_audio_map),
-	.idle_bias_on = 1,
+	.idle_bias_on = 0,
 	.endianness = 1,
 };
 
@@ -1207,25 +1216,30 @@ static s32 tas_fw_load(struct tas2783_prv *tas_dev, struct sdw_slave *slave)
 static s32 tas_io_init(struct device *dev, struct sdw_slave *slave)
 {
 	struct tas2783_prv *tas_dev = dev_get_drvdata(dev);
+	uint val;
 	s32 ret;
 
 	if (tas_dev->hw_init)
 		return 0;
 
-	tas_dev->fw_dl_success = false;
+	ret = regmap_read(tas_dev->regmap, TASDEV_REG_SDW(0, 0, 7), &val);
 
-	ret = regmap_write(tas_dev->regmap, TAS2783_SW_RESET, 0x1);
-	if (ret) {
-		dev_err(dev, "sw reset failed, err=%d", ret);
-		return ret;
-	}
-	usleep_range(2000, 2200);
+	/* Check if the AMP is in reset status. */
+	if (val == 0x20) {
+		tas_dev->fw_dl_success = false;
 
-	tas_dev->fw_use_fallback = false;
-	ret = tas_fw_load(tas_dev, slave);
-	if (!ret && tas_dev->fw_use_fallback)
-		ret = tas_fw_load(tas_dev, slave);
+		ret = regmap_write(tas_dev->regmap, TAS2783_SW_RESET, 0x1);
+		if (ret) {
+			dev_err(dev, "sw reset failed, err=%d", ret);
+			return ret;
+		}
+		fsleep(2200);
 
+		tas_dev->fw_use_fallback = false;
+		ret = tas_fw_load(tas_dev, slave);
+		if (!ret && tas_dev->fw_use_fallback)
+			ret = tas_fw_load(tas_dev, slave);
+	}
 	if (!ret) {
 		if (tas_dev->sa_func_data)
 			ret = sdca_regmap_write_init(dev, tas_dev->regmap,
@@ -1234,6 +1248,8 @@ static s32 tas_io_init(struct device *dev, struct sdw_slave *slave)
 			ret = regmap_multi_reg_write(tas_dev->regmap, tas2783_init_seq,
 						     ARRAY_SIZE(tas2783_init_seq));
 
+		/* Re-active AMP after resume. */
+		regmap_write(tas_dev->regmap, TASDEV_REG_SDW(0, 0, 2), 0);
 		if (ret)
 			dev_err(tas_dev->dev,
 				"init writes failed, err=%d", ret);
@@ -1413,6 +1429,7 @@ static s32 tas_sdw_probe(struct sdw_slave *peripheral,
 	tas_dev->dev = dev;
 	tas_dev->sdw_peripheral = peripheral;
 	tas_dev->hw_init = false;
+	tas_dev->fw_version = 0;
 	mutex_init(&tas_dev->calib_lock);
 	mutex_init(&tas_dev->pde_lock);
 
@@ -1437,6 +1454,7 @@ static void tas_sdw_remove(struct sdw_slave *peripheral)
 	struct tas2783_prv *tas_dev = dev_get_drvdata(&peripheral->dev);
 
 	pm_runtime_disable(tas_dev->dev);
+	regmap_write(tas_dev->regmap, TAS2783_SW_RESET, 0x1);
 	tas_remove(tas_dev);
 	mutex_destroy(&tas_dev->calib_lock);
 	mutex_destroy(&tas_dev->pde_lock);
diff --git a/sound/soc/codecs/tas2783.h b/sound/soc/codecs/tas2783.h
index d5996c73526c..2f034617e356 100644
--- a/sound/soc/codecs/tas2783.h
+++ b/sound/soc/codecs/tas2783.h
@@ -35,10 +35,12 @@
 #define TAS2783_AMP_LEVEL_MASK	GENMASK(5, 1)
 
 #define PRAM_ADDR_START		TASDEV_REG_SDW(0x8c, 0x01, 0x8)
-#define PRAM_ADDR_END		TASDEV_REG_SDW(0x8c, 0xff, 0x7f)
+#define PRAM_ADDR_END		TASDEV_REG_SDW(0x8c, 0xff, 0x80)
 #define YRAM_ADDR_START		TASDEV_REG_SDW(0x00, 0x02, 0x8)
 #define YRAM_ADDR_END		TASDEV_REG_SDW(0x00, 0x37, 0x7f)
 
+#define TAS2783_FW_VERSION	TASDEV_REG_SDW(0x00, 0x20, 0x3c)
+
 /* Calibration data */
 #define TAS2783_CAL_R0		TASDEV_REG_SDW(0, 0x16, 0x4C)
 #define TAS2783_CAL_INVR0	TASDEV_REG_SDW(0, 0x16, 0x5C)
-- 
2.25.1

