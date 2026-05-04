Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF89CFF885A
	for <alsa-devel@archiver.kernel.org>; Tue,  5 May 2026 13:12:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 176AD60204;
	Tue,  5 May 2026 15:12:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 176AD60204
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1777986765;
	bh=on6woJ6iHwqbVZk+EyKSIbHS85Y0y6vpRnvffkI/TGA=;
	h=From:To:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=YhUpvL4rw+amdIOowcg88ANaTinlR6m0fMTzL2t4vOn1wvZ2oYFPrBHANNAtgOeUz
	 1bQUEojlDZbJh0JEag0ah6yBxDQvjcp7Y3Ihb+mPpVJCgEm6lilIjFYLlo4vUw7zQp
	 sKjlWzBwkwARdkRkyImsAZMzFqMIy/I7S2srV9Lg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8291EF80510; Tue,  5 May 2026 15:12:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E8733F805F4;
	Tue,  5 May 2026 15:12:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EEB04F8021D; Mon,  4 May 2026 23:10:17 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012022.outbound.protection.outlook.com [52.101.66.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 18663F800BD
	for <alsa-devel@alsa-project.org>; Mon,  4 May 2026 23:10:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 18663F800BD
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=s1ccI58X
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4l84VEHmO2y2u99mxzeO3yUerGaXBDV6PSFppr7uQuFj3pntVlUphGYoVo1X2kJ25x93D2OfuMNHPyZvxX1wQ7+7/oHQTiLc83E4poJjhxExFquLR0r/SdKr9D2pANLqqy4QQ7HVtItqPfBjApJT/bZKnM8n72UyMffae5ftKIB52XfBbqYOZqszDkZ2KYZblpc9TPP/AdL2VGTXIx3xpDprWrhFI+uFeWMa+da+gXpkLGpI8UP1KOCwj2iCseO9rbsTCZwySQmBxFCdpfWgPY/M3haKd4OO+AT6CQFkmeZjv6GRfcPM65BEVbAImsdBbCy6mX/UCdOrJxhhINH4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuPfHGTIbTtJuIaiWjlTHxLtd+WOoud42GzLm5KO8oY=;
 b=wncUELeEqQzG9+JI47sACX5yVPr4dLIBvdO5r5102AIBHv2oZeHYBfNu1Iul+GHoZGAj/fC69+5KKjM8/Yf002vlKLbbwjd1ZhsfMpyEM7upgTF7t9WAgSHBIVlq/vQt0W1OexpvJ/TT2Xrm6Eylylz1wgLJgHwtsWmx4nkBrqCrRUMkunap5mNLAa/LwzOQCgwYzwMI6WepKlX6uyhkAEysVKp6jG+ABP4oNI+1MOyKazfFNk7oqAUc1uy+sliyDgLtiK+SDMjnacw32i8ka1aomoFs/2nM9T2GrL9ifWEHYkGQYTtKyszDJqG/ympzaUzBg201j2ppWxUi2hK0mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuPfHGTIbTtJuIaiWjlTHxLtd+WOoud42GzLm5KO8oY=;
 b=s1ccI58X40bNzCKXwzlb1MnIJA0DwDyxWg8Hxa8lcUAMK6k2v48xvgCZ4t3NLkl123XYC1xDJMeYx59sORRdz0RJl7vzW3GGm0hk/DknW2ky0Y7nl5c4otQ4VFI0Y/a4Lbu8/7lFyLisEoPvv/c+iewbu9yTcIrOxDx0fUN4t6YX4EqZSreIDlIAnQWJ5r+0al4uaHYL8862ltWD+4XKqhyhb7BqR+LOOiobrOALmPLrSJqzsG0wIOWP7EZ+D32VzYerW6h9ZlvCIjyeywEDGEGBI9Ef8pao4UqSdaKdhY0jVFS869KP/g0t4atGCVLPeMF9OcZq13szsw3+qZfYMQ==
Received: from AM8PR10MB4145.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1c8::17)
 by DB8PR10MB3546.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 21:10:13 +0000
Received: from AM8PR10MB4145.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8659:baa9:a13b:e398]) by AM8PR10MB4145.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8659:baa9:a13b:e398%6]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 21:10:13 +0000
From: "Kahraman, Erdem" <erdem.kahraman@siemens.com>
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: [BUG] HP ZBook Fury G1i (subsystem 0x103c8de8): ALC1308 right speaker
 not working
Thread-Topic: [BUG] HP ZBook Fury G1i (subsystem 0x103c8de8): ALC1308 right
 speaker not working
Thread-Index: AQHc3AozpHcgrTEVlUqOTCFHXrNRHQ==
Date: Mon, 4 May 2026 21:10:13 +0000
Message-ID: 
 <AM8PR10MB4145665401509CC89BFF354499312@AM8PR10MB4145.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: tr-TR, en-US
Content-Language: tr-TR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=True;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-05-04T21:10:12.884Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=C1
 -
 Restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=1;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR10MB4145:EE_|DB8PR10MB3546:EE_
x-ms-office365-filtering-correlation-id: 28e4e729-9008-485d-b103-08deaa21885e
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|31052699007|1800799024|376014|39142699007|8096899003|18002099003|56012099003|55112099003|38070700021;
x-microsoft-antispam-message-info: 
 UIEl9iLHAC3J8LhP7LABzcnHjnqi5DgkM2CwgnlV5TxWdMasSuRkEVsIYkkO6wzcxeE4qr1adBoOVY7/vN0tb+XWvlPbAegPgQf3/gKblpmpTGxP3Fu0Na3UijwvGSwA78fuk008xM3qT77IurpdybohoFHPvv1aFRtu/KK4Ep6gRL9rPOcjyvL4Sz4m0osfg8Xwmyc5zmeybxS0OGtRnsz6fYeBsx9CLOfr3+bXG5X2IaUc3FEDgFKUCQD7PvfuQguacP+eMzmJtF3+JMwbQjeFp2HU3kssHbtJUqpm6MjX7DYPgil6wChuDfCOqAh1iqmUIUxuG/G6c2DNfil2bhI8+0wnJqrdkK3cZimlWeAkQsi4KnK2zNWOjWV/IpstY6AF005piCmlAHwINsYAeAMTy/XkiDmD31LSKxrbAoip21NQbjakVz7fVjToWZKrMQOwPRLfoKYBzJ54bqRyYIC12E6TX1rfzq9o42Nll+wMH22uHH0zfDh1N9lWzBuZKLOC0hPJIAkN9dtSh6pyMpMxHwaC3+LvGOnLZojL4odBhyuQBoGCnbuRo1kBmGyvVGdTwUg35akpHSHlgAjXtHidmS9AT2pJ001tCThJHoIdUOFwVC3ZgBfe2FDSa5Yv1Z8ph8nRzoZcNyfIEOM/hg4cTuTmoa7NoLbHPA1hKD8jVgNv12Si3M/YP/idh3eAGg8tXbOtNsXFznYHqEBwVraBvySAp0xqT0LhRXHW/nwSnBJ8h5+qT1+FQroN0nLE
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR10MB4145.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(31052699007)(1800799024)(376014)(39142699007)(8096899003)(18002099003)(56012099003)(55112099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-9?Q?8UQgCxvzLdU+ZGlrmkdqI0M5TuTcLcOMq0CocEVW7OUud3OUzPxvzcze6D?=
 =?iso-8859-9?Q?ZGmXP0EZUkrhlU1woHMVQ/01KPR2h1bqW5WUswmn4+CbK8GK3dQjGu2ctg?=
 =?iso-8859-9?Q?9/GKl4dUfnsNtedHVGVSNRZbJhPrYcdHIeG6aEdC3sTt6zv3P/+NFFX0QH?=
 =?iso-8859-9?Q?epWISLKMQi0co4yRfBjuzkDzE69G+xgFNfnJhoopkcWvdqcy6guvB0ORCG?=
 =?iso-8859-9?Q?q6NbroZq34FmRfG4xar5bG/9dBU+4i+DoPf4vkXLxDHpitsh1AJyIgR+rp?=
 =?iso-8859-9?Q?na4t6UBE/WWcDmlaIrcorDqSlOxyC640imYPoOgvsKn5r55hHCWrRbYEsf?=
 =?iso-8859-9?Q?Y39nZzf8BUetJREjvdq0dzZz/vZN+3LYV9NQn+9EzEguVJcKCidCvQ0bWH?=
 =?iso-8859-9?Q?aZ6+K+tL7RkFmoXgEEtw+m5EWcn2vOycVGjQBcLm824MaMV52GKeiElLxZ?=
 =?iso-8859-9?Q?oEb5jZq6k/LLliPVj3IGBflZQqcddvkRW+7OfFv5pViN1GOs/6p45O5vCL?=
 =?iso-8859-9?Q?YBWBk5XTpbc/+3NbU/MxjGtMcexERYSeMmKWvcFMOFuw5JtAQQwejmtl2J?=
 =?iso-8859-9?Q?Em1T5G7XWM3/AhFi73YBi8VWHNS3VY5RUnhspvkcABxKDSr2ZqydQZsxFK?=
 =?iso-8859-9?Q?JlwNh75NgMhyvDAOdWtrFb0srVCZetJstA+dcB6AZp01IIATYOL+kFYg7B?=
 =?iso-8859-9?Q?TJxowUjAQJe9wHK0EDsXGWSSI71h1wnP5Vl+jocJHNru8DCvqAsgOAB0DU?=
 =?iso-8859-9?Q?ow5Ql4PP6jKVoYdAAQzwxyoBIt6XpVVgU5hlEYQowaxodosOP3aCMq1S//?=
 =?iso-8859-9?Q?OxUI/RB6DZx/NhGCNiM4kBIxOT169nWq6Ofi2TocHnfwus/X6hYi7d3Tsh?=
 =?iso-8859-9?Q?5nxcf4nLOFI6AgX++dLmyDCTd2Pd+8D8kv1/CHSmyRaL4+EgskkjoHa40W?=
 =?iso-8859-9?Q?+UAIoPR6c2RiL2TbhXVaLQKqxCB+2+BznXE/Mum9/we/DhuAyqcIIkIIUG?=
 =?iso-8859-9?Q?Lo2xdCUd6oq0Mb88771P7VvEE7f7Z2h9WIHjtd8NmfVO7KZL3fa8r/InEw?=
 =?iso-8859-9?Q?O+5J2/EHlxGn5YDjJEMzcJhGv6o9qjQUTMu2XXnzrGtcOjXZC9zy3vh2Pi?=
 =?iso-8859-9?Q?L1+kZJs273EtsXWpfawLwoRxosjnP9PXBR51dA/iXi+/TPksc4Xv4fCKPk?=
 =?iso-8859-9?Q?5AYKM6qpvOo2IdtAPDQfvWSJrP8Fq8qIB4RjpwXdgYSEH67HS/LQLCaGO3?=
 =?iso-8859-9?Q?lde1mWvX+KBaG+97vno4QbF9ZESWbYpU2GQkN5Ay3+1w+n748B5UPTO24N?=
 =?iso-8859-9?Q?z6Djo8Xr9/iejWpbK8yjHzrW6pq9barRLAgyDTkXBq4yon77AH5QRFlj5v?=
 =?iso-8859-9?Q?ZfGkEueuuuc7NL0OW14lUGmCm8q6XZy85RnMe2I/CsiVhtMuJ7UjNsmQ83?=
 =?iso-8859-9?Q?l3norrH0f9Ksm9+DFCMuoY04Dl5gIbuKLCiOm1TV/M9cF6z4mYqbP/YHcQ?=
 =?iso-8859-9?Q?rjlEA35u/AbyqsBP8Q2f8C+n0IOzmKR2nlJPT5iL/fYZzSiZEYMst7hFKx?=
 =?iso-8859-9?Q?aXZZilWpUUaR2ZUzTHe2YTESjxd2BZ0VznV2E6xTrSul+Boi14+RYyX2m1?=
 =?iso-8859-9?Q?OlzlkIYBJ9VlU5vLtmFUNJkq/5VKr3ekYmuyCimYaIQerA6kgQeSJOfIQm?=
 =?iso-8859-9?Q?nV6iuSeY8ICKrPaiF9qtgjiw9bKDX/MEsRGYEJnF/uQORtMIvOcl8PG19Y?=
 =?iso-8859-9?Q?Nh1tkSd9IwS0cw4iBiuE5qJGYZZIgK9WSnznmdzpSmN/VT8kxKrQzptZr9?=
 =?iso-8859-9?Q?lIItiiwVWA=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR10MB4145.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 28e4e729-9008-485d-b103-08deaa21885e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 21:10:13.0519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 1P4HuEcvQzKdK2SZX1BmSqYMfuxnvaTZnNMvh9bBEGRVzD1WFqiMWgqsEVWGnwPG2Pnsick/GN4QKzqtAeLyAXL0eKIPYd1XiCx5Ho3xRBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3546
X-MailFrom: erdem.kahraman@siemens.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 5SLBWOU7JCKV5IA6NZ5HIYQDUXUXLWR2
X-Message-ID-Hash: 5SLBWOU7JCKV5IA6NZ5HIYQDUXUXLWR2
X-Mailman-Approved-At: Tue, 05 May 2026 13:12:04 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-9"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Z3HE46BYPA52HAJYGECIL3W64H7EXLE7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

I have an HP ZBook Fury G1i 16" and the right internal speaker doesn't
work on Linux. Wanted to report it here since I think a quirk is missing.

Setup:
- Machine:   HP-HPZBookFuryG1i16inchMobileWorkstationPC-SBKPFV3-8DE2
- Codec:     Realtek ALC245 (Subsystem ID: 0x103c8de8)
- Kernel:    6.12.74+deb13+1-amd64
- SOF tplg:  intel/sof-ace-tplg/sof-hda-generic-2ch.tplg

So the left speaker works fine, but the right one is completely silent.
After some digging I found that the right speaker is driven by a separate
ALC1308 amplifier chip (ACPI: 10EC1308:00, path: \_SB_.PC02.I2C4.HDC1).
The snd_soc_rt1308.ko module is there and the ACPI alias matches
(acpi*:10EC1308:*), but the device never gets probed - no driver binding
at all.

>From dmesg:
  snd_hda_codec_realtek ehdaudio0D0: autoconfig for ALC245:
    line_outs=3D1 (0x17/0x0/0x0/0x0/0x0) type:speaker
    speaker_outs=3D0

Looks like there's no glue code connecting the ALC1308 to the HDA
pipeline for this subsystem ID. I saw that similar things were done for
CS35L41 on other HP machines, so maybe the same approach would work here
with a quirk in patch_realtek.c for 0x103c8de8?

Happy to test anything if that helps.

Thanks
