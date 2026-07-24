Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810A7C531C9
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Jul 2026 21:12:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DB0D360200;
	Fri, 24 Jul 2026 23:12:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DB0D360200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784927547;
	bh=tW7K0eAmafHoGG+oF3pS6F7Ym6wlJCNRuu/tDiMWsm0=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Z5Md2iV5Pp61dJucVxYkZNQg0zMlsuCM0cgvx4LCyspHNTGExgtyNf9CidnS0+hrz
	 Yme66tr2jIi6EOFNVgrhp3qLKTTkqmyvtk8fuizco7Hvye+gHrUb7r7JDBUZbgyOOz
	 wmdiL+OMhKvA3aqE7vSu2KSXxoctusH0+w0yL84o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0C971F805FB; Fri, 24 Jul 2026 23:11:54 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9EE3FF805ED;
	Fri, 24 Jul 2026 23:11:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 39E58F805BF; Fri, 24 Jul 2026 13:25:53 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.70
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1784892351;
	b=b8Nf1xteu2k0Z2GgyMPGMrqln1cGbnRo9/wFiAgQQ5frHPOAerthiOsq3Q202WIImwWp
	 bQuw7JSSsdSbclqEjMxowra6eotg3a41P5tfInLGooupe0Q1sNOreudiqFHz/3t1VywXe
	 Ghwb8ka1QSRPFBcB/gDGNW0p5MppscWGNEPu7z4HLEAi7psZaoVLhhk736oaSbD638irj
	 qEhu+bPZIHybasVXgQx66PS6bWmZCcjM7dJuXCG2sRQtVTotf0RprI7iAmSZahugNax0H
	 rL7Lby24HT9hgfXIYrkfqW4gqNnvDy+nxiKycGZsvgiHPwg7ywen+GpCyMrHPr0IByw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784892351;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=GErm7C132fOAJ9hBxt+S2P2mwg1C4Gx5sXGxBxvW0WA=;
	b=K/CU2ykW1yGrEhmRGVagePaqI9ppIUUs+lrOTzj7sTg4rYdBnztBZzLcQ9ckYL9HpyGn
	 agx3yMGsYMcUCDTeTbRcbGq5E5yIQBQhKBFcBjvWDObbLhk6QxGBLTYKpQslC9qqOkdoY
	 nN1zLBcr5Y9ZcMlb8TLH89Qgc0dX3v6eFdft+FvhSvlwCsFrn7cFkv/r/hpvoys+YB8We
	 i4qDbbOx2YYID+EWxM25UCVIsJV4AitTimit2+60teS4XDOlSsSyevmXS5zNJIQsWwG1V
	 8Tol/MEz96c8KEPdaD0dVqSVgUVIChjQDR8lYj+bwTl05zkXQxLLyY/es8pWS/D/xNA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256
 header.s=selector1 header.b=WfL8UdOj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.70
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azolkn19011070.outbound.protection.outlook.com [52.103.23.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2D979F802BE
	for <alsa-devel@alsa-project.org>; Fri, 24 Jul 2026 13:25:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2D979F802BE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256
 header.s=selector1 header.b=WfL8UdOj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUB1LT4CL+VB6J0tt5tYB1DbYxsIrSMha5OC0FRJ0o0BfE9ZqShWMgWvBWiaYrtxBQJI6ZlYjSKzQ/nnXzHS24XAdV0IaCEtNkjX7m6in4s4nK/CrHoBGWqenSKnEgYhDMAgTwYO3MO1azpAVN/AhzSZNcgmHxed+OAif57M4cUReY3Y/QJ0QUAYSKSRXLQM637s5cr28oIwepLhHRl/aF9USBFzUfHCO4xS7dS5BtDJX6etTDR0QY7kzXrsCBUG1FxQ7DlrQeI+hT0tQQBgaXhek5kKbZkZkr1LVNQ74K0x1jSmHTm1DnFjvmCW+Spc3HZlzn/SV7KxraBodBg1ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GErm7C132fOAJ9hBxt+S2P2mwg1C4Gx5sXGxBxvW0WA=;
 b=jx6HrsYGCVzyCuIOQX1VWxWcUUUkRjK9mlM+TdLMUSUwwOGFpu0Fy5LRnAvcRqJOGEOtq7X71Q8m5KsPe2R8SCHZGDiSZVR2oWg9H1pABns3HBpX+QMB/8t+V0cZ43fn+SfbxUKJkFaPqQbuv+IjiNBrpdfro56pCu/g2cVVg90M5usQBXfGhQQ0uqgVypB0DYwFuMREm3xw7Os3jrHy9GSKsOoXfx2ECfxtYcYwtg7/ZZ+zU86atgDsGcOoH5/uFNOl2rUcbhry3Dtzp6VdND55NbN97DIiUrQ4+LPsHrytzvFE47inUv6mv4MxaEdqKn4vgRhv8PDdfCAiNsgxaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GErm7C132fOAJ9hBxt+S2P2mwg1C4Gx5sXGxBxvW0WA=;
 b=WfL8UdOj96fzjlXTzfMpu7hr6aawCFIOz7wHf7NSgkG3+/5U9s6B0vodVQnpqlhx4wgbNMzjCGq8L5D/V0q1LiWuY3e0xyrVoyh+Ld8wwear5EpAMlom68gRyyfCaGgzLqTtPsENaayGKNReukRxWEwINHwYOkv3ISmpeck/5dDOtqYU7PO6S6DPFWzXdJmwlAr0BmGYsO7RXHs90HNRZY7cgDwYWzL0x2vX+M59tJvs9j3SqJE3GYcSQNuE4tGwMXTMA2SNh8t3cu+qAES+ATGMLBAzIz26Dc6oalZ7MjSsR1gxMmyRXPfHBfdTZFJXsAxxL4Efi6kkhgCVn6ty2A==
Received: from MWHPR04MB10298.namprd04.prod.outlook.com (2603:10b6:303:29d::9)
 by DM6PR04MB6953.namprd04.prod.outlook.com (2603:10b6:5:24a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 11:25:44 +0000
Received: from MWHPR04MB10298.namprd04.prod.outlook.com
 ([fe80::826f:f28d:3ebb:895f]) by MWHPR04MB10298.namprd04.prod.outlook.com
 ([fe80::826f:f28d:3ebb:895f%6]) with mapi id 15.21.0245.012; Fri, 24 Jul 2026
 11:25:44 +0000
From: Demon Player <DemonPlayer0@outlook.com>
To: "regressions@lists.linux.dev" <regressions@lists.linux.dev>
CC: "regressions@leemhuis.info" <regressions@leemhuis.info>, Mingyou Chen
	<qby140326@gmail.com>, Mario Limonciello <superm1@kernel.org>,
	"Vijendar.Mukunda@amd.com" <Vijendar.Mukunda@amd.com>, Takashi Iwai
	<tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: [REGRESSION] snd_hda_intel: 15s audio resume delay on AMD Conexant
 SN6140
Thread-Topic: [REGRESSION] snd_hda_intel: 15s audio resume delay on AMD
 Conexant SN6140
Thread-Index: AQHdG15oljGbxskmukyFauVxJSiXSw==
Date: Fri, 24 Jul 2026 11:25:44 +0000
Message-ID: 
 <MWHPR04MB102982652A66D828B734EBC4C92CF2@MWHPR04MB10298.namprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR04MB10298:EE_|DM6PR04MB6953:EE_
x-ms-office365-filtering-correlation-id: f66ae839-553c-4bbe-13a6-08dee9764d70
x-microsoft-antispam: 
 BCL:0;ARA:14566002|51005399006|8062599012|8060799015|19110799012|24121999003|22091999003|31061999003|15080799012|15030799006|19101099003|6050399003|40105399003|3430499035|26121999007|102099032|440099028|3412199025;
x-microsoft-antispam-message-info: 
 =?gb2312?B?UDNvR2ZqYUtQRzVBN0IzNE5CMUY3ZlJMUTVCbVNtWHEzQ1U3ei8zTUt2Y1JQ?=
 =?gb2312?B?ZElGN3dKOUlLYU9DaE9jRDEzMmFsbkQxb21XalRPcWs1VEtlditYd1NGVUVK?=
 =?gb2312?B?MWFtU2JBZzA2VnA3VGkxb24xeXQ3a1ltbVZyaUJjYnorMkJSanpoRXpZVXVQ?=
 =?gb2312?B?djNJR29CZFR4THZ0WUpPdEVtRUl4SDlUaTNnWUc2K1hNUjJ4RzBHTDVSMzRT?=
 =?gb2312?B?eXJlVXJFcWxyM2VsV1VZTlF5SjRmYTBlbm9adjdzT2RxT2hHYUpjNzlWOGht?=
 =?gb2312?B?bnNHa2JubHF4L0dZc3FJblZlZWFFZDNjdENwYkwvMUlYbWYycHB4U2VXcnY3?=
 =?gb2312?B?VTNJamJlQ3VZYXhOcytzbUJvbzJuc3dQa1hPTjJZY2dJSklPbEZ6aHIrbG1I?=
 =?gb2312?B?NW5nZUZXbmtIV2tNcEQyTlRzMW1ZNDFiM0FBLzJKdTU2UEFuOXAxOTUzRnM1?=
 =?gb2312?B?TEw5Q2ljbUo0UGQrSkhOb0ZMRHo3bVhjUVU5bUdnZTdnVmZaOUt5UzVVNzg0?=
 =?gb2312?B?aGE2dndvQ0tJMWltcWU2Q0R5K2JNUmhvOVplc3Q5R0V3T1d5TzdEczVETjBj?=
 =?gb2312?B?bCsvbjZVSnlZNDdVMW1VNzVHUFV4RXlOenRVeEJnNWZXZVhydVhTK3pXVC8y?=
 =?gb2312?B?RFp2dUpqREdpTldadEtkcmpnYWpOaHBpNGxVY3lxV3JKWFEwL1BaQXY1b2Zs?=
 =?gb2312?B?L0ZkSFc3M09HRTNDL1BiZGliQjlIOVFoL0JvUDVGa0k5TWxZOWNtdlQyREsz?=
 =?gb2312?B?SWhkYS95ZHI2TW01eWpEK3l6MWY2cTFISHhEU0NtWXg0OEJudXVla21WbE1a?=
 =?gb2312?B?Vm5XOEJyemZKNERYN0x3Rmk2WUpzOTlScmRLS1pRYWlVbVRhWE9qeHlna3p3?=
 =?gb2312?B?a1VRaElLTm1yR0g1Z1VMTEFJRmlnSHNkaDFyczg1aDNJUGNEMGZITUpFUS9o?=
 =?gb2312?B?RVVEd3hCelRJWGN5czEzbXdLTWlLYkFvY0lBUkRjRUI0empRNkhHNyttOWdN?=
 =?gb2312?B?ZFFQYzU1Mk9ZVXMzMS9GZEpjNENaM3lpaVBISDVJa2c4SnRqVjViWi85a01S?=
 =?gb2312?B?V0xHNlByeHpxdll5SHZuWFlKVjFSS3VDM21PVzJMbHhnUU9ON2h1RkQ1OGlp?=
 =?gb2312?B?MXgrbjZkOXMrTEEwQmVCTXFNRmYwV2hseTZHcnB0Uys1cEl3TVQrTFoyYitt?=
 =?gb2312?B?VnZreVFGYkxUNVR2TjVlVTVSU0lzWTdFMkpnd2JTMExvQmI4QVFNNE5Tc1NJ?=
 =?gb2312?B?T0toT3lBWnpRdTRUSkR0THVoTTBPd2ZhTHo4amdVd2s1UEt1d1lnc3AyZnNP?=
 =?gb2312?B?NTFRdE40WTVtZGhWdmE0dTkwdXpUU2NYZ0paQnVDZGJ0VmxjcnJhUjJSV2dD?=
 =?gb2312?B?bDRFV2xlaGE5ZzZLWU5HWFNHc0dvU2xmdllTUEIxQk4xTit2d3lpc2lqeFJL?=
 =?gb2312?Q?78q2000f?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?gb2312?B?MmROVjNGQzhMRjdUa3AzK2tnc0pLWjBWYUYzczVKaHdMaFF4RkFBUVp1Vjkx?=
 =?gb2312?B?V2FOdDlWSUxQYUhOL3BRUE9jTk1qVXpHaExucnhwSkVFYXFRbWZKczlsb2tv?=
 =?gb2312?B?QkxHYlpTY09PcCtLUTRFeXdlQk1XWThmNWFZSmx1T2JkOWFJYTlJck5WcnFQ?=
 =?gb2312?B?NWtMQTloaG5yUHlDYlZrQWx1WGg1NDNVL1VtNTRrY3N4UGZzZHp3cysrcWlH?=
 =?gb2312?B?RW1ZQll1dVR6WWMvc3greEt1UDdjbWJ0MDdxbGUweWFqd0tQTEdyOGpZRFJs?=
 =?gb2312?B?NjFaWEhlU3JnVlJzQVhnRlk5aTNLNTRxWWtKeFJKWlRNNEpzV29hVHhrRmQy?=
 =?gb2312?B?ZGRFcXowMTBxTEtZODdWTG1SMlZLbkVqWUd3bTFoVWh5T0RhSm9NQ2lFY1c1?=
 =?gb2312?B?c3dQa1Z4cHN2N3JwOFlFRGttYUdpWm1aa1pvc0UwSUNUZmQ2eDJPYVdtRTJT?=
 =?gb2312?B?bzRyVWpLdEgwdnQ5NVV5NG5JNWtPQ20rNnVxazdMU0pSOHQ5RzdkeVpRY0d3?=
 =?gb2312?B?dk84NUhPODVZd3ozVUZKMHNoRGVrT3pyS3orN2JyVkhZZnBvemlYTWRjbFlw?=
 =?gb2312?B?U29xRENSNVJ2Y2UrNFdLTkdhejNDSThMVXZwMnZLMHBIQXFaZ3duamtna2R4?=
 =?gb2312?B?K2l2dG1Ea3o5YkEwcUVMZW81L3FDajU2K1I5WGhmNWJnUmxSTUJ1TWFJTU50?=
 =?gb2312?B?czdhekJPeWs0eWJSUFVCR2xhdXJ3WUZIVFRKa1dxbUNueHcxRzRyZUw5TXJJ?=
 =?gb2312?B?dFdMc0xmSWFKank4ak0vWjFuUjUxaGFMaWlvYU0vTVF2a1Ria2pjdE1hTlV5?=
 =?gb2312?B?WDBQcVkvcHU3eCtUT2tHSjZKU0ZuRkZ4cGEzcUsrajNiUFlDVTN1aGowUzdw?=
 =?gb2312?B?QVJROUQ3WUJrazhOeStYRTIzeHFJM2pyejJUcG82b3QyMGZJM3RvREcwQWFp?=
 =?gb2312?B?MVNsaFdQamVYSGJyNUJNVy9KMHZNc2JpZkNMTEY3RzNsQk5nVmhSb0hlTzVQ?=
 =?gb2312?B?SnhNZ2IrdDl2ZFVuQVRUNjhhd3JXYVZzemM0UHVWSGkwQ2dVUnM0ZTJZNmU2?=
 =?gb2312?B?V1ArZVRqU1MzN2hxK25FU2ZCRjZRZXFQVEhhRnJrTFdLQ1U3K2RteU5LUzcz?=
 =?gb2312?B?QTk0Sk5FWit2UEJTaTNNTm51OUljY2pYY1hlTGlKUjI4Y29ndEtrbFY4Tjkv?=
 =?gb2312?B?Vi9ETjRJNEhxMmw3c2xUK2szUGoxY0ZYcmM3Ny9CankxSzFyZS9UQ2ptWFNi?=
 =?gb2312?B?WnRzclRkMktqYkk1TXNBd3NMM2N2bklmSFhMQkVQV04xOG8vVW84djN3N3h4?=
 =?gb2312?B?ZEVOREh1bjdIaU1YN1R4ZFNiaVZrZzVxRVo2aGk5eGtpZjFuRWJ3a3JuQlha?=
 =?gb2312?B?VnphNjQ5Vmw1cFJsOHpKQmdNekZWV0U0TXhhVWllWkdGbTc2Y1Y4TnZIeGp1?=
 =?gb2312?B?MlExL0RmY2VndW83dzNiZytOaElwVVJabWZWZmhqbHhPQ0JQUjJ4d1ovb3Zp?=
 =?gb2312?B?TXZyN0xzODEwOVZOeVhEZXJ6NDZFYjZBUDZ3UkZMSjY3eVF1OTlGanF6Tndl?=
 =?gb2312?B?QVYxWGsyRDQ0LzlwQWFhVE9vTlhySFRncnMySUliK1ZYWWw5Q3lXOEp1VVhX?=
 =?gb2312?B?aEg3dXlpdjkvQjBYQzRkWVVnekJsM2lZUGZQNCt6L2ptbnFPU2VOSzhSbVky?=
 =?gb2312?B?cXdKSGRHMmx4N25ZOEk5TU1jdnJ2NDdwZ2lRcmh3dHVLWDArclBkekpqM21G?=
 =?gb2312?B?Nm9lMlI0NWlzTWQzK3N6Y0VxUDVIYzZpZmcxZ1hZOGRHNDFWSVd2WWQ1aEVz?=
 =?gb2312?Q?hw9x+gI8nqW6XNtFR6bS+szfZRUvmcUmtlaqA=3D?=
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR04MB10298.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 f66ae839-553c-4bbe-13a6-08dee9764d70
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2026 11:25:44.7349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 
 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6953
X-MailFrom: DemonPlayer0@outlook.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: D2FXXGJEXXB24B66SMK53J5MEFKUKV5I
X-Message-ID-Hash: D2FXXGJEXXB24B66SMK53J5MEFKUKV5I
X-Mailman-Approved-At: Fri, 24 Jul 2026 21:11:48 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="gb2312"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZHQMCSZZ24CEDUYMKY7ERHXCY2SRUSOS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

U3ViamVjdDogW1JFR1JFU1NJT05dIHNuZF9oZGFfaW50ZWw6IDE1cyBhdWRpbyByZXN1bWUgZGVs
YXkgb24gQU1EIENvbmV4YW50IFNONjE0MA0KDQpIaSwNCg0KSSdtIHJlcG9ydGluZyBhIHJlZ3Jl
c3Npb24gaW4gdGhlIHNuZF9oZGFfaW50ZWwgYXVkaW8gZHJpdmVyIHRoYXQgSSBiaXNlY3RlZCBv
biBteSBBTUQgcGxhdGZvcm0uDQoNCkxhc3QgZ29vZCBrZXJuZWw6IHY3LjAuMTQNCkZpcnN0IGJh
ZCBrZXJuZWw6IHY3LjEtcmMxDQpCaXNlY3RlZCBmaXJzdCBiYWQgY29tbWl0OiBkZjQxNDhhNWEz
Y2YNCiAgKCJBU29DOiBBZGQgRE1JQyBzdXBwb3J0IGZvciB0aGUgQU1EIFJQTCBwbGF0Zm9ybSIp
DQoNCkhhcmR3YXJlOg0KMDE6MDAuMSBBdWRpbyBkZXZpY2UgWzA0MDNdOiBOVklESUEgQ29ycG9y
YXRpb24gR0IyMDYgSGlnaCBEZWZpbml0aW9uIEF1ZGlvIENvbnRyb2xsZXIgWzEwZGU6MjJlYl0g
KHJldiBhMSkgKHByb2ctaWYgMDAgW0hEQSBjb21wYXRpYmxlXQ0KKQ0KICAgICAgIFN1YnN5c3Rl
bTogTlZJRElBIENvcnBvcmF0aW9uIERldmljZSBbMTBkZTowMDAwXQ0KICAgICAgIFBoeXNpY2Fs
IFNsb3Q6IDANCiAgICAgICBGbGFnczogYnVzIG1hc3RlciwgZmFzdCBkZXZzZWwsIGxhdGVuY3kg
MCwgSVJRIDEwNywgSU9NTVUgZ3JvdXAgMTQNCiAgICAgICBNZW1vcnkgYXQgZmMwODAwMDAgKDMy
LWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9MTZLXQ0KICAgICAgIENhcGFiaWxpdGllczog
WzQwXSBQb3dlciBNYW5hZ2VtZW50IHZlcnNpb24gMw0KICAgICAgIENhcGFiaWxpdGllczogWzQ4
XSBNU0k6IEVuYWJsZS0gQ291bnQ9MS8xIE1hc2thYmxlKyA2NGJpdCsNCiAgICAgICBDYXBhYmls
aXRpZXM6IFs2MF0gRXhwcmVzcyBFbmRwb2ludCwgSW50TXNnTnVtIDANCiAgICAgICBDYXBhYmls
aXRpZXM6IFs5Y10gVmVuZG9yIFNwZWNpZmljIEluZm9ybWF0aW9uOiBMZW49MTQgPD8+DQogICAg
ICAgQ2FwYWJpbGl0aWVzOiBbMTAwXSBEYXRhIExpbmsgRmVhdHVyZSA8Pz4NCiAgICAgICBDYXBh
YmlsaXRpZXM6IFsxMGNdIEFkdmFuY2VkIEVycm9yIFJlcG9ydGluZw0KLS0NCjA2OjAwLjEgQXVk
aW8gZGV2aWNlIFswNDAzXTogQWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1EL0FUSV0g
UmFkZW9uIEhpZ2ggRGVmaW5pdGlvbiBBdWRpbyBDb250cm9sbGVyIFsxMDAyOjE2NDBdIChwcm9n
LWlmIDAwIFtIREENCmNvbXBhdGlibGVdKQ0KICAgICAgIFN1YnN5c3RlbTogQUlzdG9uZSBHbG9i
YWwgTGltaXRlZCBEZXZpY2UgWzFkMDU6NTAwNV0NCiAgICAgICBGbGFnczogYnVzIG1hc3Rlciwg
ZmFzdCBkZXZzZWwsIGxhdGVuY3kgMCwgSVJRIDEwOSwgSU9NTVUgZ3JvdXAgMjANCiAgICAgICBN
ZW1vcnkgYXQgZmM1YzgwMDAgKDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9MTZLXQ0K
ICAgICAgIENhcGFiaWxpdGllczogWzQ4XSBWZW5kb3IgU3BlY2lmaWMgSW5mb3JtYXRpb246IExl
bj0wOCA8Pz4NCiAgICAgICBDYXBhYmlsaXRpZXM6IFs1MF0gUG93ZXIgTWFuYWdlbWVudCB2ZXJz
aW9uIDMNCiAgICAgICBDYXBhYmlsaXRpZXM6IFs2NF0gRXhwcmVzcyBMZWdhY3kgRW5kcG9pbnQs
IEludE1zZ051bSAwDQogICAgICAgQ2FwYWJpbGl0aWVzOiBbYTBdIE1TSTogRW5hYmxlKyBDb3Vu
dD0xLzEgTWFza2FibGUtIDY0Yml0Kw0KICAgICAgIENhcGFiaWxpdGllczogWzEwMF0gVmVuZG9y
IFNwZWNpZmljIEluZm9ybWF0aW9uOiBJRD0wMDAxIFJldj0xIExlbj0wMTAgPD8+DQogICAgICAg
Q2FwYWJpbGl0aWVzOiBbMmEwXSBBY2Nlc3MgQ29udHJvbCBTZXJ2aWNlcw0KICAgICAgIEtlcm5l
bCBkcml2ZXIgaW4gdXNlOiBzbmRfaGRhX2ludGVsDQotLQ0KMDY6MDAuNSBNdWx0aW1lZGlhIGNv
bnRyb2xsZXIgWzA0ODBdOiBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMuIFtBTURdIEF1ZGlv
IENvcHJvY2Vzc29yIFsxMDIyOjE1ZTJdIChyZXYgNjIpDQogICAgICAgU3Vic3lzdGVtOiBBSXN0
b25lIEdsb2JhbCBMaW1pdGVkIERldmljZSBbMWQwNTo1MDA1XQ0KICAgICAgIEZsYWdzOiBmYXN0
IGRldnNlbCwgSVJRIDI1NSwgSU9NTVUgZ3JvdXAgMjQNCiAgICAgICBNZW1vcnkgYXQgZmM1ODAw
MDAgKDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW2Rpc2FibGVkXSBbc2l6ZT0yNTZLXQ0KICAg
ICAgIENhcGFiaWxpdGllczogWzQ4XSBWZW5kb3IgU3BlY2lmaWMgSW5mb3JtYXRpb246IExlbj0w
OCA8Pz4NCiAgICAgICBDYXBhYmlsaXRpZXM6IFs1MF0gUG93ZXIgTWFuYWdlbWVudCB2ZXJzaW9u
IDMNCiAgICAgICBDYXBhYmlsaXRpZXM6IFs2NF0gRXhwcmVzcyBFbmRwb2ludCwgSW50TXNnTnVt
IDANCiAgICAgICBDYXBhYmlsaXRpZXM6IFthMF0gTVNJOiBFbmFibGUrIENvdW50PTEyOC8xIE1h
c2thYmxlLSA2NGJpdCsNCiAgICAgICBDYXBhYmlsaXRpZXM6IFsxMDBdIFZlbmRvciBTcGVjaWZp
YyBJbmZvcm1hdGlvbjogSUQ9MDAwMSBSZXY9MSBMZW49MDEwIDw/Pg0KICAgICAgIENhcGFiaWxp
dGllczogWzJhMF0gQWNjZXNzIENvbnRyb2wgU2VydmljZXMNCiAgICAgICBLZXJuZWwgbW9kdWxl
czogc25kX3BjaV9hY3AzeCwgc25kX3JuX3BjaV9hY3AzeCwgc25kX3BjaV9hY3A1eCwgc25kX3Bj
aV9hY3A2eCwgc25kX2FjcF9wY2ksIHNuZF9wY2lfcHMsIHNuZF9zb2ZfYW1kX3Jlbm9pciwgc25k
Xw0Kc29mX2FtZF9yZW1icmFuZHQsIHNuZF9zb2ZfYW1kX3ZhbmdvZ2gsIHNuZF9zb2ZfYW1kX2Fj
cDYzLCBzbmRfc29mX2FtZF9hY3A3MA0KLS0NCjA2OjAwLjYgQXVkaW8gZGV2aWNlIFswNDAzXTog
QWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1EXSBSeXplbiBIRCBBdWRpbyBDb250cm9s
bGVyIFsxMDIyOjE1ZTNdIChwcm9nLWlmIDAwIFtIREEgY29tcGF0aWJsZV0pDQogICAgICAgRGV2
aWNlTmFtZTogUmVhbHRlayBBTEMxMjIwDQogICAgICAgU3Vic3lzdGVtOiBBSXN0b25lIEdsb2Jh
bCBMaW1pdGVkIERldmljZSBbMWQwNTozMDEwXQ0KICAgICAgIEZsYWdzOiBidXMgbWFzdGVyLCBm
YXN0IGRldnNlbCwgbGF0ZW5jeSAwLCBJUlEgMTEwLCBJT01NVSBncm91cCAyNQ0KICAgICAgIE1l
bW9yeSBhdCBmYzVjMDAwMCAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0zMktdDQog
ICAgICAgQ2FwYWJpbGl0aWVzOiBbNDhdIFZlbmRvciBTcGVjaWZpYyBJbmZvcm1hdGlvbjogTGVu
PTA4IDw/Pg0KICAgICAgIENhcGFiaWxpdGllczogWzUwXSBQb3dlciBNYW5hZ2VtZW50IHZlcnNp
b24gMw0KICAgICAgIENhcGFiaWxpdGllczogWzY0XSBFeHByZXNzIEVuZHBvaW50LCBJbnRNc2dO
dW0gMA0KICAgICAgIENhcGFiaWxpdGllczogW2EwXSBNU0k6IEVuYWJsZSsgQ291bnQ9MS8xIE1h
c2thYmxlLSA2NGJpdCsNCiAgICAgICBDYXBhYmlsaXRpZXM6IFsxMDBdIFZlbmRvciBTcGVjaWZp
YyBJbmZvcm1hdGlvbjogSUQ9MDAwMSBSZXY9MSBMZW49MDEwIDw/Pg0KICAgICAgIENhcGFiaWxp
dGllczogWzJhMF0gQWNjZXNzIENvbnRyb2wgU2VydmljZXMNCg0KSXNzdWUgZGVzY3JpcHRpb246
DQpBZnRlciByZXN1bWluZyBmcm9tIHN1c3BlbmQgKFMzKSwgdGhlIG9uYm9hcmQgYXVkaW8gZGV2
aWNlIHRha2VzIGFwcHJveGltYXRlbHkgMTUgc2Vjb25kcyB0byBiZWNvbWUgYXZhaWxhYmxlLiBE
dXJpbmcgdGhpcyBkZWxheSwgYXBsYXkgLWwgc2hvd3MgdGhlIGRldmljZSB3aXRoIFN1YmRldmlj
ZXM6IDAvMSwgb3IgdGhlIGRldmljZSAoQ29uZXhhbnQgU042MTQwKSBpcyBjb21wbGV0ZWx5IG1p
c3NpbmcgZnJvbSB0aGUgbGlzdC4NCg0KZG1lc2cgZXJyb3JzIChmcm9tIHRoZSBicm9rZW4ga2Vy
bmVsKToNClsgICAzNi4zNjI1NjhdIHNuZF9oZGFfaW50ZWwgMDAwMDowNjowMC42OiBDT1JCIHJl
c2V0IHRpbWVvdXQjMiwgQ09SQlJQID0gNjU1MzUNCg0KU3RlcHMgdG8gcmVwcm9kdWNlOg0KMS4g
Qm9vdCBpbnRvIGFueSBrZXJuZWwgZnJvbSB2Ny4xLXJjMSBvciBsYXRlciAoaW5jbHVkaW5nIHRo
ZSBiYWQgY29tbWl0KS4NCjIuIFN1c3BlbmQgdGhlIHN5c3RlbTogc3lzdGVtY3RsIHN1c3BlbmQN
CjMuIFJlc3VtZSBhZnRlciB+MTAgc2Vjb25kcy4NCjQuIFJ1biBhcGxheSAtbCBhbmQgb2JzZXJ2
ZSB0aGF0IHRoZSBzb3VuZCBjYXJkIGVpdGhlciBzaG93cyBTdWJkZXZpY2VzOiAwLzEgb3IgaXMg
bWlzc2luZy4NCjUuIFdhaXQgfjE1IHNlY29uZHMsIHJ1biBhcGxheSAtbCBhZ2Fpbi4gVGhlIGRl
dmljZSBhcHBlYXJzIGFuZCB3b3JrcyBub3JtYWxseS4NCg0KQWRkaXRpb25hbCBub3RlczoNCi0g
SSBjb25maXJtZWQgdGhlIGlzc3VlIHBlcnNpc3RzIG9uIHRoZSBsYXRlc3QgbWFzdGVyIGJyYW5j
aC4NCi0gSSBjb25maXJtZWQgdGhhdCByZXZlcnRpbmcgY29tbWl0IGRmNDE0OGE1YTNjZiByZXNv
bHZlcyB0aGUgcHJvYmxlbS4NCi0gVGhlIGlzc3VlIGRvZXMgTk9UIG9jY3VyIG9uIHY3LjAuMTQg
b3IgZWFybGllci4NCg0KUGxlYXNlIGxldCBtZSBrbm93IGlmIHlvdSBuZWVkIGFueSBhZGRpdGlv
bmFsIGxvZ3MgKGFsc2EtaW5mbywgZnVsbCBkbWVzZywga2VybmVsIGNvbmZpZykuDQoNCiNyZWd6
Ym90IGludHJvZHVjZWQ6IHY3LjAuMTQuLnY3LjEtcmMxDQo=
