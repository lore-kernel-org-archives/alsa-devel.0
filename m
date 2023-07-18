Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D971EEB64DA
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Jul 2023 11:43:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D860BDF1;
	Tue, 18 Jul 2023 13:42:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D860BDF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689680603;
	bh=DSp5Y9Wob8T3pqNcpOGK6oMk8kSnevlkUxdZnWJXbb4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=PMTcyVdyC2Et8zuYdYGoNWHv2PYbkTMaWpaEvdduglsxTvPtW/GHrNWqdRN9nOtoj
	 GFSuffOt9fKDfm7p8+SZiyG1nC6k9RYh6P3emG+cBJ4sXvh9+VnuhcRvVWoLc1vF16
	 w1xHvWNa6gnPf+8FM7xbTlEZmlcxTsTrem4SlQa0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ECC79F805AF; Tue, 18 Jul 2023 13:41:04 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 23BFBF805A8;
	Tue, 18 Jul 2023 13:41:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C9919F80544; Tue, 18 Jul 2023 13:40:57 +0200 (CEST)
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de
 [85.215.255.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0837EF800D2
	for <alsa-devel@alsa-project.org>; Tue, 18 Jul 2023 13:40:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0837EF800D2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gerhold.net header.i=@gerhold.net header.a=rsa-sha256
 header.s=strato-dkim-0002 header.b=pgoGK3Md;
	dkim=pass header.d=gerhold.net header.i=@gerhold.net header.a=ed25519-sha256
 header.s=strato-dkim-0003 header.b=UfW6+4wb
ARC-Seal: i=1; a=rsa-sha256; t=1689680438; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=e+tKi+G+OUCduOiE36fr0hOf70/pDMOhg57WzMnIiGLjiqkrVyOXeBjr+cmMX+BRuP
    don5r8kXx7r40FG5AEHbFvPbo24XY0UPtOEHxF1iUdeq3Wg//+WOvWTSs2Yl6BTsQdv8
    iM+fI1h4s7PQ0+bgZSAOu8+dYhxQktOWgnYU+wOirZesdMVoivWLxde8Ylg8jK818YoM
    FXma+1bGNTn0+STQwzhYS07pT4I3M11BBXwK73otTC5dcm1FtsOta+1qXrTpQnvAuqm+
    WaEryXWFPOTSY9OFz7p5IBWzT9NxmBlSanG8ldlv+iJ14Wp6wnjidNlyrnAquEWtRI0m
    SuOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1689680438;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=leKm6XQrXU4OSZeVodhbqX/6PYvddpq/c+MRNpyVB+c=;
    b=jM7bOn7SHkCta1CeOG3K9XzGSE2v6Kgc4BinVVPKFpauGRWacRkkYzaBFxg10Xp8+N
    dhXc/Qm8Yh/0j/aGllvzvC6hJ06q7RI7Owt+kMHL0btX94p9qkvHb9YfisBB96gRWd4h
    fLbH0sewC862yfBAVMhlMFYxKOgB/6CqgVTACVHlHaf8+yS86ldC/zH86KDkJUwFI2tI
    emJoxFubUjvzt6RsNyyYKOJuEJIYnh/0Oc2JFFdaIda1OfgoOZ/MfHwjzh6HpBNUk8Bd
    41WSV7qdgJi/mg8i1E1k3NHswa7sLvVheyaDu9ehnoRMx1yiicRlS0ZmIWQ2U7Li7vcd
    KMpQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1689680438;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=leKm6XQrXU4OSZeVodhbqX/6PYvddpq/c+MRNpyVB+c=;
    b=pgoGK3Md/dyUiwFPly13Eix0Yue9s6nmSwIhfGdvKF837oshp8dAZv35mtqa7YYSPh
    wKvilhLIKIFgDJlsmA39ks0dthN41tD2RjWnl/mVDthcyInqVmHAhN2XWz4ZT+/Yl4yC
    iIPCHdK+YGcdU754BoTiTVlR2pmtTFVpEP2L0KxSvxqxi82YopPdEktNOCDCxS8Z+jx5
    IAR05KdH4fsKGGKwHJMH+hUI2bFafBZqusQOpfeU+OmDCwH1nbmZXKxW8jcTQk+FPGHP
    9Nwms6MLR1GHHp5cW9O//9cIq5rZPpI8GPFeCvUaJHpsdLIJkHPjuVaihXjgWXgp8sHU
    S60A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1689680438;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=leKm6XQrXU4OSZeVodhbqX/6PYvddpq/c+MRNpyVB+c=;
    b=UfW6+4wbdcSNBAw4H5m5PIqRZHem5awRXYHQhZWacO6F2tMrCEYBeLKbcf7+KHkFyv
    0W/Mhi+VzbSUZed75aAw==
X-RZG-AUTH: 
 ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u45/mw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z6IBebbpL
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 18 Jul 2023 13:40:37 +0200 (CEST)
From: Stephan Gerhold <stephan@gerhold.net>
Date: Tue, 18 Jul 2023 13:40:14 +0200
Subject: [PATCH 2/6] ASoC: dt-bindings: pm8916-analog-codec: Drop pointless
 reg-names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230718-pm8916-mclk-v1-2-4b4a58b4240a@gerhold.net>
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
Message-ID-Hash: 7LWETYHVHRKCEP4HGIVE37G2YPIUH3YQ
X-Message-ID-Hash: 7LWETYHVHRKCEP4HGIVE37G2YPIUH3YQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7LWETYHVHRKCEP4HGIVE37G2YPIUH3YQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

pm8916-wcd-analog-codec has just a single reg region, so having a name
for it provides no additional value.

Drop it completely from the schema and example. There is not really any
point in keeping it (even as deprecated) because it was never used. In
old DTBs it will just be ignored as before.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../devicetree/bindings/sound/qcom,pm8916-wcd-analog-codec.yaml      | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,pm8916-wcd-analog-codec.yaml b/Documentation/devicetree/bindings/sound/qcom,pm8916-wcd-analog-codec.yaml
index 77e3cfba4746..5053799c88b5 100644
--- a/Documentation/devicetree/bindings/sound/qcom,pm8916-wcd-analog-codec.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,pm8916-wcd-analog-codec.yaml
@@ -19,10 +19,6 @@ properties:
   reg:
     maxItems: 1
 
-  reg-names:
-    items:
-      - const: pmic-codec-core
-
   clocks:
     maxItems: 1
 
@@ -126,7 +122,6 @@ examples:
       audio-codec@f000 {
         compatible = "qcom,pm8916-wcd-analog-codec";
         reg = <0xf000>;
-        reg-names = "pmic-codec-core";
         clocks = <&gcc GCC_CODEC_DIGCODEC_CLK>;
         clock-names = "mclk";
         qcom,mbhc-vthreshold-low = <75 150 237 450 500>;

-- 
2.41.0

