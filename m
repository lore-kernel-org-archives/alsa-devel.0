Return-Path: <SRS0=G6+L=HV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A4CC433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Feb 2021 23:20:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6850B64E28
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Feb 2021 23:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6850B64E28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0C6101684;
	Sat, 20 Feb 2021 00:19:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0C6101684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613776817;
	bh=+VLhexHm9NqPLI+21bpwA/ckh215C9wBv1HqOKzXPNg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e4IlyZeD/xuH6IwnbIwFnWyFSn0H1Wnx/uKc+AMJrPcYeVwauNp9elUFVWTdzbmlb
	 1cgvno9N1un2QtC5C0Psv+EQ+O+1lB2Y9DuFwjeB6nB9742MKFOPPI/b9nIULzs+aN
	 o77wDe9PcLgjCcjmOTMgnvFiiIGYOdRiLFDpDaAE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 87B8FF8032D;
	Sat, 20 Feb 2021 00:17:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D7233F802DF; Sat, 20 Feb 2021 00:17:04 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 25838F80277
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2021 00:16:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25838F80277
IronPort-SDR: pVe+a1TlrxNkwCuwrpvkNHvMg6Xbg42Jf8evON0vjlXtYZGotWkL6iOVCTi1v5qLpwkBTvYE9p
 Ssr/TQVkg46w==
X-IronPort-AV: E=McAfee;i="6000,8403,9900"; a="203290908"
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; d="scan'208";a="203290908"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2021 15:16:48 -0800
IronPort-SDR: QdoHRIejxFxi+zl+qSrXLkkXWpyCfV9aM0uRz4RrRKUC1GDoH54DC10hGF+tUfeMMqp+CIBbuG
 XkCFNfgdj+OA==
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; d="scan'208";a="420329792"
Received: from lkwerake-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.251.153.34])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2021 15:16:47 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 4/8] ASoC: sh: rcar: core: rename shadowing variables
Date: Fri, 19 Feb 2021 17:16:31 -0600
Message-Id: <20210219231635.5749-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219231635.5749-1-pierre-louis.bossart@linux.intel.com>
References: <20210219231635.5749-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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

cppcheck warnings:

sound/soc/sh/rcar/core.c:1369:22: style: Local variable 'rdai' shadows
outer variable [shadowVariable]
    struct rsnd_dai *rdai = rsnd_rdai_get(priv, dai_i);
                     ^
sound/soc/sh/rcar/core.c:1338:19: note: Shadowed declaration
 struct rsnd_dai *rdai;
                  ^
sound/soc/sh/rcar/core.c:1369:22: note: Shadow variable
    struct rsnd_dai *rdai = rsnd_rdai_get(priv, dai_i);
                     ^
sound/soc/sh/rcar/core.c:1380:22: style: Local variable 'rdai' shadows
outer variable [shadowVariable]
    struct rsnd_dai *rdai = rsnd_rdai_get(priv, dai_i);
                     ^
sound/soc/sh/rcar/core.c:1338:19: note: Shadowed declaration
 struct rsnd_dai *rdai;
                  ^
sound/soc/sh/rcar/core.c:1380:22: note: Shadow variable
    struct rsnd_dai *rdai = rsnd_rdai_get(priv, dai_i);

use a different name at lower scope.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sh/rcar/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index b1a75509851a..817eea79e0d2 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1366,10 +1366,10 @@ static int rsnd_dai_probe(struct rsnd_priv *priv)
 		for_each_endpoint_of_node(dai_node, dai_np) {
 			__rsnd_dai_probe(priv, dai_np, dai_i);
 			if (rsnd_is_gen3(priv)) {
-				struct rsnd_dai *rdai = rsnd_rdai_get(priv, dai_i);
+				struct rsnd_dai *dai = rsnd_rdai_get(priv, dai_i);
 
-				rsnd_parse_connect_graph(priv, &rdai->playback, dai_np);
-				rsnd_parse_connect_graph(priv, &rdai->capture,  dai_np);
+				rsnd_parse_connect_graph(priv, &dai->playback, dai_np);
+				rsnd_parse_connect_graph(priv, &dai->capture,  dai_np);
 			}
 			dai_i++;
 		}
@@ -1377,10 +1377,10 @@ static int rsnd_dai_probe(struct rsnd_priv *priv)
 		for_each_child_of_node(dai_node, dai_np) {
 			__rsnd_dai_probe(priv, dai_np, dai_i);
 			if (rsnd_is_gen3(priv)) {
-				struct rsnd_dai *rdai = rsnd_rdai_get(priv, dai_i);
+				struct rsnd_dai *dai = rsnd_rdai_get(priv, dai_i);
 
-				rsnd_parse_connect_simple(priv, &rdai->playback, dai_np);
-				rsnd_parse_connect_simple(priv, &rdai->capture,  dai_np);
+				rsnd_parse_connect_simple(priv, &dai->playback, dai_np);
+				rsnd_parse_connect_simple(priv, &dai->capture,  dai_np);
 			}
 			dai_i++;
 		}
-- 
2.25.1

