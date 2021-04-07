Return-Path: <SRS0=4JIF=JE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F611C433B4
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Apr 2021 09:21:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DE766124C
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Apr 2021 09:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DE766124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D5A95846;
	Wed,  7 Apr 2021 11:20:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D5A95846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617787293;
	bh=Ay+ElJmeQ1+xovAAZ58AIHYYB+V1AjsRsdJjJKkQKew=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JPbvPSAbtZabOZO7W7OyajTEqy55yaiH/F4/4Mj0nou8faDaMTPoh2GVdj0j7cOC8
	 JqikBhcNsdvlP79xhWvkTPeUqCoX3ijB96+TUxggWS6x+8AECyz4O/Y1Vw7ytHhes+
	 P7Rq7LWuHYs4vXu1byHOKcqtHhn7R4DektEDJy5Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4750DF80168;
	Wed,  7 Apr 2021 11:20:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AA23AF8016A; Wed,  7 Apr 2021 11:20:41 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7B120F80162
 for <alsa-devel@alsa-project.org>; Wed,  7 Apr 2021 11:20:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7B120F80162
Received: from mail-wm1-f69.google.com ([209.85.128.69])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <krzysztof.kozlowski@canonical.com>)
 id 1lU4MU-0000wy-8v
 for alsa-devel@alsa-project.org; Wed, 07 Apr 2021 09:20:34 +0000
Received: by mail-wm1-f69.google.com with SMTP id t125so1146213wmg.4
 for <alsa-devel@alsa-project.org>; Wed, 07 Apr 2021 02:20:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YID2bsYvH2/CWmY8DSYomS/2/8KT8mSeECFvq86VPEs=;
 b=N7na8sJ3IxkFgzZMQ1ipPaBuCuiiyfBf48v95g6nR7wjL/+RRuqXEhbATeWIthKT7R
 BON43G9thquEu/k1ZP38D5DF44A2hDZMM/tXt+/Ngtji37bo4XgmdBqgVJ39ykhg32mY
 UuHLXXQlqp5CeNy03DGs+Tqm8nGZwETfbisF3jTO9ds85HHNAb78oI4/U/fFYFmSjn8h
 WQp+sf43O+ER0BZx9U+TMLULadmtf9hclemuN8TqpFpbJJwO033Yrx93z7kVv4NAGa5L
 0F6oE4x53mHQw7ypovCoO8QBDEdW4pr6UmPELjA39AcJQ1A/GLe1nIZO97zf6HUzTioH
 Liog==
X-Gm-Message-State: AOAM530ivfas0hBQVpgMAP58e7sGlvwddYX/M7fLqrmwY4TwXAqtZKER
 kvjdtIceIBjqhSTt7R4C0dXhT0Bi5JYqxerWpxcoiJXguGZy2sBxJMiXQfOWIrjp/p3oFaem9d2
 u9LMaahRe6+szlKIxIQeMgAQYtw9uL9U/M3uJMXmh
X-Received: by 2002:adf:fb0b:: with SMTP id c11mr3132583wrr.425.1617787234051; 
 Wed, 07 Apr 2021 02:20:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBVsnkvl7ghjwOsTlQiU5s2WdUnm19wTlhQJBOdCAhWbe2BHKGnff6kbZMJVrB/GxC1NvDlw==
X-Received: by 2002:adf:fb0b:: with SMTP id c11mr3132564wrr.425.1617787233874; 
 Wed, 07 Apr 2021 02:20:33 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch.
 [188.155.192.147])
 by smtp.gmail.com with ESMTPSA id r11sm39581743wrm.26.2021.04.07.02.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Apr 2021 02:20:33 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Sameer Pujar <spujar@nvidia.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: simple-card: fix possible uninitialized single_cpu
 local variable
Date: Wed,  7 Apr 2021 11:20:27 +0200
Message-Id: <20210407092027.60769-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Colin King <colin.king@canonical.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
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

The 'single_cpu' local variable is assigned by asoc_simple_parse_dai()
and later used in a asoc_simple_canonicalize_cpu() call, assuming the
entire function did not exit on errors.

However the first function returns 0 if passed device_node is NULL,
thus leaving the variable uninitialized and reporting success.

Addresses-Coverity: Uninitialized scalar variable
Fixes: 8f7f298a3337 ("ASoC: simple-card-utils: separate asoc_simple_card_parse_dai()")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 sound/soc/generic/audio-graph-card.c | 2 +-
 sound/soc/generic/simple-card.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index ee1d924d68e5..76036ea377a9 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -367,7 +367,7 @@ static int graph_dai_link_of(struct asoc_simple_priv *priv,
 	struct device_node *top = dev->of_node;
 	struct asoc_simple_dai *cpu_dai;
 	struct asoc_simple_dai *codec_dai;
-	int ret, single_cpu;
+	int ret, single_cpu = 0;
 
 	dev_dbg(dev, "link_of (%pOF)\n", cpu_ep);
 
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 41aa40765a8d..9a05f44fc3a9 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -249,7 +249,7 @@ static int simple_dai_link_of(struct asoc_simple_priv *priv,
 	struct device_node *plat = NULL;
 	char prop[128];
 	char *prefix = "";
-	int ret, single_cpu;
+	int ret, single_cpu = 0;
 
 	cpu  = np;
 	node = of_get_parent(np);
-- 
2.25.1

