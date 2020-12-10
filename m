Return-Path: <SRS0=UiOR=FO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08959C4361B
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Dec 2020 03:38:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA7E2184D
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Dec 2020 03:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA7E2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4A12E16A4;
	Thu, 10 Dec 2020 04:37:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4A12E16A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607571518;
	bh=wh/bNvt4qdfp1lXSa5xi5VZsqSuRp11h+xF8brNNtdo=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PKeD93cRWCvuovLqRnI8MFR3J0tfrN4u92zTtkACmurBst2t9+ecU58+i0DK02Ok/
	 kxroLaDf/jt0LlVr9lqx9/PsLPsa/2wIatZA7gjZpROJegWW+/OxNkT9KV3AiwsTAw
	 UTlzA+yTw39mUHUiTcr5GBFRp+Hq8xSA88i57X7c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 21CF5F8019D;
	Thu, 10 Dec 2020 04:37:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CB95AF80253; Thu, 10 Dec 2020 04:36:59 +0100 (CET)
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com
 [IPv6:2607:f8b0:4864:20::849])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 343E7F80218
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2020 04:36:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 343E7F80218
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="EyMcipTw"
Received: by mail-qt1-x849.google.com with SMTP id f11so2910367qth.23
 for <alsa-devel@alsa-project.org>; Wed, 09 Dec 2020 19:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=SNKSc+GEn/EdH6/bPD9md/0+u0hqwDic45ePQqsW3+I=;
 b=EyMcipTwWzfrzPpgJDvUTvaWxb//8TtOJ9x19yindMFJHyqIWjlPitSTDzQDlMjUxJ
 M2gDsqFuyCpUS9Ti7ejEXjylvVgfgPLYB5/E7QgbdGXDoQKaMYFbV8rfsELKEmjO0RWi
 iiFgk/owqrKHVS5R07zYDVrouragIYgjDDeNbdE3NZurTWg5Id1fxNJibymBXovyYfmf
 9GvxZIiT6ugsLM1z3cuOqKMKPgcKg8dF3wk/GyI5kpcQ4zPquP5aqiue1NtzztNC+yaM
 oTy/ZYk2SgOPcqNn4JvMvu/dhmmuBCwGJeojybmIDkrO1wbJZCxI4/sUnUhIt9Mn4f9N
 6z5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=SNKSc+GEn/EdH6/bPD9md/0+u0hqwDic45ePQqsW3+I=;
 b=PUYO2gXET4wU9CmpVKRwQf6LgW3Id1bORKzhFQl+K3C76PbOF+JhC31uqGiqJbMLHw
 E+EHKZ6jIla5a03oNK7Khz4e3INWgzMj5rxEqjt7I+jpRmKvZ48Pp1yvD57deQMtMzwS
 C8FslMUYrH9a/6muFsGxcO/lbKpEfB6b03iTaRtnsJ/Jxmt+6furN1zwkQK/dKtZ1eod
 sSi/HvOBfDcOJZXYcso1KC0OUZP4saee6qkgwrqAIkJO6IzkbUCQsG1A+lZfg2xiUQr6
 EKO1vIzu3VRTzkp4gHYlaiYawa2S4AxcBcGUoql78IuUbd7sHNhTEBMpxjjOHtZtKz2n
 bTbg==
X-Gm-Message-State: AOAM5304KKxt9joog9fTeharHsbfWf7TaTmMnUXpI4RpXAMm4OUYXKlz
 WdU9xh0VzSgdr8ab9K2/iUH1vgovQJ+l
X-Google-Smtp-Source: ABdhPJxM6PEilULdGs6YxoZxfrFSXlS3hLcXz3JmOi+zrB/5iBjg96wVLCCTUPyf50gdBZNvKN0+NiK85Miw
X-Received: from tzungbi-z840.tpe.corp.google.com
 ([2401:fa00:1:b:725a:fff:fe41:c6a5])
 (user=tzungbi job=sendgmr) by 2002:a05:6214:1266:: with SMTP id
 r6mr6660450qvv.12.1607571414555; Wed, 09 Dec 2020 19:36:54 -0800 (PST)
Date: Thu, 10 Dec 2020 11:36:17 +0800
In-Reply-To: <20201210033617.79300-1-tzungbi@google.com>
Message-Id: <20201210033617.79300-3-tzungbi@google.com>
Mime-Version: 1.0
References: <20201210033617.79300-1-tzungbi@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v2 2/2] ASoC: rt1015p: delay 300ms after SDB pulling high for
 calibration
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Cc: tzungbi@google.com, alsa-devel@alsa-project.org
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

RT1015p needs 300ms delay after SDB pulling high for internal
calibration during the power on sequence.

Delays 300ms right before data sends out to avoid data truncated.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 sound/soc/codecs/rt1015p.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/rt1015p.c b/sound/soc/codecs/rt1015p.c
index 397083ee5b37..bba638e1eb6a 100644
--- a/sound/soc/codecs/rt1015p.c
+++ b/sound/soc/codecs/rt1015p.c
@@ -4,6 +4,7 @@
 //
 // Copyright 2020 The Linux Foundation. All rights reserved.
 
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
@@ -19,6 +20,7 @@
 
 struct rt1015p_priv {
 	struct gpio_desc *sdb;
+	bool calib_done;
 };
 
 static int rt1015p_sdb_event(struct snd_soc_dapm_widget *w,
@@ -36,6 +38,11 @@ static int rt1015p_sdb_event(struct snd_soc_dapm_widget *w,
 	case SND_SOC_DAPM_PRE_PMU:
 		gpiod_set_value(rt1015p->sdb, 1);
 		dev_dbg(component->dev, "set sdb to 1");
+
+		if (!rt1015p->calib_done) {
+			msleep(300);
+			rt1015p->calib_done = true;
+		}
 		break;
 	case SND_SOC_DAPM_POST_PMD:
 		gpiod_set_value(rt1015p->sdb, 0);
-- 
2.29.2.576.ga3fc446d84-goog

