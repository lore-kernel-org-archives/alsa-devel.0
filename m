Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72D1C3A59D
	for <alsa-devel@archiver.kernel.org>; Sun, 23 Oct 2022 14:35:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AE0039D05;
	Sun, 23 Oct 2022 16:35:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AE0039D05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666535754;
	bh=d3R6okVKHjoNxNU2TGxkaOCSUVch4EdpyWf8I4YiTQs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MLT8CM8QWtEIGKY48ixHHbmfAOq/rXZtRwekDaNceJPVUTs97Ge+Kvp+kp8ppPQX2
	 ZW5JuLuS+Njnqc5xkDV1pp63y3TFH97/QIIlwQi+a3VL1GfRUNiPRMWGclzDSmvxYU
	 cvdbVA3rt12a79V6sfwlpD4ZshUA2Azu5wvTqrI4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 55698F8055A;
	Sun, 23 Oct 2022 16:33:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 05550F80558; Sun, 23 Oct 2022 16:33:46 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7D49CF8047B
 for <alsa-devel@alsa-project.org>; Sun, 23 Oct 2022 16:33:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7D49CF8047B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="axlbN88z"
Received: by mail-wr1-x42f.google.com with SMTP id bp11so11466922wrb.9
 for <alsa-devel@alsa-project.org>; Sun, 23 Oct 2022 07:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZPVuUDMde4iT9AFYS7nsIkkUonhoCr0Fb8M7bh3R14c=;
 b=axlbN88z42NeyE9gww1dFYP+qpXMECN3tXcq/dmWjoR7QBfnKv8sAf7zy6oqZpkGJK
 fS4+Fb50bYSBaJxYSKsFYgh6aOqJBl2eVfDlQxFg3nygMMN0zpLGY1NH6v+9ueEaObih
 GvRXstIvxK22ja+OuKvM1KszAOLGI+ffJD8Tn4X42APvrxRqo1ARkmLdNXpWFktwYbuy
 ivWm8xJFmcZB0aSorqYMakPU3QnEtZ3G4M8Pq7gdiLFMVGI/H2mEH6C5SFAuekUQ7sam
 we+cvj4ThPxB70kRh+LNxFGkWga0SHGP0txJVZIICeo648JL0fWxzgZ/6ZFBdLwRaqis
 licw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZPVuUDMde4iT9AFYS7nsIkkUonhoCr0Fb8M7bh3R14c=;
 b=NoYEyRW77TuKoGLERA5sMr7tgeepmv5QcddfreCZVlBwqfNJwBjbHaToEnEFqiQyRd
 tOkkJmboTDAH5DLja20/w8MZEBhwwpAT3O8SRSzynG5sp/Z5fVgmf+d4mgMyQNU9iD98
 NMm79BGPaUTAbRJzFBhlNoZb/ZK2e42QLbYDW+x6rNdraMKZ+fRx2GPRzAfumPudtC1d
 VE5kEs4Gme2HBEuqEFjOPdPqgNeTuH/Chf0mjeG9chFrWTZcNv+vLy+dHdxAVrzTQ9cR
 1TjIRzGVyiLyfHzntQOzGlAXfmSsOsQ3gJ6Oedwa4kpY8hh6RGhxKJxdsMH3e98cy6m0
 srkg==
X-Gm-Message-State: ACrzQf0A56pLz48yrH9n8Vtl4kK6iy5jWHXukujw70GC2fJmTRHCnGET
 U46GsZhDqOE4kvcyjOaJv6c=
X-Google-Smtp-Source: AMsMyM6nByUQJewaeg4c+zis+6VAd98GbK2NlqxFod153k4DlVNEl6Kut045sy5mkB/eZajarZzoDQ==
X-Received: by 2002:a5d:42c5:0:b0:236:60ed:9abf with SMTP id
 t5-20020a5d42c5000000b0023660ed9abfmr4416189wrr.454.1666535617850; 
 Sun, 23 Oct 2022 07:33:37 -0700 (PDT)
Received: from localhost (94.197.10.75.threembb.co.uk. [94.197.10.75])
 by smtp.gmail.com with ESMTPSA id
 hg16-20020a05600c539000b003c6b70a4d69sm8300046wmb.42.2022.10.23.07.33.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Oct 2022 07:33:37 -0700 (PDT)
From: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To: paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com
Subject: [PATCH v6 5/9] ASoC: jz4740-i2s: Align macro values and sort includes
Date: Sun, 23 Oct 2022 15:33:24 +0100
Message-Id: <20221023143328.160866-6-aidanmacdonald.0x0@gmail.com>
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

Some purely cosmetic changes: line up all the macro values to
make things easier to read and sort the includes alphabetically.

Acked-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 66 +++++++++++++++++------------------
 1 file changed, 32 insertions(+), 34 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 4767abea425f..c3235e993ffb 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -4,6 +4,9 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -13,11 +16,6 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
-#include <linux/clk.h>
-#include <linux/delay.h>
-
-#include <linux/dma-mapping.h>
-
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -35,37 +33,37 @@
 #define JZ_REG_AIC_CLK_DIV	0x30
 #define JZ_REG_AIC_FIFO		0x34
 
-#define JZ_AIC_CONF_OVERFLOW_PLAY_LAST BIT(6)
-#define JZ_AIC_CONF_INTERNAL_CODEC BIT(5)
-#define JZ_AIC_CONF_I2S BIT(4)
-#define JZ_AIC_CONF_RESET BIT(3)
-#define JZ_AIC_CONF_BIT_CLK_MASTER BIT(2)
-#define JZ_AIC_CONF_SYNC_CLK_MASTER BIT(1)
-#define JZ_AIC_CONF_ENABLE BIT(0)
-
-#define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE GENMASK(21, 19)
-#define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE GENMASK(18, 16)
-#define JZ_AIC_CTRL_ENABLE_RX_DMA BIT(15)
-#define JZ_AIC_CTRL_ENABLE_TX_DMA BIT(14)
-#define JZ_AIC_CTRL_MONO_TO_STEREO BIT(11)
-#define JZ_AIC_CTRL_SWITCH_ENDIANNESS BIT(10)
-#define JZ_AIC_CTRL_SIGNED_TO_UNSIGNED BIT(9)
+#define JZ_AIC_CONF_OVERFLOW_PLAY_LAST	BIT(6)
+#define JZ_AIC_CONF_INTERNAL_CODEC	BIT(5)
+#define JZ_AIC_CONF_I2S			BIT(4)
+#define JZ_AIC_CONF_RESET		BIT(3)
+#define JZ_AIC_CONF_BIT_CLK_MASTER	BIT(2)
+#define JZ_AIC_CONF_SYNC_CLK_MASTER	BIT(1)
+#define JZ_AIC_CONF_ENABLE		BIT(0)
+
+#define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE	GENMASK(21, 19)
+#define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE	GENMASK(18, 16)
+#define JZ_AIC_CTRL_ENABLE_RX_DMA	BIT(15)
+#define JZ_AIC_CTRL_ENABLE_TX_DMA	BIT(14)
+#define JZ_AIC_CTRL_MONO_TO_STEREO	BIT(11)
+#define JZ_AIC_CTRL_SWITCH_ENDIANNESS	BIT(10)
+#define JZ_AIC_CTRL_SIGNED_TO_UNSIGNED	BIT(9)
 #define JZ_AIC_CTRL_TFLUSH		BIT(8)
 #define JZ_AIC_CTRL_RFLUSH		BIT(7)
-#define JZ_AIC_CTRL_ENABLE_ROR_INT BIT(6)
-#define JZ_AIC_CTRL_ENABLE_TUR_INT BIT(5)
-#define JZ_AIC_CTRL_ENABLE_RFS_INT BIT(4)
-#define JZ_AIC_CTRL_ENABLE_TFS_INT BIT(3)
-#define JZ_AIC_CTRL_ENABLE_LOOPBACK BIT(2)
-#define JZ_AIC_CTRL_ENABLE_PLAYBACK BIT(1)
-#define JZ_AIC_CTRL_ENABLE_CAPTURE BIT(0)
-
-#define JZ_AIC_I2S_FMT_DISABLE_BIT_CLK BIT(12)
-#define JZ_AIC_I2S_FMT_DISABLE_BIT_ICLK BIT(13)
-#define JZ_AIC_I2S_FMT_ENABLE_SYS_CLK BIT(4)
-#define JZ_AIC_I2S_FMT_MSB BIT(0)
-
-#define JZ_AIC_I2S_STATUS_BUSY BIT(2)
+#define JZ_AIC_CTRL_ENABLE_ROR_INT	BIT(6)
+#define JZ_AIC_CTRL_ENABLE_TUR_INT	BIT(5)
+#define JZ_AIC_CTRL_ENABLE_RFS_INT	BIT(4)
+#define JZ_AIC_CTRL_ENABLE_TFS_INT	BIT(3)
+#define JZ_AIC_CTRL_ENABLE_LOOPBACK	BIT(2)
+#define JZ_AIC_CTRL_ENABLE_PLAYBACK	BIT(1)
+#define JZ_AIC_CTRL_ENABLE_CAPTURE	BIT(0)
+
+#define JZ_AIC_I2S_FMT_DISABLE_BIT_CLK	BIT(12)
+#define JZ_AIC_I2S_FMT_DISABLE_BIT_ICLK	BIT(13)
+#define JZ_AIC_I2S_FMT_ENABLE_SYS_CLK	BIT(4)
+#define JZ_AIC_I2S_FMT_MSB		BIT(0)
+
+#define JZ_AIC_I2S_STATUS_BUSY		BIT(2)
 
 struct i2s_soc_info {
 	struct snd_soc_dai_driver *dai;
-- 
2.38.1

