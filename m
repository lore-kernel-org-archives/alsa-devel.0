Return-Path: <SRS0=reWy=25=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CA6C00523
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jan 2020 09:47:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0514A2070E
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jan 2020 09:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="T8m8CwR6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0514A2070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C888F1718;
	Wed,  8 Jan 2020 10:37:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C888F1718
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578476322;
	bh=ErNbpZPHQl4QxEXnMHorBeBReInJQ+55rHUBfjtf8MY=;
	h=From:To:Date:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T8m8CwR6L8doDzxkpZBcdkDeo0VEfQ5j58N4r+2Oc0et5+ZrwwGrU961427D9bpVF
	 G0knEFiZ1V1rQwb7/HCt+su1Zp+Xn7qyHZrOFeXEoIO/chK/8NSW5ahHHqUMXbk6/z
	 HTgOSdBMRwz2MQhoj4qNYt5jbGFhl0t5NqTqGgjE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 442BEF80149;
	Wed,  8 Jan 2020 10:37:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 671A8F8010B; Wed,  8 Jan 2020 10:37:50 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 33CC8F8010B
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2020 10:37:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 33CC8F8010B
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 0089bg6h008493,
 This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV02.realtek.com.tw[172.21.6.19])
 by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 0089bg6h008493
 (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
 Wed, 8 Jan 2020 17:37:42 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTITCASV02.realtek.com.tw (172.21.6.19) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Wed, 8 Jan 2020 17:37:42 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 8 Jan 2020 17:37:42 +0800
Received: from RTEXMB01.realtek.com.tw ([fe80::a917:b20f:da75:59e0]) by
 RTEXMB01.realtek.com.tw ([fe80::a917:b20f:da75:59e0%6]) with mapi id
 15.01.1779.005; Wed, 8 Jan 2020 17:37:42 +0800
From: Kailang <kailang@realtek.com>
To: Jaroslav Kysela <perex@perex.cz>, "Takashi Iwai (tiwai@suse.de)"
 <tiwai@suse.de>
Thread-Topic: [alsa-devel] Add quirk for Lenovo X1 Yoga
Thread-Index: AdXGBKMUeHaDCEg8TFmHusFrUFmazv//fPqA//95PxA=
Date: Wed, 8 Jan 2020 09:37:41 +0000
Message-ID: <5407c706a98f4a4fa6f04740bed72b67@realtek.com>
References: <6d3af68aa0fe48848c62943e9a342698@realtek.com>
 <e37b9322-5f47-2d8d-45d0-100169300747@perex.cz>
In-Reply-To: <e37b9322-5f47-2d8d-45d0-100169300747@perex.cz>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.105.211]
MIME-Version: 1.0
Cc: "\(alsa-devel@alsa-project.org\)" <alsa-devel@alsa-project.org>
Subject: Re: [alsa-devel] Add quirk for Lenovo X1 Yoga
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi Jaroslav,

Had Your Redhat kernel implement the Intel SOF driver?
PCH Dmic need to enable by SOF driver.
If it had SOF driver, it doesn't need to apply this patch.
SOF could via UCM to control bass speaker volume.

BR,
Kailang

> -----Original Message-----
> From: Jaroslav Kysela <perex@perex.cz>
> Sent: Wednesday, January 8, 2020 5:30 PM
> To: Kailang <kailang@realtek.com>; Takashi Iwai (tiwai@suse.de)
> <tiwai@suse.de>
> Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
> Subject: Re: [alsa-devel] Add quirk for Lenovo X1 Yoga
> 
> Dne 08. 01. 20 v 10:19 Kailang napsal(a):
> > Hi Takashi,
> >
> > Attach patch was for Lenovo X1 Yoga.
> 
> Remove the 'Fixes:' line. It's the different device. Otherwise:
> 
> Reviewed-by: Jaroslav Kysela <perex@perex.cz>
> 
> >
> > BR,
> > Kailang
> >
> >
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
> 
> 
> --
> Jaroslav Kysela <perex@perex.cz>
> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
> 
> ------Please consider the environment before printing this e-mail.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
