Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0925C52D7C
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Aug 2024 11:53:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9A8711E7;
	Wed, 21 Aug 2024 13:53:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9A8711E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1724241237;
	bh=ZNOIiksq+oIvdQ6nChxSzgVj3WAtiicwlWk2MzXMfF8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=mGMKEKDq9/0VbQ7kHUNkGe9Oyv1bJ6CL+O8hUg0MiILlq8b6/RcYBaWXd5rIghaxP
	 NpNpssqMIsjnNoNX/dcKUiSlDIovljhUqhBCs+WPEYt6XyCRB07sGfz48epahGI4i2
	 lM1JQnCZaEmNry6nXZj+kDfy3J/OiJfPdLY7HYYs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B0DD4F805BB; Wed, 21 Aug 2024 13:53:20 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EEF94F805BA;
	Wed, 21 Aug 2024 13:53:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1005CF80496; Wed, 21 Aug 2024 13:49:38 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4F742F8016E
	for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2024 13:49:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4F742F8016E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=W4CfS65c
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52f04b3cb33so4250068e87.0
        for <alsa-devel@alsa-project.org>;
 Wed, 21 Aug 2024 04:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724240969; x=1724845769;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MuMMiFy/GV/lo8qvjkEdntUASLQW+h7BP1y0eXqQ2Fk=;
        b=W4CfS65cNHSWB/hNnAUxWr6Egb4DUB6iuRS+5Er7Dhh62VEvhv4iEI+lypxffVpxJO
         iVzmskfyrrZxndVYGJ2XQO2nftN570ZylhIQ3MQvXncflffDkXMtcvSBRNpY+xWa3ndE
         C0yOGeeKSQBUZfz770dOQPlpPSGPovK9QWeb+kC5FJNqPyXKJJtvfuGYHygfutEAu3MQ
         NZK/md8wGLvknMGGOKFg04MSmbDDUsuK7T0qP6GKGiydo8AjR2fk5R/c87EZAYfSPBWq
         kP40lAuez969ZuN/7YJiMsfQQ6+p3mtG9aKfAwJr5+Fxwm6DCodPRVWf/7N5poMmEtoQ
         Dmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724240969; x=1724845769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MuMMiFy/GV/lo8qvjkEdntUASLQW+h7BP1y0eXqQ2Fk=;
        b=FnUUxPwMi4rMUUhqVW912C3t4noGVU3qBbcljbGL8McB8TevUfkMkfdAjiAwc8KvhC
         VdQpqQ5qVwNA3DJpTiEdJ9xC/RNGrlqKEGGfKAsNgGPZk8IP7MmpKm2b4RvQZ6bNMSLp
         zzPZFysqMlQLEDMQbGff8U7wV0+HM57+8i28C9YCNTtXNj0E7aovUH8bAje66cepiR5O
         N+D0TDB8zZmFWrbvtR9WisQgQVHcHP0uaY8M8pHQVKB4Z9uhcCSx/Zu43vlJUCDeOerl
         tohK0/IGLGSt7kK0PV0yFaHAlnsg4dk6d0s1j5yEIOaQaUNuSTi8ONUjlZoPKsfZnluQ
         GxyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+6u/CA63bStxz1574Pb6owX/smyQmqxwU33+UfYHVsCWpmiDFlMByJRpzMxoXb67krcPI+0Cn+sGB@alsa-project.org
X-Gm-Message-State: AOJu0Yz+HNW2gu3w9ukm9hI4LFGlodMWlA3oBXvfqli5KKNkErtjUKTN
	u09P2bgzYZnKw+d+XEHJgwsF9/0vIgmO5c1cqaXt1gL2V2ONn5N8
X-Google-Smtp-Source: 
 AGHT+IERUWWgK3HBz7H/4+znx84XAekugvyQB1GyHzWt3CJXUdgvULEOKqQjl6jNQIER3p0yxeZlVg==
X-Received: by 2002:a05:6512:1256:b0:533:324a:9df6 with SMTP id
 2adb3069b0e04-533485928cdmr2036535e87.29.1724240969163;
        Wed, 21 Aug 2024 04:49:29 -0700 (PDT)
Received: from localhost
 (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a86702ad43fsm89820966b.136.2024.08.21.04.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 04:49:28 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: codecs: wcd934x: make read-only array minCode_param
 static const
Date: Wed, 21 Aug 2024 12:49:27 +0100
Message-Id: <20240821114927.520193-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID-Hash: NIGO375FTQXC6D7SBVKDTMZP6PMRCQMW
X-Message-ID-Hash: NIGO375FTQXC6D7SBVKDTMZP6PMRCQMW
X-MailFrom: colin.i.king@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NIGO375FTQXC6D7SBVKDTMZP6PMRCQMW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Don't populate the read-only array minCode_param on the stack at
run time, instead make it static const.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/codecs/wcd934x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 291d0c80a6fc..910852eb9698 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -2643,8 +2643,8 @@ static void wcd934x_mbhc_get_result_params(struct wcd934x_codec *wcd934x,
 	s16 c1;
 	s32 x1, d1;
 	int32_t denom;
-	int minCode_param[] = {
-			3277, 1639, 820, 410, 205, 103, 52, 26
+	static const int minCode_param[] = {
+		3277, 1639, 820, 410, 205, 103, 52, 26
 	};
 
 	regmap_update_bits(wcd934x->regmap, WCD934X_ANA_MBHC_ZDET, 0x20, 0x20);
-- 
2.39.2

