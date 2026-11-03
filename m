Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B53606A324
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2026 08:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=X7jzRZbf;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=V/aWGSJJ
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2C75260223;
	Tue,  3 Nov 2026 09:12:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2C75260223
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793693564;
	bh=jsg8RtyhOkYqBBv2JrE8oANsp42zHAyAFV0WlQETECk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=X7jzRZbfbtPg58/TEJaAfV2h+L+Qb9wTXdHSUPy8lFR91xpjegV3PY8u60timXs3Y
	 Z5bZxaZsq/4aMdXeqoGCUkq5piCkc6xA+CGZJfA/jbb72S90W9h7LKd+vyfHOhOnQ+
	 Jvcr5HOfNSIXJVHeRCDpduDswu965KCVd5m5Cdxs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 68D5CF80604; Tue,  3 Nov 2026 09:12:06 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A81BDF805F6;
	Tue,  3 Nov 2026 09:12:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D935FF804CF; Tue,  3 Nov 2026 09:11:59 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.11
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1793693515;
	b=f23+PxtxBTScp+OWOASWQlh080tMoY44tbO+WmePBEOsioGiBVBhby5yFO9ZMafsDkHp
	 wmTAStok6bJS5ePT62nSTCsAX51SmNq0L+xYEcS0rSxR7SCkjLWZPrRPjM59PVmyZzMJA
	 U8W/U7eS0vfMpcoM9jD2cOlwKcqkaoR9XH6jFuhLHoPeFz0tbQ6hJ5CMNhuhWirhNiSVI
	 udrJ4lyTl4IOGyn7dzsVIbJxBHJuVDxzhOHRlGNROKL26cjD/1HUbMmYXhrUXzeBA+pN3
	 lfkMelDV5avt2ozs8+JXccILKn4RmoAtcA+yfTd5pBHYITvBe+yV9NwVoK3lmVqKkDQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793693515;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=jsg8RtyhOkYqBBv2JrE8oANsp42zHAyAFV0WlQETECk=;
	b=b45tmJ+QPIdMqJ2Mr81537PBdKcCHYtSAs2N08I5LDttCFUNcIQYmk2lgxg15MohKSvH
	 dMu+2sSgC6TwUQ1DRQPFEe6XKI95Y01wbYpntpzR74H44KujW4MfAbOS6zGKOSqTZqrd/
	 4kTobDfxh9xxv+SrJbFKOumce3JJKkkDlj6FmWzASV+wR9TQBZCXV4jIGPGKnICSkt88o
	 kLxbU1NnEO2C+OoXlaj93oo+dxqMH41zQQAcKl/4EAJsPsWx+7TBz9gTP5CwwdaRX8w9N
	 2BkENz6wZ1THOlU7RAvsiXdyXYxhYz8zywvwbxzzQXyackiUySWotXT9SrLHnKI64Iw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="V/aWGSJJ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 037D3F800EE
	for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2026 09:11:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 037D3F800EE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=V/aWGSJJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793693516; x=1825229516;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jsg8RtyhOkYqBBv2JrE8oANsp42zHAyAFV0WlQETECk=;
  b=V/aWGSJJTuHiB7PpLIUHXFs4idXf3nAE2ogTs50TBOMVbC/6BV+SZ37X
   KwGtL29O0xnD1AR9fNW27ZiIS7dvb1TUBr1sz3OjE21DQGExCOfmGLPJa
   hfDObqtbSakxheFQnop9DOdhZ4FF4zj8MMyLR/5xXUZRjgpGcg/55gRpZ
   gkttQcQAT8H1hKYcDmJJD7W7lZZvJeWJUjEKOd3A258ZzUqt78QZc4FaS
   9adMlD7GeA1TcrhRwkGg02BXtZk2J0dhS67ozNnxTNe9RexihTJR0Yci3
   /Fg6FDi4Jl+5fbWhmwtx5xIbYKHKqM9u1Ks60Mo4cqU6EHEEOSnwiC3Qy
   Q==;
X-CSE-ConnectionGUID: xSg0Wj/5TCKJIY5WiypZSQ==
X-CSE-MsgGUID: oHqV20/8SiGxdcsXIVGhSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2287617"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400";
   d="scan'208";a="2287617"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 00:11:51 -0800
X-CSE-ConnectionGUID: NMRDiwsaRIGrzZ/JQkyoXw==
X-CSE-MsgGUID: +Mrr6N6qTx6yij5eu/6XIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400";
   d="scan'208";a="6698338"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 00:11:50 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 00:11:49 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 00:11:49 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.25) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 00:11:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=twGfoWtVo7gA0B+6RaPejnzsWGLkieu8lZjJOHvZ8Qh2CRXp/RZm7HnxH7YiRrvmqy3CsCFzFH0JnRqaBKGcs1kn0IL5rS8PtY22UtKmkopTMmHT5DPnTHcE1ngH/fMMjn0Znn1XAGjdKnLt1/ql9xXzYSiUmk7mXfkMTSFl16/QmtIGj8rnk2PUiNfBxgVGwBZaxFyPMp0qhxYr5pAza8a1UreulJKKVJIWG1kQvgzCfbwgyse7OQfAO3nx62D3edLIKVK2y5Gvfr7sXjLKfwG6xMpelBXaYtQE+witPGTU8v1crXWFbsBhJe9+2Ucwob7IOiBa4kGhieC7EY4AXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXipsGL8yO48B+Y8d3bLoOIxviCOiDSpHwVnBae1P/U=;
 b=Y05YYsD6EwjqSpwbOBoaMAcomADA1I89L5yPQ66Fe8TjqaSKglwMqpizEwRM798WjQAzO7y4uz6ciR8NEhLRqh3R5cbJJrPJGJ4Irg2i2SoVpMon4h5iGRc/BpZz7i895GwnoiOVGZxwTF5RkSEHUJovbchYBmSEIEva+g8crOd497aoi6L+CLz7+GSgl6Fh3MccppT07i5hPoBB2TKji5Fj/Rr8DAjra52prIigv07KMxJTdYdmVb0U4Xy4HFVjpLcAdq/hvsGT1G3dRE0HQqSCeYNUzk+8Y3ba2y6+HlbestTUc2R3dZfTZwTl0tMV5aAu6LjP97GhVph7kKeChg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB8424.namprd11.prod.outlook.com (2603:10b6:a03:53e::10)
 by DS0PR11MB7831.namprd11.prod.outlook.com (2603:10b6:8:de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 08:11:41 +0000
Received: from SJ2PR11MB8424.namprd11.prod.outlook.com
 ([fe80::3df:33f9:59a1:da76]) by SJ2PR11MB8424.namprd11.prod.outlook.com
 ([fe80::3df:33f9:59a1:da76%3]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 08:11:41 +0000
From: "Liao, Bard" <bard.liao@intel.com>
To: Qianghua Wang <qianghua.wang@senarytech.com>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
CC: "Rojewski, Cezary" <cezary.rojewski@intel.com>, Liam Girdwood
	<liam.r.girdwood@linux.intel.com>, Peter Ujfalusi
	<peter.ujfalusi@linux.intel.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.dev>, Mark Brown <broonie@kernel.org>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: RE: [PATCH] ASoC: Intel: soc-acpi: use dummy topology for SN624x
Thread-Topic: [PATCH] ASoC: Intel: soc-acpi: use dummy topology for SN624x
Thread-Index: AQHda15olA6Y9v8gbEOzuPj7PLgGArcb/lqg
Date: Tue, 3 Nov 2026 08:11:41 +0000
Message-ID: 
 <SJ2PR11MB842441302AFA99E9FE6C4979FF692@SJ2PR11MB8424.namprd11.prod.outlook.com>
References: <20261103064123.115057-1-qianghua.wang@senarytech.com>
In-Reply-To: <20261103064123.115057-1-qianghua.wang@senarytech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB8424:EE_|DS0PR11MB7831:EE_
x-ms-office365-filtering-correlation-id: 8b1dc6b3-64c6-4b56-f5e5-08df398217c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|38070700021|261021123027099003|261021121427099003|11063799006|56012099006|261028144727099003|261022075727099003|261026121527099003|261022105027099003|261026140227099003|261009223027099003|10067099003|18002099003|22082099003|261102123227099003;
x-microsoft-antispam-message-info: 
 j6PjBr2eW+ZnrzRuJqXJt8gpQlkQ6aCRAxMS6XBf0Rk5bbP7jJ/zvvM09tMnsHhxt0tZOZqGxPXM4eOF76GfJ/iiQRmeBSfx5zNOFMQ4PN8ripb59KhDCqm0gyrQlWfvN5vR0FkBEXz1YliICnUPBFoq9/ptOHmmKaECTRa+p1Ok03YABFEk0NBMOUggaCp6N4wpUnvgxmJQqEw9yGZ04fpKLwe+DJwV2BTMiGgYqJfAbIrHESdTC7pOllMw3YGh0ALsrG6zQVISs27Neb9ZDQev3hYBZB46ZAi30TVioz0a4kenNZZUlR4JPE0jHZjwL/9JeHIwwWDZTXXcAOSh8IxCwQO/X/fDKTUz2hP0CH9lskzwDl9EvAxNklzp32aajiWFQPTLj8gfsf339szt87yr6AC9qTyiMhYu7DcIRwEn695Z279TveNknGFbqDgFp25FQO5xNCTNedr3W9tspgfi1MlLYljs4L5oV5wVTXipPJ4FMuf4iiPfDAZltAtei0wxIO49FVeI89L0xs7E6S3O4tLtLF6HbG228RIZacsyAm65G5KIRwFq229kRtBCVUZNdUEJX0p7Leiv6wMuQBmADrzt1Att+LAI9MqKJpqhksBXrKP4Z/iUrOuyz0G3JAZaK2u9kEZHYg2nEtR8EpLRwsSLgpRRbxZUm9buUcAwYuNksLQiExCyGNno21HdyI8sK5KSSRRDhV3vkuHSrAgmQNsV+MOTh2JIEHgPlJQ=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8424.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(261021123027099003)(261021121427099003)(11063799006)(56012099006)(261028144727099003)(261022075727099003)(261026121527099003)(261022105027099003)(261026140227099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(261102123227099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?HpQGRx9zXhAUmVDHR1UVhMiNrtH78ckFYDjhphxAn2C2lHT06wD0hICKQVSh?=
 =?us-ascii?Q?sD1gwCxdmLQMF28IUhWRw1KNpTpF1EnC5DFXAxKK6OpAwpZqVrBSpZzLMzt7?=
 =?us-ascii?Q?l96EdXaEewVHPM0eSSZ+DLFOpjEmTgZ79KMTJ8ZixE9xamhS8FNrNj6uZ80j?=
 =?us-ascii?Q?i1XFjihtyVjEvw9KQ8o8mLBWYk3SdC9oIGv2/L7n/XXd+EEB+KM3Hdo4Bmp9?=
 =?us-ascii?Q?eWoYWtSLuC1IPguEoYOewPFb3CIqbDvqnlPoPWVGqdiZ3hwJ99QzF2p1wMTM?=
 =?us-ascii?Q?le7B13qYaFg1j29iwy3Ge9mM/wM4uFE/w18BzzeQ0ulpDv3/y9Di4cb8pUt8?=
 =?us-ascii?Q?MUobvK1YzgCze6PslB9r6axWL639glUbdIsY1DTCZ8K8IZJuIlNYgG7tFGEB?=
 =?us-ascii?Q?Og8NascPqijqmTX/quNLT1lSbrgK6+l1EI4H/0mAq4Zv9g0zRGoM4twyF9/4?=
 =?us-ascii?Q?hFuIQS3XQCw0OtavHdtSRnxxbsioqW7DvjEfahZQV6lkem+xOmutr/7o6EDI?=
 =?us-ascii?Q?/a/h2ryiv4BZLa+mhsL5bOBoQhLC1bb0a7yHvDUKwzt3oOQYHYtfQ1pA+463?=
 =?us-ascii?Q?E0g3rq+AGLRYmPYDo6YP6jAttODUWKi0YJK2n9wj6boQrzD+W0HNRGj1P4DV?=
 =?us-ascii?Q?EHAmXgLrlcFbzj1vV+NI0NLNnvd0ojhzlntlO21Eht4IPNQs7+g2otFhQswM?=
 =?us-ascii?Q?n2wg0bSLYPka/5k6QIOK7j6tqeV9pfcLIDGDMwgAGbARMEJr/MBchWr2U+TW?=
 =?us-ascii?Q?EoXDSJAkgtLFYrAQx1s+idaE46gTVc5p+gXkTVZnuot1s0FzdNdGIH1ut/yl?=
 =?us-ascii?Q?CP3sRDnXgZugGQeKOgA5NFWHiQQczE8dyDshiEmt5w0HvE3RRFWvZBpEdAb/?=
 =?us-ascii?Q?hBYt2fCOK7i0FRq/vWCr49K33xIrkAFa6mwkenj9ZMHXGGkwflETzxjgCKw6?=
 =?us-ascii?Q?vfl5IXjG2UMs0Q9lKwjj2UjsHvXC2TjUybGj92CktXpIi9mK64LeJGr6fg1k?=
 =?us-ascii?Q?9LDpU/TnyHjxn3lcfvOURq27i7HoT5FrMsKQsGTRCPMJq+VMmhrvpzPRfWlp?=
 =?us-ascii?Q?XQ3OS66YnCB1m3ostGuCXjObR/vXH13ynn9cu8pWKyP78zrP0IlYRcK0jfZ2?=
 =?us-ascii?Q?eqfA1HDQEZFollCd3sUhxvu1cPjB+RJA9XQpSfX0bvX8YmGRHU78KEDkY5aw?=
 =?us-ascii?Q?j8xdvfFGnBbk/nK6NenrPZ+wuWmWHMcst8+2c9oyc0a8G3C5yVWL03YCZ0xN?=
 =?us-ascii?Q?cx1XmxguM4ZTFi6L6aafUyC075VYmbQIZh8VRD/2gndYk5JWxR/5aJgyjpDZ?=
 =?us-ascii?Q?/7HkIksIs28ckxe+D1Agr3ywQV0JpHNPK/VSPDn2ZJspU30Q/DgEvpgtskJd?=
 =?us-ascii?Q?XL/Lf+CEPo/Z/m3LjYf2L7VQEfO9gFRci22oJlj+dd4hwm5Cws9dh5fb9aV9?=
 =?us-ascii?Q?hJi/kejEworgW5tfrlgg10O5f+O4wSjv60PxvR4Bqea9j7Wdy8rsHDIScvGj?=
 =?us-ascii?Q?v2QG8rOg+f1lJDp+pu8fl+QwkU0KTz8OEcL2GMOSaDwmpnh9KNYB8vxF6okm?=
 =?us-ascii?Q?MxnHegWLhaaPZ/E1BbBbrjd89yt3a9+lNPUTW2mEbAVABiKPAUFSKyeNbrlG?=
 =?us-ascii?Q?s6AhtkN1HlX5phNxeQCH1a7cVs8sixIGLMrGpoTwEsVhaejfkwRXhNXWw/z2?=
 =?us-ascii?Q?Dnk4THPnHdz/hc4aAKNiKSw3fo0WerYd2gco2mIYpXkT5r3v?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
 iYPwebOsjQTYNcGFFSbR3Enxhb2ckaHDk6QEJ2XddRxcid9SnO1lXfOU23P0Z2hwFWoRGTZvjUsrQRiTbRxn87jfIt1MpXAFufs7kYGNYNkv6aX0WUb3YyJCOT4GxgHyXGJYjZAutnj7H2BQpjNFkj7x+y2fjnHoOPad3JtYJoHcxzZudHObjLySlAYjO4RRp5O8E0pllL1XHILlYTwWH8n1x2y84rSrk0vn2sVYqibwUMR8rMIdgFevE1uukCUkMp24Xc3mY4MTfXrIazVyJ67jwoKS5Y3OMv5YX0r8synUEEpT0A654fwUWkHQbQIIN3XOG6JAlAlRQwUhtw/+4A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 8b1dc6b3-64c6-4b56-f5e5-08df398217c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 08:11:41.7102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 6zvaf/jLx7u+PD4PGUS0o6ls+d9CAkKTniszIuUZF1xeVtG5Ud1uTopLdJs06Vl+gEvghl11b2mrhKbHDMKmzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7831
X-OriginatorOrg: intel.com
Message-ID-Hash: OJEDWOQMXJP76Y3HIJHFCBFNFD2O4CFL
X-Message-ID-Hash: OJEDWOQMXJP76Y3HIJHFCBFNFD2O4CFL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OJEDWOQMXJP76Y3HIJHFCBFNFD2O4CFL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>



> -----Original Message-----
> From: Qianghua Wang <qianghua.wang@senarytech.com>
> Sent: Tuesday, November 3, 2026 2:41 PM
> To: linux-sound@vger.kernel.org
> Cc: Rojewski, Cezary <cezary.rojewski@intel.com>; Liam Girdwood
> <liam.r.girdwood@linux.intel.com>; Peter Ujfalusi
> <peter.ujfalusi@linux.intel.com>; Bard Liao <yung-chuan.liao@linux.intel.=
com>;
> Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>; Mark Brown
> <broonie@kernel.org>; alsa-devel@alsa-project.org; Qianghua Wang
> <qianghua.wang@senarytech.com>
> Subject: [PATCH] ASoC: Intel: soc-acpi: use dummy topology for SN624x
>=20
> The SN624x SoundWire entries in the MTL, ARL, LNL and PTL match tables
> point at sof-<platform>-sn624x.tplg. Those monolithic topologies are not
> shipped in sof-bin, so the SOF probe fails with a missing topology on
> any system that does not carry the out-of-tree files.
>=20
> The SN624x jack, amp and mic DAIs map onto the generic SDCA function
> topologies (sof-sdca-jack, sof-sdca-1amp, sof-sdca-mic) and the HDMI
> fragments. Use sof-<platform>-dummy.tplg so the card is always built
> from function topologies and no monolithic topology is needed.
>=20
> Tested on a Wildcat Lake (PTL match table) laptop with SN6244, with
> sof-ptl-sn624x.tplg removed: the card probes with sof-sdca-jack-id0,
> sof-sdca-1amp-id2, sof-sdca-mic-id4 and sof-hdmi-pcm5-id5. Speaker,
> headset, DMIC and HDMI playback/capture work.
>=20
> Fixes: 32f9c551a91a ("ASoC: Intel: soc-acpi: add SN624x entries for
> ARL/LNL/MTL/PTL")
> Link: https://github.com/thesofproject/sof/issues/11167
> Link: https://github.com/thesofproject/linux/issues/6002
> Signed-off-by: Qianghua Wang <qianghua.wang@senarytech.com>

Thanks for the patch and it is the direction we are inclined towards.
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>

> ---
>  sound/soc/intel/common/soc-acpi-intel-arl-match.c | 4 ++--
>  sound/soc/intel/common/soc-acpi-intel-lnl-match.c | 4 ++--
>  sound/soc/intel/common/soc-acpi-intel-mtl-match.c | 4 ++--
>  sound/soc/intel/common/soc-acpi-intel-ptl-match.c | 6 +++---
>  4 files changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/sound/soc/intel/common/soc-acpi-intel-arl-match.c
> b/sound/soc/intel/common/soc-acpi-intel-arl-match.c
> index 310c4b77c..1d5f6677b 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-arl-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-arl-match.c
> @@ -769,14 +769,14 @@ struct snd_soc_acpi_mach
> snd_soc_acpi_intel_arl_sdw_machines[] =3D {
>  		.link_mask =3D BIT(0),
>  		.links =3D arl_link_sn6242,
>  		.drv_name =3D "sof_sdw",
> -		.sof_tplg_filename =3D "sof-arl-sn624x.tplg",
> +		.sof_tplg_filename =3D "sof-arl-dummy.tplg",
>  		.get_function_tplg_files =3D sof_sdw_get_tplg_files,
>  	},
>  	{
>  		.link_mask =3D BIT(0),
>  		.links =3D arl_link_sn6244,
>  		.drv_name =3D "sof_sdw",
> -		.sof_tplg_filename =3D "sof-arl-sn624x.tplg",
> +		.sof_tplg_filename =3D "sof-arl-dummy.tplg",
>  		.get_function_tplg_files =3D sof_sdw_get_tplg_files,
>  	},
>  	{},
> diff --git a/sound/soc/intel/common/soc-acpi-intel-lnl-match.c
> b/sound/soc/intel/common/soc-acpi-intel-lnl-match.c
> index cbf79eb2e..a9fef394f 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-lnl-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-lnl-match.c
> @@ -867,14 +867,14 @@ struct snd_soc_acpi_mach
> snd_soc_acpi_intel_lnl_sdw_machines[] =3D {
>  		.link_mask =3D BIT(0),
>  		.links =3D lnl_link_sn6242,
>  		.drv_name =3D "sof_sdw",
> -		.sof_tplg_filename =3D "sof-lnl-sn624x.tplg",
> +		.sof_tplg_filename =3D "sof-lnl-dummy.tplg",
>  		.get_function_tplg_files =3D sof_sdw_get_tplg_files,
>  	},
>  	{
>  		.link_mask =3D BIT(0),
>  		.links =3D lnl_link_sn6244,
>  		.drv_name =3D "sof_sdw",
> -		.sof_tplg_filename =3D "sof-lnl-sn624x.tplg",
> +		.sof_tplg_filename =3D "sof-lnl-dummy.tplg",
>  		.get_function_tplg_files =3D sof_sdw_get_tplg_files,
>  	},
>  	{},
> diff --git a/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
> b/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
> index e89c5cfd6..704b4e0d2 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
> @@ -1564,14 +1564,14 @@ struct snd_soc_acpi_mach
> snd_soc_acpi_intel_mtl_sdw_machines[] =3D {
>  		.link_mask =3D BIT(0),
>  		.links =3D mtl_link_sn6242,
>  		.drv_name =3D "sof_sdw",
> -		.sof_tplg_filename =3D "sof-mtl-sn624x.tplg",
> +		.sof_tplg_filename =3D "sof-mtl-dummy.tplg",
>  		.get_function_tplg_files =3D sof_sdw_get_tplg_files,
>  	},
>  	{
>  		.link_mask =3D BIT(0),
>  		.links =3D mtl_link_sn6244,
>  		.drv_name =3D "sof_sdw",
> -		.sof_tplg_filename =3D "sof-mtl-sn624x.tplg",
> +		.sof_tplg_filename =3D "sof-mtl-dummy.tplg",
>  		.get_function_tplg_files =3D sof_sdw_get_tplg_files,
>  	},
>  	{},
> diff --git a/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
> b/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
> index 0ce51c44b..a5896796a 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
> @@ -599,21 +599,21 @@ struct snd_soc_acpi_mach
> snd_soc_acpi_intel_ptl_sdw_machines[] =3D {
>  		.link_mask =3D BIT(3),
>  		.links =3D ptl_link_sn6242,
>  		.drv_name =3D "sof_sdw",
> -		.sof_tplg_filename =3D "sof-ptl-sn624x.tplg",
> +		.sof_tplg_filename =3D "sof-ptl-dummy.tplg",
>  		.get_function_tplg_files =3D sof_sdw_get_tplg_files,
>  	},
>  	{
>  		.link_mask =3D BIT(3),
>  		.links =3D ptl_link_sn6244,
>  		.drv_name =3D "sof_sdw",
> -		.sof_tplg_filename =3D "sof-ptl-sn624x.tplg",
> +		.sof_tplg_filename =3D "sof-ptl-dummy.tplg",
>  		.get_function_tplg_files =3D sof_sdw_get_tplg_files,
>  	},
>  	{
>  		.link_mask =3D BIT(3),
>  		.links =3D ptl_link_sn6247,
>  		.drv_name =3D "sof_sdw",
> -		.sof_tplg_filename =3D "sof-ptl-sn624x.tplg",
> +		.sof_tplg_filename =3D "sof-ptl-dummy.tplg",
>  		.get_function_tplg_files =3D sof_sdw_get_tplg_files,
>  	},
>  	{},
> --
> 2.53.0
>=20

