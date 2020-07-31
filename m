Return-Path: <SRS0=4tTe=BK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE70BC433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jul 2020 14:44:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B7922B3F
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jul 2020 14:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uSIVNznc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B7922B3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 52F121667;
	Fri, 31 Jul 2020 16:43:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 52F121667
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596206662;
	bh=ldfBQScEZcR9Remp9Cmaldzz+hGXEqb5J8X1V+A85Vk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uSIVNznca9bgddEkSB0NSVJLTYGgx+GdRX1ngHsfUHU7OsRWbQ8JMm9CKCr7CJoTI
	 AgDSxLqmv0+glsE8gH947EkfMH+tI0ttSk9LYRvx8EBsiTOoVgSXreKbox3ZPAGs6s
	 Uxo2BCKCAL/arpSJaD2uPM7XsHlG936/1tamPozE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 01F27F801ED;
	Fri, 31 Jul 2020 16:42:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4D7D3F801ED; Fri, 31 Jul 2020 16:42:37 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A2F95F8011C
 for <alsa-devel@alsa-project.org>; Fri, 31 Jul 2020 16:42:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A2F95F8011C
IronPort-SDR: vP/52kwwzTuC7/X0SBNQqsTSj4aXGcdPagNB17GOrJsguPgpsNl/u04GPzCbWA9OAcdVxuIFJl
 6j0/WWoYiN5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="131352428"
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; d="scan'208";a="131352428"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2020 07:42:25 -0700
IronPort-SDR: Vltdj0P445+7Zjy52FZsqiF9suOR5dOe3OdvY8hpbYPpe5cV+jJsMz3vx1kR4XYdn2pXy64BXH
 sUfaIF+0/s/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; d="scan'208";a="491505201"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga005.fm.intel.com with ESMTP; 31 Jul 2020 07:42:22 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/3] ASoC: core: Relocate and expose
 snd_soc_component_initialize
Date: Fri, 31 Jul 2020 16:41:44 +0200
Message-Id: <20200731144146.6678-2-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731144146.6678-1-cezary.rojewski@intel.com>
References: <20200731144146.6678-1-cezary.rojewski@intel.com>
Cc: pierre-louis.bossart@linux.intel.com,
 Cezary Rojewski <cezary.rojewski@intel.com>, lars@metafoo.de,
 olivier.moysan@st.com, alexandre.torgue@st.com, tiwai@suse.com,
 arnaud.pouliquen@st.com, lgirdwood@gmail.com, broonie@kernel.org,
 mcoquelin.stm32@gmail.com
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

To allow for two-step component registration, expose
snd_soc_component_initialize function and move it back to soc-core.c.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 include/sound/soc-component.h |  3 ---
 include/sound/soc.h           |  3 +++
 sound/soc/soc-component.c     | 16 ----------------
 sound/soc/soc-core.c          | 17 +++++++++++++++++
 4 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/include/sound/soc-component.h b/include/sound/soc-component.h
index 8917b15eccae..089ea9441fd1 100644
--- a/include/sound/soc-component.h
+++ b/include/sound/soc-component.h
@@ -325,9 +325,6 @@ static inline int snd_soc_component_cache_sync(
 	return regcache_sync(component->regmap);
 }
 
-int snd_soc_component_initialize(struct snd_soc_component *component,
-				 const struct snd_soc_component_driver *driver,
-				 struct device *dev, const char *name);
 void snd_soc_component_set_aux(struct snd_soc_component *component,
 			       struct snd_soc_aux_dev *aux);
 int snd_soc_component_init(struct snd_soc_component *component);
diff --git a/include/sound/soc.h b/include/sound/soc.h
index acbb5efb28ef..77a304d36c61 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -414,6 +414,9 @@ static inline int snd_soc_resume(struct device *dev)
 }
 #endif
 int snd_soc_poweroff(struct device *dev);
+int snd_soc_component_initialize(struct snd_soc_component *component,
+				 const struct snd_soc_component_driver *driver,
+				 struct device *dev, const char *name);
 int snd_soc_add_component(struct device *dev,
 		struct snd_soc_component *component,
 		const struct snd_soc_component_driver *component_driver,
diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
index dcc89fa8913a..f0b4f4bc44a4 100644
--- a/sound/soc/soc-component.c
+++ b/sound/soc/soc-component.c
@@ -33,22 +33,6 @@ static inline int _soc_component_ret(struct snd_soc_component *component,
 	return ret;
 }
 
-int snd_soc_component_initialize(struct snd_soc_component *component,
-				 const struct snd_soc_component_driver *driver,
-				 struct device *dev, const char *name)
-{
-	INIT_LIST_HEAD(&component->dai_list);
-	INIT_LIST_HEAD(&component->dobj_list);
-	INIT_LIST_HEAD(&component->card_list);
-	mutex_init(&component->io_mutex);
-
-	component->name		= name;
-	component->dev		= dev;
-	component->driver	= driver;
-
-	return 0;
-}
-
 void snd_soc_component_set_aux(struct snd_soc_component *component,
 			       struct snd_soc_aux_dev *aux)
 {
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index df4c7116f308..236755c7a79e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2441,6 +2441,23 @@ static void snd_soc_del_component_unlocked(struct snd_soc_component *component)
 	list_del(&component->list);
 }
 
+int snd_soc_component_initialize(struct snd_soc_component *component,
+				 const struct snd_soc_component_driver *driver,
+				 struct device *dev, const char *name)
+{
+	INIT_LIST_HEAD(&component->dai_list);
+	INIT_LIST_HEAD(&component->dobj_list);
+	INIT_LIST_HEAD(&component->card_list);
+	mutex_init(&component->io_mutex);
+
+	component->name		= name;
+	component->dev		= dev;
+	component->driver	= driver;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_component_initialize);
+
 int snd_soc_add_component(struct device *dev,
 			struct snd_soc_component *component,
 			const struct snd_soc_component_driver *component_driver,
-- 
2.17.1

