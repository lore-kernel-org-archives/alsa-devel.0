Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18FC1CA5FCE
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2026 06:37:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4ABC0601C9;
	Mon,  5 Oct 2026 08:37:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4ABC0601C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791182266;
	bh=WFJ/hNchyayAdkqr9G0lncaZrmnhrfoh1GzmsyEZFrA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=L0zRofYc1z/HlDLOOpcvxQkpRs+y2EX0kAjtpZpc6OZjLeEbTUYbv1AQfVng8SHCo
	 4KimjtVYIBUYJ2e1hS+rE3JRru7sQomUD5jG1jZhhHwEIbkYG5LhiGVlV1D0pdIKGl
	 +e10lrChLtmjueegV0Ow/PQHIWukGTqtHbOEZj3s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 08C96F80600; Mon,  5 Oct 2026 08:37:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0AF07F80601;
	Mon,  5 Oct 2026 08:37:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 902E5F80588; Mon,  5 Oct 2026 08:37:05 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.27
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791182221;
	b=a3eftH62TTtK1HS0m7MEPn9P34vtbtEMGDU74iFvNbB6BVQAJMOVRNtQ1E4zSQZ0DZJA
	 t8crCc6018eN5sesQGDui1Ku5VaE/RRDM4p72w6pMi6Tin2ePxbL3hfDsBGiS4ozyRfzA
	 iioUMjHwqeV8BqIjafM79ny9wa1br4ItmUi4B43TQTmRiKiQK759blbcFe5mRDlSXiEDq
	 wIIZSrGbCy4ONdB4mBlENkCfaIjCuPKe2ga4E+57Crsjnzyc3BJvjNj7F8/QvSD/1k7VM
	 bu728A7DNMwSUOG0/lV3+Imn/Hmy/dRsa/VfEYWPWYTJSBBT/O+svSSU1+qgbtbnwLw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791182221;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version;
	bh=WFJ/hNchyayAdkqr9G0lncaZrmnhrfoh1GzmsyEZFrA=;
	b=f4iL/EAWQjLREcbPwEzaWdKoTNL9XZlAjGNFa0Esd98AA7PcI/7xwAwefC8l8G0oNKAt
	 stZ8yj4H4qCPA/h0vNi9Qqin649sIQXGVisv+t5ShA22ZqGy0uCaErIn31xk5O+v8II5z
	 kgHk4foQQmlm0v5XZ1CXW1o+QE5OUVY0sy1TZgPjenLycuAaE+DgZMG02E/oDScrCIuah
	 vKs+H9F30AQhed+ZSHFvLxNzGvLuEb0vzC2D0X928aQQQevN1UGH7YO6STdcYaWPYteAU
	 C47OEBCDhscr3apLQWW1YpUBkDxpjFsDfvZ2uPQQCx7VtSVHZycAkVo+cS4dtPleHaw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=GlSryMbW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.27
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012027.outbound.protection.outlook.com [40.107.209.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 44AFCF8007E
	for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2026 08:36:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 44AFCF8007E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=GlSryMbW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGj47QMsUWKXKehlrpMcHKVNKVFMIFWT6RG6ZAhqpJ7mXYOkpFCgMJQh2LM/GtUJVBMaqIWH+nhB7u13BQpgccs+aJfla2FTXaq+cddTtbK6KCggUJQHOknBVLahUB2mpCh+UlefnFbtcowHse2B1lvxP+mxgjVMA9mPc9T+mI15qrYBYWs9TwOeqP/5FLvEcIiTy4hELotVRjEVInSn/BdtlJEyIFIfmYTdBZYSqfP7kxKxDk5KLIi/0f+/LXzi7e6bz4Abj+u1Tvufeue9f8jYK/myNiN9Ves9iWrsiR1ccFm9UYlnXNDARqRG/jCnBN6RhwB7j5DpKDqGMeCOew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bd5y7oM2gOMXumzY218jnOUwVETmdZ8zRAy0FfU5i3g=;
 b=ck7qHdcmRS1quAzxgNuryTlZLe87BKA9hV29BJGEkHkBp/fJoJ15qg7v1gFChpzdoebcP4yMaPwyoDGHrEb9BaLd45iuLVqgfH9kVlU/ocpuMCiEW47z/TVSB5z77JQG1FJV1gPH/+80W1AmIcHCNaw+/5XvWWW3f12e/o9ltyaAqZpPYdTa34u3zAXcw64z4l4zVfaKDLJBnsxWnim2XuSaPSdhfcClRKr85lkelYtizJ8L2c53ywONUeInDAznsggRLlzTHdv6Xkxm/PsEGp66IuNwL5GAlhaYGjrqZmzADUF8sE1vvZDGabbLO9H/jplM9j+YZ6WfqM3K2ang7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bd5y7oM2gOMXumzY218jnOUwVETmdZ8zRAy0FfU5i3g=;
 b=GlSryMbWVi+4KbJl7q1Jk68Upc6ZXiS38/AvDGUSAuA5pIo7BTH5gc5iNldx1MktAAIY1DB3+AgtkbQ0i4Ir4q4MAwfzPU3EfcDGqpxGHwf4OVC30yCEIi9FBYToNMgXglrNfH9jbWyWMvtoXkGRrPPDSTES6aTV3tOb0Azf0sM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 PH0PR12MB7096.namprd12.prod.outlook.com (2603:10b6:510:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Mon, 5 Oct
 2026 06:36:47 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 06:36:47 +0000
Message-ID: <6e630839-4c20-4b77-9959-d4352314e3c6@amd.com>
Date: Mon, 5 Oct 2026 12:08:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] soundwire: amd: allocate sdw_amd_ctx pdev array
 dynamically
To: Vinod Koul <vkoul@kernel.org>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org,
 yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
 venkataprasad.potturu@amd.com, Syed.SabaKareem@amd.com,
 Mario.Limonciello@amd.com, Richard.Gong@amd.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260917090407.3828816-1-Vijendar.Mukunda@amd.com>
 <20260917090407.3828816-4-Vijendar.Mukunda@amd.com>
 <asC0VC--CaFMJ_ow@parshuram>
Content-Language: en-US
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <asC0VC--CaFMJ_ow@parshuram>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:274::15) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|PH0PR12MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fc03c8b-0867-43bf-22be-08df22ab0771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|4143699003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	N3QZXdMjjVQIzxYuDtJc+4tIcYsLaGFCBE3NZwL+YRW9qbIbk5qk5WdhSV9bzc2Xt9ISWLzz9kEr/NiJMG7pnBuCLNGLtTtXDfFc1roW6XRMdJDu4EP4s6CE0EwFZMp/m1go3T6AGhkD4Kf6CRAOBKUFn4bQSn8GvVw3hdD1Vm+fUbZME4KlPOgawtphBfkcYcMUUWzz1wQDEBReAa3poAgXxH5U95mSoufR3UOA7KYn97Q+mBKObVoU/p09AzSqNW/XjYoqQbneDxPA72XE8pmJP/PFW1eiQv36w+FLHPJV7rH0iRQtRDV2/0A8J/3vm0rNLRW8LR9UDUrvbX4ucoTJwHSgHiPv8VDyMbra/NHFvovEphzP1xGf4h9+/1KTakTKX98/zJ5Gn3+a9/tmsHiyge5vyoopfgXoPRxGh0YNSPYYpgrKKiHhGbrI0A/MAJp5WRMHJCnEw5AS1FxL/XZwSyxVW5xtDbl+Pf2fwXnHIwrvYH6OuRoC1KtzOM3Td+qF/PcWlKSbv/C2brBHGnPw+xWKwCUnCIM/ccaXu47yFNpa+eATy6AeTto6aSxcl5ppkbfJyCZJwn0kdDShBOvCUxojmgNfmevBZeJ5lShaR9ZY3jCIDfs79w8G/J92HO0BDL2azag6OrRZyY93f7SyGOBjyL+Gv1IxWwwOU0w=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9567.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(4143699003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WFpHeU9yNE1XcStiMkVkWUFIbVZqRXZMQ0wvUERkU21UTnNraUk3aU9nQmF5?=
 =?utf-8?B?cHhVcHBQY3VWOTQ5S1ZPY0dqWlMyS21Ma0ZCWUxLVG9pRFJvOW01Nll1THhN?=
 =?utf-8?B?c0NBaGtYYjdKMytSTEwyWitIajE4RkpheXdiVFJrQTVkTjBwTUZJSHpoWDFk?=
 =?utf-8?B?YlNkWFRHZkc4dlBFbGxtaHBtOVFQeG5CSlVYR1U5emg1a0NMd3Fucnhma0Zv?=
 =?utf-8?B?N0txWmJpaFBOcThFQkpqd0ZLRTdOSG45eW9tNjlPM1ZoRGhLRDBVU2JOOUtR?=
 =?utf-8?B?emJFOHhWaDgwc3JJczNUUnAvK1ZVcExES1NxREhyaVVGVVJWaVJwU3hyd1FI?=
 =?utf-8?B?by9SQlhkejVPWkVERTdKOEVCWE1LbDNkRWNTb3ZPcUJteFEzSFVKN1BvZndt?=
 =?utf-8?B?d0FsMTZtTnFTV2dDamZKWGk1c3UxTi95cmFuc3U3REtOMUFTSUZGclNSTVNS?=
 =?utf-8?B?QWlPRnJ5Z3BrakhSUmhGNng4dmJEc2hMQUx1RE1wU0dzdzJMRjB5ZmttbXoz?=
 =?utf-8?B?dVZiWVdzWlF4N0ZiZVNQaGMwTkJ0Sk1ManpURVJwSzlIS1hUbWpJTW9UTXZn?=
 =?utf-8?B?d0pzRkluWGl1Z2wwZzJJY2RZYlpGZHY3QWxPWUtETmtLYUJRQ1YwQ2hOV2I2?=
 =?utf-8?B?N2YyRXZza0JYUng5K3dUZkp1Zk4zRjFadW4rVGs4T3lXRVFMNXl0TXBLY21O?=
 =?utf-8?B?UjdGSmFQRk1OeEJzb2pCdEw1VFAraFBjaXUrZVhuM1VyUkVLN21XSjRyZXEr?=
 =?utf-8?B?NTJZd2hxOC9sWU82N21VS0p1MmkzdG1NTzFKb1RnUEVEc3hPSVRzV0lzbTNX?=
 =?utf-8?B?aGE1VFpUdWE1K2VQM1htTmlMeTZTZ3EzeGRCOGRxUDJZcDZUK2xvOTN2Z3hp?=
 =?utf-8?B?aCsrRi9kTUFXVWdtTUNlSWpyOEF4R05pOTN4ZUxnYjJWR2tBbnlLS0FlQzdl?=
 =?utf-8?B?VEt2MnBkUEJmRG5LLzNrQXczaGZ4WkRwa3ZUWTBoMnBCaVJMd0VZNXVFaERh?=
 =?utf-8?B?Y3NSV2pkb3hzclg2L2ZmYU1ObEQrL1htQVN5KzFoeE5vWFAxQ09SaTZzS2Mz?=
 =?utf-8?B?RkRBU1pKc05IajRQclZLUVl4RTZVczJvSXhXMzNuYUl4UGdyMEFIRTBuZjZj?=
 =?utf-8?B?eVE3T2NhSjNPRlc5Rkt4K2F1b2k5dmEycXJOREx6NXpUUEZiWmV5NGhHM0xu?=
 =?utf-8?B?QnZtN0hsR05mUDNES2U4RWhheDhZRSs4MW9iakM3NkwyUDRUdVRlKzZyTkRP?=
 =?utf-8?B?Q0RyOFRTMjVuVGZrM1N6RGJmaC94WUEvRnByYmg2eERqSzJncmpjN292OVpp?=
 =?utf-8?B?b2tDSTFzSHJWSURkM0NEQmM2THcyZ3BtZEp6LzZBMUpwOWg2clVOeTRpcm94?=
 =?utf-8?B?MzN5Ty9ycTNvT3Y2dFc1MDhmS2ZwYnVSRkw5Yjh2OVNXVjB5ZkI4TjFuMm1N?=
 =?utf-8?B?SUFHbkthM3VUejh3Q1FtaEtuR3JFRHVoNmczWWRPZytwQ0tMY1h3bTFyVTZX?=
 =?utf-8?B?YTY0TG5FY011V2VVU0RPQWtlYXJYMzdHN2JVaEhoaWIzYTVnTkgxZ1Q1S2dM?=
 =?utf-8?B?QmFGRWhHRndMaFJJZWxyZ3gzWGd0TUs4RVVPb0FhMFhPVjNXbUJPN2dXeXNL?=
 =?utf-8?B?S0tlUDdZMDVkZC9YTzlIUDMxdWVwZUx0d2R4S1JVTW04Q2RoanZoNEhnWFc0?=
 =?utf-8?B?TXQxcm1RYWQ3T2xkY0FQS3FlcWFXLzJIUWZsRkRydmpyS3prNm94Njh6MTFG?=
 =?utf-8?B?UmFmVnJETmEwYVZDZndmODdCc01BeXhhOTdaaGlxWWtmTmJheTJKNGtyNlZo?=
 =?utf-8?B?RzdLdG9TN05hOC9odmkzZEpDYlk0MUJZZVZxZHNOVTBzTkNHK0JuYkR3SlFk?=
 =?utf-8?B?ckthTVlEZ3N1VHFuTHhhUmpxL0FYNUdsT1hwSzFFRVVBc081ck43eE8vbzl3?=
 =?utf-8?B?ZjY3Vmo4WXlueldVQjZsVEd0cUFVd0pQcUkwb1VpVzJmc2FVUHJZdmQ4MDRh?=
 =?utf-8?B?MWJJK3V6MmxYSk9tVkpOZVp5clpkZUU5MGdaVlBQVkU1NGN4b0Z6RENXdTVV?=
 =?utf-8?B?LzNOdVh2ZnVMQkFDYkNGK0dsSDVsWmtLN0hSR0FSdUQ4Z2xXeEYydnVhVExt?=
 =?utf-8?B?Y0tETXhJVkRhTXlPbE80SzdlYTYzdUh6NXRscVBpWlFVeVFHcWs5b1MwZGlT?=
 =?utf-8?B?bTFRSHB4OGo0bTBXdU4yemxHenRxR3J3ZElwbmpnMWxUaUYxRmlNOHVYMWpG?=
 =?utf-8?B?Y1JUZFBwS3FRc2RNQVlaOU5Lcnc0Z0Q1SXZ2NGU2NmFNbC94ZnhlUUl3bHB6?=
 =?utf-8?B?bDVPSGdQMWc5MERCdENGMGJTSEZjc2Z5Z2tRekl1UjFKK0Z6QThlUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 7fc03c8b-0867-43bf-22be-08df22ab0771
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 06:36:47.3051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 g+UILUJ3HucQKyC2FUd2tvrgRgMY1tOdDQKVoa/13BUVcDifwokoiHr3t2x1IRQoMkQqHqg4orADecVCvK+Cxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7096
Message-ID-Hash: DFCJRPMVLIGTCY2472JRRX37JHCBXS7E
X-Message-ID-Hash: DFCJRPMVLIGTCY2472JRRX37JHCBXS7E
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DFCJRPMVLIGTCY2472JRRX37JHCBXS7E/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 03/10/26 13:22, Vinod Koul wrote:
> On 17-09-26, 14:32, Vijendar Mukunda wrote:
>> Replace the fixed-size pdev[AMD_ACP63_SDW_MAX_MANAGER_COUNT] member of
>> struct sdw_amd_ctx with a dynamically allocated pointer array. The array
>> is sized by max_manager_count via kcalloc() in sdw_amd_probe_controller()
>> and freed on all error paths and in sdw_amd_cleanup().
>>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> ---
>>  drivers/soundwire/amd_init.c      | 12 ++++++++++++
>>  include/linux/soundwire/sdw_amd.h |  2 +-
>>  2 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/soundwire/amd_init.c b/drivers/soundwire/amd_init.c
>> index 15d117172bdb..94d766b3f8af 100644
>> --- a/drivers/soundwire/amd_init.c
>> +++ b/drivers/soundwire/amd_init.c
>> @@ -62,6 +62,7 @@ static int sdw_amd_cleanup(struct sdw_amd_ctx *ctx)
>>  			continue;
>>  		platform_device_unregister(ctx->pdev[i]);
>>  	}
>> +	kfree(ctx->pdev);
>>  
>>  	return 0;
>>  }
>> @@ -116,8 +117,16 @@ static struct sdw_amd_ctx *sdw_amd_probe_controller(struct sdw_amd_res *res)
>>  
>>  	ctx->count = count;
>>  	ctx->link_mask = res->link_mask;
>> +
>> +	ctx->pdev = kcalloc(max_manager_count, sizeof(*ctx->pdev), GFP_KERNEL);
> why not use managed api for this?
The reason devm_kcalloc() cannot be used here is that
sdw_amd_cleanup() explicitly frees ctx->pdev using kfree().
 
If devm_kcalloc(res->parent, ...) were used, the allocation
would also be tracked by devres and freed automatically during
device unbind, resulting in a double-free.
 
Therefore, the existing manual alloc/free lifecycle is
intentional.

>> +	if (!ctx->pdev) {
>> +		kfree(ctx);
>> +		return NULL;
>> +	}
>> +
>>  	struct resource *sdw_res __free(kfree) = kzalloc_obj(*sdw_res);
>>  	if (!sdw_res) {
>> +		kfree(ctx->pdev);
>>  		kfree(ctx);
>>  		return NULL;
>>  	}
>> @@ -127,6 +136,7 @@ static struct sdw_amd_ctx *sdw_amd_probe_controller(struct sdw_amd_res *res)
>>  
>>  	sdw_pdata = kcalloc(max_manager_count, sizeof(*sdw_pdata), GFP_KERNEL);
>>  	if (!sdw_pdata) {
>> +		kfree(ctx->pdev);
>>  		kfree(ctx);
>>  		return NULL;
>>  	}
>> @@ -134,6 +144,7 @@ static struct sdw_amd_ctx *sdw_amd_probe_controller(struct sdw_amd_res *res)
>>  	pdevinfo = kcalloc(max_manager_count, sizeof(*pdevinfo), GFP_KERNEL);
>>  	if (!pdevinfo) {
>>  		kfree(sdw_pdata);
>> +		kfree(ctx->pdev);
>>  		kfree(ctx);
>>  		return NULL;
>>  	}
>> @@ -171,6 +182,7 @@ static struct sdw_amd_ctx *sdw_amd_probe_controller(struct sdw_amd_res *res)
>>  
>>  	kfree(pdevinfo);
>>  	kfree(sdw_pdata);
>> +	kfree(ctx->pdev);
>>  	kfree(ctx);
>>  	return NULL;
>>  }
>> diff --git a/include/linux/soundwire/sdw_amd.h b/include/linux/soundwire/sdw_amd.h
>> index 40ba84c3b2cc..476de2c30389 100644
>> --- a/include/linux/soundwire/sdw_amd.h
>> +++ b/include/linux/soundwire/sdw_amd.h
>> @@ -139,7 +139,7 @@ struct sdw_amd_acpi_info {
>>  struct sdw_amd_ctx {
>>  	int count;
>>  	u32 link_mask;
>> -	struct platform_device *pdev[AMD_ACP63_SDW_MAX_MANAGER_COUNT];
>> +	struct platform_device **pdev;
>>  	struct sdw_peripherals *peripherals;
>>  };
>>  
>> -- 
>> 2.48.1

