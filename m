Return-Path: <SRS0=08+G=M7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B07C4338F
	for <alsa-devel@archiver.kernel.org>; Sun,  8 Aug 2021 04:28:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A69A760FC1
	for <alsa-devel@archiver.kernel.org>; Sun,  8 Aug 2021 04:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A69A760FC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zamaudio.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4763E16AC;
	Sun,  8 Aug 2021 06:27:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4763E16AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628396901;
	bh=9Q6E/XK6mieO63EzERQ7XiH/BjrV6XpzAGB7aD0AN6s=;
	h=To:From:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=u0pYFESwnuQX1LkXT0CfqMN6dXLdqbtLom0j9/S8afnvY3RtBhDKMu8gBuK6mzNx5
	 ypkLPRtlJ5NybFGeomr3SAI10+CQCwp0j1b3/WZpolcMSt36GSNEtF0Zzqy86Ntxeh
	 lmTxt3CzxzD8kvqAZAr04EGXoZPuUlzNOFwyelZ4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7C6A0F801D5;
	Sun,  8 Aug 2021 06:27:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 85D76F801DB; Sun,  8 Aug 2021 06:27:27 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 35863F8007E
 for <alsa-devel@alsa-project.org>; Sun,  8 Aug 2021 06:27:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 35863F8007E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=zamaudio-com.20150623.gappssmtp.com
 header.i=@zamaudio-com.20150623.gappssmtp.com header.b="UObPbGoV"
Received: by mail-pl1-x62b.google.com with SMTP id j3so12790614plx.4
 for <alsa-devel@alsa-project.org>; Sat, 07 Aug 2021 21:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=zamaudio-com.20150623.gappssmtp.com; s=20150623;
 h=to:from:subject:message-id:date:user-agent:mime-version
 :content-language:content-transfer-encoding;
 bh=9Q6E/XK6mieO63EzERQ7XiH/BjrV6XpzAGB7aD0AN6s=;
 b=UObPbGoVnblilk+vEDTj0CQjkJbVfn6wPoMyd6x4nf+5Ri3/1i0/7hRcTX+y/8MWCa
 WIxyyhaJz9pZlid5qiRqjtN0KgUW0txraAxuiNxb1kSn9stKQtiOSm2xDS82dX+fPiRc
 w24WQAeRLlrsAk+k3PpKRh1DFAJzTlUjnKUBUZOZktHO8ejPUnwqmFbrEFvyHBeZEEhj
 OMP16pp0wE8GxF84o7rFa/681H5/tTh/G8Cu505FbgmsPbPvOAhVMMxo40VGb1L7n6Ki
 5mry/Y/BRGYFEe7PEtRqPIfUnaR1jCIt+4k9vPsehNfnYb40Gpf4sR0do1nS5b5lvVIG
 JxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=9Q6E/XK6mieO63EzERQ7XiH/BjrV6XpzAGB7aD0AN6s=;
 b=M52SjnWbbGqbHu0FFxNX0Sua/+6/9LKcHrP5Gx7xg4gNwtyZ2ZTjzS6dBqtk/rUcIh
 CD9+/hf0h849hDaoACgfeQLWZ+DyjycGClzNze/o4Mqh2GI2KJlq3YPgm3it0ho4zXwv
 ISCWabA1+JemFGC7CGqAOorY1EQ+AN/MugQzacVlnbz71k7Xey2O4Drt5KQkn7SDX7Tn
 KdSQdY3ysFq1ewGSvGr3C42WfzyebNIScYCLyA4g49gru1tIWTZwG2PjCi3lJ+TO8MtN
 Dz7vsEmAroTq1a1F2kQApdINkrmeKj4IH9TTZfvwiv4/QlrfDM9LLXPFVrIZRZhtemGF
 Y/Zw==
X-Gm-Message-State: AOAM531Uh0JVvWZRbPrP8PIRyTNDfmNiyA34QlxcLEQFa2NQ+JSrR0kJ
 Ad9o2SJDs/ZsKb5IiZOmTMajRw==
X-Google-Smtp-Source: ABdhPJz8YHWDOQqpICfpCXARWiTe9EgHwlFhzvawKz/1KoIvjBaFyHDhfqzhjL2G4S5NV/fDjhXeqg==
X-Received: by 2002:a17:902:ab88:b029:12b:d2ee:c26f with SMTP id
 f8-20020a170902ab88b029012bd2eec26fmr5425937plr.38.1628396834928; 
 Sat, 07 Aug 2021 21:27:14 -0700 (PDT)
Received: from [192.168.1.241] (119-18-22-20.771216.mel.static.aussiebb.net.
 [119.18.22.20]) by smtp.googlemail.com with ESMTPSA id
 l11sm16041749pfd.187.2021.08.07.21.27.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Aug 2021 21:27:14 -0700 (PDT)
To: alsa-devel <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
From: Damien Zammit <damien@zamaudio.com>
Subject: usb-audio: New mixer control quirk for Digidesign Mbox
Message-ID: <628b1c33-9900-a692-89c5-c58980e5858b@zamaudio.com>
Date: Sun, 8 Aug 2021 14:27:10 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

Hi all,

I just figured out how to toggle the input source between analog/spdif on the digidesign mbox.

The problem is, when I toggle the spdif source, the hardware auto-updates to spdif clock sync as well,
so I need to update the other mixer control to reflect the new hardware state or force an update
to revert the clock source, but I need to know the current state of the other mixer control.

How do I access a second mixer control from another one to synchronise the mixer states?

Also, how would I access the current sample rate from inside a mixer control?

Damien
