Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCD1606A324
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=s7K2qai2;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cFbO0uIb
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3A8F660211;
	Wed, 11 Nov 2026 17:05:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3A8F660211
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794413162;
	bh=tyFgXGWVJItjtzpVWsrOnst4gvU2V4atyI+z4Y19fRo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=s7K2qai2ZE18soZMoQ+o7H9hoKq/nhlIML+phlzzDDpAENoOWR2cOP5mWeAG8iTvs
	 BCZBKoqmLHj4sW00bIN1mh/rmRaghYbx6T/lY4jiRoObwVx3S3e1NDNKacdsaFtrxK
	 rzCnklshS79vfJyU9HTrgBvQOSlc88uT7w5+5VXE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5EB0DF80600; Wed, 11 Nov 2026 17:05:28 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AD456F805F8;
	Wed, 11 Nov 2026 17:05:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ECB95F80537; Wed, 11 Nov 2026 17:05:21 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.36
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1794413117;
	b=YmEcPFIfHRbAq3SZe0Db1jt5rbiAUisaAKol+fxaURS07kcQZ1F/rYo9lvNhRTXEqASC
	 8aNGRsKx+S0V1b726aOKbFkBXUeS3fpy3/GXxlOUVkdmr0cZnrPf4FVfLN9Liy6mQBKX3
	 01SDfegg2o3nng9THJFGSOsxVv6lr6AvgBsfW/W3BmwQBriMcqFWf5oHFX9YCp7ccWmOB
	 17Si9OnaaBJZGnf9gkeMYanATFyn82/2wILOHmp/lTz5EaChBp5mHRwrwLg/dMrV0r4Wk
	 wjJAEdkGMib0iWuOSNq/5q6+4na7Yc6GDobvu1LIH6iXeqyGjvQfKq1Hi5b4hADkt0w==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794413117;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version;
	bh=tyFgXGWVJItjtzpVWsrOnst4gvU2V4atyI+z4Y19fRo=;
	b=esIDUmIRrgCTdTgGZnsICtZNCZ6jAYA8+XtvmOuufwW88Op5EnZxbhcMwktubVmrwpOZ
	 Ghg3iisUVW+eSUOsnST7RI0EkO9CB2W8eIvYI36wLxeTHW6MnVinZfXezFSJPO/bq9eeo
	 96Jd+ULgoQPCLdtdq/uNAodyekffwJ+fpWM61cw8ccXHWN78ajd6cP7IqyQqR3ZRh22mr
	 92+YlffXQkQ/taMvn4UUdrI2qR6PemMzOQYx9Ye7LucmF7p0J/nmorkxwfXNFcB5GjDoK
	 eRLbpOyMb/R86xlfbi5DTEdci2Em9qXZMiaeCFxqjVXPliF1kUJsf+8LrpY98bY4Ayw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=cFbO0uIb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.36
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012036.outbound.protection.outlook.com [52.101.43.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 831F0F80020;
	Wed, 11 Nov 2026 17:05:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 831F0F80020
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=cFbO0uIb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azKEciTS2v29B8gTUxgz5FA5PltFBbm0wE2x43jRx9UdWrtsf7ILJUC9KkFa4DBFaTgufCUlpBd1I2Y1xDWj3q1LpgWx4v9hgHCq914cGQzkJbBNYpeM7qa39wAZEYlojkrtaf7z/bmF4/5lsuKbNtV5akU9JPDQ7XOkh5xQhjStpfw251+YVQFgo1G/1xQ5dPdxkLCxv3UKJE/oF3DeEa5OrBYKMeBEX6T6qWhtgknR28ERBk7V5pjKaywoTLAezs4nH2PTJqIBrrJqTkCm85/BWG0RyZrVTaAtlz07k3bDJHY1OdakdJmktaKfisWke4DudOPgni882UwFdAThgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXy5U0uPAIsr0CWHwLW7uFwM73pMRxYCqleCmZPUcmE=;
 b=ZRJKizc+NowUNKMhjxXFx7N/hQoPOuYsYW7HMrO1WIFZRneHpEtcwinAZRWtF4QxxG7cER/Ll029bzAXmxYflTqSs4zUYwhX2MVB7ncW4RhwNlA8Ro3srGbNR9tX7CO9kJMXZb5bM5TAoo9YQ+Xj/FmYtwyh1pgONRmL/R9cbdHneyNWWHkVlcQGhmOoNjZl5d4DBhmkHA9Rbj47OPG/ztPjzWcxowweFxcVQYy5YYbNtXcJQF5bgfS1TciqnMySsgJyX85qgm7DqZbyLw5pczs1oFGRoOYzNLqtM0Npi1zpckvAy4X2RGiS46RsUusHcMEudpMqT9kB/uZpRNrP0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXy5U0uPAIsr0CWHwLW7uFwM73pMRxYCqleCmZPUcmE=;
 b=cFbO0uIbi7q2PhEZBC4WdQxhCyns67aoWQwcFJYb/aNKXSArkUdBP2cQcEqwANVNTGgBq/LhDKmp7PImmM/0kBludFWUvQ7oCI4iGiSX+5wWQCMiweO11DLzLl0UOgP/zVW8wVt/deT/oe0rZAIzCKbHFeYixc+lxn731d0JxGY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17)
 by CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 16:02:53 +0000
Received: from CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2]) by CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 16:02:53 +0000
Message-ID: <77647e8b-c93e-4b82-a0ff-2a8e6c39537a@amd.com>
Date: Wed, 11 Nov 2026 21:35:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] ASoC: amd: fix IRQ handler races in AMD SoundWire
 drivers
To: Mark Brown <broonie@kernel.org>
Cc: vkoul@kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 perex@perex.cz, tiwai@suse.com, yung-chuan.liao@linux.intel.com,
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
 venkataprasad.potturu@amd.com, Syed.SabaKareem@amd.com,
 Mario.Limonciello@amd.com, Richard.Gong@amd.com, Poojitha.N@amd.com,
 lee@kernel.org, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 sound-open-firmware@alsa-project.org
References: <20261107175339.3547918-1-Vijendar.Mukunda@amd.com>
 <179423621776.3711751.3620606745077536802.b4-review@b4>
Content-Language: en-US
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <179423621776.3711751.3620606745077536802.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0276.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f2::19) To CY5PR12MB6252.namprd12.prod.outlook.com
 (2603:10b6:930:20::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6252:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: d05281cc-b24b-4c52-e8e1-08df400d3e13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|11063799006|4143699003|56012099006|10067099003|261022075727099003|261026121527099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	zk8l/nvcMU7D8iCB4Pc3h/E5yh0wmba7Z5tUXgPCnSwjoeWt7ySJDTPjJhk6XswEF2go3S39p0cC9ExuVkxCDabe1lrV1vFToFoJJ0cCw2SChctg7PS/zwecYjOlO0x2noWQP2XfqXHZiz80p8wuea4wc1v2KBFUommIfQ99eSe8D3+bj8OoGl9y8mwiAi/UwNs8vQMdc2K3QtM+D33fHF3wbjNdt8Q7kcT4axI/8epyRXdM9LQ22/gWrPRx/Yzo4nwIp9J5NvA8bheMu7QAWR6bZADtvIPaoSMKaoFL4Rk4Ad3CNOwQduHSQGFMFnjU5nftTJV8mLJLf/KgF2kcfSDfeLSRsiA0WDJ0AkddwVnor8OBYkzMMH5qbpUusbEhc8sw+uS9xcfJaEbzVksP1r4eZvuyJ+IqGiPC+gGIZ2++R+FUD0miko3DAmMgrp+cBQ+ZgaZSe8RisNiOP++N2qaSJNv3YXTLEsbwIarvxcIIQNYgn74Y2gNP8nD2Cripthi00B/LzoAzwTwekbK2DDm5eBLwBRMxqIWfftlMUi4G1HeHi+Swiuhp3M54NlTg89LOzSKh2z1d3LXAFfKGcxuoOZuTFmcUooWkKfoYfLs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(11063799006)(4143699003)(56012099006)(10067099003)(261022075727099003)(261026121527099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TFF1amwwclBDUWNZblZZYk9ENk1Ea3dLS1Boem15SXJWaTRUSDRUUE5MQ1Bv?=
 =?utf-8?B?eDN2aExQY3B0ejQwNmZHQmJMRHNYdEY3RzJabW5NUUVJZDVPRGpxbDZ0cFMw?=
 =?utf-8?B?aVBpNVJpVnpzTzJJQndTTC9yRzdTbGJkaGt4ZDJvT3dsT05xZ0ZteTNlMldU?=
 =?utf-8?B?STdncFhhSDdEQlN2VzhWNlZEWEZUM2VpRndIam5YSmZncktQQ2QrSTNzSkg3?=
 =?utf-8?B?Q1FDMlVJcHlCbnkySytUVnVYWGUxNWxXcTh0SXhkUjY0NDRDdTJBeVdna3VD?=
 =?utf-8?B?N0RRYTE4RzROVmNOOGNjdVhzTkU3ZFkvUTJEamp6ekxiSVhYWGZlaExnZW9M?=
 =?utf-8?B?eEgxZnBoZzVOWVRkVy9TQ1hzb3hvVnZwWjRUOTlUM3habURiUEI2ZUthODl1?=
 =?utf-8?B?RjhWa2piaEZDU04wellUTSttNlZnNnpLMkxlSjFHa2ptZHY1SHhsK0FoTlZG?=
 =?utf-8?B?K0lNaEdldkdSc2JlRXhEQXcvalpaVGJNVW9SejZIZitacFEvZ2E0KzJwcjd4?=
 =?utf-8?B?azJMSnZ1a2NncGNNNFhuU2N3TTE4UmxneE9keTh3M0tBc2pobG1sV0ttZmZ2?=
 =?utf-8?B?b1dpbGQza2I3d3hRYU8wdytJellld01ueC9KM2U4R3gvdUtQWTRFV3RKb1JI?=
 =?utf-8?B?VTlBcXNUVkFVbXVCZ3NIQnNGQmk3R1RlalRxdUJPS2RsOTdtTnM2eVhNSExR?=
 =?utf-8?B?ei9tUjdVQlFRNUtmbXBZWHdoNUNEbHZ2NEhBRDAzQUt6aHFDL2VPODNESno0?=
 =?utf-8?B?Z3M5bHVPek5MbUpkM05hclpKSS9DQ0pTN1RkQkdzS3dCcTZ5TjlCWDVmbHd0?=
 =?utf-8?B?elJyZGNveU1TaTI4K0NIZ3JCVjJ2eXpOa2VCTkd6eUp0UVZLNHRJS3V1NGRt?=
 =?utf-8?B?amlyRm1DT1VmN0dUUC8wQTNXQXpZTi9NOUtJOFI2RkNPUjJvc2NmMEdVeDll?=
 =?utf-8?B?bHdFMmVNa0RiTGxHT2EwdzRHZzdpVHFiVVFiK1dQU2xlTDc3cGpLVk11eWcr?=
 =?utf-8?B?UTBndzJjNTRFcXllVUdVYXhkUEhENlAzMzVpbDMwUHZTRzBOUmFKdGZmR3lo?=
 =?utf-8?B?RG83cGh1NVVpZHhtTWg1REw3ZHNEb05KVG01QUE3UjZNelRnQUc2bUNLdmZ1?=
 =?utf-8?B?ZXdCRFY5QUJpRGN5Z0luMmw3bjY0SFNuZmo2Z21abUt1eUhlSHlyQ1g4MWNn?=
 =?utf-8?B?WUgyTTMwTFYydmVkQklHdjhXSVBTRkV4WlVEUkxSOVU0bFRnNHNsS214TFNR?=
 =?utf-8?B?eWl6ZFhYNHlvc1pMcHpQSXV3cTdodGd6MGNXcXF4N1F1amt4Y2xOUTJtdnJ4?=
 =?utf-8?B?WjlSNExzUUpUSTJ1QTU1WkhPYVFDTExvRXdpd3lVcnIwbDZMVklEOEhnZlZY?=
 =?utf-8?B?bUllMVVJQSt0THRIYW1MbHhmTlg0WDREOEV2YTZzL0lSQzh1cG1acEZudkp5?=
 =?utf-8?B?V2cvb2ZXVldUN05ZeThzT0dNd2JSZlAvVkhDNytnQUF0Qk1tR3NZaTBwb3py?=
 =?utf-8?B?QjNuV0U0Nm1xb1ZzOUM5Tm5lY3Fnck5EeFZJSjUvYXNrOUp5VVFHSXZLbGRH?=
 =?utf-8?B?ZnVSSG1OSnpRTThtTHE5MElhNU4ybHZ0ZE00WWhVWXpWZVdlcnhSSDIzNnFX?=
 =?utf-8?B?Rm56ZHpkaGdJZTM4RThSU0FwQU5yMy9LbHhIVmNmVFhBbVg5OFRsbHhTaWtD?=
 =?utf-8?B?aGhLOXpHVng2SjA5bzZBZFNYZUZrdGdmZDFCMml5YnBQOEFwc2t4OWROZ1Fa?=
 =?utf-8?B?QW54M0NzS1lZWC9Rck9hUmdISHVvTnQ2UU9OMFFKS0FveWJ6aVB0Q3pkb2VJ?=
 =?utf-8?B?QzNnMVNFUDBscHY4TkxHRzk0NHBpY01uU2F4N1I4UTg1NnZMdU5xK0IyaGVB?=
 =?utf-8?B?SWtPUmYyeWY5SktTUjVIZXd6a1ZCRlQxa3IyYld2elBKZGpDV1pOK0FlWjBZ?=
 =?utf-8?B?UldIMjB2WUdOVDFqMVkwc2Z4RmJoUGNadVNwNkd3SHFwRG9MRHE2M0RmNVA0?=
 =?utf-8?B?d0FmL2tyWmpXUDlUd1kvenFScmRCWWlWUDNVZkF5Q1JHMktySHUrdlRWbmhv?=
 =?utf-8?B?LzY0TzNlVGxvYlFxcmdoUlA1TVh6akV2cDVlWWRMUTRVTnZZWjV2NEtRVHA3?=
 =?utf-8?B?b2VmZjlwcStBUUh2cDdqVUpjU3dXOU9QVXBnVWtFaHI5UHRCS1lpVVpOVW4x?=
 =?utf-8?B?cXlXRmpzVFZFd280elliY0Rub1BlYmc0cmJlc1YvY3hzK04vaW9CbE81b2M1?=
 =?utf-8?B?TUIwc0pRR2ZOcEptOFRoSlVjNjBsZjQyb2VpTnVWcDZOQUdsaWEzdXM1ZVc0?=
 =?utf-8?B?OEFRUVUvRFNKaFNkN2ZDNzcxRVYvM1lGOXYvOUNiUENnVldwdlg3Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 d05281cc-b24b-4c52-e8e1-08df400d3e13
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 16:02:53.4327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 aT5w18UsWrd4ulUqOUYqLHAQkfxTQRD5/KOFNIX1jzR7E9I/fI+6HWAE7IOLnxW7vd/tVaRR9BHQoTzV62Tv8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762
Message-ID-Hash: UQZVMBPYJGWCI7VMKKJAOTD5YM7XYU7T
X-Message-ID-Hash: UQZVMBPYJGWCI7VMKKJAOTD5YM7XYU7T
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UQZVMBPYJGWCI7VMKKJAOTD5YM7XYU7T/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On 09/11/26 20:26, Mark Brown wrote:
>> Patches 3 and 4 guard schedule_work() calls with the interrupt_enabled
>> flag so that an in-flight IRQ arriving while the SoundWire manager is
>> being torn down does not queue new work after amd_disable_sdw_interrupts()
>> has cleared the flag.
>> NOTE: Patches 3 and 4 depend on the following patch which introduces the
>> interrupt_enabled field in the AMD SoundWire manager:
>>   https://lore.kernel.org/linux-sound/20261107154659.3358223-18-Vijendar.Mukunda@amd.com/
>> Until that patch is merged, patches 3 and 4 should not be picked up
>> independently.
> Please try to avoid mixing in things with differing dependencies into a
> single series, it makes things much harder to track.

Understood. I will avoid mixing patches with different dependencies in
the same series. I will re-spin the patch series accordingly.
>

