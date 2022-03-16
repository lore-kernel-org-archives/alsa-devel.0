Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F8A8C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Mar 2022 04:20:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7CFFB1712;
	Wed, 16 Mar 2022 05:19:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7CFFB1712
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647404431;
	bh=2uVgMb3gvwBQGnedPF+h1WbTRCm/caBE3Alj6dve9MA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LlNWVde1Jl+NZQIiMlJr7fCGCKsIB+YjrwJeDiHPLPDWXYMlEUafkBu4Dd1gv+9W+
	 HH+ampyiXlSUaWyNTXGloTLH+rNE/crUvPweSsN1MZb3Wr5gCOZXUi8dILt8CCEq+j
	 U21OSrf9Nj8BebJ7o+fvLG8VDNss+utLBoMPEJ60=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 04139F80087;
	Wed, 16 Mar 2022 05:19:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6245BF80084; Wed, 16 Mar 2022 05:19:38 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AF089F80084
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2022 05:19:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AF089F80084
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="b+dYa58/"
Received: by mail-pj1-x1036.google.com with SMTP id
 fs4-20020a17090af28400b001bf5624c0aaso1364311pjb.0
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2022 21:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id;
 bh=h/SuuPKRw7w24vf7OzPoNR8TbkFgl2CQUOn+EDnO+xw=;
 b=b+dYa58/Y/mBWqhfqAC4Zm+qdz/l4wkArDE84Y2K6IoBDXbcG6AJmZ8jg1sZyu0VVr
 ko8Ki77J4O2Aday6J1xofFrZtoZpGa9ZARleXA9cPsPok4UQ/uQMrkvtaLkIIfGYww6h
 9aAAO0BTukW5rtXtmkDS0EA/7qlZpQvEenW6B+7ah0Aa2iJ8qL5JJm4ZFculslZoZ/rA
 Q8jvTc/V0K3jcD18IIoslXo3QNTbKVgR/zzS9lqvJ62hveC8g5c/lTndF2PX1w2rjijz
 Qzfh2pWIYzpD5lBDPscWIxJMBTpw5tnilqBGHX6M5IHkYrnsuxBiwiFZ5pvyzB2Xsh2i
 W81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=h/SuuPKRw7w24vf7OzPoNR8TbkFgl2CQUOn+EDnO+xw=;
 b=LwWY2cYNQG2R0fAPDwnuH+Zs0zB6onc8n0kpRSc3gpsriJPXRWJL18S+6eYI3MKFAS
 KOBa9NH9Iq/8Uf1Xstzs96O8Ob/62qtdz/+Ux/oqunFGLb5BQCzpvHk68SCLyKjAK1q6
 m+2NSRb4mofRtBqE/yYwbyDuFoqLM6YOJUjvw2p0CD/bZzkOk3rs8i+IJn2OqDaZyr9A
 xw/yQFXqDCCLa7tKcUqu7mf//yqJ2M2s5+Xq8HbmSkiW3aLnRD4DByBsZ0FwsU2t4GOf
 nD7Tj3rFPIE9VFTGLzK7UKW0OK4ayLrloQTqjHWgfRyfX3l2/FhopJ18s/iyX2QFVsNt
 i0Ig==
X-Gm-Message-State: AOAM5338zsVCzivtRdrKmp3DRkVwDQIoHjACN4Bn5fX5Rixtq+jIeUmn
 jpGo410+EtpceqXlATAFAMk=
X-Google-Smtp-Source: ABdhPJzDSyxdyR405aaXQ572+WpSnGuXpBx5bgw+mkMJqEpnBrS0Kp8BwXkoGY24sqOoP+f9qNP86w==
X-Received: by 2002:a17:902:e949:b0:14b:1f32:e926 with SMTP id
 b9-20020a170902e94900b0014b1f32e926mr31673690pll.170.1647404370056; 
 Tue, 15 Mar 2022 21:19:30 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
 by smtp.googlemail.com with ESMTPSA id
 2-20020a17090a034200b001bfc572d018sm722839pjf.48.2022.03.15.21.19.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Mar 2022 21:19:29 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@codeaurora.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: msm8916-wcd-analog: Fix error handling in
 pm8916_wcd_analog_spmi_probe
Date: Wed, 16 Mar 2022 04:19:24 +0000
Message-Id: <20220316041924.17560-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
Cc: linmq006@gmail.com
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

In the error handling path, the clk_prepare_enable() function
call should be balanced by a corresponding 'clk_disable_unprepare()'
call , as already done in the remove function.

Fixes: de66b3455023 ("ASoC: codecs: msm8916-wcd-analog: add MBHC support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index 485cda46dbb9..e52a559c52d6 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -1222,8 +1222,10 @@ static int pm8916_wcd_analog_spmi_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq_byname(pdev, "mbhc_switch_int");
-	if (irq < 0)
-		return irq;
+	if (irq < 0) {
+		ret = irq;
+		goto err_disable_clk;
+	}
 
 	ret = devm_request_threaded_irq(dev, irq, NULL,
 			       pm8916_mbhc_switch_irq_handler,
@@ -1235,8 +1237,10 @@ static int pm8916_wcd_analog_spmi_probe(struct platform_device *pdev)
 
 	if (priv->mbhc_btn_enabled) {
 		irq = platform_get_irq_byname(pdev, "mbhc_but_press_det");
-		if (irq < 0)
-			return irq;
+		if (irq < 0) {
+			ret = irq;
+			goto err_disable_clk;
+		}
 
 		ret = devm_request_threaded_irq(dev, irq, NULL,
 				       mbhc_btn_press_irq_handler,
@@ -1247,8 +1251,10 @@ static int pm8916_wcd_analog_spmi_probe(struct platform_device *pdev)
 			dev_err(dev, "cannot request mbhc button press irq\n");
 
 		irq = platform_get_irq_byname(pdev, "mbhc_but_rel_det");
-		if (irq < 0)
-			return irq;
+		if (irq < 0) {
+			ret = irq;
+			goto err_disable_clk;
+		}
 
 		ret = devm_request_threaded_irq(dev, irq, NULL,
 				       mbhc_btn_release_irq_handler,
@@ -1265,6 +1271,10 @@ static int pm8916_wcd_analog_spmi_probe(struct platform_device *pdev)
 	return devm_snd_soc_register_component(dev, &pm8916_wcd_analog,
 				      pm8916_wcd_analog_dai,
 				      ARRAY_SIZE(pm8916_wcd_analog_dai));
+
+err_disable_clk:
+	clk_disable_unprepare(priv->mclk);
+	return ret;
 }
 
 static int pm8916_wcd_analog_spmi_remove(struct platform_device *pdev)
-- 
2.17.1

