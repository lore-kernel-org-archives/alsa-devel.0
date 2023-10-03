Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C08DE7AD75
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Oct 2023 16:03:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A1477E74;
	Tue,  3 Oct 2023 18:03:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A1477E74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696349031;
	bh=9Ubr+IhBnNwpdPuPk/XbfbKlx5zEKvtiPdy0NEO9LPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=JjXqNlYoe8sEW5D1kgenLOWuORdWmF8kCA5e1/IsAMhRPLBQ1RRQgofnGFfIvEmyN
	 ZWz5YQ52mPDBC26xsO1vx4pEEb6ApBZ2GpWdWvlcakliTkrnctq6vr58TIyM/mtpUg
	 5i9CyiZ4wkYec6wkJioO7lSH2KEgpSGcJOroonvU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 66453F80568; Tue,  3 Oct 2023 18:02:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D53BBF8056F;
	Tue,  3 Oct 2023 18:02:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1FB8DF80564; Tue,  3 Oct 2023 17:59:29 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2FAC4F8047D
	for <alsa-devel@alsa-project.org>; Tue,  3 Oct 2023 17:57:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2FAC4F8047D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=su6m8QvP
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9a9f139cd94so184201366b.2
        for <alsa-devel@alsa-project.org>;
 Tue, 03 Oct 2023 08:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696348636; x=1696953436;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=168VbodA38Hdi5eAfuNgKvUwcfZckCEtb5Hwk95lQ/Q=;
        b=su6m8QvPbKnKqj2v2VlEkNJEEwJ2oWhY7z2yQUsLuCZezBV4u79+ptWaCENyqLj42W
         J1pPiA90WXNKZHiUkI2H8ulM2JdDAwppZOIUYjSf3u2zd2oM7oI3kUPszXO78zsggnqN
         oBU4hxsLfuhyFPRs3r3WlIRrHfoCOhV5WpDxfZoJYc6m2mN0vna535AcyQrbqkNeRAEd
         Alos3ldIxZTt1HlRcKMk86C0Cc/VunAVRogbpv4SA8d0uob9uTfSYfCaNlUxCRwjdwCW
         Ffi/9rrhDKnDbn696wzEFhjHzB2svO6adwv7L8SdCCGRrs82ZoDhrAvEJZcNWATdWREL
         f8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696348636; x=1696953436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=168VbodA38Hdi5eAfuNgKvUwcfZckCEtb5Hwk95lQ/Q=;
        b=ryKy5XgXUS9lvW0zsUM5a/3FwG2UfXqSmw7f+WSkoMVjcKwCabFSNoeRUoMZP4caDE
         BsxTjAiOG6wDL1KQ39bUCsUXm7OlpKJQpCn0hxkrGMCiloUjLGA+bGxDPlQ4+hATmedn
         XhcxXP9q4Ty0qlUFhxlLwv7MEp9UsIAn4ntd7SwXEOUHRywcUDoZnIjE/0uSZSDUIi6T
         KbeM7y/ZD5wVfNZwA4Pcr50MzVs1yOshprFxQd4H4cvDhqJcnAQ7wOYqxK1123V4p/73
         siSLVYrBg9wtSa8bBYdRSxyA0Ga5bb5CN8z7FA22flI3hnyUr3OjSUHVTpFWNcBN+YVb
         AFNQ==
X-Gm-Message-State: AOJu0YwI4bNu9pxPlWXMy7HSykt5QWgTZBx8UbKGgVik1xi2FifbEYPv
	/0z0iD/3QeMXU7NnJYXKJu4GpQ==
X-Google-Smtp-Source: 
 AGHT+IFxb7p6HyTQDTwuHqjaxVz5+dsTwm+VvkHaxagLHnQgS8VYvxoMpoZBnybgXCeiPC4gYQTmqQ==
X-Received: by 2002:a17:906:51db:b0:9b2:abda:2543 with SMTP id
 v27-20020a17090651db00b009b2abda2543mr14616486ejk.65.1696348636295;
        Tue, 03 Oct 2023 08:57:16 -0700 (PDT)
Received: from krzk-bin.. (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id
 w25-20020a170906481900b0099bc2d1429csm1288088ejq.72.2023.10.03.08.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 08:57:15 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ASoC: soc-dapm: Add helper for comparing widget name
Date: Tue,  3 Oct 2023 17:57:09 +0200
Message-Id: <20231003155710.821315-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003155710.821315-1-krzysztof.kozlowski@linaro.org>
References: <20231003155710.821315-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: YQFU3PYGQYRZVYFYEXDAITTQ25AEVVQS
X-Message-ID-Hash: YQFU3PYGQYRZVYFYEXDAITTQ25AEVVQS
X-MailFrom: krzysztof.kozlowski@linaro.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YQFU3PYGQYRZVYFYEXDAITTQ25AEVVQS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Some drivers use one event callback for multiple widgets but still need
to perform a bit different actions based on actual widget.  This is done
by comparing widget name, however drivers tend to miss possible name
prefix.  Add a helper to solve common mistakes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/sound/soc-dapm.h  |  1 +
 sound/soc/soc-component.c |  1 +
 sound/soc/soc-dapm.c      | 12 ++++++++++++
 3 files changed, 14 insertions(+)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index d2faec9a323e..433543eb82b9 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -469,6 +469,7 @@ void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card);
 
 int snd_soc_dapm_update_dai(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params, struct snd_soc_dai *dai);
+int snd_soc_dapm_widget_name_cmp(struct snd_soc_dapm_widget *widget, const char *s);
 
 /* dapm path setup */
 int snd_soc_dapm_new_widgets(struct snd_soc_card *card);
diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
index 69198de39e79..4d7c2e3c929a 100644
--- a/sound/soc/soc-component.c
+++ b/sound/soc/soc-component.c
@@ -242,6 +242,7 @@ int snd_soc_component_notify_control(struct snd_soc_component *component,
 	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 	struct snd_kcontrol *kctl;
 
+	/* When updating, change also snd_soc_dapm_widget_name_cmp() */
 	if (component->name_prefix)
 		snprintf(name, ARRAY_SIZE(name), "%s %s", component->name_prefix, ctl);
 	else
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 2512aadf95f7..8f22ce857f4a 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2728,6 +2728,18 @@ int snd_soc_dapm_update_dai(struct snd_pcm_substream *substream,
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_update_dai);
 
+int snd_soc_dapm_widget_name_cmp(struct snd_soc_dapm_widget *widget, const char *s)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(widget->dapm);
+	const char *wname = widget->name;
+
+	if (component->name_prefix)
+		wname += strlen(component->name_prefix) + 1; /* plus space */
+
+	return strcmp(wname, s);
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_widget_name_cmp);
+
 /*
  * dapm_update_widget_flags() - Re-compute widget sink and source flags
  * @w: The widget for which to update the flags
-- 
2.34.1

