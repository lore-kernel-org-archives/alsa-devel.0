Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FFA606A31D
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2026 07:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=F2cYfhBf;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=uvLqKjTS
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EF3AD601D5;
	Fri, 23 Oct 2026 09:06:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EF3AD601D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792739193;
	bh=P1VKNObtxgOGus1ars+pBMItvpJoZQBSbJHNb+W4CcQ=;
	h=From:To:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=F2cYfhBfs31gUCzSTQwxQEmr9UptshTkSq131DjUKX5EofAwxXZkYHB4J9AN48eel
	 4qJNb7J4MGRTN+mco80qA8N0WTlnw7gz5pgISGjobZvYNZ982SxfeOjnF1VvKQPJbx
	 Mgovc+fY6AF8qznZtuWz8dTQupUAm/7QwU0xPn8k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7DEAAF80602; Fri, 23 Oct 2026 09:05:59 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DE7EAF805FD;
	Fri, 23 Oct 2026 09:05:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8CB23F80548; Fri, 23 Oct 2026 09:05:51 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,TVD_SPACE_RATIO autolearn=no autolearn_force=no version=4.0.1
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazolkn19010020.outbound.protection.outlook.com [52.103.2.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 33C85F800EE
	for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2026 09:05:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 33C85F800EE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256
 header.s=selector1 header.b=uvLqKjTS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWhELw21YrEG+3gazXktl12uzhddDP6Xp/watRTrycN2YTO4gKSTnMpcdm/5sBfebSXrVfMV9I7AoKkhyDNkFGql+Yov+lnugm+6e/UX740og0iV1KcQOpmJx1hlmAU+EB4Xf+Kcki0KziBGkdJRkY3uPdWCX24dLiw0+h2fUIoI1MajVhphZdn6bI4ipNrP9XKUQ1gieiw/YYKaq/8gCFZYnIAkJk0RC96wR3HtYRQ7Wytp0uOpQPt7G9T2gjTG1lHDUAHf5dOPMDtf0u3AHizYQDS3TGI9FPPmuqMv9cBtS74eSZpKq2SOYqD4ftQ3263NS3BLkF2iIWYqo8pASw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AaCHjT/05fG14lTKqlE2UDAQ/dzUyGTQMMY2Vf3tkV4=;
 b=C0xrcGEBmFxM6Ah7UCEWOz6weD3WlYOv8+Lm6nOWuDIOI9oNCz9hRdJqIZVBtktF51ukgctKgiX31nZcV2QRTa1uvb0XSRdXIL0PhApgiyKTl5MhYMEHGypdJZqON0pHIrngecXY6o3dpy1gBCsm6X5CozQnIDCSIwGDmouJ2tn8r97FZduYGYBpr+thyQIrXedpdkaizn07UGOM/oh/R8EIMO+AWN50FPH8fXQfG1SEZpEakrGHP1yaa5ZUTbMsc9MYG3YGf4xo8CbPdHDwrmYdnoJmTB/KU1MYTiIU+5PjddakosKIMtKDf+8y2csBSAwAXLHquubDLMM09iCMfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaCHjT/05fG14lTKqlE2UDAQ/dzUyGTQMMY2Vf3tkV4=;
 b=uvLqKjTScwgmY44WFuPtC85pXnpnB4Nnsx+J8Rz+Lkst0XGZAwpTi/Aj+I8Q3Pct82wjTOKYnIQGMdqsDMsP7a5Rtq98+1WuNug0QNHngQzWwiWMZT2MibienFiZJPuDABl+t0qED8Y28Y1Ab+6EnciWBfKHf80VU1FM5w8fCjiXM9uTg+5PnVaPCQyQfrAmk1zV+Waim0bNsR4yudSjEvHl2t2kwt01k2rKOSlGe78tlQFYUE/7GjnN6HOCyc1YtqbDpAAq6llEmOp3umVVrQkGN5gYM4Bgo10Q+Lxx855/V6Q332HOMd9r1IfvyI6+k5e5JsopjC0JLSwvHfiDuw==
Received: from SA1P223MB0582.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:255::18)
 by DM4P223MB0493.NAMP223.PROD.OUTLOOK.COM (2603:10b6:8:ae::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15; Fri, 23 Oct 2026 07:05:35 +0000
Received: from SA1P223MB0582.NAMP223.PROD.OUTLOOK.COM
 ([fe80::2fdc:3152:a66e:ff0b]) by SA1P223MB0582.NAMP223.PROD.OUTLOOK.COM
 ([fe80::2fdc:3152:a66e:ff0b%4]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 07:05:35 +0000
From: Jaime Uriel Torres <jaimeurieltorres@hotmail.com>
To: ALSA <alsa-devel@alsa-project.org>
Subject: ubsubscribe
Thread-Topic: ubsubscribe
Thread-Index: AQHdYrzmq8D85gy9tUKaO5y1lgohjg==
Date: Fri, 23 Oct 2026 07:05:35 +0000
Message-ID: 
 <SA1P223MB0582E5941726C8812284AF49CF642@SA1P223MB0582.NAMP223.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1P223MB0582:EE_|DM4P223MB0493:EE_
x-ms-office365-filtering-correlation-id: 9c3a1e54-57bd-4d33-1466-08df30d40934
x-microsoft-antispam: 
 BCL:0;ARA:14566002|15030799006|15080799012|39105399006|31061999003|19110799012|24021099003|8060799015|8062599012|4140399003|25010399006|20031999006|102099032|440099028|3412199025|40105399003|10035399007;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?fQPRvfgRwmSH5lxa0b3TzYMCUoF0d139LrIa2IRLW5qUxIU2pfBoqlSRTb?=
 =?iso-8859-1?Q?3M/4on8C2VyeQwRuPGicWc2bJklrGRojj1xaevWSk7a2nhVZ0YgD3jrrKb?=
 =?iso-8859-1?Q?lI4XXl3aORDcrXpBjR+4gXkUBtWrp2mHW8jkxbSYxuTeuTwHFurpJac0GW?=
 =?iso-8859-1?Q?9gOXWsfN0TWkNYdd2CbPLbVZlqYZHCvpnU1T4COtlyNjKmTUtBWtF1BGcW?=
 =?iso-8859-1?Q?CYQCIS1F9Kcdeu0ObYKrdlYb5fT9gsPixyZRFkC8FaOZhyFPiL7OATSc1P?=
 =?iso-8859-1?Q?MlE/PFSVWRU7dz7+dPJfaeq2thdCUnQ8XJvf/PYtaRMV28QFWnQ2kKCWHN?=
 =?iso-8859-1?Q?c65RcPHLNqBN9DGsvgxQlGAwrkGETP55tApWIeQeWmZvwmXIVEoQsuWrNg?=
 =?iso-8859-1?Q?wDvBKzAMJupWrhnS6uQC5n0WYjZNwp+kWRdFkv8ze1oel/zrVBxz3fswFR?=
 =?iso-8859-1?Q?KiRWwOTj2jF5207Yn+HEF7ypz+cFgM0YJ/R5do4MbfgaR3Zj9hmmvLjPo5?=
 =?iso-8859-1?Q?SG6d3Gv2ndRCN1Ds4ylJo/ETog4Hb4eWlijFQmIyA1suSR5M9vRx7F2X7r?=
 =?iso-8859-1?Q?3De9yhRXoQJB6vWgxVpDL/BmZbOsP6v2GPoWHq8mQevyxb/XxxOmq3XXcx?=
 =?iso-8859-1?Q?jYakcSnipSs7UvUw7eXXeOSeBHyc6bEEmw1xYtrt468FJ5GI7xOat118Gf?=
 =?iso-8859-1?Q?nJe1L9Twa2AOjSDQe2Vu4Nvikr6kUUo70G9AMZGUTBddxOqIhevrql0JYO?=
 =?iso-8859-1?Q?DNF6a9SoOjA2bFbgr+HQi5HON+wcg06CQlnOI3rIRnCV7apJXxAI8rF6Gf?=
 =?iso-8859-1?Q?qrxxAdrc2blLhTBLttnqbPdO7yS+VHS075ZlAZwDlKxCYwum7pG4jonC+I?=
 =?iso-8859-1?Q?4gbV+XbrYZLlJfLFSkyhrPNUcTRJWnPoOgAInmYr7snVN5TpgVY+gOgwD+?=
 =?iso-8859-1?Q?tQU6x9lGGsTXUuPECpxn6bS9XtHXwtG3sXDzbmNr7m3P7+5oMKjIfn4wRM?=
 =?iso-8859-1?Q?Ix2rmusByU9uW5MdE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?4qaNuNNt7bh25eayhiXlrKlLp4GPOo5SuVkOsidUmOG6jicxCcFHaHdf7Y?=
 =?iso-8859-1?Q?HGRAa7tino6IpqDQnEgicMAVEdlPqdLXsMtvOxheC/k9kW/mDGcpseNg6Q?=
 =?iso-8859-1?Q?k1GSC7OYjjxBPkxlj2Pfp1li4s9xCQ2sxaZDdTwMqCgsG1PNrWpTVMx+6O?=
 =?iso-8859-1?Q?TuoMkCmjaOY1zj6I+Z/ptl8nIDAZG3GGfjTtro2bCrryTnl5of5dGipzAG?=
 =?iso-8859-1?Q?fH17X+j6evhDjWsZ1bzfobJ17lMRybwakgpXfHvDbqdWkL1zq74WWBCmv2?=
 =?iso-8859-1?Q?N2Nwvs4u1hR3p8ofgO39QxYudYFvYEb6nwpgPF1hMIPqQ8+Mxbf7m/dh55?=
 =?iso-8859-1?Q?TI+MgF12FLwWh782ceERaz2yGkUUfAOCESZllfqTTPmzWsZrSbL8Jn7o1d?=
 =?iso-8859-1?Q?dAazqUMXs27oKEV9j1g73qsqlpWJBbs/dIuqCu49g75ot82I2XIkdrrEjD?=
 =?iso-8859-1?Q?Y201Z74Vk7KteMQEOGPsyperoXAxN3UZdR/ANBpBzhLo03uxjgjqSXrsa+?=
 =?iso-8859-1?Q?lCwTmGOfZ1LLeSEKLWaRX/7tY89a313y/mZ99IG5GcP76owB0/LKSmV679?=
 =?iso-8859-1?Q?5povx1DMFKnrJ2PfGK6gL7bMJQLllVQcwBGkp345HGRib2dboVwU51flY9?=
 =?iso-8859-1?Q?UiAUaNfyNfEi5+5fHLnQg/fuJbBnZzw/1tM/uOjxbORRrmx+hnCIMxOtkF?=
 =?iso-8859-1?Q?kyn+zI37nE//t89I4GJqz8uytcNJdmqtiOHdayZcOZqUtoBaO+RqCAoZI+?=
 =?iso-8859-1?Q?KxG4Waqv0/CY140mIN25xooet2/rVOSODLltZHeX4IwqUMZdpQxDr6kxAV?=
 =?iso-8859-1?Q?XBfp7F6t44J1yswyUp8C5WQv7XUCijcVEhRhgtMlVLDRTcEV/uyg8+3R6Z?=
 =?iso-8859-1?Q?o0JnkHKf8UvVqfwqxDBnwcb/CMPNFWEz3imHsLoxoPIi+R7mbGUVWNSK5i?=
 =?iso-8859-1?Q?+tipNj2qWZrzNBctOwihU4iS4K/UNTu/1yLCkUvygUBAJr4RDV7JZhBdk8?=
 =?iso-8859-1?Q?XDiSnaiIUDxgMmv4Z5mFFpPfWcKDN39Jtg60pySPXwLsmQneosp1g9mAwp?=
 =?iso-8859-1?Q?+O9QRuEnRzxu44JV6/wUn1sedQJGnD7h8t1CAjtK+wOqpvmKNN4WQRmzy7?=
 =?iso-8859-1?Q?GPIb0y1HvG0JMyWNob3TkOU5iSHrePGjHne4fduLW8/AqEYVCF++9Fl8AW?=
 =?iso-8859-1?Q?3xX6F9Gfsh/wbQe9xYgfdl86vhh6wSUhuAU5SBv1Ot78cDGly9B0T/uCc6?=
 =?iso-8859-1?Q?h2GS3kLsN/C8JeIbaj49TpOdmQgomVYr4J1RIcKAjQWcpzeYy12XxBQYkM?=
 =?iso-8859-1?Q?xIKwEcEumlir630XgMzf6U3GHs+hOUXX+moS7RsyS6VnenA9hZh4dyAukM?=
 =?iso-8859-1?Q?k5wlgUWnU2a7e5QRgw+TgGbDd1FPA366q11hKT9iDPirgrgWRTrlZwkN8z?=
 =?iso-8859-1?Q?3IexUfGdzADew+hn?=
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-583ad.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1P223MB0582.NAMP223.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 9c3a1e54-57bd-4d33-1466-08df30d40934
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 07:05:35.4418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 
 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4P223MB0493
Message-ID-Hash: SW6AKLKM2UXDMSB5YMYPAZR427JNGYQC
X-Message-ID-Hash: SW6AKLKM2UXDMSB5YMYPAZR427JNGYQC
X-MailFrom: jaimeurieltorres@hotmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GWGCEPFCW63IEN6T6DVD63AOI426O4Z6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>



---------------------------------------------------
Jaime Uriel Torres Serrano
cel.: 300 4654724
http://www.comtor.net/




