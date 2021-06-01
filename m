Return-Path: <SRS0=jKKe=K3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A10C47080
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Jun 2021 14:02:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D7D9613AE
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Jun 2021 14:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D7D9613AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 34A3516CA;
	Tue,  1 Jun 2021 16:01:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 34A3516CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622556168;
	bh=dbg5KP/0MBRLTSUzaiTJmnYcFgA91BG7gmNMEp/AVVY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r0FfJVj5619xeRYw8Iu/wrgYNjHTvAaYY7fFatnT4eIb3rIoaNI5q+BxrcETYBkTO
	 0JjmWKpuMnC7swLEKp2rhA272qEH8TA/F2KUyfjFlozMMeQNga1IBRRUhxnskXCJUW
	 1wmINt+Zft305otk6UOxLHi6aN4JzZ2yx2RHmsWs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B6439F80253;
	Tue,  1 Jun 2021 16:01:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 72FF5F80254; Tue,  1 Jun 2021 16:01:55 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 87085F801DB
 for <alsa-devel@alsa-project.org>; Tue,  1 Jun 2021 16:01:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 87085F801DB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="O0Uf4/PF"
Received: by mail-wm1-x330.google.com with SMTP id
 3-20020a05600c0243b029019f2f9b2b8aso905680wmj.2
 for <alsa-devel@alsa-project.org>; Tue, 01 Jun 2021 07:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=TxNXvaRSwH5cMN0IqObrUzZItiw85EBExLxK7B6JTbk=;
 b=O0Uf4/PF1Gz23LfW061xvE9TmKzIOovinXsF1shgt6sEFzYmczcX5cGsOAzYL2dU0b
 ep4PCe/1ynAGtQ4M1ZxIqeCyQsiAi3Jfc89Tr5K+KgEZOLWv5T02prBgnnyCltGsY2Yp
 SMnKJheYzgB7h65PCoFUrJfERC5ALLkSs0icfwGMY33QyF7DqhorwXwgIL9/tSGWemGP
 rWx94nxNErLiSDM5K0lu63FNMtWR66RKPISboNDblnqDVG5vXbX6I3CRk1sOlEOYME+B
 tLLGN3fP29MNz8MjWto2sEzQ5QBTU8Y0WrJh5MFj6p0pgccZ5D/qSMBO56lW8VUVTXTQ
 rwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=TxNXvaRSwH5cMN0IqObrUzZItiw85EBExLxK7B6JTbk=;
 b=Bby6OzbzARYDtBBBUQ9iQmXjOky4XtLeVgjSZda9SJ+pgcaii5d20HJ7cCQ8wbDu0L
 kTY14sSJwFI6JlsV0ihZQOXnwbxzXT08M8lPJx7NJGIoSBoqkMs1EV0zg2YOEceCpKHS
 Io3ZhTxVCM2piqaCNf8ACqspGsUaoaT9jQrs4zj/9FeJxt5iO1P3YKQXW1pRvaTKPmfm
 B6v52gE9TuGFDZ6GRTpxqMhI9tWtMeuG9lsJhJ6knDoOuTpVwLJ12pACN/YrAPQhv98n
 tIVJhgqNGIQ4ywRG0XRERfDugPialJRMwBXMHLpU6sch3l03X2DF3XYL5u9+9sjl1c6U
 TQ/w==
X-Gm-Message-State: AOAM5308oiBhYrB3+DkF4MD2youpLFhCj/Xj2IIBUMjEoGmkz1f6UlYx
 S6QmvO26aVKEOyKwBrstmcnSxA==
X-Google-Smtp-Source: ABdhPJyewGO++Mbi4rCpqZMGb6Wna6RRJEtPmWVLMLH2dCmEgIA8t9BE9H/fZURvSn2iFdiocUGxkA==
X-Received: by 2002:a1c:b384:: with SMTP id
 c126mr26885740wmf.110.1622556108028; 
 Tue, 01 Jun 2021 07:01:48 -0700 (PDT)
Received: from dell ([91.110.221.249])
 by smtp.gmail.com with ESMTPSA id v8sm3790884wrc.29.2021.06.01.07.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jun 2021 07:01:47 -0700 (PDT)
Date: Tue, 1 Jun 2021 15:01:45 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Chris Morgan <macroalpha82@gmail.com>
Subject: [GIT PULL] Immutable branch between MFD and ASoC due for the v5.14
 merge window
Message-ID: <20210601140145.GH543307@dell>
References: <20210519203754.27184-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210519203754.27184-1-macroalpha82@gmail.com>
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 heiko@sntech.de, devicetree@vger.kernel.org, tiwai@suse.com,
 robh+dt@kernel.org, lgirdwood@gmail.com, linux-rockchip@lists.infradead.org,
 broonie@kernel.org, Chris Morgan <macromorgan@hotmail.com>, jbx6244@gmail.com,
 maccraft123mc@gmail.com
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

I've applied the non-Arm patches.

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tb-mfd-asoc-v5.14

for you to fetch changes up to 437faaa6cebadf8ff4c2c28d7cb26ed4e34aeb14:

  dt-bindings: Add Rockchip rk817 audio CODEC support (2021-06-01 13:40:41 +0100)

----------------------------------------------------------------
Immutable branch between MFD and ASoC due for the v5.14 merge window

----------------------------------------------------------------
Chris Morgan (3):
      mfd: Add Rockchip rk817 audio CODEC support
      ASoC: Add Rockchip rk817 audio CODEC support
      dt-bindings: Add Rockchip rk817 audio CODEC support

 Documentation/devicetree/bindings/mfd/rk808.txt | 188 +++++++++
 drivers/mfd/rk808.c                             |  81 ++++
 include/linux/mfd/rk808.h                       |  81 ++++
 sound/soc/codecs/Kconfig                        |   6 +
 sound/soc/codecs/Makefile                       |   2 +
 sound/soc/codecs/rk817_codec.c                  | 539 ++++++++++++++++++++++++
 6 files changed, 897 insertions(+)
 create mode 100644 sound/soc/codecs/rk817_codec.c

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
