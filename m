Return-Path: <SRS0=qvmA=JD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42537C433ED
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Apr 2021 14:26:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DE0B613B3
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Apr 2021 14:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DE0B613B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aksignal.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 21924852;
	Tue,  6 Apr 2021 16:25:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 21924852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617719200;
	bh=f6Kkb05Xy1ywWXaA4VDZYAUdTERpxd12TdolAcNa4cQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fImkQMI5dY6J9xaDyXtRnirqiowVwh+WbDguKP2IzZQ/+WdhQyZ+krGqvpI27t4rk
	 En8bn+e66sp+gMG7bKvuRJvl+AY+QVL+sw+kLhpprIhMFrK7QTHArxWec+eG3vEg8p
	 iV6FmYzy16m12LMs0NUqNmWBNp8uZuaQrXITAhuU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 73877F80258;
	Tue,  6 Apr 2021 16:25:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 515F2F80425; Tue,  6 Apr 2021 16:25:00 +0200 (CEST)
Received: from router.aksignal.cz (router.aksignal.cz [62.44.4.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 54372F80169
 for <alsa-devel@alsa-project.org>; Tue,  6 Apr 2021 16:24:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 54372F80169
Received: from localhost (localhost [127.0.0.1])
 by router.aksignal.cz (Postfix) with ESMTP id 368DB3FA29;
 Tue,  6 Apr 2021 16:24:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
 by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
 with LMTP id xeJpDRGo20-5; Tue,  6 Apr 2021 16:24:43 +0200 (CEST)
Received: from pc-gameroom.prchals.tk (unknown [83.240.30.185])
 (Authenticated sender: jiri.prchal@aksignal.cz)
 by router.aksignal.cz (Postfix) with ESMTPSA id 6EE8D3FA2D;
 Tue,  6 Apr 2021 16:24:43 +0200 (CEST)
From: Jiri Prchal <jiri.prchal@aksignal.cz>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/4] ASoC: codecs: tlv320aic3x: rename probe function
Date: Tue,  6 Apr 2021 16:24:37 +0200
Message-Id: <20210406142439.102396-3-jiri.prchal@aksignal.cz>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210406142439.102396-1-jiri.prchal@aksignal.cz>
References: <20210406142439.102396-1-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
 Jiri Prchal <jiri.prchal@aksignal.cz>, Liam Girdwood <lgirdwood@gmail.com>
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

Renamed function to have it free for generic probe.

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
---
 sound/soc/codecs/tlv320aic3x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 812f0f117fd3..6549ad9296ce 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1610,7 +1610,7 @@ static bool aic3x_is_shared_reset(struct aic3x_priv *aic3x)
 	return false;
 }
 
-static int aic3x_probe(struct snd_soc_component *component)
+static int aic3x_component_probe(struct snd_soc_component *component)
 {
 	struct aic3x_priv *aic3x = snd_soc_component_get_drvdata(component);
 	int ret, i;
@@ -1689,7 +1689,7 @@ static int aic3x_probe(struct snd_soc_component *component)
 
 static const struct snd_soc_component_driver soc_component_dev_aic3x = {
 	.set_bias_level		= aic3x_set_bias_level,
-	.probe			= aic3x_probe,
+	.probe			= aic3x_component_probe,
 	.controls		= aic3x_snd_controls,
 	.num_controls		= ARRAY_SIZE(aic3x_snd_controls),
 	.dapm_widgets		= aic3x_dapm_widgets,
-- 
2.25.1

