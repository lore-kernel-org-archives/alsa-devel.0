Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BA2C43458
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:57:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 065B960278;
	Tue, 30 Jun 2026 13:57:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 065B960278
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782820652;
	bh=FwQ5ktwU7CQ5D31rTPCy3u5C/kiGZRVAJBvDVtGmnm4=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Oy9OHk5VootkD1LjzEShmmoX39QH67xjEkYxMG5R9Aa+tOXRMdC+9bViPVKUROxYr
	 6fkua2RswQPkHpUl8OhPyHvLAT2RTfgzaxGtvzCWVHRggTTwp5+cKVbpqhClPZTvF/
	 L+hcJcLiNg5rWo0xgrnlGTiMBT0tZYIp5mRhqwkc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E0AC1F80814; Tue, 30 Jun 2026 13:54:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 18B18F80800;
	Tue, 30 Jun 2026 13:54:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EA1F6F80548; Sun, 28 Jun 2026 14:28:48 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1782649728;
	b=P7moWS2KOmr9aelDyugSLyo8au1x+i9jZRwRNpUeTwaG6ATKrxH7Li3rQeBPjkKdQ1bm
	 24nbw2Cq0bEPNVrRzbh/ZXbrpWlPeaXXwfwkmSDppy1C9coGC3O/8k00TFs1ieBa8SI9j
	 T/GK7M5cCJobHdNWp/xzVmNv1w4/buk1EzTeNYo9asRAgdyRmVsq2Ntu3mXgW9ugtrEo9
	 jdwe1yHV5tQZZhdvKZDJ6N2PWqnnLo032XaxAsj19mOPGoN49EuWR0O1Ij7OqIcr7VMjt
	 jBOa72cP3huk6J/wJgIw39WFr9ql3L6VDCACmYi7hjbRGFP3NEhvagOwAkD/5XG6oHg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782649728;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version;
	bh=FwQ5ktwU7CQ5D31rTPCy3u5C/kiGZRVAJBvDVtGmnm4=;
	b=b4dIODb1wL8oPABLwNGOhXs/3ZV46EW4DrsieeFP4/tlqmKUmQ3lVppo5nxoncIZPOoD
	 AS7XGLUg7qtU7SR7mstMpwS9/e2kzn4T6BYzieFU6kyvjcBCeIF0qKz31MA6Wp0NfcGAo
	 zG2Tpgu5suQks47Bqpwhhk0FpIamnvAnpjv0Pt+JuFcjFxiHo6KTIGoaPaww/VaHkXpk2
	 gLk4y+82A7NwSp52hlhrEwJYXuCk2NlJoDQGFYgnHPV/obn4NNRPbHUe6RIKXgJr9223R
	 +C576pbv4uGQnc+fJElyWMAyHfZVos5uX6m4ONSIKtj9YyCryNmaQdXZOy6FBl4/YNA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=A95IwRvM;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=OMXQE5bs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3D172F80212
	for <alsa-devel@alsa-project.org>; Sun, 28 Jun 2026 14:28:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3D172F80212
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=A95IwRvM;
	dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=OMXQE5bs
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65SBCVIV3392865;
	Sun, 28 Jun 2026 07:28:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=ccwAn1viciTPJ
	uIXx9Nmxu8rytoRFmvc0E5JulqDkXE=; b=A95IwRvMsVcW6shKnF5bxLc2DLBnc
	b5GdQNshUfFbz7pHCUVBbnP+7mJN3qzzg8HDB5qRaHrWxCoayu92eekLmrNuehBg
	ByEK0ebuW7jFt9fpbh2ETFLKwi2sLLPmJaxTVfwHIMP7vWQNn3b1M0tccjFlVqZi
	x0KBuvBmY4xxzST7yrprL6x8fsi2eHybKZIGslgWe/sV046v3DnR2IoF7KnmTLzR
	o0tDQm3545hx5IucGQEqt3mvqhO847tSm9C4iahvsw7yEupS4OzzV9pWCvWwmgal
	cHl5Awg/zfWdpLIQowjXV/xMkrNSY8l08hxlO5N8Ckm3lu7f4SA5GYhDw==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010057.outbound.protection.outlook.com [52.101.201.57])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f32hjg7b1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 28 Jun 2026 07:28:40 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hSceWW5DTfseGLuRnUlwa1RttxJRnwiIS5Rd6rfBiD4vZEzsbQ6CKRBEB5VpcPqJbma3oUyHRYjmsnSkkuJFd+iHfL6cdEZNC4LTxnNReFI1XOycS+Dopd46PBXGDRnLJxC+6tqD8MCrbOajGylH4RWtRv9kikI3vg3jkNGTDFE7yGq548uGVg8goIlzGq38EbYQm5NoTyQhPVbyi5aQAOs4JKlBUKYXMfU3uHsy+jZ/Ew6MrSsMQVOOjeBomRK2PqdmAq368RL9TucZ29WsrZBczTP1F8rmcmcTEJRlhHc0bGnohL6UGQw/FcywZ+Ila+RhzxRhsK5MdL3090TUXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccwAn1viciTPJuIXx9Nmxu8rytoRFmvc0E5JulqDkXE=;
 b=Fnnk+Gd0DK+bEQmenhtoibIFVcX8bb+FrQLFbLCsOuGbTvtxfNveJXiyVICsUMsUAsLGiOHpILK/iTNuIhha/3bxtoUXnmkIPEqNWebOENv97hcek+fIcGqIo0wzHrEC2dw9JVScurTk8YfQhDKClA4RcZXfW0nsGOaHIgn+BPN39sHzWDBSra9Jobr3UlPAYyQcGGRBE6xXaW8HDVSfrI17WrRsP32gBLFnGKjMq8PD+2JSYjL6VjiWdUvB08FjmXDOQmgvxAnrjKCF4xCpz0QoXTlxKlKNOjqK00r/uH2C1FbFeDuT0sWLAwlcDJdjvmQjWTQWcrGXHDKUis4wwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccwAn1viciTPJuIXx9Nmxu8rytoRFmvc0E5JulqDkXE=;
 b=OMXQE5bsn/AmKXLaiWbyl4HcpdWCVAS9eE2ccMKyuiGTjYpN6Gc/rfoqN2LEHmUNfvJVREti026sqEpVbDApDNlljaNTPAXpBpdZybc186Xu6iK1gL0KT9oK/BGIe+lmWks32O/Qu53AxkJiMhv/d5aVD9bCnQJiQsaIQN7b030=
Received: from MN0PR05CA0020.namprd05.prod.outlook.com (2603:10b6:208:52c::34)
 by IA1PR10MB6219.namprd10.prod.outlook.com (2603:10b6:208:3a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Sun, 28 Jun
 2026 12:28:38 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:208:52c:cafe::3c) by MN0PR05CA0020.outlook.office365.com
 (2603:10b6:208:52c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Sun, 28
 Jun 2026 12:28:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sun, 28 Jun 2026 12:28:36 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sun, 28 Jun
 2026 07:28:36 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sun, 28 Jun
 2026 07:28:36 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Sun, 28 Jun 2026 07:28:36 -0500
Received: from lelvem-mr05.itg.ti.com ([10.250.165.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65SCSUDf2289034;
	Sun, 28 Jun 2026 07:28:31 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <broonie@kernel.org>
CC: <tiwai@suse.de>, <andriy.shevchenko@linux.intel.com>,
        <13916275206@139.com>, <alsa-devel@alsa-project.org>,
        <shenghao-ding@ti.com>, <baojun.xu@ti.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <k-yi@ti.com>, <henry.lo@ti.com>, <robinchen@ti.com>,
        <niranjan.hy@ti.com>
Subject: [PATCH v1] ASoC: amd: acp70: add tas2783 SoundWire support
Date: Sun, 28 Jun 2026 20:28:04 +0800
Message-ID: <20260628122805.811-1-baojun.xu@ti.com>
X-Mailer: git-send-email 2.43.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|IA1PR10MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dffd79b-3147-4be5-083c-08ded510c71c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|6133799003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	JKyxZCmAXoFuQEdYQsiBh4AxObybP0faz+gbrH+MEH05FGqwTing/1mTeCZdlJaoLktqrKMX8bKvLRaQMDq+lDhCqCy5DdSnZJGeXQ9YNRwkU2eX2opR4nUNnc2c/GVC04sRWrg9rkX8AUriOf9t5fMisKE7o6FBTrzCIGi/H6cHcNYELRwjZ8wjoVmxZo0hm/EMGkVtgkn0yfDdzk5YktNBEmXxbpKsNI/LzlrCB8qxHyiF39mlCg/S/RgXkFA7+9FaV+84dOSgs/KLkm/awsutBXCYwY6gxh0dJ4fxA128EjVxmGVvlXhbDD9+OtL5syvD8PYxb+5MPNkyzPlnlUhLlspYDXeUT/Op455UHkY4ZewY2cYwK9RLNPFbbUhqnGYRDYxf84ybuZhVtx3PVQndONBRjOc0wkgZiSUu2jr0SgzmWQQXyUl3ZSZKqXnVIxKmuDBU+ZrXd8Dkz7Sxllvln+r6FPwE/54j8yn2NHqbo/U2E2+1oZnkDjjo3Ya1m3k2jJnGtmXfOXA0EoATz39w2MfimxRZZ7C/P34AaFUbvrbMl1Dj4rMT7ZN+1XV5EKVIQ40Xwq5PQU8vcRv4zYdanFJooXh4dIkFA0hinKs9kPtcj0ao5s9vbubg/VPxlPcrX9wkkyNiFOZfw5K4NjzUb1XrQCYVDmAmE34P5Bpu92EFVVTk5qKvIGBvzihudkAwGx7vlWhWzBHtSpHuBg==
X-Forefront-Antispam-Report: 
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(6133799003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	rTi/QsG7Jo9Z8XRcyGoUz2VtNumf8nWQVQxE96O1Yvyl2gYbw7n1OpHZyisMW5WFeIeBjsZpSXFciOK44u1+rzKne8IsDt+qN8g2i2gy6X5rIzt0jEZWw61TQGPUjxBoet/Oqqra3dZi4tTG9xLWaKEunKmGH6bAvBf1VQCZSNpccnZCKLxXhMtQ9gEDirLYMRSAdR4edSa6b1LWGN+lH0U8NmpBlcZlY6fTqWF3IJvG4yuDeNX4aFhFHTjfFnkZpkj6R8/BsY0CR6icOgOt97yxAut4nTx/hpM098y66R8uinR3kMav1LgWQGLuDUPsB2dwvjCwSQr7ktR4+pgeGQUAJp+RyYJwB/yWnKhiTrpJct63II1DASN7T66svDg+g54ouqfgidSekFLLYeazXymDDeN+lBB2Whg05J0w3Gtlkl8zF2ZxvfrezBMSJ5+q
X-Exchange-RoutingPolicyChecked: 
	FKgACcpJF4+tLm/Jb7HriuJSuZKp8QCQlZAAE0HhY/uw6DgOHFdNk1ljv6mRkdfLeDipBFvZks2xlZb8NYoIogCjCT+AlZh1kyo8iuzbe+w3N7kAkE7ltdOHuSZj7xLP7m4HqVmvZJCFNk3Hh3G+nE5tP133HPF3/labDVrc980Iizh+/SVvVfE7QlGQtN+e8Jk99MgkVtoaNWVQfARmBLSjInxJNXfH5E40wKWR5MADIRmXH3WqtNKnxwzq9cqxROCaVSvn7NNPO9CKv2g4dehp43dVT5SmHd8APOk8bW5RzM+FbUAGkb8tYSGJKcKehrH8KVsTjEtv15Sj6WUeeA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2026 12:28:36.8779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 1dffd79b-3147-4be5-083c-08ded510c71c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6219
X-Authority-Analysis: v=2.4 cv=DrlmPm/+ c=1 sm=1 tr=0 ts=6a411378 cx=c_pps
 a=wYVaD1eOHCZ7T07lO2spig==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=sozttTNsAAAA:8 a=BoGlWVW-NvZq0emWBkgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDEwOSBTYWx0ZWRfXwqW1EqUlIcKF
 oq06s7wL4gEpV3JJkr/f5prOOnaPTBjSZ+RpiVTJ4Uj29WKbm4HxO4fnR4ISwiFgAzaYdt6kDgn
 liQNLxUU9fxSJzHn7E0bj0SRVoZRVsuPYa4jNXHeYcUPXCiLMKXxnHanWJSB+9/8/3TIDIIg84D
 wr+CC4wyUubI18SjamyCz4POa3uRpMqlzYmNNlS1y/m+BnlcadNDJxdmRlBVSj6/xeSMMZmDiEf
 FpC0OKvzNzn8HH2Ik3JTf8JONm/0Gp7jYO+3XmX/qlyDffbXfuINNSqZS6fUwakZdK3KRpc+uKE
 MrzIV8H6yVTMd8KZ2O22BBosxmLyfELaxevcbLiSdQW4HxmtLFNZVZR12TRX8psTYmAcQVywUve
 2qYr0xUwfXXPUO4JMx+OEGpQL0EmXKGUP0gIAoLaJU1sN6mUH3hQ+Y56Luai/HcOrKCGZGaayQ7
 gbXLlMi2Sxg5PD2w0jA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDEwOSBTYWx0ZWRfX++sUPfYf5V+i
 +SFIZYE/yRbtoGAZP+O9EIW3brddxdmE6NbLJ9yKrGEZGRUKgEhLA5KRtcm72QXHi2tHV4OHncr
 OZ7w2YxAhVeDbfsJZQGlXkllaBF6OoI=
X-Proofpoint-GUID: SeI4jDiKtRkK6cYtU0CkixzddxXqdv5Q
X-Proofpoint-ORIG-GUID: SeI4jDiKtRkK6cYtU0CkixzddxXqdv5Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606280109
X-MailFrom: baojun.xu@ti.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: DW34BKTZUP27R733X66XOI2O6G46N4I6
X-Message-ID-Hash: DW34BKTZUP27R733X66XOI2O6G46N4I6
X-Mailman-Approved-At: Tue, 30 Jun 2026 11:54:23 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DW34BKTZUP27R733X66XOI2O6G46N4I6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Added project 0x8EA1/8EA2 support for tas2783 on Soundwire.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
 sound/soc/amd/acp/amd-acp70-acpi-match.c | 64 ++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/sound/soc/amd/acp/amd-acp70-acpi-match.c b/sound/soc/amd/acp/amd-acp70-acpi-match.c
index 18f2918d4ada..a04075730f4f 100644
--- a/sound/soc/amd/acp/amd-acp70-acpi-match.c
+++ b/sound/soc/amd/acp/amd-acp70-acpi-match.c
@@ -45,6 +45,21 @@ static const struct snd_soc_acpi_endpoint spk_3_endpoint = {
 	.group_id = 1
 };
 
+static const struct snd_soc_acpi_endpoint tas2783_endpoints[] = {
+	{ /*Playback Endpoint*/
+		.num = 0,
+		.aggregated = 0,
+		.group_position = 0,
+		.group_id = 0,
+	},
+	{ /*Mic Capture Endpoint*/
+		.num = 1,
+		.aggregated = 0,
+		.group_position = 0,
+		.group_id = 0,
+	},
+};
+
 static const struct snd_soc_acpi_endpoint jack_amp_g1_dmic_endpoints[] = {
 	/* Jack Endpoint */
 	{
@@ -91,6 +106,15 @@ static const struct snd_soc_acpi_endpoint jack_dmic_endpoints[] = {
 	},
 };
 
+static const struct snd_soc_acpi_adr_device tas2783_0_adr[] = {
+	{
+		.adr = 0x0000300102278301ull,
+		.num_endpoints = ARRAY_SIZE(tas2783_endpoints),
+		.endpoints = tas2783_endpoints,
+		.name_prefix = "tas2783"
+	}
+};
+
 static const struct snd_soc_acpi_adr_device rt712_vb_1_group1_adr[] = {
 	{
 		.adr = 0x000130025D071201ull,
@@ -406,6 +430,15 @@ static const struct snd_soc_acpi_link_adr acp70_cs35l63x4_l0u0246[] = {
 	{}
 };
 
+static const struct snd_soc_acpi_link_adr tas2783_l0[] = {
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(tas2783_0_adr),
+		.adr_d = tas2783_0_adr,
+	},
+	{}
+};
+
 static const struct snd_soc_acpi_link_adr acp70_cs42l43_l0u1[] = {
 	{
 		.mask = BIT(0),
@@ -553,6 +586,32 @@ static const struct snd_soc_acpi_link_adr acp70_rt722_l0_rt1320_l1[] = {
 	{}
 };
 
+static const struct snd_soc_acpi_adr_device tas2783_2_adr[] = {
+	{
+		/* left */
+		.adr = 0x0000390102000001ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_r_endpoint,
+		.name_prefix = "tas2783-1"
+	},
+	{
+		/* right */
+		.adr = 0x00003c0102000001ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_r_endpoint,
+		.name_prefix = "tas2783-2"
+	},
+};
+
+static const struct snd_soc_acpi_link_adr acp70_tas2783_2[] = {
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(tas2783_2_adr),
+		.adr_d = tas2783_2_adr,
+	},
+	{}
+};
+
 static const struct snd_soc_acpi_adr_device rt1320_0_single_adr[] = {
 	{
 		.adr = 0x000030025D132001ull,
@@ -659,6 +718,11 @@ static const struct snd_soc_acpi_link_adr acp70_rt721_only[] = {
 };
 
 struct snd_soc_acpi_mach snd_soc_acpi_amd_acp70_sdw_machines[] = {
+	{
+		.link_mask = BIT(0),
+		.links = acp70_tas2783_2,
+		.drv_name = "amd_sdw",
+	},
 	{
 		.link_mask = BIT(0) | BIT(1),
 		.links = acp70_rt1320_l0_rt722_l1,
-- 
2.25.1

