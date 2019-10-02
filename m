Return-Path: <SRS0=/e/v=X5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0085C47404
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Oct 2019 10:37:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A65020862
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Oct 2019 10:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kg9yo0on";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ij5hkxaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A65020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5BE3C1683;
	Fri,  4 Oct 2019 12:36:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5BE3C1683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570185428;
	bh=S1BBvqAYq00CS2iSwi2mxnSNr6dzI/MSiINs5b/9Fz4=;
	h=From:Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kg9yo0onW/Swtbm3fEIBTm74qaxWRIoexRR2LQx9ZRBK5ywJxbDR5Wue39Wdv7uFI
	 rkBqjcWq4vhYz1oBWJsUcxADdhCkAGHPf0R13FmXqGmHGqSBqrc9QGYx1EtsFCaz27
	 04Ldk31bPCFB5h65Vl7dxdAQB2aFg8mQcyxbwoEs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F3C1F805FC;
	Fri,  4 Oct 2019 12:34:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F37C8F80391; Wed,  2 Oct 2019 15:24:58 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9CF09F800DE
 for <alsa-devel@alsa-project.org>; Wed,  2 Oct 2019 15:24:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9CF09F800DE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="ij5hkxaW"
Received: by mail-wr1-x430.google.com with SMTP id b9so19678975wrs.0
 for <alsa-devel@alsa-project.org>; Wed, 02 Oct 2019 06:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=5DSs7+EH2kSCRkXO7ucwsxgGbTKyfARZx/sJZquknNY=;
 b=ij5hkxaWe6z4lTalWKJddJirkFx45jdPbkHfgAl2Qt5SSxBg4zkf9X5TJLjoX4mw0l
 kwTQsZCtLiu+U8eXCwJ7a3cFkxl3y//OwuKPMEz2lRRnDd4i8Z97ZKxmRx9eqa/iDIxm
 Yd4F7gIvwwsJ+C3+121VTJsb9yRPgstzwURgkv70GDqJ7JhfZuFz8iPCQWVca4IG7OBU
 0sE97JsNUeH+ZB/IThA8iZ4e7uP8+GLfYVdZP3rU2GakcXgyv59MuwdMUqi2+xn1QSVA
 MmasGUg+U113DmnM4l9X4eUlkiRd7ALSOKIEI4aN+8W4oucCLu/hFbGMFg4WxvTN5yKa
 7HYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=5DSs7+EH2kSCRkXO7ucwsxgGbTKyfARZx/sJZquknNY=;
 b=MKtU4fVOxmacC65gL3VAxp5EB9vLgBuAeXccR4FeSVx9oLes1aPs9PorvPApFAzk/L
 cNhHU2jPWIkkZg2RjGVZbf3EfQxIoDoKKrtyUCplEhjxTcQ0k4ZPeIyyLK2sleloHJxO
 hzU9yrR3kOM8LfSje3xIJ8hmlVbJHGVdflx7raq6c4as9icsETl6oAoxZxe6VrgEHxRC
 /eslvN+gPd+QG1p79EEH0j1I4tbq4+KPl73LcTHZ/llkb76mb0/NYylFwI4szjluQ3Hb
 9rmsaiDCLbExqeBm163efxXpQVCx9fqOQwXAEzeZLvQBcHo3Jq7JTK35Mckua/mUtXjx
 xNjQ==
X-Gm-Message-State: APjAAAX7SIKApUOHCr95niRWgPJwYV/A2sFt3pDIESp3Yj2iwhgOZl7s
 lLViDYLRYAL1s7QINkllyvokSsrGvCP+It4Q1jMoNSwP
X-Google-Smtp-Source: APXvYqxDLXVvK8LKs4NObdmmsac/u1eJZ5RKhmzrtwQZ28t902f/5Va9Plr9eJvRw9rXeDH3TpRwGF1aAlYgLd6YV6A=
X-Received: by 2002:adf:f1d1:: with SMTP id z17mr2638341wro.330.1570022695436; 
 Wed, 02 Oct 2019 06:24:55 -0700 (PDT)
MIME-Version: 1.0
From: ed nwave <ed.nwave@gmail.com>
Date: Wed, 2 Oct 2019 14:24:44 +0100
Message-ID: <CACtB+u13jj1_Q1EgyP13i0VCyN9vEjJpsSt8vbhwvbY4q4a7vA@mail.gmail.com>
To: alsa-devel@alsa-project.org
X-Mailman-Approved-At: Fri, 04 Oct 2019 12:34:35 +0200
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Subject: [alsa-devel] Custom Kernel driver to open and use another ALSA PCM
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

Hello,

A little bit of an unorthodox request but I need my custom PCM driver to
connect directly to another PCM driver if possible. I have an application
that already sees my custom PCM driver as the connected sound card, but I
also need to pipe the PCM data within my driver after altering it out to
another PCM of my choice ( my actual sound card ).

As an example, my PCM driver acts as a sound card connected to a microphone
capture application, within the my custom PCM I've added various "dalek"
and other voice changing alterations and now I need to output this stream
into my actual sound card.
The sound card I need my driver to import or connect to is a DAC over USB
and I believe the loaded kernel module is snd_sub_audio which I can see via
lsmod. It's PCM hw:1,0.

So is this possible? An if so, how? Even the most basic information would
be appreciated.

Thanks.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
