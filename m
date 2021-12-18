Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABAB3C433EF
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Dec 2021 14:35:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1B1921A60;
	Sat, 18 Dec 2021 15:34:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1B1921A60
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1639838134;
	bh=1fY4rFQWlZPXSnxAyN9JU56MNaD5FirnNyM4RNFPCY4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=a0P5eZ+VMcVw/ZmHoxgysgOpMZPglpS0Tc74lOcwmKZdqBQacP3nbCiX7cI7KCbal
	 o7u4u38igafnqX6gaY2a+2l+va56r3ZioxPxHGdLm3cZsL1dm+2K7RwHFEx8Juo/up
	 aLYvP4+k11cwAzMNirAS1PhYrUFu+6jewkryTOfE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BED5AF8013A;
	Sat, 18 Dec 2021 15:34:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A6E3CF8013D; Sat, 18 Dec 2021 15:34:42 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C30C0F800E9
 for <alsa-devel@alsa-project.org>; Sat, 18 Dec 2021 15:34:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C30C0F800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.b="yCA5SANB"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [80.241.60.245])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4JGSzc0TN4zQk2F;
 Sat, 18 Dec 2021 15:34:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1639838074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7OTdoESR2p8GE80V8OYcNegfAIeScHkGiDPJVOeK0IA=;
 b=yCA5SANB8xFhdH9fiH11K75qkRjarhUgs/2QKkKKk/gWEMsJwG7w/iGk6BgBlvnvQ7tPGh
 jYoR27ibxCdGVEhp+dP87+qr6MF7502VNrYemN4zJj6s1eH1vINBjvmLI71EqkRFJuz043
 C9hFVKMmmyq2f0IueVzPz5Jlok8gjI85N1LIHydxuuELKK3gN6ksq4K2Z/zTsUY1fTo+x0
 wgIxGGErUj0pUh3Qg6LX29nU1A/3bkCd9/LyX02ggKPITY7IAUgD3x3CQ45mJ6KfL7EDMp
 TGjn9/xw82t4ZHrl5PsKkQ1nbYD1Zima9FxjV6dRrAm0JbITOtSvfqcKjhR0gg==
From: Alexander Stein <alexander.stein@mailbox.org>
To: Jerome Brunet <jbrunet@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 1/3] ASoC: dt-bindings: Use name-prefix schema
Date: Sat, 18 Dec 2021 15:34:21 +0100
Message-Id: <20211218143423.18768-1-alexander.stein@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Alexander Stein <alexander.stein@mailbox.org>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org
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

name-prefix.txt does not exist anymore, just reference the schema instead.

Signed-off-by: Alexander Stein <alexander.stein@mailbox.org>
---
Changes in v2:
* Fix 'pass' -> 'true'

.../devicetree/bindings/sound/simple-audio-amplifier.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/simple-audio-amplifier.yaml b/Documentation/devicetree/bindings/sound/simple-audio-amplifier.yaml
index 26379377a7ac..8327846356d3 100644
--- a/Documentation/devicetree/bindings/sound/simple-audio-amplifier.yaml
+++ b/Documentation/devicetree/bindings/sound/simple-audio-amplifier.yaml
@@ -9,6 +9,9 @@ title: Simple Audio Amplifier Device Tree Bindings
 maintainers:
   - Jerome Brunet <jbrunet@baylibre.com>
 
+allOf:
+  - $ref: name-prefix.yaml#
+
 properties:
   compatible:
     enum:
@@ -22,10 +25,7 @@ properties:
     description: >
       power supply for the device
 
-  sound-name-prefix:
-    $ref: /schemas/types.yaml#/definitions/string
-    description: >
-      See ./name-prefix.txt
+  sound-name-prefix: true
 
 required:
   - compatible
-- 
2.34.1

