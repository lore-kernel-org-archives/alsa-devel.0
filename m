Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A0EFC97F3
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2026 15:12:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 434BE601F6;
	Mon, 30 Mar 2026 17:12:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 434BE601F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774883548;
	bh=b4r6LM9eciVh8eIL5lGXTJSQw5e1WaGqNuH6BCQ+0vU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=aE5fr5Zqy+sP8bhprlUEDcXsjhti1fcDvJ5hAi/cqdeVlh2t6B1F0z+cwsijLRLjP
	 5TXQRy06Xs6kaGQTJ5HSOQcQh8teOvMCKtBXwVm5k04MHuP3R74xAUffURPr4ST4pL
	 WePeGdO1PHoLbcE8dalUeShhR4vQf/6kS9QZQnEI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1460EF805F2; Mon, 30 Mar 2026 17:11:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3D6BFF805F3;
	Mon, 30 Mar 2026 17:11:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 435C1F8052D; Mon, 30 Mar 2026 17:11:48 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011060.outbound.protection.outlook.com [52.101.52.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3F6F3F8027B
	for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2026 17:11:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3F6F3F8027B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=mdevBS20
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdMsIKggrVzPKAlu7ueVPafxykt95MUvuzf4Av8neVa50E+uHA4ZJEfR4QsNYcGZL6/2sBsWgYQ9PA2OsMms5mLkLTCjNyBsYDMk7k9zuJiK1LRLpZS/eTLRrv8nfBzppEtydMeMqZoJNrLmbXKXxRoupdVzdr7C4iKyzlNnzggeGuhNNODsCnYRA90rUlrG3uV9YGaevubkvCB6rNOaMqjxZ9h27W+lQuyfs9cMYthMVbLG8oSs2VutOWqU9d7fufKK67+g8ce/8rlv5XRLM8MB+bYs0+PEe1c5lD+mf49gX0yCpDQM1TU0Un7eE845uLLLhNhj9i1kztQOKgd8EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NkerCL8IigXhNko7WsuDk50PAKAanDiKfCH/K7C53kc=;
 b=c+yNGSZ4RiQsKL1piRZbcxauvFHWveYVSn9qBQt53SKClQKic9PezZRomSBHBYhqgMyWDmhSH8j0zqgB7VfGYmNr4ORE9Da26bkUUAM0PBxvv7ptxwetxFquKn+oAyU/PvTGkjYVby1+65WAiPw0wzk6Thf9vJJD3d3tNmLMxt05X7L1NYU4twNQz8xWjKBjfpg5MkLvc/aBlDSMNzpMcCjUp46C+xxsRdhmptWi0VvGZ3pTvjf9qyAptZnVVkY7W1dWCRyQuBUfIspqanALfTBSyQAl9eXybUgxYiYl4mVFLtXA3lHrsTfTr+CIX+LKWBZsDwlvQFupfaIY2xJx0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkerCL8IigXhNko7WsuDk50PAKAanDiKfCH/K7C53kc=;
 b=mdevBS20k4j2rYMfkpS7k82TiCXADxb+FrL5oObUBmVCnYFcgJPaLxP3nUPeN5OC2NK5vZ3ubbEDyqNenQuwalFckcvuDmF8velhFNb4kmMcNK8p0Pp9hBTLAbI5/lu2Vja9xzUMR/F3sRCcy2mmIWBs4jDJtBLYq6QEBKmT11w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 DS0PR12MB8561.namprd12.prod.outlook.com (2603:10b6:8:166::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.8; Mon, 30 Mar 2026 15:11:38 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 15:11:38 +0000
Message-ID: <cdd4acd5-8aa0-4eae-99b7-d6d47c61a80f@amd.com>
Date: Mon, 30 Mar 2026 20:41:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ASoC: amd: acp: update dmic_num logic for acp pdm
 dmic
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, yung-chuan.liao@linux.intel.com,
 lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, superm1@kernel.org,
 Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260330072431.3512358-1-Vijendar.Mukunda@amd.com>
 <20260330072431.3512358-2-Vijendar.Mukunda@amd.com>
 <03a53820-a076-42ed-9ab2-3877396f99f9@sirena.org.uk>
Content-Language: en-US
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <03a53820-a076-42ed-9ab2-3877396f99f9@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN5P287CA0013.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:265::14) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|DS0PR12MB8561:EE_
X-MS-Office365-Filtering-Correlation-Id: bba6a298-fa43-435a-6471-08de8e6ea3f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	3GF9xnG25mlt/uUuea1CT49uHWEXXAhI9Xg6PIOE3FbDhivWeKns0BxP7fJcAv7S8roLhf91NhBCyPzAg9GqXr4WULM1CojHZejgbQz5ovEao4yirVuUScipCJarq8G/mH9sPnoPNWYB0iO/E5OYs/T9a4Ns7k3b+KV1GyVmD/xeSIDAi4Abs9FLSTr4YIL5d7/AqkmnIKuRdz2iX5b2D6INL5alrj5NMSMzSArYvvvDYVu/NYJK+AfkE+/iLmJ4K5McwgT8IOsIIUIS2enGrcY0arlUoLlFPdY+HmSKuCM6kQzZw7hPaVVXt9aJ90cJ2OlRZtNymFYUowcuX6ydwYdDHqGdz0DDw8HvJZFp70ZnN2VEWQ+pBYKs6kkiB58WprAlVMe1PN4GMRqqSYSactfaoiEMrOmztuFYm0jgD2k3wDe/nDoeCsb29BBzCI+BNvD45jpkhJalcpTJIjWpCZf9X5DZXtUfoayWMVV2KFxKg5VaLT2u4jFkTpbrk3FhMMJaYXFLc7LWfNxxrwavk06p9jcQLZiseQ5tuRl91pAkjCW3knaVQTVmnVkh5SHmZKMr839JFBftloMWYkqrl3LzfpJXWzoNEKfRWhvMhRvH0yHfR2Pqren58c9aKpf+3j9mco6rQilKwGYWWnATMHNY/laFlC3gaR1vElhshk3Ftuv3bBZdEjzWzwZiBqcHQJOkRNxSZZSXn0+WGVzKL5ZqLRPg/kLGJzTqqf4TgM8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9567.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z0lYWFdMY2pMNGFwWCtkQk9RWVFnQ3dTWVNVN0FVWkxSZ1piUnhLcjgxOVFG?=
 =?utf-8?B?ck5qMC9qM0lKQkNuTWxYMUw5VERhRk9jVzNGL0VkM3N0eVl1UXlZekdGNmR1?=
 =?utf-8?B?Y2lBdlFHZkt3WSt5cXBCbzVMNGtGTGJIYnhpS3hyaEQ2eDRTLytEcEwwRXg2?=
 =?utf-8?B?Q09sRlZQS1dIOHhJM2kvWTluR3FhUXJlWVBWYWpIVGVLVUxiQUhGVTA3eDkv?=
 =?utf-8?B?VTZieXJ2bklyOS9jZXpxZmV5UnNLS3dSbjdFejg3Tk9GOWorQngrcjRWVFFq?=
 =?utf-8?B?RnhFbnV2QjhOMHM5RTNhYzVHTWEwZCs5em53ZlpZSWlGY2lSb3lheEdBcWIr?=
 =?utf-8?B?QlZDVTJyYjRoSkVmQzJYZ2FKaDFqMURvTTVwd3F6Y0tLZGFYbkNBZTFSZWt4?=
 =?utf-8?B?eS9WUGh4N2E5a1J0ZGRmS3B1WGFORjNkS016UlErQ0M0VG42Y2MzamZEVi9o?=
 =?utf-8?B?RVo4VVZ1Y3hqWGVybjBoYnphUVRTUjBCNHI3ZkFDTGZLTEhOeXppL2NCRnZj?=
 =?utf-8?B?ZEZaQWlpRFllMjROVVkrUjJQanBlTEVUeTBOanNZKzlqaTUrQmp1V0JTSzFG?=
 =?utf-8?B?anRQRGpIQW1ObWNaTzNENWdwWW0zYzVINEdsaW4vSjBWN3MzNkg0dDlIWGM5?=
 =?utf-8?B?bEZDZHFhY3dFbE0rM2JjQ3ZvbVZpcEJFVCtUd0pQM1A1Z1J6aVMvODRWSDQx?=
 =?utf-8?B?bTRZM3hmMXd0ZkZrNEpUbytsZ0N4bmd2WldQcVBqNzdMWE5OT3AwTnFrNit0?=
 =?utf-8?B?eG9nbll0ODB3T0JIM09VWm9aME5ieTNCSDQ5TkRDY3RuRlRna2FQSkpWUGZr?=
 =?utf-8?B?SVYwbWUxMDVzUUs1Tk96SzlWV1RXT1FidzJLRmRZWWpaZm1objdFeitiVG13?=
 =?utf-8?B?allzMHk2dTVSQW01cTQvSXdFRTVYbzJtMG0wVFJKRkN2ZHZqTXh4YjFqT2xl?=
 =?utf-8?B?ZnNIamVaVDg4dW1iZlUwOFRVSGRPaE9zaGJZZzZ6UjNTdG04YURxL0JISDEy?=
 =?utf-8?B?U05QaGhTcnk5SVlkWXNDcWtwTUpNbHVwZDVyRE5nKzczRDJ3dWpZbDJwMGtM?=
 =?utf-8?B?SlZjOWpKTVNNTEQrUFRnbzJqM0VCYUlNQzF2UU5zM002RHZpT09LVTdQcmtm?=
 =?utf-8?B?aVp6K2hCbnBGY214aFh3SzFXTnQyUjVvUlFwcnJZQnNBUloyYlFVN1NmQkRW?=
 =?utf-8?B?YlBMeXVvWEE3YUgrSTVsdkx6NWw1a0dXNVNxRkd4ZzFnRHNhcGJnTjRNSmpH?=
 =?utf-8?B?Z09mSHNpclQrWFpCUVhGUW9aWmJDUGtNRS96YjM2RkVwc3lheHZwanhsc1Yy?=
 =?utf-8?B?RU0xRStTZ1JheWhBblN2c1pWZTQxTXBEbitkYmFPOGZmMk1YSmJMcFh3L1VX?=
 =?utf-8?B?dVZPeDFzcW9yZlkrRUU3VUFrMTdsZlhja2R3a0RuT1k2MndETGpCZ1g5T1h0?=
 =?utf-8?B?cElNckJ1K05RMWcrMXN2TUwvbXhJN1NiWERyeExxVDl3Q21oUDI4ZVRDYUNV?=
 =?utf-8?B?bCtVMCt0aUtEbFBWTXl2dnpxU3EyZkdTWjJyYXRaamxydkU3Lzh3cFBWNUZz?=
 =?utf-8?B?UzJGT20xR1lZOFlva055VmtOVWxNTlZJTUh4K241ai9zMDVvWkFYWUhkNSto?=
 =?utf-8?B?Uy9NRWZQYThqRm1ocS9rWVMyQWQ1cSt2dnRkQWZUQ2Y5K3NZN1QrSXNLNmY0?=
 =?utf-8?B?MGRZMFpKZ0JUMkl4MFpUZGkrZ1JsWlBpbDBudjQ3QzdRWWJGNEVRSkp6TE82?=
 =?utf-8?B?QjNGaHlxcllkRm9PakxzZXhQT1hzU0phMGd3YjRDQ0R6aTluSjdjQlIyMDNl?=
 =?utf-8?B?ZkRCWWRPcTV6dDhiUEM0YWF0QUZiT2NCSlAzcHVtdUp1N04veDRJQ2JoNnp1?=
 =?utf-8?B?UFNQUnhvQXc0Q0RvN1Q3Z0g0WFBmbGxNZTZKNUtKUFlJQjJyRk9lMVVCVkZr?=
 =?utf-8?B?R1NZTXJobzJtbUZQbDFGTmVJcFdDTGVDU0xMVithWDdweGJQeTlvUmoveFVL?=
 =?utf-8?B?ZDBLODRaY2lNK0Y2Tm1wNkxwMExYYnRIT25DdytRNFFLbnorVE1vdFRiaVlZ?=
 =?utf-8?B?dmhNZHZSVUFLVnZNK2lpZ3NnbUhWMFRib3dyQk85b3Q0QlRsdnhLMnZKancx?=
 =?utf-8?B?Z1VxbHArY2NNRmgwVS9KaDk5ZitCU1NCNURqZUMxaUR3TDlNYkZrODVFS1lF?=
 =?utf-8?B?N1Q1OUYvVUhKSEJqOGdnM2FTM01oKzdTaFc1VUZBOHhhUmc2SVYwRGpKQkg1?=
 =?utf-8?B?SVlTK2NlTHk3RVN5aUFTWnRZWWVSN0lEUURKTkpraU1HZVNzTFdBeUF3OU1T?=
 =?utf-8?B?S2liajBhd2d1UHBxb3pWL1B1MVpYUmlzQ2FkT0lmSlhwMnZDbElWZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 bba6a298-fa43-435a-6471-08de8e6ea3f7
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 15:11:38.5770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 XFFIfcK8IlYFg4vmy1zXYayLVkCqQ9FdRoEbs6+V+EHBsj7K9oKlDelf0v2xomWKg46u1RVGWFecis1mqOdf8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8561
Message-ID-Hash: 555YLIDWT7YFJVQYWLRTSDPTVP5DD3TW
X-Message-ID-Hash: 555YLIDWT7YFJVQYWLRTSDPTVP5DD3TW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/555YLIDWT7YFJVQYWLRTSDPTVP5DD3TW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 30/03/26 19:13, Mark Brown wrote:
> On Mon, Mar 30, 2026 at 12:50:27PM +0530, Vijendar Mukunda wrote:
>
>> +++ b/sound/soc/amd/acp/acp-sdw-legacy-mach.c
>> @@ -535,11 +535,11 @@ static int mc_probe(struct platform_device *pdev)
>>  					  " cfg-amp:%d", amp_num);
>>  	if (!card->components)
>>  		return -ENOMEM;
>> -	if (mach->mach_params.dmic_num) {
>> +	if (soc_sdw_quirk & ASOC_SDW_ACP_DMIC) {
> soc_card_dai_links_create() (which could perhaps use better namespacing)
> checks both dmic_num and the quirk.  This doesn't seem properly joined
> up (and perhaps the code shouldn't be as spread out as it is)?
Need to drop the mach_params->dmic_num check in soc_card_dai_links_create().
Will push a separate patch for the same.

