Return-Path: <SRS0=iyFA=JF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E64C433ED
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Apr 2021 06:09:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0229610A2
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Apr 2021 06:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0229610A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aksignal.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6EF17166C;
	Thu,  8 Apr 2021 08:08:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6EF17166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617862140;
	bh=4Po9vY7BakOTJ7AaBGSjRCbGl6e3kCHmCIEuzBdUXAM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ipe0NcLGbipOPzfxPYTSYH1YlckpZCuKi+wSKuUebmFvEeMofgYnJYKIVbLZ7vJda
	 evsc4OelW25pQgXySU3GNiXZOeM1nCB0eotXKDbWTW8SEoHz7AuvaO9AZi4dEAmfGT
	 dklZeClsmUnY2wRZaXJxR3tj8m+qPGBLV7aj1XSw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E1BFFF80169;
	Thu,  8 Apr 2021 08:08:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 703B9F8020B; Thu,  8 Apr 2021 08:08:08 +0200 (CEST)
Received: from router.aksignal.cz (router.aksignal.cz [62.44.4.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF798F800BD
 for <alsa-devel@alsa-project.org>; Thu,  8 Apr 2021 08:07:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF798F800BD
Received: from localhost (localhost [127.0.0.1])
 by router.aksignal.cz (Postfix) with ESMTP id D2C654207F;
 Thu,  8 Apr 2021 08:07:47 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
 by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
 with LMTP id 6VDQMolScUen; Thu,  8 Apr 2021 08:07:47 +0200 (CEST)
Received: from pc-gameroom.prchals.tk (unknown [83.240.30.185])
 (Authenticated sender: jiri.prchal@aksignal.cz)
 by router.aksignal.cz (Postfix) with ESMTPSA id 0A2744207E;
 Thu,  8 Apr 2021 08:07:46 +0200 (CEST)
From: Jiri Prchal <jiri.prchal@aksignal.cz>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: codecs: tlv320aic3x: add SPI to the DT binding
Date: Thu,  8 Apr 2021 08:07:41 +0200
Message-Id: <20210408060741.6879-1-jiri.prchal@aksignal.cz>
X-Mailer: git-send-email 2.25.1
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

Added note and example of SPI support.

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
---
 .../devicetree/bindings/sound/tlv320aic3x.txt | 21 +++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/tlv320aic3x.txt b/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
index 9796c4639262..20931a63fd64 100644
--- a/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
+++ b/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
@@ -1,6 +1,6 @@
 Texas Instruments - tlv320aic3x Codec module
 
-The tlv320aic3x serial control bus communicates through I2C protocols
+The tlv320aic3x serial control bus communicates through both I2C and SPI bus protocols
 
 Required properties:
 
@@ -63,7 +63,7 @@ CODEC input pins for other compatible codecs:
 
 The pins can be used in referring sound node's audio-routing property.
 
-Example:
+I2C example:
 
 #include <dt-bindings/gpio/gpio.h>
 
@@ -78,3 +78,20 @@ tlv320aic3x: tlv320aic3x@1b {
 	DRVDD-supply = <&regulator>;
 	DVDD-supply = <&regulator>;
 };
+
+SPI example:
+
+spi0: spi@f0000000 {
+	tlv320aic3x: codec@0 {
+		compatible = "ti,tlv320aic3x";
+		reg = <0>; /* CS number */
+		#sound-dai-cells = <0>;
+		spi-max-frequency = <1000000>;
+
+		AVDD-supply = <&regulator>;
+		IOVDD-supply = <&regulator>;
+		DRVDD-supply = <&regulator>;
+		DVDD-supply = <&regulator>;
+		ai3x-ocmv = <0>;
+	};
+};
-- 
2.25.1

