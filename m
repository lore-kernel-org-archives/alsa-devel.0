Return-Path: <SRS0=ZkCr=I3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1836BC433C1
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Mar 2021 21:28:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B97316198A
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Mar 2021 21:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B97316198A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC3DE165D;
	Mon, 29 Mar 2021 23:27:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC3DE165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617053278;
	bh=nNAoaZeajTU7J5AO4U4z9bqG02CICInQuLkb02ezIz8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f/QMxwwpuQI6+9BRT1PWWFxiccHitZbj3Ua0ol1vdhnVuJ7Uy3Vyoy6ImbOy6IqxG
	 +6l4RGLgwKTzAyimjmmjVby+3GmixAowjwXD5uNoSfJxCJUXN9lTvMsSSi4piZZdHY
	 /j/DDHGuoAsM7L5QwAGX53G6UL39OIz32byxWxgY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 40273F80141;
	Mon, 29 Mar 2021 23:27:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EFE93F8015A; Mon, 29 Mar 2021 23:27:06 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0D4F3F80141
 for <alsa-devel@alsa-project.org>; Mon, 29 Mar 2021 23:26:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0D4F3F80141
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="qP8DOoq1"
Received: by mail-qk1-x72b.google.com with SMTP id c3so13934769qkc.5
 for <alsa-devel@alsa-project.org>; Mon, 29 Mar 2021 14:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eJqU0/cPS+mS77TP8GxPDtDH/VWNgX42EbTcAAsXICw=;
 b=qP8DOoq1GMeM8kgtESYUEd271+22IEX+ZlHTqMa6oP7VS3bEv9Hgq++3jKqmPPtQJ1
 Utbw+Q3sjxhjy0GgAsBbi95s92Uhva9Cce+6kB6HyCB8/nbNd2ATQPJZzoYHKHRrda2S
 ZUjgIh3de4CgHsJdBsnHBr65Fw0AejiCl5opfd9hCUv5oa8wmcJTxtyontq55FU8HA9o
 /IrgKMQHxwuKZrIMlvkKuTgff6FH2cHnLDbIMCKuhu7M3VKlorb/9VQPQFzM/aL46+nH
 JmO7YhaGOFWWbpQ6TieLkiG2YBYblRvNZZQ4BHpDLxzTbv9AQLMJlV1V0bX+bRD7Wqjb
 TC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eJqU0/cPS+mS77TP8GxPDtDH/VWNgX42EbTcAAsXICw=;
 b=ddNu7sJ4W7lVas7XtNrW3faWWe1JbFd7NnlnJRCQgd1mUVmQ/Y7x18lUBNCmAYs6F5
 uRvnKwTpoW1QvQzEaj2QyVKgeqZ3QB10ovx5WN6SVgGiVX2NXPdUlN0IyT+CuLYOsWsj
 5L1287+GxdcscGsA5pUr/3xFEXScBG19qwuQlm7P6e2yihULJ6yoxlhK4zWoqjGccOkc
 EfJJejiUkNeh3ajCfSUzpe5Z9lWrlHO3hfDBrMCFO/9kjEOhtvZf0HTeF2eqkSsV2eWO
 fj1fb/w98wJ/+floEY9BSB7HyDX0ms7yDUrphPseckPH0+CwmUm1xtMaFypFb72YRP3p
 hvhQ==
X-Gm-Message-State: AOAM532OLlFyXVoJ9JdocxHLj1EPg/aJ4CEaNeT4mXvytLXUlxg0AH//
 r9FKK4y6NQ1w1v6Eo9sdYeaOoljm1aiIbIw0MtHpfA==
X-Google-Smtp-Source: ABdhPJyL2OR1UUBRUKPHyqDAfcfiobuWTxHYR/Q9O4t9Wp0wgNlNAm89T8wP8qqNa1Qsbg7i6/me9yvGYh2BMm74BZI=
X-Received: by 2002:a05:620a:1326:: with SMTP id
 p6mr28094554qkj.217.1617053217507; 
 Mon, 29 Mar 2021 14:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210327092857.3073879-1-dmitry.baryshkov@linaro.org>
 <161704879057.3012082.16461217665128806379@swboyd.mtv.corp.google.com>
In-Reply-To: <161704879057.3012082.16461217665128806379@swboyd.mtv.corp.google.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 30 Mar 2021 00:26:46 +0300
Message-ID: <CAA8EJppDP3utsi_cAMPUOZU_Ma4McDVHn6gJZraKzRMGcgcjsw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: q6afe-clocks: fix reprobing of the driver
To: Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>,
 "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>
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

On Mon, 29 Mar 2021 at 23:13, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Dmitry Baryshkov (2021-03-27 02:28:57)
> > Q6afe-clocks driver can get reprobed. For example if the APR services
> > are restarted after the firmware crash. However currently Q6afe-clocks
> > driver will oops because hw.init will get cleared during first _probe
> > call. Rewrite the driver to fill the clock data at runtime rather than
> > using big static array of clocks.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
> Any fixes tag?

Missed that.
Fixes: 520a1c396d19 ("ASoC: q6afe-clocks: add q6afe clock controller")


-- 
With best wishes
Dmitry
