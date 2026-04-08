Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D26610F9951
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Apr 2026 15:43:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4211F60209;
	Wed,  8 Apr 2026 17:42:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4211F60209
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775662978;
	bh=TKjEFJA35ceJIg6uSlqeHfK9DshEN7WRsGWODMl2Dkw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=aETdaIXV6uI9u5IU4iU39FQ0J5IFcWtTzPIjvBwSl4hy8YegO9CNF+lXYxK0/CitV
	 4mp0B2achGdZ4A/+LEmbFvevrrVEtBoMCq/LPd3lTKgmgglhMlw+KAdwumwTb/N3t+
	 VQSWUDszurpWkkR42x3kZIqgLQgl6wVV3HJgbpjE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 89A4AF805F5; Wed,  8 Apr 2026 17:42:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8A798F805E0;
	Wed,  8 Apr 2026 17:42:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4275DF804CF; Wed,  8 Apr 2026 17:42:15 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010056.outbound.protection.outlook.com [52.101.56.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D4F68F8024C
	for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2026 17:42:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D4F68F8024C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=eGusi1Oy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RHC+1SEP6cNjTaUYQOpzZk/MsCo5uEAcywmK0zXIC5TdEFxV5OHFw6zXi54I4RFhuikDyPBb7AWhmWo+LU/EM1vU2zaI44yzYOdDGXclBiA3cMfbxCr8x2+yF6IIus6iGOlAS5LlbTFAERXEN3pBHTbQiGb4E1y2gK96EnCk/VwfhHxLcpHdImci29CvxsUGkzl/Nyh7rJ0jC3Q2h2jr6gFAtmU06cLnFccrkkFJTyeVMMbiksGdh13l/6QwL8VwKRkPR2jHjlLymO9Dlpgh31pRKsvmJ78l1e83P9//heLBybYiBLWkeny+er46uuK7p8cCu/L9ZC/ptMe79da+BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dk14xnyVe1Pfk0w81az+3HTXr68N9blI2ikzFrR9i4c=;
 b=LQmlQf9ljDWeYraGyovK1r1uTUQfCgmVE14nDS8i7CH5SGiI9bM8o9+QNU3RHoeTJxXEHfGX2vijYCKldQKtbfKDuB8F4nsexInGyMCF95VsaFaCkM7sgd1TT3KEi/qv9GwZEVeEOExNIYwyPgTVkQIwTRpoWll4r7V4HazY+yCqOVuE1V1IswfUPihKDQo4bbYZgC/JudmFjsLhYF3jOGuUwCbbbJMrZKn4U60mp6t4LUdoqyhCwr6N0rlj3M3JtV8vPXPibA2sFdSlPBEw3KlIEYTgG9H2CH1Z+AgZ1kcIne9QWvqq4DH9AMWvz2UJKJSx1dal52cK0txpRzEPJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dk14xnyVe1Pfk0w81az+3HTXr68N9blI2ikzFrR9i4c=;
 b=eGusi1OyBb4M/5UZsmg0HT8fuF7TIDL7FnLVljM9V5DViMcyJvEAClff1B/HOV8/7yFWSnncN3kAw6Fbd7PDwyosTeTGCzlOGAhTWekMaQOsNl7qcNkYU25m53aZNxdbt+yJ40FXKURDL+1JerjLjsjQVkCHhGN0D3wh72sf5gg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 DS4PR12MB9635.namprd12.prod.outlook.com (2603:10b6:8:281::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.19; Wed, 8 Apr 2026 15:42:06 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9769.017; Wed, 8 Apr 2026
 15:42:06 +0000
Message-ID: <bec82b3b-221d-4088-94ec-5324964e6007@amd.com>
Date: Wed, 8 Apr 2026 21:11:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoC: amd: acp: update DMI quirk and add ACP DMIC for
 Lenovo platforms
To: Syed Saba Kareem <syed.sabakareem@amd.com>, broonie@kernel.org,
 alsa-devel@alsa-project.org
Cc: Sunil-kumar.Dommati@amd.com, Mark Pearson <mpearson-lenovo@squebb.ca>,
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Charles Keepax
 <ckeepax@opensource.cirrus.com>, "Mario Limonciello (AMD)"
 <superm1@kernel.org>, Hasun Park <hasunpark@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Kees Cook <kees@kernel.org>,
 "open list:AMD ASoC DRIVERS" <linux-sound@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260408133029.1368317-1-syed.sabakareem@amd.com>
Content-Language: en-US
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <20260408133029.1368317-1-syed.sabakareem@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0126.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::9) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|DS4PR12MB9635:EE_
X-MS-Office365-Filtering-Correlation-Id: d103ba82-2c06-46a1-6ff4-08de95856349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	MAnNg17B4vVVv/P/6Fy42UBVNyoPtrYg+/z3+pf8FakH7GBJUF02WkcT0pDu2QApK9UhU/ysXxwAQW2wbwyG0SB7Cqi+PnhDhUC6jMvArkpUMAhurCwSTCCkxeNFNPMvVEYLoChvrDXeNbm172boJXah0dyTLRWZ4xZwe2e+E8A6cn8hZAIoLEBZrtSYyULpUfuUs8AkrKfCqPXQpPf17A9EHayTRjAaRl3WscpfcSwccsb/wpQqyW32IbCEBWeAUN0+OhAb+hCcQzKnb0S62gqLtsqCleUVvb7CveWOG147TET/+uvwxxIppJgWrzEdx4NQ/HnD84TReVmT4sqQ6bZifRMk9hl0PJdNDb58RpCRIPv93EZMubBvcmt5AqiF1GnVp2BTXK/LKxkRnjdN8zGBfz72DRS2vQGLFcLAq/9QFrck5udbWkzBmdLhqROWnIgP1hswo9O2hIGclqQlbPLS2i7r4XgSAwdETLNDIoG43huVDd6h8ap8xY3ZQFPoeYcnnRjnynC7odW4t2ZLnoBDkOIWHnRQ+gB5k8xblENEOkYi657/REG+R46m11+AwroO8pTeFjz6Kpr4wcgpRD99S92esAZPpGLvmIXv/rT3dou6jBkuR9mghnqWtWWfP1jTi1oGhS7mnJ+4LReE+p10W+bcvMZzsHZpA0DQpTWujtIQTpBdBy5pq/NLM9FJZUco8e7ik9oTasLi1cZ9ukhsTHHNgRy9RChYg/sC08Q=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9567.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UEdaRUp2WG1rT3NJeHBMMWIrREtacFRSekdxdWdoSDJvbGoyOE9TeDVjQXZT?=
 =?utf-8?B?aGJSS0Z5WlZITVpTajdERkNSWFYxZ1hVdVpPeGRLZW9MV24yTmZPT3NtNm5T?=
 =?utf-8?B?TFBRVVRvem81dldQb1JlWm5URUdIMU05YkxPSTZxZVZ5b3BWQ1RNdmtBc2Z3?=
 =?utf-8?B?a1ZCWWZOeldMWTZxS0RZVTNvMzBTTXpIcFNubVlzcDV3bFpWL082VG1PV0Nz?=
 =?utf-8?B?M3ZpcWozdVlWMEgxTXhQbzVTNytTR3N6RVBIQWtvMEdWV2lVaktRWG1JV3li?=
 =?utf-8?B?THRBNkFYeks5MWNWNTF2dGRoZEhrUW9ReUZlNkVlNW9UcnpWd1JBUDdWK0Nj?=
 =?utf-8?B?SGdjdXFSaE9ZQXVLMlJXaXFHRXdQYjBFMTJUcysydk4xRlNsV240dDI5R0t6?=
 =?utf-8?B?MjR3YTcxZjdOc3pjUUxXOG9XUVo5RkJIemVtNHFtRGdNT21lNnJhbytEcHFv?=
 =?utf-8?B?cDdBM1d3YXNudVlIZnRMTDQyRU5tY2RwalllS0c3SjNLaFFlTjIzRVhzY0ZJ?=
 =?utf-8?B?VDJVSFp0QmNKN0xqLzg1aHJuQ0MrMGJxZW11SWJuMitPTXhnNWFuSUphL2RM?=
 =?utf-8?B?VHVuVWJuaTU2S0F0djZ0ZDdkajc0dXVyWUtCMmtaeHdSdWowSHRKRktVSUti?=
 =?utf-8?B?bVBSNDR6Q3duTFhGZ2xMMjF3TXEvdEwzWDRtckFLSmZQUFR4TkJBdEJFek5S?=
 =?utf-8?B?MU9zZFBUbmlaRktpbS8vZktEWTgvZTR4TStLcGFoVnFlMWszREoxdmM3WXlS?=
 =?utf-8?B?MjBYakEwZEZMNWJMb0pFY1RjSmNSUkg2YmpTMnFMQkMySmpUNVhCbDZRVHhQ?=
 =?utf-8?B?Q2tyWUhKMyswSWhlbnEyWEZ0ZHNTb2N1OU5naFlFODZYOXhQWTN0dU92cHRu?=
 =?utf-8?B?QzVQMGVOY3FWRi9QM29lMVRIV09XNXdUWTdwdUt6T2hJb29KcmFxV1NRNEdM?=
 =?utf-8?B?UlkzVDFJSVV3QXJOQTNXWXJPYmplVkF0aEVMSG9jY3Naa2dvb0J2ajRKUzJX?=
 =?utf-8?B?enlQOXJ2dGdxY0taL3d0dEQzSDc5UUNmK0Fqald2Y3FwZ0Znam8ybFVORHFI?=
 =?utf-8?B?cVhWUXJpSlI2SnIzSXkrU29MMWdydUo1TS9QNkUrYlJBb2xDNCthVGZ4cXFB?=
 =?utf-8?B?UDhOTDBsR1lqa2o5NThHSVBLYnFaVGw5eWZoZTVxMjRwVlRmcHNXVXhzUUhj?=
 =?utf-8?B?ci9rTXlMeGRZR2lZUUovTEtQbDlob3BKcGY0S08xdVhBRFlabytQT0xKR05s?=
 =?utf-8?B?cDJML0Zqc0dnRkZZc2pRRzF3TEQ4K0lrZ0pvU3Z0YjVNUThFc1ltMTRleDcw?=
 =?utf-8?B?em5YaTljVUQrQjdkTEpDaXNtRnJLSU40ZFBKWmptOVJQaGNrQk5vcWo1STVZ?=
 =?utf-8?B?aklqaUUvK3BQRUY2eU9lczdZaERaVkpMSjNVOThvZC82ZXovUzgwbG00a1Rk?=
 =?utf-8?B?NU8zd0tVcm93SHlhMFg0QmxnbW1pMmwxN25hcFkveDd2N2NZSWR6U3kweEVE?=
 =?utf-8?B?SWJ3ZWU2MUw3NnlLTFpwSm43alhpTGRhanZhcXJ1YjRHSisreHM0c1BuN21K?=
 =?utf-8?B?TWZVdHZzb2F3UDNQZU9rOEtQL3VNakVkYVdMRkVnRUltbGFKSnVxY3RsU2po?=
 =?utf-8?B?dVZqSVFYVlhqNzFZTkl4dk80ZUthQWlEMTg5Njc3QW13RDh4SkprOW1hbDli?=
 =?utf-8?B?L0VjTVhiYmt3eHdkMzZ5K2tJRW9rVnlIMDBKVmIvcmVremlNZjlhL0c1ZElR?=
 =?utf-8?B?VHBCVTNOK0QwNktMaUpXTWI0ZWxNQk5YYmpIeVN6TTJDdUZKNnYrTDBwcWs0?=
 =?utf-8?B?blM4TW5MU09vSXQ0ZUZUaW9sdUgyT3YzdVFNbGs5WEpxcXRpRjVkMjNQeXdy?=
 =?utf-8?B?NkN1K1Ria1VtbVlDbnJ4cWh2UTZVSTRBS21RVlV5QUlZekFmdWhZSUo2SXo1?=
 =?utf-8?B?YXk5cklEMnVpZ2hQSENxeTFxelVjN3VYN3VjTHp2ZVBBMkpoQ1ZyNTIyR3N4?=
 =?utf-8?B?TGVpaU9IWkJSajFoZnBhVUQ5NGlGd0NsVEtwNm1HeEhtU1h1ZnhXTUtmcWFz?=
 =?utf-8?B?SmdBMzVCcFpJa0tZUGZzZDAxREpSbnBPMENGWjU2SDFQUGJNR1ZxTEUvWWVJ?=
 =?utf-8?B?M1NuWGdFZ1ZTKzBHUXZzaW0yajh0S0dIV1h5OFlGZHpLZ2xhV3hSU0tJVjZn?=
 =?utf-8?B?RDdJaWF6OHA4K3lmckNDMHZweXpPekhidDJYamFuTXdzY3c0TmVRSlVLMjgw?=
 =?utf-8?B?Tm4yekZyYTdqQmJncVpOMkhicFdQQjhsT0lwakFsbC8rdjFMbUR2eG96ZENx?=
 =?utf-8?B?MStXNzNhT0RVRW5uSFNHeVczenFrOFJpa1lGdGRTa1BYNzlkaURZUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 d103ba82-2c06-46a1-6ff4-08de95856349
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 15:42:06.3795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 hOzDloKLIa3PhWSpmJdGoTeSqeu4yacv5r1I1/aA2YhMgz3GYlSw64HxJC+Rj7BVac384X4XOiBHY7VoPEtUEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9635
Message-ID-Hash: 4ID3N2PP5IRHCIOZNMTBMQ3W7AND4U6B
X-Message-ID-Hash: 4ID3N2PP5IRHCIOZNMTBMQ3W7AND4U6B
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4ID3N2PP5IRHCIOZNMTBMQ3W7AND4U6B/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 4/8/26 19:00, Syed Saba Kareem wrote:
> From: Syed Saba Kareem <Syed.SabaKareem@amd.com>
>
> Replace DMI_EXACT_MATCH with DMI_MATCH for Lenovo SKU entries (21YW,
> 21YX) so the quirk applies to all variants of these models, not just
> exact SKU matches.
>
> Add ASOC_SDW_ACP_DMIC flag alongside ASOC_SDW_CODEC_SPKR in driver_data
> for these Lenovo platform entries, as these platforms use ACP PDM DMIC
> instead of SoundWire DMIC for digital microphone support.
>
> Fixes: 3acf517e1ae0 ("ASoC: amd: amd_sdw: add machine driver quirk for Lenovo models")
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>
> Changes since v1:
> 	- Updated DMI_MATCH to replace DMI_EXACT_MATCH for Lenovo SKU entries
> 	  (21YW, 21YX) to ensure the quirk applies to all variants of these
> 	  models.
>
>   sound/soc/amd/acp/acp-sdw-legacy-mach.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/sound/soc/amd/acp/acp-sdw-legacy-mach.c b/sound/soc/amd/acp/acp-sdw-legacy-mach.c
> index f86d14adc721..0f21e5f64531 100644
> --- a/sound/soc/amd/acp/acp-sdw-legacy-mach.c
> +++ b/sound/soc/amd/acp/acp-sdw-legacy-mach.c
> @@ -99,17 +99,17 @@ static const struct dmi_system_id soc_sdw_quirk_table[] = {
>   		.callback = soc_sdw_quirk_cb,
>   		.matches = {
>   			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "21YW"),
> +			DMI_MATCH(DMI_PRODUCT_SKU, "21YW"),
>   		},
> -		.driver_data = (void *)(ASOC_SDW_CODEC_SPKR),
> +		.driver_data = (void *)((ASOC_SDW_CODEC_SPKR) | (ASOC_SDW_ACP_DMIC)),
>   	},
>   	{
>   		.callback = soc_sdw_quirk_cb,
>   		.matches = {
>   			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "21YX"),
> +			DMI_MATCH(DMI_PRODUCT_SKU, "21YX"),
>   		},
> -		.driver_data = (void *)(ASOC_SDW_CODEC_SPKR),
> +		.driver_data = (void *)((ASOC_SDW_CODEC_SPKR) | (ASOC_SDW_ACP_DMIC)),
>   	},
>   	{
>   		.callback = soc_sdw_quirk_cb,

