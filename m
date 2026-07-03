Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EF8C43458
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jul 2026 18:05:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D588D601FD;
	Fri,  3 Jul 2026 20:05:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D588D601FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783101954;
	bh=Tnic29WaMHaNb0a6dYbUq3xqm7iltQu8C6oK6V1Fsys=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=iEDLdHFVN8lDAbfzy5iJ4eHQoRMqc+MiJu4FOCWE/YTOCVBW+ROV0VNd62I4chknX
	 KEhvpmoqMhD3hNd6gwmk/PSHqUpVXTaSLIfndXH2GYaQtJRQZ12HVZH0y6YrT4SdOd
	 cnPi82KgZW7WrtbT8IDav+THhH/lJ3iRTNeYsGYk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BC2A9F805FF; Fri,  3 Jul 2026 20:05:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 10F7EF80602;
	Fri,  3 Jul 2026 20:05:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1026BF80579; Fri,  3 Jul 2026 20:05:12 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.54
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1783101911;
	b=opXCvpyraCbor1FzOS3tz8RwvJlSTzXyMNhFqCDpM0nUtV6HK8xjBlcw5Ni77sZTNoT3
	 1Owvx1JyfQLq0zzdQBHLoQkEj0uPQzHYubiGuSq/Q7PP2cyVsOJu1kXMvGOwIhr4JY+kK
	 Wp0I/Z0LIP7Ihtzk6KvaC0mvekoELtgTDQdvpmfSQD/I7WVhOBpvRCtbqWzkMgBYmo036
	 +yzUzCI7IP8HUYGuUwilV+6g27WO7GM2HhXLdkRbDgmrGdL+xqapqJ6QwVnaOFqNH58pQ
	 Jnx9xvOQZtenCmBwNYCLu6MMGziTnr4ZLo8UuybCHL0JhqfUwNHF7WqIzKMIvH/N6Pw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783101911;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version;
	bh=Tnic29WaMHaNb0a6dYbUq3xqm7iltQu8C6oK6V1Fsys=;
	b=L1vhtUBjjVYJs/nzmDEtw1UcUO2sfF13WJd4lJTVs6ROjoIiPkABehUCkF0bX3HxpOsA
	 KGT/7WJvW2hv7LvfodQaTSqFnivu6UfRmHZ30E31VCd1kMyREwIRi8NwY2Nzx8cXhjiSI
	 yucEYYFifLlMLVojN1wPQfJ6Jmr/GN/0cIm40qrPny0/1thCUh0USGreL2yl2UUpp+Yi/
	 hJBa+UUFsMCF0M1arwIxUfanOfmpHOyFpPSNQ+iYrj8AduNuRIxlEEg0qY9uJMA3jrJWD
	 gShd7Tn2W1wgs8F02bBfG29WhuVT5IOFsSJHeFvd6sBCSZJI/TukHnLUFjRV0+yOnmQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b="Y//avTh4";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.54
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013054.outbound.protection.outlook.com
 [40.107.201.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 30273F8027B;
	Fri,  3 Jul 2026 20:05:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 30273F8027B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Y//avTh4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0mqWHFNUQH+O4BM0OY8yo2yMIRxvXE4tW/ukpP5hsyqSAJL6Wt5iFb8fQaOonIZvrCiwH5/VQXBrBBqcHHNVI9IyUGU+guOhCHaQUnhO558G6pEob/G9VZEcvMqkvY+vfecevpQTv9t2LgWin21vSmZ1BC+li7VQulccKdwMWxXJzqe2IJnpm9Yd8eTnJCowe2Lg7aHLZ/S5lK5zPaPvqii3TspdLnkHZsOM5WQrF+O45h1Dh2t/OTC9TO8uNvMBsf4uiBEW6+dYu4orxdbXHBvpfuyZD/8WXqtFohoZcX/8z3QbpLfujHL5QIu0KZBOGYGZTe8576iMa3pncTy2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k80kKPHnuHFSXdsuem+LXI4qQAp3piq6SXosD3N/5CM=;
 b=CAbPYCueR9DWoCUEU7INeTvMB39USh655bBmhXAtjtWN+F0FiArB2cSnZFApjweFbOCCMfa9hxJaCB+kX47Ak5hAngpsL8tsaNPsY3IPIcCwhlkh/J9hqdX2Zo+KTmSo4K7l6pAnMVAkN2EtQTtXG39gMryu12buI+CYVMbnUVVpZFSA9JQid2RKpegV+b6l1GSEyrYWV6s1TshldPIcazUhMr48Qu0KG9BeUK2s29wW6jE4FOiTsSQG7FnNlmgnUor84e05Z2xTxp5D/LYQg9PaDgf8QGy+OZTaImuRPRRIDCuZh4rUDbJaP5jvaQQbpYL+MBXO+K1trzcz/noxHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k80kKPHnuHFSXdsuem+LXI4qQAp3piq6SXosD3N/5CM=;
 b=Y//avTh4jpEXJ2CXXqrHneVtGh52ocGlDt+gt1DcSsL3gJ26NNhiPdJuJ/6WZQlTiVbXmU5SCmOFAQIigYpdFFWn5GlNRh7+gksJ3ziMnA1OsvKBLzXd9fEWxFkvmGR7e44ryNAUY6auaLNT0sB3+YmixjA+Y14BHO9osErhDio=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 SN7PR12MB7275.namprd12.prod.outlook.com (2603:10b6:806:2ae::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Fri, 3 Jul 2026 18:05:01 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%2]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 18:05:01 +0000
Message-ID: <5a948f03-5912-457b-9240-88c14e0a5077@amd.com>
Date: Fri, 3 Jul 2026 23:34:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] ASoC: SOF: amd: add base platform support for
 ACP7.B/7.F
To: Julian Braha <julianbraha@gmail.com>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
 perex@perex.cz, tiwai@suse.com, Basavaraj.Hiregoudar@amd.com,
 Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
 mario.limonciello@amd.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
References: <20260701095759.1012929-1-Vijendar.Mukunda@amd.com>
 <20260701095759.1012929-3-Vijendar.Mukunda@amd.com>
 <cb450caa-58d6-465b-a694-bbca3949e3be@gmail.com>
Content-Language: en-US
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <cb450caa-58d6-465b-a694-bbca3949e3be@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0064.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26c::14) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|SN7PR12MB7275:EE_
X-MS-Office365-Filtering-Correlation-Id: fe5d8bea-11c0-4b96-517b-08ded92d9a13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	Cj0u+tMv7ZN5UlYqhSCqleW8mEpAswjBgzHEHRz2rdqh8VOCnyTNU/ap3exOGCEe4FTSSm6ozhxO7Bh9iKrXozQZD6LjdoBsgHLyMNVq6arPNfKpB2mPbCibMx7Mjk+6+DCu/sUNzkIMcbv8a9bQLujAiMG2wK2VCelh4QbXxtrR0H1QO8R0S2sqT1iU1hw4goIh43jQSBsFb+P0f/T5+SaKVUATHxXYReNZOSP7PMOMOW2eN3hFZaggPz6xg/gDaP3QkU4XFd8ekvjTTMEWTVc2j5MYNe5yY7tKD/hbvCFO/rVQCX8HHBhZNjsXiT4IZ3i4q3rU1SjdPE6Qv7WAuhz1bytk3qK5IEq7xAlHRNA/MvsIVd+RpZdXgLfJgKEpiisQlM22dCJrv9GX/DY2bSH1nnG2nJHZGd6o78kwkqWSFjBYvVqE3clGnPdOgif2OzqhDnGhF6S1EKUnReqpuAQrL9JvEFUHilszWsLkHUdhAuHb9WjvYQ50VSkSWvM6Yj+RfBvvDZpMwg+uTz27li3VpSEwTfo9DVkR/cs+m5n2RwYXjMhZxyUiTD4pB7tjBSI9iT8KIW6q+b/fHpxkiWk8QGABu6Q+dceA2V/O4xJWDEHBqn9e0Hf1uHwgE0xDhKRwvdNWtBRUCMQhxq3LKE9z8aX03tpTQtbcG2/mrN0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9567.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TjdJWi8xcTB0VjJURHgyTzA1UEkvVVNBR1gza2hRMDAvZDh4amhwb1dLNzVp?=
 =?utf-8?B?V2gzbFAxbWQxUUZLK2wzYlkzMTI4bkRmNDJLK285RE1GeUpJU254Rm5oWEcr?=
 =?utf-8?B?RktINy9tVGFDWXVhTTVjRys4WHVGVnNGOHE4QnA2OEZDa0NxMWxtOEZWR2Vn?=
 =?utf-8?B?VDc3MWQ1YjE3VG9FcTJHak9BcXRmR0NVb3craDU3RE1ISitlNnRKd1pSRkh6?=
 =?utf-8?B?V0N2c2RHRmhGY2s5RzFpK1RveTlFUU9iaXNaeWp4MnlZaHBDemVkbmorK09B?=
 =?utf-8?B?WFcxMlNMTEw1OGdGNm1XOFVrNHNZc3gvUXZaZjZaMTlzb20vY1g4a0N6b1Ay?=
 =?utf-8?B?ZGl2YXBpbGJFUklrblpoWWo3S0pBUGJjSTFaaklNemRseTk0ZHhFV0hMdGNu?=
 =?utf-8?B?NW5mZ0g5VStiU2dGc3dMYU9seWJ3MXA0WUJOc285ZjJCa2RHcDBzZlkyQytJ?=
 =?utf-8?B?WlVGdy9xcS9ja2hYc2FnVytWaVhqdzBNbndKNWV4dllySWhZVS9uZ1JmcDhs?=
 =?utf-8?B?cmRjRWpWbGNGMzNlcVVHRExjVmJ5NFJ4VmYxNG03V1ZZdXQ0VTduMG50UUpK?=
 =?utf-8?B?bVpwV3g1U2JBV1J6dDFBR0ljWUpZTHgxR0pLc2ZOdHZqR1Z1WEYvQXFZRDJi?=
 =?utf-8?B?RzFxTVlhbVhRc3F6Ti9SL3Jja0xrRWhkT1BQOGNBR2JNRDlTbWJTdHlWT291?=
 =?utf-8?B?Y0pNZmloOTQ3dCtWSisrQ3hKREw4SGsyQU5EK0YxZEVyREdHWU1EbWZoSm54?=
 =?utf-8?B?V21VY05ORmQ4UmJxNG1aVmZGeWhzZjJYMjNYZUVNZ0d3c1hZdE0xbFREb254?=
 =?utf-8?B?TmhKamhBRVh4Vkh6L0VNS1FJTnVXd09OMC9oMWRSdGVqS0dFMTlad0VRMjZv?=
 =?utf-8?B?a05KWUdPc2s2cXlkVDRxR0ovOXRBdVlwdHBQTW1XZThpakFiNllueXB1bnly?=
 =?utf-8?B?aVBBQ3J2UWQ5ZmJUaFBwMllvbjFRUGpHRC9jdW5NS252SHRmeDNqcEE0WWpU?=
 =?utf-8?B?b1RzTko5K20rWmRVc0V3UXk1NDlrOHlqYWl4L1NkbTlLZ0phYitRTmVWMExz?=
 =?utf-8?B?MjhIaVZFUG5SRitVSGxRM3RmaENyK1hrVTZIVFhWR0ZOR3Z1WHlLUW9hVHBE?=
 =?utf-8?B?VFVqcTVWeGk4SDNZUW0yNEQ1NjhacksyLzdtK01Dck9jejdMZ2xEbUFtWXZU?=
 =?utf-8?B?WjI2MzcyYzQrVEVMbHQ0bGQxM1VZOGNTZXlyc0loVnpnUTJKcmVUWWlYODRr?=
 =?utf-8?B?MHg5VTJNdXlNa0Z6eEdsY3gwMEZ3MUpZWGMrYkg4RG1ldGtiTjM2NUJUUTFx?=
 =?utf-8?B?VWdyV2xyUnJEMkM2WTNQVnVyOG9IUHRIeVpyaElRR0FYTDhLRTlZSUZBejUy?=
 =?utf-8?B?UG5DSWQ5MEFuQXBzY0M5MTlEdlRTaXZoVTNhT05wT21iVHVUS1U3NSsxNllt?=
 =?utf-8?B?TUh1UHE4WHBOVjRVUHM5eVE0WjRsNFFoMmVMRkUreDdEQ0V5dzU3dzFMZjdH?=
 =?utf-8?B?dlJBKzd0TzRuM1lQakVNM3AzU0paMG1jVE1yMy9XZHd2b0ZkdzRlQnVPVjZH?=
 =?utf-8?B?aG1Zb1JpN0pqNy9qMmxLcFFYS05wT081T1JNaDZ4dEZYaXRBRGlPaHE0Y1R5?=
 =?utf-8?B?cUVzbVJYNnBJNUZRVEhPZENXSGhXa2wvTzVaem5hbkgxSjl6VXJTSU5UVzhT?=
 =?utf-8?B?ZUlXaXpoNUNndUIrSi9nYjZxbTZjSUlrL3oxM1B4VEc4b29wdWJFaVJuMkJS?=
 =?utf-8?B?V0lRbXBoNTR1cEtpTVhxZE9hWklCVkt2cGxYejhkK1hkMzFGRmRLWThZV1N2?=
 =?utf-8?B?SGRGdk5qamU4cEdyM2VXVGlXaFFpV3VBOTFWcEQ0ckJrOWdaTkZueW9ubUEw?=
 =?utf-8?B?L2kvaEFpVjFGSGRzelY5L0NIM1hXMkFYT2hMMUhlcHNXVDQ2a05KNVpRbC94?=
 =?utf-8?B?c2w0UHcvZzYvaDlVNTJBVENnbzRDMVRUV0ZPdG5jbHpESFgwbTJhN1UrQkhR?=
 =?utf-8?B?WVJzVG1NN3pTeGdiQkZBZ1FxcnlNL2RBSXhva3FOa2hXcEF5MGtUUDJVQ3ow?=
 =?utf-8?B?ZitSdkp5WjVmeTkzTXo2ZTYraW9rMytkTHZNdW1GVmgyRFNhaG1sbTlpcUgw?=
 =?utf-8?B?aXZXRHlRYjdmU1Y2YUlvS0hhM0N1a0ptUXdyNVJ4MU52bVhtb0dTSkNqaEw3?=
 =?utf-8?B?bCtSNjRWVlRyRFVoRHFVSndtNnM4TStlSThKaWxHN3JwMjhuWTlQQ1ZmRmw2?=
 =?utf-8?B?anNKaHI5V3Z5dVpNNmlRS3ZROGdOaW1jbjllTEhYZ0VXa0ZmYTM2NWJyaUlj?=
 =?utf-8?B?Q0VnOUVFenU1bk5pWW84Ri84ekp4UHFhSXM1Q0RXSXZWemJqbEdwZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 fe5d8bea-11c0-4b96-517b-08ded92d9a13
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 18:05:01.7834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 wgWmdaIrYUkNuCwEOBYcqMpFIgE3lojeUmtAJC0iAMEuYMAW7+HJPMw+HP6J/7fyXrXB2ieZ3zZQ/Di5Q4ioSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7275
Message-ID-Hash: 7YRPJ5JFT2FNAQ6ZXIXNH2D7MFBSRSRY
X-Message-ID-Hash: 7YRPJ5JFT2FNAQ6ZXIXNH2D7MFBSRSRY
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7YRPJ5JFT2FNAQ6ZXIXNH2D7MFBSRSRY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 7/3/26 22:53, Julian Braha wrote:
> [You don't often get email from julianbraha@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Hi Vijendar,
>
> On 7/1/26 10:55, Vijendar Mukunda wrote:
>> +++ b/sound/soc/sof/amd/Kconfig
>> @@ -103,5 +103,15 @@ config SND_SOC_SOF_AMD_ACP70
>>          Select this option for SOF support on
>>          AMD ACP7.0/ACP7.1 version based platforms.
>>          Say Y if you want to enable SOF on ACP7.0/ACP7.1 based platforms.
>> +config SND_SOC_SOF_AMD_ACP7X
>> +     tristate "SOF support for ACP7.B/7.F platforms"
> All of the other config options in this kconfig have a line of
> whitespace between them, could you modify SND_SOC_SOF_AMD_ACP7X to
> match this style?
I'll address this comment in a follow-up incremental patch.
Unless additional review feedback necessitates changes elsewhere in the 
series,
I'd prefer to avoid reposting the entire 16-patch series for this 
standalone fix.
>
> - Julian Braha

