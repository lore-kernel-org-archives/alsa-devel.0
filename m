Return-Path: <SRS0=KNeL=FW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40EAC4361B
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Dec 2020 09:27:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 378B623A7B
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Dec 2020 09:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 378B623A7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BC51D1740;
	Fri, 18 Dec 2020 10:26:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BC51D1740
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608283643;
	bh=grqt+/2NpvOBi+Rz0mu0GIFr8nVX51Z8A8ZLDd47hU0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=USCXWoQTej58yQ7+acy6WASrr+oDo3MOdrCo+re7T1HIqdUMDSXgQtpyTdtE7D6GP
	 22Xy2j7i+O2IlZfAxRtiSjDHXMFzTNEt1B8mq3lZt82KrNNXrTrHo7Ct+XrTCnfUNQ
	 rxBKV4VNCyUGvyshb2q76qho/yRxXrI8EUvtYxGg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B03BF80171;
	Fri, 18 Dec 2020 10:26:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ACB17F801F7; Fri, 18 Dec 2020 10:26:31 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 03CC5F8014B
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2020 10:26:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 03CC5F8014B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="iGJ9phAY"
Received: by mail-pl1-x631.google.com with SMTP id s2so1088523plr.9
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2020 01:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LfDyodGn3N3GaioGbWMxSs/AYkOdRXx/deQPhKaF5KE=;
 b=iGJ9phAYcDsQ/ghqlkKDNly4h+b07zMSzgfl/GW9LHxp2pWHqoAejww+4Babny0KNZ
 Uc3HCHkYxxjDENWVr453yRiCfhA/LQHWF23W0Ng9f7LpEA7pltyG/mvIG9fCyBqjohVD
 +mD1Urii0vTqsYWWsWhF3ka6Rf8lR+R0T1BzMZD4m3py2gQBN47ycsoVrR+yT+hEPAk2
 sxqBXBj3o+dKugfY92mGauhIFBNBc8xQpfadY+GDCMERf/Zg2bsREsGrs0HgNZLfSkF0
 z81KsaL6u/bYU3YsdQJj2F0BeKFiAtLUk4PMy4U4JeayppXGrKGUjLE/34qXvRYFcO3Y
 cU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LfDyodGn3N3GaioGbWMxSs/AYkOdRXx/deQPhKaF5KE=;
 b=pykB9eWBKZjKC+kpq6YMsoZKkXxLPFZlddeQg6EVjVMaKbLCCnC5j36DBGcBUxhQM9
 IilYiKgiE7IZRnFSM1Rv3eN38zEPGL1U2UMogYqlmnWRLL5g7R0yPXtGBk4Aax5T8eId
 t4Yc31CcoBJiHfe2hlnWvo6cgtfQMasMXcTMAVJrRtjwwT7tw6FM+Fnwn1TdigIfzOqT
 Z3o3Uxn20NutlOJ4NbtTUquxbOB1hKmSn9itMIM1EKoVldp4urYyflNxQyAIcy9lbQYS
 jOxFcOXgybbYRITELIFtDXJ1QRTFiloXRX8N+UeTSaGK4r0yyNqWdpRM1TXQ2SIH3PIc
 OijA==
X-Gm-Message-State: AOAM532GTz+V4qUdwmXQQH8Vgi+6gBT0oA/cD2y2ULYp15KERiBM7Y3N
 i4293AMI+l+tmi+3JZxpp5IbiIeEKAH0wwcgXyw=
X-Google-Smtp-Source: ABdhPJwwH/dcdOsRWtUcK6WJfo+jpRpBk6SDyEEyvON3y8W0MxZLS4Q6JCodYmPLojEBRrQABgpFp3UDr7vsolazf/Y=
X-Received: by 2002:a17:902:ac98:b029:da:cd0f:b6a4 with SMTP id
 h24-20020a170902ac98b02900dacd0fb6a4mr3604564plr.71.1608283582360; Fri, 18
 Dec 2020 01:26:22 -0800 (PST)
MIME-Version: 1.0
References: <CAE5BBpTEw2pTzDhLxaQiGwAvnH_q6aChLkuDXxEQrZFvS6wVyQ@mail.gmail.com>
 <s5h8s9wn4lr.wl-tiwai@suse.de>
 <CAE5BBpTbyjkd--Nfcqpv01wYyScEgXJSQETYhWyUH9-qPKYw+g@mail.gmail.com>
 <s5h8s9wlj86.wl-tiwai@suse.de>
 <CAE5BBpQpWkLqVFbPDjiOEqA85Pht_g+YEkpnhpdAepQkpLMfEQ@mail.gmail.com>
 <s5hy2hwjzcs.wl-tiwai@suse.de>
In-Reply-To: <s5hy2hwjzcs.wl-tiwai@suse.de>
From: Marco Giunta <giun7a@gmail.com>
Date: Fri, 18 Dec 2020 10:26:11 +0100
Message-ID: <CAE5BBpQKbmzift4SZShcG7oSh1ZQwj6Fo_1eDUko153V8WTQHw@mail.gmail.com>
Subject: Re: [PATCH] Fix mic sound on Jieli webcam
To: Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Cc: alsa-devel@alsa-project.org
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

On Thu, Dec 17, 2020 at 3:12 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> Thanks.
>
> >     Interface Association:
> >       bLength                 8
> >       bDescriptorType        11
> >       bFirstInterface         2
> >       bInterfaceCount         2
> >       bFunctionClass          1 Audio
> >       bFunctionSubClass       2 Streaming
> >       bFunctionProtocol       0
> >       iFunction               5 USB Microphone
> >     Interface Descriptor:
> (snip)
> >       AudioStreaming Interface Descriptor:
> >         bLength                11
> >         bDescriptorType        36
> >         bDescriptorSubtype      2 (FORMAT_TYPE)
> >         bFormatType             1 (FORMAT_TYPE_I)
> >         bNrChannels             1
> >         bSubframeSize           2
> >         bBitResolution         16
> >         bSamFreqType            1 Discrete
> >         tSamFreq[ 0]         8000
> >       Endpoint Descriptor:
> >         bLength                 9
> >         bDescriptorType         5
> >         bEndpointAddress     0x82  EP 2 IN
> >         bmAttributes            1
> >           Transfer Type            Isochronous
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0100  1x 256 bytes
> >         bInterval               4
>
> It's 4, and the same is set for all sample rates (8000, 16000, 44100,
> 48000).
>
> If you don't tweak the datainterval, which error do you get?
> The actual error message should appear before "... xx callbacks
> suppressed" line.

Without the tweak, only error messages are:

kernel: usb 1-8: current rate 0 is different from the runtime rate 8000
kernel: usb 1-8: current rate 0 is different from the runtime rate 16000
kernel: usb 1-8: current rate 0 is different from the runtime rate 44100
kernel: usb 1-8: current rate 0 is different from the runtime rate 48000
kernel: usb 1-8: Warning! Unlikely big volume range (=4096), cval->res
is probably wrong.
kernel: usb 1-8: [3] FU [Mic Capture Volume] ch = 1, val = 0/4096/1

but recording from mic at any rate (8000, 16000, 44100, 48000) results
in an incomprehensible sound, like Minion voice.

With your patch 'ALSA: usb-audio: Disable sample read check if
firmware  doesn't give back' error messages have gone away, but result
is the same: Minion voice.

Thanks,
  Marco
