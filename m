Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF8FC88E77
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Sep 2026 19:07:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ADB41601F2;
	Tue, 15 Sep 2026 21:07:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ADB41601F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789499239;
	bh=tH59Zj0nWZBZYxVYllNvF9bOJxMOfKpH2kfls04WLZ8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=SitG2gbDOdRs/g6cLfMbZFQ5DAuoYHwnqBFuHn8BNXQOXU2F/05UKuXphsUl8C0TJ
	 PZj2MzlCuZK6WZAoaQz4HHC6wfA9GeIhfDi9+UdxSUzOfYUO18ZftNfCUJB8QU/HT1
	 JEWqMrTCJu0bB7zMUbgEe0d8YFVhl/7wyWoWl8a0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A16F3F80601; Tue, 15 Sep 2026 21:06:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 24F89F805FA;
	Tue, 15 Sep 2026 21:06:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 91714F80588; Tue, 15 Sep 2026 21:06:37 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=fail smtp.remote-ip=192.198.163.9
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=fail; t=1789499196;
	b=OO+7VVu27UtlQwqxGEa0JTrb80B0cuY3xXLKtoaWdmtHYbUWEvjY+ECnuq4J8q2mAnbO
	 surU69ZTZXch2RlroXrlQgH7pJz4VQfXpKsbBKiKCn5wHhSAiiriASq9uW245L8peTftJ
	 IWr+MrWgis7bLfOfW2lsBKFK/5qyPxR3k2AWk58P+T/FRvI6vI9zwbhh3VUCaQS+ztu7s
	 MNsaqPTNmcYcF/rh4gqDIf4wyKqLEjfbqqd8afiJ8h23mXMIdn+DjWsz2gY0gweHcPdt+
	 wJfNbusgD69F6f6skH8aiBd7uinkj1RB3daEnvY0CmBJ0tEUN36CY11xx80kotOXXsA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789499196;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version;
	bh=tH59Zj0nWZBZYxVYllNvF9bOJxMOfKpH2kfls04WLZ8=;
	b=CdGhHCjR/pDRV3MUI/Rsttf3ES5pmCxEi0RtpZOURLPgkEU1LDAV6vbo1LStppqgyf+5
	 OTBQ5DkA5ZUCqkCDXS+Bj7JV9H5NfPCj42EE7S7c7OSjf+CCXXt3tH6zW49RxcYZRKjvl
	 F5yW2BIAgbziZkSFRYWiXy9SZm87/JkzD7gnoWddI2DMyFKR0X6tdfknPXYGYBW1W+v5t
	 solid7u4DRxgQADHvTVV98lhuuuZnkuvj7DBu3r+spbUoyv6gXXZAx4zGFctQ/5FLnt1G
	 w5C4DJ2kQOVnX9uaLMdFwz7Sefrjig4pv9fozej2YC6Pf3e1vivTO9WshZQON5JR5eQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=A2O3stOh;
	arc=fail smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2A766F80217
	for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2026 21:06:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2A766F80217
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=A2O3stOh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789499196; x=1821035196;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tH59Zj0nWZBZYxVYllNvF9bOJxMOfKpH2kfls04WLZ8=;
  b=A2O3stOhUIqTYoiKXz3f2aTCeEgmDWHse93CT185DkRIh8Pre5PUTHn9
   ncrdKleuXEUb9Zwb0I8MUYDTfIHhAUOtzSjr2qfkrhd3qEqaFKhrnftfY
   Vdncfobqvy6fnAKTNgzftuSfVQP3q8jU5EoUeQMGzc03nplf53C+dD/oZ
   RXD2mha/LbK8MQ5SNdXFfZHERlNN+0xTdpDGR+nA/UIAMwOhb+sIVDENG
   i/KplYPSZRsHgytdHzHEE/IREGTOpJk0qxi3OhMnblSbQ++vl662xP2ud
   lZ2rLngleWOGet/Gd7RF8+Ns5VScKi1yX8WA1pw77vIr5S4uKvNqQKOJr
   w==;
X-CSE-ConnectionGUID: h+Y4JXdxSH62MMtVS8FyaA==
X-CSE-MsgGUID: inpnA9wzSoaGC+JkTT2YFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100538779"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400";
   d="scan'208";a="100538779"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 12:06:33 -0700
X-CSE-ConnectionGUID: Gv+gYyybRV+X47QPc6qIHQ==
X-CSE-MsgGUID: RwVnD/+FReWsqSfzbDaI+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400";
   d="scan'208";a="275061609"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 12:06:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 12:06:31 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 12:06:31 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.40) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 12:06:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQtuOhM5MBp6EVxv8njAUV56BDTimKcP+Zw+Mpe7KFSYAYIs8ZtCNKeeCqfqmMb/KuZ42P3A+l2gou9x8s6KaftKiVociZcpRnh34T5fn3FU46pD64WEhdwVObes7zTCXeTMEewXwke7OcOy0CKh3m9abUoYOOJRRswIx0IPDNCOI4+L3PC2PRSEH+JMla+AgQ6WjLTiMO36TjBXE6rq7FeeO0jAlpJQrt5Uw8wcapX8XMOlxPVs5QxlN4x7ZNHprDxsWDYYL9fmbIqt5lHQPDY4YQjNYgydnDrUUYfoB5Vj/wsN5f0aNyJki9PmLCXWa/4ZbNJvmiYc8eLuMYb8fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ALY1Soat1BRPzPxYzFRKCdlqfreHRP+vB3PQN6HHHU=;
 b=IdApXqAO9o6LAzW9nc2r2s2Ey7QV5wUT+sBkTiRqNGumgTuDQnfMHQBn7AwkVpjrelIqPKFzMatEwooyr8kwGdfsihXbDPwsU25IrO5QbJI8rzjJLO+LEgr3MEbcj4XMQ+syK35sS99AFWGqp3K6LmAFbP5ZKLRWPLb6v6GjXuXHGke5JucXDv55NlBXQAkgO7imbZ+aVdUrjuvfC/Vl944SxWhykI97qZ/ScP2HLGnBqflMQmbr3OnRcdBWYBPv6EEW41Go+FGRSRqqsogtEBJCh+PTa8BC2ld7PDNGMb3U8Sd+MYbayKtUIudzRf17FFo+HP3VciHbOT971ot1jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6006.namprd11.prod.outlook.com (2603:10b6:510:1e1::13)
 by IA0PR11MB7884.namprd11.prod.outlook.com (2603:10b6:208:3dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 19:06:25 +0000
Received: from PH7PR11MB6006.namprd11.prod.outlook.com
 ([fe80::4e2d:28f0:ede9:73bd]) by PH7PR11MB6006.namprd11.prod.outlook.com
 ([fe80::4e2d:28f0:ede9:73bd%6]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 19:06:25 +0000
Message-ID: <e1f78e4f-f9dd-4cc5-bacb-6b61294cebca@intel.com>
Date: Tue, 15 Sep 2026 21:06:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ASoC: tas2783-sdw: add firmware download status check
To: Baojun Xu <baojun.xu@ti.com>
CC: <tiwai@suse.de>, <andriy.shevchenko@linux.intel.com>,
	<13916275206@139.com>, <alsa-devel@alsa-project.org>, <shenghao-ding@ti.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <k-yi@ti.com>,
	<henry.lo@ti.com>, <robinchen@ti.com>, <niranjan.hy@ti.com>,
	<pin-hao.huang@hp.com>, <Syed.SabaKareem@amd.com>, Mark Brown
	<broonie@kernel.org>
References: <20260915035223.1518-1-baojun.xu@ti.com>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20260915035223.1518-1-baojun.xu@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX0P273CA0012.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:26::11) To PH7PR11MB6006.namprd11.prod.outlook.com
 (2603:10b6:510:1e1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6006:EE_|IA0PR11MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e1b1bb3-e6f5-401c-b8a0-08df135c7057
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|1800799024|23010399003|7416014|366016|376014|6133799003|22082099003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
 3HIKARc7ARX21P69mGDZ4gjrS4/Zhazaxu9RUAEWNxpxKz5T+ePGRrDySFctQrLJYu1LEyzbLP2yaWclzsn9KgaLqvOf63+mUnZ6O/yhKVoGfIeJw5/KwbzCOw1PvQ4i+UP4TXVH8226sT6xZLJ22m7yLNaxkr5wFjxsKSELaip664w+JDG0VH/igTpvaOn5lE7oYI6RDeOU8rEE2YO7jR+MyTZuID6TVe8cNN6/ZPt2+9ZmVnUg4fx3X/0uv1xEJu68756sXuIUHm1u5o0JA7n2LOVt+cjzCFZQd+xlHOZpgbsdjkM3AsStWXsRrUyLdtHPvvwL1tdgZLLxa9AkAM1xiCQ+AkH29qA6Dlw2wItvP1hC9bsGBAnjZuZMhzHVGnJHXKS9togsSIHxS9io/CjYz0nm+fpKaLLNt5yszi/EghmNA7CXV3kE983iCaAgy8T7z8Bo8BOusPO20H62Bkz4s2BEQ+K6XICqfeBhmyXHhCU5CL0+JcJi2VTasklUUpRyjqAq0LFWcB9+0AN9mLv1aD5AhhUF2U1z6HaKyYiW/54nS6/cdRzBeoFU3dpi4kG4kdP8kLMfpCuV6Z0TSoBZcGXVauOnmQ9Bu0CEWJuyMceyITXeETfZ7N3hyzX+RI7jL4B5dV+r22FNhFc1DBcOnDtmhIEkni1iO5ClQvs=
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6006.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(366016)(376014)(6133799003)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?Vi9zSVI0bGg3MUpmN1RaZE1VSHBaZVl5UlN2UTBkUTFReStWR0pYSzFiVFhS?=
 =?utf-8?B?OGRPZ0dYbm0xYU5SdmRXaXFvcmFKY3RCdm1JVndLdU1YSlIxc1Z5U0hvMEFT?=
 =?utf-8?B?a3dTN0V1eTFuUExPZTFjSVI0bjR5aGtMeWQ3T3VRaVBnNlZkV0dGbWNES3VW?=
 =?utf-8?B?a21WZ3FYdTVjYmk2c0tTb2UxaG1PcC9YVE5jSUhDdUNWbHUrajExQmY0V2NJ?=
 =?utf-8?B?WUcvQS9naG52b2xEdlljRUhRWERzbCt2SUttaEJqa1I4ZVdubU94QXR4VzBk?=
 =?utf-8?B?NTRPTE95MlRqMDBDc2xwWmc5NEJ2bXBqQ3RYNFZrcUJWV1pIYmNXOVhDRXRQ?=
 =?utf-8?B?L3c5ZjVwdFMyd3dZTDRDMkhkWWVBMFZkK1J0QTR5YkhTb3JkN25uMlJzYXBM?=
 =?utf-8?B?NmhDSWNVQVRNWmZuUnBHR3JQQks3aTFOZHVDUHptWlZzUml6Snd4bHFlT3pH?=
 =?utf-8?B?aERUU2pTVUdFVitoeGZVOUdZRnF6TDFJcDJMNVRKQzZjQU9KZU5vUjNlNTVX?=
 =?utf-8?B?Z0Z1aFIyMy80YzgrWXIrQjArdkR6UFlRdlJiejhQWVlxWm9JRzFSemxjcmNM?=
 =?utf-8?B?MDZVT1RsQ1IzR3lFV2kzNnByOS9JZmczOTByUGs2ZnlNYmFHMEZTQWEvRysx?=
 =?utf-8?B?cmE2dzgwL0I5dlZqNkVuZmdweVZIU1M5L2JvZVZXU2QrbnU2VzBaaThtOXBk?=
 =?utf-8?B?eHNjZ3V2TElPdTcvZkd4aUFWRVprSGM2aHBrR21vaDlQK0tIVTF3SUJFVlRX?=
 =?utf-8?B?TjhENDFuQVJwZmJqd3hhUDdkZElGRkxjS282THFPOGpjb2w1aStMU1UyeUZJ?=
 =?utf-8?B?d3ZGUG5HR3JQbWQxbXFaQ2V1MXlCZnJ6T1A2VmJqOTNBVzRYSWlTT3hNUkRJ?=
 =?utf-8?B?MFpDRFNWdTk2ODlrYzNxTm5CZSt3aUkzeWRtRjFLNlFsbjhEcGlISVUwd2dZ?=
 =?utf-8?B?aFRKd3JiYmZFRWpreU9ESVFzZGptam1VVWZudzJKRU1BZjNxZXpCSktQY2U4?=
 =?utf-8?B?NGNhT3l5U2lHTm8yMVNuZStIRzBlR0VpYStadmFlZ0xndHRSL1cvR3pjRFlB?=
 =?utf-8?B?TTE4OU5yWm5hWVVPbWwyejhyeXNNT3dWQVdxbzlub3dKd2RtbHJPRjFjczZL?=
 =?utf-8?B?RGtJazE5cVVzQ0RhcUVDTkNxQklRR25nVHdzRElPSG5nV0sxSk1XYnB1OXdO?=
 =?utf-8?B?dXlpbkJDN0kvdVdyS0h0eHVZTnhFcFMwNEIrL0dPV3hTMW9jQU1XanVqS1ov?=
 =?utf-8?B?SHlvV2tBaDZrK0VQbExKVmFIanpCUHNDMktSUUxETjlqQ1A1TU5yalFDTEVm?=
 =?utf-8?B?azhpdFNReHV3bHJjMTFkcDZTdzZ0WklGRCtKVEwzdWN0R0dCb29TSTZ4Qksr?=
 =?utf-8?B?T3BMZ2lEd1dUakpXZTY0YVZRbjFqd1ZOM1poSmJkZlJvL2g5M0VzRy9zUzc4?=
 =?utf-8?B?QlprV0pnR2hOL09pNXNZdXErK2lsUFY3ZkZRdDdFUEFBK0d4OEg3Unpib1JV?=
 =?utf-8?B?ZzYwc1hLZHE1WW5nNWs3SmNjWTRzZExJeXY5NjByRUE1UDFMekF2c1pQMGgr?=
 =?utf-8?B?N0kyaVpQMkpiWUpuOUEzOTVVbWFrTm9sOWVXa0pzSlhSb2s1R0lWMmJaMEJM?=
 =?utf-8?B?Kzgxd0hjVktXeHlRY2ZtdzN4bU1IT0JRU3Y2T09wUUtsWmd3VEN5aDlaSU0v?=
 =?utf-8?B?VXZaMStXVktvYzZId1R5bTAzeU1YbFp5TDhOY3J2Y2NHUTVYMWtiT2E4ZlRo?=
 =?utf-8?B?TS9zZjRsdWQrODNwWExaL2RpSXJscDFmZDdNWHFHbnZsVTZpZlRBNE04YzBI?=
 =?utf-8?B?bEQ4dXo1NC9FWm5nallQSnh6OVg0WmxsWWp0amdIOTB1cFlEa250OFFjN0cz?=
 =?utf-8?B?ZHlrdHZrYzRmQzB4cXpxelBJQkUrazVIUlFMeHBFa3IxWGQvYTNNRkk1ZjBm?=
 =?utf-8?B?NlQ3TldTSjVpeGZxSFZJSWtlS1dIckpZcFQ0QWg3MzF3bDhYODNOaGpJRXlu?=
 =?utf-8?B?RnhHOEtkN0JhM2h5c3VyVStxTUdkcjFnSXNvYys1MlB4MUs1SGhoYXJMaXdr?=
 =?utf-8?B?UTgzMVpob0JFZy90dk54Qk5hR3U0SUNPUFA5MmdCV3dOZ1NyWDRtQ2gxY0s2?=
 =?utf-8?B?aXJYR1YwZ2Zwdm01Z0VtdDIwblNEUjhEN3ZHdEt6T1NtcmlibmhBMmZOOWRh?=
 =?utf-8?B?WWZWazNPdUNrZHFja1FxbXNCNmpkSlZqVkpqUSt4ajczODNONzVaZXJNOEts?=
 =?utf-8?B?ZVZmb1BFNGt0UmZUcEIzUlVINDVrdFI2ZUhSZk5uY2luSC9WdmtBaUlRRUZi?=
 =?utf-8?B?Z01zcmt4bE1DalZFV1dNNWpjNi9zSG5DZ3Y1N3M0VFVLZEFHcm8wSEtpZU1p?=
 =?utf-8?Q?OW96b7fgGcmB3PHA=3D?=
X-Exchange-RoutingPolicyChecked: 
 h0h7I7IOxhnGfP/jG3iT054x8qUoZlMhUorHQ4SQlWGwZ4T37LmkgCVHeYBCCaIVJM02YguOCLKk3+0N86NOce5K3avjX3TDhAeW5w3BoehMlwTL1TOlklzCOy7F6jP4+0V/WbNqowAhSRtc3nxeFjaftfInY4KbsHChZWwf4XVwiiWts9tlDLs4QkOJlojb0Edb9445Md4VbSmdrTTIx4oYFQ21z6L2yUi0d5LE6qfcpociZHHQSdbt1YDbdBxCELAwQoCC6M5pHqaE2NoXedc6/SZlko16co2BC83tUDJz3phQhZtCNG2eS1BJkThLlXEA9sSebIgydMjghgYEMw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 3e1b1bb3-e6f5-401c-b8a0-08df135c7057
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6006.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 19:06:25.5828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 Suc9KclLCKOGZPuPJYUIOv8lxzixQ4ECisCocPSWnELoY89AEGNIKntJQty739DTMdjbKj4JG7abNyS/eM8g4t0Efkq286IC7CEEC+FV3AE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7884
X-OriginatorOrg: intel.com
Message-ID-Hash: B36Z3J6IPNW2VTP5UYHT3ARNQWAVQUTW
X-Message-ID-Hash: B36Z3J6IPNW2VTP5UYHT3ARNQWAVQUTW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/B36Z3J6IPNW2VTP5UYHT3ARNQWAVQUTW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 9/15/2026 5:52 AM, Baojun Xu wrote:
> Currently, the firmware download is unnecessarily triggered on every
> system resume from suspend, causing significant wake-up latency. However,
> this step is redundant if the AMP remains powered on.

Either drop 'unnecessarily' in the first sentence or shorten the second
sentence to 'The step is redundant (...)'.


> @@ -996,7 +997,7 @@ static s32 tas_sdw_hw_params(struct snd_pcm_substream *substream,
>  							TAS2783_SDCA_POW_STATE_ON);
>  			if (!ret)
>  				break;
> -			usleep_range(2000, 2200);
> +			fsleep(2200);

Is this a crucial part of the patch? Looks out of scope and if so,
please move it to a separate patch.

>  		} while (retry--);
>  	}

> @@ -1252,25 +1253,29 @@ static s32 tas_fw_load(struct tas2783_prv *tas_dev, struct sdw_slave *slave)
>  static s32 tas_io_init(struct device *dev, struct sdw_slave *slave)
>  {
>  	struct tas2783_prv *tas_dev = dev_get_drvdata(dev);
> +	unsigned int val;
>  	s32 ret;
>  
>  	if (tas_dev->hw_init)
>  		return 0;
>  
> -	tas_dev->fw_dl_success = false;
> +	regmap_read(tas_dev->regmap, TASDEV_REG_SDW(0, 0, 7), &val);
> +	/* Check if the AMP is in reset status. */

Please add a newline between regmap_read() and the comment.

> +	if (val == 0x20) {
> +		tas_dev->fw_dl_success = false;
>  
