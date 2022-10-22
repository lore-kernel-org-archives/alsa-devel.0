Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 965E3C04A95
	for <alsa-devel@archiver.kernel.org>; Sat, 22 Oct 2022 16:29:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 72BA17218;
	Sat, 22 Oct 2022 18:28:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 72BA17218
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666456156;
	bh=r1bWMm0lw26cf7nBaQRoorDfLfMoHP/yXQh87xrgVjQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KsH+2pt3rqMlTbW6cLx9XlNFudlpOv3BoVeLlzKIHfQUMactbW/RwcGqS534hhJMq
	 X2FHFs4SfHov2L5LvL5CZCQx2DlXNg6DcN+3NUX3coD+rMbU1mYNgdsFjqHBkCK0UP
	 F9mfK1FS27svKW60yJQdi/o1Pl8JXEipV2xzViVA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ABA6CF80130;
	Sat, 22 Oct 2022 18:28:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0E0D2F804B0; Sat, 22 Oct 2022 18:28:01 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 72B75F80130
 for <alsa-devel@alsa-project.org>; Sat, 22 Oct 2022 18:27:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 72B75F80130
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="qwKBPuGa"
Received: by mail-wr1-x42a.google.com with SMTP id o4so1052415wrq.6
 for <alsa-devel@alsa-project.org>; Sat, 22 Oct 2022 09:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u3LZtQhmhTtG0av/Vhn5L+1eJ4O3uKOFFREHllICaQw=;
 b=qwKBPuGa1JTF0Lz0r3+ZjdptUqdyXE/Rvkl5x/B8w7r8FeSm49MVyLrsinFqRgQXxy
 lOopTc/54bAT4biIxpZeI9MX7D5PBJ5AmXFxsVd+1BhbGqA8dm/hfy2CkPuQOHG8wf8V
 G8gwFY3mKrO+ib6aO1EE+60Ar2bFZ5GwSichX1192pkD8BP5JfUdlq6viMFDBcCRpzrX
 HZpgAfszR4MTEn98go/JcL0rE+5JQ/5yJSl2O0qzufwxN1Ihy0Do7Me5izt2XRi2QW/y
 mLidQEuvuK0ABThySmoD6VEQ2X7sWRCGRyp8ngN9uPUnw2rt+5u3xNKjGMSMB9x/7qdE
 gaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u3LZtQhmhTtG0av/Vhn5L+1eJ4O3uKOFFREHllICaQw=;
 b=WdR9doCtzeMEmwnSSRSel4iAGaMuVHOLv8csmuyO4fE8V5Fm2guDC+PkpIVkYq5IlO
 Z1idnSnJlbSlKEkepFmykPbvUOjqTHcKG1XqeLLJ8YzrWtBnxkNgzS+YoEVsfYCymL1s
 fROHzcJp7YZs//ELlxyPl0U1Fi+TGQgrNlSDDCwlPOeM6/FcKP4H7AkeIGGLtlVxgI45
 kKGrDxO0/OOXadzulWO5YxnAPePoyfEtZ73u/z8ceot32GiQplws88ARrtWYk7vh1CAV
 uQFe5UBWA5iLggKl5xjNgflmPEFqeHxEUPDYModjWMaJ96XZSLz6TMIeYkrPXJ97RacZ
 xl2A==
X-Gm-Message-State: ACrzQf2zpRU2hJKQDE8rrjQS5+LwuJiF1XI4hkDjXwHtBfAWXvrBFcIT
 A7RXzPsC2UB99LfkTYBvh2w=
X-Google-Smtp-Source: AMsMyM4uW22MGCD0X1eioOOK6RWgjhEs5hH/6KkJcF4htf1J5Ex31+YCsFIIq8V4G3w0t6GQBzlXXw==
X-Received: by 2002:a5d:6da1:0:b0:231:c189:e077 with SMTP id
 u1-20020a5d6da1000000b00231c189e077mr16103020wrs.114.1666456076553; 
 Sat, 22 Oct 2022 09:27:56 -0700 (PDT)
Received: from localhost (94.197.3.61.threembb.co.uk. [94.197.3.61])
 by smtp.gmail.com with ESMTPSA id
 be5-20020a05600c1e8500b003a531c7aa66sm6141184wmb.1.2022.10.22.09.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Oct 2022 09:27:56 -0700 (PDT)
From: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To: broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, kuninori.morimoto.gx@renesas.com
Subject: [PATCH v1 2/2] dt-bindings: ASoC: simple-card: Add system-clock-id
 property
Date: Sat, 22 Oct 2022 17:27:42 +0100
Message-Id: <20221022162742.21671-2-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20221022162742.21671-1-aidanmacdonald.0x0@gmail.com>
References: <20221022162742.21671-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.com,
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

This is a new per-DAI property used to specify the clock ID argument
to snd_soc_dai_set_sysclk().

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 Documentation/devicetree/bindings/sound/simple-card.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.yaml b/Documentation/devicetree/bindings/sound/simple-card.yaml
index ed19899bc94b..cb7774e235d0 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.yaml
+++ b/Documentation/devicetree/bindings/sound/simple-card.yaml
@@ -57,6 +57,12 @@ definitions:
       single fixed sampling rate.
     $ref: /schemas/types.yaml#/definitions/flag
 
+  system-clock-id:
+    description: |
+      Specify the clock ID used for setting the DAI system clock.
+      Defaults to 0 if unspecified.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
   mclk-fs:
     description: |
       Multiplication factor between stream rate and codec mclk.
@@ -145,6 +151,8 @@ definitions:
         $ref: "#/definitions/system-clock-direction-out"
       system-clock-fixed:
         $ref: "#/definitions/system-clock-fixed"
+      system-clock-id:
+        $ref: "#/definitions/system-clock-id"
     required:
       - sound-dai
 
-- 
2.38.1

