Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E59E9A775
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2026 11:39:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 29948601F7;
	Tue, 24 Mar 2026 12:39:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 29948601F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774352355;
	bh=cWffjgYDyGbuY2A3kyHKx4cLoMyGNy6nkqv1RfUdpxA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=dsFBDDJWEGoH7ancEUNxA9qOgGwecJRTwUi19iZAYGnJEjF4pLsJMo/5GMwm0a4DJ
	 A1kjGvaxse/Bn6WJ2Q/J2TWOWYBEMrE3fiwoIW05vZ9m0OzmgaHCpTzGDmv67hcuuE
	 Wzj80nu+bW/GUxyOwcvbbGjg/6F/i3DlNbkKDZoU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1289DF805EB; Tue, 24 Mar 2026 12:38:39 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 99098F805F0;
	Tue, 24 Mar 2026 12:38:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3FF29F805BA; Tue, 24 Mar 2026 12:38:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 589BCF800C1
	for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2026 12:38:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 589BCF800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=PtmB92Er
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774352306; x=1805888306;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cWffjgYDyGbuY2A3kyHKx4cLoMyGNy6nkqv1RfUdpxA=;
  b=PtmB92Eru4XuPtwDC2R/Lt2Sl+ICJoxTM3hqlDhEqD5NXFGLegn0p3sT
   u0orFSrD3QUdSHQO542rpXxezHbv+7uV0u5cHWYIHMbJb1xjlj8ATtI67
   HFE8VIf60r0yKd+c5Hkpf/KXJJhOs6vIvDePEXuV+nsDrbIvSqCq7rQ05
   MOGaEH4ce2kbT1acOLouunSaogTW2JGLVAbOTqMn1a3kblCGhXAhtErkM
   xNMsv/KCry8kxnbopSN7kHl0lW23vx3N4KbCaN0AbrGOe/nMB1iv+A5+a
   62C1vg+KjJrpRAk/20lpg0f3JGWkAA7K1xvtWF00BJUtylo8hONHltngK
   g==;
X-CSE-ConnectionGUID: GKzwcfdMTM+ZS7adhEc/Mg==
X-CSE-MsgGUID: uKFDhHl0Ts6Fyb2EXgVY2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="86835656"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000";
   d="scan'208";a="86835656"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 04:38:19 -0700
X-CSE-ConnectionGUID: Gur1pxEqSXiXsyoin2/XZQ==
X-CSE-MsgGUID: ywxIrQKFQ2ufp/BrxQgGcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000";
   d="scan'208";a="228806262"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 04:38:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 04:38:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 04:38:17 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.6) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 04:38:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJ+VFfbmBJ/ZNbxkbAh665hPiAVgrPgxG/WLEkLUPTg73duQS2OSUdvCDYSiI2MtJlCgBQ4RCqapGHCKbLscrP5FSUY8R4HwhU5fls8W0bqoq/kORmcYMwEXwkmxU3oe9OczGDsAgMLOVDMbMoTYWgXDEHZ9NX+6JURXmcnNKzYVit7MKU09xpCD6TCpF3Uy8X6i08Z+TuwlXiT68c5VAeGN4GISNRc6bqj2Uj1FFOtNZrMGGGc0Mw4w7yR7X190BCZdI2YJXMcQJn0mj2xfGKXUgtloYc40RbnLqZoRvBWr7Q8NdWPUDZOvgdtPFdhCFxYQXAzFQOLRbLe43YQwFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JX2f/fSUV/7D1dY4ZHD8lmvErlnr+ZuswszpJENfm48=;
 b=Jf3JbXNLF20dDMW5rY1xOXWcJyeuYWGJNR7TLH6COyqnOF1wG8Vp4DAdeg60ye7RIEz4o6HAcGruN5tRCx+OjW3/lObxgLd84yJGoOcmnP9cwN89722BYzPNBR7fOZEBI3RLkmtejThyN/Bj7nRSBkhgJ4sE5eT183NYiEPTXeHV93ZcIDKoHBJrGeMYELQ6Ffg0TiCtPt+yss8fNULYC92bJGzGzDu9FpeX7Ng+cjzlbu6MdV07ZM/1hhanzepmHjCXsfpuYA/xYFeZiXQB7z0YmcBtMULhqdkPy343Z0AvYcAKEceIEEVWU9Wlji2mD8a+PFkBFeBCjAmvEpOJ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8283.namprd11.prod.outlook.com (2603:10b6:806:26c::16)
 by SN7PR11MB7419.namprd11.prod.outlook.com (2603:10b6:806:34d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 11:38:15 +0000
Received: from SN7PR11MB8283.namprd11.prod.outlook.com
 ([fe80::d18f:6b38:584a:214]) by SN7PR11MB8283.namprd11.prod.outlook.com
 ([fe80::d18f:6b38:584a:214%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 11:38:15 +0000
Message-ID: <f082905a-614e-4096-8408-4dc459260047@intel.com>
Date: Tue, 24 Mar 2026 12:38:10 +0100
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IFJlZ3Jlc3Npb24gNi444oaSNi4xNzogc25kX3NvY19hdnMgY2xh?=
 =?UTF-8?Q?ims_HDA_device_instead_of_snd=5Fhda=5Fintel=2C_fails_on_missing_t?=
 =?UTF-8?Q?opology_firmware?=
To: Robert Viren <robviren@gmail.com>
CC: <amadeuszx.slawinski@linux.intel.com>,
	<pierre-louis.bossart@linux.intel.com>, <tiwai@suse.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
References: 
 <CAC5iJJZCHm8a_jP+7nQpp4aqn_EE7JmMdPJBbu83QSBjgqZ49g@mail.gmail.com>
 <40777346-28d4-456c-af4e-cb868d8b8ac5@intel.com>
 <CAC5iJJbaG4boDEO6V5wOuJYiFdZauEdS47PSg-g0Gc1CrxnC4Q@mail.gmail.com>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: 
 <CAC5iJJbaG4boDEO6V5wOuJYiFdZauEdS47PSg-g0Gc1CrxnC4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:23::12) To SN7PR11MB8283.namprd11.prod.outlook.com
 (2603:10b6:806:26c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8283:EE_|SN7PR11MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: 634fbb01-a49a-4852-316a-08de8999d632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
 f7yKKzDsfrJWVdHPSTI5+DA/2ou5uETJqvG9/EtvkNUsxAOT57t1MfubHkWZ8L5We+0ZJy99RePFRk0Ynv+F5vjH2HvNMGYtyIz5IzgVI9FNTSIU4rm2a/l/uhPDG/Or2ODlL11VBlXj7NIyn3OkKY65Ya3cY9s6JTp05Edm80qFxkWXCEnrNBeSWALzUb3Y2Or3eFkLl7SgqHLIdJ5qgW+1+fc9TEFTJjbAfoZjAwGGBr1xZyuXt3RXwbdcdYx9ZBYKEad0j/PHoYUKOo8aaJlfL5LhUyPEnE6Ml8WhTV7SdwwgksrfKDou19awxoABuZDGVgQKdX55YjEBgxyFinAk/+7n0dfPRn7UpYrwL7YYZEN2lhx6LT/Ys9qEQ8n16iH9qldoBcvN6hlavIGBfDJ4+PgpZiUJyxiY+x7oDmeNFjuaxZDy98RhEOhYzTcWKyk4PfnxyEm6pXGOahhAXh/hVAnWRcUFoaZvnA+GoM3Trw5sxZDxy4+zkPhZBwn7n+kT6gy7OiMpKzBuUj9sFn4lHep9emAz5sozfpTe3JBdeaNVv5zB5VxjdwBRjecuzlsF6/QhHBbvJ1ct7uj3QwqRXRV5GMJ26UtoYFw8SyTrejLNUfjiRMHOLoxEX3rRSwsav3h63A2Qd7YBELJO/kcMsfoSRRpcq+4Cnfd25QkLlEgLe/R3WF9IYWaYEw2zO+BWHVGokuRX1ejVrMYBWLQamwRAsNhM/Th1omHh/ps=
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8283.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?Zm1DM0xic3BGMUZtUmM2aG5WZUJjWjhySGdvcllwZUM5dlJENTlCZmZHQ0pO?=
 =?utf-8?B?bitDbGxWY29USnpRYlMxdlFwNHRYaFRUMTMvUDFoMjlFZnIvWitLcE1DRkJ1?=
 =?utf-8?B?UzZBZkltd1l6Nk9HVm1ZTThuSTdXMHhuOTUrcy9hdzBxOVhRRmRqUEdQVDBs?=
 =?utf-8?B?K3R4OXNUakw4MUZvSmtZRHl2ZnRVdXJOVEVzUXh1VGFwcVY0ZlkzZGVlam5P?=
 =?utf-8?B?cnVobEFxOVloYzJFbjJydTl6SzhhZjBveDhRQm9Na3cvdU43cUpWUmp3Q1Y5?=
 =?utf-8?B?VjNOTzNBdWUwSHVvVWFhWWsrMzg2Y2NkbUk1TXBDS0VUVTRpbytiM1lzQjE2?=
 =?utf-8?B?bGNhT2VIYzJ0QnZnZ0hzL3NwSytBTkZEUGw3ck1BUG5DK2cwZGNvbHJ2cVRq?=
 =?utf-8?B?NnA5eFJ0QXdpU0NTUjhEM20yOHJic3NYUVFVTnE4SDRrMldFWmx0bDRNM2N3?=
 =?utf-8?B?SHB0cW1pemROUDdiOG5PZ29vVHp1eC9ZejNjeVhwVDNQZ1V0TE5UMEJLUEUy?=
 =?utf-8?B?Lzk5TUJFNDlsM3g3MngxYjdETCthaFRTaTVubE0reTg4WmNjQ3ZIZzNHejhO?=
 =?utf-8?B?R0U2cndrcVcrTml3OUorMXhORGJKeTJVSyt0b3ZpT0x0bG9EaTc3SVA5M0lo?=
 =?utf-8?B?SlRqdDZDTUVmZEc1RjFtWXJrYVJ2K21qRkNBM01aR0NVYTVReEIzL3RraWFr?=
 =?utf-8?B?bVh6cFBTOFkwaks0dStMOGNLZW5EYXRETjdYZnJkcmQrSlVrR09aa1pmcGtV?=
 =?utf-8?B?d0k3R2JUZkxYcTFNbjM3Z1VMa25kNWhBK0F3V1QvV2lZWjl1a3d4eDE5Wkls?=
 =?utf-8?B?L2VEUHBmVFVmQ2NmVmwyMmRlRE5teTFUdnBHU09jUzVUeTJvY0ZsSUcwK0Jy?=
 =?utf-8?B?b2NHVEU3Q3hHSHZHK3RnMitoY1lyNjNiK0c1OHNFNm93ZnZmc21DWmNhTlp4?=
 =?utf-8?B?SnM0UnU4Zjh2bFNxYWNiSUN4VStFazg3bjNrS1N1MDI2Q2dVbFBZTDVYaGVr?=
 =?utf-8?B?LytqZEczSFVNTWdEWjBPMjZKUE43TWx6dU5vN1RxcEhqMGVCUDYwODNsNXN1?=
 =?utf-8?B?eWcxblB1N2hQakk3WEplVmowYTZ2OHh3TmpHcTV1ZCtZeGZmdEFoMnE4cDF4?=
 =?utf-8?B?cm4rWU90bFYwQ3NoOU1YZFVXaVUyVHFRQUNXVGNDNG8xSmpXMmJUQjVPdzRy?=
 =?utf-8?B?b0NlK3pyTUJvdURmbkdCdWI5N3NEdVRVUUtVYWE3REhaMEJXeDRaLzBWQU9F?=
 =?utf-8?B?ZG05anFZNzhzcmNkVzgzd0plKytEbi9rNmU0UWN3VnIrZ2M4bU5QQnpqY2wx?=
 =?utf-8?B?OHBKRXJJRmxzV1RFNFVWWjZTKythbjRzOEpRM0hKTkJHTGJvek84TEhIOFkr?=
 =?utf-8?B?VW92czcyajZLbit3cCt5eHFRWkMvR2RXeEZrQ3Zaajd5YkFqTk1yWXZOR01S?=
 =?utf-8?B?MkVZSjRzRWdIc2EvWk4yWlVyZ1FoTENWc0Q2SnhucHZmVkJHQ2tDb1FTc1Aw?=
 =?utf-8?B?Q1ZyL0pmZCtIODlOQkNGd3k2d3hhVlNCK1hadGdpSHVjR3ZCR2JpS3FuNzd1?=
 =?utf-8?B?Yi91V2tyV2tJbkFkcVROL1pMMElHeFczOXhWVVV5b1k4N3FHZ1JmWjhLVU9K?=
 =?utf-8?B?UTM5eUVBTUhray9PNFppVjRZeGpMZ3Z0a2VvQkwwY2FkcnN4Y2xEK1VEZXAy?=
 =?utf-8?B?d1VIR0IxSHhhS2owZFNKeFNmNlY3azFURmE3b04rTVl6RzJTZ3k0MFltMjhS?=
 =?utf-8?B?VkFOMlIzUkhaRmloVzVKMXVwUFFKUTZzSzB5T1pYbEYzWDZSWDlkbmRlK0Ry?=
 =?utf-8?B?NkRxM0NJL2pmY0NEZjZrVENnMEV3a3hpdXM5VEZBY1QvMitrYUJZd2gyc3g5?=
 =?utf-8?B?NGJCemxoMkxNckpIQTdqM1pkMEwrcElaZGEyZXFEQnNyaXI0enpNZDBXb0VH?=
 =?utf-8?B?ZEVVNDdMQzVLVmN6Qi8vUHpiNzdGRkpRS09RVWNVUTF1eUJmbVFpdHVOOW1B?=
 =?utf-8?B?TTRMV2orWkF4WkY0SHpod0hNRElWaFBTakpac2ZHVkFGM01OQmtuN3l4VUF5?=
 =?utf-8?B?dEZLZ2l1QllYWWNMU1dBK1VwSUlDVkh0cGlkL3VIQlVTb3RNLzQwcXdpSlFG?=
 =?utf-8?B?QTdzVGFZSmNVM2ZQbDBSVjFxNkdhbklEWUdGTHdzNE55NjMxS2c5OUdjV29v?=
 =?utf-8?B?WFdyT3VxdGdYMURoN0Rta0tSeVZQNlNNaDR5WmRhWWd6U3QxWmh2QUJaQ3p3?=
 =?utf-8?B?aEtFRlVGaFhySnMyRjV6R2plSEFGcVdtWmF1bnpOeW42VFZsaXpyeVd4VE44?=
 =?utf-8?B?NnNNZUF6cDJlOFMya0ZhRW8zZ2hEcm1EZEsrVklXVXFxcUVPYW1BY0s5c2NB?=
 =?utf-8?Q?42hO7Kp9GD0mDvEo=3D?=
X-Exchange-RoutingPolicyChecked: 
 my3gsimoN9SdGlt0zIhBANd3J57LkZhK9sFU4SJb0O3oFq6QggjsviaAjobKXfKHCtb1XNvUbf7axh2giHDGPAYv8GYDEmTAdhI63ace+rl5NsSCFo2qTMCfv0d5zGrwFT8M5l296lYL6pu53czjrtZnBnhB4R1RT8P1UMH+VnNQClhQfnStkNcwzhedtWr1rtQphiNN9NVahjaHj+VYjWM4rRIWD8M3erE6HXZr7KgpUQ96Nab5UMbW9ISHRucv18ZLJYFCesSV+ouQLRGkaes0LZZFkZrylqhxKu8BPM0bM4CaVUK/zenuw9U3vdeoL86BTDRvNZcg+vxh7Phzug==
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 634fbb01-a49a-4852-316a-08de8999d632
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8283.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 11:38:15.2227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 Y8gDgCpSqh5q4Kg8q0Th60C0rT+GvE3H/wDSHqOa5l3+hUwArMYcvmhZ4TXj+C+UurXpHCL6FO2UTfpY++5nLiEpFeE7aY4rR69ozp8jDFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7419
X-OriginatorOrg: intel.com
Message-ID-Hash: MEWGH4JNGTWQIGSHTGOXA5DRQ6EQAJMU
X-Message-ID-Hash: MEWGH4JNGTWQIGSHTGOXA5DRQ6EQAJMU
X-MailFrom: cezary.rojewski@intel.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MEWGH4JNGTWQIGSHTGOXA5DRQ6EQAJMU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 2026-03-24 12:25 PM, Robert Viren wrote:
> Found a workaround. Blacklisting snd_soc_avs restores correct
> behaviour. Command outputs and bugzilla below.
> 
> cat /sys/module/snd_intel_dspcfg/parameters/dsp_driver
> 0
> 
>   ls /sys/firmware/acpi/tables/ | grep NHLT
> NHLT
> 
> sudo cat /sys/firmware/acpi/tables/NHLT > ~/NHLT.dat (I attached it to
> the bugzilla. 45 bytes)
> https://bugzilla.kernel.org/show_bug.cgi?id=221277

Thank you for opening the ticket. I've replied there. Things looks 
clearer though - looks to me like a regression caused by some recent 
changes in intel-dspcfg area. For non-DSP configurations, the first 
choice should be snd_hda_intel.


Kind regards,
Czarek
