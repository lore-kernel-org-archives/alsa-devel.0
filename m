Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09269CC6B1A
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:49:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EDE0360214;
	Wed, 14 Oct 2026 13:49:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EDE0360214
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791978590;
	bh=uUgMeSo5cFaiN44gHjtusgY+9qBSh/lrSo2ki28xhSw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=J5QrNACkJq2U45q58VFjYsjU928ZY8gsgVdTlFQfSIov/GZZH6iFkcXxHQagPW4wH
	 bJhvo3CT2VN+WzIvlopqomsY9FPn0N/rbnoWhkYGdcqZ8PpNmlHuu4UhEpegJ5IUNk
	 UMc31wmRLgF8/nzTnygxMRKpJr+ELrdA9Hkd1jH8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BD3A9F80608; Wed, 14 Oct 2026 13:49:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 53658F805F4;
	Wed, 14 Oct 2026 13:49:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D1DE9F80448; Wed, 14 Oct 2026 13:49:09 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.40
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791978547;
	b=nHk9y04o74/bWVLbg7QjNS59TxWZYFOn5nBnyD4t2CjTLCZRsAuaHdW3QCwioh6AhXd0
	 RpXhHI+JA8EghrpIWXgMb1x2Nh5v9DuN4+fuv5cdJPlIewZ1Pei9LtNagZyayYmC+SkTy
	 7XUMQpLt95hLD2iFdhjpOMQGIsjV7u+8OQ6Ag5KQ0sJJ0zFXCYmoEhVs/zNcepsbtmBBe
	 uqTDD0TrYOkBBavli7N+BaGT5y2ZQ5jE4CFtU80rPadvdlZgyGV5p8sLR69gaapyNlqkI
	 mP3fTDBNzADtbONfp7s8JI0NsM1BPWrYyXVZmtaz2lmaceYAqSyQ3/srnLzkiKqxPNQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791978547;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version;
	bh=uUgMeSo5cFaiN44gHjtusgY+9qBSh/lrSo2ki28xhSw=;
	b=CkHSpSozqLw4LitQftW8cfVsBAA5aINCwfdr8dwxIqEHAYpi2kh5R/37X3XNZ2uBa57E
	 Lix+YSkWpuPkaWScP/Bb0iiKLmDDq6NQ6pW1HmytxV1ftd5Kl2uCqpQlnwNDSnsOECEbq
	 Escr1DPIpdcO9o3Aig8ErHnSn1T+JXFOVwXM3C5A6NPohe7xBLZ+2x078rJYKWKr/AZpF
	 HV4KnMWixiKkJIE+aQs3A9oGqIzwK/+kdQciKp5DMNPxOnTesM1lM/kA3qQKFequuocXf
	 VUztPqmB+yrkwyN3QrsM9CQcEHYevSi1iS1C+Qo8DHrJ077szpMxrKoEHULopNSKy+Q==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=LtobhNwS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.40
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010040.outbound.protection.outlook.com
 [52.101.193.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 67D80F800E4;
	Wed, 14 Oct 2026 13:49:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 67D80F800E4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=LtobhNwS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DzuLgECYoKvo7zR8aHyPl6S/ZHn7oDpM5Sb8c1siBUe343o3BYL+wp0XjPCiJN36sIeYLjWVKQbv10AQDJs/C/P8S1NX6QfZpDvykubSRExBaIv7k2HDFTE0Q3pLOlWHwsEAhxbDDO1/lON/awmQntmSwZSbZ77WIxM1n7oDk0keET9+lR72gNY5qNsVapRrL1K1bp5jdU3yTjG4AXAkUQjnMq0TL8t3D4JwNLh+SW3Rd/nR1xIyx/4pLHkH5QROL+Og7+Ensd0fgAWCB7GOMpMiWkLWF8FYqFgDLi76JY6qgRndlYIqzMF/0J9i15pnuCd6T3HMEkBg7XDYh5NNTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUgMeSo5cFaiN44gHjtusgY+9qBSh/lrSo2ki28xhSw=;
 b=yw8iTVv3XPfoUBWwWdd+/7RJjGO1kum191mjtJbwwdki+DxFkhJBSf0CRf5DwCN3KEzMcZqmcfiMMewwUfq36A1XRH9bR3F8Mw1rvINn2FaAk7K8U4v1uKzXBxOTdlqEnGPEbospCLx9riecnfh3jZYOXkUERgfay87zSbRB5gHMEOhc4ndljEeHc4aEsXFgwJg8d9HFH3QnkLbBnhChbhno9f+09RKrpcZsgvtbblf2WfGjhbVvjz6LI813ygMjsz+5A5D4V6J6VS35+d0ZR4d9kjZb00ncGQK2TUdgSy6IJw/MCvR6Nkys6FbG4wxNJaGZe4NU20mZgKYKKWHD0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUgMeSo5cFaiN44gHjtusgY+9qBSh/lrSo2ki28xhSw=;
 b=LtobhNwSDwGczfryUfRBkHm60+elgfA6y02eeqJ9lwmfdwWIsouDVf6P6FB3QvaCRIzdFwGECFDfldxR7nTf/qV2JsVRXkFv7gWceTRaBS9FAFgRhinKEQXNglP3MGlFVapuaKKoAC1jaTFXxbuKxwXP/xMsUBo1oVRwbpVsSRQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 IA0PPF0C93AC97B.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 11:49:00 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%4]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 11:49:00 +0000
Message-ID: <031c7453-9652-4573-9de0-5db2a795562c@amd.com>
Date: Wed, 14 Oct 2026 17:21:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] ASoC: SOF/amd: ACP7.B support and ASP carveout
 firmware loading
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, yung-chuan.liao@linux.intel.com,
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
 venkataprasad.potturu@amd.com, Syed.SabaKareem@amd.com,
 Mario.Limonciello@amd.com, Richard.Gong@amd.com, Poojitha.N@amd.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 sound-open-firmware@alsa-project.org
References: <20261014100902.1215212-1-Vijendar.Mukunda@amd.com>
 <a22f2a9b-3bb9-40d0-80d6-4ce36758c4f5@sirena.org.uk>
Content-Language: en-US
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <a22f2a9b-3bb9-40d0-80d6-4ce36758c4f5@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0089.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b6::6) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|IA0PPF0C93AC97B:EE_
X-MS-Office365-Filtering-Correlation-Id: 1196a510-64d3-41d7-e274-08df29e922b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|10067099003|261009223027099003|4143699003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	b6DSCquS4MfIvZvqhJSkKgrx4RazbRqf750xHBX0TSUZ4I2HFRWiIKyasL8OmG75Sw0Q79j2/3NSmrCxQLI+kkcQAmGS/oaN8Kv4FBH+Cq9xSlvLRt3kyJQrVrnEETETT9zUANNbmss+aAC+0q46NZxoDsJDT02wk5XtyffjT2yYr6KCKDXMkea4f1MJkTMbrTuqGA59lahkGhsxqhGEMyyhPyRo1lmZpI1qJ2jgEhrm3nW2YxBEVwXDrpNbf5cOh3yDxDy1R83OiKIk/Zz8JD5hyjJKU1hlg0U2qrTXLjqpNmRM/+5W0GDmtibTgGjtsSMVpW+KUSqp312NFcCiT68Nar89ovxAGwBN+8WMjuTf+lqeq51YmFgWM9UyuNqUAzD6SYDnYTG97whIoEluQgkVbVmLwtSLENMDQWdPm/Rtx3K5bW2pIhc2hl+w+RwMY5HT7FTMDSu0TqALkALB5Ued6UBnUK0UO2DOeYBX+VwyJWvzwwWK4uSjOekgaI2sLHn195KTCSoqk2nxiChl+bBqDD9GuhbWzk487EDiZ3dacmYDR+kBsJ/De9MVi/PbRnClu3YTloubiEAUx1gP6VCptetjrBiTB/1M737mPeA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9567.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(261009223027099003)(4143699003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V3paUzF6dnhLVktTVjBZQ2pCZ09iS1ZFM24vbmI1YkxPM0djTEQ0ZEt6NE4r?=
 =?utf-8?B?d1ovQkEveVh2SE4zNXFvRUtqN0dKbG83VVErZUJpa0RRN3JRdUJxUlY1TktE?=
 =?utf-8?B?eHBsR3J4WlVUTHUzcFY2V3MrQm1yUGI3NjlsYzJKMmh1cTNTbFFLc2JMUC9s?=
 =?utf-8?B?emJ0U3htcG5peVIyVDdRdFlyOGF5OSt0NFRLNWFjQ0ZyVEpYU3RKWjFEZFhK?=
 =?utf-8?B?aTJUK0F4MGlqSWNERmwxUnJDNzBiUWRzWnVwSWVmM3BNUkVEOWVCek10am9h?=
 =?utf-8?B?dU1IM2VLVndQWWNVM0pLRWtCTG1WVFBBeGdTdmNmUmFkTjM0NGI5ODk4djZv?=
 =?utf-8?B?blhIbm00RG5GM0kzTzhIUW9BcXU1SGFCcW9lNWVtbURrNnF6KzlxejEvUmR5?=
 =?utf-8?B?d2kzODMrUld6MjNseXdPK1Bxa0FWdzNpK2RuZkxSdTYrdGlISndDVmp1VUth?=
 =?utf-8?B?c3ZiMm5ZTGFMalVLOWwyUGx6SEtzR2x0SEIrQjhiUmlHZDh2M1VYVDc4TmhQ?=
 =?utf-8?B?TlNkWElSSm1SQ1A5MkRQdEhheUwwWDQ2VTQ3cU91UkU5MXJaTDM3R24rdkd3?=
 =?utf-8?B?MXdDK2oxeTQxaHlMU2tjQ3JrMk54b0ZEaUxCVW9qZk5lU09EWGtXMHMrUUtK?=
 =?utf-8?B?dVllU2NRQ0JSVG5mSzY4bVB6Z2J6ekpoaHNicVh0dFJFbDRTUzV0cTlPRVFy?=
 =?utf-8?B?Sjczc1BuRTJ6d25Md0hnMm5Yd1VCLzIvamxQazZyMldqRkduVk1Rb3lrcFRL?=
 =?utf-8?B?TUxra1N5bE1UT1lnSEZlN2p5Tm9jRmFHLzhodWFMNVVoQkY1eFNWTjBvNm5Y?=
 =?utf-8?B?UnE0THlrWDR0ZlhuaklvclE3TEVubGxyWklEYTNTbzJLbU5IeVVDSSt3eVpm?=
 =?utf-8?B?WUlsbUovdWV4eXpIWEJQSHR5c2FZQWNzU0QrQWNJVytrU0c2NDVaOE5FUC9L?=
 =?utf-8?B?OGt1YkdVVUUrR0tjRWlaMFBqYWl6cUo5VFNheUZyakRxcFVNN1VHMXZXSnlj?=
 =?utf-8?B?Uk9YTklhTUNKc3VMQkI3MTFHdHNxYkw0RGdveHhxcy9CTkh1OE1JdmZqRFY5?=
 =?utf-8?B?UmFKUkJhTkx3bEg1b0RVR0VSSDhESlRoeFpUZEZoSVNxeVErb0psVjAxQWFj?=
 =?utf-8?B?VGVLdTJRa2ViSE5kcitoTXNXNWQ2SWdsRURNTUpyblBsRHRRZElISmtXUHZu?=
 =?utf-8?B?aUo4dy9PVFZ4alFrSW03L0dSYmNpQnpqbVYxRFl0bGt0UEZwcWhoZ0F5b2Qv?=
 =?utf-8?B?M1k3N0c4bDBUbFVIQVdzcE4vcE5qeGl2eVcvRFZuMU51TGRyMUNGVjgzNkht?=
 =?utf-8?B?TStiNjhkQkxHRjZnVjdtQTl4aitic1h4Szlmd3VLRUlIK0R6SHk4MVpWTGFZ?=
 =?utf-8?B?L0JvNnhNcUNsNThPZFcvclFJOWswQWZlL2RnS0lvLzZJRTJrQlVYVHdjc3hs?=
 =?utf-8?B?VFV3VzJSRDVTd0NReGZRLy9CU3BPNlJ0NmVkdSs4STZPZDRrakdLQiszcDhX?=
 =?utf-8?B?MXprS2FxTjZ0TFNHNjJ6bFNrVEExbkFLTVk1NzNTOUl3RmxwMXFSODNLK2Nz?=
 =?utf-8?B?Wk1yOHJ6dlRJYlk0OS9sN2k4azhtbmgrVUF4YzBmM05JbHlnMC9nN1RlOFBs?=
 =?utf-8?B?RzBnanJ2cm1ibXR4ckhUN2RjV09FV1U2YnZTcEtURjVraHhUci9lTXdqaGp4?=
 =?utf-8?B?YTRCdzM3U3JFZi9NWWNSZXh4LzBuOWVZcXhNWGhSQW50YnF2RWV6TUdUT0Vp?=
 =?utf-8?B?anQ1OGdVL3ZtUTJnWmFYMm5DU1VpbmJWNE5TYXlWVkZkejBTUWRabDMyUmxr?=
 =?utf-8?B?WXNQTWhYSEJ2UGFZbUJaelpQUlM1T01UbkJZSWY4bFpwTE44THk2RUNudHdC?=
 =?utf-8?B?ZWh4Q2NQUnVscEJtd0MyOUxlMk96UkFyaUFjZmtVSjhOc0FvZi9IbDM5VllW?=
 =?utf-8?B?NTVHdDNUQXo4dkRvZ080NlB1VVN4MlhucjBpbU5vYWRPaHFkZDh5TmtXelpv?=
 =?utf-8?B?UEhqUGZOM2ZuakdEMHJCT3pjN0RVS0NXOGdoeTI3KytVZ25NTzRFMkpHblIx?=
 =?utf-8?B?L2dzRVFNSjJRYU90bCtGK29PRGxvQ0E3RFdDSlJRcXRkWXcwR3VMRVhORE1B?=
 =?utf-8?B?cWEyeUdIVUxpWEhobGliSEdTTTZ0M2dsQnlQUHAycVNEZWoya01FM3pFWW1T?=
 =?utf-8?B?ME9ZTXNXcWF5SkZuM1hJU2Zhd3o0bnZGSkJoRmtYRE1yY3c4dmVzaGFhc2d0?=
 =?utf-8?B?M3dya0JreFFITVlmVWhPc1R0TVhteWZrYWR1MFFKZlFHbFN2eXBLTkIrayti?=
 =?utf-8?B?SERSNVBpS0RvZlRIOUR1QTlUNEVUVXl1eW8vVzRhWlBqUzNIR3dndz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 1196a510-64d3-41d7-e274-08df29e922b9
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 11:49:00.0353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 bN++hWO9kwLl6ZUQ8k6eI4StZ1N/uCoAoozpCMvHYArgPBdIzBhNCQ2iqn5svsejhd6pXGsPYNyjBscu1UpYog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF0C93AC97B
Message-ID-Hash: I4O6LVEGNV55HQ6URJQCHBGCL6EVBTGO
X-Message-ID-Hash: I4O6LVEGNV55HQ6URJQCHBGCL6EVBTGO
X-MailFrom: Vijendar.Mukunda@amd.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/I4O6LVEGNV55HQ6URJQCHBGCL6EVBTGO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 14/10/26 16:14, Mark Brown wrote:
> On Wed, Oct 14, 2026 at 03:29:08PM +0530, Vijendar Mukunda wrote:
>> This series adds ACP7.B platform support to the AMD SOF driver stack
>> and implements the ASP-authenticated firmware load path required by
>> both ACP7.B and ACP7.F.
> v1 is already in my CI queue, can you send an incremental change with
> the new stuff in here.
Posted an incremental patch set on top of v1.
https://lore.kernel.org/alsa-devel/20261013154644.3788064-1-Vijendar.Mukunda@amd.com/T/#m6b17b469c043e46ee50a3a85903324c896c81c4e


