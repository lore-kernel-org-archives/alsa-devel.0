Return-Path: <SRS0=P1jl=LH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699D1C48BE8
	for <alsa-devel@archiver.kernel.org>; Sun, 13 Jun 2021 23:32:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 001FD61363
	for <alsa-devel@archiver.kernel.org>; Sun, 13 Jun 2021 23:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 001FD61363
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B14F11757;
	Mon, 14 Jun 2021 01:31:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B14F11757
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623627136;
	bh=Qha5Q2CW/bwFp+lwMoUd5Wu9+q/xFi6pwFWRAaKtWkc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sMlxvh1P9Gxpw8Od3mmVZ5cLrmiO4z91ADj0rec7weENK02VduS+wWyHG3449UhbR
	 FfwOJa82NCgDIOAplfoh+ZPA+9WgXxddsrGak1da94F1tPuyhsF7raGsy/gk9ckByC
	 1PDrdJHWDpuX/WndP9N0k8JCEFKO5M3Dvq/PTqPc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4831FF800FB;
	Mon, 14 Jun 2021 01:31:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B731FF80165; Mon, 14 Jun 2021 01:31:24 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EDC8CF800F7
 for <alsa-devel@alsa-project.org>; Mon, 14 Jun 2021 01:31:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EDC8CF800F7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="ZBhL+xgB"
Received: by mail-wm1-x32f.google.com with SMTP id
 u5-20020a7bc0450000b02901480e40338bso8540550wmc.1
 for <alsa-devel@alsa-project.org>; Sun, 13 Jun 2021 16:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iK+fdotc8MDTLXOWsCA+bd9ELHLX8yC6MN1FxLYw3Rc=;
 b=ZBhL+xgB8mqWh3eLJJg3Z/iYwp+jlCYPiX8tmO8GhAowJpOg07QRw/MEPdckTj/kp+
 ICniI5hVwGsS2PIQIlWz7735puYXK6TjX8gWwBgKxk0KY9JxzNDK4HNgatOrSXbe0Lc2
 RF0bXch20IlR9KFs1iQsEc71ZlALOhvwrD83oO0VUwuxRnCiT+evKwNP8clkkhJYsdLG
 2v3+5cf4d/Y1NCYCiml07nL8BeVVxec9FZ3KQ80Bn22GIvZNAaaBk93WERvanqg9kWA0
 ZPH0exFbl36gqe7DWFdUYcjT3IueXbJU+jsky+TmkOdUHxBzQ1/+qlZBtvQrxT8vDCzz
 AoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iK+fdotc8MDTLXOWsCA+bd9ELHLX8yC6MN1FxLYw3Rc=;
 b=RZNiiK3hrrAOQ8ReDRmHVtK70kf3wBnOJnBDyxyAz2FbXjJu8iRKUlPIDduWstXaWD
 wfCx25lNzqEMg/vSJ98LsEdvVMCs6P/MTQ99PMNZh71Ujw3iqj7iNPj88RrvvYk8l0CZ
 Cyk0KqjISiU8HFss5/l/BCJcLk2CdnbQqtYRimk0OopydHhIH7dxcLRDf4YW8Bnqctsk
 ikmkIjAcggZ7ssNKSl9b5uia6CZDp6djB+srgX2j+vVB+LoNhki4OhKFShrwDh/WJ96F
 4T+W4xfB14vF8eZq+j/gv6iYAPjOes4VxuWzXvCSvinHR7yC8JuHJpJm4ylKENtKJ8KR
 Hw6w==
X-Gm-Message-State: AOAM530iWcqeuMj1TDWKUawgMCQKDVQOMa2LNEPiRRo+nmcACwSx0Gw6
 GrYOltQ3XbpEv//48az8+8U=
X-Google-Smtp-Source: ABdhPJxxWZyZQBZ1JBZMI/iWKh4B0GGXrb7nldKK0n8tdDlT0f6lu/3UG+BAm2A+FtPRs1yAgbiy6w==
X-Received: by 2002:a7b:c304:: with SMTP id k4mr29800169wmj.68.1623627079836; 
 Sun, 13 Jun 2021 16:31:19 -0700 (PDT)
Received: from localhost.localdomain ([195.245.23.224])
 by smtp.gmail.com with ESMTPSA id i9sm17882511wrn.54.2021.06.13.16.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Jun 2021 16:31:18 -0700 (PDT)
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Nikita Shubin <nikita.shubin@maquefel.me>
Subject: [PATCH 0/7] Prepare EP93xx drivers for Common Clock Framework
Date: Mon, 14 Jun 2021 01:30:34 +0200
Message-Id: <20210613233041.128961-1-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-input@vger.kernel.org, linux-fbdev@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
 Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, dri-devel@lists.freedesktop.org,
 Vinod Koul <vkoul@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 dmaengine@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 linux-spi@vger.kernel.org, Alexander Sverdlin <alexander.sverdlin@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
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

Nikita posted a patch converting EP93xx to use Common Clock Framework. It
turns out some cleanup is necessary in the EP93xx drivers to avoid
"Enabling unprepared" clock warnings.

Patches with stack traces in the commit messages are tested on EP9302.

Link: https://lore.kernel.org/patchwork/patch/1435884/

Alexander Sverdlin (7):
  iio: ep93xx: Prepare clock before using it
  spi: spi-ep93xx: Prepare clock before using it
  Input: ep93xx_keypad: Prepare clock before using it
  video: ep93xx: Prepare clock before using it
  dmaengine: ep93xx: Prepare clock before using it
  ASoC: cirrus: i2s: Prepare clock before using it
  pwm: ep93xx: Prepare clock before using it

 drivers/dma/ep93xx_dma.c               |  6 +++---
 drivers/iio/adc/ep93xx_adc.c           |  6 +++---
 drivers/input/keyboard/ep93xx_keypad.c |  4 ++--
 drivers/pwm/pwm-ep93xx.c               | 12 ++++++------
 drivers/spi/spi-ep93xx.c               |  4 ++--
 drivers/video/fbdev/ep93xx-fb.c        |  4 ++--
 sound/soc/cirrus/ep93xx-i2s.c          | 12 ++++++------
 7 files changed, 24 insertions(+), 24 deletions(-)

-- 
2.32.0

