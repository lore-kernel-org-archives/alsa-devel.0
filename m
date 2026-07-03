Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68756C43458
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jul 2026 17:52:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7FEAD601F6;
	Fri,  3 Jul 2026 19:52:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7FEAD601F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783101170;
	bh=CnD0DSE7baur91R1goB142PzcDTF6wpks2Y9EtapDhU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=R8WSLAk859n5Xl0MaPNAxN8F3bvNsdvx8c8y4uy+hdVzemYn3afySLHONbgJ8ot3E
	 iPxbCyl1Yo9bkg1m5dS6luIulKxj08dEtWR75fIpTXuQTD15d3MFoYEmUxggmUuSbS
	 3KicTqnLhIHm68CJgufeynsjLZP+dx8Gw4gQaklU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 04C40F80603; Fri,  3 Jul 2026 19:52:15 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A4669F80601;
	Fri,  3 Jul 2026 19:52:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 28093F80579; Fri,  3 Jul 2026 19:52:10 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.66
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1783101129;
	b=G0/5NVixuBx/FKHpVv0LBUo47swJ8FEatZkzhrm8tA/brrDDuZWdX2YRWBKHNf5qJ8oR
	 uke0Q9zTknST3rxtDSDb/4xOok9Qc7uTQlRD1uGFtv0r/xPoy1K8IP+CChUJcjuh+/UsG
	 zrA2EfgECNS8fsDf7C1sLaKdhuCYe4r6FizYb614b2vfnw7HjYs4674Vaa4uxjLquEh48
	 3keySMyGR0Fe4QJU9IDA4N+82tDTVEjLHKF5TStAVRURQBayrLBopfAgx8eHZZSZ44E8D
	 Zd/+f5UAx1GBhCiBE7JDHe+ZixG2aKADOIwTs+7ZnWbtuobcH3NTUN+MymhnzbjmqTA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783101129;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version;
	bh=CnD0DSE7baur91R1goB142PzcDTF6wpks2Y9EtapDhU=;
	b=D7tkdMuDb3MC9oZkOo/amGdcaJQkLLWtjpscMfEh3mUfEd1u46xdl+fbIOImng2Ah3yZ
	 cXWyTD/XO4+7UD+vm5Y9YxOB2br6MDj+yThlkUeFdWsJH23dDLrRck0it7w+0/weRWHXm
	 e/Eeo+bmTMHZdWGckz/cgLrq1lMSgU8RByHTaD6nyModaox2d9RLIvieU0Deh1KMmpWLw
	 fE1rwfxYtK7XynR/x0ipQ9jHWLWAoAf2+xHRyMJOTaSeCZ+D9Q6k4MbnULC4eBwSGXHH7
	 /Nn+VBs4xPKBjPbtJjxpv0PS2ykzIixI4qqxKLqi8mW935HoYOWpHV9Awj3ttU7za5w==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=kAUy3QdR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.66
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010066.outbound.protection.outlook.com
 [52.101.193.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2899FF8027B;
	Fri,  3 Jul 2026 19:52:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2899FF8027B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=kAUy3QdR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvDbwWujtkgLe2LgBJbsZgSuM73OqD89sT5Bc0JZv+i6rm8MOaZavmGxBE7h2sAbUyo+evxIRQx6JttT1Ws3funijOa0n87fS/xBFjV/hwU2AhFfNxJ0y5jeVAkhPrf6devljtr64mB336BbZ6zu/x/FnSh28XsxYr/of8xicAzi+VTZR//r9D86nHeMY/l2WeNMT/6yzJNKdlNakXdtS3v7NPNLv0rQYc9mTXrVcHOspKA7ZIyeIHaTPXEMr+qPxWkFkaOX87O+GvcQcCiQPNeyDaz9bqwcKpRHA+2XhquibYz0EoCgRtWi6XN+hRq4mZErCgV6wsR9LaGtbMM5Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNQUThRPbmaFPtVA/6ywA5neDL9jkIjrt56KjROL7PQ=;
 b=iXLPcHanIvQje/R0eDIbZfjVQ0ZiiUQOXcROsELFH7GM+NnaD3cySUfv7mcjaID2tFuKK9q1v9W6kpW9m6K6lJfFESUW7f9gBLVjv3Kj6qSBet+0VLe6y5Z+evlZd5F4wYnOSxVyjKPgXNjbyxs3chtZuyUJZ6s1PkYWDW4l7kpV9200CXhsW6AOSO4OwT2gQTKZSrYqb9Nu5FCmE19FwyHuZ9aOjttLoRfX/K0sSbvXNJrKfou3XTYRiTCeLhX1xnUTcXcHVOp4lEpUwp7jV48aWU+FqGge3FVdDGedXhZ60MTI9DWXjTwKUQZzLlXP+4JY6unXTLEpuOvdk18Zpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNQUThRPbmaFPtVA/6ywA5neDL9jkIjrt56KjROL7PQ=;
 b=kAUy3QdR/jNuvT6U1KbgFpGI8B0SSRk4E06k01AWAhKc5R2MmtLz32XseT2d6hlxE9eaH4em9gVYf7HQSUcXnB7J7ypoDRu9A3Bu1AJ+HwHsdsF8FueoTDJJEwcKtDZAAI5yDds1OKTbv0Ln6vbEcCKETBJBlkdtqe8n6NGk3v4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 SN7PR12MB6715.namprd12.prod.outlook.com (2603:10b6:806:271::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 17:52:00 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%2]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 17:52:00 +0000
Message-ID: <04ffb72b-0027-492d-be0d-4b4178e21e1e@amd.com>
Date: Fri, 3 Jul 2026 23:21:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/16] ASoC: SOF: amd: add system and runtime PM ops for
 ACP7x
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
 perex@perex.cz, tiwai@suse.com, Basavaraj.Hiregoudar@amd.com,
 Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
 mario.limonciello@amd.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
References: <20260701095759.1012929-1-Vijendar.Mukunda@amd.com>
 <20260701095759.1012929-17-Vijendar.Mukunda@amd.com>
 <58e4579d-f87c-48db-9682-fec99c4706af@sirena.org.uk>
 <68d6745f-8bfd-4b1e-b4f1-33190038566d@amd.com>
 <632c9729-3f64-41fd-b85d-18f4437a68df@sirena.org.uk>
Content-Language: en-US
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <632c9729-3f64-41fd-b85d-18f4437a68df@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0132.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b1::8) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|SN7PR12MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c5917e2-c5e5-4dec-9914-08ded92bc826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|22082099003|18002099003|6133799003|4143699003|5023799004|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	yZBDwcUIorPntJVhLSEoCwe4CnSGEBdBwdJu2MhHMRs/x2lhg/2cMQeCp4EMWGUK78ze/wktANUiZMkrushSeyq7xhUtc07SXe/9htNV3tqT7OLpaQ51Nks5pmGQJQN2BexHodytT2ipvS77McClf5+aeELTW1l+8VKRpf2nlSVKyAOGxgJxj/OQsGi9u7/6G2po7MA89CqhnQpip1Gy/7fTqyP8/hCFGUcZAN8jDDr2Sv0f9xhf2yUwr27tFFZ6mBG4su5lw85SKLhCqHqorB0UwqB3/1JCpabwvzT9pQLGem7J6uwEwZ0VnukFnsN6v5NijvB3bEhSEeN1DZ8olCdw151R1Sl5FI10wEhVtIGjjwYtENUXYKNrR5WYEmqED5qt5Yv0LblFgdbQZr4J+hipQyXefrjjSXJcPBGT6o/QlQ+ZUoh6HKEKULJUTBNqYwiNKlO9A32JhGJUkwBQZBCj2tlIfiqmf9vEmbPQckOZcwAdCHhEXh351X3tq2AEg/PlB/RxnVx8kplW9qE1hz4riW0YRN8BzNu08p/RZYZMHqtb2AKuEtNsczVk3FU0fDCXm8HFW+then5S5pwK8vwdgEh2Dtsdv21jFfwzcrhsDFUCO+CZH/etM2hdw68HaEYvXYhFeplZj6vjk3d4S5FIb8XVuyM0b+o7H0mhyDM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9567.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(22082099003)(18002099003)(6133799003)(4143699003)(5023799004)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T1NrdWRXY2pqOUUyWU1vcnpzVWJ5TjFpTW9VVmZWS3M1RTJ5QnRsN245cmdB?=
 =?utf-8?B?ei9KbTJ1eWFBNFZUdzVtYlNHZnBLVHlqQmx1VFIrWC9KY3dQeHNha3RSVDhQ?=
 =?utf-8?B?RXFtL3RPeVlDam9PR2lCTkFIdk5xUEMwOUw1VzV1clpaY3BOSCtSTS9RWlRa?=
 =?utf-8?B?V0NKVXZGTkNEeEZMVGYyWXNCb0NmcWE3cHE0VThMM0hRREp0Z3FVUzNUazJI?=
 =?utf-8?B?L2hrL1hhN0lTMGIzdUNxUGkraDNSbkw5YVZpRVd1Z0FNLzlJdE5OSEovSytS?=
 =?utf-8?B?NVVyb3BOKytPMnAzNGRVWWJ5WTRFaHdFV1NlTy91bVZTSFdWYVh6eE1JT0hJ?=
 =?utf-8?B?dGdkRDdkQy9jVWN0SFV6TXBmMjVSR1ZMWDJ2alcvRW95MDBGN3VBZ1RBUHhr?=
 =?utf-8?B?NW1NOUdWWERIN3BVdjlXU05UUFhLc3phZXpHczZNdWQ2dlhNUEFlNlBwaWtQ?=
 =?utf-8?B?R05qZ0dyVHI3dHlPWDZGYk5sUkp6WW1HK1FMQ1I0eWNJdGZHeEttYU0zSzQz?=
 =?utf-8?B?eTN6VnhuUzJPNitDMXh1M3V4NTRUYnZZNkJlTFBpemJraVZKcUs2bUFLbUdq?=
 =?utf-8?B?SjlFb2pRL3hBbkhNVTlKeVlJb0QxS3Z3WWIzV25uM0wzQ1ZobE12aEpXUGE4?=
 =?utf-8?B?RSsrTXEycFN6aUV4Mi9wdStmdnlkaVM2cklpWGxTcXd5emtMd2RtQWVNR0gr?=
 =?utf-8?B?azhWT3dsL283TURreWRuQjBjbzVCUmxib2toWkJuaXM3UC9YQ29KZHE5UTcv?=
 =?utf-8?B?dzMwazZCUGJEVGtTTmVFamdsN1JwTFhDSUMyL2d3RTVDSklpTVNnRmVDMlRw?=
 =?utf-8?B?N1pzaXkvYStXRzM0eW4wQTlPcHhBTzFLemxqd2kxQ1VMSEJTY2xGV01sNHBi?=
 =?utf-8?B?TWFXUnpYVTFuZEtGMFZTamwzR3VxYXNMODR6YURLUWRPM3FsY1ZGZ0E3NHhN?=
 =?utf-8?B?SVBaR3R3V3BaTmFCb00zTHZ3d01PeVBQWDVONlo3V2pWLzFWQTU2TVNoWklj?=
 =?utf-8?B?RW9JUTFSRFhnMzBhUDZiSGVQMzZHUUFxT09wSG5qSG04ZE5kSDNOUFZ6Q0da?=
 =?utf-8?B?UkxicC9kVGdWN1JqNzFWMEh3bi9Od05MQlQvR2hXWDQ4WGFXV1pHZ3VhMU9V?=
 =?utf-8?B?bDVHb1Z6djB2NTVGQkZuaFhnaFhiekxubzhBclJ5QUVCeVpPeXduT0Z5Nno5?=
 =?utf-8?B?NFdjOUExMDczd0RjM3YxbUVRMkFGRmhZRi9TMjRaS0poSDVTT0xpa1BoUWZI?=
 =?utf-8?B?ZjI3dFBpdVdXdWhNRUR4OHZlZGZjYXF0UFg1c3BNL2ZoT1U5STVVN3ZFOVVD?=
 =?utf-8?B?a0oyZG0yUElwRkZZV21IU3E5V0hiMVFBcDVOUTBTZTMxWVRjTmlxTHlsRW9q?=
 =?utf-8?B?RS9Hc3EwK3ZUc28xR3kyOTk0ZVFJQ2VaeHkwUHo2K2NES2Q3VEN4Q0pmTllq?=
 =?utf-8?B?aysvWUY2Szd4eHZjRFh3WlpZblloMWRLa25NSVhiT2JRdDhRU0tjLzNOVHl2?=
 =?utf-8?B?SElxcUMydTBmblJKU1VQSGxtZnZBYVRrMlhqWjB1YTFVSlpZQzdGZDAxOTNB?=
 =?utf-8?B?NklTKzFtaE11RFlrbERLb3ovNkE2WWNZKzN5NDByRlZYd3JWQjBjWW42blBG?=
 =?utf-8?B?R0N2b2lnQ29yaWY2Ymc2TklDV0k4Ynl4NXdqUVk2MkZrTXBldHNIQTk4YUVS?=
 =?utf-8?B?RDAyVHlQSEVnM1JKYVlzMWZZbTFKU1N4V3VRdDFzMUd5MGxlcjY5VDFWN1dn?=
 =?utf-8?B?ZmozNTUrMGh5UVQwSEU0M3NESytFOUtScEpSNFBjN3RHTnpmenVxZmVLNkYx?=
 =?utf-8?B?OGJmcEtoZG4vMnRQT2RVUmRyS0RIajI5VjBqQWhnRFpxdWVQM01maGt1Tmlw?=
 =?utf-8?B?bnB2UWFyZkJ6MndYZmF5K2hyWVZlaExWQURxa1VzWVhJSHowQ1M5aC9HenJq?=
 =?utf-8?B?T0UyeUtTbEhGV1pMbjk0aFNLb3Z6T3Rhc3VmN1NMQWErVWlZQzgwNHRpYUhL?=
 =?utf-8?B?Y09JS3dlRVdFeHlIUmEvbjIwWjF1Vi9Xck81akgyRG9aT1lDSC9ETUlXZDgz?=
 =?utf-8?B?ZGJJeUJ6a0l4N1V2dUwyQlVneDBQblIrZVU3aTZRYStNYjcxalFFODR4akhi?=
 =?utf-8?B?dnpqbEFvNytCM3MzTS85aEl1QmtadGM3RHY4NEo4elNMbGhnMGFyY0huKzYy?=
 =?utf-8?B?b3IrWk5tSDd6NlNJamJVUWpPTVZDbGNiWlRjYk13QWd1UG42dmdydW84Zm15?=
 =?utf-8?B?UzlBQ3kwbXgzNGNDRzAzTDkyaU9nNThNR1RCanFNZWF1REtIb2hpVDZlZUdV?=
 =?utf-8?B?bSs0NVZCbHVVNVd4U2ZhS0grOGlybGp0M0ZobHdVcVlxV1MxL3RUdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 1c5917e2-c5e5-4dec-9914-08ded92bc826
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 17:52:00.1450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 aWUN8y6YQy+a11BYUYxh4Wf8sRdKj6G1RBt/g8nMDu1HQHp1QMWpZ58r7cdUnDcj1zjoiai2apPC3s7MSZjzuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6715
Message-ID-Hash: SGXLGAIFOCBREEX74OHQSZABOATW5I4L
X-Message-ID-Hash: SGXLGAIFOCBREEX74OHQSZABOATW5I4L
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SGXLGAIFOCBREEX74OHQSZABOATW5I4L/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 7/3/26 22:39, Mark Brown wrote:
> On Fri, Jul 03, 2026 at 10:21:25PM +0530, Mukunda,Vijendar wrote:
>> On 7/3/26 21:58, Mark Brown wrote:
>>> On Wed, Jul 01, 2026 at 03:25:17PM +0530, Vijendar Mukunda wrote:
>>> The interrupt is requested with IRQF_SHARED so probably worth double
>>> checking if the interrupt handler is safe to run while the suspend and
>>> resume callbacks are running, I see we reset the device during suspend
>>> so there might be some risk of corrupted register reads?
>> There won't be any corrupted register reads when acp reset sequence
>> is executed,  all the acp registers are set to default values. i.e Interrupt
>> control registers are disabled. This sequence ensures that till interrupt
> Including whatever the threaded handler is doing?  I didn't actually
> check properly, just saw the indirection through the SOF I/O functions
> and the threaded handler.
|The threaded handler (acp_sof_ipc_irq_thread) can only be scheduled when
acp7x_irq_handler returns IRQ_WAKE_THREAD, which only happens when
ACP_DSP_TO_HOST_IRQ is set in ACP_DSP_SW_INTR_STAT. By the time the
platform suspend callback runs, the SOF core has already quiesced the DSP
(ctx_save IPC, pipeline teardown), so no new DSP-to-host interrupt can
arrive. The subsequent acp_reset() then zeroes all interrupt-enable
registers, preventing any further IRQ_WAKE_THREAD from acp7x_irq_handler.

If a thread was already queued before reset completes, it runs
acp_sof_ipc_irq_thread which reads the scratch SRAM mailbox registers
(dsp_msg_write, dsp_ack_write). After a soft reset those registers read 0,
so the handler finds nothing to do and returns IRQ_HANDLED cleanly.|
>> masks are enabled during resume sequence, no interrupt will be asserted
>> for ACP IP.
> Right, but IRQF_SHARED means it might be an interrupt for something
> else.
Correct. If another device asserts the shared INTx line during suspend,
the kernel calls acp7x_irq_handler. In that case both ACP_DSP_SW_INTR_STAT
and ACP_EXT_INTR_STAT read 0 (device is reset/idle), so the handler
returns IRQ_NONE immediately without scheduling the thread or touching
any other registers. No corrupted reads or harmful side effects occur.

In practice the ACP PCI device on ACP7.B/7.F has the INTx line assigned
exclusively to itself — we verified on target that no other device shares
it. IRQF_SHARED is set solely because the kernel's PCI layer requires it
for INTx interrupts; omitting it causes request_threaded_irq to fail even
when the line is unshared.

We can drop IRQF_SHARED flag, if that is preferred. Please let us know.

