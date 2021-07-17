Return-Path: <SRS0=ec3H=MJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FF5C636CA
	for <alsa-devel@archiver.kernel.org>; Sat, 17 Jul 2021 12:27:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87E5161289
	for <alsa-devel@archiver.kernel.org>; Sat, 17 Jul 2021 12:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E5161289
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EAAB51681;
	Sat, 17 Jul 2021 14:26:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EAAB51681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626524864;
	bh=lrout3w6B3D8kkJCNcPHKviGewLxMfJYTlKzItlutQ8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cPrhDjDa+3IxWZcgCLBWPXGFVq2WSOfEVIsgpAJaDsvKRSjmkhtxoEjTxoUeXFDC+
	 wMEnLYAR45WOONa+GK00YyArzm4frgINpNi/MIHT4/nB48uKid1sJ/XhcM5u7XUnpj
	 nryF9B1A8Sy48kfHMMUfk2JCiIGj7HWZOfV+jSKs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 93A31F80424;
	Sat, 17 Jul 2021 14:26:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 58F6DF80430; Sat, 17 Jul 2021 14:26:00 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BC8B2F80424
 for <alsa-devel@alsa-project.org>; Sat, 17 Jul 2021 14:25:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BC8B2F80424
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="e8zjZKrs"
Received: by mail-lf1-x12e.google.com with SMTP id g8so14813258lfh.8
 for <alsa-devel@alsa-project.org>; Sat, 17 Jul 2021 05:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dMgjmY3ReK3160sNRXMEVTnwL+1V9IrtsL0ZPeSMSZc=;
 b=e8zjZKrs73RqN7mZeHJnkg/8dyDHeQZFEYGqrfTildSHRgMd46L5Fuv9YNXsv/Lppf
 lyfdPvNQDwVR2SSHU874JLPJSU+2krlaEpqJH83Es4bRk+LC7zBq9vlGbQcvC9Y9t6DE
 k5eExnrQrrQ7I3Vwz5Wm7sh+N7je13cRcjU2FOThi8FMoBjeklyQ8fAeIhM07fTTCBF8
 ZUKfcB37RYn7uKlscCRfd5QOE9HPHIutglEwRKA91LHsaORFMoNXfXPDvauNiAbi/uPL
 bkdxXnVb00ka7xso05HOKLFyGDgZqPM4zZbtfUWy3HjUfnun8ZMz59VJBOiWCFBXjl5D
 nF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dMgjmY3ReK3160sNRXMEVTnwL+1V9IrtsL0ZPeSMSZc=;
 b=HfP65IwNyD4zgtzWTHg+M/OTjKiicikdUglZ6DkOAKiFDSEWFEJJgpuY0NEmFJHIzR
 vvOREo1+2DolzgjXXZccEcIhjMyTFNhsy5+I/+72+ZEQ37l3vEl8ME26WQqiaKIocvoL
 VW3paHwBJ+IU8ELnqiNJHEV6RAsVKtE/rBW6S46ctyEG200su4npWfGsNy+oIs9TRlzM
 gHo1mVtrQTZCrfVKcT40XdtDVedzmucZAFtMwlJCXvICeNJMzWieSdCfsWja1laBV+EN
 L4+42ZvQG15/R8/9S+wrdDSMXhwJHa8pxBnRMpvon0PSpeX2NowFYJiAnUJjJaPnRbQI
 p1bg==
X-Gm-Message-State: AOAM532Tk8eDHDJM/lDgLK0TZcWTUZAf0HJ2f1Gas1jGORl4ZzbASO6a
 B286cCJgcetYuOkzcOz39xk=
X-Google-Smtp-Source: ABdhPJzNnnZ/ciZloNmFqhSnnXgxZ+/dcyirVsRMSt9stS8VSGTsfwwBvV+qyXoMcFYo8BCJa6TVSw==
X-Received: by 2002:a19:c191:: with SMTP id
 r139mr11535231lff.515.1626524755702; 
 Sat, 17 Jul 2021 05:25:55 -0700 (PDT)
Received: from localhost.localdomain (91-155-111-71.elisa-laajakaista.fi.
 [91.155.111.71])
 by smtp.gmail.com with ESMTPSA id v4sm860087lfi.118.2021.07.17.05.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jul 2021 05:25:55 -0700 (PDT)
From: Peter Ujfalusi <peter.ujfalusi@gmail.com>
To: broonie@kernel.org
Subject: [PATCH 3/3] ASoC: ti: j721e-evm: Convert the audio domain IDs to enum
Date: Sat, 17 Jul 2021 15:28:20 +0300
Message-Id: <20210717122820.1467-4-peter.ujfalusi@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210717122820.1467-1-peter.ujfalusi@gmail.com>
References: <20210717122820.1467-1-peter.ujfalusi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
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

Convert the J721E_AUDIO_DOMAIN_* from defines to enum to make it possible
to extend the number of domains in the future.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
---
 sound/soc/ti/j721e-evm.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/sound/soc/ti/j721e-evm.c b/sound/soc/ti/j721e-evm.c
index 265bbc5a2f96..9347f982c3e1 100644
--- a/sound/soc/ti/j721e-evm.c
+++ b/sound/soc/ti/j721e-evm.c
@@ -23,8 +23,11 @@
  */
 #define J721E_CODEC_CONF_COUNT	5
 
-#define J721E_AUDIO_DOMAIN_CPB	0
-#define J721E_AUDIO_DOMAIN_IVI	1
+enum j721e_audio_domain_id {
+	J721E_AUDIO_DOMAIN_CPB = 0,
+	J721E_AUDIO_DOMAIN_IVI,
+	J721E_AUDIO_DOMAIN_LAST,
+};
 
 #define J721E_CLK_PARENT_48000	0
 #define J721E_CLK_PARENT_44100	1
@@ -78,7 +81,7 @@ struct j721e_priv {
 	u32 pll_rates[2];
 	unsigned int hsdiv_rates[2];
 
-	struct j721e_audio_domain audio_domains[2];
+	struct j721e_audio_domain audio_domains[J721E_AUDIO_DOMAIN_LAST];
 
 	struct mutex mutex;
 };
@@ -199,9 +202,8 @@ static int j721e_configure_refclk(struct j721e_priv *priv,
 
 	if (domain->parent_clk_id == -1 || priv->hsdiv_rates[domain->parent_clk_id] != scki) {
 		dev_dbg(priv->dev,
-			"%s configuration for %u Hz: %s, %dxFS (SCKI: %u Hz)\n",
-			audio_domain == J721E_AUDIO_DOMAIN_CPB ? "CPB" : "IVI",
-			rate,
+			"domain%u configuration for %u Hz: %s, %dxFS (SCKI: %u Hz)\n",
+			audio_domain, rate,
 			clk_id == J721E_CLK_PARENT_48000 ? "PLL4" : "PLL15",
 			ratios_for_pcm3168a[i], scki);
 
@@ -263,10 +265,11 @@ static int j721e_audio_startup(struct snd_pcm_substream *substream)
 
 	domain->active++;
 
-	if (priv->audio_domains[J721E_AUDIO_DOMAIN_CPB].rate)
-		active_rate = priv->audio_domains[J721E_AUDIO_DOMAIN_CPB].rate;
-	else
-		active_rate = priv->audio_domains[J721E_AUDIO_DOMAIN_IVI].rate;
+	for (i = 0; i < J721E_AUDIO_DOMAIN_LAST; i++) {
+		active_rate = priv->audio_domains[i].rate;
+		if (active_rate)
+			break;
+	}
 
 	if (active_rate)
 		ret = snd_pcm_hw_constraint_single(substream->runtime,
@@ -825,7 +828,7 @@ static int j721e_soc_probe(struct platform_device *pdev)
 	struct snd_soc_card *card;
 	const struct of_device_id *match;
 	struct j721e_priv *priv;
-	int link_cnt, conf_cnt, ret;
+	int link_cnt, conf_cnt, ret, i;
 
 	if (!node) {
 		dev_err(&pdev->dev, "of node is missing.\n");
@@ -849,8 +852,9 @@ static int j721e_soc_probe(struct platform_device *pdev)
 	if (!priv->dai_links)
 		return -ENOMEM;
 
-	priv->audio_domains[J721E_AUDIO_DOMAIN_CPB].parent_clk_id = -1;
-	priv->audio_domains[J721E_AUDIO_DOMAIN_IVI].parent_clk_id = -1;
+	for (i = 0; i < J721E_AUDIO_DOMAIN_LAST; i++)
+		priv->audio_domains[i].parent_clk_id = -1;
+
 	priv->dev = &pdev->dev;
 	card = &priv->card;
 	card->dev = &pdev->dev;
-- 
2.32.0

