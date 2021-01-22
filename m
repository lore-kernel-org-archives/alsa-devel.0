Return-Path: <SRS0=81m9=GZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9729C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Jan 2021 09:38:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46B2E23381
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Jan 2021 09:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B2E23381
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C67881AA1;
	Fri, 22 Jan 2021 10:37:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C67881AA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611308322;
	bh=mT10cRAlQ2WyxJl9YOeNYjla5OUEaHit6SiRMVwGCmk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FYG5gzX+X/WsTkokdApgXABLrz8TNnDf3CB0FO6LytCJoM80/WKoL5kXXOugOeesA
	 4fuL6UFXCDS8pq2zFil8O6VOhkLc9ue78y7yH8du8jetu8ZLuYDFgnRNqP7rkanbpt
	 3RDJmlk2Wp7zeg+3oDLJdFxLD4YiNtd96AtB3E7E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4C155F8015B;
	Fri, 22 Jan 2021 10:37:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BDC31F8016E; Fri, 22 Jan 2021 10:37:50 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6721DF8015B
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2021 10:37:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6721DF8015B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="iLGiLMWp"
Received: by mail-pl1-x62e.google.com with SMTP id u11so2848636plg.13
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2021 01:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eabF0vmgV5BknvbMvwMNjuPhnWV49Xa5l1tuh416Y4M=;
 b=iLGiLMWpMt1a+zS7icPwESFH0siR77/NwauBYEYPHgfK7xrfZq3guz9EAIjWync6x8
 bjWJyJa73JStnfOBml+jbNrw5uq5tGIGiLTxAnGZ6vPNLbzHGbjiwotavAeoY6ZP0S55
 W6I/92vmoykmjI1Hz+AzLPbf5IJ4o2Nj4zSOn8jhDXCRyiclqZzWBEecyvsyeOgH+eo1
 vAdLlG4ehx8fXpnIGpJXnXoJfbNW+0q+JqsNNraMkF6MtX0kqXxzDRyMeiHYS2rZWQmG
 ktMCcs7qFu8gjr3qqPob9gkQFQxDOAE7aYdHgztH+EDCVeut6yWANYgnrL4Lee2KXKN3
 P2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eabF0vmgV5BknvbMvwMNjuPhnWV49Xa5l1tuh416Y4M=;
 b=aTJV5YGXX0I4jE855qU69CCH64+EiyiNNxCcwsUXlr7kWFu+HQA/lmPihBAPWMgCuR
 R20UQT3vJ0InXwWaSHQs87W/h5egElO2tct80mGgbn2aAxqmPL6YgFm3ZzIIhHAwq1sv
 DVlziu3JYJZPzy6O+ex9BLW+TEEYjeLypsI5T/0DNg0a7alDmosO4sPAyQQzJkGzOuKz
 QCswaJhCaiYybv/ZlXdlYyiLQjGuMfdLcZGWLBUu4l7Gxi4CMJzLhrCByrawTrg1yL/y
 KySsladJcCxKMHo7ln9TnaHxqwzaYab1VlqZh990c+Op+OwJ/rJ3fhJ1HcMG2Em66DE0
 XRsA==
X-Gm-Message-State: AOAM531ESkrtF3zcG7upOMV506GAQXGl/AYJnPVvxgPtMS4LIIrReoV2
 wd8sRMmYZujfMKOkaJ93P2bOV7BORIMY7sGiFq0=
X-Google-Smtp-Source: ABdhPJx9uoRy3zM1Om9Q8+SrpqE1m53/IA/cxeykDIPBr5yPy7s7W8rsIHd5wjgb2JhjDuc4wY8Bhf3z5uRTH40famg=
X-Received: by 2002:a17:90a:6c90:: with SMTP id
 y16mr4464746pjj.129.1611308264907; 
 Fri, 22 Jan 2021 01:37:44 -0800 (PST)
MIME-Version: 1.0
References: <20210117160555.78376-1-hdegoede@redhat.com>
 <20210117160555.78376-8-hdegoede@redhat.com>
 <CAHp75Vc92WoJm5T1jbF7UUjCNrVZr2as8ccEWxCZ9aP7z+ZyLA@mail.gmail.com>
 <d0189116-d110-f91a-afd9-70f323833e32@redhat.com>
In-Reply-To: <d0189116-d110-f91a-afd9-70f323833e32@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 22 Jan 2021 11:38:34 +0200
Message-ID: <CAHp75Vdzqx0XyykL8wxwxRNk=kBMHmUKDGXJQQtdhT_1CCa4_w@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] ASoC: arizona-jack: Use arizona->dev for
 runtime-pm
To: Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 patches@opensource.cirrus.com, Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
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

On Fri, Jan 22, 2021 at 2:03 AM Hans de Goede <hdegoede@redhat.com> wrote:
> On 1/18/21 1:02 PM, Andy Shevchenko wrote:
> > On Sun, Jan 17, 2021 at 6:06 PM Hans de Goede <hdegoede@redhat.com> wrote:

...

> > Can you elaborate switchings from get() to get_sync() in few places
>
> Sorry, those 2 changes really should have been in a separate commit.
> I've put the 2 get -> get_sync() changed in their own commit now
> with the following commit-msg:
>
> """
> extcon: arizona: Always use pm_runtime_get_sync() when we need the device to be awake
>
> Before this commit the extcon-arizona code was mixing pm_runtime_get()
> and pm_runtime_get_sync() in different places. In all cases where
> either function is called we make use of the device immediately

called and we

> afterwards. This means that we should always use pm_runtime_get_sync().
> """
>
> > along with moving disable()?
> The enable / disable calls are not moved, they are removed.
>
> Here is a new commit msg which hopefully explains this better
> which I plan to use for v3:
>
> """
> Drivers for MFD child-devices such as the arizona codec drivers
> and the arizona-extcon driver can choose to either make
> runtime_pm_get/_put calls on their own child-device, which will
> then be propagated to their parent; or they can make them directly
> on their MFD parent-device.
>
> The arizona-extcon code was using runtime_pm_get/_put calls on
> its own child-device where as the codec drivers are using
> runtime_pm_get/_put calls on their parent.
>
> The arizona-extcon MFD cell/child-device has been removed and this
> commit is part of refactoring the arizona-extcon code into a library
> to be used directly from the codec drivers.
>
> Specifically this commit moves the code over to make
> runtime_pm_get/_put calls on the parent device (on arizona->dev)
> bringing the code inline with how the codec drivers do this.
>
> Note this also removes the pm_runtime_enable/_disable calls
> as pm_runtime support has already been enabled on the parent-device
> by the arizona MFD driver.
> """

Makes sense to me, thanks!

-- 
With Best Regards,
Andy Shevchenko
