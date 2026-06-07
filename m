Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A04ECD8C9D
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2026 11:30:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB92D601C9;
	Mon,  8 Jun 2026 13:30:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB92D601C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780918226;
	bh=cma+OJzNml//pjY5/TyIB3CvdYNLU5kzq96lRWpKl4o=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=s+0TOp+JFBDQO5jMU+3LVvcAJtT5CIA07dR7SbbYUeebI63pzudIfalQLdgEETMl/
	 OUmatPXLtmI1yFpGTWMWhzRWPxdgHcWoY9M0lLNKcA4R1wt39CS1eRhEJUpJ6KW1GD
	 sGhYv20RmJMFr6hDRoS6XR4BPv/J8lYR/LigOodg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 41D3DF805EE; Mon,  8 Jun 2026 13:29:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C25FAF80614;
	Mon,  8 Jun 2026 13:29:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5972CF8055B; Sun,  7 Jun 2026 21:16:55 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.46.81
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1780859810;
	b=DAwPNET0jlawGdEvF7R4sj1HZGQnvLurYyKCWFESBRFAzuHL7opjwMKnjJ9TYrZd4ibn
	 CdCDdEIqmBibMFGw1NdghmfiDDCKwM5T/w7NbUra1cYBztHLalz8cg5M/MtCqYUpTekLE
	 2pS9gl7KLwcTiB5e3F2035ZlTZ/h+aKmCEnfw/fbgW8ta9EK4+UnlQ6bQS1FKyAi5evec
	 B7pdlfOWLas7OgIGV0P2rSZHNxba23LXFMcdIPSnkn/k7zUjzDlO6QQV8x0YFsmWP4ltL
	 rWrTXONDHkkNeDWJjiGNWedG771jseQKvz+PTpIS8c3DE34cJ4RO8y0rbkvJgPAEWdQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780859810;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=j7RmSFIgtnOGo6ZSYCWWY/ZF48/taFz0f5HTSYBiK9U=;
	b=jDLOHZXASG6q0yJtnNes+6pYE0X2wDiFN5d9qKP2IlYIeale9dGPX2hSAZDlVzNASSTr
	 Dsw3T3Xx6yf1WAv/7zNOnNc5CVniHUqgaVQ6yPyUvlxwPqxi6lTDM7DELxlzbN7UUevP6
	 qwPjYVwSD7yrQ1uZ1pb3TzsfEDmxTN7KyvfrUjnMvvaT05li3LmowpmribWg8oytTcWmE
	 qH6h5qkwY0Mn8yJacwn+UAXRgxv2kQtvhEHaIt/QSCSyRq6fo2VsW1tWHcCyYlOJ/zclQ
	 qYXSV3qEWDlhsDpM5sgYh5NViPTWLh2nnWneNQptpNYIADBnBSqbqPbaBiIdPS7n7oQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.a=rsa-sha256
 header.s=selector1 header.b=n+hul24R;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.46.81
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazolkn19013081.outbound.protection.outlook.com
 [52.103.46.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C928CF80087
	for <alsa-devel@alsa-project.org>; Sun,  7 Jun 2026 21:16:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C928CF80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.a=rsa-sha256
 header.s=selector1 header.b=n+hul24R
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8qHwL5IvFc7Ict/SA4ArMlVoRtxc8B5IMdtL09cu01+n6Kej35gqraPLNsBr8Rm0hdCWEo6M9Jz9PcV+tmCFl5fFRZXCcU2B36/yqxgwu6b7RkKG+r2kjlajntZ217zywY7GFkMVAVJMZgroev4kjNXLEWKjV6s/boMTgLCz6+wGBa8rmlXiS82TaVTrGx+ncK62RTUqqa+lEEa/ATiB6I1llBCHb7SWfjlZij+aDI/gbAQrwgJuXpuP/MlxqsAxRlA6a8N+rTIEpHo5lB4+0HMp+vvyRM9gC9vXorbBrPZk34hP4V6HOQfWknVRTkmlJYezzPvC59qrtcnaypMXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/RN0noGP+CuH+Lxfp1/p/0WQMPrZS9rgLG7zUdhc9o=;
 b=NA1OqhZnAv+sxf1Q74oxEO8uuADfPTQxNgG1bOfjmY/J/K40krl0AsWnO7Lq3qLTML6EsVrYK0CzFTtxRlvbCW8x0ls9CGvGB2usZ/Ktkuan04NtMq62cUddQLVq7Zri+KGBeVR/2kohX76X5Aif2s7E9XY3w2DpolNi73kfNCO/JeVLjpli15kBB65gtAWPaRqB/hdqFl4Q9awFP7LuWDoVlXoyoAG+accdGtLiZKEoWSKLe9HzBfc69+0w1iX9p27l/kTKSCBtm7cXFSzY1WjqWHS3HtT3biuokXz4wYMIbI08wLc44eZ5ZEwgEWBOne2g0fTK6Bt36JqAimJ9EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/RN0noGP+CuH+Lxfp1/p/0WQMPrZS9rgLG7zUdhc9o=;
 b=n+hul24RP/3528mTqhxAGG6sLtclgnmR3GEOVBrWVn//6wZ8x8jyT2GhYUlZ8P1pibP9RPKzOSbfSa83tZzYJ74xdYVktYgbqlnWL00SS/aIrXbwqlRsLHc2aIqswKwomxiCQRX041B7TkYMR4bOizobVWKIPBGkfkClyuORK8sSOXhjQsr5jy4wMzZYAaNHwoDJtVyCfShWRU7x5nz5ynIsUzUb+Kd6oqdaFCj/2YlVeC6zU4R+uMpZlQn18SJx+vNjs/40pP8q7TulmOBIckmMkuWUZREi4gdkf7B7rJ2FLSTibJw8MOnLryWbilpcoqx4FPCzmoY7cOoDRUBgAQ==
Received: from AS8P250MB0887.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:54c::13)
 by DU7PPFEB0D49F29.EURP250.PROD.OUTLOOK.COM (2603:10a6:18:3::b67) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Sun, 7 Jun 2026
 19:16:48 +0000
Received: from AS8P250MB0887.EURP250.PROD.OUTLOOK.COM
 ([fe80::d225:cd5f:c40c:482]) by AS8P250MB0887.EURP250.PROD.OUTLOOK.COM
 ([fe80::d225:cd5f:c40c:482%4]) with mapi id 15.21.0092.011; Sun, 7 Jun 2026
 19:16:48 +0000
From: Gigi Furnari <gigi.furnari@hotmail.de>
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC: "tiwai@suse.de" <tiwai@suse.de>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>
Subject: [PATCH REQUEST] hda/realtek: Add fixup for HP Spectre x360 16-f1xxx
 (103c:891c, ALC245)
Thread-Topic: [PATCH REQUEST] hda/realtek: Add fixup for HP Spectre x360
 16-f1xxx (103c:891c, ALC245)
Thread-Index: AQHc9rGkEF+3gXCLL0i3KlYlBCGkew==
Date: Sun, 7 Jun 2026 19:16:47 +0000
Message-ID: 
 <AS8P250MB0887C48FD62B9F2A5B882565F41F2@AS8P250MB0887.EURP250.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8P250MB0887:EE_|DU7PPFEB0D49F29:EE_
x-ms-office365-filtering-correlation-id: 7c7133a9-788f-4ef6-295c-08dec4c95232
x-microsoft-antispam: 
 BCL:0;ARA:14566002|31061999003|15080799012|24071999003|6092099016|14030799003|5062599005|39105399006|25031999004|24021099003|8062599012|8060799015|20031999006|19110799012|3412199025|440099028|102099032|40105399003;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?DofJ6v2MPSuT+AWVMb9oCMDJbNi+FLyo+OiYJjr09ZD6ZwrgmX7ioESdNrvu?=
 =?us-ascii?Q?6lc6v+VosrpTk5suYEvagoACzo6W1g39pmZsnJqb+KkQyrWFf4VNi3qoA+Jq?=
 =?us-ascii?Q?VDvB/QjaZHrfp7BKS2FoXbab8OurecCv0RMoMcDZnZRD/q/V02b+VYa421lz?=
 =?us-ascii?Q?yDYR+R2vB2WTLEMlLrV5oQ2Ho1B08Li4yJSfz6EhRJ4MSjCuSVEUeaAt8XQT?=
 =?us-ascii?Q?/xNb2y792hCp3SKkDxoxSWsU25stslJwrjONYH56lPh0clK9Vuzu6G365YlP?=
 =?us-ascii?Q?TsNXAxlKFcqQTSruKCDp/ZGDfzs2iVzOUMgour1tDHToF50sO2Q2ULQ3G910?=
 =?us-ascii?Q?HoOa6xvKyjG+JYIwqRB9AlwJ6ady4V+lQFKCLbNGe9BuK6DO2vzMe1kzdXkn?=
 =?us-ascii?Q?/DGZacVuTscYBiJieoRQAqyPutVTEwaREO2nmQzanlgd03uTeupSY/fqnDjW?=
 =?us-ascii?Q?iq3J6y3TPk3+4f1YRZlr8IqYdQWsWImgk7tav+9Y97fLqbl3YQdl1qWbkiwb?=
 =?us-ascii?Q?wnhz6OwlY4JCMrJyoYwt8DQ148JfsT2pC+rUBlgtM+cGoCYGUjsj5Dvh/NnM?=
 =?us-ascii?Q?eYu9Pa3MppUcB3naWAdvCWjMgpcBmFGT2IPQHCogW8aXqTQO6a5ctbWGA2Jq?=
 =?us-ascii?Q?T09+0vOEeZjcQV0VyTm2cX9nnBDc9dSNZVIKShSL6d+BTQs+2cS88AGzVfLw?=
 =?us-ascii?Q?3M0yhHEPfYRvjr95oBSoDzmLsvZijvTl7etYiSnXUr45TbCA3g5sbEh7fo+p?=
 =?us-ascii?Q?vYLOgFypMeBp8GD2oB3sFnkRKlq2sZMypo7hxqmuenfwH9wj3XZ+SlugMrQn?=
 =?us-ascii?Q?DeHgYtWz9oVDsVoGeTyBNLBxC/xvdty75kNbl6h/etwhXjr68iN+omlOLBxO?=
 =?us-ascii?Q?fo2TNc+kcTND/dUSguw7ffbrzdkT9zwbs1SfF1gl9c0MO3jxZdhFTiLbfjtH?=
 =?us-ascii?Q?nItYP+DeklKN9lq5ah12wwk9wQ78qEzQRNDeFoTJKJH5Yv3aMrYI2LbqJYt/?=
 =?us-ascii?Q?0a/FyznHAdQrz1qcQTq3YU1BfxQa9mI7lYmFvZ345EjyXnCCPqm/mfcZvD8X?=
 =?us-ascii?Q?KNVFew7cAFGwot3GCLcYIHD1d7+kLL4JOmq7WU4xbh78YDrGYUCM+DnPxzMl?=
 =?us-ascii?Q?CwXAaN666/hf?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?4seZJQqQ1wIVoL9cMBcO76fEDt7j68M8POFJv8IciqW9tNtSlc2NduxC31kV?=
 =?us-ascii?Q?vv2u+Icl+zbbFOE8hSzwU+3dwjyM/LmzNELt4BuHxoYyF0rytQibBus49N+p?=
 =?us-ascii?Q?Memi6lTOm4sDso+U7bORRApHQqFPuavknbkx+9jW4VRRUlFoqwF/iH2t1G6Y?=
 =?us-ascii?Q?+AHZkjs8eV0De5/tri7Xj48nTFm/JuChCn+ufSYyaR8dhmAGLTh06HUXAvv6?=
 =?us-ascii?Q?QoFDNlz4MMt7yZs+tTd5ZQa+44B+M6acpmgTEJAbey3maFJ7uQAvqoL1BV76?=
 =?us-ascii?Q?UA5SSsVTvDQ+BCNqSRJ69CaSsmBRGeaCFtgVrBpM6j4LR01k82Pxw918WTwz?=
 =?us-ascii?Q?HQc68vpOSk4I96Yv+Go8oH4DgifEbFUeUWGeIzrNE61yUExP7GXDsBPFWgSL?=
 =?us-ascii?Q?1LposgknLU4w1rT+mePg/09iFj6XTOT3iiVw0S38CvwabgDPCaCi1QcV2o/E?=
 =?us-ascii?Q?2u2UKpSf9v8E+ClYaH9tt6RnQoNWwumwltNyz4342CjJrgABCLpwVbBTQjKv?=
 =?us-ascii?Q?2dyKY1aaZLLv+oZFxe8dkbH7UZjESf+cTrCu93E1Bth7ZsoTY95D3+EJLm/W?=
 =?us-ascii?Q?kgM1AYKFSzJPW4zLQfZ6DoAxZqYrO9QPWbBifU59rx0Jk+MSl7YvX+8omdkg?=
 =?us-ascii?Q?zqHPz8/Br4jZiQgmdmmbYxDYY9bpM7u+8dBKXx6HBMAZn92LA6CTjeejkVxb?=
 =?us-ascii?Q?CzAKhowA9N/aPJsUXgSwEEAG70sGWeZbKs6r91sPFoYpJjuSE6SgFPfjfW5M?=
 =?us-ascii?Q?Gm8R14Gysjl4xXfjxGI6SpsR02+AQ6Sz41NhsyGnsybWBcl9rnANhSO2D8us?=
 =?us-ascii?Q?Bu8HtSY1XA53XfFkGuDiDgID8TGx4qeOLzWN3ce3bQmI7TXnU7GiDRFPA1eK?=
 =?us-ascii?Q?lmHlHY0Q1MkWdG9zJAZmNolToT1bxmteEUsChwNtUpdRA3Z+R6Wo7bMCxk4f?=
 =?us-ascii?Q?kHVRRdmpenV7+ZJpif/TuR8K6XVY8VbvFyF1bsSqmvH206q78sTosJbFSSHB?=
 =?us-ascii?Q?aFpV64ecSKcJvmmDdC3DS83CT/Su4txIH779WGOOwTY1DgP7D3OzEs8py3Gx?=
 =?us-ascii?Q?f3eYqjBFgrEC0xr6QSaBTRe1vWiPM5aX+A4jo7ry5LyN0zBOHOMwL8gaJMdc?=
 =?us-ascii?Q?0VpQSnIMtAKXnVr/0QNDDdvnZz5USb7LCOrg0cx+JdB28Ge6FYSq+kexNZoG?=
 =?us-ascii?Q?sE7wH2qQyr2SaLYYNddrwsinhClmhxpe1V2+oqFymOYMmiMSN4u6lO5Vll4S?=
 =?us-ascii?Q?3HmQcl+xx/EUjhjUuKt9ObG7k09AedaGa8VVKppB/1DrCnA6CJzQsGOmXbUc?=
 =?us-ascii?Q?muvWa7capCg0boTdH8PF0/N0CwYAU16R6s9NtB1OdLfRVT9GVk84H0ZmIgbl?=
 =?us-ascii?Q?BQ2qkoiIxFJFiXkTafnprCvRVBqlu8KAfyYUIV+V+RyF2r9sJQ=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_004_AS8P250MB0887C48FD62B9F2A5B882565F41F2AS8P250MB0887EURP_"
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-6108c.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8P250MB0887.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 7c7133a9-788f-4ef6-295c-08dec4c95232
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2026 19:16:47.9661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 
 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PPFEB0D49F29
X-MailFrom: gigi.furnari@hotmail.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: I5VDTJLKY7TT72NAFBY455GEGWFXACON
X-Message-ID-Hash: I5VDTJLKY7TT72NAFBY455GEGWFXACON
X-Mailman-Approved-At: Mon, 08 Jun 2026 11:29:51 +0000
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FWWOZ4J7ZIRPFOMNPI5RXKLVOBT7YR6T/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

--_004_AS8P250MB0887C48FD62B9F2A5B882565F41F2AS8P250MB0887EURP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The HP Spectre x360 2-in-1 Laptop 16-f1xxx (PCI SSID 103c:891c) uses
a Realtek ALC245 codec. Without a fixup, the upper speakers (node 0x14)
are silent because their pin configuration is set to N/A (0x411111f0)
and the amplifier GPIO is not initialized.

The codec layout is:
  Node 0x14: upper speakers, connected to DAC 0x02, EAPD present
  Node 0x17: lower speakers, connected to DAC 0x06 (active)
  Node 0x21: headphone out, connected to DAC 0x03 (active)

The fix overrides the pin default config for node 0x14 to mark it as
an internal fixed speaker, and chains to the existing
ALC245_FIXUP_HP_X360_AMP fixup which toggles GPIO0 to enable the
amplifier -- the same mechanism used by the HP Spectre x360 14
(103c:87f7).

Note: the driver currently reads PCI SSID as 103c:0000 instead of the
correct 103c:891c (the codec reports Subsystem Id: 0x103c891c correctly
in /proc/asound/card0/codec#0). This means no device-specific fixup is
applied without an explicit model parameter. This patch adds the quirk
entry so the correct fixup is applied automatically once the SSID
reading issue is resolved, and can be used with model=3D in the meantime.

Signed-off-by: [Your Name] <your@email.com>
---

HOW TO APPLY (context lines abbreviated; apply against current mainline):

In sound/pci/hda/patch_realtek.c:

1) In the enum (near ALC245_FIXUP_HP_X360_AMP), add:
   ALC245_FIXUP_HP_SPECTRE_X360_16,

2) In alc269_fixups[], after the ALC245_FIXUP_HP_X360_AMP entry, add:

 [ALC245_FIXUP_HP_SPECTRE_X360_16] =3D {
  .type =3D HDA_FIXUP_PINS,
  .v.pins =3D (const struct hda_pintbl[]) {
   { 0x14, 0x90170110 }, /* upper speakers */
   { }
  },
  .chained =3D true,
  .chain_id =3D ALC245_FIXUP_HP_X360_AMP,
 },

3) In alc269_fixup_tbl[] (keep sorted by PCI SSID), add:

 SND_PCI_QUIRK(0x103c, 0x891c, "HP Spectre x360 16-f1xxx",
        ALC245_FIXUP_HP_SPECTRE_X360_16),

---
Full diff (line numbers are approximate; verify against current tree):

 sound/pci/hda/patch_realtek.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ enum (around ALC245_FIXUP_HP_X360_AMP line) @@
  ALC245_FIXUP_HP_X360_AMP,
+ ALC245_FIXUP_HP_SPECTRE_X360_16,

@@ alc269_fixups[] (after ALC245_FIXUP_HP_X360_AMP block) @@
+ [ALC245_FIXUP_HP_SPECTRE_X360_16] =3D {
+ .type =3D HDA_FIXUP_PINS,
+ .v.pins =3D (const struct hda_pintbl[]) {
+ { 0x14, 0x90170110 }, /* upper speakers */
+ { }
+ },
+ .chained =3D true,
+ .chain_id =3D ALC245_FIXUP_HP_X360_AMP,
+ },

@@ alc269_fixup_tbl[] (sorted position after 0x891b if present, else near 0=
x891c) @@
+ SND_PCI_QUIRK(0x103c, 0x891c, "HP Spectre x360 16-f1xxx",
+ ALC245_FIXUP_HP_SPECTRE_X360_16),

---
ADDITIONAL NOTE FOR MAINTAINER:

The codec correctly reports Subsystem Id: 0x103c891c in
/proc/asound/card0/codec#0, but dmesg shows:
  snd_hda_codec_alc269: ALC245: picked fixup for PCI SSID 103c:0000

This SSID mismatch (0000 vs 891c) means the quirk table is never
consulted. The root cause appears to be in how the HDA subsystem ID
is read on this Alder Lake platform -- a separate bug that may need
investigation in hda_codec.c or the Intel HDA driver.

Tested on:
  Device: HP Spectre x360 2-in-1 Laptop 16-f1xxx
  BIOS: F.18 10/11/2023
  Kernel: 7.0.10-201.fc44.x86_64
  OS: Fedora 44


--_004_AS8P250MB0887C48FD62B9F2A5B882565F41F2AS8P250MB0887EURP_
Content-Type: text/plain; name="codec_dump.txt"
Content-Description: codec_dump.txt
Content-Disposition: attachment; filename="codec_dump.txt"; size=10241;
	creation-date="Sun, 07 Jun 2026 19:16:12 GMT";
	modification-date="Sun, 07 Jun 2026 19:16:12 GMT"
Content-Transfer-Encoding: base64

Q29kZWM6IFJlYWx0ZWsgQUxDMjQ1CkFkZHJlc3M6IDAKQUZHIEZ1bmN0aW9uIElkOiAweDEgKHVu
c29sIDEpClZlbmRvciBJZDogMHgxMGVjMDI0NQpTdWJzeXN0ZW0gSWQ6IDB4MTAzYzg5MWMKUmV2
aXNpb24gSWQ6IDB4MTAwMDAxCk5vIE1vZGVtIEZ1bmN0aW9uIEdyb3VwIGZvdW5kCkRlZmF1bHQg
UENNOgogICAgcmF0ZXMgWzB4NTYwXTogNDQxMDAgNDgwMDAgOTYwMDAgMTkyMDAwCiAgICBiaXRz
IFsweGVdOiAxNiAyMCAyNAogICAgZm9ybWF0cyBbMHgxXTogUENNCkRlZmF1bHQgQW1wLUluIGNh
cHM6IE4vQQpEZWZhdWx0IEFtcC1PdXQgY2FwczogTi9BClN0YXRlIG9mIEFGRyBub2RlIDB4MDE6
CiAgUG93ZXIgc3RhdGVzOiAgRDAgRDEgRDIgRDMgRDNjb2xkIENMS1NUT1AgRVBTUwogIFBvd2Vy
OiBzZXR0aW5nPUQwLCBhY3R1YWw9RDAKR1BJTzogaW89Mywgbz0wLCBpPTAsIHVuc29saWNpdGVk
PTEsIHdha2U9MAogIElPWzBdOiBlbmFibGU9MCwgZGlyPTAsIHdha2U9MCwgc3RpY2t5PTAsIGRh
dGE9MCwgdW5zb2w9MAogIElPWzFdOiBlbmFibGU9MCwgZGlyPTAsIHdha2U9MCwgc3RpY2t5PTAs
IGRhdGE9MCwgdW5zb2w9MAogIElPWzJdOiBlbmFibGU9MCwgZGlyPTAsIHdha2U9MCwgc3RpY2t5
PTAsIGRhdGE9MCwgdW5zb2w9MApOb2RlIDB4MDIgW0F1ZGlvIE91dHB1dF0gd2NhcHMgMHg0MWQ6
IFN0ZXJlbyBBbXAtT3V0CiAgQ29udHJvbDogbmFtZT0iQmFzcyBTcGVha2VyIFBsYXliYWNrIFZv
bHVtZSIsIGluZGV4PTAsIGRldmljZT0wCiAgICBDb250cm9sQW1wOiBjaHM9MywgZGlyPU91dCwg
aWR4PTAsIG9mcz0wCiAgQW1wLU91dCBjYXBzOiBvZnM9MHg1NywgbnN0ZXBzPTB4NTcsIHN0ZXBz
aXplPTB4MDIsIG11dGU9MAogIEFtcC1PdXQgdmFsczogIFsweDA5IDB4MDldCiAgQ29udmVydGVy
OiBzdHJlYW09MCwgY2hhbm5lbD0wCiAgUENNOgogICAgcmF0ZXMgWzB4NDBdOiA0ODAwMAogICAg
Yml0cyBbMHhlXTogMTYgMjAgMjQKICAgIGZvcm1hdHMgWzB4MV06IFBDTQogIFBvd2VyIHN0YXRl
czogIEQwIEQxIEQyIEQzIEVQU1MKICBQb3dlcjogc2V0dGluZz1EMCwgYWN0dWFsPUQwCk5vZGUg
MHgwMyBbQXVkaW8gT3V0cHV0XSB3Y2FwcyAweDQxZDogU3RlcmVvIEFtcC1PdXQKICBDb250cm9s
OiBuYW1lPSJIZWFkcGhvbmUgUGxheWJhY2sgVm9sdW1lIiwgaW5kZXg9MCwgZGV2aWNlPTAKICAg
IENvbnRyb2xBbXA6IGNocz0zLCBkaXI9T3V0LCBpZHg9MCwgb2ZzPTAKICBBbXAtT3V0IGNhcHM6
IG9mcz0weDU3LCBuc3RlcHM9MHg1Nywgc3RlcHNpemU9MHgwMiwgbXV0ZT0wCiAgQW1wLU91dCB2
YWxzOiAgWzB4MDAgMHgwMF0KICBDb252ZXJ0ZXI6IHN0cmVhbT0wLCBjaGFubmVsPTAKICBQQ006
CiAgICByYXRlcyBbMHg0MF06IDQ4MDAwCiAgICBiaXRzIFsweGVdOiAxNiAyMCAyNAogICAgZm9y
bWF0cyBbMHgxXTogUENNCiAgUG93ZXIgc3RhdGVzOiAgRDAgRDEgRDIgRDMgRVBTUwogIFBvd2Vy
OiBzZXR0aW5nPUQwLCBhY3R1YWw9RDAKTm9kZSAweDA0IFtWZW5kb3IgRGVmaW5lZCBXaWRnZXRd
IHdjYXBzIDB4ZjAwMDAwOiBNb25vCk5vZGUgMHgwNSBbVmVuZG9yIERlZmluZWQgV2lkZ2V0XSB3
Y2FwcyAweGYwMDAwMDogTW9ubwpOb2RlIDB4MDYgW0F1ZGlvIE91dHB1dF0gd2NhcHMgMHg0MTE6
IFN0ZXJlbwogIERldmljZTogbmFtZT0iQUxDMjQ1IEFuYWxvZyIsIHR5cGU9IkF1ZGlvIiwgZGV2
aWNlPTAKICBDb252ZXJ0ZXI6IHN0cmVhbT0wLCBjaGFubmVsPTAKICBQQ006CiAgICByYXRlcyBb
MHg0MF06IDQ4MDAwCiAgICBiaXRzIFsweGVdOiAxNiAyMCAyNAogICAgZm9ybWF0cyBbMHgxXTog
UENNCiAgUG93ZXIgc3RhdGVzOiAgRDAgRDEgRDIgRDMgRVBTUwogIFBvd2VyOiBzZXR0aW5nPUQw
LCBhY3R1YWw9RDAKTm9kZSAweDA3IFtBdWRpbyBJbnB1dF0gd2NhcHMgMHgxMDA1MWI6IFN0ZXJl
byBBbXAtSW4KICBBbXAtSW4gY2Fwczogb2ZzPTB4MTcsIG5zdGVwcz0weDNmLCBzdGVwc2l6ZT0w
eDAyLCBtdXRlPTEKICBBbXAtSW4gdmFsczogIFsweDk3IDB4OTddCiAgQ29udmVydGVyOiBzdHJl
YW09MCwgY2hhbm5lbD0wCiAgU0RJLVNlbGVjdDogMAogIFBDTToKICAgIHJhdGVzIFsweDQwXTog
NDgwMDAKICAgIGJpdHMgWzB4ZV06IDE2IDIwIDI0CiAgICBmb3JtYXRzIFsweDFdOiBQQ00KICBQ
b3dlciBzdGF0ZXM6ICBEMCBEMSBEMiBEMyBFUFNTCiAgUG93ZXI6IHNldHRpbmc9RDAsIGFjdHVh
bD1EMAogIENvbm5lY3Rpb246IDEKICAgICAweDI0Ck5vZGUgMHgwOCBbQXVkaW8gSW5wdXRdIHdj
YXBzIDB4MTAwNTFiOiBTdGVyZW8gQW1wLUluCiAgQ29udHJvbDogbmFtZT0iQ2FwdHVyZSBWb2x1
bWUiLCBpbmRleD0wLCBkZXZpY2U9MAogICAgQ29udHJvbEFtcDogY2hzPTMsIGRpcj1JbiwgaWR4
PTAsIG9mcz0wCiAgQ29udHJvbDogbmFtZT0iQ2FwdHVyZSBTd2l0Y2giLCBpbmRleD0wLCBkZXZp
Y2U9MAogICAgQ29udHJvbEFtcDogY2hzPTMsIGRpcj1JbiwgaWR4PTAsIG9mcz0wCiAgRGV2aWNl
OiBuYW1lPSJBTEMyNDUgQW5hbG9nIiwgdHlwZT0iQXVkaW8iLCBkZXZpY2U9MAogIEFtcC1JbiBj
YXBzOiBvZnM9MHgxNywgbnN0ZXBzPTB4M2YsIHN0ZXBzaXplPTB4MDIsIG11dGU9MQogIEFtcC1J
biB2YWxzOiAgWzB4MjcgMHgyN10KICBDb252ZXJ0ZXI6IHN0cmVhbT0wLCBjaGFubmVsPTAKICBT
REktU2VsZWN0OiAwCiAgUENNOgogICAgcmF0ZXMgWzB4NTYwXTogNDQxMDAgNDgwMDAgOTYwMDAg
MTkyMDAwCiAgICBiaXRzIFsweGVdOiAxNiAyMCAyNAogICAgZm9ybWF0cyBbMHgxXTogUENNCiAg
UG93ZXIgc3RhdGVzOiAgRDAgRDEgRDIgRDMgRVBTUwogIFBvd2VyOiBzZXR0aW5nPUQwLCBhY3R1
YWw9RDAKICBDb25uZWN0aW9uOiAxCiAgICAgMHgyMwpOb2RlIDB4MDkgW0F1ZGlvIElucHV0XSB3
Y2FwcyAweDEwMDUxYjogU3RlcmVvIEFtcC1JbgogIEFtcC1JbiBjYXBzOiBvZnM9MHgxNywgbnN0
ZXBzPTB4M2YsIHN0ZXBzaXplPTB4MDIsIG11dGU9MQogIEFtcC1JbiB2YWxzOiAgWzB4OTcgMHg5
N10KICBDb252ZXJ0ZXI6IHN0cmVhbT0wLCBjaGFubmVsPTAKICBTREktU2VsZWN0OiAwCiAgUENN
OgogICAgcmF0ZXMgWzB4NTYwXTogNDQxMDAgNDgwMDAgOTYwMDAgMTkyMDAwCiAgICBiaXRzIFsw
eGVdOiAxNiAyMCAyNAogICAgZm9ybWF0cyBbMHgxXTogUENNCiAgUG93ZXIgc3RhdGVzOiAgRDAg
RDEgRDIgRDMgRVBTUwogIFBvd2VyOiBzZXR0aW5nPUQwLCBhY3R1YWw9RDAKICBDb25uZWN0aW9u
OiAxCiAgICAgMHgyMgpOb2RlIDB4MGEgW0F1ZGlvIElucHV0XSB3Y2FwcyAweDEwMDUxYjogU3Rl
cmVvIEFtcC1JbgogIEFtcC1JbiBjYXBzOiBvZnM9MHgxNywgbnN0ZXBzPTB4M2YsIHN0ZXBzaXpl
PTB4MDIsIG11dGU9MQogIEFtcC1JbiB2YWxzOiAgWzB4OTcgMHg5N10KICBDb252ZXJ0ZXI6IHN0
cmVhbT0wLCBjaGFubmVsPTAKICBTREktU2VsZWN0OiAwCiAgUENNOgogICAgcmF0ZXMgWzB4NDBd
OiA0ODAwMAogICAgYml0cyBbMHhlXTogMTYgMjAgMjQKICAgIGZvcm1hdHMgWzB4MV06IFBDTQog
IFBvd2VyIHN0YXRlczogIEQwIEQxIEQyIEQzIEVQU1MKICBQb3dlcjogc2V0dGluZz1EMCwgYWN0
dWFsPUQwCiAgQ29ubmVjdGlvbjogMQogICAgIDB4MjUKTm9kZSAweDBiIFtWZW5kb3IgRGVmaW5l
ZCBXaWRnZXRdIHdjYXBzIDB4ZjAwMDAwOiBNb25vCk5vZGUgMHgwYyBbVmVuZG9yIERlZmluZWQg
V2lkZ2V0XSB3Y2FwcyAweGYwMDAwMDogTW9ubwpOb2RlIDB4MGQgW1ZlbmRvciBEZWZpbmVkIFdp
ZGdldF0gd2NhcHMgMHhmMDAwMDA6IE1vbm8KTm9kZSAweDBlIFtWZW5kb3IgRGVmaW5lZCBXaWRn
ZXRdIHdjYXBzIDB4ZjAwMDAwOiBNb25vCk5vZGUgMHgwZiBbVmVuZG9yIERlZmluZWQgV2lkZ2V0
XSB3Y2FwcyAweGYwMDAwMDogTW9ubwpOb2RlIDB4MTAgW1ZlbmRvciBEZWZpbmVkIFdpZGdldF0g
d2NhcHMgMHhmMDAwMDA6IE1vbm8KTm9kZSAweDExIFtWZW5kb3IgRGVmaW5lZCBXaWRnZXRdIHdj
YXBzIDB4ZjAwMDAwOiBNb25vCk5vZGUgMHgxMiBbUGluIENvbXBsZXhdIHdjYXBzIDB4NDAwNDBi
OiBTdGVyZW8gQW1wLUluCiAgQW1wLUluIGNhcHM6IG9mcz0weDAwLCBuc3RlcHM9MHgwMywgc3Rl
cHNpemU9MHgyNywgbXV0ZT0wCiAgQW1wLUluIHZhbHM6ICBbMHgwMCAweDAwXQogIFBpbmNhcCAw
eDAwMDAwMDIwOiBJTgogIFBpbiBEZWZhdWx0IDB4NDExMTExZjA6IFtOL0FdIFNwZWFrZXIgYXQg
RXh0IFJlYXIKICAgIENvbm4gPSAxLzgsIENvbG9yID0gQmxhY2sKICAgIERlZkFzc29jaWF0aW9u
ID0gMHhmLCBTZXF1ZW5jZSA9IDB4MAogICAgTWlzYyA9IE5PX1BSRVNFTkNFCiAgUGluLWN0bHM6
IDB4MDA6CiAgUG93ZXIgc3RhdGVzOiAgRDAgRDEgRDIgRDMgRVBTUwogIFBvd2VyOiBzZXR0aW5n
PUQwLCBhY3R1YWw9RDAKTm9kZSAweDEzIFtQaW4gQ29tcGxleF0gd2NhcHMgMHg0MDA0MGI6IFN0
ZXJlbyBBbXAtSW4KICBBbXAtSW4gY2Fwczogb2ZzPTB4MDAsIG5zdGVwcz0weDAzLCBzdGVwc2l6
ZT0weDI3LCBtdXRlPTAKICBBbXAtSW4gdmFsczogIFsweDAwIDB4MDBdCiAgUGluY2FwIDB4MDAw
MDAwMjA6IElOCiAgUGluIERlZmF1bHQgMHg0MDAwMDAwMDogW04vQV0gTGluZSBPdXQgYXQgRXh0
IE4vQQogICAgQ29ubiA9IFVua25vd24sIENvbG9yID0gVW5rbm93bgogICAgRGVmQXNzb2NpYXRp
b24gPSAweDAsIFNlcXVlbmNlID0gMHgwCiAgUGluLWN0bHM6IDB4MDA6CiAgUG93ZXIgc3RhdGVz
OiAgRDAgRDEgRDIgRDMgRVBTUwogIFBvd2VyOiBzZXR0aW5nPUQwLCBhY3R1YWw9RDAKTm9kZSAw
eDE0IFtQaW4gQ29tcGxleF0gd2NhcHMgMHg0MDA1OGQ6IFN0ZXJlbyBBbXAtT3V0CiAgQ29udHJv
bDogbmFtZT0iQmFzcyBTcGVha2VyIFBsYXliYWNrIFN3aXRjaCIsIGluZGV4PTAsIGRldmljZT0w
CiAgICBDb250cm9sQW1wOiBjaHM9MywgZGlyPU91dCwgaWR4PTAsIG9mcz0wCiAgQW1wLU91dCBj
YXBzOiBvZnM9MHgwMCwgbnN0ZXBzPTB4MDAsIHN0ZXBzaXplPTB4MDAsIG11dGU9MQogIEFtcC1P
dXQgdmFsczogIFsweDAwIDB4MDBdCiAgUGluY2FwIDB4MDAwMTAwMTQ6IE9VVCBFQVBEIERldGVj
dAogIEVBUEQgMHgyOiBFQVBECiAgUGluIERlZmF1bHQgMHg0MTExMTFmMDogW04vQV0gU3BlYWtl
ciBhdCBFeHQgUmVhcgogICAgQ29ubiA9IDEvOCwgQ29sb3IgPSBCbGFjawogICAgRGVmQXNzb2Np
YXRpb24gPSAweGYsIFNlcXVlbmNlID0gMHgwCiAgICBNaXNjID0gTk9fUFJFU0VOQ0UKICBQaW4t
Y3RsczogMHg0MDogT1VUCiAgVW5zb2xpY2l0ZWQ6IHRhZz0wMCwgZW5hYmxlZD0wCiAgUG93ZXIg
c3RhdGVzOiAgRDAgRDEgRDIgRDMgRVBTUwogIFBvd2VyOiBzZXR0aW5nPUQwLCBhY3R1YWw9RDAK
ICBDb25uZWN0aW9uOiAxCiAgICAgMHgwMgpOb2RlIDB4MTUgW1ZlbmRvciBEZWZpbmVkIFdpZGdl
dF0gd2NhcHMgMHhmMDAwMDA6IE1vbm8KTm9kZSAweDE2IFtWZW5kb3IgRGVmaW5lZCBXaWRnZXRd
IHdjYXBzIDB4ZjAwMDAwOiBNb25vCk5vZGUgMHgxNyBbUGluIENvbXBsZXhdIHdjYXBzIDB4NDAw
NThkOiBTdGVyZW8gQW1wLU91dAogIENvbnRyb2w6IG5hbWU9IlNwZWFrZXIgUGxheWJhY2sgU3dp
dGNoIiwgaW5kZXg9MCwgZGV2aWNlPTAKICAgIENvbnRyb2xBbXA6IGNocz0zLCBkaXI9T3V0LCBp
ZHg9MCwgb2ZzPTAKICBBbXAtT3V0IGNhcHM6IG9mcz0weDAwLCBuc3RlcHM9MHgwMCwgc3RlcHNp
emU9MHgwMCwgbXV0ZT0xCiAgQW1wLU91dCB2YWxzOiAgWzB4MDAgMHgwMF0KICBQaW5jYXAgMHgw
MDAwMDAxYzogT1VUIEhQIERldGVjdAogIFBpbiBEZWZhdWx0IDB4OTAxNzAxMTA6IFtGaXhlZF0g
U3BlYWtlciBhdCBJbnQgTi9BCiAgICBDb25uID0gQW5hbG9nLCBDb2xvciA9IFVua25vd24KICAg
IERlZkFzc29jaWF0aW9uID0gMHgxLCBTZXF1ZW5jZSA9IDB4MAogICAgTWlzYyA9IE5PX1BSRVNF
TkNFCiAgUGluLWN0bHM6IDB4NDA6IE9VVAogIFVuc29saWNpdGVkOiB0YWc9MDAsIGVuYWJsZWQ9
MAogIFBvd2VyIHN0YXRlczogIEQwIEQxIEQyIEQzIEVQU1MKICBQb3dlcjogc2V0dGluZz1EMCwg
YWN0dWFsPUQwCiAgQ29ubmVjdGlvbjogNAogICAgIDB4MDIgMHgwMyAweDA2KiAweDA4Ck5vZGUg
MHgxOCBbUGluIENvbXBsZXhdIHdjYXBzIDB4NDAwNDhiOiBTdGVyZW8gQW1wLUluCiAgQW1wLUlu
IGNhcHM6IG9mcz0weDAwLCBuc3RlcHM9MHgwMywgc3RlcHNpemU9MHgyNywgbXV0ZT0wCiAgQW1w
LUluIHZhbHM6ICBbMHgwMCAweDAwXQogIFBpbmNhcCAweDAwMDAwMDI0OiBJTiBEZXRlY3QKICBQ
aW4gRGVmYXVsdCAweDQxMTExMWYwOiBbTi9BXSBTcGVha2VyIGF0IEV4dCBSZWFyCiAgICBDb25u
ID0gMS84LCBDb2xvciA9IEJsYWNrCiAgICBEZWZBc3NvY2lhdGlvbiA9IDB4ZiwgU2VxdWVuY2Ug
PSAweDAKICAgIE1pc2MgPSBOT19QUkVTRU5DRQogIFBpbi1jdGxzOiAweDAwOgogIFVuc29saWNp
dGVkOiB0YWc9MDAsIGVuYWJsZWQ9MAogIFBvd2VyIHN0YXRlczogIEQwIEQxIEQyIEQzIEVQU1MK
ICBQb3dlcjogc2V0dGluZz1EMCwgYWN0dWFsPUQwCk5vZGUgMHgxOSBbUGluIENvbXBsZXhdIHdj
YXBzIDB4NDAwNDhiOiBTdGVyZW8gQW1wLUluCiAgQ29udHJvbDogbmFtZT0iTWljIEJvb3N0IFZv
bHVtZSIsIGluZGV4PTAsIGRldmljZT0wCiAgICBDb250cm9sQW1wOiBjaHM9MywgZGlyPUluLCBp
ZHg9MCwgb2ZzPTAKICBBbXAtSW4gY2Fwczogb2ZzPTB4MDAsIG5zdGVwcz0weDAzLCBzdGVwc2l6
ZT0weDI3LCBtdXRlPTAKICBBbXAtSW4gdmFsczogIFsweDAwIDB4MDBdCiAgUGluY2FwIDB4MDAw
MDM3MjQ6IElOIERldGVjdAogICAgVnJlZiBjYXBzOiBISVogNTAgR1JEIDgwIDEwMAogIFBpbiBE
ZWZhdWx0IDB4MDNhMTEwYzA6IFtKYWNrXSBNaWMgYXQgRXh0IExlZnQKICAgIENvbm4gPSAxLzgs
IENvbG9yID0gQmxhY2sKICAgIERlZkFzc29jaWF0aW9uID0gMHhjLCBTZXF1ZW5jZSA9IDB4MAog
IFBpbi1jdGxzOiAweDI0OiBJTiBWUkVGXzgwCiAgVW5zb2xpY2l0ZWQ6IHRhZz0wMiwgZW5hYmxl
ZD0xCiAgUG93ZXIgc3RhdGVzOiAgRDAgRDEgRDIgRDMgRVBTUwogIFBvd2VyOiBzZXR0aW5nPUQw
LCBhY3R1YWw9RDAKTm9kZSAweDFhIFtQaW4gQ29tcGxleF0gd2NhcHMgMHg0MDA0OGI6IFN0ZXJl
byBBbXAtSW4KICBBbXAtSW4gY2Fwczogb2ZzPTB4MDAsIG5zdGVwcz0weDAzLCBzdGVwc2l6ZT0w
eDI3LCBtdXRlPTAKICBBbXAtSW4gdmFsczogIFsweDAwIDB4MDBdCiAgUGluY2FwIDB4MDAwMDM3
MjQ6IElOIERldGVjdAogICAgVnJlZiBjYXBzOiBISVogNTAgR1JEIDgwIDEwMAogIFBpbiBEZWZh
dWx0IDB4NDExMTExZjA6IFtOL0FdIFNwZWFrZXIgYXQgRXh0IFJlYXIKICAgIENvbm4gPSAxLzgs
IENvbG9yID0gQmxhY2sKICAgIERlZkFzc29jaWF0aW9uID0gMHhmLCBTZXF1ZW5jZSA9IDB4MAog
ICAgTWlzYyA9IE5PX1BSRVNFTkNFCiAgUGluLWN0bHM6IDB4MDA6IFZSRUZfSElaCiAgVW5zb2xp
Y2l0ZWQ6IHRhZz0wMCwgZW5hYmxlZD0wCiAgUG93ZXIgc3RhdGVzOiAgRDAgRDEgRDIgRDMgRVBT
UwogIFBvd2VyOiBzZXR0aW5nPUQwLCBhY3R1YWw9RDAKTm9kZSAweDFiIFtQaW4gQ29tcGxleF0g
d2NhcHMgMHg0MDA1OGY6IFN0ZXJlbyBBbXAtSW4gQW1wLU91dAogIEFtcC1JbiBjYXBzOiBvZnM9
MHgwMCwgbnN0ZXBzPTB4MDMsIHN0ZXBzaXplPTB4MjcsIG11dGU9MAogIEFtcC1JbiB2YWxzOiAg
WzB4MDAgMHgwMF0KICBBbXAtT3V0IGNhcHM6IG9mcz0weDAwLCBuc3RlcHM9MHgwMCwgc3RlcHNp
emU9MHgwMCwgbXV0ZT0xCiAgQW1wLU91dCB2YWxzOiAgWzB4ODAgMHg4MF0KICBQaW5jYXAgMHgw
MDAxMzczNDogSU4gT1VUIEVBUEQgRGV0ZWN0CiAgICBWcmVmIGNhcHM6IEhJWiA1MCBHUkQgODAg
MTAwCiAgRUFQRCAweDI6IEVBUEQKICBQaW4gRGVmYXVsdCAweDQxMTExMWYwOiBbTi9BXSBTcGVh
a2VyIGF0IEV4dCBSZWFyCiAgICBDb25uID0gMS84LCBDb2xvciA9IEJsYWNrCiAgICBEZWZBc3Nv
Y2lhdGlvbiA9IDB4ZiwgU2VxdWVuY2UgPSAweDAKICAgIE1pc2MgPSBOT19QUkVTRU5DRQogIFBp
bi1jdGxzOiAweDAwOiBWUkVGX0hJWgogIFVuc29saWNpdGVkOiB0YWc9MDAsIGVuYWJsZWQ9MAog
IFBvd2VyIHN0YXRlczogIEQwIEQxIEQyIEQzIEVQU1MKICBQb3dlcjogc2V0dGluZz1EMCwgYWN0
dWFsPUQwCiAgQ29ubmVjdGlvbjogMgogICAgIDB4MDIqIDB4MDMKTm9kZSAweDFjIFtWZW5kb3Ig
RGVmaW5lZCBXaWRnZXRdIHdjYXBzIDB4ZjAwMDAwOiBNb25vCk5vZGUgMHgxZCBbUGluIENvbXBs
ZXhdIHdjYXBzIDB4NDAwNDAwOiBNb25vCiAgUGluY2FwIDB4MDAwMDAwMjA6IElOCiAgUGluIERl
ZmF1bHQgMHg0MDYwMDAwMTogW04vQV0gTW9kZW0gTGluZSBhdCBFeHQgTi9BCiAgICBDb25uID0g
VW5rbm93biwgQ29sb3IgPSBVbmtub3duCiAgICBEZWZBc3NvY2lhdGlvbiA9IDB4MCwgU2VxdWVu
Y2UgPSAweDEKICBQaW4tY3RsczogMHgyMDogSU4KICBQb3dlciBzdGF0ZXM6ICBEMCBEMSBEMiBE
MyBFUFNTCiAgUG93ZXI6IHNldHRpbmc9RDAsIGFjdHVhbD1EMApOb2RlIDB4MWUgW1BpbiBDb21w
bGV4XSB3Y2FwcyAweDQwMDUwMTogU3RlcmVvCiAgUGluY2FwIDB4MDAwMDAwMTA6IE9VVAogIFBp
biBEZWZhdWx0IDB4NDExMTExZjA6IFtOL0FdIFNwZWFrZXIgYXQgRXh0IFJlYXIKICAgIENvbm4g
PSAxLzgsIENvbG9yID0gQmxhY2sKICAgIERlZkFzc29jaWF0aW9uID0gMHhmLCBTZXF1ZW5jZSA9
IDB4MAogICAgTWlzYyA9IE5PX1BSRVNFTkNFCiAgUGluLWN0bHM6IDB4NDA6IE9VVAogIFBvd2Vy
IHN0YXRlczogIEQwIEQxIEQyIEQzIEVQU1MKICBQb3dlcjogc2V0dGluZz1EMCwgYWN0dWFsPUQw
CiAgQ29ubmVjdGlvbjogMQogICAgIDB4MDYKTm9kZSAweDFmIFtWZW5kb3IgRGVmaW5lZCBXaWRn
ZXRdIHdjYXBzIDB4ZjAwMDAwOiBNb25vCk5vZGUgMHgyMCBbVmVuZG9yIERlZmluZWQgV2lkZ2V0
XSB3Y2FwcyAweGYwMDA0MDogTW9ubwogIFByb2Nlc3NpbmcgY2FwczogYmVuaWduPTAsIG5jb2Vm
Zj0xNDIKTm9kZSAweDIxIFtQaW4gQ29tcGxleF0gd2NhcHMgMHg0MDA1OGQ6IFN0ZXJlbyBBbXAt
T3V0CiAgQ29udHJvbDogbmFtZT0iSGVhZHBob25lIFBsYXliYWNrIFN3aXRjaCIsIGluZGV4PTAs
IGRldmljZT0wCiAgICBDb250cm9sQW1wOiBjaHM9MywgZGlyPU91dCwgaWR4PTAsIG9mcz0wCiAg
QW1wLU91dCBjYXBzOiBvZnM9MHgwMCwgbnN0ZXBzPTB4MDAsIHN0ZXBzaXplPTB4MDAsIG11dGU9
MQogIEFtcC1PdXQgdmFsczogIFsweDgwIDB4ODBdCiAgUGluY2FwIDB4MDAwMTAwMWM6IE9VVCBI
UCBFQVBEIERldGVjdAogIEVBUEQgMHgyOiBFQVBECiAgUGluIERlZmF1bHQgMHgwMzIxMTAyMDog
W0phY2tdIEhQIE91dCBhdCBFeHQgTGVmdAogICAgQ29ubiA9IDEvOCwgQ29sb3IgPSBCbGFjawog
ICAgRGVmQXNzb2NpYXRpb24gPSAweDIsIFNlcXVlbmNlID0gMHgwCiAgUGluLWN0bHM6IDB4YzA6
IE9VVCBIUAogIFVuc29saWNpdGVkOiB0YWc9MDEsIGVuYWJsZWQ9MQogIFBvd2VyIHN0YXRlczog
IEQwIEQxIEQyIEQzIEVQU1MKICBQb3dlcjogc2V0dGluZz1EMCwgYWN0dWFsPUQwCiAgQ29ubmVj
dGlvbjogMgogICAgIDB4MDIgMHgwMyoKTm9kZSAweDIyIFtBdWRpbyBNaXhlcl0gd2NhcHMgMHgy
MDAxMGI6IFN0ZXJlbyBBbXAtSW4KICBBbXAtSW4gY2Fwczogb2ZzPTB4MDAsIG5zdGVwcz0weDAw
LCBzdGVwc2l6ZT0weDAwLCBtdXRlPTEKICBBbXAtSW4gdmFsczogIFsweDgwIDB4ODBdIFsweDgw
IDB4ODBdIFsweDgwIDB4ODBdIFsweDgwIDB4ODBdIFsweDgwIDB4ODBdCiAgQ29ubmVjdGlvbjog
NQogICAgIDB4MTkgMHgxYSAweDFiIDB4MWQgMHgxMwpOb2RlIDB4MjMgW0F1ZGlvIE1peGVyXSB3
Y2FwcyAweDIwMDEwYjogU3RlcmVvIEFtcC1JbgogIEFtcC1JbiBjYXBzOiBvZnM9MHgwMCwgbnN0
ZXBzPTB4MDAsIHN0ZXBzaXplPTB4MDAsIG11dGU9MQogIEFtcC1JbiB2YWxzOiAgWzB4MDAgMHgw
MF0gWzB4ODAgMHg4MF0gWzB4ODAgMHg4MF0gWzB4ODAgMHg4MF0gWzB4ODAgMHg4MF0KICBDb25u
ZWN0aW9uOiA1CiAgICAgMHgxOSAweDFhIDB4MWIgMHgxZCAweDEyCk5vZGUgMHgyNCBbQXVkaW8g
U2VsZWN0b3JdIHdjYXBzIDB4MzAwMTAxOiBTdGVyZW8KICBDb25uZWN0aW9uOiAzCiAgICAgMHgx
MiogMHgxMyAweDE4Ck5vZGUgMHgyNSBbQXVkaW8gU2VsZWN0b3JdIHdjYXBzIDB4MzAwMTAxOiBT
dGVyZW8KICBDb25uZWN0aW9uOiAyCiAgICAgMHgxMiogMHgxMwo=

--_004_AS8P250MB0887C48FD62B9F2A5B882565F41F2AS8P250MB0887EURP_--
