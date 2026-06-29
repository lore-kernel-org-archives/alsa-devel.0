Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1BBC43458
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jun 2026 02:04:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BD27E601F1;
	Mon, 29 Jun 2026 04:04:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BD27E601F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782698652;
	bh=v0Cshw0zLXD8n3LNxCihjOPFZrvY3zdcd1JO4MQ4lCQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=vmBIEcnr12fU9VjP8a0Fb163D7FaI/Oh669VF0d7rEKV0Hn3fPTzWXjlz11uMuDrL
	 APZVa6ySISteNy5RP3WPxiF51Isn0JRBpdcm68MrQQDnUFweZXhNs9wiPA/XduE4Zu
	 TNff2WutO2HIArF2UvGxJ+Z8deCQ6LmHGzUd3vho=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8229DF805F1; Mon, 29 Jun 2026 04:03:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DE0D4F80602;
	Mon, 29 Jun 2026 04:03:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2A6EFF80495; Mon, 29 Jun 2026 04:03:29 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.17
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1782698604;
	b=hROoJ/EMuU8P+vG362s5ROFUIf8OEUktbHm6dc+Qk1iXR0GulNf/dg4g9prFO459SIZm
	 r2ARO87Z/r2iMwTRAQNnaT7Bnw4e8NXqro/6GDeuGnSyl6IYnFLdaO13REf9MsGHdvx/k
	 q4fIDW66dEZRUzVcPXw+Ih1cQmfSKnjTekLvunochBa8gmaKyY38GRxhlM0V9HbkwbEUa
	 QIJcKgml9FH5eHu/C1DoNGpOnmj+tglE0hkV2AegzE6c06m9ijJPkdk9FEGnvVUbguUDX
	 btfd4vxXtu53RVMys+fB6rPEVI7+j2BTbvUFEtgeqAU4s0K9tgVBmEiDoken4RdZRuA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782698604;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=v0Cshw0zLXD8n3LNxCihjOPFZrvY3zdcd1JO4MQ4lCQ=;
	b=fSqlj5zllGSWIDDRGT8VvSx972eO9yuadoteCNPZf2uOgHOflZemVpm/FYIU0WRfoxRr
	 frIZRmMlagzZttb4cI0n78Hvsm65jq0a/6P50wAixS/BzKDdFyjfnMQVollhUJ7EGZL3y
	 rRkT3M0OuqNj+xSnjUhyTMINvgAGOV6HhqyPJuRhLVqLtMds+2x6LmyQANXopcjac4bKL
	 ulzZ6v3h2oeBMdGGJPfSDT4FGKR5uOS0haiIiD09PkhceAjoboP3c/yPShBuJPtWXUumf
	 yDWM/Aj7HMFvHPfiVq2qqAKv48uvMtHQGpZpscixVwR/E5JkVBz5OjsRqs1qVsdLbgg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=N9NHqElY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0024AF80124
	for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2026 04:03:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0024AF80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=N9NHqElY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782698604; x=1814234604;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v0Cshw0zLXD8n3LNxCihjOPFZrvY3zdcd1JO4MQ4lCQ=;
  b=N9NHqElYcsykywC+it7nn7lRZCcZaP7TaV2FHJEj1Kci3KwiTUMCVRJz
   /8X3uTAZlo1Sq5+nkFZs1JTayr+wm78z3DYONmg5DCuf0gcE44sI41eVv
   05DnROb7lMMhCixewZgJ/Dbx2UsK0W8C/ljl+htYxN8o0tyrdzKsifnjt
   bwtq2tJDB5qr9DVUMp2UHyWoChVGKi0RykvnLh+lBur5EIT1NxmFxkqnn
   JnHFxsxlz8Np3CnPAxsOxYnMrk7TMoI+V2T9J9iDepG9kHusSkS7O7bdp
   PjhKmF8WxhzhmuBfhTAESRX9srA4SEXCEoIRpr5vhuylyDoKqVybfT3Hv
   A==;
X-CSE-ConnectionGUID: uyewFEYvTwC21rm4BeUMcQ==
X-CSE-MsgGUID: nomHmv9QQBSZBiRRcnzTTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="83255272"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600";
   d="scan'208";a="83255272"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2026 19:03:19 -0700
X-CSE-ConnectionGUID: YRaaZkXaSAKMfYP8oZpqpA==
X-CSE-MsgGUID: z9varx3MTGq9EBaTd41u1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600";
   d="scan'208";a="250131168"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2026 19:03:19 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 28 Jun 2026 19:03:17 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 28 Jun 2026 19:03:17 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.6) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 28 Jun 2026 19:03:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVPbPPXIJkAz2h0MXKGWkCg9RgqoCVEyk7uicq102O69TtygrbD6eupFXKiR0d2r5i3TwytdDDepKUTDW9Gqx9ufPwGH5+6ite1DbBh8eCsS6VlKOjGDaLqShQ2+PuiR2vnqPj5qWhJK1UdXlnNMawGWdJ0cnLkygM7cFC5poEKCvDSy3MCQZJdvMzkBCnSLBx8sWiQlZBdApTEjoN2nyy64MS95i0XumuWPjhX3z8Ypgwewlyypz2vm8tKCObL/VBBox2BHVNlFyWF54HEbW2NLmIZhWCBCzhDopIsb1qWn/8hpUUpWg+x2+/wwVvr4PbTi4/vlvH/RUuuRWJ/vkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPODgtKMw27xXIBQYm/ebe1xgWlpU0He82Z27fLZxvo=;
 b=Bp1EtMOUb/2jC9gIRFYUj1JTZkiDgTDOy1IeXuLTRVpd2yKZDLAhC8h0Nk7COK8DJcY4jz5giPynvwkv/H+kSE4XTI2fIpVEg7WMBWdA1AOJAuV7M4Sz894X8AMMP3Ipbb8qnxBTRlB/7Z7yv4wNGqjC/GivVxog+cx0+3JSNZFLKnx/gSADS8uZ5529ShY2IbgPuFeavIXqLlsnri+yVcoDuq9JXtNiy33/LtIRMwb4irpKmhHptQxMzvqXlmVoqAeKGjy9/b950dPYNC2KkT+QIMm55tIGkJAAmOhvFlAJ18sHRQ77ZdBsVfMSZDuPF9dUQ8oy+FowoRDwsUb5OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB8424.namprd11.prod.outlook.com (2603:10b6:a03:53e::10)
 by SJ0PR11MB4975.namprd11.prod.outlook.com (2603:10b6:a03:2d0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 02:03:13 +0000
Received: from SJ2PR11MB8424.namprd11.prod.outlook.com
 ([fe80::3df:33f9:59a1:da76]) by SJ2PR11MB8424.namprd11.prod.outlook.com
 ([fe80::3df:33f9:59a1:da76%5]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 02:03:13 +0000
From: "Liao, Bard" <bard.liao@intel.com>
To: Baojun Xu <baojun.xu@ti.com>, "broonie@kernel.org" <broonie@kernel.org>
CC: "tiwai@suse.de" <tiwai@suse.de>, "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>, "13916275206@139.com"
	<13916275206@139.com>, "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>, "shenghao-ding@ti.com" <shenghao-ding@ti.com>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Yi, ChEN KAI"
	<k-yi@ti.com>, "Lo, Henry" <henry.lo@ti.com>, "robinchen@ti.com"
	<robinchen@ti.com>, "Holalu Yogendra, Niranjan" <niranjan.hy@ti.com>
Subject: RE: [PATCH v1] ASoC: Intel: soc-acpi-ptl-match: add tas2783 support
Thread-Topic: [PATCH v1] ASoC: Intel: soc-acpi-ptl-match: add tas2783 support
Thread-Index: AQHdBvmDkwU8ZSQrdEG0ClvNk7DnpLZUxYZw
Date: Mon, 29 Jun 2026 02:03:13 +0000
Message-ID: 
 <SJ2PR11MB84245DE06C6EE1A946D053A3FFE82@SJ2PR11MB8424.namprd11.prod.outlook.com>
References: <20260628122543.757-1-baojun.xu@ti.com>
In-Reply-To: <20260628122543.757-1-baojun.xu@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB8424:EE_|SJ0PR11MB4975:EE_
x-ms-office365-filtering-correlation-id: 31fdd1f2-ae87-468d-771a-08ded5829386
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|38070700021|22082099003|18002099003|11063799006|56012099006|6133799003;
x-microsoft-antispam-message-info: 
 y20zHACr+qoMEjLBupr6Z8QQwGCKF9XFeJa8HmyylSIKlChXwU+NjXCtbTON0gIbfxHhJHVMtzCFaH5e2VtOV66Ze8A4j4SUAn+HuBJ+qERy0K3FvUcEwcSKpoyWCdXq9sZfmxkRvh95XRB3obCvhGxVpiCLf0Xhfbi1NNTtxhb/WIpBZI/0yA9hgmPS9rp+H/or463HozFZ+elM1GwnQKivGVGAhfpTSra1mgPx49H7w9fHrl8wtX6siB9W3Ag8eRaBuhpPKClVa6S7eF+GpnsYvJ3Oe6ZUd2j4izFouZmHoB6Fp7qcw947RbhfG/7+3E/wdqE28LXqgpGyA4/R/DBpe6wSnrSyBJUq2cONWH4h+5RDmssrYVHKv5aJ4hYXD0KnTAii8fB+0jDq1NgZiiRGxv0Kr7+mEH7cOOlYaZDP3Yl4YxgJw2ZaQW9+32Q/4GXFcvlfDH+t7AbBnpM+PDK81XhQZ9UwHIW9REsE9HZ7WGxFIf2uKB7BdsbRbbYs9nFlZNIYYCFetXeeS2HKzm2TTRoeaFpUq9ABrs+knYcMbG4w83SKQvY79zgZ895ISA/23SR/Txucjl1/7QMvLd5I67x8y5ixnO7T4rNkz+7E98Z1byTb55LVxaaUmpzStfRyLif9TebFe4PKjrCbgtFc59Y1Nn/l2c65Z5KTHwLs6OxKMPJu9L56kLkQtRQYKtkw5SpdiMfR26c7othzFGc2kn0cdm2NSQl5jT4mqzs=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8424.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?+lFxhKrxNf9CYrM3rxU9yKaPkl+sDEL/L2rIIkZd8a5fUBjBGSognWN11uyy?=
 =?us-ascii?Q?lv8D1h0K/Erl0phcFLVGfWlhIWNE1zvGd3lF3/ebof1omItYr4nH4wkn2Ei3?=
 =?us-ascii?Q?AFCB/Yp4iaExixENpJy4MtYRzx7ZfolLmuK1ug3KYBVLz/wubWgHoAPGjcp6?=
 =?us-ascii?Q?pOInu9IDB7P6PS7x8lcPE4Liddl0SumEctt41sAjcP5HjVV396QsnVIYgTQh?=
 =?us-ascii?Q?vZL4QqE7n9/6rMqNZeVOGygytZFYJ+2nknSgpBsMoBuHOp3R3oTaWgEtgL7r?=
 =?us-ascii?Q?d2YIzv/CVyKBG9W3YztbEAamU+ARQftQxgqsxeRYrQ5ATzSHCoXAA1CmKYuT?=
 =?us-ascii?Q?3uivP1i27XQg/DjYPTEOZwXteAQ6I2K1hcRmNnWryhzi6GT7Us4iUe79sb/2?=
 =?us-ascii?Q?mwHCsFCKJ4dl4eXT1oeG6hlsmUo6wJ9WnV603sLgWmsZCFzD/0PAshR8GD69?=
 =?us-ascii?Q?CwTvs2SD4V7azNecms08O446ZexpIFNDaOGPPdGDGHdUE6z7fZr5lO0Jk4W2?=
 =?us-ascii?Q?K7tD4zMVyhhqUhYRwRPrb23ZpBghyjgk5p4X9a87Gzw0YKXdC3ocrRlYz6nD?=
 =?us-ascii?Q?uhD5UMf7DrJpylrj77kP+LvpnmRVg7vAQYWF/jx3BwVwN4efaXIsnyYyTOdw?=
 =?us-ascii?Q?PL5g9peQYdh7jwY+cfRZYsZS3d09Iv4/75aZjWXUGvsXh8Z18Ig0gohhw9AE?=
 =?us-ascii?Q?wWk48V1jehAz61zPTYfQ6ORB2RA0nl5kj/bfTNPsg6w5Eg8ZPieLUyhdDw67?=
 =?us-ascii?Q?WbkeXFLPZurTXdCI9Qz706Q7g7uIvI48uNklk/VpEDKg2NhFjjYYSiDkRX6l?=
 =?us-ascii?Q?4RHdhHDKdnziX60AaKtptv+tgxHuGEAvhu8VDLprDLiY+TU4bGI4tm/Q6Tu0?=
 =?us-ascii?Q?2usP8GGZ0OLq9NGi5ZAbQzf2yH+7YdSrT4KRBLwf0e0ePOscpdseFHrsqfzO?=
 =?us-ascii?Q?vFJ+GQVILNTrqGjh00SgVxlhI/2Wfxdv7t5jSN9RYdna/zPcNTSCQeLUm5h0?=
 =?us-ascii?Q?+oaLQ7MSjWfmMZmO21ScWREgy5cVKsMEE0FnEDJsU3IUZXB32BlG4fZj5PpF?=
 =?us-ascii?Q?TR/k/ko878uXXBO10uHmDhzYwyAKFdL/ctxpHK7sf3CnquV5AcywGtK3hdAU?=
 =?us-ascii?Q?FVszC3g1+4YEwtdixR/l8Y8NWv5aHEG4eIUQLCLKcLdjMzXQznsNhvmBSpyZ?=
 =?us-ascii?Q?nPq04p+A42uH4m/UsQhfzZFRhF0hdhRSu1TyIkMARZJKDh05gUbI5SRiVfPL?=
 =?us-ascii?Q?L4EJY5chO1S8RLQ9e43btvAZQ7Ctf/zdCLjqH+GEysw6DlWLUwUCUzDGgD1C?=
 =?us-ascii?Q?FbkoCQ4W3YGCAsA4B+V26sgt0xE4BtepJx/bJhJjkwWULaygEg+Fj1GdeWEe?=
 =?us-ascii?Q?HCJRJn48lBxjGwSVv9p4xYsFLEi0exuIUoPKC+uD01+04S0VViuFeyj0XCj+?=
 =?us-ascii?Q?EgPUJ4QusbJQFBfpTzKRE0jHAE111uxMldExcWENWo6jeBUWXlRkVAgAPfW5?=
 =?us-ascii?Q?PBrXNbKqvRr9VRsyyPxuCPFkti0pFty7ps5XjZBCMXQ5r2jX3HSIW2m+30Yx?=
 =?us-ascii?Q?d8MLB1SO1wRKL/FFANu5bkZlMYE3dVR5AUje/EqgtK3o5XzxEP3Im4M26aNm?=
 =?us-ascii?Q?0cvsvKCywelQSG3dTkiTV+Pz9YbtQuotGPtiDt1+WO87/9lK4FsZUpf48WQP?=
 =?us-ascii?Q?omoZJi94ULfQV5QsWVfK3x8ePDRNLYFEki3ld7I8NtMdoUEy+WZo+Qe5rzzD?=
 =?us-ascii?Q?7gRqLwNuLg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
 enPvA1XBQ1EgQWWeAgaLwpYkWVvHIs4e5FyPD6ZQJEN9CnTH41mAUwKipEcBc77LZj+EyaWwA7sSu6Dq10QDPeqte3wx1pVSYNQpCPvnLvl2dZ8Ne3xhbBpOUuex+Oxw85NpcUlWWyb0W0tCclpGjzlU1dvJU3+VUpdR5oCGU8Hrn7Y5385zRc0kh43+og3lVob8sWFojf7lJoW76984pF7tTr48lygn/st2YzY8qbpiD8nAZ9az4jD7dJliYSt6eEYkEBdYXM1fG8rqWjn48BSSXnW9EGjYbKkVY4Btq+mVLv37Y53sPWh25dAeH9lY7GQ6Fzb5x83TYtePec478A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 31fdd1f2-ae87-468d-771a-08ded5829386
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 02:03:13.0602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 46eTtyTbbb7ri9ytg8oqlzOE7NtRP8+AHzimpjHx3oV4DNT5JU1xfx2nIN+9iqb6HxzXpJ4H3ZPDJvmlKO3wpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4975
X-OriginatorOrg: intel.com
Message-ID-Hash: SOECMOFMQTLVKYN7HZ6ITNEQTJGZJUAB
X-Message-ID-Hash: SOECMOFMQTLVKYN7HZ6ITNEQTJGZJUAB
X-MailFrom: bard.liao@intel.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SOECMOFMQTLVKYN7HZ6ITNEQTJGZJUAB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



> -----Original Message-----
> From: Baojun Xu <baojun.xu@ti.com>
> Sent: Sunday, June 28, 2026 8:26 PM
> To: broonie@kernel.org
> Cc: tiwai@suse.de; andriy.shevchenko@linux.intel.com;
> 13916275206@139.com; alsa-devel@alsa-project.org; shenghao-
> ding@ti.com; baojun.xu@ti.com; linux-sound@vger.kernel.org; linux-
> kernel@vger.kernel.org; Yi, ChEN KAI <k-yi@ti.com>; Lo, Henry
> <henry.lo@ti.com>; robinchen@ti.com; Holalu Yogendra, Niranjan
> <niranjan.hy@ti.com>
> Subject: [PATCH v1] ASoC: Intel: soc-acpi-ptl-match: add tas2783 support
>=20
> Added tas2783 support in some projects.
>=20
> Signed-off-by: Baojun Xu <baojun.xu@ti.com>
> ---
>  sound/soc/amd/acp/amd-acp70-acpi-match.c      | 64 ++++++++++++++++

"Intel" is added to the title, but the commit changes the AMD file, too

>  .../intel/common/soc-acpi-intel-ptl-match.c   | 74 +++++++++++++++++++
>  2 files changed, 138 insertions(+)
>=20
> diff --git a/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
> b/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
> index f7694b2a2b02..6b27b09d9f98 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
>  static const struct snd_soc_acpi_link_adr ptl_cs42l43_agg_l3_cs35l56_l2[=
] =3D {
>  	{
>  		.mask =3D BIT(3),
> @@ -464,6 +526,18 @@ struct snd_soc_acpi_mach
> snd_soc_acpi_intel_ptl_sdw_machines[] =3D {
>  		.drv_name =3D "sof_sdw",
>  		.sof_tplg_filename =3D "sof-ptl-rt722.tplg", /* Reuse the existing
> tplg file */
>  	},
> +	{
> +		.link_mask =3D BIT(1) | BIT(2),
> +		.links =3D tas2783_link0,
> +		.drv_name =3D "sof_sdw",
> +		.sof_tplg_filename =3D "sof-ptl-tas2783-2ch.tplg",
> +	},
> +	{
> +		.link_mask =3D BIT(2),
> +		.links =3D tas2783_link1,
> +		.drv_name =3D "sof_sdw",
> +		.sof_tplg_filename =3D "sof-ptl-tas2783-2ch.tplg",
> +	},

Is there any particular reason that you need to add the mach table for
the audio configurations? For Intel PTL+ platforms, the SOF driver will
generate the acpi mach table based on the reported acpi table and use
function topology. That means we don't need to create new acpi mach
table and topologies for new audio configurations.

>  	{
>  		.link_mask =3D BIT(1) | BIT(2) | BIT(3),
>  		.links =3D ptl_sdw_rt713_vb_l2_rt1320_l13,
> --
> 2.25.1
>=20

