Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA2A4C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Jan 2022 01:29:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0AC7716B2;
	Mon, 10 Jan 2022 02:29:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0AC7716B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1641778197;
	bh=2OUZfUp/LlSCYUIdQhP/nbmg94mdaAktVPtYxKMv9lA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=g80AjWBOzxgeJOEyyAtA7rdrsgXy4M5emPsvY9Vra298APxTwc3adVdhCLq9lY8a0
	 2TiInDuRXmYdPbf4wGdwIWScSvpUNnxgVGXAW0ct+5P/Uz7KCPqhBQjkKSG0JScZk8
	 i3rKQnyAzBJME6H3w7O6kz01SFsVYnRwi1Wn1cHY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8AF91F801F7;
	Mon, 10 Jan 2022 02:29:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4C6D7F80212; Mon, 10 Jan 2022 02:29:03 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 89D53F80054
 for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2022 02:28:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 89D53F80054
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Ms/epKE1"
Received: by mail-pj1-x1031.google.com with SMTP id
 n30-20020a17090a5aa100b001b2b6509685so14284349pji.3
 for <alsa-devel@alsa-project.org>; Sun, 09 Jan 2022 17:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gySM4oMWv1mF5kjtupUmF7Knt8DYj0ZsBjDse8zVMBU=;
 b=Ms/epKE1aC4bp0DujoXARd7xc9wPjod9KA0kIz5FoZZ5Y/h60eIeep+7B9hFx1gXR8
 feArapBDeyDpaCN1Dl510OHIrzVRLBPgc5h2e3bEsBHoSN7pc260IfHdE7RvAzihl3DD
 TknSN1xZUvb4D0pa16/tVMmznSy25nRSkUrU/kZvO6MsaikX3m4JWE/oCeeM+LyRcTpx
 bE5Z7HVuuL+7gZ0RKnXK8f21kgzH3NHbQbcyKYlukxhnYGcTKb66XxQvFg9jeXNPYgAp
 meNfUWhd6iiBRyeeGtBjVXkPs18jea06/32iM6fxowwYjfBM6S5CbCZuXgBZeS5/v55H
 Aofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gySM4oMWv1mF5kjtupUmF7Knt8DYj0ZsBjDse8zVMBU=;
 b=UqxhHT+5WG1u9PdrAhfAdvV9QpgFu3RwFJCcsipKZLPtZScrIrhsKKl6ghc1TenWMN
 Fn7k4NxWGYu/HebQWPRJBLno5BjcQK+SwUBnn0dB0EPHWCQJKWN5fpxBgpbM8wo/l3ha
 kaONsjaPj68v0p4XoNTiCRJVIgk9JBosUkj/yXs/RUswQko839Ff3dYy8wzhvI59Ex12
 grJsEy95uwT6glMvbujbLTN5iwTW7QfwQ8y2nM/RR6U9guBSfpSHUUX/Z36N367RygTS
 D/cEra4eUUmtETDxaNoizGLP1RYQ0LqYd4edcnkRQ4tVmhcUu98KChPnTjMAlZqd8ejb
 FceQ==
X-Gm-Message-State: AOAM532Hu8JH58rfrs/blAPyPGgoJ+IWnujm4LvD2CdcngRsWauStz+6
 jIo4fnE+c6V65cufUxPGqcw=
X-Google-Smtp-Source: ABdhPJzyxOkzsdbUmvLhY5W7m63RcqZT0C9E4jperqC7emOYj24F/JIz2O5eh1C+eq41NAtMAwWbnQ==
X-Received: by 2002:a17:90a:4482:: with SMTP id
 t2mr27418103pjg.133.1641778130873; 
 Sun, 09 Jan 2022 17:28:50 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
 by smtp.gmail.com with ESMTPSA id s14sm1513805pfw.33.2022.01.09.17.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jan 2022 17:28:50 -0800 (PST)
From: cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To: broonie@kernel.org
Subject: [PATCH] sound/soc/codecs: remove redundant ret variable
Date: Mon, 10 Jan 2022 01:28:33 +0000
Message-Id: <20220110012833.643994-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 Zeal Robot <zealci@zte.com.cn>, tiwai@suse.com, chi.minghao@zte.com.cn,
 lgirdwood@gmail.com, CGEL ZTE <cgel.zte@gmail.com>,
 linux-kernel@vger.kernel.org
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value from devm_snd_soc_register_component() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 sound/soc/codecs/wm8971.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 21ae55c32a6d..ddf0e2f5e66a 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -676,7 +676,6 @@ static int wm8971_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
 	struct wm8971_priv *wm8971;
-	int ret;
 
 	wm8971 = devm_kzalloc(&i2c->dev, sizeof(struct wm8971_priv),
 			      GFP_KERNEL);
@@ -689,10 +688,8 @@ static int wm8971_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, wm8971);
 
-	ret = devm_snd_soc_register_component(&i2c->dev,
+	return devm_snd_soc_register_component(&i2c->dev,
 			&soc_component_dev_wm8971, &wm8971_dai, 1);
-
-	return ret;
 }
 
 static const struct i2c_device_id wm8971_i2c_id[] = {
-- 
2.25.1

