Return-Path: <SRS0=lC1U=7X=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849B7C433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Jun 2020 10:18:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10B6C2064C
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Jun 2020 10:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BI7bpEJZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10B6C2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 73485166C;
	Wed, 10 Jun 2020 12:17:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 73485166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591784309;
	bh=AQA+0N53g+UkfOsDkioInUXtuV+ty27PNphE3H+mjcY=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From;
	b=BI7bpEJZrXcoAZEwdR0tfVKtUsUfw8iapcDNZ3YxtrLsf6zAAG3WaOqG9RgJHrZa+
	 Kk0ZwRPftHDJSdTnvWB85HTRxgfNeFF68DpstkORxZBKYSu8hmYUXloYgtXjAGyNC+
	 ClcYzxpRotw2GGM2Ux0NX9HlZPUID/8Uv7s5/USc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F10B7F8021C;
	Wed, 10 Jun 2020 12:16:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 590F8F802A0; Wed, 10 Jun 2020 12:16:48 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 57BE7F80088
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2020 12:16:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 57BE7F80088
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F196C1A02CE;
 Wed, 10 Jun 2020 12:16:41 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 18DBF1A0447;
 Wed, 10 Jun 2020 12:16:37 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2409A40307;
 Wed, 10 Jun 2020 18:16:31 +0800 (SGT)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lars@metafoo.de, perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
 broonie@kernel.org, timur@kernel.org, nicoleotsuka@gmail.com,
 Xiubo.Lee@gmail.com, festevam@gmail.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v2 1/3] ASoC: soc-card: export
 snd_soc_lookup_component_nolocked
Date: Wed, 10 Jun 2020 18:05:47 +0800
Message-Id: <55f6e0d76f67a517b9a44136d790ff2a06b5caa8.1591783089.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1591783089.git.shengjiu.wang@nxp.com>
References: <cover.1591783089.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1591783089.git.shengjiu.wang@nxp.com>
References: <cover.1591783089.git.shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
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

snd_soc_lookup_component_nolocked can be used for the DPCM case
that Front-End needs to get the unused platform component but
added by Back-End cpu dai driver.

If the component is gotten, then we can get the dma chan created
by Back-End component and reused it in Front-End.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 include/sound/soc.h  | 2 ++
 sound/soc/soc-core.c | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 74868436ac79..565612a8d690 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -444,6 +444,8 @@ int devm_snd_soc_register_component(struct device *dev,
 			 const struct snd_soc_component_driver *component_driver,
 			 struct snd_soc_dai_driver *dai_drv, int num_dai);
 void snd_soc_unregister_component(struct device *dev);
+struct snd_soc_component *snd_soc_lookup_component_nolocked(struct device *dev,
+							    const char *driver_name);
 struct snd_soc_component *snd_soc_lookup_component(struct device *dev,
 						   const char *driver_name);
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b07eca2c6ccc..d4c73e86d058 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -310,7 +310,7 @@ struct snd_soc_component *snd_soc_rtdcom_lookup(struct snd_soc_pcm_runtime *rtd,
 }
 EXPORT_SYMBOL_GPL(snd_soc_rtdcom_lookup);
 
-static struct snd_soc_component
+struct snd_soc_component
 *snd_soc_lookup_component_nolocked(struct device *dev, const char *driver_name)
 {
 	struct snd_soc_component *component;
@@ -329,6 +329,7 @@ static struct snd_soc_component
 
 	return found_component;
 }
+EXPORT_SYMBOL_GPL(snd_soc_lookup_component_nolocked);
 
 struct snd_soc_component *snd_soc_lookup_component(struct device *dev,
 						   const char *driver_name)
-- 
2.21.0

