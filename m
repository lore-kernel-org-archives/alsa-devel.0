Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A339C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Dec 2021 05:20:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 257892088;
	Fri, 10 Dec 2021 06:19:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 257892088
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1639113619;
	bh=TIqWcH4mt44tVR0i/M7G7ObLRkHCB/4pkd7TuhyTWZk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qJVx/p9fAW6dBHLqoRpqbib5X/j6kGJzeWWaTnlFD1zDBFThDFzxVF3jixlzkG08U
	 1cdadvMtunrbrBrpmOw/kuXeepF/JmQcGmF6B3FVpY4IHBJDqMsM+y/RIw9qzrr8ub
	 GCo0WEsKLbVX2A9uf1kXinamlg6LJutlCvOrctww=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8FF0AF804CC;
	Fri, 10 Dec 2021 06:19:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1B632F804E5; Fri, 10 Dec 2021 06:19:26 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D410EF800AB
 for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2021 06:19:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D410EF800AB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="IHdhVUZR"
Received: by mail-pj1-x1033.google.com with SMTP id
 n15-20020a17090a160f00b001a75089daa3so8626738pja.1
 for <alsa-devel@alsa-project.org>; Thu, 09 Dec 2021 21:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1n5pw55TMAAP+SKn+79BLK8ytK8/fOHPCl2GwuSHIGk=;
 b=IHdhVUZRyIP1kDwF23TNlIYr6AflXGTL2Qhb9EsRD1szNGl8+dGgQ5n1MhRenEftjk
 Xwkz7FuxaLl0mJCgdMdD33+Kgb5Uh3THJ/6L9xAKMBCoL1ND/sQXakUU1Xd+DJvB6Qnz
 693i9PEsie4ilayw7bYnX/sVTT+U+AsT8yAcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1n5pw55TMAAP+SKn+79BLK8ytK8/fOHPCl2GwuSHIGk=;
 b=3vwGl9zgb3c/Lmp+3kW2h69SXfmZW7fwmHja1c0Ipt+bVierNjeP9mlk8U53Aj+jSg
 /7wiZiXYM/e/UOIsGldwfBW/fcX8abYoPIEFPTpxTLL0EgJdfmepW9LEJ8G4E9Q/Ob3u
 szGhU8zHrCcDLwGDWe3NaSA/nqWcdDouqfEmE33tcD/ofhxyXVz1vQmHlXcQ+HB3pRIQ
 aKmd3J4ThfBX5Og82PCv/Xd1ogLJyN2BvQdxs1fgZQS5a7PiJNYJHR+7vNk0+G3OwTt4
 3rzHgnAptOXo7CY5SGMwSPdamBaYuKzxUDFpPPeSPzeBb/T2HVq4a9uO3U4j4Qs3Z1x6
 YrqA==
X-Gm-Message-State: AOAM5308U8Q3XGaOKvVqj0Nsk1UcHhEa7DdEFuJked3V0e70iVbG1P9k
 rYfUEWx9ZLuiSXyQF8iYILKbhA==
X-Google-Smtp-Source: ABdhPJz5InQ30owmtXBOEYTl9rLRYViCgmknbgMPnXE21LrK5AmdsKgwgw42dmFnbwrS3kjE08um9A==
X-Received: by 2002:a17:90b:50c:: with SMTP id
 r12mr21177490pjz.71.1639113553400; 
 Thu, 09 Dec 2021 21:19:13 -0800 (PST)
Received: from judyhsiao-p920.tpe.corp.google.com
 ([2401:fa00:1:10:ac18:fa:d4fe:57bf])
 by smtp.gmail.com with ESMTPSA id f3sm1197853pgv.51.2021.12.09.21.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Dec 2021 21:19:12 -0800 (PST)
From: Judy Hsiao <judyhsiao@chromium.org>
To: broonie@kernel.org
Subject: [PATCH] SoC: qcom: Distinguish headset codec by codec_dai->name
Date: Fri, 10 Dec 2021 13:19:07 +0800
Message-Id: <20211210051907.3870109-1-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: judyhsiao@google.com, Banajit Goswami <bgoswami@codeaurora.org>,
 cychiang@google.com, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, linux-arm-msm@vger.kernel.org,
 swboyd@chromium.org, dianders@chromium.org, Takashi Iwai <tiwai@suse.com>,
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

Distinguish which headset codec is on the board by codec_dai->name
instead of card->name.

Fixes: 425c5fce8a03 ("ASoC: qcom: Add support for ALC5682I-VS codec")
Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
---
 sound/soc/qcom/sc7180.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/sc7180.c b/sound/soc/qcom/sc7180.c
index 2fff764a00a7..37225ef2563a 100644
--- a/sound/soc/qcom/sc7180.c
+++ b/sound/soc/qcom/sc7180.c
@@ -131,13 +131,13 @@ static int sc7180_snd_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
 	int pll_id, pll_source, pll_in, pll_out, clk_id, ret;
 
-	if (!(strcmp(card->name, "sc7180-rt5682-max98357a-1mic"))) {
+	if (!strcmp(codec_dai->name, "rt5682-aif1")) {
 		pll_source = RT5682_PLL1_S_MCLK;
 		pll_id = 0;
 		clk_id = RT5682_SCLK_S_PLL1;
 		pll_out = RT5682_PLL1_FREQ;
 		pll_in = DEFAULT_MCLK_RATE;
-	} else if (!(strcmp(card->name, "sc7180-rt5682s-max98357a-1mic"))) {
+	} else if (!strcmp(codec_dai->name, "rt5682s-aif1")) {
 		pll_source = RT5682S_PLL_S_MCLK;
 		pll_id = RT5682S_PLL2;
 		clk_id = RT5682S_SCLK_S_PLL2;
-- 
2.34.1.173.g76aa8bc2d0-goog

