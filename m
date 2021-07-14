Return-Path: <SRS0=PPjj=MG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FDFC07E9C
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jul 2021 15:35:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DFFA613BA
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jul 2021 15:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DFFA613BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A98B16C7;
	Wed, 14 Jul 2021 17:35:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A98B16C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626276953;
	bh=0PRbiFxw16iw7UtKPfumXUJwa4NRjDq4e0DwI0CsucQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=daSN8J4CZMiwnz/rj6nLbpR4GVs+c2jrNAoblroteTDbI4d/X8Rl+Hh3ReNNmQ09X
	 C5LlckECD9RXA1m1xHWz6pK9G+VetqP/lk3U2gUjiN3R8pj1hP+OxxYGc+2HUhJEKN
	 nDxhCIScSbFBqdC9dp69TYtUvF57uYELQNnKqdq0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 18F43F804E1;
	Wed, 14 Jul 2021 17:31:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F07D4F804E1; Wed, 14 Jul 2021 17:31:22 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1EA60F804E1
 for <alsa-devel@alsa-project.org>; Wed, 14 Jul 2021 17:31:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1EA60F804E1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="MLzir5u+"
Received: by mail-wm1-x32a.google.com with SMTP id l6so1884949wmq.0
 for <alsa-devel@alsa-project.org>; Wed, 14 Jul 2021 08:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4M0Qy9u7qpzLdCXZMtfpQrDY8UIAvDYX27th6ZO86XE=;
 b=MLzir5u+L1TZw0QCQvWIj9BP6JSBDcbHCeK5bRrSwvdLa2ZhQVK4+yyzIaISzzKzSX
 169ZnI3j7fQaCN+EencL2dLJsdRxk8Ku1PtgQKiCtFpE+Crp52msf9n99sJ5zmiUvZzu
 WQepkEyiONQcRCNtSStAwa2C++VUJWivAXu7hYkbhtw/TA+oA723d7vFUbRbtLuP1sZI
 ZUncQyZ/tfYV26h3iMGyP42gHwRe1bzlCs8zoDmgIC/2dYNarsV5f0HsvzmRQiVpbnaw
 uxn/to7S+vpKSyjK/UJ/IpP/jo0xzvPWBv4T8XREcrTMpf3P9PE2sXG8L9h1zOuUWFCq
 VSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4M0Qy9u7qpzLdCXZMtfpQrDY8UIAvDYX27th6ZO86XE=;
 b=CJxJMSQedNg09x+f8Hn2e6wcGVIrOIa7Lgq7w120kND2mKmiL3fw2iUsVak22Sizup
 ejTJsu5TwIXDdjpjafuY33YlJ993YMG6nlQmEagDM5iECHferksa9wI4bZYD4b+2RJ6z
 GkF8wOxhUBllslc/BIYILm/URTexJ6smCRI8TD2GeHP825pDVMBnCeVyWaOKblR5SfkY
 P5DtVjftgmAEGTDtosQA2MCyKwk9MhJwAudTDUgz97t9nYKp1j9+LTdngsXwmVDWWztt
 vpjDl8tB5o9VhibyqxydZX8IXR345TQlLOTEvQ212DBgnFkPQ8wwdE6vJJHKmVJehCfG
 oakQ==
X-Gm-Message-State: AOAM533dp1Qed67XLYpS9WbayAQTrzOwFDGH3nkMxduNLmOGP8ye1TTK
 F17FxwkoxpEGzGATsfnhB6eybg==
X-Google-Smtp-Source: ABdhPJw9d1nsWK+DrCqoihkWKOXVTL6vRHatVZ+UtvGOXfOFrUmQgYk5h/cCRyKY0ozwwAhdupByNg==
X-Received: by 2002:a05:600c:2ca4:: with SMTP id
 h4mr11774924wmc.37.1626276675086; 
 Wed, 14 Jul 2021 08:31:15 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id y6sm2465174wma.48.2021.07.14.08.31.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jul 2021 08:31:14 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: bjorn.andersson@linaro.org,
	broonie@kernel.org,
	robh@kernel.org
Subject: [PATCH v2 13/16] ASoC: qcom: dt-bindings: add audioreach soundcard
 compatibles
Date: Wed, 14 Jul 2021 16:30:36 +0100
Message-Id: <20210714153039.28373-14-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210714153039.28373-1-srinivas.kandagatla@linaro.org>
References: <20210714153039.28373-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.de,
 plai@codeaurora.org, linux-kernel@vger.kernel.org
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

Add compatible strings for AudioReach DSP firmware based soundcards.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/sound/qcom,sm8250.yaml           | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
index 72ad9ab91832..2f61bc4a2d7e 100644
--- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
@@ -18,6 +18,8 @@ properties:
     oneOf:
       - const: qcom,sm8250-sndcard
       - const: qcom,qrb5165-rb5-sndcard
+      - const: qcom,sm8250-audioreach-sndcard
+      - const: qcom,qrb5165-rb5-audioreach-sndcard
 
   audio-routing:
     $ref: /schemas/types.yaml#/definitions/non-unique-string-array
@@ -152,6 +154,47 @@ examples:
                 sound-dai = <&q6routing>;
             };
 
+            codec {
+                sound-dai = <&vamacro 0>;
+            };
+        };
+    };
+#---------------------------
+# AudioReach based dai links
+#---------------------------
+  - |
+    #include <dt-bindings/sound/qcom,q6apm.h>
+    sound {
+        compatible = "qcom,qrb5165-rb5-audioreach-sndcard";
+        model = "Qualcomm-qrb5165-RB5-WSA8815-Speakers-DMIC0";
+        audio-routing = "SpkrLeft IN", "WSA_SPK1 OUT",
+                    "SpkrRight IN", "WSA_SPK2 OUT";
+
+        wsa-dai-link {
+            link-name = "WSA Playback";
+            cpu {
+                sound-dai = <&q6apmbedai WSA_CODEC_DMA_RX_0>;
+            };
+
+            platform {
+                sound-dai = <&q6apm>;
+            };
+
+            codec {
+                sound-dai = <&left_spkr>, <&right_spkr>, <&swr0 0>, <&wsamacro>;
+            };
+        };
+
+        va-dai-link {
+            link-name = "VA Capture";
+            cpu {
+                sound-dai = <&q6apmbedai VA_CODEC_DMA_TX_0>;
+            };
+
+            platform {
+                sound-dai = <&q6apm>;
+            };
+
             codec {
                 sound-dai = <&vamacro 0>;
             };
-- 
2.21.0

