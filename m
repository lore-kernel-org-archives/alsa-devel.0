Return-Path: <SRS0=81m9=GZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	TVD_SPACE_RATIO,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D306BC433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Jan 2021 10:09:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCE61235E4
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Jan 2021 10:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE61235E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 30FE01ADF;
	Fri, 22 Jan 2021 11:08:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 30FE01ADF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611310184;
	bh=JobWVsImbx/HeNrz380pUlxc9lbAmVEgSclfNk4Flec=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IC8v5kSo0iQnj/K5Dvt5SULay7fbBMP7AIlbaxbtDCCxLNqk4VlrwFyp3xwlWpa4W
	 eeircREvu5mfPOwOezsLdVG1u+eGiLO+0dmP0p4mv87X2iatEvh525/uBDh1yMhY2k
	 gqnLznQoAMOcqPeZpLzyx97qDnxBUxa2+E4jWHjs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DEFBCF8019B;
	Fri, 22 Jan 2021 11:08:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9A6CDF8019B; Fri, 22 Jan 2021 11:08:03 +0100 (CET)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com
 [IPv6:2607:f8b0:4864:20::64a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7D2F0F80166
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2021 11:07:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7D2F0F80166
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="CAKTvPaK"
Received: by mail-pl1-x64a.google.com with SMTP id c5so2817749plr.4
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2021 02:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=lqV301/f4HwfH+PWft19AnXErmDhDNoZA8wK7+4bESc=;
 b=CAKTvPaKGPHx6JA99/PRgf/mZEk5M4yQS/Bx/RZhlLLB3pAqXeHq2CADMLem+Oiaeu
 pqnVU1L6komSngDhQGZ1pKCbDEbFCcwUhNuAM50mo5jvXXkU2OuioCyJyXQrytcDSrAR
 PHbYdXd61CRRWCg2DrLfec6oqpFi3Vkm3LMNtb55CVkrAhp021lhXmOQ9Wy1RGbN1YWE
 t45lGgswT2jDM6X96h1SSWMDViGiHYDaXbrym0k6/W6zuiIbTfa3U0722yuTT8k3Osmv
 kzxofyausxkJL+XAjTRLhDks1Lxe4Y8EW/58+yHe872EVzBrhsZpcJvE7Tu8UXLf+dlq
 IJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=lqV301/f4HwfH+PWft19AnXErmDhDNoZA8wK7+4bESc=;
 b=ezk6ScKBwx8gEGi7VC+YegiiW9S7IdMb0Pn5YtCPwSELd7uFPjVtoC5yptUA9ZQ+xy
 +9mRqgn9ij22AUC1l4/kjn9/m534DnqZov8DNfmDcjkbahugEVVKaF8grXU7cWnEDVtB
 PnprFharynP60SYYqhe0y3h3CaROv7thMN24e/mVqx7EAprILupFPuZAKeK5mvlUt+ae
 6E/boDl+AotGa19v9+qnE2xUYhbJRAMQotLnKRxJe88gWaygD1tkGOSSg+ogfck5P7aM
 HRvhdTaFFpYz/NIanbW1crGgi00wfaoJ6VUGFQ2i20uyWjHcdUkLhND8jIw4lUV1b0Om
 4f0g==
X-Gm-Message-State: AOAM5305zqN5bA8hiGp7xWfxX39/+t3coh+sXZu/n+xM7RaO3lEWdXGF
 ilcB8k16ml2QIDknEh9JXdSXkMm0PS6u
X-Google-Smtp-Source: ABdhPJwCzaO7gucZTlP+cSjbZjTzkI764wa7qqapxJPVLKtZQc0tHf9zazmJwuFXOvmKXlVI9/2QP7WhBWHK
X-Received: from tzungbi-z840.tpe.corp.google.com
 ([2401:fa00:1:b:4552:5bc1:d50a:b3ff])
 (user=tzungbi job=sendgmr) by 2002:a17:903:230f:b029:dc:9b7f:bd0e with SMTP
 id d15-20020a170903230fb02900dc9b7fbd0emr3717278plh.47.1611310074804; Fri, 22
 Jan 2021 02:07:54 -0800 (PST)
Date: Fri, 22 Jan 2021 18:07:39 +0800
In-Reply-To: <20210122100742.3699128-1-tzungbi@google.com>
Message-Id: <20210122100742.3699128-2-tzungbi@google.com>
Mime-Version: 1.0
References: <20210122100742.3699128-1-tzungbi@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH 1/4] ASoC: mediatek: mt8192-mt6359: use asoc_substream_to_rtd()
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

Uses asoc_substream_to_rtd() helper.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
index cc0fc72305d2..f5c1c10408c9 100644
--- a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
+++ b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
@@ -39,7 +39,7 @@ struct mt8192_mt6359_priv {
 static int mt8192_rt1015_i2s_hw_params(struct snd_pcm_substream *substream,
 				       struct snd_pcm_hw_params *params)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct snd_soc_card *card = rtd->card;
 	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
 	struct snd_soc_dai *codec_dai;
@@ -74,7 +74,7 @@ static int mt8192_rt1015_i2s_hw_params(struct snd_pcm_substream *substream,
 static int mt8192_rt5682_i2s_hw_params(struct snd_pcm_substream *substream,
 				       struct snd_pcm_hw_params *params)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct snd_soc_card *card = rtd->card;
 	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
 	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
@@ -362,7 +362,7 @@ static int mt8192_i2s_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 static int
 mt8192_mt6359_rt1015_rt5682_cap1_startup(struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct snd_soc_component *component =
 		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
 	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
-- 
2.30.0.280.ga3ce27912f-goog

