Return-Path: <SRS0=fLcx=YP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DE6CA9EA0
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 18:30:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4824F21783
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 18:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rjvn7OIg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="W/dYLfYv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4824F21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E7FA51607;
	Tue, 22 Oct 2019 20:29:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E7FA51607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571769005;
	bh=IwM6lPSj09uAzIuwLKjPp+zku3V+5eXZmb9kr4aAKms=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rjvn7OIghuUOUj4hQaoqbKy8/jhPe0Zy/p3jShPTmSpZ9mO43wZSTCh5Kz097xLRT
	 UNsTPXXX/Z1cRJ62GtH2JIL56GU3C2wKVGHNArOhBY6R4X4FHFg+ejixVj+8HuTNlL
	 YJ4rOSMftkrLlkC2zfX/cqO6yvC20w1p8g8IeX+A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A759F802FB;
	Tue, 22 Oct 2019 20:29:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4EDB2F8031A; Tue, 22 Oct 2019 20:29:11 +0200 (CEST)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 33CE6F80112
 for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2019 20:29:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 33CE6F80112
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="W/dYLfYv"
Received: by mail-qk1-x742.google.com with SMTP id a194so13128586qkg.10
 for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2019 11:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=px6/z6/y0QbQnKjQ1RxHV8YUHv+a+L/4EqxeJggFLwE=;
 b=W/dYLfYvQpClgmf5k1f30sKtZhSXRDpifCBFeMRSABrl0HQGQl29+XKlKjIK4isBHu
 sV6cNUebcuARNGDE7nEvWEFGiEfierRsjw0wPw4PZ5ipPmwrFpG6XeXe1I0X4O2qZxpe
 A/k2RXF6ejPWIXKk8UMRz0Nj8tyNml1isrXs2hiVZ7INq9I/BfnkuhNgXhzAuNqBth0c
 HJOhjxU6KRAGpewFqL9s1SW1H+J/IB0xPEhiqMmQmQgOX880qj5VQDUJWy+Zipmcvd+U
 Vz2Xi6AaC8uQIGMJ5EF2QW7SokXLKjSZ9to09XkEpxldAcWP3KLo8rn9G4VWpYuOcXde
 jg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=px6/z6/y0QbQnKjQ1RxHV8YUHv+a+L/4EqxeJggFLwE=;
 b=T249cvrTiMceIdtQAjawhDaLhBUYrroL2/YXrSa6iFTjbde3X35mKxsonZToAZKMDu
 wtDzAWrSiBKOhbEFh8G2IV6U3P09zpKXOWgECkw3sDvOINldKaNrzu/0jfLaLtr5j5ZB
 7yb+p8YixHkgD4dZDMYrmpAuSp4F5UNOlm2Ed1JSI/domIXahnAo9+pY2VXH8wpV1FoI
 5vsYDkF+nJrUjo6eSbtZutlVhabGzvsxuBwAzM7huJ71+w1kOc2L1bhxlWoDfP1Hq6yo
 N4LFhiPYvh33GM/IPN7ew5FbUFFYtQrYSsBJ1h2v5kz40YENKuB4ZydoyXj2XQgWIyzy
 pSwA==
X-Gm-Message-State: APjAAAWtzoTo1wk/88bezpCLNocE0n0hHsDdhjLl2vGxElS3UzAmmN2L
 kBaQ56sAxlKUgMvkrqkRNgVQUGSOSfdpO4iVGlcSsg==
X-Google-Smtp-Source: APXvYqyWY1wpv2I18zi0qyxrW5IQAtdG5m4z67zOqPRqrsjByRLiF030lcc8Ro9ah1Z6U5DLzJuI8GE+UHfhLjg0xaw=
X-Received: by 2002:a37:9a8a:: with SMTP id c132mr4426809qke.92.1571768944930; 
 Tue, 22 Oct 2019 11:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20191018200449.141123-1-cujomalainey@chromium.org>
 <20191018200449.141123-3-cujomalainey@chromium.org>
 <20191022161342.GI5554@sirena.co.uk>
In-Reply-To: <20191022161342.GI5554@sirena.co.uk>
From: Curtis Malainey <cujomalainey@google.com>
Date: Tue, 22 Oct 2019 11:28:53 -0700
Message-ID: <CAOReqxiMMWjCnTS=bVBs-tvtfz1GSaHsoBf3PFFvpv000aPyOQ@mail.gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>,
 ALSA development <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Ben Zhang <benzh@chromium.org>,
 Bard Liao <bardliao@realtek.com>, Curtis Malainey <cujomalainey@chromium.org>
Subject: Re: [alsa-devel] [PATCH v2 02/12] ASoC: rt5677: Load firmware via
 SPI using delayed work
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

On Tue, Oct 22, 2019 at 9:13 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Oct 18, 2019 at 01:04:39PM -0700, Curtis Malainey wrote:
>
> > When 'DSP VAD Switch' is turned on, rt5677_set_vad_source()
> > enables the following digital path:
>
> > DMIC L1 ->
> > Mono DMIC L Mux ->
> > Mono ADC2 L Mux ->
> > Mono ADC MIXL ->
> > VAD ADC Mux ->
> > IB01 Mux
>
> This still looks like something I'd expect to be configured by userspace
> rather than hard coded in the driver, what happens on a system where
> someone wants to do voice detection on another DMIC?

You are right, I forgot to add that to the dapm paths, got distracted
by the race conditions I was fixing. I am thinking the best route is a
mux object that the driver turns on but has its route selected by
userspace to the various DMICs. Would that suffice?
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
