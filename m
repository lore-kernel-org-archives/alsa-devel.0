Return-Path: <SRS0=KPAB=BG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970DAC433E5
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jul 2020 08:26:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C4492074F
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jul 2020 08:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SH0w8QxW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="FSkWxPJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4492074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8DC621683;
	Mon, 27 Jul 2020 10:25:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8DC621683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595838383;
	bh=XvWuoLpZHYcqFgf5FQEqwW11qNA65yMoLMNBr4WfBOU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SH0w8QxWFJ1RFLV0BG1TMJWCRfZb+ztusrf1zDvbJwtkNsrOHZsiVCs4tfsYw8cRq
	 Hy9oLl1lL2zV16nhaU3YYSDJXF0WWY+A0/mh4Mj8yvH3ZaKMhRzj4lPLxeZWuyA0tu
	 Bu/nGUzQe0GJZYRc/7t08h/h6uMdkriIRJDirdc8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 20E1AF80158;
	Mon, 27 Jul 2020 10:25:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AEC47F80171; Mon, 27 Jul 2020 10:25:26 +0200 (CEST)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [85.215.255.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 91D86F8013C
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2020 10:25:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 91D86F8013C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net
 header.b="FSkWxPJ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1595838320;
 s=strato-dkim-0002; d=gerhold.net;
 h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
 Subject:Sender;
 bh=ymFhDf2n8j14zfm7wXMkjoAX9qryOdYV+fcCssWX+cI=;
 b=FSkWxPJ5m+1JgfPZ7JUOW+C+0egRhjOmpFzwh8JAf6IEtMw3HvHBti702/BkoLYz6A
 mU0UFZ5SkJ29N2WuOBTQpFj0NFmPrKvnlzEdlcREFHpfbsbBkm49+rwbRCX5FogwseJ2
 nAv1ymjzrfoQd/yYLPXL0/AiiE0dW2LmDkSukU1kdszaAJWcjnYEMdBqqKX0ipg8BDDC
 OsOCoVLarWHmo8l+mG45S0jlBMUTsC8aU37NjoSJzfWmOycKsmf12X5hI3Wdhkz+huqm
 GqiRdXkB91lKOXN0GgANzhnKv/dtJv0BgC+uiiLRKaze57SYh4kZ8Jj5bPVZTrteJrxr
 cpzQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB5m6IbY0="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
 by smtp.strato.de (RZmta 46.10.5 DYNA|AUTH)
 with ESMTPSA id Y0939ew6R8PGKLZ
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Mon, 27 Jul 2020 10:25:16 +0200 (CEST)
From: Stephan Gerhold <stephan@gerhold.net>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: dt-bindings: q6asm: Add Q6ASM_DAI_{TX_RX, TX,
 RX} defines
Date: Mon, 27 Jul 2020 10:25:02 +0200
Message-Id: <20200727082502.2341-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Banajit Goswami <bgoswami@codeaurora.org>,
 Stephan Gerhold <stephan@gerhold.net>, Patrick Lai <plai@codeaurora.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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

Right now the direction of a DAI has to be specified as a literal
number in the device tree, e.g.:

	dai@0 {
		reg = <0>;
		direction = <2>;
	};

but this does not make it immediately clear that this is a
playback/RX-only DAI.

Actually, q6asm-dai.c has useful defines for this. Move them to the
dt-bindings header to allow using them in the dts(i) files.
The example above then becomes:

	dai@0 {
		reg = <0>;
		direction = <Q6ASM_DAI_RX>;
	};

which is immediately recognizable as playback/RX-only DAI.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 Documentation/devicetree/bindings/sound/qcom,q6asm.txt | 9 +++++----
 include/dt-bindings/sound/qcom,q6asm.h                 | 4 ++++
 sound/soc/qcom/qdsp6/q6asm-dai.c                       | 3 ---
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6asm.txt b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
index 6b9a88d0ea3f..8c4883becae9 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
@@ -39,9 +39,9 @@ configuration of each dai. Must contain the following properties.
 	Usage: Required for Compress offload dais
 	Value type: <u32>
 	Definition: Specifies the direction of the dai stream
-			0 for both tx and rx
-			1 for only tx (Capture/Encode)
-			2 for only rx (Playback/Decode)
+			Q6ASM_DAI_TX_RX (0) for both tx and rx
+			Q6ASM_DAI_TX (1) for only tx (Capture/Encode)
+			Q6ASM_DAI_RX (2) for only rx (Playback/Decode)
 
 - is-compress-dai:
 	Usage: Required for Compress offload dais
@@ -50,6 +50,7 @@ configuration of each dai. Must contain the following properties.
 
 
 = EXAMPLE
+#include <dt-bindings/sound/qcom,q6asm.h>
 
 apr-service@7 {
 	compatible = "qcom,q6asm";
@@ -62,7 +63,7 @@ apr-service@7 {
 
 		dai@0 {
 			reg = <0>;
-			direction = <2>;
+			direction = <Q6ASM_DAI_RX>;
 			is-compress-dai;
 		};
 	};
diff --git a/include/dt-bindings/sound/qcom,q6asm.h b/include/dt-bindings/sound/qcom,q6asm.h
index 1eb77d87c2e8..f59d74f14395 100644
--- a/include/dt-bindings/sound/qcom,q6asm.h
+++ b/include/dt-bindings/sound/qcom,q6asm.h
@@ -19,4 +19,8 @@
 #define	MSM_FRONTEND_DAI_MULTIMEDIA15	14
 #define	MSM_FRONTEND_DAI_MULTIMEDIA16	15
 
+#define Q6ASM_DAI_TX_RX	0
+#define Q6ASM_DAI_TX	1
+#define Q6ASM_DAI_RX	2
+
 #endif /* __DT_BINDINGS_Q6_ASM_H__ */
diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index a2acb7564eb8..9b7b218f2a20 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -37,9 +37,6 @@
 #define COMPR_PLAYBACK_MAX_FRAGMENT_SIZE (128 * 1024)
 #define COMPR_PLAYBACK_MIN_NUM_FRAGMENTS (4)
 #define COMPR_PLAYBACK_MAX_NUM_FRAGMENTS (16 * 4)
-#define Q6ASM_DAI_TX_RX	0
-#define Q6ASM_DAI_TX	1
-#define Q6ASM_DAI_RX	2
 
 #define ALAC_CH_LAYOUT_MONO   ((101 << 16) | 1)
 #define ALAC_CH_LAYOUT_STEREO ((101 << 16) | 2)
-- 
2.27.0

