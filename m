Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7956A606A319
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Oct 2026 11:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=rl3VTUtR;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XXFHGS+z
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3F62C601D9;
	Thu, 22 Oct 2026 13:02:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3F62C601D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792666946;
	bh=9F330nSqVHhXWf/QX5UFwZ0JkD3bZkxXsykLFoqgzKk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=rl3VTUtR5TSvAG9NDYWEalY0455k6ibUi4az5hOuDEisQ2pjYnWra8TD0n2L5tRvJ
	 Rwp9JI+ustOW+V7BckxT7FUprZj3XpNg7sEjZ7vExjHGMffnf/nVQMkn7bf5dWG8RL
	 iPbd4yoUnoF8YBNRs4uPYsBGZugJT2P3n0PaqLTE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 10708F805F7; Thu, 22 Oct 2026 13:01:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 88DA3F805F3;
	Thu, 22 Oct 2026 13:01:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 96228F804CC; Thu, 22 Oct 2026 13:01:43 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011037.outbound.protection.outlook.com [52.101.52.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DD69EF80424;
	Thu, 22 Oct 2026 13:01:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DD69EF80424
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=XXFHGS+z
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izYR4bXNFhz5O9EPe7lgHXEdw4mppkvGACpriy0Yps9KbSXJhMpWwerO2zw30GUSXWxCxnEw8E8votDUFqPkWdSwvwZtY1Flfhy3hnnX3Dge2nLaAvw5Kc/e+B8ZV1gjcKS7+QLbak4gwuixSVqqqF7d5UH9TUin+hbY+cAJmFPYFwdmqsKxIhijLL6BMtQS2zfdsL08owsLUCBPUpR4X139aI8zLTIggcwFpPf24SdiqjBTuYquK9STUtEWjga4az/eEGvO3wcLTKzOmLc1VyPcvuKb5B68n+KmsnmbNVNoNqwz09nKqGqcyjySaJdGL8w1H4QSirwOKmB5mwWJjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhnOx+j/cguK+/0Scoj87/+yFuQGKjvaLpRf83wJRkY=;
 b=ejhobfWOpDmGGKKr1kmfKv54iqJZ4YPQGEeZuu1Zy0nF2NTPlZ/avR19hINMWBJCHCyfzeHZ9atoGTaIPPGGwe9lWVKy6Lk0BT0sr/s1WIg03uNY8+IJzaHfpUsoIL3K9j46YzVWrCsoPoID8GUY9gm9jc5ljIxpeQCiromwc4MK6xLQuWePt16SR2lHI2Y7ZKKQIaFQynJfbzkQfN4SHX8J/LVXTXSswnUMWQLaXPlb7EEP4ZPYkCizfw+48CihKTrZ0XJ8ILwp93qKba3LkJbUledVRVtpEEtehauAsAoBQKdgLaQEovf6nMeKXw3pniN7ojB81pjiCWZQkdNuFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhnOx+j/cguK+/0Scoj87/+yFuQGKjvaLpRf83wJRkY=;
 b=XXFHGS+zm3RUwj+HUrD/8MmZHk02YACFOdH9s/0FgqmGa2Wdflbj6Q9sOUiye2ADi7QZXGhXxmP3UJ1ml1mNDWnLYK9rcrr5dBL1u2CAZyWcUWeyb2jzhQPFwjushx5eAkBGsDQBN8uMr0I6JDobyet3CVGD2+5yv7fN8fS6pLI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 SA3PR12MB7904.namprd12.prod.outlook.com (2603:10b6:806:320::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Thu, 22 Oct
 2026 11:01:29 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%4]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 11:01:28 +0000
Message-ID: <da563826-ec0b-4be4-a4e3-3fb78ba5456e@amd.com>
Date: Thu, 22 Oct 2026 16:33:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 03/13] ASoC: amd: acp: fix PDM1 quirk and PDM
 controller selection for ACP7.B/7.F
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, pierre-louis.bossart@linux.dev,
 yung-chuan.liao@linux.intel.com, Basavaraj.Hiregoudar@amd.com,
 Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
 Syed.SabaKareem@amd.com, Mario.Limonciello@amd.com, Richard.Gong@amd.com,
 Poojitha.N@amd.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
References: <20261022060724.1814741-1-Vijendar.Mukunda@amd.com>
 <20261022060724.1814741-4-Vijendar.Mukunda@amd.com>
Content-Language: en-US
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <20261022060724.1814741-4-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::22) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|SA3PR12MB7904:EE_
X-MS-Office365-Filtering-Correlation-Id: c95204cb-112d-4940-1281-08df302bd227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|6133799003|18002099003|10067099003|261021121427099003|3023799007|22082099003|261021123027099003|260925021911599003|260925022911599003|11063799006|261009223027099003|56012099006|4143699003|260925021311599003;
X-Microsoft-Antispam-Message-Info: 
	5Yx9e58ZXMdDcxUjfQR00iRVOvnTOweFLPHpskVklI4lKkME25hwiCmBgP7CHExH5jc8p3ayGWXivyNHqonWJtWEq86ERmq4snfXYvho7oORzpVIRXNWFRYLRHHAMp/mbmM5dep7oe5WxOMJ4CzqzTTyxxVZega5XBlhZCqBvBuM7IaWFNX+Z/297DltdMKE4Creov4I5SkoyQeRDvhOh7xfy6ODQ/FQlqBoapXeg79eQ7xz64V031vPK7GiQT/VguvUh89+czI3jEFQdH5Wm8+VV1eIaXaZH4jc0fVvVnE32czxvqCScjpOFTvdlbrnpXFGi2VQUs+h4EArbCtwKhfFk6dj0S0rhXwAfRzPS7GRXiRu4IMV4lfJ/BX/jQexY7w/9ua/dIGeT3V4496Iy1e/AbhfNjdeVgO8dWrZH5R9SMaYFEolKIWJOvmWtmaJVbtUXli7GwXrqfUPGvEdQHXJoygC8ErRiF1oW1eYpdxVlJSrKA6nW5k/q5nuDWaZHFSEd/ZfjIkYxZGB4malXs5DLjImKRbm/oLR3AUciekOGlCDUBPCu9lPB1B6t8Q++Tybg2+/c7rCtgApKGH3WEsVoA+q2JdNFTWikwDlYbg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9567.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(6133799003)(18002099003)(10067099003)(261021121427099003)(3023799007)(22082099003)(261021123027099003)(260925021911599003)(260925022911599003)(11063799006)(261009223027099003)(56012099006)(4143699003)(260925021311599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MkszNzF3ZERCZ0RvOE9yWlBVV0xGYWxQVlM0cTFpcGx2SjhhcDBvRTRVVnRN?=
 =?utf-8?B?czVXcXlPTDVpdThDQStRY3hKbDZMa3cxV2dvV1BRRkRqSWtkUnhoLzNUOUx5?=
 =?utf-8?B?L2dCc0N2V0NJTzdmY2YyNk5GcnlNemg5TEt2QWhSUlVMWHFBd2hHb2s2R3JC?=
 =?utf-8?B?VFJ2ZHQ2UXRkaEdySmo3dEdjK1hEUjJoQVFDTXJtYy9xRlJBT1hPSGF4cW14?=
 =?utf-8?B?MEtUOFdUTGJHbmpXWE1oUXY2K1lCQnpzalhUQzA1WllzakpxeFpkeE5sY3Jo?=
 =?utf-8?B?UWNwNnhkbjVVU2dnWHZ2WVRwMm94YlBCREFQTmNmT2g1cVRJRjVGamhkejBn?=
 =?utf-8?B?S2lKUVYvS29SclVKWk93by95VmpLVk05WDlJUlB3bkRETDlhbnVucVFNMjJm?=
 =?utf-8?B?cGFBZTBFM1FjT2MvQmJGSWl6ZGIwbU8vWXZlK0VlTUEvSm8rRmZLWGV3d1hj?=
 =?utf-8?B?ZFFFeEcrWk9GSE9UNEFlbmFYMU9TWCszZ0R2bXZNNjBKbFJsQWlSRkRUQWZS?=
 =?utf-8?B?bDdOVHNxRjNSUVYvbWpGMnJNekR0NWFSZlNlNlpkMDFmdXBORUpuWkd0Tlp0?=
 =?utf-8?B?bWVtVEtvd0FKWXFMVjl0VmxhRVU5M3V5TzczN1FnWDduRmhiZ240Y0I4UDRP?=
 =?utf-8?B?eHM1T09OdnpueWF4c3VhZ1pRUWFhODUzWGdlK3M4OHlmMUttazJLbzVaaVlo?=
 =?utf-8?B?T05CNVJNWk1idDRSTTBNQVB5cnY5K3FINEEveG5DR1k4cDVwY09GNzlaTjlS?=
 =?utf-8?B?a2s3T0lNMWpSd1JxMC9CVmlISXgyUmQrTGdlbnJTbTRDbW5mQ24xVkQ5cG9T?=
 =?utf-8?B?Sk9kMy9Ic0pVS2ZLc0NSRm8ySVJXVDU1R29WVTVRaTVIQ0t0Y0tBTnBXQUhR?=
 =?utf-8?B?aHhzQjJmR1BJSUxpSWlNTXhsOWxNNTNnbDZLMFIzQjg0UXI2SjEyYXNzQ1Js?=
 =?utf-8?B?NVBEaWpKSUZXSkRrZDNFWHRidEZjQ1d0Ty9YLysyQjQyeEhJTU8vcGpDRWFP?=
 =?utf-8?B?ZHRaOGtjNUZqOHNUd01TKzI0Ymhsd2RVQ1dlSkUzbzR2TnNQdzdkUCtvQWRt?=
 =?utf-8?B?dTQ1QzN2M3JsemRUNDJLVnF4TXJqcjNYZGhmNE40UG1DSjNuai96N0ZBWU53?=
 =?utf-8?B?RjZNdjBPeEtYNmFyQzlmMENFYld4eStuTzkvWEhGWFJQaUQvV2NLRWJrN0hU?=
 =?utf-8?B?eVlFTmM1Zm9vRkxGaEFZTWJZTHEvemlTc21Ccm80cENhT1Q0L0REdlUxMERC?=
 =?utf-8?B?WUtCZHFDVjRuYXpkL21INzFFeVI5R1I0MmZjYVloOGVldERqQlowbU9YaVpl?=
 =?utf-8?B?OElPdjZPaUVBYnYvU0VWOTdZaG9DUkhIR2NnNk13WlRiUk1Kc0I4WmkrN2ZN?=
 =?utf-8?B?alRCTXZJN3JRZDlRS0ZwUjExbU9BZG96UXBiTXlPS0VwbVYvcWVsWGE5Ykgx?=
 =?utf-8?B?UUplVkhQWExXU2cyMlE0dU9MVDNkdmJXanBVNkUyRlpySHV5TlhYa3ZlOHVt?=
 =?utf-8?B?N2hqM1B6dnJMT1VCb2N6NVRxOWZIWXRnSWdHakFRV01XTThCbXF3eGwxSW5S?=
 =?utf-8?B?SFZGQnRnbG0zWmhzbERKekl0ODZ3WEEzbFJpb3FaV1FCT0tDWWhxZjNvSGh6?=
 =?utf-8?B?UitqRXhrWnM3TzZQMy8wLzFrakd6L0RDekxXQ2h6K08yOXJydTRlWmc4dDRS?=
 =?utf-8?B?OVFMQVJJN25yYmxmVEljd2psV3RhQ0dqOEdpajAyTW1weHNKQXBnb3BsQ0Ry?=
 =?utf-8?B?RFNQYkZkNWhRSTdaTFltVlFkb1BwSTlOdXZxMGpIU0NFRTRWeHhhbTRDQ0Nn?=
 =?utf-8?B?Mk5pQTBRQ1FrbzNINktTeTRTNnplRzVST25UTTg0ampTc0QxYW1NaWt4V1Jj?=
 =?utf-8?B?NnI0WVdEa3ZVQi9JUlZUUlBnaUlhMTZZTUo5U3B1dDM5TC90aS9Tbkl0M0ln?=
 =?utf-8?B?c2lpSDlQYmlmd2VDU2Fock1ubm4wWnYvN0xEQlR4dlgrMGU0aXo2VFZTbi9u?=
 =?utf-8?B?RStuKzFCLzBuV2FsOXdFWkFiVHhPU2NYS1dQaUw0dGE2NG91UnozSWNBK3RI?=
 =?utf-8?B?OTluUGcyTG1obnpudk4xbUF0R3RPaGlnRjErR21YTVFrWXFjc04xam5ESlBV?=
 =?utf-8?B?ZHN3aURnK1pyWTkyZlgzUU1LdHdPOE1scVMxVzY3SjJpRnlzK0d1Vm9MOGdZ?=
 =?utf-8?B?VWN6bUhLV3FweGU4bXJqTnVHOUJOY0RYY0gzODdkRFUxSEZwVXBiZjhub2xR?=
 =?utf-8?B?Y3pQKzM4MWtVWmRGQmFCSnBQNCtPMDc2VXhHekFmaHAwVzZDNUtsdlkweSs1?=
 =?utf-8?B?NW1QUzRPTTJScXd0SGIyQ09ET0E1dzFkWTZXREp3STNLS2FrVHpZZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c95204cb-112d-4940-1281-08df302bd227
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 11:01:28.1183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 cf4GQn88ws82uqyD8Em+jjxCLK1zjqmfYuId3Zl5aE6fPupRmegNSWDWoiYjX0qoXmYZWMTgZffiiUUw4XQYcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7904
Message-ID-Hash: IAJMV53RNTLMKIEGCSUAX55IBV5AE3PW
X-Message-ID-Hash: IAJMV53RNTLMKIEGCSUAX55IBV5AE3PW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IAJMV53RNTLMKIEGCSUAX55IBV5AE3PW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On 22/10/26 11:32, Vijendar Mukunda wrote:
> The ASOC_SDW_ACP_DMIC1 quirk was evaluated before dmi_check_system()
> and quirk_override were applied, so the pdm_sel fallback always saw
> the compile-time default and was effectively dead code. Move it to
> after the quirk is fully resolved and restrict it to ACP7B/7F revisions
> where PDM controller selection is meaningful.
>
> Since ACP7.B/7.F exposes exactly one active PDM controller, use
> else if for the DMIC0 fallback: check ASOC_SDW_ACP_DMIC1 first; only
> fall back to ASOC_SDW_ACP_DMIC (DMIC0) when DMIC1 is not set.
Got a minor review comment by sashiko review tool. 
https://sashiko.dev/#/patchset/20261022060724.1814741-1-Vijendar.Mukunda@amd.com?part=3
Will rephrase the commit message and respin the patch series.

>
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>  sound/soc/amd/acp/acp-sdw-sof-mach.c   | 44 +++++++++++++++++++++++++-
>  sound/soc/amd/acp/soc_amd_sdw_common.h |  3 ++
>  2 files changed, 46 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/amd/acp/acp-sdw-sof-mach.c b/sound/soc/amd/acp/acp-sdw-sof-mach.c
> index 6855141293e34..2fb5c7ecafd8b 100644
> --- a/sound/soc/amd/acp/acp-sdw-sof-mach.c
> +++ b/sound/soc/amd/acp/acp-sdw-sof-mach.c
> @@ -265,11 +265,31 @@ static int create_dmic_dailinks(struct snd_soc_card *card,
>  				struct snd_soc_dai_link **dai_links, int *be_id, int no_pcm)
>  {
>  	struct device *dev = card->dev;
> +	struct asoc_sdw_mc_private *ctx = snd_soc_card_get_drvdata(card);
> +	struct amd_mc_ctx *amd_ctx = (struct amd_mc_ctx *)ctx->private;
> +	const char *cpu_dai_name;
>  	int ret;
>  
> +	/*
> +	 * For ACP7.B/7.F platforms the PDM controller is selected from ACPI
> +	 * acp-audio-ep-port and stored in amd_ctx->pdm_sel.  Use the
> +	 * matching SOF DAI name ("acp-sof-dmic0" or "acp-sof-dmic1").
> +	 * All other platforms use the generic "acp-sof-dmic" DAI.
> +	 */
> +	switch (amd_ctx->acp_rev) {
> +	case ACP7B_PCI_REV:
> +	case ACP7F_PCI_REV:
> +		cpu_dai_name = (amd_ctx->pdm_sel == ACP7X_PDM_DMIC1) ?
> +				"acp-sof-dmic1" : "acp-sof-dmic0";
> +		break;
> +	default:
> +		cpu_dai_name = "acp-sof-dmic";
> +		break;
> +	}
> +
>  	ret = asoc_sdw_init_simple_dai_link(dev, *dai_links, be_id, "acp-dmic-codec",
>  					    0, 1, // DMIC only supports capture
> -					    "acp-sof-dmic", platform_component->name,
> +					    cpu_dai_name, platform_component->name,
>  					    "dmic-codec", "dmic-hifi", no_pcm,
>  					    asoc_sdw_dmic_init, NULL);
>  	if (ret)
> @@ -378,6 +398,7 @@ static int sof_card_dai_links_create(struct snd_soc_card *card)
>  static int mc_probe(struct platform_device *pdev)
>  {
>  	struct snd_soc_acpi_mach *mach = dev_get_platdata(&pdev->dev);
> +	struct amd_pdm_pdata *pdm_pdata;
>  	struct snd_soc_card *card;
>  	struct amd_mc_ctx *amd_ctx;
>  	struct asoc_sdw_mc_private *ctx;
> @@ -398,6 +419,10 @@ static int mc_probe(struct platform_device *pdev)
>  		amd_ctx->max_sdw_links = ACP63_SDW_MAX_LINKS;
>  		break;
>  	}
> +	if (mach->pdata) {
> +		pdm_pdata = mach->pdata;
> +		amd_ctx->pdm_sel = pdm_pdata->pdm_sel;
> +	}
>  	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
>  	if (!ctx)
>  		return -ENOMEM;
> @@ -419,6 +444,23 @@ static int mc_probe(struct platform_device *pdev)
>  		sof_sdw_quirk = quirk_override;
>  	}
>  
> +	/*
> +	 * If ACPI did not set pdm_sel (no acp-audio-ep-port in _DSD), derive
> +	 * it from the quirk bits. ACPI takes priority: quirks are only
> +	 * consulted when pdm_sel is still zero. PDM controller selection is
> +	 * only meaningful on ACP7B/7F platforms.
> +	 * ASOC_SDW_ACP_DMIC selects DMIC0 (default); ASOC_SDW_ACP_DMIC1
> +	 * overrides to DMIC1.
> +	 */
> +	if (!amd_ctx->pdm_sel &&
> +	    (amd_ctx->acp_rev == ACP7B_PCI_REV ||
> +	     amd_ctx->acp_rev == ACP7F_PCI_REV)) {
> +		if (sof_sdw_quirk & ASOC_SDW_ACP_DMIC1)
> +			amd_ctx->pdm_sel = ACP7X_PDM_DMIC1;
> +		else if (sof_sdw_quirk & ASOC_SDW_ACP_DMIC)
> +			amd_ctx->pdm_sel = ACP7X_PDM_DMIC0;
> +	}
> +
>  	log_quirks(&pdev->dev);
>  
>  	ctx->mc_quirk = sof_sdw_quirk;
> diff --git a/sound/soc/amd/acp/soc_amd_sdw_common.h b/sound/soc/amd/acp/soc_amd_sdw_common.h
> index 9e4c86bed3003..86c8e38a19bb1 100644
> --- a/sound/soc/amd/acp/soc_amd_sdw_common.h
> +++ b/sound/soc/amd/acp/soc_amd_sdw_common.h
> @@ -30,6 +30,7 @@
>  #define SOC_JACK_JDSRC(quirk)		((quirk) & GENMASK(3, 0))
>  #define ASOC_SDW_FOUR_SPK		BIT(4)
>  #define ASOC_SDW_ACP_DMIC		BIT(5)
> +#define ASOC_SDW_ACP_DMIC1		BIT(6)	/* select DMIC1 controller for ACP7.B/7.F */
>  #define ASOC_SDW_CODEC_SPKR		BIT(15)
>  
>  #define AMD_SDW0	0
> @@ -83,6 +84,8 @@
>  struct amd_mc_ctx {
>  	unsigned int acp_rev;
>  	unsigned int max_sdw_links;
> +	/* PDM controller selection, copied from amd_pdm_pdata at probe time */
> +	unsigned int pdm_sel;
>  };
>  
>  int get_acp63_cpu_pin_id(u32 sdw_link_id, int be_id, int *cpu_pin_id, struct device *dev);

