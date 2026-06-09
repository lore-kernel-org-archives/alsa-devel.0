Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55458CD8CAD
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:23:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 95E6E601CC;
	Tue,  9 Jun 2026 10:23:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 95E6E601CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780993396;
	bh=tYIt6sPOAM9SRkiznx62M1zPcis7YsQbJTCf6FgtUro=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=cjJI+hQa3JaRFownSXAigYQhjh8Vorf4bsgz6ZI5xvv5AfGIC4QvDgwuBG5Egw3oM
	 XcJBfavOgKdu2Mvs+yT1prfEj0KIU+bgXbWRA7f6mJvMjdLUt8lLKPqHfyao796Kf/
	 pKPRSRMqTBasjieeTa7UdZad9TH2Jt+dmJDn/qG4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C291AF805FF; Tue,  9 Jun 2026 10:22:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1516CF805F3;
	Tue,  9 Jun 2026 10:22:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AC998F80496; Tue,  9 Jun 2026 10:22:33 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=fail smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=fail; t=1780993352;
	b=VNk/oe3OD8onSdx4ThxqlNBoynd+1f2sFhnqIUZYKRE/FOofw3CTcva9iD29OzCbD//8
	 RT/ZfCXscsJnPF2JPVpsZDjxEKk2JFHKcZenTnoQGIrrtnqjgBG5MFidTPCKOqlE43qbx
	 l2zsTEP2HjqCgy1vCVbJDR0+0SqPTwmp4reauBZAtnMfyXhovSxdJECSePQHtoD8nVB9K
	 H48ZvC2kb9ECRrAaULBp1kaNxrCYWHQ3Y6nfZUsuo4t4ME+xETOFsjrCTA5Cp5wi2a19+
	 CVptwAy9W7nZTAVhSl1PJpp3qvn569IXmSX22O4d7q1KX+HjkC9Yh3+9XmdGTExdTKQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780993352;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version;
	bh=tYIt6sPOAM9SRkiznx62M1zPcis7YsQbJTCf6FgtUro=;
	b=SdhBss4j1qhNGUSXh6bMl175q08TQedCFEptpNdZX5eS2bTlOjOIyGRWN3PauN48ATYq
	 6fkbbHjySeR4b8eqM9iI8YFZ7lccZfZnimoSDr3U5H+M03J8Tt6N7enK69PAkHNJsWbhF
	 COnhLIO+YnYvk1p8dBt/YDFKkrcSJlmZ9/lpv/cRDOYYmSVwe6TAuYKkj9hwhFkrnDrgJ
	 dohApNHDWAkQsiAOysg+VP/EQ8hiSHnw9sLIFMVQnCuufqYXuM+sEB/W33DYChPYL6KBA
	 IiN4pvivxGltabgwMRIiFIzlK9sDgwqFrr5HSk9r+DPKu1FmG0/HJCadkTRwC33OPXg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=OhIweR35;
	arc=fail smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 54547F8001F
	for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2026 10:22:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 54547F8001F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=OhIweR35
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780993352; x=1812529352;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tYIt6sPOAM9SRkiznx62M1zPcis7YsQbJTCf6FgtUro=;
  b=OhIweR35aVritQ3o46OqZ43JlSZZQ+/Cc7CyWEENQxlnwpsEyO3R+hQ/
   LwGY3VPMqBvbxBASNyRM99gkn7JCv4hbjbXch5soFUK42wPr7h+tiIzUg
   RXKFiwxDKkqM7oxR2/83Pw1EqedoZDCupGFmJFpwgQaLzzTIsZ7GM52p6
   vEOQKsihhnJX/uNVs70i3jZHC2XdIORtReWnNgZjZkfuVuK7Gq/B11nYU
   p3rIjCEdJbQoGiwVhnvPAkK6U56ox8cWoCLbGR2h/dkfDLEpdKJk4zd4W
   ZKJbPR6sqMWb+BZ7JxDLy2mGFN7aY5kPk8LReDsh8VcakwH1JPUhu+lft
   Q==;
X-CSE-ConnectionGUID: JAv09EIuT0a+iV69pi6YiQ==
X-CSE-MsgGUID: 4lnT4ythSn24S4DoVnk51A==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="104412155"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600";
   d="scan'208";a="104412155"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 01:22:26 -0700
X-CSE-ConnectionGUID: zPi2rs4IS2aMSuivRVhufQ==
X-CSE-MsgGUID: SZB6O/4eSJK80yeW6Gt3Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600";
   d="scan'208";a="244642356"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 01:22:26 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 01:22:26 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 01:22:26 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.41) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 01:22:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/tXsrJo4oU0bDmGAZBcgtkQVqiEjfYcBk+/HBZ2HboZRD6Ls9vX70lZpJmktM2iE1HNzcN+VhKIGGKZkP+Fj7W/GgMTEx2APk/dCNaRBFym1FqmDv4OjVmsxm89gCn2eqebyKf7POeE2yP0K9PWsJ9XykXujfgPZuIDKLjllzJuJc6n2tsp3Ug3uay6Qx0ekUm0T+kjg4icyQ0r11pnYdRTaWgTQ7+SPkHqTaFF/QbkGfYXV9hIChv+/5JjhlbXbjsi8gf6h413sB44q0dEUITwRi9F+VWvHS2jYvASElUAE06weLSjoNLNRgXaLUOVF3hxyEKU7tRpg+Lk1qWrqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGjwim/JILwcyNzKjRQr6iu8kfelfLETcUGXKh8E7KU=;
 b=YoDiNPLM5n6BmwjgREYje0YFOB6dK6W6Ph10BnL82TCn+1uUguleUcCz6ozYOg/6VjvefmGS5aM1dlms7MlohRfq5rDZenpvTeNw1XMNFdXDOGkM037GulHoFKrO+blXklv7uYAUHVTCqdLp9RApHv7+9/dggKVJQhS6I6A6qQs785j7iktCSXKESGo5Nian9F3hzfUNkcyhU2UH5CDFMF4MywIBuKncdi9LbGnq7HI7DFbGrA3p2M2FFJRZB4kTaeQgIEchq/e0NhcB6xWU4/abPMrey+rb++psdAK+wsWe04dXcioSj14p+Ab/js/vLO2XvyDwEwP6I87aOcC6IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6967.namprd11.prod.outlook.com (2603:10b6:806:2bb::15)
 by DM3PPFCB5A2AEE2.namprd11.prod.outlook.com (2603:10b6:f:fc00::f4e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 08:22:20 +0000
Received: from SA1PR11MB6967.namprd11.prod.outlook.com
 ([fe80::36a9:3aca:a63e:c8f4]) by SA1PR11MB6967.namprd11.prod.outlook.com
 ([fe80::36a9:3aca:a63e:c8f4%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 08:22:20 +0000
Message-ID: <7578b308-0394-47d4-a391-ddaf7354fbb5@intel.com>
Date: Tue, 9 Jun 2026 10:22:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v0 0/7] ASoC: codecs: ES8389: Modify the ES8389 driver
To: Michael Zhang <zhangyi@everest-semi.com>
CC: <tiwai@suse.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <alsa-devel@alsa-project.org>, <broonie@kernel.org>,
	<devicetree@vger.kernel.org>
References: <20260608083540.12581-1-zhangyi@everest-semi.com>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20260608083540.12581-1-zhangyi@everest-semi.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0019.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::26) To SA1PR11MB6967.namprd11.prod.outlook.com
 (2603:10b6:806:2bb::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6967:EE_|DM3PPFCB5A2AEE2:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aa4512d-ebe1-4f44-5767-08dec6003973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|22082099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
 EymzohcnsRLM59+O3TiLsLhnJ+2mpL4uQuG68dSpk4X4KfhUjjHJheJew5+LWM0F7aJm8GF7rhaH+SNb1VcwbIhatXpkBifBSuDO9BTPmOHmOfl4PTCMOKiDblESpRkrdseEViJIbYOaY4d3eV3c0ft+NisZfQxAqCK2hA8nlC2OlmrdP5VkG+uI3MhBLDo4ADz9JuhUsjRgL0kZrV1OMwk2UAFh7WsZtbcK9PNamJaMwHrqaHHihwvdmQvNn3uvIWZLhIWqnOQPBQ8clTY82vEdfVVMDwmAqNGtnAdy0NnWFnbYSwF/kHq7gFiRyknzbDZ55dD7suZp4OP5zKK+7nF6PyqVj7hfM2DxmuxskY4Hqol2YJiVR9xpZbNOryQRe01ubkolHsybFJxzF3XQsEEinXpZkjfuUq5i1vGAotNTOJDLfM/6ACtDDBZYGxEU8E4C5Nv5uz4qtGTk0klhjDcVU5SmMp/U9My+rjTTAbsHOlXQzcJ0GLAzjPNeIq90mz/uYIaorOWTwKGrdxH/1JrQ+cQKeQbX7eDgc0f4goaEKNy3ZTpiYbc4AYHUmEE9RquiGu100q+Ssm9yUF1tCM9pBSUY1GIqfli0iAVBkmgYZ64XCqKxTVadi+21OGQqDfmTznNJA9U34pYcc0MUv5TVW1SmUxv+Dn4y/8SDlvoDyzPyqN3eQlB4D0uK9Ton
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6967.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?L1ZwR1F3VGhiV2paeTNsc0hFdWwrZGJWTXRJa20xTXFnc29LcDEzam55Vi9V?=
 =?utf-8?B?U2VQN2ljcEZlTjlPVDZZTEJmQXZyZklIeURUWVdES0FWMGh0QTlCcDQ3S09t?=
 =?utf-8?B?MVVTeE41SkNxVDV2dVFUUVZwNDFQaVMrRTBIbkhlTHNsQXFTQTA1dXNlcXlF?=
 =?utf-8?B?VXh2RTEzRmRNZkNWYkJUOGVsV0kwbSt0N0VYRkc0T0trS1F3MXVBUVVyY3JJ?=
 =?utf-8?B?L0J4SGROZXFkakN6UFZhMkI0eml5SnE1ZkhnV1lFa1BCRTNFTlk4bEVxNXVi?=
 =?utf-8?B?VHNkT0YyQ1pNT3VuRDA5eXlnU01lQldtNlRONmhjMTMrVHFqRktSM05SRHdQ?=
 =?utf-8?B?T0IyRlZseU9SaFkxOFlpQnlUdy9QNk9lKzIxOHdUanVVTzFhd1Z6M05aMXlH?=
 =?utf-8?B?djZPeXJKR0N6VExWUW04RXVNMk1IYzZMTWhQREZpVHNoajlIWit4OHo4OStk?=
 =?utf-8?B?NGdNbWVPNGRZc0Fkb1JGSXM5Vm9Hb0Q5U3BnMGpPeFZMMEdHQkNIWWxCUVpJ?=
 =?utf-8?B?V2VSOW44ekdvQlVkOTBEdDZ1Z3JSNDBGNy83bkJ3blhaZnV1UnQzckNaUFU2?=
 =?utf-8?B?M085YjlyaElNNHJyK2FmeGd3eENBTjZieWV2ekV2TGZlRzdOWE1neFIwOXNI?=
 =?utf-8?B?c0szVGdUNzBRTzVLQjYwcVVPSjc3WUF5UXFKellrT21kbWNXTWJUdDBsQ1dY?=
 =?utf-8?B?bUZPaEVweHFjYWJ0WDhRc21hc1BkdnFSR1pJRXhxdno3VDZXakp1K0NRdmxO?=
 =?utf-8?B?cE9mS21JTkVxMzJieXFsbTBOUGpUNzM0ZXlEV0MxZi9MaENkT2lDNXVHbGtK?=
 =?utf-8?B?NlVsdUNjZjlMWTVDSVlZQUxZczYwZ3d6OVh6U2szeFF5b1gzMmlLNkY0a1A5?=
 =?utf-8?B?MWxoT3lOYjhqZ3M5dXpFQkdwU1RYN2U2cFQxbWh3M3VIN2NOdFVBLzJteDdM?=
 =?utf-8?B?ZjVpN0V6eURiUUZsaHFwTWlnRW1OQUYrQU41WWlEdk01dzFCYVRjbzc2djlY?=
 =?utf-8?B?bXlMdVF6Y09UY1VkOUxLWnJMdTdmdVFaalkrdW9RQm53d0x2V3NpTFRVVDN4?=
 =?utf-8?B?RDE4NGpDcDhzcTlUN1g2cVpYRFg3c1R0S0pYQk9hK0ZjK3FGZzdLbXRDdnFL?=
 =?utf-8?B?WmhBZkFta25nN254dzJhNUl4M1lyWUdSc0Z5Q3FHWFUzOEwyQzUzeDhiSStB?=
 =?utf-8?B?VFoxOXN3VzdNbWVUUU5qOUxqaTJ5eWp6NFlvNTEzZEN1amlPZktDMDUzVUpE?=
 =?utf-8?B?VlFuMFN6QkVYSkZHVG1UbnNvb1k3bHpXR3dxNHhzaCtKcU1hVWUwOTdKZ1dE?=
 =?utf-8?B?MGI1UlR5b2MwbXJ6bkorYkg2YzRiOGhRMTd5Smh5SFYwdUI2WHdUOWNuQ1Ex?=
 =?utf-8?B?VXo1eFBoRmIzM2J3NFFYL0ZoZ3FwQXhFWXlINk1sMHo4U3FTVzMralFTOGo2?=
 =?utf-8?B?UUk5ekN2M3ZlQmZ3WE9OZnVITFIrV0I0QnJYRWVra21BSjJPNTRLMHplZld4?=
 =?utf-8?B?RFZPN1hNRGFFYVdhS2lpUmtIcWVXdUVueGYyUHFxbGRjakRoSThCUTNzYjNa?=
 =?utf-8?B?VXdpQmp4YUwrL01IY1Y2dmtVOWtrV05FT2p5N1BwekJVemRndW5nSmowUXNI?=
 =?utf-8?B?Ni9keXNuRlpZZEJGaFZnUWNpTk04SzY1V1pVSWd6elpkOVU5VXdQNzE2bXBr?=
 =?utf-8?B?L3djOG1uaWRDUjVDVktFc2hiWERBVzVOV2M4ZldzQ0tOblVBR0pMOVJITC93?=
 =?utf-8?B?WjJVckFKZU1SWmxkaVZpbk5DdGk2UDQvenVaUEtuNE81TmV2VDd6d2czK1JC?=
 =?utf-8?B?V2Q2di9NSkthVTRCMXFxVHZleUduVEdnQzV0KzVyNkNzV0h4d3JwQWR1SFFx?=
 =?utf-8?B?Vk0rWkY0akZ0VXhUZnorem9HUktUN09GdkhEMUd1UmJjckxvSTF6d3BOakVi?=
 =?utf-8?B?dlROZW4vcnpDRll2ZkRKRTNsNU5BRkZDOWpvbjNnc1VUbzd0N25LSGkyekhK?=
 =?utf-8?B?YklFcENqSllIS2doUWxrbENWZnVScDBrT3ZaekZyMmZNanNKQXVIT1QwU2JH?=
 =?utf-8?B?UnVaMHI4eWJld2V3SlFuRDVRNExxZnJ1eGxLNEk5UmV0a2xsUEtxVVg1cHNV?=
 =?utf-8?B?MXdkSTNRbFlVZDlDRXZueGx2d1ozQTA3a1BGYzRnNFEzWXFtUU5OV2VDYi9O?=
 =?utf-8?B?RXBGT2dvRTRrdWRZTm1valVsYnBhUFpJQWlyQi9sdzU3MnM4TXlDeG52azM2?=
 =?utf-8?B?bHJ0YzNudTlnTEUyajJ3cTg3MDJmZkd0Zng4OFFSVmRvZUtDandod2VOWjg3?=
 =?utf-8?B?blRRU2tUNlVQd3pVNk8wZ0l3V0daSnREQVBDb2NQWUNLK1YveklLMjJMa0t1?=
 =?utf-8?Q?bT62GXwT0woWwEkc=3D?=
X-Exchange-RoutingPolicyChecked: 
 f2yEbe7seXSe2t5OCukDx6Uw9p9f1WEsWBBNr4EOeFuMBtdyHimUEf6Qv86O1h4KZqjPy3H9dbQqoxZ89utcw6M6D3/scBhREcN3Nd0DIZgUUrTLLR1JomGssto2iBornDGj5Vjfi9yRjY0rrc9SC231SxSK3lEnPmKY7iIR6hIIO582ZjMvNKn9fFirg43OX8bw6gPYQ4LR4ooYVoMEGjJO9CG3RfofiEF9RLydP770eyXAZ2PcWjjANljPOd72huoz+Y2zcLLn+jMu5lv7T9EbWSEhOR9+qyUYzJyTxRubR8Bqd4eFh1FD9K7ucfe8Bm6uO4a4dqel12Dg3xt7UA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 4aa4512d-ebe1-4f44-5767-08dec6003973
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6967.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 08:22:20.1504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 B+XAVPZ2Edzb1gu3iLxJt6RXKCTbV9P/UQdQ2uhnt9vTwkhuMl5/Swj9nxuozsOXZetZEjzSR0VszHszIkT1ZtFmeqy25fARlMzi8zDCi0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFCB5A2AEE2
X-OriginatorOrg: intel.com
Message-ID-Hash: YXDPQM7NUPLVCDYNU4AVDBVHIQQPKRYU
X-Message-ID-Hash: YXDPQM7NUPLVCDYNU4AVDBVHIQQPKRYU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YXDPQM7NUPLVCDYNU4AVDBVHIQQPKRYU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 6/8/2026 10:35 AM, Michael Zhang wrote:
> From: Zhang Yi <zhangyi@everest-semi.com>
> 
> v0:
>    - Modify volatile_register
>    - Add MCLK_MASK to resolve the issue related to mclk_src
>    - Modify configuration about clock
>    - Add private members about HPF at driver and devicetree
>    - Add INPUT MUX at route

Hi Michael,

The cover letter is supposed to provide a summary for the patchset and a 
goal behind it.  Bullet list that just repeats commits titles is _not_ a 
summary.  Next, there is no need to provide "changes made in v0" as 
there is no revision to match this one against - after all, it's the 
first revision.

For all the patches, except 1/7 - please update the commit message so 
that it answers _why_ the change it made.  Currently, you're just 
repeating the title.
Last but not least, the expected list is: linux-sound@vger.kernel.org, 
not alsa-devel@alsa-project.org.


> Zhang Yi (7):
>    ASoC: codecs: ES8389: Modify volatile_register
>    ASoC: codecs: ES8389: Fix the issue about mclk_src
>    ASoC: codecs: ES8389: Modify the clock table
>    ASoC: codecs: ES8389: Modify the initial configuration
>    ASoC: codecs: ES8389: Add private members related to HPF
>    ASoC: codecs: ES8389: Add INPUTL MUX and INPUTR MUX
>    ASoC: dt-bindings: ES8389: Add members about HPF
> 
>   .../bindings/sound/everest,es8389.yaml        |  18 +++
>   sound/soc/codecs/es8389.c                     | 130 +++++++++++++-----
>   sound/soc/codecs/es8389.h                     |   8 +-
>   3 files changed, 121 insertions(+), 35 deletions(-)
> 

