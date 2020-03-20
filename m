Return-Path: <SRS0=JibJ=5F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2142FC4332B
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 20:58:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D7B420709
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 20:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IJCpDD0w";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ryUfaQrL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D7B420709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC1241668;
	Fri, 20 Mar 2020 21:57:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC1241668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584737886;
	bh=RdNeXXUyLBybOER72zpbOAGcVvspmC7/yJuhrWyolRw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IJCpDD0wtNxpP8ouaTye/MX7M35cDzvkgBJx5gjYZSF/+FnrQ/ZQSJBynILoWKBgz
	 M44X8VCfCr3z7h1/9GvObgKcE5b/AcwHzLWZpVezUAXWleehPMecIdXJP0Vr8Qa6Vn
	 EROKObiGdhNlZSBlowjbGXr+UZ91/xnemeo805Ic=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AE787F801F9;
	Fri, 20 Mar 2020 21:56:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5C4D1F80162; Fri, 20 Mar 2020 21:56:20 +0100 (CET)
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com
 [IPv6:2a00:1450:4864:20::142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B419EF80126
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2020 21:56:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B419EF80126
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="ryUfaQrL"
Received: by mail-lf1-x142.google.com with SMTP id c20so5669756lfb.0
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2020 13:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=z9bVlt9J+drXkckOzEfmQ7Nr2T5UaZ8eTOrZjkCCIRI=;
 b=ryUfaQrL0Q5vr3B5n7MyuIZSXWMM0WtOIYrcnmF7prGWtEqhrXWMoXEvVHIJ7CeTin
 SZqVToNvK9DElziI+cDv9Kwse5rzlO5PKeO9sqxvrY6aSgUS0cGfRj82oi6Gh+bUgW3p
 FGEIMvKzfLG5beSjDhb51mKVIiNA83nQWzNF9QO4W0/KhXYnfHxyd+rIncHhWc4ROYL6
 gdgD8bFTEMDTW10/5m4UtBBxWKMScKvlRQebVXgEsw8P0caHFL1iAig/2LgVBXHKyVpA
 qNWB9n1GNaFI/i4fdhZ7AYI43E3lkpGnSKiXpr1TFCKUlqZwISKAIhIvCTi32fvy2/kK
 mpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=z9bVlt9J+drXkckOzEfmQ7Nr2T5UaZ8eTOrZjkCCIRI=;
 b=fsX3cWB/wTap2GQ3UWdEvQrJHmQ8juoiQ7orjk1IZVsSs4JAifC9bey1zXDdX1g33k
 IF1wN9q7CAnEEsXmFpY3Zqwh87HhBBbHLk2OijHSIpOm2XBzFglEMw1eEPQ0oVAOuxWO
 Jq/9Dc3gPSIhKtjX+oZ+zelQYyH+URlhjfpI+hlTqtMlQQMHnZGLHVh5HoUzOJTMqCJP
 86fqCu7iucQkeCwgAWtCeKaI6y0Nz1JfOf53mtSqud7+nde5WpAfXXrmEykT8t2ZgeBM
 AYZdzfv11WgMRblTcGc5paFJUZtZp0jsdK87MLWwEwctx0bAAPI4eG6zi/L2rx7gEIbD
 DKwg==
X-Gm-Message-State: ANhLgQ3hBxChIxLoy5WENrWGanw1/qeikeAdQC3gW5vjab3CrjtBDXB9
 OLYfk37gg1R/qgxBBJI49z8=
X-Google-Smtp-Source: ADFU+vughOvcS0nxYLm8TI0hZE316VSnBaspUKHj3rqn6C2EVcQR2cAQHbYoZ7Zu4ztnWJt/mEHu9w==
X-Received: by 2002:ac2:54af:: with SMTP id w15mr6443768lfk.17.1584737775436; 
 Fri, 20 Mar 2020 13:56:15 -0700 (PDT)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru.
 [94.29.39.224])
 by smtp.gmail.com with ESMTPSA id 1sm3873356lft.47.2020.03.20.13.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 13:56:15 -0700 (PDT)
From: Dmitry Osipenko <digetx@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH v1 1/2] dt-bindings: sound: tegra-wm8903: Document built-in
 microphone audio source
Date: Fri, 20 Mar 2020 23:55:03 +0300
Message-Id: <20200320205504.30466-2-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320205504.30466-1-digetx@gmail.com>
References: <20200320205504.30466-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

The internal microphone source is needed in order to be able to describe
the hardware audio routing for devices that have the built-in microphone
in addition to the external Mic Jack.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt
index b795d282818d..a8f2b0c56c79 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt
@@ -18,6 +18,7 @@ Required properties:
   * Headphone Jack
   * Int Spk
   * Mic Jack
+  * Int Mic
 
 - nvidia,i2s-controller : The phandle of the Tegra I2S1 controller
 - nvidia,audio-codec : The phandle of the WM8903 audio codec
-- 
2.25.1

