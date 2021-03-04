Return-Path: <SRS0=cpFx=IC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5758BC433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Mar 2021 10:05:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09B8B64F27
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Mar 2021 10:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B8B64F27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AA1E61708;
	Thu,  4 Mar 2021 11:04:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AA1E61708
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614852326;
	bh=G8CUkQp+s8Kj1Szfv9jIFYTDPFybxN7hpJaowcwTBos=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VyE8WDv/sjt2jxI11SlF7JdIg1Ns1k0wrwtS5Xi5NQNJpRBfJ2ABEFB996bI4M41D
	 CMWkAj9u2uVZ1JWMmw4fueLJ3vLBiQtlvVC8J6jgcX5EZvIwyuwcw8OSVD2Ug3UUAY
	 5ek2yaH535Vwjcs8DIphqH8VchRAkBv91j92yUPA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 33027F80227;
	Thu,  4 Mar 2021 11:04:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 217B7F8025B; Thu,  4 Mar 2021 11:04:34 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 389D7F8007E
 for <alsa-devel@alsa-project.org>; Thu,  4 Mar 2021 11:04:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 389D7F8007E
Received: from mail-lf1-f72.google.com ([209.85.167.72])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>) id 1lHkqD-0005dC-QZ
 for alsa-devel@alsa-project.org; Thu, 04 Mar 2021 10:04:21 +0000
Received: by mail-lf1-f72.google.com with SMTP id k14so9732402lfg.16
 for <alsa-devel@alsa-project.org>; Thu, 04 Mar 2021 02:04:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Kc1YX2+moqNEiChJAD0LkzYPFpZ2rIkojhEfMRM4GEY=;
 b=axxqGhBDWvU1FKsAhdZo6vpoPvtPSyih7hTosXDGF6urYpnqUib4D82eMIXM87CRp7
 rC039HM1EAyKGpXvGnN8ii3umeVsYt3QjPSdv6Fygz0qlRf2B80WRHN7tHLf5jIElByE
 gS091VIqM8spG/Iad6Qw+Uf5iBCT1II+Bsxih5m+9P+3bjy/gnn5NJNDOfTGmRbrQnXs
 ny3K4sGG0ce3Gp9faeyBH0TJPmxM7ErynsbcL6DKAkgJik2c88SC8EB0Cv9ndkm9p8xT
 OTD8z6sxwomf8Kod70cvOzfxOWn0wxprFjCuVMXpmF2YaZt/OBg8vqBFPZwtQZl18523
 gLKw==
X-Gm-Message-State: AOAM530oW1cFwkayhC+cSqkR8uN4W1xg1cDfI0/rY5AjDbAzNg7KeaXf
 orilGqriEH1waldqCTyNqv9vdKNlZ7+2yawW8IODmmHXqVRv7/c9R7HNCSxG7DdvCm7GPFPbp2g
 rq21xi1dMrYmT4casLYxEdycLij5PvhLKAAGu1x/BAoIRjMqTqrmN3nKX
X-Received: by 2002:a2e:88cc:: with SMTP id a12mr1836040ljk.402.1614852261294; 
 Thu, 04 Mar 2021 02:04:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwJgfxRSqWNtEd/UIukeBG9yHv0tOB/7Oe2lBuCbbPpt6R/MMqcocY1/4GzTVByQ103C6iKqJh8upDmQ9IF2vg=
X-Received: by 2002:a2e:88cc:: with SMTP id a12mr1836033ljk.402.1614852261095; 
 Thu, 04 Mar 2021 02:04:21 -0800 (PST)
MIME-Version: 1.0
References: <20210304043419.287191-1-kai.heng.feng@canonical.com>
 <1ece75aa13b1ab161473dd153598256e58289dec.camel@infinera.com>
In-Reply-To: <1ece75aa13b1ab161473dd153598256e58289dec.camel@infinera.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 4 Mar 2021 18:04:09 +0800
Message-ID: <CAAd53p5n1xqzgmAj9A3oag88m3BSeK+NTP-u-VrJnP2uSh0tRA@mail.gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: Disable USB autosuspend properly in
 setup_disable_autosuspend()
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Content-Type: text/plain; charset="UTF-8"
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "livvy@base.nu" <livvy@base.nu>,
 "dylan_robinson@motu.com" <dylan_robinson@motu.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "crwulff@gmail.com" <crwulff@gmail.com>, "tiwai@suse.com" <tiwai@suse.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "alexander@tsoy.me" <alexander@tsoy.me>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "gustavoars@kernel.org" <gustavoars@kernel.org>,
 "joe@perches.com" <joe@perches.com>,
 "dmitry@d-systems.ee" <dmitry@d-systems.ee>
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

Hi Joakim,

On Thu, Mar 4, 2021 at 5:50 PM Joakim Tjernlund
<Joakim.Tjernlund@infinera.com> wrote:
>
> On Thu, 2021-03-04 at 12:34 +0800, Kai-Heng Feng wrote:
> > Rear audio on Lenovo ThinkStation P620 stops working after commit
> > 1965c4364bdd ("ALSA: usb-audio: Disable autosuspend for Lenovo
> > ThinkStation P620"):
> > [    6.013526] usbcore: registered new interface driver snd-usb-audio
> > [    6.023064] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x100, wIndex = 0x0, type = 1
> > [    6.023083] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x202, wIndex = 0x0, type = 4
> > [    6.023090] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x100, wIndex = 0x0, type = 1
> > [    6.023098] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x202, wIndex = 0x0, type = 4
> > [    6.023103] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x100, wIndex = 0x0, type = 1
> > [    6.023110] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x202, wIndex = 0x0, type = 4
> > [    6.045846] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x100, wIndex = 0x0, type = 1
> > [    6.045866] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x202, wIndex = 0x0, type = 4
> > [    6.045877] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x100, wIndex = 0x0, type = 1
> > [    6.045886] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x202, wIndex = 0x0, type = 4
> > [    6.045894] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x100, wIndex = 0x0, type = 1
> > [    6.045908] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x202, wIndex = 0x0, type = 4
> >
> > I overlooked the issue because when I was working on the said commit,
> > only the front audio is tested. Apology for that.
> >
> > Changing supports_autosuspend in driver is too late for disabling
> > autosuspend, because it was already used by USB probe routine, so it can
> > break the balance on the following code that depends on
> > supports_autosuspend.
> >
> > Fix it by using usb_disable_autosuspend() helper, and balance the
> > suspend count in disconnect callback.
> >
> > Fixes: 1965c4364bdd ("ALSA: usb-audio: Disable autosuspend for Lenovo ThinkStation P620")
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> I got an report from a co-worker who has no USB sound from a Lenovo ThinkPad in a Ultra Dock.
> USB HS is connected to Dock USB jack.
> Could this be the same problem?

It's a different issue. Please file a separate bug report.

Kai-Heng

>
>  Jocke
