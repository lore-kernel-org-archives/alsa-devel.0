Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF84C3A59D
	for <alsa-devel@archiver.kernel.org>; Sun, 23 Oct 2022 14:35:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DCA5B8B6D;
	Sun, 23 Oct 2022 16:34:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DCA5B8B6D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666535722;
	bh=l/3r9HJMe9DPrdwSqBbpNLyN/ynG2+Dc9Hr6n4e5I98=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CL5MH60UEvb5UXKB3vZNf66Ofn8uZwtUA1qg9nx4EA6MSSxt1W35I5fwLc2aI0f1b
	 XfdzK+JPM3Y6KUpfLPu8l1R+n9pkVqekg5dmlW1wK1rLadM97Wgj5bg0509FvhMAAy
	 ZseyC42Gce+VT+vg5/ZuqF/z82Y68vhzMHc86yyA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AFB90F80557;
	Sun, 23 Oct 2022 16:33:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A2775F80543; Sun, 23 Oct 2022 16:33:43 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 57F15F8012A
 for <alsa-devel@alsa-project.org>; Sun, 23 Oct 2022 16:33:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 57F15F8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Zy8H6eKZ"
Received: by mail-wr1-x429.google.com with SMTP id y16so1375896wrt.12
 for <alsa-devel@alsa-project.org>; Sun, 23 Oct 2022 07:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yagE6PfAWV1c7o+BEcxE7EzZidDlQUomGLf1in/WfkM=;
 b=Zy8H6eKZB+FQ4I7VGkb+tY3m9TLER0iULJcO2taPxrxxwuUJaQLZ/wez+a11a5aZCZ
 sCV/ScsX03su9YQBJwbBw9XCFOnpkeHtDGPqSQ3GVWi02F4V7jFRDkkejzug5nlDOsFq
 Td1DG19OibxKTK52pcQyysCuqlFz05kzHv0iT7ufJERlUd36HZwQTGRPpgTxS1GrLl8U
 U+KXZQPew75mQKQ+R0yZ7hiv1/QuePiZI4ol59bRHJ+IXXf8fYMrk/tAQKXns0Zk3IWJ
 bvWL23Ife3D39mF/Nl+KVWbfUcLIm7GRSY+UcG+AcaTYgHrUYSGwzpFL9nECiQG6mum7
 dZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yagE6PfAWV1c7o+BEcxE7EzZidDlQUomGLf1in/WfkM=;
 b=ntuFa33cG69BDo3pJZNuPvZDAodVJYespO1bwaPt0dBRXofn2AxARi/LnhSpertEH9
 Z1K/hpn4EdM3z+admMa1/Li+EAPbNxfSYP1ZlWxZC4i9kUzhww23y+QqSiwx2lcafEGP
 YOMUrx13QxZNqSrT0A9xHwsDFCDNNVjyL8Tjy4ekc4rOEgYhgNZCVhjP5YIPsi7ZcCzE
 5xog1XhAR3xvyXUr/Awx9er7cEk3cNxq5pJ6+MyjvdUF+ANCKtycT6L3csYdUL07/bg3
 cEdiKr9o7qBi+esWBD4I+xRyLAW0kzXHsiUsywo7GwTfsSwWHSG7KR1/s5K8aRM1Q2g7
 9P3g==
X-Gm-Message-State: ACrzQf3hhHK1INB4GGPhWHZhKjeNtVEY2ehX2t/1qj4YD2k9Jehd8tCU
 sU5xZIZoISVKd37zJnKeaH0=
X-Google-Smtp-Source: AMsMyM5pk4MuHnfsYjbYLcyZqpaLGd5WxlRnDn1uk1NivJVgywuBaTw9dWBYZgykPuKT1IBA5L4DMA==
X-Received: by 2002:a05:6000:50a:b0:225:210c:a7e4 with SMTP id
 a10-20020a056000050a00b00225210ca7e4mr18207884wrf.704.1666535616636; 
 Sun, 23 Oct 2022 07:33:36 -0700 (PDT)
Received: from localhost (94.197.10.75.threembb.co.uk. [94.197.10.75])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a5d4cd1000000b002362f6fcaf5sm2925381wrt.48.2022.10.23.07.33.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Oct 2022 07:33:36 -0700 (PDT)
From: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To: paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com
Subject: [PATCH v6 4/9] ASoC: jz4740-i2s: Use FIELD_PREP() macros in hw_params
 callback
Date: Sun, 23 Oct 2022 15:33:23 +0100
Message-Id: <20221023143328.160866-5-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20221023143328.160866-1-aidanmacdonald.0x0@gmail.com>
References: <20221023143328.160866-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 zhouyu@wanyeetech.com, linux-mips@vger.kernel.org
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

Get rid of a couple of macros and improve readability by using
FIELD_PREP() and GENMASK() for the sample size setting.

Acked-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index b0bbcd025241..4767abea425f 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -3,6 +3,7 @@
  *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
  */
 
+#include <linux/bitfield.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -42,8 +43,8 @@
 #define JZ_AIC_CONF_SYNC_CLK_MASTER BIT(1)
 #define JZ_AIC_CONF_ENABLE BIT(0)
 
-#define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_MASK (0x7 << 19)
-#define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_MASK (0x7 << 16)
+#define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE GENMASK(21, 19)
+#define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE GENMASK(18, 16)
 #define JZ_AIC_CTRL_ENABLE_RX_DMA BIT(15)
 #define JZ_AIC_CTRL_ENABLE_TX_DMA BIT(14)
 #define JZ_AIC_CTRL_MONO_TO_STEREO BIT(11)
@@ -59,9 +60,6 @@
 #define JZ_AIC_CTRL_ENABLE_PLAYBACK BIT(1)
 #define JZ_AIC_CTRL_ENABLE_CAPTURE BIT(0)
 
-#define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_OFFSET 19
-#define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_OFFSET  16
-
 #define JZ_AIC_I2S_FMT_DISABLE_BIT_CLK BIT(12)
 #define JZ_AIC_I2S_FMT_DISABLE_BIT_ICLK BIT(13)
 #define JZ_AIC_I2S_FMT_ENABLE_SYS_CLK BIT(4)
@@ -249,8 +247,9 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		ctrl &= ~JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_MASK;
-		ctrl |= sample_size << JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_OFFSET;
+		ctrl &= ~JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE;
+		ctrl |= FIELD_PREP(JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE, sample_size);
+
 		if (params_channels(params) == 1)
 			ctrl |= JZ_AIC_CTRL_MONO_TO_STEREO;
 		else
@@ -258,8 +257,8 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
 
 		div_field = i2s->field_i2sdiv_playback;
 	} else {
-		ctrl &= ~JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_MASK;
-		ctrl |= sample_size << JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_OFFSET;
+		ctrl &= ~JZ_AIC_CTRL_INPUT_SAMPLE_SIZE;
+		ctrl |= FIELD_PREP(JZ_AIC_CTRL_INPUT_SAMPLE_SIZE, sample_size);
 
 		div_field = i2s->field_i2sdiv_capture;
 	}
-- 
2.38.1

