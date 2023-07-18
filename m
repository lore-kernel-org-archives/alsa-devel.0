Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C1DEB64DA
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Jul 2023 11:42:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9D163DE5;
	Tue, 18 Jul 2023 13:41:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9D163DE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689680533;
	bh=QYbw7yPZBHEby2nFwhjz7buDmoUvGpgtKVePe++NQzI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ENBqZrcbSYVMTBpVzNL1ZdCWAa51VECNkWDjHtkqfNmSG0MMoRpUPKhpq/L6HCaUC
	 xMhJBM1ofyNofq4/AhRNhXCnbo7icqFwmxEr1lJGQ5nmsc1+Scjq9hSg/oIEa7DXLQ
	 7aocvmIrD4rLzrdDJdE1AJCjUD4IKpUVd9vm1AA8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 98B9FF8047D; Tue, 18 Jul 2023 13:40:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9540CF8027B;
	Tue, 18 Jul 2023 13:40:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B71D3F80535; Tue, 18 Jul 2023 13:40:49 +0200 (CEST)
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de
 [81.169.146.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4E530F8032D
	for <alsa-devel@alsa-project.org>; Tue, 18 Jul 2023 13:40:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4E530F8032D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gerhold.net header.i=@gerhold.net header.a=rsa-sha256
 header.s=strato-dkim-0002 header.b=b/WA35M2;
	dkim=pass header.d=gerhold.net header.i=@gerhold.net header.a=ed25519-sha256
 header.s=strato-dkim-0003 header.b=DevACCK4
ARC-Seal: i=1; a=rsa-sha256; t=1689680437; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=CxRkUiuk1qoWsNI605971zn6aOa83fSLJnlK9x04FMmEzxkOI6PDfjqZpC70o9MMPe
    3qXuQ+zA+v1vOSFwUu8fU1MLTGZiwCB15Ng5R2rYeyeujxesxaBecGf8r8PXBM9uuYas
    DRrCC+VjB3qgbyRoUnoJlvB51rqk5GzlYNeZSXWUKF9/klWN2YJyVpZonAw2v16IScbd
    6He6pLBWu9GOhw8XuSS2coqDCsU81I0jAFWex/QJZqeELvFuu3LkgNkrQgbuNhJAaurT
    wQ5neJSJSmze309rDJYLt41M5Ngkbl9lEg/2OPxwkBnNvASz6NcoMS4S5+iRypKlWXCm
    Ix3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1689680437;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=41FgpaaFBB/EYR10zVy+xYoyinNOFdObIZ1G8lDObro=;
    b=Ljj59MTlXUpSptntIk7qgpGtJ9/wJz8TXuiMlebtWYdC2GqRktkRoHloriUUcCcKTG
    RyP3ioano8sUHKMlSSYGYTOAdooBblntcogf31wAOmQPV4UjpEQA3IpiMqQnwr+qYKev
    QjkZC64H8uonCOQr6b7K9folS57sOreT8bi/mPv5kQ+KkPbc/BIH/5Vvn+ubMIC6J3Rn
    G1S9imK8bPQnlDnMIRoyLuQ/555amVuC3F4KJOMaXjs5oaNONEyJQAxxZ3plq93s4XiC
    MkhWWadfPq6GHsF76ym+yUqeGXJH/sYUrZiD/nAA/1/vR1Bfsq6s4+6rFw7Xd4rnBztf
    DrWg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1689680437;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=41FgpaaFBB/EYR10zVy+xYoyinNOFdObIZ1G8lDObro=;
    b=b/WA35M2/fd2FL4jEfTcUtLMFQmh9MtQhRnsBew/TPHMvktpS7yAqcL61kG1Ej/5O0
    54avBcpxuamOYhqrWv0lmp2RNMeFrmR3IURN19qi/o8VXNHHfCa9hiuhzn6TykbAJz0o
    jQ0mg724wnDdNzWPiAiQgHPK3trOul7AZbjHo01oTJ1AYwtgycwdIA+ZLt4OMgDzj0dz
    8UcChvECGj+FgBvHvYdoUfvN80rscMg1DHpUzx7QuCOs5wBGFc5LYpbLEo6VkQEDS5n2
    qQFDcxDVUUsmBQWmwu5BV01DdjUpNj9HPS8w+bodT+bRP+hrLmMwD13CmVNz8CJiXfps
    bKsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1689680437;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=41FgpaaFBB/EYR10zVy+xYoyinNOFdObIZ1G8lDObro=;
    b=DevACCK470s9gV9DOy2GyX8xBNUP/mcmqr+oh+6bVh2dcA2ylyS/kNdJHoFqJxia+u
    PviK5ps8vPvMzLWOKADg==
X-RZG-AUTH: 
 ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u45/mw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z6IBebbpJ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 18 Jul 2023 13:40:37 +0200 (CEST)
From: Stephan Gerhold <stephan@gerhold.net>
Date: Tue, 18 Jul 2023 13:40:13 +0200
Subject: [PATCH 1/6] ASoC: dt-bindings: pm8916-analog-codec: Fix misleading
 example
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230718-pm8916-mclk-v1-1-4b4a58b4240a@gerhold.net>
References: <20230718-pm8916-mclk-v1-0-4b4a58b4240a@gerhold.net>
In-Reply-To: <20230718-pm8916-mclk-v1-0-4b4a58b4240a@gerhold.net>
To: Mark Brown <broonie@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>,
 Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.3
Message-ID-Hash: 44TQDQM4XVTQQZJZ6GNYD7VSVQUZKHPW
X-Message-ID-Hash: 44TQDQM4XVTQQZJZ6GNYD7VSVQUZKHPW
X-MailFrom: stephan@gerhold.net
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/44TQDQM4XVTQQZJZ6GNYD7VSVQUZKHPW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SPMI devices typically have a single address cell and no size cell,
i.e. reg = <0xf000> for the audio codec instead of reg = <0xf000 0x200>.

The example is a bit misleading because it uses the latter. Copying
this into the device tree would be incorrect and was fixed before for
pm8916.dtsi in commit c2f0cbb57dba ("arm64: dts: qcom: pm8916: Remove
invalid reg size from wcd_codec").

Make the example more clear by adding the outer "pmic" node which
specifies the same #address/size-cells that would be used in the
real deivce tree.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../sound/qcom,pm8916-wcd-analog-codec.yaml        | 92 ++++++++++++----------
 1 file changed, 50 insertions(+), 42 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,pm8916-wcd-analog-codec.yaml b/Documentation/devicetree/bindings/sound/qcom,pm8916-wcd-analog-codec.yaml
index c385028c4296..77e3cfba4746 100644
--- a/Documentation/devicetree/bindings/sound/qcom,pm8916-wcd-analog-codec.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,pm8916-wcd-analog-codec.yaml
@@ -115,46 +115,54 @@ examples:
   - |
     #include <dt-bindings/clock/qcom,gcc-msm8916.h>
     #include <dt-bindings/interrupt-controller/irq.h>
-
-    audio-codec@f000{
-      compatible = "qcom,pm8916-wcd-analog-codec";
-      reg = <0xf000 0x200>;
-      reg-names = "pmic-codec-core";
-      clocks = <&gcc GCC_CODEC_DIGCODEC_CLK>;
-      clock-names = "mclk";
-      qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
-      qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
-      interrupt-parent = <&spmi_bus>;
-      interrupts = <0x1 0xf0 0x0 IRQ_TYPE_NONE>,
-            <0x1 0xf0 0x1 IRQ_TYPE_NONE>,
-            <0x1 0xf0 0x2 IRQ_TYPE_NONE>,
-            <0x1 0xf0 0x3 IRQ_TYPE_NONE>,
-            <0x1 0xf0 0x4 IRQ_TYPE_NONE>,
-            <0x1 0xf0 0x5 IRQ_TYPE_NONE>,
-            <0x1 0xf0 0x6 IRQ_TYPE_NONE>,
-            <0x1 0xf0 0x7 IRQ_TYPE_NONE>,
-            <0x1 0xf1 0x0 IRQ_TYPE_NONE>,
-            <0x1 0xf1 0x1 IRQ_TYPE_NONE>,
-            <0x1 0xf1 0x2 IRQ_TYPE_NONE>,
-            <0x1 0xf1 0x3 IRQ_TYPE_NONE>,
-            <0x1 0xf1 0x4 IRQ_TYPE_NONE>,
-            <0x1 0xf1 0x5 IRQ_TYPE_NONE>;
-      interrupt-names = "cdc_spk_cnp_int",
-                        "cdc_spk_clip_int",
-                        "cdc_spk_ocp_int",
-                        "mbhc_ins_rem_det1",
-                        "mbhc_but_rel_det",
-                        "mbhc_but_press_det",
-                        "mbhc_ins_rem_det",
-                        "mbhc_switch_int",
-                        "cdc_ear_ocp_int",
-                        "cdc_hphr_ocp_int",
-                        "cdc_hphl_ocp_det",
-                        "cdc_ear_cnp_int",
-                        "cdc_hphr_cnp_int",
-                        "cdc_hphl_cnp_int";
-      vdd-cdc-io-supply = <&pm8916_l5>;
-      vdd-cdc-tx-rx-cx-supply = <&pm8916_l5>;
-      vdd-micbias-supply = <&pm8916_l13>;
-      #sound-dai-cells = <1>;
+    #include <dt-bindings/spmi/spmi.h>
+
+    pmic@1 {
+      compatible = "qcom,pm8916", "qcom,spmi-pmic";
+      reg = <0x1 SPMI_USID>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      audio-codec@f000 {
+        compatible = "qcom,pm8916-wcd-analog-codec";
+        reg = <0xf000>;
+        reg-names = "pmic-codec-core";
+        clocks = <&gcc GCC_CODEC_DIGCODEC_CLK>;
+        clock-names = "mclk";
+        qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
+        qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
+        interrupt-parent = <&spmi_bus>;
+        interrupts = <0x1 0xf0 0x0 IRQ_TYPE_NONE>,
+              <0x1 0xf0 0x1 IRQ_TYPE_NONE>,
+              <0x1 0xf0 0x2 IRQ_TYPE_NONE>,
+              <0x1 0xf0 0x3 IRQ_TYPE_NONE>,
+              <0x1 0xf0 0x4 IRQ_TYPE_NONE>,
+              <0x1 0xf0 0x5 IRQ_TYPE_NONE>,
+              <0x1 0xf0 0x6 IRQ_TYPE_NONE>,
+              <0x1 0xf0 0x7 IRQ_TYPE_NONE>,
+              <0x1 0xf1 0x0 IRQ_TYPE_NONE>,
+              <0x1 0xf1 0x1 IRQ_TYPE_NONE>,
+              <0x1 0xf1 0x2 IRQ_TYPE_NONE>,
+              <0x1 0xf1 0x3 IRQ_TYPE_NONE>,
+              <0x1 0xf1 0x4 IRQ_TYPE_NONE>,
+              <0x1 0xf1 0x5 IRQ_TYPE_NONE>;
+        interrupt-names = "cdc_spk_cnp_int",
+                          "cdc_spk_clip_int",
+                          "cdc_spk_ocp_int",
+                          "mbhc_ins_rem_det1",
+                          "mbhc_but_rel_det",
+                          "mbhc_but_press_det",
+                          "mbhc_ins_rem_det",
+                          "mbhc_switch_int",
+                          "cdc_ear_ocp_int",
+                          "cdc_hphr_ocp_int",
+                          "cdc_hphl_ocp_det",
+                          "cdc_ear_cnp_int",
+                          "cdc_hphr_cnp_int",
+                          "cdc_hphl_cnp_int";
+        vdd-cdc-io-supply = <&pm8916_l5>;
+        vdd-cdc-tx-rx-cx-supply = <&pm8916_l5>;
+        vdd-micbias-supply = <&pm8916_l13>;
+        #sound-dai-cells = <1>;
+      };
     };

-- 
2.41.0

