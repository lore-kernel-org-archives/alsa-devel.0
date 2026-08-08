Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF112C5AD5A
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Aug 2026 09:25:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8B8A6601DF;
	Wed, 12 Aug 2026 11:25:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8B8A6601DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786526712;
	bh=3436y/K859SC3A32T7S8Jk2AoLTpMMJWcxXrlNVdISY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=WcYbrUTBZ4rc6jH/xXwenQmvpIUi5GAX4GQLVPJSzS4RtqVOFZOatHNBuqZkXAN+c
	 69XmnmBV2d19+RmPdpyUpmcx7o9eHQ3c5iKpJbsJpTdOSbPvfyOOp0ZagFW1VH9+fo
	 3oRCXOkQ8vUgO1fpuaiciakwnMwkmU0wuhXcSQwI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F1988F80633; Wed, 12 Aug 2026 11:24:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5DA7BF80636;
	Wed, 12 Aug 2026 11:24:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F3CABF80571; Sat,  8 Aug 2026 18:20:25 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.122
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1786206024;
	b=lUVMDGAYw+8bO+QiW7nV3N0+SIzo0ExcIQy4vRkBWNYXQfVYEAZ5M69UIMHxR4ZvDyT2
	 m5npewr7nCXCnwmvdO+FinQHDQ8rtrwXoh24s9Hcyc03z6egvXIgpamFFVXd5WIb+HNMY
	 q98jLABZkkInuRnz6Z8PJ6zXis6Fxdfdjbnlzm9wg3zcig3iMcBfMDukUg2VBfvBacBtD
	 1OYYzL5rx5jKLKPeqbU+ATxo7Q27W7+5sLtAKiAEWGEUOLt+yubG4WxZ6hfl0TC+hs1Yv
	 LspwVggxe2JbUCL/MfnuT4t/XOGnsK0jypSSDAhphtWM36/GSxLQ4+2/OVn5fPcJXcQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786206024;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version;
	bh=3436y/K859SC3A32T7S8Jk2AoLTpMMJWcxXrlNVdISY=;
	b=PDnSoLpTn+IXQCrxPgZgoJ/07/LphUe1wuAviN1tiUs0cGCQnLf5QvBFZ59vXX/IJrFk
	 wrLplR5IasKuyhLHqXj8iQFiSWERIABc99A7Osq4OtYCGnC442o3shwiqF0ge4AnVBuaw
	 YsoMlRyJE/7jJ3J2d2X7WpS/y5tdmRp1RUaKZYDi1VJnEguWSsEBpIPn9/9x1GhAgOLTR
	 vqjWmwtasBN2rHmL2EqUfGXYbaYgXnclCGVzvKBB0nE71CiXA0CgZj4r8+rWTGZ3oVVCT
	 lKoC0BROdUqLoUdaf+2R7fDW4DcXTVubk52y5gke1DG8wYFrtBY0a7k6w83dyXkwynA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=macalinao.org header.i=@macalinao.org header.a=rsa-sha256
 header.s=selector1 header.b=hZYMFKbl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.122
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11023122.outbound.protection.outlook.com
 [40.107.44.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 29A92F8012B
	for <alsa-devel@alsa-project.org>; Sat,  8 Aug 2026 18:20:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 29A92F8012B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=macalinao.org header.i=@macalinao.org
 header.a=rsa-sha256 header.s=selector1 header.b=hZYMFKbl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uDdJxWb6+0DNVzPy3ktg4o9zaVGjqRL+TaglKePUCrUV9Fx8tBBPI2zvkBXDcdumC01AGzYMbB6s1jIDitmOqSl2dk9WQfA32ziflntC1DFaiyWS1s+euYNZjNb4fm6KGmWWwRzfHnKDb5s5EkFLKp693v4b2CGhO0M7rjaUItw6Sa3sbEWrZ2I3K07D9Zmid/hNTs88epPB3NpzOerJkodSVYS+G3TvbZhGsphwadnTZO4p9/gMJj3oJJ8IuN1l1PUbkCIeI0eSfaWozuU4rfEQQ6JN6ZHgQI6wq1zhU7eYv4b1bu3bqKMMKtj5q+3ul61eBqfcdWkwp6Idp/SPCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oA5cVKFxWS0emGOV9nVymwtPIp0/Xc5Q0qzBs4o1BDY=;
 b=fKdb5mlRQjMTqNwziXYIWsvd6TIP978wycy4k3Js7R+/JmzogYAOVEKpcV4WOy1VedrTRbbSHr/+1F3OskdX86UKRjQoeEmPre7iMlzL83RM5DXjrVi39QOCIHckpXeKDRP5GCvKp14PTd6vE9nqaogpu7zENarWiioqV9rM+KA2MMz5PtfajAz5I0PlZ8cmS29BYQt8Tlcku3rI9gSl2mls2YZRznSe2ZrP4Nl7m7P2cFWOFjjG279x+fvZTiuq96PdentjdT4wW2rD7I6Z04szRF29pq7fM/f0aOLUtWMGn7FUsE6brxSjL/lgrxPMNuh1ZLz00FUGbPlUk2bZAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=macalinao.org; dmarc=pass action=none
 header.from=macalinao.org; dkim=pass header.d=macalinao.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=macalinao.org;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oA5cVKFxWS0emGOV9nVymwtPIp0/Xc5Q0qzBs4o1BDY=;
 b=hZYMFKblJAfA+XwAVE1z/tF2eh5eNK8fpqQmR4TpiLALvlB5kmWn/8qMMRViBFzYV58Ed1PqhQzkKaCxvhNJl29D2KQAijM5BbqfjI77pJsacY90XCQk18jdLkRt1LJ/itQuT6m805Sep5cIJOXvESIgN3wkOHQE/PjT/hAApDdUpEQ1pCDjl0iM035TdgmOK7S+RZ0ppXi/VqPscH4pKJWiyCaUq3H/j8kWtnP162i47NG7ehMiBdB27BpFEjr4M0/tqgWPXUHFCSvIz+/rpKZ0WYYyWjy3WfXuUJfw89YikBuPH/M3aKaJGTpJtJ86dO8W5aDuPydlcOwysA91qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=macalinao.org;
Received: from SI2PR03MB5290.apcprd03.prod.outlook.com (2603:1096:4:102::11)
 by TYZPR03MB8250.apcprd03.prod.outlook.com (2603:1096:405:23::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Sat, 8 Aug
 2026 16:20:13 +0000
Received: from SI2PR03MB5290.apcprd03.prod.outlook.com
 ([fe80::5923:f4d6:70b1:270c]) by SI2PR03MB5290.apcprd03.prod.outlook.com
 ([fe80::5923:f4d6:70b1:270c%4]) with mapi id 15.21.0292.024; Sat, 8 Aug 2026
 16:20:12 +0000
Message-ID: <1c54822e-8147-4ffe-b033-aa4ab966c872@macalinao.org>
Date: Sun, 9 Aug 2026 00:20:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: usb-audio: add QUIRK_FLAG_ALWAYS_SET_RATE for
 Mackie DLZ Creator XS
To: Takashi Iwai <tiwai@suse.de>
Cc: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 linux-sound@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
References: <20260808070902.835360-1-jj@macalinao.org>
 <87se4oabld.wl-tiwai@suse.de>
Content-Language: en-US
From: JJ Macalinao <jj@macalinao.org>
In-Reply-To: <87se4oabld.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0012.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::16) To SI2PR03MB5290.apcprd03.prod.outlook.com
 (2603:1096:4:102::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR03MB5290:EE_|TYZPR03MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cff9250-6679-4066-ba3a-08def568ec7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|786006|376014|1800799024|366016|41320700013|10067099003|4143699003|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	rGqoaw0vIdnxv29PX6NxZ7qcd4VlqPSwD2wyFgl8B0k+PQz8OsU/2luo439ZkEKnNN67rDjlsgvQFx/ezv5FPaZVPNMRBGkUf/hCvisAesGBH4FV0jH3TbIcDNrGUSpx9xAr2Z/gjXCVLEEnB+Xl937pUtTW+d7NxXINmDHLC/c8hRURfp2GwCUsTxVUYbSWIW6uRDhai+5II8Fj39lk9HzC0Jwgbp002XFb3g0NqLWY95VA/zDSOolatMI7tRXkpakEr8iP82b3H6fZPjUFr+U3vVbNu1nfKi2HLx5KNDBOLYSStDJYIMLKk6Tnvb14YAdigKa/9vG5FXDePdbIr24hLoPRKlI5b9E2kbJ2U9TfJTnY+fjwtbvCsUY9Kc70g74aaSh6CcNO22CgxQOU8xj3FeCIJi3yz26oAjRLog1KTfDm5lzwYoxaOJT2IYGE7LL7qGGwyqY8z2F6ehW1XVD3GhNtYIZCIVWNRLtqLuFubegEbLZYBPszHYUWgOu/an9R4KQUyqGfXWa0CnsgvwZ8VhkAqGLlsGPbS5Gzd5FF3hseS3B86FkHE+ThAtPc3WqK7nOKJRB8ue5sQfTfTkJsjTmoapcMBaN+QOlT9Gj5tRdRPrJM3/QgpvY7NXhczIBetqFoGV3kgPd/701RlbssIgVH/096/mvmqaMEXno=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5290.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(786006)(376014)(1800799024)(366016)(41320700013)(10067099003)(4143699003)(56012099006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b2pGUm9icG5McWFLU1NuMTB1bkM1SXhnaHp5eFlLdS85SDU5V2d5SkNpU2p3?=
 =?utf-8?B?cDlzSzBleXZid3hDOVhUMjN2WHpWcnVWYkxqYkF1cEdSOUpGeEhib1JpRGNB?=
 =?utf-8?B?S20xdkI5anQzUld0MnptdFpNcnN0QzJ6Y1NkYUtUdFlwcmpyeHFUUVE3dXpB?=
 =?utf-8?B?S3dxV0VlUkFQSGFCQzEyK0o0N0xPZmdFL1d4bGJPZmhTcDBzZjdveEp1RFlz?=
 =?utf-8?B?SFdwN01tdmJlNVFNVmVVclhGc25aK1pqb2dHbzB4cU1ETUUyNXZKRCswVSta?=
 =?utf-8?B?aDlJZDFidU9TcFhuN28rU3doaXJ2cHJrQk9VQWNEWWw4Vkx3UytYQldmdWJL?=
 =?utf-8?B?aVhkRTRadk4zV3FLZU9XWDFVeVB2cHloVlVGbEtSRm1EY29pUXk3aXcwaXQ3?=
 =?utf-8?B?dWVWczJRTlJZL3N0R2FIUjEyUFlOaWNRUzZWV0Q1WlNiN1FOQm9nWFpDV0x5?=
 =?utf-8?B?VUNERmZKVFRTVEppOWJxcEVqZUJlTm9WMVNMM0VUTUtOT3BieklNa3dmOHkx?=
 =?utf-8?B?Yjg2a3dtQ05qVjB6TUFyZTJYalMyWnNxcG45Z1NLSFJ5VUdFWHFpVUpFK051?=
 =?utf-8?B?ZUxUMDNQOC9oOVh1SzliME52c2FTN0R6QmZqRytCQkhVeUNFbVNTeVBmWTdu?=
 =?utf-8?B?bTFkMHZLaysvS1JyUWU4UVFSd3RYVi9yT1l2T3VzWkhuUnFmS0VrdStJczUw?=
 =?utf-8?B?cUdOekYrYkNWUHljUWlNWDlFdURDV1V0a3JmM2dkWnBtTk1RQjBXbWkxcnB3?=
 =?utf-8?B?NDVYMHZLQmRveWVRYWJOd0JpU1dxdFcvb1QyK2dJQnNkMlA5Z2R3M0F1aUdY?=
 =?utf-8?B?ZTFLelAwZmwwckMyVzBUa2J6aUR5a0YySk5LTHJCdnB1Vzl3OGM4S1I3UFRk?=
 =?utf-8?B?eHg4amN0K2RoMStLamhncmU4MEdZTjl0Tjk4dGp3MktLRHd6RmFUaC90UHBI?=
 =?utf-8?B?a0w5dnhubW9VZ01PdUZ4ZFVBdDk1R0Rwa2JtaEpySE51S095VjJmT0lwWWtj?=
 =?utf-8?B?Z0xjbzRyYXZpb0ljeGhScGNjbFErbE5QYjNvbU9Rd2xPMk5hMFZ0aHBITmFM?=
 =?utf-8?B?SzNKSnFlU0ExeDJ3ZlZ3YjFtNEdFdG9HZlMzSWQxbEhsS25jYUR3WS9pOERJ?=
 =?utf-8?B?WDNWR1J0RFkvZi9Sakd3dDRqdmdYYmIrVkQ3NFZ5eDhYbzFDM3dUajJBSWVh?=
 =?utf-8?B?OWVnNlcrRnNYNXQxcmI5TEwwdjFaZHpjbjJGL2F3UXoydExmTVFvL002MEt2?=
 =?utf-8?B?N2s3bGU3OVFoL1pSWS9ZMTEydU8zaWVFSkplaXlxc0ZrVFA4TnI5eGZHM21l?=
 =?utf-8?B?Ujl6d1UxSFBKRDFTUjlyVXM2QnlFWjMzc1hkUG9PTEswSThmMTBtaTAzenNL?=
 =?utf-8?B?TnFIdHNaWlQzbDUvOVF4SWplQ3EwUGVlL2Q4Ukx3dEpFd2dPTDRLNmZwaHgx?=
 =?utf-8?B?YWtIb3ljSjVTczBZUUQyVUZkVDl1WVVZRlBTemMvL01GRkp6cTBNcjBXc1dw?=
 =?utf-8?B?c2JGK0pUUlR4aFpDQVFlN0hEbDhlWjhrUHZ6MHp1dFJoS0VxZEtmMHprVml0?=
 =?utf-8?B?UUpZcTYwN0RQWUZCaEdxQ3I5RDlMNTlzczhoZDFHVTJZU1JuU2V4d1dCdjNW?=
 =?utf-8?B?UE5HdDg0cEg3YmNQdWRBVXhjVnZHSjRMazFBV3pyWUJScHZGQ3h3UEtJaTly?=
 =?utf-8?B?K1Nsdy9nNDB4c09JL0V5enhKR2RLaTU1SnpyRGJvS2YzWVpIUjB6clR5R0tW?=
 =?utf-8?B?Vm1SVWtxd3lBVUVjTUwwMUFiTnJZZ3U3bnFCVmZjSk1uOVlhVndUZVFRM3V4?=
 =?utf-8?B?VTNOWjBycHRsZUtObXJFSWZ1cUd2K0twWjk5ME1nTWthUEpwOWxUY1VNaEJY?=
 =?utf-8?B?ZUF6QXVrMkR4WVJjL3NPL0hBNWErQUg0WDFZMU1NeWhZaXljcXlqTlFaK3ha?=
 =?utf-8?B?N2FRN2M3cVo2RTFBRFFoREtDZ1QweXk1QjZFRkk4ZkRIdmpBMEZVRWRDS1hI?=
 =?utf-8?B?RDhuckhtWmJlQUprZVprbk5ZZElXeEpCNE1tVXlwc0NCZ1lHeG9jeFcyTVRV?=
 =?utf-8?B?di9SNjArdGJLdHowblhRbWNNN2RFK0JKMzh6am5vMUlqT2NNVGtRUVVmSjg3?=
 =?utf-8?B?b01kMFY0Ni9zUWp0eVhqbzVLRFZVTEs1enRoWURRVG44V1N6Ymk2aUxUTmFy?=
 =?utf-8?B?QzcrUjFja0cvYnIxL3kwTnBnQ28rUlRXZkltT0pGV21ETEcxVURCV3pwN09r?=
 =?utf-8?B?Z09LM1FNcnFXVjAvT0pvQVUvMGxwczEwVkJDalM3MEphcitxSVpSMHhuM1RT?=
 =?utf-8?B?emRib1VJT0o2bVE2REN0VVg4NmxNRVp1Tml3bUV2RzBRS2t6RFNJQT09?=
X-OriginatorOrg: macalinao.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 7cff9250-6679-4066-ba3a-08def568ec7a
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5290.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2026 16:20:12.7904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87e58715-deae-490b-8b96-6d6239d507f4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 XdKFlgg1KnBkZEKkYmeQZi4C6KHAJIaGE+Lp76lJxOoqZGFfRRDHd779aw3H6eIHst+Ptf5jCchxyH6t5nwRvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8250
X-MailFrom: jj@macalinao.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 2FVPKUN6D3LJSQHWNO2IRI45SAKH2ZCI
X-Message-ID-Hash: 2FVPKUN6D3LJSQHWNO2IRI45SAKH2ZCI
X-Mailman-Approved-At: Wed, 12 Aug 2026 09:24:25 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2FVPKUN6D3LJSQHWNO2IRI45SAKH2ZCI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 8/8/26 23:14, Takashi Iwai wrote:
> On Sat, 08 Aug 2026 09:09:02 +0200,
> JJ Macalinao wrote:
>>
>> set_sample_rate_v2v3() returns early when the clock already reports the
>> requested rate:
>>
>>       prev_rate = get_sample_rate_v2v3(chip, fmt->iface,
>>                                        fmt->altsetting, clock);
>>       if (prev_rate == rate)
>>               goto validation;
>>
>> A device advertising exactly one sample rate always takes this branch, so
>> it never receives a SET_CUR for CS_SAM_FREQ_CONTROL at all.
>>
>> The Mackie DLZ Creator XS (0a73:003a, 14 in / 4 out, 48 kHz only) requires
>> that write.  Without it the device drops off the USB bus roughly 0.2-1.8 s
>> into any stream, clearing its port CONNECTION bit; captured audio is
>> byte-correct until the instant it vanishes.
>>
>> USBPcap traces of a cold-booted device on Windows show SET_CUR 48000 issued
>> unconditionally on every stream start, followed by clean streaming.  The
>> device is otherwise driven with plain class-compliant UAC2 - it also works
>> on iOS, which cannot load a vendor driver - so no vendor-specific
>> initialisation is involved.
>>
>> The device is self-powered, so the resulting state survives a USB replug:
>> initialising it on any host that issues the write leaves it working on
>> Linux until it is power-cycled, which made the failure look intermittent.
>>
>> Add a quirk flag rather than dropping the early exit, since the opposite
>> requirement also exists in-tree: QUIRK_FLAG_FIXED_RATE suppresses rate
>> setting for single-rate devices (JBL Quantum610/810).  The two behaviours
>> are device-dependent and cannot both be the default.
>>
>> A/B on identically cold-booted hardware, same kernel, same port, repeated
>> twice:
>>
>>   without the flag  device dropped after 5-6 s, then again after 3-4 s
>>   with the flag     20 s playback followed by 20 s of 14-channel capture,
>>                     960000 frames, zero re-enumerations
>>
>> This change was developed with an AI coding assistant.  The assistant did
>> the trace analysis that located the bug and wrote the patch and this
>> changelog; the hardware testing, the cold-boot cycles and the decision to
>> submit were the author's.  Several earlier hypotheses it proposed - URB
>> queue depth, isochronous packet under-allocation, endpoint start ordering -
>> were disproven by measurement before this one.
>>
>> The bug was located with usbmon on Linux and USBPcap on Windows, by
>> diffing an enumeration capture of a cold-booted device on each host.
>> Verified on physical hardware by the A/B above.
>>
>> Assisted-by: Claude-Code:claude-opus-5
>> Signed-off-by: JJ Macalinao <jj@macalinao.org>
>> ---
>>  sound/usb/clock.c    | 3 ++-
>>  sound/usb/quirks.c   | 3 +++
>>  sound/usb/usbaudio.h | 6 ++++++
>>  3 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/usb/clock.c b/sound/usb/clock.c
>> index 2e0c18e352..647bf55b1b 100644
>> --- a/sound/usb/clock.c
>> +++ b/sound/usb/clock.c
>> @@ -626,7 +626,8 @@ static int set_sample_rate_v2v3(struct snd_usb_audio *chip,
>>       }
>>
>>       prev_rate = get_sample_rate_v2v3(chip, fmt->iface, fmt->altsetting, clock);
>> -     if (prev_rate == rate)
>> +     if (prev_rate == rate &&
>> +         !(chip->quirk_flags & QUIRK_FLAG_ALWAYS_SET_RATE))
>>               goto validation;
> 
> With QUIRK_FLAG_ALWAYS_SET_RATE, calling get_sample_rate_v2v3() is
> rather useless, and we can skip it?  e.g.
> 
>         if (!(chip->quirk_flags & QUIRK_FLAG_ALWAYS_SET_RATE)) {
>                 prev_rate = get_sample_rate_v2v3(chip, fmt->iface, fmt->altsetting, clock);
>                 if (prev_rate == rate)
>                         goto validation;
>         }

Makes sense, just need to make sure prev_rate is initialized since it's
used in several places down the line. Will retest and update with v2.
Thank you.

JJ
