Return-Path: <SRS0=jhkO=NU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF0AC432BE
	for <alsa-devel@archiver.kernel.org>; Sun, 29 Aug 2021 17:09:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F148F60F4B
	for <alsa-devel@archiver.kernel.org>; Sun, 29 Aug 2021 17:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F148F60F4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dnyon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5F3BD16B2;
	Sun, 29 Aug 2021 19:08:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5F3BD16B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630256947;
	bh=d+2QNTvIoV14dRg4l4dGxY/K6mqRrojAgpr6qjkd1vY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ri/xh5Ue5NgK4SiUbEargvHcW+0nXLBLwlvnQZz6RU2RqJzULXY5mfPA/iz9dFlcd
	 IR4mb/5t9P7rrAm7QSS7zEC51GqO9+3YT30ZEphlDJu139zUvWU6bY+LxBl20kgnEo
	 IzgwtTOl1X1NviwOS9kejrsCwwnDG3220V6IxGbc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1846AF8028D;
	Sun, 29 Aug 2021 19:07:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DF30AF80143; Sun, 29 Aug 2021 19:07:48 +0200 (CEST)
Received: from dnyon.com (dnyon.com [82.223.165.189])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8C49FF80143
 for <alsa-devel@alsa-project.org>; Sun, 29 Aug 2021 19:07:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8C49FF80143
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=dnyon.com header.i=@dnyon.com
 header.b="RQZTpODu"
Received: from dnyon.com (45.74.222.87.dynamic.jazztel.es [87.222.74.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by dnyon.com (Postfix) with ESMTPSA id CD4C940457;
 Sun, 29 Aug 2021 17:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
 t=1630256854; bh=d+2QNTvIoV14dRg4l4dGxY/K6mqRrojAgpr6qjkd1vY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RQZTpODurghBG3P44ykBj/me+k/9HHMcNsQrngtFfakKZH9kJW/EC8he6HXATnO3/
 QdcTVp94I+/HcESNsN/2wT/VpPWZadHpqfLBh6KXCCiJcFNSik0v6tKh87Vrp5s3+s
 OH0rcDgvvtvSS+9XaI+0SmsfeKHI2f/faKMRyO4TsiMbFJOHkrWO2A2z32Qphhgj5M
 xHjyXQf/zEhF3hw94DpuauoryI0k2W06QbL+gegnjqjx4e6GoVAxwIzn+knFNka3yC
 +NciyzLVJi57ChDvjvI7f8Wj9c1vDwRL2O1pu22a/u541ADeWH5E/OqUiPPx1AVCQ1
 tdnEsbS9J+Wpg==
From: Alejandro Tafalla <atafalla@dnyon.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 alsa-devel@alsa-project.org
Subject: [PATCH RESEND 2/2] dt-bindings: sound: max98927: Add reset-gpios
 optional property
Date: Sun, 29 Aug 2021 19:00:17 +0200
Message-Id: <20210829170019.384632-3-atafalla@dnyon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210829170019.384632-1-atafalla@dnyon.com>
References: <20210829170019.384632-1-atafalla@dnyon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>,
 Alejandro Tafalla <atafalla@dnyon.com>
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

Add the reset-gpios as an optional property because some devices might 
not need it to work properly.

Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
---
 Documentation/devicetree/bindings/sound/max9892x.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/max9892x.txt b/Documentation/devicetree/bindings/sound/max9892x.txt
index f6171591ddc6..73733fb60136 100644
--- a/Documentation/devicetree/bindings/sound/max9892x.txt
+++ b/Documentation/devicetree/bindings/sound/max9892x.txt
@@ -30,6 +30,9 @@ Required properties:
 
   - reg : the I2C address of the device for I2C
 
+Optional Properties:
+  - reset-gpios : reference to the GPIO connected to the reset pin, if any.
+
 Example:
 
 codec: max98927@3a {
-- 
2.32.0

