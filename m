Return-Path: <SRS0=mTWV=6K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CD5C55199
	for <alsa-devel@archiver.kernel.org>; Sun, 26 Apr 2020 10:45:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E9132070A
	for <alsa-devel@archiver.kernel.org>; Sun, 26 Apr 2020 10:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="h38O7RJU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YV8SdxWn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E9132070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A2316167D;
	Sun, 26 Apr 2020 12:44:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A2316167D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587897939;
	bh=922LOphSKBE+n9jSWPNyB3s9w9OA0VZvaXHNAZpfuRw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h38O7RJU7K0eLYzFw2ndL0pplMQYU+evhvNEFruMLrWEdirPbLVdLrjQFgHHvFmXm
	 6kH0obPcuLCxG0fYzMfePvJe+IT/j9hEjJGJv570Ds0T+7QocQH5K1C0Hk05Urs7ec
	 mPX+o50BRn41vYuigAEdoKqALiWsX5KZCQ7PQhnY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EF2A1F802BD;
	Sun, 26 Apr 2020 12:41:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7BB49F802BD; Sun, 26 Apr 2020 12:41:36 +0200 (CEST)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 60C00F8028F
 for <alsa-devel@alsa-project.org>; Sun, 26 Apr 2020 12:41:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 60C00F8028F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="YV8SdxWn"
Received: by mail-wm1-x343.google.com with SMTP id e26so16245349wmk.5
 for <alsa-devel@alsa-project.org>; Sun, 26 Apr 2020 03:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/FLLl3Lmv6P46g23QaNfgW2hXBgcdl0HHdXkGyMc3vQ=;
 b=YV8SdxWnCc7yDLnHkZGAeWRKIyr/QoRW4IOW0ERhXl1Sk67OS4PbfAGe5c44az0zzn
 gSLeDjP1mOWpE/nDCUFVkbINqiYRabevpwJKJk99nNPr6/mGS8wEg3bGOJJLwi/+sq9W
 68xapeEEDPYPqlcxP1MRaSx8KYKquHkJv9WIle6pxk2AH30Lpd4UJJmKexNSBeg+ydJh
 Xd+XKwa0wsB8XIBhc6ncR0XO9GVIEkr4WTJzhpUNdfPE1YfncqvCDedLTcQOZzXQBdZc
 Tp2rZp6tNz+zkvJHrzjn1PkvN0syPRtg2uM4X0+6/XYe4HlmSf5ECH69lBnY+yXiU/St
 ridg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/FLLl3Lmv6P46g23QaNfgW2hXBgcdl0HHdXkGyMc3vQ=;
 b=PwvhaEbuZDixI2AzRchw3UCkRHjLuvg5SShea805nFyYgyY58Y2zCZb3a4ahHPixDL
 z1B8CvE7izsVAmjVDA39sM3kdCyR9ShRg8LfyPWr5DjBHtyvyo25sxwnKVRGgRvuQRk/
 trjZJHhi4lBH33N565nsn6PUotqcGS8lWYohEqQiVtWYKgvhX3ZT3KEfqRKnMQrwPyzs
 9s8gG18I1ztNjT/ZzbG7LO/KPJGjLpj3UtBM6qHNS6P2hW6ZJjjOYfdogslVwooTwt4s
 A5QY0c5EoMiAOobgHJPVHSmk39hsMfNhEXV997pJVJbY9TH0aOq/TgQINrFiJAeoGJIZ
 Fosg==
X-Gm-Message-State: AGi0PuZEaLZyS2/oou43zmoC/y0y7DjxDSV5sZ+6//tuqR1rCYl94poc
 UY+W++ZxYWHZrujYKAo5szM=
X-Google-Smtp-Source: APiQypKv5SHULHMlQUX80eAs8h8KPRFAzZNFj61ehmLXvJWXiIe6MAQFvFVTO/AASlwcFJaq37x6pQ==
X-Received: by 2002:a7b:ce8b:: with SMTP id q11mr20341161wmj.101.1587897685701; 
 Sun, 26 Apr 2020 03:41:25 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:59f6:22c5:d1f3:662d])
 by smtp.gmail.com with ESMTPSA id
 y10sm10491793wma.5.2020.04.26.03.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2020 03:41:25 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v3 6/7] ASoC: sun4i-i2s: Adjust regmap settings
Date: Sun, 26 Apr 2020 12:41:14 +0200
Message-Id: <20200426104115.22630-7-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200426104115.22630-1-peron.clem@gmail.com>
References: <20200426104115.22630-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Marcus Cooper <codekipper@gmail.com>,
 =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
 linux-arm-kernel@lists.infradead.org
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

From: Marcus Cooper <codekipper@gmail.com>

Bypass the regmap cache when flushing or reading the i2s FIFOs.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 277bf566c154..b5ab25483a9b 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1121,6 +1121,8 @@ static bool sun4i_i2s_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case SUN4I_I2S_FIFO_RX_REG:
+	case SUN4I_I2S_FIFO_TX_REG:
+	case SUN4I_I2S_FIFO_STA_REG:
 	case SUN4I_I2S_INT_STA_REG:
 	case SUN4I_I2S_RX_CNT_REG:
 	case SUN4I_I2S_TX_CNT_REG:
-- 
2.20.1

