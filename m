Return-Path: <SRS0=qBPI=XB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2867DC43331
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:56:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0C5E208C3
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gUrLUit6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YW0k1PU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C5E208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EDF871655;
	Fri,  6 Sep 2019 21:55:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EDF871655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567799783;
	bh=GD0nc+pdJfOanRgMdcaFbJMzWh9IagvtFCCEy5IKbMw=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gUrLUit63eRg1opiI/JfwKUePrnWrRHId4l//m6ZFqRmTdiHTwymCvJjJTUoIOcDE
	 uLmzV9lzbTBqg9pHlBrvTUC25VAmZd8ZTWsfpIYJwxJmNJa7S0MIo7vrJB/LAOSTN6
	 MZ3vmHqPyaViFUL/PzYqGAhMSx0n/ROrsUMqRZY8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AA62FF80716;
	Fri,  6 Sep 2019 21:48:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4102CF806EF; Fri,  6 Sep 2019 21:48:23 +0200 (CEST)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DA418F80679
 for <alsa-devel@alsa-project.org>; Fri,  6 Sep 2019 21:48:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DA418F80679
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="YW0k1PU5"
Received: by mail-pg1-x543.google.com with SMTP id n190so4090545pgn.0
 for <alsa-devel@alsa-project.org>; Fri, 06 Sep 2019 12:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ovWve/Pf/vgU6/XEYbPPN869G7pjHo6uDWX9Rl3uHyI=;
 b=YW0k1PU5JHyefHoHhntqmiLEw8CUJH840c3QuBEYc/hfG8KIOnBgFlUTBc0dbGajE+
 ubUfrxyKdQJY9QBCyWHojiDMLe27ENKXVRT+mpPy7Gz10RFqi+01UVflfyeToIbsEKl/
 0H9IuSPat+BXfIjVzCeqsuAZfjVndTPYKw27M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ovWve/Pf/vgU6/XEYbPPN869G7pjHo6uDWX9Rl3uHyI=;
 b=N4FU1vOgp6NabTnNra4gLj2yG/wAEPyweCohxRPB0cqORcyg57fOxfdeX3Q6xitSpO
 5uUtDIrRpD/03U4ECBOYuSQW8U9LpYKU/n5LuF4Oo2PV8jZ3wCAaD2jOvdfz9l2zuWJk
 4MmceIrGuKjkpYe+nGnvZjS3+JZXcoJr8Y1R+/gCvBY3OaVH5xHliChWok8rPiBN+giw
 gyT3X3qDjN5uc7mt27JmYaIaHWtmh9MDkqwd83mpl0LSW2k+h3Co4RatAMtb9/wSIqz6
 azvREeBnYID58fHmWXpiMllJ0sGVMeg1Vh+Ars0ZRufWtaIfk+W/J19vnGS7xfeReF7c
 15jA==
X-Gm-Message-State: APjAAAVSgB9BUu0kcEcSKfnsXzH+5w9h89GOaj9LXFSZkrbVOgWxK9CZ
 xuWpWTNHRIXsjlgCnj2H59SVrjRorA==
X-Google-Smtp-Source: APXvYqzJgWCTMeAVCn60xahKjRFrZA4OyIud6uNgyIMaoj9XJsSr606EYoRHlskNVZDiDM51bl3zJA==
X-Received: by 2002:aa7:8005:: with SMTP id j5mr12756323pfi.50.1567799297726; 
 Fri, 06 Sep 2019 12:48:17 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:c87a:31ae:9107:f63d])
 by smtp.gmail.com with ESMTPSA id 129sm8340308pfd.173.2019.09.06.12.48.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2019 12:48:17 -0700 (PDT)
From: Curtis Malainey <cujomalainey@chromium.org>
To: alsa-devel@alsa-project.org
Date: Fri,  6 Sep 2019 12:46:33 -0700
Message-Id: <20190906194636.217881-12-cujomalainey@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190906194636.217881-1-cujomalainey@chromium.org>
References: <20190906194636.217881-1-cujomalainey@chromium.org>
MIME-Version: 1.0
Cc: Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Ben Zhang <benzh@chromium.org>,
 Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>,
 Curtis Malainey <cujomalainey@chromium.org>
Subject: [alsa-devel] [RFC 11/15] ASoC: rt5677: Stop and restart DSP over
	suspend/resume
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

From: Ben Zhang <benzh@chromium.org>

MCLK1 gets disabled at suspend and re-enabled at resume. Before
MCLK1 is re-enabled, if the DSP is already on (either the DSP was
left on during suspend, or the DSP is turned on early at resume),
i2c register read returns garbage and corrupts the regmap cache.

This patch stops the DSP before suspend and restarts it after
resume with a dalay to ensure MCLK is on while loading firmware.

Signed-off-by: Ben Zhang <benzh@chromium.org>
Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
---
 sound/soc/codecs/rt5677.c | 24 +++++++++++++++++++++---
 sound/soc/codecs/rt5677.h |  3 ++-
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index f07d10a8b045..098dcbaa4539 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -921,6 +921,7 @@ static int rt5677_load_dsp_from_file(struct rt5677_priv *rt5677)
 static int rt5677_set_dsp_vad(struct snd_soc_component *component, bool on)
 {
 	struct rt5677_priv *rt5677 = snd_soc_component_get_drvdata(component);
+	rt5677->dsp_vad_en_request = on;
 	rt5677->dsp_vad_en = on;
 
 	if (!IS_ENABLED(CONFIG_SND_SOC_RT5677_SPI))
@@ -1013,7 +1014,7 @@ static int rt5677_dsp_vad_get(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct rt5677_priv *rt5677 = snd_soc_component_get_drvdata(component);
 
-	ucontrol->value.integer.value[0] = rt5677->dsp_vad_en;
+	ucontrol->value.integer.value[0] = rt5677->dsp_vad_en_request;
 
 	return 0;
 }
@@ -4680,14 +4681,15 @@ static int rt5677_set_bias_level(struct snd_soc_component *component,
 			enum snd_soc_bias_level level)
 {
 	struct rt5677_priv *rt5677 = snd_soc_component_get_drvdata(component);
+	enum snd_soc_bias_level prev_bias =
+		snd_soc_component_get_bias_level(component);
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		break;
 
 	case SND_SOC_BIAS_PREPARE:
-		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_STANDBY) {
-			rt5677_set_dsp_vad(component, false);
+		if (prev_bias == SND_SOC_BIAS_STANDBY) {
 
 			regmap_update_bits(rt5677->regmap, RT5677_PWR_ANLG1,
 				RT5677_LDO1_SEL_MASK | RT5677_LDO2_SEL_MASK,
@@ -4711,9 +4713,25 @@ static int rt5677_set_bias_level(struct snd_soc_component *component,
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
+		if (prev_bias == SND_SOC_BIAS_OFF &&
+				rt5677->dsp_vad_en_request) {
+			/* Re-enable the DSP if it was turned off at suspend */
+			rt5677->dsp_vad_en = true;
+			/* The delay is to wait for MCLK */
+			schedule_delayed_work(&rt5677->dsp_work,
+					msecs_to_jiffies(1000));
+		}
 		break;
 
 	case SND_SOC_BIAS_OFF:
+		flush_delayed_work(&rt5677->dsp_work);
+		if (rt5677->is_dsp_mode) {
+			/* Turn off the DSP before suspend */
+			rt5677->dsp_vad_en = false;
+			schedule_delayed_work(&rt5677->dsp_work, 0);
+			flush_delayed_work(&rt5677->dsp_work);
+		}
+
 		regmap_update_bits(rt5677->regmap, RT5677_DIG_MISC, 0x1, 0x0);
 		regmap_write(rt5677->regmap, RT5677_PWR_DIG1, 0x0000);
 		regmap_write(rt5677->regmap, RT5677_PWR_ANLG1,
diff --git a/sound/soc/codecs/rt5677.h b/sound/soc/codecs/rt5677.h
index d18b41da1176..046ed2ee8e31 100644
--- a/sound/soc/codecs/rt5677.h
+++ b/sound/soc/codecs/rt5677.h
@@ -1846,7 +1846,8 @@ struct rt5677_priv {
 #ifdef CONFIG_GPIOLIB
 	struct gpio_chip gpio_chip;
 #endif
-	bool dsp_vad_en; /* DSP VAD enable/disable request */
+	bool dsp_vad_en_request; /* DSP VAD enable/disable request */
+	bool dsp_vad_en; /* dsp_work parameter */
 	bool is_dsp_mode;
 	bool is_vref_slow;
 	struct delayed_work dsp_work;
-- 
2.23.0.187.g17f5b7556c-goog

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
