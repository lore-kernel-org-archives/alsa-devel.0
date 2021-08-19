Return-Path: <SRS0=W9hU=NK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F45C4338F
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Aug 2021 18:44:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60F80610A5
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Aug 2021 18:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 60F80610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C39EB1678;
	Thu, 19 Aug 2021 20:43:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C39EB1678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629398664;
	bh=JmnXvtA27f3HNWDeH3joOjOLqfHZmsqnbaeRmH4xmZw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kHWD2IJ7B8v6Xu3k0b1vdIVsbcbMsCdZ28SiG9rSSOywlLABrWoyirOJTKuyazPhY
	 eFfcmmGfr2AppIStgWpdf3vjT9E2td/UVOBg3uDNOqQMUN2ICfBVlrRqLMdOV0BMKI
	 KOnkpPRjnwRRFsqZSp3fVxAZqJ0+28ojkbdbUNow=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B1D2F800EC;
	Thu, 19 Aug 2021 20:43:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 55CC0F800CC; Thu, 19 Aug 2021 20:43:33 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1023BF800CC
 for <alsa-devel@alsa-project.org>; Thu, 19 Aug 2021 20:43:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1023BF800CC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="WEgNjKT+"
Received: by mail-lf1-x12c.google.com with SMTP id o10so14937902lfr.11
 for <alsa-devel@alsa-project.org>; Thu, 19 Aug 2021 11:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=c5zVDBtjJvuw3n2j1usmurBdgybO6iB7zH3x0zJhcS4=;
 b=WEgNjKT+jKwxfCEmWRVI5h0DSy7dl5DMhsaDoroFmJ3u/m9OVUvV++QiAIf/uv07Vx
 UgCHHJM8/tzRBd64tdY1DHXg2J6YFyS9afWAXBshYv41dUDsCUOd3lyBEaMdu7RcmVXD
 FyP9KM5+gO2z1y4lqewUHkpmMT4If8VElioNLlkJV6FJGON2XZD/ZNLUjZXGAS61VwtW
 VRJssnpxugFHB8Gp0w4y4aujqlWGFzfFXZdGXcroXH8rOw2baF28ZY34ow1lyhvTdIq2
 UkM2kHjYmI1bc3xRO7ONcylSmWRgAYEosO6j4dtIKelF4ECg/QYLN1uPWZJFDGfUBAV+
 IrXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c5zVDBtjJvuw3n2j1usmurBdgybO6iB7zH3x0zJhcS4=;
 b=aYJwYURm8vOP7TiiFmFabCvzfZej1rD79Qu5dF72jsBR1xaZ7vtsOaWf1ANIs6FjZF
 cZ9VRsqBcJnyJxLQn9sYpn+PcyGx3VVBinxqyl6OuYHp7ibOmIpcdCr0Qp55cZoivvnZ
 HCKyq1cQ6XIS2ijqpDXOdyPxX1wGHfEKc953t5bo58j9K0cIMjKGOZQWf3k0HYaDtVUC
 Xi8v+z8xRGLWM5YggtvOdcmcsxCN4xm0SUaLMOsmyCQvBHdLrpvYR3KQ1OWAk6IHpDzc
 62FltOhkXLnPRSz5Ip6pss6rqkdvDtRb9OEX5b3dnVV0GAnJ9nm6RbWmrnYLS5oDQ5es
 ARIQ==
X-Gm-Message-State: AOAM533epe3KR8/rfa8MyUvIgaGkj8rhygOOwnNqqRmqR1T0CI5zWCIY
 ELQudo6QbAwbq01uQ6eHK3oupCMNTeBzwVkOMq0=
X-Google-Smtp-Source: ABdhPJxUzOlnMgY2Xdmm/PplOzBYb7NTqWgZaPz2PooQD8gxWkgavsv8Or3bWWSGtbw0Tf1hGHj1DFX0KsURLA/wcGM=
X-Received: by 2002:ac2:5470:: with SMTP id e16mr11552167lfn.399.1629398604609; 
 Thu, 19 Aug 2021 11:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAAd2w=btf3DZLbPuovAC9xo3rizmFeT4iAxJs6zNZwKxOnKT6A@mail.gmail.com>
 <20210819183450.GV890690@belle.intranet.vanheusden.com>
In-Reply-To: <20210819183450.GV890690@belle.intranet.vanheusden.com>
From: sujith kumar reddy <sujithreddy6192@gmail.com>
Date: Fri, 20 Aug 2021 00:13:12 +0530
Message-ID: <CAAd2w=YFhiJJ=4nqo7JfbrqdNWVxvSp06E=1XiHOXV8Kp2sgaQ@mail.gmail.com>
Subject: Re: arecord is failing with -V stereo
To: folkert <folkert@vanheusden.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
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

1.2.1.2

On Fri, 20 Aug, 2021, 12:04 AM folkert, <folkert@vanheusden.com> wrote:

> > arecord is  failing vumeter option -V stereo only.
>
> What version?
> Because the commandline you provide works fine here with 1.2.4-1ubuntu3.
>
>
>
