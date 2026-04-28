Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A88EFF8870
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Apr 2026 12:55:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2C405601F8;
	Tue, 28 Apr 2026 14:55:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2C405601F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1777380917;
	bh=c8uaCJnrjxSPsn2T5u5pByrMIqaifjEEfO0xH9zMwXI=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Yntq6mOqQ2i3hW2ohdzGDvkCmHTOmaRi+BEYeYAX6GOBYwN5Jjvy0PkwstYyklizP
	 PxAvn5ia+eHU/LyWOOwsDq/M4dH5pP9kBZGONr8jSZGOVrcowKsT18Tt+VYk1h/wym
	 SltyT71MCWIA6vw80pc2aIP6pkLJKM5OIdpkqbdY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 212E0F805F2; Tue, 28 Apr 2026 14:54:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A6B37F805F3;
	Tue, 28 Apr 2026 14:54:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 98AEAF804CF; Tue, 28 Apr 2026 14:54:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C918AF80169
	for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2026 14:54:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C918AF80169
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ivzdMB2J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777380869; x=1808916869;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=c8uaCJnrjxSPsn2T5u5pByrMIqaifjEEfO0xH9zMwXI=;
  b=ivzdMB2JRWnPEMfIzk2va/IqCt/iSD+ieZ0Vkl8NV367QzgO1ts+ttBe
   SYJAO0P/crRHzvh2Leuef+Ns22a2fvDaBDCz8bqP/MSL3ZRMymN39On1y
   8kJDZ3eoqLxzMv5BIsGiTNSgljFF6rpLiVZ71ZGuqReDHTQ5YFBqqK8u+
   V3eCaLpsYOM/hkeUTpcVUqLI292OBII7P2jCz8ofSVdGlRQvUiNbG9IlH
   LqZi4KJEvH5sn/15Sz9uoq8DAmW4HQkCi/qee/v2h7lO8kbfoKxtMgNuQ
   JCzbd9xr95g8KcCE6l4bAXIc3BUr8I+/1RxHHzJ7KbL+Ek64Xtn4Uxi0z
   Q==;
X-CSE-ConnectionGUID: peNnGlqnRsmAIPGnFvSX3w==
X-CSE-MsgGUID: Lntg8VCDR0GJD3t6cHksEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78203186"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000";
   d="scan'208";a="78203186"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 05:54:23 -0700
X-CSE-ConnectionGUID: XTOqharPSJ6dENPbe57CJw==
X-CSE-MsgGUID: CKt+7LiBQvi/lpTHTWyD6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000";
   d="scan'208";a="234244368"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 05:54:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 05:54:22 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 05:54:22 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.51) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 05:54:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlqWW+P2IglqpSWFsgQ4by//OhLOcLd+cEQXMgU2MaRuPfhTkwIJ1UOG8dNX/iS8XO5rsuIMBHWETpTYGWv/lYgS7rI7MxqvzrFuHpM268nUQX4OERRfFyhZIJ0CcmV7NXGGHO9cYl6hKRmPcvBpsnHDVLpaSsR/wyktXNtrQ5luKrzrBIj0bUG4tfC+R0lMV6jrZW/kqgzMHPpYylc/oXldlc3Qte0NY9/1sbxwe6bf5Nx8vuV81yS49H99sCiOn6TXwLb/h2TaiOgyVdOkTYGEJVho5YygsCmS1kqoPI8lCww5K1YjC4yXfQeJ8uenu2GHyuvHXTDb92FxUrNj1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvrL17ZApOqnp19Ft0C5sQpLD9XMSv6yd+vYc0C4ipE=;
 b=S8ALbDgDDr1QpCLjD3iqbzpBOlGF/dF4axZYOBlWH3T6gDb8u1OzCjW/UTaTyDpHqNqdeEwzqrk1PIC0YX4xHnI4fmX8uzoTocZOwV9opG2hMrIOVjC1m+Wv2UesgiaPScMc/mcwC/GlKqn92MAvoZvghISrX7brhr8ymz4yk9lxS79yBFgfYSI4tCv/knVpl2Oo+Qw4AoRZ+qLOi2GbtGAkSnlaCze/PA0Q1Y696SYkKFxE4vQHvQhpNORrNiev6YnBDIAb7gSa3Nu7ez5pUpqYW6iCC6ch5k37qFxwkn6Nd0cCRCU2J6Z2uZzOvwGqo8dJ/cMadYLUYFqzIQj9JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5985.namprd11.prod.outlook.com (2603:10b6:208:370::8)
 by SA1PR11MB9828.namprd11.prod.outlook.com (2603:10b6:806:4d9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 12:54:18 +0000
Received: from MN0PR11MB5985.namprd11.prod.outlook.com
 ([fe80::5e66:8219:629b:df9e]) by MN0PR11MB5985.namprd11.prod.outlook.com
 ([fe80::5e66:8219:629b:df9e%6]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 12:54:18 +0000
From: "Mokashi, Sachin" <sachin.mokashi@intel.com>
To: "Rojewski, Cezary" <cezary.rojewski@intel.com>
CC: "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.com"
	<tiwai@suse.com>, "pierre-louis.bossart@linux.dev"
	<pierre-louis.bossart@linux.dev>, Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: Intel: cht_bsw_rt5672: Simplify probe() with local
 'dev' pointer
Thread-Topic: [PATCH] ASoC: Intel: cht_bsw_rt5672: Simplify probe() with local
 'dev' pointer
Thread-Index: AQHc1lU4u9cKLuCO9kSMZq/lUIPfKbXzBeuAgAFoTGA=
Date: Tue, 28 Apr 2026 12:54:18 +0000
Message-ID: 
 <MN0PR11MB598543C064766C8C390F97A785372@MN0PR11MB5985.namprd11.prod.outlook.com>
References: <20260427144619.1739971-1-sachin.mokashi@intel.com>
 <4d5f3abb-bab9-468e-b1be-74bfa728b255@intel.com>
In-Reply-To: <4d5f3abb-bab9-468e-b1be-74bfa728b255@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5985:EE_|SA1PR11MB9828:EE_
x-ms-office365-filtering-correlation-id: 5737e54b-3f53-40b0-51c1-08dea52542b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 
 g1rWmFzUzgT7ttDFT5YRV/34R5r5D8SzVVxGW0iB8wzlAVGPCrIS5GaWnTYpKBQ1EJgi0ipYc4v+lTGliQ+g6r0e3idSozL0tADYf31QMz9xe0AmmcUjm3JzYwd8BW9y9esjuxWQQ46PJMWVUO2c3RJLVx4T2Qaw2YpMy5juasdU8/nkH8ramW3ek+e1+QdMIItqR9Bz8IctG8RwqqvfuN2Y8x1ugnrXgSPEOvDrWHfFL+t18eF0VrLyI6KUJ7+uZwaBc7t40RLb7qmZ14rg9QRdrcfr7i375Fr45EvRP/uv6nPgY4kq+V/itEGLykR5Wyrrj3ibxNOwjqMIRV9xFOtiB44ZVXfOt1VeK7FsKK7uabanzSvw67GbakCxWvkfmpKVnjFlumx1wP1/JieuOuQXFisycT4A8CgGhTjZ7Y9CX9ExATQA69mNioEsY1toxQAI1LvaWchTLGXSMlba1cOpdbR6xo8U16rkh+e8NO/dFYWPpjIWjMNeT8pJIfFPuRsvYl5pkZps8qO1iJVDaR5jPYmyiAZ/t9sqd2E/T6/j4yroxTJBgTUxJzoagSd5tuVJ2BC6a0zZI2fZMeQzuhVDoTJ9p4y2nQPrFoRQfI/g0LOMvcZQuyVCnvMF/AZW86AurGcJGIdWWo3VMEc05dZFrOwMGZY4Oy8A0LrxJrh8Jzu9/E7i59f5KDp04/lML+GbBdyAFainRUrrWakd71r+dpJclxkPdW0hJPs0FtAoM/3B6JWQDvTHUSG/JxfNKvS4mk+RXs8WOfk4npPC0V37k2UzeZ8MtakUgrrhnHY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dXdsR1JqZjdWRnRlY3pyVlZvUVRYVXNmNE5ja0xENEs5SS9yZzllbGswVDZh?=
 =?utf-8?B?RmtUTE13WWlOM05xM1gvcXFUYnhlRU1MMitIWnpIWDEvYW12T3N3NEtwUHN1?=
 =?utf-8?B?MUR2VkZKYXBZeDFFZUNXeFhZZDFHcWZlQXJ5UllkTUNIbVg1eExiVVVPK0hV?=
 =?utf-8?B?UGlwR2poczBCYlZjaHcyN1Y3azFuUVlFb2diZkY1bVhEYXcxVmtrOWhOY3ZE?=
 =?utf-8?B?Sk55WjRqYUpUMEQ1UkI0YUlYN0RZWGVtUDUreFhNU1FLOUJKcUcyeXVwZ3U5?=
 =?utf-8?B?REljN2wrSjFISFZteUJ5QWV4ZitvbElaWTJNWHZlU2NPVDFkSXo4aVdoYS80?=
 =?utf-8?B?YzFuT1ZqTzgvd3MvSVI4cVhNY3hWK0tQd3RFcmtKZzc4d2l0WEdyZXU1ZnBD?=
 =?utf-8?B?eWZCMzJMNjYyQ1ljMlFQQU0ybXFaNFNZbDlORzFFNjJCRXRqaTN5SVB6aldI?=
 =?utf-8?B?MEc4YzFWS0U5MFRrRnVOWlpxdXZONVNsaXl2blV6Uzl3bjV6ckdwcWVKREx4?=
 =?utf-8?B?OGltUjdKQTVwZGNQbUJPUUxRSXF6cnMxVEJuNHVJVksvaFhHdkxWQWNUTnV2?=
 =?utf-8?B?bUR5amtsY1dhcy9VMm43dzhuc2huM2VCbTdZMkJTVGtSVkhKQmZNcXpFeWpT?=
 =?utf-8?B?N0ZGOUpLRHg3ajAxUTUrLzFnS0NJM3RsVmJpUll0WkFTTmJXV2pHMXUvTll6?=
 =?utf-8?B?TWh3OE1FZ3JFWUN6aDduUTkvZldNMG1pVHFLcW1lYzAxK3RneUU1TjloRUFN?=
 =?utf-8?B?U244K1pIUng5T3oyY0xiQ1B5UGtMTkltVGJ3V0dLVEh1S29HY2RUM3FlYy9m?=
 =?utf-8?B?RkF5WHFmWllKWnd0TW9lTEJPL0hpZ0h1Z21BM21tT0pKM0pvbVlIVEVjZ3Nr?=
 =?utf-8?B?UXkrRi8yOTdQMGJmTkVFbGxlYkxTMzF6YjRySEVTcy9xQWFLWHg2ZDNyY3Uw?=
 =?utf-8?B?cGtCS3ExZmtzSndyZDkwTDhZZmUvZlVmRHI5YXZUWU9CUU1hYkJBUUlBUmov?=
 =?utf-8?B?Y25NUEZoVC82V0pmVEZ2SW9VdHoxeS8vMXh0RGtiQjFOMytvd2VIQlZzTUYw?=
 =?utf-8?B?dmJVYWxTcThySTFTQXFvWDVnSlFxekxwR2xZU1gvU0JHUnRIZFVDVVVmK1BQ?=
 =?utf-8?B?ZGNuNkd2dmdUdVpnTHlaRDlTaDNaU2NlOXpqWExqcFovQUVjZ2VUc0RFQkVx?=
 =?utf-8?B?Y0MyQ3FvTDkyUlZuWkplTGx2bXNnSTJPUlZxTVduQitOVS96anFnSFNkSlhw?=
 =?utf-8?B?MUk0WUhxUmU1M2RJWmt6blBZZ25VbE50cHY2cFVLYk5CT0N3aFhGL1JSN1p2?=
 =?utf-8?B?dUJJWHkwWmNGTWNocGhXaXRHSWsvN3d5M1g0ckkvcjhDbnN0bXZpY0FWTzBM?=
 =?utf-8?B?a1FVS0ovcnpOY1pvdEpPSjJQS0ZYeVNZRzZxc09adkhYbjNNM2dldDcraEJt?=
 =?utf-8?B?bElGL2lIRzYreDJuZzVhTE43OGNNcExwRlZYTjFNQU9tZHlZSVFiajdxQk9C?=
 =?utf-8?B?bFJpZVJvV2F6R1Mxakp0ckF6aUJkUEIwOVZHTmJyR09LNFNBeFhJbllYcERq?=
 =?utf-8?B?NDhqVis1UTdqdmJmdVY4VERYYWo2MmtTL2xRUjVXZnBya3JKcTZyT0kwcWJF?=
 =?utf-8?B?WTFBaTNyUDJhT2diUU5CMWNXdXNrelZyb2wyNXJoMEVOU3RhYXBnL1VYN2l4?=
 =?utf-8?B?cDk0RkJKTFd0K2ZoVVpQRVkxSWt5cXBDYU1UVDVuTjRMUE0rSDRtaHVhemtp?=
 =?utf-8?B?cXhtdUNFYTR6MWhFREFnS3R3bGQ1NmovRzNGbVFxclQyZ3lmR2FwM0JTNFJi?=
 =?utf-8?B?U3d3a2VkTHdCcHFoV3BSWHBHRlZiWHZFMU4wRVpUMjQvZHZXODNSSUdtaWxF?=
 =?utf-8?B?ZnRVdFQ1TFlzOVNpNGttOWFMTVBET043UkJLa2c1UGVRUHFzU0huV1dmVERR?=
 =?utf-8?B?dVBiTW5UbzRHM2gvUW94LzZkQjF4WVpxaWk3MXR2a0wycXFtSGEwK2psK0lx?=
 =?utf-8?B?OXlJcDBmVUJMUmxzOURweUQyTkN2enFndUhPd29telIxTEVpcVhoendUckdT?=
 =?utf-8?B?bkFiZHF6RWd1ZTdLYUJhd1ByRjVVMnNYRzNoYUNMVUphcDZSVGpGRGIvRDRq?=
 =?utf-8?B?Vm5YTy9yS0ZQaTRUaGpLd05NeWV3Smo0bkNTbE9xVkwydm43RUNNMWE0d3Yx?=
 =?utf-8?B?V05ROW9xazQ1akpVeXk0cTdXS3FVKzBVUVcxNmlqd0VxelRsb2RLeWtmV0Nt?=
 =?utf-8?B?bmpzSURaQ3k5bk9CQ1F0Q2haZXp6eFFXL0xlNjVlR3RodEtmdm1NYUJLSUpN?=
 =?utf-8?B?bkIwcDJMV2hyTnpYdCtZMC9IN0h3ZWE2TnFiMEJuTmgwQXRoWUVaQT09?=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
 mfzw/TucgTICFiXaNCwNA3tkWmOXSr98BRrPeX7a37+URyChV9b9S1dcqLDjx8/e0VUgtgLJ4Dh+TuDnVgX8dts4oidgrDtRaUUB8XBN3hbjq2Q0ShHzsu/CNxNiKQwt/hbxv4l4BDGt7gFvobIm9O/rW3SHgnWajfpgSas1nrJauQMlEoIFpmlaAiX5NwRctDFrE+MSiKcBWFqAye+mnOHdYHw7ItdPzr9fZWHC/4p3IKPN57JWrgTdO7GynSjM5Vyzss7mqVEAlkkMZm07GFy5wV8SlnYKIzh+dcOWjtEA4024bxM8TfYvmhOtjPIWufp1s6g9zRzVRADFbS7I9A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 5737e54b-3f53-40b0-51c1-08dea52542b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 12:54:18.3501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 OrjvetBJGtBefOzpl34K6secpJfkaifcb8b6sZZxdfHe1YJFZn+dKjrgjFRzbM4pk6coX/pDoeYqKo2/QJIjyWby20P4BF0btStb7f8dZgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9828
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64
Message-ID-Hash: 3BGQYTI7SUKW5K363HYRKE2NEQ35EGUA
X-Message-ID-Hash: 3BGQYTI7SUKW5K363HYRKE2NEQ35EGUA
X-MailFrom: sachin.mokashi@intel.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3BGQYTI7SUKW5K363HYRKE2NEQ35EGUA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

DQo+T24gMjAyNi0wNC0yNyA0OjQ2IFBNLCBTYWNoaW4gTW9rYXNoaSB3cm90ZToNCj4+IEluIHNu
ZF9jaHRfbWNfcHJvYmUoKSwgJnBkZXYtPmRldiBpcyBkZXJlZmVyZW5jZWQgcmVwZWF0ZWRseQ0K
Pj4gdGhyb3VnaG91dCB0aGUgZnVuY3Rpb24uIEludHJvZHVjZSBhIGxvY2FsIGRldiBwb2ludGVy
IGVhcmx5IGluIHRoZQ0KPj4gZnVuY3Rpb24gYW5kIHVzZSBpdCBjb25zaXN0ZW50bHkgaW4gcGxh
Y2Ugb2YgYWxsIG9wZW4tY29kZWQgJnBkZXYtPmRldg0KPj4gcmVmZXJlbmNlcy4NCj4+DQo+PiBJ
dCByZWR1Y2VzIHJlcGV0aXRpb24sIGltcHJvdmVzIHJlYWRhYmlsaXR5LCBhbmQgYWxpZ25zIHdp
dGggdGhlDQo+PiBjb21tb24ga2VybmVsIGRyaXZlciBwYXR0ZXJuIG9mIGNhY2hpbmcgdGhlIGRl
dmljZSBwb2ludGVyIGF0IGZ1bmN0aW9uIGVudHJ5Lg0KPg0KPk9uZSBuaXQgYmVsb3cgYnV0IGl0
J3Mgbm90IGEgc3Ryb25nIGZvciB2Mi4gIEZvciB0aGUgcGF0Y2g6DQo+DQo+UmV2aWV3ZWQtYnk6
IENlemFyeSBSb2pld3NraSA8Y2V6YXJ5LnJvamV3c2tpQGludGVsLmNvbT4NCj4NCj4NCj4+IEBA
IC00NTAsMTIgKzQ1MCwxMyBAQCBzdGF0aWMgaW50IHNuZF9jaHRfbWNfcHJvYmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZQ0KPipwZGV2KQ0KPj4gICAJc3RydWN0IGNodF9tY19wcml2YXRlICpkcnY7
DQo+PiAgIAlzdHJ1Y3Qgc25kX3NvY19hY3BpX21hY2ggKm1hY2ggPSBwZGV2LT5kZXYucGxhdGZv
cm1fZGF0YTsNCj4+ICAgCWNvbnN0IGNoYXIgKnBsYXRmb3JtX25hbWU7DQo+PiArCXN0cnVjdCBk
ZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+DQo+V2VpcmQgbG9jYXRpb24gZm9yIHRoaXMgZGVj
bGFyYXRpb24uIFdoeSBpbiB0aGUgbWlkZGxlIG9mIG5vd2hlcmU/DQoNCkFncmVlZCwgd2lsbCB0
YWtlIGNhcmUgb2YgaXQgZnJvbSB0aGUgbmV4dCB0aW1lLg0KDQo+DQo+PiAgIAlzdHJ1Y3QgYWNw
aV9kZXZpY2UgKmFkZXY7DQo+PiAgIAlib29sIHNvZl9wYXJlbnQ7DQo+PiAgIAlpbnQgZGFpX2lu
ZGV4ID0gMDsNCj4+ICAgCWludCBpOw0KSW50ZWwgRGV1dHNjaGxhbmQgR21iSA0KUmVnaXN0ZXJl
ZCBBZGRyZXNzOiBEb3JuYWNoZXIgU3RyYXNzZSAxLCA4NTYyMiBGZWxka2lyY2hlbiwgR2VybWFu
eQ0KVGVsOiArNDkgODkgOTkxIDQzMCwgd3d3LmludGVsLmRlDQpNYW5hZ2luZyBEaXJlY3RvcnM6
IEhhcnJ5IERlbWFzLCBKZWZmcmV5IFNjaG5laWRlcm1hbiwgWWluIENob25nIFNvcnJlbGwNCkNo
YWlycGVyc29uIG9mIHRoZSBTdXBlcnZpc29yeSBCb2FyZDogTmljb2xlIExhdQ0KUmVnaXN0ZXJl
ZCBTZWF0OiBNdW5pY2gNCkNvbW1lcmNpYWwgUmVnaXN0ZXI6IEFtdHNnZXJpY2h0IE11ZW5jaGVu
IEhSQiAxODY5MjgK

