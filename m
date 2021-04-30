Return-Path: <SRS0=h5q8=J3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C24C433B4
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Apr 2021 16:31:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA72361420
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Apr 2021 16:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA72361420
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 592A91689;
	Fri, 30 Apr 2021 18:30:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 592A91689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1619800268;
	bh=dYiHJvQtLkUBppyhHsabkoTArDmc+ssxPvCBQ03Mj/Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m16oT008uvXGEzH7NSLRgXGvYOrUVTNSjiPY7AwuMjYEwXzJqIQLLqMhPZWHxdXsy
	 JWyz3AiXTBXnNGSWFlfKpbFgLIXZA1VkOnvf0W0vUfhI7RWaoH0bcymVRhwR2pmvEF
	 5QBrGdHnV1g/tMIFkWGQPvgBi65YKEAXT45rZXcs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B2038F80165;
	Fri, 30 Apr 2021 18:30:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BF210F8016C; Fri, 30 Apr 2021 18:30:14 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9E226F800E4
 for <alsa-devel@alsa-project.org>; Fri, 30 Apr 2021 18:30:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9E226F800E4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Mq8Bnpcg"
Received: by mail-pg1-x535.google.com with SMTP id d10so11386435pgf.12
 for <alsa-devel@alsa-project.org>; Fri, 30 Apr 2021 09:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GGnjFPqxnyb5x82q+W2CEVoaczedymBQh3usKng2HjI=;
 b=Mq8BnpcggakwdADR+l7TEADjpZCptUOLodAA2Fk2Cu/wikEtBTG1Gq4ByBdcX08JG7
 XwmRwmfAQLmGztsG2cdLOFYuZ9lBtkOEpUNTSuSf62GJdP+VVXVvPY/UnbHoY+ksYXXU
 h62l+uJsXshOLalIAk0u6ZTbogqQHJjOmIv9gdztyhc9bAORRajPXfwO/+JLUXsRbHQ4
 SXvAEn+tKgl1sKLo3GmUTyXbf0C5o1ruHqJR9YplMGhaFTwx8RFxX6G7cBjWBwEUk/6y
 QcDu+q4bF0gDWolqiGqKc9mdkfLO1qhqtpub3DzCggBF5B1YrdgN7lE7ReCL0ch5agQC
 k3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GGnjFPqxnyb5x82q+W2CEVoaczedymBQh3usKng2HjI=;
 b=JfQFea2lP0ZHScGICa+LuhoffqubEVSmWpLWntaYcyVPZI98+mYP9NPRD1rlD0blVQ
 4bFZo8NNjUwA6q9DC6GoFfKYIKu1KzNz6FCedcEWi7/wAVSsjt82T9jt8zf+EIoODS47
 JpedqHSIRD/eKrSk1c0VMjw8DnEC3sjewrLF0qqUoc7pyABMoiS9I2HfrDW2FErDtxsv
 5phfWTRCNaN26uB5EQ/qgBMKlqvykWmNJLRQVJg7VOI4/wg1kB57KiH3Xq1IcWKFmidX
 UHiuVoegxVwliUPKrSV5NgsgDUoUanRqOuCOyynKOFXgZMC3C1Gy9NdOXTffa/8v7Ekk
 OOXQ==
X-Gm-Message-State: AOAM533sN7KHTnvkcBdU6AWLuITAB52y5MltixrKJ0b48rFZByDhn72D
 SWjuXOi1D7rksLnEFO9sn388EJhYrgEmHy4V2W4=
X-Google-Smtp-Source: ABdhPJz4Wo0tSXk/MEkFk+6tZ5WpZD121L1ZAR3xvO6qKPh7FOaDtxTIgZhkVktO0lqILvWBdyc7vMdKL9mTOmJzcy8=
X-Received: by 2002:a65:5a4d:: with SMTP id z13mr5388538pgs.4.1619800204608;
 Fri, 30 Apr 2021 09:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
 <CAHp75VeiHsk15QoG3X-OV8V8jqzCNeKkif9V=cx4nvKVHaKbKA@mail.gmail.com>
 <20210427143457.GI4605@sirena.org.uk> <YIglWpz8lSidXmDd@smile.fi.intel.com>
In-Reply-To: <YIglWpz8lSidXmDd@smile.fi.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 30 Apr 2021 19:29:48 +0300
Message-ID: <CAHp75VfBSjHP1LJZJTdwXzGuE2YjxdW6r7Zf6ofHsquJBPMyWA@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] spi: pxa2xx: Set of cleanups
To: Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 linux-spi <linux-spi@vger.kernel.org>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>
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

On Tue, Apr 27, 2021 at 5:54 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Apr 27, 2021 at 03:34:57PM +0100, Mark Brown wrote:
> > On Tue, Apr 27, 2021 at 02:46:02PM +0300, Andy Shevchenko wrote:
> >
> > > Mark, are you accepting patches for v5.14 now, or should I resend
> > > after v5.13-rc1 is out?
> >
> > > (I have few more in my queue :-)
> >
> > Send them now if you like.
>
> Got it!
>
> I think I prefer to produce a less noise in case this series for some reason
> needs to be changed / amended. I'll wait till this series lands in your queue.
>
> P.S. basically my question was about this series.

One item is still unclear to me. I noticed that you started already
applying patches for-next release cycle (if I understood it
correctly). Hence the question should or shouldn't I resend this
series after rc1 is out?
If I shouldn't, do you have any comments on it? If no, can it be applied now?

-- 
With Best Regards,
Andy Shevchenko
