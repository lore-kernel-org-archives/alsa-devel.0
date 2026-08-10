Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2765C5AC82
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Aug 2026 05:38:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0DCBF60203;
	Mon, 10 Aug 2026 07:37:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0DCBF60203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786340286;
	bh=KkPohPNzbTMRio5usFs9G6tvzMVjjVIh7n5BCI7t1Og=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=JMM54F5WBM2YsHA4qOwMM56+ViZZix1XCAgmigRY7V0xy7uxClr+vMX6wo9dJGg73
	 JW+KaKk7TmDSWXwkFChIAGwRrdMUC5yHbyy9+lHcxvclgxVeUXUBJWDLELPkZ462ur
	 s8lWcijWBN7Q8IhHMcf5/A/xCPEFe9XN+OBbBAFg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A3698F805F4; Mon, 10 Aug 2026 07:37:32 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 22EF4F805F3;
	Mon, 10 Aug 2026 07:37:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2336CF8051F; Mon, 10 Aug 2026 07:37:24 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.23
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1786340242;
	b=oquvGQlP+GYOI1UmIrktC88m16U77E1/dxETL++ndvc3BAP6WxiCeEzq1aehPqu6yXEO
	 zKx90ct52TUf8tou7qfS42T8S+YAo9R0YCeiBY1nZpMUJcE6e3FzN2udnkCJF1BVlPFVf
	 gHuiiFxx1JieGPBuACmooont+85jBGJm/q554wdr3cInZggXiaQ1OLmYBVYnHqbKp1LFV
	 me3kx9Eca5K63n17H2str90yQZ1d9nHPgG3xr5MYhDgurncVfpP+IblwB7cVk8VQ5qr6b
	 BYrkEEAVqiQksNTeU1AhHAZvdT8Kh6bfGV4mMTw/IHZHOWXn3fhKvqNphTwIe30ADHg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786340242;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version;
	bh=KkPohPNzbTMRio5usFs9G6tvzMVjjVIh7n5BCI7t1Og=;
	b=hL+wlIAu2jLQPhhZ4yerlH9ObcuGvyFP/9Z2a6IiTVjTrTxGS74p2eLpsYJrAtvddpJS
	 zmZzziB0OLR6JqXD7foVv4bhuNQE0/SKv/jBusT4XlNvz7WAdOA8KVajn4Dkg2mf6Awge
	 irsn6l3Dg7QdKybG3KAslrKw7be9YaXPfr3kTsYTwY7X0941ld1LtM/S/aQgSPPGvsgVx
	 if7qjXf/2sPur5ILhz4R1gcMQMBd+BzUIGzUi8TZzgnyfa2BF60G1OqEraLZ3UcJVByLi
	 k3mmcE49Y8KZiPrcIPuwq1+VCeYuqoobNRC7FsMSkdBaR0EF3n9/qhiiOSD8eu6jDKQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=gLhSIASk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.23
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012023.outbound.protection.outlook.com [52.101.43.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BFE70F800BA
	for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2026 07:37:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BFE70F800BA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=gLhSIASk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iK7auc1FmBVGjCrk266cMQrXMNqdcGC2ZPAy/QbF9l7vsueblj2oYM7eLwBm+wj7mYZhpRIeL+cjODBTt1JZzyFERkitgrceTXJ7HKDJvfw6Tj1Xd4C4fVKZwSE5W2CNJYYvlSubMuw4AxrKD9h9fgni6g9h3/owFLyZJ77ogsw22dLvoPiBLe92RQb1ddYdwUWZ2R4+46JTWMtmLlo0ddE925Y+uMGtGm2hzqwtH14ghFxTie0q3vbt4Ndh5dQ+QQwWgnhiWg6GAMYzsvX6Do69iQcJpIWq0N64jNYzCiqQQAC+piBkc7uWrixyhrTb936sxBIVfI3tbRgzdjHVag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CJ3jmcvwQc2aVM5TZmna2XBmXn5w74tKC5YWl+CFTo=;
 b=LagENH7eTx4rPEIOVZEeiWMt9v9BYlrPJLeGR38qtIX/eJwT347jWg0buvb0zrb7CPA13OsEMpgJc9GMEyhlLs/dWzl0Njt/nehefApU8eHnCUgWHhdwM5Ku+1Jzjo6HqzoOhNOmmflhN8SEBLI4zRng2FWd0Di5I78s6zLW5W+m9SCpCDsL50gQhblAWBmQ+GARnpI8WIWr8NC01lc5gUEqHCJhdyNnhBjvEtcA8a3WOF14+pdZ5S5g+CU/A9BsMb09Gz7/N8Hrx8IUuvIxjx+wvCiKGmGP+ztXM71Lc8zKFH0msjC7h9uQyEva1p/1AR03+nkPEhMm0Gzk7sjbZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CJ3jmcvwQc2aVM5TZmna2XBmXn5w74tKC5YWl+CFTo=;
 b=gLhSIASkK6x+uCB33kqiY9rsO5AcFrfzI70nEESVUZHgq4iVwZ0txUh1gV1P6P/1IKUb5oP/5Ay7YaU4pDRBUkK0mfeXfDTKiuzsfkGNv8VyRVPq79kEk85F23lestjvkiUNiyoeha6IDlXNg8Pgoy2m9PdIPdOyj46glCdaAug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 MW4PR12MB6924.namprd12.prod.outlook.com (2603:10b6:303:207::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 05:37:14 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%2]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 05:37:14 +0000
Message-ID: <6e623581-664b-4d79-b9de-429b3b433472@amd.com>
Date: Mon, 10 Aug 2026 11:06:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/BUG] ALSA: acp6x: Add DMI/PCI quirk for HP 255R G10
 internal microphone (103c:8d22)
To: Alexandru <eraleexxx@gmail.com>,
 Syed Saba Kareem <syed.sabakareem@amd.com>
Cc: mario.limonciello@amd.com,
 "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
 alsa-devel@alsa-project.org
References: 
 <CAB-5r0nx0fxnvoYqwHHfuGMuXngPk_AuXa=Q2RjCun2xRpt5og@mail.gmail.com>
Content-Language: en-US
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: 
 <CAB-5r0nx0fxnvoYqwHHfuGMuXngPk_AuXa=Q2RjCun2xRpt5og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::18) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|MW4PR12MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: f80712ba-4a80-46ad-1a75-08def6a16ec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	BQBD/VupJ/TDVmydtn6RE/dnYo4I2u7pxt+4PcQyoIEDoMCgFOIb1R98CJbj928NYUHjbTIGfLiLHLHz5yqj8DWsuDHVakCeaewj5GJiqfDXgVMETVp2wWdhGr2ucyWaShQ/HK2Z+wZmOA0LHZ9boUlU51T4fDZRhGxEfCcXL4zb/Dx00CEm/tq7v/29yhcwrGAXzjiryPGDd8tN5LtHecdmrchCJ3Ny59Z3aEW7uHiAQL3FT3cpLegjHMbW06dRCVSNrYQI6BgZop02f6eWDvNTWsZvyKmTpJKVHu92YOh5NTPr9R6BIMZ83K/JXPJPxiD8SA/9eIt0yS9uhzyCzW3xtKxAHwR+SUhxaLF4/Qk/1HM4seRwlafL8riAhpQhkUA+jEABh4V6H0qvxzuZmJSBsdtwOu5AJ2CNsCkZHH8JXd+BCLPWCz8mr9KNG+4y0VnfHFnsXTEeU24VFdM22VfTGTzFWa4hl5a8kU1FyYHYstFkSqZGVmBApXmYpvud7Nb3wE/CYGsD6+9hcUBPTnYwiVIMm1CWtsUu3WOAOrDyGarTHkLPq2mYWqKCZBkCLFWYQnIuNM0YHB0kX+yH5kqGXeXRv5PJuP2YoH4lgC2jMhFCMNR0KPXZLDuMnle3+uEtRo8nuy6ruLe1s08lVyfdm8k2YfqOTfC88bn600g=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9567.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z2NscXFhdFNWNGlySGtYVkZYWE5kSWsrRFdwN3lKeUJnbU1JVndHdnVoNUxX?=
 =?utf-8?B?TFozMzhNc0llaTBGL1ZvckNNNmhVTEFyOVNwL3VGWVFPUVc5N2E4ZHk5bmNE?=
 =?utf-8?B?VmNDcFZPUWsyOCtsWThVSWhRT2YvWTFabzBnQlV6c2hEZWxTNjNZamVGYk5a?=
 =?utf-8?B?Vmh1L2duejB0bGhQd2hNYXVXR1VjNEFEalFlVmhlamVIcTUyRXJFZGhvV2tr?=
 =?utf-8?B?T3hkWmxqRXdMVStwWGZ5QmUxZ3ZIOUpwOFRlS3habGRQQUhrNkJIVWh3eUMz?=
 =?utf-8?B?UldOYXhSYWhGRlZGL3J6K21FU3ZUdzRlNStJeVRnK2JJL2M0alY2L0VGSVRY?=
 =?utf-8?B?bnArVUVQSWN4SnVZTFdITUdwMEo1Tng3ejg1R3BSWndvckhUVEhXOGdkM2Vz?=
 =?utf-8?B?bXZpK1lJR21icG56VENNdFdkbU1Qb3hGUjNxc0kzenFCUFQ3MC91K1BCT3JX?=
 =?utf-8?B?RU1USko3b2k2V3AwdndrQTJhMXM1VGJ2a3FRclVEQXM3Z2R5dDYwYmdNc0Jo?=
 =?utf-8?B?ZTJaVnNTdDQ0WVcwT3RIMTBXODgrbkw4Q2RtL2IyTVgyZGhNbzFHMXg5ckpN?=
 =?utf-8?B?SWtqR2tVTGF4NHZBb3NZTlF0QnFzZWFGUHBGaGg2ZlBhbVo0MmR3ZnBCd3NT?=
 =?utf-8?B?QXBoUTFRWFlxbnY5WVRaRkdTL3UxNEJTMEF0NnpEbXNlejd6eWRIbGpSelhQ?=
 =?utf-8?B?YjgwZmtxYUlya3dibzVkZzB6d2Q3dGNJekdMZmtiTVBEMEVmcXFPdDVkcWxC?=
 =?utf-8?B?a3AwL2V1aDRQSUpyeElCcmUzSURPNDB1TnJTcEluY2p1YkpNaERjY0JsWHRi?=
 =?utf-8?B?THpaZi9FN1UxbERWKzI5T3hRUjYreEtHUzMwTG8xcHBRZFgyenpqRmZyL0NY?=
 =?utf-8?B?S2ZHWktwbUdLOXpDTmdLc1FiZ0RBdEJLYmw5ekZ0a24yNWtyWWlBRG5QT214?=
 =?utf-8?B?QTR2V0RzaHI2bjVFbUVBSlF5dy9TOXNEbU5GdGVFMGlZOE5sc0loWUxoZGJR?=
 =?utf-8?B?UXNaYW9UZldRM3lYNjN0TVhlUC9KK212MFBQb0hBdWt6VUowaStzQzJjcTBG?=
 =?utf-8?B?a3RHMHBhcElmRUlld1o5YzRNY25od3hFdE1PMUM0dWo5KzFOckhtbkFNZGVp?=
 =?utf-8?B?WHZCNkJPT2ExUzVQOU5wOXVvZng2SGtjNWVpdVpJZCtCdFlrZm5FNjBxUUNq?=
 =?utf-8?B?eDE5dGphcHJvREJSRFNram9OTlB1YWN0aHVwRG1JcFFFdkg0WmkvZFhDODl5?=
 =?utf-8?B?d1JiUnBXSjJJMWN5MEZJd1pMSWthLzdISU41WjFvalB2UVRwRWEzNFJueVRY?=
 =?utf-8?B?QmNrbStCc2NSRXpNMUpYT0VEVThSRHMxSGM5bTdwTUh4Ymc3R1dhdDVjak1x?=
 =?utf-8?B?WEM5cVMxbzJvNmh6czRKclIxSHNFN1dGS1MrYjBYRzdvYUVPL0pvNHZ0R3R5?=
 =?utf-8?B?N0F3WWNpa1dSZGJVa2hSZll2dWxLcFp5ME8wYVl0TklSTHZYZWNmVllFUjVU?=
 =?utf-8?B?alN3NjFTNnZsV0dxRFFBTG9uQXFneEZYeVZMWFdJWjRtb3k3NllXbGQvckVs?=
 =?utf-8?B?b1ppdUhDTVpnNTlVMEhOdVErS3ZBU2J4Z05QeUVvNnYzalk2OWRnS21XaFBa?=
 =?utf-8?B?eFlwc0hMb2FPQzdzM0NFbWV5WFpwYjRDZys1alg4b3VXanJqb041eks5U1Ba?=
 =?utf-8?B?YWhRQWRXM2VXRlVMY0Nwa3V6dmx3VURyNkFjT2U5ODhuM1AxbGJ2SVN6aXM4?=
 =?utf-8?B?UHIxSlFHbE9vSVdraWoxSmZTUWdHNFR3bm9MQ3luS3E4ZGlVNFVPWXI5UnBm?=
 =?utf-8?B?djl4czBOQkt3OW53VWczRFdJU25ZazhzSVAvNUExNjNCMC9VMzBYQTJTVnlM?=
 =?utf-8?B?eU8vNHUzNHJuK1gzdEk2YUNVeEx3SkpLRFRkWlNYRVZFUFFrbDRXOEdXZTB2?=
 =?utf-8?B?YkVCRTZ3MkRIQU5BMDhXWm5ORjBLeFhxZ0R2UnhJT3h6NkpZU2xOakxORjRZ?=
 =?utf-8?B?RkNLQzNWU0hEZkQrQlpaTkdNdDJlZzlEVXRIcStQN2s1N09EQml5KzBvRC9y?=
 =?utf-8?B?QWt3eGF4OUI3aHdZdnF0eUE0WEtJa3VwaE5wcXY0c21SQ1FpVzhWNUt1OVNt?=
 =?utf-8?B?aU1uVXJoYXFqeVcrd0JUOGtuS1BIQWt4YTI3bXN5d2xLV1JqelBZaVFaV3VW?=
 =?utf-8?B?Z0FicTcwRE8vTlJ6MXNOdEUxejVOaE5xampQTmlUY1VQWE16N1QwczZ1VmVJ?=
 =?utf-8?B?MnkxTlZMUXFpQkR4UndiUXN6K0JPdHNPOCtkYlVUa0F4SWVvU1ZFd0ZiYmkw?=
 =?utf-8?B?R2l2S2l0d1NrS21NOVhZMlg4citFaTY4d1NFYW9uT3oyWitNVmRkQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 f80712ba-4a80-46ad-1a75-08def6a16ec9
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 05:37:14.5100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 YqP2c4hE3zXaBuPPbQhme4i6ddM7U2Aw1ONzDIMjnMpdAc3abYQC9Mi8uzFsdISwvf4WatAjsgCdGJiL0yaEWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6924
Message-ID-Hash: 3FKAHRWAAFAPBABXRKDOFYWWJVNJW35G
X-Message-ID-Hash: 3FKAHRWAAFAPBABXRKDOFYWWJVNJW35G
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3FKAHRWAAFAPBABXRKDOFYWWJVNJW35G/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 8/9/26 18:22, Alexandru wrote:
> Hello,
>
> The internal digital microphone (DMIC/PDM) on the HP 255R G10 laptop 
> is not detected/working under Linux.
>
> SYSTEM INFORMATION:
> - Model: HP 255R G10
> - CPU: AMD Ryzen 7 7735U (Rembrandt-R / Yellow Carp)
> - ACP PCI Device: 1022:15e2 (rev 60)
> - Subsystem ID: 103c:8d22
> - Tested Kernels: 6.x / 7.x (CachyOS / Arch Linux)
>
> PROBLEM DESCRIPTION:
> The AMD ACP 6.x PCI device (1022:15e2) is bound by the `snd_pci_acp6x` 
> driver, but no ALSA DMIC/PDM PCM capture device is instantiated 
> (`arecord -l` only lists the HDA ALC236 codec).
>
> In Windows, the internal microphone works properly through the AMD 
> Audio CoProcessor driver (amdacpbus.sys) using HP DMIC extensions 
> (`amddmicextt_hp_*.inf`) and is presented as "Microphone Array (AMD 
> Audio Device)".
>
> In Linux, the board subsystem ID (103c:8d22) appears to be missing 
> from the DMI match table in `sound/soc/amd/yc/acp6x-mach.c` (or 
> equivalent ACP 6.x machine driver).
>
> DMI / PCI DETAILS:
> Vendor ID: 0x1022
> Device ID: 0x15e2
> Subsystem Vendor: 0x103c
> Subsystem Device: 0x8d22
>
> `lspci -nnk -s 03:00.5`:
> 03:00.5 Multimedia controller [0480]: Advanced Micro Devices, Inc. 
> [AMD] Audio Coprocessor [1022:15e2] (rev 60)
> Subsystem: Hewlett-Packard Company Device [103c:8d22]
> Kernel driver in use: snd_pci_acp6x
> Kernel modules: snd_pci_acp6x, snd_soc_acp6x_mach
>
> Requesting to add a quirk/entry for DMI_BOARD_NAME "8D22" / Subsystem 
> 103c:8d22 to enable ACP PDM/DMIC support for this laptop model.
@kareem: Add a machine driver quirk patch and share it for validation.
>
> Best regards,
> Alex

