Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F04CD37AC
	for <alsa-devel@archiver.kernel.org>; Wed, 13 May 2026 21:45:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 65B47601FA;
	Wed, 13 May 2026 23:44:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 65B47601FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778708699;
	bh=AI6P0t3nZFihwFy3X50rPiQmAeLWRbfQv9UIDbv5c7I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=DOPn+0JYUFHbFVJyVSmlwulVk9GQrF5UA4QYXErWXZ+H6upHf3UH1mXhlr45abmgH
	 p8tZVQCD6tisnqQ9J9nYyKR+0jyF4Q1rwVzbaCmDV2HwLn+URnLjw5ihkfgOd5C5nA
	 zXh15Mfi6D1LdhdmHYV2z4DmKPf/BUzhEJfRyMS0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C07D9F805F3; Wed, 13 May 2026 23:44:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6CB8FF805EC;
	Wed, 13 May 2026 23:44:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BB409F8049C; Wed, 13 May 2026 23:44:18 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010052.outbound.protection.outlook.com
 [52.101.193.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2782AF8001F
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2026 23:44:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2782AF8001F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=pcWzI6NO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aU4wS6gOlYENiw1vlluoCTub453crpkSixB0+yeeav2lBD4eqLwL6aMAOxi3frhU3CU7i0JIgxl2pYh7f/zNDDnImAH+aXQ2vAdA1rI71FaNuBkYU9CpZunNdv6hYAZyndronpJmxblLg356wtbyH2JQkWpXZTXTANjd9poIHyf1V4WD4oaJ012X+rUSHZqMguTedNRlWXbQ6tWCqvV3YfDvQZCAel+nDia/lvRhB2KIZqOZV/4rDmFAzbTPmDK8Zoo3AbIG++OrsHPJVI8KeYT7pRN0W74GF+v9g8m3vcOX25AflQx7PYnyJ5yGfgzcWnK4JYQG3khulUL44r0E3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1POIBjb8igCmAFMke5nkWYydxQ2a2cdc+Q/ItD/NE4=;
 b=XyVgfJ2/TBhEeGEe+X3uQLPOJU2RpYQGebYUaTdc4oa9VszFdPUhRD/tDyFYl2LJ1GtdiUlZ3x6BwP3mkb5/axp+T373v21QzdQ7zk7f/ut3sDkeiQXmBOf+Zj1WhRBOkqSPDTuVIhM4bx7WTm4lzHctA0ufey41qWAJYZ4MZytle9pp/dQD3EHPY5gnIsg67cFywSDYpE4+UGROsawBYngqwZDXBDLRkwlDPyso4Zc8Awennnxg80nctX3h0AjrglS06pe/FEezs+xo139UoLIbRASDMxuuSQ7Ye7bujahBg7L+xHTMAbrXQqpcmJ3aTUsp7cj5mt5S58TlCI9hqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1POIBjb8igCmAFMke5nkWYydxQ2a2cdc+Q/ItD/NE4=;
 b=pcWzI6NOGhZg1FCYk0TnIXGRoxKfamJD0e+IAjBIAivDniWP/Gdwwq6C9I5wRg8UBGKz62NypyXJWrCdLhl5fu72HtAJKIdw5gAMXu6PiFZa9Rb+kmqUayXYKIYIIfrZW35uZQcWx6sqnfOSxVhB/6sH1f4qtJChv+LDkTVSvSo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 21:44:08 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 21:44:07 +0000
Message-ID: <b8f9c082-5536-495c-a449-039187f979ad@amd.com>
Date: Wed, 13 May 2026 16:44:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] ASoC: amd: yc: HP Notebook 255R G10 (board 8D22) missing
 from quirk table
Content-Language: en-US
To: =?UTF-8?Q?Alen_Ti=C5=A1ljar?= <alen.tisljar@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, Vijendar.Mukunda@amd.com
References: 
 <CAKxS5A_OhoDGvVXZUnvUtv=j0zQ5Txq8g9_ScCPw12ZKfrmxOw@mail.gmail.com>
 <2dd667af-308a-4b72-af97-707b0a493f3e@amd.com>
 <CAKxS5A_pTv7qky_+izy+wxqq7gN0XBjoqUTo9OhNCuo_BLZ4bA@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: 
 <CAKxS5A_pTv7qky_+izy+wxqq7gN0XBjoqUTo9OhNCuo_BLZ4bA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS2PEPF0000455B.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::518) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|CY5PR12MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: ecdb68fb-fd37-4592-4a89-08deb138c2a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|11063799003|4143699003|22082099003|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: 
	5RFbVc6hWEp82iXYRHETAH3ZDnNmUqwwg4bVl4DbtNYf60T5tvNufiGdMVIwQAtuWKgGApepMB5StGhU5Upkp+luNjkuqfVNfOlP3g51qRkKbi3jRIAFTGWI3N2REo5JOIsLbyG0fikse0jL3wq2oVvV93GoW/lC1RBKP7wJ36tQwv9T/D1xoQXJzDF2ogLTstBPkRBUIh+XFALccFz3X4w49SIsFky7Hu9PL7Ps2bdVu6n9bMwEdNPONDUXybOVyKxW9F58bkd8V9dGbz22mC+N+9F6PvrDj4AiMHJhaFp6vDx7N3HKRowKPBvQ7a+NxXN9FjQUbuvk4JOwbpzid5aAUly3qqgdpjLfLOzMhigLEdSthR3ILNuEBRWPDbIIMNuIozo8ahtPdXHFTsFi6+ScvwPoPiMkaSDbfwyBccUTB2Nc7unFXboVGUwaFdDRBMf+lFaXI6cUqfCXNs8tsd4paxJ9WAP/pmgoRjy0A0EqiWxO2Wb1ZegPHLGHNM17EgQUxocscavh8nNqE4qGptbUp5g6oorwOwWvC4nhuOSWARxVx21toooTvr2DBPQYw/Z+j7MVHsQQvQSt2bM/0pRbV5ihm5NNirnllI/1+YC8mtgC50JrUSRzRynmsOc2BEheLtLHF915bass9R3Jqw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(11063799003)(4143699003)(22082099003)(18002099003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cTNDK0ZFNWUyRThOcFNwdkNFU01Ed05PQU1xMTlxYTRMaitpc0IwVlJwN21P?=
 =?utf-8?B?cjZONWxSWDdIN050eEp3YUlnNkRTeHNkaXV0VSsreE1ZV2wxTW04N3c3bUhG?=
 =?utf-8?B?VnZHZnZjb21lWlNLdHVmbWpoUkpCN0I1a01ieTBpZGwyMkxJdytsU3VMQ01S?=
 =?utf-8?B?bHRqeFdDQVlvM0x6b3NkSzBrWjNMN2JJQ2pVaDViTHJDWkFXbmVGcjVuMmRq?=
 =?utf-8?B?Vld0NW93Nk5uQkdxL3R1anBNTVo5N2V3RUpYY0JONVdFVnQ1SVdJMnArYXlL?=
 =?utf-8?B?U3kvcVQySHhxL1NmSERQZnZRQWRmN2FWMmN1djNtZDJReHJmanhGS3lZUlJB?=
 =?utf-8?B?TVh5eEJ2RDJ0YXpmeFMwR0xTSENXRFRPMExxeHg0ZHRyUUJEWGZubzd2aWdP?=
 =?utf-8?B?cGNCbERaNHdhUmhRWG1JSDZGRG1YcUk1UUxRSElVL3hId3d0OWdIdWREZUZY?=
 =?utf-8?B?SEVYRXJHS1ZPMU51bURZOTI5MmIwNTFoWkRFNzM4UHIwMi82UjZCcDNHS2pX?=
 =?utf-8?B?RDhuTEo0ZzJlUnBRVWVLV3BMbVdJVERieklRZmtBeVVkYXNjOVBTbGNpcENu?=
 =?utf-8?B?TSt1UkxpYW5nTEg2K3oyWnBxS3VKQitLTHNicnh1NnZ6Q3VvTVgvMk13bzVF?=
 =?utf-8?B?S2VyblJpQy9WLzE2dTZSemdsRlhnMHErOS9BMDNXQlB2KzdPazhBZDdTZDNB?=
 =?utf-8?B?TmZwMVJJNXNJYzZIdlp6OEozbkExKzV4NS81ZHBpYzBFOUxDR2p5ZkhPQTR3?=
 =?utf-8?B?aW9nVlB2WGJMMGs1VlJYQUFTS2lXTk5xN2NYYlRTYXplTTVremRENXpKRVBI?=
 =?utf-8?B?dnBEQjZjV0xMOFVOb3NhUEpqbjhNWmVOVEcxN2lUMC9rUUx4VGxIRVVPeXNO?=
 =?utf-8?B?T3kyM210MUlwaytyTE5SSm96d0tZdy91WmtVeThuU1lXaFg0Y1VBcXp0SExP?=
 =?utf-8?B?Q3pKU1ZuYmM2M2NHb3FnSlR0MUUzYXQ5ZWRtOTN5SGVtdWsxWllnZmYxL2xY?=
 =?utf-8?B?blA2RVp1alJuVUZDNURnOTM5UC9UeWNIV1RENnFlcVZ3Z3hXc1hXbnVQQ1Y2?=
 =?utf-8?B?Q1laSCs1b0NMMEJ3Y1FiNENrbEZVM2hWUGpUSzBPMjlJb0MzVTJmSHpuVXR4?=
 =?utf-8?B?SGhkVFdpM0hNOTBZY2ZWcEZscE9zQ2lmc2NmUjV6aVRxM2N6bno4WGNQM3Jh?=
 =?utf-8?B?ekIrRFppbllKM3FqN3dmVkZDeElUN1NTSXAyOTduaHZEcGlwVzVUZXU0bXIw?=
 =?utf-8?B?aFlpZGRLd3VvWklBWFVNaDd6N3VpM0FnOGFOMUduOUp4L25vMVovTEExWUpw?=
 =?utf-8?B?ai8wRUtDQ2VJRURzMExsWUd3YXloU29sRlpJVmQ0aFNQS3F0V2VwY1M2NzdG?=
 =?utf-8?B?enNkdElremtzWXJCQ3lGdHU0eXlhcGVNZUJGWExDeFpDQTNIeUdTajFZSzF2?=
 =?utf-8?B?MkNvb1pSNTdKS3ZpUmtkMWdhWFJUVlovclpJU1FqTHZyd2FkM0wxZXlmdGhJ?=
 =?utf-8?B?UmdJeGxIYkRhRTRHVVYrOWJjQ2dhUEZ0ckQ0ZzJQSHNzS0NtVzd4Qkp2Sm1O?=
 =?utf-8?B?blFkOTQwSzVRS0NTcHFpNmsyNjFITkpjc1BvU1FMOHNRKzlQV25BUEhqbHd0?=
 =?utf-8?B?cFlqVFBYREFkeEJUalE1Ri9PRWw2QVVKKytTdnZiRlJ6YTYrU3RFN0tMOWtq?=
 =?utf-8?B?MTVFL3BoaTVudFV1SWNEbjlhblRKNTArOTZweEo4MTBuR1FRZEU5U1NJNldY?=
 =?utf-8?B?SzZMdkp6QlFBaFoybTJZRzh0M2Y3QXpuYmpKUzJIVkVwdmNGNjdpZXhWU0hk?=
 =?utf-8?B?c1J4SkUveENYWmVZVGRJdWp1RVlNUlF5MGh1K0R1eFovdnlQYjBnZXZMVEYr?=
 =?utf-8?B?a2hnVUJ0WnU5SW1pMHRKeER3eDJJaWlCbGtuR2NKdXVWeFQxRXRndXBLcW8z?=
 =?utf-8?B?dTJ6aE4rZ1IxZE50Slh4M0ZMcmhmbnJHTDBpWmM0akM4NDg3NHVudDlURzBS?=
 =?utf-8?B?ZEJzOG1EMlAvYmhnVCtLQVBiZVZWY1IvZkc2a25GelhCdkJUZzJVODJhM0JM?=
 =?utf-8?B?c1hqRHhZYWNwYWc4dGZYcWVneVBMN0JuRG1qLzFMSVk4dFpkU1BHV1RoSjhW?=
 =?utf-8?B?R0hHMzYrZXp6QlVYYncwMktHWmY1MUIrbHlFZ0M5dHZUNFVDRDVVb1JKVGhk?=
 =?utf-8?B?WmZkenhIYktaWTNnVUVFVW5RRmhsU0JteS9Qb1NiVTZiRTRmRThaaGRKQ2NR?=
 =?utf-8?B?aWQ1d1hpVzZTRmN4MlBjUGVMN3VsMDdjdHVGclJtcTRwV0xwNlZQY2VKUXJl?=
 =?utf-8?B?MG96SGFVcmRuOEdHNEpyN0h0dFNOMjU4bEZSVDNPTUFGT3E1cjkydz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ecdb68fb-fd37-4592-4a89-08deb138c2a0
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 21:44:07.7916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 sOeOZBxSx7lRGCHZYY0zJexgOyuZvn42mtg+/5uAO+aPufGsJDOWyLLlARiEmStQOmfA2+2PhVqwGWpmSJiWOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6369
Message-ID-Hash: BVIPV3NCYOBWEB2P7SHQ75DBKZ4OYM5M
X-Message-ID-Hash: BVIPV3NCYOBWEB2P7SHQ75DBKZ4OYM5M
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BVIPV3NCYOBWEB2P7SHQ75DBKZ4OYM5M/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Alen,

You can check out the mainline kernel tree and apply your patch to that 
and build it.  This is the upstream build instructions.  They're pretty 
verbose though for someone not familiar.
https://docs.kernel.org/kbuild/index.html

Here are some instructions for Fedora:
https://docs.fedoraproject.org/en-US/quick-docs/kernel-build-custom/
Here are some for Arch:
https://wiki.archlinux.org/title/Kernel/Arch_Build_System

Generally speaking I suggest working with an LLM to help you with 
localized instructions for your distribution if none of those links help.

When you're ready to submit your patch you can find the details here:
https://docs.kernel.org/process/submitting-patches.html

Thanks,

On 5/12/26 00:49, Alen Tišljar wrote:
> Hi Mario,
> 
> thanks for the quick response. I'm not set up to build a custom kernel 
> locally yet.
> 
> Would it be possible for you to point me at a test kernel build (e.g. a 
> DKMS module, or a kernel build from your tree) that I could install and 
> test?
> 
> Alternatively, I'm willing to follow build instructions if you have a 
> recommended workflow.
> 
> Regards,
> Alen
> 
> On Mon, May 11, 2026, 23:29 Mario Limonciello <mario.limonciello@amd.com 
> <mailto:mario.limonciello@amd.com>> wrote:
> 
> 
> 
>     On 5/11/26 15:49, Alen Tišljar wrote:
>      > Hello,
>      >
>      > The internal microphone on the HP Notebook 255R G10 does not work on
>      > Linux because the board is missing from the ACP6x DMI quirk table in
>      > sound/soc/amd/yc/acp6x-mach.c.
>      >
>      > Hardware:
>      >
>      > Laptop: HP Notebook 255R G10
>      > Board name: 8D22 (HP)
>      > Audio coprocessor: AMD ACP/ACP3X/ACP6x
>      > Analog codec: Realtek ALC236 (working fine for speakers/headphones)
>      >
>      > Symptoms:
>      >
>      > Internal microphone is not captured.
>      > No acp6x DMIC device appears in arecord -l — only the ALC236 analog
>      > inputs are listed.
>      > In dmesg, the ACP6x PCI device is enabled.
>      >
>      > Tested on:
>      >
>      > Ubuntu 24.04 LTS (board 8D22 is not present in the mainline
>      > acp6x-mach.c as of today)
>      >
>      > Relevant dmesg output:
>      >
>      >      snd_pci_acp6x 0000:03:00.5: enabling device (0000 -> 0002)
>      >
>      > no further ACP6x/DMIC messages follow
>      >
>      > arecord -l:
>      >
>      > **** List of CAPTURE Hardware Devices ****
>      > card 1: Generic_1 [HD-Audio Generic], device 0: ALC236 Analog
>     [ALC236 Analog]
>      > card 1: Generic_1 [HD-Audio Generic], device 2: ALC236 Alt Analog
>      > [ALC236 Alt Analog]
>      >
>      > Suggested fix:
>      >
>      > Add the following entry to yc_acp_quirk_table[] in
>      > sound/soc/amd/yc/acp6x-mach.c, analogous to commit 0c6498a59fbb
>      > ("ASoC: amd: yc: Add HP 255 G10 into quirk table") which handled the
>      > closely related HP 255 G10 (board 8B2F):
>      >
>      > {
>      >      .driver_data = &acp6x_card,
>      >      .matches = {
>      >          DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
>      >          DMI_MATCH(DMI_BOARD_NAME, "8D22"),
>      >      }
>      > },
>      >
>      > I'm happy to test any proposed patch on this hardware. I'm not
>      > currently set up to submit a formal patch via git send-email, but if
>      > no one is able to pick this up, I'm willing to submit one myself.
>      >
>      > Thank you,
>      >
>      > Alen Tišljar
> 
>     Can you test the patch that you proposed above and see if it
>     actually works?
> 

