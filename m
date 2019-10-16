Return-Path: <SRS0=FfYG=YJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CED5C4360C
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Oct 2019 07:13:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04DE02082C
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Oct 2019 07:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nPsb7xjU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJgCFEaS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04DE02082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 444971680;
	Wed, 16 Oct 2019 09:12:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 444971680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571209986;
	bh=3FOHIxKuEbmWRBTWaVMcl4Bj2dnPzYTrOyDx6PeFJJk=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nPsb7xjUOOFMZYXoG2TW6NGKahy0R31QAEwsGgrymmlTAdxHoCjwWuUk+C74HeIR+
	 VVF87O0cE5lNigllLdvBwEnY4JNQsf4PzLo1MhraBK1jc8MRuSqscqb1J19Fh7/AOI
	 U77ZoTRmFu+rCOY6DSFml+3St5+krYY9DAMtvUZM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D4E44F80659;
	Wed, 16 Oct 2019 09:08:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AC7A7F80377; Wed, 16 Oct 2019 09:07:54 +0200 (CEST)
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com
 [IPv6:2a00:1450:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CD660F80362
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2019 09:07:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CD660F80362
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="kJgCFEaS"
Received: by mail-lf1-x144.google.com with SMTP id c195so16504243lfg.9
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2019 00:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=C5W4rfltqSQyC6633naN9KjlUdmam1uxpZxtzibKLXI=;
 b=kJgCFEaSbYOV78577b0Ifo8DUmHrNrAiSODv6VkpiQ4SsErZ0fDKXWgP+lG+SP68U1
 g2+OJWELlDAWIyzUEeuYCzDkjAIq9q3NuZlY4+DKZHtzZyJpUo1TEJQ5Fze/xCow80pj
 ddwFOQnF3LNlQLSb4GW3fvmmKlH+76ebwhYkbd6muLw/S8pnBs6XTXIiqSZvknfgaFlO
 XmbwblaP0FEOXpl45+rSovSa7Yo7izxRSGTPovF4k2LamxPDIM3EfkqVC3khx+6jqAmm
 PUqxpOc+Ite7T0fqQ9TebPT4SlyZiFo/05lf4kx4j9LSGnOoyFywilVOlGmmTRZOXDuq
 XkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=C5W4rfltqSQyC6633naN9KjlUdmam1uxpZxtzibKLXI=;
 b=KZ1AgUQFMf1nS6DoYqvE7vXo+28PyY2ve4kooa2Jw2SqtHPfIg7l/p1cu86S14Br8q
 EgMQWTShnQAZUyNuDntG1JgBJVidnthG9clbdf8pqps3WYN7PPpdWq8P4cDx9W0SUncp
 H+8tZaaVLQ1gbo7/L0zG2Wd22RrvyBkR2MizMOpCWZleIh8AZlKqchjdnFTQWnvtOG0P
 IMIRjpuIPQ7pm5ExC/x2rk8UCoRf1hEkLX0FbdlbAhXi1zwV3M2HrxsRcFAffcd9pO5S
 qTMnOyot0wNw/kAf3K7+o2QjFOmfkOuICaMkK9zb8wZ1eNoT3S1Cq9+oLyQxTq95E7wh
 6TaQ==
X-Gm-Message-State: APjAAAU8rybIKG2un9LnF3b4vtYzUQfGqDIjmnfsuUN+UsDp2IT+WM2O
 ofRjv9BkwEzlGXjR7OwwZr8=
X-Google-Smtp-Source: APXvYqx587pbMaOeJksPCwQe5cRGVDrtU25sgCJnYB02iQnvoCaKcxZz7a5nKyeK3Eyk3aql8YmWLw==
X-Received: by 2002:ac2:59d0:: with SMTP id x16mr23951110lfn.16.1571209670659; 
 Wed, 16 Oct 2019 00:07:50 -0700 (PDT)
Received: from localhost.localdomain (c213-102-65-51.bredband.comhem.se.
 [213.102.65.51])
 by smtp.gmail.com with ESMTPSA id j191sm1361493lfj.49.2019.10.16.00.07.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2019 00:07:49 -0700 (PDT)
From: codekipper@gmail.com
To: mripard@kernel.org,
	wens@csie.org,
	linux-sunxi@googlegroups.com
Date: Wed, 16 Oct 2019 09:07:39 +0200
Message-Id: <20191016070740.121435-7-codekipper@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016070740.121435-1-codekipper@gmail.com>
References: <20191016070740.121435-1-codekipper@gmail.com>
MIME-Version: 1.0
Cc: Jernej Skrabec <jernej.skrabec@siol.net>, alsa-devel@alsa-project.org,
 Marcus Cooper <codekipper@gmail.com>, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, be17068@iperbole.bo.it, broonie@kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [alsa-devel] [PATCH v6 6/7] dt-bindings: ASoC: sun4i-i2s: Add H6
	compatible
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Jernej Skrabec <jernej.skrabec@siol.net>

H6 I2S is very similar to H3, except that it supports up to 16 channels
and thus few registers have fields on different position.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 .../devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml      | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
index eb3992138eec..6928d0a1dcc8 100644
--- a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
@@ -24,6 +24,7 @@ properties:
       - items:
           - const: allwinner,sun50i-a64-i2s
           - const: allwinner,sun8i-h3-i2s
+      - const: allwinner,sun50i-h6-i2s
 
   reg:
     maxItems: 1
@@ -59,6 +60,7 @@ allOf:
               - allwinner,sun8i-a83t-i2s
               - allwinner,sun8i-h3-i2s
               - allwinner,sun50i-a64-codec-i2s
+              - allwinner,sun50i-h6-i2s
 
     then:
       required:
-- 
2.23.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
