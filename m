Return-Path: <SRS0=FEtg=KW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AA4C47089
	for <alsa-devel@archiver.kernel.org>; Thu, 27 May 2021 04:19:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2732A613D1
	for <alsa-devel@archiver.kernel.org>; Thu, 27 May 2021 04:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2732A613D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B13A51705;
	Thu, 27 May 2021 06:18:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B13A51705
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622089136;
	bh=ZfaP2A7wx1EOrYLZmIIjhyj9IxSJ1zLSX3guc+Ew6TQ=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=O2JVnJs8qMxrMT6nXQRQImPQj7ArPZKgJjWZwcvszk6RlfiZ7csOeqUVxvZ/0cXlb
	 JSlulGHToOGZXUH3Y/bNvLmrdmFdKDKQ7Nvkn4DAjhaGp9DtDY9BpmmsUpetRAgEQo
	 QpmCv4hetga3wZTovGW2BJ/8fyFsqeqZQ4qF9jl8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1D85DF8010C;
	Thu, 27 May 2021 06:18:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BBD2AF8012E; Thu, 27 May 2021 06:18:04 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 371E3F8010C
 for <alsa-devel@alsa-project.org>; Thu, 27 May 2021 06:17:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 371E3F8010C
Received: from mail-lf1-f70.google.com ([209.85.167.70])
 by youngberry.canonical.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <kai.heng.feng@canonical.com>) id 1lm7Sz-0007sl-U8
 for alsa-devel@alsa-project.org; Thu, 27 May 2021 04:17:53 +0000
Received: by mail-lf1-f70.google.com with SMTP id
 u23-20020a1979170000b02901d2e8dd801dso1528758lfc.6
 for <alsa-devel@alsa-project.org>; Wed, 26 May 2021 21:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=ZfaP2A7wx1EOrYLZmIIjhyj9IxSJ1zLSX3guc+Ew6TQ=;
 b=UYxQ55glRX4++xBjzPxxa8hyqe6V09MAlOQARjeuj7TS2c4djab1jrxYrfMq/v06CZ
 /+u942vdRO+oJjsYg4rethadki05LBWNrFoB+hNjLVWmPdlNzu/myryrVPkl6o1Tn8uf
 ALto/dzcT9BF8hI2Dr6Xf3jfKWO4pTsleJtqZOoA+z/w0j63ECsBnI9ISGFVfD6uNAYr
 BZTNZzD9s7U57rnlkHOiZnSqFckICFHW9cUZAoJzeP/E3LB0MESkf35Crr1+eMOXDNbi
 qn1tto47BsBtEqOC+YH/rOeloGZP6oNyxlD1utPX9E2Evv1+GGCkRMJHWNEXNinSl/2u
 8E7w==
X-Gm-Message-State: AOAM530dVlFsEkqmvCYLJ0sE1AarMGqzem46yfJRnttInTEJcAT5Nm5k
 meRhwsJyR9SB4g8l3WS2vRGZCu8q0A5F/49rbhEbMMw5K9LIQJ4UFHTHaPpxPIMa9+4ZCX/K3o+
 otR8q1iExNe7bSWIRoTpqSZHpW/lPW6cKNlmK+yx9Ti/QXlc8RLsu5YvP
X-Received: by 2002:ac2:5f6f:: with SMTP id c15mr1017125lfc.194.1622089073385; 
 Wed, 26 May 2021 21:17:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2lCtb6HuMNx/AUOTzRsLeUaHnM1DTBpKtL5+qj5czkVdlXXuvi8xi9wpXmxdFJGyxNde/XAFMobwy64KboBY=
X-Received: by 2002:ac2:5f6f:: with SMTP id c15mr1017110lfc.194.1622089073079; 
 Wed, 26 May 2021 21:17:53 -0700 (PDT)
MIME-Version: 1.0
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 27 May 2021 12:17:41 +0800
Message-ID: <CAAd53p70CJWM1DrMumq8tgoE4o5pPBDv=OAdOCOOJd=B98z2Og@mail.gmail.com>
Subject: Soft jack injection for USB audio?
To: "moderated list:SOUND" <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Cc: Takashi Iwai <tiwai@suse.de>, Hui Wang <hui.wang@canonical.com>
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

I have the need to use soft jack injection to debug userpsace, but
currently USB audio doesn't have that ability.

The problem I am facing is that the USB audio doesn't use snd_jack_*
to control the jack, so we can add the support for USB audio
separately.

It's not hard to add the support if we open code soft injection in USB
audio's build_connector_control(), but would it be possible to use
snd_jack_* in USB audio?

Kai-Heng
