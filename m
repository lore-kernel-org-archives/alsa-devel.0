Return-Path: <SRS0=zNzy=JG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA25C433B4
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Apr 2021 22:06:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DABFA610D0
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Apr 2021 22:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DABFA610D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5F16F1675;
	Sat, 10 Apr 2021 00:05:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5F16F1675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618005990;
	bh=UUufxAUqzPZ2aQ3WVhubdrhYPvKAz8CY0CAP/YTg47c=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BZJzUfwj6Ry4DwBRYn4g/hDAdarGZyW01DMOUtLqMZlJsXy2WOLt421AeTFjtiZni
	 8oD+Ld3geArr0GaYEoUxio3aEs24eQP4bYawvzFX3mlNO1r9sVIZC9BtSbemKAEA1C
	 STVpep4JsH+G7B2XOIbNmJyRflKpbb5G/ldymNsQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E1284F800EE;
	Sat, 10 Apr 2021 00:05:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5DCDEF8016D; Sat, 10 Apr 2021 00:05:38 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6D8ECF80168
 for <alsa-devel@alsa-project.org>; Sat, 10 Apr 2021 00:05:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6D8ECF80168
IronPort-SDR: q9jhxFJHgXyKHbnsvAN4ej6DfNmyErC/zKbC0DoNwZePKrE3iaPfZzOQxNys19RUn3uKqhE6sP
 rSDOj+x9kbBw==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="180975998"
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; d="scan'208";a="180975998"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2021 15:05:26 -0700
IronPort-SDR: gHeoIR8MUunynejsXo9mL45azM0idOolH1InjUP5wSNMRGAYOFvQX+/WNKztaWCbgncz1cD9qA
 CNUtBoTCnAxg==
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; d="scan'208";a="599291913"
Received: from ukorat-mobl2.amr.corp.intel.com (HELO rsridh-mobl1.localdomain)
 ([10.212.104.152])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2021 15:05:26 -0700
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: SOF: topology: remove useless code
Date: Fri,  9 Apr 2021 15:05:22 -0700
Message-Id: <20210409220522.1542865-1-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

The patch "ASoC: SOF: Intel: hda: assign link DMA channel at run-time"
fixed the sof_link_hda_unload() to remove the call to the BE
hw_free op but left the rest of code that become redundant.

So, remove sof_link_hda_unload() along with the link_unload() op
entirely as it is not longer needed.

Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/topology.c | 64 ----------------------------------------
 1 file changed, 64 deletions(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 036202768b75..59abcfc9bd55 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -3371,69 +3371,6 @@ static int sof_link_load(struct snd_soc_component *scomp, int index,
 	return ret;
 }
 
-static int sof_link_hda_unload(struct snd_sof_dev *sdev,
-			       struct snd_soc_dai_link *link)
-{
-	struct snd_soc_dai *dai;
-
-	dai = snd_soc_find_dai(link->cpus);
-	if (!dai) {
-		dev_err(sdev->dev, "error: failed to find dai %s in %s",
-			link->cpus->dai_name, __func__);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int sof_link_unload(struct snd_soc_component *scomp,
-			   struct snd_soc_dobj *dobj)
-{
-	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(scomp);
-	struct snd_soc_dai_link *link =
-		container_of(dobj, struct snd_soc_dai_link, dobj);
-
-	struct snd_sof_dai *sof_dai;
-	int ret = 0;
-
-	/* only BE link is loaded by sof */
-	if (!link->no_pcm)
-		return 0;
-
-	list_for_each_entry(sof_dai, &sdev->dai_list, list) {
-		if (!sof_dai->name)
-			continue;
-
-		if (strcmp(link->name, sof_dai->name) == 0)
-			goto found;
-	}
-
-	dev_err(scomp->dev, "error: failed to find dai %s in %s",
-		link->name, __func__);
-	return -EINVAL;
-found:
-
-	switch (sof_dai->dai_config->type) {
-	case SOF_DAI_INTEL_SSP:
-	case SOF_DAI_INTEL_DMIC:
-	case SOF_DAI_INTEL_ALH:
-	case SOF_DAI_IMX_SAI:
-	case SOF_DAI_IMX_ESAI:
-		/* no resource needs to be released for all cases above */
-		break;
-	case SOF_DAI_INTEL_HDA:
-		ret = sof_link_hda_unload(sdev, link);
-		break;
-	default:
-		dev_err(scomp->dev, "error: invalid DAI type %d\n",
-			sof_dai->dai_config->type);
-		ret = -EINVAL;
-		break;
-	}
-
-	return ret;
-}
-
 /* DAI link - used for any driver specific init */
 static int sof_route_load(struct snd_soc_component *scomp, int index,
 			  struct snd_soc_dapm_route *route)
@@ -3734,7 +3671,6 @@ static struct snd_soc_tplg_ops sof_tplg_ops = {
 
 	/* DAI link - used for any driver specific init */
 	.link_load	= sof_link_load,
-	.link_unload	= sof_link_unload,
 
 	/* completion - called at completion of firmware loading */
 	.complete	= sof_complete,
-- 
2.25.1

