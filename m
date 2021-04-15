Return-Path: <SRS0=rm39=JM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A4BC43460
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Apr 2021 07:58:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7DDF611F1
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Apr 2021 07:58:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7DDF611F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 52D281678;
	Thu, 15 Apr 2021 09:57:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 52D281678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618473483;
	bh=LtuwDyLikjzAN4MFrkjRD6Xt5FNPsX0iVIWLUI0Zzhk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QOh6revgK4zMmzxDysEM2cPUVGukZYsuySkmwp4Yl/tfM3xT050RzUU6BeTl8PHkh
	 eYTntYk9MVosUw8hHLvibgJlsExaSOpvWeLGZA2GkX3x131knE+ASABqBCDJnWIv6e
	 nxFPnZbilsTUXr8IaCwg4JYnJ2Mj2euuSBB91eD0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E7525F80260;
	Thu, 15 Apr 2021 09:56:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A763EF80128; Thu, 15 Apr 2021 09:38:51 +0200 (CEST)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E9AD6F80128
 for <alsa-devel@alsa-project.org>; Thu, 15 Apr 2021 09:38:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E9AD6F80128
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="LeHh8dIP"
Received: by mail-pf1-x442.google.com with SMTP id i190so15485203pfc.12
 for <alsa-devel@alsa-project.org>; Thu, 15 Apr 2021 00:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=6GHNy9nmTbGMe04/93664ci3I2+TW59tCe+/W5uRP0o=;
 b=LeHh8dIPPEH1uxk+ZfQX0XVqvC0FADJVR3NSCFf6Ay5cTWymnllDYhWv15xkha3PJr
 9Q2FiQcc2p2FkIFj7gn6vrtAVVCa7oXlwl2aNNGf6QHOxLM0xvn5D6QHsGeUvWZ1lU9E
 Xesan0sauohfnex+AZ3SXFcCfUK/PJwCZHD8Wc/AeyiK/VtSALILF2pay1x1hTXZRVjc
 sohVqKEhmw9KVb0kLcH+umLNZMNbAyYDTrUhLllTGm000/r/TPenLcyeXFxmG1o2nbFE
 vY6i4D2dzqIKi2TDu+G3cpl/IIXC2v8/GZMPmTs7YFjqcdV1tqk1+vwuurfudJ4gi+kZ
 4szA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=6GHNy9nmTbGMe04/93664ci3I2+TW59tCe+/W5uRP0o=;
 b=IkPooh7DYGxNylGY+g0yoGi+IFThcUY62eoc1nw8hKM4A2VfP27LZLnUFoU+9qctxW
 EOU87Gn2yFXPcR42WppQvPFBbXJOuahbVt92CqlsU+ZzpLOcITQxs68xCurVQqaI/uz0
 h74HsIQKEWMP6NLfQZSI82QMcKr+LZx1gTmF/x+OqJuuEVI/bKqEriJ6/yOPkvI/RRMF
 ersfrxUa7Uj0Ot8BCtSi3yoHP82LnZeAB3lJrs8B3LcHg8ZD1UJALQ5YTuw0zXeqp8/Z
 CC3V174Z/Z6N64SC0/dflIsSS370O3XromCY0/Ugb74Gykr+pO7Jdl4SjUqj2ZIVauH/
 u4BQ==
X-Gm-Message-State: AOAM531L7fqugCBnAMbB3Jv9JUQOfaO64AG471olIRu904LitIq4S9yB
 Mir4p+Mv6Q2h5yK7v2XnaiE=
X-Google-Smtp-Source: ABdhPJyPyD+7YswXHYLAmeDKVHdJIuPH5kWEybfUXLVFNMKTQQqXG50b3/COIkx2AjOz5gH4WF34Vg==
X-Received: by 2002:a63:5508:: with SMTP id j8mr2334912pgb.36.1618472316398;
 Thu, 15 Apr 2021 00:38:36 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.180])
 by smtp.gmail.com with ESMTPSA id 23sm1508138pgo.53.2021.04.15.00.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Apr 2021 00:38:36 -0700 (PDT)
From: zhuguangqing83@gmail.com
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@codeaurora.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: codecs: wcd934x: Fix missing IRQF_ONESHOT as only
 threaded handler
Date: Thu, 15 Apr 2021 15:38:29 +0800
Message-Id: <20210415073829.22750-1-zhuguangqing83@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Thu, 15 Apr 2021 09:56:15 +0200
Cc: Guangqing Zhu <zhuguangqing83@gmail.com>, linux-kernel@vger.kernel.org
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

From: Guangqing Zhu <zhuguangqing83@gmail.com>

Coccinelle noticed:
  sound/soc/codecs/wcd934x.c:5041:7-32: ERROR: Threaded IRQ with no primary
handler requested without IRQF_ONESHOT

Signed-off-by: Guangqing Zhu <zhuguangqing83@gmail.com>
---
 sound/soc/codecs/wcd934x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 5fe403307b72..cddc49bbb7f6 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -5040,7 +5040,7 @@ static int wcd934x_codec_probe(struct platform_device *pdev)
 
 	ret = devm_request_threaded_irq(dev, irq, NULL,
 					wcd934x_slim_irq_handler,
-					IRQF_TRIGGER_RISING,
+					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 					"slim", wcd);
 	if (ret) {
 		dev_err(dev, "Failed to request slimbus irq\n");
-- 
2.17.1

