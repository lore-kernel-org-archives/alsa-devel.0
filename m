Return-Path: <SRS0=H50z=GA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C933C433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Dec 2020 01:44:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED85222582
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Dec 2020 01:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED85222582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 746C8175A;
	Mon, 28 Dec 2020 02:43:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 746C8175A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609119838;
	bh=H994KfKdbTbGZXygbgZy7B/aCMAwJVMRyaybV4W4F/c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VoTcC/Sezvf03tFh11dcYSmDkqLvYN07ie5HSII6R3ijprx8s8l6T8kj1AT4aaLnB
	 0dQxLlXxhSst9YG9zyvh2kVpCPRDu2qNxpYPUf0nL+f6zYOjOAEHa3k09r1mM8irDF
	 XQ3L6wWTB6ExWpFsBKBUOELsw+s12l1mQAQdaeL0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C7721F8020C;
	Mon, 28 Dec 2020 02:43:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 50D94F8022B; Mon, 28 Dec 2020 02:43:06 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A9525F80169
 for <alsa-devel@alsa-project.org>; Mon, 28 Dec 2020 02:42:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A9525F80169
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="kHiT0Lo4"
Received: by mail-lf1-x12e.google.com with SMTP id l11so20889293lfg.0
 for <alsa-devel@alsa-project.org>; Sun, 27 Dec 2020 17:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eZcBu+rBgXs+2kKIeM4w/JJUmA2OcUU8EANO7ALKkGs=;
 b=kHiT0Lo4urz0vqYCHZVyxDtF5e+4AxdwRyth6bT7VJMfMi2DJn5iMuiaiIXZJldYD0
 0+uZoFi6nmHs39w0kQRb/TMcrLWU3N6qCu/or8x7Z99X1FKvcfTeyxvyeSxueRb1ZpxL
 wtyuOo7HRoHkrOyaxd9m6X+fEuEGwuXhOdoUCVIfW9QryP3PkOwKSzIGQVTRDr3UZQjC
 DwPcSTR9TMHPLYjg3DMJeTPQCmraB7KJ6Qs9vNxpJGwUXcxQKByi3sGcI16PAEe8vrSV
 SM7eoq34LcR/sI3cku3XHjlURGacUEYBnOjyRDy9ToY/AUY6xQ89JATVUO0t6SHDSFSq
 Pfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eZcBu+rBgXs+2kKIeM4w/JJUmA2OcUU8EANO7ALKkGs=;
 b=dBkQidQXGFCSrFUuGZvl69pYndx0SxJLQ38ToOH2Do+EUuO5TXZoL1R94aXVAzWb0w
 KQLgB+6Hd+fg/6g/J1EkKPOo1AxWP5z5CwKeyC3uX5ed1XrYXZMSr8Qbd5vVHMbK4LhR
 Nqs76NAW8VEHkRS9ng/aX+NzNpl/psMC6G1rMR8AKHTfm1m0kfyqAzX5kgTeDprbJyij
 sHTWV6HzaMPXrUSK8j0dkWHxDcmKDeRxpTaFHpUcKYK1XIeVi0LfU91g5xyZWA0rGTUD
 +iKm77ok4a14+2cjZt7E3un6qzzRZES1xhWaHL4B5EeiMw9raZUy79IHYNEbRA5k3DbY
 +C5g==
X-Gm-Message-State: AOAM533cxtU8kTKkCkuwWHfraY29jy0VyCcVhKRElO+l1lGrCcwbWV1n
 5xfKZi3GFAvuSMHk3rG+yvwEYDF17cpssupXRl0=
X-Google-Smtp-Source: ABdhPJwsMue0jmPvc/fArIY4c1pYKBFQfOxk4tr5TffnLB6WCpUZfVUWGojkOX1HjtGx5miSZ8lo2MZnMK36TIyCEaQ=
X-Received: by 2002:ac2:5042:: with SMTP id a2mr17330627lfm.42.1609119778455; 
 Sun, 27 Dec 2020 17:42:58 -0800 (PST)
MIME-Version: 1.0
References: <20201226213547.175071-1-alexhenrie24@gmail.com>
 <20201226213547.175071-10-alexhenrie24@gmail.com>
 <s5hwnx3ejaw.wl-tiwai@suse.de>
 <e158d9bb-e074-df76-d267-76756012c6dc@perex.cz>
In-Reply-To: <e158d9bb-e074-df76-d267-76756012c6dc@perex.cz>
From: Alex Henrie <alexhenrie24@gmail.com>
Date: Sun, 27 Dec 2020 18:42:46 -0700
Message-ID: <CAMMLpeTReBwygbLTcu2CxHZAiR3v6pXFwhe5uNriS=s1HowJSg@mail.gmail.com>
Subject: Re: [PATCH 9/9] conf: remove dead code from get_hexachar
To: Jaroslav Kysela <perex@perex.cz>
Content-Type: text/plain; charset="UTF-8"
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
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

On Sun, Dec 27, 2020 at 5:25 AM Jaroslav Kysela <perex@perex.cz> wrote:
>
> Dne 27. 12. 20 v 9:37 Takashi Iwai napsal(a):
> >
> > The current code is obviously wrong and the suggested fix goes even to
> > a wronger direction :)  The function should return num instead.
> >
> > I wonder how this did't hit any problem, so far.  Maybe 0x prefix was
> > rarely used, fortunately.
>
> It's a bit recent code. I fixed the return value now. It's for \xFF not for
> 0xFF prefix. Thank you for your investigation, Alex.

Thank you for fixing this properly!

-Alex
