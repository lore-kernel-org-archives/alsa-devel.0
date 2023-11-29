Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBECC4167B
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Nov 2023 21:31:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EAF5E84A;
	Wed, 29 Nov 2023 22:31:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EAF5E84A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1701293474;
	bh=1aYnqYCv9PLm7xvOfw4zPS7myMf7MBU9iCQGRqGGq+I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ZjdKgDlUYPozqgY+O/XPk3rsH7NwVbhFP9p6MfSEumuhYBsLfn1RTSG6Sh65zUMDR
	 J6r/vkrDwEONzYm3I1v5zXR8LmhNxYusby4sZfWvU57oE1L55TY9WWNanTHbPKMCYS
	 hdsqNnaC7cYF+dOi7kCCM6jVaCfI5c48WpNZwfj8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1E368F80567; Wed, 29 Nov 2023 22:29:19 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 35F8AF806A1;
	Wed, 29 Nov 2023 22:29:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 66D72F800F5; Wed, 29 Nov 2023 22:29:05 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 71602F8025A
	for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2023 22:28:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 71602F8025A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Ckd+4+zn
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c9c82a976bso1634111fa.3
        for <alsa-devel@alsa-project.org>;
 Wed, 29 Nov 2023 13:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701293333; x=1701898133;
 darn=alsa-project.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HSsSWusvyuFKnB0n59GG/ZJpbxUajSal4/kkXB4+BwY=;
        b=Ckd+4+znvhuon1kOeb+bP6BDE6bsuMV9yTn6CIlg/WL9d5pBnWDBmf2zWjwNtiOT5/
         zyaeHirhQdIGqm8NXAqb0Wuzi/pddhfXqDGV0Cnwwyj0zBgBHeBc5BJWO3OYb6Iv9l3Y
         u11MBHgkTQ9eFjKcPZnxPFHgrlQ962VPVN+DtL293jKL5dz43x2uFjBVgnl3Y7RSfuVy
         ma+NB3argskiRnWl9bdy/GfC98IOCfkdtdGXGVx2flq4offAtEWBu7Uy2xQKdgNwQwz4
         BblnHq6SqXmymY79bwy2mm6luSxgka69GDjcCyMmUPAjAAhJfzm/D0c9z4O3bfG0vZPZ
         07og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701293333; x=1701898133;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSsSWusvyuFKnB0n59GG/ZJpbxUajSal4/kkXB4+BwY=;
        b=Zuj2S9aUo2KFjPH8cuJ03rfW77H0BRuocXVkRngqQYw+Cel5oQNhb1DijTj8BghwEr
         rVWTxn9soOqRlwX/8kY0bqxll1jZhCbJmgB1rfqWcRr6iUMk08i1Euqk/mfBufUfQEHG
         yHGLzNDOEN14Rj9WZmEASfaKglBDsvWLbSWAY/ZdLPW+/w44aCHDHxg2TwML6carIpTp
         rgqTcOWNWsE0KkMe7P7wG7wAj6P+b5hD4aok9uR3gIEenviCKhGC6T5NbpJbW7cuHm9+
         FiSBzpvOnZyZtCLDelwe4cUdZBspSnIw9eJg2GtGwGUJ7Z8xgM1NyqKQ4uQJB3f+TKQ4
         3GvQ==
X-Gm-Message-State: AOJu0YzSYJ38NvEQWG/w7BAIq5p5edxRAoibLTsucrJHHcd2WbckBV6J
	/396PbMudbReJ5Hhchl4Xc7EFg==
X-Google-Smtp-Source: 
 AGHT+IEkmWdPL4oWl2UHqoreap/8MLKCw3gg/vwTWvzAYgZdYOH7cYqyChHDv5dnd47KwZaWZPj/7A==
X-Received: by 2002:a2e:9f06:0:b0:2c9:b9bc:b029 with SMTP id
 u6-20020a2e9f06000000b002c9b9bcb029mr3098669ljk.17.1701293333337;
        Wed, 29 Nov 2023 13:28:53 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id
 b5-20020a05651c032500b002bcdbfe36b9sm2106196ljp.111.2023.11.29.13.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 13:28:52 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 29 Nov 2023 22:28:46 +0100
Subject: [PATCH 10/10] ASoC: cs4349: Drop legacy include
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-descriptors-sound-cirrus-v1-10-31aa74425ff8@linaro.org>
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
Message-ID-Hash: RDPFL7V4IILR5YVR6TKUWVBLPMXFFX3H
X-Message-ID-Hash: RDPFL7V4IILR5YVR6TKUWVBLPMXFFX3H
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RDPFL7V4IILR5YVR6TKUWVBLPMXFFX3H/>
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
 sound/soc/codecs/cs4349.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/cs4349.c b/sound/soc/codecs/cs4349.c
index 9083228495d4..ca8f21aa4837 100644
--- a/sound/soc/codecs/cs4349.c
+++ b/sound/soc/codecs/cs4349.c
@@ -13,7 +13,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>

-- 
2.34.1

