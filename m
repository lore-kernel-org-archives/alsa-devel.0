Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5108ACDB475
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:43:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A23E360210;
	Mon, 22 Jun 2026 09:43:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A23E360210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782114193;
	bh=FGKrOmJs6BaOA2OH73fEwk1tky2M5u406DCN9NyAhTM=;
	h=From:To:Subject:Date:References:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=p+Sd5O5M5XQfBJ+AxZ48D9zwyS2F4nczRj+BgsG2UiKdDsqiBxVXgql+XuUhOjyxL
	 GUQTk1mp7NUyDQ28giGbZdBkK29ZHgECTIydRrJvcAU5zA1mO6y/XnadhA0cRIPGQB
	 v+mCqcs+0QxgPF5btNqJdl1X+MfM/RJz/MbpwZ+E=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4B1F1F805FE; Mon, 22 Jun 2026 09:42:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7860DF805EC;
	Mon, 22 Jun 2026 09:42:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 01750F80301; Thu, 18 Jun 2026 01:11:45 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.38.37
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1781737905;
	b=HspLzQMTwTpjpNXPPPRgL+wcJULC24UhrRedLcCFzXNnMTMS9LaoEhu1DBvnjoqgFYTN
	 pFUCtNqRSgS9iRxXyIlD9q35RSu5/S7xZTjvyqDBvbyZutkeC8iuyCdFYzQonfkHdC1Vw
	 K9cgD4FOqOthVg7711V/kiO7ZCQmfsOC7tOOqSpJo9+BPqApU58P+w4N1ZMttgxQ6Jue6
	 WDJXDmKxZ0DWu9159OHA6CJcarsumPd5/r90e8itWtlLa0v690xH34CMhSrrgkPFZuq3t
	 2PJjNbU/n/e6Q9bpO9Yu3ffdmkrkv5a7sXpC8uvrFfSJzzUUvAIduoiLg5iNHgtx//Q==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781737905;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=FJ6diXs0+e1pG1fX3cecKQjhUJBZvscaM7/6wXqwe0Y=;
	b=TMAD3SoUci5Omlmwq6sKpWaSPHaDjdXbR0IALTnLsifyYvbJT2n1Oru+jcdWWj2npvjZ
	 mnkaxwODz3kzdEqLVpXjhVsGN72rvV702kdFmaH0e1pC7zWJ2ZT8FhObeSQpzVnSx7Jhh
	 Iml9Bd39OQvlzgQPl8gtDlRtyPCRq/HDq0UU7N9N1TWkKG9I5zBdXOQZtD4SwkCktfsg5
	 WOJ1Ezxbq2cjF3CTHF+H6gvMkDM0IVYDOg8NHLtLmKBSFemkpPEF/pmBTyCkO+bHmwf6R
	 hbk5e+I9ry72B0PDeHLpUKYsngnAEImL5uwSanQmnL2a5xDTq7sjYNnP2obbOUcjUwg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256
 header.s=selector1 header.b=jZy++kkt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.38.37
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazolkn19011037.outbound.protection.outlook.com [52.103.38.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E8D31F800BD
	for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2026 01:11:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E8D31F800BD
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256
 header.s=selector1 header.b=jZy++kkt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gaPQo0SndH+Xk6Zx1qo2fx4OkJaoUOWQJCcuTf0rhGGgcLcoNp2vzfAMoN7y/3/BWLj4TJN81uUsIp7IeLJ8j8v4JumxRIccaR7G3XH/QYt49um3g0ih9KVTT/JYPkQdUP9UjCXxhrG+nwJyu+8tFkrwgTfpXI5lqYBMM1S5t2vzcSnf4jwRZdu8NFXM1ZZ+aSQE14dz3EO5RwnIwf2ZMqN9xZjtx5ZKkYtIH7f+ohaSf0S7sRF2BD0gS2wFKqcVGHA6KExgeeLsj0utIOVCARSgLb9TA23npjLEmmhSrVEHoXcPN6o3kLSr24Xip+iigZYNgUe19DZKUwnKzgx47w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJ6diXs0+e1pG1fX3cecKQjhUJBZvscaM7/6wXqwe0Y=;
 b=sMO0T02++f7VL3s0YwKa7B8hkt97YLWQHmquWba/3cwIEW2+C0I7Nd+0juf5MAKS2K9zfGMYm+znzMsvzHRIWBb8R+3fJNb5nYMOD2cny7aG6GAvI/aZb2YfGZvUukgA4G9Dgz9P4excDqR/H+bQlPa8i/jZQFriR9He9pWVREqWd9XDzuwAwg9wt2nwRJAzYHQgMe8y8U2lLkfiG3gvWwX/fbl4qMDClaTpFbBJTZOqzuPLBKlZsst6bOdu8gMjbnaoM3HhXYP8vsEYsubHUUplSft2kSEfHnt6loTlxP2tX/t/I2mPQZWTFbQ46ynmNqQvNEMfJqCtM3VKKYlRgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJ6diXs0+e1pG1fX3cecKQjhUJBZvscaM7/6wXqwe0Y=;
 b=jZy++kktlcifiwFnIPl/AZ8jl8fMkKxxaCBO1NvHVIaTd4zTR+SkXJm3cG7eppqkUhYPQD7I6FiIA9aFJPsfunWsdtpe1CWR4O37qeCvZsJYVZCcYDIHYV/U9SRQrjku+cWosxcHvRb1ldLrh5M9ldU05kk64cHzVlnVaP+TmNKXi+MH5u1vNyex+KRBZ5lm16zVDcEapLDVHp1J4kpYkhjR3zA5JzrB+7was9x5O5vKjCDhKbg3qpRxiJl3e+5bwbbQtFnZnwQW5GXNnmeVJKnjLoNCkrlPcRnzN3vNPbTwBNBGb45qbeiXLFtR7kbEqdpxXKqmQOgcyde/WMBNhQ==
Received: from LO0P302MB0098.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:369::8)
 by LO9P302MB0455.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:3c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Wed, 17 Jun
 2026 23:11:41 +0000
Received: from LO0P302MB0098.GBRP302.PROD.OUTLOOK.COM
 ([fe80::982f:4a82:7ea2:c44b]) by LO0P302MB0098.GBRP302.PROD.OUTLOOK.COM
 ([fe80::982f:4a82:7ea2:c44b%6]) with mapi id 15.21.0139.011; Wed, 17 Jun 2026
 23:11:41 +0000
From: NA NA <realgamehacker@hotmail.com>
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
Subject: Creative Sound Blaster AE9 Linux Support 
Thread-Topic: Creative Sound Blaster AE9 Linux Support 
Thread-Index: AQHc/lavvarYmQt5IUeFGq2u7D+0u7ZDYE68
Date: Wed, 17 Jun 2026 23:11:41 +0000
Message-ID: 
 <LO0P302MB009821B945A1E78DB2BE6281CDE42@LO0P302MB0098.GBRP302.PROD.OUTLOOK.COM>
References: 
 <LO2P302MB0105F8CF5B3A084E484021F7CDE42@LO2P302MB0105.GBRP302.PROD.OUTLOOK.COM>
In-Reply-To: 
 <LO2P302MB0105F8CF5B3A084E484021F7CDE42@LO2P302MB0105.GBRP302.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P302MB0098:EE_|LO9P302MB0455:EE_
x-ms-office365-filtering-correlation-id: bca23f04-f405-4980-ae63-08deccc5ca8f
x-microsoft-antispam: 
 BCL:0;ARA:14566002|24021099003|37011999003|15080799012|15030799006|19110799012|8062599012|8060799015|31061999003|102099032|440099028|3412199025|52005399003|40105399003;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?zcHiyF4SjbNbw+YBvbOwfl0+LC3PVL7GSfNFilg4SvHRm9QzDsKZ1kAZrJ?=
 =?iso-8859-1?Q?CyL4gM0rOuZLPoXgZjLspC8KbF0PWB7edVon7bI80CHX32MykjNfHRFyhs?=
 =?iso-8859-1?Q?GF/FLdssQoscoGMSWsJPW/e9ALXvOAWpRw8IYPGHy/hA3aoa7u5fsFLhvN?=
 =?iso-8859-1?Q?s0zfEvokiybTXVZJCzTB/paNJK+IkGfiesdQW7ziiBDEYoLTLVTRSXCbTj?=
 =?iso-8859-1?Q?trR1PlQa2zRHZlPkIWL4ZDxVDyzn7pNwLg0bVmd1fkp2tvSRNNQob2I8X8?=
 =?iso-8859-1?Q?emLniYlaBTlZxDKQxrjkcW8ZZKm04HkLaHoSg8iRsbq4FHWXV7P8MYJvRh?=
 =?iso-8859-1?Q?Ywh2i2HD1wSgtz7rtT4ebzgyPdvNcioGNgbctqZz+7UI40KuLWKqKfpdPI?=
 =?iso-8859-1?Q?eaxGU4QLEf3hWHOJQ/lY08W5dfO0G5YbQ4LbAKHjAI7cavLQvGmV6cf8k0?=
 =?iso-8859-1?Q?sONzJe8bWLQahTAhzMtAObv3hENIujq3Jj/FoN6AudkB87YRycSR0qSlQW?=
 =?iso-8859-1?Q?2+a2acSNudnVlOKz9wMzFhY1IDjrUNxyYoQo72NRzvinHLjikV7Zvng4+F?=
 =?iso-8859-1?Q?NIImApZTtfwlu/FArgpkejNLTrhZsEhFH9Olb9/q1u2m6axG5jfId890o5?=
 =?iso-8859-1?Q?r81sFgVqQEgNg5jK7X+sm7l08ROWDAgsFlft+CMQ7lED/5q3X4EJlmxAnU?=
 =?iso-8859-1?Q?PVKeEQZsigH6rSlcVyLmx/bm5iS1oTf3LEtEfS7kjvO0AgsNHp39wqyUnc?=
 =?iso-8859-1?Q?CH2/TyGZbpWuTmzilv2rK61wh430Ja2hwMmRBgtTBbVhtVI86qkXO/9elD?=
 =?iso-8859-1?Q?peI7XIs2vMg9fB17NaaD1DNWyaAgY55tB++Ig9W0xQPAFeOCdoVKq/KLd9?=
 =?iso-8859-1?Q?yiCGJwxPEhSRui0SNgqic4MDs02aQLjBuIryNoJNTYOs2skCySpWK2RUJ6?=
 =?iso-8859-1?Q?iKRnHnFtEJbdHZo4h3KxCD3RGjQDYK13NImZwI11hxcYGk5cFE4rk7WJW4?=
 =?iso-8859-1?Q?3oCPk9C7kD46RwDyMS+zO4ESVFBu4Lg+UIsZlq?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?cePjcHoGvv3X2IlULa77FAkVni0j5N81zThRMmdOxRxwlcdb5dG6yPHlPm?=
 =?iso-8859-1?Q?+TaiJRD01dPs9MPYzssKxPIgy5mLdfIbjnVE49bfnn8cEVcYek89oPAWon?=
 =?iso-8859-1?Q?uYun/73IIt1NNihU1wcV9y8OxhyN1Flb4DHL8PWlyRT7VhiPwT+3CqESPL?=
 =?iso-8859-1?Q?Cz0lRK+xQlKr8LpOI2ivdMj6GD76dYI7xT7PR4miGifTE0Luet1m6mGxCm?=
 =?iso-8859-1?Q?9RM3PJV70y+jgvQ0pRAeZBaQsMQgNm6eXuoJhEUpk3Y+HmNhmGKtO2CJSl?=
 =?iso-8859-1?Q?prnNvn4Jl2otyLQDeUUApntwPUponFH/xfK9L/oFMtat9Q2h3XNRzBrY5U?=
 =?iso-8859-1?Q?BlWnFAcfq4Kd3o0AMy2gwrYU9xU9KG86xJGfMlvhdhq9pqrfWAPioGAgA3?=
 =?iso-8859-1?Q?412LLymuegFUNTqbTikBMUykPxzAmGcxfpcHGyHFBK3e8rMFVwLaS91WEg?=
 =?iso-8859-1?Q?02Xw5wqI67HXsevP9pAZdGGiR9b2IXXluQX/QzuBAF/8JwyJ56hqb6403q?=
 =?iso-8859-1?Q?6b3anfyJu+w0PQr2QoEB4ifGcu8aZCcIZaQH1hQrGmrKb1e0FVisrBy9Hs?=
 =?iso-8859-1?Q?ll/nEMslnYxZQk3dk2YufhjrZtOQQ0Yxfc9jtB/iBiUpUpTe0AAKX/omUA?=
 =?iso-8859-1?Q?8Pe3jhu2GagS5su/gkDFU0v1ISCyDwv+Wr+tJWqAXWy6N/IFRgEItl51Hw?=
 =?iso-8859-1?Q?gLgS2KYLk1lkLwqPnwbudJhwuw1kdlYra4+UDR81yaVFhXzAuq2KxHUD63?=
 =?iso-8859-1?Q?UFpmdPQU3PfFADwvsz/bR3+8mCZIHHIO5WO2ceFFVjSt1nPYOe7eeoIVjv?=
 =?iso-8859-1?Q?kniEpq5LUiY/CooMoeO56JKo1kHHMeI2YXOIa/GnD7cT7p5tga7grEWFWX?=
 =?iso-8859-1?Q?COsS2hGW8VGxV4nEPCYj9Os0sqlBiNQd9h2p1kBgDLiK5XGF7hi1PXQ5jh?=
 =?iso-8859-1?Q?ysSi8XM0HdwupSQq6OpedYgSFqHM0OXKITOk3avu3iYPhVNthBtxTChj6s?=
 =?iso-8859-1?Q?4mL4HPzJJfw3Qqm8688v68PIU2hrFLaezY+osMpFP2BT3z7fNgRT5Z9UTY?=
 =?iso-8859-1?Q?fL0B7sy15MJ4brqFUrkBCOfrBpbSS327iqqK26XV/nGfzLsJcteLnD7BAZ?=
 =?iso-8859-1?Q?+rr1fCRIK8KSk1vKWK/TVCE++OzJUiLEDqpJ2qfYEcdfZOCn9mR3ZRkEMu?=
 =?iso-8859-1?Q?CPQxM8lWnfYcdCzWHAopjVe0gIJZunjYFFjOA0vpmB4ca2beTQwdhQOfjW?=
 =?iso-8859-1?Q?D5ps3pjYSsDgCJrEx3SpjfxBI/EdYVgqzqNK5SJNxVFK9/VLW3kFlFHd23?=
 =?iso-8859-1?Q?tFgxX5Jnjfnk4FIpLF13hy2gM5aZ54D4YIlYlypJUvVx0kyilX1oyfsc5H?=
 =?iso-8859-1?Q?s7ll7kGc2VfjAKHEjlqggnpb/QgqLHFLhx0yA5X896+hlEn3Y1g3LmaF5u?=
 =?iso-8859-1?Q?uJURlkAANfcFDiy4?=
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-644ca.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P302MB0098.GBRP302.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 bca23f04-f405-4980-ae63-08deccc5ca8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 23:11:41.1993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 
 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P302MB0455
X-MailFrom: realgamehacker@hotmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: NNBBPC37Z34XATPMHGP35ENL77BNOPJK
X-Message-ID-Hash: NNBBPC37Z34XATPMHGP35ENL77BNOPJK
X-Mailman-Approved-At: Mon, 22 Jun 2026 07:42:31 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JETTATPFYNU6JUEU6CIGWD5JR65ACUBH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Please contact the Linux Kernal\Audio team to get support for the Creative =
Sound Blaster AE9 added to the Linux Kernal so I can finely move to Linux, =
As it is right now, No Linux distro can even boot, everyone of them boot lo=
ops with the sound card in the system.
If a dev reads this who can add support and needs some kernel panic crash l=
ogs message me back how to get them without removing the sound card from th=
e system or getting to the desktop,
I'm more than happy to help with that

