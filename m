Return-Path: <SRS0=HhIj=FF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65373C64E7A
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Dec 2020 13:24:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FF1C2084C
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Dec 2020 13:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fMGxHpV1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="APuRAvqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FF1C2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0EB0D178C;
	Tue,  1 Dec 2020 14:23:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0EB0D178C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606829051;
	bh=qoqYo6GF9T2jOKtn4cIJjlat/DQdgNLsXAPIDDPnY90=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fMGxHpV14najDgXzrj+Oqcry9NHtmFwA+nNiXPhNeLvTvSaRTLhxyFU4OoPpOMPxe
	 1G8aM5zXeVIXdIk6b6vhdQIQv7zeHefwEFoKHZu4salUmuxO3a3apwhQLeDJmzwDaS
	 6A/3DqdsgFvL53HfvhL+SUWvb5PDHMyc6ihLUJXY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BC9ABF804C2;
	Tue,  1 Dec 2020 14:21:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EA4F2F804CC; Tue,  1 Dec 2020 14:21:55 +0100 (CET)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 51F87F804B2
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2020 14:21:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 51F87F804B2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="APuRAvqt"
Received: by mail-yb1-xb49.google.com with SMTP id w8so2375257ybq.4
 for <alsa-devel@alsa-project.org>; Tue, 01 Dec 2020 05:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=Y0+xH3UGiixm7l2bnHVG2So+xIAjdFpqflSxFA1Eik0=;
 b=APuRAvqtuiSERCQyVPcccB+bxOGCx5A0FyNSEV3jrf3j19TflrFqJlg/3vy1iKi4L8
 5+cHnjxtW4A57QcuwZPgLIEZA7lhaaQZ4+WU+GMQIIRm8znhMq56R2VkEclkmK5p7ry1
 Jf8hfEbqMsXwmPp4wIOnRFMCJ0tBC4FT5KXzvBVSHGlAKZxaKaRm0MO/cv7NHxuyLw/i
 F7tQS23y1MWfC8jO949t6sTi5QcrpEtVBtjl5HSPktymqPn/wNjp+05EtMphWI4zHg0N
 ZatxlLso6HNKk49ZrkMnLjdVKZCW4jTtupEmSZOmy/3YZTh0olZWeP4cm1jiM5fl2Zqc
 40pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=Y0+xH3UGiixm7l2bnHVG2So+xIAjdFpqflSxFA1Eik0=;
 b=QG/I3sLcpywFGoVFg1TJGKpfqIba5qnxlkdYFG2V7hfnci5UXx6TppqwF2061MA4Cv
 5gDqVZ3isYVBsQlzUuo5IIjCrwKvuQ7DviYPkbe8w2+hcx/sT0W09amr9/+9psSHtjWa
 gSxa/0hrRiomWmR5LEQNRQKA0TxASIqfqlUIq74KT0TnZfbthMjqZnZEq7rQuctE1n1s
 cCLWmR65QhXHbIqCKp6WSH2YRDUdwQ90v5NPBMEiPKGCoSnTwnAp5ZEU6+Ai3euVY8ju
 1T8GFHq+/J+darbbA0totjb4vrnT4Zk6W6xRs9kKo8za1PqLuY6x3yU0F0cBhmD8B2Ee
 XViw==
X-Gm-Message-State: AOAM532o0ToWQBer3OIOf2DdYC5hItdgFJ2mjQVbm7QQOUR8lJWgK9Dz
 FTfdjm/g6qa9u/TRDsJm1sc+gxeE0XXJ
X-Google-Smtp-Source: ABdhPJw+uhY31tURIc5osY3W//1BfP30OlaPMBzGesuEqYcTQ7v7Mvy836XZyCA4EpOmz8dx4BMiREmV3HyS
X-Received: from tzungbi-z840.tpe.corp.google.com
 ([2401:fa00:1:b:725a:fff:fe41:c6a5])
 (user=tzungbi job=sendgmr) by 2002:a25:1b45:: with SMTP id
 b66mr2917469ybb.331.1606828908023; Tue, 01 Dec 2020 05:21:48 -0800 (PST)
Date: Tue,  1 Dec 2020 21:21:23 +0800
In-Reply-To: <20201201132126.1676005-1-tzungbi@google.com>
Message-Id: <20201201132126.1676005-4-tzungbi@google.com>
Mime-Version: 1.0
References: <20201201132126.1676005-1-tzungbi@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH 3/6] ASoC: mediatek: mt8192: move rt1015_rt5682 specific data
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

Moves rt1015_rt5682 specific data right before the snd_soc_card
definition for neat purpose.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 .../mt8192/mt8192-mt6359-rt1015-rt5682.c      | 50 +++++++++----------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
index e841fd32e8cc..0d2cc6800f08 100644
--- a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
+++ b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
@@ -33,31 +33,6 @@
 
 static struct snd_soc_jack headset_jack;
 
-static const struct snd_soc_dapm_widget
-mt8192_mt6359_rt1015_rt5682_widgets[] = {
-	SND_SOC_DAPM_SPK("Left Spk", NULL),
-	SND_SOC_DAPM_SPK("Right Spk", NULL),
-	SND_SOC_DAPM_HP("Headphone Jack", NULL),
-	SND_SOC_DAPM_MIC("Headset Mic", NULL),
-};
-
-static const struct snd_soc_dapm_route mt8192_mt6359_rt1015_rt5682_routes[] = {
-	/* speaker */
-	{ "Left Spk", NULL, "Left SPO" },
-	{ "Right Spk", NULL, "Right SPO" },
-	/* headset */
-	{ "Headphone Jack", NULL, "HPOL" },
-	{ "Headphone Jack", NULL, "HPOR" },
-	{ "IN1P", NULL, "Headset Mic" },
-};
-
-static const struct snd_kcontrol_new mt8192_mt6359_rt1015_rt5682_controls[] = {
-	SOC_DAPM_PIN_SWITCH("Left Spk"),
-	SOC_DAPM_PIN_SWITCH("Right Spk"),
-	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
-	SOC_DAPM_PIN_SWITCH("Headset Mic"),
-};
-
 static int mt8192_rt1015_i2s_hw_params(struct snd_pcm_substream *substream,
 				       struct snd_pcm_hw_params *params)
 {
@@ -971,6 +946,31 @@ static struct snd_soc_dai_link mt8192_mt6359_dai_links[] = {
 	},
 };
 
+static const struct snd_soc_dapm_widget
+mt8192_mt6359_rt1015_rt5682_widgets[] = {
+	SND_SOC_DAPM_SPK("Left Spk", NULL),
+	SND_SOC_DAPM_SPK("Right Spk", NULL),
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+};
+
+static const struct snd_soc_dapm_route mt8192_mt6359_rt1015_rt5682_routes[] = {
+	/* speaker */
+	{ "Left Spk", NULL, "Left SPO" },
+	{ "Right Spk", NULL, "Right SPO" },
+	/* headset */
+	{ "Headphone Jack", NULL, "HPOL" },
+	{ "Headphone Jack", NULL, "HPOR" },
+	{ "IN1P", NULL, "Headset Mic" },
+};
+
+static const struct snd_kcontrol_new mt8192_mt6359_rt1015_rt5682_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Left Spk"),
+	SOC_DAPM_PIN_SWITCH("Right Spk"),
+	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+};
+
 static struct snd_soc_codec_conf rt1015_amp_conf[] = {
 	{
 		.dlc = COMP_CODEC_CONF(RT1015_DEV0_NAME),
-- 
2.29.2.454.gaff20da3a2-goog

