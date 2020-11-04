Return-Path: <SRS0=IYsu=EK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C5DC2D0A3
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Nov 2020 06:20:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1B05208C7
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Nov 2020 06:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Gl0EpzC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B05208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B9D6816A9;
	Wed,  4 Nov 2020 07:19:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B9D6816A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604470844;
	bh=+X3+ccK6Gu8PpGKCJCygG86P7bl+Fk54k8ab9w4p6p0=;
	h=From:To:Subject:Date:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gl0EpzC4lXGuboHAFXRhORGSZioQCdlgk9rAmI7AeOurv33sOGC3R2EqvK2uL7HDu
	 vXV2KkvRGNs9v1+bzv586JmlUz6wDHy/O71H05E7AFZwi9uc+62KF2sXFH0JWI2jrh
	 wzl5q1OJBAdcoyiT9TxZugV1rWjG46mjfuAponF4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2D015F80232;
	Wed,  4 Nov 2020 07:19:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9F155F80234; Wed,  4 Nov 2020 07:19:52 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8FD53F800EC
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2020 07:19:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8FD53F800EC
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0A46Ja5zA027656,
 This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb01.realtek.com.tw[172.21.6.94])
 by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0A46Ja5zA027656
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 4 Nov 2020 14:19:37 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXMB01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Wed, 4 Nov 2020 14:19:36 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.36) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Wed, 4 Nov 2020 14:19:36 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::513b:ca8:6e55:15a2]) by
 RTEXMBS01.realtek.com.tw ([fe80::513b:ca8:6e55:15a2%8]) with mapi id
 15.01.2106.003; Wed, 4 Nov 2020 14:19:36 +0800
From: Kailang <kailang@realtek.com>
To: Takashi Iwai <tiwai@suse.de>
Subject: RE: ASUS TM420 headphone enable
Thread-Topic: ASUS TM420 headphone enable
Thread-Index: AdaxtaxRO3Y6pYlvT6+6jYCrnkWx/AADp1AAACuH/EA=
Date: Wed, 4 Nov 2020 06:19:36 +0000
Message-ID: <3d215da3458e4bc3b0a2586abdd81b34@realtek.com>
References: <3d6177d7023b4783bf2793861c577ada@realtek.com>
 <s5hy2jil51d.wl-tiwai@suse.de>
In-Reply-To: <s5hy2jil51d.wl-tiwai@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.102.96]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Cc: " \(alsa-devel@alsa-project.org\)" <alsa-devel@alsa-project.org>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


Many Thinks.

> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Wednesday, November 4, 2020 1:33 AM
> To: Kailang <kailang@realtek.com>
> Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
> Subject: Re: ASUS TM420 headphone enable
>=20
> On Tue, 03 Nov 2020 08:49:38 +0100,
> Kailang wrote:
> >
> > Hi Takashi,
> >
> > ASUS TM420 need to use COEF bit to turn on HP.
> > Attach was enable patch.
>=20
> The patch seems missing the enum definition, so I corrected locally, and
> applied it to for-linus branch now.
>=20
>=20
> thanks,
>=20
> Takashi
>=20
> >
> > BR,
> > Kailang
> > [2 0001-asus-enable-hp.patch <application/octet-stream (base64)>]
> >
>=20
> ------Please consider the environment before printing this e-mail.
