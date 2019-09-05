Return-Path: <SRS0=PVpb=XA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6AEC3A5A5
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Sep 2019 12:05:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B8C122DD3
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Sep 2019 12:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sGZ8oz2V";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HGlhMhBa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B8C122DD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 25F721678;
	Thu,  5 Sep 2019 14:04:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 25F721678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567685129;
	bh=Ih+3Cgd8RJEdUB+EIW6BjAxBg1TZFTd1tWB9KB97k3s=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sGZ8oz2VHuFuCXqH+HWuZq32fgwIapYhL57/e5B880fFND53crg8XX4NnuNaOa06H
	 48leT0KSax6oJy+SVC2sFZ63l2WqV1StKS+ug5JieaBbfJpDjo8NM+9K41Tj1+aiNr
	 dh3wME/dQC8qW+67Yn0jWVw6PWuWyf1iBfd2gLoU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 434BBF80633;
	Thu,  5 Sep 2019 14:01:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9C717F805FE; Thu,  5 Sep 2019 14:01:44 +0200 (CEST)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B80FFF805F5
 for <alsa-devel@alsa-project.org>; Thu,  5 Sep 2019 14:01:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B80FFF805F5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="HGlhMhBa"
Received: by mail-wm1-x344.google.com with SMTP id q12so2667344wmj.4
 for <alsa-devel@alsa-project.org>; Thu, 05 Sep 2019 05:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ty6grr2CqBsGiLMZEwUvr96EbkiXeHRzoxeQk67yQIk=;
 b=HGlhMhBacIfIQFKMtkZsKhGnnBNTeG4ikwn1/HkS3Ajg2L6g78ZlyF8lhw6v6UbzqC
 RtheK/89P1pt+0pH3mLz0BKwndFqR0VToA+SyMftxNAqlO5g3ysFe6UUsS2JJDa7TT0U
 02CpO0DjOm++hE8RswmYQ3dodOc6Vswu1Lyc5dY3dZlIlH18GXxfWTT3KMzh9iQAWhlL
 WrS4sMc5IqyT4baQ7udu5pYuIYVQ4eEYuu9FqAY2fEYIlhrVJZtNVTp3tFb7ayqaXIa+
 OE9ydQzsc/jQsFWNkwiSwnL8ddqCQvM+elHpmcSgrwbFjqxrtrmpgu+FvSRv7h8YzKQW
 bP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ty6grr2CqBsGiLMZEwUvr96EbkiXeHRzoxeQk67yQIk=;
 b=R33ZnWqeMIx+BaHTJko6fjxwshBvgZFA7e9h6CMaSZgib43O+JzQim3u6D7eYAgVud
 xPc3A31+sDaxvz0DNoeuqmD9dWU/9/eDF3+3n6P0o+dXF2ty8BZilOdBoKW98tw+zana
 jpuooscwOWB3CwJOaUykRNeDXPTVjTzZsdy7XPzvnd0BthxkxvE7bNmJYGDaXDFWUtm5
 ryCAP4V2Mj8hLKOihjXo1kQmkqWIY6XGOQw3nNj60tbyPbkgfh2+TM/dhpNjQ1nloh6E
 ckMWkbP/swIvb+OOj4zz0OKQ0eNuIrNjdk+vXNfxhtsdYSFxpLCgXERXjpYeq76UBqTJ
 bNFQ==
X-Gm-Message-State: APjAAAWSbpAcdMJsrh/BMffCZ4ICLhwcHe+GPk+VdJwuN1vLv3uXw1Ik
 yWL2uOiYa0Effh0L6G3VuTpKdQ==
X-Google-Smtp-Source: APXvYqyQ2uMB+QE10XeT5YDdU0Y7KVgM/kfMVR7Ux0OrquB6l45jM69QHFeZ4laRjHpp8Uaw1YQsJw==
X-Received: by 2002:a1c:1903:: with SMTP id 3mr2504214wmz.4.1567684895062;
 Thu, 05 Sep 2019 05:01:35 -0700 (PDT)
Received: from starbuck.baylibre.local
 (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.googlemail.com with ESMTPSA id a18sm3436311wrh.25.2019.09.05.05.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2019 05:01:34 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Date: Thu,  5 Sep 2019 14:01:19 +0200
Message-Id: <20190905120120.31752-8-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190905120120.31752-1-jbrunet@baylibre.com>
References: <20190905120120.31752-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Subject: [alsa-devel] [PATCH 7/8] ASoC: meson: axg-toddr: add sm1 support
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

On sm1, the maximum number TODDR inputs is extended to 16.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-toddr.c | 68 +++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/sound/soc/meson/axg-toddr.c b/sound/soc/meson/axg-toddr.c
index 2e9a2e5862ce..c8ea2145f576 100644
--- a/sound/soc/meson/axg-toddr.c
+++ b/sound/soc/meson/axg-toddr.c
@@ -25,6 +25,7 @@
 #define CTRL0_TODDR_LSB_POS_MASK	GENMASK(7, 3)
 #define CTRL0_TODDR_LSB_POS(x)		((x) << 3)
 #define CTRL1_TODDR_FORCE_FINISH	BIT(25)
+#define CTRL1_SEL_SHIFT			28
 
 #define TODDR_MSB_POS	31
 
@@ -221,6 +222,70 @@ static const struct axg_fifo_match_data g12a_toddr_match_data = {
 	.dai_drv	= &g12a_toddr_dai_drv
 };
 
+static const char * const sm1_toddr_sel_texts[] = {
+	"IN 0", "IN 1", "IN 2",  "IN 3",  "IN 4",  "IN 5",  "IN 6",  "IN 7",
+	"IN 8", "IN 9", "IN 10", "IN 11", "IN 12", "IN 13", "IN 14", "IN 15"
+};
+
+static SOC_ENUM_SINGLE_DECL(sm1_toddr_sel_enum, FIFO_CTRL1, CTRL1_SEL_SHIFT,
+			    sm1_toddr_sel_texts);
+
+static const struct snd_kcontrol_new sm1_toddr_in_mux =
+	SOC_DAPM_ENUM("Input Source", sm1_toddr_sel_enum);
+
+static const struct snd_soc_dapm_widget sm1_toddr_dapm_widgets[] = {
+	SND_SOC_DAPM_MUX("SRC SEL", SND_SOC_NOPM, 0, 0, &sm1_toddr_in_mux),
+	SND_SOC_DAPM_AIF_IN("IN 0",  NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 1",  NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 2",  NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 3",  NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 4",  NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 5",  NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 6",  NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 7",  NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 8",  NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 9",  NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 10", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 11", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 12", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 13", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 14", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 15", NULL, 0, SND_SOC_NOPM, 0, 0),
+};
+
+static const struct snd_soc_dapm_route sm1_toddr_dapm_routes[] = {
+	{ "Capture", NULL, "SRC SEL" },
+	{ "SRC SEL", "IN 0",  "IN 0" },
+	{ "SRC SEL", "IN 1",  "IN 1" },
+	{ "SRC SEL", "IN 2",  "IN 2" },
+	{ "SRC SEL", "IN 3",  "IN 3" },
+	{ "SRC SEL", "IN 4",  "IN 4" },
+	{ "SRC SEL", "IN 5",  "IN 5" },
+	{ "SRC SEL", "IN 6",  "IN 6" },
+	{ "SRC SEL", "IN 7",  "IN 7" },
+	{ "SRC SEL", "IN 8",  "IN 8" },
+	{ "SRC SEL", "IN 9",  "IN 9" },
+	{ "SRC SEL", "IN 10", "IN 10" },
+	{ "SRC SEL", "IN 11", "IN 11" },
+	{ "SRC SEL", "IN 12", "IN 12" },
+	{ "SRC SEL", "IN 13", "IN 13" },
+	{ "SRC SEL", "IN 14", "IN 14" },
+	{ "SRC SEL", "IN 15", "IN 15" },
+};
+
+static const struct snd_soc_component_driver sm1_toddr_component_drv = {
+	.dapm_widgets		= sm1_toddr_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(sm1_toddr_dapm_widgets),
+	.dapm_routes		= sm1_toddr_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(sm1_toddr_dapm_routes),
+	.ops			= &g12a_fifo_pcm_ops
+};
+
+static const struct axg_fifo_match_data sm1_toddr_match_data = {
+	.component_drv	= &sm1_toddr_component_drv,
+	.dai_drv	= &g12a_toddr_dai_drv
+};
+
 static const struct of_device_id axg_toddr_of_match[] = {
 	{
 		.compatible = "amlogic,axg-toddr",
@@ -228,6 +293,9 @@ static const struct of_device_id axg_toddr_of_match[] = {
 	}, {
 		.compatible = "amlogic,g12a-toddr",
 		.data = &g12a_toddr_match_data,
+	}, {
+		.compatible = "amlogic,sm1-toddr",
+		.data = &sm1_toddr_match_data,
 	}, {}
 };
 MODULE_DEVICE_TABLE(of, axg_toddr_of_match);
-- 
2.21.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
