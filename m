Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9253EB64D7
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Jun 2023 12:17:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CA28B209;
	Wed, 21 Jun 2023 14:16:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CA28B209
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687349818;
	bh=c2i2qLSb/btiB88FeFuuokbr7WugXKaYVB6uBKKHUFo=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=MgzfiyDcTO1XKOc8ghs7DeZL4blAVSr1yp0mnfzu1VLNr42EJfjwj53s0eCPGnuVc
	 OvLfMzXbuot0GDOezOrsNSWuDlrHP+bBFGb+cXK1nAVl9xmRgV3QAcnGpkjHnldPYe
	 KUo3acMKSndon3hG+OFhULC0B6kThVPtrZRUdT1E=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DF32AF8057A; Wed, 21 Jun 2023 14:15:17 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 681F3F8055C;
	Wed, 21 Jun 2023 14:15:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 794DDF80217; Mon, 19 Jun 2023 11:47:01 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 66104F80132
	for <alsa-devel@alsa-project.org>; Mon, 19 Jun 2023 11:46:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 66104F80132
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=FVSBtbAn
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-4f8735ac3e3so713832e87.2
        for <alsa-devel@alsa-project.org>;
 Mon, 19 Jun 2023 02:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687168013; x=1689760013;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mgTyLdDdb0JKbsxmvr5ig7MQKF/koVbYtzKG0qR1FQE=;
        b=FVSBtbAnIdD2JGB4L/8m+3kxtOJ+IVlztZLyrAd45QBrUrMok51/Yf8vs+cbfu0eSq
         QzhNIPfEx2XC+0HQ88oo9L6zaw7P+nRl5e6QxtBBN6H7Uil0TlLu0V3Hm+tL/SUVYHgl
         mbkRNHJV98U0GL/ApfmGaTflPTKQelNz8g/vWtUEJKcN10Y6r743it0OxOw5OmQXcZY0
         fZS9ugYrYrnlwWhIHAwdWcIqvM6Z6EIuHR+6Nj5+eVbcxQ891A32fNPOWD4gectUmAHQ
         k/2uapwbSfrNtu4VjdlSXH8kibjlxJdd7YI966e3h7m2OOv3IZAEgyfw19G62pvA778s
         jcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687168013; x=1689760013;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mgTyLdDdb0JKbsxmvr5ig7MQKF/koVbYtzKG0qR1FQE=;
        b=I44QLCJ2469kiC6oPBwvjpSF14ZZ3DF8QDbvLl7uqQYBpF7a/QnSkIn4zZJViDNw9j
         frllxT/5/GrUQchrm/f9DlMgBf9gmIsirjiyWf8NngvDMKTZWcndFu0W3nGTSUpnBlgw
         V9FGBQPx693QfNrMg9jgWDpBLVK6IUcLT1DGUctzH90MgEQbW4Lnejo9VEqDM5kP+qS5
         JP/kxMH3/62Yook1sT60wVvm4SLCSnsAsuWNAPvo43fMKC4O2dzYwH6u4TKTugkY1PnK
         6tE3Np2Y1VLZRPdRgJ3vAWr+BkQ/YytQ3GSHIMjR4LrVH6s3Ocm/ZJYpx+3n9dpwISHr
         vAPA==
X-Gm-Message-State: AC+VfDxOCR/kvZf0V3nUP55i4BiPy36+brn6KSXEix6W1gHSQ2tcqWHY
	R1M3lNFS9bd2sTZukdSetRw02Q==
X-Google-Smtp-Source: 
 ACHHUZ40EMBWSgG/syJoSDMA4KN+4am/NO7LwY/DaZosq1p3vH68GpBXmJJFgzekNgpty8d1Whc2ZA==
X-Received: by 2002:a19:431e:0:b0:4f8:6dfd:faa0 with SMTP id
 q30-20020a19431e000000b004f86dfdfaa0mr1329253lfa.2.1687168013203;
        Mon, 19 Jun 2023 02:46:53 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id
 u16-20020a7bc050000000b003f080b2f9f4sm10197630wmc.27.2023.06.19.02.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 02:46:51 -0700 (PDT)
Date: Mon, 19 Jun 2023 12:46:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ryan Lee <ryans.lee@analog.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] ASoC: max98388: fix error code in probe()
Message-ID: <d44c8388-b12b-4045-95de-0d4bc7b428ac@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-MailFrom: dan.carpenter@linaro.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 6K6IIDHBF5ZXKXG2HD6EI6EM5YUEQP6O
X-Message-ID-Hash: 6K6IIDHBF5ZXKXG2HD6EI6EM5YUEQP6O
X-Mailman-Approved-At: Wed, 21 Jun 2023 12:15:08 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6K6IIDHBF5ZXKXG2HD6EI6EM5YUEQP6O/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This seems like a copy and paste bug.  Return the correct variable.
It should be "ret" instead of PTR_ERR(max98388->regmap).

Fixes: 6a8e1d46f062 ("ASoC: max98388: add amplifier driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 sound/soc/codecs/max98388.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98388.c b/sound/soc/codecs/max98388.c
index 8062a7115007..74fbaf7d7c39 100644
--- a/sound/soc/codecs/max98388.c
+++ b/sound/soc/codecs/max98388.c
@@ -960,7 +960,7 @@ static int max98388_i2c_probe(struct i2c_client *i2c)
 	ret = regmap_read(max98388->regmap,
 			  MAX98388_R22FF_REV_ID, &reg);
 	if (ret < 0)
-		return dev_err_probe(&i2c->dev, PTR_ERR(max98388->regmap),
+		return dev_err_probe(&i2c->dev, ret,
 				     "Failed to read the revision ID\n");
 
 	dev_info(&i2c->dev, "MAX98388 revisionID: 0x%02X\n", reg);
-- 
2.39.2

