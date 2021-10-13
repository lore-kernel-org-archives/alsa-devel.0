Return-Path: <SRS0=EWQz=PB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011CCC433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Oct 2021 03:11:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D13A060FDA
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Oct 2021 03:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D13A060FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 465891674;
	Wed, 13 Oct 2021 05:10:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 465891674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634094708;
	bh=WSy//ILf/QfOX4AsrXzNmkR13YV5pD9s3p2reh90ceQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U575W1vK3roBCLQ78aFP8CTzEKGgv5YMBR9jFHOxI994xbnFd9t/SRJHlbUsqr4Vm
	 3M1JZEPO/vdi6c4jneaEIjFUhSdz8Oz3ebMsnA1oZcvjusdUTZ2IJEQ2hjGABa60Je
	 5XCXGs/G2IDS+aeokAv10re6jUNC7MUBYvsVHoLA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AAB7CF800C0;
	Wed, 13 Oct 2021 05:10:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 504B2F80269; Wed, 13 Oct 2021 05:10:52 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F1A02F800C0
 for <alsa-devel@alsa-project.org>; Wed, 13 Oct 2021 05:10:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1A02F800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="JOc3Vzh7"
Received: by mail-qv1-xf2b.google.com with SMTP id z3so879783qvl.9
 for <alsa-devel@alsa-project.org>; Tue, 12 Oct 2021 20:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hF50jopThZcpb/r5CrV+DzJwIbUB5o6C3T/+nzD13DY=;
 b=JOc3Vzh7ZX1SboeRVjFtkEYohl4iZaI9Du8OEaD7eLsyeDWkakksUsYD2pY3gDE8rF
 vgoZQQDPYbe+acZsBZWgUDgX38DIQipV20UhBW+rvR8JWBocjTKY/WE4DI18jnLNH44D
 W4/ocbVJ//IM6nQ2H6MoRG0e/meXVS+FXfbKfgO22rTwVpbs+PbyUIuR8GoKU78T+m1H
 X9FjNCaevr/+tKl4oqJagKL2fwqJE1XHv6fI3gAKL84rEBazL8fcxS492aST5ksqY6mf
 m+y5tXGRL1EpdusgQbcWqaZN4cZ8QgHZaL02Lf1JaJ5+T0oQe7srpeW753zy4Se1/n/6
 jgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hF50jopThZcpb/r5CrV+DzJwIbUB5o6C3T/+nzD13DY=;
 b=hRl2R8POcJaXQB6BeWRTqHwZz5aSuBvx8fhsD4/JUbm1QWOwjVYLLc598/dnQpIe2Q
 KLQqwRxJXAFkagNMK6L++uLLfTHdSvqkCD/WTKtfuSb1hsR0aHF0CwTNboWYXESB6bUx
 mp4JL/Iipyh+OSq8D9IGj1+FwmUwnu0jsCuz8eguPstb4n1NWrfQXiVTjLtYCGS9GSdK
 eoy5PILf2zF0kUwTl2hZbbmtgXtWhl4MmcVOCpaTfV/oM6HCUJWgfyDpsPvVjJMNvgaN
 kr0Cf4CpICdR3qWFmGvHToA8dzlMCVACjWLXyYgkLT83oRel831h0LN0HOC5+LbFkuLV
 6AbQ==
X-Gm-Message-State: AOAM5315nb02o1t88OkFZ1bKOJGeN55YMufpODvZFwXpvWExNP5NVB5l
 INcXJMoyaaBp9xjwY44bJrRmQTEUdFh5UWrA7/I=
X-Google-Smtp-Source: ABdhPJyUCoEYf9vU1HZOfFPQGxlq27mKUv9xPE9tH/LsYkxkMJWAFI9sABP04eFMUavpXjRLqglJC0Gvu461dJnbPlE=
X-Received: by 2002:a05:6214:154d:: with SMTP id
 t13mr29391720qvw.40.1634094643983; 
 Tue, 12 Oct 2021 20:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <1634036070-2671-1-git-send-email-shengjiu.wang@nxp.com>
 <YWVwk1kqyF+gzEC0@sirena.org.uk>
In-Reply-To: <YWVwk1kqyF+gzEC0@sirena.org.uk>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 13 Oct 2021 11:10:33 +0800
Message-ID: <CAA+D8ANNMURSAvCtmfoM6ReMQAQ+vgX5syYOy9C+C=-BXgw01Q@mail.gmail.com>
Subject: Re: [RESEND PATCH] ASoC: wm8960: Fix clock configuration on slave mode
To: Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 patches@opensource.cirrus.com, Shengjiu Wang <shengjiu.wang@nxp.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>
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

On Tue, Oct 12, 2021 at 7:26 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Oct 12, 2021 at 06:54:30PM +0800, Shengjiu Wang wrote:
> > There is a noise issue for 8kHz sample rate on slave mode.
> > Compared with master mode, the difference is the DACDIV
> > setting, after correcting the DACDIV, the noise is gone.
>
> Charles suggested some updates to the patch to improve the error
> reporting here which you don't seem to have addressed.

Sorry, it seems his mail is missing from gmail. I find
it in my outlook now.  Let me check his comments.

Best regards
Wang Shengjiu
