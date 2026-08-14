Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E47C5B572
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2026 16:58:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 17B6D60283;
	Mon, 17 Aug 2026 18:58:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 17B6D60283
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786985924;
	bh=Vch7qGA7upS1/uZfGpfRAcbXYdns7GDvYUBp8A2difI=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=uleVmi0ADeX+Bm8muEF3tCd7OIkO18dOvdyZwmZdeaygne01wH4hlJpaJxpLC5eK8
	 +5qqBWjnZG6tWKFjamG9p8MdStGw9avU7+drqMuZcSsk88QO7Km4hRMCwan9u2lHme
	 xwb2ge0eZZ6GG62+xRAl+8sSHOJtGViiqA5hgJlg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 441F1F8064C; Mon, 17 Aug 2026 18:57:46 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 56AFBF80655;
	Mon, 17 Aug 2026 18:57:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 526CBF805A8; Fri, 14 Aug 2026 05:45:37 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=fail smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=fail; t=1786679136;
	b=Oo16dnPWAK0Bs9Bk+VL5ki2lwMqXD6JUCHPYmeqx7ygkhtUPvH4UrJ8uHAXtXq/V6Ejs
	 6GdHjO8/qxcNpswxfPQXzBtJrRyFkh7VUlPjZvEruTNxooAB97DLalX68PyTYy2nXTH6p
	 UEnJr6Xdwv5Jq8ATR8LiEIYj7XbOL3ZS9F2h4Ezx0F1YI908wE7c4n9uFz5FNpR/9jYNZ
	 KGaSg7jlU7/2FTqQjq7qSchGwM5pYfa4zsU+QsRDlDvypLtXytLc2hldiz4io/DPRuTEP
	 YZz0xzBGykMpENzLvyy1pOW59dLVeZ9dcOBHmr43SB3/xj4lOP714QQV0bW909YXEFQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786679136;
	h=DKIM-Signature:DKIM-Signature:From:To:Date:Message-ID:MIME-Version:
	 Subject;
	bh=P06bLL4OrdStEVZEEXVv/7oTVYYmN7xJWSKeOFEjr7g=;
	b=fcfp3vkfEUBTjWqB3oH8y6HkkNJO4ZRO5lL4IDWKWzV6GnSf9SB5pr1m6WnTKOXo8nh4
	 V6XWY5uWGS/NzDrVPdCcekGPR0fHM2UOavp+AxUMCKM4Q0mnSi+IhIE56+7nXPW2wRd2v
	 QubHeQ/7pKt9u1dcXU0ZDVMb9v8WL9+3mAmHt7FMr4iwAnAd+pCIbdzbdyQqKT4EQGM7Z
	 FyNqecggOuIs/QbWsxRza+dLRqyl9Z0KybqnqT9KCFnf0n67ykyDDCfMjKkLsUwXGh4tU
	 RPOF3Eqg+L6YzobX1q8/9mBP5mQ16hLz/Vd6p8upKF/z3NiAqVHiGQ8bYHodeKWJg4A==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=U3sEXodf;
	dkim=fail reason="signature verification failed" header.d=ti.com
 header.i=@ti.com header.a=rsa-sha256 header.s=selector1 header.b=HEd9hAiI;
	arc=fail smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 59A51F800B6
	for <alsa-devel@alsa-project.org>; Fri, 14 Aug 2026 05:45:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 59A51F800B6
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=U3sEXodf;
	dkim=fail reason="signature verification failed" (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=HEd9hAiI
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67E1Ah9X4189016;
	Thu, 13 Aug 2026 22:45:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=proofpoint-05-2026; bh=gxoHM7lvJYcDqTw
	qU9c6+YQsmLfRl/T/8ZYVJStuJog=; b=U3sEXodfotiDCtVKb9fll6PcJkX2hx5
	pCX1bIBuXIbHHzr1juWaw8x2kW5Jq7/zP4dngGHcs0lSV3PSw8aej8mvJWAInP9P
	/uJmZj5/DKVcrjzC3lKqSh/AfwT00EssOT44z/O5JVISlArNV4vQd9Ctb5V6qh+8
	J5nRWAK0t8MAYDmY0e9hub3bU3ag3eBRhtxycMVF2nmQW1PNtIScobg5EqPVyhZi
	h/kz0iWMKcTAj7WYLn5zr/aJxxDCuKC4BUvPj97nEHnILIwpqvdpg2snAYvukSSK
	A7+/8h/Za8pHOW/6tict1ADGQAHxSZhfhWxT1VU6eLd2DTVS2Qa1RmA==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012011.outbound.protection.outlook.com
 [40.107.200.11])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g13fxghy4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 22:45:24 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wkMgDQbsesMV6WebPSde1GKrwbJhyTIU3g9j02ZGIK8dY6BvESUPFLERWDIoWyxyxYAVly8O9TGdCHaKNBelTIea3wGvHN9j/fK3PoaftEUNlRYnYW4WmgPqhCq4NJpnRP8054FjiN8qD8PYZekidtUeB8SNowD5N4sZ0p4QVmFElJvwgaYF6cvkh2i1/vQFi+eH1jDuhIk94Rpq60ylblEDQXmUozdvsZfk5ReUqcDTKeY29c0IJb1z6jHIMd2RBO6xrcSpSmF+na6ur1wGxtVxHiFCOVy3iuqLYdVxbaTvB3xKC5ZlGgmFVOFrFHg4hkIAH4MgOklex5A+0yzqFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxoHM7lvJYcDqTwqU9c6+YQsmLfRl/T/8ZYVJStuJog=;
 b=IP1JyLAxIj7lRtsM9XyoxEItENKEva9U8VElFp/eAdpysxyCxQu43nd/1dnI3XJx4yJB4LXrXYVlH+F3KLL3nDkO2wMpEKjMCngMxvMj5Xx90Ag+StJtf62xkgHCPELtm+Z58etgihFTFDc4EzPLjpDKVIYmCZMX6E/o7qba9rfocc/pDx8+1Zli7CwSNIR6l8GXcKxh+lMTkx5lJzeoYXQyd3xTMaYOPrJBLkgt6FnTrvKMmtbuLV/zP042bXPDFWfN0w5eRduxlNVNOQvhokGxQSPlshL53zlVWjzXsmZSXducpkxTYNNzv4zaZufjXwH6nPS3vqf28OtAP7mvvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=suse.de smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxoHM7lvJYcDqTwqU9c6+YQsmLfRl/T/8ZYVJStuJog=;
 b=HEd9hAiIt42XJoVXmTX2guU4iZL4cLo3ebJ32UhfOta/ubCCAs40CpOd3x05aU6roKICelp2FhToHPcDDjPG5d9yR3Ai3/31W0vtBxO/Zz9gni8aqUtF1qToAhw3I/QJOb0ear/vxc4gaUtyVP49oaSOauwbZVDabI4s01PuxAI=
Received: from BN9PR03CA0473.namprd03.prod.outlook.com (2603:10b6:408:139::28)
 by PH0PR10MB7077.namprd10.prod.outlook.com (2603:10b6:510:286::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 14 Aug
 2026 03:45:21 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::98) by BN9PR03CA0473.outlook.office365.com
 (2603:10b6:408:139::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Fri,
 14 Aug 2026 03:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 03:45:20 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 22:45:20 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 22:45:20 -0500
Received: from DLEE209.ent.ti.com ([fe80::9756:3b42:e53b:3cbe]) by
 DLEE209.ent.ti.com ([fe80::9756:3b42:e53b:3cbe%7]) with mapi id
 15.02.2562.045; Thu, 13 Aug 2026 22:45:20 -0500
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
Thread-Index: AQHdKsmLsuzSbtZIxEKurYWoeRJwmrac4fGAgAAFEXU=
Date: Fri, 14 Aug 2026 03:45:20 +0000
Message-ID: <7ea690074ee94d9786ed21e2bdde43de@ti.com>
References: 
 <20260813021450.1897-1-baojun.xu@ti.com>,<0799cd9d-a0ef-41da-80ea-3fb9b1ef0f7f@sirena.org.uk>
In-Reply-To: <0799cd9d-a0ef-41da-80ea-3fb9b1ef0f7f@sirena.org.uk>
Accept-Language: en-GB, zh-CN, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.250.165.249]
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|PH0PR10MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fbc9161-92c1-420b-25d2-08def9b67714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|6133799003|10067099003|5023799004|56012099006|22082099003|18002099003|8096899003;
X-Microsoft-Antispam-Message-Info: 
	jEmhyl3RTUaQOEet2zf3VUfgH5N7ZfAwQGAh+phCLfjt4bqt712eReBzN7N/v5pFuX9ZEGjWl6ipAwag0HZ3SwpZ3FILcGsnEr2t8f4DE6FQ0fUy1v71OrONF96o6+ksfI2Oac9fAs5cAao5hFylGdTdIZuckjXnhffTTwj9hMMGfOLHNlfr4A9UCoTZPTWzHFyWgtUFTicd1uy9XCzxl2ymw2U+J+Xtz2ULdL0ewY36b8sFctJbBaTH+BALOMSDbdMyXZTYsXvFP84l2E6uLuPJKNQSxJqo6RtDlf+tSO/7odpGCIg0N1pEKYQ79RtiFVgWgryI5hm/9rwsF4R81/bg1ZqBS90+m0O1dzzblaQ2i2/FDCvn5zRoRGFf0E/6nu8+tL/xi2kvz2VRa6XA3s9P24oJKIdiQDxQGYbUVLGXXpcKYvr9VbiJyVUyG4HYepVBFKqLeqK9aAoVhXuj4f5MmFtmADPspQJatNrM5gFWotV9ZGRrEnoOFP8phnrkCf2KUIwx+es2PnwH7xbMBRNIqzTB/8NydvG4CNlGv9Oq7mHbe8cTf8C39Y9G4Qpb3Z1sXoP+Vc4ceOzhsPtUD2+F3fzVR4raUOUzCrgj/L5fvf9/tew6RrgehyfQ8iDASlKMPPmXxujVmoN7ZObZ4XVpMre91B4OzDIzdUwJMBdIVQNA8IhbB1YIqVOQyT1r
X-Forefront-Antispam-Report: 
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(6133799003)(10067099003)(5023799004)(56012099006)(22082099003)(18002099003)(8096899003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	nUfB1t8UjMrMgR6RFe/ef+ullt+rOvo0Tq8MphVpKKAJMLVjhsJ09s5wmX9ngL/7EVrVkNuxroV2Y7lvF4qlkp/VOlPWGeqGeJcaQm0uWVxwWujSvnEwlAKr+fKFs1Dfy7lhBk3aWXj1miXh6iuvIKXfErD06Ee39BhkzILA+WgKH9YetYae3xd/RYJNSNfmLIRGGkSHBZdcstfh80VSf5R7rw73e7/obRsQJ4VubTWyLGu544ASYLb41597GVpPDZUHsGHPqJyw1e1H6rUJOG8BjC9CGqKLFuqy7tispqgN0O8Fqg4qnRrfK7lvE9BIe1QKqazjo3kRQBc2CxEqAN29VAYFYS583HtKesMMYHWQXyYt2eiexjc+HeivQHmNhyTVJZkhHzcFVKcDOVTOXr8u6AIQuGFWmt6SaSfv/3dFEUHHdYG/1FHgup2N+87M
X-Exchange-RoutingPolicyChecked: 
	qcz+OF3pUa0s99Fe+Z0gfMPsIAuAXjOcJ1xd0F4z7/pZ1fQGlyIh/Jvd6sa3o0O2FjkmlWL38wj8ndtG8dAJR9jDPD2vmGyIviVFMg05P1D3IbR/11nPCr0xt3H+IGVHyj9K6sgVtJt23eWA9N99ILEqo0GnGpjyF5TKFSVXo7d6O9kIGYOXYzLfy9akK5kFd5zDIwAjPlOf4R7qFqA2fB+q+59gxCe0wwIwlODG8UpccqnvEAGP4nY6JihBPUTEsFLr4x3EpUbe/tji9WjfgrIToPcdb0CGH8+FCsq1JHTH1TUhYnmbWuTBHYFCwZACKJcH0xR4B4edkByS6C7srg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 03:45:20.9197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 8fbc9161-92c1-420b-25d2-08def9b67714
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7077
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDAyOCBTYWx0ZWRfX8q+3pMMNCirM
 CIJesflP1WLxBNJNiz27maDoHyNOPcXea8XPLZs0ReFfYOLQJPm3vnuUI4/G2ZDanHP3gaC5qIo
 IS+Z3cBRzEdYe7CXT7h3xCmFe10iwqE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDAyOCBTYWx0ZWRfX1b2ZWtsH+0I1
 cnR/a/vgBi5mmA/F9PlGmvkrQGfjbdZiwx7cRochCch1zKf/R+ynOgJs+/mrUklwzX9aEMPawa0
 61+DZNkFD8n+SM6nflSj6I9lEAIVulJIrBgI0FNwiajYMYZ94IveEZuHSYTfrjQDs88JPI5bwSr
 YXCj1BcEt9t2zY7fA6KOUVyt+vnAW5drj7HOPVbBQVhE6xX86wKEjdI8hD3mrGlsBjPT2YGhgrv
 QGQihxuRNirbcAhRRcgNT92hBSZDZdDDRfTssRQm7gSb5acPyApE+XPYPT8Dnxf52N4CYiDw8MD
 s+SAWCheWyQU5tYZEpx7o7q4/+RO9XpMdkwmcgGUzih97USJlNoUbHckGQMgKVz/1XyrttoxAAs
 1IlXdPSIiTvYn49MZVbcvIWHLwuCDpeFjJgpqADVcamPykTW7XaWWeF0m0sQFEOb1MELBYyQQ8H
 JYtov5TW13hB9p4Hlqg==
X-Authority-Analysis: v=2.4 cv=Ae6B2XXG c=1 sm=1 tr=0 ts=6a7e8f54 cx=c_pps
 a=la37NW5KtsdugurppmDlYQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=xqWC_Br6kY4A:10 a=HSjQpOrDgPAA:10
 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=bx814J3U1Kdcb7-RJgoA:9 a=wPNLvfGTeEIA:10 a=AYPdVbMCoRMNhZ_2:21
 a=frz4AuCg-hUA:10 a=_W_S_7VecoQA:10
X-Proofpoint-ORIG-GUID: mt9SXZM4kkG7WeybgK-4CdC-iFHC20eG
X-Proofpoint-GUID: mt9SXZM4kkG7WeybgK-4CdC-iFHC20eG
Subject: Re:  Re: [PATCH v2] ASoC: tas2783-sdw: add firmware download status
 check
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140028
X-MailFrom: baojun.xu@ti.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: QOXCYFGGRRSFWUAS3BH73XDISDDKAZME
X-Message-ID-Hash: QOXCYFGGRRSFWUAS3BH73XDISDDKAZME
X-Mailman-Approved-At: Mon, 17 Aug 2026 16:57:39 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QOXCYFGGRRSFWUAS3BH73XDISDDKAZME/>
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
> > memory pages (addresses > 0xc60000) are skipped even after an AMP reset.
>
> > +             if (!tas_dev->first_hw_init || file->dest_addr < 0xc60000=
) {
> > +                     ret =3D sdw_nwrite_no_pm(tas_dev->sdw_peripheral,
> > +                                            file->dest_addr,
> > +                                            file->length,
> +                                            file->fw_data);
>
> What happens if the amplifier uses power (eg, over a system suspend)?
> Though since nothing clears first_hw_init I guess there might be issues
> there anyway...
Hi Mark,
Yes, that is the purpose of this patch. It prevents the re-downloading of
pages above 0xC60000 after resuming from suspend, as the data in this region
persists across an AMP reset. Therefore, these pages should only be downloa=
ded
during the initial power-up (when first_hw_init is false).

Best Regards
Jim


