Return-Path: <SRS0=wzGW=65=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431F5C433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2020 06:50:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC36B20643
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2020 06:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IOBNa9tb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="NhDw5VYz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC36B20643
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 30A2D1607;
	Fri, 15 May 2020 08:49:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 30A2D1607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589525411;
	bh=lAazAiUUZTbr0pEDkoo869HbiGx5mjz22Dvth92MiQY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IOBNa9tbRGi8IBx+J0v3ChS+tV4dMKpqfI4+KhnNhBsGCnJfbQCH24JAjKRuCzxUI
	 QPs7nd0zYaUByN+W1X1FB/xxZQvrZ0ND7bAFoGfvqUFTZqOPQE1nA0U2NqHuMqBBpc
	 dKP1NDg/S6RUNIhrQe6CkZvB4FV1C6YE5tjjdnWw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5EA58F8022D;
	Fri, 15 May 2020 08:49:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E51AFF80247; Fri, 15 May 2020 08:49:18 +0200 (CEST)
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DA779F800E3
 for <alsa-devel@alsa-project.org>; Fri, 15 May 2020 08:49:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DA779F800E3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="NhDw5VYz"
Received: by mail-io1-xd42.google.com with SMTP id d7so1506068ioq.5
 for <alsa-devel@alsa-project.org>; Thu, 14 May 2020 23:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lAazAiUUZTbr0pEDkoo869HbiGx5mjz22Dvth92MiQY=;
 b=NhDw5VYzttGyQNenbMc/ylR7EC1byInlrgUQSa89mC4KHDutwLYcXmg6u2IcwDpnrL
 zX6O0Db67w36Wib4vhPxzx581G0D1rxIAxV57kcjqJHSUYLph1RrjbJUJiOSyu9OxxYX
 HXYgI4naGdq0jkImr1k9vcsDNTG8Crj/F7hIdiFmuvHs1P6+OORneOWrwCG6J7ME0WhA
 Enpne3kgRCpEBCKcFAnvJcNTn9yZS0rhqxmY39IYUxb05gOZnISUS6pACIAV8fM/dcNA
 KFMLMYEbj8QCBxpCoafiCQdpq/muz49eFsQAiKFlq5DEU/ektLrMdDk6K1+EIXPEppI6
 +FyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lAazAiUUZTbr0pEDkoo869HbiGx5mjz22Dvth92MiQY=;
 b=PctH3L5o1h6Tm52f6f7si7ITZRT3+78ph8CIzUiIJYbkzWwk7di7B+GsTSsak/28av
 7OBCZtD9YIqWYycdduk0b/+IvryykQPjr9JdKNIGgYTTCFJ6ZalGvbx5gq1GhSDew06z
 Ew+RMsmfk9qbOtxZybyPqfLWQUG/e+sVqCqrOrnbXzqGrNMbiFyVlnGzcPAIlopHCzl7
 +7HaMczmQeKuOur+d3Ie/elxHVuh/ew0rKyWgInFpzJMqJbzdsHAdOloQep5LVRSiFv1
 l1RKr0XNkH16vu7YCEq4VQsoZcuzjhlfU0xgSc7wKODoyF25mHRszt6wEguHxFvZ2qVX
 F6hQ==
X-Gm-Message-State: AOAM532Av0Wu0rdv1Pl2a0pyPW+rtymZjdoOYDPy3K4KgTCZyZGMPDmd
 PhyXCJPAxJdlq+bLvk6Qt0cda2FPlKdgxG+Fzp/tDA==
X-Google-Smtp-Source: ABdhPJxr2DQlSMvSaZ/UQbXieTwt7s7gOCjwn2Dz/Zxpwh/VXH6TkC1m7rbQ1I/LTYz38byeZJj9ldszky1WG4WV2gQ=
X-Received: by 2002:a5e:9904:: with SMTP id t4mr1624660ioj.59.1589525348149;
 Thu, 14 May 2020 23:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200514161847.6240-1-ardb@kernel.org>
 <20200514162548.GA141824@google.com>
 <CA+Px+wWps5d5qpL_0ed2jrD5bMKgd=8p1rbcRH28J-1SpgVz0Q@mail.gmail.com>
 <CAMj1kXE2KsCoDrH5nY7vmGA6K4ekDTX=v-stj1uh7UHNqquJMg@mail.gmail.com>
 <CA+Px+wV1w4gFcV+ABtK44ec0aPTT9APkpFMUyLMUh5tStgHstQ@mail.gmail.com>
In-Reply-To: <CA+Px+wV1w4gFcV+ABtK44ec0aPTT9APkpFMUyLMUh5tStgHstQ@mail.gmail.com>
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Fri, 15 May 2020 14:48:57 +0800
Message-ID: <CA+Px+wXbHzGajsNQ=W6Smn+uKe85v-wYyEDZ=xYYyrJhHaxZFg@mail.gmail.com>
Subject: Re: [PATCH] SoC: cros_ec_codec: switch to library API for SHA-256
To: Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: ALSA development <alsa-devel@alsa-project.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 Liam Girdwood <lgirdwood@gmail.com>, Eric Biggers <ebiggers@kernel.org>,
 Guenter Roeck <groeck@chromium.org>, Mark Brown <broonie@kernel.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Benson Leung <bleung@google.com>, Benson Leung <bleung@chromium.org>,
 Cheng-Yi Chiang <cychiang@chromium.org>
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

Oh, and just notice your patch title should be "ASoC:" instead of "SoC:".
