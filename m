Return-Path: <SRS0=nhcg=4A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C54C2BA83
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Feb 2020 05:58:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 107272073C
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Feb 2020 05:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gwH82YJs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="CbOH6Ou9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107272073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4483E167A;
	Wed, 12 Feb 2020 06:57:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4483E167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581487096;
	bh=2uhE0QGd8hAEApN3qefBw1UFmC2JMdKGIpKD7OeuAvs=;
	h=Date:In-Reply-To:References:From:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gwH82YJsRYIUM3E9r0vchHhAJ+eCjsKVSiJkrJzirqYHTv3ZLbVsgY12vVjkNDPiV
	 WQwxnGoDbHv9BQF+Mre3K2elMdhDkoL5R7jGybf6TdZM/xC4rjMxrUf31CsjGHM+WP
	 ZE9k5ttLSpzR9qj12I+8cDLOZretF5HZvE7RRAlY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D64BAF80257;
	Wed, 12 Feb 2020 06:55:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6030FF8019B; Wed, 12 Feb 2020 06:55:49 +0100 (CET)
Received: from mail-vs1-xe4a.google.com (mail-vs1-xe4a.google.com
 [IPv6:2607:f8b0:4864:20::e4a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A86DCF8020B
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2020 06:55:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A86DCF8020B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="CbOH6Ou9"
Received: by mail-vs1-xe4a.google.com with SMTP id z3so91951vsp.1
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2020 21:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=M9bQe4JOHID9ch3ITGyX6R7TVb2qhHoZt552O2LOt4s=;
 b=CbOH6Ou9sdy+drDOcbDXrzLEnpnYXAIK+pBQSEsEBH7Tfg8tBz6w5n4R5h3p5JzrX6
 I4u8xv+5TtTot2Ml+mC5QjCQpZT2GajfMLDUz5vNPhci/OaETQQkLiVzDJl7k1YH1CDG
 v3PH05eh6dKmpYwzz4fRuhdhcJckQ1H6mpgn39GDSJ1ZZdO1qzKtLoi4WG1yiRtgsrWl
 3HSKhSlb7imrZHP2V2q6TgK7TjJet3ekKqsv0qOEiYOV9Q+yFOlK+Bn5koa5G2ZuFBVD
 IbAdmcHMwMD5U5askdRUQEUDM2cTFRk7dr73HOx4pzp1Ac/tsj7abx9i2mDtcuHzgkNt
 dVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=M9bQe4JOHID9ch3ITGyX6R7TVb2qhHoZt552O2LOt4s=;
 b=ShDHiMzFOAAI8Mk1JoSXHfUDWzSnbSHtJgnId37f0Okw7NI+KRYc2fvNGnx3NnwK5r
 nJ5Vuoxf9Ns59iWhQX9Nl8jLAHQiGS2lWLkv0l7+tZm6WbHd32JtCBIheBgCeW03WG1C
 z/vunP1p12pWo/E5elnOdgQCiA+J7aB9ccQkaupLW12rXSK7Uh+8048dhqO7YxmSYUwJ
 C0WygIDXWX34p2HONaLPEi9gyRJSDqiN/wBm/3tHyfFjR6QwyufsWFa7PUN3C8VmQj8b
 Kb0VnqIDWrmWKqozFEG14YHZXbhfwsQkG13qDDTTlhkpaxsj2k/YUhXmya8dbkM8fgq7
 BFbQ==
X-Gm-Message-State: APjAAAWmBhdXA7sNqCkBF0nAzZQ+ghdMd18uxudRdkJq2AJam9HMTfEv
 aXSk1tQ5ah04RPUY70vefoGm7wKQJnke
X-Google-Smtp-Source: APXvYqwILyGwIMJDVisHLKgZjgfxKI88xEyIh2MlYu6lCbX5bZRxSUsN/rFOrqk6wKa/11OWAxB4jwP9d0OI
X-Received: by 2002:a1f:9d16:: with SMTP id g22mr6845916vke.22.1581486943646; 
 Tue, 11 Feb 2020 21:55:43 -0800 (PST)
Date: Wed, 12 Feb 2020 13:55:17 +0800
In-Reply-To: <20200212055517.122728-1-tzungbi@google.com>
Message-Id: <20200212124608.2.I5fa3fdca69dbb5d3dd5031c939b9b24095065a94@changeid>
Mime-Version: 1.0
References: <20200212055517.122728-1-tzungbi@google.com>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org
Cc: tzungbi@google.com, alsa-devel@alsa-project.org, dgreid@google.com,
 cychiang@google.com, jiaxin.yu@mediatek.com
Subject: [alsa-devel] [PATCH 2/2] ASoC: mediatek: mt8183-da7219: add speaker
	switch
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

Da7219 and max98357a share the same I2S lines.  When writing audio data
to the I2S, both codecs generate sound.

Da7219 already has a separate control "Headphone Switch".  Adds a new
control "Speakers Switch" for turning on/off max98357a.  Userspace
program can decide to turn on/off which codecs by different use cases.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 .../mediatek/mt8183/mt8183-da7219-max98357.c  | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
index c65493721e90..1626541cc0d6 100644
--- a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
@@ -372,9 +372,28 @@ static struct snd_soc_codec_conf mt6358_codec_conf[] = {
 	},
 };
 
+static const struct snd_kcontrol_new mt8183_da7219_max98357_snd_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Speakers"),
+};
+
+static const
+struct snd_soc_dapm_widget mt8183_da7219_max98357_dapm_widgets[] = {
+	SND_SOC_DAPM_SPK("Speakers", NULL),
+};
+
+static const struct snd_soc_dapm_route mt8183_da7219_max98357_dapm_routes[] = {
+	{"Speakers", NULL, "Speaker"},
+};
+
 static struct snd_soc_card mt8183_da7219_max98357_card = {
 	.name = "mt8183_da7219_max98357",
 	.owner = THIS_MODULE,
+	.controls = mt8183_da7219_max98357_snd_controls,
+	.num_controls = ARRAY_SIZE(mt8183_da7219_max98357_snd_controls),
+	.dapm_widgets = mt8183_da7219_max98357_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(mt8183_da7219_max98357_dapm_widgets),
+	.dapm_routes = mt8183_da7219_max98357_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(mt8183_da7219_max98357_dapm_routes),
 	.dai_link = mt8183_da7219_max98357_dai_links,
 	.num_links = ARRAY_SIZE(mt8183_da7219_max98357_dai_links),
 	.aux_dev = &mt8183_da7219_max98357_headset_dev,
-- 
2.25.0.225.g125e21ebc7-goog

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
