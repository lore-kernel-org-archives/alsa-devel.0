Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FA2CD5BD5
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2026 14:26:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6FD226027B;
	Wed, 27 May 2026 16:26:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6FD226027B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779891987;
	bh=eDLEUCcZI43KD5hsmRjjHImSbC//vtESOACoZvldY88=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=uQMr/x32v3OMBIYQ099446tl+xkolqyJuAQzHu1eYdcdvyF2mHsr6pI9EbMQkHAcg
	 NhlqJ32PssYazDhQ8m4Vk/sGEdY4DXfaj41ps0a+b1QVIqcfKUPkZeGhR649xfQXBF
	 Bxm97ZCHeAv9In/nKqvZUP2giZTAco1geuEcCqMU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 76863F805F6; Wed, 27 May 2026 16:25:53 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 03590F805EC;
	Wed, 27 May 2026 16:25:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E1B63F804FF; Wed, 27 May 2026 16:25:46 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011059.outbound.protection.outlook.com
 [40.93.194.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DC63AF80246
	for <alsa-devel@alsa-project.org>; Wed, 27 May 2026 16:25:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC63AF80246
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=vVWK9It8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VtJUgm2KOL9b1Wpc2VhGGoAGXbNToYF0Bfx7niahAn2A4cJXvwbNDUHjf3SuKfLpEdL8lJWu5G8fJK08M/h5vGUmmsET0XRNG+BuBX1flUIPmsUcYYRE8K9+hAUADjxrF0qtRvr/+cpohYtpb3BHKODlWwUFxnZz68E+Lk7HXuJvEbaPfLebpMgBMjYz/Ba1iPKv2Yw5Y6bNaCdKML/z2jAAf0C7XJIiJccne2CJeJPxU1nltO3HRvMsLQ7jlbadilrKZI3idsbQCW6n/Wb8+qtZzJyG0Fv0+EtTBKnRTaMDV6TPxjEzJ9yPBoEUZX9is4gTHFn0hWN0ksWStJ3yRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9PYrP9fSZQPAAwe444zW0pf9SBkuFuO2S0rR8tdh+g=;
 b=aoJjRglaNjD4j1thLAUmqYGuPvGUX32mbXYrIZdx+ENsSPTNW7zmpBVbx8tPdlMzZpgY8fUSccc+jcU+G5cG/0kK/0q9BSf5LZcQbCt5KOli2Zi3uvLaZm0TIQLTodWSS96DV36rVmBBFHUV7GOmelYeDkV725eWxiKf4td5xdZhYef3OfGvuTSxWZejb2RCNV6XY/8TdCM8E3PaY10MA8IOiftKQN5bUcfAKBmTNYVT++M9AKx+t8Ah9XAin6zIaGydH3Al8RygSeAx8BoWwmRM3fRNNwQiQw74qaAmIoRB9W0JaIvCdvLvgFmDexWCWze5ydgJgZm66xfZODoJyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9PYrP9fSZQPAAwe444zW0pf9SBkuFuO2S0rR8tdh+g=;
 b=vVWK9It8GpPZeE++2v812BoqS3tJ71dy58mgoaKfMXFlynnJhnWHP3oZrc1LXmLO1RV8a/IBFv5F49qXBJDGvh/Y1W/jGGuhuCrpCAsN9hIRLlS6z9cImA4fuCcqZFPBTcHZETjqs7F+5uhHziKZEls4K/jMiQn8MjiSS8VdpKQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23)
 by DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 14:25:38 +0000
Received: from BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::8e9c:2f3d:9679:942e]) by BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::8e9c:2f3d:9679:942e%6]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 14:25:38 +0000
Message-ID: <f239dec5-8c1a-430d-885f-a3a85863e55b@amd.com>
Date: Wed, 27 May 2026 19:55:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: amd: acp: Use IS_REACHABLE() for
 SND_SOC_ACPI_AMD_SDCA_QUIRKS guard
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: vijendar.mukunda@amd.com, Sunil-kumar.Dommati@amd.com,
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 "open list:AMD ASoC DRIVERS" <linux-sound@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
References: <20260527133208.3074614-1-syed.sabakareem@amd.com>
Content-Language: en-US
From: Syed Saba Kareem <syed.sabakareem@amd.com>
In-Reply-To: <20260527133208.3074614-1-syed.sabakareem@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0192.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::17) To BN9PR12MB5356.namprd12.prod.outlook.com
 (2603:10b6:408:105::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5356:EE_|DS0PR12MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: c3ff9326-dc24-4024-b694-08debbfbd2c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	jxWy4xwGdb1Q8C7gRHvdKrz/W8H3KYqPjhe2565IXvDghwQ+Mms8DSYZIHzqr+pTDY6/ZLUF92AwEt2y37aVcC8SuBPm7W86Ksm70RMIX+AAnxSBuR+IvBoAHH/y6wNOhVOghWuGZd+f4F/OUPmnBXWCJTEzaFb1YintyJm1ZbSjeQkZLbULmK7IdKBYoSu0o2Mg6pBkRSUi5FS8o8Lx8k7E4EYq6H3bLF0u9a8Ur+bHdG5lWCoZ4TEdpUyX6KKisydIAtdXjLvR1C7bEkiRUotOm0rZkfhkW/9aDsz1vLtRBWhY14I/0uLyg4SMKUP0EjRG+reJylIbT3fEMMLKa7pX74rQj6c8Xz/LqhhEKnKNQ6rpJ7JJe5WkP2qNxJCXW9UQFmooZrouKfwl6IhOQel+ncqGmFyrB6B30pULAkTGHXDshHFO3jZ+Sp9WKijM1PsZywhJo0WxVEiUp/Q6dUgP90M2v5SWX+1BGVFRcCUxo+JU25NcWqhf8otitlCvcsfR9wPudTFsM5OmTYn9nv+ScLRXfULvTy1v/TmvGgCqTEMVUO9jLM9ikrJyEt95PZOEcFiqRrZxs5ApaRpqyK+KIXJqm03z9MUCml584d22+9oVMQczjGdJFLUJBhCW0EVJxYKJ8fHxJQ6fpxLxpwtgVWRYC8wlK/pkWlRJrKXnQ0nrLJ18js/TWub4BUnm
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cDZORGlnSWtrWTNZMlhGdFF3cU42L0JsZEZjOWJhV3ZKMjNRd1NBMnpuOXhp?=
 =?utf-8?B?OFVPOWMrNnlCTHdsdkdOS1E2anVqbDRtblY2OTNrdVBoQksxVTZZVndDMTQ0?=
 =?utf-8?B?cG5rMjBWSDZaZkIxdjVQa1V3Y0VrdnBoRys1VVEyUEJEWWlZdG4zS2NhVERy?=
 =?utf-8?B?RmRJdUVwOSs2b2tEeHpuUzlsY3lnL3NWLzhrY2tiY3BIMFNDZGdQTmdXSVFV?=
 =?utf-8?B?S0JuL3NVTEZLRmgvM0hVYlh2MkJLZTNwT1EzbHRLcHdoOUg5MENEbWJBQTlm?=
 =?utf-8?B?a1JLVVRjNmY1ZVZMUkhPR3psNi9lL3pjVjVoMjQ1UjZaU1JjQXdGWk9UZUts?=
 =?utf-8?B?MFVkR3MxOFBqZlZaYkhlck9wMncwV29laE1hbGZKWnk1TCtjZVgrOCtnM3ZD?=
 =?utf-8?B?bGNtcXk5RWpVODE0RnJPVGkrbHlGZGtNbnVGaXVhS01DUUNUQzVBTStxd1pH?=
 =?utf-8?B?VEVwbjk5dFlPMWFwMjNoZ2xyT2xHdFZ0a2pORzlJdk9YbjhrZ2tRTTRURmhS?=
 =?utf-8?B?OHM3R0hBbzN5d3NNaVg5Q3hOVXg2ZENPbUhYVmtuUUw0eHJMdTdZclFrZlk3?=
 =?utf-8?B?dVBvWGpyamlybVhqSHBUd25nZUVpNXMrMDNvbG0zQjdWS0JUNEVIMkZUaXZ5?=
 =?utf-8?B?a1hyWEhpQjRPOWl6amprRGZ0dlpKZk9TWWJpVVBVU3hWSTBxUlk3cFgrVzdu?=
 =?utf-8?B?RTcrZDNadGo4YkdWaHdRd3VkVGVkakpqWUFTL0pSSFVab01ZYkhZSFdPVUhp?=
 =?utf-8?B?MUROeC9MbGFoYkFNcUZyMjFNRTdSejhoU2t0dlVsSzV3WGZ1aThrVnVGSEZt?=
 =?utf-8?B?Z3U0SngrVE92U21md0plQ055bTlPTDNDb1hxeFFYclNwMWpqNlp2MWtESk0r?=
 =?utf-8?B?Y25peDN2d2NrcStzNlZqdXVkK2xpbnZMZ0Mzd2YyZDAvMHdMaDZxSDRaRzF2?=
 =?utf-8?B?dW94K3dGS25YU05vd21nMnI0RVZPMXR5NFJCMXludEUrYVhMUFFpb2NzWCth?=
 =?utf-8?B?Mnh2d2ZXTURtZ0h2Mk9vZC9xalZaTnp0cDltK293aGtSaFkxek8rNERTZTFK?=
 =?utf-8?B?TmdhSTMzMlZrbjNoemY2N1NFdXJ2Z3dodTVLaWpaWGZHWW53VGMxSFNsSEZF?=
 =?utf-8?B?RGQrMll4Q0hmcnVMOVV3dnZJUStlYnN3ZThZa2FsRnBZNng4QkN6dHpsQ2tp?=
 =?utf-8?B?MkdtendNZ21Cd0xJWDVKSS9yR2tGS0VraWRnQXhzOWc3VFRHRHV1OS9GQW45?=
 =?utf-8?B?SlFHQ2lzUzRZbzBuRUZKTU5JQXhOMElVVlhlVitzRVhISlhrUElPMDRZVW00?=
 =?utf-8?B?T3Q1RDRxTmtzOXdnSTFsNEs2R1JheUJZR0dCNFk5bkx2VFZ4ZGV2anBmMjZv?=
 =?utf-8?B?d0ZPWml4b2FlNVRpT2pIRGtNZERXWUVkQ1RNUm1SNHFEanVVOXhWVTMzZFRl?=
 =?utf-8?B?YTBhaW1yUWJmMTZDNWhrMGRUeXdHRnRPZExFYkkrcUhnVndNN05BaDRmNjhx?=
 =?utf-8?B?dmF2alp0RmZaV1FSQ1VlVHFLdnFZRVZTOUR0VUt6SFUxTnc5Skg0NTRBMDFm?=
 =?utf-8?B?UTF4VGJiUitnQUhnL2VHV09GcnBGb1hseHJmQmhqVmlhM2lyeXpjdjZseCtT?=
 =?utf-8?B?T3A1clhRVzNjWTkyOXk4VzdGQy9aTFdqeHdreVRadldxWTRVbFpNR29pR1JG?=
 =?utf-8?B?T2lZME5teEZuVUlCZCtmbTlqM1BKQW5pQ1FFOTNFZEJaNzVMRzRQOXFmMG5Q?=
 =?utf-8?B?L0xnblFSYTNWWG1PTzlycUhPMGpZMkUzbjdSVHdUT2ZtQjk2YTI4aUU3OUpD?=
 =?utf-8?B?K3JZQTZaMjdUbm53d1VWVVIwUlMrNmw2N2J6Nm9ieUhSaU14Yjk4ZUZZYnYz?=
 =?utf-8?B?VnBKNWY0YWZKdWFSSW1IUFQ0R3JFcnY5UW5HRXVuU1ZmWlZFMnFPV3A2WG43?=
 =?utf-8?B?Ukt5ekxZNmVSL1VsMUtlU2VtREtyQ3VSK1Y5RHY0eHlOYmNyd0VZTnFrQmdT?=
 =?utf-8?B?ZVBocENHTFhmMGE5MTJVdDZPaWFWYnJkdGFIbUlPMldJVXBPRG9QVnd3K0RN?=
 =?utf-8?B?dGdCZVhSYU1qbDJRdGlsM3AzU3MwK2lRdlpVMjIrNmdTeEFTZkxvNitqZFZr?=
 =?utf-8?B?OVc0a29tRTVzdWQ0b0VZaXgrNHlSZlNrVW5kZkRYMUoyM3FrL1hvVS9sRStJ?=
 =?utf-8?B?eTV1V1JhS2h6ZnBZSU56ZHcwd0JWZHloTFlQWWtjM0poVzExYXQzQmN1WEdz?=
 =?utf-8?B?Y2xtV29KK3I5TEtvOTBKaVc2V0d0QVlhcWhSWkRhOE1tUGliSmMwdndMVTNJ?=
 =?utf-8?B?d3dLMzRhTzIzSEJNR3hmSEszNkIwL3EzUFhiVTVCelJaZ3dCQTI4UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c3ff9326-dc24-4024-b694-08debbfbd2c4
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 14:25:38.1876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 2xDtn2A0AYJljB3aFktNLlIWqzCnJlzSg6HYBcI7oqvsweSZxbFg6iSxv638Q/7KcZ6sd0U3eg5IyqMSKBUT5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6534
Message-ID-Hash: EVXN5YXH7XGGCDG7MO3WNL6LSCUXF3LO
X-Message-ID-Hash: EVXN5YXH7XGGCDG7MO3WNL6LSCUXF3LO
X-MailFrom: Syed.SabaKareem@amd.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EVXN5YXH7XGGCDG7MO3WNL6LSCUXF3LO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On 5/27/26 19:02, Syed Saba Kareem wrote:
> From: Syed Saba Kareem <Syed.SabaKareem@amd.com>
>
> Fix a build failure when CONFIG_SND_SOC_ACPI_AMD_MATCH=y (built-in) and
> CONFIG_SND_SOC_ACPI_AMD_SDCA_QUIRKS=m (module):
>
>    x86_64-linux-ld: sound/soc/amd/acp/amd-acp70-acpi-match.o:(.data+0xf00):
>      undefined reference to `snd_soc_acpi_amd_sdca_is_device_rt712_vb'
>
> The header guard uses IS_ENABLED() which evaluates to true for both =y
> and =m configs. This causes the real function declaration to be used even
> when the symbol is only available in a loadable module, resulting in an
> undefined reference when the caller is built-in.
>
> Replace IS_ENABLED() with IS_REACHABLE() which correctly evaluates to
> false when the dependency is a module but the caller is built-in, causing
> the static inline stub to be used instead.
>
> Fixes: 10d366a846be ("ASoC: amd: acp: Fix Kconfig dependencies for SND_SOC_ACPI_AMD_SDCA_QUIRKS")
> Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
> ---
>   sound/soc/amd/acp/soc-acpi-amd-sdca-quirks.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/amd/acp/soc-acpi-amd-sdca-quirks.h b/sound/soc/amd/acp/soc-acpi-amd-sdca-quirks.h
> index 0e644e71e76f..66df37d29d84 100644
> --- a/sound/soc/amd/acp/soc-acpi-amd-sdca-quirks.h
> +++ b/sound/soc/amd/acp/soc-acpi-amd-sdca-quirks.h
> @@ -9,7 +9,7 @@
>   #ifndef _SND_SOC_ACPI_AMD_SDCA_QUIRKS
>   #define _SND_SOC_ACPI_AMD_SDCA_QUIRKS
>   
> -#if IS_ENABLED(CONFIG_SND_SOC_ACPI_AMD_SDCA_QUIRKS)
> +#if IS_REACHABLE(CONFIG_SND_SOC_ACPI_AMD_SDCA_QUIRKS)
>   
>   bool snd_soc_acpi_amd_sdca_is_device_rt712_vb(void *arg);
>   

As per Arnd Bergmann offline comments this fix wont work , will send a 
another patch with proper fix.
Please discard this patch.

