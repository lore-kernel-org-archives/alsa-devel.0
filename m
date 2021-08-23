Return-Path: <SRS0=lo3o=NO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D35AC4338F
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Aug 2021 15:34:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E84F613CD
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Aug 2021 15:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4E84F613CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1C7A53E;
	Mon, 23 Aug 2021 17:33:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1C7A53E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629732882;
	bh=v3SzclK+EYZvFw1BtvjESjaoVKj3ZoqLrr0Uz9doJSY=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=c+7bDJemy3S8BQyOkIUkX+UdWfJrwi/urs+OujN0u5zKYTmZqDP5mJndNTXwxU6sh
	 cStCu3oV0silIqW0iDlYsUfEkgRhoKjYHfpvCyyp6pm5b+7QtXGbQB5o94EQ67jmhc
	 rhICQle3T1xzha1hmobmch1RaO7ofO6ugD+h2FKM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9B73FF800E7;
	Mon, 23 Aug 2021 17:33:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C2DCEF80217; Mon, 23 Aug 2021 17:33:49 +0200 (CEST)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B725DF800E7
 for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2021 17:33:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B725DF800E7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="C+sYgc/4"
Received: by mail-yb1-xb49.google.com with SMTP id
 v126-20020a254884000000b005991fd2f912so4208027yba.20
 for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2021 08:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=X8PTnqCigPxWnZk7NuEkGVC1gFezr8oq/bSFX+EkVvk=;
 b=C+sYgc/491qed9/GlLLX8KHvWCNTJaNlUkGom9nQQ9SATq82myiS7UAwdsxVL6T4id
 qGGbyCgZeB4vxjXw//ys9LUaP1JMrAbLLAgixsBj0j0JEGVwkeCMyUpJc9X2TmE/iuSA
 yBgTjwZKZklowohQMMMi+XLkFKsFULqpqakoQ9L4i5oFrggIfxzTfBymikv/p1jXZoQu
 0EnoCFS4MF6oqCMDnIDEn3Xcbh9fW4j6nqaf63CJlPFiVsZpsljXnPc1jv879ww+xEBI
 oEctTKl29NFcWsF2HGUGh3Om9KGsOR6kkLSvGKuLpxqvwO/no+AMkAuk4imJkx5fCuhP
 5n9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=X8PTnqCigPxWnZk7NuEkGVC1gFezr8oq/bSFX+EkVvk=;
 b=jiAvkQx5wwj3mL4pSR1pcPhko1bKn99E0wXjNLWWTMBiPBqb048Z5+vJbX9ahrtOla
 wXMvP2HN0Ti9dnNyhjUA4FLJ6UkWe/bX9M7+Ynutw009aP8jT25K46IZXOCHfYxedWO+
 l0WusvHeIgxW+t4VpWAsk/rLUX8TZ57IUjHoUKqnmTy7efQbqNmYtvmAFIaF4QmQXILx
 LuI7yf7dszdFTKZawT5nTQHoXFtvtPhZEBh5eZwDFzMl96oEhmnldgbtOJNe0Dnt8vLb
 5pUyKimbzjeAdGL3shPatqtcBe5g+li9sVl9iSt2wpzyfN9z+48ROwC6w1eyWFHFCWLa
 jJtA==
X-Gm-Message-State: AOAM531ZD83kfRye0KjMhl484cGYbvh8A5MMDRP3zUJtoP2KkwyLRuTn
 y6xCF7+d3FUiIx+ZS8pGUtdXrCshWNbk
X-Google-Smtp-Source: ABdhPJyUoCrNoh0OpUfCiMoJu48HBqNxOtaX6q8bq8y02y/36i3bUZ2RC1RE534ICXx4N3r6JWpcUnzoXp/M
X-Received: from tzungbi-z840.tpe.corp.google.com
 ([2401:fa00:1:10:bc5a:af6a:3f08:a084])
 (user=tzungbi job=sendgmr) by 2002:a25:c5d2:: with SMTP id
 v201mr45663214ybe.409.1629732815462; Mon, 23 Aug 2021 08:33:35 -0700 (PDT)
Date: Mon, 23 Aug 2021 23:33:23 +0800
Message-Id: <20210823153323.1297723-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH] ASoC: rt1015: remove possible unused variable `bclk_ms'
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Cc: tzungbi@google.com, alsa-devel@alsa-project.org,
 kernel test robot <lkp@intel.com>
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

bclk_ms is possible unused by using the given config (see [1]).

sound/soc/codecs/rt1015.c:724:2: warning: Value stored to 'bclk_ms' is
never read [clang-analyzer-deadcode.DeadStores]
           bclk_ms = frame_size > 32;
           ^         ~~~~~~~~~~~~~~~

In addition, bclk_ms is meaningless and confusing after applying commit
a5db2ca51367 ("ASoC: rt1015: remove unneeded variables in rt1015_priv").
The "> 32" in the expression looks like a typo but it was not.

Let's remove the confusing variable bclk_ms.

[1]: https://lkml.org/lkml/2021/8/23/305

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
For the other two reported files: tas2770.c and wm8731.c, it seems
there is no straightforward way to fix the warning. 

 sound/soc/codecs/rt1015.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt1015.c b/sound/soc/codecs/rt1015.c
index b3e69bf245dd..c0c5952cdff7 100644
--- a/sound/soc/codecs/rt1015.c
+++ b/sound/soc/codecs/rt1015.c
@@ -689,7 +689,7 @@ static int rt1015_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_component *component = dai->component;
 	struct rt1015_priv *rt1015 = snd_soc_component_get_drvdata(component);
-	int pre_div, bclk_ms, frame_size, lrck;
+	int pre_div, frame_size, lrck;
 	unsigned int val_len = 0;
 
 	lrck = params_rate(params);
@@ -706,10 +706,7 @@ static int rt1015_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	bclk_ms = frame_size > 32;
-
-	dev_dbg(component->dev, "bclk_ms is %d and pre_div is %d for iis %d\n",
-				bclk_ms, pre_div, dai->id);
+	dev_dbg(component->dev, "pre_div is %d for iis %d\n", pre_div, dai->id);
 
 	dev_dbg(component->dev, "lrck is %dHz and pre_div is %d for iis %d\n",
 				lrck, pre_div, dai->id);
-- 
2.33.0.rc2.250.ged5fa647cd-goog

