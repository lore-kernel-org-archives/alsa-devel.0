Return-Path: <SRS0=4jWs=BD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33582C433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Jul 2020 12:27:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F27206D8
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Jul 2020 12:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZVcbSwJM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="EPZygmZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F27206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 42E38167C;
	Fri, 24 Jul 2020 14:26:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 42E38167C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595593646;
	bh=LIz+nqKkYwzUHq/JJGtMGlewqrAFNsZ0u/rLsadqA10=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZVcbSwJMtb1z6/p2QGRqne1sBIGG5GrTQ8uGWi1piC9a/K8ckmiUnA/h4nSasMBT9
	 PGiM95WFJTciprmdEx8idOXq5TdljaJqIm0SS6Yb2I73H6tGrhJPBXII4l+hMgdkch
	 ialLYQYZQRSPorG+tFdPmFxmyMzCtAbaKolwYyOI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A7D7AF800CE;
	Fri, 24 Jul 2020 14:26:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 92B8BF8014C; Fri, 24 Jul 2020 14:26:33 +0200 (CEST)
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 463F4F800CE
 for <alsa-devel@alsa-project.org>; Fri, 24 Jul 2020 14:26:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 463F4F800CE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="EPZygmZW"
Received: by mail-io1-xd43.google.com with SMTP id z6so9607706iow.6
 for <alsa-devel@alsa-project.org>; Fri, 24 Jul 2020 05:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rWFRmuy7XzkLC+XwvCLatwNYcAYKtDwmSQ81EKm+28s=;
 b=EPZygmZW6iCVzHgh8qudv/JXg4jPLFpjXVerS6KVxjoWs7LuKEoilUz4dqFD24UX0s
 ZXdIcBD4EZ4AXY5tx3XN6DooetIwONQ02JD6KELko2W7l2+i9ya3EYW2bOVi/ajUVw+i
 FK9u7aWb8UlgxxIL68UY5oWr2+YQLPYAk9QJ4ZSeSeoUy2vAK5T6G/SHv1Ip4G4vs2hR
 PxgjcTw4DyEqH7CtII0xG4O94NIDczPw3vi9w0kJhxPUsIUTsFtcHvnf1PlcpwmVgiSA
 cwgiurI5cEebZud1J/M/RlVAds7aJjtVRetCFxU/tatjrx/oCXEjq+/7n9wAXxFkN8Nu
 zs7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rWFRmuy7XzkLC+XwvCLatwNYcAYKtDwmSQ81EKm+28s=;
 b=LZdwdEJoZhM3njUpp3ckTT4sn+oY5ehckEyNZKqsu3+jg+XjtUlGS+1o2F+oLybruu
 abefLRgJuGvUdNiZN7n9VAt6GY2elbjDF/VTEknC/3wL1qVQvf4kB9Zo6+r5mFPxMkay
 StDZjAlLCjnWz7H7XqIhG7P7Fn9OFuNeH49HsSEbifV7WjByjy5gV4wAY9333AC8rPz6
 KhukckL4IbCy3xWBgasKMXGD5yw9SomGnNNTyiqA9IwEwVHKHgDjMgKJZjX2E/Y6aQ8c
 gViy63Up8pTE28X3bWJZkJsItkaYZhPJmaHggRgzz/5zOGBBZ5+ccHqfrgLgcBd3faJt
 2XwQ==
X-Gm-Message-State: AOAM530eeAux4ln/6wjiAasIQ2R4G2WcC1c0vhbthIKAowQWXt3zLvbi
 ZDG8yJGO2gLnPJR2pgm10GBBByxPdtFDfo15omudxA==
X-Google-Smtp-Source: ABdhPJwXiuk6LCOsAjcA8djPS7Is+XyFH6x9FF5FXK9RvJjjcUAj+CmnlbFnkMEdiCmJwYoeNJ8ke1oS3a1E5Lhs4k0=
X-Received: by 2002:a05:6638:1513:: with SMTP id
 b19mr10193239jat.109.1595593584433; 
 Fri, 24 Jul 2020 05:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200724070731.451377-1-tzungbi@google.com>
 <20200724111634.GB5664@sirena.org.uk>
In-Reply-To: <20200724111634.GB5664@sirena.org.uk>
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Fri, 24 Jul 2020 20:26:13 +0800
Message-ID: <CA+Px+wU-R2qOFK8RhLzTXTqDheZhzOyKuiR-1S9qXj02QdruAA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: dapm: don't call pm_runtime_* on card device
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

On Fri, Jul 24, 2020 at 7:16 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Jul 24, 2020 at 03:07:31PM +0800, Tzung-Bi Shih wrote:
>
> > Commit 4e872a46823c ("ASoC: dapm: Don't force card bias level to be
> > updated") stops to force update bias_level on card.  If card doesn't
> > provide set_bias_level callback, the snd_soc_dapm_set_bias_level()
> > is equivalent to NOP for card device.
>
> > As a result, dapm_pre_sequence_async() doesn't change the bias_level of
> > card device correctly.  Thus, pm_runtime_get_sync() would be called in
> > dapm_pre_sequence_async() without symmetric pm_runtime_put() in
> > dapm_post_sequence_async().
>
> > Don't call pm_runtime_* on card device.
>
> Why is this a good fix, as opposed to only skipping the set_bias_level()
> bit?

Did you mean: skip to call snd_soc_dapm_set_bias_level() in
dapm_pre_sequence_async() and dapm_post_sequence_async()?

If so, skipping snd_soc_dapm_set_bias_level() won't fix the issue.
The runtime_usage increases in pm_runtime_get() and decreases in
pm_runtime_put().

Besides, snd_soc_dapm_set_bias_level() calls card->set_bias_level()
and card->set_bias_level_post() if any.  Skip to call
snd_soc_dapm_set_bias_level() couldn't be a good idea.  It may change
some existing code behavior.
