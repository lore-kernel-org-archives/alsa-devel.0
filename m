Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D362CA5FA7
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Sep 2026 19:05:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 945666020D;
	Tue, 29 Sep 2026 21:05:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 945666020D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790708739;
	bh=lg9EPfAr/t2aIrpNEbnYnm9gVLM+WyfMVPr/Iq56dZ8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=vPNoVta+6ESuUnnXlCmIkkIbwzR7NioWYtqs1JlPH5fAIfrC/KnTW2YbtoxGZ/7JC
	 jR5sqEC3VW0NVBlWr9p+QdM8fZPZ8U0Nee1e2GoJK6cWJVYz6AEtsu6XV5oXTLlrkJ
	 iGha2qMelQb/jJLopsIVEXVlcPrHMWgBlCKjgGLA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 40D3DF8061D; Tue, 29 Sep 2026 21:04:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A62ADF8061A;
	Tue, 29 Sep 2026 21:04:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 14DA0F804F3; Mon, 21 Sep 2026 11:22:55 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789982570;
	b=o+YhQqTRSSUGGObViQaahk2nWEYw+p3oDBJwWMgkYqaFEJe8uf0Pz0i12kpKdiqXxh5g
	 8ILRKO9LoRDWkNC7K50RcPvixQ7pvHPXJyD6W+c7hY2syTj7f+biRCLfRcw/mzIoUtuk3
	 ZHHK+ySXh4uxpXTieKPYYt2TIaVRJ316M2qthjHhZeNk5iGzKb1d8qT0+H4m4eyqxz7Gy
	 C/lsI2le74nCuTYf59wt+FnneBtmUnyA4GQ2RP0B1+snNv4YHokSqzQCT8UixZWxqY752
	 Zux/sLubtDLnxh5hrwVKelFw+Dr8ADK/BZEpo2T+J552PjCR+8hS8GgNGvCQRp4U+6Q==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789982570;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version;
	bh=lg9EPfAr/t2aIrpNEbnYnm9gVLM+WyfMVPr/Iq56dZ8=;
	b=MYmbad35RcTQyEz2xbmVKoteEKT11eEF5Ov8fR7cZAc4eQQacveKMLRiqTIDmr8bN4eR
	 qMxOxwqaiWAjhy7494Pxrfcpdu2hZ9JILRIKEF72l5+lra/CCzarddGpt0oFA12iduYr/
	 3gUEnldfNxLPOFi/Z+46W7+f/Qz4yOFHIpK9w78fW2R8owMBN3/JEwglLPMI580326Fzq
	 CcV3HEPlvafC9KgL9BfLhxa5q6+iZagIUB2eq8dajTf0goawvEM9gsfGwesATWLpIsni1
	 f6xXmHJPerVuWDmdZVA6k+fLXW4808HIzeY2xoPGzqBwnOgQnSKI47udRIyZVlVaHRQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=gMDZUTqi;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=N3VWBYNx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 27076F801F7
	for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2026 11:22:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 27076F801F7
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=gMDZUTqi;
	dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=N3VWBYNx
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68L7AsQL2998622;
	Mon, 21 Sep 2026 04:22:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=wnmKOruoYg8DkcetRUfKhAlKhyqSWRqfNRQBjqJy4
	ZE=; b=gMDZUTqihebmvUU9VMpnWfDMA0t+MzC0FH0qYGZFvGP9L0PQNLrE5VTpY
	AdvEk7/81Gy8BmGXPRRvqx6CkZKrExKvLxQIkHjCCGGakk7pY5EW9dHLbQ83MxWt
	IrZ3UHt6G16C8deoQPgClx9KXakJft2qLvVQH4xrI2OuBEkz+6Mtw9+Oa+9Xjwgk
	LnEG3bxmGwN/Ku4sQKUoGJBjSF0PG9nhWjH6+gb/RA0dB7uQzrtwX8RhE5AtUkYX
	/QBaGDbIXrxrvJISVmwW65/+ocAZyo5K4G65ebJJQLv6yX5buuu9uHn8TS3yr7kh
	ur8p4o0M5MCfqm3gtl5AJh1V/cYkQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010030.outbound.protection.outlook.com
 [52.101.193.30])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gtx9f9dr4-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 04:22:42 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2HSpMGFvVIAEz7pX2oowqgZyjJ6kS+UNYVT6bIE5uYk9GKBPDN3UbmSIRK3RF9ZsxIvZWBHZJZHnsJC+N1KSOtmW8SWTBLrwzqvqsVU20Htt7qKnuCuJE2pFYoInehRRKfr5FQr3b0wpybCVfOgbDL8oZcMfI5e7f9XF5X2Yc8r4Ttosra5tN3B7sbOk33C6SpbEKTAvIncH6vxcJebr3Pf7ZGi54Dgo3kPStvPkbuVX9xNEbXwvh0TkdTIFgJCFd/kPaLgzPi/hAACZuSgPeImWLCzKQgbSztjpW7GwFdTYV8mtRUabJ04UHgD+6dfUKuO0a8i4mKFujfhlFV7uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnmKOruoYg8DkcetRUfKhAlKhyqSWRqfNRQBjqJy4ZE=;
 b=dcVXUlEw+dNSGYV6OXnHM51cUWv4bncP2Wt0GNCmLexh/f5Q6HOIrJce7kPGm2QC0kzqKg0fzchvAAyGraqZVa3OONbO0iPZmhi5M/q+VJXajzY2VtewflyNVpZyO1AWEscp2Chy/iV6znjR7QAMQLo4NXJrSCBGu8Xik+mjE2WLOX83jXV2J/bJSagtyvpLS3DjW4JwlgwQhhTFBEV7AAzHX6nwPYYsk6fe0GFTk/49vZkeefiMC9cZ1uxt13M+qshPBhEh64ejHlPl1LcrkZidmZwcCKEoKdwIwIW2fTCMPQdSVK4Hrpp3HRp/qYiYRYd670OPKpFFLy6QvLAafA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=suse.de smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnmKOruoYg8DkcetRUfKhAlKhyqSWRqfNRQBjqJy4ZE=;
 b=N3VWBYNx0oyiOdvxqOfvtjCFVGtxJsiXnnUO1W7inBM3GerqjQOtO9HQtmarCZ32Fzlo/9s0fk5enJKo0Pts/sFDsYz0cbQDpP/VykrJVs9ErkXSUJL2fk8J9fpESaSuml/KpIRAVkn6MAoEWZ7LC08ZEFwo5xlc+BpdOp2mUXo=
Received: from CH0PR03CA0235.namprd03.prod.outlook.com (2603:10b6:610:e7::30)
 by SA1PR10MB997736.namprd10.prod.outlook.com (2603:10b6:806:4bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Mon, 21 Sep
 2026 09:22:38 +0000
Received: from BN2PEPF0000A804.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::66) by CH0PR03CA0235.outlook.office365.com
 (2603:10b6:610:e7::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 09:22:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF0000A804.mail.protection.outlook.com (10.167.245.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 09:22:38 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 21 Sep
 2026 04:22:24 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 21 Sep
 2026 04:22:23 -0500
Received: from DLEE209.ent.ti.com ([fe80::9756:3b42:e53b:3cbe]) by
 DLEE209.ent.ti.com ([fe80::9756:3b42:e53b:3cbe%7]) with mapi id
 15.02.2562.045; Mon, 21 Sep 2026 04:22:23 -0500
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
Thread-Index: AQHdSZQveSbSEr4aTUSMIwBcRdMz/bbZC6QA//+zpMc=
Date: Mon, 21 Sep 2026 09:22:23 +0000
Message-ID: <1c8da29a1fac4435a59783ab9fe7f68b@ti.com>
References: 
 <20260921064053.932-1-baojun.xu@ti.com>,<arDujlvvKixE6ifp@sirena.co.uk>
In-Reply-To: <arDujlvvKixE6ifp@sirena.co.uk>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A804:EE_|SA1PR10MB997736:EE_
X-MS-Office365-Filtering-Correlation-Id: 275a6582-0c40-4165-a03d-08df17c1e128
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|56012099006|6133799003|3023799007|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
 geDOQIcUPNJ5SuNoVXXab1Lvz/9i15JTDHR/NS7ihjS1rxc1c905QAx9bXBUT9Jj3OBBgmAWyU0P9+a5Wx4pTdvgDr5is+3eqba7cg1tOaAsq7UQ7ohku8Fa9fc35MaKJrPv2l/S37gGj5mgxDYJhFQzaKeRe6QYdrdtPpgkGnbPMyXyaMBMidjM58YRdANKJVe6E555eV9GGMg3NpYHR2G5kHi5cOdA45zQ+INJ8X4LIhCZBQ/frW8qJsL/C6UQ9BSdUFo4ph/1juN2XhyPYeWe0rQRPCz3vyyL5ANDoUA87eLDUuTnAnL/UmmEAIhdDGav7CDhskeg7avS4jXOGHBFXQ9OXLiyKa591Ox9vsY9QrVNERryMn0b/Z+64ATuOcMayGQNvMUS25Z1isMA/oSaS5kp0/4uTsXZ82qGXu6y2aDnARy6qtb7I2TB+n2RAqVmD5T+jHeoXvmzbdbHcRz1ezz1tcvVkPRFiMexNAIIMRzcCFTh9qY+Ml5W6VQxDUas/aNjIrHedX52iU0RA/hI/dQ2YhDbheyi+ulGQSguKQcSoRo4Pj3LmkbegYqxx/+yux6r7Byy484t2thO4Oa9/MUjqPzB6NjgiJ19U5uZSxGyKmRwuhb4NHb6jsTz4JMk1q4D0pWeUBtRdzFEAyEqitUDuvRMiC6Ta/JzuOm0zqjVGbrtHSd9qQqdU+D7zLKXFWpYIPMwXsqvmym1FA==
X-Forefront-Antispam-Report: 
 CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(56012099006)(6133799003)(3023799007)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 8HgDLeSlj/I5IDnc+d1kLXjkogI6ImVQxmTxAmP1irxbLOuGgRjyY1O6a7We/3Zjv5cO1TBqKs4PuF+QMstfaLqLfy+iKhB0sTK5eMMAbfMDvl9wR6/QCI70h0mY3aKMKikmJylFh3TONHUjCKMIwDQxKA0FjT1bQLQRgIUL0D40MNfQex0jV1p/Zn0JiB7jImJB8pYYQF0xEZT7p38NtVnFr/Pd7fNAKZfFI9KGe9Zj6B3atzhVT+tdsW6xrMtv7eGzpAQP9gxwamHEb3dfn9dvumLHWM1LI3DhrG3WNSoI7Iw0H4ATkbwpOr537F54iNluT2oLsvSjN4MUmFxPowO6lXt4sxfHaJfp37MxyecLl7o+lBWHW1N5xP9vnAk3lKX+IaHzQdkZRaR5lpk2u6Eptinc7qk2amc5xMKp2ZiQJr8/MqmcE8eJOSRLOemL
X-Exchange-RoutingPolicyChecked: 
	Fg7HL1hfDAkic5SQD5wkzRUXs+Il23RZ6e4HoCi1pVdY8hPfNi9690tFYaHANXLYZcaC5gnugoYkNbPgYkrv6QxGc/yXe0zi5CepRsIBpt4LjqZ5qzP5PBq0jikjAZ001noPGtTTAH3UGIml24/Sp0ecN8sbBGSOKtc3BVKKEXOTL7N1xXzhz64OoypSnO5TU+8N/MZ14Ba1rdcjD2mfKZSiA1caSvitV4mQFh8sbTJtXfTfzmyzPuEe1Gv2Q4UlAq0wc8HY0YRxRk/NdmyKwSxOT3+8/2r14O7w/0yq0iFYhGlB+Xnv+n+/R0pRF+N8eOOgcS/QWJl/Vp8OIztVig==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 09:22:38.2374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 275a6582-0c40-4165-a03d-08df17c1e128
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
 BN2PEPF0000A804.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997736
X-Authority-Analysis: v=2.4 cv=Vou2kO2n c=1 sm=1 tr=0 ts=6ab0f762 cx=c_pps
 a=VB8Rg5rwfRosJW56o453OA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=xqWC_Br6kY4A:10 a=HSjQpOrDgPAA:10
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=59-QbVjxAAAA:8 a=foHCeV_ZAAAA:8
 a=cH6R9-kdAAAA:8 a=zd2uoN0lAAAA:8 a=P4NjjOVSqqrxZ1TXFN4A:9 a=wPNLvfGTeEIA:10
 a=IGXNCFnflQ0gJHagSJzg:22 a=h8a9FgHX5U4dIE3jaWyr:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEzNCBTYWx0ZWRfXyC/HMfH9iN5f
 rGM3E6Ailp++21aW1Jeldfwt2mrU86rsj4e221vOzTC7mHCYdZHztdbPePQwcq8/v/d0cSlkWbJ
 uUUk9LptXB7aN++MeHN53QgiHuWcOvqxc20B7VWqk5gvkarQqLSdZvYVQjWeMP7M5weEZcCaK58
 SXk/36oPEpL6ma9c67mGIIOwvy0nbbpBQLoukcsNVbhulAw8lilCBL1zfi6IgkSZJL4+w+rc1q7
 V8UwRI2ZuvpyQiRp1ePEvl24mN27cUPxLt1tUl0CAf8pjw92Q3dqDN9Zuu2jwuuf8XI6BLObwVQ
 39QhqIk7U42zWypCETn/+agMolofXBoXB3tc0ZIJTwgk1jxN7KcR5bwBUJ5a2NJQTYwxXxrpL6x
 ez/Sv/RXRp63EsXDhVgeMsGUhHgHPcLpqRNz+vZX2spFKdSIKOKV85tV5iSvrvNVzVQZwOawOEK
 05NIqcDa+tE6mw4hDVw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEzNCBTYWx0ZWRfX0OkWmzGumYtG
 4pOr9aMxLADZ1H5P7zcVhTyUKDDiFEgRUDMbkiF597qgesr20eAEXyKdw8ilxNRyadBNpIRvhnR
 yfUTpcQmCOKyfYvmJxPrpZxagjcc384=
X-Proofpoint-ORIG-GUID: AlLyIv6jkCk5Um8w-6HsbHYPM7X0fVNS
X-Proofpoint-GUID: AlLyIv6jkCk5Um8w-6HsbHYPM7X0fVNS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210134
X-MailFrom: baojun.xu@ti.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 4QIDIF56LY7YJD5S5ARRRSEDL7ZL776I
X-Message-ID-Hash: 4QIDIF56LY7YJD5S5ARRRSEDL7ZL776I
X-Mailman-Approved-At: Tue, 29 Sep 2026 19:04:42 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4QIDIF56LY7YJD5S5ARRRSEDL7ZL776I/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

> From: Mark Brown <broonie@kernel.org>
> Sent: 21 September 2026 16:45
> To: Xu, Baojun
> Cc: tiwai@suse.de; andriy.shevchenko@linux.intel.com; 13916275206@139.com=
; alsa-devel@alsa-project.org; Ding, Shenghao; linux-sound@vger.kernel.org;=
 linux-kernel@vger.kernel.org; Yi, Ken; Lo, Henry; Chen, Robin; Holalu Yoge=
ndra, Niranjan; pin-hao.huang@hp.com; Syed.SabaKareem@amd.com
> Subject: [EXTERNAL] Re: [PATCH v5] ASoC: tas2783-sdw: add firmware downlo=
ad status check
>=20
> On Mon, Sep 21, 2026 at 02:40:53PM +0800, Baojun Xu wrote:
> > Currently, the firmware download is unnecessarily triggered on every
> > system resume from suspend, causing significant wake-up latency. Howeve=
r,
> > this step is redundant if the AMP remains powered on.
> > Furthermore, PRAM access is skipped if the firmware version read from
> > registers matches the expected value, indicating that the memory conten=
t
> > was retained across the AMP reset.
>=20
> > @@ -431,6 +432,8 @@ static int tas2783_sdca_mbq_size(struct device *dev=
, u32 reg)
> >=20
> >        case SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_XU22, 0x12, 0):
> >        case SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_XU22, 0x13, 0):
> > +     case PRAM_ADDR_START ... PRAM_ADDR_END:
> > +     case YRAM_ADDR_START ... YRAM_ADDR_END:
> >                return 4;
>=20
> Are you sure these are MBQ registers?

Not, will remove in next version.

>=20
> > @@ -794,6 +803,13 @@ static void tas2783_fw_ready(const struct firmware=
 *fmw, void *context)
> >                        file->version, file->length,
> >                        file->dest_addr, file->fw_data);
> >=20
> > +             if (tas_dev->fw_version =3D=3D fw_version &&
> > +                 file->dest_addr >=3D PRAM_ADDR_START &&
> > +                 (file->dest_addr + file->length) <=3D PRAM_ADDR_END) =
{
> > +                     cur_file++;
> > +                     dev_dbg(tas_dev->dev, "Ignore PRAM block");
> > +                     continue;
> > +             }
> >                ret =3D sdw_nwrite_no_pm(tas_dev->sdw_peripheral,
> >                                       file->dest_addr,
> >                                       file->length,
>=20
> This could skip blocks unintentionally if the verison happens to be 0.

It will be non-zero value after reset, and the firmware version is also non=
-zero value.

>=20
> > +                      * failed after Power-On.
> > +                      */
> > +                     ret =3D sdw_nwrite_no_pm(tas_dev->sdw_peripheral,
> > +                                            file->dest_addr,
> > +                                            file->length,
> > +                                            file->fw_data);
> > +                     if (ret < 0) {
> > +                             dev_err(tas_dev->dev,
> > +                                     "FW download failed again: %d", r=
et);
> > +                             break;
> > +                     }
>=20
> This logs an error and gives up on the download...

Yes, re-try will work for this case. If re-try still failed, should be othe=
r
fatal problem, will quit with failed.

>=20
> >        if (cur_file =3D=3D 0) {
> >                dev_err(tas_dev->dev, "fw with no files");
> >                ret =3D -EINVAL;
> >        } else {
> >                tas2783_update_calibdata(tas_dev);
> > +             ret =3D regmap_bulk_read(tas_dev->regmap, TAS2783_FW_VERS=
ION,
> > +                                     &val, 4);
> > +             tas_dev->fw_version =3D (val[0] << 24) | (val[1] << 16) |
> > +                                    (val[2] << 8) | val[3];
>=20
> ...then we do another read and overwrite the return value, potentially
> we might have a successful read.
Yes, read it with correct value after firmware downloaded. And save it for
compare in next firmware download.

>=20
> > @@ -951,7 +984,7 @@ static s32 tas_sdw_hw_params(struct snd_pcm_substre=
am *substream,
> >                                                        TAS2783_SDCA_POW=
_STATE_ON);
> >                        if (!ret)
> >                                break;
> > -                     usleep_range(2000, 2200);
> > +                     fsleep(2200);
> >                } while (retry--);
> >        }
>=20
> This should be a separate patch.

Yes, will remove it in next version.
>=20
> > @@ -962,30 +995,6 @@ static s32 tas_sdw_hw_params(struct snd_pcm_substr=
eam *substream,
> >        snd_sdw_params_to_config(substream, params,
> >                                 &stream_config, &port_config);
> >=20
> > -     /*
> > -      * The two mono amps each render one channel of the stereo stream=
:
> > -      * snd_sdw_params_to_config() hands every codec the full mask for
> > -      * playback, which leaves the pair in mirror mode and one channel
> > -      * unreproduced.  Claim a single channel instead, keyed off the
> > -      * machine-assigned component prefix rather than the SoundWire
> > -      * address, which is board-specific: soc_sdw_ti_amp.c names the a=
mps
> > -      * tas2783-1..4.
> > -      *
> > -      * Which side an amp then renders does not follow from the bit th=
at
> > -      * is set - sdw_compute_slave_ports() advances the payload offset=
 by
> > -      * the popcount of ch_mask and never looks at which bit it is - b=
ut
> > -      * from the amp's position in the codec order of the DAI link, wh=
ich
> > -      * on these boards matches the prefix numbering.
> > -      */
> > -     if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK &&
> > -         params_channels(params) =3D=3D 2 && component->name_prefix) {
> > -             const char *idx_str =3D strrchr(component->name_prefix, '=
-');
> > -             unsigned long idx;
> > -
> > -             if (idx_str && !kstrtoul(idx_str + 1, 10, &idx) && idx)
> > -                     port_config.ch_mask =3D (idx & 1) ? BIT(0) : BIT(=
1);
> > -     }
> > -
> >        /* port 1 for playback */
> >        if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
> >                port_config.num =3D 1;
>=20
> This looks like a rebasing mistake?
It should be different on 4-AMPs project, I will create separate patch for =
those issues.
>=20
> > @@ -1207,25 +1216,30 @@ static s32 tas_fw_load(struct tas2783_prv *tas_=
dev, struct sdw_slave *slave)
> >  static s32 tas_io_init(struct device *dev, struct sdw_slave *slave)
> >  {
> >        struct tas2783_prv *tas_dev =3D dev_get_drvdata(dev);
> > +     uint val;
>=20
> unsigned int.
OK, will update in next version.
>=20
> > +     /* Check if the AMP is in reset status. */
> > +     if (val =3D=3D 0x20) {
> > +             tas_dev->fw_dl_success =3D false;
> >=20
>=20
> I'm still not seeing where fw_dl_success gets set to true if the
> download was skipped.
If download was skipped, it should be true.
>=20
> > @@ -1437,6 +1454,7 @@ static void tas_sdw_remove(struct sdw_slave *peri=
pheral)
> >        struct tas2783_prv *tas_dev =3D dev_get_drvdata(&peripheral->dev=
);
> >=20
> >        pm_runtime_disable(tas_dev->dev);
> > +     regmap_write(tas_dev->regmap, TAS2783_SW_RESET, 0x1);
> >        tas_remove(tas_dev);
> >        mutex_destroy(&tas_dev->calib_lock);
> >        mutex_destroy(&tas_dev->pde_lock);
>=20
> We need to make sure the regmap is not in cache only mode to do that
> reset, or make the register volatile.
Will remove it in next version.

Best Regards
Jim
