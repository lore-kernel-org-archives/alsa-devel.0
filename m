Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA7A8CA5FA5
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Sep 2026 19:05:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CBBB36021C;
	Tue, 29 Sep 2026 21:05:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CBBB36021C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790708753;
	bh=F6XN/9mZ07pJBbRAkTMnfZxwVyY7Dks59qH1rfB+ra4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=UmtKdwhy7GJvap9rNLzkOowSF6ElLaj4mZs+c6RCZHeWXhREoOTHhQqSWL4V25rnC
	 6k45LE055BnQPKhXZapWcJdowWsrGiwIUfzsAbFcPScQoKeTe1K9/3iJaEEeJ1aX3r
	 FQ76pbKha+eJTjhnHWEQS14oIm8agbzTMiVEzE+k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5198CF80652; Tue, 29 Sep 2026 21:04:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E8012F80651;
	Tue, 29 Sep 2026 21:04:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EFD4BF804F3; Mon, 21 Sep 2026 12:09:32 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789985368;
	b=cEQ143uieaNWrmd8aRZQO7bZzWrweQ08qfgJDRJraehGXyBoRBF/2ZZDMg8HkOJCNe1C
	 0ur/v5rWeaCcD7irV+Njn66hgDnTKPnPG863TONDgF9Lma1nDEjEs52CyFKPUBFgx7L04
	 YcrLBL0fQkEGNrwiBmvaSZeGpcp+141A5tai2UulLcgEEKjtsesfHquZJmJDTNgZpGy8T
	 kpVSVUuwgE/wvMN2rTBWq8BT4Of+u4bVRwqzhcOzN1Tpacpno06a+D5g6iilVmg3pmzBO
	 LaeHR7Jt84pupl788HYAqESAunC7dU4FJssBS8qncVDlDWBJD7/vNjqHJ1faFXcQbSQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789985368;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version;
	bh=F6XN/9mZ07pJBbRAkTMnfZxwVyY7Dks59qH1rfB+ra4=;
	b=Zx5cdAaFzFevUIUiaKO+7x2Ju6+x/SY/XCa2SlpEtpcYckh7AVGf+Nuw12TwUzBnvme4
	 dY87kH9O5stAR4ougBUBnp8VoV3+ssR+59LE22VuiDYNR6hSFCOM3S1YArS5hQhS1QcKC
	 QAtpNlv/Sxed1sQfdI+sTRKRw5Xr2rwCBz8CPgOtoiuxNt7SChd0JZzJa9vXMSMHqOAqA
	 +UicpoUvaz16S+7z1SXn9qRF9TSXoypCz4c2kXfbxmB6ed1x2L2dmCMw5+ExXfRbZrXsS
	 bPe4PryMHEmPHP/aeufj5box1WLnKPMPMRqvBHti2vpZgvEZEDQZGDnA8GpuuVGFRaQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=XNpypZSH;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=pgNH9Bc0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2CC23F800FA
	for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2026 12:09:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2CC23F800FA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=XNpypZSH;
	dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=pgNH9Bc0
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68L7ArB52998619;
	Mon, 21 Sep 2026 05:09:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=BOtbyDSyrvM1qf0BsxIEXtDUSEdeSZVORvF5gNngR
	ys=; b=XNpypZSHlTw+8TmYwcsVMJsbC+9+4sw9YxFgAS0jqtdEeWza5GL0o71X/
	ztsZjJkD/rurqiG80wGEVWncIq2Rh3Lui7rijtdWe/3r/wTcTGXrYarmyI5h2B5R
	vO/4TPyVF0CAzUh7MoqWr4iYt04nPWqrLPIMRqnWtv2B+BEPXXujJR3s3NVeueaK
	2vnEG3Gffrn45ucU8d1AEFW0GXyFll7Svcn5kqKOAJcCvp+l2Ba0/UhX4yrMiQ8C
	T9rurJdTYxpa4IpzCoKwsMEeCnDsPjGtNmvKlpdq/+K1UgmQ7PQoyV9pYPl9yydK
	0/zR1qtQRtsdpqDZtt+w3FTFGzHng==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010071.outbound.protection.outlook.com
 [40.93.198.71])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gtx9f9msj-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 05:09:21 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfrF1Ob8ZCsVmTkAQfOgSGTj0tgdDJE5f9zqdL/5JaAtQ//zmzC9+STnqzuGwOQrNKQigHmaTkgvmcmPl5JJBj4MPI913YfKgXpt8Y3v2z54x9dh/o0+3oEBlXo48RlxkSvM6WZK8KCEryhhnf0n5Aua/CbZroRfn1uWldw4fe3niJguKRmA9aekiTnP0AL5xTi33g0i+P6M4slFPIAezQA717jsLCwJ2P6Yl+/70CFvgft2Q1togW9xNHydCn62Tq4ntxzPtLVP63Rgsg1ghXbw2dUSIIT4v16Vh79A31Pe3YOgQoECqyehMH29vgB7njl1o+w/TZq1dyR1C6PrFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOtbyDSyrvM1qf0BsxIEXtDUSEdeSZVORvF5gNngRys=;
 b=adMbDdlWD0/9GjJ0TVfPEDegLGhndboWtRzodqJ3Teouk/X/YMwtv/B0JybQc2kVialOVQ/jdXRKI6KkdPfZ0AudaKa7WQomPXBNYKG3S2ieyfXOAKWSZ5UO8t8iEhom2FCtLcgMg0e1kYOCGOecVpzfBeK2fU/4cYH46X0i/1lu6JgFQ3J7IxPspqAs93r+EXL5xR4lWOV/o7ULCd47Gn5+eMW0+DcKI4wbvrHUPinorW48r8xsLkmyzE+A8CslhxKFCwJw9pkfMbfzxlnqR1KZzc0hdNz3Kpp2fz+f2HIciH9n1w919WYWKcpDaU+LdQehNNwXzlSWU7X/ze29hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=suse.de smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOtbyDSyrvM1qf0BsxIEXtDUSEdeSZVORvF5gNngRys=;
 b=pgNH9Bc0YPKguJfe1E6jJcGHJjJyGNAey0mOY+6JkqK8+cLvYQlr9ruEMvfe9YdLdcQhfe4x3gCb2PheKNqdbTRstazWT8t4xOea74XdxQ5R00VLrFijAhQxDb+XMDTnWJj6JjtuAtEvsmN1geuUCz9SQ0dRZ7PG0LXF43PY8N0=
Received: from BN9PR03CA0085.namprd03.prod.outlook.com (2603:10b6:408:fc::30)
 by DM6PR10MB4121.namprd10.prod.outlook.com (2603:10b6:5:21d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Mon, 21 Sep
 2026 10:09:17 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:fc:cafe::52) by BN9PR03CA0085.outlook.office365.com
 (2603:10b6:408:fc::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 10:09:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 10:09:16 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 21 Sep
 2026 05:08:54 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 21 Sep
 2026 05:08:54 -0500
Received: from DLEE209.ent.ti.com ([fe80::9756:3b42:e53b:3cbe]) by
 DLEE209.ent.ti.com ([fe80::9756:3b42:e53b:3cbe%7]) with mapi id
 15.02.2562.045; Mon, 21 Sep 2026 05:08:54 -0500
From: "Xu, Baojun" <baojun.xu@ti.com>
To: Mark Brown <broonie@kernel.org>
CC: "tiwai@suse.de" <tiwai@suse.de>,
        "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>,
        "13916275206@139.com"
	<13916275206@139.com>,
        "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>,
        "Ding, Shenghao" <shenghao-ding@ti.com>,
        "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yi, Ken"
	<k-yi@ti.com>, "Lo, Henry" <henry.lo@ti.com>,
        "Chen, Robin"
	<robinchen@ti.com>,
        "Holalu Yogendra, Niranjan" <niranjan.hy@ti.com>,
        "pin-hao.huang@hp.com" <pin-hao.huang@hp.com>,
        "Syed.SabaKareem@amd.com"
	<Syed.SabaKareem@amd.com>
Subject: Re: [EXTERNAL] Re: [PATCH v5] ASoC: tas2783-sdw: add firmware
 download status check
Thread-Topic: [EXTERNAL] Re: [PATCH v5] ASoC: tas2783-sdw: add firmware
 download status check
Thread-Index: AQHdSZQveSbSEr4aTUSMIwBcRdMz/bbZC6QA//+zpMeAAFhOgP//s9/d
Date: Mon, 21 Sep 2026 10:08:54 +0000
Message-ID: <4d1f121c8ac348dcbb16b554e4ed2b9c@ti.com>
References: <20260921064053.932-1-baojun.xu@ti.com>
 <arDujlvvKixE6ifp@sirena.co.uk>
 <1c8da29a1fac4435a59783ab9fe7f68b@ti.com>,<arD4k6hCZyqycYYW@sirena.co.uk>
In-Reply-To: <arD4k6hCZyqycYYW@sirena.co.uk>
Accept-Language: en-GB, zh-CN, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.250.165.249]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|DM6PR10MB4121:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f93bd4-b7d5-45ec-25e4-08df17c86542
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|23010399003|82310400026|1800799024|36860700016|30052699003|376014|10067099003|4143699003|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: 
 +aHujExT1TaGuzwnmTc1AcijU9XhtW+F/EhVec4a3YPN0dW7yVwpeXNgar9jmd6kjB49lku5X2Xqbdlyt5gkb4hiuI+j+Uhufbbd9KEtAZL/Y9m1IS5rYA3yqk+5dIDK44uU7cJcwhBHbEJJQypjppoyRhRVkepiRlrPz1MnuL51AGMJvDa77fvLR0PeAmRKII6tsCPGHmQ9AO8xXdxitI4TeDMEl2baqBUFwficAEGf47e5DO+HvjnsVJVjXhhmoXXe2RLHERcGle86AEL1lyXRcxYhZovCF3ZwSdqnafogzB40FDIB4cc71v2sXTlG6OYdXH0DVbZx8BLQOMyNFdWF/ivDJrVVmoWKhB5UiQgzDi2+XU3KiNoHR+mEWMwnJnubqaEiOQOCvJJjr4CbPUr7vo8aI4jx97lSuvBJKmGZViaFU8kwULTmRm1TEk+rXE5A1LLvJne3o1WGqO5a2vRTaIOzqTpikKAy65l0pdvNdAakqqpHB/CqKrN6IPvrvTEucwnuqdwP/VwMrqbH3LsCvLbpQzMrLSk1aD5T4qZ7EY0w0G1iyGEA4MG3QKSXyq7+bPN9fOwsV87ZbusRXGYsFcf9ETvId3wCPDzohWqH7aQX4m3fym1b5k29/cTvyUjiRy/Y49yL/adfPWp4lqmyRUUaFzbuSRgLcBNLlLAcnTr5gF7gIzXfO0bKHxbpxqkAJPsM/FAqzFsNFliH0A==
X-Forefront-Antispam-Report: 
 CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(30052699003)(376014)(10067099003)(4143699003)(18002099003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 K47plp2OqscAdPZQWOTdmbTj+1vnDYpsKQkHjSDcmnccHrpRSOnAsmYLcE5ANSt86CttrZu7Sz9QEMw+RqxyWMZaKEBilBD7/vM5EfHULu5ixKlwokwj/tZaGIqqexnrov6ZFFjpmsRqka/X7+5046e6w+cbltsLc/u1KAxnnuz03CVwFDv9sD919EfFnVe5TDgZ81YT4e9PUeJiLX45JyT0G3BVnUHaVHAORciDKh9JoG9qkqHs9vYMBH4nBsyy9lDgmP+arYmNXSgss7bYAHOFoz84D3VDweho8FX2bieZnkRZpYlbnbY2GYtXEnSEV5BskmfXdA+6GJ510wGfs/T5HZeiOUTJTL4/jkiS/lq0rqZ7zenal7L200CsnI/xY+78CSv2t8umUaULBqCwBK41TCDAEbeJLRepVpDCvech+uk8Phw3Q/KrzAQ/+Lj8
X-Exchange-RoutingPolicyChecked: 
	bFAqaBvx25x4ykGlIDtiFeu1UkRVsHVcjHUp12+37SQq+LiMexhfHmMKpnsqT3MJmcMBY+c0bS2SecP+tY1/PoqZiNlAushUqjaj4w5mOBRmRGnym1lG10m0ikV/ExAXq/ctjYuS7P1TeuLm2LHxFMsmY0sMCD5zfHucQZBl/eJGz49fYvKM/GidyuFdF2casWRMbCYVdlkH1sx9G4h8yR2qVDk9ss281tEps7RbfJtlRKct3Okgm+uXKN1zNwc7XjVoSaBWIs8FpdP6WuUOjsDHBk4ZtzNkJ2PJ19OOwmdVutT/zK1c1sKpWoM45zaZ7M7jcaPHAa697LqD0T741A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 10:09:16.8447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 d8f93bd4-b7d5-45ec-25e4-08df17c86542
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
 BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4121
X-Authority-Analysis: v=2.4 cv=Vou2kO2n c=1 sm=1 tr=0 ts=6ab10251 cx=c_pps
 a=4uekZJdLSFpbpqOwIdQ1dA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=xqWC_Br6kY4A:10 a=HSjQpOrDgPAA:10
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=59-QbVjxAAAA:8 a=foHCeV_ZAAAA:8
 a=cH6R9-kdAAAA:8 a=zd2uoN0lAAAA:8 a=kF78kHKsf5pjuUH3U4EA:9 a=wPNLvfGTeEIA:10
 a=IGXNCFnflQ0gJHagSJzg:22 a=h8a9FgHX5U4dIE3jaWyr:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE0NSBTYWx0ZWRfX3R5SI90XDzst
 SD0Odf8Br5CeJutqh0sO813+LXqgvyfRhtd2f5wPlAPLK/5RRqI6KXSCr6TmmdqRY/IanYOqJMH
 MSih4Hwan5Ry17Z4iQ72iJc5NzXos20mXBn4LZxs22hIjKIV2er1VetiPfiqWYpa08SK9pQcNSt
 A8CvZvh6tK51uQcpYtWlP8X6oT4puJYtwHtdvKc2CMkoQhxh4I7sKlOfECjzTyHxaRfnuvQppqw
 43R/cUXxta7lhX4o7l+M74KgwaEgn5dxrN9WTYz6NMAGgykrUKnZLtk7yHfaQuTzUXhkYNUvy6j
 9T4q6CZnB59znvre/LGt030/TBAR/iWAhe28qOsRRZf/3CEQANsyoK7jWZa9mqyCOl1dlnN4lfR
 0R01Eexg/xrCTHn+wty3LvKw6cr/VKerTZPkh8UWigO540w5MpETHD5z+tYyFKW7RSQaWP3Z5cI
 1+zzgBp2FcNJ8/29rYw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE0NSBTYWx0ZWRfXyrzgHt1KHhlV
 kqeTJ550fxkEvl035gaXd5O991TifD5pm87RY9j7TW2hLRKOi25Itipfs1Rf4zzvZefioAgnMqb
 dAiu6PnfLL+qnnsoE6ZWSxlRgZ1TYBU=
X-Proofpoint-ORIG-GUID: ELO6S0cghz87_89AdjotmJ7o_QPJDT_c
X-Proofpoint-GUID: ELO6S0cghz87_89AdjotmJ7o_QPJDT_c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210145
X-MailFrom: baojun.xu@ti.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 4HXV5SD6X66B5SR43NV3Y2VEOKOLCPO5
X-Message-ID-Hash: 4HXV5SD6X66B5SR43NV3Y2VEOKOLCPO5
X-Mailman-Approved-At: Tue, 29 Sep 2026 19:04:42 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4HXV5SD6X66B5SR43NV3Y2VEOKOLCPO5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

>=20
> ________________________________________
> From: Mark Brown <broonie@kernel.org>
> Sent: 21 September 2026 17:27
> To: Xu, Baojun
> Cc: tiwai@suse.de; andriy.shevchenko@linux.intel.com; 13916275206@139.com=
; alsa-devel@alsa-project.org; Ding, Shenghao; linux-sound@vger.kernel.org;=
 linux-kernel@vger.kernel.org; Yi, Ken; Lo, Henry; Chen, Robin; Holalu Yoge=
ndra, Niranjan; pin-hao.huang@hp.com; Syed.SabaKareem@amd.com
> Subject: Re: [EXTERNAL] Re: [PATCH v5] ASoC: tas2783-sdw: add firmware do=
wnload status check
>=20
> On Mon, Sep 21, 2026 at 09:22:23AM +0000, Xu, Baojun wrote:
>=20
> > > > +     /* Check if the AMP is in reset status. */
> > > > +     if (val =3D=3D 0x20) {
> > > > +             tas_dev->fw_dl_success =3D false;
>=20
> > > I'm still not seeing where fw_dl_success gets set to true if the
> > > download was skipped.
>=20
> > If download was skipped, it should be true.
>=20
> As I said on the previous version can you guarantee that the driver is
> being probed with the device having been reset?  What happens if
> something earlier in the boot process left it running, or the driver was
> removed and reprobed?  The logic only works currently if the driver did
> the download that it's skipping.
>=20
Previously, a local variable tracked the AMP reset state to determine if a
firmware download was required. However, we observed that the AMP resets
during SoundWire bus stop/start sequences, causing the variable to become
stale. To improve stability, the driver now directly reads the register
value instead of relying on the cached variable.
This version has been verified to work correctly on the current platform.
Given the customer's urgent need, could you please help apply this patch?
This will allow the customer to proceed with further testing immediately.
Version 6 will be released shortly.

Best Regards
Jim=
