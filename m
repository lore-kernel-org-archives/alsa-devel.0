Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D870ACD5BC8
	for <alsa-devel@archiver.kernel.org>; Tue, 26 May 2026 13:30:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6DF376021E;
	Tue, 26 May 2026 15:30:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6DF376021E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779802214;
	bh=4eGbhLeU8JSfjeWpIIrmLsd/VlqXg6U0FDeFz2urm2A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=kkTvxAte7a32fu3rP048VPfr+/ZBP8dmzGxcIwzVyhmPyHTI898YsGlWYhjVH8zBn
	 e4sZ94KwvdC5ElEqVDUZY82MlcL4R21OZRQtfZluru+pbkZsjB9dUfLxJSjJHbb/Nv
	 irKIZ4yvB7vXW7dZHUQLtq1dn1YqrPnNxkKRUrm8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CEE0EF805F4; Tue, 26 May 2026 15:29:39 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 95B38F805F3;
	Tue, 26 May 2026 15:29:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3736AF80217; Tue, 26 May 2026 15:29:33 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CD3AFF8001F
	for <alsa-devel@alsa-project.org>; Tue, 26 May 2026 15:29:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CD3AFF8001F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=mH42Xz84
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WUA87Is6uMhPwiVA6qlqqYI2znRSaJvz/YCz61LJyUDXEpfhAlE1cn1DXbQ3vAMs00UP08HSAhoq1XdAVgSUcdcKY7a9/YVbO7+SF7AziV/IDeGIACwnCkiEHoxdC1jhfbiznyT6SOfiNF2VlbfV11HqhzeAxHtC9RikPMOpoSfFTCeNEnZyfiWdWA1KsNukM1IEJrYMu9U/bWe0LwbvV0es0TO+/DstE2LwwIUCE45c4CHEYS5UWdk1NO8rbfVEAU2e64EZ7EBycvuGG4UAzv/Od/v6AV8ljmCaH6QY8DGBP6ms3MtElXu4MzsPmOHkHa/9uxXUbQ3eD3w6o1lHDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gS13dIYDpRIiNolVy07lMk7OwrCH4NdtAOrPKYUajr0=;
 b=msDMlObEUJZmIOOcYJMV5kOHf9CC8kHAmizckcONgGitqlPOC1yBH02GGwfiWm/qU9vFJNhq9KTqOJE7s7QaifImsw+6EB7qWWetqDwt4PZ9Rh+OV1f5OB5rXCNqeBM6Sm3Kbyhq/Of1m2VYJxhDZfm7rOYkPQQ8Zhei4iqDR7Ye0fBgpeGqXuUEmFaW1pzXLf9NUw32anvgvfAhUsiZ8Jz1dPTGcWNkMi9vDhSQ1E9XTMKZBJgjryDI3hWcpwNUEuBuFf9+biEjE5ocpG3qPDXbaa7cadj7EyStU0cb4SxSCSDo5aRRElOkL3Y/L6yZVd6l9PEJRfXfOYprIvo/Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gS13dIYDpRIiNolVy07lMk7OwrCH4NdtAOrPKYUajr0=;
 b=mH42Xz84oNRFNBT8xVP0VzyVOOnLYLvAncsZeCojoEKzdjzgpQVy/BOCCUyMLOy+PSSyRWl7ttOU3DtiyIAkDPxOXAp/VRq7jaHcmV3wzEQUNEPwhdjdqc5fsalrQF6wljlJkArq4b0w9OzT0EYigrZTVcZbnvxIQivU8tXHB78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23)
 by CYYPR12MB8964.namprd12.prod.outlook.com (2603:10b6:930:bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 13:29:15 +0000
Received: from BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::8e9c:2f3d:9679:942e]) by BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::8e9c:2f3d:9679:942e%6]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 13:29:15 +0000
Message-ID: <b2b4c830-6f94-4fb7-b5ab-71a6889dd96d@amd.com>
Date: Tue, 26 May 2026 18:59:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: ASoC: Build regression for
 snd_soc_acpi_amd_sdca_is_device_rt712_vb
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org,
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>
References: <21a54840-a7b4-4802-9b40-2c92893e862a@app.fastmail.com>
Content-Language: en-US
From: Syed Saba Kareem <syed.sabakareem@amd.com>
In-Reply-To: <21a54840-a7b4-4802-9b40-2c92893e862a@app.fastmail.com>
X-ClientProxiedBy: PN0PR01CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::21) To BN9PR12MB5356.namprd12.prod.outlook.com
 (2603:10b6:408:105::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5356:EE_|CYYPR12MB8964:EE_
X-MS-Office365-Filtering-Correlation-Id: 91d3defe-98bc-4dac-115b-08debb2ac7e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|8096899003|11063799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	WAKXNpbqiJdtk9qIZz60qpoGceDlK5yZFpoqfTs32A5mBXI5Z6EySXDUzXg8AWWKWVJhKDWN1fWvHQjkQBARKsjH30vPadeXYaMmmVRk0bRoH4BblH2qoGXfN4UjSdFRwAmp4nCJltYRrnXJ9mNwzxcF9BgVjV8lIZlD45mZY97TYmu6qi8p+wU3nWdSZPw9wraRrsyFtqUtglgLyZRwyZHxwgKwRfCUbB2371HIeLp1icQ5mOAHe3pq4LfPRr8xVvWTQeb5ztYXI1TfbiRrjLq/3aqsZyF8JTEIj9ssjEfU5+PvFcNxSp9pDAinTXvX68uBtCwSU6IwhlIJFhSrtYDSQMXvgubthFOtTqFb40a1BXf+AR/UU5sduPZEKnCMQdlCJ8YKTbw7V1ZK3aJjfZaqzQHrA15Pn9bjw680QDDwsnMoPc5tTme00C7YIWpc9HDG8/O38GjrBQrUOHtnKd5CWmF0fwumQwUnNVQ1Qtculb2e0bEv8810Hx8sa3Jmm06Dz0o06Yd9aUh6e9YJQ1sxcM+sKzTFj+s6C4QtTFNxmKOROyAiJBts0S1YWEKF1juUCB4XBYeittphzqGbLDBuhkshiu6Spzh2IQOWEJMdVvqqeBsryY/qJyixX6Wh70TLxTj3G62SyanH8dMMP5ToU2oUN8iAixjt/yRN9htmDFJrGaekZ9cvIe/3rG61
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(11063799006)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TmhLeDFNWFk5WW5BRlBlN2R4c0EwVVJzbmVQQXlkZGVTdThWbWZhOU16TTZv?=
 =?utf-8?B?M29oZE0rb2xhaWFLQTlLMlYyRzR5anhHUTV2NjA1T1FlajVHRWhYS1ZPaXRt?=
 =?utf-8?B?bzFNVkZXaGV4NGwrdnZ2R0Z6NSsrMVhPdlpKMFFmNGJVREYrSTFpMzFBeXVS?=
 =?utf-8?B?c3hFUlY0NXRnQ1FkOWFTOWF3TEF6ZUlDVlprQzRLcTFodVNORWZyTjNnNmRl?=
 =?utf-8?B?Nlp0WUhUS3dBaEFHK0plYnduMk9BZU1DK1dqc2pjTDhzUEM4djhlL05DcDFu?=
 =?utf-8?B?RGVyd3l1d1c2K0VkQnZFTGNNdGVTZzJqNFVVZXd4c09WMVFlNURBVWpHbDFr?=
 =?utf-8?B?UjY4ZHh5T3gxc3VSK2tWNEVUbWlydVZ1eXRobHcrK3EyaFFvZng0MG8zV1FK?=
 =?utf-8?B?MElJaGdtd2RHMktJVitGa3FDcXRqa2FHL255RndNRmtKckU3Njh3cHJVVDZK?=
 =?utf-8?B?QVo3OXNNMkUyeUN5a0NrdXlZbUM0U1dIY3R3YXV4cHJjbkZrY3dRbUxHTGNH?=
 =?utf-8?B?RzMzSUtrWnBsQ1doYyt5dlhidHU1OVd0YVUwY2VrZXUxcUtreSsrLzVHTjZ1?=
 =?utf-8?B?azNsUjVPSzhiTE5SOGQ2MlVHNHlSRnBrMEE0ODBFcGRwT2E5WlNSb1d1VTJ4?=
 =?utf-8?B?U3Y0Q3hZVVJKVEY5RXJySWVmRVhWdWNjSm1YR2dncXp3OStyM3JCdERqbVlM?=
 =?utf-8?B?V3piZmpIOElrYktlTGlROEc0L1lnWXZYaEhsS2dZbDlWY3R5K29OOEVTMUtw?=
 =?utf-8?B?T2hteFVETTIxSzhqSHhob0ZCeFNnUloydm1oOE9LTStWUWFKL2FvRFdSV3Ax?=
 =?utf-8?B?MHJOS3N5MG5ucHdIaWRQTUJGWHdOdS82VXYwanNGTUZjVFUwbzNFSVFXTVAy?=
 =?utf-8?B?Y3RDaGVRaUVxYUQxOFlxSGVJcWJhUWl3MkVWVGNWcExpdUc2UWN6QUd1ZGU1?=
 =?utf-8?B?M3BaTDRNbnR1Mm0rMW5oNWk1QUZaNFVvbjVyS0t4Vk1KaFRnMGRnVmhXdFpr?=
 =?utf-8?B?bnBHa0gzSXUyQkdoUHpaVFNBa2Uwd2Q5cFJZUzYxb3N6QUV1eCs5T0Jpd0FY?=
 =?utf-8?B?R3BjcEdhbklhMzhSc2lQTFRTQXhhcUtxYkN4SU82eE5Vc1VaRDdFVlV5YVc2?=
 =?utf-8?B?eUFkL3hXaklmSEVIUkozTkdUWEFtZXUvOVhiZmZNc01nbnZnTzFpaFgxY2xr?=
 =?utf-8?B?b2c5YjdkWkthVDF6RzMvRGVTc1NaZlNQOXNmZlBUUEpIQTJpOGxaengwQ2NN?=
 =?utf-8?B?dTkrUURLR0t3QnNxMlRxR0FMMjRPM3h5NDFMRjl6SVNnRkN0WWgwSnlPOEgv?=
 =?utf-8?B?d210emVXeTAwV3NsR2tBUmw0bTB3STFwbUQ1WEl5Nm5OcytkeGhyVG5NYXB4?=
 =?utf-8?B?cE9nR09nVUlNd0hkcjdtaDhYZkpzY2pvZEc2d0FWMUxXQy82MUhnS2x2ZHkr?=
 =?utf-8?B?QU9peUxrM3R0NG1LYVRkdnNHcitzS1ZkODl0eDcvV05CNHZBcDFjbU83WlBl?=
 =?utf-8?B?RlpFVm84THh4dlo4WHlnK1lsUStVbWo1VldIY01HaFV2UG9sYVhOWlRzYVpU?=
 =?utf-8?B?b2JNVEJZQ1hZSHZYa1JGR3JRbjF5ZTZyckUzem5uOEdQMU9hK2QraXpGUms3?=
 =?utf-8?B?UTdNRGEvOEdkNU9VT0o1cCt0ZEE2K1ZKVU11eXRIKzZES0dBd1pUcWRjTGdN?=
 =?utf-8?B?MldLMTJzRVhLQU1iRVJJVzd5ai9QL1R6czBKSHFKVk5QUENCODYzUTRwckI5?=
 =?utf-8?B?eXVCeGhZQjBjdzVSRVltRnA0NlVSS3NET3BtYnRxRkF2U3drTXU1clJZWTRJ?=
 =?utf-8?B?SHZSY3BpdUJra2FObTF3VXIvZEFTS3ExdUY1MWpmY285NTErTnlSTzFiMEM0?=
 =?utf-8?B?WUYvVlRNM01ERGEyQ0FMT3p4V2lXM2dSRkdub1lHNFZtbVd6WmpGNFBIQnVl?=
 =?utf-8?B?RnN0VW5QbVlrU25tOTRwQTlkb1J2eUtCdVkyazRXdUx0aE5jMjAzSDNwQ1hp?=
 =?utf-8?B?VlgwaTlSNGJqS09MMnE1eFErWUtaaUJ2SC9sZW1LZFpoa1ZSWVNIUTBXMjR4?=
 =?utf-8?B?cXphdDBqRjIrLzJNd2xEZ3NZbFBhUUpTRW5XT0FlcG1yUmNYYm9iZUduYmx1?=
 =?utf-8?B?Y2hQVCs4dG5kWHBJbzIzR3VOTG9KOHFQcGcyMG5zV1JOOTlhMXAvalFtWFpv?=
 =?utf-8?B?Zm11SUIrQk51cFNMQUd1SG5WUm96aDBCOVlBaVhHTitJajZXbGdrVWxmSGpP?=
 =?utf-8?B?RUJlU3UxT2Fqa2hxVmV3Nys4SXVMM200NnNtUjVrQnY5T08wYU5SYTFHaUVy?=
 =?utf-8?B?eXZrSzE3RzlMZUJma2tUNVhjbkdCRDVSdzhubnpsNy9WMVlYeVQwUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 91d3defe-98bc-4dac-115b-08debb2ac7e7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 13:29:15.5984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 7o/jG99YEqty5o7hPNFFbvqbsV8bllS2PddvPQiwR7LK3o8Oz10aw7yBUqS6c6dfrdXzP1LY7Yl5oqKBkm9Jtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8964
Message-ID-Hash: S5FYZISA7LJ3OQYQQN2F4HTBHBHMB5JE
X-Message-ID-Hash: S5FYZISA7LJ3OQYQQN2F4HTBHBHMB5JE
X-MailFrom: Syed.SabaKareem@amd.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/S5FYZISA7LJ3OQYQQN2F4HTBHBHMB5JE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

DQpPbiA1LzI2LzI2IDE4OjM3LCBBcm5kIEJlcmdtYW5uIHdyb3RlOg0KPiBJIHJhbiBpbnRvIGEg
YnVpbGQgZmFpbHVyZSBvbiBsaW51eC1uZXh0Og0KPg0KPiBDT05GSUdfU05EX1NPQ19BTURfQUNQ
PW0NCj4gQ09ORklHX1NORF9TT0NfQU1EX0FDUF9DT01NT049bQ0KPiBDT05GSUdfU05EX1NPQ19B
TURfQUNQNXg9eQ0KPiBDT05GSUdfU05EX1NPQ19BTURfQUNQNng9eQ0KPiBDT05GSUdfU05EX0FN
RF9BQ1BfQ09ORklHPXkNCj4gQ09ORklHX1NORF9TT0NfQUNQSV9BTURfTUFUQ0g9eQ0KPiBDT05G
SUdfU05EX1NPQ19BQ1BJX0FNRF9TRENBX1FVSVJLUz1tDQo+DQo+IHg4Nl82NC1saW51eC1sZDog
c291bmQvc29jL2FtZC9hY3AvYW1kLWFjcDcwLWFjcGktbWF0Y2gubzooLmRhdGErMHhmMDApOiB1
bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBzbmRfc29jX2FjcGlfYW1kX3NkY2FfaXNfZGV2aWNlX3J0
NzEyX3ZiJw0KPg0KPiBJIHVzdWFsbHkgdHJ5IHRvIHNlbmQgYSB3b3JrYXJvdW5kIHBhdGNoIHdo
ZW4gSSBlbmNvdW50ZXINCj4gdGhlc2UsIGJ1dCBJIGNvdWxkIG5vdCBjb21lIHVwIHdpdGggYSBn
b29kIHNvbHV0aW9uLg0KPg0KPiBQbGVhc2UgaGF2ZSBhIGxvb2suDQo+DQo+ICAgICAgIEFybmQN
Cj4NCkNvdWxkIHlvdSBwbGVhc2Ugc2hhcmUgdGhlIC5jb25maWcgZmlsZT8gd2lsbCB0cnkgdG8g
cmVwcm9kdWNlIHRoZSBpc3N1ZS4NCg==
