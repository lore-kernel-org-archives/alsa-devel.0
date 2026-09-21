Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C200ECA5FA7
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Sep 2026 19:06:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B4301601FC;
	Tue, 29 Sep 2026 21:06:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B4301601FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790708773;
	bh=WknN3qNtH4JTLXmCCpLnNMgtMtc/j3sW2TuN6Se+G6A=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=j6kPJDVXb77DcvliHZjuL/FYlFw+K/W+3y3kLWaJexxBgnzG4ta6CuynZimDuVV/T
	 4YSSmzz82E5LjPNOlpN/QsEAi5mnx1zod8t6847Y7Oswvru1tBw4G8z2SH6SAzirJo
	 dLfqy8Ag0Q3ZB7YzzONKIWKQMSQVG2B7pGI9YB5U=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C056EF8067F; Tue, 29 Sep 2026 21:04:59 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2AE5EF8067C;
	Tue, 29 Sep 2026 21:04:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 54EBEF804F3; Mon, 21 Sep 2026 12:10:25 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789985421;
	b=oT6JkWLYu/+eg3MV9Ira7gjmYKrAOyV8Sw/0s2heiQzgKJodOAfvlVfmEZWVNMCjYzUd
	 MTr8JSOTf0txDmnw9btU7KSAG8ipiHlaOOnVaDJxB9Puks+eS2FinyZEBjy7NfgdVn+/R
	 06nWd/32FcpHICqtkjyEGBIaLwBFqCr7z7Lg+C9McGYJLQTSsNqfQcJ9Zt0p3ff/49bF/
	 Oydpsru05N2PsGpf6c6nJyoGidbZExFZogNFBh1drSb/TUw8ngUN+Kz6Heay0SejizPwo
	 i1vr2Po9mFwp/GCUtS18VD2STvT4B4yiSylreNwv4SGSnkT7QzEiSoW3I9yQ912bAlw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789985421;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version;
	bh=WknN3qNtH4JTLXmCCpLnNMgtMtc/j3sW2TuN6Se+G6A=;
	b=f/vWkjpOnr44PTmrFTK3Ael9HDEfne6jke1W2gFTTj3BDJ3bm7v80zOYNGUf7/T8LKs4
	 gzRycnwih56ohA4dDL6pShvGT4MOF6E23t80AwTcH/M5UjrLCHcv5UTS9H3Rais4UDCZb
	 DEEdGfy28wp9v5oI+Ps4ZGipY6KdsJwYHOPIllNJyFx94LZYYj90dZVLKNvgfVkFN81UD
	 yWvpajOP8VgBNlN+8eCU1Dy9OENvZfQbM5++shU83Am4xHsL6I0BgIc1M8HeLYtxb06BF
	 BLxHiIh1xfSd/qofKMIDPG0J7ZFHAciPbM/PdxCobxoPO6/+8auWUfFywkCXc6r/IgQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=hDwWFoi0;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b="LQw/5ePA";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A7619F800FA
	for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2026 12:10:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A7619F800FA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=hDwWFoi0;
	dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=LQw/5ePA
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68L7AwPF3481723;
	Mon, 21 Sep 2026 05:10:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=vQhFS+7nUzU/S
	YUQ4RyjWlG/MLsoj3wi6dIM9Pmxaas=; b=hDwWFoi0aWOYL3juptcoPdRlxSmlb
	j5NcswycvF9nztoScRDASfWBF11D7+U3lbg1C2s0nCxEHALQ/7CUPugimSks79ih
	n68Lb8xEeoHoXrLPI01Odr7lqRefS84vuUAMrSNlTucawpp2hdYpl0r8/MJXRLeU
	mS1MmF99mnetQVztmzswOlHFH3ol0dglg39E20JX2QDR45ITepwwj4h2c6JThc7P
	CmFOtKgep5edaJw4LnknWAt7Le1KIn7IiTur1krGDYJ1nVCDVqrW3zbEqJE+ukTy
	RIB010YKHWmYplPZqOneqLZA8A7mr8bX0eaAUCaz9C6b4DQR6j9Cci8hg==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012015.outbound.protection.outlook.com [52.101.48.15])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gt9s5p935-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 05:10:13 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSAxwE2GGjI8213y8Y8/HQfIHrn1YKrFHT8+VyWJRcBylYu4XdUQP4m7Fx6rSfoQTIHpAmfW4ca1K63Ex73s2XK2ZTTOFiAGjLWWi/Yp6kCXa6uKiHZT4VGi+TgsQB76UJuVSp+a6tCXk2S+79YL1hJp/O3YAsaWwft0/cC8pr4JnK9aT4hWu1Hj31QM7MNiSw/D5k2FUZSPifVyo6btdt0DnDap2z1jA0CYLkfeFosoTkQ6N98Pue36/5S1DvzA+3ANp8AbeH+ytEv7qgHwim3oMTxtrrgcKLHHqIrnQuBqPji8XT/wl2vmslvVwX6zXG99HDw+qFQIcC7Icb5DXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQhFS+7nUzU/SYUQ4RyjWlG/MLsoj3wi6dIM9Pmxaas=;
 b=I5RJmwpb4RHd2aHPwTLj5c24R+TBdK5mVFiBLvYG063EAhVE2hw6TwEdfTUkfHM3RfEP/maCQAVmu0NQeOLppgUc4tX9ct6GW2MD16LgTFlV6vigCCtFrI+WRT9p9Vpct1tCM8RKVJk6OR5IxXm1YP1PHe2gzKEmYlgRN5QOO2Bz5+DSjtNGOrFI1i1Pa7Ep1dpoZbD1MQfY1mSS0JGXEFR3R7foikaqElSF+CA32/ykR8Y+WEeba1jBEuO/jspGUXn2MhIKSOenFz5l4xtSL1E3L3h/bLZw4eDixRqH2jjlNolR9LUJp/blie/uPsnMIAiSvrlyB1l8PI/rLPjqIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=amd.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQhFS+7nUzU/SYUQ4RyjWlG/MLsoj3wi6dIM9Pmxaas=;
 b=LQw/5ePAuOvUT9tE42R/0N+tS0Hi/XANYtWxeV6pGlnc1ayTyB46p1yv2VaQbFNon2r3vmqX8+e8chm4fPcMjKikYe25+/HpKJsK7pvtm9rwwcCLN5+CRcvGqtX1bq1J7UaWMPR10zTNj3TXseU+Nt/GjH5IjvFEoGNHblnUr5Q=
Received: from BY5PR04CA0030.namprd04.prod.outlook.com (2603:10b6:a03:1d0::40)
 by MN6PR10MB8165.namprd10.prod.outlook.com (2603:10b6:208:4fc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Mon, 21 Sep
 2026 10:10:06 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::31) by BY5PR04CA0030.outlook.office365.com
 (2603:10b6:a03:1d0::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 10:10:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 10:10:04 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 21 Sep
 2026 05:09:21 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 21 Sep
 2026 05:09:21 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 21 Sep 2026 05:09:21 -0500
Received: from LAPTOP-70RJ5B8Q ([10.250.165.249])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68LA9CvV2751537;
	Mon, 21 Sep 2026 05:09:13 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <broonie@kernel.org>
CC: <tiwai@suse.de>, <andriy.shevchenko@linux.intel.com>,
        <13916275206@139.com>, <alsa-devel@alsa-project.org>,
        <shenghao-ding@ti.com>, <baojun.xu@ti.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <k-yi@ti.com>, <henry.lo@ti.com>, <robinchen@ti.com>,
        <niranjan.hy@ti.com>, <pin-hao.huang@hp.com>,
        <Syed.SabaKareem@amd.com>
Subject: [PATCH v6] ASoC: tas2783-sdw: add firmware download status check
Date: Mon, 21 Sep 2026 18:09:09 +0800
Message-ID: <20260921100909.986-1-baojun.xu@ti.com>
X-Mailer: git-send-email 2.55.0.windows.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|MN6PR10MB8165:EE_
X-MS-Office365-Filtering-Correlation-Id: c017159a-2e16-47a3-0a95-08df17c881d0
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|10067099003|56012099006|6133799003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: 
 Fwr9GvpZ0JJZlEkC1bufJqKIhD01o3d1jXc1VEimO/THdL0vGiHMlJ3drODND5AoD0LILzrS/cvCraDS3oWGzECMpEEBzxjOnsx3+x6qjhGhjGUzWtrjEWavO7nwHqqC/6Dm+rB2GfUhF4OlyvM87UOFrrl43dEp3gDe178IeFysX1sNGXHcVuU0SMPhomoqMXWmuolqP9H0X5zpmW6SNifgpjKYt+yCmFjBhaSZR9LYqtqbu9prk8dJ9UfvOKYdpKECLF3YLEwgiEK1wFLAlMCJcHEFCBKleGr3Irwg6jjSU77ecc7Dotv6vXgnnN3Gw47aO8UNzATi80CwLcBH6cQgn0v9nGLhFcX9KUjpRUKVphk22XSMrzly3LkslSuCJXmIM1SqZAt6YveET1mKHJ5BU8+v9SK/sEd9Tcus1tE0JUAm9tkS3E53JWxJlSrfInfOdhLE5Ey4V0nVxuA85K3fbUe4tZbsHuGu5ZfOkkrF/s6t19zNEMwqR80yDFt9+Ju4x6UySInnQ/x0hNJb8WEweFXXhaES3EGX2vRxSFMeSuNCmVtuHD4z+EbHpd6Dk3iUHKKjhgaIdNp0u/t8LFPwbwc/h9R/q9nVxaVH/UeO2N9lGAtbWMNweDsvARjUPgUebBVT/gHbQlGcSER8HyBExKbE49xsV6ga6wNH3j7ubbyVhX7SlAwYwHY2yMGFdroWU/MXMgDsk0PkWcUY1w==
X-Forefront-Antispam-Report: 
 CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(10067099003)(56012099006)(6133799003)(3023799007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 Pi7jg2EGbaN0H5D/aytR3L53MBdmGQ4b4g+fI+4kjHw3FRLwSZ9O6n4pljY107kW7KEFxm2WFZEU0rtworBvspBaj2UREGy1ZIuI7sj57YG0W61NUZyWFH2quVz4BM3Je5zLRtJ5CeiMixDlswQ71E2p5DNiUy8KVRSGPlgOs6gsghKaP6HDAnrAAP1FLr0TplIxEoBIqrVBfZee5zsXVZI5TlwrPW4A/1XLg30PIIDxiZLkJeaKW8WHzPCWd4XUQUADoKqAhdJvpzIVbhO0Fo44yd7Hlz1pipw7a9ztqL9ZKkWOlI2e01sejAEkqNYcH8frdauoy0pZSo19wpgKsl14ZtXsXDmr9Kw/5HbyxX8pLKklCKBCrPtf2CIyJ/AQLYOeiFNPJw6Jk45mphPf/uBduReiWTxLh0R17wonEJyNUIZM+o/5bpvdTZJuj//6
X-Exchange-RoutingPolicyChecked: 
	PXnzmxROaXd0ArJTAGJzsVcakAHBl6PRglBekAy83j94GOqEjueoweja+SnxPF7jRDGfiD1LKlQHdvH9yjeEVRh9RmZK6yJ6MvMOIHKXznE4NCA4GFaR7elwd0ARiYYc10BHEKo5fUfndM0GoJd2ppaY37e0kSWnjSWwNn5wUt4YuWVwru4zxzIQXmhe5lKubn3VWETt98qA6My76UUPghOtDixy2zN7y83vylFsjNS8zxuoPMson5YTNmtZG+pPALfy2SV37KxMMM7NhkvIAGLZCag5scEcds+c1ALIlsZnlm2l3Q8BI1gmx9mcZMQQZsuxQi1aA1FL38VDqC3LfA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 10:10:04.7381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c017159a-2e16-47a3-0a95-08df17c881d0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
 SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8165
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE0NyBTYWx0ZWRfXwZLepCsTnElQ
 GDyWqvUl6nn4sVJJyRldd2eTHcNUixFM2AWyCua+cAjaDDt6UDJKAkz5sYSZTxKeajVpo7kLFnI
 Xl2ixeb6IpXC96IAEFljKo4eR49T/k3iQPwfAvNNA8/XFKRpFtr1KgKwJhslGadVlBZoqKajOjN
 0RpQkcDN1TPRVjLEYSs389K5Tl3dE+SZuevLjxpKgf3R+sXAS8YR0MppuXZ1Qe24BDQ3YoaJ6KO
 ja4KWrb3ay/k0PbbrE7PXWFHuxxiMjmV0vJ+wKDEDe+/mv0slWowdNzVILyS2BomVzC9H3lOZCL
 qUCWz3z6Xo7yMZyaz5ZLRYkpH3kkCEZNeug/AGkSxlvd4n8W1jgzPS3Z9yZUOaqE1cdEUwqWMIx
 2eWN31BfCKrUUKVuhM4G8fYqS1RlOfKPnQlaFHWNJACgU/JC437OvAX5oOWQWqzJJLJo+3Ok4Gy
 nTkS2pLn8iKsj/RzMng==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE0NyBTYWx0ZWRfXzx54gq3XzOm7
 S+4OxyfGf/kIYxSdA40ZpXwYMTKxPTHHaYWmYdEgblpBVbHHx6lScg2vV5knsmYItrf0eQH2VAI
 p/7Rrw9TWF7UUb9DNiU2T9a7e3B76HA=
X-Proofpoint-GUID: 2vQJuiciaKk1NV35yHjgkOxVkeesz1_B
X-Proofpoint-ORIG-GUID: 2vQJuiciaKk1NV35yHjgkOxVkeesz1_B
X-Authority-Analysis: v=2.4 cv=X6rHu2Te c=1 sm=1 tr=0 ts=6ab10285 cx=c_pps
 a=cLI4zmX3yytpP84iY95SKA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=xTpt9nq8K6IhJSBj_EAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210147
X-MailFrom: baojun.xu@ti.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: RTU765EXOEKQPCQYNYLDMOLCY3Q6KBCZ
X-Message-ID-Hash: RTU765EXOEKQPCQYNYLDMOLCY3Q6KBCZ
X-Mailman-Approved-At: Tue, 29 Sep 2026 19:04:42 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RTU765EXOEKQPCQYNYLDMOLCY3Q6KBCZ/>
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
v6:
- Exclude PRAM and YRAM from the MBQ register group.
- Revert changes to usleep_range().
- Replace uint with unsigned int for kernel coding style compliance.
- Remove AMP reset logic from the driver remove path.
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
 sound/soc/codecs/tas2783-sdw.c | 95 ++++++++++++++++++++--------------
 sound/soc/codecs/tas2783.h     |  4 +-
 2 files changed, 58 insertions(+), 41 deletions(-)

diff --git a/sound/soc/codecs/tas2783-sdw.c b/sound/soc/codecs/tas2783-sdw.c
index 85ab3fd83c7b..2f6c7811cd38 100644
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
@@ -517,7 +518,7 @@ static const struct regmap_config tas_regmap = {
 	.volatile_reg = tas2783_volatile_register,
 	.reg_defaults = tas2783_reg_default,
 	.num_reg_defaults = ARRAY_SIZE(tas2783_reg_default),
-	.max_register = 0x41008000 + TASDEV_REG_SDW(0xa1, 0x60, 0x7f),
+	.max_register = 0x41000000 + PRAM_ADDR_END,
 	.cache_type = REGCACHE_MAPLE,
 	.use_single_read = true,
 	.use_single_write = true,
@@ -745,6 +746,7 @@ static void tas2783_fw_ready(const struct firmware *fmw, void *context)
 	const u8 *buf = NULL;
 	s32  img_sz, ret = 0, cur_file = 0;
 	s32 offset = 0;
+	u32 val[4], fw_version;
 
 	struct tas_fw_hdr *hdr __free(kfree) = kzalloc_obj(*hdr);
 	struct tas_fw_file *file __free(kfree) = kzalloc_obj(*file);
@@ -786,6 +788,11 @@ static void tas2783_fw_ready(const struct firmware *fmw, void *context)
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
@@ -794,6 +801,13 @@ static void tas2783_fw_ready(const struct firmware *fmw, void *context)
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
@@ -801,17 +815,34 @@ static void tas2783_fw_ready(const struct firmware *fmw, void *context)
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
@@ -962,30 +993,6 @@ static s32 tas_sdw_hw_params(struct snd_pcm_substream *substream,
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
@@ -1074,7 +1081,7 @@ static const struct snd_soc_component_driver soc_codec_driver_tasdevice = {
 	.num_dapm_widgets = ARRAY_SIZE(tas_dapm_widgets),
 	.dapm_routes = tas_audio_map,
 	.num_dapm_routes = ARRAY_SIZE(tas_audio_map),
-	.idle_bias_on = 1,
+	.idle_bias_on = 0,
 	.endianness = 1,
 };
 
@@ -1207,25 +1214,30 @@ static s32 tas_fw_load(struct tas2783_prv *tas_dev, struct sdw_slave *slave)
 static s32 tas_io_init(struct device *dev, struct sdw_slave *slave)
 {
 	struct tas2783_prv *tas_dev = dev_get_drvdata(dev);
+	unsigned int val;
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
@@ -1234,6 +1246,8 @@ static s32 tas_io_init(struct device *dev, struct sdw_slave *slave)
 			ret = regmap_multi_reg_write(tas_dev->regmap, tas2783_init_seq,
 						     ARRAY_SIZE(tas2783_init_seq));
 
+		/* Re-active AMP after resume. */
+		regmap_write(tas_dev->regmap, TASDEV_REG_SDW(0, 0, 2), 0);
 		if (ret)
 			dev_err(tas_dev->dev,
 				"init writes failed, err=%d", ret);
@@ -1413,6 +1427,7 @@ static s32 tas_sdw_probe(struct sdw_slave *peripheral,
 	tas_dev->dev = dev;
 	tas_dev->sdw_peripheral = peripheral;
 	tas_dev->hw_init = false;
+	tas_dev->fw_version = 0;
 	mutex_init(&tas_dev->calib_lock);
 	mutex_init(&tas_dev->pde_lock);
 
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

