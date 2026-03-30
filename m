Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595DE10F3DCD
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2026 14:16:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4A7C1601F4;
	Mon, 30 Mar 2026 16:16:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4A7C1601F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774880212;
	bh=mbtNLqBkGZnt22Si64GjS5cDJG8KiifRLpGt/pOBlI4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=GeoJ/CUbJDFHpN1Oh8gEP/PgJiq+3hYE0I1V2KdPDY/0ERooeNpB3dI5p+ygKkKDG
	 UAJSEVNCmPbsciZxxCX4+Ex5iqgZoIBIUSXyagpTdBS8oH5v8reiBYeoQnoydgBmxZ
	 1SkiaLPq+GsRbXIcIjqUAlcldz+XspCCHPxGkUXA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B0078F805ED; Mon, 30 Mar 2026 16:16:17 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 309B6F805F5;
	Mon, 30 Mar 2026 16:16:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0E84DF8052D; Mon, 30 Mar 2026 16:16:07 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010062.outbound.protection.outlook.com [52.101.85.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C434DF8027B
	for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2026 16:16:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C434DF8027B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=tQYQimbe
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fp9pxAnA+FIsMklsbSlZzyUiay7shsV9P1+F+xeJVfL1OaIfqNg0MQThazrAdvATg4Wc+rfkvKAZGybE1oAdrcL/m4IobKSQeZmlzA6aFRNrEbCRgc+M0t3Tm19kj+sB3LKH0UeBDHu1yfvBxeUrEUAQuDJFR5Rr65dl2bFQ21MOKvxtVzpsR6qzWw68jxj+lf/Az13oyPJ5Fv2g7wxiDTcQSabd2jmYxVgOXnIVFAh4876ANUsShM3o8Uy9jD/NpCk0LRkciwqNod4m64sS8rDkVe9Oe/uB0K3BWLgttwerCNk4EzAJ8ggkAbe4bFdOZFKjvX8APX8wbtQMSlRZAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlPuViGNSITmNFOQ6bzEHDpeOZxqGoA+Yxv3a4113Jw=;
 b=VLfAspWgAXtUBOOwOdRTZ3iaEZn+Op8d10Zx8ByW3+h77JmTy4TZepmcYQR4pYQEfnq2CqRgrvFKYXZn8aA3aJGrIJjTBTwqT/JRt++t2cPbIKEJQqgVhLltMuBvEGk/PpFQoQUTmkqGRTbhy8QBXdDpf2xbWtTIVFtaOgaxrj/m2Pm0fFkHUQDtZ4H8ZOsPg0Zu3faG8xMQNe6ylzRZBiHN4+fxfBGQeQT3GDRY14HyG2VqtvJGDsDNRtb28gYbbzWBd1N1KZ4DWtr1lMqNQk46gugJB+6uT/vDWoGinzlH/nfR5Ie+ONHQ51RNxTRkcSn8ck+GoFocV49qrTKKww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlPuViGNSITmNFOQ6bzEHDpeOZxqGoA+Yxv3a4113Jw=;
 b=tQYQimbeuKviT3UA06tX0JumAlxQmJHrYu02t+hKZVpi5ieYM8BQbSDWkK1tYaxJDYDAONXCiSLIAKeHg//oykdshliEPH08YTt8QJdcaJmg/9h7/yG+fyyTWdt/UiPJEDuDpuG7p7Q0BOxAqNtbW+oFkISBArsWBch6uj/BRLQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by IA0PR12MB8747.namprd12.prod.outlook.com (2603:10b6:208:48b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 14:15:57 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 14:15:56 +0000
Message-ID: <510b78db-d04d-4283-9ad7-42c0420e1db3@amd.com>
Date: Mon, 30 Mar 2026 09:15:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: amd: ps: fix the pcm device numbering for acp pdm
 dmic
To: Syed Saba Kareem <syed.sabakareem@amd.com>, broonie@kernel.org,
 alsa-devel@alsa-project.org
Cc: Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
 Sunil-kumar.Dommati@amd.com,
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Kees Cook <kees@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 "open list:AMD ASoC DRIVERS" <linux-sound@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260330094642.3088923-1-syed.sabakareem@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260330094642.3088923-1-syed.sabakareem@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::6) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|IA0PR12MB8747:EE_
X-MS-Office365-Filtering-Correlation-Id: 667060a7-59e8-4a39-fd2e-08de8e66dbf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	CXhqrrDmeNCMAGzguYPKfbW4bASJD3uxepVbNHD5cAVRrLYN1EwWyJmX7U2EtFD8pkYMJvoSsXOorgN/atJZieWEBEdXQNcwfw6TzvCgI0LojKMJeWv1q9EyUamPF95sffTvuP7rAcxbHt3OtLx78NJsAGokzGSnIkf2G+oAiTilB/U7PcpjwPqJcS9L2Ir7CshM/TGiqZsVqHOim0mEQfPjvo0mHVIKo236PmoHlgXd2/r7rrLACe44UDStpouHFmiKEp99CDb0+PSqVZQSxszIMwDIL12QoMa9tue8CTWnriVtqayCN94SJEl4Azzcp/l8ZKlq3HlCyPvq1FRR3fYOrbY3ZN/hMtQs9XTOAeKXTkosaHPys/Xnlb+inN3PkpX5fNBZ1L+pawQiZbj3PW3LRUyS98EUAxHyLDCnHuLyyPmgedghT8MUFuLpK6g168JwLmGMwGaq5x4WE3pJLSD40vcFqZ5iSR8s5ZSzB9Ax9nqRy+zxc+yM9lt9hanW7R2MBvpi+ydrkz4brwi+D1pmaPoW0/wGuzNIMIgkrbkOivu/fsMkZZxVzcMBYdc1a7i5XaylHRklj5qAFtZYcBYKzI4bkNWBpc68KuveeiLSWtmKgMDMOdJL1DA9USjMZEk+vXgx0tTUuRVFZwr/LP6GV+ySH9JgWmb77Gihe4wsuLfsSYDPKFimI0RZIrGnNvGjo2d3HEj4GtUON+yrguoc3wjwNpw3X3i13VG9VvM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QTJoUC8yTVdIZktiK1NrNjF3VmJqNWhJTXFGM0FXbGxtbEN2YmtHcXNXUEhM?=
 =?utf-8?B?QmNVTno3YTk2NHpRSUlEeWQyYk12clk4MU1FRGw2a2poblVWa2tOaWNJZkFj?=
 =?utf-8?B?V3JrYi9IQlQvQXN2aThhK04zUnpmN2liZ1EveUlTcnhqcnZOMUVQRlkxbWNU?=
 =?utf-8?B?Mkw3TDFaTGlGL0F2MFcydGx5TDEzOGJwdzNEb3FnSHk3d1dybHczeUlyRnh6?=
 =?utf-8?B?WTdmZlpQeVhTeEtoTGFBYmFoZDUvV09LZVRLUWRuZVBnNmRxYzRWT3p4Wm5M?=
 =?utf-8?B?d0I5SHRRWkh2Q0FoWmcvS3hmWG1UN2RlRTV3N0FLY3ZGbTVYbXRQMEZzRStk?=
 =?utf-8?B?YlpONndPNjFlQVM3bkgyVmJMako5aVVjTWsxc0NtUkhvSmZmcUViK0s5ZFZz?=
 =?utf-8?B?Wjc5RGZkVm5tWncrZ0pSUUhXdnowdFl4bUpRcnZ1VGpMQjVuRHhFMUhyUkFX?=
 =?utf-8?B?OURvZzI4VXdkSU1xV2lzZ21HQkNSYi9TY21kSlJoUUZPN2pSWGF4OURVWUlB?=
 =?utf-8?B?L2x6ZGt0WGplQndqbGVUNnJ5K3NiTFRzWUNZRWRVQWNSWTVNbFhWVHNCN01n?=
 =?utf-8?B?KzlGZEZPeDJkd3cwWUJveVpoY2pqWlI2RWxoMU4ydVRnalVlNVRqVmI5bHVj?=
 =?utf-8?B?T3B6a1pHTkdZNDJtWnR0amhNSHNLemxhOHhEbWpPN2RjU3B2aEtJdWszMjN0?=
 =?utf-8?B?N0N2RmhXUmwwdEdqcjdLZU1UeTlucnhseC8ySHhDWVpWNEJxd09BKzljMlE4?=
 =?utf-8?B?SFVtWFdjWFdrV25BR0d2MUdSR095RTlWNnVCREpFMUV5MkFRdmFJTnJRUGFD?=
 =?utf-8?B?TGNGZTI0QXdKazVRaTMzR3BXZXVQVlljano5TENtY2JsSmM2T0twa3VzSnlq?=
 =?utf-8?B?THN5aGlueG1wYU4rTnNTRVhkM0M3V0o2RmJnUlhkdjNBQTRzSXRGN2U4eG43?=
 =?utf-8?B?bWVwTmJqV1dEVWJUZ2ozcUlhZzRCWHJ1alErT2lDUkNKTldwbjRxUTVwbWFu?=
 =?utf-8?B?UVJuUmFDV1pPekl4MFZQTENNdkU1ZEV1aS93LzU0dVAvaW9kclA5dDMvc0Qv?=
 =?utf-8?B?QmhGN0lYTmZLYnJaZTZ6N1dIUDRxRjN2MkdLQkZQamxvczl5MTg0TEMwWVQz?=
 =?utf-8?B?bDh6TWFwb2xjTXZXY2pmd2pXUmlRVS92NCtVd0hDMVRjVTlEcGR6NnRZZlB4?=
 =?utf-8?B?dS95TGJFbm9ZREpjT2lFdDBTaGpHcGdhNFlRTWNNMjIwd3Bldk9yVkFLOWRj?=
 =?utf-8?B?YTJTSVliZUxDUXpZZURIYWxKcjlIWVVLUFVEcmxDa0NZZHZLRHl3K1RjalpB?=
 =?utf-8?B?elFOU05YT1drZ2xBNEVubTIranlkVXZMU0IrY1FJVzdtS0xLbDYzeGtnczBq?=
 =?utf-8?B?NVcyTnlPS1prV1pOb3p5Rms5MXFGYkozYTNZWmtEcTVTcmk2TE82dTJLWFNr?=
 =?utf-8?B?Nk9HckJiUlNjZk5YK0Y3NVFBcUlQLzRydjVKck5DaUNpYmh4UUZ0YzRwbjU1?=
 =?utf-8?B?Q3dvVkpqRjk5VHVtMWl6RDhCc1NRbGh1UXQ3bmhOcEYxUHNOOUNQV0wva2ox?=
 =?utf-8?B?MUFQL21pTHBybHJTOWQxWkh1dE1GcWdCSVFtWC9PVUhDQWI1MGFQYURmTWdx?=
 =?utf-8?B?U3dnUXM0MVJaYktyUGhoQXZrbzhENEJFM3d0Rkg5UGNTWHhPQnRkdlIra3NE?=
 =?utf-8?B?TDYxOWlyK2tueVM0dXZTN0pOVTZhRWl1dkVLZnd1TUtpS1lPVWhPTGZRSWNF?=
 =?utf-8?B?OVBvZm5haVU2NG83d1NOM05uRUU5QWwyRDIzZDV0TjY4WTRrNU9WaU4vT0hw?=
 =?utf-8?B?WVd3cXB6cm1sVGd5eE9wejZ2azF3ZVlGdWZWV0lLaHhpQmFhL2Q2emNNaWw5?=
 =?utf-8?B?TGtSelM2SnVoeDZkZTVONkRaL05NbVhKNldZODF5RFNzQWlOak5qaDhWT1c2?=
 =?utf-8?B?OVBVQlhEbEswVGNlRjdCNTRFOXJPTE9CenRpbDZVVjlWTGFqcERUb1Z3QlN4?=
 =?utf-8?B?bjIwVUVidENPYzRBOVpOS0E4OGdaamlXS1YwdEdLczhVRy9RM1MyWUtBeEEr?=
 =?utf-8?B?Nml3dmZMSitPQTR6cStJMnBLMW9rOTl0bTIvQzdLWkRyWWRkTUZxL09KTUNk?=
 =?utf-8?B?WkNpWWU4citOSHM1WGJMT2xPcnJCeG96c0VhWllSRTBKeVUvanBaQ0drL1JH?=
 =?utf-8?B?YVMxM1BxNERuSmZXM3M3elV0dWQrNDZaUzNiSWw0aGxNNkY0M1dqelVLUFZU?=
 =?utf-8?B?VjFvUWI1SEFEbHlUNVZXU0Y2RS9uUXRPRnBSYzc3RHVlM2FjQWppRTAycHpV?=
 =?utf-8?Q?XcCszDgm35t4jfmGsH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 667060a7-59e8-4a39-fd2e-08de8e66dbf9
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:15:56.8909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 mKn09/JBoyoTXcTKC+0hWRGVtYWSYj/3eTax2xl7nHaT4nZ7emQWi7rakK40zmtJ5766LORa7dfH85ue6i6CHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8747
Message-ID-Hash: NKMN46IT5RGJMYR2KFM7ZZ2SNAS72CXQ
X-Message-ID-Hash: NKMN46IT5RGJMYR2KFM7ZZ2SNAS72CXQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NKMN46IT5RGJMYR2KFM7ZZ2SNAS72CXQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 3/30/26 04:46, Syed Saba Kareem wrote:
> Fixed PCM device numbering is required for acp pdm dmic pcm device
> to have a common UCM changes.
> Set the 'use_dai_pcm_id' flag true in acp pdm dma driver for acp 6.3
> platform. To fix the pcm device numbering based on dai_link->id.
> 
> Signed-off-by: Syed Saba Kareem <syed.sabakareem@amd.com>

I suspect we want a stable tag on this too.  Maybe Mark can add when 
committing.

> ---
>   sound/soc/amd/ps/ps-pdm-dma.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/amd/ps/ps-pdm-dma.c b/sound/soc/amd/ps/ps-pdm-dma.c
> index c6cd844d458c..04c014349347 100644
> --- a/sound/soc/amd/ps/ps-pdm-dma.c
> +++ b/sound/soc/amd/ps/ps-pdm-dma.c
> @@ -352,6 +352,7 @@ static const struct snd_soc_component_driver acp63_pdm_component = {
>   	.hw_params	= acp63_pdm_dma_hw_params,
>   	.pointer	= acp63_pdm_dma_pointer,
>   	.pcm_new	= acp63_pdm_dma_new,
> +	.use_dai_pcm_id = true,
>   };
>   
>   static int acp63_pdm_audio_probe(struct platform_device *pdev)

