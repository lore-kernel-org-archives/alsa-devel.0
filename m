Return-Path: <SRS0=yBFe=LJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C24C48BE5
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Jun 2021 09:55:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00B9A61413
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Jun 2021 09:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B9A61413
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 768991692;
	Tue, 15 Jun 2021 11:54:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 768991692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623750945;
	bh=0JfZD3u5IFaUiozDYAt43Axmf4bDptnheqIAdh2Zo+s=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=igMl6+2FKSY67kX51xv6EDAE7VyjjjOomDKd6YLyc98vmOXvHe/jRYfqEzRNGhU9u
	 ymAt0ESc5yx/xKtBSX+CFxxdGJB2NDCBjstjk7TojaTmFWyiEF2Mq8oKSLemPX9SaN
	 VeQmneSrCfuJH7HtKG+uoREo2g7wS3D6gk0vEGDE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 18C35F804F2;
	Tue, 15 Jun 2021 11:52:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DE43BF8025E; Tue, 15 Jun 2021 11:50:48 +0200 (CEST)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DE62AF8025A
 for <alsa-devel@alsa-project.org>; Tue, 15 Jun 2021 11:50:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DE62AF8025A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de
 header.b="pENU6Le7"
Received: from localhost (dslb-084-062-104-230.084.062.pools.vodafone-ip.de
 [84.62.104.230])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: ch@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8E7D382877;
 Tue, 15 Jun 2021 11:50:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1623750641;
 bh=xeDue/WnOOtGXp+2ku3MmnMQPyFPmeXZP5vSiFO0p24=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pENU6Le7NwTMxQZjqOEj25QkR75JDIHmwQFXp33kkUSRIu4HdUoRp8YyIPK4BtShZ
 7QPsMVbLS1oxk91BQlr7ZG4Ws56kuSDbC6JqcHdW5D92CEUl2U30t7T9vPbxV6vcvO
 2N9v5g+C+KbBXrgxMoQov+xaRESgrt5kb5mkHIYpJ9OQju05Eb+gTyzOcZXyluwNgW
 /P7QgqKmS4EYIj7VdLRkxgvDtSN/F/2S1VQeIEN+M88mZLEzR7bKCqEqRlF0nqvvNi
 2LVYwJZCgOdX0D5p1N4oaf34Li6bamWv7Ygnx/0s9j/R5/JHc89o0miB04EVCBgpm0
 Oe4qnMgT+15GQ==
From: Claudius Heine <ch@denx.de>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, Marek Vasut <marex@denx.de>,
 Rob Herring <robh+dt@kernel.org>,
 devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE
 BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] ASoC: tlv320aic32x4: dt-bindings: add TAS2505 to
 compatible
Date: Tue, 15 Jun 2021 11:49:32 +0200
Message-Id: <20210615094933.3076392-4-ch@denx.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210615094933.3076392-1-ch@denx.de>
References: <20210615094933.3076392-1-ch@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 15 Jun 2021 11:51:53 +0200
Cc: Claudius Heine <ch@denx.de>
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

This adds 'ti,tas2505' for TAS2505 to the list of allowed compatible
strings.

Signed-off-by: Claudius Heine <ch@denx.de>
---
 Documentation/devicetree/bindings/sound/tlv320aic32x4.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt b/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
index ca75890f0d07..f59125bc79d1 100644
--- a/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
+++ b/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
@@ -6,6 +6,7 @@ Required properties:
  - compatible - "string" - One of:
 	"ti,tlv320aic32x4" TLV320AIC3204
 	"ti,tlv320aic32x6" TLV320AIC3206, TLV320AIC3256
+	"ti,tas2505" TAS2505, TAS2521
  - reg: I2C slave address
  - supply-*: Required supply regulators are:
     "iov" - digital IO power supply
-- 
2.32.0

