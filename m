Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D75CCD3442
	for <alsa-devel@archiver.kernel.org>; Thu,  7 May 2026 19:34:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1298360220;
	Thu,  7 May 2026 21:34:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1298360220
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778182479;
	bh=l3Ab7XyBHgYgdVUYvnIxOK1iLTlvrFfToU8aQQgN/KE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hTVSV8L6dfIvkSKRR1yM8WSW8wTGITfBwBck8X/P6lhlYbV5GufInYKAw45FXahcf
	 z641ONHfEkHbGCxhnQAk83pamMkcPC5aqA5hu/mNHPRHK1TPQM+uHX9SdIUZbcHEbS
	 xVX4CqvRHBPPpdSCDGyoSw8zGlLyoa9Gr3lBRuiA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EDD3AF805F6; Thu,  7 May 2026 21:34:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D6BAF805E6;
	Thu,  7 May 2026 21:34:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C963FF80518; Thu,  7 May 2026 21:33:59 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012062.outbound.protection.outlook.com [40.107.209.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 954CEF8007E
	for <alsa-devel@alsa-project.org>; Thu,  7 May 2026 21:33:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 954CEF8007E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=QAUvULD2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nn2IuTjL8jvdML2svC2Y/uw8o4JNrU7to2XEI9DDm9ZpLM2BzJhwFXZDWr+yHny9AkTK7iP9cj1bB8M++kV0qZwa9pIPrWyfemroVzJpeBfVzU7MVu6TtnDDrLFptWTG7IqQOP2A2tmialHvI0E6rG9S262yWDhRuCiuBG3pvetfvoPP6P4M2l38soIP6SJgqz5U14JIZsm3Qq396SBEkTdJkOSJlYN9Q8byZhGRfN4XcEybKq+n4Lau6ad7+DtY6vq97DhxLtJsgT3L/oWBi+vVfRbWKtLSTt0bTPie0uLMsg4WNg7CRd2h7nQ2WAnP9lshQp9IhSh4TMIlFcKD1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBnK3LOegx/g/JFrClnK88/roawC96Y8Z/Nty9vJdTM=;
 b=r+Zf4aETuMF2nId69g3gyri56HKBOf0nUEsIBB0lXXwzv2P+MXbZVqrAVJ6e6kQQ8jkxZktm5pDhuMe0H4CoAJn0/S0A1FvJUU+fUbH2rRn7FcJUzfhm4TumAo1Mtp4lIxlh8+O2WTnrNslDaRH4WzKGA5+1TT4Hfi4pdiKLGR4Z27alEmm3GnBWRsafB+rBU1/WogZPSz8V+APHgnOoelm0DzL+rwIbTjGIAw5AyMH9JIEWAfFx2nEaMi3rSJOnF4Xg68z0F74Fsb4PAa4KqbuK+fMa4BAqlts0GwWrVbsZKirvctIKJblvjTo1D8Wgma/vlsl6AgLvuK9cYzm6sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBnK3LOegx/g/JFrClnK88/roawC96Y8Z/Nty9vJdTM=;
 b=QAUvULD2xeKJhyPPh9PuCEmvVsXJKAAyrwY3gbTAB8h02DLNBHNFyzf4PKtRYnu+fNcWFzb5iM7KUjuM2p9JrWjMBIMcq8OlqunjlQ53TmbRTcEi9zS8wp9Z7abyebw3IzW1dClxKQD9QJSoKbYcOAsorc2tJiZ2odt0HPg7mVY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by PH7PR12MB6540.namprd12.prod.outlook.com (2603:10b6:510:213::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 19:33:51 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9891.017; Thu, 7 May 2026
 19:33:51 +0000
Message-ID: <905bfeff-ab78-4299-a2a4-45fb8f05e716@amd.com>
Date: Thu, 7 May 2026 14:33:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] ASoC: amd: acp7x: add system and runtime PM ops
Content-Language: en-US
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260507181251.20594-1-Vijendar.Mukunda@amd.com>
 <20260507181251.20594-6-Vijendar.Mukunda@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260507181251.20594-6-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR20CA0013.namprd20.prod.outlook.com
 (2603:10b6:610:58::23) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|PH7PR12MB6540:EE_
X-MS-Office365-Filtering-Correlation-Id: 8505c16e-6402-4ce3-0787-08deac6f913a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	WqEQleZfblum0glpVXTKQyge9ppfZtQlcGt8Sb/Mqy3Jwpfvg8+24A0bC4zkyonKxuvcFdPS70wBEiibOacP7KKYwgtAZcvLwVDCnwohAxOuUX+5WjKJeB/yiSsY2wn9LJJExwMar4Ou6Brw/wRqMJ8h+2IPg21bvNI7kk/zCwezIt6Wg2OL26B5DpZlkLi8CLFeq1ks3QtRJybsOW4V8/QezOpSv+qPEY8c/ZpQJfkB67P9GJcr3EZkmUwmZYkqGYvEkKc7nE81anJH/ROJkSJ66OD5tqtJE3RTKsDs0fSB5+GmJaT1MxOpMs38PwBsraQmvgapXrFWKwXRjHRdtUZf6+72CAGprN9TcaWD4xJ+B4byvHGj2jzBkIoid1tWVnGqef7ZpzXHogwzTKVk4/MfkV+7G16lf8LaN/NB1oGFkpGyZTLlD5SsqBjH0OKfTTrJUNOBI01shI8DbO99iKVWKW1AfpfS9cjTnjpJ0A9OKpA1D9fTrEeoIDhovHsyVos4zPAaOtX+D0rZauzDXfDVIEvLqWQMlvh6wqXh8tFH2BXO0e8KlGDBGaYpJpYQLioNHkl9ZmZg8f9BVuIkiUAPGXOtGoaZEhZp51U8wUKvaR0fsBZoGzOfyeZB7xadCvqeHRf+qxG0Hj3WorUn4Ha4BOKgd1ED7KEdxzCAZw9vXE6iyfsRtpRaMA0I3tl6
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OXVMSWFSVGt1NFRzSzRib3Z1bTUva3ExL3cyeHhrbnZEWFJkUi9FVlBtemxE?=
 =?utf-8?B?T2VjcUVZZnpFcHZvdXN3UFZUZ0YzZTc3b0dTbUwvQ3R6UFp1eUd0YVNIb3hO?=
 =?utf-8?B?THFPVkR1QUJKTTdITUN6djZ5cDlUTTRTeTgzWThoTzVmNWppdVIzV2JzRk1x?=
 =?utf-8?B?YStXSFdsY0hnUXBMQWgvZHpZVitmRU0zdzVvNFRVL29lNHZoQmwwRnlpVnVk?=
 =?utf-8?B?VVFiUERnS29tT0ZmSWNkV3pObDlLbk1ZaFJ1UnZMa2htcjR3VFRLR0VuNWRl?=
 =?utf-8?B?THFGU0YwZTIyaEN1WTdpczFyRnVWaG01eldSV21nRXNzc1ZQUktDZ2dVc0dT?=
 =?utf-8?B?YU44MVkreXVwNHRDYk03NThqUDZaaUpaN2IyL01qNnNDWEZYcmNoNXl5cmxj?=
 =?utf-8?B?bzZBVWRwQit3dU14TzdqN2tRRGVRNzhpS3hhamVSQm9VOXJ6K1RScmgrekJE?=
 =?utf-8?B?ZWpJWER1TTd5TWNDWFZicWtjYmpCMEhQL0I5aE84UzBFSkNwMDJnZzBPNjNF?=
 =?utf-8?B?UXdjaDFWTjU4dlZ6d2tHODdFcUpQZXo2NEJrY0lObjBHWEhhOXZXZU9hWUti?=
 =?utf-8?B?T0NNaXJ5U2Jjd0lJRE8xY2lHYUg3THJmTWROQjhLcTcrbzlLZnJBb1VZM1lS?=
 =?utf-8?B?SkJZREJ6am5vZGFWVFl5K0Ntc3J6SE41dUY1QVM0RHlsOHI2RHZaNWdtRThs?=
 =?utf-8?B?YTRFbExFZkxTbGF1cGlyK25uSzAybHc4aXU3anE4NmFoWW1BN0lNb3paTjlv?=
 =?utf-8?B?Q2diVExvc2pwUEY3cTM3M3JaUWhQYW40MFpCZU9OYWlpQ1dmQkNzaVY4U0ZV?=
 =?utf-8?B?czlGcDg5RUhaQ0NWeld3TVZSQ3drRjR6YjJhMDhmUmJsQ1QwblV1MmRHVWtn?=
 =?utf-8?B?Y2ZuUHA5bVZJYkNxY3d2NUdSdmlvS1pVaVY3MWlyKzdiamF3ZjE4bXRBUjdl?=
 =?utf-8?B?SU5NOWlsYU5wN3hNYTFzdFo2eU5vT0xZVm01QVZYdjNhQmMzK2JSdHcrc0pt?=
 =?utf-8?B?aExSTjRTMWg5dGw0SU1WaHIxMUtxOEM4ek1WMlVqKzB6cDJGcWZuWGtEMDEr?=
 =?utf-8?B?QVdpOTVaT1E3a3h3cHduWDRaQW1uaDdOTXlyZ3hCSU1mVkdUTmdDcE1ZOWVa?=
 =?utf-8?B?elZjK1dZeWRzZHFMMzF1QXdKeUtINHZENkVQNHlZRmFDSURwT0FlWDJFMU9O?=
 =?utf-8?B?cVlFaUN4akgxYlZscTBXQkNxTTZCYmdrcG5OMllZUTdpVUhwR0RJSXhveUlZ?=
 =?utf-8?B?dUZUc2phTVVpeXM5eVZ3SEhOM0RkZUt4dmlXMW9qUmhUZUZYTnduYitEak5i?=
 =?utf-8?B?WkpBVFI5eVJLY1FqWm1CeVgwN3VGSndrbnYzV1BMOTdoazdaL2FkY3dreUEv?=
 =?utf-8?B?bHg1YVExZWJrcmxNWXhWUEEydlRYZkUxd1RFaHM5UUtEWDRFNGNrYlZCbG9R?=
 =?utf-8?B?cTZNaS95cG9PdEk5SVowdkxRTHB5cGZzeWtjNFdzRkFzcHRsaGtWQlk0UVIw?=
 =?utf-8?B?aDdvbmNYa3lKYkllam45Ny8raU1zd2dpK1hSNENVSnJmY1F3dVp3VEQ2aTRS?=
 =?utf-8?B?RzNMZFlxQkNDMTJGTmNNSTdUT2xWZEs4L1RRbWdQRm04UE5YamFHaHgwUEs3?=
 =?utf-8?B?aXBqblV6ZC80WmtiQmlBZVRZNjFDNkhmZlQ4ZlhLSW5YSDNRRmZJTVE3QjI0?=
 =?utf-8?B?QW9aRC9tblR5SWJKMVBDZnAyYmdFcG0wU29HUjUyZ1prazUwZFV4c29NVGU2?=
 =?utf-8?B?VXpwUXJ3Z2V1RHIxNjgwMW1UcE1lNlBKVk1pSisxd2M5eGpjS09TZzNFQnk5?=
 =?utf-8?B?aWFzZlFqdjVpZWVmVGF5c09heitvSTZFZ1RKWmYzWWlKL0YzWlF2RGY4R3Y2?=
 =?utf-8?B?T081NS95TVkzMGM3TDBHb1hoVjRoZ0tCbXU0bEpuRWlWZVR1SXVoSWkwMUkw?=
 =?utf-8?B?SmF1N3FiTXo4UGhQeWpyc24zcjNLcG5iRGN6TmhuSjVRV2gvdkY1OWFIMVBC?=
 =?utf-8?B?bm9MZ3NqMDk0Rk5uNDVCNEJkV2hBR2twdnFtOVZtQlN5MGc0RzFyamN0TGlz?=
 =?utf-8?B?cDV0bkw3MnliOEdWU1lTUkJwVytNYzBXV0VvUWgwcVpLTDIyM1p6U1BpQzVr?=
 =?utf-8?B?MUZaekZNSkhFdTlldFl2dUVnck5uZk94MXA1VHBPcmU3bFFxdUZtcjJYcWdU?=
 =?utf-8?B?U2RDbzVtN2JrZzZwZ1ZzT3NDbkZRVkZ4Z01NWlZmMDlKbzBONU5uck11T0pa?=
 =?utf-8?B?TEtYKytESTlIc1YxelZxTVR0bUhoNElCYysyY2Z3bFBicmxkUGVxc0pTdWd2?=
 =?utf-8?Q?SN4RcSrs5dyfJ3s8St?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 8505c16e-6402-4ce3-0787-08deac6f913a
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 19:33:51.4549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 Zz6BLMshFQBhSSSBSadBHPqeWNKFd/BALhWQYhZjiDIFdAvqYV6k0F8mrS+BqpJ4qWFMV4KCrUOSCCBcO1jBcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6540
Message-ID-Hash: SZBOFBSZ22ADDJRVQIKFDGOIDXKA2DGL
X-Message-ID-Hash: SZBOFBSZ22ADDJRVQIKFDGOIDXKA2DGL
X-MailFrom: Mario.Limonciello@amd.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SZBOFBSZ22ADDJRVQIKFDGOIDXKA2DGL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 5/7/26 13:11, Vijendar Mukunda wrote:
> Add ACP7.x PM callbacks and hook up system sleep and runtime PM ops for
> the PCI driver.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>   sound/soc/amd/acp7x/acp7x-common.c | 43 ++++++++++++++++++++++++++++++
>   sound/soc/amd/acp7x/acp7x.h        |  3 +++
>   sound/soc/amd/acp7x/pci-acp7x.c    | 31 +++++++++++++++++++++
>   3 files changed, 77 insertions(+)
> 
> diff --git a/sound/soc/amd/acp7x/acp7x-common.c b/sound/soc/amd/acp7x/acp7x-common.c
> index 68f9b47766c4..df94864a1693 100644
> --- a/sound/soc/amd/acp7x/acp7x-common.c
> +++ b/sound/soc/amd/acp7x/acp7x-common.c
> @@ -75,8 +75,51 @@ static int acp7x_deinit(void __iomem *acp_base, struct device *dev)
>   	return 0;
>   }
>   
> +static int __maybe_unused snd_acp7x_suspend(struct device *dev)
> +{
> +	struct acp7x_dev_data *adata;
> +	int ret;
> +
> +	adata = dev_get_drvdata(dev);
> +	ret = acp_hw_deinit(adata, dev);
> +	if (ret)
> +		dev_err(dev, "ACP de-init failed\n");
> +	return ret;
> +}
> +
> +static int __maybe_unused snd_acp7x_runtime_resume(struct device *dev)
> +{
> +	struct acp7x_dev_data *adata;
> +	int ret;
> +
> +	adata = dev_get_drvdata(dev);
> +	ret = acp_hw_init(adata, dev);
> +	if (ret) {
> +		dev_err(dev, "ACP init failed\n");
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +static int __maybe_unused snd_acp7x_resume(struct device *dev)
> +{
> +	struct acp7x_dev_data *adata;
> +	int ret;
> +
> +	adata = dev_get_drvdata(dev);
> +	ret = acp_hw_init(adata, dev);
> +	if (ret)
> +		dev_err(dev, "ACP init failed\n");
> +
> +	return ret;
> +}

Both of snd_acp7x_runtime_resume and snd_acp7x_resume look identical. 
Will there be later code (when machine driver and IO enablement come) 
that makes them different?

If not; then I think you can drop snd_acp7x_runtime_resume().

If so; this makes sense to keep separately.

> +
>   void acp7x_hw_init_ops(struct acp_hw_ops *hw_ops)
>   {
>   	hw_ops->acp_init = acp7x_init;
>   	hw_ops->acp_deinit = acp7x_deinit;
> +	hw_ops->acp_suspend = snd_acp7x_suspend;
> +	hw_ops->acp_resume = snd_acp7x_resume;
> +	hw_ops->acp_suspend_runtime = snd_acp7x_suspend;
> +	hw_ops->acp_resume_runtime = snd_acp7x_runtime_resume;
>   }
> diff --git a/sound/soc/amd/acp7x/acp7x.h b/sound/soc/amd/acp7x/acp7x.h
> index d3a57705385a..ddb5eabf6828 100644
> --- a/sound/soc/amd/acp7x/acp7x.h
> +++ b/sound/soc/amd/acp7x/acp7x.h
> @@ -33,6 +33,9 @@
>   #define ACP7X_PGFSM_CNTL_POWER_ON_MASK		7
>   #define ACP7X_PGFSM_STATUS_MASK			0x3F
>   
> +/* time in ms for runtime suspend delay */
> +#define ACP_SUSPEND_DELAY_MS			2000
> +
>   struct acp_hw_ops {
>   	int (*acp_init)(void __iomem *acp_base, struct device *dev);
>   	int (*acp_deinit)(void __iomem *acp_base, struct device *dev);
> diff --git a/sound/soc/amd/acp7x/pci-acp7x.c b/sound/soc/amd/acp7x/pci-acp7x.c
> index 237eb06e3cad..d29a149cf175 100644
> --- a/sound/soc/amd/acp7x/pci-acp7x.c
> +++ b/sound/soc/amd/acp7x/pci-acp7x.c
> @@ -11,6 +11,7 @@
>   #include <linux/io.h>
>   #include <linux/module.h>
>   #include <linux/pci.h>
> +#include <linux/pm_runtime.h>
>   #include <linux/slab.h>
>   #include <linux/types.h>
>   
> @@ -92,6 +93,11 @@ static int snd_acp7x_probe(struct pci_dev *pci,
>   	ret = acp_hw_init(adata, &pci->dev);
>   	if (ret)
>   		goto release_regions;
> +
> +	pm_runtime_set_autosuspend_delay(&pci->dev, ACP_SUSPEND_DELAY_MS);
> +	pm_runtime_use_autosuspend(&pci->dev);
> +	pm_runtime_put_noidle(&pci->dev);
> +	pm_runtime_allow(&pci->dev);
>   	return 0;
>   
>   release_regions:
> @@ -102,6 +108,26 @@ static int snd_acp7x_probe(struct pci_dev *pci,
>   	return ret;
>   }
>   
> +static int __maybe_unused snd_acp_suspend(struct device *dev)
> +{
> +	return acp_hw_suspend(dev);
> +}
> +
> +static int __maybe_unused snd_acp_runtime_resume(struct device *dev)
> +{
> +	return acp_hw_runtime_resume(dev);
> +}
> +
> +static int __maybe_unused snd_acp_resume(struct device *dev)
> +{
> +	return acp_hw_resume(dev);
> +}
> +
> +static const struct dev_pm_ops acp7x_pm_ops = {
> +	SET_RUNTIME_PM_OPS(snd_acp_suspend, snd_acp_runtime_resume, NULL)
> +	SET_SYSTEM_SLEEP_PM_OPS(snd_acp_suspend, snd_acp_resume)
> +};
> +
>   static void snd_acp7x_remove(struct pci_dev *pci)
>   {
>   	struct acp7x_dev_data *adata;
> @@ -111,6 +137,8 @@ static void snd_acp7x_remove(struct pci_dev *pci)
>   	ret = acp_hw_deinit(adata, &pci->dev);
>   	if (ret)
>   		dev_err(&pci->dev, "ACP de-init failed\n");
> +	pm_runtime_forbid(&pci->dev);
> +	pm_runtime_get_noresume(&pci->dev);
>   	pci_release_regions(pci);
>   	pci_disable_device(pci);
>   }
> @@ -128,6 +156,9 @@ static struct pci_driver acp7x_pci_driver  = {
>   	.id_table = snd_acp7x_ids,
>   	.probe = snd_acp7x_probe,
>   	.remove = snd_acp7x_remove,
> +	.driver = {
> +		.pm = &acp7x_pm_ops,
> +	}
>   };
>   
>   module_pci_driver(acp7x_pci_driver);

