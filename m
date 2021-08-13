Return-Path: <SRS0=Pedv=NE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73654C4320A
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Aug 2021 14:44:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DAD760F36
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Aug 2021 14:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0DAD760F36
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 66ADD186B;
	Fri, 13 Aug 2021 16:43:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 66ADD186B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628865837;
	bh=2ELQLvMtCrecNZ/ldrQSej35xw8fxLgLoprN+DnGGVM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KV25WdOoh2iJti+T5G9m6nIquPBvd0WF852GEzeqUtzK76vCzDK0o+G57rSWmOua6
	 QUfhP6E26jUro8BjbjA+MxGriBPcXvm2sv0zpZKVNglY5NpMIiIc47koK8NG+o3IUV
	 itV4TOwpA5TKFw3H1IfBsDZoxR3T8XMvSrILVeFs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CB6E5F8020D;
	Fri, 13 Aug 2021 16:34:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0F589F802D2; Fri, 13 Aug 2021 16:34:41 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BD975F80129
 for <alsa-devel@alsa-project.org>; Fri, 13 Aug 2021 16:34:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BD975F80129
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="JGIFBLhz"
Received: by mail-pl1-x62d.google.com with SMTP id n12so11560874plf.4
 for <alsa-devel@alsa-project.org>; Fri, 13 Aug 2021 07:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wFkAP9X+bq/zMMDamtqclNUNcl2vhKVeQXYPNowjSN4=;
 b=JGIFBLhz4diYF+b2lpf1akN6Tbbks53mHqUfLDE6f6U2x5rqflQ60OGajgeg4z1c1t
 7C/6/z/gN/Aqf5ZpbghpbvifQcJzdJzuxAwWuSZ7XTiWhoWTzyawiiuzGx5zVVP7FwiZ
 TGjT7dT+zUqt06ttpRsDczXkjrD6srypuZfDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wFkAP9X+bq/zMMDamtqclNUNcl2vhKVeQXYPNowjSN4=;
 b=GOcfj0tJj4QumZN2C0yuZv+x+t+c8thHpmnWilK/DgBtQFgVwT03nwh/loyWXvldLt
 mBn8bMjrTuSbBXlHYtHgLMjY19NSH9WtOaTdiX34K7B3axe5l/TvwrnzLHoI9dlyJ4V8
 lSLevessYIatBDm85mrSLAuY3y9VNqn6dxTPsdEt4yQe6p1Foh3kXlqJ3y1mfWGcjTx3
 SAS0A+e/VDp3l6e6zOtHOFu8vRhx4fwHp4e8lhAr2afU9eF+fc0pGQWSTrpg4tRFHFy2
 rYVqETzEqOAoxdbbOGAz0akYKJ4wjCOjq509AMym5txwatNnhOBsH5CcBPat2USWL+7G
 1bHA==
X-Gm-Message-State: AOAM530MmmQYW/Xuezv5KTZAQJX0MclUNApRde4eFmOKYZPR3dVpAmcm
 DtL3t+Eix5qmb3FJMBVYLu9MPg==
X-Google-Smtp-Source: ABdhPJxhLQKy3pT6OP/4d7pO0DABK6nLFB13CK6zL1eahKK/CiKS5doSOkWJeDGTy8+0GBP7EoXy1A==
X-Received: by 2002:a05:6a00:15cf:b029:3c2:7a3c:1758 with SMTP id
 o15-20020a056a0015cfb02903c27a3c1758mr2756140pfu.41.1628865266591; 
 Fri, 13 Aug 2021 07:34:26 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com
 ([2620:15c:202:201:12ec:9590:9106:e9bf])
 by smtp.gmail.com with ESMTPSA id z16sm2817001pgu.21.2021.08.13.07.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Aug 2021 07:34:26 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: rt5682: Remove unused variable in rt5682_i2c_remove()
Date: Fri, 13 Aug 2021 07:34:05 -0700
Message-Id: <20210813073402.1.Iaa9425cfab80f5233afa78b32d02b6dc23256eb3@changeid>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Oder Chiou <oder_chiou@realtek.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org,
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Stephen Boyd <swboyd@chromium.org>
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

In commit 772d44526e20 ("ASoC: rt5682: Properly turn off regulators if
wrong device ID") I deleted code but forgot to delete a variable
that's now unused. Delete it.

Fixes: 772d44526e20 ("ASoC: rt5682: Properly turn off regulators if wrong device ID")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 sound/soc/codecs/rt5682-i2c.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/rt5682-i2c.c b/sound/soc/codecs/rt5682-i2c.c
index e559b965a0a6..b9d5d7a0975b 100644
--- a/sound/soc/codecs/rt5682-i2c.c
+++ b/sound/soc/codecs/rt5682-i2c.c
@@ -294,8 +294,6 @@ static void rt5682_i2c_shutdown(struct i2c_client *client)
 
 static int rt5682_i2c_remove(struct i2c_client *client)
 {
-	struct rt5682_priv *rt5682 = i2c_get_clientdata(client);
-
 	rt5682_i2c_shutdown(client);
 
 	return 0;
-- 
2.33.0.rc1.237.g0d66db33f3-goog

