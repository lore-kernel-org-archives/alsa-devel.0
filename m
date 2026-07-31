Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC767C54F54
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jul 2026 08:16:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D362D60212;
	Fri, 31 Jul 2026 10:16:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D362D60212
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785485806;
	bh=mF2kwqO5D49OPJiWCrwWcJ2vkUIVDL5wNeulVThdXlo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=mHqSBtGrczc0dZO1wnJXJvqvQADS1RgF57cbj1CsdSi0y1dc5ScVp59SEmU8u166J
	 YU41PmFrtwo6KQzYT7e3abGObcWahdXifhKT0RjXJvbg8SGKrw+Wf8alwYdM6XTdHz
	 zPpjndPIzP43yasfNKuB7F7WfpUyYIjVEHjk7MpQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BEAE2F805FF; Fri, 31 Jul 2026 10:16:09 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 59ECDF805FF;
	Fri, 31 Jul 2026 10:16:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0D4D2F8051F; Fri, 31 Jul 2026 10:16:02 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.86
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1785485757;
	b=JRF7kk/GXfAK7OesnLY0ceGvP2LQAUYZ6383Lwref12Bc1k4wl6a3kNr/McjrUHbTm2F
	 OlunWbhbNFAWh86itlpaSUuvN9I5wjNsmUDBk+s3HeGJAzWgwexBuygwTYy3gpC+3kx6k
	 1ewPOBPMa7hoYvt48ORu05dzc9SBeUZZn0ujFOhObQXZywDKW2H0bljtdd83nydKNBoFR
	 7zQ7CQFRc/tZkJqTa5g+FeXlaf+zfm6BkVj0x7BZGxvWmGYv91PqLTRp8eD5byRv9CPmP
	 VZPUbs3P3milNtho70TNV8vfN8TEKyZ3W9S0clgo4sR5uKHarfv+jeAXrDHtcWA8IUA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785485757;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=u6YVMiSkdFBf1Y/ryvF/omCuBicKnbH371S8aTvb7dQ=;
	b=aD2RFD8fbvMbAa0RRjJeUZUmDEFF+nf9kxE3nDTlMrULwjl5TLhgWONwrWuIOdwRoXHP
	 Hu80Jek3cPrXcazsFsCxKWCfnkZUMr35spqsH5jrySUbGrkuZmXLrMydyoYF55kZLFE74
	 vboj7yNmkPt5hMdRxUN27XVOl+05SC7JBRy3JBvGRhqRWSaxwG3vYEIivFTuVb+tV1Rub
	 d9P7yq5iMGpf3oPSqgyzzwnb4dGu29TTWDXo0z8OnbDE/91kfIFRKIutaBlBmntlJxofN
	 gfrbzuIr2wIaRa1EewX2urHQF7UL82gL3hnmAyEXRey/pfx8t5NM4gc+BERcFixjp0w==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256
 header.s=selector1 header.b=JC8TAbXi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.86
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazolkn19013086.outbound.protection.outlook.com [52.103.43.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8CB95F8014C
	for <alsa-devel@alsa-project.org>; Fri, 31 Jul 2026 10:15:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8CB95F8014C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256
 header.s=selector1 header.b=JC8TAbXi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=At54EsqKkWF3qD6YjVkc1nTOa0+ZUriPdwPqAcySNSJMJb1USjf7nc7G3i4R7GS/eV5rXwE4ncEV5KTOR2x++7wnPP3jrS4mA1G/IH413iyesHZFdOBTwgQpMdQM+jFTT1HydB/Drilhhk7f3MeiFlZP/aibm6DuYDxkSNGeoFw6AtvWfCIAmigOeofDws1ratQroXRNYxGSl0i6S7r6o9bW1CNdCGTNLdEyRTi5iqxlPg+rrJgiPaA1SeFXZQ71EuFATr3/NMV3V4zZnDw/q/jNB/rtW8zdYrlRT7BMsa/YnSO1iBrYjFVV0jAb/t+fetHtHmTKhTu4cM7rtGbrjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Fm+LAqLtCPjTUrbSFHSmXnfN9t1+a8ya0S6NVDUAQ8=;
 b=zFgJz8owm4cTWmogzA6OCQxDiNhuM634RFQHMZax0Ss9UZ0BAnEF6NdleNTMXan7YjZki94fLkofO2e+FHZIPYDvjKQDPzdlDPUOA80uK803a/qiXtDaJ7JPYH6OQOyVGR6S/SPSuGQTDH4IdUSqmWZhvQy090Uv+vKmS0Dq/t0Kg45KNSxRsdLEsFTaXdXKBfUPpVZR620966rfg66yfb8PmMzCr/B4k3wCjjdcFkpdzlyYwd5gY02cRPFjM8TGNZq4mMrqLwYYSIZcRVWw10Ncg9VfsmxXgUxW5F2i597DlQui+Ks55svbaBfOYxjow5+KRsZwGVqTSinDbZyztQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Fm+LAqLtCPjTUrbSFHSmXnfN9t1+a8ya0S6NVDUAQ8=;
 b=JC8TAbXiw0GJxBEgbA3irTXp0ILmK6Zjp4VihcO2BdaS0Xkduh5bR2/2gUBU02YBPvDEZ5yNPZpTt7PN17+8Bc/I6tZdfKEb0X438/uJ/lUx4kSn2eT9Er2PPlDCflh7k6oiqT9zmmIB2OSMMsc6k1kOWHc/r0CGKKxifduV3MaeF6i+PnqVZYtHR9e9NVN8yNkfe0xdimo6s0n8H0MJOiA86Nl5UR+1OnmbWuLJ3Zsfe+pNACv7F6Y+3W4g+pTILPPgeU/ihWVPZ83dbLMN5xIxW+7yqLIDuBi07pVufon4hC1DRGoIplpNFub/nblEu0920XccTVeNAgqt227QyQ==
Received: from PSAPR01MB3912.apcprd01.prod.exchangelabs.com
 (2603:1096:301:4d::11) by SG2PR01MB4387.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 08:15:48 +0000
Received: from PSAPR01MB3912.apcprd01.prod.exchangelabs.com
 ([fe80::4989:b66b:5a3c:8d84]) by PSAPR01MB3912.apcprd01.prod.exchangelabs.com
 ([fe80::4989:b66b:5a3c:8d84%4]) with mapi id 15.21.0245.009; Fri, 31 Jul 2026
 08:15:48 +0000
From: Ashmita Chakraborty <aschakra_ashim@outlook.com>
To: Padhia Luo <lcj20010426@gmail.com>, "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>
CC: "tiwai@suse.com" <tiwai@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA: hda/realtek: Fix speaker mute LED on Lenovo
 ThinkBook 14 G8+ IPH
Thread-Topic: [PATCH] ALSA: hda/realtek: Fix speaker mute LED on Lenovo
 ThinkBook 14 G8+ IPH
Thread-Index: AQHdH/MdlnYK0tYwCkOgvxmgv7q/ZraHSLrj
Date: Fri, 31 Jul 2026 08:15:48 +0000
Message-ID: 
 <PSAPR01MB391283EE04A79662DB3EDA91FDC82@PSAPR01MB3912.apcprd01.prod.exchangelabs.com>
References: <20260730071453.19636-1-lcj20010426@gmail.com>
In-Reply-To: <20260730071453.19636-1-lcj20010426@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR01MB3912:EE_|SG2PR01MB4387:EE_
x-ms-office365-filtering-correlation-id: 376f332f-6522-4d4c-9f0c-08deeedbed64
x-microsoft-antispam: 
 BCL:0;ARA:14566002|24121999003|20031999006|41001999006|31061999003|7071999006|19110799012|8062599012|8060799015|12121999013|22091999003|24071999003|15030799006|25010399006|24021099003|55001999006|4140399003|39105399006|15080799012|40105399003|2607281247196008|102099032|440099028|3412199025;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?Tcrpi/J9ouCBQwzMV57NUharC3JF04VxAmC65WzR3i/7d1NAo3FLptQOW3vL?=
 =?us-ascii?Q?ahqRA/uBEsEARUkO0ZRSKpGIT7zKPqUrATnZHP5X2qfy5a3n/e/kagAcQ5DV?=
 =?us-ascii?Q?qtHvAvUKnFxwRdosG6NtAoroUygDLwPThetWjGugAwkSHnrvRrOo0dgWVOkQ?=
 =?us-ascii?Q?U0zkbA59tOSNuvXA0zIz3hg5s3cVOWL2psVeiOWX2x4qDp7iiDVh0Npxx//i?=
 =?us-ascii?Q?Dgm+lsaFppQk32myYCPAISA1y/TNXHm2/o1SlehddRWMwEc54LDSBgKG/4gT?=
 =?us-ascii?Q?fj82vbVc2OAGSxh4loOJ97M+Pp84ZP+EV0lTsQdEXxwSSoxSdXOu9rf+qvYo?=
 =?us-ascii?Q?8ZnrKoXPr/byfjcr+jnZTFByCC6QjKHiQWncW0zUHmgHbvh1I/vu5Wbk8JOy?=
 =?us-ascii?Q?XAKM07vUTvxQpzCrf3LBZpRy07AobUbDyqaxrcvrp3cZKRYE74OQoGdBuyhs?=
 =?us-ascii?Q?dJiq/V8LQNIoGvjZjFGb38KAog1VkQF+YXnVKaRBnWlRevN1ISarIfWPTPGl?=
 =?us-ascii?Q?yu83ctWoVxtsqOu1DUXJDhn73G8YWZgcXOqD8WObsjb4LsYI6JgadcJeiuWM?=
 =?us-ascii?Q?FbGlMEOT/edxkZs2YHkYXxkH5XIc+vWf5EW1i+5NAgDmhfkcg5blfQ1DmipN?=
 =?us-ascii?Q?6IVxzJ28YJuU3jyMTYevvNPf5F2sOHJ6YZK8SWCAIAd+KTlgD6p31qIcBUXt?=
 =?us-ascii?Q?1B3gc0GauCVRMpo4hSbXOp84InvN/H2NQp8ZqZyEa78mQOV0qEQDIBRwVMI/?=
 =?us-ascii?Q?nEzZHR721YTktwu13sKrX+t8i2/eucLPcIYvpAzdbjr+84uc1M/93IJcYx4a?=
 =?us-ascii?Q?+sPUHlgsstl40snOZDosdLj1XZHtlcoGpF4cqR2d7s8Q3080hCXvs5p0ENQi?=
 =?us-ascii?Q?FpROpkhXFRNFX9doAejVnaXFR2M1u8q6yqSUf2fphp/Yrnhyk5bwZbLMEHST?=
 =?us-ascii?Q?/WBxxNbe73NYSKjVUppyE599rrSvLqjf94CsIxZLNZFrYGEpSwv+zgHYDm/P?=
 =?us-ascii?Q?EvTI11IPG6DkkZ2tBUus1bqHYcEjvCM+LPLLBLbhkn6IAIsMbokL+25Qxi4Q?=
 =?us-ascii?Q?t4Ai5jwsuVKiYDri6MsC4kI7kqKkggSamav1V6urdb7/MHzKaJaf6wMPiH04?=
 =?us-ascii?Q?3dlOsn+uLh6DHoOO08CV8iH5jWWDwakl+n+qKHgrOAzy8ZwhYBZUS0zkb8zw?=
 =?us-ascii?Q?XLlAYC7A9Io/q8Q2hIyTrXCSFCeXNKF5L0HFsQwATGrqL2g0hX0CjlUzEJw?=
 =?us-ascii?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?jcAJnZ7uIACxJ+4auinvpvTIZ+T76qfe4AXXEqRc0+wbHSgf07aZSl9ILlCL?=
 =?us-ascii?Q?k/8dmWL6jS7lU4H/PfokS5PuEr7dYeKNam6DuCxy3b/kLFGo2+L+PMgdyqq9?=
 =?us-ascii?Q?1dkAdKp6G2H5EcYlG0DmkBOWL4MrTXpJlRISRJoGzj0ElZ4sHZpl3cNGybuZ?=
 =?us-ascii?Q?Dfmv4w6aidBMrG9IgXv/l57cW9swFH8LZEWPm7/vtTAX8SOtCdFeZGZNWkrP?=
 =?us-ascii?Q?3cU3bLDh91eiIfKNCbqjYrrKSsIN63musXdfRN/qFuQ5KwvzkqHS9gAZ7Pt/?=
 =?us-ascii?Q?8mx1SLNlCw4mDaZJooLp0f53CF++Z3TXcpLwrB76XXmOYyADBDD8wurqVW2k?=
 =?us-ascii?Q?lo2ai8smEDIw6oDYYI6Sz03JuudYmWEAxtLqn0DhJlW1pMN9UVh7uV91R/Fb?=
 =?us-ascii?Q?oLy4k4jut9h9mlSp/tqAg2SrSnkqEdqBwxU3TOnxe7yZfm/h6NixT7kAbli6?=
 =?us-ascii?Q?0iU2UeJ584W+yon2jZGpe3I6QcEUifNQ5YR7YiBTJjG1m94vMu91taJVQRty?=
 =?us-ascii?Q?2UgJ15o+CwLa1POQD6Zn6fSKTbVU+cNgVTDG5rfjGRTBEHtGHN9XiqiJZ6NS?=
 =?us-ascii?Q?E3Xw63Wxy6Dow5/UJY7g7X9fgsGfGRVxw9J+gM6n5GjJdNQtRAJWJkAbfc+A?=
 =?us-ascii?Q?8GzaCT9ko5FPslJ60blUiMphLcNneU3Mu+4q//0bBBZ1qs4sucrRKgdjsjCg?=
 =?us-ascii?Q?d51a7hW4TxItQjk4Tr1z94BiekWXF3B6cldXPpfjkDeB281GuzVJjYri3atn?=
 =?us-ascii?Q?hBJrFbkQ0Vk4rX2hTt6o03v01Jea6sQDjZ5dwVpQfll/+OpFjF8eNZ9RBlwG?=
 =?us-ascii?Q?qHXidjuXzN97msiQEaRSLBK4A5uNQPGyHiDfAleWDxwrhn1mIGWBzOVYJmBw?=
 =?us-ascii?Q?hD2u06fL9V98mRoc4sAiOrWn42Z0CD9CMLKr59bbPWWe3hgkYSKoN4OJdCEZ?=
 =?us-ascii?Q?g4zeFk7PVg/N1TVty27N5/5X/r/BNvs42/gVbVrJ7sx9bzolPejFsI5iTJPG?=
 =?us-ascii?Q?uO43jb+q+zshujN+Xtp2ero09IbuBsAw8Zx7nszMWWynCDwWs7E8xZy8r+kj?=
 =?us-ascii?Q?+CYVTp73PtmqswZe/3KtrAxfwcBwbTaNnt/MMb7ATtcrwQvWhvCZdspED3hu?=
 =?us-ascii?Q?9hvh/iG017PS3zoGvxYv2oNOdbF58GPeFlCE3d3AzkcXwWwZWR1+ePyzx0WY?=
 =?us-ascii?Q?DMJrsiFAWnASExslifb27KvnjjElEu6iOb22GdPn+wf3HhYWvjpbpUCUgY0W?=
 =?us-ascii?Q?Qp5nCGiIvpln1fx9hE3AMZ6zx7w1qDtckPRDL1CSWS7qd4oGXLyXE8CSS0Kd?=
 =?us-ascii?Q?nDk/GPwg4TLDVJtwJfcC70+eUg/w7AAvnrDj4XIrmxlExf1/U4aRIuoJpfvU?=
 =?us-ascii?Q?WNEYMx5DxUAYIY7Ese/5R/sgPOz30mQBhwW1ctzEJhQTfgVX7FDdE7tS5dUo?=
 =?us-ascii?Q?gpWQPsEAhNZzRVERRgpAl7E9axW/nxB3?=
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: 
 PSAPR01MB3912.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 376f332f-6522-4d4c-9f0c-08deeedbed64
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 08:15:48.0172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 
 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB4387
Message-ID-Hash: YMAJDZLZJDU4GML3TYXMUS6XUG4JC46X
X-Message-ID-Hash: YMAJDZLZJDU4GML3TYXMUS6XUG4JC46X
X-MailFrom: aschakra_ashim@outlook.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/W3UF7CJBNOY5GDA2QORGZGM7JF22LPTR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hello Padhia,

Is there any discussion channel like discord, or slack for the sound open firmware project? Ever since I enrolled as an IC in sof project, I have been receiving emails from the "alsa-devel"
email domain, but I don't find any discussion channel for communication with the developers.
I would appreciate any such discussion forums to begin contribution effectively in the community. Thanks for having me in the community!

Regards,
Ashmita
________________________________
From: Padhia Luo <lcj20010426@gmail.com>
Sent: Thursday, July 30, 2026 12:44 PM
To: alsa-devel@alsa-project.org <alsa-devel@alsa-project.org>
Cc: tiwai@suse.com <tiwai@suse.com>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; Padhia Luo <lcj20010426@gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Fix speaker mute LED on Lenovo ThinkBook 14 G8+ IPH

On the ThinkBook 14 G8+ IPH (SSID 17aa:393e, ALC287) the F1 speaker mute
LED never lights up, while the F4 mic mute LED works.

Both LEDs are platform LEDs registered by lenovo-wmi-hotkey-utilities and
default to the audio-mute / audio-micmute triggers, so the speaker LED only
follows a control carrying SNDRV_CTL_ELEM_ACCESS_SPK_LED. No control on
this machine has that flag set, so snd_ctl_led never attaches anything and
/sys/class/sound/ctl-led/speaker/card0/list stays empty. The mic LED is
unaffected because MIC_LED is set from the SOF topology on the DMIC
control, which does not go through the codec fixups at all.

The pin configuration of this machine matches the ThinkPad pin quirk that
selects ALC285_FIXUP_THINKPAD_HEADSET_JACK - pin_config_match() masks out
the sequence/association nibbles, so 0x14=0x90170120 still matches the
0x90170110 in the table. That fixup chains into ALC269_FIXUP_THINKPAD_ACPI,
but hda_fixup_thinkpad_acpi() returns early because is_thinkpad() is false:
a ThinkBook exposes neither LEN0068/LEN0268 nor IBM0068. Therefore
snd_hda_gen_add_mute_led_cdev() is never called and spec->vmaster_mute_led
stays 0.

The vendor fallback SND_PCI_QUIRK_VENDOR(0x17aa, "Lenovo XPAD",
ALC269_FIXUP_LENOVO_XPAD_ACPI) would have handled this correctly - the
machine does expose LHK2019 and VPC2004, so is_ideapad() is true - but it
never runs: the pin quirk has already set codec->fixup_id, and
snd_hda_pick_fixup() returns immediately in that case.

Add an SSID quirk selecting a fixup that keeps everything the machine
currently gets (headset jack handling plus the X1 Gen7 DAC routing) and
additionally runs the ideapad ACPI setup. It chains into
ALC287_FIXUP_LENOVO_YOGA_PRO7, which already combines
alc285_fixup_thinkpad_x1_gen7 with ALC269_FIXUP_LENOVO_XPAD_ACPI, so the
resulting chain differs from the current one only by the added ideapad step
and cannot regress the analog output or the headset jack.

Tested on 7.1.5 on the affected machine: the speaker LED group is now
populated at probe time without any userspace help, and the F1 LED
follows the mute state.  Compared against a boot with the previous fixup
selection, the mixer control list (names and numids) and the registered
jack input devices are identical.

Note that the underlying mismatch is not specific to this SSID. Any Lenovo
non-ThinkPad whose pins collide with a ThinkPad pin quirk loses its mute
LED the same way. Letting hda_fixup_thinkpad_acpi() fall back to the
ideapad check would cover the whole class at once, but that touches a
helper shared with every ThinkPad, so this patch only fixes the machine
that was actually tested.

Signed-off-by: Padhia Luo <lcj20010426@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -4077,6 +4077,7 @@
         ALC298_FIXUP_LENOVO_C940_DUET7,
         ALC287_FIXUP_LENOVO_YOGA_BOOK_9I,
         ALC287_FIXUP_LENOVO_YOGA_PRO7,
+       ALC287_FIXUP_LENOVO_XPAD_HEADSET_JACK,
         ALC287_FIXUP_13S_GEN2_SPEAKERS,
         ALC256_FIXUP_SET_COEF_DEFAULTS,
         ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE,
@@ -6109,6 +6110,16 @@
                 .chained = true,
                 .chain_id = ALC269_FIXUP_LENOVO_XPAD_ACPI,
         },
+       [ALC287_FIXUP_LENOVO_XPAD_HEADSET_JACK] = {
+               .type = HDA_FIXUP_FUNC,
+               .v.func = alc_fixup_headset_jack,
+               .chained = true,
+               /* Same as ALC285_FIXUP_THINKPAD_HEADSET_JACK, except that the
+                * mute LEDs are driven through ideapad_laptop rather than
+                * thinkpad_acpi.
+                */
+               .chain_id = ALC287_FIXUP_LENOVO_YOGA_PRO7,
+       },
         [ALC623_FIXUP_LENOVO_THINKSTATION_P340] = {
                 .type = HDA_FIXUP_FUNC,
                 .v.func = alc_fixup_no_shutup,
@@ -7790,6 +7801,7 @@
         SND_PCI_QUIRK(0x17aa, 0x3920, "Yoga S990-16 pro Quad VECO Quad", ALC287_FIXUP_TXNW2781_I2C),
         SND_PCI_QUIRK(0x17aa, 0x3929, "Thinkbook 13x Gen 5", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
         SND_PCI_QUIRK(0x17aa, 0x392b, "Thinkbook 13x Gen 5", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
+       SND_PCI_QUIRK(0x17aa, 0x393e, "Lenovo ThinkBook 14 G8+ IPH", ALC287_FIXUP_LENOVO_XPAD_HEADSET_JACK),
         HDA_CODEC_QUIRK(0x17aa, 0x394c, "Lenovo Yoga Slim 7 14AGP11", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
         SND_PCI_QUIRK(0x17aa, 0x3977, "IdeaPad S210", ALC283_FIXUP_INT_MIC),
         SND_PCI_QUIRK(0x17aa, 0x3978, "Lenovo B50-70", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
