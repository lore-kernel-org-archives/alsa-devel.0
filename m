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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103DEC4363A
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:50:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 346032076E
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pkyWeCEz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rEPruIXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 346032076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8B8351654;
	Fri, 30 Oct 2020 15:49:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8B8351654
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604069437;
	bh=hJ/fmI3LFZTy1500BXQDzXT5dQDWjzsCJKx5P9vikbs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pkyWeCEzf3bFjZssyT48+Jyt57oEwYPqwWxZrzfQWCdHHAhlO+lAYnepk/Gt/q8nB
	 aFU00e7p00r4NTinH6MJpu9QnxklBHmLVpIMMEUTPNG7hrNo0G6Ou0EGdEZTiPIMqo
	 vG7DLNwsAMhz0XarFy7ElbLecd2kIySZNSRVw7SI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B43D5F804F3;
	Fri, 30 Oct 2020 15:47:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0772FF804F3; Fri, 30 Oct 2020 15:47:23 +0100 (CET)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9A029F804D2
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2020 15:47:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A029F804D2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="rEPruIXP"
Received: by mail-ot1-x344.google.com with SMTP id a6so5736447otp.10
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2020 07:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hVl8qXyL4uyE+bKvgQrUQIjmv0VmS+Xl5odcY5Z+CoI=;
 b=rEPruIXPTVXLfk67LDH5YCfgYBjZF5vIrUX5Tbnn9ls+c7uvOSpuBR/pxgWaM4eLSA
 uucxveJU5jrBrOSrMFqsyyhPBvcOeI4XyN2NmHddCtWdlLfsEopLtb5OqTayDGPTX3u4
 xg7DRqPCiYusOR/daBojNeKKOYebXxUlXDcNxTita3qsSUKzL2+Yki2pnNB0D7/Dz0jQ
 76XaRk7uZ4dpmNl5+4w5lFgXRRrf6+CidQu/MUSiiAZHf8JX5Cl+TjWzDmqDijky8nca
 UUtDE+1n1CYaGMkN6L/rs//PJWFax6Csj+ooUdl1J8mU9Hjds5ip3msnn/3Ki+Jjqiga
 Jp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hVl8qXyL4uyE+bKvgQrUQIjmv0VmS+Xl5odcY5Z+CoI=;
 b=Ys78iHaijSdMFfm9YGeXdEfzpF6eqxCeXrwkF6kZlU0corLY/Al+D9oNJE94CAvmb3
 RNUkpcvK9+T/uNzTltQmEsqa7XG//1I4vkPjXG2wTJVL5Jk5YDnWBlLd4L5/8Tv2P7JB
 pUbc6LbkQFw/d3RLF7RjgaZmaYQOgbcNJIeVBX4iSAOTzZF1D/BuxgyN+t+AqcKHOExD
 ZD0aTr3ZUTeUWXg+mZQD0t421XeXUZWC7VpkZ6HGfHaBfRblNCkiqNL9vdcEUqSqznrD
 pB+ct77Cr1yOoHj4Y3i3gsETorp/8ePCEpFJhZEI+ZgDk+FUzEjDLaVnh5Ra9+gGcrCC
 kWYw==
X-Gm-Message-State: AOAM530M2ik1krZ6q+SKcL5P7Ffx3vtk9sAG8aj7bwQSWSlh8iziaOv3
 X9L67FJquVC1lFDuRGeodHM=
X-Google-Smtp-Source: ABdhPJyXk1sTONN1FzWWHkaULZ0gNYWaxtyOSeBBxR4VbPDIVIvSmhcinPoe5FOpCzGCuc0JWuo7/A==
X-Received: by 2002:a9d:3d44:: with SMTP id a62mr1834140otc.254.1604069233998; 
 Fri, 30 Oct 2020 07:47:13 -0700 (PDT)
Received: from localhost.localdomain (213-245-241-245.rev.numericable.fr.
 [213.245.241.245])
 by smtp.gmail.com with ESMTPSA id s20sm1462856oof.39.2020.10.30.07.47.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 07:47:13 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v10 06/15] ASoC: sun4i-i2s: Add 20 and 24 bit support
Date: Fri, 30 Oct 2020 15:46:39 +0100
Message-Id: <20201030144648.397824-7-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030144648.397824-1-peron.clem@gmail.com>
References: <20201030144648.397824-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Marcus Cooper <codekipper@gmail.com>,
 linux-sunxi@googlegroups.com,
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

Extend the functionality of the driver to include support of 20 and
24 bits per sample.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 46e4da18c27f..786731191d90 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -600,6 +600,9 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	case 16:
 		width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 		break;
+	case 32:
+		width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		break;
 	default:
 		dev_err(dai->dev, "Unsupported physical sample width: %d\n",
 			params_physical_width(params));
@@ -1081,6 +1084,10 @@ static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
+#define SUN4I_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
+			 SNDRV_PCM_FMTBIT_S20_LE | \
+			 SNDRV_PCM_FMTBIT_S24_LE)
+
 static struct snd_soc_dai_driver sun4i_i2s_dai = {
 	.probe = sun4i_i2s_dai_probe,
 	.capture = {
@@ -1088,14 +1095,14 @@ static struct snd_soc_dai_driver sun4i_i2s_dai = {
 		.channels_min = 1,
 		.channels_max = 8,
 		.rates = SNDRV_PCM_RATE_8000_192000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		.formats = SUN4I_FORMATS,
 	},
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 1,
 		.channels_max = 8,
 		.rates = SNDRV_PCM_RATE_8000_192000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		.formats = SUN4I_FORMATS,
 	},
 	.ops = &sun4i_i2s_dai_ops,
 	.symmetric_rates = 1,
-- 
2.25.1

