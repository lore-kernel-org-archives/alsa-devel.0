Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47303C43458
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:23:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DA930601A6;
	Mon, 29 Jun 2026 10:23:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DA930601A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782721396;
	bh=Pnrg13TGwMleYG8g+dTWyN5okARyL0H3Xr7d0lvPDeE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=VPH1Y02mtqm0QB74x+Nk2AS5MkvCwIitBnHNwec3VTLWD5WD4ckBWjEWhOPHcuXwD
	 F8UQf758z3m511/M8FyjEs7WMlGenayqDvrMNdLPdlUgxIPD2+3weFhgInjMQeXMR/
	 DPDrAej7dZYq1uiniS6NoQl1dyYlpXv3+coFoFFM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 236BDF80496; Mon, 29 Jun 2026 10:22:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E94DEF805F9;
	Mon, 29 Jun 2026 10:22:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 63066F80495; Mon, 29 Jun 2026 10:22:35 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=fail smtp.remote-ip=192.198.163.9
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=fail; t=1782721354;
	b=QsMwoAQPmIq+02niUrdRUnRzFC9dYTyzBzw2Zpvl0VCrC2CVHO/gpFPEjNktVAlaDAuz
	 vqsF+jdt7ThEWTZja14o+fP9KlUS9sLAbZ9UFl4r5QQ8L9PldDupzh+9xH1c20dZXeU1Q
	 0pDBx4w604RvHhn3M6AKQ6tYv/d4qjFjE64cERANvDvYX2V3DwZbnKN2VzMYyUDNXG0Rw
	 wxkwwyajnfexcRfJpQGx0eddLTOz1WrxJy3YWLRspzbvE5jGjpZjmXq7wlw70HlxyKhbU
	 FRfxvBtuZuVwfODh++Ev5s8GzeDsI5kVlE7uxZzEpGMGDyKbMxcYINnGp+zz/cOuVBQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782721354;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version;
	bh=Pnrg13TGwMleYG8g+dTWyN5okARyL0H3Xr7d0lvPDeE=;
	b=inHzBtGf5OKOKHZWu/OWZWHJaRkr0CE063RSNWrcy1ncyXVlPa0lWT9FwqOZqzuoLcvW
	 ykjT+2fSK5ESvu3o+eTpQZiSdANYi/CzeBx57QN+kiiUZYy1NLzjQ3GOgXHJhSxqVnKkJ
	 2luFxKliGGSJIBqjBppHVbQoYrbQVRc9vzQwhb+WtNsGNAJwLkOHJ6KRiqZ/bMevFgeQY
	 6ZLTGC4K2oj57+2Srfuudn6XiOwECX/bO8htexBzsGiKkGlKf169OBUdVd3i2ivwtVtcx
	 WBtkhbOU89KqJIjpA/6qOdABnUER5owAfLKdfX/6v107PgSJgoDY2Qx23qZcV77JICg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=PTSONsLL;
	arc=fail smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 05705F80124
	for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2026 10:22:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 05705F80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=PTSONsLL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782721354; x=1814257354;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Pnrg13TGwMleYG8g+dTWyN5okARyL0H3Xr7d0lvPDeE=;
  b=PTSONsLLtpoktmkyyOqq4F3pgTrt0p0klLOtBwM92e2ir1Y42UBtAE/v
   dNb+62nAHKu+RgX+bRWCUqFAtuElMFm9NBAo3VfOso36JqmzQAaOB50aQ
   yV6fKwykyayGTn0rDCgx/tAVXo3viuRyx15Ue+0N9HV/lIQYFd2wPPaCa
   3xLix3188HweXjJWy+NsClJ5fzsGg9dW9uvfpgaMGy25Ow9LyT42SWqr6
   RE7gITfEZrXxonBtlMJVlhmBCiGbILQkO/df9lCCgGLRCHhMmGFono3LO
   JfjBLIDMuud69w97iS86QVMz+AG+PMpCM0ocyXFYaz5EP6mayIerX6feK
   Q==;
X-CSE-ConnectionGUID: u7TtYUjIRmiQi0c+IBT7JQ==
X-CSE-MsgGUID: VCacls4/SBCspZosOEQ2eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="94058803"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600";
   d="scan'208";a="94058803"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 01:22:30 -0700
X-CSE-ConnectionGUID: EYN3g139RSmI/+Krp1o+zA==
X-CSE-MsgGUID: eZJCSQnKSi29/pfqC0A6Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600";
   d="scan'208";a="250826930"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 01:22:31 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 01:22:29 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 29 Jun 2026 01:22:29 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.9) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 29 Jun 2026 01:22:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HxkjSIzLiJUQeIroZXB03OS9VM0qdTZtKAVXhUgYDDsKVoPi8tzGq9Hy+TruidUmT5R1xjjkb1alWenxyVXXty8jlvrMK4FSs0tiU5LWcVPJA6b2P3Hlgd7lEc+3hC2Xnx6ekssPPfdyJe0LDu9RJS7zw/QUrAppEbEIF3mftCN47sEXu6WwTm2AEEZ86jfN/89w54CS5jEEEyuWcDtYxq3Y1xFmb9W1qErl/S6kW3Xt8vX8KI0XTGcsMi9S0HHp2WmqnnhifF8hoszPRDNjSxiRMyRdl/GCWBl8k4CYsPcCoKGp+CzYgeCRVGCJA/ODK0/sIiiBhPwCtmpa1BKM4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2HjCW3rtROkWnXoXnBuL8zI/L+HA0WFG1q7FRhz2XU=;
 b=EaPrHp3MKFn1DRfQPwVYp68ridMgnH2dgPqRJw0GMxaxQOqQvsKGzpVjbuyc11vdC3CZGlbSWqiqQ/pSBriuMaf/w9+mAgjlHCCsoqsT+lB6xrRzWHC89Gx+iHTwFI7wtYcs7hMohoHLdoUyD5lkRZOd3rswNp8gJvirIAjn8ADZ55CRYtNN0ktj7R+sBpeb3x7qgEnGSYkZWqJGtHu8h++TyeOmISkPXr1oHx6gnUlFjGo5kogc/WwwLmTtTu6c+6+rVHyhpl6rJfC9a2Qn1xIdvXQn+TQAr2lY7XwObtJ9BZU7zURrS7Pux1ljEpRkB8SrTeWH2p6W97u5H80++g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6967.namprd11.prod.outlook.com (2603:10b6:806:2bb::15)
 by MN0PR11MB5961.namprd11.prod.outlook.com (2603:10b6:208:381::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 08:22:27 +0000
Received: from SA1PR11MB6967.namprd11.prod.outlook.com
 ([fe80::36a9:3aca:a63e:c8f4]) by SA1PR11MB6967.namprd11.prod.outlook.com
 ([fe80::36a9:3aca:a63e:c8f4%3]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 08:22:27 +0000
Message-ID: <ba7870a7-71b9-4024-91cf-68029481b72b@intel.com>
Date: Mon, 29 Jun 2026 10:22:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ASoC: amd: acp70: add tas2783 SoundWire support
To: Baojun Xu <baojun.xu@ti.com>
CC: <tiwai@suse.de>, <andriy.shevchenko@linux.intel.com>,
	<13916275206@139.com>, <alsa-devel@alsa-project.org>, <shenghao-ding@ti.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <k-yi@ti.com>,
	<henry.lo@ti.com>, <robinchen@ti.com>, <niranjan.hy@ti.com>, Mark Brown
	<broonie@kernel.org>
References: <20260628122805.811-1-baojun.xu@ti.com>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20260628122805.811-1-baojun.xu@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0009.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:357::9) To SA1PR11MB6967.namprd11.prod.outlook.com
 (2603:10b6:806:2bb::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6967:EE_|MN0PR11MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df4124e-609c-4593-64c7-08ded5b78dbd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
 inrkaEwACtWkKy4xZZNVzrmP4GrFYh6TeJsVju/tuW9TvP6/BOzZO5qIpf/y2J3w6c0We2bfKB21eFXuN0f4l0+A3PiWDiuM9ZHwfVPiwOB2l2w1d8xGxrB7sAaQUxxC/LQgGvHlLD6s3aLbAw4V9dO5Tx6p4of9k6ZMzlzZ636mbk3r4S8fo/kA5m5YD1RZM6EdIc7WrF9NDD+w3HPEqfOUh1V02THLjco/BHgxIFi3gqvTTe3sQC5sTdfIjbiRX+zgc0aMQiVgQextKlux+IOVKc5Spk85jRK2Z6L6dlN1KOzo53ajuJZIEKJuF2NDyiAx3U/6IbG9ifjCSRIyAiXmCbsqKyqr1Pp+NCiTCKGktNE3VK/ny/BOZIh4lCzAjHyD7IB6KM8Ahw6hKF+NnmwD0kWIH2An++rwBl5A/pLaVfje9nrbUHSIijc470yGQGspR7unkN4WSm/Jkb2OEoqlWApjetsGkczzxMumsTJdTrzI+wyQ0FnSvNPyHI5KkKq/kQrJXv4mZMVfO8uzjSg/tZ9a3brleSoCQ5owj0ULyKVVq4WFYQKCeSgABIl+XY0l116mE8f7/lIZ97FCeTTI/5QSvgEwVmqe8flZUnPL/R5vV8xxQsWtVd9LDY7Kxtle3O/1O0sis9CIFZWGEnWg/wijlIQJChcHqdq2Onw=
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6967.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?bkQ1L1d3bEsxNld1WXliY2NGenVRQUV2OUsxMXhCUlFoZG9zMGJMelprb1J4?=
 =?utf-8?B?bzRlSXFaVThROUluN29xNjlmWmo2Q1NBNUdDMzVwSXYyaTVrSjlxd0RSY2R2?=
 =?utf-8?B?RFNPcnFNQjVrMUtCb2g3MVYxWHJrUTU1M21ZbzVXNndvQWxRaS9IbSsxV1No?=
 =?utf-8?B?OVNBWnRTcFNiMU50RVZFUXBHaHBLUkNnYjE2ZW9ZeTZjUlZCT1I2a2wvaTBz?=
 =?utf-8?B?MFd0aDZhK2F5WDhtQmUzRTJBU3FJNUxmU1Z4KzlkWElNL3JhNjgzZUVoMDE0?=
 =?utf-8?B?by92d3J5eEhZK0VVeGpIdC9VSmNsYytaMlZET2hhZlhMQmtXblJaaWZ0WjFS?=
 =?utf-8?B?REtBWUx2T0hCWTArc0hlRjdtdzZ1MXZkRjltTlVPbFg0bjQzeHhVOHJRMWds?=
 =?utf-8?B?SmNLVk5FVFVJamZleU0ycEZkeVR0cmtRSTR6RFJsZzQrVk1JYzN6dThSRWlm?=
 =?utf-8?B?NDg5MXMvTjEyS0Z6WVp1c204YTd5Sm9MZ1B3R2RoYVlnZHBYWnpScmNvcmlh?=
 =?utf-8?B?ZGpTTTc4eHJDMHZKM1BNTkhhY2hFUy9vV21WRGI1R2R5K1gzeStiMUF1OFJl?=
 =?utf-8?B?TG8rNVlweXdEUzNNV2djQ2ZJOXhuUDVpRnZkcENkK1dDQlFVVndSck1ra3I1?=
 =?utf-8?B?QW5OUUF4clpmMTU2ajNkc2REbGhoL1VwK2pORXhiTG50YmJnU2swZWx4QUZK?=
 =?utf-8?B?ZG5VVTBzWk55cGNseDAwNlI5eWx5OHdYajlMMUlQcUxXTmdYNEtaRXdvREFq?=
 =?utf-8?B?M0kxVEp1amNmWU5CdnBWZitCMmg1UlMrdCtvUzR6RVRicWlsbkR0ZWZJYkVu?=
 =?utf-8?B?eEdYbGV4d0FPemxFeWw5dHZIS0NERTZPVm5PVlVhSXgrWmw2UE9LQk5kU0Fq?=
 =?utf-8?B?bHdHL2ZzWExvbVFWZkVkT2VRSmZRL01MR3JueVpMNlZBMGF3dUJ1SGc1TlUy?=
 =?utf-8?B?TXQ1Q04wNDcrVDJIK0FUVWdleGtPbmp1MGRtQ0V5cGNjTzhGOHNuWmtGbnpD?=
 =?utf-8?B?T2tBTzJIMENqRmMxZHd6dWM0b3M2YVpqeHBOcWZkZXgwZW1iVlY2RlRTRlhU?=
 =?utf-8?B?ek9TNGwwZmszZzBLMmhicXVCSnluVll4NzliaEVLYU5kbEp3eG51VXhEbWk3?=
 =?utf-8?B?b015aUovSEtIZ3FhS015Yjk4azBwamMwd0lXZ0tqZDZlUGVvNGNuQmJYdldX?=
 =?utf-8?B?QXk1SUxMMEQ0aURseVpCYmhHT295aHZOZVlpcjRuMEJYUGNMeWVLT29ReDZi?=
 =?utf-8?B?c21jcDhEUzdUUXFpK2JWOVlVV1B1YUJlbHl1S1lVN2dzNmtkUDZuSjdXSm9G?=
 =?utf-8?B?QjNMbFI2djE4ZHk3bmdTQ2t2VzhjU2NzSTJxeE9BRURWaGRYdi9QQmMrS0RS?=
 =?utf-8?B?QUpKT0tGeXhheFFXSXV3UXUvbW9EeUY2VHF4YVBjekI3cEYrY2VvTHQ1YTk4?=
 =?utf-8?B?UzJrSDhCYlNlK29mOHI5Mk1EQ0IwZWw2RTBDdEZaMWtIaDRJM2VQanJibUJs?=
 =?utf-8?B?WjJJM3FMT0dKYzAzQzNhRFUrODlRQWhkNFNLNjZkeE9JQjJsdjdMMXRubnZS?=
 =?utf-8?B?V2szclBaVU8vNzkyL3c4TSs4a0ptczViYnJVWDJ3MGhzSE5ETTZ5R05rdWVw?=
 =?utf-8?B?cTI2am9SdUtKU1dJU2tnU1I2UU9peVpNODNZRmpiTWNQdVdYNGFDNWV0OFNJ?=
 =?utf-8?B?bG9tZHNpdGZySW1xY1N3YklSbzI5SXdJNkhKbTlBNGN3MC9TdDdsdTF4MjJD?=
 =?utf-8?B?NWl0WWNOcVBBVFI4QjlQU2VGM1hJT3JTbTAvclBNNGlKdm1iaUpRTUpsYStO?=
 =?utf-8?B?bE1jQVRyblN6REZiVkRBZ05HUzZVZDlCa2Y1bXE2Q2hRdmhjK052NlhzOW91?=
 =?utf-8?B?SytrOGlDTHJiam5rbXRDN3JuLzhuK3l5WlQ5NTFZSmN4Q1hZS1JjMWxuTTcr?=
 =?utf-8?B?V2xXeXptRDNaUklabUZYeDUvUnBmS0NYNjVaRzNrQjB0TUE2N1VVVFZOTloz?=
 =?utf-8?B?bmMrdWlqeXNlRWZaUHNuMzlKMmRzV1Yyd2o2ZWMvdzFKTDA1b20ySFpUNGhv?=
 =?utf-8?B?ell6Tk5SZXBFSFQ4d0VZU2pNQ3ZhSHkzOWdRVFNkTDBWUlFlL1BnbytiOTRL?=
 =?utf-8?B?bmZwaDZ6K3ZpTVM3Zld0NnZIeGNMUElOZ01ZekJ0QXBmcVNLYzdMV0VNN2lR?=
 =?utf-8?B?a1JRMmFTeGVGZE8zUkpPWUpudnlQVkRvUEVlbEFrTVFOQi8wZ3hpMFRnZjdq?=
 =?utf-8?B?dExnRnhSKzhMdlZuYTB2WnllelIrT3Fnb25DaUorU3BVRGFKT1pIYUVzMko2?=
 =?utf-8?B?SGpCbFE4RmV1L0x3Y01ScTBTZmZMZGkwUFVqU1JVUC9XM2YzOUJJZHhQOHVn?=
 =?utf-8?Q?MLJpwQ/n6ShdB974=3D?=
X-Exchange-RoutingPolicyChecked: 
 sJjv12aqyp4g5/NPwctSzAbQpO+Kpxxd8U/RIr8K+LsfCnVso6eIbUBNxpBrFh0zQ6VXiiPvWEAkEl+IrCT+4YeYB1sUmAYHqlgE8LDKyW9JvYlDc0fnY1sxCsiUB854GRZS+1TuGN4fLb56/eXnZadnvacJ25XivMoPxU+u04f04dRIozwH0JoCKho7UxJVjuJJalOFc3Ck8HQuHVkdM1d0RFq0bqJAplYbbjjM/hCWJAED7OvIU2cyPDVO8Cbvj7C1R3lfN9pJ+V6BGhxf132iN9VmQMNg5jZH3+Q3s/K8Pa3kRCOQtP4nv+FaQlZXypEu2i05y+PSrWCjHEpK1Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2df4124e-609c-4593-64c7-08ded5b78dbd
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6967.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 08:22:26.9500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 hJtr88/eWFQOu+KORWfpEeMo7D76KpU8CpaCE4IjclRY9n9IMv9F0wQ32Kc/42ZLcxmfMI43TdJ4A35Hfhx0W4s/ITM7GK7+5oOJ2Ix3u90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5961
X-OriginatorOrg: intel.com
Message-ID-Hash: B4TDHBHHXGQSLM5THKR4J6WDZ4DSOFOR
X-Message-ID-Hash: B4TDHBHHXGQSLM5THKR4J6WDZ4DSOFOR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/B4TDHBHHXGQSLM5THKR4J6WDZ4DSOFOR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 6/28/2026 2:28 PM, Baojun Xu wrote:
> Added project 0x8EA1/8EA2 support for tas2783 on Soundwire.
Just like with your other patch, please rephrase the title. "Added" does 
not make sense [1].

While at it, shouldn't these two patches be part of a single patchset? 
Both circle around the tas2783-support subject.


[1]: 
https://lore.kernel.org/linux-sound/952140ad-5fa6-45cc-bf0a-b9968d4db404@intel.com/T/#ma0aa8dddb9e7c7de297d59eeb596abc8850e6bc1


Kind regards,
Czarek
