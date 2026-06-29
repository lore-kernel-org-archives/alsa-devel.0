Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15854C43458
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:17:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 468B7601F1;
	Mon, 29 Jun 2026 10:16:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 468B7601F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782721028;
	bh=mUt31l728fKC67WXP+4PGfDTxQuTaJcPh3XXkLKaj5c=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=psgnGc2vnVsSWP8goUkGbXO8Qmi8rmdbt8HEK9+jeDAtWFGrQus8GXDpe+/C044Fq
	 FziAHiudlzWf7i8J92FMGlZHweNZN1vB5E02hxzamns+37p28AunBUIZ5eWbCkhKo6
	 O2vQoL7fn5ZqN+Mv2v60eKsc5MOrOflWcBJ5r68k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B6605F805F3; Mon, 29 Jun 2026 10:16:32 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EB9D5F805F6;
	Mon, 29 Jun 2026 10:16:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7014BF80495; Mon, 29 Jun 2026 10:16:26 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=fail smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=fail; t=1782720985;
	b=D1DY0745CKsK7ld4wXjK1FKXSzTRKqf7tobiYMb3NEqTSvUJT/vTguzlw1iZNv6qFCS/
	 JT641mW8XA9aPDzy6jBdlpSTtE7HY7AoVcIZybhEi6kG1Gk/f6r82AaIdONS4pdpLR+cp
	 Q8Rb4/cTcY9Zik+7mX/pA/7J6/ow+4rNd1sGCLmZu4+SgnVIFTh1yY+WbXLtRyt38xTGi
	 pQklh7cSQSCkdCE0sNAz46myD+Z3pwKqVM6SHuAvf5gjP9HtvK480LNmFgtfxCbxV7Etp
	 8MDGQm9ZS2HQa4UJygs2WgQ4sAFMWgCj3Ab+7RGCejyTHkD59f/yDySXe0a3RJZ5Mhg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782720985;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version;
	bh=mUt31l728fKC67WXP+4PGfDTxQuTaJcPh3XXkLKaj5c=;
	b=XGrOiaaXpZHyxWb2RpqWj+I5hV/nR82qj9cKjVQOM3ObGNeAzU1kcZ9rAznfGXD0f1PW
	 4lkIsgcdo1kdQlus1oMZskaa9IgKtEs0GcX0hKP7XuC+UhHC0T+VbajMEnOoQbnNum2Xq
	 dpthyMB3KtfLWBH9XRjavi346txhV9v0HUD1XhpEeTSGxM++n30J0V/qjy1AiMpRG5LZ3
	 abuj8BQfqbcCBsG8kWq12LXfrEtgLt5nWpbWuohcy/EJU/FdFBFA8FFpxS9EhP6fZqM/Q
	 yvIadZI1wZMGRVs7QGkWUamu8VE7tiBvCtkfI4kTIHllx1FkeioAa3NCpQoR92tDC9w==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=HXa1C7Ri;
	arc=fail smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 02D58F80124
	for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2026 10:16:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 02D58F80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=HXa1C7Ri
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782720985; x=1814256985;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mUt31l728fKC67WXP+4PGfDTxQuTaJcPh3XXkLKaj5c=;
  b=HXa1C7RiA1Hm5o7GpWgJ4W7x6p7JleYtugM49sTlwBjfofORDX+Dccmj
   wn/KUEN50DvPkR0qcpeva8A9lq7g1s7Vf33GVTVabZoXgjboDZYx7/2mZ
   7dT/si7CFskybFgALosCnIvwHyv+i1p7rJDQW7NEsA9hIRrCpuRX9kwhI
   7yMMqIDdgP6QlaWZP0RH7XLJ+USfVh9yCECWOuIBFX6XhUZRE/rRtqApb
   Z52xobf/pTcts9hf4UGRF/mVMnxCksGY86N0Zco2bQ8GwVHt3jKttp2K1
   +mPVsyZPl3uXVXDlGrsy+jTkH0nhr82p58Rncex+VwO2vIYYKrSvdDb3/
   w==;
X-CSE-ConnectionGUID: sugVCW33SfuRWwGmly031w==
X-CSE-MsgGUID: rI3hJB0EQpCcG2w6mJtBhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="83408137"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600";
   d="scan'208";a="83408137"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 01:16:19 -0700
X-CSE-ConnectionGUID: b+SeRvCZTBiTsMITYdgt2g==
X-CSE-MsgGUID: stuXkWosRJS7W6g10SvC4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600";
   d="scan'208";a="252028646"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 01:16:20 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 01:16:18 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 29 Jun 2026 01:16:18 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.61) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 29 Jun 2026 01:16:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GutydmjO0C88vQPH8TBfnqM1tJaV6fUTkYpngPSgXF2BGGh6U9lFZ9UUI1fi6JHJEW2tvKOeaVvmMT5EuFrjPXHDjY1WGNoDrgasPQ0yKOJCQRif/r9mr3g35SZ4htPFK4BujiFDbTuxD7OqLT7/fC4o89ROFFJDAynS88lvxz7DgjFXemuZDVBx7DRRd5LS2sYIu66QOleU/U8xiPoTnmBQhaQz92SSSxbEZfcbLh/EJucclp/Ksh5qDo/mCEbsoIpKg1bi1fy/7EqdJEMlH0D/dHDgHwGY0dTLSLc7PzzMQPO8ODjIj1Fws5nJNGSEgG8aLc8OOxAbn+AoogAp8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQctrRMGN8YsGIj6a57fLRlhO6KeI1bMp/yjdrFYSCY=;
 b=FKf/iQd6RGRuD8Adviyznp13o5FxGjcizHwxGPaooRkVfDE1q5YNRcQNSixt4R4coA7PkKdqt4eflrGlD5JcYlWGYoJZOSOsMqYrGzzE8LM8oUGUaG5fjdW6V6Ow+XEgT6fT7ucatm7A6UFlONrkGhBxzTt8TQlIAhoeRe7AR6NF/ksIUCx87PdrSAGtqoAPa3dP9U3p9NXJY9DdBtAVWAlpBC4nuLMthKiBcA0wA+d8MZ+yl6Kb22XYtaS4rjajrBGwXSpgilPwp1T+V5hSlfv7BkhmA3IHTmqGfH8x1OYxO4izrKumQs0570nB8WN3s0vBLk5GEMwCCjDjXBhvMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6967.namprd11.prod.outlook.com (2603:10b6:806:2bb::15)
 by MN0PR11MB5961.namprd11.prod.outlook.com (2603:10b6:208:381::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 08:16:11 +0000
Received: from SA1PR11MB6967.namprd11.prod.outlook.com
 ([fe80::36a9:3aca:a63e:c8f4]) by SA1PR11MB6967.namprd11.prod.outlook.com
 ([fe80::36a9:3aca:a63e:c8f4%3]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 08:16:11 +0000
Message-ID: <952140ad-5fa6-45cc-bf0a-b9968d4db404@intel.com>
Date: Mon, 29 Jun 2026 10:16:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ASoC: Intel: soc-acpi-ptl-match: add tas2783 support
To: Baojun Xu <baojun.xu@ti.com>
CC: <tiwai@suse.de>, <andriy.shevchenko@linux.intel.com>,
	<13916275206@139.com>, <alsa-devel@alsa-project.org>, <shenghao-ding@ti.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <k-yi@ti.com>,
	<henry.lo@ti.com>, <robinchen@ti.com>, <niranjan.hy@ti.com>, Mark Brown
	<broonie@kernel.org>
References: <20260628122543.757-1-baojun.xu@ti.com>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20260628122543.757-1-baojun.xu@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0003.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:357::7) To SA1PR11MB6967.namprd11.prod.outlook.com
 (2603:10b6:806:2bb::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6967:EE_|MN0PR11MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: d3cd1f0c-19dd-458b-a10c-08ded5b6ada9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
 5uOKm/QPLxtRU5WfE4CQWK4WAPk1troz3rG72G5HRN+66M4trN0Y3y4N6QXMExbzSms6lw2eZ70fJHObLm2ZrfGmrV8YTEHCP4+NsykTPpoD2ArirWeRGy+tkWgYtEuB0iXAO2FCrFBBvhpL45ExBQOXjW2J2BXP3Nfxy3lJUTblZ69UfkS7rCQsgJEDBEKwWY7MswH1XUMHsZFbCHMp434bz2Ahrdw8pX7SCe5XlwaUvCIVdmUWZSdvl7XYFU51t27NPSS/s2qGgYS1jqs016RrrQz4jD5GFpDNbcTVtHmXQPvlNUwM3hPl5YPzXwLY2thaWw5/Ea8VY7JGNT7x0XBaN3XrsN4X5OC7epmVqA4GaUnfeICqL57DOCvm7TQiznuikHebN2RnmZbe3xTdYaWpJzM8WZsfKCIrUQhY+0B7sQkR95L+yq5kGzAkQdg6q08x1CTsG2iTj2kaIjOUZybwC7eXdmRUTJmPF7bmeQIcjVQ2vK2x8sVAmrVkIRjmQB+inHe7FipPGITzXdOZVAWRu1uqpmYTji1Lpugc+Dc4g0uZjCSIhqw5W/9dplnR+LRqsTfOFb/3Lhl8M3FVB6erSmhdXMNPTcS5q1efpDR/SN+02Mmt/Z4UsWaVh0VVTR+57hzvXxO6y2Xa+PzwmhPSuVhalFjvRsh+Zd6MPRE=
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6967.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?bnkzM0hRZE9UWlFzNjhXY0dveGtySG5QNUlmYWtRU0FnNEVwQlZQY0ZjcHNy?=
 =?utf-8?B?L0FRTXRmYTlDcFBsZ1RMY21SMC9DT3ZoaEI5QzhxaG84OEptWGUzK1A5L1Y4?=
 =?utf-8?B?L2VOeE05czFUNjZDNEthUWpuNGNSN21UdzNJdThTWVZabVg1WEdMVUdYcHR0?=
 =?utf-8?B?OWFvU0lEYXJPdWFKNmNZbkVKVlZKSHg1dkN5K3JUeVRaZU5VS21aNXpEWXFH?=
 =?utf-8?B?YnRaK2xBSjM0V2hJcjRBL3o5RHA3cVpaZFg0ZW1HTUg5Z0lNYzJ5UnhnenpU?=
 =?utf-8?B?YjJlYVFRZ0t1K1lOWWkzVjhHWjRXb1NWbmN1ZThEMXlReEZxT3o5Y0tXVk44?=
 =?utf-8?B?dzRxWE5icVRGK0Z5bWJpS3pacWdVY3ZidEN6RHJONWxGMjJHVlNTdEUzUExy?=
 =?utf-8?B?MDFPbHNESjAvbjRvVkpHbVFCK0tNbFJRZ240ZHBQWGhrcWNheWZNL3RFdnJT?=
 =?utf-8?B?Skk4bU9BYS9wa1JZT2Fjd0hYbnZPSzhhL0ZnYXdQR0Z4UmtFZGRjS2UxYzJp?=
 =?utf-8?B?WWFaRkhjWHJSdjNKVVRhQzZvbW9YYjh6MVUyTDZ4Y0JuZFBQb3dtckFzTDVF?=
 =?utf-8?B?YVdVbXQ3LzkwZ1A0dXNMVWZCS2lNZGhlYmJTVi9vOUMwL2p3NzF2NXNvT0xU?=
 =?utf-8?B?M0hseFczT2ZFWlFqVGlrbDlWNGV5d3FhTjVsVENVQS9ES1VXbVhXT1NadVNs?=
 =?utf-8?B?MzlHRzNmTWhPV1FPVGlndnNVUjExMkpOMi8xY0R5S3pSYUFXL2xxcnhiTlVK?=
 =?utf-8?B?d2tMNXpta1R3WFEycXpaOEtENWJNaGU3d3UyRXNkMjZPL2xCYWdWMnBDYzQ4?=
 =?utf-8?B?L1VqNmtteGVKd1RLbmtBVVZjWGxkZCttT1dJMEVQdDBDNW1VUFN0aGZzdkxo?=
 =?utf-8?B?M3BSMXViQzJnTUJtK1dqQUcvUVlhcDZqYkpvMkEwMVM5Sk0yZHZobkEzcy8w?=
 =?utf-8?B?VkdVYzE4c0xndnN0V0ZpWTRoSENaaVN2MW01ZStVVFFXVjczcUdVbjFBN2ZN?=
 =?utf-8?B?b0dkZmlMTkMycUZXUmhhUjJqMEZZc1RXQWFYN09uS0YwYTQ2cjdlanpYc0Iw?=
 =?utf-8?B?TjhQS1hIZkJtSHRKTVE3WGRrcmtBZStaeUkvRytDWmw5dk8wK1F2ZGJTeXl3?=
 =?utf-8?B?Nzk4K2xSMyt0VnVwOFdNSFlzMktTRDgxMVNTTzVmZXp2ZmhzN29RSjFBZG52?=
 =?utf-8?B?bEVXUit5ZFhoeThST3hXQzFrbFdBamlWQk5OUXV2WW8wcFhrSEduTkxDWmNM?=
 =?utf-8?B?QjNjeEFrOWk5cU5TMDI3MHdXUk1mdTc2aFRnR0JKNXBpWlhnd1RkRkZ4amtJ?=
 =?utf-8?B?aUYzWFp1ZUdQRCtlZStnYTg5czhkenVrRWNPU1hMVFVITFhmTWVSQ0RUZVov?=
 =?utf-8?B?NTUwSWpFd1dFdmdhcFZDUm1qVFd4blZjWEVIeGZiL1dMZXpadFFCclJpNlZ3?=
 =?utf-8?B?WlFkRWxLRStiYzl1VGc4UnMwZFdlbE1GRHhjaG5HQUpwVUsrZDhSV0VDc2Yz?=
 =?utf-8?B?eDVmQ2ZBZkdxaUxlZVNEU0Q3YWZJN1Z3bVU5UzNad0RjdURxUEhQeDdadVN6?=
 =?utf-8?B?eDRoVGZESVhkVzBmR1RaR3dVZDJoUUY2MjQ1dnVhd0krM3dXa1Z3T2JUdW1j?=
 =?utf-8?B?ak05ZWpXaHVCdTAzOWZ3anB2VGwzdVdOZ0JzdkxTUzc2dllwQUFBZ3dYY05I?=
 =?utf-8?B?eDJuemE3TzhPNlpOQzdjN1VENEd2Q1l6dlhBald0bjJkdE9JTUx4MnFRR0FW?=
 =?utf-8?B?dm5TMEw0TGQ5b3MvN3VuNEFndDIwWXBoYjhJcTN2MW02aHVJKzhVdkFldmJG?=
 =?utf-8?B?R25ZN2lNRFFncEN4MmJ1OURLTWVQVEs2WWFkczZQZmQ5Y2FBN1ZjMlkvNlpX?=
 =?utf-8?B?Y1UwaGwwaVdJbThqOEp5Y1JCWCszMFJYelhTNml5dUlsUWVHOXIxRXhqTmQ5?=
 =?utf-8?B?QXZEQXFEUEIwQzZHRzJIc25ZRDhLdTlXZGh1NysrQXhPbFkvSkpHR0xvUlBw?=
 =?utf-8?B?ejZUWlNqb3IxYXFYRFZwSHdLNXF1ZTErR2U2aFZEUTJxTXB2K1VWYnZDU2Jl?=
 =?utf-8?B?eDJENjROUVoxLzBZaTB4dHRlclJTb2lDd3B2R1BrQXlhUVJRQk56eE5Qbk0x?=
 =?utf-8?B?UHV6OFhrU2l0VGRHbnNCY0ltTVBLbmZnMHg1MjF6L3B4YmQ4MEZXM0NpVGpL?=
 =?utf-8?B?NGdEL20wQkZNZHdZdVZwbnVWY1VlRFJaM3I4OUZtZHQ2UkV2azVHaFY0Tm9z?=
 =?utf-8?B?VVFlMHhaODBMQ1R2WlRDSXl6NUlPNERWTXNlS001TGJFc0V0VFdFTnZzT1VX?=
 =?utf-8?B?WDVhWTFrcjVkZTRGVCtLTXpQOFBQSW1HUHVJeEFVQW1vWWZpeWJOVmdxempJ?=
 =?utf-8?Q?nI0zvxV9J/NM6aqQ=3D?=
X-Exchange-RoutingPolicyChecked: 
 NQd/XznJ84ROJhhNWUwtbPV98wqPqSeilGovpQgWpBhig3OqqfZFBNi7OxMGGQBQTE5C861/5CxJESfHDYCcBeYs/5ruL6Ckbaypv3OQT3cvD+7DjO6R9yqvpA/w7BpN82/ZRf91+UzTUT2i6afqZmDzHYy4JS7NohqmkXp9rDVGvs4lRYoXfsh0hYfMNEsAKKvIP1hkKbNMCn/rUYbmU0Ik1putJW8axslsZd1Xk45b7IVl4TGp6NYBTfq1bSVemXf2DxaljIsp/AzvanZegC2u/iM6yHi925A33Tkt9d7h+uIfAI4ydpJ2elYMxcy0KkvY3KrV9ZOUKGJZJdkbrw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 d3cd1f0c-19dd-458b-a10c-08ded5b6ada9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6967.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 08:16:10.9883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 2cXP78jv0/XHThXMBxeRYVcVzC0h1MsigegU8/uERjaVV7gjY02+ZHEJ4Hr+F0RfPEQn+6omurby/bGYQKO/T4MjUzBFIprxJLC9WKsQjWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5961
X-OriginatorOrg: intel.com
Message-ID-Hash: UCVI3XNZ47D54KL5LHXLLFVLZCCQ426B
X-Message-ID-Hash: UCVI3XNZ47D54KL5LHXLLFVLZCCQ426B
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UCVI3XNZ47D54KL5LHXLLFVLZCCQ426B/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 6/28/2026 2:25 PM, Baojun Xu wrote:
> Added tas2783 support in some projects.

No patch "added" anything.  The patch is a proposal to _add_.  Please 
rephrase.

Next, why is Intel's soc-acpi-ptl-match altered when it seems the board 
is supported only by the AMD component?  Commit's title does not help or 
clarify the situation either.
> 
> Signed-off-by: Baojun Xu <baojun.xu@ti.com>
> ---
>   sound/soc/amd/acp/amd-acp70-acpi-match.c      | 64 ++++++++++++++++
>   .../intel/common/soc-acpi-intel-ptl-match.c   | 74 +++++++++++++++++++
>   2 files changed, 138 insertions(+)
