Return-Path: <SRS0=Q+Fc=4C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E86C2BA83
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Feb 2020 13:17:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DE9C2187F
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Feb 2020 13:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FUttgjTT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="crz6YhDt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE9C2187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C8DE51693;
	Fri, 14 Feb 2020 14:16:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C8DE51693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581686246;
	bh=hjJbimVtbiQ7gZbnzn2uj1Vhl7S1y9wm+1jjskTE7ZQ=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FUttgjTTCuVFxOJ4koOQGKCgS/w6AhUuVObr8okIYkU0wb9XuBLlqojPlzqXPYpY5
	 31dt817vfjDZT/dbFTwUQpMG+Cbgcf0TqaMYnxTnsrX7xjkutE9f/PyNZlbbqeylCB
	 9dHJA7jWUqtbonqEVsuVkWrDksY6oEN/Ju58T+JE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ABCE1F8027D;
	Fri, 14 Feb 2020 14:14:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2C78EF80264; Fri, 14 Feb 2020 14:14:07 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 36E15F80138
 for <alsa-devel@alsa-project.org>; Fri, 14 Feb 2020 14:13:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 36E15F80138
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="crz6YhDt"
Received: by mail-wm1-x341.google.com with SMTP id t14so10558747wmi.5
 for <alsa-devel@alsa-project.org>; Fri, 14 Feb 2020 05:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R5hDX2fKXXUqTN4gPhmTaSqEJNj3ED130xdKjaE+HMU=;
 b=crz6YhDtrV4g8O0/zuiDTYuG8zBCm32KRjK1pD7VSdJPhUVaoAYvLpqkt3v7PIzjH3
 obkCAkhtBFnXK0ExU10NKjBrPtLnGlHTsfOGNOgSjcQhRYEOeRtAg1kX/YRO+Cpa9CLE
 SyXdc2npbGM93qpvkjgJrD/mv/tT2utWUvKQKBvK9rmNbTqeXFFI5Ah27zYZyLJdsPlH
 abrWcUMYrrH+AJtI+u6RxalK5ymeul/ch5gXVOK15AQlgMEAY5XYjtclqy18QKxpgTHN
 EzYMvc6y+368tLzlLAASePwT+nXO3iliU+BhwY4QgFIoei+DzzeE7FcVSYd8tUstN+zy
 snGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R5hDX2fKXXUqTN4gPhmTaSqEJNj3ED130xdKjaE+HMU=;
 b=WcHiaX/kLbfaj1FW5tAaOh23meqjvE92jorxrpEotFjIVdwX96x18/o8nutImhJbIz
 JjWVthafEnorufJyodHDvlkpZkaBw4Qb0+ycNWxiEOF0D3XiTfOv3+CXqAurPW1LW8u0
 pwYOgp7gEcP4GVz1m3CBqvHOZ++1mbY8aTmHCxoQKYghIKAHZItx0HzwbIwA0GUFNbBh
 L98NnEDJGQdDSwRvGQN1b6BuO+JN7LkGaPiX5GIQ5CiDkgWzIp2evWbXFaPrLUA16rLn
 2pMmsFBcCwhz5C9WAu4Fxcz+QqB6MOpOxk2g/nmJi2rYeyt5NhBpmq59gcabVVsWaJPd
 vLtA==
X-Gm-Message-State: APjAAAUI1qHbTezP9NAM2FyVZeAzaLK7YxsEfZ71xhxAXrAlopskglFh
 jAhtZjv8g6UCqbSqRCmFXJMziA==
X-Google-Smtp-Source: APXvYqwgaIoCglawV5EQ+iFySvSsaN3OWiu9vP82DWE/KGYV9dscwOSz5sA+BE7GOlaYfgmLrE+ljA==
X-Received: by 2002:a1c:4c13:: with SMTP id z19mr4579049wmf.75.1581686038936; 
 Fri, 14 Feb 2020 05:13:58 -0800 (PST)
Received: from starbuck.baylibre.local
 (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.googlemail.com with ESMTPSA id w7sm6760792wmi.9.2020.02.14.05.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 05:13:58 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Date: Fri, 14 Feb 2020 14:13:49 +0100
Message-Id: <20200214131350.337968-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214131350.337968-1-jbrunet@baylibre.com>
References: <20200214131350.337968-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Subject: [alsa-devel] [PATCH 4/5] ASoC: meson: aiu: fix acodec dai input
	name init
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Remove the double initialization of the dai input name as reported by
sparse.

Fixes: 65816025d461 ("ASoC: meson: aiu: add internal dac codec control support")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/aiu-acodec-ctrl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/meson/aiu-acodec-ctrl.c b/sound/soc/meson/aiu-acodec-ctrl.c
index 12d8a4d351a1..b8e88b1a4fc8 100644
--- a/sound/soc/meson/aiu-acodec-ctrl.c
+++ b/sound/soc/meson/aiu-acodec-ctrl.c
@@ -128,7 +128,6 @@ static const struct snd_soc_dai_ops aiu_acodec_ctrl_output_ops = {
 
 #define AIU_ACODEC_INPUT(xname) {				\
 	.name = "ACODEC CTRL " xname,				\
-	.name = xname,						\
 	.playback = AIU_ACODEC_STREAM(xname, "Playback", 8),	\
 	.ops = &aiu_acodec_ctrl_input_ops,			\
 	.probe = meson_codec_glue_input_dai_probe,		\
-- 
2.24.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
