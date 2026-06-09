Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5739CD8CA4
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:50:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 255D9601CF;
	Tue,  9 Jun 2026 11:50:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 255D9601CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780998633;
	bh=bLr/x62fufMUkBZ+0EEI5hA0CYDJnANEohBWPKSzbUE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=gI21cCXLwrF8rGp6sCfigha887162kLfjcU6vJ7M7WeuYkgzjh4UDq4uTHhxsg6Hp
	 GhF71QBHVm+pbO9CGs2GDGIt36vK6XxuYqNtdwU5MPV8LjCfS0N7/LWq1U9zUuDdtn
	 WzG7Vfu9U7PcRKmMMuh9/LOjOtS1Zao3uYiOLTvU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2B032F805FB; Tue,  9 Jun 2026 11:49:58 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B2844F805FE;
	Tue,  9 Jun 2026 11:49:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 33A4CF80496; Tue,  9 Jun 2026 11:49:53 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=fail smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=fail; t=1780998591;
	b=L0aY3MT09XykTif3xgSrjJFY51dPm1Ux3oJzHxvZmLAK/08qx0w2IVyD1p0Q/GoAJMOA
	 /iJkoeFyLfxFkpwq6SIpKvbtmesjUdB3PG9+OEoI/g6vZKZHnaA9RdYHgqv5fQWoMEgOE
	 WByyb1ZKV3nGMM8J92+kdJkXy6GWQnBK6WSidmNLUP34gsDErmZ6t3SQ8H6Kuvr5n1IUK
	 OJrHNmq4RjDjj8N451F8FPK4y3Y7CVwaEKEQTEuFoigi8ziah4GdOJTyjI8V49SlfwoaP
	 Oe9tp+MGw1Od9ht9y92v61wyDN3i3QmwhvhkyxfY8Ky9dNbWkcqUKFyTRKIzpj0Pj/Q==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780998591;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version;
	bh=bLr/x62fufMUkBZ+0EEI5hA0CYDJnANEohBWPKSzbUE=;
	b=H1tZ/h0wDWnkMyxqwxIhIGlkW7oNskcwFH0lj3L0D0oQ2kjORiX/NkTPHxsjKt9BrFNI
	 CjZGHkVC5lAz9wGzNf6GuOcSwJIAR9OKmP6FvdNHOKQxFU4BktwaXsE+nul7zb4fmMLx5
	 YSMGwtbzAGVbdrE/KaH7NpsYwH2snmlvEJUnK8UuFE+peHkrnMDL5BV8X92fWAjhSxizR
	 toLqAMPwu0JZv2nRc86H9FS0Ry1QnsfCwv5DMMJEP2J/pABw323wlukP917L/IFhK1vrd
	 Q10KYrxqj1t8gtJ0LuZ5fjNBDKBoZX1PJYvKc4S+ATrKCayE1366ea4N0Y90RdL4BPQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=DYgNCAv5;
	arc=fail smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 438D8F801F5
	for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2026 11:49:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 438D8F801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=DYgNCAv5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780998591; x=1812534591;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bLr/x62fufMUkBZ+0EEI5hA0CYDJnANEohBWPKSzbUE=;
  b=DYgNCAv5Ndferd0aWMdRHCWWLrKmOrPXGhQYHgrxfqKthQVDTlFZCCFV
   l6qCKA4eGfEOOHrtOlNQmM4phTphhCH+GAkk4KmZp25fSKZFHTOduyAVm
   dW0Kl175ghQb0qDEHPUfg+mcpX/zNPuCYeq2ZwcdGzA/szgeNzg4K50Yi
   daLO7vY3ljcxzzXodxSNQwDjYvjnJ1AlqLTdvTFGTJT1IiLcq2MduRgDN
   1Y8OpvHRPHgkg+OLSLxJedpAF5qtb60YPYMsFPjfnCzdwi2wQTti1uqlp
   tRWcvETdYSPQojSP/DViJuG4Zq65Z98UMnBsEFVaRcELdD/EKjOhlPn8z
   Q==;
X-CSE-ConnectionGUID: imLuiNc3TIK764mtKzIrDQ==
X-CSE-MsgGUID: RUgK4AFAQkaJ4AEITNwxjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="104418303"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600";
   d="scan'208";a="104418303"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 02:49:45 -0700
X-CSE-ConnectionGUID: hOJuw64uSlimn+v6BhIvHA==
X-CSE-MsgGUID: u/H8gYT+QfOGtFaXc3WkDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600";
   d="scan'208";a="245661762"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 02:49:45 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 02:49:43 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 02:49:43 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.28)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 02:49:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pPdmGOgz+25dEo8ph/1kN4HRCJuil/vPZN2fM+wpKGgwCkALil9TlXU44O7EN6PBbflt/QQLCsC9h8FUk99K+scWCa5GTgdHDWxvhhALiV8qeunwjaf1t+VK17yiKy5wEbPA/BSekRNeIRsPfgFE+X8fR7NDr8qKdKEWpoubsu5pyw5Ts2C7NHflwK5G8IGUcN7sX6K0o8Y2fLiRfJeLJvyQkOU228x8X8ZzohVJtHflBf1CPqvWtJAgLSYC2bKlY8Wg2hLw/klhwJ/21orIP76rNt9tFwUKNvIJix2MkENpHBffNP94I9edDTb+inGx0hqpVTeFmiJQhmYJtuDMrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mH+eiKX6PXzoGBtzCVpG1VoLTZItjzGWvH8AwVHdBZo=;
 b=uCue6sKohrhgOTgOQjekDWfF8L5oAhh+AMiqpsnGUc+sAqUYERG+k8MWwelxyoJLRxWmcVMU6Qj7EBYt2WTHwLZpLV7ASItkDNOSGb2M3I0r6JL1WS2zLaKuRIdCpU56IAVvOkCo89/ft5G1StDSzE+Pv0Z2Rg/8NSQGRt8k6z6kgIEPM8UsIjHGdTvs8okk/ewYAKEesFCQxcJ0LpW0/MHqUsti/hSkaXqnYO4IxwAidfWrERy4X0chcc6x2wzvS40qo7Hw0CPl1hBpIo4bK+fYt+kfAKI4nh3W0pg2wKjdIGIoqeX8rypgyGZMlD39/zb3Q56VzB5EFCA/N8zKBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6967.namprd11.prod.outlook.com (2603:10b6:806:2bb::15)
 by DM6PR11MB4516.namprd11.prod.outlook.com (2603:10b6:5:2a5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 09:49:35 +0000
Received: from SA1PR11MB6967.namprd11.prod.outlook.com
 ([fe80::36a9:3aca:a63e:c8f4]) by SA1PR11MB6967.namprd11.prod.outlook.com
 ([fe80::36a9:3aca:a63e:c8f4%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 09:49:35 +0000
Message-ID: <329cf637-786d-4fee-9c63-b8e73827b330@intel.com>
Date: Tue, 9 Jun 2026 11:49:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] ASoC: codecs: nau8360: Add support for NAU83G60
 amplifier
To: Neo Chang <YLCHANG2@nuvoton.com>
CC: <lgirdwood@gmail.com>, <perex@perex.cz>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<neo.chang70@gmail.com>, <kchsu0@nuvoton.com>, <sjlin0@nuvoton.com>, "Mark
 Brown" <broonie@kernel.org>
References: <20260609024128.585938-1-YLCHANG2@nuvoton.com>
 <20260609024128.585938-3-YLCHANG2@nuvoton.com>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20260609024128.585938-3-YLCHANG2@nuvoton.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0051.eurprd03.prod.outlook.com
 (2603:10a6:803:50::22) To SA1PR11MB6967.namprd11.prod.outlook.com
 (2603:10b6:806:2bb::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6967:EE_|DM6PR11MB4516:EE_
X-MS-Office365-Filtering-Correlation-Id: 836b1787-d568-408d-037b-08dec60c69af
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|11063799006|4143699003|5023799004|56012099006|6133799003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 
 3OJTAGAr94vy7ESJtqpL0Zhac+fOv2HviKiXXhOPJQtiwqo4u+N0ttBswZqVih5YTM9L+AYGCYzkSAe2axb9k4CoNglBRzcqe83nvtJXOR8dZ0z2EY+wmpo8FDTfK7xSzA3tJH51ZCODFzq+9d1j8aahJzQJucU+Vp7KAnAOoej/WR/Aja21DHyup+Q3kF8fGoK+cgP8hOr8Zi9wanq84lqfdabF0Y19LuP5xiyYRXsJT+udXYkxRiCSjCGeD0M/o0PDVethTB/JkfoS6GVy0TE18YFxnHs+VNXhOk6G0HmoMIiqtPCyqbUayAuL+sxfHxuIQBk1i0AvaLW6QpyuesUv2FbL6KTwwyw9IRF9LooxDpunst+iYjHMdKIqQIPQrjbbMaXclAPKxwWQ2HkfJqxA8WsR+cuVN0VzL+qLReAlXLGCyidh0ZdcVH9REno45jvGij+FRrrDav/1mU1oUSmMyS5QLSonKM5Lx3cjs144e/3GwninoAKIrW2fvWh2FxArbvhvQj7LH/w6Xx0x0voDVd+tqo4kJ19wYBC38t4IGR269ECdF0cZrxZIm/RzhZGtdfkSGaNS67ZnM6IemDuwOt1YZFoyW4DJ8F32DcytE1E/ejhSdz3CiKqHQSy5Su8IPj4l45sjEld+1kLF9A==
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6967.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(11063799006)(4143699003)(5023799004)(56012099006)(6133799003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?VUxPcituMEFQS2JRbVZ0cUhNd2pKTUViVWMwRWQ4L29UajdudDlqSDZWN2dv?=
 =?utf-8?B?U0lQRWZhTk54cDdyZjBCelFFcWRRcDF1UnhzYW5DbXJtYzM4SmRBZmIwdUxM?=
 =?utf-8?B?OEsybUdxRmFQU09sVjlnNzVPdTUyQnVwemhTdUVTUjBFU0h6S244aDR4a2M4?=
 =?utf-8?B?MkxWRktKRWZUSVBJQVlzRXJlNW5MQVNvcEpSYlhtZHdzOVJjRSs0QldtbXVN?=
 =?utf-8?B?anNLZHl3b2ovYndyeE9MaDh1ZkJDRDJrWVBqS0xHNWZyaWxpYjJGdDR3czZi?=
 =?utf-8?B?YkFvS1J4R2ZrZzVVRVJqeGlURlpjMk8rTFZZazdwaG5Hc1ByeEphOFlYeTly?=
 =?utf-8?B?c1FnUWgrRitXN3VGRUxIVEYrWGh2SGV3Z252aDdnZHFxenVjMmJ6bHBhTzVi?=
 =?utf-8?B?eDJSS05HRHM1NUM0UDJ0Umg1QVFXaFk1Q0xZRWN0SHl0RXQ1NEQ2c3c0ODBR?=
 =?utf-8?B?MENiM1Rvdnd2Wm93Q2NBRmNYOXVBRkM3TEp6UGM4VzNZN21HL0ZXUVBpVmhF?=
 =?utf-8?B?dE5VTStBcnlvTEFhOXFYalJVVmNka21ZVGhrNkp1aFBvcmNWTDNJUUd3MUds?=
 =?utf-8?B?ckdOOGprMC9Tb1ZFcUtJSFQ1amUzcVJiM2hIQUpjc05ybml4L1FxaGNOSzh2?=
 =?utf-8?B?N1hXbGpxdk1PUVZkanNwQjhJUis0VkN3ZVoxWmMvVmVCVFNRc0dua1hPTFlq?=
 =?utf-8?B?VE9pbkUvR3FvN2JhVTFzdStEcU1xa2RWeGd2L29WNFo1MGhaTGZJUC94aWpL?=
 =?utf-8?B?UmpGVGkyTGduTWtZRGZGS0xBTWxKdXlwOXU4aHhLVTM1NXptZTFwbUZYeEdF?=
 =?utf-8?B?R2dFL0NodzA4V1FUUWgxN0ZPZGkwTU01ZzFiVWMyR084ZWlaalV6VnZzL1I2?=
 =?utf-8?B?dFFGendDb2tDM2ZnRUFCRmRXUDFUWFU4U3JKeXRrM0VHWldFTEhiSWR1WXRv?=
 =?utf-8?B?NW5HS2praHdEbCtOYnd0WmRXRUYvckhlellrV0FuNUJmZVBOOFgyeGQ5R1Zt?=
 =?utf-8?B?enFTNFFJQUt6WnVTSEQ2MlkvaFdHdk9KOWtsejgvRlpYTys2eFk4M1pDNDFP?=
 =?utf-8?B?K1JXSjBabDRhcTBQQjVNMmtpY2Q1MjJINGJRMlVqd3lIVU9zZzNBeUhrUnFI?=
 =?utf-8?B?YXpXUmZNMVI5bGtJOUV1SVNrZTdYdmxNV3VtbGlOdXJlazhlRWM3WCtLZVhB?=
 =?utf-8?B?NG1leVVkazAvOFJGSjVPbGhKczFuaWtnOEhteU9TNUJkTDVWdEhuZWVLck93?=
 =?utf-8?B?Q21kdWJkZ2VHWFd2VkY5WXpUQzRhckk4Y0YxUXRRcWZZZmtEZHpWZ01vRmtT?=
 =?utf-8?B?VHBFOFcyblBZMTVkTElQblZJcmc3dUhwREUzMDlRYVVPdER3cmpKL3hnVDZ0?=
 =?utf-8?B?YXFZeUxDc0h6RmkrTGZxYmVpS3JjYlVvSTRkNzZUSW93cWMzb2JSYmJhcDZv?=
 =?utf-8?B?NDBRTCtySGJJemJYZm1tcGFGWk1TVlZSUkVCV2RwU0YweUc4WDdoZVFpeS8z?=
 =?utf-8?B?cjJKUkZib0FnY0F6UzVMcmJhK2U2YTY3OUVTMVM4QjcvUjVodzRCVExtaGNk?=
 =?utf-8?B?djZkOFowZkZaR3YxTXB2NFUza3FrdzBxTUFuZDJ2dTNFa3QzS3dwV21MNlg1?=
 =?utf-8?B?RnpSZXhuTlNYS3pzS2NjMHAzRyt4QXh4bUFUUXNzd1VXT0R0UVJLKy9Xek90?=
 =?utf-8?B?TGJFRGdRam5wNytzeGFJYnFvRHcvTktKRlo2MkRtSmdzYWIxQzRxMGdLUUk1?=
 =?utf-8?B?OWMrZWpjOUgxdmlLeHVsSkkramFudEJPMlFRZTZUdVY1SUNQZUlrYllISHcv?=
 =?utf-8?B?TlVZNUJONFExcTkzd2E2enVJM2ZIUXZTOUVoTXYyRFlXR2FWS2d2Q1NVS21U?=
 =?utf-8?B?L24yZTlVTDRYOUc5d1MzUHZ4cjRLOEUyQ1FVSUNuNXgya05tWnVoTHVta3JS?=
 =?utf-8?B?eEdoaUkvUkw1d1JhZ29sY2RzZ2Qxeko3dlJVa0U1aUsvM25DSEtyMGxROWJs?=
 =?utf-8?B?Z2Vzemo5NXlMdWRpcjVWc3ZNZVFEVFZtTnR3QlpEU2VVOTNpTGpZOUFPNHJm?=
 =?utf-8?B?NXBoZ0ZvYUxNc3BpUjQyTVZ6dWMyVUV3VElaUEsyTVFwTFliLy9HZk9neEpZ?=
 =?utf-8?B?WDBSUXdhZDN3Mm5NMjl3VlhLa2R4NkgvQXduVWVaTmpvN21SZjRoSTZqNUJi?=
 =?utf-8?B?RzVneUdOWDkvUFhQZzlobG96eHNmd29IVmFORE85SVU2OXc2VWJHYWFmQVdh?=
 =?utf-8?B?WnVaSTh3WGhDTnRFT2ZqNU52U29GL2E1SDgxNmwyT1NlSTdWbXMzeURoRXNl?=
 =?utf-8?B?OFZWZnFxL2s1Z3FrSEU2UW9EZy9WN3dLZWh4eWw3NStOUkowY1lwcUs3R01X?=
 =?utf-8?Q?swYQRTK/blYdc3ko=3D?=
X-Exchange-RoutingPolicyChecked: 
 SZCVrYBsdl87QpofVupQPf/YmScfsuk5109QuL4hZoo/Ynas4a7hOTp4QojHdCvGlkkBKEhfNegf414t2EIa6QaI89YtXRaRCsoavy0ZLfoJ+la35ltckfLIkvnThguJwNwFUThwxVA+4EyjyXaCTI3SYLM23V2sZbSn5i+MEoearsfLJo4QLAhe1E9m48mK0B6I0xoGNlcM+FMR7xBlrz5UPc8tYwolPSzkcsN5t3nHuygwnLKwAGKWZ9X2kCFGqir4L7O4gStBbdqM0qIGVHElSNHkGrL9prb+PVv/UM/auWhv/RCl1vBuCtagASItZjRrqRfFXZm4HPessFnTpg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 836b1787-d568-408d-037b-08dec60c69af
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6967.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 09:49:35.1033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 yu+UXzhrfvtfRg7Z8xhxestmrloI3vGFv35RtP8l9KbW7izM5Dho7nwc3zkT96zFJzIWWhJTJwVrdZ88YvaTp/ODdcqokaxrp0hB6csLiaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4516
X-OriginatorOrg: intel.com
Message-ID-Hash: 6DARMEGWPM6J7CVRGHG3SSYDVL3KVVHS
X-Message-ID-Hash: 6DARMEGWPM6J7CVRGHG3SSYDVL3KVVHS
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6DARMEGWPM6J7CVRGHG3SSYDVL3KVVHS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 6/9/2026 4:41 AM, Neo Chang wrote:
> Add support for the Nuvoton NAU83G60 audio codec. The NAU83G60 is a
> stereo 30W+30W smart amplifier with an integrated low-latency
> Advanced Audio DSP.

Hi Neo,

I've provided a number of possible improvements and nitpicks which scale 
for the entire file - not just the occurrences I've highlighted.  In 
general, it's hard to follow the code.  A lot of arithmetics bundled 
together with limited spacing/comments/self-explanatory names.  Sheer 
number of if-statements and brackets does not help either.

There seem to be quite a bit of defensive programming here too - checks 
just to print a message.  I'd suggest to enlist event tracing and log 
the TX/RX communication unconditionally.  Would eliminate the need for 
many of prints found here.

> +static int nau8360_reply_from_dsp(struct snd_soc_component *component,
> +	const struct nau8360_cmd_info *cmd_info, int data_size,
> +	void *data, unsigned short dsp_addr)
> +{
> +	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(component);
> +	struct device *dev = component->dev;
> +	unsigned int payload, *data_buf;
> +	int i, j, ret, frag_len, frag_payload_len, len_pos, pad_len, pad_len_exp;
> +	int data_count = 0;

13 local variables.  Does not look good.  I'd try to refactor this one. 
Ask yourself - what's the (one) goal this function shall achieve.  It's 
clear that currently it does more than one thing e.g.: performs 
validation of the payload.  The validation could be moved into a 
separate function.

> +
> +	if (!cmd_info->reply_data) {
> +		dsp_dbg(dev, "The cmd without reply data!!");
> +		ret = nau8360_dsp_replied(nau8360, &frag_len, dsp_addr);
> +		if (ret)
> +			goto err;
> +		else if (!frag_len)
> +			goto done;

No need for 'else if', 'if' suffices.

> +	}
> +
> +	if (!data) {
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +	data_buf = (unsigned int *)data;
> +
> +	ret = nau8360_dsp_replied(nau8360, &frag_len, dsp_addr);
> +	if (ret)
> +		goto err;
> +	else if (!frag_len)
> +		goto done;

Ditto.

> +
> +	frag_payload_len = frag_len - 1;
> +	if (cmd_info->msg_param)
> +		data_count = data_size;
> +	for (i = 0; i < frag_payload_len; i++) {
> +		ret = regmap_read(nau8360->regmap, dsp_addr, &payload);
> +		if (ret) {
> +			dev_err(dev, "failed to read payload of dsp");
> +			goto err;
> +		}
> +		if (cmd_info->msg_param) {
> +			if (data_count >= NAU8360_DSP_DATA_BYTE) {
> +				*data_buf++ = payload;
> +				data_count -= NAU8360_DSP_DATA_BYTE;
> +				payload_read(dev, payload);
> +			} else {
> +				for (j = 0; j < NAU8360_DSP_DATA_BYTE; j++) {
> +					if (data_count <= 0)
> +						break;
> +
> +					((u8 *)data_buf)[j] = (payload >> (j * 8)) & 0xff;
> +					data_count--;
> +				}
> +				payload_read(dev, payload);
> +				break;
> +			}
> +		} else {
> +			*data_buf = payload;
> +			payload_read(dev, payload);
> +		}
> +	}
> +
> +	/* check the reply length same as request */
> +	if (data_count && (cmd_info->cmd_id == NAU8360_DSP_CMD_GET_KCS_RSLTS ||
> +			cmd_info->cmd_id == NAU8360_DSP_CMD_GET_KCS_SETUP)) {
> +		dev_warn(dev, "payload_len %d, expected %d",
> +			data_size - data_count, data_size);
> +	}
> +	dsp_dbg(dev, "reading trailing fragment");
> +	ret = regmap_read(nau8360->regmap, dsp_addr, &payload);
> +	if (ret) {
> +		dev_err(dev, "failed to read trailing fragment");
> +		goto err;
> +	}
> +
> +	len_pos = payload & 0xff;
> +	len_pos |= ((payload >> 8) & 0xc0) << 2;
> +	if (len_pos != frag_len) {
> +		dev_err(dev, "LEN_POST %02X, expect %02X", len_pos, frag_len);
> +		ret = -EPROTO;
> +		goto err;
> +	}
> +
> +	pad_len = ((payload >> 8) & 0x30) >> 4;
> +	if (cmd_info->msg_param)
> +		pad_len_exp = frag_payload_len * NAU8360_DSP_DATA_BYTE -
> +			(data_size - data_count);
> +	else
> +		pad_len_exp = 0;
> +	if (pad_len != pad_len_exp) {
> +		dev_err(dev, "PAD_LEN %02X, expect %02X", pad_len, pad_len_exp);
> +		ret = -EPROTO;
> +		goto err;
> +	}
> +	dsp_dbg(dev, "LEN_POST 0x%x, PAD_LEN 0x%x", len_pos, pad_len);
> +	payload_read(dev, payload);
> +done:
> +	return 0;
> +err:
> +	dev_err(dev, "DSP reply error %d !!!", ret);
> +	return ret;
> +}

...

> +int nau8360_dsp_init(struct snd_soc_component *component)
> +{
> +	dev_info(component->dev, "DSP initializing...");
> +	return nau8360_dsp_set_kcs_setup(component);
> +}

Do we need a function that just inlines to nau8360_dsp_set_kcs_setup() 
except for a single print?  Doubt so.

...

> +static int nau8360_adacl_event(struct snd_soc_dapm_widget *w,
> +	struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
> +
> +	if (SND_SOC_DAPM_EVENT_ON(event))
> +		snd_soc_component_update_bits(component, NAU8360_R6E_DAC_CFG0,
> +			NAU8360_PD_DACL_DIS, 0);
> +
> +	return 0;
> +}
> +
> +static int nau8360_adacr_event(struct snd_soc_dapm_widget *w,
> +	struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
> +
> +	if (SND_SOC_DAPM_EVENT_ON(event))
> +		snd_soc_component_update_bits(component, NAU8360_R6E_DAC_CFG0,
> +			NAU8360_PD_DACR_DIS, 0);
> +
> +	return 0;
> +}
> +
> +static int nau8360_dacl_event(struct snd_soc_dapm_widget *w,
> +	struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
> +
> +	if (SND_SOC_DAPM_EVENT_OFF(event))
> +		snd_soc_component_update_bits(component, NAU8360_R6E_DAC_CFG0,
> +			NAU8360_PD_DACL_DIS, NAU8360_PD_DACL_DIS);
> +
> +	return 0;
> +}
> +
> +static int nau8360_dacr_event(struct snd_soc_dapm_widget *w,
> +	struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
> +
> +	if (SND_SOC_DAPM_EVENT_OFF(event))
> +		snd_soc_component_update_bits(component, NAU8360_R6E_DAC_CFG0,
> +			NAU8360_PD_DACR_DIS, NAU8360_PD_DACR_DIS);
> +
> +	return 0;
> +}

Refactor the above four functions - you could create a wrapper to lower 
LOCs without huring the readability.  If you prefer, instead of a 
one-for-four, you could have one "positive" wrapper (handles EVENT_ON 
cases) and a "negative" one (handles EVENT_OFF cases).

...

> +static int nau8360_codec_probe(struct snd_soc_component *component)
> +{
> +	struct snd_soc_dapm_context *dapm = snd_soc_component_to_dapm(component);
> +	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(component);
> +	struct regmap *regmap = nau8360->regmap;
> +	struct device *dev = nau8360->dev;
> +	int ret, vbat, vsaw_level, vsaw_slope;
> +
> +	nau8360->dapm = dapm;
> +	nau8360_coeff_set_def(nau8360);
> +	ret = nau8360_dsp_setup(component);
> +	if (ret)
> +		goto err;
> +
> +	ret = nau8360_dsp_setup_controls(component);
> +	if (ret) {
> +		nau8360_dsp_enable(regmap, false);
> +		dev_err(dev, "DSP setup controls failed(%d)", ret);
> +		goto err;
> +	}
> +
> +	/* default disable Sense signal after booting */
> +	snd_soc_dapm_disable_pin(nau8360->dapm, "Sense");
> +	snd_soc_dapm_sync(nau8360->dapm);
> +
> +	/* VBAT is sensed by chip. */
> +	ret = nau8360_vbat_level(regmap, &vbat);
> +	if (ret) {
> +		dev_err(dev, "Failed to get valid VBAT level: %d\n", ret);
> +		goto err;
> +	}
> +	dev_dbg(dev, "VBAT %dV for nau8360", vbat);
> +
> +	/* Config sawtooth clock according to VBAT. Class D modulator input short setting
> +	 * for mute and de-pop purpose. Restore normal after initiation.
> +	 */
> +	ret = nau8360_sawtooth_params(vbat, &vsaw_level, &vsaw_slope);
> +	if (ret) {
> +		dev_err(dev, "can't get sawtooth clock parameters (%d)", ret);
> +		goto err;
> +	}
> +	regmap_update_bits(regmap, NAU8360_RA5_ANA_REG_1, NAU8360_VSAW_LV_MASK |
> +		NAU8360_KVCO_SAW_MASK, (vsaw_level << NAU8360_VSAW_LV_SFT) |
> +		(vsaw_slope << NAU8360_KVCO_SAW_SFT));
> +
> +	return 0;
> +err:
> +	return ret;

Why are we using the goto here if there is no unwinding found within the 
error path?  Either you've forgotten to add the unwinding or the goto is 
redundant.

Repeat for all the functions with similar behavior found in this file.

> +}
> +
> +static int __maybe_unused nau8360_suspend(struct snd_soc_component *component)
> +{
> +	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(component);
> +
> +	regmap_update_bits(nau8360->regmap, NAU8360_R90_HW2_CTL0, NAU8360_HW2_STALL,
> +		NAU8360_HW2_STALL);
> +	nau8360_dsp_enable(nau8360->regmap, false);
> +	regcache_cache_only(nau8360->regmap, true);
> +	regcache_mark_dirty(nau8360->regmap);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused nau8360_resume(struct snd_soc_component *component)
> +{
> +	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(component);
> +	struct regmap *regmap = nau8360->regmap;
> +	int ret;
> +
> +	regcache_cache_only(regmap, false);
> +	nau8360_peq_mem_enable(regmap, true);
> +	regcache_sync(regmap);
> +	nau8360_peq_mem_enable(regmap, false);
> +
> +	/* disable Sense at standby */
> +	snd_soc_dapm_disable_pin(nau8360->dapm, "Sense");
> +	snd_soc_dapm_sync(nau8360->dapm);
> +
> +	ret = nau8360_dsp_setup(component);
> +	if (ret)
> +		goto err;

Drop the goto, no error handling here.

> +
> +	return 0;
> +err:
> +	return ret;
> +}

...

> +static int nau8360_reg_write(void *context, unsigned int reg, unsigned int value)
> +{
> +	struct i2c_client *client = context;
> +	int ret, count = 0;
> +	u8 buf[6];
> +
> +	buf[count++] = reg >> 8;
> +	buf[count++] = reg & 0xff;
> +	if (reg != NAU8360_RF000_DSP_COMM && reg != NAU8360_RF002_DSP_COMM) {

Refactor to positive a check.  Positive checks are easier to follow and 
as long as there is no major impact on complexity of the code that 
follows, there is no reason to hurt readability.

> +		/* format for Codec, 2 bytes value and endian big */
> +		buf[count++] = value >> 8;
> +		buf[count++] = value & 0xff;
> +		dev_dbg(&client->dev, " %x <= %x", reg, value);
> +	} else {
> +		/* format for DSP, 4 bytes value and native */
> +		buf[count++] = value & 0xff;
> +		buf[count++] = (value >> 8) & 0xff;
> +		buf[count++] = (value >> 16) & 0xff;
> +		buf[count++] = (value >> 24) & 0xff;
> +	}
> +
> +	ret = i2c_master_send(client, buf, count);
> +	if (ret == count)
> +		return 0;
> +	else if (ret < 0)
> +		return ret;
> +	else
> +		return -EIO;

No need for 'else if', 'if' suffices.  And the 'else' can be dropped.

> +}

...

> +static struct reg_default *nau8360_alloc_defaults(struct device *dev, int *total_regs)
> +{
> +	struct reg_default *dyn_defaults;
> +	int reg_num = ARRAY_SIZE(nau8360_reg_defaults);
> +	int total = reg_num + (2 * NAU8360_TOT_BAND_PER_CH * NAU8360_TOT_BAND_COE);
> +	int i, j, idx;
> +
> +	dyn_defaults = devm_kzalloc(dev, total * sizeof(*dyn_defaults), GFP_KERNEL);
> +	if (!dyn_defaults)
> +		return NULL;
> +
> +	memcpy(dyn_defaults, nau8360_reg_defaults, sizeof(*dyn_defaults) * reg_num);
> +	idx = reg_num;
> +
> +	for (i = 0; i < NAU8360_TOT_BAND_PER_CH; i++) {
> +		unsigned int l_base = NAU8360_R100_LEFT_BIQ0_COE +
> +					(i * NAU8360_TOT_BAND_COE_RANGE);
> +		unsigned int r_base = NAU8360_R200_RIGHT_BIQ0_COE +
> +					(i * NAU8360_TOT_BAND_COE_RANGE);

Just add a local:
	unsigned int range = i * NAU8360_TOT_BAND_COE_RANGE;
to simplify the code.

> +
> +		for (j = 0; j < NAU8360_TOT_BAND_COE; j++) {
> +			dyn_defaults[idx++].reg = l_base + j;
> +			dyn_defaults[idx++].reg = r_base + j;
> +		}
> +	}
> +
> +	*total_regs = total;
> +
> +	return dyn_defaults;
> +}
> +
> +static int nau8360_i2c_probe(struct i2c_client *i2c)
> +{
> +	struct device *dev = &i2c->dev;
> +	struct nau8360 *nau8360 = dev_get_platdata(dev);
> +	struct regmap_config regmap_cfg = nau8360_regmap_config;
> +	struct reg_default *dyn_defaults;
> +	int num_total_regs;
> +	int i, ret, value;
> +
> +	if (!nau8360) {

What?  This seems redundant.

> +		nau8360 = devm_kzalloc(dev, sizeof(*nau8360), GFP_KERNEL);
> +		if (!nau8360)
> +			return -ENOMEM;
> +	}
> +	i2c_set_clientdata(i2c, nau8360);
> +	mutex_init(&nau8360->lock);
> +
> +	dyn_defaults = nau8360_alloc_defaults(dev, &num_total_regs);
> +	if (!dyn_defaults)
> +		return -ENOMEM;
> +
> +	regmap_cfg.reg_defaults = dyn_defaults;
> +	regmap_cfg.num_reg_defaults = num_total_regs;
> +
> +	nau8360->regmap = devm_regmap_init(dev, NULL, i2c, &regmap_cfg);
> +	if (IS_ERR(nau8360->regmap))
> +		return PTR_ERR(nau8360->regmap);
> +	nau8360->dev = dev;
> +
> +	nau8360_reset_chip(nau8360->regmap);
> +	ret = regmap_read(nau8360->regmap, NAU8360_R46_I2C_DEVICE_ID, &value);
> +	if (ret) {
> +		dev_err(dev, "Failed to read NAU83G60 device id %d",
> +			ret);

No need for a new line here, you won't exceed the recommended char limit.

> +		return ret;
> +	}
> +
> +	for (i = 0; i < NAU8360_TDM_TXN; i++)
> +		nau8360->tdm_tx_func_slot[i] = TDM_SLOT_NONE;
> +	for (i = 0; i < NAU8360_TDM_RXN; i++)
> +		nau8360->tdm_rx_func_slot[i] = TDM_SLOT_NONE;
> +	nau8360->tdm_chan_len = 32;

Either use constant or comment any use of hardcodes.

> +	ret = nau8360_read_device_properties(nau8360);
> +	if (ret)
> +		return ret;
> +
> +	nau8360_print_device_properties(nau8360);
> +	nau8360_init_regs(nau8360);
> +
> +	return devm_snd_soc_register_component(dev, &soc_comp_dev_nau8360, &nau8360_dai, 1);
> +}
> +
> +static const struct i2c_device_id nau8360_i2c_ids[] = {
> +	{ "nau8360", 0 },
> +	{ }

Please match the style of existing entires.  Checkout Mark's for-next to 
be up-to-date with recommended style or see commit 910714d4e79b ("ASoC: 
Use named initializers for arrays of i2c_device_data").

[1]: 
https://patch.msgid.link/ae2ff4898eb340bd8bcafb7b75443eb4a0ce3e76.1778692164.git.u.kleine-koenig@b
aylibre.com

> +};
> +MODULE_DEVICE_TABLE(i2c, nau8360_i2c_ids);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id nau8360_of_ids[] = {
> +	{ .compatible = "nuvoton,nau8360", },
> +	{}

Ditto.  Sidenote: you've used a different style then for the i2c table.

> +};
> +MODULE_DEVICE_TABLE(of, nau8360_of_ids);
> +#endif
> +
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id nau8360_acpi_match[] = {

struct acpi_device_id is available even if CONFIG_ACPI is disabled.  Not 
sure if we even need preproc #ifdef here.  Remove it and do some 
compilation checks.

> +	{"NVTN2002", 0,},
> +	{},

Ditto.  Sidenote: you've used a different style then for the i2c and the 
of table.

> +};
> +MODULE_DEVICE_TABLE(acpi, nau8360_acpi_match);
> +#endif
> +
> +static struct i2c_driver nau8360_i2c_driver = {
> +	.driver = {
> +		.name = "nau8360",
> +		.of_match_table = of_match_ptr(nau8360_of_ids),
> +		.acpi_match_table = ACPI_PTR(nau8360_acpi_match),

Does this compile if I disable e.g.: CONFIG_ACPI ?

> +	},
> +	.probe = nau8360_i2c_probe,
> +	.id_table = nau8360_i2c_ids,
> +};
> +module_i2c_driver(nau8360_i2c_driver);
