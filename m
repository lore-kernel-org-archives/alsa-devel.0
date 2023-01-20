Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C9AC25B4E
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Jan 2023 10:28:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 144BD3092;
	Fri, 20 Jan 2023 11:27:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 144BD3092
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674210479;
	bh=KwfGMBaU2gWgaVN9Fo8sr/qJSnalTs5cmjKOWtVAOzc=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=qmuC+s8BLkUadHSq1AywmYrJ8gjvaBtvuy6ZFrMVh3G7peFBG71W2Ooa6NibcZ2X2
	 mH5kQU2qFvtDYe+pi6ynl+F8Zfqde5J6++kU7oL5s/RgHGaBdtg5RK9K2UHUNE8JaY
	 gtnV9TysNqED/S6FXPJYf/KyvpMtIZZX1X5tHHg8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A909F80557;
	Fri, 20 Jan 2023 11:26:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 42592F80495; Fri, 20 Jan 2023 11:26:12 +0100 (CET)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BCBF0F80495
 for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2023 11:26:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BCBF0F80495
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256
 header.s=axis-central1 header.b=g//LtH6e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; q=dns/txt; s=axis-central1; t=1674210366;
 x=1705746366; h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zq0C28u4Y8exuvoqKW0nWKnZEuIJ+MuaDC7ZdjB7/+8=;
 b=g//LtH6ew57MhGS3HqjT2MUmFSpUNbVjiHKfQxr91ObijPPmjacyxhJF
 bIp62A/1R2+RO3WmZ+gnBzb6W/ZEsT2l2c3tbijKC6TY60tMBoHFp9cDx
 6e2V4ri+g7Rv2xq0ccvhDedzYtbr6GZGmJ7SDzUYVAwPKnDVZ691+q4+Y
 F/tMORo7KbXsT5gUF8u92Z1QTsgEemXJgfA3PtCI3SGNV1kV3DF9zL87u
 IERBDoij3A2Dnw+Ec3OCPtFcHPpPE7cjE0opvawv0r/h83ui5wQESEYiM
 61LIl/2nobzX4nsWXYKo9d/9s8KjgsQMqxHR44tLlOf+kIj8kbB8VZeOs A==;
From: Astrid Rost <astrid.rost@axis.com>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring
 <robh+dt@kernel.org>, Dylan Reid <dgreid@chromium.org>
Subject: [PATCH v2 4/4] ASoC: dt-bindings: ti,ts3a227e.yaml: add jack-type
Date: Fri, 20 Jan 2023 11:25:54 +0100
Message-ID: <20230120102555.1523394-5-astrid.rost@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230120102555.1523394-1-astrid.rost@axis.com>
References: <20230120102555.1523394-1-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kernel@axis.com,
 linux-kernel@vger.kernel.org, Astrid Rost <astrid.rost@axis.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Add jack-type: Bitmap value of snd_jack_type to allow combining
card drivers to create a jack for it.

Signed-off-by: Astrid Rost <astrid.rost@axis.com>
---
 Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml b/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
index 785930658029..1d949b805f98 100644
--- a/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
@@ -27,6 +27,14 @@ properties:
   interrupts:
     maxItems: 1
 
+  jack-type:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Bitmap value of snd_jack_type to allow combining
+      card drivers to create a jack for it. Supported is
+        1 SND_JACK_HEADPHONE
+        2 SND_JACK_MICROPHONE
+    default: 3
+
   ti,micbias:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: Intended MICBIAS voltage (datasheet section 9.6.7).
-- 
2.30.2

