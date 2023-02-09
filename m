Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 885DBC636CC
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Feb 2023 01:22:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 55F92836;
	Thu,  9 Feb 2023 02:21:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 55F92836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675905729;
	bh=JkAg7I4xX2ZHwLyXN7kQS5+LcN1xcKDz/x6WfiZGuXM=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=CuGHY5VkiR57ROAcwhVEAN6gdO3FwtRuSJ5Tu/h5+gv1zv2F0hQDLTWe5+P1yw49g
	 N56DOkmQLAoFdilvPIPfjMnn5o+nvG+AOIDgRCqutmAUzxqzI3XMKyaHR8fqDLqyrC
	 srE5y76jKjqV1Bc2UeYF8v8c1HlJ6hODQhywNugU=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E69F8F80086;
	Thu,  9 Feb 2023 02:20:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0C6AFF800E4; Thu,  9 Feb 2023 02:20:50 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 119D0F80094
	for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2023 02:20:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 119D0F80094
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=NkUqlJEj
Received: by mail-il1-x12b.google.com with SMTP id a5so272696ilk.6
        for <alsa-devel@alsa-project.org>;
 Wed, 08 Feb 2023 17:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c4B/fP2D/WU+gvJrKKscgdRErT41eDBoC5g7skBzasQ=;
        b=NkUqlJEjSov6W2wIEnq48XFTKiW5FzL+wHt0lB8O7+5qepak1bLdF+ealyW5nlTKoZ
         R8WVT9oDjgCa5PTbHJDSjUqTaQ3Emw95eyyahcVuOWAS1J+vEKh/V3iNGOe5WPoPS+7F
         i0ewRT6s/2PRIPWclUIcBjYqUZZx3afRiZx8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c4B/fP2D/WU+gvJrKKscgdRErT41eDBoC5g7skBzasQ=;
        b=wvU+hmWVmmue0V5U1XLd6hP2Pbl37V3PdNtk/RNlqICSSVOdoeyzlzQ7zseSW3Lmb+
         ZIbt1h6px86dBr6uZp25a+1FHr6Hidu3eRkh4lDQblxCo0kXwKCRNHkSEyd4DrRREwD4
         hyHdsXHZE1F/ho+bL50UM3JA+z8FdLhGrFUBsNKbdA66JTOPk2xkXxQdYHP5FU6Ogq/+
         X39bvUmPmHsWNDuPMeX8q3PB9BTajB/rn/uAiOdl4mXqsMH/C6+2VqOw4Q2mNoSiJ6rX
         vHfEbQTIU5THhJPUk5dqYuk8xn+7AeYGTbSfEGHUw6F0khDPrMlPKKjE08WLU+qiPYQh
         zuRQ==
X-Gm-Message-State: AO0yUKW5q/9GDLyRxjnxvV8kmSiat1ygNdJB1rix+fTWnG/rpCfosQn0
	tcpJKIZDemNW8RKaCCPvz7Bc0Q==
X-Google-Smtp-Source: 
 AK7set/BMy8+uzdHTjc28D58ZB+OLGxa38IJBo8tQeuPQ/aQ4jNRmPt1RTq9/JLVWjl906HZlLggUg==
X-Received: by 2002:a05:6e02:12ed:b0:310:e9f4:1e32 with SMTP id
 l13-20020a056e0212ed00b00310e9f41e32mr10892050iln.19.1675905631149;
        Wed, 08 Feb 2023 17:20:31 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id
 j18-20020a02cc72000000b003a60e059970sm2253jaq.84.2023.02.08.17.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 17:20:30 -0800 (PST)
From: Matthias Kaehlcke <mka@chromium.org>
To: Oder Chiou <oder_chiou@realtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] SoC: rt5682s: Disable jack detection interrupt during suspend
Date: Thu,  9 Feb 2023 01:20:23 +0000
Message-Id: 
 <20230209012002.1.Ib4d6481f1d38a6e7b8c9e04913c02ca88c216cf6@changeid>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: WJVD2DNRBWRH2PHPSISI6NXKKB7WISZA
X-Message-ID-Hash: WJVD2DNRBWRH2PHPSISI6NXKKB7WISZA
X-MailFrom: mka@chromium.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, Douglas Anderson <dianders@chromium.org>,
 Judy Hsiao <judyhsiao@chromium.org>, linux-kernel@vger.kernel.org,
 Matthias Kaehlcke <mka@chromium.org>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WJVD2DNRBWRH2PHPSISI6NXKKB7WISZA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The rt5682s driver switches its regmap to cache-only when the
device suspends and back to regular mode on resume. When the
jack detect interrupt fires rt5682s_irq() schedules the jack
detect work. This can result in invalid reads from the regmap
in cache-only mode if the work runs before the device has
resumed:

[   19.672162] rt5682s 2-001a: ASoC: error at soc_component_read_no_lock on rt5682s.2-001a for register: [0x000000f0] -16

Disable the jack detection interrupt during suspend and
re-enable it on resume. The driver already schedules the
jack detection work on resume, so any state change during
suspend is still handled.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 sound/soc/codecs/rt5682s.c | 10 +++++++++-
 sound/soc/codecs/rt5682s.h |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5682s.c b/sound/soc/codecs/rt5682s.c
index f5e5dbc3b0f0..59117ebc5ecd 100644
--- a/sound/soc/codecs/rt5682s.c
+++ b/sound/soc/codecs/rt5682s.c
@@ -2895,6 +2895,9 @@ static int rt5682s_suspend(struct snd_soc_component *component)
 {
 	struct rt5682s_priv *rt5682s = snd_soc_component_get_drvdata(component);
 
+	if (rt5682s->irq)
+		disable_irq(rt5682s->irq);
+
 	cancel_delayed_work_sync(&rt5682s->jack_detect_work);
 	cancel_delayed_work_sync(&rt5682s->jd_check_work);
 
@@ -2919,6 +2922,9 @@ static int rt5682s_resume(struct snd_soc_component *component)
 			&rt5682s->jack_detect_work, msecs_to_jiffies(0));
 	}
 
+	if (rt5682s->irq)
+		enable_irq(rt5682s->irq);
+
 	return 0;
 }
 #else
@@ -3259,7 +3265,9 @@ static int rt5682s_i2c_probe(struct i2c_client *i2c)
 		ret = devm_request_threaded_irq(&i2c->dev, i2c->irq, NULL, rt5682s_irq,
 			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 			"rt5682s", rt5682s);
-		if (ret)
+		if (!ret)
+			rt5682s->irq = i2c->irq;
+		else
 			dev_err(&i2c->dev, "Failed to reguest IRQ: %d\n", ret);
 	}
 
diff --git a/sound/soc/codecs/rt5682s.h b/sound/soc/codecs/rt5682s.h
index 67f86a38a1cc..caa7733b430f 100644
--- a/sound/soc/codecs/rt5682s.h
+++ b/sound/soc/codecs/rt5682s.h
@@ -1472,6 +1472,7 @@ struct rt5682s_priv {
 	int pll_comb;
 
 	int jack_type;
+	unsigned int irq;
 	int irq_work_delay_time;
 	int wclk_enabled;
 };
-- 
2.39.1.519.gcb327c4b5f-goog

