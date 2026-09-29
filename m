Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF90CA5FA5
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Sep 2026 19:10:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 09665602A6;
	Tue, 29 Sep 2026 21:10:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 09665602A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790709035;
	bh=V740UxGUel6r8zFEIN1/h8IHhymTjIKRr84PhumstjQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=DnYPVTaDc2nmAG06uyOSjKhMzPIJs/fEENTfyn7AVLvCakEN2FA8eXQ1aF7rs07tC
	 HuhMvvaBVUarEIrCyLyq0dLAqTvOgIIuhti2ayLdY5I7dDFXQIMEmgZQwqscx38/ev
	 oAqsk0jPbXlyzF66K28YyYJz+98cuN7Q6ObQhytQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 105F7F80C6F; Tue, 29 Sep 2026 21:07:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D7A79F80C74;
	Tue, 29 Sep 2026 21:07:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3A2B5F8055C; Tue, 29 Sep 2026 03:22:51 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.93
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1790644969;
	b=PspoMTlCsSl9jxtqATfRJ0IgeJxxoSOuvV6dDeMwDBJeUOOqxFwqtVKoertGal3OlVfI
	 wQ+9ZgX5/vGDLtBXEItO1iKAqrJUGI39lZYsEG8whuoqzx1sIILegcqcwkhIXK61EZDnR
	 cgbby6lpKVb9fzvilCVoDB11LGMO3G1ig/gcvFWbkSFup2FSaRob5S+VKQ3vLizA5Gu9h
	 4F4luORx2MkiQZkG7ZiQ8Mzf4OgJfkpUql7DXnraFOYuMKH+26b/Pe8gsfilNMhrm5W11
	 urPMSLr2rVAxmykm1hX1UMQx4WDATKao/TZtTTmD4iRNvVac6udjPT25ZY9uB6RjqWQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790644969;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version;
	bh=V740UxGUel6r8zFEIN1/h8IHhymTjIKRr84PhumstjQ=;
	b=U1SL+drmlyha1B8NI9en7yGghDsPcUaVdKHew67k3J3iPf0FLCD0GDrH2LZ5uQvp9XqY
	 H56G2a7cXJFpfmY+GVHANwp/K3ElpeLYenFoAY+k6P1XA+CKA/KSE0Afc+yC0C3eABpVK
	 e6NIJwMAdsW6Yy/r+pcJFOuu0VrzmbOKSAoP8SGLcqBV4y3sJMFhPFSTVdH6mT+/Rs0gW
	 QuhAOitGZjGrdjX5YhOq4euj6VLQBu16Rq1NtQntKNhkhdAaf7q22ijSDhNcaaNKONrrg
	 igvbH68i05TvtjkN1XaIZxcHWzrvbBeLC1QrJw2Q5sYb3WFlj7wIQdgA7k3WlCaRJjg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256
 header.s=selector1 header.b=Z333AMlx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.93
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azolkn19010093.outbound.protection.outlook.com [52.103.10.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5A820F80448
	for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2026 03:22:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5A820F80448
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256
 header.s=selector1 header.b=Z333AMlx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pKfpoMn6Qwok3fUft5ufNB7UDg/P0qkB74qX0jUf27s+EBd19hsnzbB4wRDdGw6sPPe1RSNJ7QcGQNSqqadXVYiHB62hlPNWL6fesxksF2Itoh9OsEYlymYMP+qkUmTXo+8gbFgODVBGahSHpyFdXvDLVGy9fAWiY+XkyMcuFy+mBy+DE5ODPh/U4l5yYFfiq8QpU3PzIwV3exUUW2s3S6YTdRuFLiPHhR4z2M/TQtMeCfw5F9CJWSoONZ0pJbu/XXbPAU7UUgZXNyK2rAxQ2xFhgBItMhblGys9s7GDV+R+hK8o2jQHA9V9FcErGFBmKccCvFZPD/UtSiFnbJLlAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujfi13XoIopzlaweqjHCgrLH/0sPktw3MZvQ0ulrN58=;
 b=Q4rNOloXKl1qDlP9pHPewosTGEP1JJl0iDCIbYsC6dpIn02pZkQ71D1xG2GGYPdT0vzDgHTKbFcHSfIma1SEepcQB6h07Gqjg6aGT3nBtTsAr7W/xRpgwldZXYq1abzzTfCUI6w8iU+pyRhalvMBZdbvENZ+GY2KXiMKCQGQVzxH0Qh4HZ+vFbziMyYfj0T1y4lAqWoC2NRj7bLd8DVyIHkjkQJfilJCZnugkdPw9wzb+f3e8QpqHysBFAkyTq3Oe1hfbwuJW1ppLc0mTV7QU0wsXMPqAop4B08cDtnBJR/br0O/2reNVjiwQ6fTbbLSoHW2CIF6qESIqguXJFB8Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujfi13XoIopzlaweqjHCgrLH/0sPktw3MZvQ0ulrN58=;
 b=Z333AMlxAkPMhrXtcz/63WrHBGIlLe+2SOhYOAotgXjr2kEPzk/VIF+zcb8WThHuqN1oFsH7+veBnhBlaTdZ5gOZha6UsX82CQ+j31aa0ok3TT29ii7yp4NGgWXE+oDbvKTHYp3OoK6LjTscXlwUz+3vxklDJI717EDotqdEnVXLKFD0MQWNbVXZQjYq2UPwd9cfKdwqxhqO+xSyeBNZC2ytxBGJXy7stORkxjgHd9gsb8A5lBk8RBh5szMyLEqYf+aBF1IHPNAJYb5yOO6m4d3XGet3XA8BUFuRT7NeOYZnMAhyiiMiZNDiT3ZmPy265V43eYqAhzg9rPl0jX1/QQ==
Received: from DM6PR02MB5433.namprd02.prod.outlook.com (2603:10b6:5:79::32) by
 SA0PR02MB7369.namprd02.prod.outlook.com (2603:10b6:806:e3::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.24; Tue, 29 Sep 2026 01:22:42 +0000
Received: from DM6PR02MB5433.namprd02.prod.outlook.com
 ([fe80::8766:b6fe:2e51:d829]) by DM6PR02MB5433.namprd02.prod.outlook.com
 ([fe80::8766:b6fe:2e51:d829%3]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 01:22:42 +0000
Message-ID: 
 <DM6PR02MB5433B368AD66DFB1D5C2D465EA8C2@DM6PR02MB5433.namprd02.prod.outlook.com>
Date: Mon, 28 Sep 2026 21:22:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION 6.14 -> 7.0] ALSA snd-ctxfi: no PCM playback on
 Creative X-Fi Titanium HD (EMU20k2 / SB1270)
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, regressions@lists.linux.dev
References: 
 <DM6PR02MB5433F3C2A156335B6ED47756EA8E2@DM6PR02MB5433.namprd02.prod.outlook.com>
 <87eced5zi5.wl-tiwai@suse.de>
Content-Language: fr
From: Dany Patoine <dany_patoine@hotmail.com>
In-Reply-To: <87eced5zi5.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0022.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::6) To DM6PR02MB5433.namprd02.prod.outlook.com
 (2603:10b6:5:79::32)
X-Microsoft-Original-Message-ID: 
 <91014380-36a2-488a-8a9b-dfec202099af@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR02MB5433:EE_|SA0PR02MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: a5b28ccd-3dc1-4489-15f3-08df1dc828cd
X-Microsoft-Antispam: 
	BCL:0;ARA:14566002|51005399006|5072599009|6090799003|25010399006|8060799015|19110799012|15080799012|23021999003|37011999003|24021099003|2607281247196008|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SGczN2htQU5EUm9mbjBBT3JlNXM4d2l4R1JncUVWL2JJY2s0NlVlV2F6K0ZX?=
 =?utf-8?B?N0hxRThBdFkwRmZaMk9EeHc2clZOM09NcExPWmszSVdSODBJSFIzR21TKzk2?=
 =?utf-8?B?MUM0eGVnckhqRHpLL1g1bDVSMTBnMzlzQm85R2t4dW0rRHIwWlhtdnFyUDRu?=
 =?utf-8?B?dlkxMjFFazBZRXpjTkFCUGRxazBNWmg4akdQQlZXcFhLQi9YbDVaeEE3SzdG?=
 =?utf-8?B?WFhvZ2JXWjl0MTJOWEtxSTVvUU5pWTVSZlVmVzJadDFRVWIvYkpFZGcrUDJV?=
 =?utf-8?B?a1piYVY3ZjZ3YmtLQzg1bVdkVE9GdEhid3NCOHgyT3VHeHpadExjREtZNEVJ?=
 =?utf-8?B?QVpZOGYrN0x5cGV6WG1sQjFHME1EMTVCT2xHSjlzTHpDMWJZb1g5WnJITnEz?=
 =?utf-8?B?RlpkVUVJbU9YZVExcnY4WFZIYmtYa1plSDNXbStMajY3Q0tQZmtWQkRDdnlp?=
 =?utf-8?B?a25HU3hGdEJQdXc0MUZldW1ZYk5KazV0R0VSM3RLUVJmeUlQZ0k5WVdxdTAr?=
 =?utf-8?B?OHRFWCt6TTd0YkJOcjhhczhoNmdhc1ZFNUtBc01ybFRkcTNhUmZwQ1k4YkUr?=
 =?utf-8?B?bTFJNU5NRFlNS1JtL090elJ2YVdWTVkraWE1U2Zrd3Ficmp5NTRkUXVUcVVv?=
 =?utf-8?B?WHpOVjlFNzd5SG1yY1Z4YWNpMGZ0RGVCbnBEdlFvT2NxSWNXUTFIQ2hYTlZi?=
 =?utf-8?B?bmF4S2JhWXVDc21lRUFmT00rZDhLNjdnRlhZQjhSQ3dxSDVRTjlUQUFaYXRC?=
 =?utf-8?B?SE9Vc3c3S000UGFsRmpoT3VQWW43azA1dlJ4dGlvcUFTZFg4TGwxRW5PVlR2?=
 =?utf-8?B?NGdDcGp2NVNvZmN4b0xUd0VDUUdmVnprQ3psbGlTQ0pKVWhKM2E5STE0S1lu?=
 =?utf-8?B?RHFuN0NOL2Q0bEJDMjl5M3AxNnRSU1M5QnQvQ1k3emxyMWZGaXRSbG5BbTV1?=
 =?utf-8?B?dzhIMWZHTjRBRW1DVzZpZW1lQkxYZm5kelhTdTBiVloyUGxPa1JPUG1kaDhW?=
 =?utf-8?B?cGwvdm80M255bkdFQUdYRVlqanMwUUZiSUNHNGlHd3pXMWp5RHVRUVVLeHRQ?=
 =?utf-8?B?c0ZsK1VrdHFPeWg1R0VkaER5MU5VaFcrVjhPMmZFbkZjUDFxK2Q5RlNBWE8w?=
 =?utf-8?B?SWZMOTh4SE9pUkFPWmUyQTlqSlNMWXVKZGRXSGdvSHJHT2JSMkVCZEFKOEph?=
 =?utf-8?B?RWNSaHFMWm9iZENaUDZzTjB4dk9INkFHL2NFdVA3YXJTdUVSOEVKOS9oM01X?=
 =?utf-8?B?U25BdW5JeFV1bDE5TGZWL1czUlJLZW1wOWpJWjBOMkJIZ0xESlRGOFYySWo5?=
 =?utf-8?Q?cwOpGMitNQ/QGUyVwqoO02vdz8VmIX5WNk?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cENOYWlrY0NpbWcwb1NaYTBFZHJKUVVZUkV0MnR2SG9yTWwrMlB1RE1BK0ZP?=
 =?utf-8?B?MmNGUFUwQWVNR21jRGxBWVhSMXJraGJWYXVHMXAxNWRwQTM3ajFSVHdyVDZQ?=
 =?utf-8?B?eXVOc1IrdE55anJ5QjVCcENpUStWMVRzeE5qSm4wejV2TkIrZ2hhL25jUGRH?=
 =?utf-8?B?Y0ovV3VuWUNPUlBsR1p0UG9HbStrSUdyNjg4bHNEMGFUV3hzd3c2bXFKMmRW?=
 =?utf-8?B?eFBreUdQQzJYaDRBWTIwNjVnK0ZQczlXS0FZTHlYVWhTVlBLWUM1b2dKekNt?=
 =?utf-8?B?aS9TUU9NdVR1aWdHbkhhUVZOblAzVDhKOFVpNjVqSmV5bmc5aEozTkliL1dS?=
 =?utf-8?B?OWcwT0puV1JsS0pQRUs4OVFCMFR0SjRmOGx1WVZJQWIvN0FlM3NkbHJSaStJ?=
 =?utf-8?B?TS9oMlBZRU9GbWt1OWttN2cxNFh4QnNocERXRnpuOFVKWFRlWkhyZWJOQ3RS?=
 =?utf-8?B?NGpjNzRnNmJpVThaUGZ4QzAyUjNDR3NqbGpsMXJUbktlOTVKQlA4dTB0Zzlv?=
 =?utf-8?B?Z0lFSEV1d3orVUZyaDBpWHAyWTJtYkh6enl2UEVIczBnVjc4cnhNWWF4d3pk?=
 =?utf-8?B?UjlDWlNTL3Y0NGdXUk9KWU53QXRDRHZFZ2xuM1ZHSHFJa2R1QnhyWW0xL2pt?=
 =?utf-8?B?cnp2N1lPSEMxU1RxUnBCalhaRHlyU21hZEUyczBuRzNWRGUxL1JNUkdleUtX?=
 =?utf-8?B?T1hUanVWNlRVd0pWcWlDbHoyUnFzeUN6MUcrdWhwSVdjM3dPV1JEbmFrVE5H?=
 =?utf-8?B?SWl3Rm9oSS9GZFZGL1Y2bzJlN3MrY3hqbUs5cnhzV25sc2lPTFYxQVB3aUIx?=
 =?utf-8?B?Ni9MQUxEaEpxdHRWOGxnRVQrbEVPeStiOXhBV1Z1M0NjOXZuKzZPZE1YUnpK?=
 =?utf-8?B?U3dxdldSV1M2NmRUaFQzREErMis3dzJXazNWY2xLQzNzbUh0WnRHcm50K2Nm?=
 =?utf-8?B?SHp4Wkt3TVhHclJ4YnRyR2RNVFA3emdicmE3R3JZMkJnTUJIOHZha2w1MVhj?=
 =?utf-8?B?Z0Z0VVJxSU1kcStRTVpsbUlncjUwWkdTTHVxRzlZc2o5QjVHMWEzeXIzUjJY?=
 =?utf-8?B?dXdhZWVaVko1ODlleUhMeVBkQ0l0VmhteDNGbldicW1WMmJmWlNVTzdDN1U5?=
 =?utf-8?B?OWdmRW4zS0pTL0JVTitDeUpEZzhCNUVoMzRDQkNuOFZqakRESmZBbXVkMnZh?=
 =?utf-8?B?OXFBbzlHNUs4TlNXV2Q0SkF1SjA2ZmM5ZmJlU0R2YUxRMTMwYTVsYlJJbzZr?=
 =?utf-8?B?NEQwNzVUQnhLaVA2ai9EaDVnWHhZcng3bEdvR3VpV1BKTnltUkluSkVtMW5q?=
 =?utf-8?B?TERTOXRncU9KbHdKRC9semRCeXUxNWF0SGpyNWhqVzBneW82T0w5YzBucEdJ?=
 =?utf-8?B?U2VvMUVpNGRuaStvVUxPSENZbTE0RXgyMXBMRUowbDhDcEFIM3dWSXJOMGpZ?=
 =?utf-8?B?NlovejRJcDRWQUdOaTc2SzkraHZhd2lGMVRZWWR2QUNmWUdrKy8wMGJ5b2JC?=
 =?utf-8?B?WmpmSHJwWWNTSGZMNkc1MC9tMFh6UnNBZzVsK0pVM3JTa3dzWFhnWHUzd0Fj?=
 =?utf-8?B?Y1hYdStvd0FMcFFOU004WFljSzl5L0pzeUdqaTlRODE1OFd5UjdaRWVzbDg1?=
 =?utf-8?B?MmIyL0lHWWsrdUY2OUJLQ2t3aVJvQXRXN3Myc0hXWUtQSUVxei9vbjdaM1Fv?=
 =?utf-8?B?bEZDcTBzY2JmYlF4WUEzYnFzc202V0lFNHpMVnpIRlZWbXBQcFBleTdScHl0?=
 =?utf-8?B?cnhuK3c3SkZBWi9FeDRndmhUU28yamdXTU56b3dNWkNyaWU2dzM1WjJlYnZw?=
 =?utf-8?B?d2JzUFBiT2VnS3FkMHVMUDloaU5ONXJxWktKU0E2V1BQbXBTUjFTU1VTYWdL?=
 =?utf-8?Q?Lh+7mlpi889Le?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-cd312.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 a5b28ccd-3dc1-4489-15f3-08df1dc828cd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5433.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 01:22:42.8198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7369
X-MailFrom: dany_patoine@hotmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: O4TSRLU7Z5RWVMX7FYXBG76BZOIDSJF7
X-Message-ID-Hash: O4TSRLU7Z5RWVMX7FYXBG76BZOIDSJF7
X-Mailman-Approved-At: Tue, 29 Sep 2026 19:07:11 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TJD3DB3RVA4PIXSGXSLXSL7YGKCHNH6O/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 28 Sep 2026, Takashi Iwai wrote:
 > Could you verify the latest 7.3-rc5 kernel to see whether the
 > regression is still present at first?  If the bug is still there,
 > please go bisection.

The regression is still present on v7.3-rc5.

I built v7.3-rc5 from the mainline git tree (tag v7.3-rc5, commit
72d3fcf802c4), without distro patches, using a config derived from
the working Ubuntu 6.14 config (localmodconfig). use_system_timer=1.

Results on v7.3-rc5:
   - speaker-test -D plughw:CARD=XFi,DEV=0 -c 2 -t sine -f 440
     exits with 0, but no sound is produced.
   - MP3 playback through PipeWire: no sound either.
   - A short pop/click is heard at desktop session start, where the
     login sound would normally play, but there is no continuous
     PCM output.
   - dmesg only shows "chip 20K2 model SB1270 (1102:0062) is found"
     and "Use system timer", with no errors.

I am starting the bisection now. Since builds are slow on this
machine, I plan to:
   1. confirm that vanilla v6.14, built the same way, works;
   2. bisect over the commits touching sound/pci/ctxfi between v6.14
      and v7.3-rc5 (33 commits);
   3. confirm the result on the full tree (the suspect commit vs its
      parent, and a revert on top of v7.3-rc5).
Please let me know if you would prefer a full-tree bisection instead.

I can send the full dmesg and alsa-info output from the v7.3-rc5
boot if useful.

Thanks,
Dany

Le 2026-09-28 à 08:30, Takashi Iwai a écrit :
> On Mon, 28 Sep 2026 01:51:04 +0200,
> Dany Patoine wrote:
>> Hello,
>>
>> I am reporting a playback regression in the snd-ctxfi driver affecting a
>> Creative Sound Blaster X-Fi Titanium HD. The card works perfectly on kernel
>> 6.14 but produces no audible PCM playback on kernel 7.0.
>>
>> HARDWARE
>> - Card:   Creative Sound Blaster X-Fi Titanium HD (model SB1270)
>> - Chip:   EMU20k2 / CA20K2
>> - PCI:    02:00.0 Audio device [0403]: Creative Labs EMU20k2
>>            [Sound Blaster X-Fi Titanium Series] [1102:000b] (rev 03)
>> - Driver: snd_ctxfi (with module option use_system_timer=1)
>> - System: ASUS P8H67-M PRO, Intel Core i5-2400, x86_64
>>
>> SOFTWARE
>> - Distribution: Linux Mint 22.3 (Ubuntu 24.04 "noble" base)
>> - Sound server: PipeWire + WirePlumber
>> - WORKS:  kernel 6.14.0-37-generic  (Ubuntu HWE)
>> - BROKEN: kernel 7.0.0-31-generic and 7.0.0-34-generic (Ubuntu HWE 7.0)
>>
>> SYMPTOM
>> On 7.0, PCM playback produces no audible output, through BOTH paths:
>>
>>    (a) Direct ALSA, bypassing PipeWire:
>>          speaker-test -D plughw:CARD=XFi,DEV=0 -c 2 -t sine -f 440
>>        completes with exit code 0, but no sound is produced.
>>
>>    (b) The normal PipeWire path (default sink = the X-Fi):
>>        also completely silent.
>>
>> Details of the failure mode:
>>    - kernel 7.0.0-31: truncated / choppy fragments with use_system_timer=1,
>>      and total silence with use_system_timer=0.
>>    - kernel 7.0.0-34: total silence with use_system_timer=1.
>>    - No xrun and no error is logged; playback appears to stall silently.
>>
>> On kernel 6.14.0-37, the exact same commands and configuration
>> (use_system_timer=1) produce clean, continuous audio.
>>
>> RULED OUT (all verified while booted on the failing 7.0 kernel)
>>    - Card detection: OK. snd_ctxfi loads without error; `aplay -l` lists
>>      card "XFi [Creative X-Fi]" with all PCM devices (Front/WaveIn,
>>      Surround, Center/LFE, Side, IEC958 Non-audio).
>>    - Mixer / routing: Master 98%, PCM 100% (no playback mute), Front [on]
>>      100%, "Analog Output" = Speakers. PipeWire's default sink is the X-Fi
>>      at 94% and is not muted.
>>    - use_system_timer: both values tested (0 and 1), neither gives
>>      continuous sound on 7.0.
>>
>> RELATION TO A KNOWN FIX
>> This appears to be DISTINCT from the EMU20k2 regression fixed by commit
>> e9418da50d9e ("ALSA: ctxfi: Limit PTP to a single page"): that issue only
>> affected PulseAudio while direct ALSA (speaker-test) kept working. Here,
>> direct ALSA is ALSO silent, so it looks like a different problem.
>>
>> WHAT I CAN PROVIDE
>> These kernels are Ubuntu-packaged, not vanilla mainline. On request I can:
>>    - provide full dmesg from a 7.0 boot and `alsa-info.sh` output,
>>    - test a vanilla mainline 7.0.x / 7.1.x kernel,
>>    - test any candidate patch,
>>    - perform a git bisect between 6.14 and 7.0 if that would help.
> Could you verify the latest 7.3-rc5 kernel to see whether the
> regression is still present at first?  If the bug is still there,
> please go bisection.
>
>
> thanks,
>
> Takashi
