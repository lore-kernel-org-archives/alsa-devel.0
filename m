Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B186C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Dec 2021 09:35:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9AA451768;
	Mon, 20 Dec 2021 10:34:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9AA451768
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1639992918;
	bh=VbxyW9PCxe1CFZQseOXr/BWjD7U+pNRWK2DTcWJFfwg=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MIFQOk8CxlJvKzLPpLo+p/MbQ7qU7RSo7uxouihIMATjvJwgc8HgcQTJiIm+FC8jj
	 XpVOfcc+g2OfWQD/EDtVTX+4Fu1MERFReG8w2UpZyEyziEJWs/BNbEaaYjrhA2WLbO
	 GPrLYCMarK+4ynrZ7KLZ7fVagmuPSrdZXsYwfnSE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1CEBAF80125;
	Mon, 20 Dec 2021 10:34:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D9939F8012A; Mon, 20 Dec 2021 10:34:25 +0100 (CET)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B5C4FF800B5
 for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2021 10:34:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5C4FF800B5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="WWwAjf1B"
Received: by mail-yb1-xb49.google.com with SMTP id
 q15-20020a252a0f000000b006092c637e21so18575939ybq.5
 for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2021 01:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=mJpBRcT5BH30A4x6goxDHrmI3LZ8HIpAwKqxhK8KlcQ=;
 b=WWwAjf1BSlGTk8t++XOI9PK12eT4Ge96vdcnL55/0D87+jmM9zUPCE12+IXOEC5t8a
 b+mN4qCqZa2Lh0+DxzAVVouZGyAuqLu74EUAuawiSgbY/Bo3vyj5nHvuEn56BeI3A1g+
 gpbAy1rTlYVhYq3dLaWyG88cIyupTXCt4CMIqJxYc09YRYjCwQ7m/A+pFM9rOW3sezyc
 hPI9te0SIw2Gv+B6EiusMTsXZCwlOCngz6Sz5xpQML99aQtLtjszDj7ACXYk6EbyZgA5
 CV15Mp5dxrnZUsasBE+rXbOYmVRqntiNT8vLNpcm1KQVygQqagohsYK9DpEBGqZawfHS
 x/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=mJpBRcT5BH30A4x6goxDHrmI3LZ8HIpAwKqxhK8KlcQ=;
 b=6PtIEG9Pi9PnOjXBAE6thgJeMg9x8cQsuHJajksQ16YFhpVsZXtelQnhzAqrde5td2
 HUpnuSVFAv680Yo5JHRoeUCsdCSESYJdTetksW74bEFd/kdZnPnenx7rQGmCRoQz9XB4
 S1inPSc1wy9DA9tKQVmQILB54uS//GH2WR4I/3qju4/5C1EJuz6KWP9q5iEg2LBrD2Vz
 aqrGaSjSn3wtyQSW+1LgrBZHk4KygzehXyJVO1htTyYmH19A9UqW+q/8VSnjMjUIeUKk
 ZQv+YYoUeN8xuytddTBKLdbiMjqlZ9TFr3y9jr5XCgVLe3PvUUWNtgx096RH6GWsozmP
 x7bA==
X-Gm-Message-State: AOAM530o1YUm2RaxZm+kSkfql7l2U/sibV1zL595p8W7FcBjFBY1Eab9
 poaMAXhB1sDa6sjG32KMvtkuxqGihe+p
X-Google-Smtp-Source: ABdhPJzJS1mf5NXNVYIoiOB8DtLr3fy2ued89TcjiX/1rZgGP1Ko/CyRtHSG/uEwgZnAfMKFyjL2RfGnzW2c
X-Received: from tzungbi-z840.tpe.corp.google.com
 ([2401:fa00:1:10:67df:2181:5cc1:9eb9])
 (user=tzungbi job=sendgmr) by 2002:a25:8609:: with SMTP id
 y9mr21012502ybk.50.1639992859079; Mon, 20 Dec 2021 01:34:19 -0800 (PST)
Date: Mon, 20 Dec 2021 17:34:07 +0800
Message-Id: <20211220093408.207206-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH] ASoC: mediatek: mt8195-mt6359: reduce log verbosity in probe()
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com
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

Eliminates error messages if snd_soc_register_card() failed.  Kernel
emits messages if device probe error anyway.

This is mainly for removing the following error messages during boot.
    >>> snd_soc_register_card fail -517

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c | 2 --
 sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c
index 5cdbfaafd479..9cf907c49ea8 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c
@@ -1114,8 +1114,6 @@ static int mt8195_mt6359_rt1011_rt5682_dev_probe(struct platform_device *pdev)
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret) {
-		dev_err(&pdev->dev, "%s snd_soc_register_card fail %d\n",
-			__func__, ret);
 		of_node_put(priv->hdmi_node);
 		of_node_put(priv->dp_node);
 		of_node_put(priv->platform_node);
diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
index fa50a31e9718..fdd444138728 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
@@ -1358,8 +1358,6 @@ static int mt8195_mt6359_rt1019_rt5682_dev_probe(struct platform_device *pdev)
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret) {
-		dev_err(&pdev->dev, "%s snd_soc_register_card fail %d\n",
-			__func__, ret);
 		of_node_put(priv->hdmi_node);
 		of_node_put(priv->dp_node);
 		of_node_put(priv->platform_node);
-- 
2.34.1.173.g76aa8bc2d0-goog

