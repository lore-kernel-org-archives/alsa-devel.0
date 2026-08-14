Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3E0C5B572
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2026 16:59:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 89C846027A;
	Mon, 17 Aug 2026 18:58:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 89C846027A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786985941;
	bh=N5F73YhAZ8/lblAL3LyoakiU8NpGu8pm0kU29KT/SDA=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=mg0oNCuj5Ri1VbzgwJOqDrsJMKLhgatXv0SfNYtT9l7D3CZ60yZ1gcptkCFk3NPab
	 gnNgFf3OKdTqLrOmZao10ZjRiQ7ukq0lpBde2+3eTjtx4D3+5vxRVK6HGU+fBCOzqo
	 qdyHhHLYBb79VOcxzsmKLypxuHep59eRdRchw3bs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6D268F80688; Mon, 17 Aug 2026 18:57:52 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9E22EF80688;
	Mon, 17 Aug 2026 18:57:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EF937F805A8; Fri, 14 Aug 2026 05:51:25 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=fail smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=fail; t=1786679484;
	b=UUukAanIQxfrtbRBauRCJJ61RkYVZV47uWDnHswKFWhtFj8twfTMYM9IXHdWOiXeGyaz
	 90Ge/T16jey8OjCYzKcikgwOdI3GxFMDsnXB9tYGgTOGX/Ynmvzhd4m64yTFnf/0VvBr1
	 HXVOOLJnFp2XEhrEzTXhSeSLuVx3/pedjSmOYks/wN+Hyg69hn6lgXuXkr8iuO6KnT4E8
	 7cUUoZ6HR7TmJ6oOqnywY6AIvUX2VWQqp/mxboC6l7kVVNVdN1ILy2E2kA+gGuMFHuocF
	 q605uMTqAszsLwMVaXkemFGSF9pbsj4ndk22lqg8v5suOd5RFzeBfvd9p/OfKc825fQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786679484;
	h=DKIM-Signature:DKIM-Signature:From:To:Date:Message-ID:MIME-Version:
	 Subject;
	bh=N5F73YhAZ8/lblAL3LyoakiU8NpGu8pm0kU29KT/SDA=;
	b=L6nXraTqaYln7sVAexZYzx4vzul8v+xuYMMaaoLmJC6hx1eU8S185IznNDSyrMB8a20d
	 9MsJlYMsghxZCoaKdpK9w0890p78kD56O0ZdarmuVouaf3xOMXea9w+emNUN3qPG9/Dqp
	 fntmwyZujowaeTAWB43NdkGRheaMU1qPpRPCKjNZmqgHgxNq5qeZZaBwBtBeKZK40Z1pW
	 5W84xagVdgJudrYXSvPPhX63imsF7AgknBpWci5PoWMIxD3zLw4KyRSMsRkUjumEJ9qbC
	 nVSrWoVDzU0kZTZP8RUe7aI8lhYCMju8khk55hce1Fg3y6sDr3UPwsP8bqla9TtRn/w==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=E53kAy6T;
	dkim=fail reason="signature verification failed" header.d=ti.com
 header.i=@ti.com header.a=rsa-sha256 header.s=selector1 header.b=DhhSNVNw;
	arc=fail smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EF5A2F80525
	for <alsa-devel@alsa-project.org>; Fri, 14 Aug 2026 05:51:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EF5A2F80525
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=E53kAy6T;
	dkim=fail reason="signature verification failed" (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=DhhSNVNw
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67E32WSq641614;
	Thu, 13 Aug 2026 22:51:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=VeHLcxEjbWmQoiqu7nGVlTScX33HGiobfr1/5jjmw
	Qc=; b=E53kAy6T8Ac8QX2mex0mogF4svAbentyAzmBU6VZv03T7RlN4aSbsMxkb
	+R0yug/8PLevwKghFDNHMswN3uykisUmXE40IJ5HH0DF20HpqFtNsEg8CxX0zO1O
	8y0wNakC8tvPd5yHctHTdK8ozZ+Cv1L1/nnDVoVXlWXSzZpQlL1sr13NN5XouBLi
	nSF23tpBMIjSdajI9Gmcp4HnpZzxo7gQSTlfRyCg58DdZ/bpcqFm8TI8PHffRq8Q
	5zROlcd8UkYC7G1fcZ8SCnvRq8wTVJWEltEmWsxAUbIFnqCgGyTQ+dyVVQpsW0Jo
	Rk9aN5eqzIFH4sjRRZwUy0ewxbdpw==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010040.outbound.protection.outlook.com
 [40.93.198.40])
	by m0384305.ppops.net (PPS) with ESMTPS id 4g1tryg6j1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 22:51:16 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ExqX0o4TfFk+3lRxIUu8p1R6OU8bk3hreqI3WZmEtR/Sjonr8RXcmn6sdvnA9LRSq1dqf6Cy5EFmhIuT7KPIb844/WBczhaswMtnOTwVrViFo451r0MHK/SHIvnXnYMRsk+TWX19s/CT/Y/68Q/f1MQymiBwDlpInHVXa6eNewXwBCIRQK/vQ1/tWT0h7hZHT2UXmt+7eOpeD24yAOc5eNq7yIKR3tDKjzIRovM9U/X5bRlwnnkxoykxBiFOprMfUZPHDiGq8gYHbJ/gg5yYgSdxl0gtFE6SUc1x/D+LQiXerWDS/eukTWONqebykYEc+SQStFbT30NcyYxMmbrElw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeHLcxEjbWmQoiqu7nGVlTScX33HGiobfr1/5jjmwQc=;
 b=ctOIPMND3o+Wef0U6lIOiIsgDJyZdVUkLDSib0qomKVZW7mNXEkXt5mssnBCc2mhZpbxuOMvN2V/esbMv0tJK0fOa0ZifEnzXKPlfthdWzTjbiJbo88U5kEJ93dOqv46ikuvTN+OhRuIdBO94H4q0UsLqZi7UCtMkYRxs2+gZ/K7YOUenvlmVWXfDqFba7wO6S9rzauVOw32RpplSsH9FexYm+ZKm7/Lv0UTLcLxmjc7eRx0uM585Ax9kbDbwTXbk5yRYgI5k9rTbNix+G+N1OX1hZdaADX8hXStNBQv/Mu14aHY1tMCgI+q/G8JZxVus7msXrPqxWE8x6ZVFxFmHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=suse.de smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeHLcxEjbWmQoiqu7nGVlTScX33HGiobfr1/5jjmwQc=;
 b=DhhSNVNw/S64bwPP3vy5HizNgx3nnB7xp3odZGxOBmNXgbVIbG3rGBJJM5LUcKiS8382+gmJ2ZIwwkxr8E7x3l5nGvKDfgX/dUG2M7T/cWXCSUT+wKulpEGev7ui7YAgZhmv3zmJgD4W7F/BlZBLQGCMUPTrN6dEbXqmn9tA06w=
Received: from CH2PR16CA0023.namprd16.prod.outlook.com (2603:10b6:610:50::33)
 by LV0PR10MB997564.namprd10.prod.outlook.com (2603:10b6:408:344::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 14 Aug
 2026 03:51:14 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::3a) by CH2PR16CA0023.outlook.office365.com
 (2603:10b6:610:50::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 03:51:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 03:51:14 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 22:51:12 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 22:51:12 -0500
Received: from DLEE209.ent.ti.com ([fe80::9756:3b42:e53b:3cbe]) by
 DLEE209.ent.ti.com ([fe80::9756:3b42:e53b:3cbe%7]) with mapi id
 15.02.2562.045; Thu, 13 Aug 2026 22:51:12 -0500
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
Thread-Topic: [EXTERNAL] Re: [PATCH v2] ASoC: tas2783-sdw: add firmware
 download status check
Thread-Index: AQHdKsmLsuzSbtZIxEKurYWoeRJwmrac4fGAgAAIf7E=
Date: Fri, 14 Aug 2026 03:51:12 +0000
Message-ID: <fddf1c891e364b92a95eb0f8b86921da@ti.com>
References: 
 <20260813021450.1897-1-baojun.xu@ti.com>,<0799cd9d-a0ef-41da-80ea-3fb9b1ef0f7f@sirena.org.uk>
In-Reply-To: <0799cd9d-a0ef-41da-80ea-3fb9b1ef0f7f@sirena.org.uk>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|LV0PR10MB997564:EE_
X-MS-Office365-Filtering-Correlation-Id: 642f84c6-09d1-4c9e-a59d-08def9b749cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|18002099003|22082099003|56012099006|5023799004|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	lYN5xwBgdYOnhRDB2YRO/1Y/DwYDDMMyLReRmcRbSde1r87ms4UpMmlpKx/XhJ+EYhLvly4GVuDUZoTXXVuNMhVMCcO+AXXh7jb4kVic0Ql2HQFRwFbEAxOVJNPuETQvomYa49L6dMOCJwREcWNugEc0usaHeW/GGDb1vdbTR8ZTGaFtuUCtBhr3cHFqAde29ZVVeequ8pYLnJu+3KLXO8N5Eg13Fl+nonkfXLabvstM67TCY7P9ItRGtaAG/WuF2TVwV+ZzmXmlquHaU04K9oJUCskKwZ3+lEZ+HXsE+QPhBl0S0xDWP3ucwI5v+ytkIO52lwFjutsTZntyX7DJuCUebJzWC3kaxy47piCbK8p1kUn8JaPxjKzyeg7z3VujPXC+mHy338c7k1HXEdA05DlvKOTmWUUhSJTrBVOzft1Coorq1Uo8fQ1YPh/xSALc/xPFpUmXhyaCgMxfSqkqmIqF6p0BZp4hTfHUp4n/dVdbdjN6wIkaWv1c1C+roAjaGv0we2IiakgSaF3/BkoO+L3Om8jAKManWlB3H5X3TtS6sdR9BeXePd1rxUsPY9UqT9bv+2r52TkdoJzV6uqQOYO2AKCCiYnJ0F4jqAdp+wR2KUimU+xE9svlZqrn/apxP82rWeOrIgTiSsDg+N7ypV62fvFR2BjhF9QlSnJCOV9bq4ax/EUgpSNxkEiFBEQhdz2s7WPuZF8aEBglP6+nVw==
X-Forefront-Antispam-Report: 
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(18002099003)(22082099003)(56012099006)(5023799004)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	kn7c9JKr0J9c1r51ZythtyE1h8sSY8ZoWqyCz5Ka0rTosAmNeUY9J+D+vEn7ekKOYFmPlyGv3TeMcb7LQIe2K7QpuV1EFokaDCqoW8zhjbgrvtAV18YRnPSQDo9jlcfTnM3UcOblA7WWE7qcEmXwGj/E3rYDOIV4UO35U/ruZ969DwkiBtTikvvCizZXQnw8GYomXyZZrz+jRzeROLggM0rVqR7aV4qwVFw5tRUhheKWUYCiJfuV1a+JFdGIgqpkctonOqdCDCph2hnjGuCKfbh6WXA35buhN+mo6GGF7GTK9DG/P/6m0Kkc/93xLPr42sJWGrs4UPBfkLAtWc2aToW4yT/7jkdsCmhdnPSGyWZTQi03QpGFHCGCL6+eVfUphwjpjEBSf9nrfXnWHI/ACl6+2oHzILmv8B7vvG9Aqca6Ggip+tEm0BZgkYSMOBSM
X-Exchange-RoutingPolicyChecked: 
	k2EiZwyh5VzXIeWEW+nIc0nPvmNpvhEGD99Quhtx+ufHFjeCATryucZmnb0EMh4/VyQfPQ9GHn4S2bLR46bnlnGuph0Y1nkup/Cmp+Rnz7/Q5/n8b5KKFPFD1n+iPmaAMu6vD0/N+2Py/CRNsHfAuwW3uvBsp1gNYL28gky5ewWJfhDl60wVHATv0CKnZwsfgBOIaEbllcyt3jatPNkFbUF1763VRqmVprmjiTDxVJJFXhJdNIrYx1vybPxwTPgK8c2UAmS2pojRJ8O/vrdlGmjKjunX3mQrXp7xOjmAZXm9Cab04FJMUJcrL/Y7ErU5Me830Gu3wuj2T+Kccg7QGQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 03:51:14.4659
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 642f84c6-09d1-4c9e-a59d-08def9b749cb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997564
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDAyOCBTYWx0ZWRfX3RY5mzzflG/w
 bJCEISFD80g8FlDzm5mImk7wTEPXNqg5sV/cy5q87aN9lFYVoA3fCzdkJNElgu1lmRnl3DznvNB
 9Cf4Smpcg4xnkbr7E2+998nzZ56MKeCBVGK+YUzZGJMNKh0BrIDbKQ+gspJJLeXVTv1I5u2HxwE
 ogOYnJtDNNGfCaLpbt6ynA8rHoc2eueOq+4mfJV7DgahZJvNSxfvuf/Jy7gzB/2X0pGUdMJpFxF
 E8FaXdtsRtAT1vPZ/LapkLkhVA/zos2jtvQdqvfPgnAvbptVkX3zl34WGKKebIohjPT8I8JFJMi
 wEuXtwJVuu7LaqXZeG/+cXrd6iI9bz2GEP9ZBInxHjSr13GRFbcpQJijFkql8g8eciFvCeBPrLc
 ZNS20kkdCaEUMH+5EJkVgz5zfz23DQfmkT9SjpLGOeGmIFapTEo2e8uOcY42zzzKMHHUKIqW3m3
 e3NAmV13ReqNdkaJQoA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDAyOCBTYWx0ZWRfX6IGFB3NYDEtP
 Xc0+JMsgTEVjrvS8f1TmkwavE8QOndFvRwmZ0N8vLYfKvWRNsEngYDocqbJO/m7k6WB2VwTxxws
 CqstbNf6KqR/1yW2mWzPfsT9v/eQsoo=
X-Proofpoint-GUID: sWGLrieG-7z7n608XoRMEWiIRf_kIotJ
X-Authority-Analysis: v=2.4 cv=H87rBeYi c=1 sm=1 tr=0 ts=6a7e90b4 cx=c_pps
 a=F7bn8UBrlesmBZzvaxvKyw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=xqWC_Br6kY4A:10 a=HSjQpOrDgPAA:10
 a=8nJEP1OIZ-IA:10 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=bx814J3U1Kdcb7-RJgoA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: sWGLrieG-7z7n608XoRMEWiIRf_kIotJ
Subject: Re:  Re: [PATCH v2] ASoC: tas2783-sdw: add firmware download status
 check
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140028
X-MailFrom: baojun.xu@ti.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: UUTTL5PKBUFFVXZTD7LT3XYGST22XG2V
X-Message-ID-Hash: UUTTL5PKBUFFVXZTD7LT3XYGST22XG2V
X-Mailman-Approved-At: Mon, 17 Aug 2026 16:57:46 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UUTTL5PKBUFFVXZTD7LT3XYGST22XG2V/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

> On Thu, Aug 13, 2026 at 10:14:50AM +0800, Baojun Xu wrote:
> > Currently, the firmware download is unnecessarily triggered on every
> > system resume from suspend, causing significant wake-up latency. Howeve=
r,
> > this step is redundant if the AMP remains powered on. Furthermore, cert=
ain
> > memory pages (addresses > 0xc60000) are skipped even after an AMP reset=
.
>=20
> > +             if (!tas_dev->first_hw_init || file->dest_addr < 0xc60000=
) {
> > +                     ret =3D sdw_nwrite_no_pm(tas_dev->sdw_peripheral,
> > +                                            file->dest_addr,
> > +                                            file->length,
> +                                            file->fw_data);
>=20
> What happens if the amplifier uses power (eg, over a system suspend)?
> Though since nothing clears first_hw_init I guess there might be issues
> there anyway...
Hi Mark,
Yes, that is the purpose of this patch. It prevents the re-downloading of
pages above 0xC60000 after resuming from suspend, as the data in this regio=
n
persists across an AMP reset. Therefore, these pages should only be downloa=
ded
during the initial power-up (when first_hw_init is false).

Best Regards
Jim

