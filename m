Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F13E81DFD
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Oct 2023 13:49:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D699E84B;
	Fri,  6 Oct 2023 15:48:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D699E84B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696600178;
	bh=X6ka0fokYeMm5as4cUEcHTb2khBCsJky52NkZLRweRg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Gfu/ttyshoG+kUoFO26hcI3fC6LpDSSrDAcHn4DVytu9gr+OS/Dv5BWOqRp00cLi4
	 ETNAAf//xbE9XqC9W13XfD9AHfID+FMnID53lyHGkH9UrAhDL/qnanSrINMYMHEUhU
	 NaKvdnq9tBWrB0Q1ZRRX1ZRorrV3mLcTSJjXXLCU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B1C93F805C9; Fri,  6 Oct 2023 15:47:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 22C02F80551;
	Fri,  6 Oct 2023 15:47:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2BA52F805C3; Fri,  6 Oct 2023 15:47:27 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C6D65F80310
	for <alsa-devel@alsa-project.org>; Fri,  6 Oct 2023 15:46:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C6D65F80310
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=p3lyk5Ml
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-50481a0eee7so4027488e87.0
        for <alsa-devel@alsa-project.org>;
 Fri, 06 Oct 2023 06:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696599990; x=1697204790;
 darn=alsa-project.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rbOUvzEjDlea4hheqP+YItFqmSWqoancs5Dg0PuH8cA=;
        b=p3lyk5MlbBf/TBDaAvAlaPqC+CuM21dDQtRNHUhIN4FFeLMMbv5A809u95GfQXmhNj
         ZhiDHN/zzeZdGYUbT2S/FrmQLTMmwLgBq5bl3d3z2wAqEr+iik1megaTpVd3MmiEOVav
         pXKO+/wpR6J3nVFc0QOm/Z9Xkb6Lm+dc9vmdg7rdSlZnKK8Lq8Bm7UWO332S+Ytp+byi
         s9ETtlk4v5DrWFHFdYK75IDqr6n4Fd6R1GlVx6JdMI7xj3T2YYHv3GC5iz3k/4KekH18
         LoajuKJY2hC4kNGHqSwrQ32OgDiINwbHSeLptzLFdWgNn/vVqatBVqjmn8CN0DWOLu3y
         QVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696599990; x=1697204790;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rbOUvzEjDlea4hheqP+YItFqmSWqoancs5Dg0PuH8cA=;
        b=du9/Rdxv3nEu5qa01OgEICwqARwy84JrVXhCZ2JV0bBLGLz93rqDojYTCkf53fGT5w
         +JEEit/5LF3Dz3iLC03wDUMxeSNzuXrdKEzbMKcOQGbR0vgYWw62h0mVmxSh+fosstHV
         s1LsSnXkUKdTGrD9G7pNySNR5TocgULVU6sOZ6qPAQsvur8dr+FKtfLr37TqJDKLK9vl
         PiNWZAp1ey1f6uqUGiMR2UT7CfwAuXxkjwfko03hDzVmB4nRmnCX8ev6V8e8/+QcWDtX
         RX718Y0t3D6yjWLMgkQerGziAlPWkK3ys32d8dj0kLVDPH24fEEJfdUj0kj7CHks3tCK
         uOKg==
X-Gm-Message-State: AOJu0YwYft7Ai7Rp3nxU9A2D/FGkXqdkRkFGjSotz4v6LUk0wMD9HtOU
	kaFRxs87MCwWErJsIr5LGoXNZA==
X-Google-Smtp-Source: 
 AGHT+IE03cY9cbfFat4D3ognOlfRjSknFV24Pw5RSzWKwx+wwbMMYFomv7Z/+zEYe9XkBY/RRQgYGA==
X-Received: by 2002:a05:6512:3e0d:b0:504:320a:b420 with SMTP id
 i13-20020a0565123e0d00b00504320ab420mr3957398lfv.17.1696599990012;
        Fri, 06 Oct 2023 06:46:30 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id
 v25-20020a197419000000b004fe37199b87sm308733lfe.156.2023.10.06.06.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 06:46:29 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 06 Oct 2023 15:46:26 +0200
Subject: [PATCH 3/8] ASoC: mt8173-max98090: Drop unused include
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231006-descriptors-asoc-mediatek-v1-3-07fe79f337f5@linaro.org>
References: <20231006-descriptors-asoc-mediatek-v1-0-07fe79f337f5@linaro.org>
In-Reply-To: <20231006-descriptors-asoc-mediatek-v1-0-07fe79f337f5@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
Message-ID-Hash: 2OCMVRRKIWUSO7EHVLCFDEBGI6HAIVNM
X-Message-ID-Hash: 2OCMVRRKIWUSO7EHVLCFDEBGI6HAIVNM
X-MailFrom: linus.walleij@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2OCMVRRKIWUSO7EHVLCFDEBGI6HAIVNM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This driver includes the legacy GPIO header <linux/gpio.h> but
is not using any symbols from it. Drop the include.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 sound/soc/mediatek/mt8173/mt8173-max98090.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8173/mt8173-max98090.c b/sound/soc/mediatek/mt8173/mt8173-max98090.c
index bfb2094758ff..0200da192116 100644
--- a/sound/soc/mediatek/mt8173/mt8173-max98090.c
+++ b/sound/soc/mediatek/mt8173/mt8173-max98090.c
@@ -9,7 +9,6 @@
 #include <linux/module.h>
 #include <sound/soc.h>
 #include <sound/jack.h>
-#include <linux/gpio.h>
 #include "../../codecs/max98090.h"
 
 static struct snd_soc_jack mt8173_max98090_jack;

-- 
2.34.1

