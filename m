Return-Path: <SRS0=vuHx=ZK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A0DC432C0
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Nov 2019 07:37:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B77B20730
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Nov 2019 07:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RwyKP3iS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lasfj/iU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B77B20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E462C167B;
	Mon, 18 Nov 2019 08:36:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E462C167B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574062668;
	bh=mD4/1ARAR2BZ7Z+obgXdv4ZDvB9qz+2IeEOag148KJY=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RwyKP3iSHQ4BEq6azO30gTtesgdryDGdq5TeRNQPoFV0MOi8czZAsJxODU2vrs8cn
	 sAa6oxqhKRluh6EN5IgPk1kXu7TD0C8gBezhc3OGHD/Hau6FCgAdu5hg3DbxdI8Gug
	 X4QlFoON8rPrzVE/mO6FaDMeDkqfJani5aezENxU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 523FDF8011A;
	Mon, 18 Nov 2019 08:36:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 758EBF8013B; Mon, 18 Nov 2019 08:36:55 +0100 (CET)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 489A9F800E6
 for <alsa-devel@alsa-project.org>; Mon, 18 Nov 2019 08:36:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 489A9F800E6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="lasfj/iU"
Received: by mail-pl1-x644.google.com with SMTP id e3so9294897plt.7
 for <alsa-devel@alsa-project.org>; Sun, 17 Nov 2019 23:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=O2pEQ/gFrO9sbquSpD0RUFiXEZPVde4Gd/3NvXvj/F8=;
 b=lasfj/iUysHaMF/qDePjau4redMEkpAtBhX7DCWwsRWWjoMjocxy53+NEzYlRx6r+F
 eqQDOy6M4w/kJNlBDir5GV7B2JaigQk7H0QKVPSK7M2gIomrHOwulfnCqztEEL6G/k+F
 T7zpBu/Uw/7zNWTTExlJ4dC0NjILJUqniavbTldNu4ppTZ3oaPyO3RS7l5Y89icjrMnZ
 /4WyzvHplHa/ygdLd2SvixPvFo1NgnVt+pk/A2J6R40uU80Zbbce2AecXSatp6LWc5c9
 IGSnhiCXSLSiMCZlQN4f6XKPDoRRUE6jCcsxilTW/Fdw8qB5t66bpprKEK5tvlf3mB+U
 L/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=O2pEQ/gFrO9sbquSpD0RUFiXEZPVde4Gd/3NvXvj/F8=;
 b=RmIWXIktbIXFVtnlQjp70Ta38eQL5eAEFVxJxA3tOfBS/zZGEtkXgILVzMMT9AmyBD
 f07A7J5pwETDgysJz3PSHdoK1vGlFn4FEPVEzzo7qO9LHl1dO01GSzMgXFhSfeKOpmVK
 n5mj4Hadeu4ae0IpanSPDG0lqvvf8ITGzvUOMDMPrP+JCni28fgluW1v5rPne1qsLF08
 ogOW0Dxyfo6u1OjbfGVgj6h7m94mrDd7X89TlITG5tgOlCUaJm4vizzV3LhlsFFcgsgd
 R7kEEeSMFtU/JvrZUkhRtC3cBNaHIJBhYeIE4HqYw6Z+a1m0fb4k8wzoNLHMg1CaVs+S
 5GXQ==
X-Gm-Message-State: APjAAAXwrK6jx2pQWYBSjqiEHBgF4Ww0Q4VdUm6TKqw9qqCrC+Ab/I0L
 2ALQxWvqR6KFTEhMBN7kuo0=
X-Google-Smtp-Source: APXvYqzTxqKx8I3LrGzO+aP1mTgFtsOpNih9t3u1AhFiqfSjAM2j1hpXKU8cxdopEtymDDo+1JkzHA==
X-Received: by 2002:a17:90a:2470:: with SMTP id
 h103mr39127468pje.12.1574062609419; 
 Sun, 17 Nov 2019 23:36:49 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
 by smtp.gmail.com with ESMTPSA id k13sm18597563pgl.69.2019.11.17.23.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Nov 2019 23:36:48 -0800 (PST)
From: Chuhong Yuan <hslester96@gmail.com>
To: 
Date: Mon, 18 Nov 2019 15:36:33 +0800
Message-Id: <20191118073633.28237-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 Chuhong Yuan <hslester96@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [alsa-devel] [PATCH] ASoC: wm2200: add missed operations in remove
	and probe failure
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

This driver misses calls to pm_runtime_disable and regulator_bulk_disable
in remove and a call to free_irq in probe failure.
Add the calls to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 sound/soc/codecs/wm2200.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index cf64e109c658..7b087d94141b 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -2410,6 +2410,8 @@ static int wm2200_i2c_probe(struct i2c_client *i2c,
 
 err_pm_runtime:
 	pm_runtime_disable(&i2c->dev);
+	if (i2c->irq)
+		free_irq(i2c->irq, wm2200);
 err_reset:
 	if (wm2200->pdata.reset)
 		gpio_set_value_cansleep(wm2200->pdata.reset, 0);
@@ -2426,12 +2428,15 @@ static int wm2200_i2c_remove(struct i2c_client *i2c)
 {
 	struct wm2200_priv *wm2200 = i2c_get_clientdata(i2c);
 
+	pm_runtime_disable(&i2c->dev);
 	if (i2c->irq)
 		free_irq(i2c->irq, wm2200);
 	if (wm2200->pdata.reset)
 		gpio_set_value_cansleep(wm2200->pdata.reset, 0);
 	if (wm2200->pdata.ldo_ena)
 		gpio_set_value_cansleep(wm2200->pdata.ldo_ena, 0);
+	regulator_bulk_disable(ARRAY_SIZE(wm2200->core_supplies),
+			       wm2200->core_supplies);
 
 	return 0;
 }
-- 
2.24.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
