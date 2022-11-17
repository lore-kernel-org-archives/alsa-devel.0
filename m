Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242B7C4332F
	for <alsa-devel@archiver.kernel.org>; Sat, 19 Nov 2022 08:43:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 594D51694;
	Sat, 19 Nov 2022 09:42:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 594D51694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668847395;
	bh=GsrDwYJpZ3K+S0JIFUE+VyAhrKI8+kYsDtdkd44pGEs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GBmBO4BWl4fFrtCcBSuDIqmOyfPusZDuK9GwX9iSuvC8TqYQOJZMg4Rd2C2ulIxL2
	 gcrH0RHM0qQeyW46hp8SEc6gN+oko4h7GiYatW1BB9EdReMDV8+g09XbYnE/OppZGe
	 DLjAbDsSTH87KvXqlcwki3/4A68qk7BFzKcegBgk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ED683F8057D;
	Sat, 19 Nov 2022 09:40:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 81973F8051D; Thu, 17 Nov 2022 13:39:17 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B160F8025A
 for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2022 13:39:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4B160F8025A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="lcPHPPZL"
Received: by mail-lf1-x130.google.com with SMTP id s8so2566205lfc.8
 for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2022 04:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ugMBQI/CGdLw5JdCEtKoVTwaKmCj5RmUXEMoLxKIBbk=;
 b=lcPHPPZLPVoOh2gvUJWQXtKOOX+svrikFq3/iElv3IWxcU7NSiqM7IOaXs2C2lE1LK
 NQ6Mz7EYFwXmyDOarXfupzphKJE/2muZN5dpHj1Ji5Q/l0UvY0bO8CFrfHvKOBMiI+uN
 S/TPz9ieFvvfxxdSXt3WhiyXNJV4QoFZ1g+PkzZ+mDds6QZ+7D2h1GyWPOXifD82XpBi
 Ft6RfBe9attwb737JofFZOKfzoS5WAjTDxQE2vnp0UKggWaxApdqploNwzYw1yZdrnuJ
 YtUxd6G7fjvoTeu+xeLg+/kPu01LnjMI5ELRkq/DhmeqN5xwLzMsfXJDlWkL7wtqmLEL
 96kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ugMBQI/CGdLw5JdCEtKoVTwaKmCj5RmUXEMoLxKIBbk=;
 b=V3279swxjlAqlbKRrzosREfzf3PG5XYiCjWGPTogMvlvvXHpuAiOhwV2LB7+pedD2l
 HbGpcz4o7kObogcPkRDtOBs48TA/aaGjy7ZTtbrH1aIyjQNnierGD/YRdbs+1kyfDBm3
 zmU9bTzLGoeBSGcbP6VrPLGrIAJQabMuSz8UBiENY7UMdE7IcpDv4bAeePrlT8hJCha4
 h3iNtK/zR13j0lO51f8tqPTI1cyisNUHTCVyHn8KmQqNVmrgBeVTmuBmFfIdnfdftC8U
 BMVia6auz9YlZffuNb1pc4cRoOOOqOwMuC8wSXq7bUx8P2/mxyXznDc1wui1meuB4pxr
 5H8A==
X-Gm-Message-State: ANoB5pkEULJZ9ST8/EquwKKqsl9gvLBvKG+qE2XhCd2fbGa5uLW8+3+M
 5JBLrTn2umndLGIzjCGyAbBv2A==
X-Google-Smtp-Source: AA0mqf5J4zgczTAjGCzd24Jcix6qL84UxPJ/LL1MaY0euJIStPemkPT1hJEMAHEevs8ExijdUCjPEQ==
X-Received: by 2002:a05:6512:746:b0:4a2:4f74:f47c with SMTP id
 c6-20020a056512074600b004a24f74f47cmr773458lfs.367.1668688748094; 
 Thu, 17 Nov 2022 04:39:08 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl
 (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
 by smtp.gmail.com with ESMTPSA id
 u28-20020ac24c3c000000b004972b0bb426sm127855lfq.257.2022.11.17.04.39.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Nov 2022 04:39:07 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
 netdev@vger.kernel.org, linux-can@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
 linux-usb@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-watchdog@vger.kernel.org
Subject: [RFC PATCH 2/9] dt-bindings: memory-controllers: ti,
 gpmc-child: drop redundant part of title
Date: Thu, 17 Nov 2022 13:38:43 +0100
Message-Id: <20221117123850.368213-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221117123850.368213-1-krzysztof.kozlowski@linaro.org>
References: <20221117123850.368213-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 19 Nov 2022 09:40:30 +0100
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

The Devicetree bindings document does not have to say in the title that
it is a "Devicetree binding", but instead just describe the hardware.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/memory-controllers/ti,gpmc-child.yaml   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ti,gpmc-child.yaml b/Documentation/devicetree/bindings/memory-controllers/ti,gpmc-child.yaml
index 4a257fac577e..532a91d6c564 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ti,gpmc-child.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ti,gpmc-child.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/memory-controllers/ti,gpmc-child.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: device tree bindings for children of the Texas Instruments GPMC
+title: Texas Instruments GPMC bus child nodes
 
 maintainers:
   - Tony Lindgren <tony@atomide.com>
-- 
2.34.1

