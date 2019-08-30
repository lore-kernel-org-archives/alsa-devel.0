Return-Path: <SRS0=nNdU=W2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F38C3A5A3
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Aug 2019 07:45:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D5E6206BB
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Aug 2019 07:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iSMKCEnI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="T/dPKkb/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D5E6206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5BC83165F;
	Fri, 30 Aug 2019 09:44:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5BC83165F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567151149;
	bh=v9YQqnrJO2O0RJkr8dg9Qf8uQJb8SG1rJ9rVZg+Lxfo=;
	h=Date:In-Reply-To:References:From:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iSMKCEnIJYTcF7YJHz/oQ4ZEX22vQFKJ1aBKnRaJOMAYaczTzs06DKKOBe5V075wi
	 9FDIJyLe5UDUg+PqC6khj3y8jqyakKyFz6J5ubWJQp4F5ookdaMB6K1VbjQwH5BQIN
	 2oa0naDFeR5w4A5yHtXOaUJuOjtlr+2FkyewAGbw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 35C89F805F7;
	Fri, 30 Aug 2019 09:43:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C3C1DF805F9; Fri, 30 Aug 2019 09:43:05 +0200 (CEST)
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com
 [IPv6:2607:f8b0:4864:20::74a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 291ADF805F7
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2019 09:43:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 291ADF805F7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="T/dPKkb/"
Received: by mail-qk1-x74a.google.com with SMTP id y188so6327713qke.18
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2019 00:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=sQAvSFliNRzsihBO4D3II/hLNdzvUKs4D9QWENz0aT8=;
 b=T/dPKkb/qUAnqls4DkHU3SWROP0nWhRKfrPw40+ZwfOtNsaL09igGbf+CqYiCnn+PD
 h6Mk7hgleMJmhhAWQcIVeNvm9QYGmQ+RncavwmwOLS1U8oeR6x1GFm1+gItbASBy3O3T
 OnpyV26/WKvRzCcYhXPwGRPupV2Ve9Mp0r2rNcN0RKGU1pKLH0Dl0SiujFAEpFe9LxI4
 NOfIo/KwYy0SRnSzGUmcu8VNCSF3YeH2JsCTld/JFuSXZwkY5e1YEXgnRtk//B6FPcbo
 kKjTJNYOgYYq0l+2cG1tBx2VtrSB8OcPIN0FCLyuLDWBlUILgNPaV+7+n9PWwe9CYYyR
 zyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=sQAvSFliNRzsihBO4D3II/hLNdzvUKs4D9QWENz0aT8=;
 b=ez/WhsxlvN4hfKFLJJXIgn//1C/7yJXAUbX+5qEnSDW3wZOp0J9UA31ICz3ZYDYxIV
 NWmUNwu1Im/XrxWcYxXH7PmxJOagnbvmSZnRHgEG5u5XO0yx5sx4cbEzV+hJdqsYgo/f
 g8ENrs9DKQWCmxQ83H2eqnFlPMl/OsyTMXLI7L2Hc1j8aX1FoIE58+X1x+dwCYdeWi8A
 9TaW7cM5G62HwzFhu4Ukg6HZRnZgtPshR/vYlhtbn0MROfitN6LW7AXyS7zqHqazzv5N
 q5sJy0O9QxQ16JRbLvs4jQagpp+WVwhfipRLdiKOviDNZrTnLAEZ7EacZXlWOS8suXz7
 fNNQ==
X-Gm-Message-State: APjAAAWByUJUm7TU43ucpzeG4tNcflWlPAaWuMeSeeolVqkaj4+W+BRa
 Y68jpcKGFSnE+pEKZcsk3X4p3r5GQ+lV
X-Google-Smtp-Source: APXvYqxsgpQKxPDMv2XBA/AMCE1G5HEXvJ3UK59pPVMrTkwRVe2S9FWqVL86NbwiC7uiehRoW5MDJppi6dSd
X-Received: by 2002:a37:9b48:: with SMTP id d69mr14297756qke.449.1567150981129; 
 Fri, 30 Aug 2019 00:43:01 -0700 (PDT)
Date: Fri, 30 Aug 2019 15:42:39 +0800
In-Reply-To: <20190830074240.195166-1-tzungbi@google.com>
Message-Id: <20190830074240.195166-4-tzungbi@google.com>
Mime-Version: 1.0
References: <20190830074240.195166-1-tzungbi@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org
Cc: tzungbi@google.com, alsa-devel@alsa-project.org, dgreid@google.com,
 cychiang@google.com
Subject: [alsa-devel] [PATCH 3/4] ASoC: mediatek: mt8183: remove forward
	declaration of headset_init
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Message-ID: <20190830074239.9wuJOhWYRmfoCi0a8V8jVtD9TtKwuxXWYuk5LOooGzg@z>

The forward declaration of mt8183_mt6358_ts3a227_max98357_headset_init
is for cyclic dependency between card, headset_dev, and headset_init.

It used to be:
- card depends on headset_dev
- headset_dev depends on headset_init
- headset_init depends on card

Commit a962a809e5e4 ("ASoC: mediatek: mt8183: make headset codec
optional") removed the cyclic dependency.

Thus, it is safe to remove the forward declaration.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 .../mt8183/mt8183-mt6358-ts3a227-max98357.c         | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
index a7ad41b6e885..30a7735c4af3 100644
--- a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
@@ -390,14 +390,6 @@ mt8183_mt6358_ts3a227_max98357_dai_links[] = {
 	},
 };
 
-static int
-mt8183_mt6358_ts3a227_max98357_headset_init(struct snd_soc_component *cpnt);
-
-static struct snd_soc_aux_dev mt8183_mt6358_ts3a227_max98357_headset_dev = {
-	.dlc = COMP_EMPTY(),
-	.init = mt8183_mt6358_ts3a227_max98357_headset_init,
-};
-
 static struct snd_soc_card mt8183_mt6358_ts3a227_max98357_card = {
 	.name = "mt8183_mt6358_ts3a227_max98357",
 	.owner = THIS_MODULE,
@@ -428,6 +420,11 @@ mt8183_mt6358_ts3a227_max98357_headset_init(struct snd_soc_component *component)
 	return ret;
 }
 
+static struct snd_soc_aux_dev mt8183_mt6358_ts3a227_max98357_headset_dev = {
+	.dlc = COMP_EMPTY(),
+	.init = mt8183_mt6358_ts3a227_max98357_headset_init,
+};
+
 static int
 mt8183_mt6358_ts3a227_max98357_dev_probe(struct platform_device *pdev)
 {
-- 
2.23.0.187.g17f5b7556c-goog

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
