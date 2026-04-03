Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371BAE7E37F
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Apr 2026 12:13:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 03FB2601FC;
	Fri,  3 Apr 2026 14:12:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 03FB2601FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775218379;
	bh=EUDHkExOpWqZLMCVAeoxLr/+YU5eJxT5gYMKrJjhQSQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=vF75TIp3wHBplUmpEAEl1fzTL+37hIT84jMbIpt6yE//rtC/wjrx/miV0ceQEp/wB
	 LDoMIdplqrG9Tq+b2cOAyLI2YvcWCyytyg3K1sqbGmyvagEX7fhwf78pF4RfN+ia/d
	 O4Hyw+cC2akY5wq5DthuWg+HWd/d9fB17+8TPiX4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 232C8F805F3; Fri,  3 Apr 2026 14:12:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 70465F805E8;
	Fri,  3 Apr 2026 14:12:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 37188F8055B; Fri,  3 Apr 2026 14:12:14 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010046.outbound.protection.outlook.com [52.101.46.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 31A11F800EE
	for <alsa-devel@alsa-project.org>; Fri,  3 Apr 2026 14:12:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 31A11F800EE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=WKbqYFTA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fBl6g5DqjmxBXbovz29KD7MTIuywK+ctI19DVTny/f05/qkez7LFO3Bmrdl+1f+EJRz46IIbcwZjgPEUcBErhCJgEgg+1PjQHbDLKV/hh4bdMzaSteeH892gPSBc/A0hl4RZLPaAOG7RaEYD/MNHfJcaOkrBUXq1HFFoW70NZ2WZDYpiah8nfanf/LL0MQdqXu1VasQLI/lRtQ0bFAgtIhkws8dchQ3Up6iE6cLJmqT5xo0NmuNh0cTGrwBWK/iiGYivr6xmxtRwEwK/pJpBjYBuhsi1P/Ipp+fF12M3Dglo6Z8c8C8ZOQ71s8mzyP+eLujo7F05wcCfePtQR5JXdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUDHkExOpWqZLMCVAeoxLr/+YU5eJxT5gYMKrJjhQSQ=;
 b=rZVOItwIdAgebrzYNJN+Qfk0k++ZeeAlAAiXemv5EjtX6UGOOpah+n1PvOcFiMdgEji2CD5MjONBwBWRh838k1G+k5EP+RO6X7zLksLWGheFLcudUgD/CVR1KRX+t8+tTaKWqXqeYfTdmjnt2rgeexBTAL6f6/ITzHTUjYf3YSK5pdE2yHcBOOIPZAzM2Xhn2wMtIT3V64mZMrUs6VrYezN3+okssn8iPdqUquK//vMzGQj8noJgwVjp2b9AVOU4PpA9ikVNG88slDKGoxIRPUEQ/lfNpEWvYx+w41bemkYDt0ZUR0r2LTddqFbrDk3nQTRUnwmXB8iN4GTcGCzA3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUDHkExOpWqZLMCVAeoxLr/+YU5eJxT5gYMKrJjhQSQ=;
 b=WKbqYFTAL6PGnUiECOETTDrnYYFK4UleDADaSSYj/cuUqy7fK+NNHqBgnTLoPXqRi0xYyUjAxiSVdk/DkQ4oKcblWIYFdS/z7XkGjVtqSyhnmbLOcsoSH7rMkxrihrR2CC8QK43GNneiYFJvRR5Qe9o8Ikkz5FQGcpDC0iWW1tw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 SA1PR12MB7270.namprd12.prod.outlook.com (2603:10b6:806:2b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Fri, 3 Apr
 2026 12:12:05 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9769.017; Fri, 3 Apr 2026
 12:12:05 +0000
Message-ID: <f4869b83-664f-438d-b8fb-a0e96da415c7@amd.com>
Date: Fri, 3 Apr 2026 17:41:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ASoC : amd: acp: Update Quirk for Lenovo Platforms
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>,
 Syed Saba Kareem <syed.sabakareem@amd.com>
Cc: alsa-devel@alsa-project.org,
 Sunil-kumar Dommati <Sunil-kumar.Dommati@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Charles Keepax
 <ckeepax@opensource.cirrus.com>, "Mario Limonciello (AMD)"
 <superm1@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Hasun Park <hasunpark@gmail.com>,
 Simon Trimmer <simont@opensource.cirrus.com>, Kees Cook <kees@kernel.org>,
 "open list:AMD ASoC DRIVERS" <linux-sound@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260403100948.678548-1-syed.sabakareem@amd.com>
 <fc7cd530-2199-4c12-af75-6ea17997777c@sirena.org.uk>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <fc7cd530-2199-4c12-af75-6ea17997777c@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0061.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:267::10) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|SA1PR12MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b626616-7dad-4717-b678-08de917a382b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	xxDIy92yLYpcT4GhrTxRPqsLn+WPYo2HMk42bavH2GouhaJtqXUqSogaoK3SfAopnXzv6TYCmvOvSDo8mccKQmzGSpnVUKzwUHCvKGsVxd350aJAQcQxJkFJztaES355CYOsBmIq7osDXnxjMZsNgBqTLcQXCEuHKRj2mSieOgFVv7uupnC8hxUbAdMkpJl04ElVbSdyk91qiFtlMiAdcZO6EkwC5CGIBfUsVcvPVIOp6K2C5jAaQDWrou+rt2PiC2xWaFi70cjCFesVJnGwUpUcILL1NlbHZAGU1Nzz4nWN2RBNBb/epbG/hFkCaHGZOXw27xAFXKAHlt95nIPtchR13oqLxhhqdCT6lrcUpTuLi2m7yyQ5Syo2NKzdJXWCfLMnustsldUfXgfWKREL/ZTJZ4f9Dj2ltkgkOgolqiOPuO/aokk7GlUfVHuOM13eo/Rs0yh7HbLBbOZ+YCfqcKoCHZ4yKL6NYxoPd2zltvkunIK4XOzkvv2gGfsL3u/9b1Fvvm/xfzvVJY7yFsEGg0XttdUShl9WzOTDpXMri/leHP0mutlXFZfBGT4kGaKV6y5k2vcwiHyMUJ+Pcdc8mk3RsdeBWSv12m/+UHFKRO0KtkXdrW0JCoVP6bqJnrwJsX7GxyU/HjdaEXsGkEiIxq43qFEFFQUt+oIfwip+4ZNaTzhAkNfuE/ia8ownQjJYTwkoE16HCRjB6A1YK1gwyqYWD4gu9KmXelRLPptZGi8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9567.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MWNBK0ZRVmVnQ2c4SUdmcENCWFRqeUJDR3M0WFowcVZqM0JDUStTL0pqYXJB?=
 =?utf-8?B?NzQ2RlZ4ZmRDVFlYUWFGYVVqQ3pra05TSHU4YytOeDZwSWswUjBpWlpVeVZj?=
 =?utf-8?B?WlVCNHpQaS9JbzNxUkdNcHRqSGdDemJNLzNtUTdtb05wZkphNnRFWkFjcmY1?=
 =?utf-8?B?cXdTbHNNb3dmWGE1RlU3dUpEMUlkN3NFWFN2bWNBcXNQemxhVzlsMFIwbGFa?=
 =?utf-8?B?MFdoUE92aDdxTW52WVhhaU1rYkUwaEhBcTUyQWkwRFRRSDc0WndNR0hiTEJ5?=
 =?utf-8?B?N0RlZDc4eEhEUVIreHBoYlUyTm9HZXpScWYyWWwvbXFJaldNYVhtMGFMU2JF?=
 =?utf-8?B?eDV2TUduOVk0UVV2YThubVJZVTB6MUdxazZaOFFUNmY4NTVaM3pxU0V3Ty9N?=
 =?utf-8?B?L1dsaExnbEttcXo2ckpNYVVxR3l4bnF2aHRxS0xEMGt1S1FZcUViVUJCVC9n?=
 =?utf-8?B?OFZHTUQxOUZiN2xNTzNOYW9sMWFNWDVIRU9lRjhTemxHYVRxVFcrYmRKOXhM?=
 =?utf-8?B?ZnRJc1ErRmFMUkpSQlhXOUNWWFU3NmJPV1hMeHRMYXNIUys0TDBOSTR4cVlW?=
 =?utf-8?B?OStaMFZqLyttUGpPYVo2WW1TY3UwMGxleWFudzZVZ00yUXhndjhHRWpkNGxu?=
 =?utf-8?B?VjlHSVZZejBEaU5oRnZPaGpUM0hod1Z4d2xKZ2duM2tXbW9XYm9QdjFEUFlS?=
 =?utf-8?B?bzZ3OXJmY3dPQ05xWDlZZk1jVjhmK3V1TmM4SnV1b2J3ZnRQSFZRT2hDNHFn?=
 =?utf-8?B?N2FwdDFjenpUYzhmaHkvSVJpK2pWNTBYemVuUmJYazVDS2NMalUyalEvK2o5?=
 =?utf-8?B?R0JjbHEvbkxVckFRTytTZ3o3TWNOK1h1VStMV0RNa1p4dm1PQWRyL0VaY0pL?=
 =?utf-8?B?dE1hTVROb3NLWnhKazdvcGxzTWxyQXg4MllaNmJTT2Y0RE1nSlFSeDV6eHgx?=
 =?utf-8?B?Si8zeDN2UXJiaFh2MVRnOWZwd1RmVVFJck9UQ2dlUGxrUTUvcXBMYTZxQXpo?=
 =?utf-8?B?THRXQTBDUmtIdzkybW9uT2VxUGRkaEg4ZldQa3RrTGpiNkdDbjgwOStvV0sy?=
 =?utf-8?B?NE9McGFrNWU1dnB4ZzdmTnYxeTNYYXZnTDkrU2liUzJ3RlR3dEszUDhvdjFz?=
 =?utf-8?B?VjBWcVptT09hSVJLY1NLR2tYRld5bzdJSEpoMHkvWTI0R0w5UHI2SkdhUTda?=
 =?utf-8?B?YXVOZXlVNnI3eEk0MkhUUGFuQm9iRDU5K0ZWR0V5MDhKQkZURmgrTXY3WVlh?=
 =?utf-8?B?VmtkZTVTUm9UQ2xwM213UzNwbERuSlY2QkVxd2hJMDhuenFCTnA5VllQVElO?=
 =?utf-8?B?Zlc5OEd3NlJvTElXVXZtZEJmWWpKTjRXQzYvRzRGUnlsWldGZmFLbncwOEZs?=
 =?utf-8?B?ZkdZcnU1K1p3S3dxcEtUUWlmYWErazJNcmM2S3UySk1wb1RnYlZGWnExaW1H?=
 =?utf-8?B?dk9IOWhLYVhZYmM2REdBRE96enJaYVNXWlJWZktkbU0wdVlhQ2JiWllqOGxG?=
 =?utf-8?B?RUNjekFIU2laMDhqcmk0OEp1SGVTdWZTYlF4dUdXZkFpVnNhODEyUUJmK1Jv?=
 =?utf-8?B?RmlJNmx1bVpISDVsTkszUjdueHVZbnJkcERZWDhKNXRoRDNSYk9hdjNaSkJG?=
 =?utf-8?B?dzNIaG9vKzNwTCs2YzRhWFdaWG4wY1RTSW5udERYZ2xvQXRRak9kckV0SHVw?=
 =?utf-8?B?WUpqek9jdy83cEJXSXRsQ2pHVGlmMUtyanRTUmh3TkRieTIzVHFHRnhkK1NI?=
 =?utf-8?B?RGJEK2kxTlBUVWp4dFp2d2tnSGVHem5NbUt6WVFucmhJQVFHRDVxTDRqQXFQ?=
 =?utf-8?B?MFdwM1drak5TZ1FyTWJTeFFBU1ZGNlVQZGllU0tUOGtpaTFDUjhUVHMwUVhM?=
 =?utf-8?B?azJpZUxKeGlxYUJzR2dSbmh5MFJ3RUJNRzFXenNjcFd2V081RThJWE5DSkkr?=
 =?utf-8?B?bEdZTE5HaEQzSk9sV0ZrRFNWeEJ1R2E5Rno0Ukd6R0xGaFYzZUdVdUdsZzhE?=
 =?utf-8?B?VVFhaHhmcEI5L3JzYlkzWTM5M291S0I4NDJ3djl0NElsMDZHaEZYdUZqT3Rw?=
 =?utf-8?B?QmxuUzJWYUUxNlNLU2R5NHo0SjlqS29zVWNkTVl4VTNhc1IrQVdRWEdhK0hr?=
 =?utf-8?B?dW1FYithbzk5bUlaUlJkbVJ2eFR0ZVBzK1NRaUJmcG9PZmRRVDNsWjY2VDZD?=
 =?utf-8?B?MHRkcFk5RmtFQnlBTEZDWHZacCtKVGMwMlN2RzNSdW5naEtwV0wwUSt5M0Iv?=
 =?utf-8?B?MUI3S0QvMDR6RnROTkJ0NTNhdjc1cGMrK3NvRmJSUlJIY1p1SkRRdTA5Nzhn?=
 =?utf-8?B?SkRiNmR6azFiamhJRm5hS1FWbVpMY1ZCcWd5VHl1ZC9FNjJRcG4rdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 4b626616-7dad-4717-b678-08de917a382b
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 12:12:04.9526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 xmRJjOEjXIJYShFddO3SMuI2nD7kjePCQD2jTqhyHgQ9mxhvuSEr5ToHLHEy8kYGGf551NmC6ANdo5iVO7/uGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7270
Message-ID-Hash: 2ONQEKU35D2ZQA4S7ZMORI6TNBXR6TIL
X-Message-ID-Hash: 2ONQEKU35D2ZQA4S7ZMORI6TNBXR6TIL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2ONQEKU35D2ZQA4S7ZMORI6TNBXR6TIL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 03/04/26 17:25, Mark Brown wrote:
> On Fri, Apr 03, 2026 at 03:39:38PM +0530, Syed Saba Kareem wrote:
>> Use DMI_MATCH instead of DMI_EXACT_MATCH for the Lenovo SKU,
>> So the quirk is applied to all variants of this model.
> I only have patch 1 here, what's the story with the rest of the thread?
Kareem supposed to send single patch only. By mistake, he mentioned
PATCH 1/2

