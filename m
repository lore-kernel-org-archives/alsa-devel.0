Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A851ECD484E
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2026 21:29:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6DAB7601F3;
	Mon, 11 May 2026 23:29:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6DAB7601F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778534994;
	bh=+Wo9ql/lRv7mmxCuzOHfauqleq/lmST0RrA2rFtPm38=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=VOv/AEM1Rc7PmZ316Qnua7UtziXditrT5YsaQTqrz6qiTvyhx92OM/diIml3n1yq/
	 vQORysJSRGNoC6pam+NIKU3CFLLPEznslhJVON0UurPRth1o0Oi40Pe9Pk2giVyRvV
	 n1oSYQDY+0pYKQYvjfRhJCwKf4Xq4M/amPcTRFmY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 449D9F805EA; Mon, 11 May 2026 23:29:20 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A475BF805EB;
	Mon, 11 May 2026 23:29:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 70353F80535; Mon, 11 May 2026 23:29:15 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010057.outbound.protection.outlook.com [52.101.85.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7DF64F80154
	for <alsa-devel@alsa-project.org>; Mon, 11 May 2026 23:29:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7DF64F80154
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=OxV7ZYyr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/7num6dM6wGBR2N2wFGPPrs5f+jnb8t/40e4bZYlhkvzXPs5T+bTHyXt8IoAxnIST+Uac+TfMMpGPmTv1kfLAjPuXA5+0GfeHEGDWlPTrCGKfW+FwURaCE2jdLRZCO+MLHYQvCGtjdRTXJoFOZPvLzNwwwhQiS5zT7AMgLMYqgtjKoUVfqiaMd2X/vjcK/aWUhxjW7RrP2N849MXZYTkR3/HmzNSU6xAvwNS33sO7wLreS9oA+34czqNORa8PFSBa5Yq2s/MXBdOdHZkDAtjPYAXOfD5L6PLVrPeJXNeDqEnrem7IbZ/FSTvtwQYJFBoqFQ6kvL8TVnLAtbrQzr7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZWapCQQjnYtp4+f4ZudqVZJjPW2GR/MROzak4Bxnhs=;
 b=OZlrkHJLEz1hp1BGz173Zm0JW3uNUh+KDQt0lEpphIzE+u7gQQ/3FePJ4UhRcaSzXE3E1fNFNhK1XhtSUA45uy9o4Kaon1FiBoyAw6WMJPX7ybM8nSs0LZGBuuIXI/H4mISFb/DhlX7gTXoIbDSS341p9DbBTXGgKlRphRHrmahyX7Clhd9FBHeSfuMD+49J24MhNPay29Zw7PYDpWQlmS9595qvWt3dXucPUYC40qbZcaO49aSOO3cVS7wADJR/SnOGEW8J7/rTEae7FPpQsbwB7vqxmFNfAkRKY4dl5+SrunUadefO1hZPk5/w1CzbNFbulbfH5ngaoXr8jv7BwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZWapCQQjnYtp4+f4ZudqVZJjPW2GR/MROzak4Bxnhs=;
 b=OxV7ZYyrG+LUGdDcreXg/qUCaK+BbQKOjlSWT+FbF9T0K38LIJ4EDejIE4cwLNBz70K/dgXdO/qSG5vt3LYfufJ37bkASFqu5n+mjQcEI5TJ8ax1BM5FJnLppV1B09BiDVBKUd70O89r7tB7vMveC1XxWc7BM+4fg7Azxvc322A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by SJ2PR12MB9244.namprd12.prod.outlook.com (2603:10b6:a03:574::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 21:29:07 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 21:29:07 +0000
Message-ID: <2dd667af-308a-4b72-af97-707b0a493f3e@amd.com>
Date: Mon, 11 May 2026 16:29:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] ASoC: amd: yc: HP Notebook 255R G10 (board 8D22) missing
 from quirk table
Content-Language: en-US
To: =?UTF-8?Q?Alen_Ti=C5=A1ljar?= <alen.tisljar@gmail.com>,
 alsa-devel@alsa-project.org
Cc: broonie@kernel.org, Vijendar.Mukunda@amd.com
References: 
 <CAKxS5A_OhoDGvVXZUnvUtv=j0zQ5Txq8g9_ScCPw12ZKfrmxOw@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: 
 <CAKxS5A_OhoDGvVXZUnvUtv=j0zQ5Txq8g9_ScCPw12ZKfrmxOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR2101CA0015.namprd21.prod.outlook.com
 (2603:10b6:805:106::25) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|SJ2PR12MB9244:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ab7d936-1874-4adb-3d7d-08deafa45539
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|3023799003|56012099003|18002099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info: 
	nTEs18gXbH8Uqs6qWqJkaIM4PaWOaQhsGZ4grCBfrksvGyM6/3DCjoB0KtS7+HYl0zstVABKuQ6NZJqUFboBSyquQ+89A8sdEgzwZ9K9yfziNR8pkb7YTmk8c60O3fug9OdPZYlKlqUVXxUxRkGNtbR0HODT+49n5a3etWZ5RUm41QbM+j5+/SrDhk1b90Kju9RkqTv37xFWkW3Ak5rmqYxoEz7HhNnfyegfx28ytq5gIvIcm/UUp8TyHfG2bHh0D5dK4rH/aMT70lXw5fCLG7YGOoeGmafB8W/Dl9t+L0YFDGp9GTJvLnXsp/FbNChiKvSGbctBk0oeDgwhW8PHLKqOY47dtbK0fcbfxvcq02ys8+hqjxmMM6fpWBabgDNmu9h5563rWRx01kLBAJr/WgHxUs7M96AuaPHSW6a2EMqvKDGia94LHGwvxdMd9HEs0mFtY1FJIdxaKBFXUc4GAjTTVcEtHHJt3tQllJd8A0/7IJvSpcj8YXPDEMSBJa0oD97zu5J28ABiPRX+4+P/2xI/mXUfHekZu1jrGP/VC6yu441KbdA1ZHsG0ulke4lPnGn8xFGqGgbXPGImktv3pXAw34fx/EyUaX6EcVmWRq3sCK24+oG5WbeMVNNtZijcXarrk700kVY0GMKZBW7LXMUKbfOmH50Hbq/bnw8r/mFblM0uib+/F4wV3/eBC/m2
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(3023799003)(56012099003)(18002099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MmFVM0ZVUWVNclhaSkgvUlFMUm41bzFPWDI4YzdrMHdraGlaRlFxUXVJZWdn?=
 =?utf-8?B?cDNQQzVEZTliYVNKTWxxL2dPM1JsMXQ3NjIrRW1kd1VxMW5kbnk1SmpUMk05?=
 =?utf-8?B?empuTDZLVWxSSHpRNnUyL1Vuekk0MG9CVmFFMlBWTjZDQjRLWkdLditBa3hn?=
 =?utf-8?B?MWlDeVBCczVxSjd4dklScnBCS3hLemc1OVQ4VVVsZlk2SlVzbWsxRzF2ZHpx?=
 =?utf-8?B?R2Q4dXMvaWFyNExCNVM3dHcwNGMzTU9UR2Y3RGhaM251Sm5rM2tyOHgwZ0hr?=
 =?utf-8?B?MGRNbW0rVnozWms2QTNNRGVSSVdUeFVMQ3lwWS92aUVUdTFIQWprVzhrVTBu?=
 =?utf-8?B?SW1nb0Fhbjh4L1JnU25ZYlNFSWFENms4aUk0WUVaUlBET1lNNElqWnhuZ0pj?=
 =?utf-8?B?MFNPY1p3eVlNM2RYdFZpOElWcHdoMmtLRlRqWHA2SmloMmJFSTNETkpXQmYw?=
 =?utf-8?B?eHdZUGlQMC9VekxEQXlhNkdDS3RLVGhmeDc5Tyt2ZGFCcVlpQkJ4dUJGVTVo?=
 =?utf-8?B?TVlWRTlXNSszbDhLRVZBa2ErUWZSdjJ6T1ZWbHJUREhHTG9SOUlWNmhRSGlt?=
 =?utf-8?B?WFZ1enhpS1o1RHI1amNDOHM3azZhMzNLR3lmY1B2c2tyR3JPU2sySzNzYWlO?=
 =?utf-8?B?VGIyOG82Y2lsbHVYUG8rbGZxd3FBL2NJTC9JOHdzNU9pR2RUUkZkYzFQOTM3?=
 =?utf-8?B?U051TlVBNGN4TU8yVUx6Uk1XQ1F5aGpjVFZ3QU9lTlYxL0krdGVzckgrakpr?=
 =?utf-8?B?L3BKd2p4K2VDWWFON0lRQXFZMFRNcUVxUFZuV3JneE1EWjZFUW1DT2hsd1NW?=
 =?utf-8?B?RTc2ZFBCbkdyUHRiR2xZMEVWay96QVNleW9tVkk3Ujhoa21CdERpMDNqaGcz?=
 =?utf-8?B?cFpVeWJZTng2WEgxZDlQZGVGSXlGa29uYm94dlA5YjhoQ042RzBzTWhtRGZw?=
 =?utf-8?B?blFzKzFRd1FqbUp5VnIzN0hhQ1E3ck9sbEcxdDIvTGdpa0M0aThaOE16UGtS?=
 =?utf-8?B?dTg4TUw2TE1VRTdVSEk1T0dKSS9Mc0JrbnJLNG1OV2dBVkgyTCtqQkIraUsx?=
 =?utf-8?B?bnBRTzBJUElZWHR3azJOdEtRNVZIVzY3bndPMTlwWCs1MGJlL2QxYVhRd2Vq?=
 =?utf-8?B?NWtkaXBXMmpidGt1OSs4WC82VCtjWXFyTVBGUUNTSElmN0dFQndOV25XYkRs?=
 =?utf-8?B?ZHFlbHF2dHEvRmpKNmZLNmtNQ0MwdkRhMFgvUXh5bGRCdUhVcW4vRVQyRExI?=
 =?utf-8?B?eC96ZmRlM0RIRkJyWG0rblVkMmxjMFZ2OVFTTFpvY1JXZmFOK09QUkRSYW5z?=
 =?utf-8?B?MWhtcmRKejNDTzRQUTFkdHFLdzNiOTlnelFjc2hZalg5amNSZXJNdklmLytN?=
 =?utf-8?B?b0hNUzUwUVVnM2Z6VjlzY0k5K3hCNjZwak1vdHVyZ3F5K2R5Z1RnaWdXRkhM?=
 =?utf-8?B?WUJ6T3k5cU9Pa2RhV1BDY3lrbGxGNkI1Ny9NM0U4SnBzb0FQdm1KRnNqVSt1?=
 =?utf-8?B?R20xd3BUYmxpeTJKbXlaa0hoRys5STFSYm5HdEVJMGdVWHE0S3lteEdPaVNM?=
 =?utf-8?B?bWVJbFN3Z2h2c09BREt2UElCUWlaWVE4TzRkaDZiTlRLT281b1hPSU92NnpR?=
 =?utf-8?B?QUo0NjVxNlRWbjhSSHJsQ1ZSamxSQWhYWERpdlRHbzR3RHNxZGw4d2dGeDZD?=
 =?utf-8?B?WmxRQzdlanViNm1yYitOZndXSWVaT3VGcnU5cVl1Y09ETnpkd1g5MVQzSk5j?=
 =?utf-8?B?SXdiUlJBQ0ZxOHBqcERXOHVPTFJybmdTWnVROVpSVmdTRTFieDM2RmxtY3cv?=
 =?utf-8?B?V2kvQWdiSlVwdTVLMUZuaUZWOURjU2ZndTRKdytRNGRmSzhlOHNCSk92MnRF?=
 =?utf-8?B?TVRmVEtjMERQdFRVL0FrOTJ3ODlJZGRVbnhyZFNLRVdtWnVMY2pzMDZTN3ov?=
 =?utf-8?B?OGtScVhxcGk3SWtpOWlIbU1zWGxBWUx6c1VaNkxnL0JNcW9DaVhEZXdMbHFU?=
 =?utf-8?B?U3hXd0VBQnh6QWxxM3ZhWVpzQWo1K1JOamxaVWVkTE5FVFZ5U3B0aDFZWFJV?=
 =?utf-8?B?REp2VUY4a0hMNytUN1NhKzBPYnQ0d2dDdTZMMEQvTlBucjJ1WXdpNS93UmV3?=
 =?utf-8?B?eWZhcDdlYWZZcXV5MDllekxwZWY0U1RRa1hSR2tONHcrK0xBU1RBS3E5amJo?=
 =?utf-8?B?b2JlbktxTHB4cGgvNm1EcElxLzJnZkluOVN3WXRSUWNUZUdBSnZGc1dRdHZr?=
 =?utf-8?B?cG1iYW1naGl5dko0STZET3Q2ZnNNbHJIaXRuUnRtUUNTcFhhU0I5YnJVVDNY?=
 =?utf-8?B?WDJVbzZYUkVtYUpJY1I1UEVBVzdacGZibk9oQ1p1NDJkNWJ1ZHk4dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 1ab7d936-1874-4adb-3d7d-08deafa45539
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 21:29:07.5762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 9FPzzttRZXxSgtoamki8dkh9CbhRpiLAIIHBg4sfbfmf26mRA2J6LRM2ch/udRMhVv/IUzN2z3wQKKNI08lv3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9244
Message-ID-Hash: Q2S3UC3B2AYMUPE7OGUHOZZLJLEJB4SP
X-Message-ID-Hash: Q2S3UC3B2AYMUPE7OGUHOZZLJLEJB4SP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Q2S3UC3B2AYMUPE7OGUHOZZLJLEJB4SP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 5/11/26 15:49, Alen Tišljar wrote:
> Hello,
> 
> The internal microphone on the HP Notebook 255R G10 does not work on
> Linux because the board is missing from the ACP6x DMI quirk table in
> sound/soc/amd/yc/acp6x-mach.c.
> 
> Hardware:
> 
> Laptop: HP Notebook 255R G10
> Board name: 8D22 (HP)
> Audio coprocessor: AMD ACP/ACP3X/ACP6x
> Analog codec: Realtek ALC236 (working fine for speakers/headphones)
> 
> Symptoms:
> 
> Internal microphone is not captured.
> No acp6x DMIC device appears in arecord -l — only the ALC236 analog
> inputs are listed.
> In dmesg, the ACP6x PCI device is enabled.
> 
> Tested on:
> 
> Ubuntu 24.04 LTS (board 8D22 is not present in the mainline
> acp6x-mach.c as of today)
> 
> Relevant dmesg output:
> 
>      snd_pci_acp6x 0000:03:00.5: enabling device (0000 -> 0002)
> 
> no further ACP6x/DMIC messages follow
> 
> arecord -l:
> 
> **** List of CAPTURE Hardware Devices ****
> card 1: Generic_1 [HD-Audio Generic], device 0: ALC236 Analog [ALC236 Analog]
> card 1: Generic_1 [HD-Audio Generic], device 2: ALC236 Alt Analog
> [ALC236 Alt Analog]
> 
> Suggested fix:
> 
> Add the following entry to yc_acp_quirk_table[] in
> sound/soc/amd/yc/acp6x-mach.c, analogous to commit 0c6498a59fbb
> ("ASoC: amd: yc: Add HP 255 G10 into quirk table") which handled the
> closely related HP 255 G10 (board 8B2F):
> 
> {
>      .driver_data = &acp6x_card,
>      .matches = {
>          DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
>          DMI_MATCH(DMI_BOARD_NAME, "8D22"),
>      }
> },
> 
> I'm happy to test any proposed patch on this hardware. I'm not
> currently set up to submit a formal patch via git send-email, but if
> no one is able to pick this up, I'm willing to submit one myself.
> 
> Thank you,
> 
> Alen Tišljar

Can you test the patch that you proposed above and see if it actually works?

