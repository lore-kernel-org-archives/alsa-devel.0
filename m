Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC5FDC43458
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:54:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EFC466020B;
	Tue, 30 Jun 2026 13:54:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EFC466020B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782820488;
	bh=CtKdkGs2X4u5hCONFlpPC2m29zgorXbfFtPNxazICnQ=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=cIWT2m1wL5VFVWZvBbVCb6PObGSMB/l3m1hUZrzAq5FRpy/vWajg8wwhp5m7A3ynI
	 heWE+3Dz7A7gR28sq88N9s8YnnBxAaCIo6Bguh4tkuCZyk8HqVdu22Po5R2nxzVUtA
	 qXXqpNPpYuIpDgetAMfFgQyiOdCQL471HJuCjsvk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 87189F80687; Tue, 30 Jun 2026 13:53:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5486CF80685;
	Tue, 30 Jun 2026 13:53:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 57BD2F80510; Thu, 25 Jun 2026 12:29:11 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1782383349;
	b=bsm0Z/lNiODhydk2MuPVso26vg6qcMu8azLPxTqo9dEIdousDr7rlMGSPSufvFF78xgG
	 cVjj53ZZjkNVW3BjnOJKdyiMBbj7HeHr+BQMTOd6PO6IiC/hsSbzc1sw+n//8gaFz2jKm
	 cHsfCC5O0MDF91dhwGaUoaJiwETBR5Uu3wx87roQWx3yixdQHFOt0Dde+ZZrY/gSAqxRk
	 PW3CNubAZzUO5LQU0g2kcYfbms143VglYfeJiq1zzeRdEoPrNCQOkmSxxTAO/3L16/gWZ
	 c4WDbjn6YeBdUpcx+VDCuEnV2I0Jv06JN3CxVtJxjjXLCS5xgPVHu3mBDHmLqj0CTbw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782383349;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version;
	bh=CtKdkGs2X4u5hCONFlpPC2m29zgorXbfFtPNxazICnQ=;
	b=rnuCOe4wrrMLhvh6bXx6xjaWT2OgbXqqhAl09zvl6u8oDM1rYZGpHGsZp939REn/T+u/
	 Tsm4u6mIhOKRn3Ny4OsxRCZaYgDU1c+Z7QzMN/z5Ud8RyeDaW71M+H8TVTpQ+wg9agIGA
	 8imbnCvgTVWxy1ghaFO8sUro8rDF54lsBAwCwRFxO7QX2A/HzQQDObHFnKyRTQaxZ5Urr
	 ky7/5Sgjn8kE2o/yVZvYRAu6C2vgPhE2GmQZKXVw1UVX9+xmJ6hRU/CGjzxLKzP2Uv8Qs
	 GNpnoqqn1EKs0SYLc6PF6yliFnWWjF5CB5zUY8l2fVyTcNbg4vlT+OexKbYClFipjNA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=MGfeVXw0;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b="tonEav/Q";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3B192F80100
	for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2026 12:29:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3B192F80100
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=MGfeVXw0;
	dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=tonEav/Q
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65PANJwe1093328;
	Thu, 25 Jun 2026 05:29:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=nwJ6BeQq0nHfw
	2oFwTbCeM/W0/y25Zk1/H+ovMipWn0=; b=MGfeVXw0304AyqZg7ZJb5zHgyWV8I
	G6s+Rfa3FvvmceZqQYPipu0B2UJi5jADn9Pl9jWSe7FiAtfI/dpMJ32K/ez5rjQX
	vBoTz52vtWMrQrcswEOEUasORCfjapAlx8hWeny9z4rNAv6nUS/2vo0uNNC4zGV1
	PFixPwj+1ranb9FQ60HncolXljVuOvwbvju9K0WPX3aUfUk8jxdoT/4hbvscpwnZ
	bPFoOuqlNOb0m7UWAgldfeTxjerscLGRRLPGsfAXK9L0LxYAi60BEbkD5ge/CnCF
	3Bi2KEKc56whk7+rbocemuovQNRbxoSPjHbAw58sKbTN5nENXQtPIOrhA==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11011051.outbound.protection.outlook.com [52.101.57.51])
	by m0384305.ppops.net (PPS) with ESMTPS id 4f12hfr0xg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 05:29:00 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNORSoy6NIaqCS8Y4LO6uEGlxGOZoh12NVO760cDG3S6c+hcdVexX4Negq5iXMqR4XZTcJ6zbWeK5HVyhXJJswegNsXuIm94RcVc6S6tEHGlImis8/B/LLYAYYyn/5J0rlS4GSx8MYpHsMQw1b9lpNGg3zjpTgW4fxbUHNoDHj/EsId6wFdU4bfVJPsI53qq0rff+kctgcMBMCI0abQJlyYA1re+tKkWdEmdj4DRlVTq5RK1CiX3bm6c0RSQWtpWVsx0xshRtruPdv6kCIooYEpKmLXqP0yK4PTOAlg6ism0BSJPuWwZ7RWQ1+o15HUslffTmTu7Vt3e3N2Sn7evew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwJ6BeQq0nHfw2oFwTbCeM/W0/y25Zk1/H+ovMipWn0=;
 b=mw/hSn3F6namE6pxCQ73GhaL91M4n1bHTxnZeTvkJuHXgZc6lz10wdf2kxpWZsqd2aQEC3rS8ZSmz9tGFQclRoJQnsxC0wdZ7SFIUnZM6h6Y7HtxIECpyU+WNlFUvrZFGBCCq4vRK34UQeB+cODQzMOf/I3b+I/F02o517MPaNMoxpa7Vi/HAiSZHF8+H1+CZxi+7hgM3cHSVyCE6ILlhc6VW2rd6YqOfHE8Qv1o1QEKbrUNBTRdYMNuJ+2pFPQD6iJY3hU7/Bse45tREUGHmSQEULTxdYtp4DOb6kyJticaFnRrbnLk1DHanGxMv/AqNLwqaHI64yMvEMkMN/bTfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwJ6BeQq0nHfw2oFwTbCeM/W0/y25Zk1/H+ovMipWn0=;
 b=tonEav/QQDD8JuyC38/qcFtnGkiNuEsANpJE1XtRtsk/Sid9Osf7pVKlIu0l1CJqOQtVpRMtwMvuSeQWpRKhQG+CxOAKbM0KXz0WWklI92KJyxuE7D9zXeHPCSGEQ2LB5TK89oexNb8CZqdyqNAQmoGlcy5miWU8sVcReHQ8XvI=
Received: from MN2PR14CA0003.namprd14.prod.outlook.com (2603:10b6:208:23e::8)
 by DM4PR10MB6181.namprd10.prod.outlook.com (2603:10b6:8:88::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 10:28:55 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:23e:cafe::55) by MN2PR14CA0003.outlook.office365.com
 (2603:10b6:208:23e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 10:28:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 10:28:53 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 25 Jun
 2026 05:28:47 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 25 Jun
 2026 05:28:47 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 25 Jun 2026 05:28:47 -0500
Received: from lelvem-mr05.itg.ti.com ([10.250.165.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65PASfkU2526656;
	Thu, 25 Jun 2026 05:28:42 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <broonie@kernel.org>
CC: <tiwai@suse.de>, <andriy.shevchenko@linux.intel.com>,
        <13916275206@139.com>, <alsa-devel@alsa-project.org>,
        <shenghao-ding@ti.com>, <baojun.xu@ti.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <k-yi@ti.com>, <henry.lo@ti.com>, <robinchen@ti.com>,
        <niranjan.hy@ti.com>
Subject: [PATCH v1] ASoC: tas2781: Update default register address to TAS2563
Date: Thu, 25 Jun 2026 18:28:15 +0800
Message-ID: <20260625102815.20043-1-baojun.xu@ti.com>
X-Mailer: git-send-email 2.43.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|DM4PR10MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff12800-9d27-457b-b3b7-08ded2a48e8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	ROvsEHCpfGRFNt26xFXRxJVYop1xOy6pIkYIajft6mbEWhyFvjBodgOluM/ZHH0fxVYedWxwuV5OFNcgKjOaW+M7ENmytLa2rBfjbT/6JHSWLB4JhETBrZT6iNSNz2n7bczTILhpvnNShmElo9HtZ1NTd/oEoVYfOSH8MaVKFTwr07s5uv4DWZ2vAAJtC/ZE3XJ1SHrONMD/hkglLtnIZ0rVr9Z0mioYwacz91LzD9QbhrdaOdNiDm5Nw6Vlw4GF/njRGrHdH6Vu9MNBxK27WCOp8j9v/8RzkFlQUXf1rOa9226En+OcguDUQO4S2mSiE3158BNVLEn8RrUvoJo2/wov4EsjCM/j2d/xqVvBmskNDkdP+gGucBPwcJLKNhloMB7SccgM4O3fzJlJOMFftlk+7rGbW6Ro5vNhjXOpQ+zW5+jKJeORv9db2C4g1IBfBBEa24d4q0WNQtH3qab5EjmZvusMzvBM1BR4VPTPhDM8y2ARh0o6EkbEG0SMGFqY8+Hbpt1B8dVwfFucqSICremhDXYHznNb8hBbR/vFlcYH9ZwchY6WnyKjjfYShGM+dpuJlc2UVY0cyxIf3s3yyDUmmefN0dv3HS/DzG66UxO2nhtxXu+IH6RVUP2IlEF4zomgOwI+yqeyuwoWgPLL++AcZkC98PwER1jst7njwkBIUM580pPz3EJmuFf5ql2WrWr+4X0WT7YTPIR5RhPC1w==
X-Forefront-Antispam-Report: 
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	KtlDkGEQuA9A9zO/61nlMxngcg6wThzxjb9DKLMDBqCQ7pkix2ICOjoNhZMhVH7cPRtQvUwXcNs75cRf63zKf0VbwxdyJTqnJKIZZmLLf6hUZ63drWeASYvafy8/2jSSX3WZLFPtP2BESuPYupRCccWFqrLUYp+Qpcc2B9nfvFNi0Sa9wEC0pnwBFCT7/Wis9kRbrBXwj4HT732i0CmLyZzmcZi7+6dSrHiLHIaurOqoujsRwgYPnl0RGzloMUOqi0h+rl2mRDu/g1Iehyd3ox+NtoPcM4UdnvdfJcDogyfA32iYcVdLJRUXQ/7385I+im9Ok2WcUEuj9UbmHCg4U9BCJCM/pyv6sgE3UY9Yon7B0DzwFWKpiMZ+ebE5veQAYXQlcAsZDPhaqy8DYZEfC+IkwQZ9jDiBwDqnw1euxtPsZ7ai6eMTlInsCbxBnaHD
X-Exchange-RoutingPolicyChecked: 
	ZErcgmldZULaa4aWTPlkm3rmiWRQnZh4xlfPGKST5Cj2BywKV/j6u2DKQClRgToXZaFIqgPRfSQoTRCGfaqc/B78kbm7eVclwdeV9R9PAF89n7mxGWbU73InbFjtIE5uQiQuuc24707F4fWvZkAJjBWWH5v+zWoM3MEoGzbcaQHw+GRRhwFlB/jZ9IjdWI2OqWxWGH3X22uW/3fr5fEDwKbVXExDM74rMJEyt0zAfBR9r7Yfeuo8m4aIW+V+qdRTQbMS6f73LB6NyjrKZ7S7TmaevawyZ+sGeeuUhkifh0bvUdMUN7u/6JjT6+YllEfVj0SybI8nfWhvdf/JGoOp8Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 10:28:53.9982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2ff12800-9d27-457b-b3b7-08ded2a48e8c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6181
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA5MCBTYWx0ZWRfX2cjWeh9NGds4
 A+rn8TA3mqEe+PqZR61gTXrGz1nbtxU00BVZX3u8N2qE1FXPTZjr6R8aq5y5va/S+jahoWns5/s
 0d84fpS+qqImbU3J6jzfnrI/hSY1HYpVY0zBOHD8Qb3YQcSqKZP+vf3cyVEBx/c7eao9BLTX4Vc
 H/bKoEgIVfCnzFHPk5kSuqSDVy4yO/HWs2E+dToMqMQ5yvBOTxKublevZ9F7D+XkmcDEnIAgc6M
 YC/G9uUT21Bng2zRkpMaEAOPQ61CxiEtYauKnIA6iuUPKi0ssQfQ6H6KKUkPiy8R4m04SBGJ0/J
 L0sCfYQS8T5RRUMdpx8B56pfw304A+L9RTuN0ETTQjhcQYMoSXzZG1kKuyzWu/DCmJ7wuwRCmk/
 fPDPYdrygCBcVUHf11fjwZNQhNaA+/YcqgdTnnMGMjSVajnM3gF7QI671gsRa72n1FuOwLQxoFW
 rbh0PF9No7EX0HHEfTA==
X-Authority-Analysis: v=2.4 cv=YeqNIQRf c=1 sm=1 tr=0 ts=6a3d02ec cx=c_pps
 a=aOchWjQmdX1ADhYh+yUFEQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=sozttTNsAAAA:8 a=tSOKsbN2ZdipfDFKYTYA:9
X-Proofpoint-ORIG-GUID: p_Uvnc9joL82zW77ToHxfDAYQgQcUrXJ
X-Proofpoint-GUID: p_Uvnc9joL82zW77ToHxfDAYQgQcUrXJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA5MCBTYWx0ZWRfX7G7TnNCsNsmA
 Y6P3ZYXGvmtfsk+A0/LFvHs1xO2aEOifm66Nv7mAkmY2wcTKYMUJzuRDLxabPLov3N/R/yQEpnF
 K2pxYrxk6t4SORk31jxAauaZ5pZv9Wo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 clxscore=1011 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250090
X-MailFrom: baojun.xu@ti.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: NLIQ7HQ6VFBITJFJVYMZRYVDQ7KH2JLA
X-Message-ID-Hash: NLIQ7HQ6VFBITJFJVYMZRYVDQ7KH2JLA
X-Mailman-Approved-At: Tue, 30 Jun 2026 11:53:36 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NLIQ7HQ6VFBITJFJVYMZRYVDQ7KH2JLA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The previous TAS2781 address is overwritten during calibration,
so switching to the TAS2563 address is required.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
 include/sound/tas2781.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/tas2781.h b/include/sound/tas2781.h
index d45f805b5d18..b763da613769 100644
--- a/include/sound/tas2781.h
+++ b/include/sound/tas2781.h
@@ -59,9 +59,9 @@
 #define TASDEVICE_CHECKSUM_REG		TASDEVICE_REG(0x0, 0x0, 0x7e)
 
 /* XM_340 */
-#define	TASDEVICE_XM_A1_REG	TASDEVICE_REG(0x64, 0x63, 0x3c)
+#define	TASDEVICE_XM_A1_REG	TASDEVICE_REG(0x64, 0x02, 0x4c)
 /* XM_341 */
-#define	TASDEVICE_XM_A2_REG	TASDEVICE_REG(0x64, 0x63, 0x38)
+#define	TASDEVICE_XM_A2_REG	TASDEVICE_REG(0x64, 0x02, 0x64)
 
 /* Volume control */
 #define TAS2563_DVC_LVL			TASDEVICE_REG(0x00, 0x02, 0x0c)
-- 
2.25.1

