Return-Path: <SRS0=mEIa=AU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E66FC433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jul 2020 12:27:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A95320708
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jul 2020 12:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VCt7SF16";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="NMUZB5T+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A95320708
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2D2E71612;
	Thu,  9 Jul 2020 14:26:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2D2E71612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594297627;
	bh=Uyzyw0ozb7UCNGvwdIF2MFoBYSiKTAt8UpfRQBEFuXk=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VCt7SF16zeVUBPg2KUK4hoVl6UoT/0KaqSIW92O+50f/wJRhmuCn2fbz6pjQbf8vr
	 nURdOMXy8+3BC9O0lYyR4S1qGp0QZUynCt/jOSJO+OtMZ1llvEwtRdiCi2XYBv00Ya
	 NdSx82R6ey2y96ArvPUYemG91rOLH9J+bPae5daE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D9CD7F802BC;
	Thu,  9 Jul 2020 14:25:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 491C5F801F9; Thu,  9 Jul 2020 14:25:09 +0200 (CEST)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B50ECF801F9
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2020 14:25:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B50ECF801F9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="NMUZB5T+"
Received: by mail-yb1-xb49.google.com with SMTP id t7so2691988ybk.2
 for <alsa-devel@alsa-project.org>; Thu, 09 Jul 2020 05:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=HmvZ1z9U4n6rR7duFi81k3VPNqIpG1EH8iqhWp8tRD0=;
 b=NMUZB5T+5+tZYKaW3KsvajVKg4SeF9Lcg4pFSz6wo8KXD3Z9kB+1WbD/vpUvM7D65v
 tUKSpikUYY8WS8t1SN/65/40WNin4EGk2FSVwT/GEIpACY102e38LJvcFxAOmd5zIQI6
 s0vw/6T/DLrcx6pwihtcIZuJCZlZdJZFrCX8Np/64a8M+alpKKsl49+lnjGE39+2Y8J4
 fxaUnls46I6jtt3A9ftMr1GPKpHo9lGVHxMJtDFSFOJBSXv4AsWnMLcuj37zflETo9FI
 UmiZ+e6ManBto71mnnmp610chzumQaN6WLVk2GScKr86iDwjqpEEeuxU9abV8HHkuzvw
 ST3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=HmvZ1z9U4n6rR7duFi81k3VPNqIpG1EH8iqhWp8tRD0=;
 b=EgdqSr/VD8MRDUPp582HMAEbTCLSCLXtOe+GcAsdaXcLlKO6gMVTLzmPJCkGQ+2b3I
 Y87/w1cB6olkwZAmfLnqo3NpUCmsAXGG3JMNxbtVKNbxQSTmb316Dj2WxhxdYvuLZOo4
 CMjiruMM1dEge3g0UwlAiDi7qSb5pK45gfYWgsI7GAyi7yzQQYI/CHYo9n0zL9KDctJN
 yHJyRrTwbpwwPWHg7ZNrRbH/Rq30llzX8za6d6/2iqUH7Iosn+2QB+q9BWqd3prtVAST
 aRWI/hIux3r5jR8dSok9D7NdFNWxAAfqflOvuTQm7yglpOOKBG61ZHobpHZ2bizcKgeM
 VRYA==
X-Gm-Message-State: AOAM532kLvmLFUTvVK97Xf9b40nAI+n6pb8zAsfWYlvSp/r59pwArEAK
 E/UiRtIgBdGFldmecutu+gkFIawahcd+
X-Google-Smtp-Source: ABdhPJw/Jmifs746HEdEzjZzKb0bIfF3JLHoGixRoD/ggWNV2NU6nJujZftNAzmWotbqocrFajPzZrK1zG5r
X-Received: by 2002:a25:2805:: with SMTP id o5mr53760242ybo.97.1594297504413; 
 Thu, 09 Jul 2020 05:25:04 -0700 (PDT)
Date: Thu,  9 Jul 2020 20:24:43 +0800
In-Reply-To: <20200709122445.1584497-1-tzungbi@google.com>
Message-Id: <20200709122445.1584497-4-tzungbi@google.com>
Mime-Version: 1.0
References: <20200709122445.1584497-1-tzungbi@google.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH 3/5] ASoC: mediatek: mt8183-da7219: extract codec and DAI names
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Cc: tzungbi@google.com, alsa-devel@alsa-project.org
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Extracts codec and DAI names of DA7219.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
index 9636771ce9a2..17c8e4ac18a9 100644
--- a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
@@ -17,6 +17,9 @@
 #include "../../codecs/da7219.h"
 #include "mt8183-afe-common.h"
 
+#define DA7219_CODEC_DAI "da7219-hifi"
+#define DA7219_DEV_NAME "da7219.5-001a"
+
 struct mt8183_da7219_max98357_priv {
 	struct snd_soc_jack headset_jack;
 };
@@ -54,8 +57,7 @@ static int mt8183_da7219_i2s_hw_params(struct snd_pcm_substream *substream,
 		dev_err(rtd->dev, "failed to set cpu dai sysclk\n");
 
 	for_each_rtd_codec_dais(rtd, j, codec_dai) {
-
-		if (!strcmp(codec_dai->component->name, "da7219.5-001a")) {
+		if (!strcmp(codec_dai->component->name, DA7219_DEV_NAME)) {
 			ret = snd_soc_dai_set_sysclk(codec_dai,
 						     DA7219_CLKSRC_MCLK,
 						     mclk_fs,
@@ -87,8 +89,7 @@ static int mt8183_da7219_hw_free(struct snd_pcm_substream *substream)
 	int ret = 0, j;
 
 	for_each_rtd_codec_dais(rtd, j, codec_dai) {
-
-		if (!strcmp(codec_dai->component->name, "da7219.5-001a")) {
+		if (!strcmp(codec_dai->component->name, DA7219_DEV_NAME)) {
 			ret = snd_soc_dai_set_pll(codec_dai,
 						  0, DA7219_SYSCLK_MCLK, 0, 0);
 			if (ret < 0) {
@@ -268,13 +269,13 @@ SND_SOC_DAILINK_DEFS(i2s1,
 
 SND_SOC_DAILINK_DEFS(i2s2,
 	DAILINK_COMP_ARRAY(COMP_CPU("I2S2")),
-	DAILINK_COMP_ARRAY(COMP_CODEC("da7219.5-001a", "da7219-hifi")),
+	DAILINK_COMP_ARRAY(COMP_CODEC(DA7219_DEV_NAME, DA7219_CODEC_DAI)),
 	DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
 SND_SOC_DAILINK_DEFS(i2s3,
 	DAILINK_COMP_ARRAY(COMP_CPU("I2S3")),
 	DAILINK_COMP_ARRAY(COMP_CODEC("max98357a", "HiFi"),
-			 COMP_CODEC("da7219.5-001a", "da7219-hifi")),
+			   COMP_CODEC(DA7219_DEV_NAME, DA7219_CODEC_DAI)),
 	DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
 SND_SOC_DAILINK_DEFS(i2s5,
-- 
2.27.0.383.g050319c2ae-goog

