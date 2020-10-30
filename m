Return-Path: <SRS0=7OoL=EF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3BDC4741F
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:52:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B1C520727
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cyVzNage";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OX4GPg5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1C520727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9BC3A10E;
	Fri, 30 Oct 2020 15:51:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9BC3A10E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604069519;
	bh=fLbCOZDYEwZewm5YtCP7VtEk2XTUfJCp2InFzLYYtxA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cyVzNage22UaAKcfjCvtUy9ZJDt/2TYW8pOU1R8rs8FPrTe7KdJYQNz5Rn0WVCI8S
	 +TzvHOhrjZOIGkQcD/XN7i3J3B1YIAy7+pfZSh5MWYuyfcWOUbwd6fkfwTmzaDGGXB
	 WnFPIHv0Nksj/8D+Ly4IFh3jroYYVLmheN6AaX0g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A2A9F80510;
	Fri, 30 Oct 2020 15:47:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 219F7F804FE; Fri, 30 Oct 2020 15:47:29 +0100 (CET)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4F366F804D2
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2020 15:47:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4F366F804D2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="OX4GPg5V"
Received: by mail-ot1-x342.google.com with SMTP id b2so5757382ots.5
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2020 07:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZdYIRpJXQysolM6oP9zf52EwQrg31M/ZfGFP3DuIu5M=;
 b=OX4GPg5VsTfhqBx058ybshrvZonS3TOFrNB6pQSQYAt9GOJf/+kvU57cdit7QM6sWg
 OQp+W+SwmjJkR80VsUmpkDYuNc6SuE99SGUCm5+RylcABXjLczpWr+cCyFtzH90PV1XN
 ptiSiA5yJ+7Q7MXCWzrawRRbIqzYeIuJdSQJN9gSAJ7g/RPqLvHdWdMSnvm6o/RKr/Fk
 wEM1RD7d9koaF/h9g1WRGU1aj3r68PoV9LoKUPM3muv+LSYDPlILDz6EYEyvuerNju7I
 IBEvamVsWC/fz4GlUzS+cJiO5nXB9HPNJqIsAs6Yfgs6eJApEBMVI/k/wiuYDYdueBfB
 YuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZdYIRpJXQysolM6oP9zf52EwQrg31M/ZfGFP3DuIu5M=;
 b=jGQWSvMHif3Fdcb21PiqVED0t+3+GXLobPIB12pcHT/72LIDm1uNXCNJmdKGL63oPX
 LkG8xl6nMRO4YKAgACl3ymdjiZq70cRRVXXGlSaQyXEY8CUMWD0UPBT9FiAFVtm05W2k
 H+7MEm0v2sQkJxlJf1sjGCYHN7q1HwDCtGJp0Ak+IQKT3YMG6oStdz842ASxvT7Z77VZ
 4lHmw1CMX6c6diOVsvOd0Ecv0TM3GzH0LtPH/ZPVnaLZcekM4VlPEeFg+2OQdPJF29wW
 n4vYkrt+PZmQXY/c2T9j5qHw5k/I5qKYGzTupQDjPhMd+w0LiOLfgzbMYXsYekFvf6w1
 QiaQ==
X-Gm-Message-State: AOAM5303ar1nRP8ro7P87GT3/FHu0mLakNekCYR2FmOa14pXOrMt29Wf
 bxANbCkdTh4PlPNMx3/RxkY=
X-Google-Smtp-Source: ABdhPJxuVgbxtNmHxZe8XmLqrwhnM3JiW3gaijw6IDQCb9UiO1JffwDqHqrVnxqYvCOajuDO2rv+Hw==
X-Received: by 2002:a9d:7cce:: with SMTP id r14mr1989365otn.204.1604069240086; 
 Fri, 30 Oct 2020 07:47:20 -0700 (PDT)
Received: from localhost.localdomain (213-245-241-245.rev.numericable.fr.
 [213.245.241.245])
 by smtp.gmail.com with ESMTPSA id s20sm1462856oof.39.2020.10.30.07.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 07:47:19 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v10 08/15] ASoC: sun4i-i2s: Fix setting of FIFO modes
Date: Fri, 30 Oct 2020 15:46:41 +0100
Message-Id: <20201030144648.397824-9-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030144648.397824-1-peron.clem@gmail.com>
References: <20201030144648.397824-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>,
 alsa-devel@alsa-project.org, Samuel Holland <samuel@sholland.org>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Marcus Cooper <codekipper@gmail.com>, linux-sunxi@googlegroups.com,
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

From: Samuel Holland <samuel@sholland.org>

Because SUN4I_I2S_FIFO_CTRL_REG is volatile, writes done while the
regmap is cache-only are ignored. To work around this, move the
configuration to a callback that runs while the ASoC core has a
runtime PM reference to the device.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 003610c0badf..4f5cd850752d 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -596,6 +596,13 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
+	/* Set significant bits in our FIFOs */
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
+			   SUN4I_I2S_FIFO_CTRL_TX_MODE_MASK |
+			   SUN4I_I2S_FIFO_CTRL_RX_MODE_MASK,
+			   SUN4I_I2S_FIFO_CTRL_TX_MODE(1) |
+			   SUN4I_I2S_FIFO_CTRL_RX_MODE(1));
+
 	switch (params_physical_width(params)) {
 	case 16:
 		width = DMA_SLAVE_BUSWIDTH_2_BYTES;
@@ -924,13 +931,6 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return ret;
 	}
 
-	/* Set significant bits in our FIFOs */
-	regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
-			   SUN4I_I2S_FIFO_CTRL_TX_MODE_MASK |
-			   SUN4I_I2S_FIFO_CTRL_RX_MODE_MASK,
-			   SUN4I_I2S_FIFO_CTRL_TX_MODE(1) |
-			   SUN4I_I2S_FIFO_CTRL_RX_MODE(1));
-
 	i2s->format = fmt;
 
 	return 0;
-- 
2.25.1

