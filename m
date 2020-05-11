Return-Path: <SRS0=FWLr=6Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8E6C47255
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2020 13:27:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69B1B206F5
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2020 13:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fQ9A5zTW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69B1B206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BDD151607;
	Mon, 11 May 2020 15:26:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BDD151607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589203667;
	bh=CTUFrRofuoI4mX0x7QUQSjCDuKABftPgYBx9hbqgHAs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fQ9A5zTWc05bsmsblJwEskT755najZY1m+dW34z2XUR4RXrsQcnmzGVILjiqFu2F2
	 tFdAd355rmo3UWihPX8P+Z9TR6C6Rbgit8uC4cDcWwWa11kkF4ivVRdg/Ol49aQnDN
	 NXorGKJU3VHu0eRY8PMY1OVVtfJaYNJylx9MBwFQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 79A79F80254;
	Mon, 11 May 2020 15:26:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AC46FF8028C; Mon, 11 May 2020 15:25:57 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C5411F8014C
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2020 15:25:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C5411F8014C
Received: from [127.0.0.1] (localhost [127.0.0.1]) (Authenticated sender: sre)
 with ESMTPSA id AD2B72A144C
Received: by jupiter.universe (Postfix, from userid 1000)
 id DA64F480101; Mon, 11 May 2020 15:25:45 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Support Opensource <support.opensource@diasemi.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Subject: [PATCHv3 1/5] ASoC: da7213: Add da7212 DT compatible
Date: Mon, 11 May 2020 15:25:40 +0200
Message-Id: <20200511132544.82364-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200511132544.82364-1-sebastian.reichel@collabora.com>
References: <20200511132544.82364-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>,
 Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, kernel@collabora.com,
 Sebastian Reichel <sebastian.reichel@collabora.com>
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

This adds a compatible for da7212. It's handled exactly the
same way as DA7213 and follows the ACPI bindings.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
PATCHv2 -> PATCHv3: fixed typo in DT binding file's compatible string
---
 Documentation/devicetree/bindings/sound/da7213.txt | 4 ++--
 sound/soc/codecs/da7213.c                          | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/da7213.txt b/Documentation/devicetree/bindings/sound/da7213.txt
index 58902802d56c..69ed23b25e25 100644
--- a/Documentation/devicetree/bindings/sound/da7213.txt
+++ b/Documentation/devicetree/bindings/sound/da7213.txt
@@ -1,9 +1,9 @@
-Dialog Semiconductor DA7213 Audio Codec bindings
+Dialog Semiconductor DA7212/DA7213 Audio Codec bindings
 
 ======
 
 Required properties:
-- compatible : Should be "dlg,da7213"
+- compatible : Should be "dlg,da7212" or "dlg,da7213"
 - reg: Specifies the I2C slave address
 
 Optional properties:
diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 925a03996db4..aff306bb58df 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -1571,6 +1571,7 @@ static int da7213_set_bias_level(struct snd_soc_component *component,
 #if defined(CONFIG_OF)
 /* DT */
 static const struct of_device_id da7213_of_match[] = {
+	{ .compatible = "dlg,da7212", },
 	{ .compatible = "dlg,da7213", },
 	{ }
 };
-- 
2.26.2

