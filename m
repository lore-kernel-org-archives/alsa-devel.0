Return-Path: <SRS0=87PQ=ZU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1E1C432C0
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Nov 2019 16:24:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59528217BA
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Nov 2019 16:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="n1Scpv/f";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="QlG8FeOh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59528217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2333F16DB;
	Thu, 28 Nov 2019 17:23:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2333F16DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574958271;
	bh=YwsI+CjbD+Q1ihsYN8iUZIO3WhKyCyimxkPY82F0yHs=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n1Scpv/fP1a+De1zxBJgkg2fydYAw5kfD3BXcbJUM+xl0iv+wIfHySlw2MXv8kWws
	 eBaJevYHpRKpjt9oWCNLi2uSraGtZTb9wSA4Yb6iPaBtNk1Fic52HRdPpVt+dJX6hf
	 6OnOzUkv5GaS0NWkYaiuI5LLuKOKlycKqdLnji1o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 97A89F800CE;
	Thu, 28 Nov 2019 17:23:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 72B56F800CB; Thu, 28 Nov 2019 17:23:38 +0100 (CET)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D7BFDF800CB
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2019 17:23:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D7BFDF800CB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="QlG8FeOh"
Received: by mail-qk1-x742.google.com with SMTP id v19so3540323qkv.3
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2019 08:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=K8XvQHgppYcDW50Z3mxnLcawHzKVUChFD3WmygE8jJY=;
 b=QlG8FeOh4YutiDQZiMigBWumte0ZxgjrWi7dlY33bnq/Pix3ZMtX1PdvOKVeC+YM6V
 lxrYrlLXApqvXBrhyOoLnzvzmHs2gxLXow3B1TDyAVSBreMqKBXpM9D0rUxKCIgt3e5K
 dVIcQkH60qlvG67nXfZ9XOcj0X6lNbOAU6ZR1SoZqh8TiABMtmFSzPr8cP7Gue0ufzIx
 YTBMTIzIV9pHyoC2/ob8S+84iOyOKskZKVkgMAthHjQ4NqU8o2aWVPyESwfY4eEdYbVJ
 dBGpLC278mjZeolaJDHnW4wA1Htx91scXmx5MMsCr20wB9aA0r+VAu2YxJIiLJFHhVmV
 XXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K8XvQHgppYcDW50Z3mxnLcawHzKVUChFD3WmygE8jJY=;
 b=EKJwfaiJcOQG2pdsEjALJ3Rhu1nTE47hQSLL5FT4V1GYNGaHRZkTQStPOVRlPwoUF3
 Z+9403gucwKhfMtAQuGMDPYNb3GdvkEadVUfWV4DWoHUrWFVUuJL371XchQLKnbVRLml
 WqKQ6TODRV9dMSbj0+GuT4V09mbWsx0p6BNYROu7wcnsQqfHCsFvQOCZPozeeldIJAAb
 VR7S2X/HE0ntiamD/VOYwKF4zSuwU91F/egHgI18mxlgQSGok8CDMkbEeN5tHzess9s4
 tTKbNCpUA8rm+pZAH1IKcE4wP2WPy6tuyJh4/fNKBGfkH71U92614hyVyRK6O0EIkeVf
 EU5w==
X-Gm-Message-State: APjAAAU6CDn5ySo73Hq2wjkANP/v9pX+67I4PjWi9IT7cUrRGgTvMWWB
 hZfjxraZYSfwF+YmLj+y1wZaKbh4BnerRCNF0LhuJQ==
X-Google-Smtp-Source: APXvYqz1IJXxT9rTtNsjA/xKc5VDvtDe/wEq74yU0DmldaqtV/JtzOKgaJH1FbCLywxSEXr50xk3GlZCJpAIQ7rTVG4=
X-Received: by 2002:ae9:f711:: with SMTP id s17mr10873263qkg.238.1574958213431; 
 Thu, 28 Nov 2019 08:23:33 -0800 (PST)
MIME-Version: 1.0
References: <20191128011358.39234-1-cujomalainey@chromium.org>
 <s5hlfs0ld25.wl-tiwai@suse.de> <20191128134901.GE4210@sirena.org.uk>
In-Reply-To: <20191128134901.GE4210@sirena.org.uk>
From: Curtis Malainey <cujomalainey@google.com>
Date: Thu, 28 Nov 2019 08:23:21 -0800
Message-ID: <CAOReqxj1V475mbfSEWNn3NrMJDttO+23KjboBR01tGhzAAJmBw@mail.gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>,
 Curtis Malainey <cujomalainey@chromium.org>,
 ALSA development <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: core: only flush inited work during
	free
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

On Thu, Nov 28, 2019 at 5:49 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Nov 28, 2019 at 07:39:30AM +0100, Takashi Iwai wrote:
>
> > For this delayed_work, the situation is a bit complex, though.
> > Usually the work is set up to point to a fixed function, but in the
> > case of ASoC, it seems serving for different purposes depending on the
> > component type.  I guess the cleaner way would be a redirect call
> > like:
>
> Yes, or just separate fields for each.
Sounds good, I will refactor this change and send a new version next
week as US is on holiday rest of this week.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
