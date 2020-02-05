Return-Path: <SRS0=flyq=3Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3485BC33CA1
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:39:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6AF2217BA
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NDAgI3cA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="CoDv4bmu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6AF2217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D1580167A;
	Wed,  5 Feb 2020 10:39:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D1580167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580895593;
	bh=jqzzkrQXnD4ID1h2SBOUaw6OALb+V6fimUp3bSOZHw0=;
	h=Date:In-Reply-To:References:From:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NDAgI3cAjJ0kjSinLpeef74D40sLu4l6vwyd1QWKgRmU7vArO99OHLL1hnjBAmfCq
	 Ma7oG+WZZfXOPfm85dBYnkJFPcBNgHViizwEJq8vjVv6B1R1L7oXbb7H19yuhwgEq5
	 dvG7Ig2hj2GpEWU/bvtOnhK8AofJj/g5ciMlZKg0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A4A7F8019B;
	Wed,  5 Feb 2020 10:38:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A1A8AF80233; Wed,  5 Feb 2020 10:38:12 +0100 (CET)
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com
 [IPv6:2607:f8b0:4864:20::f4a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 375B5F80150
 for <alsa-devel@alsa-project.org>; Wed,  5 Feb 2020 10:38:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 375B5F80150
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="CoDv4bmu"
Received: by mail-qv1-xf4a.google.com with SMTP id d7so1112254qvq.12
 for <alsa-devel@alsa-project.org>; Wed, 05 Feb 2020 01:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=KEIH1qwXja/ZmU3/27elfahliyGtpPNLFM8jJAbIPe0=;
 b=CoDv4bmuhxUgR9bmsyfNwNeOGpipEjZz8WHI+CF859hIUpkYWhXlhZwzAGsS+bPxJw
 Ni25hCPqGGwCReROxGvBFe85BqQlIdFwrDE8Aowsf/8AHVm8sqc7vLbbhkP17oOX64eb
 V9eMMRvIDW6H7Pz8nTq7LCrhZOZuL2C3HVODNKe2b6HpegWPXfbX1PzxIsimi9NcM4Xu
 CGVHfTG2rPKgIC8f/fJqIRs0ZAsBZr18+eBxoedw8zjw9rdjBhGLKhyTIMnZ1jiCjUib
 qHWvt/JaBhiM4wikSZFQXK0Qu3yEzmFTBljvuMJBn2OfWVYp40mGXjDSVIAJLqBKIP/K
 Jezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=KEIH1qwXja/ZmU3/27elfahliyGtpPNLFM8jJAbIPe0=;
 b=YGBn52V+tfgLoVwrc/xgYjttUtbWVh3QKOnyBj62Ya8sZOZHx2v6CtuvJIXe6zeU2R
 kU4jBwgYu+yGpr0j8dulPD0tmnhxLpWctHi6H/yXvMPSIonZkm4GWjmxg9MSDWjJWiIy
 r2SXLaldATrI5TdALa+Dhb0UC60M85Rc8ihgYrcycUKtMp3IxUhAe7LNi0GW3qFKcdzI
 rcxL8wEMRtuKQG1+Ad4gVq2y5I1G2TbTi7O5YyLyG1P46X7E9dHKJowrhW+Io1CzChWz
 2Zfg+ROKnpwV9OxDYz99yXjdAKR3OnbhF3CON5dGOeGEDPGVOiycTpYJEJZdkqlOF+Ag
 ahUw==
X-Gm-Message-State: APjAAAWJ/JDksb1QAO0cHep6iKTnkY8BiwJvnNKGX8PqVaZrmaW3yyp6
 /s9dBO/Tw37jLUEWWQokLp/XN9rq8aX8
X-Google-Smtp-Source: APXvYqxBmBAsv6b6o4/hWnX6IZaGVfp7aEruPTeKewWwwid+Xv/sFuCAvNLDBkRklTQQiyRmKKgqtlZR4Yp3
X-Received: by 2002:ac8:769a:: with SMTP id g26mr32402406qtr.259.1580895486103; 
 Wed, 05 Feb 2020 01:38:06 -0800 (PST)
Date: Wed,  5 Feb 2020 17:37:43 +0800
In-Reply-To: <20200205093745.79298-1-tzungbi@google.com>
Message-Id: <20200205170416.1.Ieba8d422486264eb7aaa3aa257620a1b0c74c6db@changeid>
Mime-Version: 1.0
References: <20200205093745.79298-1-tzungbi@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org, airlied@linux.ie, daniel@ffwll.ch
Cc: alsa-devel@alsa-project.org, cychiang@google.com, tzungbi@google.com,
 dri-devel@lists.freedesktop.org, ck.hu@mediatek.com,
 linux-mediatek@lists.infradead.org, p.zabel@pengutronix.de,
 matthias.bgg@gmail.com, dgreid@google.com,
 linux-arm-kernel@lists.infradead.org
Subject: [alsa-devel] [PATCH 1/3] drm/mediatek: exit earlier if failed to
	register audio driver
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Exits earlier if register_audio_driver() returns errors.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index c79b1f855d89..23c2b0e8693d 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1656,7 +1656,7 @@ static const struct hdmi_codec_ops mtk_hdmi_audio_codec_ops = {
 	.get_eld = mtk_hdmi_audio_get_eld,
 };
 
-static void mtk_hdmi_register_audio_driver(struct device *dev)
+static int mtk_hdmi_register_audio_driver(struct device *dev)
 {
 	struct hdmi_codec_pdata codec_data = {
 		.ops = &mtk_hdmi_audio_codec_ops,
@@ -1669,9 +1669,10 @@ static void mtk_hdmi_register_audio_driver(struct device *dev)
 					     PLATFORM_DEVID_AUTO, &codec_data,
 					     sizeof(codec_data));
 	if (IS_ERR(pdev))
-		return;
+		return PTR_ERR(pdev);
 
 	DRM_INFO("%s driver bound to HDMI\n", HDMI_CODEC_DRV_NAME);
+	return 0;
 }
 
 static int mtk_drm_hdmi_probe(struct platform_device *pdev)
@@ -1705,7 +1706,11 @@ static int mtk_drm_hdmi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	mtk_hdmi_register_audio_driver(dev);
+	ret = mtk_hdmi_register_audio_driver(dev);
+	if (ret) {
+		dev_err(dev, "Failed to register audio driver: %d\n", ret);
+		return ret;
+	}
 
 	hdmi->bridge.funcs = &mtk_hdmi_bridge_funcs;
 	hdmi->bridge.of_node = pdev->dev.of_node;
-- 
2.25.0.341.g760bfbb309-goog

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
