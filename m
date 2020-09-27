Return-Path: <SRS0=Oq54=DE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACC5C4346E
	for <alsa-devel@archiver.kernel.org>; Sun, 27 Sep 2020 19:34:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8892323A05
	for <alsa-devel@archiver.kernel.org>; Sun, 27 Sep 2020 19:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="G01GIHXq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLJ61lga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8892323A05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 18CF81AA4;
	Sun, 27 Sep 2020 21:33:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 18CF81AA4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601235279;
	bh=c0Jmkle34lcelvv1AxYeXtRnxz1TEmNAwZTA+1Ou7jA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G01GIHXqAicaPFgy+v6065X8c19AByBLIJN9A4w42qFPSIqz64aiHqk4q2gAEwodZ
	 RhEGcGf351CLtkdLqV6FIXjhlUrCiv+RpISkPq05TG6OtG5C+AK/Ysaw7PEF4Djhv+
	 G2WsvQgsSC1sna19GsRLMRy8mTWYb3VdzQzGjXiI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 036F0F80305;
	Sun, 27 Sep 2020 21:30:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6C32AF801DB; Sun, 27 Sep 2020 21:29:38 +0200 (CEST)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 10457F801DB
 for <alsa-devel@alsa-project.org>; Sun, 27 Sep 2020 21:29:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 10457F801DB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="LLJ61lga"
Received: by mail-wm1-x342.google.com with SMTP id q9so4396718wmj.2
 for <alsa-devel@alsa-project.org>; Sun, 27 Sep 2020 12:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JlxXAFB85DXviVVzU9snS3b51VMvFbEM+bK6288hNSg=;
 b=LLJ61lgaZTOMqpVlNPKwbccLGS/qKNP3TcbScbdHfhnJ57en1huY00FJx1oxE1n3LB
 124K55B/1sRjka5yKE1J3I6Bx58rgfrPkKft9px1ggdQiNp1KYYH6mcOoSr13ZFI1Me8
 NjNsx91mcPoB3s1koIWgwyg1jI2nX46eb+A383oA79ZuafsEv3KxKDGB2Ft5n5y52kAT
 Vbp7+spDWmRGv7zWxrdI8KJRymtbX6OF4cFQwwwBi8Xt2siPVqkJQMMR9LyGgf99g+eW
 bPaIaLUKmrj2trNfxDerkD8x9CzfwYQBI2WDsaE5rzUWF/QHzUTnHkJmu3/ybWAPMx5l
 piRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JlxXAFB85DXviVVzU9snS3b51VMvFbEM+bK6288hNSg=;
 b=Bij+Bsmg4EkdDb82/f5dV7tEdGn/3wMCvNFEsYGO5eFuwpZILKVJFxq0exxtTFXJVe
 Bv9F7cl++oru9d4vz6qBWRUociQsnRu0p9LNtO8fWs3IS5Ol4qYkZpC69QfjaGWrGdUH
 DkxaFm/z7bCYZfJTxjzoEXy2ZeTKY4g/N7S97FRWOeEo0iy91B+Q4KFyWbcp66EX003j
 O8esglu8iXRZ9oyLA5owRXgdnYAr0tfRizxTdENU8MMbensXADxd98WGCnVYfAhXjuBc
 6XsD6yPpQko28Hk2SG6hNC4OgzqgtnV1TLEwNhRN2xJ8AOSwqiysce4EpN7gnXBNsbSI
 8CXA==
X-Gm-Message-State: AOAM530pOHHKp2LkxCc1Z00EanOCZvddLWCpBIZrY1iCzHaSZ05vvuHm
 Ij5e7GPGYNAcVVguzwfNN5Y=
X-Google-Smtp-Source: ABdhPJzU+oCRv5cPGJT6Jhm1gGotghAHe7SKA1ZenbPaXNMkpCnPCWNF1TQAQSwhJCnE9s5ZUCum2A==
X-Received: by 2002:a1c:e046:: with SMTP id x67mr7969163wmg.35.1601234964796; 
 Sun, 27 Sep 2020 12:29:24 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr
 (213-245-241-245.rev.numericable.fr. [213.245.241.245])
 by smtp.gmail.com with ESMTPSA id n21sm6149609wmi.21.2020.09.27.12.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2020 12:29:24 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v5 06/20] ASoc: sun4i-i2s: Add 20 and 24 bit support
Date: Sun, 27 Sep 2020 21:28:58 +0200
Message-Id: <20200927192912.46323-7-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200927192912.46323-1-peron.clem@gmail.com>
References: <20200927192912.46323-1-peron.clem@gmail.com>
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
Signed-off-by: Clément Péron <peron.clem@gmail.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index b31454eee43c..60b2fec1bbe9 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -590,6 +590,9 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	case 16:
 		width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 		break;
+	case 32:
+		width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		break;
 	default:
 		dev_err(dai->dev, "Unsupported physical sample width: %d\n",
 			params_physical_width(params));
@@ -1071,6 +1074,10 @@ static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
+#define SUN4I_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
+			 SNDRV_PCM_FMTBIT_S20_LE | \
+			 SNDRV_PCM_FMTBIT_S24_LE)
+
 static struct snd_soc_dai_driver sun4i_i2s_dai = {
 	.probe = sun4i_i2s_dai_probe,
 	.capture = {
@@ -1078,14 +1085,14 @@ static struct snd_soc_dai_driver sun4i_i2s_dai = {
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

