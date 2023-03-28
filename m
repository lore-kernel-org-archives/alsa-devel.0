Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA27C6FD18
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Mar 2023 16:17:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 51277A4C;
	Wed, 29 Mar 2023 18:16:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 51277A4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1680106620;
	bh=rGmMpIgVP9TI8SKgVuuqiJ5yMUB6GNQe7ZL5e+fYMeE=;
	h=From:Date:Subject:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=oo/airb93hsfwUJYPXBYlMC+KJDYfCbHKcs7Rrm2hVLCM3u7qJER9LpMW6Uts31ht
	 qLS8vFNBXkWOcVizJrWfA1oyQQ6ldQxgZoCIPPRqG/hYwQmNYUO+HVkoAqDjkd+sg9
	 CkEmxIRppDb3QOQPhnQWRGKx1/I1GudLkOQsqEME=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 210A2F80114;
	Wed, 29 Mar 2023 18:14:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 935FBF80272; Tue, 28 Mar 2023 13:25:24 +0200 (CEST)
Received: from out-54.mta0.migadu.com (out-54.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 920FEF80114
	for <alsa-devel@alsa-project.org>; Tue, 28 Mar 2023 13:25:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 920FEF80114
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=aLSb6RZz
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1680002718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yB0broTK4NnUke2AgkitBwlfXMZiqx+hknTbHQnvGFo=;
	b=aLSb6RZzErsLa4pRdK/Go3dP43kRzvUeOfSRRqBgBllKkmqUP8oSY9T7xyJMOLsBlv1/8g
	qV2Ba3x7ffMJA1Uhv0j3UQrZL5uARv1weiIRPfbE3N4Rw8RRVH8qrewgT2wMIF3B6JT4+I
	UGPipyZiTuLI5tveZd9cMktvNZ803Fo=
From: Richard Leitner <richard.leitner@linux.dev>
Date: Tue, 28 Mar 2023 13:25:14 +0200
Subject: [PATCH] ASoC: dt-bindings: maxim,max9867: fix example
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230328-max9867_dt_example_fix-v1-1-cdf31c3fdfc8@linux.dev>
X-B4-Tracking: v=1; b=H4sIAJnOImQC/x3NUQqDMBBF0a3IfDdFE01tt1JKGM2kDtQok1IC4
 t4b/bw8Dm+DRMKU4FFtIPTjxEss0VwqGCeMb1LsS4OutamN7tWM+d7bm/NfRxnn9UMucFbUGBs
 0th51BwUPmEgNgnGcDh4WUfbaHssqVMB5+Xzt+x/eVGh2ggAAAA==
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Ladislav Michl <ladis@linux-mips.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1084;
 i=richard.leitner@linux.dev; h=from:subject:message-id;
 bh=rGmMpIgVP9TI8SKgVuuqiJ5yMUB6GNQe7ZL5e+fYMeE=;
 b=owGbwMvMwCX2R2KahkXN7wuMp9WSGFKUzs2Vsmpbo/78Hy+/54QnvCphrgpyaiWpd+Yali+NDS0r
 XbC+o5SFQYyLQVZMkcXemKvdPbfsfaWiTi7MHFYmkCEMXJwCMJHZngx/5dmNMu7NcPhqPNEwsnXH7Z
 c8kVzJ9985famQ3nd4nVnqToZ/Ksefta0K5jMrZb/B5N3TfyW23zT/TvGJ+XdufplRWNPDAQA=
X-Developer-Key: i=richard.leitner@linux.dev; a=openpgp;
 fpr=3F330A87476D76EF79212C6DFC189628387CFBD0
X-Migadu-Flow: FLOW_OUT
X-MailFrom: richard.leitner@linux.dev
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: M557BKX4IFKN26AEORDW2EHUAOUVO4JT
X-Message-ID-Hash: M557BKX4IFKN26AEORDW2EHUAOUVO4JT
X-Mailman-Approved-At: Wed, 29 Mar 2023 16:14:03 +0000
CC: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Richard Leitner <richard.leitner@linux.dev>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/M557BKX4IFKN26AEORDW2EHUAOUVO4JT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Remove the common clock node from the example as suggested by
Krzysztof Kozlowski in [1].

[1] https://lore.kernel.org/lkml/45d306d3-8efb-12ac-0a83-f01ca2982b0a@linaro.org/

Signed-off-by: Richard Leitner <richard.leitner@linux.dev>
---
 Documentation/devicetree/bindings/sound/maxim,max9867.yaml | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/maxim,max9867.yaml b/Documentation/devicetree/bindings/sound/maxim,max9867.yaml
index 6f27029b137d..0b9a84d33b6c 100644
--- a/Documentation/devicetree/bindings/sound/maxim,max9867.yaml
+++ b/Documentation/devicetree/bindings/sound/maxim,max9867.yaml
@@ -57,10 +57,4 @@ examples:
             clocks = <&codec_clk>;
         };
     };
-
-    codec_clk: clock {
-        compatible = "fixed-clock";
-        #clock-cells = <0>;
-        clock-frequency = <12288000>;
-    };
 ...

---
base-commit: ad58151fa04280a938c173bcba05ba42a4073d92
change-id: 20230328-max9867_dt_example_fix-e136f2a4da25

Best regards,
-- 
Richard Leitner <richard.leitner@linux.dev>

