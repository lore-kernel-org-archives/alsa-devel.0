Return-Path: <SRS0=CfAr=OT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C3AC433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Sep 2021 09:45:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E2F7613A9
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Sep 2021 09:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4E2F7613A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 38FCA168B;
	Wed, 29 Sep 2021 11:44:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 38FCA168B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632908705;
	bh=vrl4WgKSD3fzQo7LCQpXJMqFVxkK8LGkUruwN2K8s+w=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rn7943Opf0kQwDityx4hUG5yzQy6zpL2w9tCGGJhofph/nDSlpqs8HnVM1LprlhO4
	 4WtSFeHOqFDASSSb/HZ0BdJ+If/oekUXF7z/jcaSjkqbOQsTSwZBq+eOYmAGL8g5Yt
	 7pADN93usG9YpJFVUwTx3LsRERc/anH8x28Vjkc8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9EEB5F80105;
	Wed, 29 Sep 2021 11:44:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 76F07F80227; Wed, 29 Sep 2021 11:44:12 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AA07BF80105
 for <alsa-devel@alsa-project.org>; Wed, 29 Sep 2021 11:44:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AA07BF80105
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="hxWleLzb"
Received: by mail-lf1-x12e.google.com with SMTP id z24so8066738lfu.13
 for <alsa-devel@alsa-project.org>; Wed, 29 Sep 2021 02:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZX5/OLXbcKow/MyLmIvfS7K1Bp5NfiQXOfcHQ+IUkf0=;
 b=hxWleLzbstchpsvQKiG23E8pOaFLMrgrgAAM+Mx+w60M3/i7w1TFE97NBgTs6G+P35
 sTNj4o7HadmWK4hGZwRd27PpdqTBCoPD1cX5Fb3lq85MAZm3PKZu24VrMnHQ4K/jPffM
 yGoOJyLXwvBo8DLZDHNXY0AyzFxgQJeJ7QrOn/DMTu6qGJy7yBda0GAD7A9NLGq+/+Uo
 kxOj4WO6hV8Uh8IzDsM6dIKS6wsTZEy67GHe9e3mPDeLhIw8Udx30Cl42r9f6y+96haJ
 71PoLatMx+pwU8ayBceLAigDl82bIFJPvoR4fQBqhzOO3pjfoX/WxEzZyHli/IDbHYFs
 fFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZX5/OLXbcKow/MyLmIvfS7K1Bp5NfiQXOfcHQ+IUkf0=;
 b=e75HFVaMG7M84tr1YdUyf2v9klxza7BHpptrekc3ds6l5kVCbi273Aw68V5oiFogNT
 M+gMacU77NS036CJOZA8lGLko4ViQcI/pjBd8raUNT91U4wqgJnEor3RBGEyrFYHg/xE
 mAbacDdC4dTg/HSJPOnGV8zGul5oytbizU5t0UV/mdyhID35rbPA3Bff1ytPo1GSEPNF
 9Av8UY2Q85aTvn7unbqq4hPJKZvOp0E8taXMjhJ2xLXGif7u1TAcYpPE8hj8VboLN5sm
 1nx0LD/Wb0/1ow0/wk8DPzRjtJ7Iy/HiMPkIP4bMvL2Zwdj1v5PxE8plq1Wjfxi29DDy
 M2ww==
X-Gm-Message-State: AOAM532gwR6vpjLZ6dc+7Yite4U+XFebgTKRSLwfvoWgF8OTTk3xeMfD
 TZWoAgxivks9VbIBrTD0vhc=
X-Google-Smtp-Source: ABdhPJypimcvGnek+f7kxlDrVFGvtrmISlMN2SmorT7qYa4RlYGeBFFPVI61M5gwhAQCGLDHtWVpTw==
X-Received: by 2002:a05:651c:170e:: with SMTP id
 be14mr4769283ljb.487.1632908646586; 
 Wed, 29 Sep 2021 02:44:06 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se.
 [98.128.228.193])
 by smtp.gmail.com with ESMTPSA id n7sm182717lft.309.2021.09.29.02.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Sep 2021 02:44:05 -0700 (PDT)
From: Rikard Falkeborn <rikard.falkeborn@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: ux500: mop500: Constify static snd_soc_ops
Date: Wed, 29 Sep 2021 11:44:01 +0200
Message-Id: <20210929094401.28086-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Rikard Falkeborn <rikard.falkeborn@gmail.com>, Takashi Iwai <tiwai@suse.com>
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

The struct mop500_ab8500_ops is only assigned to the ops field in the
snd_soc_dai_link struct which is a pointer to const struct snd_soc_ops.
Make it const to allow the compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 sound/soc/ux500/mop500_ab8500.c | 2 +-
 sound/soc/ux500/mop500_ab8500.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ux500/mop500_ab8500.c b/sound/soc/ux500/mop500_ab8500.c
index 2c39c7a2fd7d..3e654e708f78 100644
--- a/sound/soc/ux500/mop500_ab8500.c
+++ b/sound/soc/ux500/mop500_ab8500.c
@@ -348,7 +348,7 @@ static int mop500_ab8500_hw_free(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-struct snd_soc_ops mop500_ab8500_ops[] = {
+const struct snd_soc_ops mop500_ab8500_ops[] = {
 	{
 		.hw_params = mop500_ab8500_hw_params,
 		.hw_free = mop500_ab8500_hw_free,
diff --git a/sound/soc/ux500/mop500_ab8500.h b/sound/soc/ux500/mop500_ab8500.h
index 8138a4e9aaf5..087ef246d87d 100644
--- a/sound/soc/ux500/mop500_ab8500.h
+++ b/sound/soc/ux500/mop500_ab8500.h
@@ -11,7 +11,7 @@
 #ifndef MOP500_AB8500_H
 #define MOP500_AB8500_H
 
-extern struct snd_soc_ops mop500_ab8500_ops[];
+extern const struct snd_soc_ops mop500_ab8500_ops[];
 
 int mop500_ab8500_machine_init(struct snd_soc_pcm_runtime *rtd);
 void mop500_ab8500_remove(struct snd_soc_card *card);
-- 
2.33.0

