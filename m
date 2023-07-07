Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E561EB64D9
	for <alsa-devel@archiver.kernel.org>; Fri,  7 Jul 2023 22:18:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DF11C3E8;
	Sat,  8 Jul 2023 00:17:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DF11C3E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1688768321;
	bh=ll9Mivpndkl8Ru9s4Vm/opYdAjvJGnCRiG90i5qhPbM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=undv09RHaqSm3rTbVa6f/DL5DdSYYv2zwbcoWrnn3iWgIKYAXGaBpKbvtVZnJixwc
	 EdtPU9V9PJxZNur5sQBY1CjWktNbWZgTJIosEDQ3LqWVr2o80cZnioiQheD2Thwlrp
	 3fG73404tt9LUTJbKVBCDBJ2MEnp4L0cbu7WOlNw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 455EBF80132; Sat,  8 Jul 2023 00:17:50 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D438CF80125;
	Sat,  8 Jul 2023 00:17:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D7904F80125; Sat,  8 Jul 2023 00:17:44 +0200 (CEST)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com
 [209.85.166.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D9C7BF80104
	for <alsa-devel@alsa-project.org>; Sat,  8 Jul 2023 00:17:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D9C7BF80104
Received: by mail-io1-f50.google.com with SMTP id
 ca18e2360f4ac-78362f574c9so88471539f.3
        for <alsa-devel@alsa-project.org>;
 Fri, 07 Jul 2023 15:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688768257; x=1691360257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VbcO12KcuCZy6mIXJQxBwZ8MhvfUPsQU9+tPXTNckJU=;
        b=FBGiPLOCepoWv65rSNOkDfUwOn1zagpJlPZx2ODSt2NPKWEMwtBrr6uKacvs8/Kaik
         Xxn8NLWUVjvdb5Etke6rr/eHKlXX8tkeGtQeev8F2rDPGpkG8zeY3Gq6R2L30hV+tcDd
         KAkcX+8s+w0OlKfJ4dDODp5I0IPDVjm3SVxVGBHcGkKpRYGgMMkwa3lGoksoRXm3Mnxg
         82G3vVg6TFEc5kyyPMtcucmCLNHpbuyflEGfXm1Epb8SzbKJ4AL3nxLgttX9iUBXD7di
         xkLOPnTnfcQdJWEPsBgb4yrOEK/UfOmt9Y2813zDFSZU4mGe3umzTp0TZUjBFSwbhTMx
         s8jQ==
X-Gm-Message-State: ABy/qLYt+kYaPcdd3m8TkPHZWuet9FJBzB5hnp+pFUGJFZlUOXqnsBQt
	HmJJb5+VUJrBvfT0QD2ZSA==
X-Google-Smtp-Source: 
 APBJJlFO+EngP3AgSBdVkctaKn6OK6ew2bMWVk+3PoD7xbagCXQdFDfFEahreMSZGD6t8VCzb0Oc6g==
X-Received: by 2002:a5e:dd0c:0:b0:786:ea57:22e2 with SMTP id
 t12-20020a5edd0c000000b00786ea5722e2mr2706201iop.20.1688768256760;
        Fri, 07 Jul 2023 15:17:36 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id
 u25-20020a02aa99000000b0042b4e2fc546sm1542025jai.140.2023.07.07.15.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 15:17:35 -0700 (PDT)
Received: (nullmailer pid 1071485 invoked by uid 1000);
	Fri, 07 Jul 2023 22:17:34 -0000
From: Rob Herring <robh@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: audio-graph-card2: Drop incomplete example
Date: Fri,  7 Jul 2023 16:17:25 -0600
Message-Id: <20230707221725.1071292-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ROL6WMRNGIOBHY5SBRA4VBETYMOAUVRD
X-Message-ID-Hash: ROL6WMRNGIOBHY5SBRA4VBETYMOAUVRD
X-MailFrom: robherring2@gmail.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ROL6WMRNGIOBHY5SBRA4VBETYMOAUVRD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The example in audio-graph-card2 binding is incomplete, uses
undocumented compatibles strings, and doesn't follow typical .dts
formatting. Rather than try to fix with what would probably be a lengthy
example, just drop the example.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/sound/audio-graph-card2.yaml     | 20 +------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-card2.yaml b/Documentation/devicetree/bindings/sound/audio-graph-card2.yaml
index 3de7b36829da..d3ce4de449d5 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-card2.yaml
+++ b/Documentation/devicetree/bindings/sound/audio-graph-card2.yaml
@@ -39,22 +39,4 @@ required:
 
 additionalProperties: false
 
-examples:
-  - |
-    sound {
-        compatible = "audio-graph-card2";
-
-        links = <&cpu_port>;
-    };
-
-    cpu {
-        compatible = "cpu-driver";
-
-        cpu_port: port { cpu_ep: endpoint { remote-endpoint = <&codec_ep>; }; };
-    };
-
-    codec {
-        compatible = "codec-driver";
-
-        port { codec_ep: endpoint { remote-endpoint = <&cpu_ep>; }; };
-    };
+...
-- 
2.40.1

