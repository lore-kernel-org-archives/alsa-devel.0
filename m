Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29216606A31C
	for <alsa-devel@archiver.kernel.org>; Sun,  8 Nov 2026 04:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=LtnkrSFc;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CNJKYr5W
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC8DB601DA;
	Sun,  8 Nov 2026 05:11:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC8DB601DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794111104;
	bh=dSkcwMWRZz0KP9OHJkQKQAMxASJW2GoyTRxgpNat8pA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=LtnkrSFcOv/W1FEu2R9NIRX/BB0W/i8bTKbxS15wZyEMEedfBHI+c+k+QGPS4hPgO
	 H/t3vu25bbu2dQp0BnXwsNuQ8UQzxgLUeyUV8ayjWu8jvSqRZYhalflPkuytPncCko
	 dYNsKr0fnrBEyGnmNqCFVZLu+3CvmnSbRfCycWps=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 419C0F805F9; Sun,  8 Nov 2026 05:11:13 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 18033F805F9;
	Sun,  8 Nov 2026 05:11:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2A7CFF80538; Sun,  8 Nov 2026 05:11:06 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.68
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1794111064;
	b=NSSTmBfq5C5UsPyw+4GsQVgamacQW8BaAf6XDtApI8xTJ7P+3TPSZmku22D98vvw9kMg
	 kIDjJkdl84lHIeprQOPgDbIQsEKxE0Ddvh7tEqRWaE5OY8fUvv4p4wgyv0JpZ/ugm6Jm7
	 ysOlM2bJHamitA1c/DKH/5+BkON4QwS4LWSCzimdMyCulOxMRrUP1lym+ywJ4ACqx2/4j
	 PhHz6EQxTIz1S+1TBcUcMTY8zsD4G7+v1IQXw3zRaiXIEUMxNtmd7WZf2z69PQDOZPt8Z
	 Crmz8QcZMvXaVFevh4R7kJKlJJhHcGFDJpjpYmtoL2TPzUIkoCUl1UWHym/qDL2rqaQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794111064;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version;
	bh=dSkcwMWRZz0KP9OHJkQKQAMxASJW2GoyTRxgpNat8pA=;
	b=rmLORvUsF7I0E15Hz62czfJy0lNAOQhBeWtyVAp8BuRWC09RWbADaSwD3XetvODAE8Fa
	 jtSzCzM77J3uElHWLVnDUDOcyRMn1VGdnWVNgW+HdAa8jjVO2xPpgsl1+gaDojDOs3Y6m
	 brYh5T4e6ueUwRGvpXOYLMXfjcY0q7XsY5GtkSZkuOZBTuRg6SD2nmhuFjeTXRVC8nfMb
	 T51xp2csDQhot9v2ujNKzpgNZa8jUhgE6YV92JoyoAUo8kd6DcGQk6piwJj2O5YkoM8z/
	 b2pcztL7GRo726j9vuKatNP/Nk2MWE0KWcOZIdQwaf/ttOXTKjAc3aCAml1ZQJyhSFQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=CNJKYr5W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.68
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012068.outbound.protection.outlook.com [40.107.209.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 44960F80124;
	Sun,  8 Nov 2026 05:11:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 44960F80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=CNJKYr5W
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P0/gpNpyBVxGuaTS2UJC+h3b5Vsa7JMWBYMAY6mc9VJ0P5zHNylBUVYW//h4jCnFXbPOj+Ybg5KjWSzPDDwKhGPXj4O67pBV7uco3NTG7vAKnEeFG16qIJnGhPiRssGiz54atEZqByCC0lRuaThQR/+EiZbrK/dUgzgy5Zmwjnmxvdk63sEqtqE9I5FJwJTi7L5Ymjkvk7lLOxRdCJrUx4CwDEyIpCbbwMexVUCng+fYNulBXiBm5DRZMVxWVjtnRgakeqhGlE+H56f84OB+EeSNmOvedlKANI04FGQh6AJz5H68u/asSE0SSVJ6iTWS2brUwlFkLKd7jabrRTEHBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvEtj8P/HUx4xT1hY2Y9ghDPQRlm+nah92Ga0yiwuPw=;
 b=fteA3r/Mj/Uh8e2pwonnseacf51sUZeXPKeQdnq+viC+ww8Qz3u/yV7i7+zI6jgo1eZHQEtcnuOCVugvBKsxCK7Q8m7fszKrO21Tx+x3qAM9ERlK5WhoVEjVYychXu59pwMs7r5JtLPmn/PO5yrNe2bW32w0miSeTAVVmSUKyy2e3qFvkH59B1HFHsdqboGGRucMos2WonKX8ShjgnAJrj2CXQqCkYddaYTyXI0iTxMFJ2CtYcELB5CSA1F2OPwtSzdrGJikbnjwAnGLr8/G7gDklMhTYh81KxvgZJmhduahP1wW3aqa1nKG2WSC9zDZYDE8UqeCLufK8m3oZtkKEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvEtj8P/HUx4xT1hY2Y9ghDPQRlm+nah92Ga0yiwuPw=;
 b=CNJKYr5WYwfO5z96gAFjaeO6jVaN7MMvPs/03fWLUA306fjulzxM8ovH6qibufClvhDnjttZJd1YIbRpKC6Cg3QJEOLDmewHK2L/Cnwau6sbwUiO+2R8ElRrd+dL66xJ9mrzWNt5txa+z/WbvGX7RWgXD0VZh51qgO6ZitL3Jvc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 04:10:55 +0000
Received: from CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2]) by CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2%4]) with mapi id 15.21.0592.009; Sun, 8 Nov 2026
 04:10:55 +0000
Message-ID: <22ea1b39-b4ab-47e5-8386-c8320ec7c087@amd.com>
Date: Sun, 8 Nov 2026 09:43:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ASoC: SOF: amd: guard SDW IRQ work scheduling with
 interrupt_enabled flag
To: kernel test robot <lkp@intel.com>, broonie@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, vkoul@kernel.org,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, yung-chuan.liao@linux.intel.com,
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
 venkataprasad.potturu@amd.com, Syed.SabaKareem@amd.com,
 Mario.Limonciello@amd.com, Richard.Gong@amd.com, Poojitha.N@amd.com,
 lee@kernel.org, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 sound-open-firmware@alsa-project.org
References: <20261107175339.3547918-4-Vijendar.Mukunda@amd.com>
 <202611080910.HG54RIuC-lkp@intel.com>
Content-Language: en-US
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <202611080910.HG54RIuC-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0047.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:271::10) To CY5PR12MB6252.namprd12.prod.outlook.com
 (2603:10b6:930:20::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6252:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 1adae1bd-7d29-48be-b48a-08df3d4e490b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|10067099003|11063799006|4143699003|56012099006|261021135927099003|261021133027099003|261021130227099003|261021123027099003|261021121427099003|261022113327099003|261022105027099003|261022075727099003|261022115727099003|261026130827099003|261009223027099003|261026140227099003|261026135527099003|261026121527099003|261028144727099003|261102123227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	faonvJV4EcQqIY2BKY/a92fbj740AL1HDZ4b2sNa7UaBC/yVfL8kB/Kt54CTVaftgMmt2AyuaKS1e6gLzKvaI4QF/iFeKmUVpKQaNf/mw9F7eM5DV9jXRWvrQnCpsNLrUo/K1x18cz6ijIb7fjL4FmLPP/2NjNzTHGsCh6nFps/aFFtt8GckAJdatUpGniNW4gZUOsyQwgBkVZUvADfHT00zeI1Uco1PD8qHe67xl8ITLJeLi4BUmFeL/Xaeibz8E0aPTM9m2k9IFqSR1oDoQT81sNKwuwvID+kcjXcnYVrdSYRbmpDo3OX0l19fDTE859fcBZib0ULjp4voLEHPGnkO3vfq8Az9tGZgkssrhju9X/r44GzIycXi4KXgVrSkDTC8/RWZqgW1QqrYIo9Zh+6VmGb33zdUXWH4HGORI+Xn9BKkAERSo+jBwAbmg+2B+3W2khh0QoryqmG4suPp5lEbekgeL/EHjPvzMNSHOOWuIyZu8hT6SxhPSc5yHRyr49AXTe9WhoQk0r73guP8a04+pTdZH4IGHY7NnZquwq8u/T/VnGauv5CgldHOlEMnFiyDJtIovVuLLWnQCeoGzgyVQyzHyFeoD/fXj2R3Lapsq7cQ5rNhMgRW/Expoc4C
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(261021135927099003)(261021133027099003)(261021130227099003)(261021123027099003)(261021121427099003)(261022113327099003)(261022105027099003)(261022075727099003)(261022115727099003)(261026130827099003)(261009223027099003)(261026140227099003)(261026135527099003)(261026121527099003)(261028144727099003)(261102123227099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WG9DQmZKaUNDKzlvemxKVXpTZVNhS3VKRzdCVnd0OGNSdzlzcGFMOG52c3lr?=
 =?utf-8?B?MVVnQytURW92aHJQQ2JUVC9tRGRmNmVwWTYrVGZJdmJMcmhqdkRPb1Q4enl0?=
 =?utf-8?B?ci9oamNrNndObGJHZXBDMHZtS0xOYzd4TlFOZDJnMmRRR3d0VjJGSmovc1Ez?=
 =?utf-8?B?S3NYRTlBY2NOTDFYNlZkaFpWQzdSUklRanNTT1ROK2VVR3czU3RlRXQ1RmhF?=
 =?utf-8?B?S3RPZjh2SnlIdVBLOG9tTjZBZHJYQTBzTGdZN21XZ0xudDFQWjFFdzNsWEl3?=
 =?utf-8?B?bzhCN3V5VGdnb2xJQktkdk94cjVKcy82OEw5cVlrbCtjUjM1cTEyNmNvbnVv?=
 =?utf-8?B?cGFFQkxTQWJPWVdpSENReHdNeEFnME9GbExVb1lYSmRrby9ZZzF0Vzh0S0Y0?=
 =?utf-8?B?bHliSzFORHQ1VDY0eTI5RGJmRkxaT3A4clNoZDEvUTRZRktucjMzTTBkVFZj?=
 =?utf-8?B?SnYvaXE0eEMvNml0cXhpQitncG80YnB4aVBPQVhKSnlDK1RvM1NiVlZUNlVW?=
 =?utf-8?B?M3A1czNRNy9Ba1hReHhiZitZV0pMNXFFUTN6S3ByV2xMWGZWaWRVVkdJb3Yy?=
 =?utf-8?B?eFpxekR5QUlrdC8ybXRkeG8zUisvMW9xZzlzdHVPeVF2akQwRERqQUI1VzNj?=
 =?utf-8?B?ZDRzSExxc2FHTkJiM050K0RLa2JGWEFpa3N5SUo4V1IyLzdZSU4xMkNCNjgv?=
 =?utf-8?B?R2JzdWprck4vZDNmUTFOczhJOWl0bG1vYXRFZ1ZORnY4bGxENnlNZUVod3Ra?=
 =?utf-8?B?MWV2b1F5NlVqSzhSeXM0QkE0K0htN0daUTk5bUxyeDdYWWJ2K09ZWHlQUmxL?=
 =?utf-8?B?NTFieDdCalpFeGR3WmRGNlVGMEFjN1RXT1ZkNC9LZ2gvTndqWFNSVmQ0d2FJ?=
 =?utf-8?B?UXNFeUFqelFmbWZ3VU1uc09IN0hFRWNzcDIrbWtzNEFiTWZxRkVxSm0yU0F2?=
 =?utf-8?B?aGFyc0M0c1kwalMvSzJjWjZ2TzVVcmY1eFRxemVzN3hRbHB3YmZPbzduSU9n?=
 =?utf-8?B?K3E1MjR3WnZweHR4ODRiaURFb1d0WHlJbVhXOWFZWUFMaUgyVmx1akRtS0Y0?=
 =?utf-8?B?eWxmTnVPdE9WUVI2djd5YWdjckd4b04rOUE1R0lWWGpNYkNtMG9Td0dwMDZm?=
 =?utf-8?B?RjhzaUs0WW1kU3N1Q3c3VzhzRkttNVR3MWIxcEdFbjc3bEZ5amFKczA0OFU4?=
 =?utf-8?B?cXZjeGNwQkIyM1AycnhGV21aSFpxbmRwc3pTdXZMNVNLRTdzN3E4L1VKN0hv?=
 =?utf-8?B?aWplN3k5VlZmUTh0bExYYVBrc3JlQ0xab3RzbUJERU5aWUM5QitsZTYvbVVi?=
 =?utf-8?B?L0d1L2crejhFYXNlOEpLZEZmcW1iZUR1T1BzbFpQcXQxSEpJeGtaaVFUVWYz?=
 =?utf-8?B?a2ZEcndzdE1jRTlQOWVDRHpKNENXNThUMElhQXo0NC9UaGhwQ1dyb2hyaHJp?=
 =?utf-8?B?Y3NmU0l3SUlOV09zWHVKbDA5dUtrMDhsYmN5UVdoMi9iYTlBcGZQalZjb21a?=
 =?utf-8?B?VjErZmpSMFBueElOQkoxT1R0KysweDhJQmpBa3gyMzdDVWFQVi9idjVGS2pj?=
 =?utf-8?B?T1ZFQ2tPMkdwM3JlblJCcXhtazlhV1Q3TFoxMnBCbzV2MUZESGRya1doWFFJ?=
 =?utf-8?B?UU05eHoxM2xIQVJtZ0VhTHRoYTVnbCtJVnlFNDU4UE13S29xRFB1WmU4b0g5?=
 =?utf-8?B?blFuS1IrZTErTG1KWm03aTA3T2RuaHkxcW5JcDdyUzhra29Dd1pYR05EdEhj?=
 =?utf-8?B?bzRkS1NSYkY3TWxHUU9Yd2dNQzlHVWNSSmUyRHh5dC9YYS9nazNvOTFUMGFY?=
 =?utf-8?B?WFRVTnJSeUxncEhXN0V0NU5Ga1p3SnlJWmdTT0RqVVlUekxWZTlMQkZGRTcr?=
 =?utf-8?B?YktRVUFWYXhlT0xyOW1YTEdWOVI1QmdrL0FJOVQrOWRWa3hDQ09oRTJsV0pI?=
 =?utf-8?B?SVhidm83S1VTS1Z6d0JxMzIyYjZTTjcwYWp6RWptZGZ0ZlN6bTV0SEpRNzF5?=
 =?utf-8?B?SWhEem9lUWs3ZXV1bjZnVGR4bGdyd09VOVV1bUQrN1lsSnhGMVJCUEZXTDhr?=
 =?utf-8?B?Q3Jqd25qRFZQMGp4QWdyVXc3amNoNWNvVGF6c3RuakNuSWd3QnlWS3pJSHB1?=
 =?utf-8?B?bVNCTlU0RDg1ei9xR1lreTZYVDZsU0NySjlocHg1ZDd5MHhyWTJJb0J3Mmov?=
 =?utf-8?B?eWdjY1Rhand0QWtETTBDSzUvU0lVb25kaENvL25vdThZUW5yRnNjcXdybW1H?=
 =?utf-8?B?VFFoSW9iNzRrTGMyR25qaEE4Z1dXRXhFaTE5S1AxckJGNmhBV1ZQWWVQL0dM?=
 =?utf-8?B?ak50ZHpKQVZCUVVwbEZHTjlXUFpLaHgvUkliMHpUclBjN1hrczZLdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 1adae1bd-7d29-48be-b48a-08df3d4e490b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 04:10:55.5895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 p9ExFZUFrTp9k1/fEqBBXRZFCe1KjDsOLEamnFiAZMShRR52bkpKEFEFp56XzpABjfgPLwtI2MqFhMOKZg0JEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551
Message-ID-Hash: BVLVMA3ZJB5BDA4GD4PMFZJXSBETNDEQ
X-Message-ID-Hash: BVLVMA3ZJB5BDA4GD4PMFZJXSBETNDEQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BVLVMA3ZJB5BDA4GD4PMFZJXSBETNDEQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On 08/11/26 06:55, kernel test robot wrote:
> Hi Vijendar,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on broonie-sound/for-next]
> [also build test ERROR on vkoul-dmaengine/next linus/master v7.4-rc1 next-20261105]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Vijendar-Mukunda/ASoC-amd-ps-guard-adata-sdw-dereferences-with-NULL-check-in-IRQ-handler/20261107-232226
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> patch link:    https://lore.kernel.org/r/20261107175339.3547918-4-Vijendar.Mukunda%40amd.com
> patch subject: [PATCH 3/4] ASoC: SOF: amd: guard SDW IRQ work scheduling with interrupt_enabled flag
> config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20261108/202611080910.HG54RIuC-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261108/202611080910.HG54RIuC-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202611080910.HG54RIuC-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    sound/soc/sof/amd/acp.c: In function 'acp_irq_handler':
>>> sound/soc/sof/amd/acp.c:589:55: error: 'struct amd_sdw_manager' has no member named 'interrupt_enabled'
As mentioned in cover letter, Patch 3/4 & 4/4 has dependency on below
patch which introduces the interrupt_enabled field in the AMD SoundWire manager:

  https://lore.kernel.org/linux-sound/20261107154659.3358223-18-Vijendar.Mukunda@amd.com/


>      589 |                         if (amd_manager && amd_manager->interrupt_enabled)
>          |                                                       ^~
>    sound/soc/sof/amd/acp.c:621:63: error: 'struct amd_sdw_manager' has no member named 'interrupt_enabled'
>      621 |                                 if (amd_manager && amd_manager->interrupt_enabled)
>          |                                                               ^~
>
>
> vim +589 sound/soc/sof/amd/acp.c
>
>    566	
>    567	static irqreturn_t acp_irq_handler(int irq, void *dev_id)
>    568	{
>    569		struct amd_sdw_manager *amd_manager;
>    570		struct snd_sof_dev *sdev = dev_id;
>    571		const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
>    572		struct acp_dev_data *adata = sdev->pdata->hw_pdata;
>    573		unsigned int base = desc->dsp_intr_base;
>    574		unsigned int val;
>    575		int irq_flag = 0, wake_irq_flag = 0;
>    576	
>    577		val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, base + DSP_SW_INTR_STAT_OFFSET);
>    578		if (val & ACP_DSP_TO_HOST_IRQ) {
>    579			snd_sof_dsp_write(sdev, ACP_DSP_BAR, base + DSP_SW_INTR_STAT_OFFSET,
>    580					  ACP_DSP_TO_HOST_IRQ);
>    581			return IRQ_WAKE_THREAD;
>    582		}
>    583	
>    584		val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, desc->ext_intr_stat);
>    585		if (val & ACP_SDW0_IRQ_MASK) {
>    586			snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->ext_intr_stat, ACP_SDW0_IRQ_MASK);
>    587			if (adata->sdw) {
>    588				amd_manager = dev_get_drvdata(&adata->sdw->pdev[0]->dev);
>  > 589				if (amd_manager && amd_manager->interrupt_enabled)
>    590					schedule_work(&amd_manager->amd_sdw_irq_thread);
>    591			}
>    592			irq_flag = 1;
>    593		}
>    594	
>    595		if (val & ACP_ERROR_IRQ_MASK) {
>    596			snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->ext_intr_stat, ACP_ERROR_IRQ_MASK);
>    597			snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->acp_sw0_i2s_err_reason, 0);
>    598			/* ACP_SW1_I2S_ERROR_REASON is newly added register from rmb platform onwards */
>    599			switch (adata->pci_rev) {
>    600			case ACP_RMB_PCI_ID:
>    601			case ACP63_PCI_ID:
>    602			case ACP70_PCI_ID:
>    603			case ACP71_PCI_ID:
>    604			case ACP72_PCI_ID:
>    605				snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SW1_I2S_ERROR_REASON, 0);
>    606				break;
>    607			default:
>    608				break;
>    609			}
>    610			snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->acp_error_stat, 0);
>    611			irq_flag = 1;
>    612		}
>    613	
>    614		if (desc->ext_intr_stat1) {
>    615			val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, desc->ext_intr_stat1);
>    616			if (val & ACP_SDW1_IRQ_MASK) {
>    617				snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->ext_intr_stat1,
>    618						  ACP_SDW1_IRQ_MASK);
>    619				if (adata->sdw) {
>    620					amd_manager = dev_get_drvdata(&adata->sdw->pdev[1]->dev);
>    621					if (amd_manager && amd_manager->interrupt_enabled)
>    622						schedule_work(&amd_manager->amd_sdw_irq_thread);
>    623				}
>    624				irq_flag = 1;
>    625			}
>    626			switch (adata->pci_rev) {
>    627			case ACP70_PCI_ID:
>    628			case ACP71_PCI_ID:
>    629			case ACP72_PCI_ID:
>    630				wake_irq_flag = amd_sof_check_and_handle_acp70_sdw_wake_irq(sdev);
>    631				break;
>    632			}
>    633		}
>    634		if (irq_flag || wake_irq_flag)
>    635			return IRQ_HANDLED;
>    636		else
>    637			return IRQ_NONE;
>    638	}
>    639	
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

