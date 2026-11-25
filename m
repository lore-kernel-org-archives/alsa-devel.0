Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B67606A31E
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Nov 2026 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=UsLmDd35;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tDrYchy6
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 747C86021C;
	Wed, 25 Nov 2026 10:34:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 747C86021C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795599256;
	bh=RxngosLJgWvwRtNp+3tD60AazOnIQa+J8oPEfG30hYQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=UsLmDd35mVWUo1m9wo/f1+mb3Iiv0pUtFk4ayorb5M9WxuPNh5ViBb7nYrN8bx+lD
	 DLKNkeVktkP1X0tf30sQcnQ/u/SzUnymTWin8uCxcJw+/2VjTJYMjTwDwT59rEHtBV
	 SLi8WEV7bsRRfOMYv8dJcoudqx5HwT1zqDLvKPug=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DC63AF805FF; Wed, 25 Nov 2026 10:33:41 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1E93EF80100;
	Wed, 25 Nov 2026 10:33:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9907CF80568; Wed, 25 Nov 2026 10:33:34 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.62
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1795599210;
	b=qc70MjVIvm5ENJEDEt6/pCxwxJgT3+OKzSIMOjZ/jpCBEnvirvjuF/u3dlswtgWuW8bW
	 TM67XVOcsGhXILLfHkZWbDe5ZXuKuj3YxSSUvF/yycwQx6nZvf8YhQUWOtMhFV+2DMyZt
	 NGihfAkel5Kumph0eP2jQpXsEg4lofExIMuXTOrxhZVY5eDxkPyfNFyUnGXXEuBV2UkOv
	 SE+yQefuh8ttEiMK5WnRJoSkQ0C1VBsccye0kV0mrfdKC58JoT+7FTsnXfiK7MA1bAHAm
	 nQkaGx6UEwtmfU0R94WTW6ouwkuz0Q0PFt22HRFhjsLb1ebK2RkONF7nwTTwQqIBXCg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1795599210;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version;
	bh=RxngosLJgWvwRtNp+3tD60AazOnIQa+J8oPEfG30hYQ=;
	b=imoeJFsheDuYbcyqWJ9BW6D8ABEOPnT5wKpLTlSWHvSboHlwYcmsEzlL3LP0DkaPC7cx
	 PM+IcQNZzp5VtCBOTjvgaZwjIS9q0f8sUiL7r+DIkJRCKRP0R5gWzfnEgJbzJopApE/5U
	 OvcFAAb1w5oc132i+cPbx32vRagdwwcLNQPMW+Abm0CrLu+f3TULDY9Vaxzcj7uHduRtY
	 eyazUj0j0lCDRvD0Lg0dvzD9GojcWt+Oy0Ql7p9m/MQQUgkkGnasPQMHoH9wyvAxxaCV6
	 BsfuVZsa+Ks4wL0whrkKrt2fDrZIilvANznSDnDQGMc/ru32Gxappm7idFic83cDTNQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=tDrYchy6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.62
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010062.outbound.protection.outlook.com [52.101.61.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 36039F8027B
	for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2026 10:33:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 36039F8027B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=tDrYchy6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJRKZnaWiBuTqKpmK+G2U3yEiOwmz4EoqvBHQ9fjF+oogOtltDH++Dv/lrMyqfBk825+igvQdo1D0D4BRjPIPv5bE4kikRlXhqVWQW0EuPiDaeMX5n9mIci8GytBqsRlxkBx08x6Ih/FCgv1fNxuVN36N7awZZUxefL+oet+vB/tCUKbaA80/6Ri8KokxlRFIxCKN0NEczA/krajnxB4gKbRPeuW++HVaG7W5bcsTF03NEVbG/OAoZtrZv5KWmIGEm/FJxJ9ymRuAxoxZhvguqhBI47/rx/EW5eiJBaxP+Z3OSGd7P5q/UinBdRuDi2x94jBeWpTd3ZiWRNfUX79fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x85ZrLgLVZ2u27nl2iDBCxCBo21vp5nUpjJyUnMXL6Q=;
 b=gnLT0outkQI76g0M/nxbrRc0ifse0ZD0JZJCxGx8QjSqdg+/MSsQWBdA21SttR/YMpR0Tgo9Qu0JrnWTPNtdVYjUr7/0gzdG4qGee43QzNK4rEkkPmsh2CX9NucVK90v+bU0CvUX8G/NbGcZeoddKMkLwVrQeh2ocPH8a6YUVuVXFpm2oOYsItnP2b6J7vGQ9vY+QzpbVTmZ6Xe455Q1hKkcvelshUVnkJwGcG3LFvAwJBNJR6PCFGdGwehCCtPa7fadjNViTvPfmI1V29mkem7OWUqMrnzCC6/RcJ4qWyeK8za7HZmlap0QgtJXVoC+b6mBQLGaB5wvy7bLPwtkxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x85ZrLgLVZ2u27nl2iDBCxCBo21vp5nUpjJyUnMXL6Q=;
 b=tDrYchy6aJo7CzJoFF0TBd6BQRhxMvILoSxn2/hI80y6bg5ZWQGKhJlukPRrSN79QVnPUSzPt7PyXYEPDsv1VM5ME89p2gjZlqHvGSA2W0xk7l5bVmA6zJ1bURwGWXAQGy8FBqkVRVXKyicaODPfiM6dBpD3KXwVzu+imtd0jJ0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17)
 by SA3PR12MB7879.namprd12.prod.outlook.com (2603:10b6:806:306::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 25 Nov
 2026 09:33:23 +0000
Received: from CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2]) by CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2%4]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 09:33:23 +0000
Message-ID: <61c0a076-5433-410a-b1b7-247d4393bf01@amd.com>
Date: Wed, 25 Nov 2026 15:02:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: amd: yc: Add DMI quirk for HP 255R G10 (board 8D22)
To: =?UTF-8?Q?Alen_Ti=C5=A1ljar?= <alen.tisljar@gmail.com>,
 Mark Brown <broonie@kernel.org>, linux-sound@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
References: <20261124182329.20428-1-alen.tisljar@gmail.com>
Content-Language: en-US
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <20261124182329.20428-1-alen.tisljar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0022.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::12) To DS7PR12MB6240.namprd12.prod.outlook.com
 (2603:10b6:8:94::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6252:EE_|SA3PR12MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c8fc18-d9bb-422a-46d8-08df4ad72614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|261009223027099003|11063799006|261028144727099003|56012099006|261026140227099003|261026121527099003|261022105027099003|10067099003|261021121427099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: 
	UIkzIvdoX6WtIM/ocBzSw0p7uWvQd+7FyJl0xkWD7e0F6i11eK53ZuIx+Yj1ysI1UGg1NwqS2roK4OTHpcPkMIfOU/fuBR/Q7eWejDEKEDwtpIo5TaQIGIbM4wnPbrV34E/9uroJmueKxDVx3BYe6Npfouxphpto+IHZClIYs8ysSPtroWbWLUYhgumBbuk+YOHMvcpVPaEZOMRSO8z9ilD8P6+m1AZ/Sn8ueO+EaUIyUW9NJDtinTzBhj/5G2BWPSnxgN4s0pfs1prAoae14FARwQ4Tgfk1yemlOKYZkgwLOVeOO4LsnFbWST8g45vNLXrJpBUDc1r5GPjmvqH2uB5BjPUvIrxmb76VGHuyWSXCrmxDS37vHzZMkWzOqln4BamFdAuJegpXGaDu3NHndhEfikxpilTrCoK+4gQplrs+bBm4o1Qg8wj25tIG2owA29xEoUy4yKXkOSs01WyDBFq3EiyW9FN/sBrNUK7Q9oELfrDybh0bowz5L3LQ5vo7g8Uo3rHJcwkAQXpqEQh6aBGXLMGcox1G/uqhs8lXWG0YaF2cd5BvVzxmggRBId/95XMps2jcWNpaV7goQemBaPflNE2x53MPecufLN6SYUCDUXa1G0gVnkOAbNhEWFdyxb0ekkZ948bSc0bKX6lA1NUB57U20PU4LlXubl+tq7c=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(261009223027099003)(11063799006)(261028144727099003)(56012099006)(261026140227099003)(261026121527099003)(261022105027099003)(10067099003)(261021121427099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b1R2aFhFSmluMVUvS20zYjYwZStoZHI1SzM4VldOdW5XYTRvUlRBMEFKMlZu?=
 =?utf-8?B?SWN4b09kekdEMXdCb2YwZGdXRW9vT0pnanc2VTl2aGtYYkJWUDk3L2VabDBy?=
 =?utf-8?B?Qmh0cVU0NCtYeGZJWkhSVTZLU0djYWxxaXVHWDU3STlvRmZhbGJBcnl4ZTE2?=
 =?utf-8?B?Y3cxRXBLU1BWeGJnRzQweTFXR1diNlgwWUNqM2F4bXpyVHVFZFhVWW9CUDd4?=
 =?utf-8?B?ZXVqOHJpa2dLL3lsV0huVEdTOWZoQmthbnFDYnp2TXdQVnh4K3dzU2NTamxG?=
 =?utf-8?B?T0grQWJUeEZZRDJ4VmdhbU93eFFqcU5YSG9rOU9nVTA2RWFZc2l4VW9hczlp?=
 =?utf-8?B?a1RKaTdtVTloU3dnVGN2V293S1JzNHZCN050bHJyWmhEaGg2bXM3Q0FmQjEx?=
 =?utf-8?B?eVpJYjJCSk1kYVJ2UjBkd2VyUGVSNFdPWFBSMFc4TTNtZUI1UXJzQThEaWxJ?=
 =?utf-8?B?d3N0MFNKWUlzNGNjcEx6cHdjNGI5Y3lQekJXOExVdTlQRHVTY3JTL2JqMmts?=
 =?utf-8?B?dzlQcEtTRThlMHRUMUJacjRvMmVZVFRCdVd5VUNMS1cvZ3RDT2VZNmtEYTVI?=
 =?utf-8?B?Q1MwZFY5UjFnQm1TNVpYbVJZQXplUjYyeHZZVStEWFRJakxlam1ZZXRhdXN5?=
 =?utf-8?B?cEhMc0FYczVtZXNTR1pvYWh0UHJ2bXRnWElFcTV5K0Z3YUpTU2Fic1RzTGNm?=
 =?utf-8?B?MEswOVFJalRPTEdOZ1U1SkVJcFJrbVc1SWtScjVIVEVlRlgzai9zTW5GaTZi?=
 =?utf-8?B?bXRTY3pVUHRYeGhITTdMSCtEdHNBQk5hZVZ2MmdJWVU2NFdXWkdQU3N5Qkh3?=
 =?utf-8?B?c3hlWDNDS2JxWml0bGYzMlpMaVlkZlh5cWpkUFN6S2x1aGtHMlBVb2U3VSsv?=
 =?utf-8?B?eUdBZzMxQ2ptMndadXYyVHJiMlpyVTlxdDRBS05VUkg0ODZuSmx6c3VNanBH?=
 =?utf-8?B?MmpnSHc2Q1ZGTGtiekRuWEVsYk4vTlJnakVQMjJ5TUJCemJ4VGtCOEtacVdh?=
 =?utf-8?B?NnZZVGNCVElkeWY4alp2Tm9QOTVXWThUUGxlSWpQZ0NTZndiTjZ2RzFzdHhv?=
 =?utf-8?B?bEhnV2VHOCtvUHVjMFIrYm9YTkZxZC9aQWkyMnh0a0pScm9MT1VUZmdlUkRx?=
 =?utf-8?B?YkVFdWJuazk3QkovY0tFdTZ0RHI2Wk5IbWl2Z1MwejdlN0plWUR1K1pIQVNZ?=
 =?utf-8?B?R01OZW5oNGUva0FCRmZHaXlScnBmM2hOdStZZUhSajhFREJFNDBrdVpMYXFQ?=
 =?utf-8?B?bGtZSEx2T1JmWm9lT3Q4Y2pEdE1zSHI4NjVaUUNnSHRMdjJMdStyOUVvczVW?=
 =?utf-8?B?eldVMEhQbzF2TlZBblBRS05FcVlQYU9IWWhGZVc2d213ak9mbHhVQ1J6OURX?=
 =?utf-8?B?UlBYMThQS1pBejdMKzRFM0hTR1M2dG5mcjNDM0FZOXpvNFZ2bDd6bnQvS3NG?=
 =?utf-8?B?RHdIVllFQXdYa2FSMEpNdGJuQWg1ZDdkV2U2ZFNxTjhnOUJIcFZpRnF1eXFk?=
 =?utf-8?B?MU1VenR4R2tjUG9kd3NSaVd4Z2IxS1RkYmRwM1RlMG03VWJlRmErMVB5WHRK?=
 =?utf-8?B?YVZhN0I2enh0Sy9MVGNPOURTRVJNU0JDNGd6N3doM1BYby9TLy9wU3ZoVEk3?=
 =?utf-8?B?MzUyZzNKVm5Wb212cUxrbnZqTXVUNzVpOFFrQlpsSmVoU3BZT2dPTDNkNHM5?=
 =?utf-8?B?SWc4VUJzMjlNWEhQK2lSeWlzMlJ5ZUVIZ3hrUklwbDE4SCt4OXZEbkJlWGVx?=
 =?utf-8?B?ajYrY2ZtdCtYTkRFVjRXMmFiMlcyZ2U3dzBNWStSYmo2ak5rUHlLcm96VXk1?=
 =?utf-8?B?MWNyZ3gwMDE4dE5RcVl4em1nMXRwOEdUNnB2UHBURnRWamRFTzJvdVVpZDN2?=
 =?utf-8?B?TjNmOGlYNU1BY1J3WUYzQjFsV1V6aEpZZzU3NmFBYUYyQ1JEZUlqTGE1RlR2?=
 =?utf-8?B?YjAwYitMd1J5WUZmeDlmY2ZxUUpRMFc5ekJYdnJSSVcyOTI5SGh4Y2VtYXEx?=
 =?utf-8?B?Q2VrK0VKcitOcENSMUlxdnFWODlQOHhnOHplTWx5bi84ZmJhbVZXR3BQQWFW?=
 =?utf-8?B?SFFHSDRQNzNEeXVOZXNOd0t4NE9GWjBGbFZXZW5XTFVsNkFEeURocDZ3RGtp?=
 =?utf-8?B?aUMvSHJVWDVXU3ZTckVVc2NUaHB0Y294U2E1THNEQ0p1d3gyeG50K1hTUlRp?=
 =?utf-8?B?OTdqbWRObllWWDZjOHNyL1Q4ZkxIUTF4S1ZiNCt3dThLcU1GaTc2TjJXcDVO?=
 =?utf-8?B?VzdZL2NoTUlGaUg2UEY2MzNsUzZuMG03ZC93SGxIaVFwRWJMMGd6SFRyeElh?=
 =?utf-8?B?M3QwU3Y5K3FPR0RLVzFwS2ZUWTBLOU1EZ3d3TFFyZHVRM3lpc3RiUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 39c8fc18-d9bb-422a-46d8-08df4ad72614
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6240.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 09:33:23.4081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 BYe/G0hb9XRHeyDoZcvZsmJQ82NHRKy3sBuNDWqCo35xR06zc+yEsas3SqueF0o9lJnLm5/KGmt+P2fEdkkTlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7879
Message-ID-Hash: FLE7DSZYRD42FIQXNP2E5ZQKU6XXZBFK
X-Message-ID-Hash: FLE7DSZYRD42FIQXNP2E5ZQKU6XXZBFK
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FLE7DSZYRD42FIQXNP2E5ZQKU6XXZBFK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>



On 11/24/26 23:53, Alen Tišljar wrote:
> [You don't often get email from alen.tisljar@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> The HP 255R 15.6 inch G10 Notebook PC (board 8D22, Ryzen 7 7735U)
> has an internal DMIC connected to the ACP6x. Without a quirk entry
> the acp6x machine driver doesn't register a card and the internal
> microphone doesn't work.
>
> Add a DMI entry for the board to enable it.
>
> Signed-off-by: Alen Tišljar <alen.tisljar@gmail.com>
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>   sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
> index f636b5ba5..9dcb98160 100644
> --- a/sound/soc/amd/yc/acp6x-mach.c
> +++ b/sound/soc/amd/yc/acp6x-mach.c
> @@ -731,6 +731,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
>                          DMI_MATCH(DMI_BOARD_NAME, "8A22"),
>                  }
>          },
> +       {
> +               .driver_data = &acp6x_card,
> +               .matches = {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "8D22"),
> +               }
> +       },
>          {
>                  .driver_data = &acp6x_card,
>                  .matches = {
> --
> 2.53.0

