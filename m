Return-Path: <SRS0=0EZw=NY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A504CC432BE
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Sep 2021 11:23:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54BE060F21
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Sep 2021 11:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 54BE060F21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ECD69179A;
	Thu,  2 Sep 2021 13:23:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ECD69179A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630581834;
	bh=PyAY/cxESAd6kQ9Y2xrex8QQh6QcsgqCcMk2I3OxRvQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Vre3m8V5FJkr65/9GaFIon9EE1yjbracNN7dRC0KCUhAp72jHxEJZa9qnR0OdGWVu
	 k7vwDDyluMen3JlsSpbOPWAmknh10rBsXXn7bRJaWMeUefCKy6rY1cWqWDTOQSpXu+
	 A8Rd5WLqoL6bzTJ9WCGbLvktlIfUUciz0326lAIA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8042DF8025B;
	Thu,  2 Sep 2021 13:23:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8BD12F80269; Thu,  2 Sep 2021 13:23:00 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7E656F8020D
 for <alsa-devel@alsa-project.org>; Thu,  2 Sep 2021 13:22:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7E656F8020D
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="219086545"
X-IronPort-AV: E=Sophos;i="5.84,372,1620716400"; d="scan'208";a="219086545"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2021 04:22:46 -0700
X-IronPort-AV: E=Sophos;i="5.84,372,1620716400"; d="scan'208";a="467356771"
Received: from leeyapha-desk2.amr.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.251.212.83])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2021 04:22:44 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Subject: [PATCH] ASoC: soc-topology: Move template info print
 soc_tplg_dapm_widget_create()
Date: Thu,  2 Sep 2021 14:23:01 +0300
Message-Id: <20210902112301.22657-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: guennadi.liakhovetski@linux.intel.com, alsa-devel@alsa-project.org,
 pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com,
 jaska.uimonen@linux.intel.com
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

A DAPM widget now can have different types of controls, it is no longer
correct to print the type as it is just the type of the first control.

Move it after the loop where we create the controls and print the number
of the control types.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 sound/soc/soc-topology.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index f6e5ac3e0314..73e1b7b48ce9 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1473,10 +1473,6 @@ static int soc_tplg_dapm_widget_create(struct soc_tplg *tplg,
 		goto widget;
 	}
 
-	control_hdr = (struct snd_soc_tplg_ctl_hdr *)tplg->pos;
-	dev_dbg(tplg->dev, "ASoC: template %s has %d controls of type %x\n",
-		w->name, w->num_kcontrols, control_hdr->type);
-
 	template.num_kcontrols = le32_to_cpu(w->num_kcontrols);
 	kc = devm_kcalloc(tplg->dev, le32_to_cpu(w->num_kcontrols), sizeof(*kc), GFP_KERNEL);
 	if (!kc)
@@ -1536,6 +1532,8 @@ static int soc_tplg_dapm_widget_create(struct soc_tplg *tplg,
 	}
 
 	template.kcontrol_news = kc;
+	dev_dbg(tplg->dev, "ASoC: template %s with %d/%d/%d (mixer/enum/bytes) control\n",
+		w->name, mixer_count, enum_count, bytes_count);
 
 widget:
 	ret = soc_tplg_widget_load(tplg, &template, w);
-- 
2.33.0

