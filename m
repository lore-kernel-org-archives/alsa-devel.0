Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4101C7618E
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Apr 2023 21:49:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 619E4EAE;
	Fri, 21 Apr 2023 23:49:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 619E4EAE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1682113790;
	bh=gOtMGFHovg6rXvDWIwomnUsw2vyCpivFkQBXQMSdFBU=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=qWJW/fpouADVYtDT0nPCHOeQrBd45NT3Bu0GqaA48bZWETkP7/k2exBCsIkr+4/W5
	 WopQVwqKs9rmAhwa63r57NFcgFhRdeGGjJi8XG5JRstWFPSHdwef78TmA4Bv6MsCSe
	 N/wjWJch6NYF6dI6j9Qydczpgq2cIg/JCbB/nRUE=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 066F4F800D0;
	Fri, 21 Apr 2023 23:48:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 00B55F80155; Fri, 21 Apr 2023 23:48:29 +0200 (CEST)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com
 [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 150E3F800F8
	for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2023 23:48:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 150E3F800F8
Received: by mail-ot1-f51.google.com with SMTP id
 46e09a7af769-6a5f03551fdso2045048a34.0
        for <alsa-devel@alsa-project.org>;
 Fri, 21 Apr 2023 14:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682113700; x=1684705700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DRyhlU6c3feVqq/s8FXw+A2ovCuk/nDpRc2zb7Wb02o=;
        b=gTTK3hOqInZo+lybrg/Lqapvoo9rDrSzZBYQtb3qb8qlX+cN16xyARkFw0TpIaPW7A
         FDUutvPZFKjaz+txsNlujIjY8T46yW3JTDKZWTmSUKA/fbx6gwESvIW3AIsjlHMdhi6Q
         ewUNrtmWqGjM8VLmZpp1MgGYh+GTEW9MvXpO1+FWcAr/4wAWo6/Of8W0Xe9vw4vL9ZRc
         u27MUvr614DSQrYhXdM1c1Uu9Cna5BZ9ewrCND7NNyv/2HBa9HRQMtPgfHoZxf39CkzN
         djC8YE0mqtZGvWBO+uxrK9HVXoix0wN7PfjCloseFCb4l4Mtd6WNrAq07lp8br2QW1pU
         amVg==
X-Gm-Message-State: AAQBX9c29ZP8hHe+ov4c6WjPh9b2fO9Yh9ZKPwNmvQkoGILRNibYawVQ
	Aw0G6m3Gc9UAei1FbNzRZQ==
X-Google-Smtp-Source: 
 AKy350aZUQfz+TT7Tkt8vP5BUlF8jQwcYin20eCbq0naZufUG8oi6julfm/UDVlx8BlcTVY1c1/c/Q==
X-Received: by 2002:a05:6830:1698:b0:6a6:2f86:978d with SMTP id
 k24-20020a056830169800b006a62f86978dmr2681665otr.12.1682113700088;
        Fri, 21 Apr 2023 14:48:20 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id
 dk10-20020a0568303b0a00b006a60606de62sm2128180otb.52.2023.04.21.14.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 14:48:19 -0700 (PDT)
Received: (nullmailer pid 1812127 invoked by uid 1000);
	Fri, 21 Apr 2023 21:48:18 -0000
From: Rob Herring <robh@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>
Subject: [PATCH] ASoC: dt-bindings: More dropping unneeded quotes
Date: Fri, 21 Apr 2023 16:48:10 -0500
Message-Id: <20230421214810.1811962-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: N4V7RXSNLIWQJRYNS4ROXRG24AR576AU
X-Message-ID-Hash: N4V7RXSNLIWQJRYNS4ROXRG24AR576AU
X-MailFrom: robherring2@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, patches@opensource.cirrus.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/N4V7RXSNLIWQJRYNS4ROXRG24AR576AU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Another batch of dropping unneeded quotes on $id and $schema which were
missed in the last round. Once all these are fixed, checking for this can
be enabled in yamllint.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/sound/nvidia,tegra-audio-common.yaml  | 4 ++--
 Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml   | 4 ++--
 .../devicetree/bindings/sound/qcom,q6dsp-lpass-clocks.yaml    | 4 ++--
 .../devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml     | 4 ++--
 Documentation/devicetree/bindings/sound/tas2562.yaml          | 4 ++--
 Documentation/devicetree/bindings/sound/tas2770.yaml          | 4 ++--
 Documentation/devicetree/bindings/sound/tas27xx.yaml          | 4 ++--
 Documentation/devicetree/bindings/sound/wlf,wm8903.yaml       | 4 ++--
 8 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-common.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-common.yaml
index 7c1e9895ce85..2588589ad62d 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-common.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-common.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/sound/nvidia,tegra-audio-common.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/sound/nvidia,tegra-audio-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Common properties for NVIDIA Tegra audio complexes
 
diff --git a/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml b/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml
index cdbb4096fa44..9e5b30d9c6e6 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/sound/qcom,q6apm-dai.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/sound/qcom,q6apm-dai.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Qualcomm Audio Process Manager Digital Audio Interfaces
 
diff --git a/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-clocks.yaml b/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-clocks.yaml
index 1168410f6fbd..3552c44137ed 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-clocks.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-clocks.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/sound/qcom,q6dsp-lpass-clocks.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/sound/qcom,q6dsp-lpass-clocks.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Qualcomm DSP LPASS Clock Controller
 
diff --git a/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml b/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml
index 044e77718a1b..08c618e7e428 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/sound/qcom,q6dsp-lpass-ports.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/sound/qcom,q6dsp-lpass-ports.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Qualcomm DSP LPASS(Low Power Audio SubSystem) Audio Ports
 
diff --git a/Documentation/devicetree/bindings/sound/tas2562.yaml b/Documentation/devicetree/bindings/sound/tas2562.yaml
index a5bb561bfcfb..41489a3ac79f 100644
--- a/Documentation/devicetree/bindings/sound/tas2562.yaml
+++ b/Documentation/devicetree/bindings/sound/tas2562.yaml
@@ -2,8 +2,8 @@
 # Copyright (C) 2019 Texas Instruments Incorporated
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/sound/tas2562.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/sound/tas2562.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Texas Instruments TAS2562 Smart PA
 
diff --git a/Documentation/devicetree/bindings/sound/tas2770.yaml b/Documentation/devicetree/bindings/sound/tas2770.yaml
index 26088adb9dc2..930bd111b072 100644
--- a/Documentation/devicetree/bindings/sound/tas2770.yaml
+++ b/Documentation/devicetree/bindings/sound/tas2770.yaml
@@ -2,8 +2,8 @@
 # Copyright (C) 2019-20 Texas Instruments Incorporated
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/sound/tas2770.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/sound/tas2770.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Texas Instruments TAS2770 Smart PA
 
diff --git a/Documentation/devicetree/bindings/sound/tas27xx.yaml b/Documentation/devicetree/bindings/sound/tas27xx.yaml
index 8cba01316855..bda26b246634 100644
--- a/Documentation/devicetree/bindings/sound/tas27xx.yaml
+++ b/Documentation/devicetree/bindings/sound/tas27xx.yaml
@@ -2,8 +2,8 @@
 # Copyright (C) 2020-2022 Texas Instruments Incorporated
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/sound/tas27xx.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/sound/tas27xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Texas Instruments TAS2764/TAS2780 Smart PA
 
diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8903.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8903.yaml
index 7105ed5fd6c7..4cfa66f62681 100644
--- a/Documentation/devicetree/bindings/sound/wlf,wm8903.yaml
+++ b/Documentation/devicetree/bindings/sound/wlf,wm8903.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/sound/wlf,wm8903.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/sound/wlf,wm8903.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: WM8903 audio codec
 
-- 
2.39.2

