Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E92C4167B
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Nov 2023 21:30:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DDC47DE5;
	Wed, 29 Nov 2023 22:30:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DDC47DE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1701293440;
	bh=ldNdFxhQm8pe3gD06rPzZZR3kdwQ47mC0qwPu00ZFcg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hzDNfTrsyePSuoh8fqx4jqARcBiQBiZvoNfg7lyEX2P0KFINVl7tjzrXGs/ONJ6QV
	 yaKdWHInmnul//26ilRYe90TOJiJ+Yj/jmCA2v7itGnRVjqYnSeVtDn88ocmwEFhja
	 ZKkQljU6/zSqxecsyuuf3YoZp5MxFW0hkZuMck+I=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 80F82F80624; Wed, 29 Nov 2023 22:29:12 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7BC2AF80634;
	Wed, 29 Nov 2023 22:29:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B8D6FF802BE; Wed, 29 Nov 2023 22:29:02 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4C6A6F80254
	for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2023 22:28:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4C6A6F80254
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=urqxufmb
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2c9b5c12898so3551161fa.2
        for <alsa-devel@alsa-project.org>;
 Wed, 29 Nov 2023 13:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701293331; x=1701898131;
 darn=alsa-project.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iu+jnDbRLvNSd29JPH0PlE0Rt4h1OZvlGiQIvlLElkY=;
        b=urqxufmbyV9a+bkv3seezZ/64r3S2Qlb9nWqN0mDnQEdelZf1Dz0/+SqgRtO/jHO6L
         gW6Bi6buqJZAat5UhVuR+EXYhMlRQ3FaglWrI7TLFLr/yW0nTZunTGfQ7G+f2JUEasc3
         hCDbya0qm6QFyYzg0e560L0MG9kvPGSVfNZvJgSraTGIlmD5wt4DI9A6jbvN0Fd5vShU
         NYzNZ3CxO1XdIiBs0vlO3EZFCWNfB29ycBGirOxd9p9wUR8dOOmziLsXNOOiB+fbBZMi
         N7p1wYWWxQ23hq8pPdR/5bTi8GARHEsxs2aPttjj38E7ka2riHzdwmWQ9/QaEWCx6Qzf
         k5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701293331; x=1701898131;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iu+jnDbRLvNSd29JPH0PlE0Rt4h1OZvlGiQIvlLElkY=;
        b=Ka8XzaubQtWxNMdSkTOkfFVaSWuwYz/UaION93DcH77cAfJ6G7mwnWZWFuRCwfuNyW
         lwf3Y1ptOYH3TU5DeLP6kO6VV/hQRA2j+8j3JYhWLPZexoDd+QGp71vnflNqQdt4n3Pd
         FRL3NvGfNlEAeItYHrintafdAPWvc1uxTdKP3BL9sm6EwIMx2GMQEqLt6SqtpMXJkwPV
         0c7ZA+vXuoN6GTGNGIFmdNRapKrTa1LrTMSyHBxMuFdV0ZCxYe5AvPxWxVGr1GwOJK7Z
         B6UwdMj0ilgyFljq0dTVZHVCbfoGehVdLBGsu8mEu14csIgMzZOPiwq/ssLOE00c/RXk
         y76Q==
X-Gm-Message-State: AOJu0YyMvF2HBS1JQSG+hcfIpaATOiX2l2qX+ETtzvsOVLr5/I1LmrPz
	8LP2AwXLvmfaebX/815I5319Sg==
X-Google-Smtp-Source: 
 AGHT+IF/28zICERnGlS5+OnSEEJkvgxEGnITMU5KpHeObXbDWy5BHjwpi8sDYXn7h5PUPVbGD2wWHA==
X-Received: by 2002:a2e:87d9:0:b0:2c9:bfb1:aa75 with SMTP id
 v25-20020a2e87d9000000b002c9bfb1aa75mr2165119ljj.29.1701293331064;
        Wed, 29 Nov 2023 13:28:51 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id
 b5-20020a05651c032500b002bcdbfe36b9sm2106196ljp.111.2023.11.29.13.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 13:28:50 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 29 Nov 2023 22:28:44 +0100
Subject: [PATCH 08/10] ASoC: cs42l42: Drop legacy include
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-descriptors-sound-cirrus-v1-8-31aa74425ff8@linaro.org>
References: <20231129-descriptors-sound-cirrus-v1-0-31aa74425ff8@linaro.org>
In-Reply-To: <20231129-descriptors-sound-cirrus-v1-0-31aa74425ff8@linaro.org>
To: Paul Handrigan <Paul.Handrigan@cirrus.com>,
 James Schulman <james.schulman@cirrus.com>,
 David Rhodes <david.rhodes@cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Hartley Sweeten <hsweeten@visionengravers.com>,
 Alexander Sverdlin <alexander.sverdlin@gmail.com>,
 Nikita Shubin <nikita.shubin@maquefel.me>
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4
Message-ID-Hash: RLUMOP6KYGJYOUDBJ3XPNA5LSXDF5FG7
X-Message-ID-Hash: RLUMOP6KYGJYOUDBJ3XPNA5LSXDF5FG7
X-MailFrom: linus.walleij@linaro.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RLUMOP6KYGJYOUDBJ3XPNA5LSXDF5FG7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This driver includes the legacy GPIO API <linux/gpio.h> but
does not use any symbols from it.

Drop the include.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 sound/soc/codecs/cs42l42.c | 1 -
 sound/soc/codecs/cs42l42.h | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 94bcab812629..2d11c5125f73 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -15,7 +15,6 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index 7785125b73ab..3d85ebc59489 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -14,7 +14,7 @@
 
 #include <dt-bindings/sound/cs42l42.h>
 #include <linux/device.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/mutex.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>

-- 
2.34.1

