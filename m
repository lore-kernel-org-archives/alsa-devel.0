Return-Path: <SRS0=We8V=6G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B40C55186
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2020 09:26:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11E092073A
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2020 09:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FW//zHOy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ZAs2V+lU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E092073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 55E6516A9;
	Wed, 22 Apr 2020 11:25:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 55E6516A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587547567;
	bh=5aeCjWTdqPWPzb1goDChpHsmnqlUMywMUXA0Ei2GBjQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FW//zHOyTT5oMhVrjP8rQx/7oItzZjXHRnGJRs9NyfgxJrNJBw7ExoxibVBLOWMMR
	 wtzadpP1eVcxJHEiTmj5ZTqszBzR//ak/b8HJMTG+VPswOgPsUga7yiV9tH2/adZ/s
	 P4ochzI8d5BKvMGkt67bLoaGS+lstlvM9gfoLWYk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CCE9DF80142;
	Wed, 22 Apr 2020 11:25:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C65C2F801D9; Wed, 22 Apr 2020 11:25:15 +0200 (CEST)
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C6997F80108
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2020 11:25:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C6997F80108
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="ZAs2V+lU"
Received: by mail-il1-x144.google.com with SMTP id u189so1189703ilc.4
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2020 02:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=s2KOo5DN2tQHC0ttBGqJLKqcOpz5bYVgQnDC4CjvClk=;
 b=ZAs2V+lUe93nujpIJ5+JhZZTOeDEONMpOVYNTYGO2doZAzF0TlL7PlDdcFQtLLe7S2
 9N1saTGc1W6HUZ71rpytWhbO8ZMC7fmNWWIk6/6cBmYtXN9riRtBE+WEWTs5ltlg7tuM
 Ghm7zikO8PJDRYS8NOqF61dbZ6/HqHwgBIryRURT4FDOyoOEOtBWfxoB2A9qAXu9B4Gv
 HzQri354TaeTyf1J2sLo4oYCuyNZITBp1kW7k0pKCldiVgWb3TmL06gLeStWT5nPxWfO
 w3AEeCAmYhUmC9MV7OQGTuqnjF4x+AoY81SnbvzVGNsmU/5a93m0xkOO8yssGHAeiWsx
 RKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=s2KOo5DN2tQHC0ttBGqJLKqcOpz5bYVgQnDC4CjvClk=;
 b=ffTvV/oZ3z00ofZvCTwhjRfkEdjjJ0LpjyVSpG908M/xlPXFipDBU+Z9RaLwn3umSl
 OVqy2WeXsuuHP1WG6z+vVgX5w2Q3H/C4NFtOQOv5Z96xZb4OGv0m+SVhyMUkBlFNjnZ0
 yGKbpnck/H6LX1L2AhXbII1p99Dnsrc5GKQUWgNlPBXnfvLmSHeTCDIifhGFAaqCQ0a1
 8BBAjK8kfDembzRTFW7uYWP6c//ZvYmeI432xTiTQ5CuJ65Kw1nrBBYzFwqqQxaYsCN3
 TNLjL8JiOfSF/MCTVJGEC7URsieWGgWzmp/oz00A9HLOQM3CRyMsAJQVlp6KKh3GQLvw
 paiw==
X-Gm-Message-State: AGi0PuYiVBsdTB/Pva7EFBmN2QbF6fAe42w1dumUQBYWzzqgcTDvlw3r
 6eEm9o5xBtvIqort+is5F275RMuZTFIEoLp4p/k/lg==
X-Google-Smtp-Source: APiQypJgyckQ2MQp5BO2H/uyX8MsVT3MvPc+pdQJlBFrT5jjUilrKtVyvlFUQkUOdrUdaQe07WwCX65FWGv4TwcHLlA=
X-Received: by 2002:a92:798f:: with SMTP id
 u137mr11579542ilc.235.1587547505829; 
 Wed, 22 Apr 2020 02:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200422083550.50711-1-broonie@kernel.org>
In-Reply-To: <20200422083550.50711-1-broonie@kernel.org>
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Wed, 22 Apr 2020 17:24:54 +0800
Message-ID: <CA+Px+wUFgz0MP0vwkJ+5L5V5G6AK7-6iDbRuUerFBmwnm-CYFA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: dmic: Allow GPIO operations to sleep
To: Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: ALSA development <alsa-devel@alsa-project.org>,
 Liam Girdwood <lgirdwood@gmail.com>
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

On Wed, Apr 22, 2020 at 4:37 PM Mark Brown <broonie@kernel.org> wrote:
>
> If there is a power GPIO provided we control it from DAPM context so there
> is no problem with a sleeping GPIO, use the _cansleep() version of the API
> to allow this.

Compared gpiod_set_value_cansleep() vs. gpiod_set_value().

gpiod_set_value_cansleep()
+        might_sleep_if(extra_checks);

gpiod_set_value()
+        /* Should be using gpiod_set_value_cansleep() */
+        WARN_ON(desc->gdev->chip->can_sleep);

And the extra_checks is:
#ifdef  DEBUG
#define extra_checks    1
#else
#define extra_checks    0
#endif

Looks like it only changes behavior when DEBUG.

Wondering about:
- Did you get any warning message to inspire you to use _cansleep() version?
- Does that imply in any _can sleep_ context, it is more encouraged to
call _cansleep() version?  (e.g.
https://elixir.bootlin.com/linux/v5.7-rc2/source/sound/soc/codecs/max98357a.c#L41)
