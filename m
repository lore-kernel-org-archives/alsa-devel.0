Return-Path: <SRS0=HqWb=NX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FC4C432BE
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Sep 2021 09:54:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7785460F3A
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Sep 2021 09:54:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7785460F3A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 20FAF1775;
	Wed,  1 Sep 2021 11:53:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 20FAF1775
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630490087;
	bh=SmTAB7VaKl94wgENh/MAffyJf/5YcCA5FUPA2jj8UdQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u0i+UghGraA8+5aa1tOG24Bu4kHrF6zg4EKCw/nlIEw7Cm1os6iOpBw3I9MvXgfBK
	 /uOmCIK7jcDwpr7LLENYQMi87FDJ9kzTS+Gxy606psuwDosjqnI5BGRqb6rJsgDHEz
	 D1pRQXs2W6rCfQfwtMW5dwdEuwqCze9fd8DDhZ9w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2AF15F80227;
	Wed,  1 Sep 2021 11:53:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 619CAF80423; Wed,  1 Sep 2021 11:53:17 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 73958F80227
 for <alsa-devel@alsa-project.org>; Wed,  1 Sep 2021 11:53:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 73958F80227
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="304275898"
X-IronPort-AV: E=Sophos;i="5.84,368,1620716400"; d="scan'208";a="304275898"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2021 02:53:06 -0700
X-IronPort-AV: E=Sophos;i="5.84,369,1620716400"; d="scan'208";a="460674442"
Received: from pujfalus-mobl.ger.corp.intel.com (HELO
 peter-virtualbox.ger.corp.intel.com) ([10.251.211.191])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2021 02:53:03 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 vkoul@kernel.org
Subject: [PATCH 1/2] ASoC: soc-component: Convert the mark_module to void*
Date: Wed,  1 Sep 2021 12:52:54 +0300
Message-Id: <20210901095255.3617-2-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210901095255.3617-1-peter.ujfalusi@linux.intel.com>
References: <20210901095255.3617-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: kai.vehmanen@linux.intel.com, alsa-devel@alsa-project.org,
 daniel.baluta@nxp.com, pierre-louis.bossart@linux.intel.com,
 kuninori.morimoto.gx@renesas.com
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

The mark_module of the snd_soc_component is strict snd_pcm_substream type
which prevents it to be used by compressed streams.

Change the type to void* along with the snd_soc_component_module_get()
and snd_soc_component_module_put() to allow the same mark to be used by
compressed when it's module_get_upon_open is set to 1.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 include/sound/soc-component.h |  8 +++-----
 sound/soc/soc-component.c     | 16 +++++++---------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/include/sound/soc-component.h b/include/sound/soc-component.h
index 8c4d6830597f..a393ac397eca 100644
--- a/include/sound/soc-component.h
+++ b/include/sound/soc-component.h
@@ -220,7 +220,7 @@ struct snd_soc_component {
 	int (*init)(struct snd_soc_component *component);
 
 	/* function mark */
-	struct snd_pcm_substream *mark_module;
+	void *mark_module;
 	struct snd_pcm_substream *mark_open;
 	struct snd_pcm_substream *mark_hw_params;
 	struct snd_pcm_substream *mark_trigger;
@@ -391,15 +391,13 @@ void snd_soc_component_exit_regmap(struct snd_soc_component *component);
 #define snd_soc_component_module_get_when_open(component, substream)	\
 	snd_soc_component_module_get(component, substream, 1)
 int snd_soc_component_module_get(struct snd_soc_component *component,
-				 struct snd_pcm_substream *substream,
-				 int upon_open);
+				 void *mark, int upon_open);
 #define snd_soc_component_module_put_when_remove(component)	\
 	snd_soc_component_module_put(component, NULL, 0, 0)
 #define snd_soc_component_module_put_when_close(component, substream, rollback) \
 	snd_soc_component_module_put(component, substream, 1, rollback)
 void snd_soc_component_module_put(struct snd_soc_component *component,
-				  struct snd_pcm_substream *substream,
-				  int upon_open, int rollback);
+				  void *mark, int upon_open, int rollback);
 
 static inline void snd_soc_component_set_drvdata(struct snd_soc_component *c,
 						 void *data)
diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
index 8e8d917d22f8..82a1430313dc 100644
--- a/sound/soc/soc-component.c
+++ b/sound/soc/soc-component.c
@@ -251,8 +251,7 @@ int snd_soc_component_set_jack(struct snd_soc_component *component,
 EXPORT_SYMBOL_GPL(snd_soc_component_set_jack);
 
 int snd_soc_component_module_get(struct snd_soc_component *component,
-				 struct snd_pcm_substream *substream,
-				 int upon_open)
+				 void *mark, int upon_open)
 {
 	int ret = 0;
 
@@ -260,25 +259,24 @@ int snd_soc_component_module_get(struct snd_soc_component *component,
 	    !try_module_get(component->dev->driver->owner))
 		ret = -ENODEV;
 
-	/* mark substream if succeeded */
+	/* mark module if succeeded */
 	if (ret == 0)
-		soc_component_mark_push(component, substream, module);
+		soc_component_mark_push(component, mark, module);
 
 	return soc_component_ret(component, ret);
 }
 
 void snd_soc_component_module_put(struct snd_soc_component *component,
-				  struct snd_pcm_substream *substream,
-				  int upon_open, int rollback)
+				  void *mark, int upon_open, int rollback)
 {
-	if (rollback && !soc_component_mark_match(component, substream, module))
+	if (rollback && !soc_component_mark_match(component, mark, module))
 		return;
 
 	if (component->driver->module_get_upon_open == !!upon_open)
 		module_put(component->dev->driver->owner);
 
-	/* remove marked substream */
-	soc_component_mark_pop(component, substream, module);
+	/* remove the mark from module */
+	soc_component_mark_pop(component, mark, module);
 }
 
 int snd_soc_component_open(struct snd_soc_component *component,
-- 
2.33.0

