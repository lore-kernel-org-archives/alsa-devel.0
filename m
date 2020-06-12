Return-Path: <SRS0=DU/y=7Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD881C433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 21:01:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52AB1204EA
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 21:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="C/c58pKd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52AB1204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BDB3C1681;
	Fri, 12 Jun 2020 23:00:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BDB3C1681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591995692;
	bh=WnyIdlFvIkcnaoI9J+G0GG4hDBAomKzMVQn6+CwNKgI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C/c58pKdNMoLUUB9CfUlSVKJLYP01zyr2wW1UU8RIhVhxG3s+/pwGT776yggYkgCR
	 oEXaz7ghNHjO9OgJWGsuMS3qtsx5WG8yo5EWmsqGSjG0OpZueAlYe6qHnJXre9br3b
	 yZKJImQlI9+8a++QLxRU3KdDilxb596NctmKWiEY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D5AF9F801F7;
	Fri, 12 Jun 2020 22:59:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1D4BFF800C7; Fri, 12 Jun 2020 22:59:53 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9B8CAF800C7
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2020 22:59:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9B8CAF800C7
IronPort-SDR: fzi9JO+s9JBOIakmPzSCrjpsTm1c7j4vydu3sDiJ1V9cm+jqaro76ZVvMMrefjLF5BPm+uwq75
 tieeqUG6nqpw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2020 13:59:42 -0700
IronPort-SDR: jhGeOHm4o7flSRKytD4hu7MVr3rQZjuWdlygXylAI8XsAR0YtmJ5x0cJAvN4ORh4Fmz3hIBNgS
 FRGWDMKPVYOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,504,1583222400"; d="scan'208";a="272026625"
Received: from tcampell-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.231.137])
 by orsmga003.jf.intel.com with ESMTP; 12 Jun 2020 13:59:41 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/2] ASoC: soc-devres: add devm_snd_soc_register_dai()
Date: Fri, 12 Jun 2020 15:59:37 -0500
Message-Id: <20200612205938.26415-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200612205938.26415-1-pierre-louis.bossart@linux.intel.com>
References: <20200612205938.26415-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, broonie@kernel.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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

The registration of DAIs may be done at two distinct times, once
during a component registration and later when loading a
topology. Since devm_ managed resources are freed in the reverse order
they were allocated, when a component starts unregistering DAIs by
walking through the DAI list, the memory allocated for the
topology-registered DAIs was freed already, which leads to 100%
reproducible KASAN use-after-free reports.

This patch suggests a new devm_ function to force the DAI list to be
updated prior to freeing the memory chunks referenced by the list
pointers.

BugLink: https://github.com/thesofproject/linux/issues/2186
Suggested-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 include/sound/soc.h    |  4 ++++
 sound/soc/soc-devres.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 828baea66b76..2756f9bcac3e 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1363,6 +1363,10 @@ void snd_soc_remove_pcm_runtime(struct snd_soc_card *card,
 struct snd_soc_dai *snd_soc_register_dai(struct snd_soc_component *component,
 					 struct snd_soc_dai_driver *dai_drv,
 					 bool legacy_dai_naming);
+struct snd_soc_dai *devm_snd_soc_register_dai(struct device *dev,
+					      struct snd_soc_component *component,
+					      struct snd_soc_dai_driver *dai_drv,
+					      bool legacy_dai_naming);
 void snd_soc_unregister_dai(struct snd_soc_dai *dai);
 
 struct snd_soc_dai *snd_soc_find_dai(
diff --git a/sound/soc/soc-devres.c b/sound/soc/soc-devres.c
index a9ea172a66a7..11e5d7962370 100644
--- a/sound/soc/soc-devres.c
+++ b/sound/soc/soc-devres.c
@@ -9,6 +9,43 @@
 #include <sound/soc.h>
 #include <sound/dmaengine_pcm.h>
 
+static void devm_dai_release(struct device *dev, void *res)
+{
+	snd_soc_unregister_dai(*(struct snd_soc_dai **)res);
+}
+
+/**
+ * devm_snd_soc_register_dai - resource-managed dai registration
+ * @dev: Device used to manage component
+ * @component: The component the DAIs are registered for
+ * @dai_drv: DAI driver to use for the DAI
+ * @legacy_dai_naming: if %true, use legacy single-name format;
+ *	if %false, use multiple-name format;
+ */
+struct snd_soc_dai *devm_snd_soc_register_dai(struct device *dev,
+					      struct snd_soc_component *component,
+					      struct snd_soc_dai_driver *dai_drv,
+					      bool legacy_dai_naming)
+{
+	struct snd_soc_dai **ptr;
+	struct snd_soc_dai *dai;
+
+	ptr = devres_alloc(devm_dai_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return NULL;
+
+	dai = snd_soc_register_dai(component, dai_drv, legacy_dai_naming);
+	if (dai) {
+		*ptr = dai;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return dai;
+}
+EXPORT_SYMBOL_GPL(devm_snd_soc_register_dai);
+
 static void devm_component_release(struct device *dev, void *res)
 {
 	snd_soc_unregister_component(*(struct device **)res);
-- 
2.20.1

