Return-Path: <SRS0=kZkJ=FP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCB5C4361B
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Dec 2020 05:14:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6609523EB3
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Dec 2020 05:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6609523EB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EE7FA1684;
	Fri, 11 Dec 2020 06:13:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EE7FA1684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607663677;
	bh=leCxgKCw/JyYIcVLSlV2Q681xda+q0YzEHZJfuIHZD8=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sfFd/FY1LWkOEvutVSsY2HROrlvsJv2i3N0MnT9X9SdIgaIjdb2vYIDVSJBBVS0yE
	 BonlMMlhN9AGokkBDIm74dxY5eocIWSoDdPfkVji+fhPQPIAbdE6q4VlW0BSGYn2Sy
	 dHDI6iLXEote0RmqsK26lVPC6lBQDse8qrbORDlc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E9F03F802BE;
	Fri, 11 Dec 2020 06:12:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5862FF804B0; Fri, 11 Dec 2020 06:12:55 +0100 (CET)
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com
 [IPv6:2607:f8b0:4864:20::1049])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8FECAF802BE
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2020 06:12:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8FECAF802BE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="emgnXj/Z"
Received: by mail-pj1-x1049.google.com with SMTP id kk4so1796083pjb.7
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2020 21:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=64rrKA1XAShTMqjY0LlZBcP7tQX0AmPAC+RLWQwGwlg=;
 b=emgnXj/ZxoHcJWybIZeB+XhBbjkoqa7TY1AdwZQW1M/MsSXnUbV0oqs+nJhCn2NxKV
 sFaIZR5JpZ88ASBNl0vA8cD+jkQcmT5BVI7oVkAEyDxVoV5nuZBPrSo4qMEn8e/pMqFs
 kKnXO9jqFPL8ygAukadVQc1dRPkAAyCFEzyWHHYflO9a2+lZyGm//t6vZWUKeH+l+y0k
 z6Ke426Ee5trio5S2I5J+E0gjoIHB+Tw8Ez3jHKyn4geb7aBdQSkUmNhOEzqhmUWE89J
 PD4qxpJktuTU8wnCEzk4ETYKmCFNYI4llfdOduO4cvtbiRQR7IjyfEob2D3zns1y6lhp
 znxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=64rrKA1XAShTMqjY0LlZBcP7tQX0AmPAC+RLWQwGwlg=;
 b=jDypNETzqHRbh4t/OXVAhZ6fvrGW1vqMNaq9rdTRljke3Nl8FtGo0bt5ux+NXq/08R
 eUvidsI2PTRm96LnvA0MUMv/1EreTGLa7ZRbtZEa5c+8ZQFXMHAE+it91VnqAQg8MM1R
 1/cUihqVCLyyVAkNQzAc6ySSdvnBKT5zY8bkUDoFxqWKgueYAhCiNVNCo28fzqrS4McV
 Qn5aM01BPs4j7S/XLeKkho0msBgTyuqtdusneAGQ6fRcw4k5YpKl3ysabH5sAZwRlC/s
 O530VoC2fgabk57uSf1HmajGbS80m+x5Zx79ePT8n59swXQN0m/O+t1STXJl8Ybn/DpK
 hdCA==
X-Gm-Message-State: AOAM532p/76hUq6GAiSTYvx4NDdVrKLm02jwpdrNUAHuGhGul6OzGDRl
 st+3zpZmA6OEW+l2uAbvUAOh3BlrpW9T
X-Google-Smtp-Source: ABdhPJxG1U3de5HsMyTLs/XJsogRutTIoHfBCfiIsxzXPD2U4buxJAY/4IAZHR8dJD1PvHBgo5DA5fe5iKdg
X-Received: from tzungbi-z840.tpe.corp.google.com
 ([2401:fa00:1:b:725a:fff:fe41:c6a5])
 (user=tzungbi job=sendgmr) by 2002:a17:902:854b:b029:db:c725:edcd with SMTP
 id d11-20020a170902854bb02900dbc725edcdmr1949201plo.64.1607663567905; Thu, 10
 Dec 2020 21:12:47 -0800 (PST)
Date: Fri, 11 Dec 2020 13:12:24 +0800
In-Reply-To: <20201211051224.2307349-1-tzungbi@google.com>
Message-Id: <20201211051224.2307349-3-tzungbi@google.com>
Mime-Version: 1.0
References: <20201211051224.2307349-1-tzungbi@google.com>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [PATCH v3 2/2] ASoC: rt1015p: delay 300ms after SDB pulling high for
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

Assuming the calibration state gets lost after system suspend.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 sound/soc/codecs/rt1015p.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/soc/codecs/rt1015p.c b/sound/soc/codecs/rt1015p.c
index ee9dfa2dbbf0..671f2a2130fe 100644
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
 		gpiod_set_value_cansleep(rt1015p->sdb, 1);
 		dev_dbg(component->dev, "set sdb to 1");
+
+		if (!rt1015p->calib_done) {
+			msleep(300);
+			rt1015p->calib_done = true;
+		}
 		break;
 	case SND_SOC_DAPM_POST_PMD:
 		gpiod_set_value_cansleep(rt1015p->sdb, 0);
@@ -60,7 +67,20 @@ static const struct snd_soc_dapm_route rt1015p_dapm_routes[] = {
 	{"Speaker", NULL, "SDB"},
 };
 
+#ifdef CONFIG_PM
+static int rt1015p_suspend(struct snd_soc_component *component)
+{
+	struct rt1015p_priv *rt1015p = snd_soc_component_get_drvdata(component);
+
+	rt1015p->calib_done = false;
+	return 0;
+}
+#else
+#define rt1015p_suspend NULL
+#endif
+
 static const struct snd_soc_component_driver rt1015p_component_driver = {
+	.suspend		= rt1015p_suspend,
 	.dapm_widgets		= rt1015p_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(rt1015p_dapm_widgets),
 	.dapm_routes		= rt1015p_dapm_routes,
-- 
2.29.2.684.gfbc64c5ab5-goog

