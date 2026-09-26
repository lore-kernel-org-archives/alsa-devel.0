Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66214C98328
	for <alsa-devel@archiver.kernel.org>; Sat, 26 Sep 2026 09:00:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2C23560183;
	Sat, 26 Sep 2026 11:00:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2C23560183
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790413231;
	bh=g962SAQ85z4S18hw+OsIKittjcAxjnMPJ8B5PwSweSU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=W479eoAcK6jIZI8sPGnRZix/AzjjeqpT670r53FyPVPInSBJ4yU9J/g1F456zWOUn
	 r2hM0wLCq2Oe3MUXixqVDl3I9WIJwycCgHNKK+WKYrRQpGh97K0KzwXEgTozcPjkHY
	 u3QMY0yK8QO9nvdQcl9ARjnDuNs9/5V2+jT6c7gE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5845EF80600; Sat, 26 Sep 2026 10:59:53 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BB97CF805FD;
	Sat, 26 Sep 2026 10:59:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B47D0F80423; Sat, 26 Sep 2026 10:59:44 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.71
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1790413183;
	b=WU4fuJZXZ6/7Pyz016M5rBjbKkBQtDwFtLd/wP6mYABmL7bpJ4479Ei2B8Fm3Bf28569
	 Rl9dIBJIHTkd4LEMOXzCNP7409noiBBOcfGgDHeY+570Krgv78LxUrmntPVYUq0AQF9q3
	 dAkLWzZTfj6jxKXhR4UmXnUkoOMYljXG4HWvQJ/g7aHsmoMCXPlRrUYVL2sXCRFU4Nni3
	 d7b+WJxjpiZAqt05ap8XhGDtvWu2zv+Ea0XyIjKeRnkcNqVO+UTx/RpqD3J1HwT3oO0hn
	 wDTysF8tKADVjphSIT5dZLGAb5j9vHbiG/eYWeTk354RmHeFDXcuiSoK3Xgh+zad/XQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790413183;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version;
	bh=g962SAQ85z4S18hw+OsIKittjcAxjnMPJ8B5PwSweSU=;
	b=h/EzInDbnr63zBn92PoQ0xAfV261k4T3kHjCH8M8ZAjMmkkh7j6irCjl5OpamWb1ru8Q
	 hQnj8r43m7jVt2nvwwnIVDANxfed3BLvMPzSII84uw2Iw6ClUSlyyWBJTx0cMY2EuK4UB
	 Dtjpv9h0JpwQddQIFFkZYuJHH7QzKp/n6+4KlOdPdOCmvyBKLw49zQUdly2MFtXmdpMC9
	 l60bUvevHdV3Dx5fvKZ7jToXcY0HXvWah12hx720CttCFhHm9Z5LTnRiDh1R2ctAP2EO1
	 O2f9jyFNC/JjDgNu6SbrA0KnwZXGsKUbT5KB/hQVF2c2H6EuGOhM+R8c4pu315Vj1fw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=czJU8aI5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.71
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012071.outbound.protection.outlook.com
 [40.93.195.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 56ACBF80153
	for <alsa-devel@alsa-project.org>; Sat, 26 Sep 2026 10:59:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 56ACBF80153
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=czJU8aI5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcXpjRv21BPZopF6A+gIkW5q8VKSYf/U/uxAOcH4qYmsbjHqpUiHCyO8mO4h7AcXwoXFzgSzCRdjQykxGA6akpVjN2c6Zrmo0jVid1sg6DgcukcAXtqunZgnnh+rX+WeTPaPRyswJz9itbjBOblJOTpPX8UVUrU/ucLTrGLZNf+ejfh/yfPi7OAAud+nmbAewv9SFnoE9bbf674BdGjCu4OHwP+b2izwDzkD/8/7ilAx/Q+Xyl8AxEvc1SIISKy5Njs+S/rIY5hid2rajPqOcLcBYk558hOncKQr9LEqylwMh9pEw/6kD+DUDMu7T3XoqZKvVi0e2/VLrA1nued82w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XY/c3TZqGf/GoxuGIDyciXEkjNnKaASIihPYMyzIsM=;
 b=Dld17wZuC3yaKokajX6ggiyUnux2tAR1v7Z7WvRsCy1gVvcEy5HJQPMvFU80DCbVrF92QN36JQ70i7MdsXdU3bjrEIZGMPov5BJ4FUsTwVkRP4qLnqpUSNqephiiX7by4cmcUaSK/uWdXYxSYN9B/nlpKJNmkhzs0+JbJRhhJEURAs56wcxuC19RHeN6nWjbcJ5orySJsuXXagv+qfdrJ2FCrY5MeJOfPnBih5X04N+xd6N7SGN+kRb2fTlPx7P5a/wYpsKvQdxRIwfrRMwGmkjHEst2Wb0/cuMtI61xQ3Oy/JnKV/uZjyRyM6sfduy5YVOdV/AGSVPdBPP4MzPwjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XY/c3TZqGf/GoxuGIDyciXEkjNnKaASIihPYMyzIsM=;
 b=czJU8aI5DJCK5EnA5U2rquofEtdGuMQzOo4eN8BSHDNobHvzGnSdWCpPBf1l6RH3IwP8xjqqud76iOy0/VTMcm8gIkCg9oRWj/3gqurOMsZGNdGYt6N2ybWcCiZyJjH9hRJwEGzkMDnkZfnIaqqnRZNL7WQRdKokojsPYFKSPFs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 MN2PR12MB4318.namprd12.prod.outlook.com (2603:10b6:208:1d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Sat, 26 Sep
 2026 08:59:37 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%4]) with mapi id 15.21.0451.014; Sat, 26 Sep 2026
 08:59:36 +0000
Message-ID: <305d8770-50f5-4489-a901-f73069a1b964@amd.com>
Date: Sat, 26 Sep 2026 14:28:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/9] soundwire: amd: SoundWire manager driver bug fixes
To: vkoul@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org,
 yung-chuan.liao@linux.intel.com, Basavaraj.Hiregoudar@amd.com,
 Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
 Syed.SabaKareem@amd.com, Mario.Limonciello@amd.com, Richard.Gong@amd.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260917083732.3803526-1-Vijendar.Mukunda@amd.com>
Content-Language: en-US
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <20260917083732.3803526-1-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::17) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|MN2PR12MB4318:EE_
X-MS-Office365-Filtering-Correlation-Id: 561a4bb2-f500-4732-537a-08df1bac7d55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	idxTcXVGI1Q8BPansI6zNadPcf6e8h4wCjrdjb7fqprxxqH6o0fHoCgjMU/uFjtLxygGCIaiUqE/wFsLdWkOGVmolL9khqR9MkF/z9C3VetGe6iEfYeZ4cQ4687G7Gb/gAcfSy2aqQZ7E+iQPrv1ArmKpQGYyNKL6TjEa18S3noRDtqPasECl4Hq51DIprfYCrTBvUAk7iE0YBZ/8t9SQ7WQ4WGKl7rK2HRjM+URETUjOUapp3nPF3XkjepQlHHFWCBXdQw3gs1F56rJjFxYL8X3ErVZ5pWsN0iK3HULFUlJjTbzWmTa2BTtN1/ufkl1tXW48LYCkf+whK9uPcPDRpmgN3t+XbBQGVnhOi37+ivLkV1kOKKHNz2w327pWxT2CKNWeKVs3wAq15x1RemGslwhog3ajqd9AoVpljGlff//PHAFOF3SSCjuGnw3rtmYgvFIiffC0bhHhTg4uYq7gdl5fgS5FPtZ/AnAx0cdeer8b7X6ezcmHdsbcXvrhMkT1/AJlQuCRAOujZSICoij5dH7nZSzlWnhQO4tNDlCE1bFvjwHOVckF3Qj9WjsbgKovgxt62gAJ5vieKPGQLcjtbjMRPqXyEcsxi/yac1rSaj5Jk7kLkY1/MPYINVPOFzaIMdKjS8ULRwtJ/NCKHG9YSAz9l2eTqJ1Tm4hPu2Wfwg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9567.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V0xmN0ZKdEI1YVZjdnljVlNKZ1VHMTNIREVZNVJrRG9LTmsxdXVaaEFoUTBm?=
 =?utf-8?B?SS9HSXluY2xCTk1oT2F4NklKTHFNWGMvSWdXQWJmTXdncVY2UDRXMUZCWFZY?=
 =?utf-8?B?bEZsbGxFU2JKcDZVYm40bFpLVTdpMksrb3BLUUFxYTFVLzVNcmJsemdxZUo3?=
 =?utf-8?B?emg3OXBBSWpuOXVmdFI2MmtDNHpxQzJNOUF6M0xJWVUwVWhSSERUS1hJWW1x?=
 =?utf-8?B?Q1Y0OW1FT1BDbjUvVWxhSWw3MW1XRUF3UzVuTWNPdERISmQ5Tithc09FcWVK?=
 =?utf-8?B?TG9CNmdvenRSYlVxcTJFN1d2cUNyOGpZcUtKZkp2c01Nc2JkWVZ6MHJlQkhG?=
 =?utf-8?B?SFllMVNDMjV3QnpwTklSUUxFRnZWT05iRFRrQVkvM3l2OGVCeWtaeFF3NldB?=
 =?utf-8?B?VFJQOVdBYkJTT1FqcUJpK1BpNHVVd3RRVXVKMXl6NkNYWTBWWDNSV05JRWxn?=
 =?utf-8?B?SnVwWXFvRmJta0lEdFNFaENDMjJpVGsxeGJoQVpYaU44TFZEQnFabmR4SXU2?=
 =?utf-8?B?WWhYME01Z0RneVNveGhvMWxaS2xyMlFWRGtrMVpDUWo0SGNIdVlZa3ZEc1g1?=
 =?utf-8?B?SkY0dU10SnZLdjJpKzR0Nk4reWxMY1lFVytIbU9xaEZEZ3J2K00zSHJpVkJ1?=
 =?utf-8?B?ZmhoaUpvYUtnTmt3cXNqbE1jdXBuZ0RKbWl2MW40SXdpdFZ0Z0RoL3A5VFRJ?=
 =?utf-8?B?S2FSbUdIVGpaNGd1b20yQUFLQzBCWVl0THZjQ1BnYUZ5bmhud3ZRNkhBWFQr?=
 =?utf-8?B?SGlmdFRyM09ybHd2c1UyZDRxcmtGekI1cmFzWTduNGpZK3l0TkxrV3JaY2ZQ?=
 =?utf-8?B?ODRWK09RaUE0SExodkxQWFlRMTMrVmVpZnl6WDBxak8xUUxKTisrYzFaTjgw?=
 =?utf-8?B?V3p0VEJEZTRoejIvS3doSHpNb3FmN0h4THpwWG5ESHN0WTcyWE5oeFN6TU5M?=
 =?utf-8?B?dU9mUUgyRnRFbVovenlQQm4wYUdNeVpBSzMwbTdPekl4djU4cXI4cEtPaEtJ?=
 =?utf-8?B?c3lpWHRjMmZoa0YvbEs0VUdqNklaUUFLdThXY0JHekZ3VTVvMGNKaG1nYTZD?=
 =?utf-8?B?bHFEYi9ldFhudmFBcUo5K1pYamhGZjlOcU0rUWxGN09aVzFScmtVNnlpcmIy?=
 =?utf-8?B?Y1ZJOUhrTzlqQWhWeUk3a1hGUlBzOGZmQ0hpb2V0NFgwY3M0dG1kcHVLUGZ2?=
 =?utf-8?B?Q0JMUitBWVQyN0lrWHJIa28rMXJWSmtuZ0RSY01aSmx3aVVvcFZyWWtlV3ZD?=
 =?utf-8?B?YnRBWVIwL0VhUThUNHgrbWRJR0hCV0hlczZDRXorQnNhU2NlYlo2cWhtYnVR?=
 =?utf-8?B?WEE5ZkYySzBIYXlGUXl3ajExTnJUQ2pwOEZuUUZ0dzZ2eEdoU1ltTEN0Z1Az?=
 =?utf-8?B?d2N6ME9Ka1BKMWN0WnRRVFFxcStJNWxNNisxKzB4c0U2Mm5aSmMrZDlCeHVr?=
 =?utf-8?B?Nzh1eUF2by9iYzVMMmtaNm5IYm1sc3QxcmJOa3BlR3dobUhuMkozN05ZT3BJ?=
 =?utf-8?B?TFhTd21veUF1Wk5jVS90cXNoR0dtS2JlRWNtUUdxQndtQXJmcEpTTU0xSzFw?=
 =?utf-8?B?ZE5DZmU3dDlXOU9VbSs2OHUxZTFleFRYQ0pZK2VrdWdhQTRERU9QSUVTNXhk?=
 =?utf-8?B?M0VGL3dFc3R3MjNrY1hZZkhBUXI1WnVaaGU0SzZGVnZDWEN0ZVhFQlRrN2li?=
 =?utf-8?B?MkdCVmY5WStwRHBuQWdjNy94Y1FhK1BxWS9JVEtrUTVIbGJlM1RVNXZJeVY0?=
 =?utf-8?B?eDM4QkI3eVpwTzVzaHJ2WHUwbUdTTTNyTm5QUUVHZDNBd1E0ai9DMUNtMkVQ?=
 =?utf-8?B?andmY3pWaXpLN0hBdDhXbUJ4M1p2VlhRUU8xRGtPNzNobHEyeE93czhSNHJW?=
 =?utf-8?B?TjVWQjNWdDloVTZqTXF3ZjJqZHRGK3A2UmJqZ1hrcTRTc05PaVBkMlN2UHRP?=
 =?utf-8?B?OW1xK3RQOWJUZGhFZWRoeWdmRk9xdTJ6RERoZHErbDRrTnlKSUR1SHZMWmlq?=
 =?utf-8?B?UWpFUnEzSnB1YmZxK0YzY3kwR3B6dmREWi9LQzExWk9ubEhIYjZFdGtLMXYr?=
 =?utf-8?B?M21nY01aWEtQU1B1K05MRkt2QzZzbGltNmF2WXM4KytKMTh3eU5ycEoydTJF?=
 =?utf-8?B?aUZsZHJxMzBqTHpKUEpvaUhGRFFzV21BUkpDUWpPanNFUjFyZ0hoQ1B2ZWcz?=
 =?utf-8?B?TXRPZDA0SkkybWFYcW05dTdJdWR3Y2kwcDFsZENBeDlQZFBOZ3JuTXpDZ2lo?=
 =?utf-8?B?OVZ6VU9yamNpa2xncDI2YStQazNOeUlpTDFycFYzS0o4SEF2bzhxTmFsTVIz?=
 =?utf-8?B?T3dzN2xoY0FsVE9EQy9ZUGlpN3BRMStIdm9zSHluKzFpVDMyNFRDZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 561a4bb2-f500-4732-537a-08df1bac7d55
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 08:59:36.4379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 /MSQ6MfMLX6yGD3GRRBJlh/sYOj1Zx2ajyomt7GYpiA0WzTjpHBvYxE0LZpnTIUSBt7h7NVehB8aI8Xynue+Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4318
Message-ID-Hash: ZGPXETK27YXBWL7F7MJVBXW2R5X4RF26
X-Message-ID-Hash: ZGPXETK27YXBWL7F7MJVBXW2R5X4RF26
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZGPXETK27YXBWL7F7MJVBXW2R5X4RF26/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 9/17/26 14:04, Vijendar Mukunda wrote:
> This series collects bug fixes for the AMD SoundWire manager
> driver (ACP6.3/7.0/7.1/7.2). The patches address correctness issues
> in command response handling, slave status caching, work-queue teardown
> ordering, resource cleanup on probe failure, and power-management
> suspend/resume sequences.
Hi Vinod & Pierre

Could you please help to review the patch set?

Thanks,
Vijendar
>
> Changes since v1:
> - Update comment for ping_slave_stat variable description in patch 2/9.
> - split the remove path work drain and pm ops guard patch into separate
>    patches (patches 3/9 and 4/9) to improve clarity and maintainability.
>
> Vijendar Mukunda (9):
>    soundwire: amd: fix SDW command timeout return value handling
>    soundwire: amd: cache ping slave status to avoid spurious disconnect
>      on timeout
>    soundwire: amd: fix work drain ordering in remove path
>    soundwire: amd: pm_runtime guard in remove path
>    soundwire: amd: fix ctx leak when sdw_amd_startup() fails
>    soundwire: amd: propagate amd_init_sdw_manager() error on resume
>    soundwire: amd: drop amd_deinit_sdw_manager() in POWER_OFF suspend
>    soundwire: amd: replace >= ACP70 with explicit switch/case in PM paths
>    soundwire: amd: fix interrupt gate and work drain ordering in PM ops
>
>   drivers/soundwire/amd_init.c      |   9 +-
>   drivers/soundwire/amd_manager.c   | 204 ++++++++++++++++++++----------
>   include/linux/soundwire/sdw_amd.h |   4 +
>   3 files changed, 149 insertions(+), 68 deletions(-)
>

