Return-Path: <SRS0=7OoL=EF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44C1C4363A
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:40:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD66E2071A
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FCGOxWvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD66E2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BD157167C;
	Fri, 30 Oct 2020 13:39:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BD157167C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604061616;
	bh=QJpAOLxD85EBXXk90VeqbXx9jHwcZ3A/j2LGEkfr/lQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FCGOxWvc/XREAFYDYE+edUtgQceE31I62iOE0PhU73LwnAD6vwzpUbjsmd0jjEojr
	 njk1EI7um8W+IOh6Tho+xpZ3PxLy2/MOAa2gBVJfT7X9YMqM79KrNKnOpftY4q8B6j
	 u7CMvHpVkuBt8G7O/WHDNynmyHfGZ0iVTyncJeVQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 811B0F804C1;
	Fri, 30 Oct 2020 13:37:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 46228F804BB; Fri, 30 Oct 2020 13:37:50 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9904BF801D5
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2020 13:37:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9904BF801D5
IronPort-SDR: sJVUHXvrYSpL1SBXkXfBO/ruYI/ondjlC+jDH9eYEHvXEqLjZNHOYazLH+C6agVJygyFXykJDE
 ZmX2ziV9LKEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="230234010"
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; d="scan'208";a="230234010"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2020 05:37:38 -0700
IronPort-SDR: LnAzXmrQnOYJM7u2SuxWW2qOuq9fjJ6nsv/l5dwdP8hu7mYBohPANxFW3ubyBjyva73QwWp97I
 hWMYgD2ad0kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; d="scan'208";a="362433719"
Received: from pi-desktop.igk.intel.com ([10.237.148.102])
 by orsmga007.jf.intel.com with ESMTP; 30 Oct 2020 05:37:36 -0700
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 3/6] ASoC: topology: Unify all device references
Date: Fri, 30 Oct 2020 10:54:24 -0400
Message-Id: <20201030145427.3497990-4-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030145427.3497990-1-amadeuszx.slawinski@linux.intel.com>
References: <20201030145427.3497990-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
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

From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

In few places tplg->comp->dev is used, while everywhere else tplg->dev
is being used. Unify those uses towards tplg->dev, as it is being set to
comp->dev during initialization anyway.

Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/soc-topology.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 2a71cec7277e..9d95c1b01c5a 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1865,7 +1865,7 @@ static int soc_tplg_dai_create(struct soc_tplg *tplg,
 	/* pass control to component driver for optional further init */
 	ret = soc_tplg_dai_load(tplg, dai_drv, pcm, NULL);
 	if (ret < 0) {
-		dev_err(tplg->comp->dev, "ASoC: DAI loading failed\n");
+		dev_err(tplg->dev, "ASoC: DAI loading failed\n");
 		goto err;
 	}
 
@@ -1875,7 +1875,7 @@ static int soc_tplg_dai_create(struct soc_tplg *tplg,
 	list_add(&dai_drv->dobj.list, &tplg->comp->dobj_list);
 
 	/* register the DAI to the component */
-	dai = devm_snd_soc_register_dai(tplg->comp->dev, tplg->comp, dai_drv, false);
+	dai = devm_snd_soc_register_dai(tplg->dev, tplg->comp, dai_drv, false);
 	if (!dai)
 		return -ENOMEM;
 
@@ -1982,13 +1982,13 @@ static int soc_tplg_fe_link_create(struct soc_tplg *tplg,
 	/* pass control to component driver for optional further init */
 	ret = soc_tplg_dai_link_load(tplg, link, NULL);
 	if (ret < 0) {
-		dev_err(tplg->comp->dev, "ASoC: FE link loading failed\n");
+		dev_err(tplg->dev, "ASoC: FE link loading failed\n");
 		goto err;
 	}
 
 	ret = snd_soc_add_pcm_runtime(tplg->comp->card, link);
 	if (ret < 0) {
-		dev_err(tplg->comp->dev, "ASoC: adding FE link failed\n");
+		dev_err(tplg->dev, "ASoC: adding FE link failed\n");
 		goto err;
 	}
 
@@ -2493,7 +2493,7 @@ static int soc_tplg_dai_config(struct soc_tplg *tplg,
 	/* pass control to component driver for optional further init */
 	ret = soc_tplg_dai_load(tplg, dai_drv, NULL, dai);
 	if (ret < 0) {
-		dev_err(tplg->comp->dev, "ASoC: DAI loading failed\n");
+		dev_err(tplg->dev, "ASoC: DAI loading failed\n");
 		goto err;
 	}
 
-- 
2.25.1

