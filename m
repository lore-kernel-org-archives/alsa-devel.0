Return-Path: <SRS0=WtzT=H7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15EEC433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 19:35:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88A6260241
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 19:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A6260241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8C5AB1668;
	Mon,  1 Mar 2021 20:34:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8C5AB1668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614627303;
	bh=8zkdJs6qGxXEaf4TVsrvtbXB+XOSv6xsiBpPAuWJ4Ug=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YydFawwdv2J+fOjabThkZhJ+ANIrDryvvkIK6qhcGI1UkMJiJCCkMi7Hs4asVZ9+L
	 aY4lLTOWJ7BxkatbEeoM0RRf/buUHVOiymTXBAcjQ7I21SCicJ3gAdoNdH2yVbWOAZ
	 +8kX/WY3q24OPWetYYndv2lwYR7PfZDpnU6tkHYs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0FE7FF80257;
	Mon,  1 Mar 2021 20:34:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 89142F8025E; Mon,  1 Mar 2021 20:34:11 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B75B3F80150
 for <alsa-devel@alsa-project.org>; Mon,  1 Mar 2021 20:34:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B75B3F80150
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="SE/Ad4Ks"
Received: by mail-qk1-x735.google.com with SMTP id q85so17794082qke.8
 for <alsa-devel@alsa-project.org>; Mon, 01 Mar 2021 11:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pumBrlPvSRQ35NQ2oUABR8NJww1593QYGAQuqnujt4U=;
 b=SE/Ad4KsrH7rRD/eugjUtzUW3Xkco0kZlpRcQ3mZ+yAP5d8IspEPZpUaNJESM5XHdV
 xZGor72Qg0WrMAFvD62A7Z0LMEfKm5oWvLAlhXM2nYZUGAgqFg0RcgFoBTIdUkc0aS9W
 qL2aaIy86agj9hayoG6jMVwAYgTG1hXdrgEs3F7FkCK+6ozvExmGkANIgPYuXIUf37s3
 HfGkudbd1atuVyedtnGVoFxRd9uI/2C5WuIK6uQ6tDxCetNwbL1teYPWpYL8IbIdxzr/
 TjO28vLxJL5PT1ldG6knHoxw6E47g5YclVB9H9E4JIv1wSWDrRFO7STa/trFcDY36u3w
 IFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pumBrlPvSRQ35NQ2oUABR8NJww1593QYGAQuqnujt4U=;
 b=FDatuM1C5tt3g4DK5pLqSfImq2vcY3Fp04UoYQXTMIxymCk26TVKY/kZqY83lpUlSZ
 H6QEktd65mVBjYxrnlU0UhoKxnFqWXz1tl7NIZ1OY9GY1wfhR3r2JcG0wP95pT/BHIR0
 mSdVzrJYhMtGKrfRhctWPonWGr/+62o08a9JNdhfdAWj1TAZa+0HvobO6m8aZIxCF5w/
 B6kesKuZX9xZWufzbPsHEyFJE7uAkmSA4FRMi5xnf98qO/AJw29pPwbHzT/49EkDYD8T
 bkAxArwFcKhAQ1Ub3PZJb6aRMbFs1LMAP/mS17/dONTXFVs0s3IM5rd/xjoyY4gjKLTb
 ag+A==
X-Gm-Message-State: AOAM530hkZddvVPCiYIbjpCR7e5flHeST5IPPumC333eTpcnxpUaS5uu
 Z3pJtRKRNCQjnpRXj3G+Q0w=
X-Google-Smtp-Source: ABdhPJz2qXPHyuah5NVNZ5GwAbOErUP/sWPG4hz/SJd0WBCPurA4q4pPe6AO0allwbENsLGTUSUSRg==
X-Received: by 2002:a05:620a:16b6:: with SMTP id
 s22mr15117496qkj.240.1614627245579; 
 Mon, 01 Mar 2021 11:34:05 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:482:919::1000])
 by smtp.gmail.com with ESMTPSA id a9sm11747737qtx.96.2021.03.01.11.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Mar 2021 11:34:05 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: broonie@kernel.org
Subject: [PATCH] ASoC: wm8524: Do not print probe defer error
Date: Mon,  1 Mar 2021 16:33:28 -0300
Message-Id: <20210301193328.2123511-1-festevam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: patches@opensource.cirrus.com, shengjiu.wang@nxp.com,
 Fabio Estevam <festevam@gmail.com>, alsa-devel@alsa-project.org,
 cphealy@gmail.com
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

On an imx8mq-evk the following error is seen:

[    1.375809] wm8524-codec audio-codec: Failed to get mute line: -517

It happens because the codec driver may probe prior to the imx gpio
driver, which causes a probe defer.

Change to dev_err_probe() to avoid printing this error.

Reported-by: Chris Healy <cphealy@gmail.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 sound/soc/codecs/wm8524.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8524.c b/sound/soc/codecs/wm8524.c
index 4e9ab542f648..81f858f6bd67 100644
--- a/sound/soc/codecs/wm8524.c
+++ b/sound/soc/codecs/wm8524.c
@@ -227,7 +227,7 @@ static int wm8524_codec_probe(struct platform_device *pdev)
 	wm8524->mute = devm_gpiod_get(&pdev->dev, "wlf,mute", GPIOD_OUT_LOW);
 	if (IS_ERR(wm8524->mute)) {
 		ret = PTR_ERR(wm8524->mute);
-		dev_err(&pdev->dev, "Failed to get mute line: %d\n", ret);
+		dev_err_probe(&pdev->dev, ret, "Failed to get mute line\n");
 		return ret;
 	}
 
-- 
2.25.1

