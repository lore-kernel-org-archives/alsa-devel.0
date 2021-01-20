Return-Path: <SRS0=/R4B=GX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643D9C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 15:32:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D063B2336D
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 15:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D063B2336D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 26A591884;
	Wed, 20 Jan 2021 16:32:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 26A591884
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611156773;
	bh=pulY75jH8j2lxdFLVWWtj+dCXPhLScSrZ9Pf+eITMqk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QQBJZdx6DB58xo3KUbMCzpEQM50bxMPUhMV/+ky0sc+6LBgdolFoe4EgoVn7X7/lc
	 vaUnMqtoVKhQqlAoGkhb//7xuHjY9S0KdpFFoXdH72gm+N+4kn9RFxAx2NfLK6i2GL
	 Kn44e9wxTn70lYrXXQIs6BEPioOonSVn1/Ua3/TY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 32A4BF804E7;
	Wed, 20 Jan 2021 16:29:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 76535F80227; Wed, 20 Jan 2021 16:29:14 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 32E1BF8019B
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2021 16:29:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 32E1BF8019B
IronPort-SDR: wUOXyEBGicp0s834kISNVTGotnylcakgW9nlZbwrPlalGP/khOQ1iMmiiQVsfzyZ2oM7OA5hzl
 Ca3vdwdMbEdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="197850635"
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; d="scan'208";a="197850635"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2021 07:28:58 -0800
IronPort-SDR: KXcPxnFoun0RpIgO2sAvkre0j/W5LixQgJqolMBSxM4p4XQxgaHUcyZtsj0fG1VCi2L2XHGgr/
 /Zbj2MaGHalA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; d="scan'208";a="354347843"
Received: from pi-desktop.igk.intel.com ([10.237.148.102])
 by orsmga006.jf.intel.com with ESMTP; 20 Jan 2021 07:28:56 -0800
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 2/5] Revert "ASoC: soc-devres: add devm_snd_soc_register_dai()"
Date: Wed, 20 Jan 2021 16:28:43 +0100
Message-Id: <20210120152846.1703655-3-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120152846.1703655-1-amadeuszx.slawinski@linux.intel.com>
References: <20210120152846.1703655-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
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

As described in preceding patch, waiting with DAI removal until device
is being unregistered can lead to working on freed memory, hence having
DAIs managed by resource managed memory is a bad idea, revert commit
creating devm_ API for this, so no one makes a mistake of using it.

This reverts commit 0fae253af563cf5d1f5dc651d520c3eafd74f183.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/soc.h    |  4 ----
 sound/soc/soc-devres.c | 37 -------------------------------------
 2 files changed, 41 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 3fa6c40a63b7..69cb19a93765 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1236,10 +1236,6 @@ void snd_soc_remove_pcm_runtime(struct snd_soc_card *card,
 struct snd_soc_dai *snd_soc_register_dai(struct snd_soc_component *component,
 					 struct snd_soc_dai_driver *dai_drv,
 					 bool legacy_dai_naming);
-struct snd_soc_dai *devm_snd_soc_register_dai(struct device *dev,
-					      struct snd_soc_component *component,
-					      struct snd_soc_dai_driver *dai_drv,
-					      bool legacy_dai_naming);
 void snd_soc_unregister_dai(struct snd_soc_dai *dai);
 
 struct snd_soc_dai *snd_soc_find_dai(
diff --git a/sound/soc/soc-devres.c b/sound/soc/soc-devres.c
index 4534a1c03e8e..c6364caabc0e 100644
--- a/sound/soc/soc-devres.c
+++ b/sound/soc/soc-devres.c
@@ -9,43 +9,6 @@
 #include <sound/soc.h>
 #include <sound/dmaengine_pcm.h>
 
-static void devm_dai_release(struct device *dev, void *res)
-{
-	snd_soc_unregister_dai(*(struct snd_soc_dai **)res);
-}
-
-/**
- * devm_snd_soc_register_dai - resource-managed dai registration
- * @dev: Device used to manage component
- * @component: The component the DAIs are registered for
- * @dai_drv: DAI driver to use for the DAI
- * @legacy_dai_naming: if %true, use legacy single-name format;
- *	if %false, use multiple-name format;
- */
-struct snd_soc_dai *devm_snd_soc_register_dai(struct device *dev,
-					      struct snd_soc_component *component,
-					      struct snd_soc_dai_driver *dai_drv,
-					      bool legacy_dai_naming)
-{
-	struct snd_soc_dai **ptr;
-	struct snd_soc_dai *dai;
-
-	ptr = devres_alloc(devm_dai_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return NULL;
-
-	dai = snd_soc_register_dai(component, dai_drv, legacy_dai_naming);
-	if (dai) {
-		*ptr = dai;
-		devres_add(dev, ptr);
-	} else {
-		devres_free(ptr);
-	}
-
-	return dai;
-}
-EXPORT_SYMBOL_GPL(devm_snd_soc_register_dai);
-
 static void devm_component_release(struct device *dev, void *res)
 {
 	const struct snd_soc_component_driver **cmpnt_drv = res;
-- 
2.25.1

