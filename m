Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE931606A882
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2026 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=E2jS4zI6;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=msoOYjpr
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 75BD6601E5;
	Thu, 12 Nov 2026 16:26:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 75BD6601E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794497214;
	bh=WgViGC7j/JSWb9LvsXCqHeMeadbn4L5ZGEqkmJaRHyY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=E2jS4zI6dopGtm9tA6xMm3dLPjKnYWUxmF5pLOo2UB6s8zJSurdCOkYnPh2DqTFnO
	 c/kWzSKkkYjE2JDC1XlkTJIQ7B38cTbeI4XNCKWaCt1uTpWR9ZzPtWLhktO4ZJzEnT
	 Y+twcwJ3nfARf6VawQmCPF8yHZdXTRFKcx6TX5Ks=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 72EC2F80602; Thu, 12 Nov 2026 16:26:21 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BE8ABF805FF;
	Thu, 12 Nov 2026 16:26:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AA9C1F80016; Thu, 12 Nov 2026 16:26:14 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.35
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1794497173;
	b=Esw7bfbvkviWoEu7UX8MDvFl1LpHzzTKxFcnRcg8HKZmhnBGkYFfOUmhDMrkpeteW3SN
	 LVUjPVWKrE7zChGGccFz+JXvHDdNV7ZAgBvuWXlQH2k+qhR57xbNktsDL6A3R3AJRisM8
	 rpUm1iF7shXizScjIitvqWJ0SQj5J8VU2xx8SeBVGDPegr1rwJxPXlyqIGsQAte7zvnz4
	 Xd6iRsKmakjPhGZOAtJQePOyciEW5VvFL1k6HYS5rcOaEapuo0Li/k8EC2umOyvh0hF3a
	 +dufWHqHAwN+i6JUXxaNHnujvfG1xHk5xYYbqTcVPtwepWp/JEA744qt7MePbQHH4+A==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794497173;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version;
	bh=WgViGC7j/JSWb9LvsXCqHeMeadbn4L5ZGEqkmJaRHyY=;
	b=ES3MECBxbkuhEVIdUIimo8VX8AWbXw5E1+TPY3NYqXH1okcctuZUxm2xgTMV9tbjJs04
	 vJlfc7j6T+ERZ43ms4f8KchoypoH8/R3UwA/ozFwLcLF6h3/IKv22Xy7Xl9I6QqTM06kn
	 WFaFz3UIHgnbJ58W60KasT20BxLM+mPfnd4/X/KrHn9TOM4gtIJS7MViVmV9WY7qOgGF8
	 AZLECbSY83aEl9ZzLkBmqS2AzOkAbdj5fo45/MQRa1SzUAfYxmVho2p3IlbJvO4G7tEmQ
	 Z7i1zJiCUOEg5Af0HVAmP0dsK6Geq9y2bDBlc6dfWiUJhK20MuKFzIQ5IrONrUH0+MQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=msoOYjpr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.35
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010035.outbound.protection.outlook.com [52.101.85.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DBB1EF80016
	for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2026 16:26:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DBB1EF80016
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=msoOYjpr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fTWQt6Qazg3utbk+YskuBTW/ZzEMcwsqf9e9ZVvKVI0syyIAAemtrXokxRPpM8FzXTjLoiDiFHcIuyexKFDQfyrxJHUgFt9i23cfm9tmQadukAHi0WSu/4C9gzCpDxD90qFFH2JCgeoLVYr+aaH3HZ6krdEFk8tS6iMeYQW2PCU41S6n5VBE8jhcdGhKd6MqL5Bn4ovUhcWPdDOTZ5xfI8nzD/fa7VRU05fYughB5c5HsLLmhR9y5tQogTysD3PWXDXJDVjDkJK2XqZpC5L78adI3ST3TmJxXIsaOtn77vgVbLTmfqjj79mjk8v/s8jz5yvRBIAmNUe4GoT201Qebw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vt+c1lP2MQcLpTotezIR1f9VeVftDQBNu6OCIQabi8I=;
 b=rqKnBrXYn1o2vQwfkTWQ5+Nze8xUIDITWo34O6j1USW2KMNC0y7VsRkB9LDXyOgPa3WFQ1Cvlyqa1v3BO6e/ksmySj4jhFtIUZke6pXEA2j249rj/jiT6WdmyvM9aYzHQXPVvYyN9KmrL5BZD7qTVJhTrP5IN9HLCOoToxpTFycbvmg2MLUddtbzCeZDouphyPaUvSpc/T/GUu2umZcYgEoRby+0qSMxSABD7S50wf4YdWed4VrVOjhXDXvDNJyt9pylDz1MsY0ubyGeOwMGJYVa3UeJc6bAx9sxCqKLWmlXWFTgZy4q2DZPJS4DBF8MaGOBl/6VCTcM2rYas3iAFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vt+c1lP2MQcLpTotezIR1f9VeVftDQBNu6OCIQabi8I=;
 b=msoOYjprmwLjPQIhq8i8zIq3hrQ/kcoPjHOhePZ0nRvWXo9q08tmCWHILKDFve4kjHyod8JP/Gx52qt2twmEs0mcBmFIh5gzXKAcbnbXpiaUnFrE9fy8r+CFgcOGzw29B9OfewucA8PhcS/NQ26eL4OkPzY3PIKPai/Ir8ApwJ0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17)
 by BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 12 Nov
 2026 15:26:03 +0000
Received: from CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2]) by CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2%4]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 15:26:03 +0000
Message-ID: <f73ee923-81b2-4637-9ca5-6bc93dfac35a@amd.com>
Date: Thu, 12 Nov 2026 20:58:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] ASoC: amd: acp: ACP7.F SoundWire configs and SOF
 function topology support
To: Syed Saba Kareem <syed.sabakareem@amd.com>, broonie@kernel.org,
 alsa-devel@alsa-project.org
Cc: anson.tsao@amd.com, Sunil-kumar.Dommati@amd.com,
 mario.limonciello@amd.com, Guo Ren <guoren@kernel.org>,
 "open list:C-SKY ARCHITECTURE:Keyword:csky" <linux-csky@vger.kernel.org>
References: <20261112123603.2891858-1-syed.sabakareem@amd.com>
Content-Language: en-US
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <20261112123603.2891858-1-syed.sabakareem@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ad::12) To CY5PR12MB6252.namprd12.prod.outlook.com
 (2603:10b6:930:20::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6252:EE_|BL1PR12MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: 007f873f-4b8e-4e30-1633-08df40d14347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|22082099003|18002099003|10067099003|261026140227099003|261009223027099003|11063799006|56012099006|261102123227099003|261021121427099003|261026121527099003|261022105027099003|261022075727099003|261021123027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: 
	fO8TUuW32vemvkFLcvw/q7rvsI3pqHhHRd7gmmp7Us/+6DKMcWJe50KuN5Q3IC4N0G+ofhX5g5wzELaRHEfsLxdEjw9tE1BfjEPJo+JsBhivyrLLmmzsl7IJ+0IVYbpVekTwmaSkzVJXB+mA1RkiwCVaQ1pIQG46Ktn/4g3MjU+luhJffxwPpVqKmlQVa6NC+QqsXxnSuQmMU9eSqjfasz0fz/AcdCONuYFVhAq6M2y291sjxjAqKPaeFo0pJazMONg7acU3kABI/L6gI5lb4I10bI8FlXEAi0kj/kCxkztqLDCqG6/WNfUJkkwyMBoHVUes+LJC3SdFte9v9GaZybREW4eCfjffu71tCJUtRmigGvf8jUjviDRhDVHTvElzBwnK/aj9wsm52dDjU6ZhQ672IpFTj/LQaHnwBaYnHOXvYoN2GBN5OtaXVcgP4NwOsdzVLa78GE2X6wx5BkBX9lz3Q7v+qiFPRTgrqQ4WY3Zi8hIBn5hHiqdEzABDkO5RA1VDgnphNhiQ70rom8KTVYfgBQC9GgfNpNuFhvn2dhOBKxA7a6uA4ehYaqtYioAC3eVyeml6AbAm35+yjQ98Fbk6OqgZc88p+xRjJNk2euR9QN/XUyCjjmyhnf5utNc/1mPZzsmqq2wZslzubQVPJCuBZIdNAE9q6bl7H4x8V3A=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(261026140227099003)(261009223027099003)(11063799006)(56012099006)(261102123227099003)(261021121427099003)(261026121527099003)(261022105027099003)(261022075727099003)(261021123027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d3BPenhHRUhBNTh1QklmOHVBZERqNThNNmdwTzhTeFlxeW02cXhlVTdDZFBS?=
 =?utf-8?B?WEtNT1RuNjdXeDZ2M3o5eHg2R0VMTkVXM3pyd3NYTjIwalZYM3JucndmVFZz?=
 =?utf-8?B?TUJObE5LRElhbXBpbzJsalpTVVczOVFqZ2hrUTl4bXpBNHphSk1CQlQxZ21h?=
 =?utf-8?B?RENnQndac2Y3QnJDTldlYWRSVmMrdVRNTkdIV05zWnZCNUZQRDljNkUwZUsz?=
 =?utf-8?B?OVdUN05TaVdIdUcwSFE4Vk04MEJkOHQ5ckN2VmNCc0U1akRNa3ljYkJvWDln?=
 =?utf-8?B?YkNNZHVpTzBRSEtDZTUrRmlWS2Y0RXhNcjd2ek5yWnJPQnNFT3hHKy91cG5F?=
 =?utf-8?B?RzJtcFhidkJSU2tCSXY3bk4zNjRGc3VCT0NjWlp4ZjRxczVXcUkzelBJNFd5?=
 =?utf-8?B?NjRUQlNQcWp5Mm9Pc2dtVWppenVJdmN0S0cvY1I1OXQwNmFnMy9BR0lRUUNE?=
 =?utf-8?B?VVlDR3FEdUt6R0RORUE5ak5nSTgvKzh4MHk3UG9Qb2YydGpaZ3pNSDJCSElR?=
 =?utf-8?B?cHo0Q1BYWUdiQmh5T0lzSmwxWWp3UDFnb091MVMyUEd0T08yM3FZN0Zvbk1r?=
 =?utf-8?B?ZFBkK0dKM3Q4RGkwNWw2RUVzeGVvQ3NCUmpWZEFyVGNUajFSY3BaNUhaeVVY?=
 =?utf-8?B?YWlmYmhxMmtEUEd1c0pydmxndDhTeDRrbXRrVkJZSXJtbWxWb2hWMW5nb2VI?=
 =?utf-8?B?K2VSb2dKck1xVWNsUG5xU3N5clRuZ1ordFp0TjQvZFZTVStvaEliaFVjSzVQ?=
 =?utf-8?B?VHExNXI2TE9tVVNCaXRremdrQkJGTFZoY2hSckNGZUtkM3YvRFNsWThNRk1X?=
 =?utf-8?B?R2d1Zlo3TUxEdkNMNGsyUE5NQnpGaldtUng3cTMzSlkxVjJaMWxDZ1FDakVx?=
 =?utf-8?B?MVI2UHRuZUhuOG5lZ2VjdUpNazVKK2gzdlZGTFpwamFGVnRocnlwWmdNd2Nr?=
 =?utf-8?B?ZUg5cFNHZzE4Z21uMEdJY0xoamhhUHA4dzVWVEJXSWRlcExNMERLUG5tYVhQ?=
 =?utf-8?B?dlJyK0kvNzVzTUJ5NG95UmlTeU1jbWZHNGkxZHJXNm5MbzVyWUVBT3VobnQ3?=
 =?utf-8?B?RXpBQkxFeHk2a0lMUVFmSzR1eVJBMnQ5aC9WbnpRcTZKcW1RQzV1bjhoOGpu?=
 =?utf-8?B?eVBSMnBZUmRmbUdoWWVUT3Jjcm9ndHZTdGxaOHJ4TEg4MVdvdXdyd1IwWnU3?=
 =?utf-8?B?ZzFNU2VPVXlUOG5SQVNsTFRtWWxiRHVNaklEY3R6Tmtha0J1YjNzb3JkTlVS?=
 =?utf-8?B?NVJNVitaUXh4VGRyUkt5OTRIMzVrMVVjb1gxMXV4SXhVNm9rOEo4aEpJZ3F1?=
 =?utf-8?B?SWRWRmpaT1Q2aTFjZVp6UWJDZkNTdlhCVlUwRHJGdkJHenV0Yk93RkRNdk9m?=
 =?utf-8?B?OFgxRjRDL21LaEVTZ2tUZEdZRVZ3ZDhOM25ZM0pROS9SZHpLQUt6dDUra081?=
 =?utf-8?B?S0d6dmhxOVBEZ3RZWURlNmhPeFQ2RU9wT3NDSCtmSFNabGlXUURpazQvb0NN?=
 =?utf-8?B?eDVER290K2pLR0VrWVNqb3g1ZVM1M1NLWDVubWxYTDlNa0o2d2J1OHdGSEZR?=
 =?utf-8?B?SHlDSTJPbVN4b1cyTXQwZnl0b2w2MHBDMG5Zd3FmL09GWFF3aW0zVTcwMERL?=
 =?utf-8?B?YjBDVTdhTlZUbndXZENHZlhleExmVVJvZ0dCaWE2YVJMK1d6UUFEWFhsSTNU?=
 =?utf-8?B?VUI4ZHRqRU5VVzNGZzU5MW00MFphbXlOSmtmNkFTa0tqZCs3SHFnclVGallY?=
 =?utf-8?B?K3JldENTSWpqNStaNXRGdVJFeXdUdG5hV0o1OGNXK2laeTJFcjNsTnFXSUJY?=
 =?utf-8?B?cHpKNzZpR2RTc3ZVdDZVVlZXUllYMytwbzM1c1FEV1M2NFlIQmxhVmo4ckdq?=
 =?utf-8?B?OVNlMkM5UmFjeUMxZmcvMXNtSHJmTWJYSy92LzVFeFBrODgydFpreFFIQ1BN?=
 =?utf-8?B?ZlJabGhjNFQ3RWIzakowN2ZBc0t5YjZQblZyMkJDV0gwMWxuc3dvSlJubVky?=
 =?utf-8?B?ZkhaTnoxMS8wbmFKdEtEMDV3RXRIRzM3UWhpRUY4NGVpMnBJNlBxRndWdlR6?=
 =?utf-8?B?UG1iK1ZheU05dFE2bmZQYlgvbzk2OXZJK2ViSytaUzBnaFVmOWYyS3Y1TWF5?=
 =?utf-8?B?R1l5MzZuY0ZtWldRQUsxMmlVVGFjTnVGZDFhSUF3YWJ3VXZWU2dGODliN29S?=
 =?utf-8?B?UG91ejAxK0VLN1d0MnpSOTNUZXI5a2d1NnRjNUJjeHA5VDZ0VEw3V0t0WlFI?=
 =?utf-8?B?NExXQlkxeFlTcU5CMzhWV1lzME1SUHpScGxqV1psWmF3MzJ1c3podGQ4S0Iz?=
 =?utf-8?B?SGV5R2F4WldnbldNVS8zc1ZFRXIwcnZ1RG9kOURWbUFFSExTZ0E2Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 007f873f-4b8e-4e30-1633-08df40d14347
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 15:26:03.4460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 U/2DdElw0sN/t8iPNvHuyTkrj+fu/goCDKKueORKlfdl0+Mek7tn5FlQ+tYRBR6I9pmNMis2bh4Qk1A22VaLlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5874
Message-ID-Hash: ESEGZ3FV3LGLB4EBVRAJGJKBPSFVMHSR
X-Message-ID-Hash: ESEGZ3FV3LGLB4EBVRAJGJKBPSFVMHSR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ESEGZ3FV3LGLB4EBVRAJGJKBPSFVMHSR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On 12/11/26 18:05, Syed Saba Kareem wrote:
> From: Syed Saba Kareem <Syed.SabaKareem@amd.com>
>
> This series adds the Cirrus SoundWire machine configurations for ACP7.F
> and reworks the SOF function-topology handling so it can be shared
> between the Intel and AMD ACP drivers.
>
> Patches 1-2 add the ACP7.F Cirrus SoundWire machine descriptors
> (endpoint, adr_device and link_adr tables and the machine entries) and
> the Dell speaker-amp DMI quirks.
>
> Patches 3-6 move the common SOF function-topology helpers out of the
> Intel code into soc-acpi, add AMD ACP support for them, always append
> the DAI type to the SoundWire DAI link names, and finally enable
> function topologies for the ACP7.B and ACP7.F SoundWire machines.
>
> Changes in v4:
>  - Add a public SND_SOC_ACPI_SOF_PLATFORM_NAME_MAX constant in
>    soc-acpi.h as the single authoritative platform-name buffer size and
>    use it for the Intel and AMD callers, replacing the per-driver
>    SOF_INTEL_PLATFORM_NAME_MAX / SOF_AMD_PLATFORM_NAME_MAX defines.
>  - Make snd_soc_acpi_sof_get_platform_name() take a struct device
>    pointer instead of a struct snd_soc_card pointer, consistent with its
>    companion snd_soc_acpi_sof_get_tplg_filename().
>  - Type the tplg_dev parameter of snd_soc_acpi_sof_get_tplg_filename()
>    as enum snd_soc_acpi_tplg_device_id instead of a plain int, now that
>    it is a public API.
>  - Select SND_SOC_ACPI unconditionally in the AMD match Kconfig as well
>    (matching the Intel match) so the shared SOF helpers are always
>    built and there are no undefined references on non-ACPI configs.
>  - Drop the now-unused linux/firmware.h include from the Intel
>    sof-function-topology-lib.c.
>  - In amd_sof_sdw_get_tplg_files(), honour best_effort when
>    get_sdw_link_num() fails on a recognised SoundWire link: skip the
>    link instead of aborting the whole probe, consistent with the
>    handling of unrecognised links.
>  - Expand the patch 3, 4 and 5 commit messages to document the sscanf
>    field widening (the old "sof-%3s" field silently truncated longer
>    platform names), the platform-name buffer sizing, the CONFIG_ACPI
>    guarding of the ACPI-only matching helpers, and why appending the
>    DAI type does not regress the monolithic-topology platforms
>    (ACP6.3/ACP7.0) given the partial topology/DAI-link name matching.
>
> Changes in v3:
>  - Select SND_SOC_ACPI unconditionally in the Intel match Kconfig so the
>    topology helpers moved into soc-acpi link on non-ACPI builds (fixes a
>    kernel test robot modpost error on csky).
>
> Changes in v2:
>  - Drop the unused acp7x_cs35l63x4_l0u0246 link_adr array in patch 1
>    (reported by the kernel test robot).
>  - Add "ASoC: amd: acp: always append the DAI type to SoundWire DAI
>    link names" (patch 5).
>  - Move the AMD function-topology helpers into their own
>    amd-sof-function-topology-lib.{c,h} instead of reusing the Intel
>    file name.
>
> Siva Subramanian Ravi Saravanan (4):
>   ASoC: soc-acpi: move common SOF topology helpers
>   ASoC: amd: acp: add SOF function topology support
>   ASoC: amd: acp: always append the DAI type to SoundWire DAI link names
>   ASoC: amd: acp: enable function topologies for ACP7.B and ACP7.F
>     SoundWire

Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>
> Syed Saba Kareem (2):
>   ASoC: amd: acp: add Cirrus SoundWire configs for ACP7.F
>   ASoC: amd: acp: add SoundWire speaker quirks for Dell platforms
>
>  include/sound/soc-acpi.h                      |  34 ++
>  include/sound/soc-topology.h                  |  10 +
>  sound/soc/amd/acp/Kconfig                     |   2 +-
>  sound/soc/amd/acp/Makefile                    |   3 +-
>  sound/soc/amd/acp/acp-sdw-sof-mach.c          |  51 ++
>  sound/soc/amd/acp/amd-acp7x-acpi-match.c      | 452 ++++++++++++++++++
>  .../amd/acp/amd-sof-function-topology-lib.c   | 140 ++++++
>  .../amd/acp/amd-sof-function-topology-lib.h   |  19 +
>  sound/soc/intel/Kconfig                       |   2 +-
>  .../intel/common/sof-function-topology-lib.c  | 129 ++---
>  sound/soc/soc-acpi.c                          |  55 +++
>  sound/soc/soc-topology.c                      |  16 +
>  12 files changed, 808 insertions(+), 105 deletions(-)
>  create mode 100644 sound/soc/amd/acp/amd-sof-function-topology-lib.c
>  create mode 100644 sound/soc/amd/acp/amd-sof-function-topology-lib.h
>
>
> base-commit: 87eda92d89790d56ddce1af560815a04d70e3a43

