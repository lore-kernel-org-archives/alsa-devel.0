Return-Path: <SRS0=WNy5=IU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F5EC433C1
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 13:35:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37A026192E
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 13:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A026192E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 18B519F6;
	Mon, 22 Mar 2021 14:34:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 18B519F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616420105;
	bh=Up8NqiwQzN4KckuQKLNR6euPBOCGFEgdn3k5fSJBIqw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dzPTUQ0an/cCLdxZoQ4d+Z81QFPwTCSAAoPZ6CBihumLiDfI2qv71TW3ysbjAvbcx
	 WDUxbrrusDWglo6xO6gik93zYrJcABZL/UovMEDStZI9s/Xa0ATg8SwM/ClHar9JtF
	 ugjErTz5huueuKA7EXBCixHXfbGQ7J4nUqIl5ysU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A87CF8016B;
	Mon, 22 Mar 2021 14:34:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2C1C9F8016B; Mon, 22 Mar 2021 14:34:13 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AB9B4F8012F
 for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2021 14:33:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AB9B4F8012F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="zVfozITb"
Received: by mail-lj1-x229.google.com with SMTP id f16so21113670ljm.1
 for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2021 06:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0WPnh+9BruSzYQXPNbQjjx8XWnL6ZcqnHNniGVHI2ic=;
 b=zVfozITby6X5m9cVgVI4NHg5AGR4Yo8qfxBadC5vuclSxXdMiAnlP8/q6gcc671q6M
 yoDHGQPlbQQbAPghxNLjwU32gH0oFgO4TE9mFrkbcUhq17oA4SI8FJhejv7q+DDBNBmL
 vObdz/8gDuN+3y8LqnOWSgZjxLgNPg8e4yn1e/3StGUsLWcd3Qq6ylFIoxFEhIyHeGhf
 FYm2Gl2MqwbCf41PqRcGMWZkLam4KKDt86jlJBewNZGxf0qd2KHTH7X3g9UxMJl8aaYL
 FZmOd+e675px7yqiZ6HcGMOElUtSA+J4U4KZ0BXSl6Gqz5n6jZFHThyr9/dD4FeO/Y+p
 kG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0WPnh+9BruSzYQXPNbQjjx8XWnL6ZcqnHNniGVHI2ic=;
 b=UG1GcigSPta8DZ1qCshIUC5WYh/Hdl7Zz7SG6Ik8zlegrwl7KTPMZR0lU61d26xsw6
 dOgnthKj1L+u5qyl8+a2bW6Ho2nAQajo7D7xAkbevBVs4ZYd6e/YUlBGC0YpsWjhKYcb
 zmxMx7mseIJxV+4P+0IcXuRB8zKYb1+9M87ZbKhpGS3I6OB91X8iz0BFKIA4ff8+g3UL
 +aK4+Jv+m8mzSVUZubEoRR1UZkClweO3VoSkYI8rpNYiMR1R5sduyd3uMm8TFC6Jc1zn
 Ckf94bjls0cz08e/IefhM0ol6JfWYcZpsbIMwqEA4kvTzIITQMYszgXNgVIY2X4gIyWw
 Yueg==
X-Gm-Message-State: AOAM530n0S4HcCkX4T+AtYmJ/n23W95h/2QXpZIo51ahTuS06MQHpHsD
 /Q/PLjhGUSv8Qr6/Jd2hvAdbCUBpEKDEyLR/2nNisA==
X-Google-Smtp-Source: ABdhPJz0oc64Kx9cMP677X5vUFdOcCeCOUsWcX+1Bc1alVrv+fsS4ITQzDOa0UVfYhR9B41iluJDnEVhOWCLRUDi0tE=
X-Received: by 2002:a2e:864a:: with SMTP id i10mr9253577ljj.467.1616420037816; 
 Mon, 22 Mar 2021 06:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <202103191536.9cD1TuQQ-lkp@intel.com>
 <CAHp75Vchoe2Z00ODh_AWos3Chfa1AoQMjZw7aD=5cGsTFtK7hQ@mail.gmail.com>
In-Reply-To: <CAHp75Vchoe2Z00ODh_AWos3Chfa1AoQMjZw7aD=5cGsTFtK7hQ@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 22 Mar 2021 14:33:46 +0100
Message-ID: <CACRpkda5ofCs=nkpZXVyekw2LoeYZUNrFTu1iGPt47ZSMa-6eg@mail.gmail.com>
Subject: Re: include/linux/unaligned/be_byteshift.h:46:19: error: redefinition
 of 'get_unaligned_be32'
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 kbuild-all@lists.01.org, kernel test robot <lkp@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

On Fri, Mar 19, 2021 at 10:57 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Mar 19, 2021 at 9:05 AM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Linus,
> >
> > FYI, the error/warning still remains.
(...)
> >    In file included from include/linux/build_bug.h:5,
> >                     from include/linux/bitfield.h:10,
> >                     from drivers/iio/magnetometer/yamaha-yas530.c:22:
>
> Isn't it fixed already somewhere?

It is, I think Jonathan already applied the fix, it is just waiting to
percolate up
to Greg and then to Torvals:
https://lore.kernel.org/linux-iio/20210221154511.75b3d8a6@archlinux/

>> Kconfig warnings: (for reference only)
>>    WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_PDC
>>    Depends on SOUND && !UML && SND && SND_SOC && SND_ATMEL_SOC && HAS_DMA
>>    Selected by
>>    - SND_ATMEL_SOC_SSC && SOUND && !UML && SND && SND_SOC && SND_ATMEL_SOC
>>    - SND_ATMEL_SOC_SSC_PDC && SOUND && !UML && SND && SND_SOC && SND_ATMEL_SOC && ATMEL_SSC
>
> This one though is interesting.

This looks like nothing to me :/
As confused as ever about Kconfig.

Yours,
Linus Walleij
