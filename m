Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD22C43458
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2026 02:07:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B99C76022A;
	Wed,  8 Jul 2026 04:07:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B99C76022A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783476443;
	bh=EKHK4zBvg41Brru4MF1qdLZibIGtkz8mkMSucBOdRoo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=UYWcsaXs1+IZeaKBAddlXdpVQfoRwoNhS/9sOzXxLLFfUDYoe9SR66xJogjBPB2ln
	 JlXAZx7KaDHOVwh5oZB5+2+VSyzPJsZhJMlre2FMPDD2MmYWPJmfvUZGOcKo9+6LhN
	 IJTdZ7gprIx4KVN87AWcFX6KnvaPD3r19wh/uld0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6D1EDF805F8; Wed,  8 Jul 2026 04:06:49 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B8EC7F80601;
	Wed,  8 Jul 2026 04:06:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E422EF8055B; Wed,  8 Jul 2026 04:06:42 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.36
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1783476398;
	b=qqney51A7KDSMfNDvEaJOVMqx6V80bBtdG0igBH2LfsH9uKSqRISwyWvhUxo/SnT10Z2
	 kVtcGEdjv0LitvHH89J9M9A4iq2gPk10HsediJFIGBrJL+4MegW22Tkuimq/uBCDl9VgU
	 DvAnJ95Fgj1jzcE8v6lWnzoGZoz32PylL11Zrcorn1Enp+yJ+EKvmTCDWT+8kFuDyVw4A
	 Py1zihjr4m5VfVD4pkvMIWWC9Tm1PmUX59f+AUqx0Cyt9jcs2WMBF3xpn9DVbsXzIa5Lw
	 7+QCt2BQYUcfGK7p0SHCYVIicr7p5zQ0FpMqiHlLfDotIIMWYvFnWWD3qqpZEeYTWpQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783476398;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version;
	bh=EKHK4zBvg41Brru4MF1qdLZibIGtkz8mkMSucBOdRoo=;
	b=Tq1nDdhnHvucjc+GPuxSqsGpX5/pMGOh8AbqERZwbPB6NuFDnpjxY+FuWtgmogs/aEfV
	 om96yKk46Prid4Iw2pGjGqoHr6EmKUsGtjB0fz4FiqFI0bMA4/IHQtsrJAbj4qFL28wF+
	 8MXJZUdz6agWex9+eWdYBeEfpY3yP1QzH4rn+Nr6GDCVG58FNr0As20ayRUYqdvJVYhAT
	 GPjCqiO5zzFx5mFkzau2lSNSN1JiHL2XF18Y1yOyMLy960dqUv0G99Sbn0DVYBSZHIWR+
	 xeufsJCYpfg8n6KmWaaxafqdpuAvy4gd5bRtkH04Xu5sKK6CZjeb2cjdDFHuRTdcGdg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=NCsGM4rW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.36
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011036.outbound.protection.outlook.com [52.101.52.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 55AEDF800C1
	for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2026 04:06:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 55AEDF800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=NCsGM4rW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=glIvR8JY+LO5BZ/4ji5rWPkSsP9y+OAfbQlGMolSNCc4sjmce+0RgCg1d5xRnP7n8GvUlBgTWyAuXQMu5H/0bhkkPUj1nRkksYd8bQnJoqdmMC9lscKW16QKhKHgJQvI5LFbPnFs2yTFNHbACBnrijnd/H1abWHNuDeVpWS26WfqciFJrGyb2jtjjmpThp7b+dZwISLeaIPFbsRVy/dv52uH4mcBcIswypn+kfBzY5fNzOKBfUF/zl4SiJsmr10TjueEYjoXz4GQEQB6Btmn9BaUBc6LAlQ8AhqXbtStKTJZTOJclx04emfOaaeBb114qnkGzo2VsYSeYRGAHBy5DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bn2ur4enYSuo/eCRWjXePcullVg4Qoc0qY0lg4+HYco=;
 b=hh9OChjXdVc1FnRHcb4PpgAnmdOCQyucI+PiG6UwidXdebPxSCHq08kpJeeULbW0mqf2ttjF/XQAUBNLlcFDbFdRk/GgB6gD7Yjj+ft3f/WUF2itX46FRMy3ii827e0Dc+Cqiw5O1mDOa0ytBsstxc8r7ohTXO6bhOYwoMqBg6+UjjV7FWdO1+uYPN19XF1nELXci7ecczKFqvdX6rVKWOWvOu8KtWjJ065FFG39BiPvkKkzA85EAL4oztF+oNhtzqGX/8xygYEzi0wuNaQnyH4mROO8lfF5zTdcfNxv+33Nd+tWmT9exjR56S0E9N2AhXB5NNtrakNIQV/0M6rXUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bn2ur4enYSuo/eCRWjXePcullVg4Qoc0qY0lg4+HYco=;
 b=NCsGM4rW/zDicwqszVEtx5UaJIlXJdLwL137mfNIe6Uh9G1rDNL8acWFg8yID0lD7ZtJKoW04cEk0ZZyMYyyCeUrKn6OZQVeu1OCujmtR2QXcWy9TPJJhii73n3MKcXa34020/c7lPhnJjIDvGY60XNvxjzP8/Ka4wGSEFOG8FU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 PH0PR12MB5648.namprd12.prod.outlook.com (2603:10b6:510:14b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Wed, 8 Jul 2026 02:06:25 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%2]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 02:06:25 +0000
Message-ID: <2e9e480c-b235-4c39-9dd3-cea5f600cdee@amd.com>
Date: Wed, 8 Jul 2026 07:35:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ASoC: amd: ps: replace bitwise OR with logical OR in
 IRQ return check
To: Mario Limonciello <superm1@kernel.org>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
 syed.sabakareem@amd.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260707060130.2514138-1-Vijendar.Mukunda@amd.com>
 <20260707060130.2514138-4-Vijendar.Mukunda@amd.com>
 <22b0795c-64d0-4a39-8f21-c24ee5a5853e@kernel.org>
Content-Language: en-US
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <22b0795c-64d0-4a39-8f21-c24ee5a5853e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PNYP287CA0108.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2bb::11) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|PH0PR12MB5648:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e0e486d-22cb-4e2b-eb8c-08dedc9583e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|4143699003|18002099003|11063799006|56012099006|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	rXLTI17HH4PP8lir25Lf4pno4Me4z6qbiOgnGnO4zbu0FKrcSRLBh+2X3oFxDIff7s5MWW4kT9WBAGPQ1YegoXsFB25+myDPzJRDOVQYv4O+DUvBL+9oxlxzDMMmueitW/+ZksuodzLXmVMKQ1lD7lAHVqSkgpL25oxujM7FZKpy5zcOmDYIRGTLQKOPOTZ69jMjyhM6dKFORa2KPKCtGLiZ3gkC+Z8nwrVfLbrEHX1GiIaGXYoUBUUYwuhh+QYz8z4f3Qml+E5XeVAKNH0tldJv5YOkG0Wb02CnxAwols8osjf99ITdp9mWlCQmoLOLNWzUH7bUfztssCyviuFqb/vVv0CIfs2hsyXIvgFpKeQzFUBrkC7oCoZy/t4U5Pm3PNzZNJav/+1YAlnRRUp+wpMb7QONQqRxz5u1Y9w6q0AsA62hhqXvlMKFcrDlWIPK+zDjwWkWi4gzmG29oMuYNCziyHwVqAjbISJT0MUGVboXY8VFIkVbEUVzcx5f2MZFrhPIJWbbL7h2kn2gJtWrlcheqPPbmSipbThBDPFzHLQqI1An6vYsHu4z1ybavyrDoJ5nfyA+Cs0Ln3xB390mtOELWLe7epHKmXLERlzdpBULfN+3ZGDNVuDHM94Syb3wtlDNu9ntdKrAtvEOe/CvKL7BjhX/BuSgzvjAnwHeo0s=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9567.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(4143699003)(18002099003)(11063799006)(56012099006)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bC83eERhRzl5Z291VXJDZEc5cjlZbGo1VUlxaHZLeGZ5U3ZnSTkwKytnT0ls?=
 =?utf-8?B?ZGlQWEFJV2dMTk53c281aGlBdWx0a2RmejFuWEdQbHNVMDhFbmxFUTdWbnFs?=
 =?utf-8?B?MkNudjlIR1FMbjR6QWVLeElaT2Z3MUJQWkJLNGJFMk4vTEtTLzhabkhqRkU1?=
 =?utf-8?B?djhZSWEzQ0p4N3lhaDZxTllqU3VjMjB3Rjd6WDlGaXVHR0pkN0lERTVxR0g3?=
 =?utf-8?B?VTdZSFJTMXc3MjM3aGRaWDVHZnBuZVhNUVZTcmppeVNRcng1dDgrbWxvdG5Q?=
 =?utf-8?B?LzE1L0ptZmVjOFFBaERvY0VZTjRwbnJyNXdVN3hiSDh3bWh5S2JOVkMwT2Np?=
 =?utf-8?B?ZnN0V2orYUp0aitYcm9NQit0VTEwb2V3Q1o4SFhQTGJZakdkU3gwTEJkQnFa?=
 =?utf-8?B?SGdORml0cUs0TTN3V2RsOGhCUEs0T0tsWFN3SzcvU095YTFFREhIMkNuaUJz?=
 =?utf-8?B?cC9OQU9DUytzeWVidFBCb0xiN3J0UUFwS01ReUkzQ1g5b3N6N1VWN3o0VkN2?=
 =?utf-8?B?ak04bTJIUjNNa2loMzJYZXZ1SFBJOFd0V0Urdkh4Rm9XVEwyRExDeUZLN0ty?=
 =?utf-8?B?cTRpWVdhTkZxcmVjd3hYZU1objk2M3F5Wit0bTRPbEtXZjBOSldESk85WTQ0?=
 =?utf-8?B?aFBzK3pSWFA0WGltcTFzVVoyNmlPdFlIRjc2R29NZllDN0pmVUpReDJjZGVj?=
 =?utf-8?B?TkhQV2U3QlN1UDJNT3BNWUVUYlNsRitNbXFkMiswWWRnczFQMG4wMnFzN1V0?=
 =?utf-8?B?MjV6aStac3paZlpPek1UL3RmalpkOXdQQVFoNFlxMk5aOFBIaVF3QklrcjRV?=
 =?utf-8?B?Uzk4dkVIbW1ncm82Mm54R2IzSU12b0FiZUNpdVFKYTA5azZHTDN0Z1p0a1pF?=
 =?utf-8?B?UWlmUkJiRWkwRDdoZmVVYjhVVEowUnI3bkdMbGxXa0dpM0pZam03N2FwR0NV?=
 =?utf-8?B?Z2dYeTBTYi8vVWZ2RzZVR2dHaktRREg2Z0l0di9GemRCcGg5OWFEUHhWeGUr?=
 =?utf-8?B?WjA1RVlocFFWNkpHTEk3bEJaTUNVNkZUdzg1b1lPK01Nb0RJcVc3WUJKcW9C?=
 =?utf-8?B?V1VRN1BQVkhSZzhNWDlsOGhZOXBodWFKSEpQSlhDZ0pVSGczUFhuQ2V5TWNZ?=
 =?utf-8?B?SW9FYXNyV29Ed1c2dU5tbHg2NW5VUnpkTWJmNnExL2tLd0Zld3YwS3piY1lF?=
 =?utf-8?B?c3RNWXBhekFZRzJyMlhKbEhETHRYQ0E3Y25paS93bGVPeGFYbExPNzNEOFlM?=
 =?utf-8?B?TVBicmpMcm5ueWx6TUZDcUZ3NGFwamdQRWFQaEVnN2VISlcxejhDZ09tUWY1?=
 =?utf-8?B?dEN4eTM2T3R6WHFYY1M1bEV4WGYxVS8wVTVyS2FRRklCWUIwOUpXbjJEQWM0?=
 =?utf-8?B?eHlQSlZCaGdpVFl0RXY4STNnSzBuVW5NRWJWcDgzY2h1T05zbmxKZnFWYTBV?=
 =?utf-8?B?dVpnbmVNaEVZUmtFT0RocUUybGRRVklXbmdmaHI4ZjFPWEVweTA4cXVLTk54?=
 =?utf-8?B?cjZ1WmpCc1JCQ3ZZb1hKWGxOQ3Y4M2tEdkVjK1F6RDIxSTY5UnNJSWR3NkEz?=
 =?utf-8?B?NVgrcWRkY0tvdjdKUzFWeFRleVdkZndvemEvL1Rkc3lKZXZmeld2RXZzREVQ?=
 =?utf-8?B?Y0l5VHJSeGgxTm4zVFBGTVhGRTNHaUlBS2IzQXAzclA4VkJ3NzNjNGlZWGRB?=
 =?utf-8?B?RzNsQnNLTUZycEZ6Q3A4WGtnK0lhOC9CVStscDY0eTVkUGVsVHhoc3c4TFRt?=
 =?utf-8?B?UXJGbEpoN3FXdmZLSFJ3TS83WDVtQ2NOR2dnQnQwQjBhOXZIQlZTNzVxeUVC?=
 =?utf-8?B?dGJHanpGbXk1L2c1YkpjUG0wT1hwK2s2UlVOdnVuck5wYTVUbFRxWGNLb1l5?=
 =?utf-8?B?azJrUzJzKzlxd2VHNHVCU2EvdFVyWkFPR2xsdG81QVlrY0RDTmVEVkpId2g2?=
 =?utf-8?B?WldEK0IrRW9vMjR1ZkRLM011YkRUQko4dUl0dHN0MWVCTEVnQ0t6V1VHRkc4?=
 =?utf-8?B?OWhudE1VT2M0djFCWCtXL2VHbm1wYm5KTW5ZRVRidGJxM1dSZnV6bHM5MnRL?=
 =?utf-8?B?MTVkRE84QWJpYWJsa25KTEVhci9ZZnNiMGdib1dJU3hqbm91akYrb0NWb1R0?=
 =?utf-8?B?dEMrWGl0VkJ4K2g4VHJZWGd3RlpVWCtWVThhU3hGMWkvOHZNVkVwL3lXYU9p?=
 =?utf-8?B?M0NXODFrRHNHdWtOYVd6dTMwTjlYMXdQOGIzdGN0ZmRmUDdodjBSZjdKczJq?=
 =?utf-8?B?bVN1eFBCV1RkUmhrekw3ZjdkQ3ZIRS9WdWVmYytRMUZTV3FyWkJKK2tHaHp2?=
 =?utf-8?B?dVQ0OFlyc09xWUNkeTE5bUZiZFlCR3pPTFNpZ251TFc3TitxK3pNQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 1e0e486d-22cb-4e2b-eb8c-08dedc9583e7
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 02:06:25.7776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 i+GwafbqqLgpJ8pIF1275VAbhm95qWyEUD5sJMkl8R/sCYBgopwi0ayLvE8zwGEdfPv4yd4U5MP6XixubIZlvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5648
Message-ID-Hash: PZM34MJRB26AHKP4CJEL4U3NGNP3BVXA
X-Message-ID-Hash: PZM34MJRB26AHKP4CJEL4U3NGNP3BVXA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PZM34MJRB26AHKP4CJEL4U3NGNP3BVXA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 7/7/26 23:19, Mario Limonciello wrote:
>
>
> On 7/7/26 00:59, Vijendar Mukunda wrote:
>> The condition 'irq_flag | wake_irq_flag' uses bitwise OR to combine two
>> integer flags that are used as booleans. Replace with logical OR '||' to
>> correctly express the intended boolean check.
>>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> Fixes: 7f91f012c1df0 ("ASoC: amd: ps: fix for irq handler return status")

This is a style/readability cleanup only.
Since irq_flag and wake_irq_flag are strictly used as boolean values (0/1),
using | or || yields the same runtime behavior.
No functional bug is being fixed here, so a Fixes: tag is not warranted.


>> ---
>>   sound/soc/amd/ps/pci-ps.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
>> index 1162d13d8505..729f9aaba69e 100644
>> --- a/sound/soc/amd/ps/pci-ps.c
>> +++ b/sound/soc/amd/ps/pci-ps.c
>> @@ -248,7 +248,7 @@ static irqreturn_t acp63_irq_handler(int irq, 
>> void *dev_id)
>>       if (sdw_dma_irq_flag)
>>           return IRQ_WAKE_THREAD;
>>   -    if (irq_flag | wake_irq_flag)
>> +    if (irq_flag || wake_irq_flag)
>>           return IRQ_HANDLED;
>>       else
>>           return IRQ_NONE;
>

