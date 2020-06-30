Return-Path: <SRS0=uo8V=AL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9955C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Jun 2020 22:46:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F77B2073E
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Jun 2020 22:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IZidYOsZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3JQTxGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F77B2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BFAC2836;
	Wed,  1 Jul 2020 00:45:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BFAC2836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593557171;
	bh=hCciCbwxuDAIwmh0wiaEiOREnFvsgPQnwkKdrBkhOWw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IZidYOsZKtG+sqy4kHXe1O8TYNZIHRVBEPTG2BAssEqYkw6iPqyMw4+dl3ssWBPOH
	 SpvNCcBy3lj51pePUWYzwT9EEmH2r0yDxECJ6Ccn/WzBc0BEaVHUJ4gVVLszYwpOR2
	 o0qrPP1sn4FlKPSw5aJw5eWT5KvcqOtvDyjEftxA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 47CE2F801F2;
	Wed,  1 Jul 2020 00:45:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E7660F8022D; Wed,  1 Jul 2020 00:45:19 +0200 (CEST)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 14777F8013E
 for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2020 00:45:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 14777F8013E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="N3JQTxGh"
Received: by mail-qk1-x744.google.com with SMTP id c139so20323351qkg.12
 for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2020 15:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=DWMvebG8Albfesqy4OFZUtlmMuyd/6eplwjz8gwUPII=;
 b=N3JQTxGhkMYr+82bxrPbWTcXdr9kCUAQbLd9v0lQnG0MM9xFHnuWutfPGZ5x6yk4tO
 7g0iHtJ5c/BQhc3y147Cro/EEN4ba0YTJVyfx1i/1OEui4NPB2VyOfEwVbcvJ7qcxoMk
 2FGyu/jmppew2DVFJe8gMz6LHKyTyTDEeSg85rwp0/9zUbsJpt5/2kYnvtZQHbu1p0Ti
 9BVKrK3nV/UKVO5/0xN+5F3ia55AhwgFgPPxc401bHbm9In+lMMXGHrg/LEp+LQEVn3B
 YrAMzuU2pbGpPsz00Yc4G6lqm/7AempAiftMeib5uBtcM36LoONbFV9yez68zajcQi+B
 Ma3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=DWMvebG8Albfesqy4OFZUtlmMuyd/6eplwjz8gwUPII=;
 b=bpm6HqDfTmaWCKfu4TEVRLLSSvcXkCpN7OK2yCHkjc5xwApCxL8VSb+/jEPPRGLMom
 d97uxwMQqv8gnnEhCLxSZR9Z+HeDHAUpLsKHes4Bk2L+x0e8Kvun3klAdccZZQd7KMmr
 T3B2kzePiHAf3VcvJvRjz723hSm4Bzcm68BW7YGGzCbnMIxFRXH3E1WPkBpVa6lpw3uv
 m23Ewp8XzC3O8KxlGKLeBM3XL6sb4xu3qXJL3spgrtWrofDWcQNLIDAGBEdFutAtmzJa
 5+CD83kMYYkcQ1eCRY7rMAI6n3FQ/CtEfOo6W9fI9jG3lSQNc+jV/8CMpX0i7a/tI1ml
 87tg==
X-Gm-Message-State: AOAM530Qg672Uo39RqsOHPoDqqmINOvUxqWH6NzkwtTJqrZkShSdXeTc
 qCpPXZvC01jcOuQkWKRROEE=
X-Google-Smtp-Source: ABdhPJwVPWSXqgclpbsbjpHIGS59kxAMDggDD4wRd/Yyje4Esz+wTIzYY8DdVAZ6n0ZyB+6rvDH2Qw==
X-Received: by 2002:a05:620a:635:: with SMTP id
 21mr22740927qkv.491.1593557115108; 
 Tue, 30 Jun 2020 15:45:15 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:92b:d42f:2bc1:abe3:59f0])
 by smtp.gmail.com with ESMTPSA id
 b186sm4093608qkd.28.2020.06.30.15.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 15:45:13 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: broonie@kernel.org
Subject: [PATCH] ASoC: dt-bindings: keembay-i2s: Fix reg descriptions
Date: Tue, 30 Jun 2020 19:44:59 -0300
Message-Id: <20200630224459.27174-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org,
 Fabio Estevam <festevam@gmail.com>, jee.heng.sia@intel.com
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

intel,keembay-i2s has two register regions:
- I2S registers
- I2S gen configuration

Describe these regions accordingly to fix the following warning seen
with 'make dt_binding_check':

Documentation/devicetree/bindings/sound/intel,keembay-i2s.example.dt.yaml: example-0: i2s@20140000:reg:0: [538181632, 512, 539623588, 4] is too long

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 .../devicetree/bindings/sound/intel,keembay-i2s.yaml        | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml b/Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml
index 175e4fb0c315..2e0bbc1c868a 100644
--- a/Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml
@@ -23,7 +23,8 @@ properties:
 
   reg:
     items:
-      - description: I2S configuration
+      - description: I2S registers
+      - description: I2S gen configuration
 
   reg-names:
     items:
@@ -60,7 +61,8 @@ examples:
      i2s3: i2s@20140000 {
          compatible = "intel,keembay-i2s";
          #sound-dai-cells = <0>;
-         reg = <0x20140000 0x200 0x202a00a4 0x4>;
+         reg = <0x20140000 0x200>, /* I2S registers */
+               <0x202a00a4 0x4>; /* I2S gen configuration */
          reg-names = "i2s-regs", "i2s_gen_cfg";
          interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
          clock-names = "osc", "apb_clk";
-- 
2.17.1

