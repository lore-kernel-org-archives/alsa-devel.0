Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC8C606A321
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=Ly6BGc2D;
	dkim=pass (2048-bit key, unprotected) header.d=OUTLOOK.DE header.i=@OUTLOOK.DE header.a=rsa-sha256 header.s=selector1 header.b=pvqpk+za
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BB4386022B;
	Mon,  9 Nov 2026 16:00:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BB4386022B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794236462;
	bh=ZfLtgMechoVo01ORtC8BwXY39MKQqH/k4RI5S6XTRhc=;
	h=From:To:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Ly6BGc2DYUchBMvVIaJtNYSDJb0FYEZNBK/moRIwIK4qVFXmQuBM+NQMT+Dj7CH+g
	 IK+zTBGmUpzy6aF81mqsMrUxZ9FOtFGP70cb9Imp/idrD496QODTZ8QCatF7gEHvra
	 1hyjSrHValtSVF7K4+Mjx7bwfuKwGTAxOtFWwLB0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 47CAAF80690; Mon,  9 Nov 2026 15:59:46 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 61A3DF80684;
	Mon,  9 Nov 2026 15:59:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5B28EF805AA; Wed,  4 Nov 2026 22:15:12 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.46.76
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1793826911;
	b=TT0bYINXgJmJR4kQ4mdMkbPM9J2Pwilobyc/psawRBC43yuN6StY9FWI/I12k/D9YObK
	 5gjnLxnHEISGKLjE1PtFQ0splMUK5Qm6RrOVuuu56v+H6GOgQ6uvuOidbMdmDq+i5+9by
	 MlWxxdTQBd3XSp9ChbgbR8x4gjJrZNrdxrU1Xi1gMCFVvGp/EsES22qQ9A6pazD3ObzYx
	 dXQxRLhbEbMazPzgeRMq80Ebq1PN7xcFVY5+l6MbZPkljRT0HqxVXPyiChN4jy/ZHE2tu
	 Z5ljqn5vU8zvNOfSEscpEnZ7Cw/Grq6KpIv0AdoszLo6/bqLLuSEzkU6CPsqeSx+H4A==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793826911;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ZfLtgMechoVo01ORtC8BwXY39MKQqH/k4RI5S6XTRhc=;
	b=U6JvhpvcGxNIXYx6qmjS5uDDTFOYLWvfg+QPIHyGf/r/XPm/15TN5mZKTaWmeDB4IIkS
	 ZAiOL/5Kno1hzkLjpJf0N3gMFtREO5r4YJ2gukk9G8fpOGIdCHUFaKPYHHwFLsQoeycQX
	 JgNBQbZxAkxAT3cZb+LoPVQhXBavU3imDzW2Gs1/atT+Nv/Pgmp2XlwfLByP55jTU3adC
	 kn7QinqQD1V7p9xGTSsUnOMBrtFmcj89QNaOHSs4ahPuwup20EvEBR3EuaXmzjq9BKng4
	 VB8genGuHJFkwRrTFb4jwviP85IKZoiBMR41arh3hea7JYieqx6s8nolJeqpmsKLRHg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
	dkim=pass header.d=OUTLOOK.DE header.i=@OUTLOOK.DE header.a=rsa-sha256
 header.s=selector1 header.b=pvqpk+za;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.46.76
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazolkn19013076.outbound.protection.outlook.com
 [52.103.46.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0578AF800E4
	for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2026 22:15:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0578AF800E4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=OUTLOOK.DE header.i=@OUTLOOK.DE header.a=rsa-sha256
 header.s=selector1 header.b=pvqpk+za
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ld3CM9iAdGUVzogE34JyfHaxcxvslEn/onpF5advQgCrxjjdLfeEcQydb5LUOBGiCxy06jecC4f8Yh7MkuiuAhADQtNF05l5juc8GA18k4+PuU4mA1QUGztdxirz6hDMvya4D8K1Yu1LhpvDrQ4pDbJq+c1MKhJps6V0TTYYQOqPW69J92sqJ8Avaa/wz/nAbH+uzmAWPvJbgKXrD/KWSMqXEGXM2O91UWW5leNzX2D6wqR8wsfYl3gsE/2XSWwIZOPMEbjX/uB0r3ntgqex/Tp857HASGWrq9BcNmHr8lVMm8K1PbvI9yb6iL2y8n3O9Hiyp5WnjEciVsFYf603sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfLtgMechoVo01ORtC8BwXY39MKQqH/k4RI5S6XTRhc=;
 b=gW/rbuDjgeC7ZB1DRQUE4+ZYAHql+Wf+9ztcMWysHpxqOktxqIlFtH/+Ma9FYOJ1HwjxsrLJ6hFLiyZ3BDrewix60Ponqk3tSfg3Jz6qKC1AjLz8/k2Zs42FT16IXnL7ZfBNo9GyIP9AvxePaHW8ZvhlFnGJsw6kRaKR7GTGzZUyxnifxNIJ3j5/KQ6gtyBbjAP+xDYJD4BDtNRoqNtMjPt1lAC1VOlWycciq9RwsqKmoglbtgHwffNqyFg8TQkNgiyL9e8Pb75vv2OirkisbOWpLFJaFQzOSrC99oh7RL3UirYtaA0S284rCm6RwRPvlqnI+cOO3ORc4zzAv55CMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfLtgMechoVo01ORtC8BwXY39MKQqH/k4RI5S6XTRhc=;
 b=pvqpk+zaI+uFW9mvswfYaIT/QxIOD7ZwxszJ11qnURitFm7lJxfLfbLRv1lfen+ri5potkAVELmZgcncO1K8gwnpkf8KRLXb6oNu3tpIL6IVATmD9MR6qDjokf8C8OI+WSjp3kit3RyULo/yBmypnq+sDL4R+k/t1g3zBJL2Y+vxej6VrdCK0hVEc38mJKPSQD3km1VzK9t2j6gyTI0ozkefon8xakgVd481KqPomP9Vy6KmKVpvalP4la8cUjVEjhsVW+XWrqng0iVvtYKPCOCIbhANloSn7lKphGVgsbSnEcaCUTSSW12joipDXbWj//k0aOK6xIgnSSGjAcRJDg==
Received: from AM9PR01MB7284.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:2cd::9) by AS8PR01MB8729.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:44d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 21:15:08 +0000
Received: from AM9PR01MB7284.eurprd01.prod.exchangelabs.com
 ([fe80::e6a8:d03:ddbd:2bd9]) by AM9PR01MB7284.eurprd01.prod.exchangelabs.com
 ([fe80::e6a8:d03:ddbd:2bd9%6]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 21:15:07 +0000
From: golne tree <lrepper@outlook.de>
To: "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: ASoC: Intel: sof_es8336: internal analog mic on Gemini Lake laptop
 needs HEADSET_MIC1 quirk plus explicit mixer writes, no DMI match
Thread-Topic: ASoC: Intel: sof_es8336: internal analog mic on Gemini Lake
 laptop needs HEADSET_MIC1 quirk plus explicit mixer writes, no DMI match
Thread-Index: AQHdbJ/rKC5cu2nFOkm8SwcJqtYGwQ==
Date: Wed, 4 Nov 2026 21:15:07 +0000
Message-ID: 
 <AM9PR01MB728455EF755C5F80732FC8A1D0682@AM9PR01MB7284.eurprd01.prod.exchangelabs.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR01MB7284:EE_|AS8PR01MB8729:EE_
x-ms-office365-filtering-correlation-id: 312e02a5-35a0-4121-c276-08df3ab8b3cb
x-microsoft-antispam: 
 BCL:0;ARA:14566002|31061999003|15080799012|15030799006|19110799012|8060799015|39105399006|8062599012|41001999006|37102599003|25010399006|4140399003|45011099003|20031999006|3412199025|440099028|102099032|40105399003;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?211Q9Rk3UDDv23DGIRtcN2MtHA9C8Md7JGDUjIaqNsTFSy3UtKlbqs0v+T?=
 =?iso-8859-1?Q?suetHBCqytWjsLA+DtshDZJ6rgJkiF3Y65n7ng5xfrJHaIl9EFduEjPwmU?=
 =?iso-8859-1?Q?At9aeH3U85hza2oql+oYxejG4B/WRvDJT2nPnpKxk9b0Hce1PfN8ZpSoaw?=
 =?iso-8859-1?Q?uRf0eQ+tWH+Jo3RtgVZPuWfjcOEbx5zXsp5R2a9J0qGhgfnGIiw46ViJpM?=
 =?iso-8859-1?Q?PcVoExAGE/urSA4F1SwwblycnAmZq0w2HyolKZl/k3C+QoW/0zSe/KyLqd?=
 =?iso-8859-1?Q?pHBGvrxJldUDkRTBghCSaRO0XwzXLYm/VLEccMjRo2s4/Gx+U1OE7H4VRT?=
 =?iso-8859-1?Q?uu2/ho/Id8tnczwa6E6GCjEUBpLnfyXOyX0kj4Ed0vCsrWUpLiVubP2MBi?=
 =?iso-8859-1?Q?+Tz1xssKqghOPN2+Yx0vlOwnUKeIN1FBNyP12o6mU2KnlY0US5v6HB7rd3?=
 =?iso-8859-1?Q?IkQZk+Bk2m3ZFraNZOxLaT9ae9TN4WehByJrm8JAoFdvZcSHKs3PYiqKP+?=
 =?iso-8859-1?Q?GtEDz+S5n45iyKHOAsvJWTSJtPCjBSQjzIFaar34Ou3cF+AmtNav9deac8?=
 =?iso-8859-1?Q?SKSRu5a1N8B7fJlGJ+u5pqdotX3lktrWIbj6P6wOiDpuHKRQXFyHzsNzCr?=
 =?iso-8859-1?Q?JR5sXFFAABG2ei9j/LZByB3bkhHweks50z5vtpfU5HHAtaL67jvygJnlu+?=
 =?iso-8859-1?Q?XLri92l6Uv+y+5rpGc75QQYLgWmSIjZ1V5K3EdN+keC/Hi/AHBN2U+VwMn?=
 =?iso-8859-1?Q?NhD7IlKR7yeCSWenzOK3za3WhkAIAz19uHBUgnT8VPyhqJhz3D4IVoXl2X?=
 =?iso-8859-1?Q?g8dKGn5QPy9HWLAjFDpMKePAw0csVjnf0grWuNfNZSFtbDqWz0Z11HO5wj?=
 =?iso-8859-1?Q?PCiIX8nq+VgwvH7/+Ah7UMdcqlhVGmwqdwm3znsqo17eNxLxYsC9wbwaut?=
 =?iso-8859-1?Q?Jr3HWCbmUMLSRRQ+sgSGfxCRx13bRIiCtb/SRsMO8Hh+t+JxsmIFi05Wd7?=
 =?iso-8859-1?Q?6nALQ8+4toe3s+UyDhQvFqjsHY41bWW5/+wdcMwq4CKdRknOAAMdx3zftR?=
 =?iso-8859-1?Q?ceIP4vTID23d6x0Wp+xWtX70rJD3Rdp1Zum9dWb12+89?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?ognmglXUM0d1mzX40rn6zs9cO83MJZ/YSkXuGbR8JWD5FazrBMJ5aUizKr?=
 =?iso-8859-1?Q?Lbo5sMTzpEIR8ayf468u7jKxwRdYhLtNKF79psHvtAS5KCXjftDU4/JxK1?=
 =?iso-8859-1?Q?orWt/IaSVMVKWSyffUA3D9kKeva9FzBxXErJnABk4Pwc+Pbvnpvg37s520?=
 =?iso-8859-1?Q?kYGSO0y6hfqvPWxxFxM1SzmUaPEs6RiGUEfYwiwY+E5QiVOG6xf5mrmTBN?=
 =?iso-8859-1?Q?nizs4I4B3v9wyuXUC+QdcTcanNpEAIE7TF9RNCSnvKB6aubj3N5P5D3abL?=
 =?iso-8859-1?Q?dG5I9d9dmOm4Zd/3ulpuGw6gNltmlb18hnjVre23QoXId2HbeXUiYy0fHu?=
 =?iso-8859-1?Q?F6StEQhUq7pxe8g1BvDg8YifvITYjyRZwNAoKgZf/H/cdoSEigthWN5JLy?=
 =?iso-8859-1?Q?BbuJXMn16dLRrF6U/uG2em1JyFTy/l+g1+cSMZ8AqurdNaEsY6SyK4XHHD?=
 =?iso-8859-1?Q?O1GMJrfSobM0i/PP2YaiE0noWMgtUFrogChbfCXPDif131NrtgDdycW8Px?=
 =?iso-8859-1?Q?nKLQiY40IcRzmt8xLnqGoMpP0sJONhOg3FQi0oOvKsKXDZKEcl5py+/bEL?=
 =?iso-8859-1?Q?tTOOwFfTmj2QEqilw8jZQu05l42xfLs3vVfyx3cXb5S8ZDatJbkcdlpRzo?=
 =?iso-8859-1?Q?RmbXZuvuA3zCf4yQ3hyt7/pLMNfRrwglMGExSHpJEFj6PZ8C5Z1x68/9tY?=
 =?iso-8859-1?Q?ENFqZlTR5hM4zIkhNltKNyDz64IUqu169ys+GYXwOaakh4TeT4B3Flha9A?=
 =?iso-8859-1?Q?DzzfXh6QvwusqlkJHDQfdnLuON0ofIht+VZv1BAz0H4uoqURAUnyt6i0/1?=
 =?iso-8859-1?Q?Mgbl3hFp4izYSjO5/e/aqY/lmGCIQUGLZRopdnE9onAZlYDG/jz56/nCAV?=
 =?iso-8859-1?Q?6BO3A5J2g3NACT2GTodsXe12g9bktqgbQjVDXBX+lp/Y6C6V710/uW5F6V?=
 =?iso-8859-1?Q?4wtIk8A2/EB7aOI5wP0nYCnQZiBsSIVK410MukD0bIsUlBnaHEI+cTs/7C?=
 =?iso-8859-1?Q?QQPZsn6sHsxWpxex33/onEqExlDh8KanDLwk1DZ1JyYcgKsFMvEsg0cpkq?=
 =?iso-8859-1?Q?tX+3OGJ8FombqtOaKGoF667KLABaNoFbGBN8wBvyNmQO/lXYvfUjue0odS?=
 =?iso-8859-1?Q?yn7CaJiLoX8UYRx3eULQDdp8VtLpMYEqGoSwZpXw/IPmD1aOrVfZEUkKM+?=
 =?iso-8859-1?Q?CpY0avS2IJ6jWFftMegXHo+Mgvt4Y7pqyW15Uxa9GqZBUJRGCSK8fmWRI9?=
 =?iso-8859-1?Q?6+S+Vp9KjOA80jycFwAHZXLfi56m2mKV4bB/HB2KwNzEtGG7PH6lWbNoCm?=
 =?iso-8859-1?Q?4fithCbX/B4Jw/kWJlHIcg+qQuTpKSVX1aNaSGmdhJ1Af+gNL+Anpmbdqw?=
 =?iso-8859-1?Q?k6OyU01AjO0Il9f2jB8XntyngykvTkY3KEqDNkLRAvQegO0UrKPCIgKjtw?=
 =?iso-8859-1?Q?CS3W09lUmv3eOTFMhUhJScP1Pm3I8gkbgJSrJdvuy3oqDkfNm5rI4iHvlx?=
 =?iso-8859-1?Q?Y=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-d13a4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: 
 AM9PR01MB7284.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 312e02a5-35a0-4121-c276-08df3ab8b3cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 21:15:07.4749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 
 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR01MB8729
X-MailFrom: lrepper@outlook.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: GOKYWIX3HKAXD7BO2FY2LHA2DSAEKWWU
X-Message-ID-Hash: GOKYWIX3HKAXD7BO2FY2LHA2DSAEKWWU
X-Mailman-Approved-At: Mon, 09 Nov 2026 14:59:25 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VXWHNHZBB7DX6VRPHFQ3356QVSCGSKXU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

Hello,=0A=
I have a cheap OEM laptop (Denver brand) with an Intel Celeron N4020=0A=
and an ES8336 codec. The internal microphone does not work on Linux,=0A=
but it works on Windows with the vendor driver. I found a combination=0A=
that makes it work and would like to ask how this can be made=0A=
automatic for this board.=0A=
Hardware / software=0A=
Laptop: Denver (OEM). DMI system and baseboard fields are all=0A=
"Default string"=0A=
BIOS: American Megatrends, version string=0A=
"$(AMI_ROM_NAME)_T$(2021)$(03)$(12)$(18)$(44)" (looks like an=0A=
unfilled template, build around 2021-03)=0A=
CPU: Intel Celeron N4020, audio controller 8086:3198,=0A=
subsystem 02f3:f000=0A=
Kernel: 7.2.7-1-cachyos (CachyOS)=0A=
Driver: snd_soc_sof_es8336, card sof-essx8336=0A=
SOF firmware: intel/sof/sof-glk.ri=0A=
Topology: intel/sof-tplg/sof-glk-es8336-ssp2.tplg=0A=
ACPI: ESSX8336 on I2C2 (address 0x11) with one GpioIo (pin 29),=0A=
one GpioInt (pin 20) and a large _DSM method=0A=
dmesg: "DMICs detected in NHLT tables: 0"=0A=
Problem=0A=
The internal microphone records only noise or silence. A headset=0A=
microphone works.=0A=
Findings=0A=
With the default quirk mask (0x2, SSP2): Differential Mux=0A=
"lin1-rin1" gives noise only, the two "with 20db Boost" values=0A=
give digital silence. "lin2-rin2" gives a usable signal only if I=0A=
turn on "Headset Mic Switch" by hand.=0A=
So the internal mic seems to be wired to the MIC2 input=0A=
(lin2-rin2), which the driver reserves for the headset by default.=0A=
With the module option snd_soc_sof_es8336 quirk=3D0x102=0A=
(SSP2 | SOC_ES8336_HEADSET_MIC1), dmesg shows "quirk headset at=0A=
mic1 port enabled".=0A=
After a reboot with quirk=3D0x102 and no manual mixer commands, the=0A=
internal mic still records only silence, although reading the=0A=
controls back shows Internal Mic Switch =3D on, Headset Mic Switch =3D=0A=
off and Digital Mic Mux =3D 0. Writing only Differential Mux =3D 1=0A=
(lin2-rin2) did not help. After I write these four controls=0A=
explicitly with amixer cset, the internal mic works:=0A=
Differential Mux =3D 1 (lin2-rin2)=0A=
Headset Mic Switch =3D off=0A=
Internal Mic Switch =3D on=0A=
Digital Mic Mux =3D 0=0A=
I have not determined which single write is the decisive one, and=0A=
I do not know why the explicit write is needed when the values read=0A=
back as correct. To work around it I now run these commands from a=0A=
systemd user service after login.=0A=
Quirk 0x22 (DMIC) with the dmic2ch topology gives only digital=0A=
silence, which fits the missing DMIC in NHLT.=0A=
I have not yet tested the headset microphone with quirk 0x102.=0A=
Questions=0A=
Because all DMI fields are "Default string", I cannot see how a DMI=0A=
quirk could match this board. Is there another way to set=0A=
SOC_ES8336_HEADSET_MIC1 automatically (another DMI field, ACPI=0A=
data, the _DSM method)?=0A=
Should the UCM profile for sof-essx8336 write these controls when=0A=
the internal mic is enabled, and is it expected that the values=0A=
read back correctly but the path stays inactive until they are=0A=
written?=0A=
I can provide the DSDT, alsa-info output and more logs, and I can=0A=
test patches on this machine.=0A=
Best regards,=0A=
Goldi Tree=
