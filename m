Return-Path: <SRS0=sipn=AY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAD4C433E1
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Jul 2020 05:47:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 940A920674
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Jul 2020 05:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="l4+Q6eKj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/3YJatC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 940A920674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1198715F2;
	Mon, 13 Jul 2020 07:46:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1198715F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594619226;
	bh=9wI/wahgrpcGGXwEJI6DDCVP4TgfBXzG5ONbrhMQCAQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l4+Q6eKjVT1GhuUg/AvA0xXSYz0uEh1TELwEDQ/lJz5wjU5C2Xj9ywUFxWhGH9X1S
	 C4/SWiw3eLu2m0lHASG861pcUBRI1tO/KUuRNnXzdHnLVCP5DebUvZJm/I+UHHRO5M
	 q2UFgo0UQgw8OzNUMssbAlsuJdFyamVsJmeDyh54=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 82D03F80217;
	Mon, 13 Jul 2020 07:46:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CABBBF8021D; Mon, 13 Jul 2020 07:46:12 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D93F7F80116
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2020 07:46:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D93F7F80116
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Q/3YJatC"
Received: by mail-io1-xd31.google.com with SMTP id p205so3620301iod.8
 for <alsa-devel@alsa-project.org>; Sun, 12 Jul 2020 22:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9wI/wahgrpcGGXwEJI6DDCVP4TgfBXzG5ONbrhMQCAQ=;
 b=Q/3YJatCQENPGHS3j5tNO8vIdrAr/Qb/GXSSJGSyhFkZ/Efn01VyEar9dCNhyrrOFd
 +dc10pETc3Fjn0EDw3Nl+trFhYN8QixvXsMvwWuWhL4LCHrj3g5cF+d+igOFyOpvM9MN
 WyPt43JgTpuFMGbO2JLD2ze1SGUcMaESOLOGbabaCnKnvNK12tAZeJoea2VJHAZ/G74e
 c/3lvFJhRZOg7bcxSNlZY+FBE/Qi3sU7JqHe345umpKi0q4EEO332e1B6dFCyd2MEhgb
 kw5m4UFAGpK4ASBwOVwF///WgGyPrUknn2OrOwX60YZ/FX7wKCWvMdUjHQx1Zwz8+kHc
 x5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9wI/wahgrpcGGXwEJI6DDCVP4TgfBXzG5ONbrhMQCAQ=;
 b=gVJn2uaXd4yCMAs7i1EewsigiQdw5068UD7MzFDDeVgFauxJ8PD3Vz+zJ21txG82/+
 YgRtAq8b5pqXSQOiNpzPJzamen+Uy6Kh9uh8cZHTI34ITg7aAf7y512jtl/tsMyc06u0
 ShE9yL3Mues7WQs0Yvh208RcGXzR/O/IuHkiN2PzKCZW39RKFKnI9RRe0SBmIYOJzL4P
 CJ05kRTlN1jHENIdeNSRQLg/7ExiESc1quV5pUXnpl5ypn9S0HbIm59z4W+d9raBa3zb
 Tp2kKYWMXplAJ2cK2As89LPhtM5x7xDloH3nFfLKmO1zTlzx5HwaIgk2HBh1ikXBkPtI
 9i5w==
X-Gm-Message-State: AOAM53086fHeUDfdjrkyvNmuuAHvztGECEcaWo+WOZulzT1BJenfyYJM
 /wwwnrdLmkLk8EHtuR2Voo1NXdEH+oPM8S/2v5s=
X-Google-Smtp-Source: ABdhPJxneK0E/u9NuBzLyxX0TgWKQwmJ5eiGW2UkW8SLWZtbJTL1gF2g1hQ69vgKn9Zz3yk2Pcq4l6wiNe59DXySLRE=
X-Received: by 2002:a6b:bb43:: with SMTP id l64mr59127682iof.191.1594619162048; 
 Sun, 12 Jul 2020 22:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsN2-TTemU8JOnh3YErxe2GH7xtG+EZrF9gn_JWLmMxRag@mail.gmail.com>
 <98b1ba96fca2c6e1a90ce4120b3f3201a3cefd43.camel@tsoy.me>
In-Reply-To: <98b1ba96fca2c6e1a90ce4120b3f3201a3cefd43.camel@tsoy.me>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Mon, 13 Jul 2020 10:45:51 +0500
Message-ID: <CABXGCsPUeH=YuxjWVd8Fx7j57qtNuBsoxDfO5aE-D3rwC08foA@mail.gmail.com>
Subject: Re: Beginning 5.8rc1 kernel USB headsets (ASUS ROG Delta and HyperX
 Cloud Orbit S) play sound as if in slow-motion.
To: Alexander Tsoy <alexander@tsoy.me>
Content-Type: text/plain; charset="UTF-8"
Cc: alsa-devel@alsa-project.org,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
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

On Fri, 10 Jul 2020 at 17:15, Alexander Tsoy <alexander@tsoy.me> wrote:
>
> You've probably hit this bug:
> https://bugzilla.kernel.org/show_bug.cgi?id=208353
>

The issue already not reproduced at least on commit git 0bddd227f3dc

--
Best Regards,
Mike Gavrilov.
