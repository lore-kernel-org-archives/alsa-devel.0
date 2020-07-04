Return-Path: <SRS0=zuuw=AP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF19C433E0
	for <alsa-devel@archiver.kernel.org>; Sat,  4 Jul 2020 11:42:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B851E20890
	for <alsa-devel@archiver.kernel.org>; Sat,  4 Jul 2020 11:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="glG6ebD8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWxCfElw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B851E20890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4EE6E169B;
	Sat,  4 Jul 2020 13:41:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4EE6E169B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593862963;
	bh=w3Se1i0ln9IaTvFtx9Ktn4F+9Dhi4xvfdhzG9X9IyAE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=glG6ebD89kWUMCPz8mTE9aStjtY7x7DNGK4FAbyASjYFmCX7e7NDtfoj8sD9905Ip
	 pyrU4EmjcQgEebOmGEz3FutN82OGT8PMdu4QsMNiOGVOdjYoAM20SrufAX3ZKg4ulF
	 aMOnfKj3+lllt16wEpKta68UcdMpaYNYVMRCScjs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9B8D7F802BD;
	Sat,  4 Jul 2020 13:39:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2EF3DF802E0; Sat,  4 Jul 2020 13:39:18 +0200 (CEST)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 06714F80253
 for <alsa-devel@alsa-project.org>; Sat,  4 Jul 2020 13:39:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 06714F80253
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="CWxCfElw"
Received: by mail-wm1-x344.google.com with SMTP id 22so34362993wmg.1
 for <alsa-devel@alsa-project.org>; Sat, 04 Jul 2020 04:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZsMT0CrEUbDwl+d5khTOYaGtUlOWn7Yi+9GLp9dBrZs=;
 b=CWxCfElwflkj5WONPGRdnQaYiBwZy6w16x4tiGVF4F3fu4Oi6amp7+80lpZNuKfszE
 M9MKKSr3k9MyE9glWYaEaoGFSsdiXu4UGAxQl+DpjJqIX/GiOWzcGx7GSItnaHCPa0B5
 hqadLjAJ7JrYoVlmTSr4ARyeRO+khyjdL0qCRuyn6cFjb4OZQMa1DGXRTfGnim+IT5Hh
 ePqYWSfVwk5DiXrdikVJaAJiMa0iCX/TdW2R1rjdDXM+uJHviTj3jlvjaTihL59V6KUr
 2xvFWdRGGvBLwto2Giu3coB8ZiGSJ3j9WAd5yOBoTFUsgcfkOuZIwsZaDLI3ZovtFm42
 AR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZsMT0CrEUbDwl+d5khTOYaGtUlOWn7Yi+9GLp9dBrZs=;
 b=kWUGhpviCZiJszvKZBwKqNDwJ/0CtXfLax/BR+3Jw2dJ2Q3OUCsxfWtXCMC45DlvP5
 ST3CdHjgwhA8Jj+UQVdfa9QUmGjkDrEFGG7izJMerMXNSh216GBf9dyYmSM8R2n9zuVF
 T2+Bmn4j2LgN8gC/qXnS+qrYgGg2Aj1XlPlV1Gx5s+j6w+at+xocjbvNPDlrwSzjIAl2
 +p2jRtP8E5XG+4DCEaF+/iICPcvq6jeApD9oMqZctlYfgFntwMsAEiqKKCtYNkBwPnRJ
 659Q1lBnO6g8bqUnlx5YghMdNAVaGibC5ALJ+IpkZIwcRuZ8H6asEtTqnu0fEZ4FEekP
 M/AA==
X-Gm-Message-State: AOAM532Y0hzuB6tjaCOR7Gelgg0jHJEvIa+iX+3wTt5ce+WsFOYKtXao
 4CuB/bPW9Gf854mVw9VvxgE=
X-Google-Smtp-Source: ABdhPJxLVU5s3PcDZkCGylGjdsqSH/E6IhkRhbORJX9k4Y433+Def/ioWVDRJ/5MZkenGYU8fL6Osg==
X-Received: by 2002:a05:600c:249:: with SMTP id
 9mr35124620wmj.80.1593862749557; 
 Sat, 04 Jul 2020 04:39:09 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr
 (213-245-241-245.rev.numericable.fr. [213.245.241.245])
 by smtp.gmail.com with ESMTPSA id j24sm18657373wrd.43.2020.07.04.04.39.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 04:39:08 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 03/16] dt-bindings: ASoC: sun4i-i2s: Add H6 compatible
Date: Sat,  4 Jul 2020 13:38:49 +0200
Message-Id: <20200704113902.336911-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200704113902.336911-1-peron.clem@gmail.com>
References: <20200704113902.336911-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>,
 alsa-devel@alsa-project.org, Rob Herring <robh@kernel.org>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Marcus Cooper <codekipper@gmail.com>, linux-sunxi@googlegroups.com,
 =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
 linux-arm-kernel@lists.infradead.org
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

From: Jernej Skrabec <jernej.skrabec@siol.net>

H6 I2S is very similar to H3, except that it supports up to 16 channels
and thus few registers have fields on different position.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml      | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
index 112ae00d63c1..606ad2d884a8 100644
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
2.25.1

