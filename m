Return-Path: <SRS0=4tTe=BK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776C6C433E3
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jul 2020 09:19:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F12EC21883
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jul 2020 09:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Z1Oc5lh8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Q4dxRilW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12EC21883
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 59A9D1664;
	Fri, 31 Jul 2020 11:18:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 59A9D1664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596187149;
	bh=MBYKW+6zfDB2a54T6hWqLG1CXD8Xv9gEE8YRBupknoc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z1Oc5lh8IjPzKwfVIAwK5LlFfjDXaK4i5E4E7SIMoqN/dsNfgCv5TEn4yoablaycA
	 z6iCw9e/8sYiq5pHG7w0UBAbgU8vqWN0vw4oFeAhxzaxcYB3loFOtsD06qtFmEQouP
	 tgGVo8raWxDrAyMSv3wkOF6fU361JGX/rLl5xPm8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EE4A6F8011C;
	Fri, 31 Jul 2020 11:18:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B699DF80171; Fri, 31 Jul 2020 11:18:16 +0200 (CEST)
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 78AC3F8011C
 for <alsa-devel@alsa-project.org>; Fri, 31 Jul 2020 11:18:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 78AC3F8011C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="Q4dxRilW"
Received: by mail-io1-xd42.google.com with SMTP id l1so31000979ioh.5
 for <alsa-devel@alsa-project.org>; Fri, 31 Jul 2020 02:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MBYKW+6zfDB2a54T6hWqLG1CXD8Xv9gEE8YRBupknoc=;
 b=Q4dxRilWRBgR7d7mMciRIspoaJm1fKMtrrxqGop4MRWMLfDc2D9yEkmq7lanCl9IDe
 r7Ipz4IWXCJMfmE8gERtTCXqU0PCd2yaU25HbqQAmtQQfmbt9kxpDNN2AVYcf2lFK1pC
 cwqvXq69UceGzBHTSrTnvMYRIvHZl+qJ4u17vqcges3uTIgsNJpdkSZKEYBAdS6e1jjj
 qwjFZv61E1DWla4RqmgLOTPcf169N+7qeHI86xyeTQ+kuv1LDlJTZGttIqTSER1GnIn6
 R01XGra1AUEkoKQGTvP1e29NBtDPetvcV9hgYInxlth9Nfx8/iX5yND0vqQLmGYSWbhj
 /bCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MBYKW+6zfDB2a54T6hWqLG1CXD8Xv9gEE8YRBupknoc=;
 b=XC/3YFdXqeCIQyklsZfjjpWJluOWm/dxug3351TzSBiSf0gs6Xbx7esTDo5Iuj/89L
 vo5cxyqCRUPwX3/xOQGX6ph0/8b+PMPfMqGWxJQztr+Cr9RWF5AHaMGGclkS2+HBG1pt
 SZZbG1shHMrAnklouvU2sb5i2A0tn6kbvK/4104K10eRUK5wU3Q3VKAp4KcQMGvYBXbk
 Fq8TW3QAllq0o+KX3ncP75h+rQRFeLrv03MPG/WbVU/B5/sgZrTft2RfTgWRi6tV+ZkS
 nWrnsFPfLhaPncWQ5ecqCkbCsUGyEFk80HFWFca9JA6vKQpkrJXeack3x0sDb6tGFxmZ
 bCUg==
X-Gm-Message-State: AOAM532EsCqXTDW5az6gqYwKE8sbwlyhQ8GAq7GuaKFKFi5191VPVa3i
 XOzZfBAncmmBYozlov+CTxzFhFDIrmWklC65/J5Few==
X-Google-Smtp-Source: ABdhPJx+ufc4R00ufDto7B+hLq2EDngnNSkTrnF9favAezBqDM2gxaTBrSA3LHvhe9NZwN3t9yBnkD6e7zjqycRcULE=
X-Received: by 2002:a5d:9b05:: with SMTP id y5mr2682909ion.59.1596187081282;
 Fri, 31 Jul 2020 02:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200731084023.2678931-1-cychiang@chromium.org>
 <20200731084023.2678931-3-cychiang@chromium.org>
In-Reply-To: <20200731084023.2678931-3-cychiang@chromium.org>
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Fri, 31 Jul 2020 17:17:50 +0800
Message-ID: <CA+Px+wXL6-zM6vBZj9_6MhxQz7Dy_Z4J7+RUYEViVkWYv2zX=g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ASoC: qcom: sc7180: Add machine driver for sound
 card registration
To: Cheng-Yi Chiang <cychiang@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Cc: Taniya Das <tdas@codeaurora.org>,
 ALSA development <alsa-devel@alsa-project.org>,
 Banajit Goswami <bgoswami@codeaurora.org>, Takashi Iwai <tiwai@suse.com>,
 Rohit kumar <rohitkr@codeaurora.org>, Patrick Lai <plai@codeaurora.org>,
 Ajit Pandey <ajitp@codeaurora.org>, Andy Gross <agross@kernel.org>,
 dgreid@chromium.org, devicetree@vger.kernel.org,
 Tzung-Bi Shih <tzungbi@chromium.org>, Stephan Gerhold <stephan@gerhold.net>,
 linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-arm-kernel@lists.infradead.org, Douglas Anderson <dianders@chromium.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>
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

On Fri, Jul 31, 2020 at 4:41 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
>
> From: Ajit Pandey <ajitp@codeaurora.org>
>
> Add new driver to register sound card on sc7180 trogdor board and
> do the required configuration for lpass cpu dai and external codecs
> connected over MI2S interfaces.
>
> Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>

LGTM.
