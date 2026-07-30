Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43295C55167
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jul 2026 07:28:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5170260171;
	Fri, 31 Jul 2026 09:28:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5170260171
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785482898;
	bh=pre+hHZpCu3CLs2fzONCmSctOJiHFmkYAwTnKVB1f4k=;
	h=From:To:Subject:Date:References:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=edD2wGYompdUXcOqppxQpIUdmJFynQNTPJCOSrxB1aZiiiC0LRE7/CL4QIONCJs50
	 q67MR24EsTUpugy8zAAorC8z+MMVZktllz7ukmyd5K6RuHhUf5hs7kXCMl7lMZ++A5
	 +9LAkLMtzHb9O3wqOr7m/n4vf86U9n8w1AFp+0HQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B98EFF8060D; Fri, 31 Jul 2026 09:27:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CEEBEF80608;
	Fri, 31 Jul 2026 09:27:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 895AEF80496; Thu, 30 Jul 2026 17:11:01 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.37.61
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1785424259;
	b=I2dwUtNY+K4xqP5udDFbTZ3ad7u1L252mJ8GTKeJiH5z4RRvYPfgf8qZSEFSuLGSvLYj
	 c6iCy+n0GvCDpMjvMEv4ZF7xQnaUJhq/SB6FY7IvAE06QKjzlm4jxy73YxFPPhcE3sMaj
	 Ppl9hPC1vzcHCxWdSnrl3CyY9Q1UXqF4CYql1NZx9TvI1R8nU3qJzakclDC+QuJJHKa6S
	 0t2cZl/t0uzFWUSjMhttzv2BAFG4B/u/j8UCQqdL9sPR0YmTAk9X8UAWPBZ35M3ND7mmh
	 9mmyEOQTVtpfJxWrfpfB6xxZmhS/G3g06YvQ0H3hxQc/l0ylzR3fstAJ9cN+Nu1vmSw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785424259;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=vDjCQtn6OryPV3dE34yuTPT2edIYCbxFc00k5IRFteI=;
	b=gWxhIYGMuR9tHvbKETNjY9Q+RYVEr1HLqn5cA8Q5Jzn/cHQ1wxD08vUyGjS83Vtrht0B
	 7vZ/kaCbzPH0mvli6AWbAiu0dOhRdOTZqvglDK+4XvRSgSBt4NQo4lwzY5WV+BQfZsj0y
	 38+reDtLt4OzeK8Ml+6ZztUAepHBMv9b/sw9NhCmhphtkJbd1qAmawCkeuY1W+5YCrFKN
	 DFKauoQkPGHamNjUNNOT9gyFOWklsOVGrdxb8CC7Qhl2dHRNAxoImN8TsvSRuX7i85F7j
	 LhXrMeXnhUBdvu2PA00d635F5GFiXg1j7VTSPEtu2cJAlQZrq1X7y6AU88Wg5Embvkw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256
 header.s=selector1 header.b=cjHQDtEH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.37.61
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazolkn19012061.outbound.protection.outlook.com [52.103.37.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9F8BBF8014C
	for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2026 17:10:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F8BBF8014C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256
 header.s=selector1 header.b=cjHQDtEH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sz0w5v3dALyAHUvwRjLt08wG3NyQPp8vweUgu8kTK+0haDBcfM0k1+QxKSfaQY/Up4yR9OcQ8/4hgD1+GYJYw0Uj3MFSaqztwOmQNPqEY4g3RltmIQu0PATSrguvUwJk9fw4R257vorsUdpjIv2qK3G7Zw9hBfJePo31J+WLrwsoTrUVbCQF5rfDmw4xhSQgkeh/gHYbjg31ykyKNfQ2Swv39Y3N7bKaNJZAlXxMGY2hzUXyoz0AQYIi+2EPrbqjecgaVENwFoNQllr1WB7sX3QaM1oStJc2Q20cGzf6DQtnFqIrKZUOi3tvrig0fUzoHNs0Ljvv+Rx3ttbKyJZ3vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDjCQtn6OryPV3dE34yuTPT2edIYCbxFc00k5IRFteI=;
 b=tmvYzuKfj4aTHoH2wcSnTptQM/Jv9h0NTsxmUi+vnM3mcM3nTSNy9eHapViXbqNhcrkDTMwy+DFez48mA7E/i6AOeKymZIGEfoigTm5zuhn8O0/t671HtfsOdLwts7zgIhp1sdEs3wZcVV/2FO7padd/q8CzDY8+sULBILx9s+6PuiFE+U8ccIfiXKMSYArjZFT7Y7pav6x1s65Uj+xWNZgNRGUwJeIwdUneLe1Nt8EXOgAxgt8mzKYuEVyicOBdfxO8voOJYLHnpLaHFPajAtP36/M9I2g2QKrRSk4L+nTQzbJH/rxoj0dPDiCsamyVJgRVl/9Vi2x1xEHiR9od5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDjCQtn6OryPV3dE34yuTPT2edIYCbxFc00k5IRFteI=;
 b=cjHQDtEHmGPOMJX4l+SkXREdTqMCgNY2/MisD1h8UVhRbqkzFCs7F8lhYoy6DvxUBqHHeK+s2Ou5LLW1A9TgIPRHbZ/E34QtaHrkz1YgcnGV0KKPbMWXexVu1WFtFnpHFrk3BYSttwz3SzvdNe/Jvi/nLVBvTnijUXY1q8YD10Tc4hqf/mG/wNuQmJZIvkvbjnMD2hYXVilNOJ/f0q/zX/xrcTFV12xzlbw454L9mp0Lq4fSgJdA2CL9W6CmqfwY3kab4wlg5AGVuLCSY8SOHi3EAxYdMfb09+BtCirfiWEljvyBdpTyFBvoyFFU4+/q6DadhcnLgWm4wxb8gL8kKw==
Received: from LO2P302MB0105.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:376::5)
 by LO7P302MB2381.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:476::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 15:10:56 +0000
Received: from LO2P302MB0105.GBRP302.PROD.OUTLOOK.COM
 ([fe80::55da:c6fc:c228:8dc5]) by LO2P302MB0105.GBRP302.PROD.OUTLOOK.COM
 ([fe80::55da:c6fc:c228:8dc5%6]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 15:10:56 +0000
From: NA NA <realgamehacker@hotmail.com>
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: github dot com s3boun3t ae9_build Creative Sound Blaster AE9 Linux
 Support
Thread-Topic: github dot com s3boun3t ae9_build Creative Sound Blaster AE9
 Linux Support
Thread-Index: AQHc/q7hWg2Tq2EJt0aQVzfSMx06rbaGbE9GgAABZYE=
Date: Thu, 30 Jul 2026 15:10:56 +0000
Message-ID: 
 <LO2P302MB01054AA457365823BE78A6F0CDC92@LO2P302MB0105.GBRP302.PROD.OUTLOOK.COM>
References: <1781737905-5649-mlmmj-27712a67@vger.kernel.org>
 <LO0P302MB009878C699318CC1889A8204CDE42@LO0P302MB0098.GBRP302.PROD.OUTLOOK.COM>
 <LO2P302MB01051333F7AFACDAAA702087CDC92@LO2P302MB0105.GBRP302.PROD.OUTLOOK.COM>
In-Reply-To: 
 <LO2P302MB01051333F7AFACDAAA702087CDC92@LO2P302MB0105.GBRP302.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO2P302MB0105:EE_|LO7P302MB2381:EE_
x-ms-office365-filtering-correlation-id: 4ca479dc-3c8e-4f80-d04c-08deee4cc167
x-microsoft-antispam: 
 BCL:0;ARA:14566002|25010399006|37011999003|55001999006|24021099003|51005399006|15080799012|15030799006|8062599012|8060799015|19110799012|31061999003|3412199025|440099028|102099032|2607281247196005|40105399003;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?EP2VhdS2iEC9SRQQWJX0rpSMC0x9VpYDzb3P7SbHyUmjb0f7LJMeGjp9+m?=
 =?iso-8859-1?Q?foai3iqw/WxWQPACzjHF+qC0+xFdCRu+vOXSCB1lMe+yB88N1a8ZwEZGuL?=
 =?iso-8859-1?Q?0sA0g69+ToL1Vg0FXCeWNjLuCdVRE6mvpBpACUWe15S6n+vOejoIQjULZD?=
 =?iso-8859-1?Q?SviCpIwO2IjjKwG2xKCdDyeJthne3PCuQONndgIcn5S37rocWkkjq34Of8?=
 =?iso-8859-1?Q?D+jLSDpXF2X/QLQednO7uF9orAJcz0bmpSBkaVTsQzjppXnjUARXMJt4xw?=
 =?iso-8859-1?Q?XbknXGjn+9wv51Pj+UWRBgCCgQEodAf6J9FzHJjqLFprWb6Tz5DgBGxYCK?=
 =?iso-8859-1?Q?6NLFNuFxLoN934KtVI7lB3ESMTK57nT2C8KZZaKnVJLzsSqBhtS7P4QPHG?=
 =?iso-8859-1?Q?rCRpgxbIMeHSA+wmmLsBriwp1U7Yo7vgQD0z23jI99GNQxgL7Bes0Sskr2?=
 =?iso-8859-1?Q?14bqMXSSJLJkTL5gEEq7tn2y8Y4bmAj0PzKDesR3o/iieshXvht/pCv8zu?=
 =?iso-8859-1?Q?gRjHyO+mc9tM/3Z5eptY5h0E3cN1LIJRRpkLo3sKBLUHssIVkca2bmkvRl?=
 =?iso-8859-1?Q?1b9mB3RL0w82C8HATwkkXQNgqxNGzEyBsYCeL3+e7unkxezO3kzgCBvImA?=
 =?iso-8859-1?Q?LFxBepMVA+24YqNavDEaGGRRD3sST3kzaKG/Vx5ksS2uHh3agYTEYsrKkk?=
 =?iso-8859-1?Q?rmmFULDjj/UFf20Q7d4zg4HO3hTdX64cMFXTy91IJ0yvyFvrmko8iNv1dO?=
 =?iso-8859-1?Q?mU/muj7lmj8B3dAhhfPjTUTRwW3v5ssVB1mP3DfcGTBRswjCFrkoc+gjye?=
 =?iso-8859-1?Q?+B1XFZFpTjXcrEp3mzTYf6fyq21DYCbl0mpm2XRexNpKWknZcDF2u4Sb0r?=
 =?iso-8859-1?Q?je2hKH71GMSS03fHAsUTCMPlNhuFY7TxMA8D5s2n32cOvh9ETB+i9Dcs4g?=
 =?iso-8859-1?Q?OSklBFh03KsKzTzcW2BSt9AjAtw+ebXCrhaFc6WayuR0qCkkTGQwGIZNeL?=
 =?iso-8859-1?Q?G3aNqD+2x1i2HaEk7kwaDxgAoNNgr6m5ph5qFrc7Cvc9CEmAg2ASYc0JWn?=
 =?iso-8859-1?Q?x2TitcsAEzTcd6DGwXOEX0A=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?fofvPcwXjyC2ZQa/FOMenFaXsImlp1zpG68de1JUapD7Fx6trsakEFpjo+?=
 =?iso-8859-1?Q?eXdWApO1xoWKZEeViQki9UyW8G5aq9r1F6Omn+vzvDbyOFUHr4c3bT6jeR?=
 =?iso-8859-1?Q?HzsVl3HJEowxyKPvJMMp8mK3qhIK+yGLX2Wgy/OEvdgzQpjbmNePx/Wh8A?=
 =?iso-8859-1?Q?dLYcljsPDJi7w0Yclo84r1d/LT4OSNHdHGVhhkWW5B6weK7eOKKa4CVfLf?=
 =?iso-8859-1?Q?5+8YlxYaVot9zzPCTzyQjmgxGLL0kSszl+dk9LJc4CNZD9pV20y9C9VKiE?=
 =?iso-8859-1?Q?6y49qUv+P6SEQ8fB+E2P2eQYYB2Uu1R45NthiTn8bV0YFwH+k/lP+MYZZv?=
 =?iso-8859-1?Q?TR6YmpoqHa/vRWM5mCg+LKqFKA5b1J7MEkoTKCTbj0kDGGvyUAW7hugDB3?=
 =?iso-8859-1?Q?30Jz1D0M9zOE5RCsE1VN5opaY5Msue4D7KGKlhoE09SDZhuk8pOJCJyY4c?=
 =?iso-8859-1?Q?yQ93YkLEVU5maPQdxkj5LXXa0KTH2yBSnedMD0KSNtKNaVCDIPK0jnfuqe?=
 =?iso-8859-1?Q?kvkeokVBdJrO21wXVigXhN7CF4CXneBSn0/CL9LYP3HYH6AyZZ/UxmK8mI?=
 =?iso-8859-1?Q?hitKISq+ndmfu43hE4UIaEg6U8qB82KP0GOuKoLBym8Aon2gk3JCOUAo3z?=
 =?iso-8859-1?Q?BAckNuqCKHu9sBLc3tVMt3tMvjqOoMA3tU44xlhS147B1xCD7G+65yDTN8?=
 =?iso-8859-1?Q?EVo0Q9u+76RmXlijQVoXnUGB1YoPU1hvwUihReIRVizG/F782yFDMAt8Oi?=
 =?iso-8859-1?Q?iiuA1kdBpTteMnY+zfPcjB/jz98aJxNfE3nKYExlbMt9xSSPKDv3ymjs4V?=
 =?iso-8859-1?Q?KE81rOdHiu/k+/FueLcctjYsR/w1W1fDubmFII2IqIyDBCCByzUfCHPjre?=
 =?iso-8859-1?Q?X8Ais7dLADZRMUPA6DxlbyjTRrxSiZ9j/+UpuTBl8ikYgJk5qZb8aMRO2o?=
 =?iso-8859-1?Q?IUeZZ4YqD109JvqiBedb2umsO2QO3nKmloZCFb8nLlc4WYUgFmt6mec0Lq?=
 =?iso-8859-1?Q?2K0TNTtJ50MzuW1iSv27VstLVVE8f18VuA4Evw8CS1wiDEqi+/aWrdfj53?=
 =?iso-8859-1?Q?waknoO2vQ3vCF12j9inJ1gwsJEo4JMsrOYAp39J/PFfRuZaFeac33RcjHT?=
 =?iso-8859-1?Q?ukNY4WQZkRjAhemkZ/RAPtN9ZwxlqC444dCTu0EtvIryrVPVrdvpxoQ5HZ?=
 =?iso-8859-1?Q?Uc/LC5+aP+dHM8jRNjXnie+b9X3wyH41Z2/xwXEHCBNllbO7LL/4+ULhue?=
 =?iso-8859-1?Q?Zkz/mcgPnp3JMiAG8wYI8R2XmwVTxfigy6uIkqRDKwYclAK1+kQz/7hA8P?=
 =?iso-8859-1?Q?Y28FleKfcEeYpQLUzqblUpWrTWdTZecTmSaZTKUXYc8Ry+bgPpCqHqlvvA?=
 =?iso-8859-1?Q?/qqvZUKrLPlLwjaandp5Q2yb4+Aaluv3K9HhW6Ltsn/ooMSy90hcnwNgyY?=
 =?iso-8859-1?Q?PmSN4pOl1hrJo3HQ?=
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-644ca.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO2P302MB0105.GBRP302.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 4ca479dc-3c8e-4f80-d04c-08deee4cc167
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 15:10:56.2434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 
 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P302MB2381
X-MailFrom: realgamehacker@hotmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: KBGL6HXOGMMRJCVD6SE5XB7EMHHPK4CC
X-Message-ID-Hash: KBGL6HXOGMMRJCVD6SE5XB7EMHHPK4CC
X-Mailman-Approved-At: Fri, 31 Jul 2026 07:27:33 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6TJRSDI3M6UWAXUFTEJ2IEMIUAKQURDP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

There is a github project that has started the work for your team by "s3bou=
n3t" titled "ae9_build"
Please get support for the Creative Sound Blaster AE9 added to Linux
Without support at all every Linux distro boot loops with the soundcard in =
the system, If I remove it, it works, I'm not the only person with this iss=
ue of it causing bootloops


________________________________
From: NA NA <realgamehacker@hotmail.com>
Sent: 18 June 2026 00:13
To: linux-sound+owner@vger.kernel.org <linux-sound+owner@vger.kernel.org>
Subject: Creative Sound Blaster AE9 Linux Support

Please contact the Linux Kernal\Audio team to get support for the Creative =
Sound Blaster AE9 added to the Linux Kernal so I can finely move to Linux, =
As it is right now, No Linux distro can even boot, everyone of them boot lo=
ops with the sound card in the system.
If a dev reads this who can add support and needs some kernel panic crash l=
ogs message me back how to get them without removing the sound card from th=
e system or getting to the desktop,
I'm more than happy to help with that


