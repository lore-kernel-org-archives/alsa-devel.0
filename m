Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A79BC04A6A
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Aug 2023 06:35:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5FB4A82B;
	Thu, 10 Aug 2023 08:34:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5FB4A82B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691649343;
	bh=kD1ArL5xB2uQ7o7fUx+wVoVd1qlUtiurSQ/Sv6ge9PA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=uEoxkjjsW22Ze1sVFyzDiqA2S6l1Pc2TNLPsKOKbk3GIJCkFWfSFJv5ps8vsWyFcN
	 I2IZR6ySLeOVey7L2odcnhVCnCD85pRUWcV/9DzonCGT7H8nbKDyBxW5o0JDNEfFvl
	 GEJNaFrk97D1If+LxT68nGSepD5qD5Vlb1ZmdiUw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3CDEFF805AB; Thu, 10 Aug 2023 08:34:01 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6ED35F805A1;
	Thu, 10 Aug 2023 08:34:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3FA61F8057A; Thu, 10 Aug 2023 08:33:33 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 82073F80508
	for <alsa-devel@alsa-project.org>; Thu, 10 Aug 2023 08:33:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 82073F80508
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=LsM/h3KP
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-4fe21e7f3d1so763815e87.3
        for <alsa-devel@alsa-project.org>;
 Wed, 09 Aug 2023 23:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691649196; x=1692253996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swPZatRmU5IAV5ZeCQ4kXkKbN4f+jKft+68xvypLEqM=;
        b=LsM/h3KPobzkTcoOxI5RPb0T84ud0ZGa4N6jmsjPveiCQzV7GU6U3za5q2AyO4B+5n
         wo+am54GWZdmEQr7eZszZcWrHM3Xd2eu3AQfdqqekomh4lTA7GwaFrZBJw9iaTmYenmS
         N9vy8Kgq357VzueL7xAclqjL1GRsGamNq57RexwJV8w8/d6hWz9J9vcqxzQ9nkGbuR4M
         MNxVek3Fl72nyvkPUlRrBizy1HpDb9unAgTEwUnaWQ4MYuoI9oA1svnj3wqg/G7/3iJA
         IBhXL09whKGx2e5We4vwU1V1BFTHYcs0bXXhIPRz/tROEOoMjMtQtvpZ27Wa/0hxEud1
         8kSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691649196; x=1692253996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=swPZatRmU5IAV5ZeCQ4kXkKbN4f+jKft+68xvypLEqM=;
        b=RNwcfDfH818qybAGuUUHJBIV5+WlM+harsqnu2AMtLe7syGYoALA4jDec0XKOL5dzs
         8+uyNRSUwiWjQwVq9wOfPYi+KfmKtFALQ8PL6GdnY8ebMvO1FgPkMzP4dRsADtsv6Was
         UkpCNciAuglLw3cA080KND+MOh800MJNX8h9BRfaVMaGr2/7sq5JVk5IMYhI+xNFTVOt
         +6DhpoZLa70ydcmlWgV78qw41ENwY/CCZ4891g4bMIpHAXnBrgfkOp7DKXaS/YTWuxHw
         9igwWePmlpsENJzvNa0AiKDqSvWE93NfnZ/+rWWuWcK7FBVOzYClHcWHpSsUcT70fBYH
         KHwg==
X-Gm-Message-State: AOJu0YxMpAdn6pAX1fYtkqs4HhlkWV8s+6+sEMsVyxgYAO9JXHLndtn5
	HDOk9TcbAT0hFgOtoSOPkD0/Sw==
X-Google-Smtp-Source: 
 AGHT+IFSMwcqRWrUYV9irC56xpJoWb74ftanQaLP6RyThzYdg+w2lYlHHTaLxfomYlbHvWOWiHg8fw==
X-Received: by 2002:a05:6512:3e1f:b0:4fe:5795:35ed with SMTP id
 i31-20020a0565123e1f00b004fe579535edmr1082315lfv.6.1691649195909;
        Wed, 09 Aug 2023 23:33:15 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id
 o10-20020a1c750a000000b003fe2b6d64c8sm4020018wmc.21.2023.08.09.23.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 23:33:15 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Jerome Brunet <jbrunet@baylibre.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Rohit kumar <quic_rohkumar@quicinc.com>,
	Cheng-Yi Chiang <cychiang@chromium.org>,
	Rao Mandadapu <srivasam@codeaurora.org>,
	Judy Hsiao <judyhsiao@chromium.org>,
	Trevor Wu <trevor.wu@mediatek.com>,
	Jonathan Bakker <xc-racer2@live.ca>,
	alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v2 06/11] ASoC: dt-bindings: samsung,tm2: use common sound
 card
Date: Thu, 10 Aug 2023 08:32:54 +0200
Message-Id: <20230810063300.20151-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810063300.20151-1-krzysztof.kozlowski@linaro.org>
References: <20230810063300.20151-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: V4EPUOI2JSZFPST2PN4ZJXAVSUUNLAVQ
X-Message-ID-Hash: V4EPUOI2JSZFPST2PN4ZJXAVSUUNLAVQ
X-MailFrom: krzysztof.kozlowski@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/V4EPUOI2JSZFPST2PN4ZJXAVSUUNLAVQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Reference the common sound card properties and deprecate the
custom "samsung,audio-routing" in favor of generic one.  This allows to
remove "model" property and make the binding closer to other sounds
cards.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/sound/samsung,tm2.yaml   | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/samsung,tm2.yaml b/Documentation/devicetree/bindings/sound/samsung,tm2.yaml
index 491e08019c04..760592599143 100644
--- a/Documentation/devicetree/bindings/sound/samsung,tm2.yaml
+++ b/Documentation/devicetree/bindings/sound/samsung,tm2.yaml
@@ -10,6 +10,9 @@ maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
   - Sylwester Nawrocki <s.nawrocki@samsung.com>
 
+allOf:
+  - $ref: sound-card-common.yaml#
+
 properties:
   compatible:
     const: samsung,tm2-audio
@@ -32,6 +35,8 @@ properties:
       being the connection's source; valid names for sources and sinks are the
       WM5110's and MAX98504's pins and the jacks on the board: HP, SPK, Main
       Mic, Sub Mic, Third Mic, Headset Mic.
+      Deprecated, use audio-routing.
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/non-unique-string-array
 
   i2s-controller:
@@ -44,20 +49,15 @@ properties:
   mic-bias-gpios:
     description: GPIO pin that enables the Main Mic bias regulator.
 
-  model:
-    description: The user-visible name of this sound complex.
-    $ref: /schemas/types.yaml#/definitions/string
-
 required:
   - compatible
   - audio-amplifier
   - audio-codec
-  - samsung,audio-routing
+  - audio-routing
   - i2s-controller
   - mic-bias-gpios
-  - model
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
@@ -70,7 +70,7 @@ examples:
         audio-amplifier = <&max98504>;
         mic-bias-gpios = <&gpr3 2 GPIO_ACTIVE_HIGH>;
         model = "wm5110";
-        samsung,audio-routing = "HP", "HPOUT1L",
+        audio-routing = "HP", "HPOUT1L",
                                 "HP", "HPOUT1R",
                                 "SPK", "SPKOUT",
                                 "SPKOUT", "HPOUT2L",
-- 
2.34.1

