Return-Path: <SRS0=P7Dr=G7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D2BC433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Jan 2021 08:31:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46E2164DBD
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Jan 2021 08:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E2164DBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9A9D716BC;
	Thu, 28 Jan 2021 09:30:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9A9D716BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611822682;
	bh=wLgm5bMgORgkU5gdTaUbH96xJ6VbH9sOVXJVwTfxzrY=;
	h=In-Reply-To:References:Subject:From:To:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eafU5NSJxhLKHn3OZNpfhyYaqmc6/N32vxkTH397JxAwHXDfVq0feI2YTcy1eNR3m
	 iDF/PMZ78Jb6OykyAk/FjiugyjCx/i296Bn7vDQvEMtNNzS+xL1ZPww+0Y1g2vx2QB
	 46IGveajpijpVgX03yd2k7Zzgge4n6MleTzvcUlw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0D58CF80158;
	Thu, 28 Jan 2021 09:30:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B396FF8015B; Thu, 28 Jan 2021 09:30:28 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2E7FCF800E9
 for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2021 09:30:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2E7FCF800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="m1b089FN"
Received: by mail-pl1-x62d.google.com with SMTP id e9so2933984plh.3
 for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2021 00:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:content-transfer-encoding:in-reply-to:references
 :subject:from:cc:to:date:message-id:user-agent;
 bh=ylVX93kG0pfKLjOK+VyaAAnOVEasqsi8+AYeDV5CIVc=;
 b=m1b089FNnXo/FIiunebnJhh/k60S/WpehXj3Sn+4cJjvq7c7gjsn3qu3e1LmwBksDI
 c1uj3sQjem5jPatGk0juLcrRCEyooTxLT869X7uL5VkZRiITvBItmB0neRIuYzBqVhX+
 ewZGSlmSnNBvkKwWR0vJTGCrtbVA/WUvXlyBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:content-transfer-encoding
 :in-reply-to:references:subject:from:cc:to:date:message-id
 :user-agent;
 bh=ylVX93kG0pfKLjOK+VyaAAnOVEasqsi8+AYeDV5CIVc=;
 b=B5PvteSwYxX0t7+FlG3ji1A4xzW0WdLRsTni4pys+lmPeO/j74hVtK3roZh5Siz1Q8
 +F6ULNSIihy63I6tmNvoRb1lHDhI0uL8Xg/Lmd1gkKbHCiIC/VQMLGQSkzG8hSEjh8aK
 0s88fuQtpUF5y/H+T9bz17M0uvUbwreO3Y1pnqWap1RNzd6BrfV6Y1a3h78unLEzJTho
 y/ebnD5MNc6R5CsDoqKuz+WRRhjs4RjKF8XOhCRK/xVzl3C7dIe5fKppDA/uhDPgw2tc
 /4Y46Umy0vBV9oKAaU8/wL10Pfl7WwjSo3v/KGPdTTx+rPsRMzDfv71yk0kYRVisj7i9
 knQQ==
X-Gm-Message-State: AOAM532b9Ya1fa9aHOwE1HU1BybD0xBRnDfLCJgVOumam7J3+GlnZLI0
 yzjxKcwL1smFbKdZyUmrdmcF7Q==
X-Google-Smtp-Source: ABdhPJxv0VGQQsxMPwF5kTuNuglyyXV6LtQH2Bm9BpqAnuekS43gpU7rJFA5oCN9CaT2gYItOLy3cA==
X-Received: by 2002:a17:90a:df0c:: with SMTP id
 gp12mr10171448pjb.3.1611822608072; 
 Thu, 28 Jan 2021 00:30:08 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:304c:5453:303a:8268])
 by smtp.gmail.com with ESMTPSA id l190sm4813102pfl.205.2021.01.28.00.30.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Jan 2021 00:30:07 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210128021753.2560931-1-judyhsiao@google.com>
References: <20210128021753.2560931-1-judyhsiao@google.com>
Subject: Re: [PATCH] drm/msm/dp: trigger unplug event in msm_dp_display_disable
From: Stephen Boyd <swboyd@chromium.org>
To: Judy Hsiao <judyhsiao@chromium.org>, linux-kernel@vger.kernel.org
Date: Thu, 28 Jan 2021 00:30:05 -0800
Message-ID: <161182260580.76967.3767678954967498619@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Cc: Taniya Das <tdas@codeaurora.org>, alsa-devel@alsa-project.org,
 Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Rohit kumar <rohitkr@codeaurora.org>, Patrick Lai <plai@codeaurora.org>,
 Andy Gross <agross@kernel.org>, dgreid@chromium.org,
 devicetree@vger.kernel.org, Judy Hsiao <judyhsiao@google.com>,
 tzungbi@chromium.org, Stephan Gerhold <stephan@gerhold.net>,
 linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-arm-kernel@lists.infradead.org, dianders@chromium.org,
 cychiang@google.com, Takashi Iwai <tiwai@suse.com>,
 Mark Brown <broonie@kernel.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Judy Hsiao <judyhsiao@chromium.org>
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

Quoting Judy Hsiao (2021-01-27 18:17:53)
> 1. Trigger the unplug event in msm_dp_display_disable() to shutdown
>    audio properly.
> 2. Reset the completion before signal the disconnect event.
>=20
> Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
> ---

Fixes: 158b9aa74479 ("drm/msm/dp: wait for audio notification before disabl=
ing clocks")

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Tested-by: Stephen Boyd <swboyd@chromium.org>
