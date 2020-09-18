Return-Path: <SRS0=g50q=C3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766F4C43464
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:07:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88006207D3
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tcjNMX+2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Gi7uKkM9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88006207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4CB6416A3;
	Fri, 18 Sep 2020 21:07:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4CB6416A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600456076;
	bh=rs0U90cvMniyQwj+KcKcEtZxaMtpSO3IW2NIdR+tdAI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tcjNMX+2fTh2NFhDFK2yzmv80w+kmVCfEUjMQ5hWNEgAWmzhl6Z5Cr32R59D3rJTV
	 XBpOJ2LCjcDCQ5NYUqMfi51iG4Qj9+mHeu9OsD4tKFqeW0rf+4YgKaTe8/As+9GfDz
	 KfC3Cw59nneqJibCRSIB654u1ZqxJyMvVWltNPAc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2E18CF8020B;
	Fri, 18 Sep 2020 21:06:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B1FF6F8020B; Fri, 18 Sep 2020 21:06:10 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A91BAF8013A
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2020 21:05:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A91BAF8013A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Gi7uKkM9"
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08IJ5tlL084774;
 Fri, 18 Sep 2020 14:05:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1600455955;
 bh=CoXhZYsCP8vlZjkExtcfpn4Zh4jMPI7Jl8YtUqogz7E=;
 h=From:To:CC:Subject:Date;
 b=Gi7uKkM9NcR8XxGj4RxCXIu7pAerEZL6eJ0jZhQ/7YIq+zOQT0+rBRC4+a7EkJuIL
 +rwfSj/p4ue6+Qn/j9c8FJup/iGYp0mhHF1ppA4/IIgNGe7usZdnYU9Nx0fADc2w/4
 iYJtZ5TakjbTqF8R/qRUhmAMJcLiF9GHPTB3k3Vo=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08IJ5t3X100400;
 Fri, 18 Sep 2020 14:05:55 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 18
 Sep 2020 14:05:54 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 18 Sep 2020 14:05:55 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08IJ5shj082266;
 Fri, 18 Sep 2020 14:05:54 -0500
From: Dan Murphy <dmurphy@ti.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
 <robh+dt@kernel.org>
Subject: [PATCH 1/9] ASoC: tas2770: Fix calling reset in probe
Date: Fri, 18 Sep 2020 14:05:40 -0500
Message-ID: <20200918190548.12598-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Dan Murphy <dmurphy@ti.com>
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

tas2770_reset is called during i2c probe. The reset calls the
snd_soc_component_write which depends on the tas2770->component being
available. The component pointer is not set until codec_probe so move
the reset to the codec_probe after the pointer is set.

Fixes: 1a476abc723e6 ("tas2770: add tas2770 smart PA kernel driver")
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tas2770.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index c09851834395..03d7ad1885b8 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -575,6 +575,8 @@ static int tas2770_codec_probe(struct snd_soc_component *component)
 
 	tas2770->component = component;
 
+	tas2770_reset(tas2770);
+
 	return 0;
 }
 
@@ -771,8 +773,6 @@ static int tas2770_i2c_probe(struct i2c_client *client,
 	tas2770->channel_size = 0;
 	tas2770->slot_width = 0;
 
-	tas2770_reset(tas2770);
-
 	result = tas2770_register_codec(tas2770);
 	if (result)
 		dev_err(tas2770->dev, "Register codec failed.\n");
-- 
2.28.0

