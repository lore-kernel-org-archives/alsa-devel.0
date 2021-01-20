Return-Path: <SRS0=/R4B=GX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0E9C433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 08:11:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55C172313A
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 08:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C172313A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5E72F17E3;
	Wed, 20 Jan 2021 09:10:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5E72F17E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611130265;
	bh=RhOQ+uGUEhLb0eifc/brM02LnRG/GSHM+uQsiNxD2OE=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vsbH16/Ptgw8CC9aUwhTU4bOf/Q3/sMlTZF0SZ+cOqnIlNcOqeBMRt8ftQtnVIpbw
	 s3+acSd8H8feLN17nSkyfwXLyjl32BCSyFihz+ii7Y1UcvO0S/9r+b/ra4GUi1P2hH
	 JB9eqW5L9o7i0KflPdo/2bkqYn0vyXn3SLydGQ2o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9B0A9F804BD;
	Wed, 20 Jan 2021 09:09:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4ECA0F802BE; Wed, 20 Jan 2021 09:09:21 +0100 (CET)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com
 [IPv6:2607:f8b0:4864:20::64a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C3D53F80164
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2021 09:09:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C3D53F80164
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="l0gmTUjJ"
Received: by mail-pl1-x64a.google.com with SMTP id d1so15997604plh.13
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2021 00:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=BhiRI9BtJk/FQ656s3vJH/ppgffKgcRGDy0obhFDdNo=;
 b=l0gmTUjJG0/1eeSZ2hYlKBdOm49eF6glOT1dYrlAKtXy2Ztbah28WKnB0nZOl/lrC9
 qd2BoGDcx4VzWJBPgFF1ieIqU8Epmt5faO3C3VKvE7pLpjZnyafAcPB9TJ1IUgx3TRGe
 4F2+FMPRG8RHQCEOJfEMWqrP5sedjtWvS7m44fMpivSDgsUWseZFsz48w2mda2iuMvSy
 WW7747r2l6Siy45+uRn6x+tqvgGSRLERDrjistJqMCQ+cVWPBzKkrXiCC5ch+4AsIZaE
 Cp8fXxugUCSnw2DiTLTBzyc1fAspKqh8bU0qOMs7jHf1GmsW+p2S/ABeslRiwEe4UZMq
 dMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=BhiRI9BtJk/FQ656s3vJH/ppgffKgcRGDy0obhFDdNo=;
 b=N6OKc7Uq1Bdyn9/7W6bxu2X1EvErwMwV5rfn0SSR+fBpcOS4+xst6mkQ+UEAmUntUX
 D2MwybetrWE0ERFBLdQ+I6Qd3UrYZPwSPuUuzHRmCJiOefX4ttvLFS1l83JbfkxjWJ8y
 Pp5wPjJ0Yb5lNNmS1bEaigM2qLKtItPaoYG9LeQvMi5o37FxoB0jk2pbCCb42BMPM9xA
 zkHownYgb7HuF7Upq64R5YczRMfGL8p7/knVj9tdpC2QhrcJFHxFKqmRKKnh8lO4+i4Y
 2BJX946pvS9u2XyLjN+UcJzPL6Hx2BarC80/ES9gqp47W0fxIR5cDYETQgcyfmHdsL5y
 YSOg==
X-Gm-Message-State: AOAM532lqj3fzYIM9skxD9/nDZ5XML34X34XQJVpr08mCJalFPAtAnuL
 KIFauKvAT1n5jbh+3x9ct/BROqagW2aW
X-Google-Smtp-Source: ABdhPJzM/v09y2w61XJdhUUXgy2b587avNFy+mm2IIXkVPOvDqVZECqnXYZ3McyNCmwltBZD7Kj/GA1yxcZ9
X-Received: from tzungbi-z840.tpe.corp.google.com
 ([2401:fa00:1:b:1164:8893:969a:b338])
 (user=tzungbi job=sendgmr) by 2002:a17:902:e887:b029:de:7863:19b0 with SMTP
 id w7-20020a170902e887b02900de786319b0mr8873005plg.42.1611130150733; Wed, 20
 Jan 2021 00:09:10 -0800 (PST)
Date: Wed, 20 Jan 2021 16:08:47 +0800
In-Reply-To: <20210120080850.699354-1-tzungbi@google.com>
Message-Id: <20210120080850.699354-3-tzungbi@google.com>
Mime-Version: 1.0
References: <20210120080850.699354-1-tzungbi@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 2/5] ASoC: mediatek: mt8192-mt6359: simplify mt8192_rt5682_init
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Cc: tzungbi@google.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
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

Returns snd_soc_component_set_jack() directly in mt8192_rt5682_init.
No need to have another block to check the return value.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
index 72d337fc8534..8ea24b32a535 100644
--- a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
+++ b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
@@ -326,13 +326,7 @@ static int mt8192_rt5682_init(struct snd_soc_pcm_runtime *rtd)
 	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
 	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
 
-	ret = snd_soc_component_set_jack(cmpnt_codec, jack, NULL);
-	if (ret) {
-		dev_err(rtd->dev, "Headset Jack set failed: %d\n", ret);
-		return ret;
-	}
-
-	return 0;
+	return snd_soc_component_set_jack(cmpnt_codec, jack, NULL);
 };
 
 static int mt8192_i2s_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
-- 
2.30.0.284.gd98b1dd5eaa7-goog

