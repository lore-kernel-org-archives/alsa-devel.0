Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E67CE9A74E
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2026 09:38:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DBE1760199;
	Tue, 24 Mar 2026 10:38:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DBE1760199
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774345127;
	bh=QzG8cd2z7Sx8G8yHDfyAys1sJCVohYRQkfPgYdNmuAA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=dm4AcGXdNt5Qzc8zRsUJPsBScQMCmOA8A+j8H7V/lr3Mp/oxasqXeuBsPWBVuBtH6
	 LMAqIL7mCp4BAKy45HwF4ldgnckVD+VHv1aQIz6iMO2dwSPL/0+hUFvlG0amwtkFwW
	 No4zQXrY6WjfFP7ZAUq3YGvM2yHv6W3Wo4qIpgc8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B6CF2F805F7; Tue, 24 Mar 2026 10:38:11 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8DA66F805EF;
	Tue, 24 Mar 2026 10:38:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2BCCCF805BA; Tue, 24 Mar 2026 10:38:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0AE74F800E2
	for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2026 10:37:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0AE74F800E2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=DbrXFX+8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774345082; x=1805881082;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QzG8cd2z7Sx8G8yHDfyAys1sJCVohYRQkfPgYdNmuAA=;
  b=DbrXFX+8ma1QMlRomnSxEiM1UY3ikg97Wjsr4OkVnKSCDpLIUfmVsmGK
   uTiXaAIONS+Ng2rEbpFeI2m7TG5p+Ei+pIIGUoKeb80sHP4MoOP+svB/P
   Jc5j3p5h7Gp50KPQSANQrA3ksR4P/PovpUwlXFVeBKmWny2HT8J0u149/
   ztkDWJvmqc0RuREkez9CM61kER5vw0jjWTKnengBin3r6E0NfEI/NY9CT
   fUA250g8iiNBjqU8iecR8KqA6j0xvdk1XDIQEzB2t2NWok0uqrv06UBAu
   HDXX0wqoM4tTPrmXcOb0dYPc2fhbghmpbqD1169nKMUbjc9WA4EaTfROm
   Q==;
X-CSE-ConnectionGUID: 0OBBvv+aRPqjYxhUF0ddcQ==
X-CSE-MsgGUID: BRRTP1MsS6uLs1hxuaE9vA==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="85664772"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000";
   d="scan'208";a="85664772"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 02:37:56 -0700
X-CSE-ConnectionGUID: 1g/PIKJvRzONMqWlGJRD7A==
X-CSE-MsgGUID: 4CD9MfNWRuiXJ71G9YjDFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000";
   d="scan'208";a="262222515"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 02:37:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 02:37:54 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 02:37:54 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.11) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 02:37:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1r0HPAcTN/ZZHbnqGVhuznJwDJKZ/C8SCRI9xVQtsKvCTqPulr6cn5UeYJ9CEk1tVgOlj0+GySHBKPrWs6QVq3/1pc0SRZPiu3I2z9gjdxpYkJPUI5ZTf1p0reoRQyX+iRjytFO0ZZoyYbpladKeIfWWszIOWg4grLwLAGvOCKi2p0zozDUY7sqGUsZDy2I8POKfCKwn0PAluEe5vh3/z6MgIe1ZWEbCN5sCFgYsfa//5Rkyr3loS+y2IQumApmWRPpHsi/JUBTp+YYNOiny+Fn8SlsTEWBNYfGMrDQFZzZxXgb7vZk5GVkc2xglAnJGWGxvt9ZoRVWrTjFQs12ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCzFssUux/qzAPpk6tFU8/Sy3D/w2ZgaIlKBdFQ9jFo=;
 b=dLuGGyzOmlCqf2XmpBU1HI9pSKLBcdXFBiu67JbWhPPYEustCEQxXxNYFaKwe0li6u+Y7uV921+JndiQWlRwoDwpahtFw/3AHU2Y2cnKXUOYeMmcZh0iOpVJYZncqaxuwqtXGZGw+fcgj+1hBGjOcVf3u1TLMNdgHmCKlUHgvJfBv4Ev0hNCH8B4WBeHFOs9oKdr5l7n/lubHaFQwvDKvSE5v+gCXePYt+3bTaFFxUf+wzd9dkSX1IAuZFbiBDqjTbcPT76UT0Fvjr2b3mdU+pW2IEtH4rxQX+4jRP/lQlqNGbmCia5HFhvD9m89XJurC7ld5f/eA2a6uFwPu37GEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8283.namprd11.prod.outlook.com (2603:10b6:806:26c::16)
 by CH3PR11MB8240.namprd11.prod.outlook.com (2603:10b6:610:139::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 09:37:52 +0000
Received: from SN7PR11MB8283.namprd11.prod.outlook.com
 ([fe80::d18f:6b38:584a:214]) by SN7PR11MB8283.namprd11.prod.outlook.com
 ([fe80::d18f:6b38:584a:214%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 09:37:51 +0000
Message-ID: <40777346-28d4-456c-af4e-cb868d8b8ac5@intel.com>
Date: Tue, 24 Mar 2026 10:37:47 +0100
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
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: 
 <CAC5iJJZCHm8a_jP+7nQpp4aqn_EE7JmMdPJBbu83QSBjgqZ49g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0043.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::6) To SN7PR11MB8283.namprd11.prod.outlook.com
 (2603:10b6:806:26c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8283:EE_|CH3PR11MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: 346855bf-968f-4d1b-7742-08de898904b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
 cAqNO0OR7V+5RFFQK9sQ2MayK0yLjSCjF3cvaa9u2EeVrSNeHFuZSaxwo7Y9/80+v6iuX2jee/rH+sKgirFy29Up6KOjCfZ0pRb6eIZCZj2OiaqPwdqwR18ZMu3zeUkGjfHTtyOH6bVjroXHYb6vc8aFUbVTUtouZylEEX6q7XHnkUwUlrACj8ergD5f0YV+TRO02dvbEwBq2TQq/0N/LI4050B63SITo98c0uC+W3F0kh+6rdoQmHR74j2SwIdSW3YzvSj6+h5kh/vmHFlvsrDwmrrBeZh0n73kJ3J4Ru9AgPZHYixXlNsW/eZIvY/hDbpjAThulboRM7P/GUy9BnmJ+RxJjK/fOV6mnFcvMHJ/tm/vo7gWjnL+sl2bIafpyo0+Wour9M5vJ4RNrKXbk6oDBf6vl0Rur4MjM8//A6/u7HdUvfgsJbdWXjuTpLJ67xzv3k0yILbxEtsJs4lNuQumqAiBZkDKF8u7fKgtkjT6AzoY/QNC7Ckww29mWBJXNhbI17HJ5mxhLYWZZI7N30GlVNLctWS6aCRncxr/h49GNDcSeRorGWAZIDbb0O8+OKAE+T79+K4zmNhX2fDfoWlySaV61L4MJ4iMPODOO5OWsANjYwaDkCN1vyifL3JVdRcSwa9NqiHoIR9pUFe3lXGOCjqK8zm99tK3C9qxByJj1wOE4OU/2U7LIa4ron11lEjTljY8W6M6MsdhOfim0agH5hOfRt/uJPA1e1u9HkE=
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8283.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?T2l6bkpkRGZOR0FoNGZBRzlOWW5zMGlxYitsMzB5NGZPelMxWlRHUmdtbHVG?=
 =?utf-8?B?S2Ruem9Mc1V2NUljc0d1UldUV1Z6eDVPNkdHa0xZa2VPZXlIWTVubXNFU3Zz?=
 =?utf-8?B?TjhrRkhqNk1Va1lOMlNObWp6S1VpdUFVOUN5d2xwWGg4b24vbnptOVQ1YThj?=
 =?utf-8?B?OVArTStCM1pocm5RR2NLdDZrbmN0SXFEdW1hbmpyYlVuSVBHNHZDRnlRcmJJ?=
 =?utf-8?B?RlJDMlhwTzRBM3R0SzZzYTdiQ2dUOU43UjNGYWovYnlTdXFyTmVrTDVQNHV2?=
 =?utf-8?B?anVzeUUyT0lSU1FVUFpIcmRDTmZOQllXL3ZsVWJkTUZ6SG1NZncvblhYeWc0?=
 =?utf-8?B?bHV5cERET1g3d1FuRnpXSFFGNlo0WFVseWVpL2VvU21zemdJNzIxSEZUSURk?=
 =?utf-8?B?VThrc2tQaG1sSExDaXFUbnRtTVlDSkVHZFNTZHhqYlVJUnVLRFJJanZoZDZ0?=
 =?utf-8?B?NnREUUEyVUtDRDJmZHRndkdtZmhwVGhyQjZ1cXlTTk1yelBKOG1RdUQxWExR?=
 =?utf-8?B?dWx1aFJWSHJ0cGZ0MFhvOHdQMVhLbllXNlVNRzErQ3ZmVVFmZUxTcjB5SDFH?=
 =?utf-8?B?d29GZkNzRzVoWVpVQTdIVXpJVm8xWVJJTGM5WUNBUDdsd2lqZkdpcS9JWm5S?=
 =?utf-8?B?N2srNUVTTGM4TXdpODBKZnB2L0RvU1djMERHM04rUENRY2N6TDZGMHFCbk9S?=
 =?utf-8?B?ZUJCZjlnT2JUeFZ1TmZKYXluZjJxMW5UT0R2UTRTclZGR050ajdnRWRQeDdi?=
 =?utf-8?B?K3VYeEw3NmF2RUlydW9ZK1BPL25zeWF0QVRkNmk4aEZxM3lhdU56Q3dVdVBv?=
 =?utf-8?B?cFZlQkNHY0g0S1lMQ2Z3cWFRVnlsNFJTb0piVkNtcVR5dEdLWTR3aDRGeXUz?=
 =?utf-8?B?NFdOYUIyNjBvYjFVd0I0ZzZkVTN6SW9NRnE1WnNxQkdyMFhkczU5eHBUcjYv?=
 =?utf-8?B?LzJiNnU0RnhGdGNuRVg1dVZ5Y25SOTlTZ2NEbTFja01KLzRtZkFjaWZtUnFa?=
 =?utf-8?B?WnF2emo1SlhTQmk1MDlFRjFJcWoxajZCbnlndEZNTU9EWGxMMk9aU282bisx?=
 =?utf-8?B?Lzd5N2hQRENKS0xjVXRXSmpycFI3c3dkcUdubnBScXBJTHUwUmhyRGg3MDdy?=
 =?utf-8?B?TzlvMGtnMVlwa1FQWGxwRnd5ay95NkNWM3ZKMklWWG5TV2hncFk1YkFvU2RU?=
 =?utf-8?B?TlYrMHdna09vQjBBVkJQVTVnRk8xNCtEckhWMW5pMkpzampMVnFOelFFOStP?=
 =?utf-8?B?TWg5bVJyOERiZFhKQk54cW1ET3RabXBOZ3FHeVZzTjA4Vmd6TEtUam5DZ1Vq?=
 =?utf-8?B?Q0NWZUtFTmVEVG5VUHpDdm1OQ0F0QVpPcnpvWGR0VWtsTlNveEs2STB3VWx2?=
 =?utf-8?B?M2tIR29SRWR6TUxIZ3M2MFVYSGpIR1AvVXpsdTVla1lNNVM2UnNJbENHb0Nx?=
 =?utf-8?B?UFBCWGdPMjUwK1ExN3dTZ0pNQWJKSTVrVVE5UGtXa25aY2paUU5PQjEvTEc4?=
 =?utf-8?B?TmoxN1NWMkE1dW9uajFJWUFncDFxcXFXNHJsc0QxTjloaXk1SlRZU1BmSm9u?=
 =?utf-8?B?ZzNUQU1ZQzNKcTJCbEZEd3NsZFQrcWpHOHk5Nmp0ditvZGlTSXc2MVNQOWli?=
 =?utf-8?B?MGNmYUQ4U0lTdStEU1A4WTAxQ1AvZlV4ZmVtWk4xOEdYMHpiS0dYTmRzWklU?=
 =?utf-8?B?SDNPeC9aR1lSNEdZMWU5Tld0WGRGcVE4OXRtUHp5eWJxQzB4R3NGR0tTWUVx?=
 =?utf-8?B?MnZVNGlNY0daUGNBUkhQZ245ZTFrV3RhdGNGQzRpOUtFT0wzYUxxRklWZCtp?=
 =?utf-8?B?dUp4b0dNMml6dU5pSWNoY3I1MUxhazl0emVkTHdud052Rk02TTYyN3NJeE5a?=
 =?utf-8?B?OGQ2NnMvbk1xRVc5ckdyaFIwYjg4QjRUa2VkMWY0d1ZweEp4ektMTXZWMTQ4?=
 =?utf-8?B?UXhZRWNyRVZMOEwyKzBYSzh2d2lrN1kvMXJvcTFrbTlYVytrZ28zRlRpang4?=
 =?utf-8?B?bEw1WW5zcHBnU25ITklJKy9rMW5sZVZDVFFwQVQyMjQwc3FBY1l5cXhiWU1i?=
 =?utf-8?B?UnVuYkJZQUUzWWdPcEJRUTJmN3k2aVRNOGVPYUlTVm5zOFpxVVdpZW9IVGNZ?=
 =?utf-8?B?SmxiK2w3MkRDTU8wSkFuZjM3a3lFQU9XYVU5RU9YRnI5bDNvUDhYVnVyYktx?=
 =?utf-8?B?Y3R5N2FXOTdJVm1tVWptS2cvSkxMMWE1MFl4Qm1ENUJFN3hkczFORDIxYm94?=
 =?utf-8?B?QnlVcXdqeUg4dEMwVy9CamRJWDlBWi8yVjZFZERnYVd4QTZacUFzcEpXVS9O?=
 =?utf-8?B?UFVkOTVPYTI4dzRienlZSGh2dkV0QmFvZGltQUdJN0VtQXN3dHQ4WGgyZ2V1?=
 =?utf-8?Q?Yp0hvchy4EXg05vs=3D?=
X-Exchange-RoutingPolicyChecked: 
 ky3aK45n/48TQdvw+DpX2GMOLQXWr+0v7KzKEvLDvOczXR/2pFJgubZoML+zUL2OslWV8fBZOxt0jy82PSoK9dGt5QbiNQC3ZrdUDxpDEqcbABW716TShfkDJIT/vCbLwhw+p1ihAEYxEUty7I0ANqqLONVeZ7g45wDHH5XkGtBOuzyHHVtoPVNEAy+6Jp8mlBQ/nAOsiGVjD1nYuvkdpswdquIRhHJus8NOvjQuHxQrK1/spDKm2u6qwbTcpZoQUiPm0ggtGUvXwZGhFvsfC5FD7SAT4oDdBqE/RLVavy3QIKRcy4YgLefaHDflrUorhpvim8HIf1PuD35KoDobNQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 346855bf-968f-4d1b-7742-08de898904b0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8283.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 09:37:51.7879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 qEcIF31l7ioam3hUumS5ZdpJeLmkbbLi2+/57xwxgTDrcu0cGEWy2AUhZD95d/3NpVsl0yEiIExOd19nO/FsfpZwkjsenjlg6la2/o9C2d4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8240
X-OriginatorOrg: intel.com
Message-ID-Hash: FWPVVHU4BLR64EXF7BM2I67WHUKTFHPP
X-Message-ID-Hash: FWPVVHU4BLR64EXF7BM2I67WHUKTFHPP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FWPVVHU4BLR64EXF7BM2I67WHUKTFHPP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 2026-03-24 2:48 AM, Robert Viren wrote:
> Hardware: HP laptop (Bang & Olufsen), Conexant CX20724, Intel PCH HDA
> (0000:00:1f.3), 13th gen Intel, linux-firmware 20240318
> 
> Audio works fine with 6.8 kernel. 6.17 with the same modules loading
> and identical firmware my audio fails. Result is dummy output and an
> audible whine which drives me nuts. See logs below.

Hi Robert,

Typically Conexant codecs on Intel configurations aren't paired with 
interfaces which do require DSP-capable driver to function e.g.: DMIC. 
The default for configurations with no devices requiring DSP-capability 
is snd_hda_intel driver.

Looks to me like an unintended consequence of some recent 
HDA-driver-selection changes. Before we move to the code though, first 
let's check the value of 'dsp_driver' provided to the selector module.

	cat /sys/module/snd_intel_dspcfg/parameters/dsp_driver

Please paste the result here. Then, let's see what you have in ACPI:

	ls /sys/firmware/acpi/tables/ | grep NHLT
	/* if non-empty */
	sudo su
	cat /sys/firmware/acpi/tables/NHLT > ~/NHLT.dat

I'd suggest to open a bugzilla and attach the NHLT table there.


Kind regards,
Czarek
