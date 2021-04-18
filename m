Return-Path: <SRS0=kjsd=JP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0877C433ED
	for <alsa-devel@archiver.kernel.org>; Sun, 18 Apr 2021 13:48:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E8336052B
	for <alsa-devel@archiver.kernel.org>; Sun, 18 Apr 2021 13:48:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8336052B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gatech.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E8D971690;
	Sun, 18 Apr 2021 15:48:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E8D971690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618753736;
	bh=q5pJd3JPFwdmH553Dec37mXQvkfxapANhnLW5nnoVsA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oMnSyokIOztWb5VD3JuKFj/lfSOGg51klUw+a4TM/Q1vTGD4DAIOy7s7elX2Eo4qf
	 p+y0XCJ7wu/FhYX1qQt8jM1lUQ7MnaP1T4cWhfgFD2HOKxFK9LNoAjKO6fvtMoiBFh
	 gc1XQ4+eVEqFJWvJWlTlv8zP+IzjkU4plO9yATa0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D1BBF80423;
	Sun, 18 Apr 2021 15:47:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AF163F800F2; Sun, 18 Apr 2021 15:47:13 +0200 (CEST)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BBC52F800F2
 for <alsa-devel@alsa-project.org>; Sun, 18 Apr 2021 15:47:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BBC52F800F2
Received: by mail-qv1-f45.google.com with SMTP id x27so15703501qvd.2
 for <alsa-devel@alsa-project.org>; Sun, 18 Apr 2021 06:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dVe072jpHpPfiRxFA7g63W4XJ76XNpC7vmJrY1ltClg=;
 b=PbFj1Bua9Hnd0WYgzxcuZGXxw2Pw0oeFOEShaa6lXzzqH9Yta+jCIH+2I5QE6TSKpe
 me1SJHFaA2kSKLN7CcSBNG0qr2X0cDdAYcDAMSMWOHnAC7r+CDgN1wX0rP+pnhWBkbQ+
 f8blm4MP6WN6Eoe3J73OEs9P/xcbut9BGjx7R+Bel6/xZZZBSeLZTp1ELbGqD7zzmwUC
 M0S3jKhdD/z3+7oInM8X3VQQuH6UASagEjNMVuu8GKbEGP3sT2On/kNkdmIoEhdBLvd2
 XTf73BbYhkOcWKriWi6VP1DiT106OJW5laAjN17PFkgpZ8fY79lOosFm9gfxVcB2zSmh
 1cFw==
X-Gm-Message-State: AOAM533dFd+FyZt3oV+SZCdyLbn83jnfJCI5reRZFi2K7Z7GB7gEQanr
 u5IucvyeVFG5p+RtezIsLCo=
X-Google-Smtp-Source: ABdhPJznK9YdOfSBWjTcTjk95iNMzpC5QgKF/1HUfZj4hsarc5KMUhSdxxgwlHltEOH4AYRnhL4CxA==
X-Received: by 2002:a0c:ea48:: with SMTP id u8mr17087759qvp.15.1618753620959; 
 Sun, 18 Apr 2021 06:47:00 -0700 (PDT)
Received: from localhost.localdomain ([2601:184:417f:5b5f::f3be:e978])
 by smtp.gmail.com with ESMTPSA id p23sm3927937qtl.8.2021.04.18.06.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Apr 2021 06:47:00 -0700 (PDT)
From: David Ward <david.ward@gatech.edu>
To: Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/5] ASoC: rt286: Fix upper byte in DMIC2 configuration
Date: Sun, 18 Apr 2021 09:46:54 -0400
Message-Id: <20210418134658.4333-2-david.ward@gatech.edu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210418134658.4333-1-david.ward@gatech.edu>
References: <20210418134658.4333-1-david.ward@gatech.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Shuming Fan <shumingf@realtek.com>, alsa-devel@alsa-project.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mario Limonciello <mario_limonciello@dell.com>
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

This HDA verb sets the upper byte of the Configuration Default register, so
only an 8-bit value should be used. For the rt298, the same fix was applied
in commit f8f2dc4a7127 ("ASoC: rt298: fix wrong setting of gpio2_en").

Signed-off-by: David Ward <david.ward@gatech.edu>
---
 sound/soc/codecs/rt286.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 8abe232ca4a4..f9b29782b62a 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -1204,7 +1204,7 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
 	mdelay(10);
 
 	if (!rt286->pdata.gpio2_en)
-		regmap_write(rt286->regmap, RT286_SET_DMIC2_DEFAULT, 0x4000);
+		regmap_write(rt286->regmap, RT286_SET_DMIC2_DEFAULT, 0x40);
 	else
 		regmap_write(rt286->regmap, RT286_SET_DMIC2_DEFAULT, 0);
 
-- 
2.31.1

