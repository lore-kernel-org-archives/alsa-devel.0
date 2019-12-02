Return-Path: <SRS0=OCx8=ZZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648A8C432C3
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Dec 2019 11:10:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E40672073B
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Dec 2019 11:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GRCidJ4x";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaxqxTw3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E40672073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 297761668;
	Tue,  3 Dec 2019 12:09:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 297761668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575371443;
	bh=3khMC8K3PS36VtRdk+skykbe1kdvUhzmCqIJMCVoSz4=;
	h=From:Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GRCidJ4xZ16FGsow0CaPqyjqb0+UudIUW964ISKwdbkgLZJiZ1kX2mXS7djqbJI3x
	 SAXz26SXBquiTg6KBJKdE1wr5xH1O4R4vS/EdP2K2J6qP5++bIftA1QXHKlhB/uk7K
	 PxM7kJMMvwapJbC+gN7JHSf0uSmqd6UA5JfKkjLM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C576CF8023F;
	Tue,  3 Dec 2019 12:08:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DD95DF80214; Mon,  2 Dec 2019 21:29:18 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B1C60F800B4
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2019 21:29:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B1C60F800B4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="VaxqxTw3"
Received: by mail-lf1-x12f.google.com with SMTP id m30so906259lfp.8
 for <alsa-devel@alsa-project.org>; Mon, 02 Dec 2019 12:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=SNBBc9Lie3zy/EUF57jcb0Q68vIv0yQ5xlJEf3YvY6w=;
 b=VaxqxTw3zOgGqFNPIqHwV0uWaaykoYFAwHU49hyZ9lIezLIgrS7DTOj4SpOB6j11lR
 tZvtSLs8AudobC0Y7YoMFd448ipxT6wTsdoywZNrkuw6nCtpeTuf4MU8pC0pHmi+roi2
 UVZSB49ECEjyr0/6oVBFe1EAnbHYBjBKIzuYQfKQBQ3sr1axwkn0e7+AiU2HG6quOHBW
 KyqPIMcgxhpbsU77vPLdEnVbjX0Z1bADDLRbgpBvWRHe2DdYPcWv4gl0r77Osp8u7PlZ
 53ANtjZECYKcAHl5n+iwhKeBYUUfU0ZozX6SqrinnNc1nKUb9b2OsVKRf3jk17pmvMMZ
 uO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=SNBBc9Lie3zy/EUF57jcb0Q68vIv0yQ5xlJEf3YvY6w=;
 b=pa0oUfKg4te24YO6sKz6pWVZB8Ck0pEckwpXjVrrDzg8kmyLUV/1JLZc4NjDk4KRe6
 GJowUN0gFCuJJCbZ5EMAuLTz1lZ78ULUzWeWtqwh//M8ByucOQ8noBu+tbEFAvmTcBg+
 Gdy1dagyDdQsuQA5q7Jg+tn16Ip8l4Tmxy7HKlOjkDc7uSTncPdvJyPjHoV2ICAi/pTe
 bzMSGuqZdROWyXyKTvKqMc41+LMCHDK6EW5AzS5flMXX3ME0huW8ofdkD5r6R9YviKGY
 A1RSYpDdKWG+PERZqGJBAJEyPRz5hxSV2agJuJ3/IWKg2n+o6QUhWitp7W4kCRoPm4jo
 r/gA==
X-Gm-Message-State: APjAAAV9r6DMpiEpEMMBnN1Etxw5f/UACQGHCS6VEVj/0JkLVBLQFqzO
 S3sg5iEvmX3pGTxyb+AoQltYLUMVZHWBm2uxj6zSQyrq
X-Google-Smtp-Source: APXvYqyfRJSq3lEw/qjhiqzNGZUyWtdBw11y3RlnFPwcTR/aAW7p8AH3ateZff32Lv2AW6iSS0VKzH2x68Fvyk6fCLo=
X-Received: by 2002:a19:3f16:: with SMTP id m22mr542356lfa.116.1575318553903; 
 Mon, 02 Dec 2019 12:29:13 -0800 (PST)
MIME-Version: 1.0
From: Umar Dockrat <umarfd@gmail.com>
Date: Mon, 2 Dec 2019 22:29:02 +0200
Message-ID: <CAE08+Qb2DOyLW0_hGJHTOiExf=N5v=wnndu0z018=mBxk82C+A@mail.gmail.com>
To: alsa-devel@alsa-project.org
X-Mailman-Approved-At: Tue, 03 Dec 2019 12:08:10 +0100
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Subject: [alsa-devel] Integrating Texes Instruments PCM1860 ADC
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

Good Day,

I have been struggling with the integration of a PCM1860 ADC for audio
recording. I have created a "sound card" board that contains both a
PCM5102A (DAC) and PCM1860 (ADC).

The main processor is an Omega Onion 2 which is based on MediaTek MT7688
SoC device.

I am struggling with creating the device tree as the Kernel currently has
reference to the PCM186X where X is 2,3,4 or 5 but not the more simple
PCM1860. The difference between the PCM1860 and the PCM186X is that the
PCM1860 does not have I2C control and is HW configured using pull up/down.

https://www.kernel.org/doc/Documentation/devicetree/bindings/sound/pcm186x.txt


I have tried multiple device tree setup's and have only got the DAC working
when configured in isolation, as soon as I add any reference to the ADC
then both DAC and ADC are not recognised.

This DTSI allows the DAC to function
https://pastebin.com/z9H67DHd

There are my attempts at including the DAC and ADC:
https://pastebin.com/RLsKNsiR
https://pastebin.com/rmJVcCz1

Please can someone assist with the correct way to integrate this ADC
device?
Any suggestions on how to properly debug this further is also really
appreciated.

Thanks,
UFD
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
