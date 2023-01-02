Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00108C46467
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Jan 2023 11:44:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8186094EC;
	Mon,  2 Jan 2023 12:43:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8186094EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1672659882;
	bh=VHu+U2f8NH80Q8jsWP1wRYouUy/Npm1p2d37zMx/MGo=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=FY5uDu0+U/RosObPcc77ypvYgZYtK2GvHrMIm+v3zm3HfFdc9IgrRfTRu3jxPdRoQ
	 gBFmWx6nrrtR/h+SA0vsicZmXTQYze7BJKGFA9AI3LBkL8sNEIEMfUoCKbN0s/HFo1
	 dqRew1qd4zXrqLICma5lQSY+sOEHOe8Nc3shqBLo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 35F5CF8057E;
	Mon,  2 Jan 2023 12:42:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EF1FCF8055B; Mon,  2 Jan 2023 12:42:09 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6B8CAF800C0
 for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2023 12:42:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6B8CAF800C0
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=fRM/fxDl
Received: by mail-lf1-x12c.google.com with SMTP id bp15so41232199lfb.13
 for <alsa-devel@alsa-project.org>; Mon, 02 Jan 2023 03:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l5BQ+1OykJNJsHs5tcaOG30ml/uGVrBU87LMcPdV8zM=;
 b=fRM/fxDlUALu6ECRXeB8H4JGEENdHMfeVFBr4nnIjeAV1DMReAGdy+VQmFSBnoxrR4
 +fM6gGKxZuiN0uc1VijxgzkEIL5/4JpW/istSlmPsEsVOrtRIP71t0tzyJpfv1Mzwt0D
 6P0SryFFkmoz9JUo24GfQq8H/ULD/8LvMiFqiM6KQeIU1uqbtpSsM0fmRB4cI5mh42Vt
 mm6aOywOIBYU5dhjUDkfq1Hkkue6jP/8lsP04XOxCReEqu1S+8P4vXFZjk9iZ37AgMvw
 EoiWOjGMXnPhRiEp8nIThcy7mPCsvoj5UlJHSK1OAVs3b6bxqw/AmrsBmAo19cHgym40
 Tg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l5BQ+1OykJNJsHs5tcaOG30ml/uGVrBU87LMcPdV8zM=;
 b=K2fCJwY5Al4Z6Lp1FzV821m7Mdigu4whVCIU+g9Kj3OD1NmQfY/NaWprZv2VoKamNf
 j2NyHJ+lYCjknxOwt1iikJmaP9ioaG6W0aKuNu10//MKhRwvfzrduaKMe7cCTo2utOPt
 eT5o6rz7euk+YTz4BB3RISwN+zz1HrUAGns1FTkgbl2uwu5CX3dNjsC2r7K72Y6w9KFa
 Hf28S/EvDoWgBz7QaULwzpGEciIuTvGZokP6XpdxN5UguN6ro3ZZ9YLaXFJ3EnIpR7vQ
 lOUrqBVJl3MP3v408dfayP83CzEt4wx6Afr5vq7dhrudBwe7AhhF5nkB82Nyxo/CnAA3
 M+JQ==
X-Gm-Message-State: AFqh2kqeLfrIm8HiV45yi4oQSQ8HxQmQFnYEvxEBAqERyjJSIHW2RA9M
 iTTfCG67D8rU9b/vk/5OvHHy+Q==
X-Google-Smtp-Source: AMrXdXuGQ9JzQqwc2ZeEFIxkrXF2oicM9ZNu1cH2soNd9yHwRX/GsnC8xzPw/8AsZ3PhXrftAw3/ag==
X-Received: by 2002:a05:6512:b0c:b0:4b5:97cf:8f1a with SMTP id
 w12-20020a0565120b0c00b004b597cf8f1amr13379095lfu.40.1672659718470; 
 Mon, 02 Jan 2023 03:41:58 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl
 (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
 by smtp.gmail.com with ESMTPSA id
 c20-20020ac24154000000b0048a8c907fe9sm4356397lfi.167.2023.01.02.03.41.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jan 2023 03:41:58 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 2/8] ASoC: codecs: wsa881x: Simplify &pdev->dev in probe
Date: Mon,  2 Jan 2023 12:41:46 +0100
Message-Id: <20230102114152.297305-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230102114152.297305-1-krzysztof.kozlowski@linaro.org>
References: <20230102114152.297305-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The probe already stores pointer to &pdev->dev, so use it to make the
code a bit easier to read.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wsa881x.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index 6c8b1db649b8..cd7be55f6a89 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -1113,20 +1113,20 @@ static int wsa881x_probe(struct sdw_slave *pdev,
 	struct wsa881x_priv *wsa881x;
 	struct device *dev = &pdev->dev;
 
-	wsa881x = devm_kzalloc(&pdev->dev, sizeof(*wsa881x), GFP_KERNEL);
+	wsa881x = devm_kzalloc(dev, sizeof(*wsa881x), GFP_KERNEL);
 	if (!wsa881x)
 		return -ENOMEM;
 
-	wsa881x->sd_n = devm_gpiod_get_optional(&pdev->dev, "powerdown",
+	wsa881x->sd_n = devm_gpiod_get_optional(dev, "powerdown",
 						GPIOD_FLAGS_BIT_NONEXCLUSIVE);
 	if (IS_ERR(wsa881x->sd_n)) {
 		dev_err(&pdev->dev, "Shutdown Control GPIO not found\n");
 		return PTR_ERR(wsa881x->sd_n);
 	}
 
-	dev_set_drvdata(&pdev->dev, wsa881x);
+	dev_set_drvdata(dev, wsa881x);
 	wsa881x->slave = pdev;
-	wsa881x->dev = &pdev->dev;
+	wsa881x->dev = dev;
 	wsa881x->sconfig.ch_count = 1;
 	wsa881x->sconfig.bps = 1;
 	wsa881x->sconfig.frame_rate = 48000;
@@ -1149,7 +1149,7 @@ static int wsa881x_probe(struct sdw_slave *pdev,
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
 
-	return devm_snd_soc_register_component(&pdev->dev,
+	return devm_snd_soc_register_component(dev,
 					       &wsa881x_component_drv,
 					       wsa881x_dais,
 					       ARRAY_SIZE(wsa881x_dais));
-- 
2.34.1

