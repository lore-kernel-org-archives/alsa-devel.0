Return-Path: <SRS0=HcWj=ED=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57616C55178
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:44:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29029247D2
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rQIPJZPl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gV58zQ7b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29029247D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 35ABA851;
	Wed, 28 Oct 2020 16:44:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 35ABA851
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603899890;
	bh=nwZZllA5AVjSzqJVYvyFUYoVdBrzZTDOvBh4UeOgEqw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rQIPJZPlsEDHVmZ0Y5c7F7uIXPyOrPwTnWxyJCcjLX3otNOGur4+Yucq9/fr0qXS6
	 lrfE5UnMmsy4ZNUKBXmBHivEFhRQJuwOGVGp4AAu7YS2uj6TaM9bK+2+MLJ7wdE+f8
	 +LK8eizbV6Gu0XUkLElRHQU6yNoQ1b9USzcIuL/8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AFDFAF80134;
	Wed, 28 Oct 2020 16:43:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BAB84F80249; Wed, 28 Oct 2020 16:43:57 +0100 (CET)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF904F80134
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2020 16:43:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF904F80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="gV58zQ7b"
Received: by mail-wm1-x343.google.com with SMTP id v5so22298wmh.1
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2020 08:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ctzgjv+NmABx1Kt3m2tDVwm2LGH0KuiBAUYDbPhDv1Q=;
 b=gV58zQ7bh4+ztDSwyh2p5Aqif/Pag750BWBT8Py2nSDCISM6Unz+z27j16xVcBQbNE
 hjvcViqHWR/L7BtIkZnthPnJ2CJ6z3qgAEMLUtU2lIElxal1mAqnniCxVHx3+ElDsMxO
 jANfc2MOEaSJ4xP5hR7BtOpiSyOoKBayf4UxlRj7G4gqApUM2g0jMOEaLbT4JW4JUZEq
 Lgrod5Zv6t1uKsv3IcmkOE2w/30StqfebZopmwDllb6UNI65U5ImhUIO09K9eo6Q41EI
 TGLz0FX49l0KvJohNis8hdD4NCGOyA19ubHAqd3yfpZfgx2hwpiy7NKm/5Vuo+ds7vFX
 sthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ctzgjv+NmABx1Kt3m2tDVwm2LGH0KuiBAUYDbPhDv1Q=;
 b=tAaKoSvi2DV1PSfJQM54ox80Yt8GU+139o7Bpd/Ztll8r+KyDAZhQ+eofDpW2EB691
 if1/P/U7jN6dnzlMvHTBFfKiAqTfLw4QClI1kuo0CSh6suXxavnFExMVxynJ9/9UKKla
 eSj8wcYTmzYg/yiHIfawFuMPTQ+GsqgtCeiIX8BoJ32rv4+q+7RhT/Uw+yLAeuKgk9vl
 beMM8D5Wvurxj0ZdIH6WGQCsFoVEY0y6liqsG6MQggQuHirC+ERRZkZ44fc15LXUDu26
 oYsZXHQDwGLyFV6Qri+fxuwUhTKWczUfwT8XRLlaldisiJ3It6Vb4U0NjprFV3jAYDuh
 bsqg==
X-Gm-Message-State: AOAM531Ew/KishrGAKmzauULBSfAjyzAS/zDuyyj/qdI7j8TZvHFQRQi
 A1tjwt9qbZymlEVYX9y29UJxyA==
X-Google-Smtp-Source: ABdhPJwcaqp3i4eiwneqkNGjFUh8FzXBxoYJHVg6VFa94j4eRxJJuLa5s7T5KrPNDyh0rG8MALMp+Q==
X-Received: by 2002:a7b:c7c3:: with SMTP id z3mr8803418wmk.43.1603899829707;
 Wed, 28 Oct 2020 08:43:49 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id u9sm7884114wrp.65.2020.10.28.08.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2020 08:43:49 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH 2/2] ASoc: codecs: wcd9335: Set digital gain range correctly
Date: Wed, 28 Oct 2020 15:43:40 +0000
Message-Id: <20201028154340.17090-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201028154340.17090-1-srinivas.kandagatla@linaro.org>
References: <20201028154340.17090-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-kernel@vger.kernel.org
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

digital gain range is -84dB min to 40dB max, however this was not
correctly specified in the range.

Fix this by with correct range!

Fixes: 8c4f021d806a ("ASoC: wcd9335: add basic controls")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd9335.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index f2d9d52ee171..4d2b1ec7c03b 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -618,7 +618,7 @@ static const char * const sb_tx8_mux_text[] = {
 	"ZERO", "RX_MIX_TX8", "DEC8", "DEC8_192"
 };
 
-static const DECLARE_TLV_DB_SCALE(digital_gain, 0, 1, 0);
+static const DECLARE_TLV_DB_SCALE(digital_gain, -8400, 100, -8400);
 static const DECLARE_TLV_DB_SCALE(line_gain, 0, 7, 1);
 static const DECLARE_TLV_DB_SCALE(analog_gain, 0, 25, 1);
 static const DECLARE_TLV_DB_SCALE(ear_pa_gain, 0, 150, 0);
-- 
2.21.0

