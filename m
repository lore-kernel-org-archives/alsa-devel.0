Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B360C5B56A
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Aug 2026 09:25:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3EDFE60218;
	Wed, 12 Aug 2026 11:25:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3EDFE60218
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786526731;
	bh=teloP6bguwoj3utoFrHu7L2lzLzhBPBHMVL4gj6sux4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=b5LlaqTAv4fty+ezo1kdIskjLjPwwaRQFZpVJEuIoCddJlu4zYuX7/l33SrMUEDec
	 b0viSNBQt2vSPtQuIBmrYJNZIdGheQaF891RhBP+pzwB1rR9PNUKrlzfvgPdboJSw9
	 GZkxTdBWkleoURpQKoCvZttfVMdofpa+omUXFVvA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BCD82F805FC; Wed, 12 Aug 2026 11:24:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3FE3EF80641;
	Wed, 12 Aug 2026 11:24:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 70836F80571; Sat,  8 Aug 2026 19:29:13 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.84
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1786210152;
	b=q4tQnomHg6JCtti5WVWf/8Wr/SwdANXtjwPiBQ9udIdBTsWReFtkAjedLDa/Bpr0UIlm
	 BEfk6OCJMjuJXVhQ8Rd3xg+QdSQWi92BpIO9ThYlqs3SpweGVdM6RUplIcXMVfNAD7Wgj
	 0+qA42I6yx7lRPVMId2JhwUc5TW4/DpzvWjF1veGW2KnH4pbhYxkPdggBpV0bcWoN8AW1
	 6p+d7GyXfHwXmRiAWcKKsNwmn8edfMF6R7c/lK2MIPEensRJoaMnezLgx9yHp+ArcsM/M
	 P973CcOWeK7CfB/mZHQe05XIVOyCmWuivtkqXL/kRqsjhdqPsD1hUB1BdkbRm0f1oVw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786210152;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=teloP6bguwoj3utoFrHu7L2lzLzhBPBHMVL4gj6sux4=;
	b=F2RxnFMM5mgg2yVYov92dZ01HQh7TEUp4ghcqH2BeGkO3N4YsQL2OHt5UUeLwgJ+QTeX
	 t/UV8R17SE7wPLW+7DLXcOSi65ntHn4M3hkIG9McOOag+2htOtBHJvdAXMD1dRqTpW6Uo
	 vsDNaiswJ65wo9CPx1jgr9TVNPXj2dY012t/FCNwu9FX/meSPaVC8TfePUaq/DgrIDZKO
	 eQCm4DpNji4jiEeLPZOrsilBMzU/usnMiXIoOiUE7HIEiHBC41W5isrLBc5YspofPfbPz
	 RFEjbPHqtVEyPAFvkd+Vl/w9iMI3TwxYyUHql3IXwGe/oJoRmD9ot4UhW1wTXmJQRRQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=macalinao.org header.i=@macalinao.org header.a=rsa-sha256
 header.s=selector1 header.b=aAZDxtfJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.84
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11023084.outbound.protection.outlook.com
 [40.107.44.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9F581F8025A
	for <alsa-devel@alsa-project.org>; Sat,  8 Aug 2026 19:29:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F581F8025A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=macalinao.org header.i=@macalinao.org
 header.a=rsa-sha256 header.s=selector1 header.b=aAZDxtfJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLdw7N1EPksmumGKdeyhLMbazj4H0nGe34/r0PObjPYcSvQrr/rOxY83qtyG6o91gpVY8LEVm9p5Ar/Jtmvz+kCzoVuiooPc3Uw8ugyAItrh8BFSu/2d7UlhdOd1q9O/XEN97/Dh7G40Sp4J3KUe2H2mU/WGA5K8uEKR6nKsRgQLVJAqshNpDwot3hzoGRUGzmEm6B3hN+wxWUW0LtPU3dotnTCMCxbG7bUy3YE2/rqHjU1DHs0TeEkw3ihwjrdwMKWac2tx6QSqj5MVMhqygJAdqk2fxSZeKTBGBd07XV1pI4nWIC5jvml3aOMBUCB6oApnYVviBnITqqLBeUBaOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPqfpUVxzYAAM1+nCTRZup9tXxxBkwXIwnzLkHYk7Yw=;
 b=E8sAAH6GLt25bKSdPHs+PkOH6rDjzQtiotvH8NR+KjzzhPkprx3a2BoCKf6MY3OE09Q1pQpHzBzfe71wTbcb8mea+b57oYLZCprTcqE+jV8r0MzBCgVAdvLTP0wFqoEFyxUlOtbMGLjgP7YVhUBF0KxteBkDmGbQaYYKMLKpo+ee/I1TboVp6osuypjFzq3AAOoEipJ3BuxKY+LmcBlmtXRgGr/OEbKZePDFgXjoRv7he7b5zC0PcnzDrkq3a6SswHdpnNAVTl/yH/xi7VO2uxRcPaKbOIXMITbDgETQnv26JK6uhYQ4aO3cC61vZDVroJu5Ey48wCiuJEnB+MHpMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=macalinao.org; dmarc=pass action=none
 header.from=macalinao.org; dkim=pass header.d=macalinao.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=macalinao.org;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPqfpUVxzYAAM1+nCTRZup9tXxxBkwXIwnzLkHYk7Yw=;
 b=aAZDxtfJcNX6i9cDSLPM9wGu5P2V6mbh8Qk7z+fbJgsuhWXz+IBrafA/q8caaaFgaqj8FkwYpJ2LTNUMyi9ojIHscAV6YLIqtCmqIj1sCkrHYTLeZmOGZks8jYAgd071kfDxGYcV+EQr5pyOS4VNQ0h3G9WjWRLNE9aTb+uDLYrEeMU9tYZiJPc71f7RzCIninVj7RyBjz4N42YHknxYLei/nM3VUkECzZgtgRLTJo8MSr6lyYdalH5TuLFf7wgGVgX5yB6sBNo4R26d/BI8mNB9HL56RMdN5HvgEllOKS5zYJ49f46lzMPTz0Y0J2od3sD7Gi3P6GYSF88LTItWyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=macalinao.org;
Received: from SI2PR03MB5290.apcprd03.prod.outlook.com (2603:1096:4:102::11)
 by SEZPR03MB7036.apcprd03.prod.outlook.com (2603:1096:101:e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Sat, 8 Aug
 2026 17:29:02 +0000
Received: from SI2PR03MB5290.apcprd03.prod.outlook.com
 ([fe80::5923:f4d6:70b1:270c]) by SI2PR03MB5290.apcprd03.prod.outlook.com
 ([fe80::5923:f4d6:70b1:270c%4]) with mapi id 15.21.0292.024; Sat, 8 Aug 2026
 17:29:02 +0000
From: JJ Macalinao <jj@macalinao.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	JJ Macalinao <jj@macalinao.org>
Subject: [PATCH v2] ALSA: usb-audio: add QUIRK_FLAG_ALWAYS_SET_RATE for Mackie
 DLZ Creator XS
Date: Sun,  9 Aug 2026 01:27:26 +0800
Message-ID: <20260808172726.1107550-1-jj@macalinao.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <1c54822e-8147-4ffe-b033-aa4ab966c872@macalinao.org>
References: <1c54822e-8147-4ffe-b033-aa4ab966c872@macalinao.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0058.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:8::9)
 To SI2PR03MB5290.apcprd03.prod.outlook.com (2603:1096:4:102::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR03MB5290:EE_|SEZPR03MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a4727f1-1c27-44d8-faf2-08def57289a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|786006|366016|1800799024|41320700013|376014|23010399003|56012099006|5023799004|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	oU4XJAH3e16obAguOfuif6WRWeex+jpdmPsGKlGnHOJn2OQDNOSkyfJLLPp6CvrzJrBFBP1hkOqeksADqrz5WMLz4RlL+8ii69bEtCysibRoP4wEe7i6twwf6PaaVo9xQkMWd7n2akB3m7gEMCZwz4tM90eTc1PvW976HB+CYXsEh7sWbHJ3dTUwmOa9iqOLEvTUoVh7SsMjQAd7+YxLCc497/QIe60/1gSIaz9x0kac99I1B5ipFlXTtpZBL3gkDTjXIbEBswt31VBkuK7pB/v8kVKCMlMbWdUTVxvTEe5GJx2yIjjCjYwuq4+9Q87SMfmBzVBOqcwC8/XcsN6SmjIRDvLyPxoHrvf7M6xkI+n64ulGGPTq9EA2KfOR8xkVT5Hb/jYl5ID86LoeJ4teRqriEA0M9EJttzzXgmqycC3nu9nGAJ9FNydNz+ZF3BJ4PWmAyMiW9Jsqc81tyApjjLuloxoUQPRfHbGkwCon+1VR1fAouJ0o3La31IQFZqtBTfPACtOURI0h6FBLrd7oJuGWrUbzBEaaGze46j8WiMAwzuv3mCyGLaIRkQTo/3cdaBEIUKK0YkrEaMcPn9BznRu5nOKCS479QJ5XrqPQoqrqnDTyfvMbAuzPCWXDFr4OfrzCRu51Cxs2Qz889i1JqSkyI/nRx+RGiqqTl3rnnfk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5290.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(786006)(366016)(1800799024)(41320700013)(376014)(23010399003)(56012099006)(5023799004)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UqGStm/49sX+MV71mYK/viwNg18D2QGrShxDYLtNtm5FcoHUNsxcHClbLtnx?=
 =?us-ascii?Q?bFsxWQJTjky46r2CN25xCijSgH2bdJDrN/AzPCXALLk/d60yDrvZSWy8+Izl?=
 =?us-ascii?Q?AMbCtp9DkoXYcJ7IqMLcGgFmr7ewpkkIvhUzo7/YpXvEvapkhd10wa2JjX0H?=
 =?us-ascii?Q?TxHxjmvRsbOe3sGZsvwHm2L4JcWD9RMt1oGlAje9zycfH3Nj/5shl1AsYNoN?=
 =?us-ascii?Q?5qsoyCjc9vjEkbmjhCIYBfOcGGRJzsW/DJcEsyEPcKMxzB2jYyb5L4Vtb1FT?=
 =?us-ascii?Q?1zzebg5jSFXqFlE5tf9fWYiiqiw6cRpfgMLS7DxwcGPyJr4kB+uO/ZKkGba0?=
 =?us-ascii?Q?0vWWUFN9e+DsFeB6aLfuAHJIOCQClnOiUfifhmKc8mxCcOY7TDQLeWkEQmP5?=
 =?us-ascii?Q?Bqn7MUQPkq/y7+EjHx5kZV15WdiYVasWO0mht4bPYrCSARMrZG6Xc4cgGWxG?=
 =?us-ascii?Q?cK6AQSv5sY4b6PBgJ1/sUzY0xMVZYfBOx7WQzfVq5lbZgYFS9TqSxDTWRJNS?=
 =?us-ascii?Q?B2fQzkfJGRu9ay8JeAXfnRNz7iyTxzJdQJABa8igqnfHKFoK3oSxY9u1QT10?=
 =?us-ascii?Q?Cs+ii6fPHzz+tbTCX96RDDsI9D9HvcAe2JGZnJhbeV2cZ0v34p9Pkru5Ale1?=
 =?us-ascii?Q?pMswBu6AAoadHHU6dM25JyfcexZN5FypxvR6w6nDU/7xdF6HpBPbJFpR26q0?=
 =?us-ascii?Q?l0vkUOPvOiWDXwfy/oum5Zup3FsYJhVEy1NgILO+UKmq37/0z/O58ZGNvN0s?=
 =?us-ascii?Q?iv5n34c9n9SUh6tYuop7YTi8vZt5nwO9iZbjpNGolmpJJrnj4RzKZJ7uxvwT?=
 =?us-ascii?Q?vv/0URND52O0QBm8oLyJJq265txfIWNPxIo2XSO0tyxiNIriBFKouPq50O6M?=
 =?us-ascii?Q?CCN2w1XJGRtOHJ18c+YqY61lOFEvncib6df+kJcjCz0FGh+9yF2NKcWsEP9s?=
 =?us-ascii?Q?aHHOBZzxpMjWrt5sHW4vpYxmiuDvo2tiWldKkhLuHwfWkUWtFX5xu+Q1rUdC?=
 =?us-ascii?Q?c76q0ahIC3CQpQ/JPEMpK5t5/DKY2ul6G9j4JUQbPtJvInmVIZ0xUqdvGToi?=
 =?us-ascii?Q?ns8geBmoxDXDlsm4Mk9wbus/5UrZ+WP4dtCdneXdEvGflb316ZXPWEYK567z?=
 =?us-ascii?Q?w2j/mfLfmZxJ8Z3eKyZiF0LM2hfq39Ifz0K86V12AE0Kn7HRa5CKZcvfF7wz?=
 =?us-ascii?Q?d3Ss5mZaK2tBNlSpdtGQ1LR9w3jQnSKe9vM9V/QkRiCEBBD7zE2VWaGtYwtN?=
 =?us-ascii?Q?d01dxfRZLwDiI/MXav0SVSW8oB88ePN2qaCUF8Plw/KXHlI0MYRz3ae1nnjO?=
 =?us-ascii?Q?VpZZEe0WXp71LZlAH+R3BzayE7iwV18Q3h/H14LYi7Bjan7ITbfTBxJ46LFl?=
 =?us-ascii?Q?7+f3SmDmYt1L+jOGMXQBVd1hYVtQNXTGRk0UanKXKqNl719hdmoSbE3KhgVP?=
 =?us-ascii?Q?YcBdewuUZi4RSAXOy2Nv3XCtNqxPfbnh46BiFVoONtgTRkLtsAcszZvOfMEd?=
 =?us-ascii?Q?fG2gBsP80IMt0tFLVPnztY3cAiwX33vttkxwCXqJi+rmSomciOrjtWKDyfw2?=
 =?us-ascii?Q?PdZUZBEvhjz3fVH/V3HY2BmOXwSeEz4tNLf97z6FskLvNOGcodydloGZHWYg?=
 =?us-ascii?Q?Ebr80FkduPlFQpgWC1b+LbStY7XB+2nMyZa5zfFvL+6QBVG+0LsJhMJmnAhi?=
 =?us-ascii?Q?F0o2NTvsPqFx/NINZj87V/CSJcuAYzrsljUYxwFzj3gfvgGo?=
X-OriginatorOrg: macalinao.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 9a4727f1-1c27-44d8-faf2-08def57289a8
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5290.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2026 17:29:01.9225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87e58715-deae-490b-8b96-6d6239d507f4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 S92Cg1pEfPq7SwjcidOr/Y0CGAB6UggvxkR9aNBGuRjkzLWDL8FAspn938Y2YbY5Gtv8jjBqeie0MOjGebFbtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7036
X-MailFrom: jj@macalinao.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: YAQ642J7ZPI56NDYLNAIZC3KIDCPSNDS
X-Message-ID-Hash: YAQ642J7ZPI56NDYLNAIZC3KIDCPSNDS
X-Mailman-Approved-At: Wed, 12 Aug 2026 09:24:30 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YAQ642J7ZPI56NDYLNAIZC3KIDCPSNDS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

set_sample_rate_v2v3() returns early when the clock already reports the
requested rate:

	prev_rate = get_sample_rate_v2v3(chip, fmt->iface,
					 fmt->altsetting, clock);
	if (prev_rate == rate)
		goto validation;

A device advertising exactly one sample rate always takes this branch, so
it never receives a SET_CUR for CS_SAM_FREQ_CONTROL at all.

The Mackie DLZ Creator XS (0a73:003a, 14 in / 4 out, 48 kHz only) requires
that write.  Without it the device drops off the USB bus roughly 0.2-1.8 s
into any stream, clearing its port CONNECTION bit; captured audio is
byte-correct until the instant it vanishes.

USBPcap traces of a cold-booted device on Windows show SET_CUR 48000 issued
unconditionally on every stream start, followed by clean streaming.  The
device is otherwise driven with plain class-compliant UAC2 - it also works
on iOS, which cannot load a vendor driver - so no vendor-specific
initialization is involved.

The device is self-powered, so the resulting state survives a USB replug:
initializing it on any host that issues the write leaves it working on
Linux until it is power-cycled, which made the failure look intermittent.

Add a quirk flag rather than dropping the early exit, since the opposite
requirement also exists in-tree: QUIRK_FLAG_FIXED_RATE suppresses rate
setting for single-rate devices (JBL Quantum610/810).  The two behaviors
are device-dependent and cannot both be the default.

A/B on identically cold-booted hardware, same kernel, same port, repeated
twice:

  without the flag  device dropped after 5-6 s, then again after 3-4 s
  with the flag     20 s playback followed by 20 s of 14-channel capture,
                    960000 frames, zero re-enumerations

This change was developed with an AI coding assistant.  The assistant did
the trace analysis that located the bug and wrote the patch and this
changelog; the hardware testing, the cold-boot cycles and the decision to
submit were the author's.  Several earlier hypotheses it proposed - URB
queue depth, isochronous packet under-allocation, endpoint start ordering -
were disproven by measurement before this one.

The bug was located with usbmon on Linux and USBPcap on Windows, by
diffing an enumeration capture of a cold-booted device on each host.
Verified on physical hardware by the A/B above.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: JJ Macalinao <jj@macalinao.org>
---
v2: skip the GET_CUR entirely when the flag is set, per Takashi's review,
    rather than issuing it and discarding the result.

    prev_rate is initialized to 0 because it is still read below - the
    !cur_rate fallback and the TEAC 0x0644 block. That is not a new state:
    get_sample_rate_v2v3() already returns 0 when the GET fails, so both
    paths handle it today.

    Retested on cold-booted hardware, same unit and port: 20 s playback
    followed by 20 s of 14-channel capture, 960000 frames, no
    re-enumeration.

 sound/usb/clock.c    | 11 +++++++----
 sound/usb/quirks.c   |  3 +++
 sound/usb/usbaudio.h |  6 ++++++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 2e0c18e352..34832183a1 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -600,7 +600,7 @@ int snd_usb_set_sample_rate_v2v3(struct snd_usb_audio *chip,
 static int set_sample_rate_v2v3(struct snd_usb_audio *chip,
 				const struct audioformat *fmt, int rate)
 {
-	int cur_rate, prev_rate;
+	int cur_rate, prev_rate = 0;
 	int clock;
 
 	/* First, try to find a valid clock. This may trigger
@@ -625,9 +625,12 @@ static int set_sample_rate_v2v3(struct snd_usb_audio *chip,
 			return clock;
 	}
 
-	prev_rate = get_sample_rate_v2v3(chip, fmt->iface, fmt->altsetting, clock);
-	if (prev_rate == rate)
-		goto validation;
+	if (!(chip->quirk_flags & QUIRK_FLAG_ALWAYS_SET_RATE)) {
+		prev_rate = get_sample_rate_v2v3(chip, fmt->iface,
+						 fmt->altsetting, clock);
+		if (prev_rate == rate)
+			goto validation;
+	}
 
 	cur_rate = snd_usb_set_sample_rate_v2v3(chip, fmt, clock, rate);
 	if (cur_rate < 0) {
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 3330eb6049..d00d6a543a 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2333,6 +2333,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x0951, 0x16ad, /* Kingston HyperX */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
+	DEVICE_FLG(0x0a73, 0x003a, /* Mackie DLZ Creator XS */
+		   QUIRK_FLAG_ALWAYS_SET_RATE),
 	DEVICE_FLG(0x0b05, 0x18a6, /* ASUSTek Computer, Inc. */
 		   QUIRK_FLAG_MIXER_CAPTURE_MIN_MUTE),
 	DEVICE_FLG(0x0b0e, 0x0349, /* Jabra 550a */
@@ -2638,6 +2640,7 @@ static const char *const snd_usb_audio_quirk_flag_names[] = {
 	QUIRK_STRING_ENTRY(IFB_SILENCE_ON_EMPTY),
 	QUIRK_STRING_ENTRY(MIXER_GET_CUR_BROKEN),
 	QUIRK_STRING_ENTRY(PLAYBACK_URB_FIXUP),
+	QUIRK_STRING_ENTRY(ALWAYS_SET_RATE),
 	NULL
 };
 
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 31e6125000..c49709d7ad 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -260,6 +260,10 @@ extern bool snd_usb_skip_validation;
  *  to insufficient buffer depth combined with xHCI scheduling variability.
  *  The larger buffer (MAX_URBS = 12, ~64ms) absorbs system scheduling
  *  jitter during boot, while URB_ISO_ASAP ensures consistent xHCI scheduling.
+ * QUIRK_FLAG_ALWAYS_SET_RATE:
+ *  Issue SET_CUR for the sample rate even when the clock already reports the
+ *  requested rate.  A device advertising a single rate is otherwise never sent
+ *  the request at all, and some require it before streaming will start.
  */
 
 enum {
@@ -295,6 +299,7 @@ enum {
 	QUIRK_TYPE_IFB_SILENCE_ON_EMPTY		= 29,
 	QUIRK_TYPE_MIXER_GET_CUR_BROKEN		= 30,
 	QUIRK_TYPE_PLAYBACK_URB_FIXUP		= 31,
+	QUIRK_TYPE_ALWAYS_SET_RATE		= 32,
 /* Please also edit snd_usb_audio_quirk_flag_names */
 };
 
@@ -332,5 +337,6 @@ enum {
 #define QUIRK_FLAG_IFB_SILENCE_ON_EMPTY		QUIRK_FLAG(IFB_SILENCE_ON_EMPTY)
 #define QUIRK_FLAG_MIXER_GET_CUR_BROKEN		QUIRK_FLAG(MIXER_GET_CUR_BROKEN)
 #define QUIRK_FLAG_PLAYBACK_URB_FIXUP		QUIRK_FLAG(PLAYBACK_URB_FIXUP)
+#define QUIRK_FLAG_ALWAYS_SET_RATE		QUIRK_FLAG(ALWAYS_SET_RATE)
 
 #endif /* __USBAUDIO_H */

base-commit: 140fe610af607fd70da95c447943fc2690855519
-- 
2.55.0

