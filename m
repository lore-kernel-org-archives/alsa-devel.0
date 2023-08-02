Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF74C001DF
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Aug 2023 17:59:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 37006820;
	Wed,  2 Aug 2023 19:59:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 37006820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690999194;
	bh=5u1Ny99g6NHLLGYkq00QMh64p+nGQH1ZFYlntEYOsTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=t5QEqhci4T9HS0SkSMz2+pq4vzNmzu6GpBWfGVqJPauxbw/3weyst72U15MOvIuaZ
	 RE3TlDBUygRls8oGg3Lr7yoiKYydHe0AMwnbIlrcpfospSGXL7iUr1Cq5RJXLuwfn8
	 I9zPoaYCx9N92QrdGc3ryVLO//ivmeELX0LvJHSo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CEAFAF80564; Wed,  2 Aug 2023 19:58:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 33269F80553;
	Wed,  2 Aug 2023 19:58:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3E157F80535; Wed,  2 Aug 2023 19:58:08 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1AB9CF8016D
	for <alsa-devel@alsa-project.org>; Wed,  2 Aug 2023 19:57:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1AB9CF8016D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20221208 header.b=kZWYUQ2z
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-317c11517a0so3447f8f.0
        for <alsa-devel@alsa-project.org>;
 Wed, 02 Aug 2023 10:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690999076; x=1691603876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brF3soBTEQ7lATGtnS3zYxb7mTThtaUthI8D9XqkA8U=;
        b=kZWYUQ2zZqRsD5oZlb5Tp99pT8j2KFnXx/x0wYpcz3Ah+nAL+XycehI0yWOotAftmg
         Zq1+7eTn8w4mVc3czxO7dqDi9+Idxh/kp+08TSOmFudi+6m/GU/xgGcR8ZNoo6f4zYqJ
         TBXShkSvrwbDN9hr3vP9r3P/Hc7RBRyeHCz5nrPiLF76GrjqwW8YQeM5ynJr5fSA/KSJ
         pXBKvI9BVt7GpJl6NxZBndooXEhrO9TsuC3YRKAhl0S37bi/w2tGttNvBeQsJ6Vhu+3y
         mOfG4sTPucFQdCX+SQQddJE6b5ewcSmuJFQaZxsP8/EJB1IqAyKhOeRgxA4IqODXHj+f
         VMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690999076; x=1691603876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brF3soBTEQ7lATGtnS3zYxb7mTThtaUthI8D9XqkA8U=;
        b=INORoGqNeLxFVGG6oG9/80q8bBAeyZ0U10d2ql9ISCwdxh/Q9izXMjKmleMXn76xbG
         90DMH1/Jz/Nih22ogSh0pJdUel5ENMvCMdGI5p7ud826tlhVBaKslh4ggRHSl3DAX8IC
         p1GITUCPvVstf1sBkMn4pcys8oH5njCPaMSp0rkW1KFBQ97/ULOfRyae+4ym78tGAhpQ
         njUgDSFrJxlNrRaobCIrevinWjRpZoMRB0ifDy1Jk74PTcwSLo+puoP/en9Dd4in1kRN
         coWCrAKjJhkkgBpqB1fuoJ1Es/z1hARcQ4nKkzCTE0NeBzPGqXHJEHhBnQ+ftM6ePM9w
         Endw==
X-Gm-Message-State: ABy/qLasPStZ7t1Fm5Lm8X3gpMm6rbzdv3zQG0+zfiLOL54kq8j/tOee
	jk/kLvBUbbBYU/LIKmzpEojP8oUmqbY=
X-Google-Smtp-Source: 
 APBJJlGS3n72jelR+5CW5X/s/y1sftl/stCBASnlJP6scTtObuQyQ2mFLQUolQRV7m0Ede6z6aQhzw==
X-Received: by 2002:adf:e546:0:b0:317:6570:afec with SMTP id
 z6-20020adfe546000000b003176570afecmr5701405wrm.3.1690999076398;
        Wed, 02 Aug 2023 10:57:56 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1])
        by smtp.gmail.com with ESMTPSA id
 l23-20020a7bc457000000b003fe20db88ebsm2192439wmi.31.2023.08.02.10.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:57:56 -0700 (PDT)
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
To: alsa-devel@alsa-project.org
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
	Alper Nebi Yasak <alpernebiyasak@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Takashi Iwai <tiwai@suse.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-kernel@vger.kernel.org,
	Akihiko Odaki <akihiko.odaki@gmail.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?=
 <nfraprado@collabora.com>
Subject: [PATCH 01/27] ASoC: amd: acp-da7219-max98357a: Map missing jack
 kcontrols
Date: Wed,  2 Aug 2023 20:57:11 +0300
Message-Id: <20230802175737.263412-2-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230802175737.263412-1-alpernebiyasak@gmail.com>
References: <20230802175737.263412-1-alpernebiyasak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: IDW322FA326OTL4PRYP6HPIY2EK5DVBJ
X-Message-ID-Hash: IDW322FA326OTL4PRYP6HPIY2EK5DVBJ
X-MailFrom: alpernebiyasak@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IDW322FA326OTL4PRYP6HPIY2EK5DVBJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This driver does not properly map jack pins to kcontrols that PulseAudio
and PipeWire need to handle jack detection events. The DA7219 codec used
here can detect Headphones, Headset Mic and Line Out connections. Expose
each to userspace as kcontrols and add the necessary widgets.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---

 sound/soc/amd/acp-da7219-max98357a.c | 41 +++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 7464ca2b596c..9e3133bec2b1 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -28,6 +28,21 @@
 #define RT5682_PLL_FREQ (48000 * 512)
 
 static struct snd_soc_jack cz_jack;
+static struct snd_soc_jack_pin cz_jack_pins[] = {
+	{
+		.pin = "Headphone Jack",
+		.mask = SND_JACK_HEADPHONE,
+	},
+	{
+		.pin = "Headset Mic",
+		.mask = SND_JACK_MICROPHONE,
+	},
+	{
+		.pin = "Line Out",
+		.mask = SND_JACK_LINEOUT,
+	},
+};
+
 static struct clk *da7219_dai_wclk;
 static struct clk *da7219_dai_bclk;
 static struct clk *rt5682_dai_wclk;
@@ -66,11 +81,13 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 	if (IS_ERR(da7219_dai_bclk))
 		return PTR_ERR(da7219_dai_bclk);
 
-	ret = snd_soc_card_jack_new(card, "Headset Jack",
-				SND_JACK_HEADSET | SND_JACK_LINEOUT |
-				SND_JACK_BTN_0 | SND_JACK_BTN_1 |
-				SND_JACK_BTN_2 | SND_JACK_BTN_3,
-				&cz_jack);
+	ret = snd_soc_card_jack_new_pins(card, "Headset Jack",
+					 SND_JACK_HEADSET | SND_JACK_LINEOUT |
+					 SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+					 SND_JACK_BTN_2 | SND_JACK_BTN_3,
+					 &cz_jack,
+					 cz_jack_pins,
+					 ARRAY_SIZE(cz_jack_pins));
 	if (ret) {
 		dev_err(card->dev, "HP jack creation failed %d\n", ret);
 		return ret;
@@ -146,11 +163,13 @@ static int cz_rt5682_init(struct snd_soc_pcm_runtime *rtd)
 	if (IS_ERR(rt5682_dai_bclk))
 		return PTR_ERR(rt5682_dai_bclk);
 
-	ret = snd_soc_card_jack_new(card, "Headset Jack",
-				    SND_JACK_HEADSET | SND_JACK_LINEOUT |
-				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
-				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
-				    &cz_jack);
+	ret = snd_soc_card_jack_new_pins(card, "Headset Jack",
+					 SND_JACK_HEADSET | SND_JACK_LINEOUT |
+					 SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+					 SND_JACK_BTN_2 | SND_JACK_BTN_3,
+					 &cz_jack,
+					 cz_jack_pins,
+					 ARRAY_SIZE(cz_jack_pins));
 	if (ret) {
 		dev_err(card->dev, "HP jack creation failed %d\n", ret);
 		return ret;
@@ -631,6 +650,7 @@ static struct snd_soc_dai_link cz_dai_5682_98357[] = {
 static const struct snd_soc_dapm_widget cz_widgets[] = {
 	SND_SOC_DAPM_HP("Headphones", NULL),
 	SND_SOC_DAPM_SPK("Speakers", NULL),
+	SND_SOC_DAPM_LINE("Line Out", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_MIC("Int Mic", NULL),
 };
@@ -654,6 +674,7 @@ static const struct snd_soc_dapm_route cz_rt5682_audio_route[] = {
 static const struct snd_kcontrol_new cz_mc_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphones"),
 	SOC_DAPM_PIN_SWITCH("Speakers"),
+	SOC_DAPM_PIN_SWITCH("Line Out"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
 	SOC_DAPM_PIN_SWITCH("Int Mic"),
 };
-- 
2.40.1

