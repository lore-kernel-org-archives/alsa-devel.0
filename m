Return-Path: <SRS0=jKKe=K3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D66C4708F
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Jun 2021 06:21:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6BE361159
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Jun 2021 06:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6BE361159
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F4391614;
	Tue,  1 Jun 2021 08:20:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F4391614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622528493;
	bh=VjF5fmPWmJV34AdLHtXksUvrbFB635DQDVeSSdm6xpw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X8o0tf8gu4zHDe2kzJS0nVQc88S5J8B9SnMnOOWwQfB8rVVsE2nsQDZ5dGF2HzlXV
	 XMEkU4aWTfI3FkOsOvoT0bwIbg5gDSAISGAzAGBU1bmikLVxCSZeMbGrf51qX3BhdK
	 YrufulIHpcp7UKBIbJXkYwYVSI1ak2nE2gaUXqdc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 053ECF800B2;
	Tue,  1 Jun 2021 08:20:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BE1D4F80254; Tue,  1 Jun 2021 08:20:39 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B90D5F80141
 for <alsa-devel@alsa-project.org>; Tue,  1 Jun 2021 08:20:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B90D5F80141
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="gWoOaav6"
Received: by mail-io1-xd2a.google.com with SMTP id a8so14053453ioa.12
 for <alsa-devel@alsa-project.org>; Mon, 31 May 2021 23:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VjF5fmPWmJV34AdLHtXksUvrbFB635DQDVeSSdm6xpw=;
 b=gWoOaav6t1rcuEJBzjAASU8hMh7ElCyKu3WcOsSLEc3Xe7lVLiay+RXoHxsk5buD9D
 CJxpSkbkECsVfZz3xspVANq7Em5/UA/KnkZK2eyepxsTrI9nmXCBsG/Ba+Fld77RFgyI
 KY0MKjd7G9GdbwK/dn3nFtFKUPHaEO3NiNr9KyReDbaYycz5FX3FtxuKgoUxpMWK06E9
 rTUvb+BIfbN2poEUQU5Hr3BWCif1Gt8KkTBkAKd3ONOXRH1BMGIHpg/bytVrYCBUyiG5
 aOj9qMNfW0/l0idxvtkTiQ1kkAythJVkrd//a8aEGOpbEifgVF7PwRE2MoHgJTRjzPKG
 fs8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VjF5fmPWmJV34AdLHtXksUvrbFB635DQDVeSSdm6xpw=;
 b=quxLs/DQMFH68fixE9L79w1U/MvgrIDeLCuh8aPxowWwmyQiinNUHckI2/lFqabmWq
 kSdkB6zHXPbLQz3JD15hFXabHJMOjiqhYjfAQS61MwB8khUn41M8dlUk1HX/IdyryiQs
 DZHH4TvyksvWgjs+NW5i5BU2+R7eaquEDqlScMoXuQM5J3OTd455DlcOHK6w1tkcq6K8
 /4LNXnoYtGcLE4DQFBBUEJmZC4JNDFwOI1ngISwgvN1oX9d09MCNdl57Kq77CWfZUH3d
 rEbq88RNGGNC/DRnQ4muO7fqk5+S6ut01/AWC2l+h2z/o8+pT/uBtSsMZ8wzB7n6+Pcu
 0tiw==
X-Gm-Message-State: AOAM530wuaOqHoLLRPaC7M/XVW2Eo/TTK27nLLInsPssoqrGQk1zqE0L
 c5+qu07zXSlHFRoGN7at5V0p59WSJ6MpaKTEHMOviw==
X-Google-Smtp-Source: ABdhPJwwuuEEw4PW352dxmKdk5M40VGM4ah+oUqxQCijlCOa4x8O+ussAGmRTo654Y1vrVDRwi6DFNUbJ0yZ/HPFQkM=
X-Received: by 2002:a5d:9694:: with SMTP id m20mr15203280ion.185.1622528428085; 
 Mon, 31 May 2021 23:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210526154704.114957-1-judyhsiao@chromium.org>
In-Reply-To: <20210526154704.114957-1-judyhsiao@chromium.org>
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Tue, 1 Jun 2021 14:20:16 +0800
Message-ID: <CA+Px+wXGjZCOhhAVh9eRw6L-g8g7Qi7Rf_3YHpHSCB2o=XQ+4g@mail.gmail.com>
Subject: Re: [PATCH] ASoC: max98357a: set channels_max to 4
To: Judy Hsiao <judyhsiao@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Cc: Taniya Das <tdas@codeaurora.org>,
 ALSA development <alsa-devel@alsa-project.org>,
 Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Rohit kumar <rohitkr@codeaurora.org>, Patrick Lai <plai@codeaurora.org>,
 Andy Gross <agross@kernel.org>, Dylan Reid <dgreid@chromium.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Tzung-Bi Shih <tzungbi@chromium.org>,
 Stephan Gerhold <stephan@gerhold.net>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Stephen Boyd <swboyd@chromium.org>, Rob Herring <robh+dt@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 Douglas Anderson <dianders@chromium.org>,
 Jimmy Cheng-Yi Chiang <cychiang@google.com>, Takashi Iwai <tiwai@suse.com>,
 Mark Brown <broonie@kernel.org>
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

On Wed, May 26, 2021 at 11:47 PM Judy Hsiao <judyhsiao@chromium.org> wrote:
> Sets channels_max to 4 to support QUAD channel.

Could you point out probably the up-to-date MAX98357A datasheet for
4-channel support?

On a related note, from the public datasheet I could find[1], "Table
5" only shows 2 channel's configuration.

[1]: https://pdf1.alldatasheet.com/datasheet-pdf/view/623796/MAXIM/MAX98357A.html
