Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23AAC83F10
	for <alsa-devel@archiver.kernel.org>; Sun, 27 Aug 2023 04:18:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B6840A4C;
	Sun, 27 Aug 2023 06:17:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B6840A4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693109900;
	bh=BABXMPxMneUALd9yAZ4Y+SGWfeNAvDpxE0Y1auJbp0g=;
	h=From:Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=t6/jXhkoEScszNJ/LsUR1Bj96OUnIxz24JX2rqQSmeJw1ct474TkjbbT37KouQneH
	 xsqcKQm7TVFUP12hkrf4CVJE/KQp0EeJNIUp/gA0fl+34Fl2agUmoZQAMOu3kHvjdW
	 Ml2DVoergopBOKa82Hvco04iJYUAffc8GlNwJuWc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 99C8FF8032D; Sun, 27 Aug 2023 06:17:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D6BF5F80158;
	Sun, 27 Aug 2023 06:16:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 396C7F80158; Sun, 27 Aug 2023 06:16:21 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B6650F800D1
	for <alsa-devel@alsa-project.org>; Sun, 27 Aug 2023 06:15:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B6650F800D1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20221208 header.b=VjNpwv46
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1cca0a1b3c7so1537167fac.2
        for <alsa-devel@alsa-project.org>;
 Sat, 26 Aug 2023 21:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693109742; x=1693714542;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yt7H9ySicMeQ6CipjH35qj5+nF/2PyaMgGzn05Vybi8=;
        b=VjNpwv46Ds0oNBdkjzqAcQmeeXEzwAZA0VnMUYxq2xHXIT2KlnzZ82nndTyc4BL7tj
         MC0n8srTzz++vFBulgnkkZfW+VMV+fUYfU4lrNhExo+vt90av/TwTizVFchvjCZbpjEo
         Ge4+q9SGK3JopZ8MStAdV++By+EHrz8EozzNq3LFx6eQbgZvYANOVrScaE4a78O8L8bu
         S98d0/ydDhaTZ4ZMf6tXGpIlZd6qgx+zwbbXq+LtMGOQkmyL6rc8FLddIGYyFCIfXqQf
         7+whShT1TQmiAviWLR9ZYf2Qj58X8JK60uDrMkoyYThTN8Pnj58/gVXjU7Q9fmmQU4ij
         hc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693109742; x=1693714542;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yt7H9ySicMeQ6CipjH35qj5+nF/2PyaMgGzn05Vybi8=;
        b=Sb/xQlByBe9VXNCCzkQBK+2nbxuUw87/3mqtaj7wZUutFUtSzvvSCekdRRVWg0g2Rg
         MVBlGJ+CRtlA7YE4ZmPP2037XFrNgsf7BaZKIn352Ri7cK+B5XcUJ2qwSpM8hKSI2TMl
         +DedPCiiTLechIiksUfzXBSflixqymi9/I856erracfQqtnS3hsXWoe+A0/DvA1zdXb0
         lkXh+oC2lv4B0KEEHSOITXbK5I5uOs1K5D37U0pTt9tUJiye+pQKrYJ5r/XETIT8aoZT
         zsE3Bv+s3bphKm0pRE/KYgHTbkuYaapSodQr8eX/9huIfdrh1gUooVb5fSCYcSM/5CuS
         kaUA==
X-Gm-Message-State: AOJu0YzqyicvDZTdJed7xflzlG0lqYG5ATF9UHsrwlrKV7dj/WeLGmlu
	vcVtGGbglWJDSwE1XZDGI6XwSy9zxwhgqPqgvfs=
X-Google-Smtp-Source: 
 AGHT+IEoUvPk6fAL1zO2iNnHtZ/RsuPPopD1xHzzPzFvrD7UL4pz6gUMFIOeL8dZvsFYOgbLk6j47OuViMRaG+7y5H8=
X-Received: by 2002:a05:6870:d60c:b0:1ba:caf2:acc3 with SMTP id
 a12-20020a056870d60c00b001bacaf2acc3mr7407554oaq.5.1693109741964; Sat, 26 Aug
 2023 21:15:41 -0700 (PDT)
MIME-Version: 1.0
From: Adam Ford <aford173@gmail.com>
Date: Sat, 26 Aug 2023 23:15:30 -0500
Message-ID: 
 <CAHCN7xKQ549ExO83Yur=_MPv3aYFdR0nfzUSuEXO74OddAr5gQ@mail.gmail.com>
Subject: Question about simple-audio-card with dummy CODEC
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	ALSA Development Mailing List <alsa-devel@alsa-project.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID-Hash: OKTQNE6QBHKDKAEGMN4OVILBLMMAL2XZ
X-Message-ID-Hash: OKTQNE6QBHKDKAEGMN4OVILBLMMAL2XZ
X-MailFrom: aford173@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OKTQNE6QBHKDKAEGMN4OVILBLMMAL2XZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

I want to use a PDM microphone on a variety of i.MX8M (Mini/Nano/Plus)
boards with the simple-audio-card driver.  I can get this device to
enumerate when I use "fsl,imx-audio-card" and it appears that it
connects to a dummy codec:

sysdefault:CARD=imxaudiomicfil
    imx-audio-micfil, micfil hifi snd-soc-dummy-dai-0
    Default Audio Device

When I attempt to use "simple-audio-card" with just the
simple-audio-card,cpu  sound-dai node pointing to the micfil cpu
without a codec node, nothing appears in arecord -L, and I don't see
errors.

I am guessing the simple-audio-card driver is expecting a CODEC, so
hacked soc-utils.c to give soc_dummy_driver an of_match_table and
assigned it a corresponding 'compatible' name. I then routed the codec
node on the simple-audio-card to the dummy CODEC and it enumerated
just like it did with the custom fsl,imx-audio-card driver:

sysdefault:CARD=soundpdm
    sound-pdm, 30ca0000.audio-controller-snd-soc-dummy-dai snd-soc-dummy-dai-0
    Default Audio Device

I am asking what is the best way to let simple-audio-card  use a dummy
codec?  If the dummy codec is the better option, what compatible name
should I use?

adam
