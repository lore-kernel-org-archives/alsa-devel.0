Return-Path: <SRS0=+StP=ZM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBC9C432C0
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:26:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E91E20714
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WgHP+Sfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E91E20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 894EE1673;
	Wed, 20 Nov 2019 16:25:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 894EE1673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574263598;
	bh=xUPxHRSXkSE/QJHCoRiTcBykPWgLHnU5lw6/L0TWM/g=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WgHP+SfpELMuDDIaL9Tad/r1FwrGbHzmVxnwqp0hqRehDkbQ6zRuIhGJn+dNpTEwk
	 56/eo3MXmmSv3d/52q1bc3F8p+Wv5Yg4OJR+2Z21wLIHy8M4I0gJw4VfR1FMqhHO8e
	 L5hpLn4/AaFTyIRifS//BdQOKfH1i/v6v9fRYsII=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 104AAF80140;
	Wed, 20 Nov 2019 16:24:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4F3C7F8014B; Wed, 20 Nov 2019 16:24:16 +0100 (CET)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41EFCF8013E
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2019 16:24:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41EFCF8013E
Received: from [127.0.0.1] (localhost [127.0.0.1]) (Authenticated sender: sre)
 with ESMTPSA id C1A382910E9
Received: by earth.universe (Postfix, from userid 1000)
 id 218143C0C77; Wed, 20 Nov 2019 16:24:08 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
 Support Opensource <support.opensource@diasemi.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Date: Wed, 20 Nov 2019 16:24:01 +0100
Message-Id: <20191120152406.2744-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191120152406.2744-1-sebastian.reichel@collabora.com>
References: <20191120152406.2744-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>, kernel@collabora.com
Subject: [alsa-devel] [PATCHv2 1/6] ASoC: da7213: Add da7212 DT compatible
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

This adds a compatible for da7212. It's handled exactly the
same way as DA7213 and follows the ACPI bindings.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 Documentation/devicetree/bindings/sound/da7213.txt | 4 ++--
 sound/soc/codecs/da7213.c                          | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/da7213.txt b/Documentation/devicetree/bindings/sound/da7213.txt
index 58902802d56c..759bb04e0283 100644
--- a/Documentation/devicetree/bindings/sound/da7213.txt
+++ b/Documentation/devicetree/bindings/sound/da7213.txt
@@ -1,9 +1,9 @@
-Dialog Semiconductor DA7213 Audio Codec bindings
+Dialog Semiconductor DA7212/DA7213 Audio Codec bindings
 
 ======
 
 Required properties:
-- compatible : Should be "dlg,da7213"
+- compatible : Should be "dlg,da7212" or "dlg,7213"
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
2.24.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
