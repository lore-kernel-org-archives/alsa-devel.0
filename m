Return-Path: <SRS0=p6mo=LY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB315C11F66
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Jun 2021 23:42:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 392A46142D
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Jun 2021 23:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 392A46142D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9D10D15E5;
	Thu,  1 Jul 2021 01:41:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9D10D15E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625096558;
	bh=1a1xjYyAxAJukVlOWgAQ3qeB6p+FGxo20u3NzOJY/MQ=;
	h=From:Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HgfrLbbat4HCS+2XYkBOjmrnqTNbPhw8XyX7NJMTPy5J8Zrx9U1FYPNt/fterv+8M
	 Ib23Nv8M2nHQk9eze8oU7JRl6bmQrZQl8e1L7QOlAyxXlMJ8mDxDtmaxzE26Yv3T63
	 pGCxsHqTup+7H8BUhDRLhKuQGK2Bi8HjiBkeTOeg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 41629F80217;
	Thu,  1 Jul 2021 01:41:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 416A9F80229; Thu,  1 Jul 2021 01:41:47 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E88C9F800BA
 for <alsa-devel@alsa-project.org>; Thu,  1 Jul 2021 01:41:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E88C9F800BA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="VGPacmbi"
Received: by mail-lf1-x130.google.com with SMTP id a18so8256021lfs.10
 for <alsa-devel@alsa-project.org>; Wed, 30 Jun 2021 16:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=iT6ND97dfk1N1ou/NLd8RsXm1QHsVroYIyzxZ1twf0M=;
 b=VGPacmbiMrlFdJugR+OtBhElHikylG9x6knAXSDLg3j4jZ2nWC+loYL9k/xhGRlzv9
 e63kmeFwqiH8TYfhpIjSs1f00JEI7mu5xMisxgR/JdPteq09HeBOZ9WfWH39qsUugJQ4
 Gosbuijezz0kJp5Ogg6PeqDorrF+v3M1WCxnqzT3rXH49NLZreoansGSiRmQSkwr6BUq
 zK7AOncK9GoS4Joe+73+avHsHkQW/6mBt9UrJ3Vwijyt0gs/DdB2fHkzhTyhA+EOv3wa
 LCIfxpR0hXKTYjmdfoWgD8663DMJH6f/UXKrt7lq0HKsazVWez1TdLpo20EVeK9iWG3G
 CZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=iT6ND97dfk1N1ou/NLd8RsXm1QHsVroYIyzxZ1twf0M=;
 b=mJ0eeAjVWaysxKMPf5irktKnrrnX0iPyH3ux4rOle8jUfJVYNkZ2KcEX7H7LGD+6pX
 mDrTEuzG5rc8wQjvGk+bwv6d3eNU5M46D54A6pZ75qbKtugbQjOwHwJWPfv+Y2olOnXM
 86PhaQ/2dFgLcIr5s3UH8CCVrqgBI1i40W9XUyWDMf/K2NSq5gPETyTuCpN+mTy/pmnu
 F8za+IlQhR+J7ncD0syP0eDJ9UkVQgs6uWiWz7BIoNnUAOluTCjjso3E8R1v6kCbOb3h
 gPb3MfoASgxfSr+noXoBFhAy3WelNzDB/8KcR+xt2+ybd10SwOCWSxZja1iJRq53SlYO
 r79g==
X-Gm-Message-State: AOAM532RlWCnTeBrL2EYBpZmqiQeEM3ioZL4YjniD5FhskgiOS4pqmNG
 5JoOk2tjktpJAkZkUScesHwPKSbJqGPduyBLaoRxwLIU6Cc=
X-Google-Smtp-Source: ABdhPJwYoHX2P9Y5kEUgsq3B5Bx9h6c2pBtvvlrFXz3FzGYniWz92oC9dA7jq87L2r5wJOtVSaLe5ovWgI29WZNf/Bg=
X-Received: by 2002:a05:6512:219:: with SMTP id
 a25mr30871315lfo.295.1625096500364; 
 Wed, 30 Jun 2021 16:41:40 -0700 (PDT)
MIME-Version: 1.0
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Thu, 1 Jul 2021 05:11:29 +0530
Message-ID: <CAHhAz+h9=fMu7jLfmzZF2XMWAT=JBLik2WSSbfYtLg3kmzqWtg@mail.gmail.com>
Subject: trigger timestamp
To: alsa-devel <alsa-devel@alsa-project.org>, 
 kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
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

From the user space test application , Is it possible to get the
trigger timestamp corresponding to SNDRV_PCM_TRIGGER_START &
SNDRV_PCM_TRIGGER_STOP events for audio playback capture?

-- 
Thanks,
Sekhar
