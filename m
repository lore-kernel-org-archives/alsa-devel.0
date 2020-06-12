Return-Path: <SRS0=DU/y=7Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9FFC433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 07:51:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 090EE207D8
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 07:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="C3e2krJQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090EE207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9DB311685;
	Fri, 12 Jun 2020 09:50:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9DB311685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591948284;
	bh=12qfjoSLFIyodLbVMzzulIGmWcFqLWhcPR3Up65ETus=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From;
	b=C3e2krJQx7AzLjzCnxRGeo56zzw/DDMRjDI+bbstnpprzElsUxJNUz4Qgd08x/qfd
	 Hwp6nJT3jwV0Y/8pNcHi3SPzmyA1TmFqEqvX3blziyVmiGI5RCbmijXNYSnigES/v1
	 dKOakVGkvAFeo49BA0fi9Qj1kjVyU8VVJKQGXaNo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 80AF1F802BD;
	Fri, 12 Jun 2020 09:49:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C36D2F802BE; Fri, 12 Jun 2020 09:48:56 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A7ABDF8021C
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2020 09:48:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A7ABDF8021C
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C7779200922;
 Fri, 12 Jun 2020 09:48:49 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D9378200037;
 Fri, 12 Jun 2020 09:48:44 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 91748402FB;
 Fri, 12 Jun 2020 15:48:38 +0800 (SGT)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lars@metafoo.de, perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
 broonie@kernel.org, timur@kernel.org, nicoleotsuka@gmail.com,
 Xiubo.Lee@gmail.com, festevam@gmail.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v3 2/4] ASoC: dmaengine_pcm: export soc_component_to_pcm
Date: Fri, 12 Jun 2020 15:37:49 +0800
Message-Id: <429c6ae1f3c5b47eb893f475d531d71cdcfe34c0.1591947428.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1591947428.git.shengjiu.wang@nxp.com>
References: <cover.1591947428.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1591947428.git.shengjiu.wang@nxp.com>
References: <cover.1591947428.git.shengjiu.wang@nxp.com>
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

In DPCM case, Front-End needs to get the dma chan which has
been requested by Back-End and reuse it.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 include/sound/dmaengine_pcm.h         | 11 +++++++++++
 sound/soc/soc-generic-dmaengine-pcm.c | 12 ------------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index b65220685920..8c5e38180fb0 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -161,4 +161,15 @@ int snd_dmaengine_pcm_prepare_slave_config(struct snd_pcm_substream *substream,
 
 #define SND_DMAENGINE_PCM_DRV_NAME "snd_dmaengine_pcm"
 
+struct dmaengine_pcm {
+	struct dma_chan *chan[SNDRV_PCM_STREAM_LAST + 1];
+	const struct snd_dmaengine_pcm_config *config;
+	struct snd_soc_component component;
+	unsigned int flags;
+};
+
+static inline struct dmaengine_pcm *soc_component_to_pcm(struct snd_soc_component *p)
+{
+	return container_of(p, struct dmaengine_pcm, component);
+}
 #endif
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index f728309a0833..80a4e71f2d95 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -21,18 +21,6 @@
  */
 #define SND_DMAENGINE_PCM_FLAG_NO_RESIDUE BIT(31)
 
-struct dmaengine_pcm {
-	struct dma_chan *chan[SNDRV_PCM_STREAM_LAST + 1];
-	const struct snd_dmaengine_pcm_config *config;
-	struct snd_soc_component component;
-	unsigned int flags;
-};
-
-static struct dmaengine_pcm *soc_component_to_pcm(struct snd_soc_component *p)
-{
-	return container_of(p, struct dmaengine_pcm, component);
-}
-
 static struct device *dmaengine_dma_dev(struct dmaengine_pcm *pcm,
 	struct snd_pcm_substream *substream)
 {
-- 
2.21.0

